import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Forgot Password")
                .font(.largeTitle)
                .foregroundColor(.yellow)
                .padding()
                
            Spacer()
            Spacer()
            
            TextField("Email Address",
                      text: $viewModel.email,
                      prompt: Text("Email Address")
                          .foregroundColor(.init(white: 0.5)))
                .foregroundColor(.white)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.field)
                .cornerRadius(10.0)
                .padding(.bottom, 10)
                
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
                
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .padding()
            }
                
            Button(action: {
                viewModel.sendPasswordReset()
            }) {
                Text("Send Reset Email")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .cornerRadius(10.0)
            }
            .padding()
                
            if viewModel.isPasswordResetEmailSent {
                Text("Password reset email sent!")
                    .foregroundColor(.green)
                    .padding()
            }
                
            Spacer()
        }
        .padding()
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ForgotPasswordView()
}
