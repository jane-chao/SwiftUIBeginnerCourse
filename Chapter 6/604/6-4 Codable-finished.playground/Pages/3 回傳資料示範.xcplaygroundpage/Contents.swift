//: 假設今天有個文件這樣寫..
/*:
    回傳資料範例：
     {
         "id": 13,
         "firstName": "Jane"
     }
*/
import Foundation

struct Response: Decodable {
    var firstName: String
}

let data = Data("""
{
"id": 13,
"firstName": "Jane"
}
""".utf8)

let response = try! JSONDecoder().decode(Response.self, from: data)
print(response)

//: [Next](@next)
