/*:
## SwiftUI 6-4：Codable

> 之前已經介紹過自動產生的 Codable，今天會再介紹到一些比較複雜的，需要自己處理的情況。
 
 
### 複習一下
* `typealias Codable = Decodable & Encodable`
* Decodable（解碼）：使用 Data 來啟動一個類型。
* Encodable（編碼）：把類型編碼成 Data。
* 常見的通用編碼：JSON。
 
 

### 和網路呼叫的關聯？
* 下載來的 Data 必須解碼（decode）成類型使用。
* 大部分的 API 都接受/提供 JSON 編碼的資料。
 
 */

//: [Next](@next)
