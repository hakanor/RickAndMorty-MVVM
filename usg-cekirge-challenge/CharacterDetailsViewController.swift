//
//  CharacterDetailsViewController.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 24.04.2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
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
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
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
        view.backgroundColor = .yellow
        [characterImage, scrollView] .forEach(view.addSubview(_:))
        
        characterImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
        
        scrollView.anchor(top: characterImage.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        scrollView.addSubview(stackView)
    }
    
    private func configureStackView(){
        let countOfDictionary = 10
        for i in 0...countOfDictionary {
            let cell = DetailsCell()
            cell.ConfigureDetailsCell(key: "\(i)", value: "value")
            stackView.addArrangedSubview(cell)
        }
    }
    
    // MARK: - API
    private func fetchCharacterImage() {
        
    }
    
    // MARK: -Selectors {
    @objc private func handleBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
