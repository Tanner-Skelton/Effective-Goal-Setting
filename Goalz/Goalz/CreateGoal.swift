//
//  CreateGoal.swift
//  Goalz

import SwiftUI

class CreateGoal: ObservableObject {
    @Published var goalTitle: String = ""
    @Published var startDate: Date = Date.init()
    @Published var endDate: Date = Date.init()
    @Published var description: String = ""
}

struct CreateGoalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var newGoalObj = CreateGoal()
    
    private var views: [String] = ["Title", "StartDate", "EndDate", "Description"]
    @State private var canSubmit: Bool = false
    @State private var viewIndex: Int = 0
    
    var body: some View {
            Form{
                if views[viewIndex] == "Title" {
                    GoalTitleView()
                }
                if views[viewIndex] == "StartDate" {
                    StartDateView()
                }
                if views[viewIndex] == "EndDate" {
                    EndDateView()
                }
                if views[viewIndex] == "Description" {
                    GoalDescriptionView()
                }
                if canSubmit {
                    Button("Create") {
                        addGoal(title: self.newGoalObj.goalTitle,
                                startDate: self.newGoalObj.startDate,
                                endDate: self.newGoalObj.endDate,
                                description: self.newGoalObj.description)
                    }
                } else {
                    if viewIndex != 0 {
                        Section() {
                            Button("Back"){
                                self.viewIndex -= 1
                            }
                        }
                    }
                    Button("Next") {
                        self.viewIndex += 1
                        if viewIndex == (views.count - 1) {
                            self.canSubmit = true
                        }
                    }
                }
            }
            //.navigationTitle("Create Goal")
            //.padding()
            //.navigationBarHidden(true)
            .lazyPop()
            .navigationBarTitle("Create Goal", displayMode: .large)
            .environmentObject(newGoalObj)
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

struct GoalTitleView: View {
    @EnvironmentObject var newGoalObj: CreateGoal
    
    var body: some View {
        Section(header: Text("Goal Name"), footer: Text("*It is important that your goal's name is meaningful.")) {
            TextField("Name your goal!", text: self.$newGoalObj.goalTitle)
        }
    }
}

struct StartDateView: View {
    @EnvironmentObject var newGoalObj: CreateGoal
    
    var body: some View {
        Section(header: Text("Start Date"), footer: Text("If you are not ready to start working on this today that is fine! Set a date for the future, we will remind you.")) {
            DatePicker("Start Date", selection: self.$newGoalObj.startDate)
        }
    }
}

struct EndDateView: View {
    @EnvironmentObject var newGoalObj: CreateGoal
    
    var body: some View {
        DatePicker("End Date", selection: self.$newGoalObj.endDate)
    }
}

struct GoalDescriptionView: View {
    @EnvironmentObject var newGoalObj: CreateGoal
    
    var body: some View {
        TextField("Describe your goal:", text: self.$newGoalObj.description)
    }
}

struct CreateGoalView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGoalView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
