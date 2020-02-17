//
//  API.swift
//  GoogleSearch
//
//  Created by Oleg Bakatin on 16.02.2020.
//  Copyright © 2020 Oleg Bakatin. All rights reserved.
//

import Foundation

protocol API: class {
    
    // google token
    var token: String? { get }
    
    typealias SearchBooksResult = APIResult<Books>
    func searchBooks(req: APISearchBooksRequest, completion: @escaping (SearchBooksResult) -> Void)
    
}

typealias APIResult<A> = Result<A, APIError>

struct APIError: Error {
    // error message from API response
    var message = ""
    
    // error message to display
    var messageToDisplay: String {
        return message.isEmpty ? "Unknown error. Please try again." : message
    }
    
    // client side errors
    static func unknown() -> APIError {
        return APIError()
    }
    
    static func noInternet() -> APIError {
        return APIError(
            message: "Please connect to a Wi-Fi or mobile network and try again."
        )
    }
}

struct APISearchBooksRequest {
    var text = ""
}
