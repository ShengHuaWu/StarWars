//
//  State.swift
//  StarWars
//
//  Created by ShengHua Wu on 12/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    let filmsState: FilmsState
}

enum FilmsMode {
    case loading
    case finished([Film])
}

struct FilmsState: StateType {
    let mode: FilmsMode
}
