import Foundation

enum Validation {
    enum Rule {
        case required
        case email
        case minLength(Int)
        case maxLength(Int)
        case custom((String) -> Bool)
    }
    
    static func validate(_ value: String, rules: [Rule]) -> String? {
        for rule in rules {
            switch rule {
            case .required:
                if value.isEmpty {
                    return "This field is required"
                }
            case .email:
                let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
                if !emailPredicate.evaluate(with: value) {
                    return "Please enter a valid email"
                }
            case .minLength(let length):
                if value.count < length {
                    return "Must be at least \(length) characters"
                }
            case .maxLength(let length):
                if value.count > length {
                    return "Must be less than \(length) characters"
                }
            case .custom(let validator):
                if !validator(value) {
                    return "Invalid input"
                }
            }
        }
        return nil
    }
} 