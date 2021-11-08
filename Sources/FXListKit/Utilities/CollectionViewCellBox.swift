//
//  CollectionViewCellBox.swift
//  FXListKit
//
//  Created by Mr.wu on 2020/1/26.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#if os(iOS)

import UIKit
import Combine

open class CollectionViewCellBox<View: UIView>: UICollectionViewCell {
    
    public var customView: View
    private var cancellable: Any?
    
    public override init(frame: CGRect) {
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
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
        let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)
        autoLayoutAttributes.frame = autoLayoutFrame
        
        return autoLayoutAttributes
    }
    
    @available(iOS 13.0, *)
    public func configWithPublisher<T: Publisher>(_ publisher: T, callback: ((View, T.Output) -> Void)?) where T.Failure == Never {
        cancellable = publisher.sink { [weak self] value in
            guard let self = self else { return }
            callback?(self.customView, value)
        }
    }
    
}

#endif
