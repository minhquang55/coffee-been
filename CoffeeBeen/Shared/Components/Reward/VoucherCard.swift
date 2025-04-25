import SwiftUI

struct VoucherCard: View {
    let title: String
    let description: String
    let daysRemaining: Int
    
    var body: some View {
        HStack {
            Image("onboarding-1") // You'll need to add this asset
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.red)
                        .font(.headline)
                    Text("Ends in \(daysRemaining)")
                        .font(.body)
                        .foregroundColor(.red)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
