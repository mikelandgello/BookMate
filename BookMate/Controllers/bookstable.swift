//
//  bookstable.swift
//  BookMate
//
//  Created by Dmitriy Piskunov on 29.10.21.
//

import UIKit

class bookstable: UITableViewController {

    // Тут наполняется структура, заданная в ячейке BookShelf
    var base: [library] = [
    library(bookTitle: "Palanik", bookRating: 44, bookJanre: "Fiction"),
    library(bookTitle: "Bredberry", bookRating: 55, bookJanre: "Detective"),
    library(bookTitle: "Potter", bookRating: 66, bookJanre: "Non-fiction"),
    library(bookTitle: "OZzy", bookRating: 43, bookJanre: "Fiction"),
    library(bookTitle: "Holms", bookRating: 99, bookJanre: "Detective"),
    library(bookTitle: "Begger", bookRating: 6, bookJanre: "Non-fiction"),
    ]
    
    // Тут считается массив состоящий из существующих в базе жанров (1)
    var takeSection: [String] {
        let janre = base.compactMap({ $0.bookJanre })
        let set = Set(janre)
        print (set)
        return set.sorted()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // регистрируем ячейку
        let nib = UINib(nibName: "bookShelf", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: bookShelf.identifier)
    }
    
        // Хитрая функция выдающая книжки по каждому входящему жанру, созданному в (1)
    private func filterBooksFor(janre: String) -> [library] {
        let filtered = base.filter ({$0.bookJanre == janre})
        print (filtered)
        return filtered
    }
    
    
    // MARK: - Table view data source
        //Number of sections is equal to number of janres
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return takeSection.count
    }
    
//Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let classString = takeSection[section]
                let books =  filterBooksFor(janre: classString)
                return books.count
    }

    // Отсылаем систему к NIB файлу ячейки. Потом вызываем из ячейки функцию, присваювающую лэйблам необходимые значения
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookShelf", for: indexPath) as! bookShelf
        
        let janre = takeSection[indexPath.section]
        let booksInJ = filterBooksFor(janre: janre)
        cell.input(with: booksInJ[indexPath.row])
        
        return cell
    }
        // скопипащенный хэдер
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .green
        let label = UILabel(frame: CGRect(x: 0, y: 10,
                                          width: tableView.frame.width,
                                          height: 15))
        
        label.text = takeSection[section]
        label.textAlignment = .center
        label.textColor = .black
        header.addSubview(label)
        
        return header
}
    //скопипащенный футтуер
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let futter = UIView()
        futter.backgroundColor = .blue
        let janre = base.compactMap({ $0.bookJanre })

        let label = UILabel(frame: CGRect(x: 0, y: 10,
                                          width: tableView.frame.width,
                                          height: 15))
        
        
        let classString = takeSection[section]
        let books =  filterBooksFor(janre: classString)
        
        let rating = books.compactMap({ $0.bookRating }).reduce(0, +)
                
        
        label.text = "number of books \(books.count), average rating \(rating/books.count)"
        label.textAlignment = .center
        label.textColor = .white
        futter.addSubview(label)

        return futter
    }
    
    //Adding cells
 
    @IBAction func plus(_ sender: UIBarButtonItem) {
        let name = bookstable.randomFakeFirstName()
        let janre = bookstable.randomFakeJanre()
        var plus = library(bookTitle: name, bookRating: Int.random(in: 0...100), bookJanre: janre)
        base.append(plus)
        tableView.reloadData()
    }
        public static func randomFakeFirstName() -> String {
            let firstNameList = ["Henry", "William", "Geoffrey", "Jim", "Yvonne", "Jamie", "Leticia", "Priscilla", "Sidney", "Nancy", "Edmund", "Bill", "Megan"]
            return firstNameList.randomElement()!
        }
    
    public static func randomFakeJanre() -> String {
        let janreList = ["Fiction", "Detective", "Non-fiction"]
        return janreList.randomElement()!
    }
    
    
    
    
}
