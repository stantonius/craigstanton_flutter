import 'package:CraigStantonWeb/utils/widgets/image_carousel.dart';

import '../utils/views/home_view.dart';
import '../utils/ResponsiveLayout.dart';
import '../utils/const_utils.dart';
import '../utils/widget_utils.dart';
import 'package:flutter/material.dart';
import '../utils/widgets/circles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<dynamic, dynamic> menuList = ConstUtils().stringUtils.menuItems;
  int clickPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: ResponsiveLayout.isSmallScreen(context)
              ? Size.fromHeight(50.0)
              : Size.fromHeight(0.0),
          // here the desired height
          child: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.red,
            iconTheme: new IconThemeData(color: Colors.white),

            // ...
          )),
      drawer: ResponsiveLayout.isSmallScreen(context)
          ? Drawer(
              child: Container(
                  color: ConstUtils().colorUtils.blackBG_A,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        child: ConstUtils().widgetUtils.headingText(
                            name: ConstUtils().stringUtils.fullname,
                            color: Colors.white,
                            context: context,
                            textSizeLarge: 32,
                            textSizeMedium: 22,
                            textSizeSmall: 18),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 10),
                          child: WidgetUtils().lineHorizontal(
                              color: Colors.black45, height: 1)),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: menuList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.yellow,
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: ConstUtils().widgetUtils.menuButtons(
                                    menuList.keys.elementAt(index),
                                    menuList[menuList.keys.elementAt(index)],
                                    context),
                              ),
                              onTap: () {
                                setState(() {
                                  clickPosition = index;
                                  Navigator.of(context).pop();
                                });
                              },
                            );
                          }),
                    ],
                  )),
            )
          : null,
      body: bodyUI(),
    );
  }

  Widget bodyUI() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        //BackgroundCircles(),
        Visibility(
          visible: ResponsiveLayout.isSmallScreen(context) ? false : true,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    height: 80,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: menuList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            splashColor: Colors.yellow,
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: ConstUtils().widgetUtils.menuButtons(
                                  menuList.keys.elementAt(index),
                                  menuList[menuList.keys.elementAt(index)],
                                  context),
                            ),
                            onTap: () {
                              setState(() {
                                clickPosition = index;
                              });
                            },
                          );
                        }),
                  ))
            ],
          ),
        ),
        Align(
          alignment: ResponsiveLayout.isSmallScreen(context)
              ? Alignment.topCenter
              : Alignment.topRight,
          child: Visibility(
            visible: ResponsiveLayout.isSmallScreen(context)
                ? clickPosition != 0 ? false : true
                : true,
            child: Container(
              margin: EdgeInsets.only(
                top: 100,
              ),
              child: ImageCarousel(),
              height: ResponsiveLayout.isSmallScreen(context) ? 300 : 600,
              width: ResponsiveLayout.isSmallScreen(context) ? 300 : 600,
            ),
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
                top: ResponsiveLayout.isSmallScreen(context) ? 100 : 160),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical, child: PageHome()),
          ),
        )
      ],
    );
  }
}
