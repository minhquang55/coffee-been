//
//  AppRouter.swift
//  CoffeeBeen
//
//  Created by Trần Minh Quang on 25/4/25.
//

import SwiftUI

struct AppRouter: View {
    @StateObject var appState = AppState()

    var body: some View {
        switch appState.route {
        case .splash:
            SplashView {
                appState.finishSplash()
            }
        case .login:
            LoginView(onLoginSuccess: {
                appState.loginSuccess()
            })
        case .home:
            HomeView()
        }
    }
//        .environmentObject(appState) // chia sẻ cho toàn bộ app nếu cần
}

#Preview {
    AppRouter()
}
