//
//  Actions.swift
//  StarWars
//
//  Created by ShengHua Wu on 12/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import ReSwift

struct FetchFilmAction: Action {
    let resource = Film.all
}

struct AssignFilmAction: Action {
    let films: [Film]
}
