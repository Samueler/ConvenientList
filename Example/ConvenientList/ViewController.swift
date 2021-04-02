//
//  ViewController.swift
//  ConvenientList
//
//  Created by Samueler on 04/02/2021.
//  Copyright (c) 2021 Samueler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func tableViewAction(_ sender: Any) {
        let vc = TableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func collectionViewAction(_ sender: Any) {
        let vc = CollectionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

