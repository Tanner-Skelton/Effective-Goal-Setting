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
