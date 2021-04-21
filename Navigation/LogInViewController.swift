//
//  LogInViewController.swift
//  Navigation
//
//  Created by Артем on 30.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: Properties
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    // MARK: - Login View Content
    // Logo Image
    private let logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "Logo")
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    // Login Field
    private lazy var loginTextFiel: UITextField = {
        let login = UITextField()
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        login.tintColor = UIColor(named: "ColorSet")
        login.autocapitalizationType = .none
        login.placeholder = "Email or phone"
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        login.leftViewMode = .always
    
        login.layer.cornerRadius = 10

        login.backgroundColor = .systemGray6
    
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    // Password Field
    private lazy var passwordTextFiel: UITextField = {
        let password = UITextField()
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        password.tintColor = UIColor(named: "ColorSet")
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        password.placeholder = "Password"
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        password.leftViewMode = .always
        
        password.layer.cornerRadius = 10

        password.backgroundColor = .systemGray6
        
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    private lazy var spacerForStackView: UIView = {
        let spacer = UIView()
        spacer.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        spacer.backgroundColor = .lightGray
        
        spacer.translatesAutoresizingMaskIntoConstraints = false
        return spacer
    }()
    
    private lazy var  loginAndPasswordStackView: UIStackView = {
        let loginPasswordStack = UIStackView()
        loginPasswordStack.axis = .vertical
        loginPasswordStack.spacing = 0
        loginPasswordStack.distribution = .fillProportionally
        
        loginPasswordStack.addArrangedSubview(loginTextFiel)
        loginPasswordStack.addArrangedSubview(spacerForStackView)
        loginPasswordStack.addArrangedSubview(passwordTextFiel)
        
        spacerForStackView.widthAnchor.constraint(equalTo: loginPasswordStack.widthAnchor, multiplier: 1).isActive = true

        loginPasswordStack.backgroundColor = .systemGray6
        
        loginPasswordStack.layer.borderColor = UIColor.lightGray.cgColor
        loginPasswordStack.layer.borderWidth = 0.5
        loginPasswordStack.layer.cornerRadius = 10
        
        loginPasswordStack.translatesAutoresizingMaskIntoConstraints = false
        return loginPasswordStack
    }()
    
    // Log In Button
    private lazy var logInButton: UIButton  = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.darkGray, for: .selected)
        button.setTitleColor(.darkGray, for: .highlighted)
        button.addTarget(self, action: #selector(logInButtonSuccessed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Keyboard notifications
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func logInButtonSuccessed() {
        navigationController?.popViewController(animated: true)
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Keyboard Actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentSize.height = view.bounds.height + keyboardSize.height * 0.25
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentSize.height = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubviews(
            logoImageView,
            loginAndPasswordStackView,
            logInButton
        )
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            loginAndPasswordStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            loginAndPasswordStackView.heightAnchor.constraint(equalToConstant: 100),
            loginAndPasswordStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            loginAndPasswordStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            logInButton.topAnchor.constraint(equalTo: loginAndPasswordStackView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            logInButton.bottomAnchor.constraint(equalTo: loginAndPasswordStackView.bottomAnchor, constant: 66)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
