//
//  FilmListViewController.swift
//  StarWars
//
//  Created by ShengHua Wu on 12/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

class FilmListViewController: UIViewController {
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let webService = WebService()
        webService.load(resource: Film.all) { (result) in
            switch result {
            case let .success(films):
                print(films)
            case let .failure(error):
                print(error)
            }
        }
    }
}
