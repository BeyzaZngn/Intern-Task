import SwiftUI

struct CreateAccountView: View {
    @ObservedObject var authModel: AuthModel
    @Binding var isPresented: Bool
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Create Account")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.yellow)
                
                TextField("Name",
                          text: $firstName,
                          prompt: Text("Name")
                              .foregroundColor(.init(white: 0.5)))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.field)
                    .cornerRadius(5.0)
                    .padding(.bottom, 10)
                
                TextField("Surname",
                          text: $lastName,
                          prompt: Text("Surname")
                              .foregroundColor(.init(white: 0.5)))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.field)
                    .cornerRadius(5.0)
                    .padding(.bottom, 10)
          
                TextField("Email Address",
                          text: $email,
                          prompt: Text("Email Address")
                              .foregroundColor(.init(white: 0.5)))
                    .foregroundColor(.white)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.field)
                    .cornerRadius(5.0)
                    .padding(.bottom, 10)
                
                SecureField("Password",
                            text: $password,
                            prompt: Text("Password")
                                .foregroundColor(.init(white: 0.5)))
                    .foregroundColor(.white)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.field)
                    .cornerRadius(5.0)
                    .padding(.bottom, 10)
                Spacer()
                
                Button(action: {
                    authModel.createNewAccount(email: email, password: password, firstName: firstName, lastName: lastName)
                }) {
                    Text("Create Account")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(5.0)
                }
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("Cancel")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(5.0)
                }
            }
            .padding(.vertical, 80)
        }
        .padding()
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    CreateAccountView(authModel: AuthModel(), isPresented: .constant(true))
}
