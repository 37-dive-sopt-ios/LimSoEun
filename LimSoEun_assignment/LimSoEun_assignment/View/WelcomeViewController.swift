//
//  WelcomeViewController.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 10/23/25.
//

import Foundation
import UIKit
import SnapKit

final class WelcomeViewController: UIViewController {
    
    var name: String?
    
    private let navigationView = CustomNavigationView(title: "대체 뼈찜 누가시켰어ㅋㅋ")
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bamin")
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "환영합니다"
        label.font = .font(.pretendardBold, ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let welcomePersonLabel: UILabel = {
        let label = UILabel()
        label.text = "???님 \n반가워요!"
        label.font = .font(.pretendardSemiBold, ofSize: 18)
        label.textAlignment = .center
      //  label.numberOfLines = 1
        return label
    }()
    
    private var backToLoginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.backgroundColor = UIColor.baeminMint500.cgColor
        button.setTitle("뒤로가기", for: .normal)
        button.layer.borderColor = UIColor.baeminWhite.cgColor
        button.titleLabel?.font = .font(.pretendardBold, ofSize: 18)
        button.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private func bindID() {
        guard let name = name else { return }
        self.welcomePersonLabel.text = "\(name)님 \n반가워요!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        setupNavigation()
        setLayout()
        bindID()
    }
    
    private func setLayout() {
        [logoImageView, welcomeLabel, welcomePersonLabel, backToLoginButton].forEach {
            self.view.addSubview($0)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(221)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        welcomePersonLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            
        }
        
        backToLoginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(16)
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
    
    @objc
    private func backToLoginButtonDidTap() {
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

#Preview {
    WelcomeViewController()
}
