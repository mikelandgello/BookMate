//
//  bookShelf.swift
//  BookMate
//
//  Created by Dmitriy Piskunov on 30.10.21.
//

import UIKit


struct library {
let bookTitle: String
let bookRating: Int
let bookJanre: String
}


class bookShelf: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var janreLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
        // Configure the view for the selected state
    }
    static let identifier = "bookShelf"
    
    func input (with: library) {
        nameLabel.text = "Автор: \(with.bookTitle)"
        janreLabel.text = "Жанр: \(with.bookJanre)"
        descriptionLabel.text = "Score: \(with.bookRating)"
    }
    
    
}


