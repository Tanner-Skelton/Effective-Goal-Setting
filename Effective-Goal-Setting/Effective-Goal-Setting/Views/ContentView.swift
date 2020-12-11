//
//  ContentView.swift
//  Effective-Goal-Setting
//
//  Created by Tanner Skelton on 12/10/20.
//

import SwiftUI
import CoreData
import UIKit

struct GoalView: View {
    // How to create another view
    var body: some View {
        Text("Hello")
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    /*@FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    */
    
    // showing views based on bool
    //@State private var isShowingGoalView = false
    // showing views base on selection
    @State private var selection: String? = nil
    
    var toolbar: UIToolbar!
    var systemItem = UIBarButtonItem.SystemItem.compose

    var body: some View {
        NavigationView{
            // Need to have something in the main view
            Text("Test")
            /*VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                NavigationLink(
                    destination: GoalView(),
                    tag: "Goal",
                    selection: $selection ) { EmptyView() }
                
                Button("Create Goal"){
                    self.selection = "Goal"
                }
            })*/
                .navigationBarTitle("Goals")
                //.navigationBarItems(trailing: NavigationBarView())
                .toolbar(content: {
                    ToolbarItem{
                        NavigationLink(
                            destination: GoalView(),
                            label: {
                                Image(systemName: "trash")
                            })
                    }
                })
        }
    }
    /*var body: some View {
        List {
            ForEach(items) { item in
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }*/

    /*
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    */
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
