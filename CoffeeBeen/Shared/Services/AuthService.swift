import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    static let shared = AuthService()
    private init() {}
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    func register(withEmail email: String, password: String, firstName: String, lastName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(
                withEmail: email,
                password: password
            )
            self.userSession = result.user
            
            let user = User(
                id: result.user.uid,
                firstName: firstName,
                lastName: lastName,
                email: email,
                phoneNumber: "",
                address: "",
                profileImageUrl: ""
            )
            
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore
                .firestore()
                .collection("users")
                .document(user.id!)
                .setData(encodedUser)
            
            self.currentUser = user
        } catch {
            print(
                "DEBUG: Failed to create user with error \(error.localizedDescription)"
            )
            throw error
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(
                withEmail: email,
                password: password
            )
            self.userSession = result.user
            if let user = self.userSession {
                let token = try await user.getIDToken()
                if let tokenData = token.data(using: .utf8) {
                    KeychainHelper.shared
                        .save(
                            tokenData,
                            service: "accessToken",
                            account: "CoffeeBeen"
                        )
                }
            }
            try await fetchUser()
        } catch {
            print(
                "DEBUG: Failed to sign in with error \(error.localizedDescription)"
            )
            throw error
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print(
                "DEBUG: Failed to sign out with error \(error.localizedDescription)"
            )
        }
    }
    
    func fetchUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        self.currentUser = try snapshot.data(as: User.self)
    }
} 
