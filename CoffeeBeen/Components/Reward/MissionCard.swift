import SwiftUI

struct MissionCard: View {
    let title: String
    let description: String
    let currentProgress: String
    let totalProgress: String
    let timeRemaining: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image("onboarding-1") // You'll need to add this asset
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 0) {
                    Text(title)
                        .font(.headline)
                    Spacer()
                    Text("\(currentProgress) ")
                        .foregroundColor(Theme.primary)
                    Text("/ \(totalProgress)")
                }
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.red)
                        .font(.headline)
                    Text("Ends in \(timeRemaining)")
                        .font(.body)
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
