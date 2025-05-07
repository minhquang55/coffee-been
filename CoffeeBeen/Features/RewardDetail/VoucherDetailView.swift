import SwiftUI

struct VoucherDetailView: View {
    let voucher: UserVoucher

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Title & Remaining time
            VStack(alignment: .leading, spacing: 8) {
                Text(voucher.title)
                    .font(.title2)
                    .fontWeight(.bold)
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                    Text(voucher.remainingTime)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 8)

            Divider()

            // Terms and Conditions
            VStack(alignment: .leading, spacing: 12) {
                Text("Terms and Conditions")
                    .font(.headline)
                VStack(alignment: .leading, spacing: 8) {
                    Text("1. Vouchers are only valid in Indonesia.")
                    Text("2. Vouchers can only be used once.")
                    Text("3. Vouchers can only be valid using the Coffee Pay payment method.")
                    Text("4. Vouchers can only be used from 07.00 am to 09.00 pm.")
                }
                .font(.subheadline)
                .foregroundColor(.black)
            }

            Spacer()

            // Use Now Button
            Button(action: {
                // Action for using the voucher
            }) {
                Text("Use Now")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Theme.primary)
                    .cornerRadius(16)
            }
            .padding(.bottom, 16)
        }
        .padding()
        .navigationTitle("Voucher")
        .navigationBarTitleDisplayMode(.inline)
    }
}
