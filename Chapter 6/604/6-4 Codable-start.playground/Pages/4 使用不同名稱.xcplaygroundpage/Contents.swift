//: ### 使用不同屬性名稱
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

extension User: Decodable { }

let user = try! JSONDecoder().decode(User.self, from: jsonData)
print(user)

//: [Next](@next)
