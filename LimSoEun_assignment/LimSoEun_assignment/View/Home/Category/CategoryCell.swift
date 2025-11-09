//
//  CategoryCell.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/06/25.
//

import UIKit
import SnapKit

final class CategoryCell: UICollectionViewCell {

    
    private let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminBackgroundWhite
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardRegular, ofSize: 13)
        label.textColor = .baeminBlack
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(iconView)
        iconView.addSubview(imageView)
        addSubview(titleLabel)
        
        iconView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(58)
        }
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
    }
    
    func configure(title: String, imageName: String) {
        titleLabel.text = title
        imageView.image = UIImage(named: imageName)
    }
}

