//
//  ViewController.swift
//  StatusView
//
//  Created by jogendra on 02/05/2019.
//  Copyright (c) 2019 jogendra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StatusViewDelegate {

    var statusView = StatusView()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupStatusView()
    }

    func setupStatusView() {
        statusView = StatusView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        view.addSubview(statusView)
        statusView.isVisible = true
        statusView.titleText = "This will appear on the status view"
        statusView.backgroundColor = .black
        statusView.titleTextColor = .white
    }

    func didTapStatusView() {
        print("Status view tapped!")
    }

}

