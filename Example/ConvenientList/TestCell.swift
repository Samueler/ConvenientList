//
//  TestCell.swift
//  ConvenientList_Example
//
//  Created by ty.Chen on 2021/4/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import ConvenientList

class TestCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lazy Load
    
    lazy var label: UILabel = {
        let label = UILabel(frame: contentView.bounds)
        label.textColor = .red
        return label
    }()
}

// MARK : UpdateProtocol

extension TestCell: UpdateDataProtocol {
    func update(rowData: Any?) {
        if let data = rowData as? Int {
            label.text = "\(data)"
        } else if let data = rowData as? String {
            label.text = data
        } else {
            label.text = "未知rowData"
        }
    }
}
