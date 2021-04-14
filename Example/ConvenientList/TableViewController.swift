//
//  TableViewController.swift
//  ConvenientList_Example
//
//  Created by ty.Chen on 2021/4/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import ConvenientList

class TableViewController: UIViewController {

    private var data: TableViewData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TableViewController"
        
        var rows = [TableViewRow]()
        for index in 0..<100 {
            if index % 2 == 0 {
                let row = TableViewRow(rowData: index, rowViewType: TestCell.self, rowHeight: 100)
                rows.append(row)
            } else {
                let row = TableViewRow(rowData: "index:\(index)", rowViewType: TestCell.self, rowHeight: 44)
                rows.append(row)
            }
        }
        
        let section = TableViewSection(listRows: rows)
        
        let header = TableViewHeaderFooter(viewType: TableViewHeaderFooterView.self, viewData: "------Header------", viewHeight: 44)
        let footer = TableViewHeaderFooter(viewType: TableViewHeaderFooterView.self, viewData: "------Footer------", viewHeight: 88)
        
//        var section =  TableViewSection(listRows: rows, footer: footer)
//        section.header = header
        
        data = TableViewData(listSections: [section])
        
//        data?.listDidScrollClosure = { scrollView in
//            print("scrollView: \(scrollView.contentOffset.y)")
//        }
        
        data?.tableViewDidSelectedClosure = { [weak self] tableView, indexPath in
            guard let self = self else { return }
//            print("indexPath: \(indexPath.row)")
            
            guard let data = self.data else { return }
            
            let row = TableViewRow(rowData: "我是新加的", rowViewType: TestCell.self, rowHeight: 50)
            let section = TableViewSection(listRows: [row])
            
            data.add(listSection: section, at: data.listSections?.count ?? 0)
            
//            let result = data.add(listRow: row, for: IndexPath(row: data.listSections?[0].listRows?.count ?? 0, section: 0))
            
//            let result = data.update(listSection: section, at: 0)
//            let result = data.update(listRow: row, for: IndexPath(item: 0, section: 0))
//            let result = data.delete(listSection: 0)
//            let result = data.delete(listRow: IndexPath(row: 0, section: 0))
            
//            if result {
                self.tableView.reloadData()
//            }
        }
        
        view.addSubview(tableView)
        tableView.dataSource = data
        tableView.delegate = data
        tableView.reloadData()
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.registerHeaderFooterView(viewType: TableViewHeaderFooterView.self)
        return tableView
    }()
}
