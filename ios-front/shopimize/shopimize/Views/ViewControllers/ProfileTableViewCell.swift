//
//  ProfileTableViewCell.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    var testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "fuata"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(testLabel)
        NSLayoutConstraint.activate([
            testLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            testLabel.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
            testLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
