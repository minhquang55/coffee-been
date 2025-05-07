import SwiftUI

struct RegisterFormState {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    
    var firstNameError: String?
    var lastNameError: String?
    var emailError: String?
    var passwordError: String?
    
    var isValid: Bool {
        firstNameError == nil && lastNameError == nil && emailError == nil && passwordError == nil
    }
}

struct RegisterView: View {
    @State private var registerFormState = RegisterFormState()
    @State private var step = 1
    @State private var prevStep = 1
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertType: AlertView.AlertType = .error
    @Environment(\.dismiss) var dismiss
    
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
            "buttonText": "Submit",
            "stepDescription": "Input Your Password"
        ],
        4: [
            "buttonText": "Let's Explore"
        ]
    ]
    
    private func validateForm() {
        // Validate First Name
        registerFormState.firstNameError = Validation.validate(
            registerFormState.firstName,
            rules: [.required, .minLength(2), .maxLength(50)]
        )
        
        // Validate Last Name
        registerFormState.lastNameError = Validation.validate(
            registerFormState.lastName,
            rules: [.required, .minLength(2), .maxLength(50)]
        )
        
        // Validate Email
        registerFormState.emailError = Validation.validate(
            registerFormState.email,
            rules: [.required, .email]
        )
        
        // Validate Password
        registerFormState.passwordError = Validation.validate(
            registerFormState.password,
            rules: [.required, .minLength(6), .maxLength(20)]
        )
    }
    
    private func showValidationError() {
        let error: String?
        switch step {
        case 1:
            error = registerFormState.firstNameError ?? registerFormState.lastNameError
        case 2:
            error = registerFormState.emailError
        case 3:
            error = registerFormState.passwordError
        default:
            error = nil
        }
        
        if let error = error {
            alertMessage = error
            alertType = .error
            showAlert = true
        }
    }
    
    private func isCurrentStepValid() -> Bool {
        validateForm()
        
        switch step {
        case 1:
            return registerFormState.firstNameError == nil && registerFormState.lastNameError == nil
        case 2:
            return registerFormState.emailError == nil
        case 3:
            return registerFormState.passwordError == nil
        default:
            return true
        }
    }
    
    private func handleNextStep() {
        if isCurrentStepValid() {
            if step == 3 {
                Task {
                    await registerUser()
                }
            } else {
                withAnimation {
                    prevStep = step
                    step = min(step + 1, 4)
                }
            }
        } else {
            showValidationError()
        }
    }
    
    private func handlePrevStep() {
        withAnimation {
            prevStep = step
            step = max(step - 1, 1)
        }
    }
    
    private func registerUser() async {
        isLoading = true
        
        do {
            try await AuthViewModel.shared.register(
                withEmail: registerFormState.email,
                password: registerFormState.password,
                firstName: registerFormState.firstName,
                lastName: registerFormState.lastName
            )
            
            withAnimation {
                prevStep = step
                step = min(step + 1, 4)
            }
        } catch {
            alertMessage = error.localizedDescription
            alertType = .error
            showAlert = true
        }
        
        isLoading = false
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: step == 4 ? .center : .leading, spacing: 24) {
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
                    .disabled(isLoading)
                    .overlay {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Create New Account")
            .navigationBarBackButtonHidden(step == 1 ? false : true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if step > 1 && step < 4 {
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
        .alert(
            isPresented: $showAlert,
            alert: AlertView(
                title: alertType == .error ? "Error" : "Success",
                message: alertMessage,
                type: alertType,
                onDismiss: { showAlert = false }
            )
        )
    }

    // MARK: Step Views

    @ViewBuilder
    private func step1View() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("First Name")
                    .foregroundColor(.gray)
                TextField("First Name", text: $registerFormState.firstName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Last Name")
                    .foregroundColor(.gray)
                TextField("Last Name", text: $registerFormState.lastName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func step2View() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Your Email")
                    .foregroundColor(.gray)
                TextField("Your Email", text: $registerFormState.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func step3View() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                PasswordField(spacing: 8, password: $registerFormState.password)
            }
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
        }
        .padding(.top, 200)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                dismiss()
            }
        }
    }
}
