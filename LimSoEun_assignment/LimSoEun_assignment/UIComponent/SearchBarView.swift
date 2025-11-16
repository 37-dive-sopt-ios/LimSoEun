//
//  SearchBarView.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/6/25.
//

import UIKit
import SnapKit

final class SearchBarView: UIView {

    // MARK: - UI
    
    private let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "찾아라 맛있는 음식과 맛집"
        textField.font = .font(.pretendardRegular, ofSize: 14)
        textField.textColor = .baeminGray300
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.baeminBlack.cgColor
        textField.clearButtonMode = .whileEditing
        return textField
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

    // MARK: - Setup
    private func setupView() {
        addSubview(textField)
        textField.addSubview(searchIcon)
        
        textField.addPadding(leftAmount: 12, rightAmount: 36)
    }

    // MARK: - Layout
    private func setLayout() {
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(40)
        }

        searchIcon.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(18)
        }
    }
}
#Preview {
    SearchBarView()
}
