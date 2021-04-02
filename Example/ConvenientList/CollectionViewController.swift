//
//  CollectionViewController.swift
//  ConvenientList_Example
//
//  Created by ty.Chen on 2021/4/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import ConvenientList

class CollectionViewController: UIViewController {
    
    private var data: CollectionViewData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CollectionViewController"
        
        var items = [CollectionViewItem]()
        for index in 0..<100 {
            if index % 2 == 0 {
                let item = CollectionViewItem(rowData: index, rowViewType: TestCollectionViewCell.self, itemSize: CGSize(width: 88, height: 88))
                items.append(item)
            } else {
                let item = CollectionViewItem(rowData: "index:\(index)", rowViewType: TestCollectionViewCell.self, itemSize: CGSize(width: 88, height: 88))
                items.append(item)
            }
        }
        
        let header = CollectionViewHeaderFooter(viewType: CollectionHeaderFooterView.self, viewData: "------Header------", viewHeight: 88)
        let footer = CollectionViewHeaderFooter(viewType: CollectionHeaderFooterView.self, viewData: "------Footer------", viewHeight: 44)
        
        let section = CollectionViewSection(listRows: items, header: header, footer: footer)
        data = CollectionViewData(listSections: [section])
        
        data?.listDidScrollClosure = { scrollView in
            print("scrollView: \(scrollView.contentOffset.y)")
        }
        
        data?.collectionViewDidSlectedClosure = { tableView, indexPath in
            print("indexPath: \(indexPath.row)")
        }
        
        view.addSubview(collectionView)
        collectionView.dataSource = data
        collectionView.delegate = data
        collectionView.reloadData()
    }
    
    // MARK: - Lazy Load
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(cellType: TestCollectionViewCell.self)
        collectionView.register(supplementaryViewType: CollectionHeaderFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(supplementaryViewType: CollectionHeaderFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
        return collectionView
    }()
}

