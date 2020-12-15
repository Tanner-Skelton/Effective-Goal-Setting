//
//  CreateGoal.swift
//  Goalz

import SwiftUI

struct CreateGoalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var goalTitle: String = ""
    @State var startDate: Date = Date.init()
    @State var endDate: Date = Date.init()
    @State var goalDescription: String = ""
    
    
    var body: some View{
            Form{
                Section(header: Text("Goal Name"), footer: Text("*It is important that your goal's name is meaningful.")) {
                    TextField("Name your goal!", text: $goalTitle)
                }
                Section(header: Text("Start Date"), footer: Text("If you are not ready to start working on this today that is fine! Set a date for the future, we will remind you.")) {
                    DatePicker("Start Date", selection: $startDate)
                }
                DatePicker("End Date", selection: $endDate)
                TextField("Describe your goal:", text: $goalDescription)
                Button("Confirm") {
                    addGoal(title: self.goalTitle,
                            startDate: self.startDate,
                            endDate: self.endDate,
                            description: self.goalDescription)
                }
            }
            //.navigationTitle("Create Goal")
            //.padding()
            //.navigationBarHidden(true)
            .lazyPop()
            .navigationBarTitle("Create Goal", displayMode: .large)
        }
    
    
    private func addGoal(title: String, startDate: Date, endDate: Date, description: String) {
        guard title != "" else { return }
        guard description != "" else { return }
        let newGoal = Goal(context: viewContext)
        newGoal.title = title
        newGoal.startDate = startDate
        newGoal.endDate = endDate
        newGoal.goalDescription = description
        //viewContext.insert(newGoal)
        do {
            try viewContext.save()
            print("Goal Created.")
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CreateGoalView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGoalView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
