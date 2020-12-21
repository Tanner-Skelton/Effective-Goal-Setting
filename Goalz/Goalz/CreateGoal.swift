//
//  CreateGoal.swift
//  Goalz

import SwiftUI

class CreateGoal: ObservableObject {
    @Published var goalTitle: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var description: String = ""
    @Published var canMoveView: Bool = false
    
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
                if views[viewIndex] == "StartDate"{
                    StartDateView()
                }
                if views[viewIndex] == "EndDate" {
                    EndDateView()
                }
                if views[viewIndex] == "Description" {
                    GoalDescriptionView()
                }
                if canSubmit {
                    Section(){
                        Button("Create") {
                            addGoal(title: self.newGoalObj.goalTitle,
                                    startDate: self.newGoalObj.startDate,
                                    endDate: self.newGoalObj.endDate,
                                    description: self.newGoalObj.description)
                        }.disabled(!self.newGoalObj.canMoveView)
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
                        self.newGoalObj.canMoveView = false
                        if viewIndex == (views.count - 1) {
                            self.canSubmit = true
                        }
                    }.disabled(!self.newGoalObj.canMoveView)
                }
            }
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
            TextField("Name your goal!", text: self.$newGoalObj.goalTitle, onCommit: {
                if self.newGoalObj.goalTitle != "" {
                    self.newGoalObj.canMoveView = true
                } else {
                    self.newGoalObj.canMoveView = false
                }
            })
        }
    }
}

struct StartDateView: View {
    @EnvironmentObject var newGoalObj: CreateGoal
    
    @State private var footerText = ""
    
    var body: some View {
        Section(header: Text("Start Date"), footer: Text("\(footerText)").fixedSize(horizontal: false, vertical: true)) {
            DatePicker("Start Date", selection: self.$newGoalObj.startDate).onChange(of: self.newGoalObj.startDate, perform: { value in
                if self.newGoalObj.startDate >= Date() {
                    self.newGoalObj.canMoveView = true
                    self.footerText = "Feel free to change the date to sometime in the future if you are not ready to start!"
                } else {
                    self.newGoalObj.canMoveView = false
                    self.footerText = "Please enter a date after \(Date())"
                }
            }).onAppear(perform: {
                self.newGoalObj.canMoveView = true
                self.footerText = "Feel free to change the date to sometime in the future if you are not ready to start!"
            })
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
