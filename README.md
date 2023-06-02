# SwiftUI 入門課程
放置 [SwiftUI 入門課程](https://www.youtube.com/playlist?list=PLXM8k1EWy5khONZ9M9ytK8mMrcEOXvGsE) 的相關檔案，以及每一章節的相關連結、延伸閱讀。

### Chapter 1：基本介紹
介紹 Xcode 介面和 SwiftUI 的基本架構。

##### 相關連結
* [1-1 展示的手機版本、升級趨勢網站](https://mixpanel.com/trends)
* [1-3 使用的盤子圖片來源](https://www.flaticon.com/free-sticker/dinner_7603521)
* [1-5 展示的裝置資訊網站](https://iosref.com/res)
* [1-5 排版類型延伸閱讀](http://defagos.github.io/understanding_swiftui_layout_behaviors/)
* 如果你從 UIKit 過來可能會問 AppDelegate 去哪了。
請搭配[這個 property wrapper](https://developer.apple.com/documentation/swiftui/uiapplicationdelegateadaptor) 使用。
不過，如果只是要啟動時進行一些操作，在 App 的 init 中進行即可；如果是畫面切換相關事件，請用 [ScenePhase](https://developer.apple.com/documentation/swiftui/scenephase)。

---

### Chapter 2：排版
練習排版和基本的重構程式碼。

##### 相關連結
* [在 SwiftUI 中实现视图居中的若干种方法](https://www.fatbobman.com/posts/centering_the_View_in_SwiftUI/)
* 除了影片中搭配計算屬性使用 **@ViewBuilder**，你可能也會[在啟動或 closure 中使用它](https://swiftontap.com/viewbuilder)。

---

### Chapter 3：屬性包裝
介紹 SwiftUI 中常用的屬性包裝：State、Binding 和 Environment；練習建立清單、表單，並使用 enum 整理程式碼。

##### 相關連結
* [EnvironmentValues 環境變數](https://developer.apple.com/documentation/swiftui/environmentvalues)
* 影片中提到的「**在 result builder 中，local 變數會被當作建造的 block**」，詳細的資訊可以在這個 [evolution 記錄](https://github.com/apple/swift-evolution/blob/main/proposals/0289-result-builders.md#the-result-builder-transform)中了解，在 *The result builder transform* 的分類下可以認識 result builder 對不同語句的判斷。

---

### Chapter 4：資料持久化
介紹 iOS 環境原生的資料持久化方式以及編碼的概念介紹，並實作一個設定畫面，使用 AppStorage 儲存布林、enum 和 Array 的資料。

##### 相關連結
* [官方的資料持久化文件](https://developer.apple.com/documentation/swiftui/persistent-storage)
* [會新增 Presentation 的調整器](https://developer.apple.com/documentation/swiftui/view-presentation)
* 影片中提到可以嘗試**建立自己的 AppStorage 屬性包裝**，如果有興趣可以參考 [SwiftLee 的這篇文章](https://www.avanderlee.com/swift/appstorage-explained/
)，不過這個是個相對進階的內容，你會需要有基本 Combine 概念、了解 ObservableObject 和 DynamicProperty 。
* 使用 FileManager 時，你可能會需要知道[如何取得檔案 URL](https://chaocode.co/blog/getting-url)。

---

### Chapter 5：測試
介紹測試的基本概念、Xcode 的測試介面並實作一個測試，以及使用 Measurement 進行單位轉換並且根據使用者 Locale 顯示在地化的單位字串。

##### 相關連結
* [WWDC20: 在地化的格式化工具](https://developer.apple.com/videos/play/wwdc2020/10160/)，影片中介紹了能把日期、單位、數字和文字等等資料，根據使用者 Locale 進行格式化的工具。
* [WWDC19: 測試、Test Plan、CICD 介紹](https://developer.apple.com/wwdc19/403)
* 了解 [Locale](https://developer.apple.com/documentation/foundation/locale)，Locale 並不單指語言，而是結合語言加上地區，提供更精確的慣用法。例如同樣是英文，在不同國家寫日期的順序依然會有所不同。
    - 在你的 app 沒有做其他語言之前，**Locale 會被設定成你的專案的 base language**，詳細的介紹可以看[這篇文章](https://medium.com/swlh/know-your-language-locale-in-swift-beae4fcc5174)，裡面也提供了`取得使用者偏好 / 正在使用的語言的方法`，在你還沒做多語言之前，你可以嘗試取得這些值來強制修改 Locale。
  
* [在 iOS16 加上工具列的背景色](https://sarunw.com/posts/swiftui-tabview-color/)：文章是針對 TabBar 介紹，不過這個調整器 `toolbarBackground` 也能用來修改 Navigation Bar。
* 你可能會發現 TabBar 在 iOS14 以前長得不一樣 🥲，如果你想要全部統一的話可以參考[這篇文章中的程式碼](https://blog.personal-factory.com/2021/12/29/ios15-transparent-navigationbar-and-tabbar-by-default/)做修改。

---

### Chapter 6：網路呼叫
介紹基本的網路概念，並且用 The Cat API 實作網路呼叫，實作一個專門處理網路的 Manager 以及處理相關錯誤。

##### 相關連結
* 6-2 [常見 HTTP 狀態碼](https://developer.mozilla.org/zh-TW/docs/Web/HTTP/Status)
* 6-2 [MIME 類型名稱對照](https://www.iana.org/assignments/media-types/media-types.xhtml)
* 6-2 [判斷是否使用 Cache 資料的流程圖](https://developer.apple.com/documentation/foundation/nsurlrequest/cachepolicy/useprotocolcachepolicy)
* 6-3 影片中提到的[將回傳加入 cache 的條件](https://developer.apple.com/documentation/foundation/urlsessiondatadelegate/1411612-urlsession)
* 6-5 影片中使用的[快速產生 JSON 解析程式碼的網站](https://app.quicktype.io/)。要記得用自動產生的程式碼的時候，不管多簡單的資料都要自己再檢查一遍哦
* 6-8 [StateObject 的文件](https://developer.apple.com/documentation/swiftui/stateobject)：這個文件簡單介紹了搭配 `ObservableObject` 的三個屬性包裝器，以及它們的更新時機。建議大概閱讀啟動和更新的部分，當未來遇到 StateObject 重複被啟動或是沒有如預期的更新的時候再次回來閱讀。
* 6-8 如果對 **StateObject 和 ObservedObject** 的差別有疑惑，可以參考 onevcat 的[這篇文章](https://onevcat.com/2020/06/stateobject/)。
* 6-11 [onAppear 和 task 調整器的差別](https://byby.dev/swiftui-task-vs-onappear)，這篇文章提到的差別我覺得都蠻重要的，除了影片中提過的，還有額外講到 task 搭配 id 的用法。
* 6-11 如果對於使用`Task`和`Task.detached`的時機不太確定，可以參考[這篇文章](https://www.donnywals.com/understanding-unstructured-and-detached-tasks-in-swift/)裡面的 **When to use unstructured tasks** 和 **When to use detached tasks**。
  ###### 另外，目前主流的做法是避免使用 detached，這並不是因為它不好，而是沒有什麼非得要用的原因（i.e. 沒必要讓自己的程式碼變複雜）。不過，我個人覺得 detached 的 explicit 對於初期掌握自己的程式碼在做什麼很有幫助，還有因為它沒有繼承而產生的一些報錯和警告也對初期學習很有幫助。
* 6-11 如果想瞭解更多關於`onAppear`出現的時機，可以看這篇關於 [View 的生命週期](https://www.vadimbulavin.com/swiftui-view-lifecycle/) 的文章。
* 6-11 影片中提到的，ObservableObject 會讓整個 View 進到 MainActor，[這篇文章](https://oleb.net/2022/swiftui-task-mainactor/)詳細講了關於 View struct 神秘的 @MainActor 情況。再一次強調，我覺得不用太在意這個，遇到這個錯誤就直接改進 MainActor 中就好。