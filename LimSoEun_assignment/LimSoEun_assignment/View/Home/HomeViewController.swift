//
//  HomeViewController.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/6/25.
//

import UIKit
import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우리집"
        label.font = .font(.pretendardSemiBold, ofSize: 16)
        label.textColor = .baeminBlack
        return label
    }()
    
    private let downIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "down")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var locationStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, downIcon])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()
    
    private let discountIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "baemin_discount")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let alarmButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "alarm"), for: .normal)
        return button
    }()
    
    private let cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cart"), for: .normal)
        return button
    }()
    
    private let searchBar = SearchBarView()
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let bmartImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bmart")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "전상품 쿠폰팩 + 60%특가"
        label.font = .font(.pretendardRegular, ofSize: 14)
        label.textColor = .baeminBlack
        return label
    }()
    
    private let categorySectionBackground = CategorySectionBackgroundView()
    
    private let marketSectionView = MarketSectionView()
    
    private let adBannerView = AdBannerView()
    
    private let foodRankSectionView = FoodRankSectionView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .baeminBackgroundWhite
        setupLayout()
    }
    
    // MARK: - Layout
    private func setupLayout() {
        [locationStackView, discountIcon, alarmButton, cartButton, searchBar, scrollView].forEach {
            view.addSubview($0)
        }
        
        //ZStack .!!!!
       // view.bringSubviewToFront(<#T##UIView#>)
        
        locationStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(9)
            $0.leading.equalToSuperview().inset(16)
        }
        
        discountIcon.snp.makeConstraints {
            $0.centerY.equalTo(locationStackView)
            $0.trailing.equalTo(alarmButton.snp.leading).offset(-12)
            $0.size.equalTo(24)
        }
        
        alarmButton.snp.makeConstraints {
            $0.centerY.equalTo(locationStackView)
            $0.trailing.equalTo(cartButton.snp.leading).offset(-12)
            $0.size.equalTo(24)
        }
        
        cartButton.snp.makeConstraints {
            $0.centerY.equalTo(locationStackView)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        
        // SearchBar 고정
        searchBar.snp.makeConstraints {
            $0.top.equalTo(locationStackView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        //  ScrollView + ContentView
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        
        // ScrollView 안쪽 콘텐츠
        [bmartImage, descriptionLabel, categorySectionBackground, marketSectionView, adBannerView, foodRankSectionView].forEach {
            contentView.addSubview($0)
        }
        
        bmartImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(bmartImage.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        categorySectionBackground.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        marketSectionView.snp.makeConstraints {
            $0.top.equalTo(categorySectionBackground.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        adBannerView.snp.makeConstraints {
            $0.top.equalTo(marketSectionView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(140)
            
        }
        
        foodRankSectionView.snp.makeConstraints {
            $0.top.equalTo(adBannerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(280)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}


#Preview {
    HomeViewController()
}
