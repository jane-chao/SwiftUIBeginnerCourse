# SwiftUI 入門課程
放置 [SwiftUI 入門課程](https://www.youtube.com/playlist?list=PLXM8k1EWy5khONZ9M9ytK8mMrcEOXvGsE) 的相關檔案，以及每一章節的相關連結、延伸閱讀。

### Chapter 1
介紹 Xcode 介面和 SwiftUI 的基本架構。

##### 相關連結
* [1-1 展示的手機版本、升級趨勢網站](https://mixpanel.com/trends)
* [1-3 使用的盤子圖片來源](https://www.flaticon.com/free-sticker/dinner_7603521)
* [1-5 展示的裝置資訊網站](https://mixpanel.com/trends)
* [1-5 排版類型延伸閱讀](https://iosref.com/res)
* 如果你從 UIKit 過來可能會問 AppDelegate 去哪了。
請搭配[這個 property wrapper](https://developer.apple.com/documentation/swiftui/uiapplicationdelegateadaptor) 使用。
不過，如果只是要啟動時進行一些操作，在 App 的 init 中進行即可；如果是畫面切換相關事件，請用 [ScenePhase](https://developer.apple.com/documentation/swiftui/scenephase)。

---

### Chapter 2
練習排版和基本的重構程式碼。

##### 相關連結
* [在 SwiftUI 中实现视图居中的若干种方法](https://www.fatbobman.com/posts/centering_the_View_in_SwiftUI/)
* 除了影片中搭配計算屬性使用 **@ViewBuilder**，你可能也會[在啟動或 closure 中使用它](https://swiftontap.com/viewbuilder)。

---

### Chapter 3
介紹 SwiftUI 中常用的屬性包裝：State、Binding 和 Environment；練習建立清單、表單，並使用 enum 整理程式碼。

##### 相關連結
* [EnvironmentValues 環境變數](https://developer.apple.com/documentation/swiftui/environmentvalues)
* 影片中提到的「**在 result builder 中，local 變數會被當作建造的 block**」，詳細的資訊可以在這個 [evolution 記錄](https://github.com/apple/swift-evolution/blob/main/proposals/0289-result-builders.md#the-result-builder-transform)中了解，在 *The result builder transform* 的分類下可以認識 result builder 對不同語句的判斷。

---

### Chapter 4
介紹 iOS 環境原生的資料持久化方式以及編碼的概念介紹，並實作一個設定畫面，使用 AppStorage 儲存布林、enum 和 Array 的資料。

##### 相關連結
* [官方的資料持久化文件](https://developer.apple.com/documentation/swiftui/persistent-storage)
* [會新增 Presentation 的調整器](https://developer.apple.com/documentation/swiftui/view-presentation)
* 影片中提到可以嘗試**建立自己的 AppStorage 屬性包裝**，如果有興趣可以參考 SwiftLee 的[這篇文章](https://www.avanderlee.com/swift/appstorage-explained/
)，不過這個是個相對進階的內容，你會需要有基本 Combine 概念、了解 ObservableObject 和 DynamicProperty 。
* 使用 FileManager 時，你可能會需要知道[如何取得檔案 URL](https://chaocode.co/blog/getting-url)。
