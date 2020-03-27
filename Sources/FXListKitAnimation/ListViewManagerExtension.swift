//
//  FXlistKitAnimation.swift
//  
//
//  Created by Mr.wu on 2020/3/26.
//

import Foundation
#if canImport(FXListKit)
import FXListKit
#endif

#if canImport(DifferenceKit)
import DifferenceKit

public extension ListViewManager {
    
    func reloadWithAnimation() {
        let data: [ArraySection<Section, Row>] = dataSource.map({ ArraySection(model: $0, elements: $0.rows) })
        generateDataSource()
        let newData: [ArraySection<Section, Row>] = dataSource.map({ ArraySection(model: $0, elements: $0.rows) })
        let changeset = StagedChangeset(source: data, target: newData)
        collectionView?.reload(using: changeset, setData: { [weak self] (data) in
            self?.dataSource = data.map({ $0.model })
        })
    }
}

extension Section: Differentiable { }
extension Row: Differentiable { }
#endif

