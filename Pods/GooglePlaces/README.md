# Google Places API for iOS

**NOTE:** This pod is the official pod for the Google Places API for iOS.
Previously this pod was used by another developer, his content has been moved to
[Swift Google Maps API](https://github.com/honghaoz/Swift-Google-Maps-API) on
GitHub.

This pod contains the Google Places API for iOS, supporting both Objective C and
Swift.

Use the [Google Places API for iOS]
(https://developers.google.com/places/ios-sdk/) for exciting features based
on the user's location and Google's Places database. You can enable users to
add a place, autocomplete place names, use a place picker widget, identify
the user's current place or retrieve full details and photos of a place.

The Google Places API for iOS is distributed as a stand alone Pod. This Pod
contains all the Google Places API for iOS functionality which does not require
a map.

# Getting Started

*   *Guides*: Read our [Getting Started guides]
    (https://developers.google.com/places/ios-sdk/start).
*   *Code samples*: In order to try out our demo app, run

    ```
    $ pod try GooglePlaces
    ```

    and follow the instructions on our [developer pages]
    (https://developers.google.com/places/ios-api/code-samples).

*   *Support*: Find support from various channels and communities.

    *   Support pages for [Google Places API for iOS]
        (https://developers.google.com/places/support).
    *   Stack Overflow, using the [google-places-api]
        (https://stackoverflow.com/questions/tagged/google-places-api) tag.

*   *Report issues*: Use our issue tracker to [file a bug]
    (https://code.google.com/p/gmaps-api-issues/issues/entry?template=Places%20API%20for%20iOS%20-%20Bug)
    or a [feature request]
    (https://code.google.com/p/gmaps-api-issues/issues/entry?template=Places%20API%20for%20iOS%20-%20Feature%20Request)

# Installation

To integrate Google Places API for iOS into your Xcode project using CocoaPods,
specify it in your `Podfile`:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.4'
target 'YOUR_APPLICATION_TARGET_NAME_HERE' do
  pod 'GooglePlaces'
end
```

Then, run the following command:

```
$ pod install
```

Before you can start using the API, you have to activate it in the [Google
Developer Console](https://console.developers.google.com/) and integrate the
respective API key in your project. For detailed installation instructions,
visit Google's Getting Started Guides for the [Google Places API for iOS]
(https://developers.google.com/places/ios-api/start).

# License and Terms of Service

By using the Google Places API for iOS, you accept Google's Terms of
Service and Policies. Pay attention particularly to the following aspects:

*   Depending on your app and use case, you may be required to display
    attribution. Read more about [attribution requirements]
    (https://developers.google.com/places/ios-api/attributions).
*   Your API usage is subject to quota limitations. Read more about [usage
    limits](https://developers.google.com/places/ios-api/usage).
*   The [Terms of Service](https://developers.google.com/maps/terms) are a
    comprehensive description of the legal contract that you enter with Google
    by using the Google Places API for iOS. You may want to pay special
    attention to [section 10]
    (https://developers.google.com/maps/terms#10-license-restrictions), as it
    talks in detail about what you can do with the API, and what you can't.
