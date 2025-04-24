import SwiftUI

struct HomeView: View {
    @State private var selectedCategory = "All"
    @Environment(\.colorScheme) var colorScheme
    
    let categories = ["All", "Cappuccino", "Espresso", "Latte", "Americano"]
    let coffees = [
        Coffee(name: "Cappuccino", description: "With Steamed Milk", price: 4.20, imageName: "cappuccino"),
        Coffee(name: "Espresso", description: "Strong and Bold", price: 3.50, imageName: "espresso"),
        Coffee(name: "Latte", description: "With Foamed Milk", price: 4.50, imageName: "latte"),
        Coffee(name: "Americano", description: "Espresso with Water", price: 3.00, imageName: "americano")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Theme.spacingLarge) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: Theme.spacingSmall) {
                            Text("Find the best")
                                .font(Theme.titleFont)
                                .foregroundColor(Theme.text)
                            
                            Text("coffee for you")
                                .font(Theme.titleFont)
                                .foregroundColor(Theme.primary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "person.circle.fill")
                            .font(.title)
                            .foregroundColor(Theme.primary)
                    }
                    .padding(.horizontal, Theme.spacingMedium)
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Theme.textSecondary)
                        
                        TextField("Search coffee...", text: .constant(""))
                            .font(Theme.bodyFont)
                            .foregroundColor(Theme.text)
                        
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(Theme.primary)
                    }
                    .padding()
                    .background(Theme.secondary)
                    .cornerRadius(Theme.cornerRadiusMedium)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding(.horizontal, Theme.spacingMedium)
                    
                    // Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: Theme.spacingMedium) {
                            ForEach(categories, id: \.self) { category in
                                CategoryButton(
                                    title: category,
                                    isSelected: selectedCategory == category,
                                    action: { selectedCategory = category }
                                )
                            }
                        }
                        .padding(.horizontal, Theme.spacingMedium)
                    }
                    
                    // Coffee Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: Theme.spacingMedium),
                        GridItem(.flexible(), spacing: Theme.spacingMedium)
                    ], spacing: Theme.spacingMedium) {
                        ForEach(coffees) { coffee in
                            CoffeeCard(coffee: coffee)
                        }
                    }
                    .padding(.horizontal, Theme.spacingMedium)
                }
                .padding(.vertical, Theme.spacingMedium)
            }
            .background(Theme.background)
            .navigationBarHidden(true)
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.bodyFont)
                .foregroundColor(isSelected ? Theme.secondary : Theme.text)
                .padding(.horizontal, Theme.spacingMedium)
                .padding(.vertical, Theme.spacingSmall)
                .background(isSelected ? Theme.primary : Theme.secondary)
                .cornerRadius(Theme.cornerRadiusMedium)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

struct Coffee: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let price: Double
    let imageName: String
}

struct CoffeeCard: View {
    let coffee: Coffee
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.spacingSmall) {
            // Coffee Image
            Image(coffee.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadiusMedium))
            
            // Coffee Info
            VStack(alignment: .leading, spacing: Theme.spacingSmall) {
                Text(coffee.name)
                    .font(Theme.subtitleFont)
                    .foregroundColor(Theme.text)
                
                Text(coffee.description)
                    .font(Theme.captionFont)
                    .foregroundColor(Theme.textSecondary)
                    .lineLimit(2)
                
                HStack {
                    Text("$\(coffee.price, specifier: "%.2f")")
                        .font(Theme.subtitleFont)
                        .foregroundColor(Theme.primary)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(Theme.primary)
                    }
                }
            }
            .padding(.horizontal, Theme.spacingSmall)
        }
        .background(Theme.secondary)
        .cornerRadius(Theme.cornerRadiusMedium)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    HomeView()
} 