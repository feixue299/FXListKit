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
    struct Model {
        var textGroup: [String]
        var imageGroup: [UIImage]
        
        mutating func random() {
            for i in 0..<textGroup.count {
                let j = Int(arc4random()) % textGroup.count
                textGroup.swapAt(i, j)
            }
            for i in 0..<imageGroup.count {
                let j = Int(arc4random()) % imageGroup.count
                imageGroup.swapAt(i, j)
            }
        }
    }

    var model = Model(textGroup: ["hello", "world", "i", "love", "you", "java",
                                  "swift", "python", "objective-c", "ruby", "Dart",
                                  "go", "PHP", "c", "c#", "c++", "feixue", "aria",
                                  "lisp", "luna"],
                      imageGroup: ["0", "2_04", "4", "2_06",
                                   "2_02", "1", "2_05", "5", "2_05"].map({ UIImage(named: $0)! }))

    lazy var listManager = ListViewManager {
        [Section { [weak self] property in
            guard let strongSelf = self else { return [] }
            property.minimumInteritemSpacing = 1
            property.minimumLineSpacing = 1
            return strongSelf.textRowGroup() + strongSelf.imageRowGroup()
        }]
    }
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "refresh", style: .plain, target: self, action: #selector(refreshItemTap(sender:)))

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)

        collectionView.dataSource = listManager
        collectionView.delegate = listManager
    }
    
    @objc func refreshItemTap(sender: UIBarButtonItem) {
        model.random()
        listManager.reloadData()
        collectionView.reloadData()
    }
}

extension ViewController {
    func textRowGroup() -> [Row] {
        return model.textGroup.map { [weak self] text in
            Row(cellType: CollectionViewCellBox<UILabel>.self,
                modelConfig: (text, { view, model in
                    view.backgroundColor = UIColor.white
                    view.customView.textAlignment = .center
                    view.customView.text = model
                }), configPropertyClosure: { property in
                    property.size = .section(value: 4)
                }, didSelect: {
                    let vc = CustomViewController<UILabel>()
                    vc.customView.textAlignment = .center
                    vc.customView.text = text
                    self?.navigationController?.pushViewController(vc, animated: true)
            })
        }
    }

    func imageRowGroup() -> [Row] {
        return model.imageGroup.map { [weak self] image in
            Row(cellType: CollectionViewCellBox<UIImageView>.self,
                modelConfig: (image, { view, model in
                    view.customView.image = model
                }), configPropertyClosure: { property in
                    property.size = .custom(size: image.size)
            }, didSelect: {
                let vc = CustomViewController<UIImageView>()
                vc.customView.contentMode = .scaleAspectFit
                vc.customView.image = image
                self?.navigationController?.pushViewController(vc, animated: true)
            })
        }
    }
}
