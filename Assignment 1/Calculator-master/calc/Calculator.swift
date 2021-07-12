//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//
///
/// - Author: Aung Kaung Myat
/// - Parameters:
///   - no1: First number
///   - no2: Second number
/// - Returns: The addition result
///
/// - Warning: The result may yield Int overflow.
/// - SeeAlso: https://developer.apple.com/documentation/swift/int/2884663-addingreportingoverflow
//main function to calculate the final result of user input
import Foundation


class Calculator {
    
    //function to add two inputs(integers)
    func add(no1: Int, no2: Int) -> Int {
        return no1 + no2
    }
    
    //function to substract two inputs(integers)
    func substract(no1: Int, no2: Int) -> Int{
        return no1 - no2
    }
    
    //function to multiply two inputs(integers)
    func multiply(no1: Int, no2: Int) -> Int{
        return no1 * no2
    }
    
    //function to divide two inputs(integers)
    func divide(no1: Int, no2: Int) -> Int{
        if(no2 == 0){
            print("The number cannot be divided by zero")
            exit(1)
        }else{
            return no1 / no2
        }
    }
    
    //function to find remainder from two inputs(integers)
    func modulus(no1: Int, no2: Int) -> Int{
        if(no2 == 0){
            print("The number cannot be divided by zero")
            exit(1)
        }else{
            return no1 % no2
        }
    }
    
    func calculate(args: [String]) -> String {
        var operatorSigns : [String] = []//a string array to collect operators
        var numbers : [Int] = []//an integer array to collect input numbers
        
        //a for loop to seperate operators and numbers
        for counter in 0...args.count - 1 {
            if (counter % 2 == 1){
                switch args[counter]{
                case "+","-","x","/","%":
                    operatorSigns.append(args[counter])
                default:
                    exit(1)// to exit from program when the input is invalid
                }
            }else{
                if (Int(args[counter]) == nil){
                    exit(1)// to exit from program when the input is invalid
                }
                numbers.append(Int(args[counter]) ?? 0)//to add int numbers into numbers array
                
            }
        }
        
        var index = 0// as a counter to stop while loop
        
        //a while loop to go thorugh all the operatorSigns
        //if conditions to find primary precedence operators and solve them
        while (index <= operatorSigns.count - 1){
            
            if (operatorSigns[index] == "x"){
                let dummy = multiply(no1: numbers[index], no2: numbers[index+1])
                numbers[index] = dummy
                numbers.remove(at: index + 1)
                operatorSigns.remove(at: index)
            }else if(operatorSigns[index] == "/"){
                let dummy = divide(no1: numbers[index], no2: numbers[index+1])
                numbers[index] = dummy
                numbers.remove(at: index + 1)
                operatorSigns.remove(at: index)
            }else if(operatorSigns[index] == "%"){
                let dummy = modulus(no1: numbers[index], no2: numbers[index+1])
                numbers[index] = dummy
                numbers.remove(at: index + 1)
                operatorSigns.remove(at: index)
            }else{
                index += 1
            }
        }
        
        // while loop to go thorugh all the operatorSigns
        //if conditions to solve the rest of the operators
        index = 0
        while (index <= operatorSigns.count - 1){
            if (operatorSigns[index] == "+"){
                let dummy = add(no1: numbers[index], no2: numbers[index+1])
                numbers[index] = dummy
                numbers.remove(at: index + 1)
                operatorSigns.remove(at: index)
            }else if (operatorSigns[index] == "-"){
                let dummy = substract(no1: numbers[index], no2: numbers[index+1])
                numbers[index] = dummy
                numbers.remove(at: index + 1)
                operatorSigns.remove(at: index)
            }else{
                index += 1
            }
        }
            
        
        return String(numbers[0])
    }
   
}





