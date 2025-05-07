import FirebaseAuth
import FirebaseFirestore
import Foundation

@MainActor
class UpdateProfileViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var address = ""
    @Published var isUpdating = false

    private var uid: String? {
        AuthenticationService.shared.currentUser?.uid
    }

    init() {
        Task {
            await fetchCurrentUser()
        }
    }

    func fetchCurrentUser() async {
        guard let uid else { return }

        do {
            let snapshot = try await FirestoreService.shared.collection(
                collectionName: .users
            ).document(uid).getDocument()

            if let data = snapshot.data() {
                self.firstName = data["firstName"] as? String ?? ""
                self.lastName = data["lastName"] as? String ?? ""
                self.email = data["email"] as? String ?? ""
                self.phoneNumber = data["phoneNumber"] as? String ?? ""
                self.address = data["address"] as? String ?? ""
            }
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
        }
    }

    func updateProfile() async -> Bool {
        guard let uid else { return false }

        isUpdating = true
        defer { isUpdating = false }

        do {
            let data: [String: Any] = [
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "phoneNumber": phoneNumber,
                "address": address,
            ]

            try await FirestoreService.shared.collection(collectionName: .users)
                .document(uid).updateData(data)
            return true
        } catch {
            return false
        }
    }
}
