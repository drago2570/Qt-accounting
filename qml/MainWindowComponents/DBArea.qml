import QtQuick 2.15
import TableModel 1.0
import QtQuick.Controls 2.15

Rectangle {
    id: _root
    property alias _model:_tableView.model

    color: "grey"

    VerticalHeaderView {
        id: _verticalHeader
        implicitWidth: 30
        height: _root.height
        interactive: false
        rowSpacing: 1

        model: _tableView.rows + 1

        delegate: Rectangle {
            id: _verticalHeaderDelegate
            implicitHeight: index === 0 ? 50 : 30
            implicitWidth: 30
            color: "lightblue"

            Text {
                anchors.centerIn: _verticalHeaderDelegate
                text: index === 0 ? "№" : index
            } // Text
        } // delegate
    } // VerticalHeaderView

    HorizontalHeaderView {
        id: _horizontalHeader
        anchors.left: _tableView.left
        implicitWidth: _root.width
        height: 50
        syncView: _tableView
        interactive : false
        columnSpacing: 1

        delegate: Rectangle{
            id: _horizontalHeaderDelegate
            implicitHeight: _horizontalHeader.height
            implicitWidth: Math.max(_horizontalHeaderText.contentWidth + 10, _tableView.width / _tableView.columns)
            color: "lightblue"
            Text {
                id: _horizontalHeaderText
                text: display
                anchors.centerIn: _horizontalHeaderDelegate
            }

            MouseArea {
                id: _headerMouseArea
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    if(mouse.button === Qt.LeftButton)
                    {
                        _tableView.model.sortColumn(index)
                    }
                }
            } // MouseArea
        } // delegate
    } // HorizontalHeaderView

    TableView {
        id: _tableView
        width: _root.width - 30
        height: _root.height - 50
        anchors.top: _horizontalHeader.bottom
        anchors.left: _verticalHeader.right
        anchors.topMargin: 1
        anchors.leftMargin: 1
        columnSpacing: 1
        rowSpacing: 1
        interactive : false

        model: DatabaseModel{}

        delegate: Rectangle {
            id: _tableViewDelegate
            implicitHeight: 30
            implicitWidth: Math.max(_tableViewText.contentWidth + 10, _tableView.width / _tableView.columns)
            color: "green"
            TextEdit {
                id: _tableViewText
                anchors.centerIn: _tableViewDelegate
                text: display

                onEditingFinished: {
                    _tableView.model.editField(index, _tableViewText.text)
                    console.log("edited " + _tableViewText.text)
                }
            } // TextEdit
        } // Delegate
    } // TableView
} // Item
