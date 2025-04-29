import Foundation
import FirebaseStorage

@MainActor
final class StorageService {
    static let shared = StorageService()
    private let storage = Storage.storage()
    
    private init() {}
    
    func downloadURL(_ imagePath: String?) async throws -> URL {
        let ref = storage.reference().child(imagePath ?? "")
        return try await withCheckedThrowingContinuation { continuation in
            ref.downloadURL { url, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let url = url {
                    let urlString = url.absoluteString
                    if urlString.contains(":443") {
                        let fixedString = urlString.replacingOccurrences(of: ":443", with: "")
                        return continuation.resume(returning: URL(string: fixedString) ?? url)
                    }
                    continuation.resume(returning: url)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
        }
    }
}
