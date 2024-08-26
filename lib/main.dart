import 'package:flutter/material.dart';
import 'package:wake_people_app/widgets/onbutton.dart';

void main() {
  runApp(const MyApp());
}

const navyBlue = Color.fromRGBO(5, 68, 94, 1.0);
const blueGrotto = Color.fromRGBO(24, 154, 180, 1.0);
const blueGreen = Color.fromRGBO(117, 230, 218, 1.0);
const babyBlue = Color.fromRGBO(212, 241, 244, 1.0);


const colorThemeLight = ColorScheme(
  brightness: Brightness.light, 
  primary: navyBlue, 
  onPrimary: Colors.white, 
  secondary: blueGrotto, 
  onSecondary: Colors.white, 
  error: Colors.red, 
  onError: Colors.white, 
  background: babyBlue, 
  onBackground: navyBlue, 
  surface: blueGreen, 
  onSurface: navyBlue);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: colorThemeLight,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  bool _isAlarmOn = false;
  double turns = 0.0;
  DeviceStatus _deviceStatus = DeviceStatus.ready;


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  void _turnAlarmOn() {
    //TODO: connect to server

    _isAlarmOn = true;
  }

  void _turnAlarmOff() {
    //TODO turn off device alarm

    _isAlarmOn = false;
  }

  void _changeRotation() {
    setState(() {
      turns += 1.0 / 8.0;
    });
  }

  void _resetPosition() {
    setState(() {
      turns = 0.0;
    });
  }


  Widget deviceIconButton(DeviceStatus status) {
    IconData icon;
    
    switch(status) {

      case DeviceStatus.connected:
       icon = Icons.wifi_tethering;
       break;
      case DeviceStatus.error:
       icon = Icons.wifi_tethering_error;
       break;
      case DeviceStatus.ready:
       icon = Icons.portable_wifi_off;
       break;
      default:
       icon = Icons.error;
    }

    return IconButton(
      onPressed: () {
        setState(() {
          _deviceStatus = DeviceStatus.connected;
        });

        _deviceDialog(context);
      }, 
      icon: Icon(icon, color: Theme.of(context).colorScheme.onPrimary));
      
  }

  Future<void> _deviceDialog(BuildContext context) {
   
    return showDialog(context: context, 
    builder: (context) {
      return SimpleDialog(
        title: Text("Devices", style: const TextStyle(fontWeight: FontWeight.bold),),
        children: [
          Container(
            width: 150,
            height: 250,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                ListTile(onTap: () {},
                 title: Text("Device 1"),
                 trailing: Icon(Icons.wifi_2_bar),
                )
              ],
            )
          )
        ],
      );
    },);
  }


  @override
  Widget build(BuildContext context) {

    Widget curButton = !_isAlarmOn? 
    Onbutton( onTapUp: (details) {
      _turnAlarmOn();
      _changeRotation();
    },): 
    OffButton( onTapUp: (details) {
      _turnAlarmOff();
      _resetPosition();
    },);

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          deviceIconButton(_deviceStatus),
          IconButton(
            splashColor: Colors.black,
            splashRadius: 20,
            onPressed: () {}, 
            icon: Icon(Icons.access_alarms, color: Theme.of(context).colorScheme.onPrimary,)),
          IconButton(
            tooltip: 'Volume',
            onPressed: () {}, 
            icon: Icon(Icons.volume_down, color: Theme.of(context).colorScheme.onPrimary))
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            curButton,
            SizedBox(height: 50,),
            AnimatedRotation(turns: turns, 
            duration: const Duration(milliseconds: 250), 
            child: Icon(Icons.notifications_active, size: 50,),
            onEnd: () {
              setState(() {

                if(_isAlarmOn){
                    if(turns>0){
                    turns -= 1.0/ 4.0;
                    }else if(turns<0){
                    turns += 1.0/ 4.0;
                    }
                }
                
              });
            },)
          ],
        ),
      ),
    );
  }
}


enum DeviceStatus {
  connected,
  error,
  ready
}