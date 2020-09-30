import 'package:flutter/material.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation =
        Tween<double>(begin: 0.0, end: 6.28).animate(animationController);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.fling();
      }
    });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedLogo(
      animation: animation,
    ));
  }
}

class AnimatedLogo extends AnimatedWidget {
  final Tween<double> _sizeAnim = Tween<double>(begin: 0.5, end: 1.5);
  AnimatedLogo({Key key, Animation animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation animation = listenable;
    // TODO: implement build
    return Transform.rotate(
        angle: animation.value,
        child: Transform.scale(
            scale: _sizeAnim.evaluate(animation),
            child: Container(
                width: 50,
                height: 50,
                child: Image.network(
                    'https://www.mozilla.org/media/protocol/img/logos/firefox/logo-lg-high-res.7ba3ce88e665.png'))));
  }
}
