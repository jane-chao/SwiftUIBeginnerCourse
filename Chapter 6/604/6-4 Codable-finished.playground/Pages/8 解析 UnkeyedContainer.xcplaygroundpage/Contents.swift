//: ### UnkeyedContainer
/*:
    回傳資料範例：
     {
         "status": 200,
         "quota": 100,
         "response": {
                         "id": 13, "firstName": "Jane", "lastName": "Chao",
                         "friends":[
                                     {"id": 1},
                                     {"id": 8}
                                   ]
                     }
     }
*/
import Foundation

let jsonData = Data("""
{
"status": 200,
"quota": 100,
"response": {
"id": 13, "firstName": "Jane", "lastName": "Chao",
"friends":[
            {"id": 1},
            {"id": 8}
          ]
}
}
""".utf8)

struct User {
    var id: Int
    var name: String
    var friendID: [Int]
}

extension User: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case firstName
        case lastName
        case friends
        
    }
    
    enum FriendIDContainerCodingKeys: CodingKey {
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        
        let lastName  = try container.decode(String.self, forKey: .lastName)
        let firstName = try container.decode(String.self, forKey: .firstName)
        self.name = "\(firstName) \(lastName)"
        
        var friendContainer = try container.nestedUnkeyedContainer(forKey: .friends)
        
        var ids = [Int]()
        while !friendContainer.isAtEnd {
            let friendIDContainer = try friendContainer.nestedContainer(keyedBy: FriendIDContainerCodingKeys.self)
            ids.append(try friendIDContainer.decode(Int.self, forKey: .id))
        }
        self.friendID = ids
    }
}


struct Response: Decodable {
    let response: User
}

let user = (try! JSONDecoder().decode(Response.self, from: jsonData)).response
print(user)

//: [Next](@next)
