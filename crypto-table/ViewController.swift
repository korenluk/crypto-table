//
//  ViewController.swift
//  crypto-table
//
//  Created by Lukas Korinek on 02.09.2021.
//

import UIKit

class ViewController: UIViewController {

    lazy var text: UILabel = {
        let label = UILabel()
        label.text = "CRYPTO APP"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }

    func setup() {
        view.addSubview(text)
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
