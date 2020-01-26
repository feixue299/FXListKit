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
            case custom(size: CGSize)
        }
        
        public var size: Size = .custom(size: CGSize(width: 60, height: 60))
        public var canMoveItem: Bool = true
    }
    
    public let cellType: AnyClass
    public let configClosure: ((_ view: UIView) -> Void)?
    public let property = Property()
    
    public init<View: UIView>(cellType: View.Type, configPropertyClosure: ((_ property: Property) -> Void)? = nil) {
        self.cellType = cellType
        self.configClosure = nil
        configPropertyClosure?(self.property)
    }
    
    public init<View: UIView, Model>(cellType: View.Type, model: Model, configClosure: @escaping (_ view: View, _ model: Model) -> Void, configPropertyClosure: ((_ property: Property) -> Void)? = nil) {
        self.cellType = cellType
        configPropertyClosure?(self.property)
        self.configClosure = { (view: UIView) -> Void in
            if let vi = view as? View {
                configClosure(vi, model)
            } else {
                fatalError("类型不一致")
            }
        }
    }
}

