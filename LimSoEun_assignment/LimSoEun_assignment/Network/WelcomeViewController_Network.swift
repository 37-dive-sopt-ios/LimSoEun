//
//  Untitled.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/17/25.
//


import UIKit

import SnapKit
import Then

final class WelcomeViewController_Network: BaseViewController {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "환영합니다!"
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.textAlignment = .center
        $0.textColor = .black
    }
    
    private lazy var getUserButton = UIButton().then {
        $0.setTitle("내 정보 조회 (GET)", for: .normal)
        $0.backgroundColor = .baeminMint300
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .font(.pretendardRegular, ofSize: 14)
        $0.titleLabel?.numberOfLines = 2
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(getUserButtonTapped), for: .touchUpInside)
    }

    private lazy var updateUserButton = UIButton().then {
        $0.setTitle("이메일 수정(PATCH)", for: .normal)
        $0.backgroundColor = .baeminMint500
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .font(.pretendardRegular, ofSize: 14)
        $0.titleLabel?.numberOfLines = 2
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(updateUserButtonTapped), for: .touchUpInside)
    }

    private lazy var deleteUserButton = UIButton().then {
        $0.setTitle("회원탈퇴 (DELETE)", for: .normal)
        $0.backgroundColor = .systemRed
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .font(.pretendardRegular, ofSize: 14)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(deleteUserButtonTapped), for: .touchUpInside)
    }

    // MARK: - Properties
    
    private let userId: Int
    private let provider: NetworkProviding
    
    // MARK: - Init
    
    public init(userId: Int, provider: NetworkProviding = NetworkProvider()) {
        self.userId = userId
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
    }
    
    // MARK: - UI Setup
    
    private func setHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(getUserButton)
        view.addSubview(updateUserButton)
        view.addSubview(deleteUserButton)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        getUserButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        updateUserButton.snp.makeConstraints {
            $0.top.equalTo(getUserButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        deleteUserButton.snp.makeConstraints {
            $0.top.equalTo(updateUserButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
    }
    
    // MARK: - Actions
    
    /// GET /api/v1/users/{id}
    @objc private func getUserButtonTapped() {
        Task {
            await fetchUser()
        }
    }
    
    /// PATCH /api/v1/users/{id}
    @objc private func updateUserButtonTapped() {
        showUpdateNicknameAlert()
    }
    
    /// DELETE /api/v1/users/{id}
    @objc private func deleteUserButtonTapped() {
        showDeleteConfirmation()
    }
    
    // MARK: - Network Methods
    
    @MainActor
    private func fetchUser() async {
        loadingIndicator.startAnimating()
        do {
            let response = try await UserAPI.performGetUser(id: userId, provider: provider)
            showAlert(title: "조회 성공", message: "이름: \(response.name)\n이메일: \(response.email)\n나이: \(response.age)")
        } catch {
            showAlert(title: "조회 실패", message: error.localizedDescription)
        }
        loadingIndicator.stopAnimating()
    }
    
    @MainActor
    private func updateUserNickname(_ email: String) async {
        loadingIndicator.startAnimating()
        
        do {
            let response = try await UserAPI.performUpdateUser(
                id: userId,
                name: nil,
                email: email,
                age: nil,
                provider: provider
            )
            
            showAlert(title: "수정 완료", message: "새 이메일: \(response.email)")
            
        } catch {
            showAlert(title: "수정 실패", message: error.localizedDescription)
        }
        
        loadingIndicator.stopAnimating()
    }
    
    @MainActor
    private func deleteUser() async {
        loadingIndicator.startAnimating()
        do {
            _ = try await UserAPI.performDeleteUser(id: userId, provider: provider)
            
            showAlert(title: "탈퇴 완료", message: "안녕~") { [weak self] in
                self?.navigationController?.popToRootViewController(animated: true)
            }
        } catch {
            showAlert(title: "탈퇴 실패", message: error.localizedDescription)
        }
        loadingIndicator.stopAnimating()
    }
    
    // MARK: - Helpers
    
    private func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 8
        return button
    }
    
    private func showUpdateNicknameAlert() {
        let alert = UIAlertController(
            title: "이메일 수정",
            message: "변경할 이메일을 입력해주세요.",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = "새 이메일"
            textField.keyboardType = .emailAddress
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let confirmAction = UIAlertAction(title: "수정", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let newEmail = alert.textFields?.first?.text ?? ""
            
            if newEmail.isEmpty {
                self.showAlert(title: "오류", message: "이메일을 입력해주세요.")
                return
            }
            
            Task {
                await self.updateUserNickname(newEmail)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        present(alert, animated: true)
    }
    
    private func showDeleteConfirmation() {
        let alert = UIAlertController(
            title: "정말 탈퇴하시겠어요?",
            message: "회원 정보가 모두 삭제됩니다.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "탈퇴", style: .destructive, handler: { _ in
            Task { await self.deleteUser() }
        }))
        
        present(alert, animated: true)
    }
    
}

