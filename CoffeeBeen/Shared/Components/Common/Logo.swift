//
//  Logo.swift
//  CoffeeBeen
//
//  Created by Trần Minh Quang on 23/4/25.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        HStack {
            Text("Coffee").font(.title).bold()
            Text("Been").font(.title).bold().foregroundColor(Theme.primary)
        }
    }
}

#Preview {
    Logo()
}
