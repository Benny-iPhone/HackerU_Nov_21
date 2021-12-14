import UIKit

/*
 func solution(input: Int, cost: Int) -> [Int] {

     var arrExcessTMP: [Int] = []
     let dollarExcess: Int  = (input - cost) / 100
     let centExcess: Int  = (input - cost) % 100
     
     let cent_50: Int  = centExcess / 50
     let centExcess_50: Int  = centExcess % 50
     
     let cent_25: Int  = centExcess_50 / 25
     let centExcess_25: Int  = centExcess_50 % 25
     
     let cent_10: Int  = centExcess_25 / 10
     let centExcess_10: Int  = centExcess_25 % 10
     
     let cent_05: Int  = centExcess_10 / 5
     let centExcess_05: Int  = centExcess_10 % 5
     
     let cent_01: Int  = centExcess_05 / 1

     arrExcessTMP.append(dollarExcess)
     arrExcessTMP.append(cent_50)
     arrExcessTMP.append(cent_25)
     arrExcessTMP.append(cent_10)
     arrExcessTMP.append(cent_05)
     arrExcessTMP.append(cent_01)
     
     return arrExcessTMP
 }
 */

//we can instantiate array with pre-populated objects
let arr: [Int] = [Int](repeating: 0, count: 5) + [Int](repeating: 1, count: 5)

func solution(input: Int, cost: Int) -> [Int] {
    let coins: [Int] = [100, 50, 25, 10, 5, 1]
    var resultArray: [Int] = [Int](repeating: 0, count: coins.count)
    var change = input - cost
    
    //if no change, result array of zeros
    guard change > 0 else {
        return resultArray
    }
    
    for i in 0..<coins.count {
        let coinValue = coins[i]
        resultArray[i] = change / coinValue
        change = change % coinValue
    }
    
    return resultArray
}

/*
 First run
 i: 0
 change: 401
 coinValue: 100
 resultArray[0] = 401/100 => 4
 change <= 401 % 100 = 1
 
 i: 1
 change: 001
 coinValue: 50
 resultArray[1] = 001/50 => 0
 change <= 001 % 50 = 1
 
 i: 2
 change: 001
 coinValue: 25
 resultArray[2] = 001/25 => 0
 change <= 001 % 25 = 1
 
 i: 3
 change: 001
 coinValue: 10
 resultArray[3] = 001/10 => 0
 change <= 001 % 10 = 1
 
 i: 4
 change: 001
 coinValue: 5
 resultArray[4] = 001/5 => 0
 change <= 001 % 5 = 1
 
 i: 5
 change: 001
 coinValue: 1
 resultArray[5] = 001/1 => 1
 change <= 001 % 1 = 0
 */

solution(input: 500, cost: 99) //expecting: [4,   0,    0,    0,  0,  1]
solution(input: 100, cost: 5)
solution(input: 300, cost: 2)


/*
 input: 300
 cost: 2
 change: 298
 
 First run
 i: 0
 change: 298
 coinValue: 100
 resultArray[0] = 298/100 => 2
 change <= 298 % 100 = 098
 
 i: 1
 change: 098
 coinValue: 50
 resultArray[1] = 098/50 => 1
 change <= 098 % 50 = 048
 
 i: 2
 change: 048
 coinValue: 25
 resultArray[2] = 048/25 => 1
 change <= 048 % 25 = 023
 
 i: 3
 change: 023
 coinValue: 10
 resultArray[3] = 023/10 => 2
 change <= 023 % 10 = 003
 
 i: 4
 change: 003
 coinValue: 5
 resultArray[4] = 003/5 => 0
 change <= 003 % 5 = 003
 
 i: 5
 change: 003
 coinValue: 1
 resultArray[5] = 003/1 => 3
 change <= 003 % 1 = 0
 */
