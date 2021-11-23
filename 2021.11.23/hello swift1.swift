import Foundation

//let = constant
//var = variable
let num = 1
print(num)
let num2 = 2
print("sum:\(num + num2)")

//will not compile, num is a constant
//num -= 3

var num4 = 0
num4 += num2 * 2
print(num4)

var num5 = 1
// += is a shorthand
//instead of x = x + 3
num5 = num5 + 4
//we can type x += 3
num5 += 4
//and so goes to -= (minus)
num5 -= 2
//and *= mulitply
num5 *= 3
//also divide /=
num5 /= 2

print(num5)
