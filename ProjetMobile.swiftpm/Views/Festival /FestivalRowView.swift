import SwiftUI

struct FestivalRowView: View {
    var festival: Festival
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(festival.name)
                .font(.headline)
            Text("Date: \(formattedDate(festival.dateDebut)) - \(formattedDate(festival.dateFin))")
                .font(.subheadline)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

