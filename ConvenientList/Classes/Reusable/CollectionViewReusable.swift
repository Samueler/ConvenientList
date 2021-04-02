//
//  CollectionViewReusable.swift
//  ConvenientList
//
//  Created by ty.Chen on 2021/4/2.
//

import Foundation

public extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.identifier) matching type \(cellType.self).Please check that you registered the cell beforehand!")
        }
        return cell
    }
    
    func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, forSupplementaryViewOfKind elementKind: String) {
        register(supplementaryViewType.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: supplementaryViewType.identifier)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(supplementaryViewType: T.Type,ofKind elementKind: String,for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: supplementaryViewType.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a view with identifier \(supplementaryViewType.identifier) matching type \(supplementaryViewType.self).Please check that you registered the view beforehand!")
        }
        return view
    }
}

extension UICollectionReusableView: Reusable {}

