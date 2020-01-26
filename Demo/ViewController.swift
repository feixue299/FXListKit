//
//  ViewController.swift
//  Demo
//
//  Created by Mr.wu on 2020/1/26.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import FXListKit
import UIKit

class ViewController: UIViewController {
    let listManager = ListViewManager {
        [Section { property in
            property.minimumInteritemSpacing = 1
            property.minimumLineSpacing = 1
            var textGroup: [Row] = ["hello", "world", "i", "love", "you", "java",
                                    "swift", "python", "objective-c", "ruby", "Dart",
                                    "go", "PHP", "c", "c#", "c++", "feixue", "aria",
                                    "lisp", "luna"]
                .map { text in
                    Row(cellType: CollectionViewCellBox<UILabel>.self, model: text, configClosure: { view, model in
                        view.backgroundColor = UIColor.white
                        view.customView.textAlignment = .center
                        view.customView.text = model
                    }, configPropertyClosure: { property in
                        property.size = .section(value: 5)
                    })
                }
            let imageGroup: [Row] = ["0", "2_04", "4", "2_06",
                                     "2_02", "1", "2_05", "5", "2_05"]
                .map({ UIImage(named: $0)! })
                .map { image in
                    Row(cellType: CollectionViewCellBox<UIImageView>.self, model: image, configClosure: { view, model in
                        view.customView.image = model
                    }, configPropertyClosure: { property in
                        property.size = .custom(size: image.size)
                    })
                }
            textGroup.append(contentsOf: imageGroup)
            return textGroup
        }]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)

        collectionView.dataSource = listManager
        collectionView.delegate = listManager
    }
}
