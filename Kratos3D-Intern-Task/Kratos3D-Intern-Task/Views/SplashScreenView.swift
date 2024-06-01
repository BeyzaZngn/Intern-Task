import SwiftUI
import SDWebImageSwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise SplashScreen
    var body: some View {
        if isActive {
            HomeView()
        } else {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                AnimatedImage(name: "launch_gif.gif")
                    .frame(width: 300, height: 300)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
