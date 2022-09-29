//
//  ContentView.swift
//  WatchNotes WatchKit Extension
//
//  Created by bytedance on 2022/9/28.
//

import SwiftUI

struct ContentView: View {
    @State private var text:String = ""
    @State private var notes:[Note] = [Note]()
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("", text: $text)
                Button {
                    // 1. the button only run when the textfield is not empty.
                    guard text.isEmpty == false else { return }
                    
                    // 2. create a note instance and initialize it with the textfiele's text
                    let note = Note(id: UUID(), text: text)

                    // 3. append note into the notes array
                    notes.append(note)
                    
                    // 4. make the text empty again
                    text = ""
                    
                    // 5. save the notes
                    saveNote()
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 40, weight: .bold))
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.purple)

            } // HStack
        } // VStack
    }
    
    func saveNote() {
        do {
            // convert notes into data with jSONEncoder
            let data = try JSONEncoder().encode(notes)
            
            print("note: \(notes)")
            
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            try data.write(to: url)
            

        } catch {
            print("convert notes failed.")
        }
        
    }
    
    func  getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}

//extension Button {
//
//}
                       
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
