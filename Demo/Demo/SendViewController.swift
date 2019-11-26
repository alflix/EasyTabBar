//
//  SendViewController.swift
//  Demo
//
//  Created by John on 2019/11/26.
//  Copyright © 2019  John. All rights reserved.
//

import UIKit

class SendViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.textColor = .black
        label.text = "Send"
        label.font = .systemFont(ofSize: 20)
        view.addSubview(label)
        label.centerInSuperview()
    }
}
