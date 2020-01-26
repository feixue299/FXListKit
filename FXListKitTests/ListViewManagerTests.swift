//
//  ListViewManagerTests.swift
//  FXListKitTests
//
//  Created by Mr.wu on 2020/1/26.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import XCTest
import FXListKit

class ListViewManagerTests: XCTestCase {

    override func setUp() {
        _ = ListViewManager{
            [Section { (property) in
                [Row(cellType: CollectionViewCellBox<UILabel>.self, model: "hello world", configClosure: { (cell, model) in
                    cell.customView.text = model
                }, configPropertyClosure: { (property) in
                    property.size = CGSize(width: 100, height: 100)
                })]
            }]
        }
    }

}
