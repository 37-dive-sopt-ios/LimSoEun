//
//  CategorySectionView.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/06/25.
//

import UIKit
import SnapKit

final class CategorySectionView: UIView {
    
    // MARK: - 캬테고리 데이터
    private let categories = [
        ("한그릇", "rice"),
        ("치킨", "chicken"),
        ("카페·디저트", "dessert"),
        ("피자", "pizza"),
        ("분식", "snack"),
        ("고기", "meat"),
        ("찜·탕", "soup"),
        ("야식", "night"),
        ("패스트푸드", "fastfood"),
        ("픽업", "pickup")
    ]
    
    // MARK: - CollectionView
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .baeminWhite
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 확장된 register 함수 사용
        collectionView.register(CategoryCell.self)
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(collectionView)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(168)
        }
    }
}

// MARK: - UICollectionView DataSource
extension CategorySectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(for: indexPath)
        let (title, imageName) = categories[indexPath.item]
        cell.configure(title: title, imageName: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.inset(by: collectionView.adjustedContentInset).width
        let width = (availableWidth - 16 * 2 - 10 * 4) / 5
        return CGSize(width: width, height: 84)
    }
}

#Preview {
    CategorySectionView()
}
