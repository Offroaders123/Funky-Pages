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
            .sheet(isPresented: $showingFilePicker){
                FilePicker(content: $content)
            }
            .navigationTitle("A Section")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
