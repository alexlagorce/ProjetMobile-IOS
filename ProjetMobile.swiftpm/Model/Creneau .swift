import SwiftUI

import Foundation

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

struct CreneauxByDay {
    let day: Date
    let creneaux: [Creneau]
}

func groupCreneauxByDay(creneaux: [Creneau]) -> [CreneauxByDay] {
    let groupedCreneaux = Dictionary(grouping: creneaux) { creneau in
        Calendar.current.startOfDay(for: creneau.timeStart)
    }
    return groupedCreneaux.map { key, value in
        CreneauxByDay(day: key, creneaux: value)
    }
}

struct CreneauEspace: Codable {
    var idCreneauEspace: Int
    var idCreneau: Int
    var idEspace: Int
    var currentCapacity: Int
    var capacityEspaceAnimationJeux: Int
    var espace: Espace 
    
    // CodingKeys si nécessaire
}

struct Espace: Codable{
    var idEspace: Int
    var name: String
    var posteEspaces: [PosteEspace]
}

struct PosteEspace: Codable{
    var idPoste: Int
    var idEspace: Int
}

//pas utilisé encore 
struct Inscription: Codable{
    var idUser: Int
    var idCreneauEspace: Int
    var isAccepted: Bool
    var isFlexible: Bool
}

struct IsReferent: Codable{
    var idUser: Int
    var idEspace: Int
    var jeuxIdGame: Int
}
