# Classic Archive

Classic Archive is a World of Warcraft: Classic item database created by Brennan Dourdoufis for Northeastern University CS5610.

The website allows users to search for any item in the game using the [NexusHub WoW Classic API](https://nexushub.co/developers/api).

Logged-in users can add items to their personal favorites list, which can be viewed at any time on their profile page. Item search results will also display a list of users who have favorited that item, allowing users to navigate to those other users' profiles. 

Logged-in users may also navigate to a page containing information on their selected faction's racial abilities from the site's homepage.

## The Flutter Framework

This project's front-end is built in Flutter, a UI framework created by Google which allows for the creation of native mobile, web, and desktop applications from a single codebase. I chose to create this project using Flutter (with instructor permission) as it is what we have recently started using at my work. For more general information regarding Flutter, see [here](https://flutter.dev/).

In Flutter, nearly every component of a project is defined as a Widget, from full pages, to specific internal components, to dialog boxes. Widgets are generally built based on their state, which can be defined as a separate object along with the main widget. When a widget's state changes, the framework will rebuild the widget using its updated state values. To learn more about widgets in Flutter, see [here](https://flutter.dev/docs/development/ui/widgets-intro).

## The BLoC Pattern
Flutter also differentiates itself from other web frameworks by its usage of the BLoC state management system. I've implemented two BLoC's in my project- one for managing user and favorite information from my Node server, and the other to communicate with the NexusHub API for retrieving item data.

For more information on BLoCs, see [here](https://www.raywenderlich.com/4074597-getting-started-with-the-bloc-pattern) and [here](https://www.didierboelens.com/2018/08/reactive-programming-streams-bloc/).

## Routing in Flutter
With Flutter being released initially as a mobile application framework designed to work natively on both Android and iOS, not much thought was put into routing for web applications. As such, Flutter instead utilizes the Navigator widget to maintain a set of child widgets in a Stack. The Navigator essentially works as follows: if I want to navigate to the item search page from my home page, I can simply call 'Navigator.push(...)' from the home page widget, where ... is replaced with a declaration of a MaterialPageRoute containing my SearchPage widget. This pushes the SearchPage to the top of the stack, loading it on top of the home page. When the user clicks the back button to return to the home page, 'Navigator.pop()' is called, which pops the SearchPage widget off the Navigator stack, revealing the home page again.

The issue with this is that it means Flutter does not use the website URL for navigation. As a result, I was not able to meet the project requirements for specific URL assignments to pages. For more information on the Navigator, take a look at the [documentation page](https://api.flutter.dev/flutter/widgets/Navigator-class.html).

## Deployment
This project has been deployed using GitHub Pages! The deployed version can be found [here](https://bdourdoufis.github.io/classic-archive-deployment/#/). This version of the project communicates with a Node.js server hosted on Heroku, which can be found [here](https://classic-archive-user-service.herokuapp.com/). This deployed Node server modifies data in a Mongo database hosted on [MongoDB Atlas](https://www.mongodb.com/cloud/atlas).