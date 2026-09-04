
import UIKit
import Foundation

var greeting = "Hello, playground"

let str = ["♤", "♧", "♡","♢", " "]

for i in 0..<5 {
    for j in 0..<10 {
        for k in 0..<10 {
            print(str[Int.random(in: 0..<str.count)], terminator:"")
        }
        print()
    }
    print("\n")
}
