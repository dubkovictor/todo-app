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
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
    @State private var showingSettingsView = false
    @State private var showingAddTodoView = false
    @State private var animationButton = false
    
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "Unknown")
                            Spacer()
                            Text(todo.priority ?? "Unknown")
                        }
                    } //:FOREACH
                    .onDelete(perform: deleteTodo)
                }//: LIST
                .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(action: {
                        self.showingSettingsView.toggle()
                        
                    }, label: {
                        Image(systemName: "paintbrush")
                            .imageScale(.large)
                    })//: BUTTON
                        .sheet(isPresented: $showingSettingsView, content: {
                            SettingsView()
                        })
                )
                //MARK: - No todo items
                if todos.count == 0 {
                    EmptyListView()
                }
            } //: ZSTACK
            .sheet(isPresented: $showingAddTodoView, content: {
                AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
            })
            .overlay (
                ZStack {
                    Group {
                        Circle()
                            .fill(Color(.blue))
                            .opacity(self.animationButton ? 0.2 : 0)
                            .scaleEffect(self.animationButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(.blue)
                            .opacity(self.animationButton ? 0.15 : 0)
                            .scaleEffect(self.animationButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(.easeOut(duration: 2).repeatForever(), value: animationButton)
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    }//: BUTTON
                    .onAppear {
                        self.animationButton.toggle()
                    }
                } //: ZSTACK
                .padding(.bottom, 15)
                .padding(.trailing, 15)
                , alignment: .bottomTrailing
            )
        }//: NAVIGATION
    }
    
    //MARK: - Functions
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}
//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
