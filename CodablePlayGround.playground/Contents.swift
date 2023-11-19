import UIKit

var greeting = "Hello, playground"


let myJson = """
[
  {
    "book": {
      "author": "Robin",
      "language": "IN"
    },
    "library": [
      {
        "location": "India",
        "city": "Pune"
      },
      {
        "location": "Europe",
        "city": "Moscow"
      }
    ]
  },
  {
    "book": {
      "author": "Chetan",
      "language": "IN"
    },
    "library": {
      "location": "India",
      "city": "Mumbai"
    }
  }
]
"""


struct BookStores: Decodable {
    enum CodingKeys: String, CodingKey {
        case book
        case library
    }
    struct Book: Decodable {
        let author: String
        let language: String
    }
    struct Library: Decodable {
        let location: String
        let city: String
    }
   
    let book: Book
    let library: [Library]
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.book = try container.decode(Book.self, forKey: .book)
        do {
            self.library = try container.decode([Library].self, forKey: .library)
        } catch(_) {
            let newDictionaryLibrary = try container.decode(Library.self, forKey: .library)
            self.library = [newDictionaryLibrary]
        }
       
    }
}

let decoder = JSONDecoder()
let data = myJson.data(using: .utf8)!
let stores = try! decoder.decode([BookStores].self, from: data)
for (index, stores) in stores.enumerated() {
    for library in stores.library {
        print(library.city)
    }
}

