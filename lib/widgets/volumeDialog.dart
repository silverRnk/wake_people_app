import 'package:flutter/material.dart';

class VolumeDialoge extends StatefulWidget {
  final double initVolume;
  final void Function(double) onVolumeChange;

  const VolumeDialoge({super.key, required this.onVolumeChange, required this.initVolume});

  @override
  State<VolumeDialoge> createState() => _VolumeDialogeState();
}

class _VolumeDialogeState extends State<VolumeDialoge> {
  double _volume = 0.0;

  @override
  void initState() {
    setState(() {
    _volume = widget.initVolume;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
              width: 150,
              height: 250,
              // padding: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Slider(
                  value: _volume, 
                  secondaryTrackValue: 1.0,
                  onChanged: (double value) {
                    setState(() {
                      _volume = value;
                      widget.onVolumeChange(value);
                    });
                },),
              ),
            );
  }
}