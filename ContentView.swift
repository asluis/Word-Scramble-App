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
    @State var score = 0
    
    // Below vars are for error messages
    
    @State var errorMSG = ""
    @State var errorTitle = ""
    @State var showingError = false
    
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
                Text("Score \(score)")
                    .padding()
                    .font(.headline)
                
            }
            .navigationTitle(Text("\(rootWord)"))
            .onAppear{ // Runs code whenever view loads for the first time
                startGame()
            }
            .alert(isPresented: $showingError){
                Alert(title: Text(self.errorTitle), message: Text(self.errorMSG), dismissButton: .default(Text("Dismiss")))
            }
            .navigationBarItems(trailing:
                Button(action: {
                    print("Button pressed")
                    startGame()
                    enteredWords = [String]()
                }){
                    Text("New Word")
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
                score = 0
                return
            }
        }
        
        //If we make it here then there was an error
        fatalError("Could not load WordBank.txt")
    }
    
    func customErrorAlert(msg:String, title:String){
        self.errorMSG = msg
        self.errorTitle = title
        self.showingError = true
    }
    
    func isOriginal() -> Bool{
        return !enteredWords.contains(word)
    }
    
    func doesNotReUseLetters() -> Bool{
        
        var tempRoot = rootWord
        
        for letter in word{
            if let pos = tempRoot.firstIndex(of: letter){
                tempRoot.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    
    func isValid(word:String) -> Bool{
        // UI Kit text checker for spelling errors
        let checker = UITextChecker()
        
        //Converting our string into a C String
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
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
        
        guard isValid(word:word) else {
            customErrorAlert(msg: "Entered word is not spelled correctly!", title: "Incorrect spelling!")
            word = ""
            return
        }
        
        guard doesNotReUseLetters() else{
            customErrorAlert(msg: "Used more letters than are available in the original word!", title: "Too many letters")
            word = ""
            return
        }
        
        guard isOriginal() else{
            customErrorAlert(msg: "Word already used. Try again!", title: "Similar Word")
            word = ""
            return
        }
        
        enteredWords.insert(word, at: 0)
        score = score + 1
        word = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
