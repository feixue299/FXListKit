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

//TODO:适配UICollectionViewLayout
public class ListViewManager: NSObject {
    private var sectionGroup: [Section]
    private let sectionGroupClosure: () -> [Section]
    private var _registerReuseIdentifierGroup: [String] = []
    private weak var collectionView: UICollectionView?
    
    public init(_ sectionGroup: @escaping () -> [Section]) {
        self.sectionGroup = sectionGroup()
        self.sectionGroupClosure = sectionGroup
        super.init()
    }
    
    public func configCollectionView(_ view: UICollectionView) {
        view.delegate = self
        view.dataSource = self
        collectionView = view
    }
    
    public func reloadData() {
        self.sectionGroup = self.sectionGroupClosure()
        collectionView?.reloadData()
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

        row.configClosure?(cell)

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
}

extension ListViewManager: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch sectionGroup[indexPath.section].rows[indexPath.row].property.size {
        case let .section(value):
            let sectionProperty = sectionGroup[indexPath.section].property
            let itemWidth = collectionView.frame.width - sectionProperty.minimumInteritemSpacing * CGFloat(value - 1) - sectionProperty.inset.left - sectionProperty.inset.right
            let remainder = Int(itemWidth) % value
            let width = Int(itemWidth) / value
            
            if remainder > (indexPath.row) % value {
                return CGSize(width: width + 1, height: width)
            } else {
                return CGSize(width: width, height: width)
            }
        case let .custom(size):
            return size
        case .single(let height):
            let sectionProperty = sectionGroup[indexPath.section].property
            let itemWidth = collectionView.frame.width - sectionProperty.inset.left - sectionProperty.inset.right
            return CGSize(width: itemWidth, height: height)
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
