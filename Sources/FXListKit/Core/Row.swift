//
//  Row.swift
//  FXListKit
//
//  Created by Mr.wu on 2020/1/25.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#if os(iOS)

import Foundation
import UIKit

public struct Row {
    public class Property {
        public enum Size {
            case section(value: Int)
            case single(height: CGFloat)
            case custom(size: CGSize)
        }

        public var size: Size = .custom(size: CGSize(width: 60, height: 60))
    }

    public let cellType: AnyClass
    public let configClosure: ((_ view: UIView) -> Void)?
    public let property = Property()
    public let didSelect: (() -> Void)?

    public init<View: UIView>(cellType: View.Type,
                              cellConfig: ((_ view: View) -> Void)? = nil,
                              configPropertyClosure: ((_ property: Property) -> Void)? = nil,
                              didSelect: (() -> Void)? = nil) {
        self.cellType = cellType
        configClosure = { view in
            if let vi = view as? View {
                cellConfig?(vi)
            } else {
                fatalError("类型不一致")
            }
        }
        configPropertyClosure?(property)
        self.didSelect = didSelect
    }
}

#endif
