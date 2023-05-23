//: ### 用 RawValue 宣告不同名稱
import Foundation

let jsonData = Data("""
{
"id": 13,
"firstName": "Jane"
}
""".utf8)


struct User {
    var id: Int
    var name: String
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name = "firstName"
    }
}

let user = try! JSONDecoder().decode(User.self, from: jsonData)
print(user)

let data = try! JSONEncoder().encode(user)
let string = String(data: data, encoding: .utf8)!
print(string)

//: [Next](@next)
