import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Logo()
            Text("Version 1.1.0")
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    SplashScreen()
} 
