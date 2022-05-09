import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:g_zone/api/search_api.dart';
import 'package:g_zone/app/app.logger.dart';
import 'package:g_zone/models/search_suggestion.dart';
import 'package:g_zone/ui/dummywidgets/bottom_nav_bar.dart';
import 'package:g_zone/ui/dummywidgets/header.dart';
import 'package:g_zone/ui/home/home.dart';
import 'package:g_zone/ui/rooms/rooms.dart';
import 'package:stacked/stacked.dart';


class defaultPage extends StatelessWidget {
  final searchController = TextEditingController();
  final log = getLogger('HomeView');
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff3C4861),
                        Color(0xff232f4c),
                        Color(0xff192543),
                      ]
                  )
              ),
            ),
            Positioned(
              height: size.height*0.09,
              width: size.width,
              top: 0,
              left: 0,
              child: Header(pageName: viewModel.pageName[viewModel.currentIndex]),
            ),
            Positioned(
              height: size.height*0.79,
              width: size.width,
              top: size.height*0.11,
              left: 0,
              child: IndexedStack(
                index: viewModel.currentIndex,
                children: viewModel.screens,
              )
            ),
            Positioned(
              height: size.height*0.1,
              width: size.width,
              bottom: 0,
              left: 0,
              child: Container(
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
                            currentIndex: viewModel.currentIndex,
                            onTap: (index) => {
                              viewModel.updateScreen(index)
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ViewModel
class HomeViewModel extends ChangeNotifier {
  int currentIndex = 0;
  final screens = [
    HomeView(),
    Rooms(),
  ];
  final pageName = [
    'Home', 'Rooms', 'test1', 'test2'
  ];

  void updateScreen(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
