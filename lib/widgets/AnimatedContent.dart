import 'package:flutter/material.dart';

class AnimatedContent extends StatefulWidget {

  final Widget child;
  final bool show;

  const AnimatedContent({Key key, this.child, this.show = false}) : super(key: key);

  @override
  AnimatedContentState createState() => AnimatedContentState();
}

class AnimatedContentState extends State<AnimatedContent> with TickerProviderStateMixin{

  AnimationController animationController;
  Animation<Offset> animationSlideUp;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 600));

    animationSlideUp = new Tween(begin: Offset(0.0, 5.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
        parent: animationController, curve: Curves.ease));

    if(widget.show){
      animationController.forward();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedContent oldWidget) {
    if(widget != oldWidget){
      if(widget.show && !oldWidget.show){
        animationController.forward(from: 0.0);
      }else if(!widget.show){
        animationController.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animationSlideUp,
      child: FadeTransition(
        opacity: animationController,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
