//
//  CollectionHeaderFooterView.swift
//  ConvenientList_Example
//
//  Created by ty.Chen on 2021/4/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import ConvenientList

class CollectionHeaderFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = bounds
    }
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
}

extension CollectionHeaderFooterView: UpdateDataProtocol {
    func update(rowData: Any?) {
        guard let data = rowData as? String else { return }
        titleLabel.text = data
    }
}
