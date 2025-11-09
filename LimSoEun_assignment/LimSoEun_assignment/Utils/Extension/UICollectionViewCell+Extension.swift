//
//  UICollectionViewCell+Extension.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/06/25.
//

import UIKit

extension UICollectionViewCell {
    /// 셀 reuse identifier를 자동 생성
    static var identifier: String {
        return String(describing: self)
    }
}
