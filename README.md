M3SideMenu
==========
a little Objective C side navigation view, that we created for a certain project.
The view is separated into 3 segments: 
- top: extendable table view with add/remove cell functionalities 
- middle: navigation buttons, the view resizes itself depending on the button count) 
- bottom: custom view template (e.g. profile picture) 
 
Each of the three segments can be disabled/hidden, which will make the others adjust their sizes accordingly

 
 
Installation: 
- in your desired ViewController the required header 
#import "M3SideMenu.h" 
- create the side menu: 
```Objective-c
M3SideMenu *menu = [[M3SideMenu alloc] initWithDelegate:self]; 
// this sets the tableView datasource delegate to your view as well,
// so the basic tableView datasource methods need to be
     [self.view addSubview:self.menu]; 
// optional
     self.menu.isTableViewExtandingEnabled = YES; // makes the tableView extendable 
     [self.menu configureBottom:view]; // add the desired bottom view 
```
- in "M3SideMenu.h" set the cell/header heights and the desired padding 
- build & run! 

- demo: [M3SideMenu Demo](https://www.youtube.com/watch?v=aGZSNC-Z4Ks)
