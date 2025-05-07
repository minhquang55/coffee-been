import Foundation
import FirebaseFirestore

@MainActor
class RewardViewModel: ObservableObject {
    @Published var missions: [UserMission] = []
    @Published var vouchers: [UserVoucher] = []
    @Published var isLoaded: Bool = false
    @Published var willExpireVoucherQuantity = 0
    @Published var inprogressMissionQuantity = 0
    
    func loadData(userId: String) {
        Task {
            await loadMissions(userId: userId)
            await loadVouchers(userId: userId)
            
            DispatchQueue.main.async {
                self.isLoaded = true
            }
        }
    }
    
    private func loadVouchers(userId: String) async {
        Task {
            do {
                let userVoucherDocs = try await fetchUserSubCollection(userId: userId, collectionName: .users, subCollectionName: .vouchers)
                var loadedVouchers: [UserVoucher] = []
                
                for doc in userVoucherDocs {
                    let data = doc.data()
                    
                    guard
                        let voucherId = data["voucherId"] as? String,
                        let endTimestamp = data["endDate"] as? Timestamp,
                        let statusString = data["status"] as? String,
                        let status = VoucherStatus(rawValue: statusString)
                    else {
                        continue
                    }
                    
                    let voucherData = try await fetchDocumentByCollectionName(collectionName: .vouchers, documentId: voucherId)
                    let imageRef = try await StorageService.shared.getImageReference(path: voucherData["imagePath"] as? String ?? "")
                    let imageUrl = try await StorageService.shared.downloadURL(imageReference: imageRef)
                    
                    let userVoucher = UserVoucher(
                        id: voucherId,
                        title: voucherData["title"] as? String ?? "",
                        description: voucherData["description"] as? String ?? "",
                        effectivePeriod: voucherData["effectivePeriod"] as? Int ?? 0,
                        remainingTime: calculateRemainingTime(endTimestamp: endTimestamp) ?? "",
                        imageUrl: imageUrl,
                        status: status
                    )
                    
                    loadedVouchers.append(userVoucher)
                }
                self.vouchers = loadedVouchers
            } catch {
                print("🔥 Error loading vouchers: \(error)")
            }
        }
    }

    private func loadMissions(userId: String) async {
        Task {
            do {
                let userMissionDocs = try await fetchUserSubCollection(userId: userId, collectionName: .users, subCollectionName: .missions)
                var loadedMissions: [UserMission] = []
                var inprogressMissionQuantity = 0

                for doc in userMissionDocs {
                    let data = doc.data()
                    
                    guard
                        let missionId = data["missionId"] as? String,
                        let currentProgress = data["currentProgress"] as? Int,
                        let endTimestamp = data["endDate"] as? Timestamp,
                        let statusString = data["status"] as? String,
                        let status = MissionStatus(rawValue: statusString)
                    else {
                        continue
                    }

                    let missionData = try await fetchDocumentByCollectionName(collectionName: .missions, documentId: missionId)
                    
                    
                    let imageRef = try await StorageService.shared.getImageReference(path: missionData["imagePath"] as? String ?? "")
                    let imageUrl = try await StorageService.shared.downloadURL(imageReference: imageRef)

                    let userMission = UserMission(
                        id: missionId,
                        title: missionData["title"] as? String ?? "No Title",
                        description: missionData["description"] as? String ?? "No Description",
                        effectivePeriod: missionData["effectivePeriod"] as? Int ?? 0,
                        remainingTime: calculateRemainingTime(endTimestamp: endTimestamp) ?? "",
                        imageUrl: imageUrl,
                        status: status,
                        totalProgress: missionData["totalProgress"] as? Int ?? 0,
                        currentProgress: currentProgress
                    )
                    
                    if (status == .inprogress) {
                        inprogressMissionQuantity += 1
                    }

                    loadedMissions.append(userMission)
                }
                self.missions = loadedMissions
                self.inprogressMissionQuantity = inprogressMissionQuantity

            } catch {
                print("🔥 Error loading missions: \(error)")
            }
        }
    }

    // MARK: - Private helpers
    
    private func fetchUserSubCollection(userId: String, collectionName: CollectionName, subCollectionName: CollectionName) async throws -> [QueryDocumentSnapshot] {
        let snapshot = try await FirestoreService.shared.collection(collectionName: collectionName).document(userId).collection(subCollectionName.rawValue).getDocuments()
        return snapshot.documents
    }
    
    private func fetchDocumentByCollectionName(collectionName: CollectionName, documentId: String) async throws -> [String: Any] {
        let snapshot = try await FirestoreService.shared.collection(collectionName: collectionName).document(documentId).getDocument()
        guard let data = snapshot.data() else {
            throw NSError(domain: "No voucher data", code: 0)
        }
        return data
    }
}
