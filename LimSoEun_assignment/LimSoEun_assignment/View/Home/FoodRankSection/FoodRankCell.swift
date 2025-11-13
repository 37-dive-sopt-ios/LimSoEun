//
//  FoodRankCell.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/13/25.
//

import UIKit
import SnapKit

final class FoodRankCell: UICollectionViewCell {
    
    // MARK: - UI
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .baeminWhite
        return iv
    }()
    
    private let storeLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardRegular, ofSize: 12)
        label.textColor = .baeminGray600
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let starImageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 11, weight: .medium)
        let iv = UIImageView(image: UIImage(systemName: "star.fill", withConfiguration: config))
        iv.tintColor = .systemYellow
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 11)
        label.textColor = .baeminGray600
        return label
    }()
    
    private let reviewCountLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 12)
        label.textColor = .baeminGray300
        return label
    }()
    
    private let menuLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardRegular, ofSize: 13)
        label.textColor = .baeminBlack
        label.numberOfLines = 1
        return label
    }()
    
    private let discountLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardBold, ofSize: 14)
        label.textColor = .systemRed
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardBold, ofSize: 14)
        label.textColor = .baeminBlack
        return label
    }()
    
    private let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardRegular, ofSize: 12)
        label.textColor = .baeminGray600
        label.attributedText = NSAttributedString(
            string: "16,000원",
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        return label
    }()
    
    private let minimumOrderLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardBold, ofSize: 13)
        label.textColor = .baeminPurple
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(storeLabel)
        
        let ratingStack = UIStackView(arrangedSubviews: [starImageView, ratingLabel, reviewCountLabel])
        ratingStack.axis = .horizontal
        ratingStack.spacing = 1
        ratingStack.alignment = .center
        
        [ratingStack, menuLabel, discountLabel, priceLabel, originalPriceLabel, minimumOrderLabel].forEach {
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        storeLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
        }
        
        ratingStack.snp.makeConstraints {
            $0.centerY.equalTo(storeLabel)
            $0.leading.equalTo(storeLabel.snp.trailing).offset(4)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        menuLabel.snp.makeConstraints {
            $0.top.equalTo(ratingStack.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        discountLabel.snp.makeConstraints {
            $0.top.equalTo(menuLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(discountLabel)
            $0.leading.equalTo(discountLabel.snp.trailing).offset(4)
        }
        
        originalPriceLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview()
        }
        
        minimumOrderLabel.snp.makeConstraints {
            $0.top.equalTo(originalPriceLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    func configure(
        store: String,
        rating: String,
        reviewCount: String,
        menu: String,
        discount: String,
        price: String,
        originalPrice: String,
        minimumOrder: String,
        imageName: String
    ) {
        storeLabel.text = store
        ratingLabel.text = rating
        reviewCountLabel.text = "(\(reviewCount))"
        menuLabel.text = menu
        discountLabel.text = discount
        priceLabel.text = price
        originalPriceLabel.text = originalPrice
        minimumOrderLabel.text = minimumOrder
        imageView.image = UIImage(named: imageName)
    }
}


