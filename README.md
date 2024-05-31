# Pokedex

## Initial description
For this solution I started with a design pattern of MVVM-C using UIKit, AlamofireImage to be responsible for async download images, Swinject for Dependency Injection.

## View Components 
Regarding the structure of the API and in the middle of development, it was migrated all the UI views from UIKit to SwiftUI to improve development speed and a lot of components provided by SwiftUI were very important to simplify the solution used.
As a side effect of using UIViewController + SwiftUI with UIHostingController, the layout of some orientations are not correctly displaying as it should.
The next step is to remove all the UIViewController components and only use SwiftUI views. 

## Authorization
Informed in https://pokeapi.co/docs/v2#info , this API doesn't require authentication. 

## Frameworks Used 
With the AsyncImage it wasn't required anymore to have AlamofireImage as dependency of the project.
Even thought the knowledge of creating the Dependency Injection Framework, I prefered to use Swinject to simplify this part of development and focus on the Must Have requirements.

 ## Pagination
 The viewModel logic for infinite scroll pagination is developed, but the structure created for retrieve the Search Field wasn't updating the displayed list. So, it won't be available at 1.0 version.
 
 ## Search Field
 The logic for search through searchfield at top of the list is implemented and it is function. However, due to conflicts with Pagination, have a great potential to be adjusted at next verions.
 The API only returns the pokemon info if it is requested by their PokemonID or the correct full name. With this, the search is only filtering the already loaded information.
 
 ## Functional Programing
 If it applies to Higher Order Function, I tried to use the most possible functions. Instead of only using ForEach, tried to use map, compactMap, joined, filter ... to manipulate the information.
 
 ## Unit Test \ UI Test
Still not implemented in this 1.0 version
