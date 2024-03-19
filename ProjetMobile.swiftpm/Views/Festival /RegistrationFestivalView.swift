import SwiftUI

struct RegistrationFestivalView: View {
    var festival: Festival
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var registrationViewModel: RegistrationViewModel
    @ObservedObject var posteViewModel = PosteViewModel()
    @ObservedObject var creneauViewModel = CreneauViewModel()
    
    @State private var tshirtSize = ""
    @State private var isVegetarian = false
    @State private var registrationSuccess = false 
    
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
            
            VStack(alignment: .leading) {
                Text("Choix des postes")
                    .font(.headline)
                
                if let postes = posteViewModel.postes {
                    ForEach(postes) { poste in
                        VStack(alignment: .leading) {
                            Text(poste.name)
                                .font(.headline)
                            
                            Text(poste.description)
                                .font(.subheadline)
                            
                            Text("Capacité: \(poste.capacityPoste)")
                                .font(.subheadline)
                        }
                        .padding(.vertical, 8)
                    }
                } else {
                    ProgressView()
                }
            }
            .padding(.bottom, 20)
            
            // Section des créneaux
            VStack(alignment: .leading) {
                Text("Choix des créneaux")
                    .font(.headline)
                
                if let creneaux = creneauViewModel.creneaux {
                    ForEach(creneaux) { creneau in
                        VStack(alignment: .leading) {
                            Text("Début: \(creneau.timeStart)")
                                .font(.subheadline)
                            
                            Text("Fin: \(creneau.timeEnd)")
                                .font(.subheadline)
                        }
                        .padding(.vertical, 8)
                    }
                } else {
                    ProgressView()
                }
            }
            .padding(.bottom, 20)
            
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
                Text("S'inscrire")
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
            posteViewModel.fetchPostes(for: festival.id)
            creneauViewModel.fetchCreneaux(for: festival.id)
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


