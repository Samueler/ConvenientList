//
//  TableViewReusable.swift
//  ConvenientList
//
//  Created by ty.Chen on 2021/4/2.
//

import Foundation

public extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cellType.identifier) as? T
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.identifier) matching type \(cellType.self).Please check that you registered the cell beforehand!")
        }
        return cell
    }
    
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type) {
        register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.identifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type) -> T {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: viewType.identifier) as? T else {
            fatalError("Failed to dequeue a view with identifier \(viewType.identifier) matching type \(viewType.self).Please check that you registered the cell beforehand!")
        }
        return headerFooter
    }
}

extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }
