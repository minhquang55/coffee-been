enum CollectionName: String {
    case missions = "missions"
    case users = "coffee-users"
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
