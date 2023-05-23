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

extension User: Decodable {
    enum CodingKeys: CodingKey {
        case id, firstName
    }
    
    
    init(from decoder: Decoder) throws {
        // 1. 建立一個 Container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // 2. 透過 CodingKey 從 Container 拿到對應的資料。
        // 3. 把資料放進屬性，啟動類型
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .firstName)
    }
}

extension User: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .firstName)
    }
}

let user = try! JSONDecoder().decode(User.self, from: jsonData)
print(user)

let data = try! JSONEncoder().encode(user)
let string = String(data: data, encoding: .utf8)
print(string)

//: [Next](@next)
