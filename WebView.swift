/*
 WebView work was made a few days later, and these resources helped me out :)
 https://www.youtube.com/watch?v=GaXgDy0rRv8
 https://stackoverflow.com/questions/57053007/how-to-remove-the-top-safe-area-in-swiftui
 https://stackoverflow.com/questions/28795476/detect-if-page-is-loaded-inside-wkwebview-in-javascript
 https://stackoverflow.com/questions/67974721/ios-make-function-calls-between-uiviewrepresentable-and-view-both-ways-swiftui
 */
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL
    var testdo = false
    var callback: (() -> Void)? = nil
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let userContentController = WKUserContentController()
        
        userContentController.add(context.coordinator, name: "observer")
        
        configuration.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func printStuff() {
        print("printstuff")
    }
    
    typealias UIViewType = WKWebView
}

class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
    var control: WebView
    
    init(_ control: WebView) {
        self.control = control
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        showAlert(body: message.body)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.control.callback?()
    }
    
    func sendjs(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func showAlert(body: Any) {
        print("Working!")
    }
}
