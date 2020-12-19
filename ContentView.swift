//
//  ContentView.swift
//  WordScramble App
//
//  Created by Luis Alvarez on 12/17/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            List{
                Text("text entry")
            }
            .navigationTitle(Text("WORD GOES HERE"))
            .navigationBarItems(trailing:
                Button("BUTTON"){
                    print("Buttin pressed")
                }
            )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
