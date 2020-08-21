import QtQuick 2.15
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import TableModel 1.0

TableView {
    id: _tableView
    columnSpacing: 1
    rowSpacing: 1
    interactive : false

    model: DatabaseModel{}

    delegate: Rectangle {
        implicitHeight: 30
        implicitWidth: Math.max(_text.contentWidth + 10, _tabView.width / columns)
        id: _delegate
        color: "green"
        TextEdit {
            id: _text
            anchors.centerIn: _delegate
            text: display

            onEditingFinished: {
                console.log("edited " + _text.text)
                _tableView.model.resetData()
            }
        }
    } // Delegate

    Component.onCompleted: {
         _tableView.model.changeTab(currentIndex);
    }
} // TableView
