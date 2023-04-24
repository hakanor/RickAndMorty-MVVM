//
//  DetailsCell.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 24.04.2023.
//

import Foundation
import UIKit

class DetailsCell: UIView {
    
    // MARK: - Subviews
    private lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.contentMode = .scaleToFill
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.contentMode = .scaleToFill
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Lifecycle
    init(key: String, value: String) {
        super.init(frame: .zero)
        setupViews()
        ConfigureDetailsCell(key: key, value: value)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(keyLabel)
        addSubview(valueLabel)
        
        keyLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: valueLabel.leftAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
        valueLabel.anchor(top: topAnchor, left: keyLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 16, width: 0, height: 0)
    }
    
    // MARK: - Configuration
    func ConfigureDetailsCell(key:String, value:String){
        keyLabel.text = key
        valueLabel.text = value
    }
    
}
