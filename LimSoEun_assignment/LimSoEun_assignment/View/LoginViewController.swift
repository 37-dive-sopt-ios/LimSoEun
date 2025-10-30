
//
//  LoginViewController.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 10/23/25.
//

import Foundation
import UIKit
import SnapKit

final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - UI
    private let navigationView = CustomNavigationView(title: "이메일 또는 아이디로 계속")
    
    ///이메일 입력 필드
    private let emailField = FloatingLabelTextField(
        titleText: "이메일 아이디",
        activePlaceholder: "이메일 또는 아이디를 입력해주세요"
    )
    ///비밀번호 입력 필드
    private let passwordTextField = PasswordTextField(
        titleText: "비밀번호",
        activePlaceholder: "비밀번호를 입력해주세요"
    )
    ///로그인버튼
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
    ///계정 찾기 버튼
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
        
        emailField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
 
    //MARK: - layout
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
    //MARK: - navigation 설정
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
    //MARK: - 화면이동
    private func pushToWelcomeVC() {
           let welcomeViewController = WelcomeViewController()
            welcomeViewController.name = emailField.textField.text
           self.navigationController?.pushViewController(welcomeViewController, animated: true)
       }
    ///뒤로가기 액션
    @objc private func backButtonTapped() {
            dismiss(animated: true)
        }
    ///로그인버튼 클릭 시 액션
    @objc
    private func loginButtonDidTap() {
    
        ///이메일 정규식 안맞으면  토스트 버튼 활성화
        guard let email = emailField.textField.text, Validator.isValidEmail(email) else {
                showToast(message: "이메일 형식이 달라요")
                return
            }
        pushToWelcomeVC()
    }
    
    //MARK: - 로그인 버튼 활성화
    @objc private func textFieldDidChange() {
        let isEmailFilled = !(emailField.textField.text ?? "").isEmpty
        let isPasswordFilled = !(passwordTextField.textField.text ?? "").isEmpty
        
        if isEmailFilled && isPasswordFilled {
            loginButton.layer.backgroundColor = UIColor.baeminMint500.cgColor
            loginButton.layer.borderColor = UIColor.baeminMint500.cgColor
        } else {
            loginButton.layer.backgroundColor = UIColor.baeminGray200.cgColor
            loginButton.layer.borderColor = UIColor.baeminGray200.cgColor
        }
    }
}

//MARK: - UITextField Extension
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
