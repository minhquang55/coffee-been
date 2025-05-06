//
//  ProfileView.swift
//  CoffeeBeen
//
//  Created by Trần Minh Quang on 24/4/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var accessToken: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            Text("ProfileView")
            Text("AccessToken:")
                .font(.headline)
            Text(accessToken.isEmpty ? "(No token)" : accessToken)
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
        }
        .onAppear {
            accessToken = KeychainHelper.shared.readString(service: "accessToken", account: "CoffeeBeen") ?? ""
        }
    }
}

#Preview {
    ProfileView()
}
