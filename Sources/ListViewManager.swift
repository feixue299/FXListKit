//
//  ListViewManager.swift
//  FXListKit
//
//  Created by Mr.wu on 2020/1/26.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import Foundation
import UIKit

public class ListViewManager: NSObject {
    
    private let sectionGroup: [Section]
    private var _registerReuseIdentifierGroup: [String] = []
    
    public init(_ sectionGroup: () -> [Section]) {
        self.sectionGroup = sectionGroup()
        super.init()
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
        return sectionGroup[indexPath.section].rows[indexPath.row].property.canMoveItem
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
        return sectionGroup[indexPath.section].rows[indexPath.row].property.size
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
        return .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
}
