import SwiftUI

struct RegistrationFestivalView: View {
    var festival: Festival
    @State private var tShirtSize = ""
    @State private var isVegetarian = false
    
    var body: some View {
        VStack {
            // Afficher les détails du festival
            Text("Inscription pour \(festival.name)")
                .font(.title)
                .padding()
            
            // Champ de saisie pour la taille du t-shirt
            TextField("Taille du t-shirt", text: $tShirtSize)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Toggle pour l'option végétarienne
            Toggle("Végétarien", isOn: $isVegetarian)
                .padding()
            
            // Bouton pour soumettre le formulaire d'inscription
            Button("S'inscrire") {
                // Ajouter la logique pour soumettre le formulaire
                submitRegistration()
            }
            .padding()
            
            Spacer() 
        }
        .padding()
    }
    
    func submitRegistration() {
        // Ajouter la logique pour soumettre les données d'inscription
        // Par exemple, vous pouvez envoyer les données au serveur ici
        print("Inscription soumise pour \(festival.name)")
        print("Taille du t-shirt: \(tShirtSize)")
        print("Végétarien: \(isVegetarian)")
    }
}
