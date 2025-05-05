import SwiftUI

struct AlertView: View {
    let title: String
    let message: String
    let type: AlertType
    let onDismiss: () -> Void
    
    enum AlertType {
        case error
        case success
        case warning
        
        var color: Color {
            switch self {
            case .error:
                return .red
            case .success:
                return .green
            case .warning:
                return .orange
            }
        }
        
        var icon: String {
            switch self {
            case .error:
                return "xmark.circle.fill"
            case .success:
                return "checkmark.circle.fill"
            case .warning:
                return "exclamationmark.triangle.fill"
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: type.icon)
                .font(.system(size: 40))
                .foregroundColor(type.color)
            
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Button(action: onDismiss) {
                Text("OK")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(type.color)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 10)
        .padding()
    }
}

struct AlertViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    let alert: AlertView
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented = false
                    }
                
                alert
                    .transition(.scale.combined(with: .opacity))
                    .animation(.spring(), value: isPresented)
            }
        }
    }
}

extension View {
    func alert(isPresented: Binding<Bool>, alert: AlertView) -> some View {
        modifier(AlertViewModifier(isPresented: isPresented, alert: alert))
    }
} 