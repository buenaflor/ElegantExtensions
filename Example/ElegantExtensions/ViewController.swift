//
//  ViewController.swift
//  ElegantExtensions
//
//  Created by Giancarlo Buenaflor on 06/05/2018.
//  Copyright (c) 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import ElegantExtensions

class ViewController: UIViewController {

    let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.add(subview: topContainerView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.5)
            ]}
    }
}

