/*
 Help from this one:
 https://betterprogramming.pub/importing-and-exporting-files-in-swiftui-719086ec712
 
 Completed on 1:06 AM July 29, 2022
 */
import SwiftUI
import UniformTypeIdentifiers

struct MessageDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.plainText] }
    
    var message: String
    
    init(message: String) {
        self.message = message
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        message = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: message.data(using: .utf8)!)
    }
}
