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
    
    fileprivate lazy var loadingView = LoadingView(frame: .zero)
    
    fileprivate var films = [Film]()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(loadingView)
                
        mainStore.subscribe(self) { (subscription) in
            subscription.select { (state) in
                state.filmsState
            }
        }
        
        mainStore.dispatch(fetchFilms)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
        loadingView.frame = view.bounds
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
    func newState(state: FilmsState) {
        switch state {
        case .loading:
            loadingView.isHidden = false
            loadingView.startAnimating()
            tableView.reloadData()
        case let .finished(films):
            self.films = films
            loadingView.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        }
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

// MARK: - Loading View
final class LoadingView: UIView {
    // MARK: Properties
    private lazy var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    // MARK: Designated Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        addSubview(spinner)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        spinner.sizeToFit()
        spinner.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    // MARK: Animate
    func startAnimating() {
        spinner.startAnimating()
    }
}
