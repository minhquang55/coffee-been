import Combine
import FirebaseAuth
import Foundation

class AppState: ObservableObject {
    @Published var route: Route = .splash
    
    init() {
        Task {
            await AuthViewModel.shared.fetchCurrentUser()
        }
    }

    func checkInitialRoute() {
        if !UserDefaults.standard.bool(forKey: "hasFinishedOnboarding") {
            route = .onboarding
        } else if AuthenticationService.shared.currentUser == nil {
            route = .login
        } else {
            route = .main
        }
    }

    func handleFinishSplash() {
        checkInitialRoute()
    }

    func handleFinishOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasFinishedOnboarding")
        checkInitialRoute()
    }

    func loginSuccess() {
        self.route = .main
    }

    func signoutSuccess() {
        self.route = .login
    }
}
