import SwiftUI

struct PasswordField: View {
    let spacing: CGFloat
    @Binding var password: String
    @State private var isPasswordVisible = false
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text("Password")
                .foregroundColor(.gray)
            HStack {
                if isPasswordVisible {
                    TextField("••••••••••", text: $password)
                } else {
                    SecureField("••••••••••", text: $password)
                }
                
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .textFieldStyle(.plain)
            .padding(.vertical, 12)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.3))
                    .offset(y: 12)
            )
        }
    }
}
