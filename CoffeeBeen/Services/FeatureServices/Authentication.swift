import FirebaseAuth

final class AuthenticationService {
    static let shared = AuthenticationService()
    private init() {}
    let auth = Auth.auth()
    let currentUser = Auth.auth().currentUser

    func fetchCurrentUser() async throws -> User? {
        guard let uid = currentUser?.uid else {
            return nil
        }
        return try await FirestoreService.shared.getDocument(
            path: "\(CollectionName.users.rawValue)/\(uid)",
            as: User.self
        )
    }
}
