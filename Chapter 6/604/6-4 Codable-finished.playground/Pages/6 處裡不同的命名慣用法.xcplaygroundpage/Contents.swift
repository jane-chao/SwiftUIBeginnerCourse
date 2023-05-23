//: ### 處裡不同的命名慣用法
/*:
    回傳資料範例：
     {
         "first_name": "Jane",
         "last_name": "Chao",
     }
*/
import Foundation

let jsonData = Data("""
{
 "first_name": "Jane",
 "last_name": "Chao",
}
""".utf8)

struct User: Codable {
    var firstName: String
    var lastName: String
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
let user = try! decoder.decode(User.self, from: jsonData)
print(user)

let encoder = JSONEncoder()
encoder.keyEncodingStrategy = .convertToSnakeCase
let data = try! encoder.encode(user)
let string = String(data: data, encoding: .utf8)!
print(string)


//: [Next](@next)
