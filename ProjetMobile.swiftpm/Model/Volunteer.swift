import SwiftUI

struct Volunteer: Codable, Identifiable{
    var id: String?
    var idFestival: Int
    var idUser: String
    var isVege: Bool
    var sizeTeeShirt: String
    var getTeeShirt: Bool
    var status: Status
    var festival: Festival
    var jeuxIdGame: String?
    
    private enum CodingKeys: String, CodingKey{
        case id, idFestival, idUser, isVege, sizeTeeShirt, getTeeShirt, status, festival, jeuxIdGame
    }
}

enum Status: String, Codable{
    case notAccepted
    case accepted
}
