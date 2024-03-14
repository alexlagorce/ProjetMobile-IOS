import SwiftUI

struct RegisterRequest: Codable {
    var lastName: String
    var firstName: String
    var address: String
    var email: String
    var password: String
}

struct RegistrationView: View {
    @State private var email = ""
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var adress = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showingSuccessAlert = false
    @State private var alertMessage = ""
    @Environment(\.dismiss) var dismiss
    
    func registerUser() {
        guard let url = URL(string: "https://montpellier-game-fest-volunteers-api-vincentdub2.vercel.app/register") else { return }
        
        // Création de l'objet RegisterRequest avec les nouvelles données
        let request = RegisterRequest(lastName: lastName, firstName: firstName, address: adress, email: email, password: password)
        
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "POST"
        requestUrl.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Encodage de l'objet RegisterRequest en JSON
            requestUrl.httpBody = try JSONEncoder().encode(request)
        } catch let error {
            print("Failed to encode request, \(error.localizedDescription)")
            return
        }
        
        // Envoi de la requête à l'API
        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            if let error = error {
                print("Error during session: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) else {
                print("Error with the response, unexpected status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                return
            }
            
            DispatchQueue.main.async {
                print("User successfully registered")
                self.alertMessage = "User successfully registered"
                self.showingSuccessAlert = true
                dismiss()
            }
        }.resume()
    }
    
    var body: some View {
        VStack{
            //image
            Image("rock-n-solex")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            // form fiels
            VStack(spacing: 20){
                InputView(text: $email, title: "Email Adress", placeholder: "name@example.com")
                    .autocapitalization(.none)
                
                InputView(text: $firstName, title: "First Name", placeholder: "Enter your first name")
                
                InputView(text: $lastName, title: "Last Name", placeholder: "Enter your last name")
                
                InputView(text: $adress, title: "Address", placeholder: "Enter your address")
                
                InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                
                InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 0)
            
            // sign in button
            
            Button{
                registerUser()
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
            .padding(.top, 2)
            
            Spacer()
            
            Button{
                dismiss()
            } label: {
                HStack(spacing: 3){
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
                .padding(.bottom, 7)
            }
        }
        .alert(isPresented: $showingSuccessAlert) {
            Alert(title: Text("Registration Successful"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                dismiss()
            })
        }
        
    }
}
