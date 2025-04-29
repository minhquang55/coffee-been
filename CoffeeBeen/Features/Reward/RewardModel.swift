import Foundation
import FirebaseFirestore

class BaseReward: Identifiable {
    var id: String
    var title: String
    var description: String
    var effectivePeriod: Int
    var remainingTime: String
    var imageUrl: URL?
    
    init(id: String, title: String, description: String, effectivePeriod: Int, remainingTime: String, imageUrl: URL?) {
        self.id = id
        self.title = title
        self.description = description
        self.effectivePeriod = effectivePeriod
        self.remainingTime = remainingTime
        self.imageUrl = imageUrl
    }
}

class UserMission: BaseReward {
    var status: MissionStatus
    var totalProgress: Int
    var currentProgress: Int
    
    init(id: String, title: String, description: String, effectivePeriod: Int, remainingTime: String, imageUrl: URL? = nil, status: MissionStatus, totalProgress: Int, currentProgress: Int) {
        self.status = status
        self.totalProgress = totalProgress
        self.currentProgress = currentProgress
        super.init(id: id, title: title, description: description, effectivePeriod: effectivePeriod, remainingTime: remainingTime, imageUrl: imageUrl)
    }
}


class UserVoucher: BaseReward {
    var status: VoucherStatus
    
    init(id: String, title: String, description: String, effectivePeriod: Int, remainingTime: String, imageUrl: URL? = nil, status: VoucherStatus) {
        self.status = status
        super.init(id: id, title: title, description: description, effectivePeriod: effectivePeriod, remainingTime: remainingTime, imageUrl: imageUrl)
    }
}
