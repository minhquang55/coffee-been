import SwiftUI

struct StatsSection: View {
    @ObservedObject var rewardViewModel: RewardViewModel
    var body: some View {
        HStack(spacing: 15) {
            StatsCard(quantity: String(rewardViewModel.vouchers.count), statType: "Vouchers", description: "5 will expire", progressValue: 0.6)
            StatsCard(quantity: String(rewardViewModel.missions.count), statType: "Missions", description: "\(rewardViewModel.inprogressMissionQuantity) inprogress", progressValue: Double(rewardViewModel.inprogressMissionQuantity / 1))
        }
        .padding(.horizontal)
    }
}
