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
    var viewModel: CharacterDetailsViewModelInterface
    
    //MARK: -Subviews
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "arrow.left")
        button.tintColor = .black
        button.backgroundColor = .clear
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        stackView.spacing = 5
        // Satırların dikey margin’leri: 5 (dp/pt)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initialization
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
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
        viewModel.fetchCharacterImage()
    }
    
    // MARK: - Helper Functions
    private func configureUI(){
        self.title = self.viewModel.character.name
        view.backgroundColor = .white
        [scrollView] .forEach(view.addSubview(_:))
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, width: UIScreen.main.bounds.width)
        
        scrollView.addSubview(containerView)
        scrollView.addSubview(stackView)
        
        // - Resmin yatay margin’leri: 50 (dp/pt)
        // - Resmin dikey margin’leri: 20 dp/pt.
        containerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor,  right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 50, paddingBottom: 20, paddingRight: 50, height: 315)
        
        containerView.addSubview(characterImage)
        
        characterImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        characterImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        // Resmin ebatları: 275x275 (dp*/pt**)
        characterImage.heightAnchor.constraint(equalToConstant: 275).isActive = true
        characterImage.widthAnchor.constraint(equalToConstant: 275).isActive = true
        
        // Resim ile Status arası 20 dp/pt olacaktır
        // Satırların yatay margin’leri: 20 (dp/pt)
        // Metinlerin alt margin’i (Created at’in alt margin’i) : 20 (dp/pt)
        stackView.anchor(top: containerView.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: UIScreen.main.bounds.width - 40 )
    }
    
    private func configureStackView(){
        for detail in self.viewModel.detailsArray {
            
            let keyLabel = UILabel()
            keyLabel.text = detail.key
            keyLabel.numberOfLines = 2
            keyLabel.textAlignment = .left
            keyLabel.font = UIFont(name: "Avenir-Heavy", size: 22)
            
            let valueLabel = UILabel()
            valueLabel.text = detail.value
            valueLabel.numberOfLines = 2
            valueLabel.textAlignment = .left
            valueLabel.font = UIFont(name: "Avenir-Medium", size: 22)

            let innerStackView = UIStackView()
            innerStackView.axis = .horizontal
            innerStackView.distribution = .fill
            innerStackView.alignment = .fill
            
            innerStackView.addArrangedSubview(keyLabel)
            innerStackView.addArrangedSubview(valueLabel)
            
            stackView.addArrangedSubview(innerStackView)
        }
    }
    
    // MARK: -Selectors {
    @objc private func handleBackButton(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension CharacterDetailsViewController: CharacterDetailsViewModelDelegate {
    func didFetchImageFailed(error: Error) {
        print(error)
        // handle error here - show alert
    }
    
    func didFetchCharacterImage(data: Data) {
        self.characterImage.image = UIImage(data: data)
    }
}
