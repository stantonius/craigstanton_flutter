import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/models/const_utils.dart';
import 'package:CraigStantonWeb/utils/models/constants/widget_utils.dart';
import 'package:CraigStantonWeb/utils/routes/router.dart';
import 'package:CraigStantonWeb/utils/routes/route_names.dart';
import 'package:CraigStantonWeb/utils/services/locator/locator.dart';
import 'package:CraigStantonWeb/utils/services/locator/navigation.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';

class MainLayoutTemplate extends HookWidget {
  final Widget child;
  MainLayoutTemplate({Key key, @required this.child}) : super(key: key);

  final Map<dynamic, dynamic> menuList = ConstUtils().stringUtils.menuItems;
  final String _animationNameWhite = "craig_white";
  final String _animationNameBlack = "craig_black";

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = useProvider(appThemeProvider).state;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: ResponsiveLayout.isSmallScreen(context)
                ? Size.fromHeight(60.0)
                : Size.fromHeight(0.0),
            // here the desired height

            child: AppBar(
              centerTitle: true,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.white),
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    });
              }),
              title: Container(
                  padding: EdgeInsets.only(top: 5),
                  height: 60,
                  width: 60,
                  child: FlareActor("animations/CRAIG_white.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: _animationNameWhite)),
            )),
        drawer: ResponsiveLayout.isSmallScreen(context)
            ? Drawer(
                child: Container(
                    height: 100,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 30),
                          child: ConstUtils().widgetUtils.headingText(
                              name: ConstUtils().stringUtils.fullname,
                              context: context,
                              textSizeLarge: 32,
                              textSizeMedium: 22,
                              textSizeSmall: 30),
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
                              return Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: ConstUtils().widgetUtils.menuButtons(
                                    menuList.keys.elementAt(index),
                                    menuList[menuList.keys.elementAt(index)],
                                    context),
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ThemeSwitch(),
                        )
                      ],
                    )),
              )
            : null,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            /// The child widget needs to go first otherwise you cannot select the
            /// buttons
            child,
            Stack(alignment: Alignment.center, children: <Widget>[
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
                                  return ConstUtils().widgetUtils.menuButtons(
                                      menuList.keys.elementAt(index),
                                      menuList[menuList.keys.elementAt(index)],
                                      context);
                                }))),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        height: 150,
                        width: 150,
                        child: isDarkTheme
                            ? FlareActor("animations/CRAIG_white.flr",
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                animation: _animationNameWhite)
                            : FlareActor("animations/CRAIG_black.flr",
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                animation: _animationNameBlack),

// CRITICAL IT IS SAME NAME AS ANIMATION IN RIVE
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            padding: EdgeInsets.only(top: 20),
                            child: ThemeSwitch()))
                  ],
                ),
              ),
            ]),
          ],
        ));
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
