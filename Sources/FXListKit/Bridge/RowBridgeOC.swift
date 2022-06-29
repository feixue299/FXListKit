//
//  RowBridgeOC.swift
//  FXListKit
//
//  Created by 8-PC on 2020/6/2.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import Foundation
import UIKit

public class RowProperty: NSObject {
    public let property = Row.Property()

    @objc public init(section value: Int) {
        property.size = .section(value: value)
    }

    @objc public init(single height: CGFloat) {
        property.size = .single(height: height)
    }

    @objc public init(custom size: CGSize) {
        property.size = .custom(size: size)
    }
}

public class RowBridgeOC: NSObject {
    public private(set) var row: Row

    @objc public init(cellType: AnyClass) {
        guard let type = cellType as? UIView.Type else {
            fatalError("cellType is not a UIView.Type")
        }
        row = Row(cellType: type)
        super.init()
    }

    @objc public init(cellType: AnyClass,
                      cellConfig: ((_ collection: UICollectionView, _ view: UIView, _ indexPath: IndexPath) -> Void)? = nil,
                      property: RowProperty,
                      didSelect: Row.SelectClosure? = nil) {
        guard let type = cellType as? UIView.Type else {
            fatalError("cellType is not a UIView.Type")
        }

        row = Row(cellType: type, cellConfig: cellConfig, configPropertyClosure: { (pro) in
            pro.size = property.property.size
        }, didSelect: didSelect)
    }
}
