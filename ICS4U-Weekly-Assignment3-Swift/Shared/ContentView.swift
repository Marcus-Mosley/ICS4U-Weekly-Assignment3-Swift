//
// ContentView.swift
// ICS4U-Weekly-Assignment3-Swift
//
// Created by Marcus A. Mosley on 2021-01-28
// Copyright (C) 2021 Marcus A. Mosley. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var arr = Array(repeating: 0, count: 250)
    @State private var arrText: String = ""
    @State private var sortText: String = ""
    @State private var search: String = ""
    @State private var searchResult: String = ""
    @State private var result: Int = 0
    @State var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            Text("Random Array: \(arrText)")
                .padding()
                .font(.body)
            Text("Sorted Array: \(sortText)")
                .padding()
                .font(.body)
            Button(action: {
                for counter in (0...arr.count - 1) {
                    arr[counter] = Int.random(in: 0...999)
                }
                
                arrText = printArr(arr)
                sort(0, arr.count - 1)
                sortText = printArr(arr)
            }) {
                Text("#1. Get Array")
                    .padding()
            }
            TextField("Enter a value: ", text: $search)
                .padding()
            Button(action: {
                if (Int(search) != nil || Int(search)! > 0) {
                    result = binarySearch(0, arr.count - 1, Int(search)!)
                    if (result == -1) {
                        searchResult = "Value not present"
                    } else {
                        searchResult = "Value found at index \(String(result))"
                    }
                } else {
                    showingAlert = true
                }
            }) {
                Text("#2. Search Value")
                    .padding()
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Important Message"), message: Text("Not Valid Input"), dismissButton: .default(Text("Got It!")))
            }
            .padding()
            Text("\(searchResult)")
                .padding()
                .font(.body)
        }
    }
    
    // Organizes the pivot and the smaller and larger values relative to it.
    func partition( _ low: Int, _ high: Int) -> Int {
        let pivot: Int = arr[high]
        var index: Int = low - 1
        var temp: Int = 0
        
        for counter in (low..<high) {
            if (arr[counter] < pivot) {
                index += 1
                temp = arr[index]
                self.arr[index] = arr[counter]
                self.arr[counter] = temp
            }
        }
        temp = arr[index + 1]
        self.arr[index + 1] = arr[high]
        self.arr[high] = temp
        return index + 1
    }
    
    // The driver of the sorting algorithm
    func sort( _ start: Int, _ length: Int) {
        var partInd: Int = 0
        if (start < length) {
            partInd = partition(start, length)
            sort(start, partInd - 1)
            sort(partInd + 1, length)
        }
    }
    
    // Creates a String that is ready to be printed from an Array
    func printArr(_ arr: [Int]) -> String {
        var text: String = ""
        
        for counter in (0...arr.count - 1) {
            text += String(arr[counter]) + ", "
        }
        return text
    }
    
    // Searches for a given value in an array
    func binarySearch(_ start: Int, _ length: Int, _ search: Int) -> Int {
        if (length >= start) {
            let mid: Int = start + (length - start) / 2
            if (arr[mid] == search) {
                return mid
            } else if (arr[mid] > search) {
                return binarySearch(start, mid - 1, search)
            } else {
                return binarySearch(mid + 1, length, search)
            }
        }
        return -1
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
