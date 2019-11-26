//
//  NearbyViewController.swift
//  Demo
//
//  Created by John on 2019/3/20.
//  Copyright © 2019 John. All rights reserved.
//

import UIKit

class NearbyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel()
        label.textColor = .black
        label.text = "Nearby"
        label.font = .systemFont(ofSize: 20)
        view.addSubview(label)
        label.centerInSuperview()
    }
}
