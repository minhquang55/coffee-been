import FirebaseAuth
import FirebaseFirestore
import Foundation

class AuthViewModel: ObservableObject {
    static let shared = AuthViewModel()
    private init() {}
    
    @Published var currentUser: User?

    func fetchCurrentUser() async {
        do {
            self.currentUser = try await AuthenticationService.shared
                .fetchCurrentUser()
        } catch {
            print(
                "DEBUG: Failed to fetch current user with error \(error.localizedDescription)"
            )
        }
    }

    func register(
        withEmail email: String,
        password: String,
        firstName: String,
        lastName: String
    ) async throws {
        do {
            let result = try await AuthenticationService.shared.auth.createUser(
                withEmail: email,
                password: password
            )
            let user = User(
                id: result.user.uid,
                firstName: firstName,
                lastName: lastName,
                email: email
            )
            let encodedUser = try Firestore.Encoder().encode(user)
            try await FirestoreService.shared.collection(collectionName: .users)
                .document(user.id!).setData(encodedUser)
            await fetchCurrentUser()
        } catch {
            print(
                "DEBUG: Failed to create user with error \(error.localizedDescription)"
            )
            throw error
        }
    }

    func signIn(withEmail email: String, password: String) async throws {
        do {
            _ = try await AuthenticationService.shared.auth.signIn(
                withEmail: email,
                password: password
            )
            await fetchCurrentUser()
        } catch {
            print(
                "DEBUG: Failed to sign in with error \(error.localizedDescription)"
            )
            throw error
        }
    }

    func signOut() {
        do {
            try AuthenticationService.shared.auth.signOut()
            self.currentUser = nil
        } catch {
            print(
                "DEBUG: Failed to sign out with error \(error.localizedDescription)"
            )
        }
    }
}
