import SwiftUI

struct FilePicker: UIViewControllerRepresentable {
    @Binding var content: String
    
    func makeCoordinator() -> FilePicker.Coordinator {
        return FilePicker.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<FilePicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.text])
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<FilePicker>) {}
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let picker: FilePicker
        
        init(parent: FilePicker) {
            picker = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            let url = urls[0]
            do {
                let content = try Data(contentsOf: url)
                print(content)
            } catch {
                print("Couldn't load file: \(error)")
            }
        }
    }
}
