//
//  Section.swift
//  FXListKit
//
//  Created by Mr.wu on 2020/1/25.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

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

