#!/bin/bash
TMP=tmp/
OUTPUT=output/
SHORTNAME=$1
THEME_DIR=`pwd`

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

cp -Rf '../!skeleton-1600/theme' ./

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

mkdir build
cd build 
rm -Rf *
cmake -DCMAKE_BUILD_TYPE="Release" /home/xcezzz/mirall -DCSYNC_BUILD_PATH=/home/xcezzz/ocsync-build -DCSYNC_INCLUDE_PATH=/home/xcezzz/ocsync/src -DCMAKE_TOOLCHAIN_FILE=../mirall/admin/win/Toolchain-mingw32-openSUSE.cmake -DOEM_THEME_DIR=${THEME_DIR}
make package
cp /home/xcezzz/mirall-build/${SHORTNAME}-1.6.0.0beta1-setup.exe ./
