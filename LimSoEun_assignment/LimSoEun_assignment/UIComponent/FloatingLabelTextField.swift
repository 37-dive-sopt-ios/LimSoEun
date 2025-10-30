//
//  FloatingLabelTextField.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 10/27/25.
//

import UIKit
import SnapKit

class FloatingLabelTextField: UIView {
    
    //MARK: - UI
    private let titleLabel = UILabel()
    let textField = UITextField()
    
    //MARK: - Properties
    let titleText: String
    private let activePlaceholder: String
    private var titleLabelTopConstrant: Constraint?
    
    //MARK: - init
    init(titleText: String, activePlaceholder: String) {
        self.titleText = titleText
        self.activePlaceholder = activePlaceholder
        super.init(frame: .zero)
        
        setupUI()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setupUI() {
        titleLabel.text = titleText
        titleLabel.font = .font(.pretendardRegular, ofSize: 12)
        titleLabel.textColor = .baeminGray200
        titleLabel.alpha = 0
        titleLabel.backgroundColor = .white
        
        textField.placeholder = titleText
        textField.font = .font(.pretendardRegular, ofSize: 14)
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.baeminGray200.cgColor
        textField.addLeftPadding()
        
        textField.addTarget(self, action: #selector(editingBegan), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingEnded), for: .editingDidEnd)
        

        addSubview(textField)
        addSubview(titleLabel)
    }
    
    private func setupLayout() {
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(46)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(textField.snp.leading).offset(16)
            $0.bottom.equalTo(textField.snp.top).offset(12)
        }
    }
    
    //MARK: - 텍스트필드 변하는 부분
    @objc private func editingBegan() {
        UIView.animate(withDuration: 0.2) {
            //border 강조
            self.textField.layer.borderWidth = 2
            self.textField.layer.borderColor = UIColor.baeminBlack.cgColor
            
            //floating label 활성화
            self.titleLabel.alpha = 1
            self.titleLabel.font = .font(.pretendardRegular, ofSize: 11)
            self.titleLabel.textColor = .baeminBlack
            
            self.titleLabelTopConstrant?.update(offset: -12)
            self.layoutIfNeeded()
            
            //placeholder변경
            self.textField.placeholder = self.activePlaceholder

        }
    }
    
    @objc private func editingEnded() {
        UIView.animate(withDuration: 0.2) {
            
            //원래대로 복귀
            self.textField.layer.borderWidth = 1
            self.textField.layer.borderColor = UIColor.baeminGray200.cgColor
            
            //입력이 없으면 라벨 숨기고 placeholder다시 돌려놓기
            if (self.textField.text ?? "").isEmpty {
                self.titleLabelTopConstrant?.update(offset: 16)
                self.titleLabel.alpha = 0
                self.textField.placeholder = self.titleText
            } else {
                //입력 중에는 텍스트 홀더 숨기기
                self.textField.placeholder = ""
            }
            self.layoutIfNeeded()
        }
    }
}

#Preview {
    FloatingLabelTextField(titleText: "이메일", activePlaceholder: "이메일 텍스트 홀더")
}
