import SwiftUI

struct User: Codable, Identifiable{
    var id: String
    var lastName: String?
    var firstName: String
    var email: String
    var address: String?
    
    init(id: String, lastName: String?, firstName: String, email: String, address: String?){
        self.id = id
        self.lastName = lastName
        self.firstName = firstName
        self.email = email
        self.address = address
    }
    
    private enum CodingKeys: String, CodingKey{
        case id
        case lastName
        case firstName
        case email
        case address
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id && lhs.lastName == rhs.lastName && lhs.firstName == rhs.firstName && lhs.email == rhs.email && lhs.address == rhs.address
    }
}


