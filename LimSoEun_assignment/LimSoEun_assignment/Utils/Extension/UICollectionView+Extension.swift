//
//  UICollectionView+Extension.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/6/25.
//

import UIKit

extension UICollectionView {
    
    /// 셀 등록
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(
            withReuseIdentifier: T.identifier,
            for: indexPath
        ) as? T else {
            fatalError(" \(T.identifier) dequeue 실패")
        }
        return cell
    }
}
