import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false 
    @State private var alertMessage = ""
    
    @AppStorage("loggedIn") var loggedIn: Bool = false
    
    
    func loginUser() {
        guard let url = URL(string: "https://montpellier-game-fest-volunteers-api-vincentdub2.vercel.app/login") else {
            alertMessage = "Invalid URL"
            showAlert = true
            return
        }
        
        let credentials = ["email": email, "password": password]
        guard let postData = try? JSONSerialization.data(withJSONObject: credentials) else {
            alertMessage = "Failed to encode credentials"
            showAlert = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                alertMessage = "Error: \(error.localizedDescription)"
                showAlert = true
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                alertMessage = "Invalid response from server"
                showAlert = true
                return
            }
            
            if (200..<300).contains(httpResponse.statusCode) {
                // Connexion réussie, vous pouvez rediriger l'utilisateur ou effectuer d'autres actions ici
                print("User successfully logged in")
                self.loggedIn = true
            } else {
                // Gérer les erreurs de connexion
                alertMessage = "Error: \(httpResponse.statusCode)"
                showAlert = true
            }
        }.resume()
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                //image
                Image("festival-du-jeu")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                // form fiels
                VStack(spacing: 24){
                    InputView(text: $email, title: "Email Adress", placeholder: "name@example.com")
                        .autocapitalization(.none)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // sign in button
                
                Button{
                    loginUser()
                } label: {
                    HStack{
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                // sign up button
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label : {
                    HStack(spacing: 3){
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

