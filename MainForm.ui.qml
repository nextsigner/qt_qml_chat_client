/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Copyright (C) 2016 basysKom GmbH, author Bernd Lamecker <bernd.lamecker@basyskom.com>
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QtWebChannel module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    property alias message: message
    property alias txtTit: txtTit
    property alias nt: txtTit.nt
    property alias msgListView: msgListView
    property alias userListView: userListView

    Rectangle {
        width: parent.width
        height: 28
        border.width: 1
        Text {
            id: txtTit
            property int nt: 0
            property var titles: ["Its is a <b>CLIENT</b> app send/received message from all user connected to qt_qml_chat_server", "Download from github qt_qml_chat_server for received a message and connect multi users", "This client and the server app are connected in ws://localhost:12345 "]
            text: txtTit.titles[0]
            font.pixelSize: parent.width * 0.0225 < 26 ? parent.width * 0.0225 : 26
            anchors.centerIn: parent
        }
    }
    ColumnLayout {
        width: parent.width
        height: parent.height - y
        y: 28

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                border.width: 1
                Rectangle {
                    width: parent.width
                    height: 28
                    color: "black"
                    Text {
                        text: "<b>Messages</b>"
                        font.pixelSize: 24
                        anchors.centerIn: parent
                        color: "white"
                    }
                }

                ListView {
                    id: msgListView
                    width: parent.width
                    height: parent.height - 28
                    clip: true
                    y: 28
                    spacing: 10
                }
            }
            Rectangle {
                Layout.minimumWidth: parent.width * 0.3
                Layout.maximumWidth: parent.width * 0.3
                Layout.fillWidth: true
                Layout.fillHeight: true
                border.width: 1
                Rectangle {
                    width: parent.width
                    height: 28
                    color: "black"
                    Text {
                        text: "<b>User List</b>"
                        font.pixelSize: 24
                        anchors.centerIn: parent
                        color: "white"
                    }
                }
                ListView {
                    id: userListView
                    width: parent.width
                    height: parent.height - 28
                    clip: true
                    y: 28
                    spacing: 10
                }
            }
        }

        //        Text {
        //            id: userlist
        //            width: 150
        //            Layout.fillHeight: true
        //        }
        TextField {
            id: message
            height: 50
            Layout.fillWidth: true
            Layout.columnSpan: 2
        }
    }
}
