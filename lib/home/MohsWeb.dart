import 'package:cached_network_image/cached_network_image.dart';
import 'package:coronamongolia/Styles.dart';
import 'package:coronamongolia/custom/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Strings.dart';

class MohsWeb extends StatefulWidget {
  @override
  _MohsWebState createState() => _MohsWebState();
}

class _MohsWebState extends State<MohsWeb> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: PageView(
                controller: controller,
                children: <Widget>[
                  _infoPageItem("https://covid19.mohs.mn/documents/icon/med9.png",INFO_TITLE_1,text: INFO_TEXT_1),
                  _infoPageItem("https://covid19.mohs.mn/documents/icon/med8.png",INFO_TITLE_2,text: INFO_TEXT_2,textList: INFO_TEXT_LIST_2),
                  _infoPageItem("https://covid19.mohs.mn/documents/icon/med7.png",INFO_TITLE_3,text: INFO_TEXT_3,textList: INFO_TEXT_LIST_3),
                  _infoPageItem("https://covid19.mohs.mn/documents/icon/med6.png",INFO_TITLE_4,textList: INFO_TEXT_LIST_4),
                  _infoPageItem("https://covid19.mohs.mn/documents/icon/med5.png",INFO_TITLE_5,text: INFO_TEXT_5),
                  _infoPageItem("https://covid19.mohs.mn/documents/icon/med4.png",INFO_TITLE_6,text: INFO_TEXT_6),
                  _infoPageItem("https://covid19.mohs.mn/documents/icon/med3.png",INFO_TITLE_7,textList: INFO_TEXT_LIST_7),
                  _infoPageItem("https://covid19.mohs.mn/documents/icon/med2.png",INFO_TITLE_8,textList: INFO_TEXT_LIST_8),
                  _infoPageItem("https://covid19.mohs.mn/documents/icon/med1.png",INFO_TITLE_9,text: INFO_TEXT_9),
                ],
              ),
            ),
          ),
          Container(height: 8,),
          SmoothPageIndicator(
            controller: controller,
            count: 9,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: primaryColor,
              dotColor: shadowColor
            ),
          )
        ],
      ),
    );
  }

  Widget _infoPageItem(String image, String title, {String text, List<String> textList}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 24),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 10.0, // has the effect of softening the shadow
                        spreadRadius: 8.0,
                        offset: Offset(0,0)// has the effect of extending the shadow
                      )
                    ]
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            text != null ? Text(
              text,
              style: TextStyle(
                fontSize: 16,
              ),
            ) : Container(),
            textList != null ? Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: textList.map((text){
                  return Text(
                    LIST_DOT+text+"\n",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  );
                }).toList()
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
