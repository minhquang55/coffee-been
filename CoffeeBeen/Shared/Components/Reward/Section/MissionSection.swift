import SwiftUI

struct MissionSection: View {
    @ObservedObject var rewardViewModel: RewardViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Mission for you")
                .font(.title3)
                .fontWeight(.bold)
            
            VStack(spacing: 15) {
                ForEach(rewardViewModel.missions, id: \.id) { mission in
                    MissionCard(
                        title: mission.title,
                        description: mission.description,
                        currentProgress: "\(mission.currentProgress)",
                        totalProgress: "\(mission.totalProgress)",
                        remainingTime: mission.remainingTime,
                        imageUrl: mission.imageUrl
                    )
                }
            }
        }
        .padding(.horizontal)
    }
}
