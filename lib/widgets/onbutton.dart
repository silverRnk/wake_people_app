
import 'package:flutter/material.dart';

class Onbutton extends StatelessWidget {
  

  const Onbutton({super.key, this.onTapDown, this.onTapUp});

  final GestureTapDownCallback? onTapDown;

  final GestureTapUpCallback? onTapUp;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 125, 
            width: 250,
            child: Card(
              color: Theme.of(context).colorScheme.primary,
              child: InkWell(
                onTapDown: onTapDown,
                onTapUp: onTapUp,
                child: Center(
                  child: Text('On', 
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 20,),
                  textAlign: TextAlign.center,),
                ))));
  }
}

class OffButton extends StatelessWidget {
  

  const OffButton({super.key, this.onTapDown, this.onTapUp});

  final GestureTapDownCallback? onTapDown;

  final GestureTapUpCallback? onTapUp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 125, 
            width: 250,
            child: Card(
              color: Theme.of(context).colorScheme.secondary,
              child: InkWell(
                splashColor: Theme.of(context).colorScheme.primary,
                onTapDown: onTapDown,
                onTapUp: onTapUp,
                child: Center(
                  child: Text('Off', 
                  style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 20,),
                  textAlign: TextAlign.center,),
                ))));
  }
}