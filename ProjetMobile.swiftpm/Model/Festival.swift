import SwiftUI

struct Festival: Codable, Identifiable{
    var id: Int 
    var name: String
    var address: String
    var city: String
    var postalCode: String
    var country: String
    var isActive: Bool
    var dateDebut: Date
    var dateFin : Date
    
    private enum CodingKeys: String, CodingKey {
        case id = "idFestival", name, address, city, postalCode, country, isActive, dateDebut, dateFin
    }
}
