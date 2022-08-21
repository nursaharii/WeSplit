//
//  ContentView.swift
//  weSplit
//
//  Created by Nurşah ARİ on 20.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var TotalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    @FocusState private var amountIsFocused: Bool
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount:",value: $checkAmount,format: .currency(code: Locale.current.currencyCode ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)
                    Picker("Number of people",selection: $numberOfPeople) {
                        ForEach (2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                    
                }
                
                Section {
                    Picker ("Tip Persentage",selection: $tipPercentage) {
                        
                        ForEach(Array(stride(from: 0, to: 101, by: 5)), id: \.self) { index in
                            Text(index,format: .percent) //increase by custom number
                        }
                    }
                }header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }header: {
                    Text("Amount per person")
                }
                Section {
                    Text(TotalAmount,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }header: {
                    Text("Total Amount")
                }
            }
            .navigationTitle("WeSplit").toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
