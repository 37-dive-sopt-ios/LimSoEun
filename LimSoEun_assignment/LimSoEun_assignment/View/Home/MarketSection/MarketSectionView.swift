//
//  MarketSectionView.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/9/25.
//

import UIKit
import SnapKit

final class MarketSectionView: UIView {
    
    //MARK: 이미지 데이터
    private let markets = [
        ("B마트", "bMartLogo"),
        ("CU", "cu"),
        ("이마트슈퍼", "emartMall"),
        ("홈플러스", "homeplus"),
        ("GS25", "gs25"),
        ("이마트","emart")
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 8
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.register(MarketCell.self)
        return cv
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .baeminWhite
        addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MarketSectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            markets.count
        }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MarketCell = collectionView.dequeueReusableCell(for: indexPath)
        let (title, imageName) = markets[indexPath.item]
        cell.configure(title: title, imageName: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60, height: 80)
    }
    
}

#Preview {
    MarketSectionView()
}
