//
//  CryptoDetailViewController.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

import UIKit

protocol CryptoDetailViewControlling {
    var coordinator: CryptoDetailCoordinating? { get set}
}

class CryptoDetailViewController: UIViewController, CryptoDetailViewControlling {
    var coordinator: CryptoDetailCoordinating?

    var viewModel: CryptoDetailViewModel!

    lazy var name: UILabel = {
        let label = UILabel()
//        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var maxSupply: UILabel = {
        let label = UILabel()
//        label.text = "Max Supply"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
        viewModel.downloadCrypto()
    }

    func setupUI() {
        view.addSubview(name)
        view.addSubview(maxSupply)
        name.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        name.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        maxSupply.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        maxSupply.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    func setupData() {
        name.text = viewModel.crytoDetail?.nameFull
        maxSupply.text = viewModel.crytoDetail?.maxSupply
    }

}

extension CryptoDetailViewController: CryptoDetailViewModelDelegate {
    func didDownloadCrypto() {
        setupData()
    }

    func didFail(with error: Error) {
        print(error)
    }
}
