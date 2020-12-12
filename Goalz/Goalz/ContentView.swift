//
//  ContentView.swift
//  Goalz
//
//  Created by Tanner Skelton on 12/11/20.
//

import SwiftUI

struct CreateGoalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var goalTitle: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date.init()
    @State var goalDescription: String = ""
    
    var body: some View{
        NavigationView{
            Form{
                TextField("Name of your goal:", text: $goalTitle)
                DatePicker("Start Date", selection: $startDate)
                DatePicker("End Date", selection: $endDate)
                TextField("Describe your goal:", text: $goalDescription)
                Button("Confirm") {
                    // make sure we have a goal title
                    guard self.goalTitle != "" else {return}
                    guard self.goalDescription != "" else {return}
                    let newGoal = Goal(context: viewContext)
                    newGoal.title = self.goalTitle
                    newGoal.startDate = self.startDate
                    newGoal.endDate = self.endDate
                    newGoal.goalDescription = self.goalDescription
                    do {
                        try viewContext.save()
                        print("Goal Created.")
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .padding()
            .navigationBarTitle("Set a Goal")
            //.navigationBarHidden(true)
            .accentColor(.blue)
            
        }
        .lazyPop()
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var goals: FetchedResults<Goal>
    
    var body: some View {
        NavigationView{
            Form {
                ForEach (goals) { goal in
                    Text(goal.title)
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

