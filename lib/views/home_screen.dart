import 'dart:math';

import 'package:course_example/managers/skew_manager.dart';
import 'package:course_example/widgets/wave_animation.dart';
import 'package:flutter/material.dart';
import 'package:oak_tree/oak_tree.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool doneLoading = false;
  bool isBoatVisible = true;
  bool showStartButton = false;
  bool showAlarmButton = false;
  bool showPortHoleButton = false;
  late AnimationController bobbingController;
  late Animation<double> bobbingAnimation;
  late AnimationController pitchController;
  late Animation<double> pitchAnimation;

  @override
  void initState() {
    super.initState();

    bobbingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1244),
    )..addListener(() {
        setState(() {});
      });

    final Animation<double> curve =
        CurvedAnimation(parent: bobbingController, curve: Curves.easeInOut);

    bobbingAnimation = Tween<double>(begin: 195, end: 215).animate(curve);

    pitchController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1247));
    final Animation<double> pitchCurve =
        CurvedAnimation(parent: pitchController, curve: Curves.easeInOut);
    pitchAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(pitchCurve);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        doneLoading = true;
      });

      bobbingController
        ..forward()
        ..repeat(reverse: true);

      pitchController
        ..forward()
        ..repeat(reverse: true);

      await Future.delayed(Duration(milliseconds: 1750));
      setState(() {
        showStartButton = true;
      });

      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        showAlarmButton = true;
      });

      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        showPortHoleButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Stack(
          children: [
            Positioned(
              top: 50,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: IconButton(
                  onPressed: () {
                    oak<SkewManager>().toggle();
                  },
                  icon: Icon(Icons.menu),
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 20,
              child: Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.black54,
                ),
              ),
            ),
            Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.easeInOut,
                  top: !doneLoading ? -100 : 225,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height + 300,
                    child: Stack(
                      children: [
                        WaveAnimation(
                          waveColor: Colors.blueAccent.shade400,
                          height: 12,
                          offset: 1,
                          speed: 2500,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Positioned(
                    top: bobbingAnimation.value,
                    left: 75,
                    child: Transform.rotate(
                      angle: pitchAnimation.value,
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Image(
                            image: AssetImage(
                          'assets/sailboat.png',
                        )),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.easeInOut,
                  top: !doneLoading ? -100 : 300,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height + 300,
                    child: WaveAnimation(
                      waveColor: Colors.blueAccent,
                      height: 12,
                      offset: MediaQuery.of(context).size.width * 0.65,
                      speed: 2500,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: showStartButton ? 1 : 0,
                  duration: Duration(milliseconds: 250),
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 250,
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Start meditating',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Icon(
                              Icons.access_time,
                              color: Colors.white,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.shade400,
                              blurRadius: 6.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                0.0,
                                3.0,
                              ),
                            ),
                          ],
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AnimatedOpacity(
                  opacity: showAlarmButton ? 1 : 0,
                  duration: Duration(milliseconds: 250),
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 250,
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Set a reminder',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Icon(
                              Icons.add_alert_sharp,
                              color: Colors.white,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.shade400,
                              blurRadius: 6.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                0.0,
                                3.0,
                              ),
                            ),
                          ],
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // AnimatedOpacity(
                //   opacity: showPortHoleButton ? 1 : 0,
                //   duration: Duration(milliseconds: 250),
                //   child: Align(
                //     alignment: Alignment.center,
                //     child: GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => PortHole()));
                //       },
                //       child: Container(
                //         width: 250,
                //         padding: EdgeInsets.all(16),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               'The Porthole',
                //               style:
                //                   TextStyle(color: Colors.white, fontSize: 16),
                //             ),
                //             Icon(
                //               Icons.all_out_rounded,
                //               color: Colors.white,
                //             )
                //           ],
                //         ),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           boxShadow: [
                //             BoxShadow(
                //               color: Colors.blueAccent.shade400,
                //               blurRadius: 6.0,
                //               spreadRadius: 0.0,
                //               offset: Offset(
                //                 0.0,
                //                 3.0,
                //               ),
                //             ),
                //           ],
                //           color: Colors.blueAccent,
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
