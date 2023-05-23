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


//: [Next](@next)
