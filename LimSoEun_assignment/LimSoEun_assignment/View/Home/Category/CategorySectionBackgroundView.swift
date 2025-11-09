//
//  CategorySectionBackgroundView.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/7/25.
//

import UIKit
import SnapKit

final class CategorySectionBackgroundView: UIView {
    
    // MARK: - Components
    private let categoryHeaderView = CategoryHeaderView()
    private let categorySectionView = CategorySectionView()
    private let separatorLine = DividerView()
    
    private let moreButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()

        let fullText = "음식배달에서 더보기"
        let attributedText = NSMutableAttributedString(string: fullText)

        // "음식배달" 부분만 bold
        let boldFont = UIFont.font(.pretendardExtraBold, ofSize: 14)
        let regularFont = UIFont.font(.pretendardRegular, ofSize: 14)
        let fullRange = NSRange(location: 0, length: fullText.count)
        let boldRange = (fullText as NSString).range(of: "음식배달")

        attributedText.addAttribute(.font, value: regularFont, range: fullRange)
        attributedText.addAttribute(.font, value: boldFont, range: boldRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.baeminBlack, range: fullRange)

        if let image = UIImage(named: "chevron_right") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 12, height: 12)).image { _ in
                image.draw(in: CGRect(origin: .zero, size: CGSize(width: 12, height: 12)))
            }
            config.image = resizedImage
        }

        config.attributedTitle = AttributedString(attributedText)
        config.imagePlacement = .trailing
        config.imagePadding = 6
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)

        button.configuration = config
        return button
    }()

    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        bindActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .baeminWhite
        addSubview(categoryHeaderView)
        addSubview(categorySectionView)
        addSubview(separatorLine)
        addSubview(moreButton)
    }
    
    private func setupLayout() {
        categoryHeaderView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        categorySectionView.snp.makeConstraints {
            $0.top.equalTo(categoryHeaderView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }
        
        separatorLine.snp.makeConstraints {
            $0.top.equalTo(categorySectionView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(separatorLine.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Bind
    private func bindActions() {
        categoryHeaderView.onCategorySelected = { [weak self] index in
            guard let self = self else { return }
            let isVisible = (index == 0)
            self.categorySectionView.isHidden = !isVisible
            self.separatorLine.isHidden = !isVisible
            self.moreButton.isHidden = !isVisible
        }
    }
}

#Preview {
    CategorySectionBackgroundView()
}
