import Foundation
import Firebase
import FirebaseStorage

// AuthModel class manages user authentication processes
class AuthModel: ObservableObject {
    @Published var isCurrentlyLoggedOut = false
    
    init() {
        // Checks if the user is currently logged in
        isCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
    }
    
    // Login function with e-mail and password
    func loginUser(email: String, password: String) {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login user \(error)")
                return
            }
            
            self.isCurrentlyLoggedOut = false
            print("Successfully logged in as user: \(result!.user.uid)")
        }
    }
    
    // Function to create a new user
    func createNewAccount(email: String, password: String, firstName: String, lastName: String) {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { [self] result, error in
            if let error = error {
                print("Failed to create user \(error)")
                return
            }
            
            print("Successfully created user \(result!.user.uid)")
            self.loginUser(email: email, password: password)
            self.storeUserInformation(email: email, firstName: firstName, lastName: lastName)
        }
    }
    
    // Function to store user information in Firestore database
    func storeUserInformation(email: String, firstName: String, lastName: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": email, "uid": uid, "firstName": firstName, "lastName": lastName]
        
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .setData(userData)
    }
    
    // User logout function
    func handleSignOut() {
        isCurrentlyLoggedOut = true   // Updates the user's session status
        try? FirebaseManager.shared.auth.signOut()   // Exits via Firebase
    }
}
