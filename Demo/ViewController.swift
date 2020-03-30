//
//  ViewController.swift
//  Demo
//
//  Created by Mr.wu on 2020/1/26.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

import FXListKit
import FXListKitAnimation
import UIKit

class ViewController: UIViewController {
    struct Model {
        var textGroup: [String]
        var imageGroup: [UIImage]

        mutating func random() {
            random(array: &textGroup)
            random(array: &imageGroup)
        }

        func random<Element>(array: inout [Element]) {
            for i in 0 ..< array.count {
                let j = Int(arc4random()) % array.count
                array.swapAt(i, j)
            }
        }
    }

    var model = Model(textGroup: ["hello", "world", "i", "love", "you", "java",
                                  "swift", "python", "objective-c", "ruby", "Dart",
                                  "go", "PHP", "c", "c#", "c++", "feixue", "aria",
                                  "lisp", "luna"],
                      imageGroup: ["0", "2_04", "4", "2_06",
                                   "2_02", "1", "2_05", "5"].map({ UIImage(named: $0)! }))

    lazy var listManager = ListViewManager { [weak self] in
        guard let strongSelf = self else { return [] }
        return [Section { property in
            property.minimumInteritemSpacing = 1
            property.minimumLineSpacing = 1
            property.inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            return strongSelf.model.textGroup.map { text in
                Row(cellType: CollectionViewCellBox<UILabel>.self,
                    key: text,
                    cellConfig: { view in
                        view.backgroundColor = UIColor.white
                        view.customView.textAlignment = .center
                        view.customView.text = text
                    },
                    configPropertyClosure: { property in
                        property.size = .section(value: 4)
                    },
                    didSelect: {
                        let vc = CustomViewController<UILabel>()
                        vc.customView.textAlignment = .center
                        vc.customView.text = text
                        self?.navigationController?.pushViewController(vc, animated: true)
                })
            }
        }, Section { _ in
            [Row(cellType: CollectionViewCellBox<UILabel>.self,
                 cellConfig: { view in
                     view.backgroundColor = .white
                     view.customView.textAlignment = .left
                     view.customView.text = "single line"
                 },
                 configPropertyClosure: { property in
                     property.size = .single(height: 44)
                 },
                 didSelect: {
                     let vc = CustomViewController<UILabel>()
                     vc.customView.textAlignment = .center
                     vc.customView.text = "single line"
                     self?.navigationController?.pushViewController(vc, animated: true)
            })]
        }, Section { _ in
            strongSelf.model.imageGroup.map { image in
                Row(cellType: CollectionViewCellBox<UIImageView>.self,
                    key: image,
                    cellConfig: { view in
                        view.customView.image = image
                    },
                    configPropertyClosure: { property in
                        property.size = .custom(size: image.size)
                    },
                    didSelect: {
                        let vc = CustomViewController<UIImageView>()
                        vc.customView.contentMode = .scaleAspectFit
                        vc.customView.image = image
                        self?.navigationController?.pushViewController(vc, animated: true)
                })
            }
        }]
    }

    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "refresh", style: .plain, target: self, action: #selector(refreshItemTap(sender:)))

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)

        listManager.configCollectionView(collectionView)
    }

    @objc func refreshItemTap(sender: UIBarButtonItem) {
        model.random()
        listManager.reloadWithAnimation()
    }
}
