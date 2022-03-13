# GithubRepoSearch

## Platform: iOS

Xcode version: 13.2.1

iOS Deployment Target: iOS 15.2

Swift version: Swift 5

The app is written in CLEAN architecture which is separated into 3 layers.

- UI layer

Responsible for UI.
This layer is responsible for showing the contents from the Domain layer and UI navigation.

- Domain layer

Contains the business logic of the app.
This layer contains the combinations of the data logics to build contents for UI.

- Data layer

Contains the data logic of the app.
This layer is responsible for talking to the backend or database to save or retrieve data.

The workspace contains 4 sub-projects.

- RepoSearch - Represents the UI layer of CLEAN architecture. Please select `RepoSearch` target to run the app.
- DomainLayer - Represents the Domain layer of CLEAN architecture
- DataLayer - Represents the Data layer of CLEAN architecture
- Dependencies - Dependencies container of the app
