//
//  TableViewData.swift
//  ConvenientList
//
//  Created by ty.Chen on 2021/4/2.
//

import Foundation

public protocol TableViewRowDataProtocol: ListRowDataProtocol {
    var rowHeight: CGFloat { get }
}

public struct TableViewRow: TableViewRowDataProtocol {
    public typealias RowViewType = UITableViewCell

    public var rowData: Any?
    public var rowViewType: UITableViewCell.Type
    public var rowHeight: CGFloat

    public init(rowData: Any?, rowViewType: RowViewType.Type = UITableViewCell.self, rowHeight: CGFloat = 44) {
        self.rowData = rowData
        self.rowViewType = rowViewType
        self.rowHeight = rowHeight
    }
}

public struct TableViewHeaderFooter {
    public var viewType: UITableViewHeaderFooterView.Type
    public var viewData: Any?
    public var viewHeight: CGFloat
    
    public init(viewType: UITableViewHeaderFooterView.Type, viewData: Any?, viewHeight: CGFloat) {
        self.viewType = viewType
        self.viewData = viewData
        self.viewHeight = viewHeight
    }
}

public struct TableViewSection: ListSectionDataProtocol {
    
    public typealias ListRow = TableViewRow
    public var listRows: [TableViewRow]?
    
    public var header: TableViewHeaderFooter?
    public var footer: TableViewHeaderFooter?
    
    public init(listRows: [TableViewRow]? = nil, header: TableViewHeaderFooter? = nil, footer: TableViewHeaderFooter? = nil) {
        self.listRows = listRows
        self.header = header
        self.footer = footer
    }
}

open class TableViewData: ListDataClass<TableViewSection, TableViewRow> {
    public var tableViewDidSelectedClosure: ((UITableView, IndexPath) -> Void)?
}

extension TableViewData: ListDataCRUDProtocol {
    
    @discardableResult public func add(listSection: TableViewSection?, at section: Int) -> Bool {
        guard let listSection = listSection,
              let sections = listSections,
              sections.count >= section
        else { return false }
        listSections?.insert(listSection, at: section)
        return true
    }
    
    @discardableResult public func add(listRow: TableViewRow?, for indexPath: IndexPath) -> Bool {
        guard let listRow = listRow,
              let sections = listSections,
              let rows = sections[indexPath.section].listRows,
              rows.count >= indexPath.row
        else { return false }
        
        listSections?[indexPath.section].listRows?.insert(listRow, at: indexPath.row)
        
        return true
    }
    
    @discardableResult public func read(listSection atSection: Int) -> TableViewSection? {
        guard let sections = listSections else { return nil }
        return sections[safe: atSection]
    }
    
    @discardableResult public func read(listRow forIndexPath: IndexPath) -> TableViewRow? {
        guard let sections = listSections else { return nil }
        return sections[safe: forIndexPath.section]?.listRows?[safe: forIndexPath.row]
    }
    
    @discardableResult public func update(listSection: TableViewSection?, at section: Int) -> Bool {
        guard let sections = listSections,
              let listSection = listSection,
              sections.count > section
        else { return false }
        
        listSections?[section] = listSection
        return true
    }
    
    @discardableResult public func update(listRow: TableViewRow?, for indexPath: IndexPath) -> Bool {
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
