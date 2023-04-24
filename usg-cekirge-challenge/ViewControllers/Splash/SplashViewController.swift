//
//  SplashViewController.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 24.04.2023.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Subviews
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "portal.png")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 154/255, green: 195/255, blue: 90/255, alpha: 1)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 44, weight: .bold)
        label.text = "Welcome!"
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkFirstLaunch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let homeVC = HomeViewController()
            homeVC.modalPresentationStyle = .fullScreen
            self.present(homeVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helper Functions
    private func configureUI(){
        view.backgroundColor = .white
        [logo, titleLabel] .forEach(view.addSubview(_:))
        
        let screen = UIScreen.main.bounds
        
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingRight: 24, height: screen.width)
        
        titleLabel.anchor(top: logo.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 24,  paddingRight: 24)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func checkFirstLaunch() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore {
            self.titleLabel.text = "Hello!"
        } else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
}
