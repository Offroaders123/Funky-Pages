import SwiftUI

struct ContentView: View {
    @State private var name = "Template File"
    @State private var document: MessageDocument = MessageDocument(message: "Hello, world!")
    @State private var isImporting = false
    @State private var isExporting = false
    
    @State private var urlString: String = "https://stedit.app"
    
    @State var showWebView = false
    private var webView: WebView {
        WebView(url: URL(string: urlString)!, testdo: self.showJSAlert) {
            print("Callback!")
        }
    }
    @State var showJSAlert = false
    
    var body: some View {
        VStack (spacing: 10) {
            webView
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .ignoresSafeArea(.all, edges: .all)
            Button("Open test file") {
                self.showJSAlert.toggle()
                self.webView.printStuff()
                /*
                 <script>
                 document.write("webkit" in window);
                 </script>
                 */
            }
        }
        
        /*VStack {
            GroupBox {
                TextField(text: $name) {
                    Text("Enter your file name...")
                }
                TextEditor(text: $document.message)
            }
            GroupBox {
                HStack {
                    Spacer()
                    Button(action: { isImporting = true }, label: {
                        Text("Import")
                    })
                    Spacer()
                    Button(action: { isExporting = true }, label: {
                        Text("Export")
                    })
                    Spacer()
                }
            }
        }
        .padding()
        
        .fileImporter(isPresented: $isImporting, allowedContentTypes: [.plainText], allowsMultipleSelection: false) { result in
            do {
                guard let selectedFile: URL = try result.get().first else { return }
                guard selectedFile.startAccessingSecurityScopedResource() else { return }
                guard let message = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                selectedFile.stopAccessingSecurityScopedResource()
                
                document.message = message
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        
        .fileExporter(isPresented: $isExporting, document: document, contentType: .plainText, defaultFilename: name) { result in
            if case .success = result {
                
            } else {
                
            }
        }*/
    }
}
