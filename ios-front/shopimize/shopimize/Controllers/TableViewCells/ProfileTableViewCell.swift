//
//  ProfileTableViewCell.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    var containerView = UIView()
    
    var testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupContainer()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupContainer() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        addSubview(testLabel)
        
        // self.contentView.backgroundColor = .clear
        
        // TODO: Create shadow with beziere path to be more eficient
        /// https://stackoverflow.com/questions/37645408/uitableviewcell-rounded-corners-and-shadow
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = false
        containerView.layer.shadowRadius = 4.0
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 2, height: 5)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                               constant: CGFloat(TableConstants.cellVerticalInset)),
            
            containerView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,
                                                 constant: -CGFloat(TableConstants.cellHorizontalInset)),
            
            containerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -CGFloat(TableConstants.cellVerticalInset)),
            
            containerView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,
                                                constant: CGFloat(TableConstants.cellHorizontalInset)),
            
            testLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            testLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            testLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
