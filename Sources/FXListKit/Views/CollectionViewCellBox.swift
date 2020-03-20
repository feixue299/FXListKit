//
//  CollectionViewCellBox.swift
//  FXListKit
//
//  Created by Mr.wu on 2020/1/26.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#if os(iOS)

import UIKit

public class CollectionViewCellBox<View: UIView>: UICollectionViewCell {
    
    public var customView: View
    
    override init(frame: CGRect) {
        customView = View()
        super.init(frame: frame)
        customView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#endif
