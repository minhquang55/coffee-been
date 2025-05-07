import PhotosUI
import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var currentImagePath: String? = AuthViewModel.shared.currentUser?.profileImageUrl
    @Published var currentImageUrl: URL?
    @Published var newImageUrl: URL?
    @Published var photoItem: PhotosPickerItem? {
        didSet {
            Task { await loadPhotoItem() }
        }
    }
    
    func fetchCurrentUserImageUrl() async {
        guard let path = AuthViewModel.shared.currentUser?.profileImageUrl else {
            print("No profile image path found.")
            return
        }

        do {
            let ref = try await StorageService.shared.getImageReference(path: path)
            let url = try await StorageService.shared.downloadURL(imageReference: ref)
            self.currentImageUrl = url
        } catch {
            print("Failed to get image URL: \(error.localizedDescription)")
        }
    }


    private func loadPhotoItem() async {
        guard let item = photoItem else { return }
        do {
            if let data = try await item.loadTransferable(type: Data.self),
                let image = UIImage(data: data)
            {
                self.selectedImage = image
                await handleUploadImage(image)
            }
        } catch {
            print("Failed to load photo item: \(error.localizedDescription)")
        }
    }

    private func handleUploadImage(_ image: UIImage) async {
        guard let imageData = image.jpegData(compressionQuality: 0.8)
        else { return }

        do {
            let fileName = UUID().uuidString + ".jpg"
            let path = "images/\(fileName)"
            let ref = try await StorageService.shared.getImageReference(
                path: path
            )
            let uploadedUrl = try await StorageService.shared.uploadImage(
                data: imageData,
                imageReference: ref
            )

            try await FirestoreService.shared
                .collection(collectionName: .users)
                .document(AuthViewModel.shared.currentUser?.id ?? "")
                .updateData(["profileImageUrl": path])

            if let oldPath = currentImagePath, oldPath != path {
                let oldRef = try await StorageService.shared.getImageReference(
                    path: oldPath
                )
                try await StorageService.shared.removeImage(
                    imageReference: oldRef
                )
            }

            self.newImageUrl = uploadedUrl
            self.currentImagePath = path

        } catch {
            print("Image upload error: \(error.localizedDescription)")
        }
    }
}
