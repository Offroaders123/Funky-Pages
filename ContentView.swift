import SwiftUI

struct ContentView: View {
    @State private var showingFilePicker = false
    @State private var content = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hi there!")
                Button("Open a File!"){
                    showingFilePicker = true
                }
                TextEditor(text: $content)
            }
            .navigationTitle("A Section")
            .navigationBarTitleDisplayMode(.inline)
            .fileImporter(isPresented: $showingFilePicker, allowedContentTypes: [.text]){ result in
                do {
                    let url = try result.get()
                    print(url)
                    
                    guard url.startAccessingSecurityScopedResource() else { return }
                    if let data = try? Data(contentsOf: url),
                       let value = String(bytes: data, encoding: .utf8) {
                        print(value)
                        content = value
                    }
                    url.stopAccessingSecurityScopedResource()
                } catch {
                    print("Couldn't load file:")
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
}
