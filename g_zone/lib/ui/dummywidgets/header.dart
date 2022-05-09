import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_zone/app/app.locator.dart';
import 'package:g_zone/app/app.logger.dart';
import 'package:stacked_services/stacked_services.dart';

class Header extends StatelessWidget {

  final String pageName;
  Header({Key? key, required this.pageName}) : super(key: key);

  final log = getLogger('Header');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(
              flex: 1,
              child: Container(
              )
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                    pageName,
                    style: const TextStyle(fontFamily: 'OpenSans', fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 55),
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(Icons.more_horiz, color: Colors.white),
                ),
              ),
          ),
        ],
      ),
    );
  }
}




