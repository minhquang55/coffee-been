import Foundation

struct CoffeePlace: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let rating: Double
    let imageUrl: String
    let description: String
    let isFavorite: Bool
}

// Sample Data
extension Coffee {
    static let sampleData = [
        CoffeePlace(
            name: "Coffe Bean",
            location: "Bali, Indonesia",
            rating: 0.0,
            imageUrl: "coffee-1",
            description: "",
            isFavorite: true
        ),
        CoffeePlace(
            name: "Coffe Bean",
            location: "Bandung, Indonesia",
            rating: 0.0,
            imageUrl: "coffee-2",
            description: "",
            isFavorite: true
        ),
        CoffeePlace(
            name: "Coffe Bean - Resort Kuta",
            location: "Kuta, Indonesia",
            rating: 4.9,
            imageUrl: "coffee-3",
            description: "One of the best and most popular coffee",
            isFavorite: false
        ),
        CoffeePlace(
            name: "Coffe Bean - Mandalika's",
            location: "Mandalika, Indonesia",
            rating: 4.8,
            imageUrl: "coffee-4",
            description: "One of the best and most popular coffee",
            isFavorite: false
        ),
        CoffeePlace(
            name: "Coffe Bean - Street View",
            location: "Street View",
            rating: 4.7,
            imageUrl: "coffee-5",
            description: "One of the best and most popular coffee",
            isFavorite: false
        )
    ]
} 
