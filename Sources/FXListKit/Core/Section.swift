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

extension Section.Property: Equatable {
    public static func == (lhs: Section.Property, rhs: Section.Property) -> Bool {
        return lhs.inset == rhs.inset &&
            lhs.minimumLineSpacing == rhs.minimumLineSpacing &&
            lhs.minimumInteritemSpacing == rhs.minimumInteritemSpacing &&
            lhs.referenceSizeForHeader == rhs.referenceSizeForHeader &&
            lhs.referenceSizeForFooter == rhs.referenceSizeForFooter
    }
}

extension Section: Hashable {
    public static func == (lhs: Section, rhs: Section) -> Bool {
        guard lhs.rows.count == rhs.rows.count else { return false }
        for (index, lrow) in lhs.rows.enumerated() {
            if lrow != rhs.rows[index] {
                return false
            }
        }
        return lhs.property == rhs.property
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}

#endif
