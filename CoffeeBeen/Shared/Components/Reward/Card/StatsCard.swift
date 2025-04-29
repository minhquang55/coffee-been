import SwiftUI

struct StatsCard: View {
    let quantity: String
    let statType: String
    let description: String
    let progressValue: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(quantity)
                .font(.title)
                .fontWeight(.bold)
            Text(statType)
                .font(.headline)
            ProgressView(value: progressValue)
                .tint(.green)
            Text(description)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)

    }
}
