//
//  RewardView.swift
//  CoffeeBeen
//
//  Created by Trần Minh Quang on 24/4/25.
//

import SwiftUI

struct RewardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Attractive gift for you")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Carry out the missions and enjoy the rewards")
                        .foregroundColor(.gray)
                    
                    // XP Progress Section
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
                
                // Stats Section
                HStack(spacing: 15) {
                    StatsCard(quantity: "11", statType: "Vouchers", description: "5 will expire", progressValue: 0.6)
                    StatsCard(quantity: "17", statType: "Missions", description: "3 In progress", progressValue: 0.8)
                }
                .padding(.horizontal)
                
                // Voucher Section
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Voucher for you")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        Text("View All")
                            .foregroundColor(.green)
                    }
                    
                    VoucherCard(
                        title: "25% discount for all menus",
                        description: "25% discount on all menus during ...",
                        daysRemaining: 1
                    )
                }
                .padding(.horizontal)
                
                // Mission Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Mission for you")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 15) {
                        MissionCard(
                            title: "Buy 10 Coffee",
                            description: "Buy 10 Coffees and get 1 Coffee for free",
                            currentProgress: "8",
                            totalProgress: "10",
                            timeRemaining: "12 hours"
                        )
                        
                        MissionCard(
                            title: "Hang out 1 Hour",
                            description: "Hang out and drink coffee with your ...",
                            currentProgress: "45",
                            totalProgress: "60",
                            timeRemaining: "12 hours"
                        )
                        
                        MissionCard(
                            title: "Hang out 2 Hour",
                            description: "Hang out and drink coffee with your ...",
                            currentProgress: "45",
                            totalProgress: "120",
                            timeRemaining: "3 days"
                        )
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGray6))
    }
}
