//
//  Section.swift
//  FXListKit
//
//  Created by Mr.wu on 2020/1/25.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#if os(iOS)

import Foundation
import UIKit

public struct Section {
    
    public class Property {
        public var inset: UIEdgeInsets = .zero
        public var minimumLineSpacing: CGFloat = 10
        public var minimumInteritemSpacing: CGFloat = 10
        public var referenceSizeForHeader: CGSize = .zero
        public var referenceSizeForFooter: CGSize = .zero
    }
    
    public let rows: [Row]
    public let property: Property
    
    public init(_ rows: @escaping (Property) -> [Row]) {
        self.property = Property()
        self.rows = rows(self.property)
    }
}

extension Section.Property: Hashable {
    public static func == (lhs: Section.Property, rhs: Section.Property) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(inset.top)
        hasher.combine(inset.bottom)
        hasher.combine(inset.left)
        hasher.combine(inset.right)
        hasher.combine(minimumLineSpacing)
        hasher.combine(minimumInteritemSpacing)
        hasher.combine(referenceSizeForHeader.height)
        hasher.combine(referenceSizeForHeader.width)
        hasher.combine(referenceSizeForFooter.height)
        hasher.combine(referenceSizeForFooter.width)
    }
}

extension Section: Hashable {
    public static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        for row in rows {
            hasher.combine(row)
        }
        hasher.combine(property)
    }
}

#endif
