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

public class Row {
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

extension Row.Property.Size: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .single(height):
            hasher.combine("single:\(height)")
        case let .section(value):
            hasher.combine("section:\(value)")
        case let .custom(size):
            hasher.combine("custom:\(size)")
        }
    }
}

extension Row: Hashable {
    public static func == (lhs: Row, rhs: Row) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(NSStringFromClass(cellType))
        hasher.combine(property.size)
    }
}

#endif
