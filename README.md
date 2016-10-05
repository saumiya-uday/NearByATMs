NearByATMs

================================================================================
ABSTRACT:

This demonstrates the two primary use cases for the Core Location Framework & Google Maps SDK : "Getting the User's Current Location", Display near by ATMS Branches on Google Maps on tap of the annotation it will give details about the branch/ atm user has selected Reverse Geocoding is used to display users currrent address



================================================================================
BUILD REQUIREMENTS:

iOS 8.0 SDK or later
CocoaPods to install GoogleMaps SDK 2.1.0

================================================================================
RUNTIME REQUIREMENTS:

iOS 8.0 or later

Before running the project run "pod install" command on terminal and open the workspace

================================================================================
PACKAGING LIST:

BUILD Settings:
 These environments tend to have a few different parameters such as the server hostname, Bundle ID and third-party app API keys to name a few.
Preprocessing macros are set, for changing service BaseURL, Google Map SDK API key depending on Stating or production


AppDelegate
The application delegate has a minimal role in this sample: in -applicationDidFinishLaunching: Initializes the app with Google Maps API key. Checks is user has enable the app to use location is not enabled it alerts user to enable App to access locatiom.

NAMapViewController
Attempts to acquire a location measurement with a specific level of accuracy. Displays reverse geocode address of user.Shows user with Map Annotations (GSMarkers) for ATMs/ Branches nearby this current location 

NALocationController
Displays ATM / Branch details on the view, ATM/ Branch working hours details,phone number,distance, address, services.

LocationManager
Helper Class that has Location Service setup like accuracy, distance for user location tracing. Delegate method of this class update NAMapController about user location latitude, longitude. This Location details is given to WebserviceManager to retrieve list of nearby ATMS/ Branches from backend server.
Reverse geocoder displayes user address from the latitude and longitude obtained

WebserviceManager
Responsible to fetch ATM list nearby from the latitude and longitude obtained. Completion handler updated the Maps with the annotations for the coresponding latitude,longitude on Google Map




================================================================================
