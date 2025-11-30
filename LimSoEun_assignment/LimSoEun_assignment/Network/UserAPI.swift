//
//  UserAPI.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/17/25.
//

import Foundation

/// User 관련 API 엔드포인트
/// Moya의 TargetType 과 비슷하게 구현함
enum UserAPI {
    case register(RegisterRequest)           // POST /api/v1/users - 회원가입
    case login(LoginRequest)                 // POST /api/v1/auth/login - 로그인
    case getUser(id: Int)                    // GET /api/v1/users/{id} - 개인정보 조회
    case updateUser(id: Int, UpdateUserRequest) // PATCH /api/v1/users/{id} - 개인정보 수정
    case deleteUser(id: Int)                 // DELETE /api/v1/users/{id} - 회원탈퇴
}

// MARK: -

extension UserAPI: TargetType {

    /// 기본 URL
    var baseURL: String {
        // SOPT 세미나 서버 URL
        return Environment.baseURL
    }

    /// API 경로
    var path: String {
        switch self {
        case .register:
            return "/api/v1/users"
        case .login:
            return "/api/v1/auth/login"
        case .getUser(let id):
            return "/api/v1/users/\(id)"
        case .updateUser(let id, _):
            return "/api/v1/users/\(id)"
        case .deleteUser(let id):
            return "/api/v1/users/\(id)"
        }
    }

    /// The HTTP method used in the request.
    var method: Method {
        switch self {
        case .register:
            return .post
        case .login:
            return .post
        case .getUser:
            return .get
        case .updateUser:
            return .patch
        case .deleteUser:
            return .delete
        }
    }

    /// The type of HTTP task to be performed.
    public var task: HTTPTask {
        switch self {
        case .register(let request):
            return .requestJSONEncodable(request)
        case .login(let request):
            return .requestJSONEncodable(request)
        case .getUser:
            return .requestPlain
        case .updateUser(_, let request):
            return .requestJSONEncodable(request)
        case .deleteUser:
            return .requestPlain
        }
    }

    /// 헤더 (Moya와 동일 - 필요시 오버라이드)
    public var headers: [String: String]? {
        return nil
    }
}

// MARK: - Convenience Methods

extension UserAPI {
    /// 회원가입 API 요청 헬퍼
    static func performRegister(
        username: String,
        password: String,
        name: String,
        email: String,
        age: Int,
        provider: NetworkProviding? = nil
    ) async throws -> UserResponse {
        
        let provider = provider ?? NetworkProvider()
        
        let request = RegisterRequest(
            username: username,
            password: password,
            name: name,
            email: email,
            age: age
        )
        
        let response: BaseResponse<UserResponse> =
            try await provider.request(UserAPI.register(request))
        
        guard let data = response.data else {
            throw NetworkError.noData
        }
        return data
    }

    /// 로그인 API 요청 헬퍼
    static func performLogin(
        username: String,
        password: String,
        provider: NetworkProviding? = nil
    ) async throws -> LoginResponse {
        
        let provider = provider ?? NetworkProvider()
        
        let request = LoginRequest(username: username, password: password)
        
        let response: BaseResponse<LoginResponse> =
            try await provider.request(UserAPI.login(request))
        
        guard let data = response.data else {
            throw NetworkError.noData
        }
        return data
    }

    /// 개인정보 조회 API 요청 헬퍼
    static func performGetUser(
        id: Int,
        provider: NetworkProviding? = nil
    ) async throws -> UserResponse {
        
        let provider = provider ?? NetworkProvider()
        
        let response: BaseResponse<UserResponse> =
            try await provider.request(UserAPI.getUser(id: id))
        
        guard let data = response.data else {
            throw NetworkError.noData
        }
        return data
    }

    /// 개인정보 수정 API 요청 헬퍼
    static func performUpdateUser(
        id: Int,
        name: String? = nil,
        email: String? = nil,
        age: Int? = nil,
        provider: NetworkProviding? = nil
    ) async throws -> UserResponse {
        
        let provider = provider ?? NetworkProvider()
        
        let request = UpdateUserRequest(name: name, email: email, age: age)
        
        let response: BaseResponse<UserResponse> =
            try await provider.request(UserAPI.updateUser(id: id, request))
        
        guard let data = response.data else {
            throw NetworkError.noData
        }
        return data
    }

    /// 회원탈퇴 API 요청 헬퍼
    static func performDeleteUser(
        id: Int,
        provider: NetworkProviding? = nil
    ) async throws -> BaseResponse<EmptyResponse> {
        
        let provider = provider ?? NetworkProvider()
        
        return try await provider.request(UserAPI.deleteUser(id: id))
    }
}
