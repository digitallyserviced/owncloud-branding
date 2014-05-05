/*
 * Copyright (C) by Klaas Freitag <freitag@owncloud.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
 * for more details.
 */

#ifndef MYTHEME_THEME_H
#define MYTHEME_THEME_H

#include "mirall/theme.h"
#include "mirall/version.h"
#include "config.h"

#include <QString>
#include <QDebug>
#include <QPixmap>
#include <QIcon>
#include <QApplication>

 namespace Mirall {

  class myCloudTheme : public Theme
  {
  public:
    myCloudTheme(){};

    QString configFileName() const { return QLatin1String(APPLICATION_CONFIG_FILE); }
    QIcon   trayFolderIcon( const QString& ) const { return themeIcon( QLatin1String(APPLICATION_TRAYFOLDER_ICON) ); }
    QIcon   folderDisabledIcon() const { return themeIcon( QLatin1String("state-pause") ); }
    QIcon   applicationIcon() const { return themeIcon( QLatin1String(APPLICATION_APP_ICON) ); }
    QString defaultServerFolder() const { return  QLatin1String("/"); }
    QString overrideServerUrl() const { return QLatin1String(APPLICATION_SYNC_URL); }
    //QPixmap wizardHeaderLogo() const { return applicationIcon().pixmap(64); }
    QColor  wizardHeaderBackgroundColor() const { return QColor(APPLICATION_HEADER_BG_COLOR); }
    QColor  wizardHeaderTitleColor() const { return QColor(APPLICATION_HEADER_BG_COLOR); }
    QPixmap wizardHeaderLogo() const { return QPixmap(":/mirall/theme/colored/wizard_logo.png"); }

    QString about() const {
      QString devString;
      return  QCoreApplication::translate("ownCloudTheme::about()",
       "<p>Version %2. "
       "For more information visit <a href=\"%3\">%4</a></p>"
       "<p></p>"
       "%7"
       )
      .arg(MIRALL_STRINGIFY(MIRALL_VERSION))
      .arg("http://" MIRALL_STRINGIFY(APPLICATION_DOMAIN))
      .arg(MIRALL_STRINGIFY(APPLICATION_DOMAIN))
      .arg(devString);
    }

    QPixmap splashScreen() const;

    QIcon   folderIcon( const QString& ) const;
    
    QVariant customMedia(CustomMediaType type){
      return QCoreApplication::translate("ownCloudTheme", "");
    }

    QString helpUrl() const {
      return QString::fromLatin1(APPLICATION_HELP_URL).arg(MIRALL_VERSION_MAJOR).arg(MIRALL_VERSION_MINOR);
    }
  private:


  };

}
#endif // MYTHEME_MIRALL_THEME_H
