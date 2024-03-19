import SwiftUI

struct RegistrationFestivalView: View {
    var festival: Festival
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var registrationViewModel: RegistrationViewModel
    
    @State private var tshirtSize = ""
    @State private var isVegetarian = false
    @State private var registrationSuccess = false // État pour contrôler l'affichage du message de succès
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Inscription pour \(festival.name)")
                .font(.title)
                .padding(.bottom, 10)
            
            // Informations personnelles
            VStack(alignment: .leading) {
                Text("Informations personnelles")
                    .font(.headline)
                
                TextField("Taille T-shirt", text: $tshirtSize)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
                
                Toggle("Végétarien", isOn: $isVegetarian)
            }
            .padding(.bottom, 20)
            
            Spacer()
            
            // Bouton de soumission
            Button(action: {
                guard let currentUserID = userViewModel.user?.id else {
                    // Gérer le cas où l'ID de l'utilisateur actuel n'est pas disponible
                    print("ID utilisateur non trouvé")
                    return
                }
                
                registrationViewModel.submitRegistration(userID: currentUserID, festivalID: String(festival.id), tshirtSize: tshirtSize, isVegetarian: isVegetarian)
                
                // Mettre à jour l'état registrationSuccess pour afficher le message de succès
                registrationSuccess = true
            }) {
                Text("Inscription")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.bottom)
            
            // Afficher le message de succès si registrationSuccess est vrai
            if registrationSuccess {
                Text("Inscription réussie au festival \(festival.name) !")
                    .foregroundColor(.green)
                    .padding(.bottom)
            }
        }
        .padding()
        .onAppear {
            // Récupérer les informations de l'utilisateur actuel
            userViewModel.fetchCurrentUser()
        }
    }
}

struct RegistrationData {
    var userID: String
    var festivalID: String
    var tshirtSize: String
    var isVegetarian: Bool
}


