import SwiftUI

struct SplashView: View {
    let onFinish: () -> Void
    @State private var logoScale: CGFloat = 0.8
    @State private var logoOpacity: Double = 0.5

    var body: some View {
        ZStack {
            Logo()
                .scaleEffect(logoScale)
                .opacity(logoOpacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.logoScale = 1.2
                        self.logoOpacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        onFinish()
                    }
                }
            Text("Version 1.1.0")
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        
    }
}
