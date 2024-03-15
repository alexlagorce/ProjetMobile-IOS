import SwiftUI

struct User: Codable, Identifiable{
    var id: String
    var lastName: String?
    var firstName: String
    var email: String
    var adress: String?
    
    init(){
        self.id = ""
        self.lastName = ""
        self.firstName = ""
        self.email = ""
        self.adress = ""
    }
    
    private enum CodingKeys: String, CodingKey{
        case id
        case lastName
        case firstName
        case email
        case adress
    }
}


