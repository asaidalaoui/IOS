1. Implementation Contributions: 
Ali Darwiche - 33%
+Updated core data with auto-update functionality
+Front-end design for login/create account screens

Abderrahman Said-Alaoui - 33%
+Available time left view feature (aka progress bar in weekly view)
+WeeklyTaskTableViewControl

Keith Wong - 33%
+Update available time feature
+WeeklyTaskTableViewControl

Coffee - 1%
+Stay Awake feature

2. Grading Level:
Ali Darwiche- 100%
Abderrahman Said-Alaoui - 100%
Keith Wong - 80%
Coffee - 120%

3. Differences:

+Deleting a task involves a difference process for this release. Instead of swiping a task in the task list, the user shall click on the task, which will take them to the task details screen. On this screen, a "Delete task" button is displayed to the user

+Alerts were added to appear in any cases of errors or invalid inputs

+Removed Navigation controller and created "Cancel" buttons to act as back buttons when adding new tasks

+Views that are connected to future features have a label on them saying "Unavailable in alpha release"

4. Special Instructions: Any special instructions needed to make sure your app can be built and run. For example, if you use CocoaPods - the minimum version to use.
This project uses IQKeyboardManagerSwift cocoapod. The minimum are iOS 8.0 and Xcode 7.3. The used IQKeyboardManager version used for this version is 4.0.2 (latest).

Directions:
install cocoa pods: $sudo gem install cocoa pods
execute: $pod install
open project through the IOSProject.xcworkspace instead of IOSProject.xcodeproj.

It is possible when opening the project for the first time, an error message might be displayed about the import statement of IQkeyboard. Ignore the error, and just run the application, the error should disappear.

During the run time of the application, if the keyboard does not show up on the screen, make sure to toggle Hardware>Keyboard>Toggle Software Keyboard
