//
//  HomeTableViewCell.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 24.04.2023.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let cornerRadiusValue : CGFloat = 16

    // MARK: - Subviews
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadiusValue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.contentMode = .scaleAspectFit
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var genderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadiusValue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.addSubview(containerView)

        containerView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 10, paddingBottom: 8, paddingRight: 10)
        
        [image, nameLabel, genderImage] .forEach(containerView.addSubview(_:))
        
        image.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 84, height: 84)
        image.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        nameLabel.anchor(top: containerView.topAnchor, left: image.rightAnchor, bottom: containerView.bottomAnchor, right: genderImage.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        genderImage.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor ,paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 84, height: 84)
        genderImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = cornerRadiusValue
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 0.2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureCell(character: Character){
        let url = URL(string: character.image)
        self.image.sd_setImage(with: url,completed: nil)
        self.nameLabel.text = character.name
        switch character.gender {
            case "Male":
                self.genderImage.image = UIImage(named: "male.png")
            case "Female":
                self.genderImage.image = UIImage(named: "female.png")
            case "unknown":
                self.genderImage.image = UIImage(named: "unknown.png")
            default:
                print("Error switch case")
        }
    }

}
