import SwiftUI

struct Poste: Codable, Identifiable, Equatable {
    var id: Int
    var name: String
    var description: String
    var capacityPoste: Int
    var idFestival: Int
    
    static func == (lhs: Poste, rhs: Poste) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.description == rhs.description
        && lhs.capacityPoste == rhs.capacityPoste
        && lhs.idFestival == rhs.idFestival
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "idPoste", name, description, capacityPoste, idFestival
    }
}
