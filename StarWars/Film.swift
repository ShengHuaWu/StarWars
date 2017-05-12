//
//  Film.swift
//  StarWars
//
//  Created by ShengHua Wu on 12/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case missing(String)
}

struct Film {
    let director: String
    let producer: String
    let title: String
    let episodeID: Int
    let openingCrawl: String
}

typealias JSONDictionary = [String : Any]

extension Film {
    init(json: JSONDictionary) throws {
        guard let director = json["director"] as? String else {
            throw SerializationError.missing("director")
        }
        
        guard let producer = json["producer"] as? String else {
            throw SerializationError.missing("producer")
        }
        
        guard let title = json["title"] as? String else {
            throw SerializationError.missing("title")
        }
        
        guard let episodeID = json["episode_id"] as? Int else {
            throw SerializationError.missing("episode_id")
        }
        
        guard let openingCrawl = json["opening_crawl"] as? String else {
            throw SerializationError.missing("opening_crawl")
        }
        
        self.director = director
        self.producer = producer
        self.title = title
        self.episodeID = episodeID
        self.openingCrawl = openingCrawl
    }
}

extension Film {
    static let all = Resource<[Film]>(url: URL(string: "http://swapi.co/api/films")!, parseJSON: { json in
        guard let dictionary = json as? JSONDictionary,
            let results = dictionary["results"] as? [JSONDictionary] else {
            throw SerializationError.missing("results")
        }
        
        return try results.map(Film.init)
    })
}
