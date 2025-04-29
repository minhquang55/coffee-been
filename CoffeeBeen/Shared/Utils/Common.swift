import Foundation
import FirebaseFirestore

func calculateRemainingTime(endTimestamp: Timestamp) -> String? {
    
    let endDate = endTimestamp.dateValue()
    let currentDate = Date()
    let remainingTime = endDate.timeIntervalSince(currentDate)
    
    if remainingTime <= 0 {
        return "Expired"
    }

    let days = Int(remainingTime) / (60 * 60 * 24)
    let hours = (Int(remainingTime) % (60 * 60 * 24)) / (60 * 60)
    let minutes = (Int(remainingTime) % (60 * 60)) / 60
    
    if days > 0 {
        return "Ends in \(days)d"
    } else if hours > 0 {
        return "Ends in \(hours)h"
    } else if minutes > 0 {
        return "Ends in \(minutes)m"
    } else {
        return "Expired"
    }
}
