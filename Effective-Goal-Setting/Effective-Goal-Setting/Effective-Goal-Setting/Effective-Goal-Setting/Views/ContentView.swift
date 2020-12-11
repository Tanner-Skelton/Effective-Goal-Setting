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

struct NavigationBarView: View {
    
    @State private var isShowingGoalView = false
    var body: some View {
        NavigationView{
            NavigationLink(
                destination: GoalView(),
                label: {
                    /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/
                })
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [])
    private var goals: FetchedResults<Goal>
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
                List {
                    ForEach(goals) { goal in
                        Text(goal.title ?? "Untitled")
                    }.onDelete(perform: deleteGoal)
                }
                //button that adds a goal to the DB
                Button("+ Goal") {
                    addGoal()
                }
                
                
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
    
    private func saveContext() {
        do {
            try  viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    //Test function to add new goal with title "New goal + the date it was ceated"
    private func addGoal() {
        let newGoal = Goal(context: viewContext)
        newGoal.title = "New Goal \(Date())"
        newGoal.timestamp = Date()
        
        saveContext()
    }
    
    private func deleteGoal(offsets: IndexSet) {
        withAnimation {
            offsets.map { goals[$0] }.forEach(viewContext.delete)
            saveContext()
        }
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

}
