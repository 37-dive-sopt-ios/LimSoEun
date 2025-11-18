//
//  MarketCell.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/9/25.
//

import UIKit
import SnapKit

final class MarketCell: UICollectionViewCell {
    //MARK: - UIComponent
    private let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminBackgroundWhite
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let imageView: UIImageView = {
        let image  = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        return image
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 12)
        label.textColor = .baeminBlack
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [iconView,titleLabel].forEach {
            contentView.addSubview($0)
        }
        iconView.addSubview(imageView)
        
        iconView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(54)
          
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(54)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
    }
    
    //MARK: - configure
    func configure(title: String, imageName: String) {
        titleLabel.text = title
        imageView.image = UIImage(named: imageName)
    }
}
