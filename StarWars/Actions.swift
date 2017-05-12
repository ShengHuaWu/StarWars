//
//  Actions.swift
//  StarWars
//
//  Created by ShengHua Wu on 12/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import ReSwift

// MARK: - Action Creator
func fetchFilms(state: AppState, store: Store<AppState>) -> Action? {
    let webService = WebService()
    webService.load(resource: Film.all, completion: { (result) in
        switch result {
        case let .success(films):
            mainStore.dispatch(SetFilmsAction(films: films))
        case let .failure(error):
            print(error)
        }
    })
    
    return nil // Return nil will NOT execute the reducer.
}

// MARK: - Action
struct SetFilmsAction: Action {
    let films: [Film]
}