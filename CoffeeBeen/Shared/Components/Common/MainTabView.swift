//
//  MainTabView.swift
//  CoffeeBeen
//
//  Created by Trần Minh Quang on 25/4/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(
                        selectedTab == 0 ? "icon_home_fill" : "icon_home_linear"
                    )
                }
                .tag(0)
                    
            CoffeeView()
                .tabItem {
                    Image(
                        selectedTab == 1 ? "icon_coffee_fill" : "icon_coffee_linear"
                    )
                }
                .tag(1)
            
            RewardView()
                .tabItem {
                    Image(
                        selectedTab == 2 ? "icon_tag_fill" : "icon_tag_linear"
                    )
                }
                .tag(2)
                    
            ProfileView()
                .tabItem {
                    Image(
                        selectedTab == 3 ? "icon_profile_fill" : "icon_profile_linear"
                    )
                }
                .tag(3)
        }
    }
}
