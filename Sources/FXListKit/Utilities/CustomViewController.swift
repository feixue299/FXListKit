//
//  CustomViewController.swift
//  Demo
//
//  Created by Mr.wu on 2020/1/27.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import UIKit

open class CustomViewController<CustomView: UIView>: UIViewController {
    
    open var customView: CustomView
    
    public init() {
        self.customView = CustomView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        customView.frame = view.bounds
        view.addSubview(customView)
    }

}
