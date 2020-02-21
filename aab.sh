#!/bin/sh

NAME="app"
TARGET_NAME="app"

MODE="universal"
APK_FOLDER="apk"

AAB="$NAME.aab"
APKS=$NAME.apks
APK="$APK_FOLDER/$MODE.apk"

TARGET_AAB="$TARGET_NAME.aab"
TARGET_APKS="$TARGET_NAME.apks"
TARGET_APK="$APK_FOLDER/$TARGET_NAME.apk"

PWD="android"
KEYSTORE="jks/test.jks"
ALIAS="android"

if [ -f $DEFAULT_AAB ]; then
    java -jar bundletool.jar build-apks --overwrite --mode=$MODE --bundle=$AAB --output=$APKS --ks=$KEYSTORE --ks-key-alias=$ALIAS --ks-pass=pass:$PWD
else
    echo "cannot find $AAB"
fi

if [ -f $APKS ]; then
    unzip $APKS -d $APK_FOLDER
else 
    echo "cannot find $APKS"
fi

if [ ! -f $TARGET_AAB ] && [ -f $AAB ]; then
    mv -f $AAB $TARGET_AAB
else
    echo "cannot find $AAB or target $TARGET_AAB already exists"
fi

if [ ! -f $TARGET_APKS ] && [ -f $APKS ]; then
    mv -f $APKS $TARGET_APKS
fi

if [ ! -f $TARGET_APK ] && [ -f $APK ]; then
    mv -f $APK $TARGET_APK
fi

zip -er $TARGET_NAME.zip $APK_FOLDER 