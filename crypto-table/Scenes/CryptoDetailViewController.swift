//
//  CryptoDetailViewController.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

import UIKit
import SDWebImage

protocol CryptoDetailViewControlling {
    var coordinator: CryptoDetailCoordinating? { get set}
}

class CryptoDetailViewController: UIViewController, CryptoDetailViewControlling {
    var coordinator: CryptoDetailCoordinating?

    var viewModel: CryptoDetailViewModel!

    lazy var symbol = makeLabel()

    lazy var name = makeLabel()

    lazy var nameFull = makeLabel()

    lazy var maxSupply = makeLabel()

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
        viewModel.downloadCrypto()
    }

    func setupUI() {
        view.backgroundColor = .black
        view.addSubview(symbol)
        view.addSubview(name)
        view.addSubview(nameFull)
        view.addSubview(maxSupply)
        view.addSubview(image)

        navigationItem.title = viewModel.crypto

        image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 300).isActive = true
        image.heightAnchor.constraint(equalToConstant: 300).isActive = true

        symbol.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        symbol.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50).isActive = true

        name.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        name.topAnchor.constraint(equalTo: symbol.bottomAnchor, constant: 25).isActive = true

        nameFull.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameFull.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 25).isActive = true

        maxSupply.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        maxSupply.topAnchor.constraint(equalTo: nameFull.bottomAnchor, constant: 25).isActive = true
    }

    func setupData() {
        guard let cryptoDetail = viewModel.cryptoDetail else {
            return
        }

        symbol.text = "Symbol: " + cryptoDetail.symbol
        name.text = "Name: " + cryptoDetail.name
        nameFull.text = "Full Name: " + cryptoDetail.nameFull
        maxSupply.text = "Max Supply: " + cryptoDetail.maxSupply
        image.sd_setImage(with: URL(string: viewModel.cryptoDetail?.iconUrl ?? ""),
                          placeholderImage: UIImage(named: "dollar"))
    }

    func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }
}

extension CryptoDetailViewController: CryptoDetailViewModelDelegate {
    func didDownloadCrypto() {
        setupData()
    }

    func didFail(with error: CryptoError) {
        print(error)
    }
}
