import 'package:flutter/material.dart';
import '../../utils/ResponsiveLayout.dart';
import '../../utils/const_utils.dart';
import '../../utils/widget_utils.dart';

class MainMenu extends StatelessWidget {
  Map<dynamic, dynamic> menuList = ConstUtils().stringUtils.menuItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PreferredSize(
          preferredSize: ResponsiveLayout.isSmallScreen(context)
              ? Size.fromHeight(50.0)
              : Size.fromHeight(0.0),
          // here the desired height
          child: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: ConstUtils().colorUtils.blackBG_A,
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
                            color: Colors.yellow,
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
    );
  }
}
