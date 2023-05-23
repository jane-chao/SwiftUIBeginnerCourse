//: ### My Syntax Sugar（非必要）
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id       = try container[.id]
        
        let lastName: String  = try container[.lastName]
        let firstName: String = try container[.firstName]
        self.name = "\(firstName) \(lastName)"
        
        var friendContainer = try container.nestedUnkeyedContainer(forKey: .friends)
        
        self.friendID = try friendContainer.map {
            try $0.container()["id"]
        }
    }
}

struct Response: Decodable {
    let response: User
}

struct DecodingKey: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    
    init?(intValue: Int) {
        return nil
    }
}

extension DecodingKey: ExpressibleByStringLiteral {
    init(stringLiteral value: StringLiteralType) {
        self.stringValue = value
    }
}



extension KeyedDecodingContainerProtocol {
    subscript<T: Decodable>(_ key: Key) -> T {
        get throws {
            try self.decode(T.self, forKey: key)
        }
    }
}

extension UnkeyedDecodingContainer {
    mutating func map<T>(_ transform: (Decoder) throws -> T) throws -> [T] {
        var items = [T]()
        while !self.isAtEnd {
            let item = try transform(superDecoder())
            items.append(item)
        }
        
        return items
    }
}

extension Decoder {
    func container() throws -> KeyedDecodingContainer<DecodingKey> {
        try self.container(keyedBy: DecodingKey.self)
    }
}



let user = (try! JSONDecoder().decode(Response.self, from: jsonData)).response
print(user)
