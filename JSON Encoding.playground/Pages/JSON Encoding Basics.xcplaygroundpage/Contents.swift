/*:
 # JSON Encoding Basics
 
 If you've been using Apple's Swift programming lanugage for very long, you probably know
 that you can easily encode and decode JSON data using the `Codable` protocol. What you may
 *not* realize is that `Codable` has some serious limitations when it comes to encoding
 Swift dictionaries!
 
 Let's start with a simple example that shows the basics of encoding and decoding data stores
 in a dictionary. For our scenario, we'll assume we're building a game that allows the user
 to build collections of geometric objects (circles, squares, triangles, etc) and we want to
 keep a list of number of items they've acquired at various points in the game.
 
 A simple JSON encoding of this data might look something like:
 
 ```
 "{
   "objects" : {
     "Circle" : [
       1,
       2,
       3
     ],
     "Square" : [
       4,
       5,
       6
     ],
    "Triangle" : [
       7,
       8,
       9
     ]
   }
 }"
 ```
 
 Let's see how we can encode and decode this data. First, we'll declare a `struct` which holds the dictionary of in-game objects:
 */
import Foundation
struct GameData: Codable {
    let objects: [String: [Int]]
}

//: Now let's see how we'd parse a JSON representation of this data:
let inputString = """
{
  "objects": {
    "Circle": [1, 2, 3],
    "Square": [4, 5, 6],
    "Triangle": [7, 8, 9]
  }
}
"""
let inputData = inputString.data(using: .utf8)!
let decoder = JSONDecoder()
let gameData = try decoder.decode(GameData.self, from: inputData)

print(gameData.objects["Circle"]!)
print(gameData.objects["Square"]!)
print(gameData.objects["Triangle"]!)

//: If we wanted to encode object data as JSON, we'd do something like:
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let outputData = try encoder.encode(gameData)
let outputString = String(data: outputData, encoding: .utf8)

//: [Next](@next)
