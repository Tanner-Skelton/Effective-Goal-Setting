//
//  DetailGoalView.swift
//  Goalz
//
//  Created by John Erwin on 12/13/20.
//

import SwiftUI

struct DetailGoalView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var goal: Goal
    
    var body: some View {
      //  Text("Detailed Goal View!")
        VStack{
            Text(goal.title)
                .font(.largeTitle)
            Text(goal.goalDescription)
                .font(.title)
            Text("Start Date: \(goal.startDate)")

            Text("End Date: \(goal.endDate)")

        }
    }
}
