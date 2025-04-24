import SwiftUI

struct PopularCoffeeCard: View {
    let coffee: CoffeePlace
    
    var body: some View {
        HStack(spacing: 12) {
            Image(coffee.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(coffee.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(coffee.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    ForEach(0..<5) { index in
                        Image(systemName: index < Int(coffee.rating) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                    Text(String(format: "%.1f", coffee.rating))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(8)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    PopularCoffeeCard(coffee: Coffee.sampleData[2])
        .padding()
} 
