# MetFlix Application - Core Abstractions

MetFlix Application uses my swift package named [core_architecture](https://github.com/syedqamara/core_architecture)

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
- Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s `UIModel` protocol with associated type `DataModelType` restricted to `DataModel`.

## `HomeViewProtocol` Protocol

```swift
/**
 A protocol representing the view for the Home module in the MetFlix application.
 
 - Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s `SwiftUIView` protocol.
 */
public protocol HomeViewProtocol: SwiftUIView {
    
}
```
- Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s `SwiftUIView` protocol.

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
- Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s `SwiftUIView` protocol.

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
- Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s `ViewModeling` protocol.

### `HomeViewModeling` Protocol

The `HomeViewModeling` protocol defines the view model interface for the Home module in the MetFlix application. This protocol conforms to the `ViewModeling` protocol provided by [core_architecture](https://github.com/syedqamara/core_architecture), indicating its role as a view model within a broader architecture.

#### Properties

1. **`error`**
   - *Type:* `Error?`
   - *Description:* An optional property that represents any error that might occur during the data-fetching process. This property allows the view to react to and display error states appropriately.

2. **`isLoading`**
   - *Type:* `Bool`
   - *Description:* A boolean property that signals whether the view model is currently in the process of loading data. This property helps the view manage and display loading indicators as needed.

3. **`search`**
   - *Type:* `String`
   - *Description:* A property representing the search query string for movies in the Home module. The view can bind to this property to enable user interaction and searching functionality.

4. **`movies`**
   - *Type:* `[MovieUIM]`
   - *Description:* An array of `MovieUIM` objects representing the movies to be displayed in the Home module. The view can bind to this property to dynamically update the displayed movies.

#### Methods

1. **`onAppear()`**
   - *Description:* A method that the view can call when it appears on the screen. This method is typically used to trigger the initial loading of data, such as fetching a list of movies. It can include logic for handling initial setup and data loading.

2. **`loadNextPage()`**
   - *Description:* A method responsible for loading the next page of movies in a paginated list. This method can be called when the user scrolls to the bottom of the movie list, indicating a need for more data.

#### Conformance Note

- *Note:* This protocol conforms to the `ViewModeling` protocol from [core_architecture](https://github.com/syedqamara/core_architecture), ensuring consistency and adherence to the architecture's design principles. This conformance implies that the `HomeViewModeling` protocol serves as a specific implementation of the more general `ViewModeling` protocol within the MetFlix application.

### Example Usage

```swift
// Create an instance of a type conforming to HomeViewModeling
var homeViewModel: HomeViewModeling = // ...

// Accessing properties
let currentError = homeViewModel.error
let isLoading = homeViewModel.isLoading
let currentSearchQuery = homeViewModel.search
let currentMovies = homeViewModel.movies

// Triggering initial loading
homeViewModel.onAppear()

// Loading the next page
homeViewModel.loadNextPage()
```

**Note:** Implementations of this protocol would typically include additional logic, such as networking calls to fetch movie data, data processing, and state management. This protocol serves as a contract for creating Home module-specific view models within the MetFlix application.

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
- Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s `ViewModeling` protocol.

Certainly! Let's break down the components of the `MovieDetailViewModeling` protocol and provide documentation for each part:

### `MovieDetailViewModeling` Protocol

The `MovieDetailViewModeling` protocol is designed to represent the ViewModel for displaying detailed information about a movie. It conforms to the `ViewModeling` protocol, indicating its role as a view model responsible for managing the presentation logic and data for a corresponding view.

#### Properties

1. **`movieId`**
   - *Type:* `Int`
   - *Description:* An integer property representing the unique identifier of the movie for which detailed information is being displayed. This property is both readable and writable, allowing the view model to dynamically update the associated movie.

2. **`movieDetail`**
   - *Type:* `MovieDetailUIM?`
   - *Description:* An optional property representing the detailed UI model (`MovieDetailUIM`) for the associated movie. This property is read-only and provides a structured representation of the movie details for consumption by the view.

3. **`error`**
   - *Type:* `Error?`
   - *Description:* An optional property indicating any error that might occur during the process of fetching or updating movie details. This property allows the view model to communicate error states to the associated view.

4. **`isLoading`**
   - *Type:* `Bool`
   - *Description:* A boolean property indicating whether the view model is currently in the process of loading movie details. This property helps the view to manage and display loading indicators appropriately.

#### Methods

1. **`onAppear()`**
   - *Description:* A method that the view can call when it appears on the screen. This method is typically used to trigger the initial loading of movie details. It can include logic for fetching data, handling initial setup, and managing other tasks related to the appearance of the associated view.

### Example Usage

```swift
// Create an instance of a type conforming to MovieDetailViewModeling
var movieDetailViewModel: MovieDetailViewModeling = // ...

// Accessing properties
let currentMovieId = movieDetailViewModel.movieId
let currentMovieDetail = movieDetailViewModel.movieDetail
let currentError = movieDetailViewModel.error
let isLoading = movieDetailViewModel.isLoading

// Triggering initial loading
movieDetailViewModel.onAppear()
```

**Note:** Implementations of this protocol would typically include additional logic, such as networking calls to fetch movie details, data processing, and handling state changes. This protocol serves as a blueprint for creating view models specific to movie detail views within a larger architecture.

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
- Note: Conforms to [core_architecture](https://github.com/syedqamara/core_architecture)'s service protocol with asynchronous methods.

### `MovieServiceProtocol` 

The `MovieServiceProtocol` is a protocol that defines the services for movie-related operations in the MetFlix application. It outlines the methods required for fetching information about popular movies and retrieving detailed information about a specific movie. This protocol conforms to the service protocol provided by [core_architecture](https://github.com/syedqamara/core_architecture), and all its methods are asynchronous.

#### Protocol Methods

1. **`getPopular(query:)`**
   - *Description:* Fetches a paginated list of popular movies based on the provided query parameters.
   - *Parameters:*
     - `query`: An instance of `PopularMovieQueryParameters` containing parameters for the query, such as page number, sorting criteria, etc.
   - *Returns:* An asynchronous result (`async throws`) containing a `PaginatedResult` of `Movie` objects.
   - *Throws:* An error if the operation encounters any issues.

2. **`get(by:)`**
   - *Description:* Fetches detailed information about a specific movie based on its unique identifier.
   - *Parameters:*
     - `id`: A string representing the unique identifier of the movie.
   - *Returns:* An asynchronous result (`async throws`) containing detailed information about the movie in the form of a `MovieDetail` object.
   - *Throws:* An error if the operation encounters any issues.

#### Conformance Note

- *Note:* This protocol conforms to the service protocol provided by [core_architecture](https://github.com/syedqamara/core_architecture). The conformance indicates that this protocol follows the design principles and conventions established by the core architecture, ensuring consistency in service-related implementations within the MetFlix application.

### Example Usage

```swift
// Create an instance of a type conforming to MovieServiceProtocol
var movieService: MovieServiceProtocol = // ...

// Fetch popular movies
do {
    let queryParameters = PopularMovieQueryParameters(page: 1, sortBy: .popularity)
    let popularMovies = try await movieService.getPopular(query: queryParameters)
    print("Popular Movies: \(popularMovies.results)")
} catch {
    print("Error fetching popular movies: \(error)")
}

// Fetch detailed information about a specific movie
do {
    let movieId = "123456"
    let movieDetail = try await movieService.get(by: movieId)
    print("Movie Detail: \(movieDetail)")
} catch {
    print("Error fetching movie detail: \(error)")
}
```

**Note:** Implementations of this protocol would typically involve networking operations to interact with a movie-related API, transforming data, and error handling. The `MovieServiceProtocol` provides a clear contract for the services required by the MetFlix application related to movies.

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
