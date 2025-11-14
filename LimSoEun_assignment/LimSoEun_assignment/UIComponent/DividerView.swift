//
//  DividerView.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/8/25.
//

import UIKit
import SnapKit

final class DividerView: UIView {
    
    // MARK: - Init
    init(color: UIColor = .baeminBackgroundWhite, height: CGFloat = 1) {
        super.init(frame: .zero)
        backgroundColor = color
        
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
