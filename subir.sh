#!/bin/bash
git add *.md
git add *.js
git add *.cpp
git add *.qml
git add *.pro
git add *.qrc
git add *.conf
git add *.AppImage
git add *.sh
git commit -m "$1"
git push -u origin master
