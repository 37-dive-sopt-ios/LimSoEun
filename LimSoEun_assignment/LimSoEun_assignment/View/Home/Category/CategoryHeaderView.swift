//
//  CategoryHeaderView.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/7/25.
//

import UIKit
import SnapKit

final class CategoryHeaderView: UIView {
    
    private let categories = ["음식배달", "픽업", "장보기·쇼핑", "선물하기", "혜택모아보기"]
    private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0
    var onCategorySelected: ((Int) -> Void)?
    
    // MARK: - UI Components
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = true
        scroll.alwaysBounceHorizontal = true
        scroll.alwaysBounceVertical = false
        scroll.isDirectionalLockEnabled = true
        return scroll
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        return stack
    }()
    
    private let baselineView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminGray200
        return view
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminBlack
        return view
    }()
    
    private var underlineCenterX: Constraint?
    private var underlineWidth: Constraint?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .baeminWhite
        setupView()
        setupLayout()
        updateUnderline(animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(baselineView)
        addSubview(underlineView)
        
        for (index, title) in categories.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(index == 0 ? .baeminBlack : .baeminGray300, for: .normal)
            button.titleLabel?.font = index == 0
                ? .font(.pretendardBold, ofSize: 18)
                : .font(.pretendardMedium, ofSize: 18)
            button.tag = index
            button.addTarget(self, action: #selector(categoryTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(2)
            $0.height.equalToSuperview()
        }
        
        baselineView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        underlineView.snp.makeConstraints {
            $0.bottom.equalTo(baselineView.snp.bottom)
            $0.height.equalTo(3)
                   underlineCenterX = $0.centerX.equalTo(buttons[selectedIndex].snp.centerX).constraint
                   underlineWidth = $0.width.equalTo(buttons[selectedIndex].titleLabel?.intrinsicContentSize.width ?? 0).constraint
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUnderline(animated: false)
        bringSubviewToFront(underlineView)
    }
    
    // MARK: - Actions
    @objc private func categoryTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        updateSelectionState()
        updateUnderline(animated: true)
        onCategorySelected?(selectedIndex)
        scrollToCenter(button: sender)
    }
    
    // MARK: - Update
    private func updateSelectionState() {
        for (index, button) in buttons.enumerated() {
            let isSelected = index == selectedIndex
            button.setTitleColor(isSelected ? .baeminBlack : .baeminGray300, for: .normal)
            button.titleLabel?.font = isSelected
                ? .font(.pretendardBold, ofSize: 18)
                : .font(.pretendardMedium, ofSize: 18)
        }
    }
    
    private func updateUnderline(animated: Bool) {
        guard buttons.indices.contains(selectedIndex) else { return }
        let selectedButton = buttons[selectedIndex]
        let titleWidth = selectedButton.titleLabel?.intrinsicContentSize.width ?? 0
        
        underlineCenterX?.deactivate()
        underlineWidth?.deactivate()
        
        underlineView.snp.remakeConstraints {
            $0.bottom.equalTo(baselineView.snp.bottom)
            $0.height.equalTo(2)
            $0.centerX.equalTo(selectedButton.snp.centerX)
            $0.width.equalTo(titleWidth)
        }
        
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
        }
    }
    
    // MARK: - Scroll Centering
    private func scrollToCenter(button: UIButton) {
        guard let scrollViewWidth = scrollView.superview?.frame.width else { return }
        let buttonCenterX = button.center.x
        let offsetX = max(0, buttonCenterX - scrollViewWidth / 2)
        let maxOffsetX = scrollView.contentSize.width - scrollViewWidth
        scrollView.setContentOffset(CGPoint(x: min(offsetX, maxOffsetX), y: 0), animated: true)
    }
}

#Preview {
    CategoryHeaderView()
}
