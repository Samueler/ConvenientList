//
//  CollectionViewData.swift
//  ConvenientList
//
//  Created by ty.Chen on 2021/4/2.
//

import Foundation

public protocol CollectionViewItemDataProtocol: ListRowDataProtocol {
    var itemSize: CGSize { get }
}

public struct CollectionViewItem: CollectionViewItemDataProtocol {
    public typealias RowViewType = UICollectionViewCell
    
    public var rowData: Any?
    public var rowViewType: UICollectionViewCell.Type
    public var itemSize: CGSize
    
    public init(rowData: Any?, rowViewType: RowViewType.Type = UICollectionViewCell.self, itemSize: CGSize = CGSize(width: 44, height: 44)) {
        self.rowData = rowData
        self.rowViewType = rowViewType
        self.itemSize = itemSize
    }
}

public struct CollectionViewHeaderFooter {
    public var viewType: UICollectionReusableView.Type
    public var viewData: Any?
    public var viewHeight: CGFloat
    
    public init(viewType: UICollectionReusableView.Type, viewData: Any?, viewHeight: CGFloat) {
        self.viewType = viewType
        self.viewData = viewData
        self.viewHeight = viewHeight
    }
}

public struct CollectionViewSection: ListSectionDataProtocol {
    public typealias ListRow = CollectionViewItem
    public var listRows: [CollectionViewItem]?
    
    public var header: CollectionViewHeaderFooter?
    public var footer: CollectionViewHeaderFooter?
    
    public init(listRows: [CollectionViewItem]? = nil, header: CollectionViewHeaderFooter? = nil, footer: CollectionViewHeaderFooter? = nil) {
        self.listRows = listRows
        self.header = header
        self.footer = footer
    }
}

open class CollectionViewData: ListDataClass<CollectionViewSection, CollectionViewItem> {
    public var collectionViewDidSlectedClosure: ((UICollectionView, IndexPath) -> Void)?
}

extension CollectionViewData: ListDataCRUDProtocol {

    @discardableResult public func add(listSection: CollectionViewSection?, at section: Int) -> Bool {
        guard let listSection = listSection,
              let sections = listSections,
              sections.count >= section
        else { return false }
        listSections?.insert(listSection, at: section)
        return true
    }
    
    @discardableResult public func add(listRow: CollectionViewItem?, for indexPath: IndexPath) -> Bool {
        guard let listRow = listRow,
              let sections = listSections,
              let rows = sections[indexPath.section].listRows,
              rows.count >= indexPath.row
        else { return false }
        
        listSections?[indexPath.section].listRows?.insert(listRow, at: indexPath.row)
        
        return true
    }
    
    @discardableResult public func read(listSection atSection: Int) -> CollectionViewSection? {
        guard let sections = listSections else { return nil }
        return sections[safe: atSection]
    }
    
    @discardableResult public func read(listRow forIndexPath: IndexPath) -> CollectionViewItem? {
        guard let sections = listSections else { return nil }
        return sections[safe: forIndexPath.section]?.listRows?[safe: forIndexPath.row]
    }
    
    @discardableResult public func update(listSection: CollectionViewSection?, at section: Int) -> Bool {
        guard let sections = listSections,
              let listSection = listSection,
              sections.count > section
        else { return false }
        
        listSections?[section] = listSection
        return true
    }
    
    @discardableResult public func update(listRow: CollectionViewItem?, for indexPath: IndexPath) -> Bool {
        guard let sections = listSections,
              let listRow = listRow,
              let rows = sections[indexPath.section].listRows,
              rows.count > indexPath.row
        else { return false }
        
        listSections?[indexPath.section].listRows?[indexPath.row] = listRow
        return true
    }
    
    @discardableResult public func delete(listSection atSection: Int) -> Bool {
        guard let sections = listSections,
              sections.count > atSection else { return false }
        listSections?.remove(at: atSection)
        return true
    }
    
    @discardableResult public func delete(listRow forIndexPath: IndexPath) -> Bool {
        guard let sections = listSections,
              let rows = sections[forIndexPath.section].listRows,
              rows.count > forIndexPath.row
        else { return false }
        listSections?[forIndexPath.section].listRows?.remove(at: forIndexPath.row)
        return true
    }

}

