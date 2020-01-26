//
//  SectionTests.swift
//  FXListKitTests
//
//  Created by Mr.wu on 2020/1/25.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import XCTest
import FXListKit

class SectionTests: XCTestCase {

    override func setUp() {
        _ = Section { (section) in
            section.titleForHeader = "header"
            return [Row(cellType: UIView.self)]
        }
    }
    
}
