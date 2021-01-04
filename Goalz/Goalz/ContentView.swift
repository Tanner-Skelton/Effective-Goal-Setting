//
//  ContentView.swift
//  Goalz

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Goal.title, ascending: true)]
    ) var goals: FetchedResults<Goal>
    
    fileprivate func extractedFunc() -> some DynamicViewContent {
        return ForEach(goals, id: \.self) { goal in
            NavigationLink(destination: DetailGoalView(goal: goal)){
                Text(goal.title)
            }
        }
        .onDelete(perform: { indexSet in
            for index in indexSet {
                viewContext.delete(goals[index])
            }
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        })
    }
    
    var body: some View {
        NavigationView {
            List {
                extractedFunc()
            }
            .navigationTitle("Goalz")
            .toolbar(content: {
                NavigationLink(
                    destination: CreateGoalView(),
                    label: {
                        Text("Navigate")
                    })
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

