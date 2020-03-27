//
//  RowTests.swift
//  FXListKitTests
//
//  Created by Mr.wu on 2020/3/27.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import XCTest
import FXListKit

class RowTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHashable() {
        
        let row1 = Row(cellType: UILabel.self, cellConfig: nil, configPropertyClosure: { (property) in
            property.size = .single(height: 60)
        })
        let row2 = Row(cellType: UILabel.self, cellConfig: nil, configPropertyClosure: { (property) in
            property.size = .single(height: 60)
        })
        let row3 = Row(cellType: UILabel.self, cellConfig: nil, configPropertyClosure: { (property) in
            property.size = .single(height: 45)
        })
        let row4 = Row(cellType: UIView.self, cellConfig: nil, configPropertyClosure: { (property) in
            property.size = .single(height: 45)
        })
        let row5 = Row(cellType: UIView.self, cellConfig: nil, configPropertyClosure: { (property) in
            property.size = .section(value: 45)
        })
        
        XCTAssert(row1.hashValue == row2.hashValue)
        XCTAssert(row1 == row2)
        
        XCTAssert(row1.hashValue != row3.hashValue)
        XCTAssert(row1 != row3)
        
        XCTAssert(row3.hashValue != row4.hashValue)
        XCTAssert(row3 != row4)
        
        XCTAssert(row4.hashValue != row5.hashValue)
        XCTAssert(row4 != row5)
    }
    
    func testPropertySizeHashable() {
        let size1 = Row.Property.Size.section(value: 10)
        let size2 = Row.Property.Size.section(value: 20)
        let size3 = Row.Property.Size.single(height: 10)
        let size4 = Row.Property.Size.single(height: 10)
        
        print("size1.hash:\(size1.hashValue)")
        print("size2.hash:\(size2.hashValue)")
        print("size3.hash:\(size3.hashValue)")
        print("size4.hash:\(size4.hashValue)")
        
        XCTAssert(size1 != size2)
        XCTAssert(size1 != size3)
        XCTAssert(size3 == size4)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
