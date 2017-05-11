//
//  ViewController.swift
//  StarWars
//
//  Created by ShengHua Wu on 11/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://swapi.co/api/films")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
            }
        }.resume()
    }
}

