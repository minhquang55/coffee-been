import FirebaseStorage
import Foundation

@MainActor
final class StorageService {
    static let shared = StorageService()
    private let reference = Storage.storage().reference()

    private init() {}

    func getImageReference(path: String) async throws -> StorageReference {
        return reference.child(path)
    }

    func uploadImage(data: Data, imageReference: StorageReference) async throws
        -> URL
    {
        _ = try await imageReference.putDataAsync(data)
        return try await imageReference.downloadURL()
    }
    
    func downloadURL(imageReference: StorageReference) async throws -> URL {
        let url = try await imageReference.downloadURL()
        let urlString = url.absoluteString
        if urlString.contains(":443") {
            let fixedString = urlString.replacingOccurrences(of: ":433", with: "")
            return URL(string: fixedString) ?? url
        }
        return url
    }

    func removeImage(imageReference: StorageReference) async throws {
        try await imageReference.delete()
    }
}
