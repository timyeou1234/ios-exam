# iOS_Exam Overview

==== File Structure ====

## Service

Use to send Api to get random user information.

*  Use this service to get random user information <https://randomuser.me/documentation#multiple>

## Model

Use to define the struct of data.

*  Use codable to transform json data to custom object.

## Module

**ContactList :** Use MVVM design pattern for ContactListViewController the main list to reduce the size of api logic and refresh activity in single viewController.


**ContactDetail :** Use tradition MVC pattern to simplfy code and logic.

## View

To Custom the cell use from tableView  

*  All views use autolayout.

## Optional requirements

*  Changes are commit follow the git flow rule.

*  Use codable to transform json data to custom object.

*  All views use autolayout.

*  Try to write own Unit Test, which I didn't have experience on online project. If you can provide some tips for me will be wonderful. 

*  Still trying to figure out RxSwift to use with MVVM, once done, will open a feature to refactor current protocol.



#### Many thanks to give me this test, although I may not done well, but I learn alot from it. It will be wonderful if we can discuss the way to emprove such a project. 