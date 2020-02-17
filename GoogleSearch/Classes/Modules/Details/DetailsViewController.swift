//
//  DetailsViewController.swift
//  GoogleSearch
//
//  Created by Oleg Bakatin on 17.02.2020.
//  Copyright © 2020 Oleg Bakatin. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var bookText: UITextView!
    @IBOutlet weak var bookImage: UIImageView!
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Private and setup function
extension DetailsViewController {
    
    private func setup() {
        guard let book = book else { return }
        title = book.title
        bookText.text = book.description ?? "No description"
        if let image = book.image {
            bookImage.downloaded(from: image)
        } else {
            bookImage.image = UIImage(named: "book-cover-placeholder")
        }
    }
}
