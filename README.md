# M3SideMenu

[![CI Status](http://img.shields.io/travis/rok črešnik/M3SideMenu.svg?style=flat)](https://travis-ci.org/rok črešnik/M3SideMenu)
[![Version](https://img.shields.io/cocoapods/v/M3SideMenu.svg?style=flat)](http://cocoadocs.org/docsets/M3SideMenu)
[![License](https://img.shields.io/cocoapods/l/M3SideMenu.svg?style=flat)](http://cocoadocs.org/docsets/M3SideMenu)
[![Platform](https://img.shields.io/cocoapods/p/M3SideMenu.svg?style=flat)](http://cocoadocs.org/docsets/M3SideMenu)
==========
# Overview 
a little Objective C side navigation view, that we created for a certain project.
The view is separated into 3 segments: 
- top: extendable table view with add/remove cell functionalities 
- middle: navigation buttons, the view resizes itself depending on the button count) 
- bottom: custom view template (e.g. profile picture) 
 
Each of the three segments can be disabled/hidden, which will make the others adjust their sizes accordingly

# Demo 
[M3SideMenu Demo](https://www.youtube.com/watch?v=aGZSNC-Z4Ks)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

- M3SideMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "M3SideMenu"

- in your desired ViewController import the "M3SideMenu.h" header 
- create the side menu: 
```Objective-c
M3SideMenu *menu = [[M3SideMenu alloc] initWithDelegate:self]; 
// this sets the tableView datasource delegate to your view as well,
// so the basic tableView datasource methods need to be implemented
     [self.view addSubview:self.menu]; 
// optional
     self.menu.isTableViewExtandingEnabled = YES; // makes the tableView extendable 
     [self.menu configureBottom:view]; // add the desired bottom view 
```
- in "M3SideMenu.h" set the cell/header heights and the desired padding 
- build & run!  

## Author

rok črešnik, rok@mice3.it

## License
M3SideMenu is available under the MIT license. See the LICENSE file for more info.

