import SwiftUI

struct Creneau: Codable, Identifiable {
    var id: Int
    var timeStart: Date
    var timeEnd: Date
    var idFestival: Int
    var creneauEspace: [CreneauEspace] 
    
    private enum CodingKeys: String, CodingKey {
        case id = "idCreneau", timeStart, timeEnd, idFestival, creneauEspace
    }
}

struct CreneauEspace: Codable {
    var idCreneauEspace: Int
    var idCreneau: Int
    var idEspace: Int
    var currentCapacity: Int
    var capacityEspaceAnimationJeux: Int
    
    // CodingKeys si nécessaire
}

