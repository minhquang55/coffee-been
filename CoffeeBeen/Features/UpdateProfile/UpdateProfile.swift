import SwiftUI

struct UpdateProfileView: View {
    @StateObject private var viewModel = UpdateProfileViewModel()
    @Environment(\.dismiss) private var dismiss

    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ScrollView {
                VStack(spacing: 12) {
                    InputField(
                        title: "Email",
                        text: $viewModel.email,
                        icon: "envelope"
                    )
                    InputField(
                        title: "First Name",
                        text: $viewModel.firstName,
                        icon: "person"
                    )
                    InputField(
                        title: "Last Name",
                        text: $viewModel.lastName,
                        icon: "person"
                    )
                    InputField(
                        title: "Address",
                        text: $viewModel.address,
                        icon: "house"
                    )
                    InputField(
                        title: "Phone Number",
                        text: $viewModel.phoneNumber,
                        icon: "phone"
                    )
                }
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
            }

            Spacer()

            Button(action: {
                Task {
                    let success = await viewModel.updateProfile()
                    if success {
                        toastMessage = "Profile updated successfully!"
                        withAnimation {
                            showToast = true
                        }
                        try? await Task.sleep(nanoseconds: 1_000_000_000)
                        withAnimation {
                            showToast = false
                        }
                        try? await Task.sleep(nanoseconds: 500_000_000)
                        dismiss()
                    }
                }
            }) {
                Text("Save Changes")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Theme.primary)
                    .cornerRadius(12)
                    .disabled(viewModel.isUpdating)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .navigationTitle("Edit Profile")
        .overlay(
            Group {
                if showToast {
                    ToastView(message: toastMessage)
                        .transition(
                            .asymmetric(
                                insertion: .opacity,
                                removal: .move(edge: .trailing).combined(with: .opacity)
                            )
                        )
                        .padding(.trailing, 16)
                }
            },
            alignment: .topTrailing
        )
    }
}

struct InputField: View {
    var title: String
    var text: Binding<String>
    var icon: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 24, height: 24)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField(title, text: text)
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(12)
    }
}

struct ToastView: View {
    var message: String

    var body: some View {
        Text(message)
            .font(.subheadline)
            .foregroundColor(.white)
            .padding()
            .background(Theme.primary)
            .cornerRadius(12)
            .padding(.top, 30)
    }
}
