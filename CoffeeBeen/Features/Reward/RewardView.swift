import SwiftUI

struct RewardView: View {
    @StateObject private var rewardViewModel = RewardViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeaderSection()
                StatsSection(rewardViewModel: rewardViewModel)
                VoucherSection(rewardViewModel: rewardViewModel)
                MissionSection(rewardViewModel: rewardViewModel)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGray6))
        .onAppear {
            guard !rewardViewModel.isLoaded else { return }
            rewardViewModel.loadData(userId: "hZ3yDIBkcMVT1Swp25IU")
        }
    }
}
