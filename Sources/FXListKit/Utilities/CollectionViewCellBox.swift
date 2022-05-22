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

@available(iOS 13.0, *)
public class CellPublisherChannel<View> {
    
    public typealias CallBack<T: Publisher> = (_ view: View, _ value: T.Output) -> Void
    
    private var cancellable: [AnyCancellable] = []
    private let view: View
    
    init(view: View) {
        self.view = view
    }
    
    func initPublisher<T: Publisher>(_ publisher: T?, callback: CallBack<T>?) where T.Failure == Never {
        guard let publisher = publisher else { return }
        cancellable = [
            publisher.sink { [weak self] value in
                guard let self = self else { return }
                callback?(self.view, value)
            }
        ]
    }
    
    @discardableResult
    public func appendPublisher<T: Publisher>(_ publisher: T?, callback: CallBack<T>?) -> Self where T.Failure == Never {
        guard let publisher = publisher else { return self }
        cancellable.append(
            publisher.sink { [weak self] value in
                guard let self = self else { return }
                callback?(self.view, value)
            }
        )
        return self
    }
}
 
open class CollectionViewCellBox<View: UIView>: UICollectionViewCell {
    
    public var customView: View
    private var channel: Any?
    
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
    @discardableResult
    public func configWithPublisher<T: Publisher>(_ publisher: T?, callback: ((_ view: View, _ value: T.Output) -> Void)?) -> CellPublisherChannel<View> where T.Failure == Never {

        let _channel = CellPublisherChannel(view: customView)
        if let publisher = publisher {
            _channel.initPublisher(publisher, callback: callback)
        }
        channel = _channel
        return _channel
    }
    
}

#endif
