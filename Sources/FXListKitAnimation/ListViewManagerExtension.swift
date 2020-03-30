//
//  FXlistKitAnimation.swift
//  
//
//  Created by Mr.wu on 2020/3/26.
//

import Foundation
import UIKit
#if canImport(FXListKit)
import FXListKit
#endif

#if canImport(DifferenceKit)
import DifferenceKit
#endif

private let rowKey = "rowKey"

public extension Row {
    
    var key: Int? {
        set { objc_setAssociatedObject(self, rowKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
        get { objc_getAssociatedObject(self, rowKey) as? Int }
    }
    
    init<View: UIView, Key: Hashable>(cellType: View.Type,
                       key: Key,
                       cellConfig: ((_ view: View) -> Void)? = nil,
                       configPropertyClosure: ((_ property: Property) -> Void)? = nil,
                       didSelect: (() -> Void)? = nil) {
        self.init(cellType: cellType, cellConfig: cellConfig, configPropertyClosure: configPropertyClosure, didSelect: didSelect)
        self.key = key.hashValue
    }
    
}

public extension ListViewManager {
    
    func reloadWithAnimation() {
        let data: [ArraySection<Section, RowKey>] = dataSource.map({ ArraySection(model: $0, elements: $0.rows.map(RowKey.init)) })
        generateDataSource()
        let newData: [ArraySection<Section, RowKey>] = dataSource.map({ ArraySection(model: $0, elements: $0.rows.map(RowKey.init)) })
        let changeset = StagedChangeset(source: data, target: newData)
        collectionView?.reload(using: changeset, setData: { [weak self] (data) in
            self?.dataSource = data.map({ $0.model })
        })
    }
}

extension Section: Differentiable { }

private struct RowKey: Hashable, Differentiable {
    let row: Row
    init(row: Row) {
        self.row = row
    }
    static func == (lhs: RowKey, rhs: RowKey) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(row.key)
    }
}

