import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Notifications page"),
        ),
        floatingActionButton: _BotonFlotante(),
        bottomNavigationBar: _BottomNavigation(),
      ),
    );
  }
}

class _BotonFlotante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final notiModel =
            Provider.of<_NotificationModel>(context, listen: false);
        int num_notifications = notiModel.numero;
        num_notifications++;

        notiModel.numero = num_notifications;
        if (num_notifications >= 2 && num_notifications < 100) {
          final controller = notiModel.bounceController;
          controller.forward(from: 0.0);
        }
      },
      child: Icon(FontAwesomeIcons.play),
      backgroundColor: Colors.green,
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int num_notifications =
        Provider.of<_NotificationModel>(context).numero;
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.green,
      items: [
        BottomNavigationBarItem(label: "Car", icon: Icon(FontAwesomeIcons.car)),
        BottomNavigationBarItem(
            label: "Notifications",
            icon: Stack(
              children: [
                Icon(FontAwesomeIcons.bell),
                Positioned(
                  top: 0,
                  right: 0,
                  child: (num_notifications < 100)
                      ? BounceInDown(
                          from: 10,
                          animate: (num_notifications > 0) ? true : false,
                          child: Bounce(
                            from: 10,
                            controller: (controller) =>
                                Provider.of<_NotificationModel>(context)
                                    .bounceController = controller,
                            child: Container(
                              alignment: Alignment.center,
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 240, 157, 105)),
                              child: Text(
                                num_notifications.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      : Icon(Icons.brightness_1,
                          size: 8, color: Color.fromARGB(255, 240, 157, 105)),
                  //child: Icon(Icons.brightness_1,size: 8, color: Colors.greenAccent), notificaciones con un puntito
                )
              ],
            )),
        BottomNavigationBarItem(
            label: "Bone", icon: Icon(FontAwesomeIcons.bone)),
      ],
    );
  }
}

class _NotificationModel extends ChangeNotifier {
  int _numero = 0;
  late AnimationController _bounceController;
  int get numero => this._numero;
  set numero(int valor) {
    this._numero = valor;
    notifyListeners();
  }

  AnimationController get bounceController => this._bounceController;
  set bounceController(AnimationController controller) {
    this._bounceController = controller;
  }
}
