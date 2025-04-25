import SwiftUI

struct RegisterFormState {
    var firstname: String = ""
    var lastname: String = ""
    var email: String = ""
    var password: String = ""
    var OTP: String = ""
}

struct RegisterView: View {
    
    private let registerSteps: [Int: [String: String]] = [
        1: [
            "buttonText": "Input Account",
            "stepDescription": "Input Your Name"
        ],
        2: [
            "buttonText": "Create Account",
            "stepDescription": "Input Your Account"
        ],
        3: [
            "buttonText": "Verification",
            "stepDescription": "Input Your Password"
        ],
        4: [
            "buttonText": "Submit",
            "stepDescription": "Input OTP Verification"
        ],
        5: [
            "buttonText": "Let's Explore"
        ]
    ]
    
    @State private var step = 1
    @State private var isPasswordVisible = false
    @State private var registerFormState = RegisterFormState()
    @State private var prevStep = 1
    
    private func isCurrentStepValid() -> Bool {
        switch step {
        case 1:
            return !registerFormState.firstname.isEmpty
        case 2:
            return !registerFormState.email.isEmpty && registerFormState.email.contains("@")
        case 3:
            return !registerFormState.password.isEmpty
        case 4:
            return registerFormState.OTP.count == 4
        default:
            return true
        }
    }
    
    private func handleNextStep() {
        if true {
            withAnimation {
                prevStep = step
                step = min(step + 1, 5)
            }
        }
    }
    
    private func handlePrevStep() {
        withAnimation {
            prevStep = step
            step = max(step - 1, 1)
        }
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: step == 5 ? .center : .leading, spacing: 24) {
                if let stepDescription = registerSteps[step]?["stepDescription"] {
                    Text(stepDescription)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .padding(.bottom)
                }

                ZStack {
                    if step == 1 {
                        step1View()
                            .transition(.move(edge: prevStep < step ? .trailing : .leading))
                    }
                    if step == 2 {
                        step2View()
                            .transition(.move(edge: prevStep < step ? .trailing : .leading))
                    }
                    if step == 3 {
                        step3View()
                            .transition(.move(edge: prevStep < step ? .trailing : .leading))
                    }
                    if step == 4 {
                        step4View()
                            .transition(.move(edge: prevStep < step ? .trailing : .leading))
                    }
                    if step == 5 {
                        successView()
                            .transition(.opacity)
                    }
                }
                .animation(.easeInOut, value: step)

                Spacer()

                if let buttonText = registerSteps[step]?["buttonText"] {
                    PrimaryButton(buttonText: buttonText) {
                        handleNextStep()
                    }
                    .padding()
                }
            }
            .navigationTitle("Create New Account")
            .navigationBarBackButtonHidden(step == 1 ? false : true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if step > 1 && step < 5 {
                        Button(action: {
                            handlePrevStep()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }

    // MARK: Step Views

    @ViewBuilder
    private func step1View() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("First Name")
                .foregroundColor(.gray)
            TextField("First Name", text: $registerFormState.firstname)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

            Text("Last Name")
                .foregroundColor(.gray)
            TextField("Last Name", text: $registerFormState.lastname)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func step2View() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Email")
                .foregroundColor(.gray)
            TextField("Your Email", text: $registerFormState.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func step3View() -> some View {
        PasswordField(spacing: 16, password: $registerFormState.password).padding(.horizontal)
    }

    @ViewBuilder
    private func step4View() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("OTP Code")
                .foregroundColor(.gray)
            TextField("Enter OTP code", text: $registerFormState.OTP)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func successView() -> some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)
            Text("Registration Successful!")
                .font(.title2)
                .bold()
        }.padding(.top, 200)
    }
}

#Preview {
    RegisterView()
}
