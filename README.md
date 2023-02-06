# weather-app
## What's implemented
* Sea design
* MVVM Architecture
* Open weather map APIs
* User geo localization
* Dependency Injection
* Google Places APIs
  * Search for places with autocomplete feature
* Favorite locations/places list
* View favorited locations on map
* Some extra info about specific location (city name)

## Future improvements
* Unit Testing (TDD)
* CI / CD build pipeline with Fastlane (CD is not yet implemented)
* Code coverage
* Swiftlint
* Better error handling
* Static code analysis
* Offline weather information
* Show last time updated (offline mode)

## Notes
One essential aspect that I have omitted is Unit Testing. The reason behind is due to some unforeseen events I could only start the project more than a week after being assigned same. Since I was already past the submission date, I was granted some additional time to hand over an acceptable solution. I had to decide between either starting to write tests or starting to code the app (a working solution).

Regarding the Forecast5 - https://openweathermap.org/forecast5 api, it returns forecasts on a 3 hour basis. I would prefer using forecast16 - https://openweathermap.org/forecast16 in a future project as it provides daily forecast instead of 3 hour basis forecasts for 6 days.

API Keys normally should be kept locally, but in this case I committed my plist containing my API keys to ease the task of the reviewers by allowing them to build the app without having to create their own API keys.
