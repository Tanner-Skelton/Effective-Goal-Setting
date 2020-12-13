//
//  ContentView.swift
//  Goalz

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Goal.title, ascending: true)
        ]
    ) var goals: FetchedResults<Goal>
    //@FetchRequest(sortDescriptors: [])
    //private var goals: FetchedResults<Goal>
    
    var body: some View {
        NavigationView{
            List {
                ForEach(goals) { goal in
                    VStack(alignment: .leading) {
                        Text("\(goal.title)")
                    }
                }
            }
                .navigationBarTitle("Goalz")
                .toolbar(content: {
                    NavigationLink(
                        destination: CreateGoalView(),
                        label: {
                            Text("Navigate")
                        })
                })
        }
    }
    
    public func addGoal(title: String, startDate: Date, endDate: Date, description: String) {
        withAnimation {
            let newGoal = Goal(context: viewContext)
            newGoal.title = title
            newGoal.startDate = startDate
            newGoal.endDate = endDate
            newGoal.goalDescription = description
            
            self.saveContext()
        }
    }
    
    public func deleteGoal(offsets: IndexSet) {
        withAnimation {
            offsets.map { goals[$0]}.forEach(viewContext.delete)
        }
        self.saveContext()
    }
    
    
    public func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

