import UIKit

struct DataModel: Codable {
    var title : String
    var number : Int
}

let data = DataModel(title: "one", number: 1)
let encoder = JSONEncoder()
let jsonData = try? encoder.encode(data)

if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8) {
        print(jsonString)
}
