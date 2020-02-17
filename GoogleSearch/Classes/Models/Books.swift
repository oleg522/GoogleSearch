//
//  Books.swift
//  GoogleSearch
//
//  Created by Oleg Bakatin on 16.02.2020.
//  Copyright © 2020 Oleg Bakatin. All rights reserved.
//

import Foundation

class Books: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    let items: [Book]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([Book].self, forKey: .items)
    }
    
    init(books: [Book]) {
        self.items = books
    }
}


