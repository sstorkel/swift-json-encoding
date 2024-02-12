//: [Previous](@previous)
/*:
 # Encoding Problems
 
 This works great, but what if we want to leverage some of the advanced capabilites
 of Swift? Let's assume that our game has a finite number of geometric objectst that our
 player can collect. In that case, we might want to represent those objects using a Swift
 `enum` for additional type safety.
 */
import Foundation

enum Shape: String, Codable {
    case Circle
    case Line
    case Triangle
    case Square
    case Pentagon
    case Hexagon
}

struct GameData: Codable {
    let objects: [Shape: [Int]]
}

let gameData = GameData(objects: [
    .Circle: [1, 2, 3],
    .Line: [4, 5, 6],
    .Triangle: [7, 8, 9]
])

/*:
 Looking at our new versions of `Shape` and `GameData`, you might think that our JSON representation
 would be relatively similar:
 
    {
      "objects": {
        "Circle": [1, 2, 3],
        "Line": [4, 5, 6],
        "Triangle": [7, 8, 9]
      }
    }
 
  Unfortunately, Swift does something *completely* unexpected! Let's take a look:
 */
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let outputData = try encoder.encode(gameData)
let outputString = String(data: outputData, encoding: .utf8)

/*:
 If you look at the `outputString` you'll see that there's a subtle but *important* difference:
 rather than `"objects"` being a JSON dictionary, it's actually encoded as an ***Array*** where
 the keys and the values alternate. That definitely isn't what we want!
 ```
 {
   "objects" : [ // ← note the square rather than curly bracket!
     "Circle",
     [
       1,
       2,
       3
     ],
     "Line",
     [
       4,
       5,
       6
     ],
     "Triangle",
     [
       7,
       8,
       9
     ]
   ]             // ← note the square rather than curly bracket!
 }
 ```
 # What's Happening?
 
 This weird behavior isn't documented anywhere, but Federico Zanetello has written a great
 blog post explaining what's happening: [Encoding and decoding Swift dictionaries with 
 custom key types](https://www.fivestars.blog/articles/codable-swift-dictionaries).
 
 It turns out that `JSONEncoder` and `JSONDecoder` will ***only*** generate JSON dictionaries
 if the keys for a dictionary are `String` or `Int`. If the dictionary uses any other type for
 the key, you end up with an array that alternates keys and values. 
 
 Federico even has a link [to the relevant
 source code](https://github.com/apple/swift/blob/d2085d8b0ed69e40a10e555669bb6cc9b450d0b3/stdlib/public/core/Codable.swift.gyb#L1967) showing the problem.
 */
//: [Next](@next)
