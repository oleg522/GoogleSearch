//
//  SearchPresenter.swift
//  GoogleSearch
//
//  Created by Oleg Bakatin on 16.02.2020.
//  Copyright © 2020 Oleg Bakatin. All rights reserved.
//

import Foundation
import UIKit

class SearchPresenter: NSObject {
    
    var showMessage: ((_ message: String) -> Void)?
    var showBooks: ((_ books: [Book]) -> Void)?
    
    var searchingRequests = [String: Bool]()
    var lastSearchingRequest = ""
    
    weak var api: API? = ServiceLocator.shared.tryGetService()
    
}

// MARK: - Other Functions
extension SearchPresenter {
    
    func search(text: String) {
        
        lastSearchingRequest = text
        if searchingRequests[text] ?? false {
            return
        }
        searchingRequests[text] = true
        guard !text.isEmpty else { return }
        let req = APISearchBooksRequest(text: text)
        api?.searchBooks(req: req) { [weak self, text] result in
            guard let self = self else { return }
            self.searchingRequests.removeValue(forKey: text)
            switch result {
            case .success(let books):
                print("success")
                if text == self.lastSearchingRequest {
                    self.showBooks?(books.items)
                }
            case .failure(let error):
                print("fail")
                self.showMessage?(error.messageToDisplay)
            }
            if self.lastSearchingRequest == text {
                self.lastSearchingRequest = ""
            }
        }
    }
}
