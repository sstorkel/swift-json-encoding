//: [Previous](@previous)
/*:
 # Solutions
 Federico's [blog post](https://www.fivestars.blog/articles/codable-swift-dictionaries) cover several
 good workarounds for this issue, including a slick `@propertyWrapper` that makes using `enum` keys
 almost effortless. 
 
 If you're also dealing with a case where your JSON structure doesn't map easily to Swift model
 objects then a [solution suggested by John Sundell](https://www.swiftbysundell.com/basics/codable/)
 might make more sense. We'll explore that below
 */
//: We start with the same object definitions from last time:
import Foundation

enum Shape: String {
    case Circle
    case Line
    case Triangle
    case Square
    case Pentagon
    case Hexagon
}

struct GameData {
    let objects: [Shape: [Int]]
}

//: But we also add an object that provides a direct mapping to the JSON we want to generate and parse
struct JSONGameData: Codable {
    let objects: [String: [Int]]
}

//: And we add extensions that allow us to freely convert between `GameData` and `JSONGameData`
extension GameData {
    var jsonGameData: JSONGameData {
        var jsonGameData = JSONGameData(objects: Dictionary(uniqueKeysWithValues: self.objects.map { key, value in (key.rawValue, value) }))
        return jsonGameData
    }
}

extension JSONGameData {
    var gameData: GameData {
        return GameData(objects: Dictionary(uniqueKeysWithValues: self.objects.map { key, value in (Shape(rawValue: key)!, value) }))
    }
}

//: Now we can encode `GameData` by converting it into `JSONGameData`
let sampleData = GameData(objects: [
    .Circle: [1, 2, 3],
    .Line: [4, 5, 6],
    .Triangle: [7, 8, 9]
])

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let outputData = try encoder.encode(sampleData.jsonGameData)
let outputString = String(data: outputData, encoding: .utf8)

//: Similarly, we can decode our JSON into `JSONGameData` then convert it into `GameData`
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
let data = try decoder.decode(JSONGameData.self, from: inputData)
let gameData = data.gameData

print(gameData.objects[.Circle]!)
print(gameData.objects[.Square]!)
print(gameData.objects[.Triangle]!)

//: [Next](@next)
