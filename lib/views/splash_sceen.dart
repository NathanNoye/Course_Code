import 'package:course_example/views/home_screen.dart';
import 'package:course_example/widgets/skew_menu.dart';
import 'package:course_example/widgets/wave_animation.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplasScreen extends StatefulWidget {
  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  RiveAnimationController controller = SimpleAnimation('Timeline 1');
  double scale = 0.5;
  double isVisible = 0.0;
  bool areWavesVisible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        scale = 1;
        isVisible = 1;
      });

      await Future.delayed(Duration(milliseconds: 7500));
      setState(() {
        areWavesVisible = true;
      });

      await Future.delayed(Duration(milliseconds: 4000));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SkewMenu(
                    child: HomeScreen(),
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          AnimatedOpacity(
            duration: Duration(milliseconds: 1000),
            opacity: isVisible,
            child: AnimatedScale(
              duration: Duration(milliseconds: 1000),
              scale: scale,
              curve: Curves.easeOutCubic,
              child: Align(
                alignment: Alignment(0, -0.25),
                child: Container(
                  width: 300,
                  height: 300,
                  child: RiveAnimation.asset(
                    'assets/brain_boat_1.riv',
                    controllers: [controller],
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 5000),
            curve: Curves.easeInOut,
            top: areWavesVisible
                ? -100
                : MediaQuery.of(context).size.height + 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height + 300,
              child: WaveAnimation(
                waveColor: Colors.blueAccent,
                height: 12,
                offset: 0,
                speed: 1000,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
