//
//  CustomNavigationView.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 10/24/25.
//

import UIKit
import SnapKit

final class CustomNavigationView: UIView {
    private let backButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    
    var onBackButtonTap: (() -> Void)?
    
    init(title: String) {
        super.init(frame: .zero)
        setupUI(title: title)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setupUI(title: String) {
        backgroundColor = .white
        
        let arrowImage = UIImage(named: "arrowLeft")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(arrowImage, for: .normal)
        backButton.tintColor = .baeminBlack
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        titleLabel.text = title
        titleLabel.font = .font(.pretendardExtraBold, ofSize: 18)
        titleLabel.textColor = .baeminBlack
        
        addSubview(backButton)
        addSubview(titleLabel)
    }
        
    private func setupLayout() {
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Actions
      @objc private func backButtonTapped() {
          onBackButtonTap?()
      }
    
}

#Preview {
    CustomNavigationView(title: "네비게이션바")
}
