//
//  Book.swift
//  GoogleSearch
//
//  Created by Oleg Bakatin on 16.02.2020.
//  Copyright © 2020 Oleg Bakatin. All rights reserved.
//

import Foundation

class Book: Decodable {
    var title: String?
    var image: String?
    var description: String?
    
    init(title: String, image: String, description: String) {
        self.title = title
        self.image = image
        self.description = description
    }
    
    init () {}
    
    private enum VolumeCodingKey: String, CodingKey {
        case volumeInfo
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageLinks
    }
    
    private enum ImageCodingKey: String, CodingKey {
        case thumbnail
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: VolumeCodingKey.self)
        
        let volumeContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .volumeInfo)

        self.title = try volumeContainer.decode(String.self, forKey: .title)
        self.description = try? volumeContainer.decode(String.self, forKey: .description)

        let imagesContainer = try volumeContainer.nestedContainer(keyedBy: ImageCodingKey.self, forKey: .imageLinks)
        self.image = try imagesContainer.decode(String.self, forKey: .thumbnail)
    }
}
