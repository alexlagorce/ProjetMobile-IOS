import SwiftUI

struct ProfileView: View {
    @ObservedObject var userViewModel = UserViewModel()
    
    var body: some View {
        VStack {
            if let user = userViewModel.user {
                Text("Mon profil")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .foregroundColor(.gray)
                
                ProfileItemView(title: "Nom", value: user.lastName ?? "")
                ProfileItemView(title: "Prénom", value: user.firstName)
                ProfileItemView(title: "Email", value: user.email)
                ProfileItemView(title: "Adresse", value: user.address ?? "")
                
                Spacer()
                
                NavigationLink(destination: ModifyProfileView()) {
                    Text("Modifier")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.vertical, 20)
            } else {
                ProgressView("Chargement en cours...")
            }
        }
        .padding()
        .onAppear {
            userViewModel.fetchCurrentUser()
        }
    }
}

struct ProfileItemView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .foregroundColor(.gray)
                .font(.headline)
            
            Text(value)
                .foregroundColor(.white)
                .font(.body)
            
            Divider()
        }
        .padding(.vertical, 8)
    }
}

struct ModifyProfileView: View {
    @ObservedObject var userViewModel = UserViewModel()
    @State private var lastName: String = ""
    @State private var firstName: String = ""
    @State private var email: String = ""
    @State private var address: String = ""
    @State private var successMessage = ""
    
    var body: some View {
        VStack {
            Text("Modifie ton profil :")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("Nom", text: $lastName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Prénom", text: $firstName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Adresse", text: $address)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
            
            Button(action: {
                guard let currentUserId = userViewModel.user?.id else {
                    // Gérer le cas où l'ID de l'utilisateur actuel n'est pas disponible
                    return
                }
                
                // Créer un nouvel utilisateur avec l'ID de l'utilisateur actuel et les champs modifiés
                let updatedUser = User(id: currentUserId, lastName: lastName, firstName: firstName, email: email, address: address)
                // Appeler la fonction updateUser du viewModel
                userViewModel.updateUser(updatedUser)
                
                // Mettre à jour le message de succès
                successMessage = "Les modifications ont été enregistrées avec succès !"
            }) {
                Text("Enregistrer")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.vertical, 20)
            
            // Afficher le message de succès
            Text(successMessage)
                .foregroundColor(.green)
                .padding()
        }
        .padding()
        .onAppear {
            userViewModel.fetchCurrentUser()
        }
        .onChange(of: userViewModel.user) { user in
            // Assigner les valeurs actuelles de l'utilisateur aux champs lorsque l'utilisateur change
            if let user = user {
                lastName = user.lastName ?? ""
                firstName = user.firstName
                email = user.email
                address = user.address ?? ""
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


