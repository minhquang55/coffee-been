//
//  Onboarding.swift
//  CoffeeBeen
//
//  Created by Trần Minh Quang on 23/4/25.
//

import SwiftUI

struct Onboarding: View {
    @State private var currentIndex = 0
    let totalPages = 3
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("onboarding-\(currentIndex + 1)")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(width: geometry.size.width)
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.black.opacity(1),
                            Color.black.opacity(0.0)
                        ]
                    ),
                    startPoint: .bottom,
                    endPoint: .center
                ).ignoresSafeArea()
            }
            VStack {
                Spacer()
                Text("Let's explore")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Kinds of coffee")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text(
                    "Let's explore various coffee flavors with us with just few clicks"
                )
                .foregroundStyle(.white)
                .padding(.horizontal)
                .padding(.vertical, 1)
                // Thanh trạng thái: chấm tròn
                HStack(spacing: 8) {
                    ForEach(0..<totalPages, id: \.self) { index in
                        Rectangle()
                            .fill(
                                index == currentIndex ? Theme.primary : Color.gray
                                    .opacity(0.5)
                            )
                            .frame(width: .infinity, height: 5)
                            
                    }
                }
                .padding()
                
                Button(action: {
                    if currentIndex < totalPages - 1 {
                        currentIndex += 1
                    } else {
                        print("Get Started → Navigate to Home")
                        // Navigate to home screen
                    }
                }) {
                    Text(
                        currentIndex == totalPages - 1 ? "Get Started" : "Next"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Theme.primary)
                    .cornerRadius(12)
                }.padding()
            }
        }
    }
}

#Preview {
    Onboarding()
}
