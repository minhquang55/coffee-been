import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let address: String
    let profileImageUrl: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    init(id: String? = nil, firstName: String, lastName: String, email: String, phoneNumber: String = "", address: String = "", profileImageUrl: String = "") {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.address = address
        self.profileImageUrl = profileImageUrl
    }
}
