import FirebaseFirestore

final class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()
    private init() {}

    func collection(collectionName: CollectionName) -> CollectionReference {
        return db.collection(collectionName.rawValue)
    }
    
    func getDocuments<T: Decodable>(
        from path: FirestoreQueryPath,
        as type: T.Type,
        whereField: String? = nil,
        isEqualTo: Any? = nil,
        orderBy: String? = nil,
        descending: Bool = false,
        limit: Int? = nil
    ) async throws -> [T] {
        var ref: Query

        switch path {
        case .collection(let collection):
            ref = db.collection(collection.rawValue)

        case .subcollection(let parent, let docId, let sub):
            ref = db.collection(parent.rawValue).document(docId).collection(sub.rawValue)
        }

        if let whereField = whereField, let isEqualTo = isEqualTo {
            ref = ref.whereField(whereField, isEqualTo: isEqualTo)
        }

        if let orderBy = orderBy {
            ref = ref.order(by: orderBy, descending: descending)
        }

        if let limit = limit {
            ref = ref.limit(to: limit)
        }

        let snapshot = try await ref.getDocuments()
        let documents = try snapshot.documents.compactMap { doc in
            try doc.data(as: T.self)
        }

        return documents
    }

    func getDocument<T: Decodable>(path: String, as type: T.Type) async throws
        -> T
    {
        let snapshot = try await db.document(path).getDocument()
        guard let data = try? snapshot.data(as: T.self) else {
            throw NSError(domain: "DecodeError", code: 0)
        }
        return data
    }

    func setDocument<T: Encodable>(path: String, data: T) async throws {
        try db.document(path).setData(from: data)
    }

    func updateFields(path: String, data: [String: Any]) async throws {
        try await db.document(path).updateData(data)
    }

    func deleteDocument(path: String) async throws {
        try await db.document(path).delete()
    }
}
