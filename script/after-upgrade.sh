#!/bin/sh

# Append additional files and directories to ignore
echo "
# Assets
/assets/
/scraper/
strings_secret.xml

# Code coverage
coverage/

# Build/bundle
ios/main.jsbundle

# Keystores
*/keystores/*

# Environment
*/env.js

# Typescript output
artifacts/
" >> .gitignore

# Update the package name of the app
sed -i '' 's/com\.campusguide/ca.josephroque.campusguide/g' ./android/app/build.gradle
sed -i '' 's/com\.campusguide/ca.josephroque.campusguide/g' ./android/app/src/main/AndroidManifest.xml
sed -i '' 's/com\.campusguide/ca.josephroque.campusguide/g' ./android/app/BUCK

# Fix broken library
sed -i '' 's/domain = require/\/\/domain = require/g' ./node_modules/asap/raw.js

# Fixing react-native-maps (check https://github.com/airbnb/react-native-maps/issues/1193)
sed -ie 's/RCTConvert\+MapKit\.m/RCTConvert\+AirMap\.m/g' node_modules/react-native-maps/lib/ios/AirMaps.xcodeproj/project.pbxproj
sed -ie 's/RCTConvert\+MapKit\.h/RCTConvert\+AirMap\.h/g' node_modules/react-native-maps/lib/ios/AirMaps.xcodeproj/project.pbxproj
rm -f node_modules/react-native-maps/.babelrc

# Remove the MainActivity files added in the new package
rm -r ./android/app/src/main/java/com/

# Link react-native dependencies
react-native link react-native-linear-gradient
react-native link react-native-vector-icons
react-native link react-native-maps
react-native link react-native-device-info
react-native link react-native-fs
react-native link react-native-snackbar
