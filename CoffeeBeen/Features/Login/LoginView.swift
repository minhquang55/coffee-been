import SwiftUI

struct LoginFormState {
    var email: String = ""
    var password: String = ""
}

struct LoginView: View {
    var onLoginSuccess: () -> Void
    @State private var loginFormState = LoginFormState()
    @State var isRememberMe = false
    @State var isPasswordVisible = false
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertType: AlertView.AlertType = .error

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Logo
                Logo()
                    .scaleEffect(1.5)
                    .padding(.top, 100)

                Spacer()

                // Form
                VStack(spacing: 24) {
                    // Email field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .foregroundColor(.gray)
                        TextField(
                            "coffeebeen@gmail.com",
                            text: $loginFormState.email
                        )
                        .autocapitalization(.none)
                        .textFieldStyle(.plain)
                        .padding(.vertical, 12)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray.opacity(0.3))
                                .offset(y: 12)
                        )
                    }

                    // Password field
                    PasswordField(
                        spacing: 8,
                        password: $loginFormState.password
                    )

                    // Remember me & Forgot password
                    HStack {
                        HStack(spacing: 8) {
                            Button(action: {
                                isRememberMe.toggle()
                            }) {
                                Image(
                                    systemName: isRememberMe ? "checkmark.square.fill" : "square"
                                )
                                .foregroundColor(
                                    isRememberMe ? Theme.primary : .gray
                                )
                            }
                            Text("Remember me")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Button(action: {
                            // Handle forgot password
                        }) {
                            Text("Forgot password")
                                .font(.system(size: 14))
                                .foregroundColor(Theme.primary)
                        }
                    }

                    // Create Account
                    NavigationLink(destination: RegisterView()) {
                        Text("Create Account")
                            .foregroundColor(Theme.primary)
                    }.padding(.top, 12)

                    // Sign In button
                    Button(action: {
                        handleSignIn()
                    }) {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                    }
                    .background(Theme.primary)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.top, 12)

                    // Social login
                    VStack(spacing: 20) {
                        Text("or continue with")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)

                        HStack(spacing: 40) {
                            // Google
                            Button(action: {}) {
                                Image(systemName: "g.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }

                            // Apple
                            Button(action: {}) {
                                Image(systemName: "apple.logo")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .padding(.all, 6)
                                    .foregroundStyle(Color.white)
                                    .background(Circle().fill(Color.black))
                            }

                            // Facebook
                            Button(action: {}) {
                                Image(systemName: "f.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                    .padding(.top, 24)
                }
                .padding(.horizontal, 24)
            }
            .padding(.bottom, 40)
        }
        .alert(
            isPresented: $showAlert,
            alert: AlertView(
                title: alertType == .error ? "Error" : "Success",
                message: alertMessage,
                type: alertType,
                onDismiss: { showAlert = false }
            ))
    }

    private func handleSignIn() {
        isLoading = true
        print("Sign in")
        Task {
            do {
                try await AuthService.shared.signIn(
                    withEmail: loginFormState.email, password: loginFormState.password)
                isLoading = false
                onLoginSuccess()
            } catch {
                isLoading = false
                alertMessage = error.localizedDescription
                alertType = .error
                showAlert = true
            }
        }
    }
}

#Preview {
    LoginView(
        onLoginSuccess: {},
        isRememberMe: false,
        isPasswordVisible: false
    )
}
