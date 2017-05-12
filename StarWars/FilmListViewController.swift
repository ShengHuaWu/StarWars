//
//  FilmListViewController.swift
//  StarWars
//
//  Created by ShengHua Wu on 12/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit
import ReSwift

// MARK: - Film List View Controller
class FilmListViewController: UIViewController {
    // MARK: Properties
    fileprivate lazy var tableView: UITableView = {
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
        
        view.addSubview(tableView)
        
        mainStore.subscribe(self)
        
        mainStore.dispatch(fetchFilms)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    deinit {
        mainStore.unsubscribe(self)
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

// MARK: - Store Subscriber
extension FilmListViewController: StoreSubscriber {
    func newState(state: AppState) {
        films = state.filmsState.films
        tableView.reloadData()
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
