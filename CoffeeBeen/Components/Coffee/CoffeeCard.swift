import SwiftUI

struct CoffeeCard: View {
    let coffee: CoffeePlace
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(coffee.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(coffee.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.white)
                    Text(coffee.location)
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
            .cornerRadius(12)
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    CoffeeCard(coffee: Coffee.sampleData[0], width: 200, height: 250)
} 
