import SwiftUI

struct VoucherCard: View {
    let title: String
    let description: String
    let imageUrl: URL?
    let remainingTime: String
    
    var body: some View {
        HStack {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                case .failure(let error):
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                        .onAppear {
                            print(error)
                        }
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
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
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
