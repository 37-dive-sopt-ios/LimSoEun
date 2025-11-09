//
//  UITextField+Paddding.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/6/25.
//

import UIKit

extension UITextField {
    
    /// 왼쪽 패딩 추가
    func addLeftPadding(_ width: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    /// 오른쪽 패딩 추가
    func addRightPadding(_ width: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    /// 좌우 패딩을 한 번에 추가
    func addPadding(leftAmount: CGFloat = 10, rightAmount: CGFloat = 10) {
        addLeftPadding(leftAmount)
        addRightPadding(rightAmount)
    }
}
