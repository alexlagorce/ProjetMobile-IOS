import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel = FestivalViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.festivals) { festival in
                VStack(alignment: .leading) {
                    Text(festival.name)
                        .font(.headline)
                    Text("Date: \(formattedDate(festival.dateDebut)) - \(formattedDate(festival.dateFin))")
                        .font(.subheadline)
                }
            }
            .navigationTitle("Dashboard")
            .onAppear {
                viewModel.fetchFestivals()
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
