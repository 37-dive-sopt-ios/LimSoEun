//
//  Validator.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 10/27/25.
//

import Foundation

enum Validator {
    
    //이메일 유효 검증
    static func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
    }
}
