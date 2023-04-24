//
//  CharacterDetailsViewController.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 24.04.2023.
//

import UIKit
import SDWebImage

class CharacterDetailsViewController: UIViewController {
    //MARK: -Properties
    private let character: Character
    private var detailsArray: [(key: String, value: String)] = []
    
    //MARK: -Subviews
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "arrow.left")
        button.tintColor = .black
        button.backgroundColor = .clear
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initialization
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
        self.setupArray()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        configureUI()
        configureStackView()
        fetchCharacterImage()
    }
    
    // MARK: - Helper Functions
    private func configureUI(){
        self.title = self.character.name
        view.backgroundColor = .yellow
        [scrollView] .forEach(view.addSubview(_:))
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        scrollView.addSubview(characterImage)
        scrollView.addSubview(stackView)
        
        characterImage.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        stackView.anchor(top: characterImage.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func configureStackView(){
        for detail in self.detailsArray {
            
            let keyLabel = UILabel()
            keyLabel.text = detail.key
            keyLabel.numberOfLines = 2
            keyLabel.textAlignment = .left
            keyLabel.font = UIFont.systemFont(ofSize: 22)
            
            let valueLabel = UILabel()
            valueLabel.text = detail.value
            valueLabel.numberOfLines = 2
            valueLabel.textAlignment = .left
            valueLabel.font = UIFont.systemFont(ofSize: 22)

            let innerStackView = UIStackView()
            innerStackView.axis = .horizontal
            innerStackView.distribution = .fill
            innerStackView.alignment = .fill
            
            innerStackView.addArrangedSubview(keyLabel)
            innerStackView.addArrangedSubview(valueLabel)
                    
            stackView.addArrangedSubview(innerStackView)
        }
    }
    
    private func setupArray(){
        detailsArray.append(("Status:", self.character.status))
        detailsArray.append(("Specy:", self.character.species))
        detailsArray.append(("Gender:", self.character.gender))
        detailsArray.append(("Origin:", self.character.origin.name))
        detailsArray.append(("Location:", self.character.location.name))
        var episodeString = ""
        let episodeNumbers = character.episode.compactMap { $0.components(separatedBy: "/").last }
        for episode in episodeNumbers {
            episodeString += episode + " "
        }
        detailsArray.append(("Episodes:", episodeString))
        detailsArray.append(("Created at:", self.character.created))
    }
    
    // MARK: - API
    private func fetchCharacterImage() {
        let url = URL(string: self.character.image)
        self.characterImage.sd_setImage(with: url,completed: nil)
    }
    
    // MARK: -Selectors {
    @objc private func handleBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
