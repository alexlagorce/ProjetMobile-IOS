import SwiftUI

struct RegistrationFestivalView: View {
    var festival: Festival
    
    // Variables de liaison pour les informations personnelles
    @State private var tshirtSize = ""
    @State private var isVegetarian = false
    
    // Variables de liaison pour les choix de poste
    // Ajoutez ici les variables pour les choix de poste
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Inscription pour \(festival.name)")
                .font(.title)
                .padding(.bottom, 10)
            
            // Section des informations personnelles
            VStack(alignment: .leading) {
                Text("Informations personnelles")
                    .font(.headline)
                
                // Ajoutez ici les champs pour les informations personnelles
                TextField("Taille T-shirt", text: $tshirtSize)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
                
                Toggle("Végétarien", isOn: $isVegetarian)
            }
            .padding(.bottom, 20)
            
            // Section des choix de poste
            VStack(alignment: .leading) {
                Text("Choix des postes")
                    .font(.headline)
                
                // Ajoutez ici les choix de poste
            }
            
            Spacer()
            
            // Bouton de soumission
            Button(action: submitRegistration) {
                Text("S'inscrire")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.bottom)
        }
        .padding()
    }
    
    // Fonction pour soumettre le formulaire d'inscription
    func submitRegistration() {
        // Ajouter la logique pour soumettre les données d'inscription
        // Par exemple, vous pouvez envoyer les données au serveur ici
        print("Inscription soumise pour \(festival.name)")
        print("Taille du t-shirt: \(tshirtSize)")
        print("Végétarien: \(isVegetarian)")
    }
}
    


