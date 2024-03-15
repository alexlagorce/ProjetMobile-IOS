import SwiftUI

struct LoggedInView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            TabView {
                DashboardView()
                    .tabItem {
                        Label("Dashboard", systemImage: "square.grid.2x2")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
            .navigationBarTitle("Acceuil", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                // Action à exécuter lorsqu'un bouton est appuyé
                isLoggedIn = false // Déconnexion en définissant isLoggedIn sur false
            }) {
                Text("Logout")
                    .fontWeight(.bold)
            })
        }
    }
}
