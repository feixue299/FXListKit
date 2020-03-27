//
//  SectionTests.swift
//  FXListKitTests
//
//  Created by Mr.wu on 2020/3/27.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import XCTest
import FXListKit

class SectionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHashable() {
        let section1 = Section { (property) -> [Row] in
            property.inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            return [Row(cellType: UILabel.self, cellConfig: nil, configPropertyClosure: { (property) in
                property.size = .single(height: 40)
            })]
        }
        let section2 = Section { (property) -> [Row] in
            property.inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            return [Row(cellType: UILabel.self, cellConfig: nil, configPropertyClosure: { (property) in
                property.size = .single(height: 40)
            })]
        }
        let section3 = Section { (property) -> [Row] in
            property.inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 20)
            return [Row(cellType: UILabel.self, cellConfig: nil, configPropertyClosure: { (property) in
                property.size = .single(height: 40)
            })]
        }
        let section4 = Section { (property) -> [Row] in
            property.inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 20)
            return [Row(cellType: UILabel.self, cellConfig: nil, configPropertyClosure: { (property) in
                property.size = .single(height: 20)
            })]
        }
        let section5 = Section { (property) -> [Row] in
            property.inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 20)
            return [Row(cellType: UILabel.self, cellConfig: nil, configPropertyClosure: { (property) in
                property.size = .single(height: 20)
            }), Row(cellType: UIView.self)]
        }
        
        XCTAssert(section1 == section2)
        XCTAssert(section1.hashValue == section2.hashValue)
        XCTAssert(section2.hashValue != section3.hashValue)
        XCTAssert(section3.hashValue != section4.hashValue)
        XCTAssert(section4.hashValue != section5.hashValue)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
