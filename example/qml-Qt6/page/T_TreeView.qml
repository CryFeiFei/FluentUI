import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import FluentUI
import "qrc:///example/qml/component"

FluContentPage {

    title:"TreeView"

    function treeData(){
        const dig = (path = '0', level = 4) => {
            const list = [];
            for (let i = 0; i < 9; i += 1) {
                const key = `${path}-${i}`;
                const treeNode = {
                    title: key,
                    key,
                };
                if (level > 0) {
                    treeNode.children = dig(key, level - 1);
                }
                list.push(treeNode);
            }
            return list;
        };
        return dig();
    }

    Column{
        id:layout_column
        spacing: 12
        width: 300
        anchors{
            topMargin: 20
            top:parent.top
            left: parent.left
            leftMargin: 10
            bottom:parent.bottom
            bottomMargin: 20
        }

        FluText{
            text:"共计%1条数据，当前显示的%2条数据".arg(tree_view.count()).arg(tree_view.visibleCount())
        }

        RowLayout{
            spacing: 10
            FluText{
                text:"cellHeight:"
                Layout.alignment: Qt.AlignVCenter
            }
            FluSlider{
                id:slider_cell_height
                value: 30
                from: 30
                to:100
            }
        }
        RowLayout{
            spacing: 10
            FluText{
                text:"depthPadding:"
                Layout.alignment: Qt.AlignVCenter
            }
            FluSlider{
                id:slider_depth_padding
                value: 30
                from: 30
                to:100
            }
        }
        FluToggleSwitch{
            id:switch_showline
            text:"showLine"
            checked: true
        }
        FluToggleSwitch{
            id:switch_draggable
            text:"draggable"
            checked: true
        }
        FluButton{
            text:"all expand"
            onClicked: {
                tree_view.allExpand()
            }
        }
        FluButton{
            text:"all collapse"
            onClicked: {
                tree_view.allCollapse()
            }
        }
    }
    FluArea{
        anchors{
            left: layout_column.right
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            rightMargin: 5
            topMargin: 5
            bottomMargin: 5
        }
        FluShadow{}
        FluTreeView{
            id:tree_view
            anchors.fill: parent
            cellHeight: slider_cell_height.value
            draggable:switch_draggable.checked
            showLine: switch_showline.checked
            depthPadding: slider_depth_padding.value
            Component.onCompleted: {
                var data = treeData()
                dataSource = data
            }
        }
    }
}
