import SwiftUI

struct VoucherSection: View {
    @ObservedObject var rewardViewModel: RewardViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Voucher for you")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Text("View All")
                    .foregroundColor(.green)
            }
            
            VStack(spacing: 15) {
                ForEach(rewardViewModel.vouchers, id: \.id) {voucher in
                    VoucherCard(
                        title: voucher.title,
                        description: voucher.description,
                        imageUrl: voucher.imageUrl,
                        remainingTime: voucher.remainingTime
                    )
                }
            }
        }
        .padding(.horizontal)
    }
}
