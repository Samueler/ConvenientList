//
//  ListData.swift
//  ConvenientList
//
//  Created by ty.Chen on 2021/4/2.
//

import Foundation

public protocol ListRowDataProtocol {
    associatedtype RowViewType: Reusable
    var rowData: Any? { get }
    var rowViewType: RowViewType.Type { get }
}

public protocol ListSectionDataProtocol {
    associatedtype ListRow: ListRowDataProtocol
    var listRows: [ListRow]? { get }
}

public protocol ListDataClassProtocol {
    associatedtype ListSection: ListSectionDataProtocol
    associatedtype ListRow: ListRowDataProtocol

    var listSections: [ListSection]? { get }

    init(listSections: [ListSection]?)

    subscript(section: Int) -> ListSection? { get }
    subscript(row: Int, section: Int) -> ListRow? { get }
    subscript(indexPath: IndexPath) -> ListRow? { get }
}

public protocol UpdateDataProtocol {
    func update(rowData: Any?)
}

public protocol ListDataCRUDProtocol {
    associatedtype ListSection: ListSectionDataProtocol
    associatedtype ListRow: ListRowDataProtocol
    
    @discardableResult func create(sectionData listSection: ListSection?, section: Int) -> Bool
    @discardableResult func create(rowData listRow: ListRow?, at indexPath: IndexPath) -> Bool
    @discardableResult func read(at section: Int) -> ListSection?
    @discardableResult func read(rowData indexPath: IndexPath) -> ListRow?
    @discardableResult func update(sectionData listSection: ListSection?, at section: Int) -> Bool
    @discardableResult func update(rowData listRow: ListRow?, at indexPath: IndexPath) -> Bool
    @discardableResult func delete(at section: Int) -> Bool
    @discardableResult func delete(rowData indexPath: IndexPath) -> Bool
}

open class ListDataClass<ListSection: ListSectionDataProtocol, ListRow: ListRowDataProtocol>: NSObject, ListDataClassProtocol {
    public typealias ListSection = ListSection
    public typealias ListRow = ListRow
    
    public var listSections: [ListSection]?
    
    public var listDidScrollClosure: ((UIScrollView) -> Void)?
    
    public var listDidZoomClosure: ((UIScrollView) -> Void)?
    
    public var listWillBeginDraggingClosure: ((UIScrollView) -> Void)?
    
    public var listWillEndDraggingClosure: ((UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>) -> Void)?
    
    public var listDidEndDraggingClosure: ((UIScrollView, Bool) -> Void)?
    
    public var listWillBeginDeceleratingClosure: ((UIScrollView) -> Void)?
    
    public var listDidEndDeceleratingClosure: ((UIScrollView) -> Void)?
    
    public var listDidEndScrollingAnimationClosure: ((UIScrollView) -> Void)?
    
    public var listShouldScrollToTopClosure: ((UIScrollView) -> Bool)?
    
    public var listDidScrollToTopClosure: ((UIScrollView) -> Void)?
    
    required public init(listSections: [ListSection]? = nil) {
        self.listSections = listSections
    }
    
    public subscript(section: Int) -> ListSection? {
        return listSections?[safe: section]
    }
    
    public subscript(row: Int, section: Int) -> ListRow? {
        guard let section = self[section] else {
            return nil
        }

        guard let row = section.listRows?[safe: row] as? ListRow else {
            return nil
        }
        
        return row
    }
    
    public subscript(indexPath: IndexPath) -> ListRow? {
        return self[indexPath.row, indexPath.section]
    }
}

