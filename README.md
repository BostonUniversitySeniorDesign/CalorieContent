# calorie_app

This project was the introductory mini project for Computer Engineering students enrolled in the Senior Design (i.e Senior Capstone) session I class.
The purpose of this project is to act as a refresher/introduction to cross-platform/Full-Stack app development using Agile methodologies. 
It is also meant as an introduction to the style of the course, and get students accustomed to working in pairs.

The introduction of the Software Mini Project is the following: to create a mobile app that tracks the calories of foods/recipes that you eat and stores them. 
It calculates the calorie content through scanning product barcodes and using a USDA/FDA RESTful API.
 
While this project is not graded to completetion, here are the expected requirements:
#### Backend service
1. REST Service to return calories of a recipe based on
2. Barcodes of ingredients, images of ingredients, and/or name of ingredient
3. Servings per item in the call
#### Application will calculate calories of a recipe or food you eat
4. Take a picture
5. Read barcodes of products
6. Ask the user for amount of servings
7. Keeps track of all users recipes and daily food intake
8. Use Gmail for authentication
#### Use FDA API to get nutrition information to get nutrition facts
* Study them well
* Build test examples

## How to run this app 
1. Ensure you have Flutter 2.2.3 installed, newer versions will break the web portion of the application due to SDK dependencies.
2. Make sure that the google-services.json is present within the Android build directory, otherwise errors will occur!
3. run 'flutter doctor -v' to make sure you have the correct dependencies to use the SDK. 
4. DO NOT run flutter upgrade to update dependencies, run flutter pub get (pub is flutter's 'package' manager).
5. 'flutter run' will run the application
	* NOTE: to run the app on a physical device and not an emulator you must do the following:
		* On Android: enable developer settings and enable USB debugging. Fluter will automatically detect your device and install a cached version of the application to hotload
		* On IOS: You must enable your developer account and allow for code signing in XCode. Once that is finished, you must enable your developer profile. Alternatively you can use TestFlight.
		* On Web: Ensure you have an up-to-date version of Chrome.
* KNOWN BUG ON WEB: Barcodes don't scan as easily, most likely due to the lack of high-res image processing on front-facing lapop cams (or lack of function computer vision plugins).

## Foresights, Reflections (What we could have done better)

In retrospect, we should have started on our backend. As front-end and UI on flutter is fairly trivial due to it's hot-reload capabilities, and Widget-Tree style formatting, starting with the backend would have allowed us more time to
"figure out" our sign-in page with gmail auth, and connect the parsed JSON responses to firebase.

Figuring out the Flutter learning curve was interesting. For this project, we were tempted to use React Native, as we were both already familiar with the platform, but we wanted to get familiar with an up-and-coming framework with rapid prototyping capabilities.

Looking back, what really ate up most of our time was finding plugins and libraries that were not deprecated. Most tutorials were outdated, and while Google's documentation is stellar, accessing things like Cameras and Filesystems are not documented, leaving difficult tasks like those wholly up to the community to implement. Updating flutter also lead to breaking a lot of plugins that relied on older versions of the SDK. (plenty of conflicting documentation on nullsafety, to boot).

All in all, it was an amazing learning experience when it came to Flutter's approach to Imperative and Declarative UI, as well as interacting with Widgets that are reactive/stateful.
 
## Sprint Log

### Sprint 1
Plans for the SPRINT week of 9/7:

#### Tasks for both of us
- Figure out how layouts/widgets work in flutter (completed)
- Finish the tutorial/codelab on the flutter site (completed)
- Understand how a RESTful API works (completed)

#### Tasks to be completed:
- Be able to scan barcodes with the device camera (completed)
- Pull information from the barcode (completed)
- Start firebase for the backend (not completed)

### Sprint 2
Last week of the project, plans for week of 9/13

#### Tasks to be completed
- Connect API to Camera + retrieve food data (completed)
- Set up Firebase backend for authentication (incomplete) :(

## Resources Used
* Additional tool: Postman for analyzing JSON structure using HTTP GET requests.
* Plugin + code examples: 'https://pub.dev/packages/qr_code_scanner'
* Other example of QR/barcode scanning: https://heartbeat.fritz.ai/scan-barcodes-in-flutter-using-firebases-ml-kit-b5b014a67ed1
* Parsing JSON and using classes to organize request data: https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
* Passing data between stateful widgets in Dart: https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51

## Images
