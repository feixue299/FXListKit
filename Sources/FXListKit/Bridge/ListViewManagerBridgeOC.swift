//
//  ListViewManagerBridgeOC.swift
//  FXListKit
//
//  Created by 8-PC on 2020/6/2.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import Foundation

extension ListViewManager {
    @objc public convenience init(sections: [SectionBridgeOC]) {
        self.init { () -> [Section] in
            return sections.map({ $0.section })
        }
    }
}
