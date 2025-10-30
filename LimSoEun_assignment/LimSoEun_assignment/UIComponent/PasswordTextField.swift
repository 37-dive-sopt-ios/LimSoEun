//
//  PasswordTextField.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 10/27/25.
//

import UIKit
import SnapKit

final class PasswordTextField: FloatingLabelTextField {

    // MARK: - UI
    private let toggleSecureButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "eye-slash"), for: .normal)
        button.tintColor = .baeminGray300
        button.imageView?.contentMode = .scaleAspectFit
        
        //TODO: - 트러블슈팅적기!
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        
        return button
    }()

    private let clearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "x-circle"), for: .normal)
        button.tintColor = .baeminGray300
        button.imageView?.contentMode = .scaleAspectFit
        
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        
        return button
    }()
    
    private let buttonContainer = UIView()
    private let buttonStack = UIStackView()

    // MARK: - Init
    override init(titleText: String, activePlaceholder: String) {
        super.init(titleText: titleText, activePlaceholder: activePlaceholder)
        setupPasswordButtons()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupPasswordButtons() {
        textField.isSecureTextEntry = true

        toggleSecureButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        
        // 스택뷰 설정
        buttonStack.axis = .horizontal
        buttonStack.spacing = 4
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.addArrangedSubview(toggleSecureButton)
        buttonStack.addArrangedSubview(clearButton)
        
        // 텍스트필드 오른쪽 뷰에 컨테이너 연결
        buttonContainer.addSubview(buttonStack)
        textField.rightView = buttonContainer
        textField.rightViewMode = .whileEditing
        
        self.textField.placeholder = self.titleText
        self.textField.setPlaceholder(color: .baeminGray200)
      
    }

    // MARK: - Layout
    private func setLayout() {
        toggleSecureButton.snp.makeConstraints { $0.size.equalTo(20) }
        clearButton.snp.makeConstraints { $0.size.equalTo(20) }
        buttonStack.spacing = 4

        buttonStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
        //TODO: - 버튼 사이즈 조절 및 레이아웃 수정 ! 

        buttonContainer.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(24)
        }
    }

    // MARK: - Actions
    @objc private func togglePasswordVisibility() {
        textField.isSecureTextEntry.toggle()
        let imageName = textField.isSecureTextEntry ? "eye-slash" : "eye"
        toggleSecureButton.setImage(UIImage(named: imageName), for: .normal)
    }

    @objc private func clearTextField() {
        textField.text = ""
    }
}

#Preview {
    PasswordTextField(titleText: "비밀번호", activePlaceholder: "비밀번호를 입력해주세요!")
}
