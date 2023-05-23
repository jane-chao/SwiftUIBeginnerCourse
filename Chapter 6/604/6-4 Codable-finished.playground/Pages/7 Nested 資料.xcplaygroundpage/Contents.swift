//: ### 更複雜的資料
/*:
    回傳資料範例：
     {
         "status": 200,
         "quota": 100,
         "response": [
                        {"id": 13, "firstName": "Jane", "lastName": "Chao"},
                        {"id": 1, "firstName": "Teddy", "lastName": "Lin"}
                     ]
     }
*/
import Foundation

let jsonData = Data("""
{
"status": 200,
"quota": 100,
"response":
[
{"id": 13, "firstName": "Jane", "lastName": "Chao"},
{"id": 1, "firstName": "Teddy", "lastName": "Lin"}
]
}
""".utf8)

struct Response<T: Decodable>: Decodable {
    var response: T
}

struct User: Decodable {
    var id: Int
    var name: String
    
    enum CodingKeys: CodingKey {
        case id, firstName, lastName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        
        let firstName = try container.decode(String.self, forKey: .firstName)
        let lastName  = try container.decode(String.self, forKey: .lastName)
        self.name = "\(firstName) \(lastName)"
    }
}

let response: Response<[User]> = try! JSONDecoder().decode(Response.self, from: jsonData)
let users = response.response

print(users)


//: [Next](@next)
