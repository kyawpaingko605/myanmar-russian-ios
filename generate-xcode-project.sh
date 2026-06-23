#!/bin/bash

# Generate Xcode project from Swift package
cd ios
swift package generate-xcodeproj
cd ..

echo "✅ Xcode project generated!"
echo "📱 Open: ios/MyanmarRussianLearner.xcodeproj"
