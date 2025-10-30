//
//  UIViewController+Toast.swift
//  LimSoEun_assignment
//

import UIKit
import SnapKit

extension UIViewController {
    
    func showToast(message: String, duration: TimeInterval = 2.0) {
        // 중복 방지
        view.subviews.filter { $0.tag == 9999 }.forEach { $0.removeFromSuperview() }
        
        // MARK: UI
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.font = .font(.pretendardMedium, ofSize: 14)
        toastLabel.textColor = .baeminWhite
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .baeminGray700
        backgroundView.layer.cornerRadius = 15
        backgroundView.alpha = 0
        backgroundView.tag = 9999
        
        backgroundView.addSubview(toastLabel)
        view.addSubview(backgroundView)
        
        //MARK: - layout
        toastLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        backgroundView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(120)
            $0.width.lessThanOrEqualToSuperview().multipliedBy(0.8)
        }
        
        // MARK: - 애니메이션
        UIView.animate(withDuration: 0.3, animations: {
            backgroundView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                backgroundView.alpha = 0.0
            }) { _ in
                backgroundView.removeFromSuperview()
            }
        }
    }
}
