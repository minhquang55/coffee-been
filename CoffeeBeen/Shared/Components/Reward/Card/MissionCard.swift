import SwiftUI

struct MissionCard: View {
    let title: String
    let description: String
    let currentProgress: String
    let totalProgress: String
    let remainingTime: String
    let imageUrl: URL?
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
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
                    Text(remainingTime)
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
