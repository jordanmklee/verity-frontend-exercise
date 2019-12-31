import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 1024
    height: 768
    title: qsTr("verity-frontend-exercise")

    Rectangle{
        id: headerContainer
        width: parent.width;
        height: headerTitle.height

        Text{
            id: headerTitle
            anchors.left: headerContainer.left
            anchors.leftMargin: 10
            font.pointSize: 48;
            font.bold: true
            text: qsTr("Page title")
        }

        Rectangle{
            id: socialIcons
            anchors.right: headerContainer.right
            anchors.top: headerContainer.top
            anchors.rightMargin: 10
            anchors.topMargin: 10
            width: githubIcon.width + facebookIcon.width

            Image{
                id: githubIcon
                source: "github.png"
                anchors.right: facebookIcon.left
                anchors.rightMargin: 10
            }

            Image{
                id: facebookIcon
                source: "facebook.png"
                anchors.right: socialIcons.right
            }

        }
    }



    Rectangle{
        id: contentContainer
        width: parent.width; height: (contentTitle.height + contentBodyContainer.height)
        anchors.top: headerContainer.bottom
        anchors.topMargin: 10

        Text{
            id: contentTitle
            anchors.left: contentContainer.left
            anchors.leftMargin: 10
            font.pointSize: 36
            text: qsTr("Page sub-title")
        }

        Rectangle{
            id: contentBodyContainer
            width: contentContainer.width;
            height: (imageContainer.height >= contentBody.height) ? imageContainer.height : contentBody.height
            anchors.top: contentTitle.bottom

            Rectangle{
                id: imageContainer
                width: 500; height: 300
                clip: true
                anchors.left: contentBodyContainer.left
                anchors.top: contentBodyContainer.top
                anchors.leftMargin: 10
                anchors.topMargin: 10

                MouseArea{
                    anchors.fill: parent
                    onWheel: {
                        // Mouse location before zoom
                        var before = mapToItem(img, wheel.x, wheel.y);
                        var beforePercentX = before.x / img.width;
                        var beforePercentY = before.y / img.height;

                        // Scale image
                        img.width += wheel.angleDelta.y * (imageContainer.width/100);
                        img.height += wheel.angleDelta.y * (imageContainer.height/100);

                        // Minimum Scale
                        if(img.width < imageContainer.width || img.height < imageContainer.height){
                            img.width = imageContainer.width;
                            img.height = imageContainer.height;
                        }

                        // Mouse location after zoom
                        var after = mapToItem(img, wheel.x, wheel.y);
                        var afterPercentX = after.x / img.width;
                        var afterPercentY = after.y / img.height;

                        // Mouse point centering
                        var offsetX = (afterPercentX - beforePercentX) * img.width;
                        var offsetY = (afterPercentY - beforePercentY) * img.height;

                        // For zooming out, keep image within container
                        var topLeft = mapToItem(img, 0, 0);
                        var botRight = mapToItem(img, imageContainer.width, imageContainer.height)

                        if(topLeft.x < 0)
                            offsetX += topLeft.x;
                        if(topLeft.y < 0)
                            offsetY += topLeft.y;
                        if(botRight.x > img.width)
                            offsetX += (botRight.x - img.width);
                        if(botRight.y > img.height)
                            offsetY += (botRight.y - img.height);

                        // Translate image
                        trans.x += offsetX;
                        trans.y += offsetY;
                    }
                }

                Image{
                    id: img
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: imageContainer.horizontalCenter
                    anchors.verticalCenter: imageContainer.verticalCenter
                    source: "placeholder.png"

                    transform: Translate{
                        id: trans
                    }
                }
            }

            Text{
                id: contentBody
                width: contentBodyContainer.width - 20
                anchors.left: contentBodyContainer.left
                anchors.top: contentBodyContainer.top
                anchors.leftMargin: 10
                anchors.topMargin: 10
                wrapMode: Text.WrapAnywhere
                font.pointSize: 18
                text: qsTr("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Felis bibendum ut tristique et egestas quis ipsum. Faucibus vitae aliquet nec ullamcorper sit amet risus nullam eget. Eu feugiat pretium nibh ipsum consequat nisl vel pretium. Sodales neque sodales ut etiam sit amet nisl purus. Eu lobortis elementum nibh tellus molestie nunc. Volutpat blandit aliquam etiam erat velit scelerisque in dictum. Felis eget velit aliquet sagittis id consectetur purus ut faucibus. Proin fermentum leo vel orci porta non pulvinar. Lectus vestibulum mattis ullamcorper velit. Sed id semper risus in hendrerit gravida rutrum. Feugiat vivamus at augue eget. Mauris in aliquam sem fringilla ut morbi tincidunt augue. Diam maecenas ultricies mi eget mauris pharetra et ultrices. Viverra vitae congue eu consequat ac felis donec. In mollis nunc sed id semper. Amet consectetur adipiscing elit duis tristique. Lacus suspendisse faucibus interdum posuere lorem ipsum dolor sit amet. A erat nam at lectus urna. Malesuada fames ac turpis egestas.")

                // Wrap text around imageContainer
                onLineLaidOut: {
                    if(line.y < imageContainer.height){
                        line.x += imageContainer.width + 10;
                        line.width -= imageContainer.width + 10;
                    }
                }
            }

        }
    }



}
