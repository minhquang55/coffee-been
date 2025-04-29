import FirebaseFirestore

final class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()
    
    private init() { }
    
    func collection(collectionName: CollectionName) -> CollectionReference {
        return db.collection(collectionName.rawValue)
    }
} 
