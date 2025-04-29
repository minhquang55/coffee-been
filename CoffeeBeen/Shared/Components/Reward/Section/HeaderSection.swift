import SwiftUI

struct HeaderSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Attractive gift for you")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Carry out the missions and enjoy the rewards")
                .foregroundColor(.gray)
            
            HStack {
                Image(systemName: "gift.fill")
                    .foregroundColor(.red)
                
                VStack(alignment: .leading) {
                    Text("350 XP more to get rewards")
                        .font(.subheadline)
                    ProgressView(value: 0.7)
                        .tint(.green)
                }
                
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
        }
        .padding(.horizontal)
    }
}
