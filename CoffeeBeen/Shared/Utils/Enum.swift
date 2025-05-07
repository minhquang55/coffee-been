enum Route {
    case splash, onboarding, login, main
}

enum CollectionName: String {
    case missions = "missions"
    case users = "users"
    case vouchers = "vouchers"
}

enum MissionStatus: String {
    case available = "available"
    case inprogress = "inprogress"
    case completed = "completed"
    case expired = "expired"
}

enum VoucherStatus: String {
    case unused = "unused"
    case used = "used"
    case expired = "expired"
}

enum FirestoreQueryPath {
    case collection(CollectionName)
    case subcollection(parentCollection: CollectionName, documentId: String, subcollection: CollectionName)
}
