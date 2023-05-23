//: ### 編碼與解碼
import Foundation

struct User {
    var name: String
    var age: Int
}

let user = User(name: "Jane", age: 5)

extension User: Encodable {
    
}

extension User: Decodable {
    
}

let data = try! JSONEncoder().encode(user)
let user2 = try! JSONDecoder().decode(User.self, from: data)
print(user2)


//: [Next](@next)
