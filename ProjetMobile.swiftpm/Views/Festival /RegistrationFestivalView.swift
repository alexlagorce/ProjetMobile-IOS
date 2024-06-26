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
    
    func onTapGestureAction(idCreneauEspace: Int, 
                            idCreneau: Int, 
                            idEspace: Int, 
                            newCapacity: Int, 
                            capacityEspaceAnimationJeux: Int, 
                            espace: Espace) -> (Int, Int, Int, Int, Int, Espace) {
        creneauViewModel.updateCreneauEspaceCapacity(idCreneauEspace: idCreneauEspace, 
                                                     newCapacity: newCapacity,
                                                     idCreneau: idCreneau,
                                                     idEspace: idEspace,
                                                     capacityEspaceAnimationJeux: capacityEspaceAnimationJeux,
                                                     espace: espace)
        // Return the updated values
        return (idCreneauEspace, idCreneau, idEspace, newCapacity, capacityEspaceAnimationJeux, espace)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            Text("Inscription pour \(festival.name)")
                .padding(.top, 10)
                .font(.title)
                .padding(.bottom, 10)
                .bold()
            VStack(alignment: .leading) {
                // Informations personnelles
                VStack(alignment: .leading) {
                    Text("Informations personnelles :")
                        .font(.title)
                        .font(.headline)
                        .foregroundColor(.gray)
                        .bold()
                    
                    TextField("Taille T-shirt", text: $tshirtSize)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                    
                    Toggle("Végétarien", isOn: $isVegetarian)
                }
                .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("Choix des postes et des créneaux :")
                        .font(.title)
                        .font(.headline)
                        .padding(.bottom, 20)
                        .foregroundColor(.gray)
                        .bold()
                    
                    if let postes = posteViewModel.postes {
                        if let creneaux = creneauViewModel.creneaux, !creneaux.isEmpty {
                            let creneauxByDay = groupCreneauxByDay(creneaux: creneaux)
                            // Utiliser creneauxByDay dans votre vue
                            ForEach(creneauxByDay, id: \.day) { creneauxDay in
                                VStack(alignment: .leading) {
                                    // En-tête du jour
                                    Text("\(creneauxDay.day, formatter: DateFormatter.dayAndDateFormatter)")
                                        .font(.headline)
                                        .padding(.bottom, 10)
                                        .foregroundColor(.blue)
                                    
                                    // Grille pour les postes et les créneaux de la journée
                                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: creneauxDay.creneaux.count + 1), alignment: .leading, spacing: 20) {
                                        // En-têtes des colonnes
                                        Text("Poste:")
                                            .font(.headline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        ForEach(creneauxDay.creneaux) { creneau in
                                            Text("\(formattedTime(creneau.timeStart)) - \(formattedTime(creneau.timeEnd))")
                                                .font(.subheadline)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                    .padding(.bottom, 10)
                                    
                                    Divider() // Ligne entre les jours
                                    
                                    ForEach(postes.indices) { index in
                                        let poste = postes[index]
                                        VStack(alignment: .leading) {
                                            Text(poste.name)
                                                .font(.headline)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.bottom, 5)
                                            
                                            HStack(spacing: 30) {
                                                Spacer().padding(.leading, 20)
                                                ForEach(creneauxDay.creneaux) { creneau in
                                                    if let creneauEspace = creneau.creneauEspace.first(where: { $0.idCreneau == creneau.id && $0.espace.name == poste.name }) {
                                                        CapaciteView(capacite: creneauEspace.currentCapacity, capacityPoste: poste.capacityPoste)
                                                            .onTapGesture {
                                                                let (idCreneauEspace, idCreneau, idEspace, currentCapacity, capacityEspaceAnimationJeux, espace) = onTapGestureAction(idCreneauEspace: creneauEspace.idCreneauEspace, 
                                                                                                                                                                                      idCreneau: creneau.id, 
                                                                                                                                                                                      idEspace: creneauEspace.idEspace, 
                                                                                                                                                                                      newCapacity: creneauEspace.currentCapacity + 1, 
                                                                                                                                                                                      capacityEspaceAnimationJeux: creneauEspace.capacityEspaceAnimationJeux, 
                                                                                                                                                                                      espace: creneauEspace.espace)
                                                                    
                                                                // Utiliser les valeurs renvoyées si nécessaire
                                                            }
                                                    } else {
                                                        Text("-")
                                                            .font(.subheadline)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                    }
                                                }
                                            }
                                        }
                                        .padding(.bottom, 10)
                                        Divider() // Ligne entre les postes
                                    }
                                }
                                .padding(.bottom, 20)
                            }
                        } else {
                            ProgressView()
                        }
                    } else {
                        ProgressView()
                    }
                }
                
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
}

struct RegistrationData {
    var userID: String
    var festivalID: String
    var tshirtSize: String
    var isVegetarian: Bool
}

private func formattedTime(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    return formatter.string(from: date)
}

extension DateFormatter {
    static let dayAndDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd MMMM" // "EEEE" pour le jour de la semaine complet, "dd" pour le jour du mois, "MMMM" pour le mois complet
        return formatter
    }()
}

struct CapaciteView: View {
    var capacite: Int
    var capacityPoste: Int
    
    var body: some View {
        let capacityPercentage = Double(capacite) / Double(capacityPoste) * 100.0
        let displayText = "\(capacite) / \(capacityPoste)"
        
        return Text(displayText)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 2)
            .foregroundColor(capacityPercentage >= 80.0 ? .red : .green) // Change la couleur en rouge si la capacité est >= 80%
    }
}
