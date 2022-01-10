import 'package:flutter/material.dart';
import 'package:flutter_notifications/screens/second_screen.dart';
import 'package:flutter_notifications/services/notification_api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    NotificationApi.init();
    listenNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Уведомления'),
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    child: const Center(
                      child: Text(
                        'Now',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: sendNotificationNow,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    child: const Center(
                      child: Text(
                        'Later',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: sendNotificationLater,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void listenNotification() =>
      NotificationApi.onNotification.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SecondScreen(payload: payload),
        ),
      );

  void sendNotificationNow() {
    NotificationApi.showNotification(
      title: 'Новое уведомление',
      body: 'Оу, здрасте, как ваши дела?',
      payload: 'Ку',
    );
  }

  void sendNotificationLater() {
    NotificationApi.showScheduledNotification(
      title: 'Новое уведомление',
      body: 'Оу, здрасте, как ваши дела?',
      payload: 'Ку',
      scheduledDate: DateTime.now().add(
        const Duration(seconds: 10),
      ),
    );
  }
}
