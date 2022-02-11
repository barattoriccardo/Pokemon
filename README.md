# Pokemon

## Version

1.0


## Build and Runtime Requirements

+ xCode 11.0 or later
+ iOS 11.0 or later


## Configuring the Project

Configuring the Xcode project is easy because Pokemon doesn't use any pods or external libraries.


## About Pokemon

Pokemon is a sample project for iOS. In this sample, the user can get a list of all Pokemons and see stats and other info about any pokemon.


## Application Architecture

Pokemon follows the Model-View-ViewModel (MVVM) design pattern and uses modern app development practices and doesn't include Storyboards or XIB, everything concerning UI is written programatically in each ViewController or View.


## Scenes

Pokemon List: This scene displays a list of all pokemons with their own names and images
Pokemon Details: This scene allows users to see a pokemon image, its stats and other useful info


## Unit Tests

Pokemon has unit tests written for ViewModel classes. The tests can be run on an iOS target. To run the unit tests, select Pokemon scheme in the Scheme menu. Then hold the Run button down and select the "Test" option, or press Command+U to run the tests.
