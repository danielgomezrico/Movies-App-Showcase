# movie_flutter

List movies and information around them

## Getting Started

### How to run
You can run the project with the following commands:
1. Run `$ make doctor`:
2. Edit `assets/.env` filling missing env variables
3. Run `$ make autogenerate`
4. Run `$ make run`

### Other commands
Run `$make` on console to see the available commands:

```console
$ make
  doctor                         Run you if you have any issues starting the project
  autogenerate                   Auto generate files
  autogenerate_watching          Auto generate files
  tests                          Run tests with coverage
  run                            Run the project on device
  lint                           Run all linters
  build_android                  Build android
  format                         Auto format the code base following lint rules
  check_linters                  Run all linters
  app_uninstall                  Uninstall app from android device for tests
```

### How to test
Steps:
```console
$ make doctor
$ make autogenerate
$ make unit_test
```

> You will see a report with the test coverage in HTML

## Architecture
- Is a layered architecture based on Clean Architecture and SOLID principles. 
   - The presentation layer is designed with `MVVM` and `view states` with unidirectional data flow.
   - Environment variables should live in `assets/.env`, you must run `make doctor` to create that file.
   - Some differences with clean architecture:
     - it is thought to show an architecture that can evolute over time based on the project/company requirements but allowing us to still apply good practices over the code. 
     - Not all interfaces are created from the beginning.
     - For everything I did not create a use case, I used the repository directly.
     - I don't mean that clean architecture does not work, but that for a small  project, it is good to follow what you need and works for you and not go creating 1000x clases without having a return on that.
- The Widgets/Pages/Flutter code is meant to be vanilla, so most of the logic remains in the ViewModel/UseCase and can be tested.
- Folders:
  - `features/`: contains UI components that represent a full window 
  - `widgets/`: contains UI components that represent one small part of a window
  - `common/`: contains all code that can be shared over the project
  - `api/`: contains all logic to communicate with the API
- Tests:
  - Mostly of what is being tested is the business logic, we want to have a lot of these because they run fast.
  - One integration test was added to show the use of mockito and UI Robots pattern.
  - I implemented some extensions to add code sugaring, so it pretty easy to mock requests, futures and streams.
- Components:
   - `Favorite feature`: is using a positive UI strategy to show faster the feedback to the user.
   - `EventBus`: used to update the list of favorites if the user changed it, it helps to decouple dependencies but must not be used for everything.
   - `Router`: is a simple custom implementation that allows us to have type safety when navigating between pages:
     - Define what attributes a page requires to start
     - Define what a page returns when it ends
     - Be able to test the navigation with unit testing
  - `Result`: Error / Success handling is done using a [Result Monad](https://adambennett.dev/2020/05/the-result-monad/).

### Architecture diagram
```mermaid
flowchart TD
    %% Define subgraph colors
    subgraph UI [UI]
        style UI fill:#607d8b,stroke:#000,stroke-width:2px
        Page[Page]:::pageStyle
        Widget[Widget]:::widgetStyle
        ViewModel[ViewModel]:::viewModelStyle
        Router[Router]:::widgetStyle
    end

    subgraph BusinessLogic [Business Logic]
        style BusinessLogic fill:#8bc34a,stroke:#000,stroke-width:2px
        Repository[Repository]:::repositoryStyle
        UseCase[UseCase]:::useCaseStyle
        Result[Result]:::useCaseStyle
        EventBus[EventBus]:::useCaseStyle
    end

    subgraph Data [Data]
        style Data fill:#ffb74d,stroke:#000,stroke-width:2px
        Storage[Storage]:::storageStyle
        Models[Models]:::modelsStyle
    end

    %% Define node styles
    classDef pageStyle fill:#b0bec5,stroke:#000,stroke-width:2px;
    classDef widgetStyle fill:#b0bec5,stroke:#000,stroke-width:2px;
    classDef viewModelStyle fill:#78909c,stroke:#000,stroke-width:2px,color:#fff;
    classDef useCaseStyle fill:#aed581,stroke:#000,stroke-width:2px;
    classDef storageStyle fill:#81d4fa,stroke:#000,stroke-width:2px;
    classDef modelsStyle fill:#dce775,stroke:#000,stroke-width:2px;
    classDef repositoryStyle fill:#ef9a9a,stroke:#000,stroke-width:2px;

    %% Define connections
    Page --> ViewModel
    Widget --> ViewModel
    ViewModel --> UseCase
    ViewModel -.-> Repository
    UseCase --> Storage
    UseCase --> Models
    UseCase -.-> Repository
```

## Screens

| Movies Showcase | Favorite Movies | Movie Detail | 
| --- | --- | --- |
| ![](docs/1.png) | ![](docs/2.png) | ![](docs/3.png) |

## Features

| Clear Error Messages                   | Empty State                  | Retry                       |
|----------------------------------------|------------------------------|-----------------------------|
| ![](docs/clear%20error%20messages.png) | ![](docs/empty%20values.png) | ![](docs/error%20retry.gif) |

| Endless Pagination                 | Sorting and show in grid or list            | 
|------------------------------------|---------------------------------------------|
| ![](docs/endless%20pagination.gif) | ![](docs/sorting and grid:list changer.gif) | 



| remove favorite |  add favorite | see favorites offline |



How long did you spend on this?
> I spent 4 days in my free time (because I am working right now) to get it done, I did try as much as I could, I tried following all the directions required.

Did you complete your implementation?
> Yes, I did it with all the required features and with some extras:
> - Dark mode
> - Architectural Diagram (a very simple one)


What would you have added if you had more time?
> - Add some animations to the movies list
> - Add search by text
> - Add a fast scroll at the left by letter, it's harder to scroll when the list is big
> - Add performance optimizations avoiding shader glitches with SkSl warmup.
> - Add firebase with remote config to enable A/B testing

What was the most difficult part of the app?
> I made multiple designs, like 4 until I found one that makes me feel more confortable and make it look a bit out of a sampel.

What was your favorite part of the app?
> I really enjoy working on UI, and Architecture part as well.

Is there anything else you’d like to add?
> It was a lot of work to do but I really enjoyed it, I did fly back to my University times when I used to have to make final projects and spent a lot of nights and coffee. I’d like to invest more time in Testability, I added just a few tests on present logic layers which I consider the most important part of any architecture.

