import 'dart:async';  // ✅ Import Timer
import 'package:covid_tracker/Views/World_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with TickerProviderStateMixin {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WorldState())));
  }

  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this)
    ..repeat();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      AnimatedBuilder(animation: _controller,
          child: Container(
            width:200,
            height: 200,
            child: Image.asset("assets/images/virus.png"),
          ),
          builder: (BuildContext context, Widget? child){
        return Transform.rotate(angle: _controller.value*2.0 * math.pi ,
          child: child,
        );
          }),
      SizedBox(height: 30),
      Text("Covid Tracker App", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
    ],
  ),
),
    );
  }
}
