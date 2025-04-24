//
//  CoffeeSearchBarView.swift
//  CoffeeBeen
//
//  Created by Trần Minh Quang on 24/4/25.
//

import SwiftUI

struct CoffeeSearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search Coffee", text: $searchText)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
    }
}
