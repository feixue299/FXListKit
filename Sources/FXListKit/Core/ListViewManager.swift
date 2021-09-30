//
//  ListViewManager.swift
//  FXListKit
//
//  Created by Mr.wu on 2020/1/26.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#if os(iOS)

import Foundation
import UIKit

#if canImport(FXListKitInternal)
import FXListKitInternal
#endif

public class ListViewManager: NSObject {
    public var dataSource: [Section] {
        get { return sectionGroup }
        set {
            sectionGroup = newValue
        }
    }
    private var sectionGroup: [Section]
    private let sectionGroupClosure: () -> [Section]
    private var _registerReuseIdentifierGroup: [String] = []
    public private(set) weak var collectionView: UICollectionView?
    
    public init(_ sectionGroup: @escaping () -> [Section]) {
        self.sectionGroup = sectionGroup()
        self.sectionGroupClosure = sectionGroup
        super.init()
    }
    
    @objc public func configCollectionView(_ view: UICollectionView) {
        view.delegate = self
        view.dataSource = self
        collectionView = view
        updateCollectionViewState()
    }
    
    public func reloadData() {
        generateDataSource()
        updateCollectionViewState()
        collectionView?.reloadData()
    }
    
    public func generateDataSource() {
        self.sectionGroup = self.sectionGroupClosure()
    }
    
    private func updateCollectionViewState() {
        var rows = self.sectionGroup.reduce([], { $0 + $1.rows })
        if rows.contains(where: { $0.property.size == .singleAutoHeight }) {
            if #available(iOS 10.0, *) {
                (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }
        } else {
            (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = CGSize.zero
        }
    }
}

extension ListViewManager: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionGroup.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionGroup[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let row = sectionGroup[indexPath.section].rows[indexPath.row]
        let cell = __collectionView(collectionView, for: indexPath)
        row.configClosure?(collectionView, cell, indexPath)

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }

    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }

    public func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return nil
    }

    public func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        return IndexPath()
    }
    
    private func __collectionView(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        let row = sectionGroup[indexPath.section].rows[indexPath.row]

        let reuseIdentifier = NSStringFromClass(row.cellType)
        if !_registerReuseIdentifierGroup.contains(reuseIdentifier) {
            _registerReuseIdentifierGroup.append(reuseIdentifier)

            if NSObject.verifyClass(row.cellType, isSubclassOf: UICollectionViewCell.self) {
                collectionView.register(row.cellType, forCellWithReuseIdentifier: reuseIdentifier)
            } else {
                fatalError("不是UICollectionViewCell的子类")
            }
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(row.cellType), for: indexPath)
        return cell
    }
}

extension ListViewManager: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeType = sectionGroup[indexPath.section].rows[indexPath.row].property.size
        switch sizeType {
        case let .section(value):
            return section(collectionView, layout: collectionViewLayout, indexPath: indexPath, value: value)
        case let .custom(size):
            return size
        case .single(let height):
            let sectionProperty = sectionGroup[indexPath.section].property
            let itemWidth = collectionView.frame.width - sectionProperty.inset.left - sectionProperty.inset.right
            return CGSize(width: itemWidth, height: height)
        case .sectionCustomHeight(value: let value, height: let height):
            let size = section(collectionView, layout: collectionViewLayout, indexPath: indexPath, value: value)
            return CGSize(width: size.width, height: height)
        case .sectionScale(value: let value, scale: let scale):
            let size = section(collectionView, layout: collectionViewLayout, indexPath: indexPath, value: value)
            return CGSize(width: size.width, height: size.width / scale)
        case .sectionOffset(value: let value, offset: let offset):
            let size = section(collectionView, layout: collectionViewLayout, indexPath: indexPath, value: value)
            return CGSize(width: size.width, height: size.width + offset)
        case .singleAutoHeight:
            let sectionProperty = sectionGroup[indexPath.section].property
            let itemWidth = collectionView.frame.width - sectionProperty.inset.left - sectionProperty.inset.right
            return CGSize(width: itemWidth, height: 1000)
        }
    }
    
    private func section(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath, value: Int) -> CGSize {
        let sectionProperty = sectionGroup[indexPath.section].property
        let itemSide: CGFloat
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout, layout.scrollDirection == .horizontal {
            itemSide = collectionView.frame.height - sectionProperty.minimumInteritemSpacing * CGFloat(value - 1) - sectionProperty.inset.top - sectionProperty.inset.bottom
        } else {
            itemSide = collectionView.frame.width - sectionProperty.minimumInteritemSpacing * CGFloat(value - 1) - sectionProperty.inset.left - sectionProperty.inset.right
        }
        let remainder = Int(itemSide) % value
        let width = Int(itemSide) / value
        
        if remainder > (indexPath.row) % value {
            return CGSize(width: width + 1, height: width)
        } else {
            return CGSize(width: width, height: width)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionGroup[section].property.inset
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionGroup[section].property.minimumLineSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionGroup[section].property.minimumInteritemSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return sectionGroup[section].property.referenceSizeForHeader
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return sectionGroup[section].property.referenceSizeForFooter
    }
}

extension ListViewManager: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return sectionGroup[indexPath.section].rows[indexPath.row].didSelect != nil
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return sectionGroup[indexPath.section].rows[indexPath.row].didSelect != nil
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sectionGroup[indexPath.section].rows[indexPath.row].didSelect?()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}

#endif
