import SwiftUI

struct PrimaryButton: View {
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.primary)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}
