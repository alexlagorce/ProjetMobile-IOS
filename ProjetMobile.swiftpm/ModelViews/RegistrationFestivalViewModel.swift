import SwiftUI

class RegistrationViewModel: ObservableObject {
    
    func submitRegistration(userID: String, festivalID: String, tshirtSize: String, isVegetarian: Bool) {
        
        // Soumettre les données d'inscription
        let registrationData = RegistrationData(userID: userID, festivalID: festivalID, tshirtSize: tshirtSize, isVegetarian: isVegetarian)
        
        // Appeler la fonction pour soumettre les données d'inscription
        submitRegistrationData(registrationData)
    }
    
    func submitRegistrationData(_ registrationData: RegistrationData) {
        guard let url = URL(string: "https://montpellier-game-fest-volunteers-api-vincentdub2.vercel.app/festivals/\(registrationData.festivalID)/volunteers") else {
            print("URL invalide")
            return
        }
        
        // Créer le corps de la requête
        let requestBody: [String: Any] = [
            "idUser": registrationData.userID,
            "isVege": registrationData.isVegetarian,
            "sizeTeeShirt": registrationData.tshirtSize,
            "idFestival": registrationData.festivalID
        ]
        
        // Convertir le corps de la requête en données JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            print("Échec de l'encodage des données JSON")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Réponse HTTP invalide")
                return
            }
            
            if (200..<300).contains(httpResponse.statusCode) {
                print("Inscription réussie pour \(registrationData.festivalID)")
                // Traiter la réponse si nécessaire
            } else {
                print("Échec de l'inscription. Code d'état HTTP: \(httpResponse.statusCode)")
                // Gérer les erreurs de l'API si nécessaire
            }
        }.resume()
    }
}

