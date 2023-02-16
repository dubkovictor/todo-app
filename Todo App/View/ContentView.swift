//
//  ContentView.swift
//  Todo App
//
//  Created by Victor on 16.02.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: - PROPERTIES
    @State private var showingAddTodoView: Bool = false
    
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Text("text")
            }//: LIST
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                self.showingAddTodoView.toggle()
            }, label: {
                Image(systemName: "plus")
            })//: BUTTON
                .sheet(isPresented: $showingAddTodoView, content: {
                    AddTodoView()
                })
            )
        }//: NAVIGATION
    }
}
//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
