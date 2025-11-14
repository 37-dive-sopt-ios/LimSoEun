//
//  BannerCell.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/10/25.
//

import UIKit
import SnapKit

final class BannerCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .baeminBackgroundWhite
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}
