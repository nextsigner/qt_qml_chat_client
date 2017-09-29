import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import Qt.WebSockets 1.0
import "qwebchannel.js" as WebChannel

ApplicationWindow {
    id: root

    property var channel
    property string loginName: loginUi.userName.text
    visible: true
    width: 640
    height: 480
    title: qsTr("qt_qml_chat_client by nextsigner")

    WebSocket {
        id: socket

        // the following three properties/functions are required to align the QML WebSocket API
        // with the HTML5 WebSocket API.
        property var send: function(arg) {
            sendTextMessage(arg);
        }

        onTextMessageReceived: {
            onmessage({data: message});
        }

        property var onmessage

        active: true
        //url: "ws://127.0.0.1:12345"
        url: "ws://127.0.0.1:12345"
        onStatusChanged: {
            switch (socket.status) {
            case WebSocket.Error:
                errorDialog.text = "Error: " + socket.errorString;
                errorDialog.visible = true;
                break;
            case WebSocket.Closed:
                errorDialog.text = "Error: Socket at " + url + " closed.";
                errorDialog.visible = true;
                break;
            case WebSocket.Open:
                //open the webchannel with the socket as transport
                new WebChannel.QWebChannel(socket, function(ch) {
                    root.channel = ch;

                    //connect to the changed signal of the userList property
                    ch.objects.chatserver.userListChanged.connect(function(args) {
                        mainUi.userlist.text = '';
                        ch.objects.chatserver.userList.forEach(function(user) {
                            mainUi.userlist.text += user + '\n';
                        });
                    });

                    //connect to the newMessage signal
                    ch.objects.chatserver.newMessage.connect(function(time, user, message) {
                        var line = "[" + time + "] " + user + ": " + message + '\n';
                        mainUi.chat.text = mainUi.chat.text + line;
                    });

                    //connect to the keep alive signal
                    ch.objects.chatserver.keepAlive.connect(function(args) {
                        if (loginName !== '')
                            //and call the keep alive response method as an answer
                            ch.objects.chatserver.keepAliveResponse(loginName);
                    });
                });

                loginWindow.show();
                break;
            }
        }
    }

    MainForm {
        id: mainUi
        anchors.fill: parent

        Connections {
            target: mainUi.message
            onEditingFinished: {
                if (mainUi.message.text.length) {
                    //call the sendMessage method to send the message
                    console.log("Enviando Mensaje desde Cliente... "+loginName+" "+mainUi.message.text)
                    root.channel.objects.chatserver.sendMessage(loginName,
                                                                mainUi.message.text);
                }
                mainUi.message.text = '';
            }
        }
    }

    Window {
        id: loginWindow

        title: "Login"
        modality: Qt.ApplicationModal
        width: 300
        height: 200

        LoginForm {
            id: loginUi
            anchors.fill: parent

            nameInUseError.visible: false

            Connections {
                target: loginUi.loginButton

                onClicked: {
                    //call the login method
                    root.channel.objects.chatserver.login(loginName, function(arg) {
                        //check the return value for success
                        if (arg === true) {
                            loginUi.nameInUseError.visible = false;
                            loginWindow.close();
                        } else {
                            loginUi.nameInUseError.visible = true;
                        }
                    });
                }
            }
        }
    }

    MessageDialog {
        id: errorDialog

        icon: StandardIcon.Critical
        standardButtons: StandardButton.Close
        title: "Chat client"

        onAccepted: {
            Qt.quit();
        }
        onRejected: {
            Qt.quit();
        }
    }
}
