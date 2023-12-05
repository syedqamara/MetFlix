# MetFlix Application Architecture Documentation

## HomeUIM Module

### 1.1 Overview

The `HomeUIM` module is a pivotal component of the MetFlix application, responsible for managing the UI models within the home view. It encapsulates the data models for various sections, including episodes, channels, and categories.

### 1.2 `HomeSectionUIM` Enumeration

#### 1.2.1 DataModelType

```swift
public struct DataModelType {
    public var episodes: EpisodesApiData?
    public var channels: ChannelsApiData?
    public var categories: CategoriesApiData?
    public var error: Error?
}
```

#### 1.2.2 Cases

```swift
public enum HomeSectionUIM: UIModel {
    case episodes(EpisodesDataUIM?), channels(ChannelsDataUIM?), categories(CategoriesDataUIM?), none, error(Error)
}
```

#### 1.2.3 Initialization

```swift
public init(dataModel: DataModelType) {
    // Initialization logic for each case
}
```

#### 1.2.4 `isSameSection(_:)` Function

```swift
func isSameSection(_ section: HomeSectionUIM) -> Bool {
    // Comparison logic for each case
    return false
}
```

### 1.3 Extension: `Identifiable`

```swift
extension HomeSectionUIM: Identifiable {
    public var id: String {
        // Unique identifier logic for each case
        return ""
    }
}
```

### 1.4 Conclusion

The `HomeUIM` module evolves to accommodate additional data models, maintaining a modular and scalable approach to UI architecture.

---

## HomeAbstract Module

### 2.1 Overview

The `HomeAbstract` module serves as the architectural backbone for the Home module, defining abstract protocols for UI modeling, view modeling, services, and cache management.

### 2.2 `UIModeling` Protocol

```swift
public protocol UIModeling: UIModel where DataModelType: DataModel {
    // Protocol definition
}
```

### 2.3 `HomeViewModeling` Protocol

```swift
public protocol HomeViewModeling: ViewModeling {
    var sections: [HomeSectionUIM] { get set }
    func onAppear()
    func refresh()
}
```

### 2.4 `HomeModuling`, `HomeViewProtocol`, `ViewModuling`

```swift
public protocol HomeModuling: ViewModuling where ViewType: HomeViewProtocol {}
public protocol HomeViewProtocol: SwiftUIView where ViewModelType: HomeViewModeling {}
```

### 2.5 Specialized Modules and Protocols

```swift
public protocol EpisodesModuling: ViewModuling where ViewType: EpisodesViewProtocol {}
// ... Similar definitions for Categories and Channels ...
```

### 2.6 `ServiceProtocol`

```swift
public protocol ServiceProtocol {
    // Protocol definition
}
```

### 2.7 Specialized Service Protocols

```swift
public protocol MindValleyServiceProtocol: ServiceProtocol {
    // Protocol definition
}
// ... Similar definitions for Episode, Channel, Categories, and ImageDownloading ...
```

### 2.8 `CacheManagerProtocol`

```swift
protocol CacheManagerProtocol {
    // Protocol definition
}
```

### 2.9 Conclusion

The `HomeAbstract` module remains a robust foundation for the Home module, incorporating the latest updates in data models and maintaining a consistent and scalable architecture.

---

## Implementation Details

### 3.1 Data Loading

- All data is loaded from the provided API calls.
- Images and JSON are cached efficiently to allow offline viewing.
- Graceful handling of missing data instances is implemented to provide a good user experience.

### 3.2 Scrollable Views

- Both New Episodes and Channels sections are horizontally scrollable, with a maximum of 6 items per row.

### 3.3 Unit Tests

- The project includes unit tests to ensure the correctness and reliability of the implemented functionalities.

### 3.4 Evaluation Criteria

- The code is evaluated based on readability, design adherence to measurements and colors, maintainability following SOLID principles, scalability for future requirements, and testability.

### 3.5 Expected Output

- The app should run on any device running iOS 13 and above.
- Code sharing is done as a zipped file or a link through Google Drive, Dropbox, or any file-sharing platform.
- A README file is expected, answering specific questions related to challenges faced and potential future features.

## Cache Management

### 4.1 Introduction

This section introduces the cache management strategy employed in the MetFlix application to efficiently handle data storage and retrieval. Two property wrappers, `Cached` and `CachedPermanent`, play a key role in achieving this.

### 4.2 `Cached` Property Wrapper

The `Cached` property wrapper provides a mechanism for caching values using a `SynchronizedCacheManager`. This manager ensures thread-safe operations, crucial for a smooth user experience.

```swift
@propertyWrapper
public struct Cached<V> {
    private let key: String
    private let cacheManager: SynchronizedCacheManager = SynchronizedCacheManager.shared

    public var wrappedValue: V? {
        get {
            return cacheManager.get(valuefor: key)
        }
        set {
            if let newValue = newValue {
                cacheManager.insert(value: newValue, for: key)
            } else {
                cacheManager.remove(for: key)
            }
        }
    }

    public init(key: String) {
        self.key = key
    }
}
```

### 4.3 `CachedPermanent` Property Wrapper

The `CachedPermanent` property wrapper utilizes `UserDefaults` for persistent caching. This is suitable for values that need to be retained even after the application restarts.

```swift
@propertyWrapper
public struct CachedPermanent<V> {
    private let key: String
    public var wrappedValue: V? {
        get {
            return UserDefaults.standard.value(forKey: key) as? V
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }

    public init(key: String) {
        self.key = key
    }
}
```

### 4.4 Usage

#### 4.4.1 `Cached` Example

```swift
struct ExampleViewModel {
    @Cached(key: "exampleKey")
    var cachedValue: String?
}
```

#### 4.4.2 `CachedPermanent` Example

```swift
struct PermanentExampleViewModel {
    @CachedPermanent(key: "permanentExampleKey")
    var cachedPermanentValue: Int?
}
```

### 4.5 Conclusion

The cache management system, facilitated by the `Cached` and `CachedPermanent` property wrappers, ensures efficient data storage and retrieval, contributing to a seamless user experience in the MetFlix application.

## API Integration

### 5.1 Introduction

This section delves into the API integration strategy implemented in the MetFlix application. The `MindValleyEndpoints` enumeration and its conformances provide a streamlined approach to managing API endpoints, while an extension to the `Cached` property wrapper enhances cache management for these endpoints.

### 5.2 `MindValleyEndpoints` Enumeration

The `MindValleyEndpoints` enumeration enumerates the various endpoints required for API integration.

```swift
public enum MindValleyEndpoints {
    case episodes, channels, categories
}
```

### 5.3 Conformances to `Pointable`

The enumeration conforms to the `Pointable` protocol, defining the necessary properties for endpoint configuration.

```swift
extension MindValleyEndpoints: Pointable {
    public var pointing: String {
        switch self {
        case .episodes:
            return "z5AExTtw"
        case .channels:
            return "Xt12uVhM"
        case .categories:
            return "A0CgArX3"
        }
    }

    public static var allCases: [MindValleyEndpoints] {
        [
            .episodes,
            .channels,
            .categories
        ]
    }

    public var debugID: String { "debugging.id.\(pointing)" }
    public var configID: String { "configuration.id.\(pointing)" }
}
```

### 5.4 Extension to `Cached`

An extension to the `Cached` property wrapper facilitates the initialization of cache keys based on the provided endpoint.

```swift
extension Cached {
    init(endpoint: MindValleyEndpoints) {
        self.init(key: endpoint.pointing)
    }
}
```

### 5.5 Usage

#### 5.5.1 Endpoint Enumeration Usage

```swift
let episodesEndpoint = MindValleyEndpoints.episodes
print(episodesEndpoint.pointing) // Output: "z5AExTtw"
```

#### 5.5.2 `Cached` Initialization with Endpoint

```swift
let cachedEpisodes = Cached(endpoint: .episodes)
```

### 5.6 Conclusion

The API integration section introduces an efficient approach to managing endpoints using the `MindValleyEndpoints` enumeration. Additionally, the extension to `Cached` enhances cache management tailored to specific API endpoints.

## Dependency Injection

### 6.1 Introduction

This section details the implementation of dependency injection for MetFlix services, utilizing the third-party library named `swift-dependencies`. The provided code context showcases the setup for injecting services related to episodes, channels, categories, and image downloading.

### 6.2 Service Dependencies

Several service dependencies are defined as enumeration types conforming to `DependencyKey` and `TestDependencyKey` protocols. These dependencies represent the services for episodes, channels, categories, and image downloading.

```swift
enum EpisodeServiceDependency: DependencyKey, TestDependencyKey {
    static var liveValue: EpisodeServiceProtocol = MindValleyService()
    static var testValue: EpisodeServiceProtocol = MockMindValleyServiceProtocol(parameter: .none(.init()), returned: .none(.init()))
}

enum ChannelServiceDependency: DependencyKey, TestDependencyKey {
    static var liveValue: ChannelServiceProtocol = MindValleyService()
    static var testValue: ChannelServiceProtocol = MockMindValleyServiceProtocol(parameter: .none(.init()), returned: .none(.init()))
}

enum CategoryServiceDependency: DependencyKey, TestDependencyKey {
    static var liveValue: CategoriesServiceProtocol = MindValleyService()
    static var testValue: CategoriesServiceProtocol = MockMindValleyServiceProtocol(parameter: .none(.init()), returned: .none(.init()))
}

enum ImageDownloadServiceDependency: DependencyKey, TestDependencyKey {
    static var liveValue: ImageDownloadingProtocol = MindValleyService()
    static var testValue: ImageDownloadingProtocol = MockMindValleyServiceProtocol(parameter: .none(.init()), returned: .none(.init()))
}
```

### 6.3 `DependencyValues` Extension

An extension to `DependencyValues` provides easy access and modification of the defined service dependencies.

```swift
extension DependencyValues {
    var episodeService: EpisodeServiceProtocol {
        get {
            self[EpisodeServiceDependency.self]
        }
        set {
            self[EpisodeServiceDependency.self] = newValue
        }
    }
    
    var channelService: ChannelServiceProtocol {
        get {
            self[ChannelServiceDependency.self]
        }
        set {
            self[ChannelServiceDependency.self] = newValue
        }
    }
    
    var categoryService: CategoriesServiceProtocol {
        get {
            self[CategoryServiceDependency.self]
        }
        set {
            self[CategoryServiceDependency.self] = newValue
        }
    }
    
    var imageService: ImageDownloadingProtocol {
        get {
            self[ImageDownloadServiceDependency.self]
        }
        set {
            self[ImageDownloadServiceDependency.self] = newValue
        }
    }
}
```

### 6.4 Usage with `@Dependency`

The `@Dependency` property wrapper simplifies the usage of service dependencies within the MetFlix application.

```swift
@Dependency(\.categoryService) var categoryService

do {
    let categories = try await categoryService.categories()
    // Use the fetched categories
} catch {
    // Handle error
}
```

### 6.5 Conclusion

The implementation of dependency injection for MetFlix services, as demonstrated in this section, ensures a modular and testable codebase. The `swift-dependencies` library facilitates the management of service dependencies, providing flexibility for both live and test environments.

## Launch Configurations

### 7.1 Introduction

The "Launch Configurations" section describes the launch configuration process within the MetFlix application. The provided code illustrates the `launch()` function, responsible for configuring and registering essential components, such as network endpoints and themes, during the app launch.

### 7.2 Code Explanation

The `launch()` function begins by using the `@Dependency` property wrapper to obtain an instance of the `registrar`—a crucial component responsible for handling various registrations within the MetFlix application.

```swift
@Dependency(\.registerar) var registrar
```

#### 7.2.1 Configuration for DebugUITheme.NetworkDebugModule.KeyValue

The function proceeds to configure a theme using the `@Configuration` property wrapper, specifically for the `DebugUITheme.NetworkDebugModule.KeyValue`. The chosen theme, in this case, is `.appTheme`.

```swift
@Configuration<DebugUITheme.NetworkDebugModule.KeyValue>(DebuggerUI.networkModuleKeyValueThemeName) var theme: DebugUITheme.NetworkDebugModule.KeyValue?
_theme.wrappedValue = .appTheme
```

#### 7.2.1 Network Endpoint Registrations

Next, the function attempts to register three network endpoints for fetching data related to episodes, channels, and categories. These registrations involve specifying the name, host, endpoint, HTTP method, content type, response type, and additional headers.

```swift
try registrar.networkRegister(
    name: "Get Episodes Api",
    host: Config.mindValleyHost,
    endpoint: MindValleyEndpoints.episodes,
    method: .get,
    contentType: .queryParam,
    responseType: EpisodesApiData.self,
    headers: [:]
)

try registrar.networkRegister(
    name: "Get Channels Api",
    host: Config.mindValleyHost,
    endpoint: MindValleyEndpoints.channels,
    method: .get,
    contentType: .queryParam,
    responseType: ChannelsApiData.self,
    headers: [:]
)

try registrar.networkRegister(
    name: "Get Categories Api",
    host: Config.mindValleyHost,
    endpoint: MindValleyEndpoints.categories,
    method: .get,
    contentType: .queryParam,
    responseType: CategoriesApiData.self,
    headers: [:]
)
```

#### 7.2.1 Error Handling

In case of any errors during the configuration process, the function catches the error and prints a message in debug mode.

```swift
catch let error {
    #if DEBUG
        print("Launch_Configuration_Error")
        print(error)
    #endif
}
```

### 7.3 Conclusion

The "Launch Configurations" section outlines the `launch()` function's role in initializing and configuring crucial components during the MetFlix application launch. This includes setting themes and registering network endpoints, ensuring a smooth and error-handled launch process.

## Debugger

 | Home (without Debugger) | Breakpoint (Debugger) | Home (with Debugger) |
 |-------|-------|-------|
 |  <img width="250" height="400" src="/MetFlix/Resources/Screenshots/home_1.png" ></img>  | <img width="250" height="400" src="/MetFlix/Resources/Screenshots/home_1.png" ></img>   | <img width="250" height="400" src="/MetFlix/Resources/Screenshots/home_1.png" ></img>   |

*Author: Syed Qamar Abbas*
*Project: MetFlix*
*Creation Date: 26/11/2023 - 02/12/2023*

