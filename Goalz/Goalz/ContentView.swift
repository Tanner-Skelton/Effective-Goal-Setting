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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
