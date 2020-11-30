import 'package:CraigStantonWeb/main.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../layouts/ResponsiveLayout.dart';
import '../models/const_utils.dart';
import '../models/constants/widget_utils.dart';
import 'package:flutter/material.dart';
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
                : Size.fromHeight(50.0),
            // here the desired height
            child: AppBar(
              centerTitle: true,
              elevation: 0.0,

              iconTheme: new IconThemeData(color: Colors.white),

              // ...
            )),
        drawer: ResponsiveLayout.isSmallScreen(context)
            ? Drawer(
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      child: ConstUtils().widgetUtils.headingText(
                          name: ConstUtils().stringUtils.fullname,
                          context: context,
                          textSizeLarge: 32,
                          textSizeMedium: 22,
                          textSizeSmall: 18),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: 20, bottom: 20, left: 10, right: 10),
                        child: WidgetUtils()
                            .lineHorizontal(color: Colors.black45, height: 1)),
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
                    ThemeSwitch()
                  ],
                )),
              )
            : null,
        body: Stack(alignment: Alignment.center, children: <Widget>[
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
                                  //clickPosition = index;
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
                    )),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        padding: EdgeInsets.only(top: 20),
                        child: ThemeSwitch()))
              ],
            ),
          ),
          widget.bodyWidget
        ]));
  }
}

class ThemeSwitch extends HookWidget {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = useProvider(appThemeProvider).state;

    return Container(
        child: Switch(
      value: isDarkTheme,
      activeColor: Color(0xfff8f9fa),
      activeTrackColor: Color(0xff6c757d),
      inactiveTrackColor: Color(0xff6c757d),
      inactiveThumbColor: Color(0xff212529),
      onChanged: (newValue) {
        context.read(appThemeProvider).state = !isDarkTheme;
        print(newValue);
      },
    ));
  }
}
