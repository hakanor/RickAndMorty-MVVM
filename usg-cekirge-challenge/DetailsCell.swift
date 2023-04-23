//
//  DetailsCell.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 24.04.2023.
//

import Foundation
import UIKit

class DetailsCell: UITableViewCell {
    
    // MARK: - Subviews
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.contentMode = .scaleToFill
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.contentMode = .scaleToFill
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        [leftLabel, rightLabel] .forEach(contentView.addSubview(_:))
        leftLabel.anchor(left: contentView.leftAnchor)
        rightLabel.anchor(right: contentView.rightAnchor)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Configuration
    func ConfigureDetailsCell(key:String, value:String){
        leftLabel.text = key
        rightLabel.text = value
    }
    
}
