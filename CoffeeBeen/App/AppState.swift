//
//  AppState.swift
//  CoffeeBeen
//
//  Created by Trần Minh Quang on 25/4/25.
//

import Foundation
import Combine

class AppState: ObservableObject {
    enum Route {
        case splash, login, main
    }

    @Published var route: Route = .splash

    func finishSplash() {
        // Có thể check auth ở đây
        let isLoggedIn = false // thay bằng check Firebase/Auth
        self.route = isLoggedIn ? .main : .login
    }

    func loginSuccess() {
        self.route = .main
    }

    func logout() {
        self.route = .login
    }
}
