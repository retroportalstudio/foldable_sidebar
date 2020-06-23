# Foldable Sidebar

An easy to implement Foldable Sidebar Navigation Drawer for Flutter Applications.

## Current Features

* Initial Release for Foldable Navigation Sidebar

## Demo
![](https://github.com/retroportalstudio/foldable_sidebar/blob/master/foldable_sidebar.gif)

## Usage
To Use, simply add FoldableSidebarBuilder to your Scaffold's body, as follows:
```dart
      child: Scaffold(
      body: FoldableSidebarBuilder(
                drawerBackgroundColor: Colors.deepOrange,
                drawer: CustomDrawer(closeDrawer: (){
                  setState(() {
                    drawerStatus = FDBStatus.FDB_CLOSE; // For Closing the Sidebar
                  });
                },),
                screenContents: FirstScreen(), // Your Screen Widget
                status: drawerStatus,
              ),
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                  child: Icon(Icons.menu,color: Colors.white,),
                  onPressed: () {
                    // To Open/Close Sidebar
                    setState(() {
                      drawerStatus = drawerStatus == FDBStatus.FDB_OPEN ? FDBStatus.FDB_CLOSE : FDBStatus.FDB_OPEN;
                    });
                  }),
            ),
           ),
```
Important Enums:
```dart
FSBStatus.FSB_OPEN //For Opening the Sidebar
FSBStatus.FSB_CLOSE  //For Closing the Sidebar
```

## Roadmap
Plans to add more customizations.

## License
[MIT](https://choosealicense.com/licenses/mit/)
