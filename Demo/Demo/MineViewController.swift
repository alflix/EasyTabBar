//
//  MineViewController.swift
//  Demo
//
//  Created by John on 2019/11/26.
//  Copyright © 2019 Ganguo. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.textColor = .black
        label.text = "Mine"
        label.font = .systemFont(ofSize: 20)
        view.addSubview(label)
        label.centerInSuperview()
    }
}
