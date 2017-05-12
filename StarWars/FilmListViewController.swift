//
//  FilmListViewController.swift
//  StarWars
//
//  Created by ShengHua Wu on 12/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - Film List View Controller
class FilmListViewController: UIViewController {
    // MARK: Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(FilmCell.self, forCellReuseIdentifier: FilmCell.description())
        tableView.dataSource = self
        return tableView
    }()
    
    fileprivate var films = [Film]()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let webService = WebService()
        webService.load(resource: Film.all) { (result) in
            switch result {
            case let .success(films):
                self.films = films
                self.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
        
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }
}

// MARK: - Table View Data Source
extension FilmListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmCell.description(), for: indexPath)
        let film = films[indexPath.row]
        cell.textLabel?.text = film.title
        cell.detailTextLabel?.text = film.director
        return cell
    }
}

// MARK: - Film Cell
final class FilmCell: UITableViewCell {
    // MARK: Designated Initializer
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
