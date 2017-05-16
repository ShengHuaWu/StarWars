## ReSwift at First Glance
Recently, I watched a [video](https://news.realm.io/news/krzysztof-zablocki-mDevCamp-ios-architecture-mvvm-mvc-viper/) which was talking about iOS architecture and the lecturer mentioned an architecture called ReSwift during the talk.
Couple days later, the name appeared again from the [SwiftCoder podcast](https://swiftcoders.podbean.com).
Therefore, I decided to do some research and tried to figure it out.

### Introduction
The followings are cited from [ReSwift's GitHub page](https://github.com/ReSwift/ReSwift).
ReSwift is a Redux-like implementation of the unidirectional data flow architecture in Swift.
ReSwift helps you to separate three important concerns of your app’s components:
- State: in a ReSwift app the entire app state is explicitly stored in a data structure.
- Views: in a ReSwift app your views update when your state changes. Your views become simple visualizations of the current app state.
- State Changes: in a ReSwift app you can only perform state changes through actions. Actions are small pieces of data that describe a state change.

![ReSwift](https://github.com/ShengHuaWu/StarWars/blob/master/Resources/ReSwift.png)

ReSwift relies on a few principles:
- The Store stores your entire app state in the form of a single data structure.
This state can only be modified by dispatching Actions to the store.
Whenever the state in the store changes, the store will notify all observers.
- Actions are a declarative way of describing a state change.
Actions don't contain any code, they are consumed by the store and forwarded to reducers.
- Reducers will handle the actions by implementing a different state change for each action.
Reducers provide pure functions, that based on the current action and the current app state, create a new app state.

### Demonstration

### Conclusion
The unidirectional flow means that all data in an application follows the same lifecycle pattern, making the logic of your app more predictable and easier to understand.
It also encourages data normalization, so that you don't end up with multiple, independent copies of the same data that are unaware of one another.
Store, state, actions, and reducers are simple structs or functions and it's easier to maintain and test.
By drastically limiting the way state can be mutated, your app becomes easier to understand and it gets easier to work with many collaborators.
