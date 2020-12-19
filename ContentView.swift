//
//  ContentView.swift
//  WordScramble App
//
//  Created by Luis Alvarez on 12/17/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var word = ""
    @State var enteredWords:[String] = [String]()
    @State var rootWord = ""
    
    var body: some View {
        NavigationView{
            VStack{
                
                TextField("Enter word here", text: $word, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(enteredWords, id: \.self){
                    Image(systemName: "\($0.count).circle")
                    Text("\($0)")
                }
            }
            .navigationTitle(Text("\(rootWord)"))
            .onAppear{
                startGame()
            }
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
    
    func startGame(){
        /*
         Starts game, finds and loads WordBank.txt
         Converts words in .txt to an array of strings,
         then grabs a random element from array as chosen word.
         */
        
        // Finding WordBank in bundle.main.url
        if let wordBankURL = Bundle.main.url(forResource: "WordBank", withExtension: ".txt"){
            
            //Load WordBank into string format
            if let words = try? String(contentsOf: wordBankURL){
                
                //Split word bank into an array using \n as delimiter
                let wordBank = words.components(separatedBy: "\n")
                
                //Set the rootword to a random word from word bank or default if not possible
                self.rootWord = wordBank.randomElement() ?? "Default"
                
                //Exit
                return
            }
        }
        
        //If we make it here then there was an error
        fatalError("Could not load WordBank.txt")
    }
    
    func addNewWord(){
        /*
         Lowercase newWord and remove any whitespace
         Check that it has at least 1 character otherwise exit
         Insert that word at position 0 in the usedWords array
         Set newWord back to be an empty string
         */
        
        let thisWord = word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard thisWord.count > 0 else{
            word = ""
            return
        }
        
        enteredWords.insert(word, at: 0)
        word = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
