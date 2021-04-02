//
//  TestCollectionViewCell.swift
//  ConvenientList_Example
//
//  Created by ty.Chen on 2021/4/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import ConvenientList

class TestCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lazy Load
    
    lazy var label: UILabel = {
        let label = UILabel(frame: contentView.bounds)
        label.font = .systemFont(ofSize: 10)
        label.textColor = .red
        return label
    }()
}

extension TestCollectionViewCell: UpdateDataProtocol {
    func update(rowData: Any?) {
        if let data = rowData as? Int {
            label.text = "\(data)"
            label.backgroundColor = .purple
        } else if let data = rowData as? String {
            label.text = data
            label.backgroundColor = .orange
        } else {
            label.text = "未知rowData"
        }
    }
}

