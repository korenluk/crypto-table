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

    lazy var table: UITableView = {
        let table = UITableView()
        table.separatorColor = .cyan
        table.separatorInset = .zero
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CryptoCell.self, forCellReuseIdentifier: "cellid")
        table.dataSource = self

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
        navigationItem.title = "Crypto Table"
        table.isHidden = true
        setup()
        viewModel.delegate = self
        viewModel.updateCrypto()
    }

    override func viewWillAppear(_ animated: Bool) {
        print("Appear TABLE")
        viewModel.updateCrypto()
        table.reloadData()
    }

    func setup() {
        view.addSubview(table)
        view.addSubview(loadingView)
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        table.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        table.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }

}

extension CryptoTableViewController: CryptoTableViewModelDelegate {
    func didUpdateCrypto() {
        table.isHidden = false
        table.reloadData()
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