import SwiftUI

struct LoggedInView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            TabView {
                MyFestivalsView()
                    .tabItem {
                        Label("Mes festivals", systemImage: "list.bullet.circle")
                    }
                DashboardView()
                    .tabItem {
                        Label("S'inscrire", systemImage: "square.and.pencil")
                    }
                ProfileView()
                    .tabItem {
                        Label("Mon profil", systemImage: "person")
                    }
            }
            .navigationBarItems(trailing: Button(action: {
                // Action à exécuter lorsqu'un bouton est appuyé
                isLoggedIn = false // Déconnexion en définissant isLoggedIn sur false
            }) {
                Text("Logout")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            })
        }
    }
}
