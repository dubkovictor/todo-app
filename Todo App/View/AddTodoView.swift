//
//  AddTodoView.swift
//  Todo App
//
//  Created by Victor on 16.02.2023.
//

import SwiftUI

struct AddTodoView: View {
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presenntantionMode
    
    @State private var name = ""
    @State private var priority = "Normal"
    
    let priorities = ["Hight", "Normal", "Low"]

    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    //MARK: - Todo name
                    TextField("todo", text: $name)
                    
                    //MARK: - Todo priority
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    //MARK: - Save Button
                    Button {
                        print("Save a new todo item.")
                    } label: {
                        Text("Save")
                    }//: BUTTON

                }
                Spacer()
            }//: VSTACK
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                self.presenntantionMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            })
            )
        } //: NAVIGATION
        
    }
}

//MARK: - PREVIEW
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
