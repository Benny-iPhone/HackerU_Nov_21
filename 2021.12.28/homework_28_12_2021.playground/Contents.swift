import UIKit

struct Point {
    let x: Double
    let y: Double
    
    func distance(from p: Point) -> Double {
        //x-axis side of right traingle
        let a = abs(self.x - p.x)
        //y-axis side of right traingle
        let b = abs(self.y - p.y)
        //calculate c^2 = a^2 + b^2
        let sqrC = pow(a, 2) + pow(b, 2)
        
        return sqrt(sqrC)
    }
}

let p1 = Point(x: 0, y: 0)
let p2 = Point(x: 3, y: 4)
print(p1.distance(from: p2))

struct Traingle {
    let top: Point
    let left: Point
    let right: Point
}

