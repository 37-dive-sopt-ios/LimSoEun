
//
//  LoginViewController.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 10/23/25.
//

import Foundation
import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    private let navigationView = CustomNavigationView(title: "이메일 또는 아이디로 계속")
    
    private let emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일 아이디"
        textField.font = .font(.pretendardRegular , ofSize: 14)
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.baeminGray200.cgColor
        textField.setPlaceholder(color: .baeminGray700)
        textField.addLeftPadding()
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        textField.font = .font(.pretendardRegular , ofSize: 14)
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.baeminGray200.cgColor
        textField.setPlaceholder(color: .baeminGray700)
        textField.addLeftPadding()

       
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = UIColor.baeminGray200.cgColor
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = .font(.pretendardBold , ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.baeminGray200.cgColor
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var findAccountButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "계정찾기"
        config.image = UIImage(
            systemName: "chevron.right",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .medium)
        )
        config.imagePadding = 5
        config.baseForegroundColor = .baeminBlack
        config.contentInsets = .zero

        let button = UIButton(configuration: config)
        button.titleLabel?.font = .font(.pretendardRegular, ofSize: 14)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        setupNavigation()
        setLayout()
    }
    
    private func setLayout() {
        [emailField, passwordTextField, loginButton, findAccountButton].forEach {
            self.view.addSubview($0)
        }
        
        emailField.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(emailField)
            $0.height.equalTo(46)
           
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(emailField)
            $0.height.equalTo(46)
          
        }
        
        findAccountButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(emailField)
          
        }
    }
    
    private func setupNavigation() {
        view.addSubview(navigationView)
        navigationView.onBackButtonTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
    }

    private func pushToWelcomeVC() {
           let welcomeViewController = WelcomeViewController()
           welcomeViewController.name = emailField.text
           self.navigationController?.pushViewController(welcomeViewController, animated: true)
       }
      
    @objc private func backButtonTapped() {
            dismiss(animated: true)
        }
    
    @objc
    private func loginButtonDidTap() {
        pushToWelcomeVC()
    }
    
    
}

extension UITextField {
    func addLeftPadding(_ width: CGFloat = 10) {
        let pv = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        leftView = pv
        leftViewMode = .always
    }
    
    func addRightPadding(_ width: CGFloat = 10) {
        let pv = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        rightView = pv
        rightViewMode = .always
    }
    
    //textField 색상변경
    func setPlaceholder(color: UIColor) {
            guard let string = self.placeholder else {
                return
            }
            attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
        }
}

//MARK: - Preview
#Preview {
    LoginViewController()
}
