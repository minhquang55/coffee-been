//
//  CoffeeView.swift
//  CoffeeBeen
//
//  Created by Trần Minh Quang on 24/4/25.
//

import SwiftUI

struct CoffeeView: View {
    @State private var searchText = ""
    private let favoriteItems = Array(Coffee.sampleData.prefix(2))
    private let popularItems = Array(Coffee.sampleData.dropFirst(2))
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Header
                Text("Find your best cafe")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Enjoy the love of the best coffee taste")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                // Search Bar
                CoffeeSearchBarView(searchText: $searchText)
                    .padding(.vertical, 20)
                
                // Favorite Places
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Favorite Place")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        Button("View All") {
                            // Handle view all action
                        }
                        .foregroundColor(Theme.primary)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(favoriteItems) { coffee in
                                CoffeeCard(
                                    coffee: coffee,
                                    width: 160,
                                    height: 200
                                )
                            }
                        }
                    }
                }
                
                // Popular Places
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Popular Place")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        Button("View All") {
                            // Handle view all action
                        }
                        .foregroundColor(.green)
                    }
                    
                    VStack(spacing: 12) {
                        ForEach(popularItems) { coffee in
                            PopularCoffeeCard(coffee: coffee)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CoffeeView()
}
