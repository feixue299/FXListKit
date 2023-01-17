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
        public typealias Size = SizeType
        public enum SizeType {
            case singleAutoHeight
            case section(value: Int)
            case single(height: CGFloat)
            case custom(size: CGSize)
            case sectionCustomHeight(value: Int, height: CGFloat)
            /// scale : width / height
            case sectionScale(value: Int, scale: CGFloat)
            case sectionOffset(value: Int, offset: CGFloat)
        }

        public enum IdentityType {
            case `default`
            case unique
        }
        
        public var size: SizeType = .custom(size: CGSize(width: 60, height: 60))
        public var identityType: IdentityType = .default
    }

    public typealias Closure<View> = (_ collectionView: UICollectionView, _ cell: View, _ indexPath: IndexPath) -> Void
    public typealias SelectClosure = ((IndexPath) -> Void)
    
    public let cellType: AnyClass
    public let configClosure: Closure<UIView>?
    public let property = Property()
    public let didSelect: SelectClosure?

    public init<View: UIView>(cellType: View.Type,
                              cellConfig: Closure<View>? = nil,
                              configPropertyClosure: ((_ property: Property) -> Void)? = nil,
                              didSelect: SelectClosure? = nil) {
        
        self.cellType = cellType
        configClosure = { (_ collectionView: UICollectionView, _ view: UIView, _ indexPath: IndexPath) in
            if let vi = view as? View {
                cellConfig?(collectionView, vi, indexPath)
            } else {
                fatalError("类型不一致")
            }
        }
        configPropertyClosure?(property)
        self.didSelect = didSelect
    }
}

extension Row.Property.SizeType: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .single(height):
            hasher.combine("single:\(height)")
        case let .section(value):
            hasher.combine("section:\(value)")
        case let .custom(size):
            hasher.combine("custom:\(size)")
        case .sectionCustomHeight(value: let value, height: let height):
            hasher.combine("sectionCustomHeight:\(value), height:\(height)")
        case .sectionScale(value: let value, scale: let scale):
            hasher.combine("sectionScale:\(value), scale:\(scale)")
        case .sectionOffset(let value, let offset):
            hasher.combine("sectionOffset:\(value), offset:\(offset)")
        case .singleAutoHeight:
            hasher.combine("singleAutoHeight")
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
