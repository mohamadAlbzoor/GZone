import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_zone/app/app.locator.dart';
import 'package:g_zone/app/app.logger.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomNavBar extends StatefulWidget {
  Size size;
  BottomNavBar({Key? key, required this.size}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState(size: size);
}

class _BottomNavBarState extends State<BottomNavBar> {

  Size size;
  int currentIndex = 0;

  final log = getLogger('BottomNavBarState');
  final _navigationService = locator<NavigationService>();

  _BottomNavBarState({required this.size});

  @override
  void initState() {
    log.i(size);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height*0.1,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
        ),
        child: Center(
          child:
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    selectedItemColor: const Color.fromRGBO(231, 153, 149, 1.0),
                    unselectedItemColor: const Color.fromRGBO(61, 73, 98, 1.0),
                    unselectedFontSize: 10,
                    selectedFontSize: 10,
                    currentIndex: currentIndex,
                    onTap: (index) => {
                      setState(
                              () => currentIndex  = index
                      ),
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Home'
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.meeting_room),
                          label: 'Rooms'
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.analytics),
                          label: 'Stat'
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person),
                          label: 'Profile'
                      ),
                    ]
                )
            ),
        )
    );
  }
}