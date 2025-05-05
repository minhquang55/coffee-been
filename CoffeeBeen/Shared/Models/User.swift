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
} 
