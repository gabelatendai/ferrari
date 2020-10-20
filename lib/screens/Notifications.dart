import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//this is the name given to the background fetch
const simplePeriodicTask = "simplePeriodicTask";
// flutter local notification setup
void showNotification( v, flp) async {
  var android = AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.high, importance: Importance.max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: iOS);
  await flp.show(0, 'Virtual intelligent solution', '$v', platform,
      payload: 'VIS \n $v');
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callbackDispatcher, isInDebugMode: true); //to true if still in testing lev turn it to false whenever you are launching the app
  await Workmanager.registerPeriodicTask("5", simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: Duration(seconds:10 ),//when should it check the link
      initialDelay: Duration(seconds: 5),//duration before showing the notification
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
  runApp(LocalNotifications());
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {

    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: android, iOS: iOS);
    flp.initialize(initSetttings);




    var response= await http.post('http://snagasportswear.com/notification.php');
    print("here================");
    print(response);
    var convert = json.decode(response.body);
    if (convert['verified']  == false) {
      showNotification(convert['name'], flp);
    } else {
      print("no messgae");
    }


    return Future.value(true);
  });
}



class LocalNotifications extends StatelessWidget {
  LocalNotifications();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter notification',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Testing push notification")
              ,
              centerTitle: true,
            ),
            body: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Text("Flutter push notification without firebase with background fetch feature")
                ),
              ),
            )
        ));
  }
}




