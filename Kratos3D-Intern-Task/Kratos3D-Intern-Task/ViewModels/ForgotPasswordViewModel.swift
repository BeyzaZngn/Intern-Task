import SwiftUI
import Firebase

// The ForgotPasswordViewModel class manages password reset operations
class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isPasswordResetEmailSent: Bool = false

    // Function to send password reset email
    func sendPasswordReset() {
        // Checks if the email field is empty
        guard !email.isEmpty else {
            self.errorMessage = "Please enter your email."
            return
        }
        
        // Sets the loading status and error message when starting the password reset process
        self.isLoading = true
        self.errorMessage = nil

        // Sends password reset email via Firebase
        FirebaseManager.shared.auth.sendPasswordReset(withEmail: email) { error in
            self.isLoading = false  // When the operation is complete, the load status is false
            if let error = error {
                self.errorMessage = error.localizedDescription  // If there is an error, the error message is set
            } else {
                self.isPasswordResetEmailSent = true  // If the operation was successful, the password reset email sent information is set
            }
        }
    }
}
