import SwiftUI
import Firebase
import FirebaseAuth

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @StateObject var authModel = AuthModel()
    
    var email: String? {
        FirebaseManager.shared.auth.currentUser?.email
    }
    
    var body: some View {
        if authModel.isCurrentlyLoggedOut {
            LoginView(authModel: authModel)
        } else {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if homeViewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                    } else {
                        Spacer()
                        Text("\(homeViewModel.firstName) \(homeViewModel.lastName)")
                            .foregroundColor(.yellow)
                            .font(.largeTitle)
                        
                        Spacer()
                        
                        Button(action: {
                            authModel.handleSignOut()
                            // Reset User Data
                            homeViewModel.clearUserData()
                        }) {
                            Text("Logout")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow)
                                .cornerRadius(5.0)
                        }
                    }
                }
                .padding(.vertical, 80)
            }
            .padding()
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                // Get new user information.
                homeViewModel.fetchUserData()
            }
        }
    }
}

#Preview {
    HomeView()
}
