import SwiftUI

struct LoginView: View {
    @ObservedObject var authModel: AuthModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var showForgotPasswordView = false
    @State private var isSecured = true
    @State private var showCreateAccountView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Background")
                    .frame(width: 200, height: 300)
                
                VStack {
                    Image("Logo")
                        .resizable()
                        .frame(width: 300, height: 300)
                    Spacer()
                    VStack {
                        // Email Address TextField
                        emailAdressField
                        // Password TextField
                        passwordField
                        
                        // Remember Me and Forgot Password
                        HStack {
                            rememberMeSection
                            Spacer()
                            forgotPasswordSection
                        }
                        .padding(.horizontal, 10)
                        
                        // Login Now Button
                        loginNowButton
                            .padding(.vertical, 20)
                        
                        HStack {
                            // Create One Button
                            Text("Don't have an account?")
                                .foregroundColor(.gray.opacity(0.6))
                            createAccountButton
                        }
                        .padding(.bottom)
                    }
                }
            }
            .padding()
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .navigationDestination(isPresented: $showCreateAccountView) {
                CreateAccountView(authModel: authModel, isPresented: $showCreateAccountView)
            }
            .navigationDestination(isPresented: $showForgotPasswordView) {
                ForgotPasswordView()
            }
        }
    }
    
    struct CheckboxToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
                configuration.label
            }
        }
    }
}

extension LoginView {
    private var emailAdressField: some View {
        TextField("Email Address",
                  text: $email,
                  prompt: Text("Email Address")
                      .foregroundColor(.init(white: 0.5)))
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .foregroundColor(.white)
            .padding()
            .background(Color.field)
            .cornerRadius(10.0)
            .padding(.bottom, 20)
    }
    
    private var passwordField: some View {
        HStack {
            if isSecured {
                SecureField("Password",
                            text: $password,
                            prompt: Text("Password")
                                .foregroundColor(.init(white: 0.5)))
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    .padding()
                
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: "eye.slash")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
            } else {
                TextField("Password",
                          text: $password,
                          prompt: Text("Password")
                              .foregroundColor(.init(white: 0.5)))
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    .padding()
                
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: "eye")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
        }
        .background(Color.field)
        .cornerRadius(10.0)
        .padding(.bottom, 20)
        .frame(maxHeight: 60)
    }
    
    private var rememberMeSection: some View {
        Toggle(isOn: $rememberMe) {
            Text("Remember me")
                .foregroundColor(.gray.opacity(0.6))
        }
        .toggleStyle(CheckboxToggleStyle())
        .foregroundColor(.green)
    }
    
    private var forgotPasswordSection: some View {
        Button(action: {
            showForgotPasswordView = true
        }) {
            Text("Forgot password?")
                .foregroundColor(.yellow)
        }
    }
    
    private var loginNowButton: some View {
        Button(action: {
            authModel.loginUser(email: email, password: password)
        }) {
            Text("Login Now")
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.yellow)
                .cornerRadius(5.0)
        }
    }
    
    private var createAccountButton: some View {
        Button(action: {
            showCreateAccountView = true
        }) {
            Text("Create one")
                .foregroundColor(.yellow)
        }
    }
}

#Preview {
    LoginView(authModel: AuthModel())
}
