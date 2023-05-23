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
    var id: Int // 可能是任何，不過文件上通常會寫得更清楚
    var firstName: String
}

let jsonData = Data("""
{
"id": 13,
"firstName": "Jane"
}
""".utf8)

let response = try! JSONDecoder().decode(Response.self, from: jsonData)
print(response)


//: [Next](@next)
