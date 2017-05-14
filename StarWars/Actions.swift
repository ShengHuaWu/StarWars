//
//  Actions.swift
//  StarWars
//
//  Created by ShengHua Wu on 12/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import ReSwift

// MARK: - Action Creator
func fetchFilms(with webService: WebServiceProtocol = WebService()) -> (AppState, Store<AppState>) -> Action? {
    return { state, store in
        webService.load(resource: Film.all, completion: { (result) in
            switch result {
            case let .success(films):
                store.dispatch(SetFilmsAction(films: films))
            case let .failure(error):
                print(error)
            }
        })
        
        // Return nil will NOT execute the reducer.
        return LoadingFilmsAction()
    }
}

// MARK: - Action
struct LoadingFilmsAction: Action {}

struct SetFilmsAction: Action {
    let films: [Film]
}
