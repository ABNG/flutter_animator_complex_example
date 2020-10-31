import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final animatorKey = AnimatorKey<double>();
  final animatorKey1 = AnimatorKey<double>();
  final animatorKey2 = AnimatorKey<double>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 20,
            child: Stack(
              children: [
                Animator<double>(
                  tweenMap: {
                    //to use sequence animation change this final Map<String, Tween<dynamic>> tweenMap; value  to final Map<String, dynamic> tweenMap; from inside the package
                    //we have total 250 milliseconds. during 200 milliseconds animation goes to 0 to 1.2 then next 50 milliseconds, animation goes to 1.2 to 1.0,
                    //in reverse, during 50 milliseconds animation goes 1.0 to 1.2 then next 200, 1.2 to 0.0.
                    //that's why we see a bounce.
                    "first": TweenSequence([
                      TweenSequenceItem(
                          tween: Tween<double>(begin: 0.0, end: 1.2),
                          weight: 75),
                      TweenSequenceItem(
                          tween: Tween<double>(begin: 1.2, end: 1.0),
                          weight: 25),
                    ]),
                    "second": Tween<double>(begin: 270.0, end: 0.0),
                  },
                  animatorKey: animatorKey,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  builder: (context, animation, child) => Transform.translate(
                    offset: Offset.fromDirection(math.radians(270),
                        animation.getAnimation<double>('first').value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(math.radians(
                          animation.getAnimation<double>('second').value))
                        ..scale(animation.getAnimation<double>('first').value),
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        fillColor: Colors.blue,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(18),
                      ),
                    ),
                  ),
                ),
                Animator<double>(
                  tweenMap: {
                    "first": TweenSequence([
                      TweenSequenceItem(
                          tween: Tween<double>(begin: 0.0, end: 1.2),
                          weight: 75),
                      TweenSequenceItem(
                          tween: Tween<double>(begin: 1.2, end: 1.0),
                          weight: 25),
                    ]),
                    "second": Tween<double>(begin: 225.0, end: 0.0),
                  },
                  animatorKey: animatorKey1,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  builder: (context, animation, child) => Transform.translate(
                    offset: Offset.fromDirection(math.radians(225),
                        animation.getAnimation<double>('first').value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(math.radians(
                          animation.getAnimation<double>('second').value))
                        ..scale(animation.getAnimation<double>('first').value),
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        fillColor: Colors.amber,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(18),
                      ),
                    ),
                  ),
                ),
                Animator<double>(
                  tweenMap: {
                    "first": TweenSequence([
                      TweenSequenceItem(
                          tween: Tween<double>(begin: 0.0, end: 1.2),
                          weight: 75),
                      TweenSequenceItem(
                          tween: Tween<double>(begin: 1.2, end: 1.0),
                          weight: 25),
                    ]),
                    "second": Tween<double>(begin: 180.0, end: 0.0),
                  },
                  animatorKey: animatorKey2,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  builder: (context, animation, child) => Transform.translate(
                    offset: Offset.fromDirection(math.radians(180),
                        animation.getAnimation<double>('first').value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(math.radians(
                          animation.getAnimation<double>('second').value))
                        ..scale(animation.getAnimation<double>('first').value),
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        fillColor: Colors.purple,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(18),
                      ),
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {
                    //You can  forward, start, reverse animation
                    if (animatorKey.controller.isDismissed) {
                      animatorKey.controller.forward();
                      animatorKey1.controller.forward();
                      animatorKey2.controller.forward();
                    } else if (animatorKey.controller.isCompleted) {
                      animatorKey.controller.reverse();
                      animatorKey1.controller.reverse();
                      animatorKey2.controller.reverse();
                    }
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  fillColor: Colors.red,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
