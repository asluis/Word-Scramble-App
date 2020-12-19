//
//  ContentView.swift
//  WordScramble App
//
//  Created by Luis Alvarez on 12/17/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var word = ""
    
    var body: some View {
        NavigationView{
            List{
                TextField("Enter word here", text: $word)
            }
            .navigationTitle(Text("WORD GOES HERE"))
            .navigationBarItems(trailing:
                Button(action: {
                    print("Button pressed")
                }){
                    Text("BUTTON")
                        .font(.headline)
                        .padding(4)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
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
