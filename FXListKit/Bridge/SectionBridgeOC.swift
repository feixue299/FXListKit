//
//  SectionBridgeOC.swift
//  FXListKit
//
//  Created by 8-PC on 2020/6/2.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import Foundation
import UIKit

public class SectionProperty: NSObject {

    public private(set) var property = Section.Property()

    @objc public init(inset: UIEdgeInsets = .zero,
                minimumLineSpacing: CGFloat = 10,
                minimumInteritemSpacing: CGFloat = 10,
                referenceSizeForHeader: CGSize = .zero,
                referenceSizeForFooter: CGSize = .zero) {
        property.inset = inset
        property.minimumLineSpacing = minimumLineSpacing
        property.minimumInteritemSpacing = minimumInteritemSpacing
        property.referenceSizeForHeader = referenceSizeForHeader
        property.referenceSizeForFooter = referenceSizeForFooter
    }

}

public class SectionBridgeOC: NSObject {
    public private(set) var section: Section

    @objc public init(property: SectionProperty, rows: [RowBridgeOC]) {
        section = Section({ (property) -> [Row] in
            return rows.map({ $0.row })
        })
    }

}
