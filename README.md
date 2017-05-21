## ReSwift at First Glance
Recently, I watched a [video](https://news.realm.io/news/krzysztof-zablocki-mDevCamp-ios-architecture-mvvm-mvc-viper/) which was talking about iOS architecture and the lecturer mentioned an architecture called ReSwift during the talk.
Couple days later, the name appeared again in one episode of [SwiftCoder podcast](https://swiftcoders.podbean.com).
Therefore, I decided to do some research and tried to figure it out.

### Introduction
The followings are cited from [ReSwift's GitHub page](https://github.com/ReSwift/ReSwift).
ReSwift is a Redux-like implementation of the unidirectional data flow architecture in Swift.
ReSwift helps you to separate three important concerns of your app’s components:
- State: in a ReSwift app the entire app state is explicitly stored in a data structure.
- Views: in a ReSwift app your views update when your state changes. Your views become simple visualizations of the current app state.
- State Changes: in a ReSwift app you can only perform state changes through actions. Actions are small pieces of data that describe a state change.

![ReSwift](https://github.com/ShengHuaWu/StarWars/blob/master/Resources/ReSwift.png)

ReSwift also relies on a few principles:
- The Store stores your entire app state in the form of a single data structure.
This state can only be modified by dispatching Actions to the store.
Whenever the state in the store changes, the store will notify all observers.
- Actions are a declarative way of describing a state change.
Actions don't contain any code, they are consumed by the store and forwarded to reducers.
- Reducers will handle the actions by implementing a different state change for each action.
Reducers provide pure functions, that based on the current action and the current app state, create a new app state.

### Demonstration
I will demonstrate how to adopt ReSwift in a simple project.
This project uses [SWAPI](https://swapi.co) to fetch the films of Star Wars and displays them within a table view.
The following is the visual presentation of my view controller.

![Sample](https://github.com/ShengHuaWu/StarWars/blob/master/Resources/Sample.png)

Let's start to define my `State`.
Because my project is quite simple, I just use an `enum` to describe the `FilmsState`.
```
struct AppState: StateType {
    let filmsState: FilmsState
}

enum FilmsState {
    case loading
    case finished([Film])
}
```
Secondly, I create three different `Action`s, including `LoadingFilmsAction`, `SetFilmsAction`, and `fetchFilms`.
Since the films' data is fetched from SWAPI and this action is asynchronous, `fetchFilms` is actually an `ActionCreator` instead of an `Action` type.
After fetching films' data finishes, I use the `Store` to dispatch a `SetFilmsAction` in order to update the table view.
Besides, I write a `WebService` class to handle the networking operation, you can find more details in [this article](https://medium.com/@shenghuawu/web-service-in-swift-86b4fa25a92c).
```
struct LoadingFilmsAction: Action {}

struct SetFilmsAction: Action {
    let films: [Film]
}

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

        return LoadingFilmsAction()
    }
}
```
The `Reducer` of my project is very simple as well and it just returns a new `State` based on a previous `State` and an incoming `Action`.
```
func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(filmsState: filmsReducer(action: action, state: state?.filmsState))
}

func filmsReducer(action: Action, state: FilmsState?) -> FilmsState {
    switch action {
    case let action as SetFilmsAction:
        return .finished(action.films)
    case _ as LoadingFilmsAction:
        return .loading
    default:
        return state ?? .finished([])
    }
}
```
Then, I create the `mainStore` of my project inside the file of `AppDelegate` as a global variable.
```
let mainStore = Store<AppState>(reducer: appReducer, state: nil)
```
Finally, I hook everything up in my `FilmListViewController`.
Let `FilmListViewController` conform to `StoreSubscriber` protocol and implement `newState` method in order to update UI.
```
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
```
Subscribe `State` changes in `viewDidLoad` method and do the unsubscription in `deinit` method.
```
override func viewDidLoad() {
    // ...

    mainStore.subscribe(self) { (subscription) in
        subscription.select { (state) in
            state.filmsState
        }
    }
}

deinit {
    mainStore.unsubscribe(self)
}
```
Dispatch `fetchFilms` action in `viewDidLoad` method and it will trigger the loading view and fetch films' data via SWAPI.
```
override func viewDidLoad() {
    // ...

    mainStore.dispatch(fetchFilms())
}
```
The sample project is [here](https://github.com/ShengHuaWu/StarWars).

### Conclusion
The unidirectional flow means that all data in an application follows the same lifecycle pattern, making the logic of your app more predictable.
By drastically limiting the way state can be mutated, your app becomes easier to understand and it gets easier to work with many collaborators.
It also encourages data normalization, so that you don't end up with multiple, independent copies of the same data that are unaware of one another.
Furthermore, `Store`, `State`, `Action`s, and `Reducer`s are simple structs or functions and it's easier to maintain and test.
I personally think that it's great way to establish a complex app and to collaborate with many team members in the same project.
Any comment and feedback are welcome, so please share your thoughts. Thank you.
