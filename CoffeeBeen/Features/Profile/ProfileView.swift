import PhotosUI
import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @EnvironmentObject var appState: AppState
    private let currentUser: User? = AuthViewModel.shared.currentUser

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {
                        Text("Coffee Beans")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Theme.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)

                        ZStack {
                            Circle()
                                .stroke(
                                    style: StrokeStyle(lineWidth: 3, dash: [8])
                                )
                                .foregroundColor(.green)
                                .frame(width: 100, height: 100)

                            if let image = viewModel.selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 90, height: 90)
                                    .clipShape(Circle())
                            } else {
                                AsyncImage(url: viewModel.currentImageUrl) {
                                    phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 90, height: 90)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 90, height: 90)
                                            .clipShape(Circle())
                                    case .failure:
                                        Image("onboarding-1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 90, height: 90)
                                            .clipShape(Circle())

                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }

                            Circle()
                                .fill(Color.black)
                                .frame(width: 36, height: 36)
                                .overlay(
                                    PhotosPicker(
                                        selection: $viewModel.photoItem,
                                        matching: .images,
                                        photoLibrary: .shared()
                                    ) {
                                        Image(systemName: "camera.fill")
                                            .foregroundColor(.white)
                                    }
                                )
                                .offset(y: 50)
                        }
                        .padding(.vertical, 16)

                        Text(
                            "\(currentUser?.firstName ?? "") \(currentUser?.lastName ?? "")"
                        )
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 8)
                        Text("Position goes here")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        VStack(spacing: 0) {
                            NavigationLink {
                                UpdateProfileView()
                            } label: {
                                ProfileRow(
                                    icon: "person.circle",
                                    title: "Account",
                                    subtitle: "Manage and protect your account"
                                )
                            }
                            ProfileRow(
                                icon: "bell",
                                title: "Notification",
                                subtitle: "Set your notifications"
                            )
                            ProfileRow(
                                icon: "creditcard",
                                title: "Payment",
                                subtitle: "Manage and protect your payment"
                            )
                            ProfileRow(
                                icon: "bookmark",
                                title: "Bookmark",
                                subtitle: "Set bookmark"
                            )
                            ProfileRow(
                                icon: "location.circle",
                                title: "Privacy and Policy",
                                subtitle: "Privacy and policy"
                            )
                        }
                        .padding(.top, 24)
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding(.horizontal, 8)
                    }
                    .background(Color(.systemGray6).ignoresSafeArea())
                }
                Spacer()
                Button("Sign Out") {
                    AuthViewModel.shared.signOut()
                    appState.signoutSuccess()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(.red)
                .foregroundColor(.white)
                .cornerRadius(14)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }.task {
            await viewModel.fetchCurrentUserImageUrl()
        }
    }
}
