import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/models/const_utils.dart';
import 'package:CraigStantonWeb/utils/widgets/image_carousel.dart';
import 'package:CraigStantonWeb/utils/widgets/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageHome();
  }
}

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  double iconSize = 24;

  double horizontalSpace = 30;

  Map<dynamic, dynamic> menuList = ConstUtils().stringUtils.menuItems;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: ResponsiveLayout.isSmallScreen(context)
              ? Alignment.topCenter
              : Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(
                top: ResponsiveLayout.isSmallORMediumScreen(context) ? 0 : 100,
                right: ResponsiveLayout.isLargeScreen(context) ? 100 : 0,
                bottom:
                    ResponsiveLayout.isSmallORMediumScreen(context) ? 50 : 0),
            child: ImageCarousel(),
            height: ResponsiveLayout.isSmallScreen(context)
                ? 300
                : ResponsiveLayout.isXLargeScreen(context)
                    ? 1000
                    : 600,
            width: ResponsiveLayout.isSmallScreen(context)
                ? 400
                : ResponsiveLayout.isXLargeScreen(context)
                    ? 1000
                    : 600,
          ),
        ),
        Align(
            alignment: ResponsiveLayout.isSmallScreen(context)
                ? Alignment.bottomCenter
                : Alignment.centerLeft,
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(
                  left: ResponsiveLayout.isSmallScreen(context) ? 0 : 250,
                  top: ResponsiveLayout.isSmallScreen(context) ? 150 : 160,
                  bottom: ResponsiveLayout.isSmallScreen(context) ? 100 : 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: ResponsiveLayout.isSmallScreen(context)
                      ? EdgeInsets.only(bottom: 14)
                      : EdgeInsets.only(bottom: 0),
                  child: Column(
                    crossAxisAlignment: ResponsiveLayout.isSmallScreen(context)
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ConstUtils().widgetUtils.menuTextWithSize(
                          context: context,
                          name: "HELLO, I’M",
                          textSizeSmall: 30,
                          textSizeMedium: 30,
                          textSizeLarge: 30),
                      ConstUtils().widgetUtils.spaceVertical(20),
                      ConstUtils().widgetUtils.headingText(
                          name: ConstUtils().stringUtils.fullname,
                          context: context,
                          textSizeLarge: 42,
                          textSizeMedium: 42,
                          textSizeSmall: 42),
                      ConstUtils().widgetUtils.spaceVertical(10),
                      ConstUtils().widgetUtils.contentText(
                            context: context,
                            name: ConstUtils().stringUtils.bio,
                          ),
                      ConstUtils().widgetUtils.spaceVertical(
                          ResponsiveLayout.isSmallScreen(context) ? 50 : 100),
                      Row(
                        mainAxisAlignment:
                            ResponsiveLayout.isSmallScreen(context)
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              launchUrl(ConstUtils().stringUtils.linkGithub);
                            },
                            child: Icon(
                              FontAwesomeIcons.github,
                              size: iconSize,
                            ),
                          ),
                          ConstUtils()
                              .widgetUtils
                              .spaceHorizontal(horizontalSpace),
                          InkWell(
                            onTap: () {
                              launchUrl(ConstUtils().stringUtils.linkLinkedIn);
                            },
                            child: Icon(
                              FontAwesomeIcons.linkedin,
                              size: iconSize,
                            ),
                          ),
                          ConstUtils()
                              .widgetUtils
                              .spaceHorizontal(horizontalSpace),
                          InkWell(
                            onTap: () {
                              launchUrl(ConstUtils().stringUtils.linkTwitter);
                            },
                            child: Icon(
                              FontAwesomeIcons.twitterSquare,
                              size: iconSize,
                            ),
                          ),
                          ConstUtils()
                              .widgetUtils
                              .spaceHorizontal(horizontalSpace),
                          InkWell(
                            onTap: () {
                              launchUrl("craig.stanton2@gmail.com");
                            },
                            child: Icon(
                              Icons.mail,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  // Widget to embed in template
                ),
              ),
            ))
      ],
    );
  }
}
