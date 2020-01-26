//
//  RowTests.swift
//  FXListKitTests
//
//  Created by Mr.wu on 2020/1/26.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import XCTest
import FXListKit

struct Model {
    
}

class RowTests: XCTestCase {

    override func setUp() {
        _ = Row(cellType: UILabel.self, model: "hello world", configClosure: { (cell, model) in
            cell.backgroundColor = .black
            cell.text = model
        }) { (property) in
            property.size = CGSize(width: 60, height: 60)
        }
        
    }

}
