//
//  AppState.swift
//  CoffeeBeen
//
//  Created by Trần Minh Quang on 25/4/25.
//

import Foundation
import Combine
import FirebaseAuth

class AppState: ObservableObject {
    enum Route {
        case splash, login, main
    }

    @Published var route: Route = .splash
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscribers()
    }

    private func setupSubscribers() {
        AuthService.shared.$userSession
            .sink { [weak self] userSession in
                self?.route = userSession == nil ? .login : .main
            }
            .store(in: &cancellables)
    }

    func finishSplash() {
        if AuthService.shared.userSession != nil {
            self.route = .main
        } else {
            self.route = .login
        }
    }

    func loginSuccess() {
        self.route = .main
    }

    func logout() {
        AuthService.shared.signOut()
    }
}
