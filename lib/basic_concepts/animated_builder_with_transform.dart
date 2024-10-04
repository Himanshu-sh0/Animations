import 'package:flutter/material.dart';
import 'dart:math';

/// Animation controller [ _controller ] : an object that allows you to control changes to a double value.
/// An Animation Object [_animation ] : An object that is tied to the Animation Controller [_controller ], and changes its value according to the [ _controller ] (could be a double value or offset value).
/// [ AnimationController ] requires two main parameters, [ vsync ] and [ duration ]
/// [ vsync ] :  which object/widget should i sync the animation with.
/// [ duration ] : how long should the animation take , to get animated.
/// [ _animation ] is initialized with [ Tween ] - [ Animation ] which is used to animate an object between two values.
/// by default it returns a [ Tween ]-[ Object]. However, [_animation ] requires an Animation.
/// So, the [ animate ] method is applied over the tween object, to get an [ Animation ] out of it.

class Day1 extends StatefulWidget {
  const Day1({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() {
    return Day1State();
  }
}

class Day1State extends State<Day1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);
    _controller.repeat();
  }

  /// free the memory allocated to the controller.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 35, 35, 35),
      ),
      backgroundColor: const Color.fromARGB(255, 35, 35, 35),
      body: Center(
        // A widget that re-draws the content/animation whenever the controller value changes.
        child: AnimatedBuilder(
          animation: _controller,
          // used to translate or rotate a widget along any axis.
          builder: (context, child) => Transform(
            // the pibbit point along which the rotation will happen.
            alignment: Alignment.center,
            // matriz4.identity is just like Offset.zero, no translation , no rotation. just, reset the matrix.
            transform: Matrix4.identity()..rotateZ(_animation.value),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(-2, -2),
                    blurStyle: BlurStyle.inner,
                  ),
                  BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 6,
                    blurRadius: 6,
                    offset: Offset(4, 7),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
