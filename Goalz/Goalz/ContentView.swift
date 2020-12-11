//
//  ContentView.swift
//  Goalz
//
//  Created by Tanner Skelton on 12/11/20.
//

import SwiftUI

struct CreateGoalView: View {
    var body: some View{
        NavigationView{
            Form {
                Text("This is the form")
            }
            .navigationBarTitle("Set a Goal")
            //.navigationBarHidden(true)
            .accentColor(.blue)
        }
        .lazyPop()
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var goals: FetchedResults<Goal>
    
    var body: some View {
        NavigationView{
            NavigationLink(
                destination: Text("Hello World!"),
                label: {
                    Text("Navigate")
                })
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
    
    private func addGoal() {
        withAnimation {
            let newGoal = Goal(context: viewContext)
            newGoal.title = "New goal bitch"
            newGoal.startDate = Date()
            newGoal.endDate = nil
            newGoal.goalDescription = "this is a new goal bitch"
            
            saveContext()
        }
    }
    
    private func deleteGoal(offsets: IndexSet) {
        withAnimation {
            offsets.map { goals[$0]}.forEach(viewContext.delete)
        }
        self.saveContext()
    }
    
    
    private func saveContext() {
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
        ContentView()
    }
}

