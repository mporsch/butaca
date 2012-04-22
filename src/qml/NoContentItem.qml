import QtQuick 1.1
import com.nokia.meego 1.0
import 'constants.js' as UIConstants

Item {
    property alias text: noContentText.text

    Label {
        id: noContentText
        platformStyle: LabelStyle {
            fontPixelSize: UIConstants.FONT_XLARGE
        }
        color: !theme.inverted ?
                   UIConstants.COLOR_FOREGROUND :
                   UIConstants.COLOR_INVERTED_FOREGROUND
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap
        anchors.centerIn: parent
        opacity: 0.5
    }
}
