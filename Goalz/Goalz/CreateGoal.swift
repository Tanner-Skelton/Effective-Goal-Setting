//
//  CreateGoal.swift
//  Goalz
//
//  Created by John Erwin on 12/12/20.
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
                    addGoal(title: self.goalTitle, startDate: self.startDate, endDate: self.endDate, description: self.goalDescription)
                }
            }
            .padding()
            .navigationBarTitle("Set a Goal")
            //.navigationBarHidden(true)
            .accentColor(.blue)
            
        }
        .lazyPop()
    }
    
    private func addGoal(title: String, startDate: Date, endDate: Date, description: String) {
        guard title != "" else { return }
        guard description != "" else { return }
        let newGoal = Goal(context: viewContext)
        newGoal.title = title
        newGoal.startDate = startDate
        newGoal.endDate = endDate
        newGoal.goalDescription = description
        do {
            try viewContext.save()
            print("Goal Created.")
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}
