//
//  CryptoCell.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

import UIKit

class CryptoCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.textLabel?.textColor = .white
        self.detailTextLabel?.textColor = .white
        self.selectionStyle = .none
        self.backgroundColor = .black
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
