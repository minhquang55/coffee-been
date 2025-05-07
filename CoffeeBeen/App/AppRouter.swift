import SwiftUI

struct AppRouter: View {
    @StateObject var appState = AppState()

    var body: some View {
        switch appState.route {

        case .splash:
            SplashView(onFinishSplash: appState.handleFinishSplash)

        case .onboarding:
            Onboarding(onFinishOnboarding: appState.handleFinishOnboarding)

        case .login:
            LoginView(onLoginSuccess: appState.loginSuccess)

        case .main:
            MainTabView().environmentObject(appState)
        }
    }
}
