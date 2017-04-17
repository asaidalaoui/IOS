1. Implementation Contributions: 
Ali Darwiche - 33%
+Updated core data with auto-update functionality
+Front-end design for login/create account screens

Abderrahman Said-Alaoui - 33%
+Available time left view feature (aka progress bar in weekly view)
+WeeklyTaskTableViewControl

Keith Wong - 33%
+Update available time feature
+WeeklyTasksTableViewController and WeeklyTasksTableViewCell
+Added icon images on the tab bar controller

Coffee - 1%
+Stay Awake feature

2. Grading Level:
Ali Darwiche- 100%
Abderrahman Said-Alaoui - 100%
Keith Wong - 100%
Coffee - 120%

3. Differences:

+The available time left view is implemented onto the WeeklyTasksTableViewController.

4. Special Instructions: Any special instructions needed to make sure your app can be built and run. For example, if you use CocoaPods - the minimum version to use.
This project uses IQKeyboardManagerSwift cocoapod. The minimum are iOS 8.0 and Xcode 7.3. The used IQKeyboardManager version used for this version is 4.0.2 (latest).

Directions:
install cocoa pods: $sudo gem install cocoa pods
execute: $pod install
open project through the IOSProject.xcworkspace instead of IOSProject.xcodeproj.

It is possible when opening the project for the first time, an error message might be displayed about the import statement of IQkeyboard. Ignore the error, and just run the application, the error should disappear.

During the run time of the application, if the keyboard does not show up on the screen, make sure to toggle Hardware>Keyboard>Toggle Software Keyboard
