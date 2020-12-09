import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/models/const_utils.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutView();
  }
}

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  bool flagwavePause = true;
  bool winkingCraig = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: ResponsiveLayout.isSmallScreen(context) ? 8 : 4,
            child: Card(
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: MouseRegion(
                        onHover: (event) {
                          setState(() {
                            winkingCraig = false;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            winkingCraig = true;
                          });
                        },
                        child: Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: 20),
                            height: 150,
                            width: 150,
                            child: FlareActor(
                              "animations/Craig_avatar.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              isPaused: winkingCraig,
                              animation:
                                  "craig_wink", // CRITICAL IT IS SAME NAME AS ANIMATION IN RIVE
                            ))),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                          child: ListTile(
                              title:
                                  Text(ConstUtils().stringUtils.aboutMeTitle),
                              subtitle: Text(
                                  ConstUtils().stringUtils.aboutMeContent))))
                ],
              ),
            ),
          ),
          Spacer(
            flex: 1,
          )
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: ResponsiveLayout.isSmallScreen(context) ? 8 : 4,
            child: Card(
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: MouseRegion(
                        onHover: (event) {
                          setState(() {
                            flagwavePause = false;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            flagwavePause = true;
                          });
                        },
                        child: Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: 20),
                            height: 150,
                            width: 150,
                            child: FlareActor(
                              "animations/Can_to_UK.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              isPaused: flagwavePause,
                              animation:
                                  "flight_path", // CRITICAL IT IS SAME NAME AS ANIMATION IN RIVE
                            ))),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                          child: ListTile(
                        title: Text(ConstUtils().stringUtils.aboutTravelTitle),
                        subtitle:
                            Text(ConstUtils().stringUtils.aboutTravelContent),
                      )))
                ],
              ),
            ),
          ),
          Spacer(
            flex: 1,
          )
        ]),
      ],
    );
  }
}
