//
//  BaseResponse.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/17/25.
//

import Foundation

/// 서버 파트장이 준 API 의 공통 응답 형식
public struct BaseResponse<T: Decodable>: Decodable {
    public let success: Bool
    public let code: String?
    public let message: String?
    public let data: T?
}

/// 응답 데이터가 필요 없는 경우 - Empty 타입
public struct EmptyResponse: Decodable {
    public init() {}
}
