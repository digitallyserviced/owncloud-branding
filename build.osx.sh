#!/bin/bash
TMP=tmp/
MIRALL=~/work/mirall
OCSYNC=~/work/ocsync
BUILD_TYPE="Debug"
OUTPUT=output/
SHORTNAME=$1
THEME_DIR=`pwd`
mkdir -p ${TMP}


writeThemeQrc ()
{
    SHORTNAME=$1
    cat > theme.qrc <<THEMEQRCDATA
<RCC>
    <qresource prefix="/mirall">
        <file>theme/colored/state-sync-32.png</file>
        <file>theme/colored/state-pause-32.png</file>
        <file>theme/colored/state-ok-32.png</file>
        <file>theme/colored/state-offline-32.png</file>
        <file>theme/colored/state-error-32.png</file>
        <file>theme/colored/state-information-32.png</file>
        <file>theme/black/state-sync-32.png</file>
        <file>theme/black/state-pause-32.png</file>
        <file>theme/black/state-ok-32.png</file>
        <file>theme/black/state-offline-32.png</file>
        <file>theme/black/state-error-32.png</file>
        <file>theme/black/state-information-32.png</file>
        <file>theme/white/state-sync-32.png</file>
        <file>theme/white/state-pause-32.png</file>
        <file>theme/white/state-ok-32.png</file>
        <file>theme/white/state-offline-32.png</file>
        <file>theme/white/state-error-32.png</file>
        <file>theme/white/state-information-32.png</file>
        <file>theme/colored/state-sync-64.png</file>
        <file>theme/colored/state-pause-64.png</file>
        <file>theme/colored/state-ok-64.png</file>
        <file>theme/colored/state-offline-64.png</file>
        <file>theme/colored/state-error-64.png</file>
        <file>theme/colored/state-information-64.png</file>
        <file>theme/black/state-sync-64.png</file>
        <file>theme/black/state-pause-64.png</file>
        <file>theme/black/state-ok-64.png</file>
        <file>theme/black/state-offline-64.png</file>
        <file>theme/black/state-error-64.png</file>
        <file>theme/black/state-information-64.png</file>
        <file>theme/white/state-sync-64.png</file>
        <file>theme/white/state-pause-64.png</file>
        <file>theme/white/state-ok-64.png</file>
        <file>theme/white/state-offline-64.png</file>
        <file>theme/white/state-error-64.png</file>
        <file>theme/white/state-information-64.png</file>
        
        <file>theme/colored/wizard_logo.png</file>
        <file>theme/colored/$SHORTNAME-icon-22.png</file>
        <file>theme/colored/$SHORTNAME-icon-32.png</file>
        <file>theme/colored/$SHORTNAME-icon-48.png</file>
        <file>theme/colored/$SHORTNAME-icon-64.png</file>
        <file>theme/colored/$SHORTNAME-icon-128.png</file>
    </qresource>
</RCC>

THEMEQRCDATA

}

rm -Rf theme
pushd '../base-files-1600'
cp -Rf * ${THEME_DIR}/
popd

convert template.png -crop 128x128+47+31 png32:${TMP}desktop.icon.png

convert ${TMP}desktop.icon.png -resize 128x128 png32:theme/colored/$SHORTNAME-icon-128.png
convert ${TMP}desktop.icon.png -resize 64x64 png32:theme/colored/$SHORTNAME-icon-64.png
convert ${TMP}desktop.icon.png -resize 48x48 png32:theme/colored/$SHORTNAME-icon-48.png
convert ${TMP}desktop.icon.png -resize 32x32 png32:theme/colored/$SHORTNAME-icon-32.png
convert ${TMP}desktop.icon.png -resize 22x22 png32:theme/colored/$SHORTNAME-icon-22.png
convert ${TMP}desktop.icon.png -resize 16x16 png32:theme/colored/$SHORTNAME-icon-16.png
convert ${TMP}desktop.icon.png -resize 16x16 png32:theme/colored/$SHORTNAME-icon-16.png

convert template.png -crop 132x63+45+293 png32:theme/colored/wizard_logo.png

convert template.png -crop 150x57+222+31 bmp3:nsi/page_header.bmp
convert template.png -crop 164x314+417+31 bmp3:nsi/welcome.bmp

writeThemeQrc "${SHORTNAME}"

mkdir -p osx-build
cd osx-build
rm -Rf *
cmake -DOEM_THEME_DIR=${THEME_DIR} -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DQTKEYCHAIN_INCLUDE_DIR=/usr/local/include/ \
    -DQTKEYCHAIN_LIBRARY=/usr/local/lib/libqt5keychain.dylib -DBUILD_WITH_QT4=OFF -DBUILD_OWNCLOUD_OSX_BUNDLE=ON \
    -DCSYNC_BUILD_PATH=${OCSYNC}-build -DCSYNC_INCLUDE_PATH=${OCSYNC}/src -DCMAKE_PREFIX_PATH=/usr/local/Cellar/qt5/5.2.1/lib/cmake/ \
    -DNEON_INCLUDE_DIRS=/usr/local/Cellar/neon/0.30.0/include -DNEON_LIBRARIES=/usr/local/Cellar/neon/0.30.0/lib/libneon.dylib \
    $MIRALL 

read test?"Press Enter To Continue Build"

make
cp -Rf /usr/local/lib/libqt5keychain.* desktopsync.app/Contents/MacOS/
make package
cd ..
mkdir -p clients
cp -Rf osx-build/*.dmg ./clients/
