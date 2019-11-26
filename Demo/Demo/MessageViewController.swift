//
//  MessageViewController.swift
//  Demo
//
//  Created by John on 2019/11/26.
//  Copyright © 2019  John. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel()
        label.textColor = .black
        label.text = "Message"
        label.font = .systemFont(ofSize: 20)
        view.addSubview(label)
        label.centerInSuperview()
    }
}
