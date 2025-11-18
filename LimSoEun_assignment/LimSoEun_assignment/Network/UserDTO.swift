//
//  UserDTO.swift
//  Seminar04
//
//  Created by 이명진 on 10/30/25.
//
//4주차
import Foundation

/// 사용자 정보 응답 모델
struct UserResponse: Decodable {
    let id: Int
    let username: String
    let name: String
    let email: String
    let age: Int
    let status: String
}

/// 로그인 요청 모델
struct LoginRequest: Encodable {
    let username: String
    let password: String
}

/// 로그인 응답 모델
struct LoginResponse: Decodable {
    let userId: Int
    let message: String
}

/// 개인정보 수정 요청 모델
struct UpdateUserRequest: Encodable {
    let name: String?
    let email: String?
    let age: Int?
}
