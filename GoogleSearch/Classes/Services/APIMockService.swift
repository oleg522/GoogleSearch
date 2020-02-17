//
//  APIMockService.swift
//  GoogleSearch
//
//  Created by Oleg Bakatin on 16.02.2020.
//  Copyright © 2020 Oleg Bakatin. All rights reserved.
//

import Foundation

class APIMockService: API {
    var token: String?
    
    func searchBooks(req: APISearchBooksRequest, completion: @escaping (SearchBooksResult) -> Void) {
        let mysteriousIsland = Book(title: "Mysterious Island", image: "https://i.ebayimg.com/images/g/l~EAAOSwa6heICV~/s-l300.jpg", description: "The Mysterious Island is a novel by Jules Verne, published in 1874. The original edition, published by Hetzel, contains a number of illustrations by Jules Férat. The novel is a crossover sequel to Verne's famous Twenty Thousand Leagues Under the Sea and In Search of the Castaways, though its themes are vastly different from those books.")
        
        let nineteenEightyFour = Book(title: "1984", image: "https://upload.wikimedia.org/wikipedia/en/c/c3/1984first.jpg", description: "Nineteen Eighty-Four: A Novel, often published as 1984, is a dystopian novel by English novelist George Orwell. It was published in June 1949 by Secker & Warburg as Orwell's ninth and final book completed in his lifetime.")
        
        let books = Books(books: [mysteriousIsland, nineteenEightyFour])
        completion(.success(books))
    }
}
