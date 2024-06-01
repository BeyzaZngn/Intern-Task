import SwiftUI
import Firebase

// The HomeViewModel class manages user data and makes it observable
class HomeViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var isLoading: Bool = true

    init() {
        // Retrieves user data by calling the fetchUserData function
        fetchUserData()
    }

    func fetchUserData() {
        // Checks if there are currently logged in users
        guard let user = FirebaseManager.shared.auth.currentUser else {
            self.isLoading = false
            return
        }
        
        // Gets the document reference of the user logged in to Firestore
        let userRef = FirebaseManager.shared.firestore.collection("users").document(user.uid)
        
        // Fetches the document from Firestore
        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                self.firstName = data?["firstName"] as? String ?? ""
                self.lastName = data?["lastName"] as? String ?? ""
            } else {
                print("Document does not exist")
            }
            self.isLoading = false
        }
    }
    
    // Function to clear user data
    func clearUserData() {
        self.firstName = ""
        self.lastName = ""
        self.isLoading = true
    }
}

