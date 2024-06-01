import Firebase
import FirebaseStorage
import FirebaseDatabase

// Create a class to manage Firebase operations
class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    let database: Database
    
    static let shared = FirebaseManager()
    
    // Class initialiser - runs when the class instance is created
    override init() {
        FirebaseApp.configure()
        
        // Starting Firebase components
        auth = Auth.auth()
        storage = Storage.storage()
        firestore = Firestore.firestore()
        database = Database.database()
        
        // Call the initialiser of the superclass (NSObject)
        super.init()
    }
}
