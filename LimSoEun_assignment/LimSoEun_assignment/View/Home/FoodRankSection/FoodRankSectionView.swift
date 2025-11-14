
//
//  FoodRankSectionView.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/13/25.
//

import UIKit
import SnapKit

final class FoodRankSectionView: UIView {
    
    // MARK: - 더미데이터
    private let foods = [
        (
            store: "백억보쌈제육볶음",
            rating: "5.0",
            reviewCount: "1,973",
            menu: "[든든한 한끼] 보쌈 막국수",
            discount: "25%",
            price: "12,000원",
            originalPrice: "16,000원",
            minimumOrder: "최소주문금액 없음",
            imageName: "bossam"
        ),
        (
            store: "백억보쌈제육볶음",
            rating: "5.0",
            reviewCount: "1,973",
            menu: "(1인) 피자 + 사이드 Set",
            discount: "20%",
            price: "12,000원",
            originalPrice: "16,000원",
            minimumOrder: "최소주문금액 없음",
            imageName: "pizzaSet"
        ),
        (
            store: "백억보쌈제육볶음",
            rating: "5.0",
            reviewCount: "1,973",
            menu: "[든든한 한끼] 제육덮밥",
            discount: "15%",
            price: "10,000원",
            originalPrice: "12,000원",
            minimumOrder: "최소주문금액 없음",
            imageName: "jeyukbokkeum"
        ),
        (
            store: "백억보쌈제육볶음",
            rating: "5.0",
            reviewCount: "1,973",
            menu: "[든든한 한끼] 제육덮밥",
            discount: "15%",
            price: "10,000원",
            originalPrice: "12,000원",
            minimumOrder: "최소주문금액 없음",
            imageName: "jeyukbokkeum"
        )
    ]
    
    // MARK: - Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우리 동네 한그릇 인기 랭킹"
        label.font = .font(.pretendardSemiBold, ofSize: 16)
        label.textColor = .baeminBlack
        return label
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = .baeminGray300
        return button
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("전체보기 >", for: .normal)
        button.titleLabel?.font = .font(.pretendardMedium, ofSize: 14)
        button.setTitleColor(.baeminGray300, for: .normal)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(FoodRankCell.self)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .baeminWhite
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupLayout() {
        [titleLabel, infoButton, seeAllButton, collectionView].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        
        infoButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
            $0.size.equalTo(16)
        }
        
        seeAllButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(220)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionView
extension FoodRankSectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FoodRankCell = collectionView.dequeueReusableCell(for: indexPath)
        let food = foods[indexPath.item]
        cell.configure(
            store: food.store,
            rating: food.rating,
            reviewCount: food.reviewCount,
            menu: food.menu,
            discount: food.discount,
            price: food.price,
            originalPrice: food.originalPrice,
            minimumOrder: food.minimumOrder,
            imageName: food.imageName
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 220)
    }
}

#Preview {
    FoodRankSectionView()
}
