# MetFlix Application - Core Abstractions

| Movies List (without Debugger) | Movies Detail (without Debugger) | Movies Detail (Debugger) |
|-------|-------|-------|
|  <video width="250" height="400" src="https://github.com/syedqamara/MetFlix/raw/main/assets/5058871/9a7b4954-7865-420e-879a-87c45b4d003c" type="video/mp4"></video>  | <video width="250" height="400" src="https://github.com/syedqamara/MetFlix/assets/5058871/b139d84d-21c9-45d7-b717-c26098601a7c" type="video/mp4"></video>   | <video width="250" height="400" src="https://github.com/syedqamara/MetFlix/assets/5058871/1d81bfee-03c6-4c5b-95f1-31cab8d48f98" type="video/mp4"></video>   |







## `UIModeling` Protocol

```swift
// MARK: - App Abstracts

/**
 A protocol representing the UI model for views in the MetFlix application.
 
 - Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s `UIModel` protocol with associated type `DataModelType` restricted to `DataModel`.
 */
public protocol UIModeling: UIModel where DataModelType: DataModel {
    
}
```
## `HomeViewModeling` Protocol

```swift
// MARK: - Home Module Abstracts

/**
 A protocol defining the view model for the Home module in the MetFlix application.
 
 - Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s `ViewModeling` protocol.
 */
public protocol HomeViewModeling: ViewModeling {
    var error: Error? { get }
    var isLoading: Bool { get }
    var search: String { get set }
    var movies: [MovieUIM] { get set }
    
    func onAppear()
    func loadNextPage()
}
```

## `HomeViewProtocol` Protocol

```swift
/**
 A protocol representing the view for the Home module in the MetFlix application.
 
 - Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s `SwiftUIView` protocol.
 */
public protocol HomeViewProtocol: SwiftUIView {
    
}
```

## `MovieDetailViewProtocol` Protocol

```swift
// MARK: - Movie Detail Module Abstracts

/**
 A protocol representing the view for the Movie Detail module in the MetFlix application.
 
 - Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s `SwiftUIView` protocol.
 */
public protocol MovieDetailViewProtocol: SwiftUIView {
    
}
```

## `MovieDetailViewModeling` Protocol

```swift
/**
 A protocol defining the view model for the Movie Detail module in the MetFlix application.
 
 - Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s `ViewModeling` protocol.
 */
public protocol MovieDetailViewModeling: ViewModeling {
    var movieId: Int { get set }
    var movieDetail: MovieDetailUIM? { get }
    var error: Error? { get }
    var isLoading: Bool { get }
    func onAppear()
}
```

## `MovieServiceProtocol` Protocol

```swift
// MARK: - Movie Service Abstract

/**
 A protocol defining the services for movie-related operations in the MetFlix application.
 
 - Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s service protocol with asynchronous methods.
 */
public protocol MovieServiceProtocol {
    func getPopular(query: PopularMovieQueryParameters) async throws -> PaginatedResult<Movie>
    func get(by id: String) async throws -> MovieDetail
}
```

## `CacheManagerProtocol` Protocol

```swift
// MARK: - Cache Manager Abstract

/**
 A protocol defining the cache management operations for the MetFlix application.
 
 - Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s cache manager protocol.
 */
protocol CacheManagerProtocol {
    func insert<V>(value: V, for key: String)
    func remove(for key: String)
    func get<V>(valuefor key: String) -> V?
}
```

For more detailed documentation on the `core_architecture` library, visit [core_architecture Documentation](https://github.com/syedqamara/core_architecture).

---

**Author:**

[Syed Qamar Abbas](https://github.com/syedqamara)
```

This Markdown document provides an overview of the MetFlix application's core abstractions, connecting them to the `core_architecture` library and providing a link to the library's documentation. It concludes with the author's details and a link to their GitHub profile.
