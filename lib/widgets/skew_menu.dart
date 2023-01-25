import 'dart:math';

import 'package:course_example/managers/skew_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oak_tree/oak_tree.dart';

class SkewMenu extends StatefulWidget {
  final Widget child;

  SkewMenu({
    required this.child,
  });

  @override
  State<SkewMenu> createState() => _SkewMenuState();
}

class _SkewMenuState extends State<SkewMenu> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<SkewManager>(builder: (context, SkewManager manager, _) {
      return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.orange, Colors.orange.shade600],
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  width: 200,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      DrawerHeader(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: SvgPicture.asset(
                            'assets/brain.svg',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              onTap: () {},
                              leading: Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Home',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: Icon(
                                Icons.add_alert_sharp,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Alarms',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: Icon(
                                Icons.accessibility_new_rounded,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Breathe',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                manager.toggle();
                              },
                              leading: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Close',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: manager.skewValue),
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                builder: (_, double val, __) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 200 * val)
                      ..rotateY((pi / 5) * val),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(manager.isOpen ? 20 : 0),
                      child: widget.child,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
