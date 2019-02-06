//
//  ViewController.swift
//  StatusView
//
//  Created by jogendra on 02/05/2019.
//  Copyright (c) 2019 jogendra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StatusViewDelegate {

    func didTapStatusBarView() {
        print("Status view tapped!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStatusView()
    }

    func setupStatusView() {
    }

}

