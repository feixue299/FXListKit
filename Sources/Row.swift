//
//  Row.swift
//  FXListKit
//
//  Created by Mr.wu on 2020/1/25.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import Foundation
import UIKit

public struct Row {
    
    public class Property {
        public enum Size {
            case section(value: Int)
            case single(height: CGFloat)
            case custom(size: CGSize)
        }
        
        public var size: Size = .custom(size: CGSize(width: 60, height: 60))
    }
    
    public let cellType: AnyClass
    public let configClosure: ((_ view: UIView) -> Void)?
    public let property = Property()
    public let didSelect: (() -> Void)?
    
    public init<View: UIView, Model>(cellType: View.Type,
                                     modelConfig: (model: Model, configClosure: (_ view: View, _ model: Model) -> Void)? = nil,
                                     configPropertyClosure: ((_ property: Property) -> Void)? = nil,
                                     didSelect: (() -> Void)? = nil) {
        self.cellType = cellType
        self.configClosure = { (view: UIView) -> Void in
            if let vi = view as? View {
                modelConfig?.configClosure(vi, modelConfig!.model)
            } else {
                fatalError("类型不一致")
            }
        }
        configPropertyClosure?(self.property)
        self.didSelect = didSelect
    }
}

