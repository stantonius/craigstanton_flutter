import '../layouts/ResponsiveLayout.dart';
import '../models/const_utils.dart';
import '../models/constants/widget_utils.dart';
import 'package:flutter/material.dart';
import '../widgets/circles.dart';
import 'package:flare_flutter/flare_actor.dart';

class MainPageTemplate extends StatefulWidget {
  final bodyWidget;
  const MainPageTemplate(this.bodyWidget);

  @override
  _MainPageTemplate createState() => _MainPageTemplate();
}

class _MainPageTemplate extends State<MainPageTemplate>
    with AutomaticKeepAliveClientMixin {
  Map<dynamic, dynamic> menuList = ConstUtils().stringUtils.menuItems;
  int clickPosition = 0;

  String _animationName = "craig_white";

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        body: Stack(alignment: Alignment.center, children: <Widget>[
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
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      height: 150,
                      width: 150,
                      child: new FlareActor(
                        "animations/CRAIG_white.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation:
                            _animationName, // CRITICAL IT IS SAME NAME AS ANIMATION IN RIVE
                      ),
                    ))
              ],
            ),
          ),
          widget.bodyWidget
        ]));
  }
}
