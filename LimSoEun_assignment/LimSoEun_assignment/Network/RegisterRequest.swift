//
//  RegisterRequest.swift
//  sopt-37th-01Seminar
//
//  Created by 임소은 on 11/8/25.
//

/// 유저 등록 API
struct RegisterRequest: Encodable {
    let username: String
        let password: String
        let name: String
        let email: String
        let age: Int
}
