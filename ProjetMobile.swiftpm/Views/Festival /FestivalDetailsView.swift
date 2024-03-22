import SwiftUI

struct FestivalDetailsView: View {
    var festival: Festival
    
    var body: some View {
        VStack {
            Text("Détails du Festival")
                .padding(.top, 10)
                .font(.title)
                .padding(.bottom, 10)
                .bold()
            
            Text("Nom du Festival: \(festival.name)")
                .padding(.bottom, 10)
            Text("Adresse: \(festival.address)")
                .padding(.bottom, 10)
            Text("Ville: \(festival.city)")
                .padding(.bottom, 10)
            Text("Date de Début: \(formattedDate(date: festival.dateDebut))")
                .padding(.bottom, 10)
            Text("Date de Fin: \(formattedDate(date: festival.dateFin))")
                .padding(.bottom, 10)
            
            Spacer()
        }
        .padding()
    }
    
    // Fonction pour formater la date
    private func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}


