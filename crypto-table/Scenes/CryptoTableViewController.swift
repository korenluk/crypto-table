//
//  CryptoTableViewController.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

import UIKit

protocol CryptoTableViewControlling {
    var coordinator: CryptoTableCoordinating? { get set}
}

class CryptoTableViewController: UIViewController, CryptoTableViewControlling {
    var coordinator: CryptoTableCoordinating?

    var viewModel: CryptoTableViewModel!

    var table: UITableView = {
        let table = UITableView()
        table.backgroundColor = .black
        table.separatorColor = .cyan
        table.separatorInset = .zero
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CryptoCell.self, forCellReuseIdentifier: "cellid")
        return table
    }()

    var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.transform = CGAffineTransform(scaleX: 1.75, y: 1.75)
        indicator.startAnimating()
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = .black
        navigationItem.title = "Crypto Table"
        setup()
        table.dataSource = self
        table.delegate = self
        viewModel.delegate = self
        viewModel.downloadCrypto()
    }

    override func viewWillAppear(_ animated: Bool) {
        print("Appear TABLE")
    }

    func setup() {
        view.addSubview(table)
        view.addSubview(loadingView)
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        table.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

}

extension CryptoTableViewController: CryptoTableViewModelDelegate {
    func didDownloadCrypto() {
        table.reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.getTarget(), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .white
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }

    func didFail(with error: Error) {
        print(error)
    }
}

extension CryptoTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCrypto()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let crypto = viewModel.crypto(at: indexPath.row)
        cell.textLabel?.text = crypto.name
        cell.detailTextLabel?.text = crypto.price.description + " $"
        return cell
    }
}

extension CryptoTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let crypto = viewModel.crypto(at: indexPath.row).name
        print(crypto)
        coordinator?.select(crypto: crypto)
    }
}
