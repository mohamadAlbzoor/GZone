import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_zone/app/app.locator.dart';
import 'package:g_zone/app/app.logger.dart';
import 'package:g_zone/app/app.router.dart';
import 'package:g_zone/models/game_info.dart';
import 'package:g_zone/ui/dummywidgets/bottom_nav_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:stacked_services/stacked_services.dart';


class CardView extends StatelessWidget {

  final GameInformation inf;
  CardView({Key? key, required this.inf}) : super(key: key);

  final navigationService = locator<NavigationService>();
  final log = getLogger('CardView');

  String downloads(String owners){
    int tmp = int.parse(owners);
    if(tmp > 1000000)return (tmp~/1000000).toString() + 'M';
    if(tmp > 1000)return (tmp~/1000).toString() + 'k';
    return tmp.toString();
  }

  String rating(int rate){
    if(rate > 1000000)return (rate~/1000000).toString() + 'M';
    if(rate > 1000)return (rate~/1000).toString() + 'k';
    return rate.toString();
  }

  Widget textShape(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height*0.50,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: DefaultTextStyle.merge(
            style: const TextStyle(
              fontSize: 32.0,
              //fontFamily: 'monospace',
            ),
            child:SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8),
                        child: DefaultTextStyle(
                          style: const TextStyle(fontFamily: 'Cairo', fontSize: 20, color: Colors.white),
                          child: Text(inf.name),
                        ),//BoxDecoration
                      ), //Container
                    ), //SizedBox
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                          padding: const EdgeInsets.only(right: 12),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DefaultTextStyle(
                              style: const TextStyle(fontFamily: 'Cairo', fontSize: 16, color: Colors.white),
                              child: Text(inf.releaseDate),
                            ),
                          )///BoxDecoration
                      ), //Container
                    ) //Flexible
                  ], //<Widget>[]
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                const SizedBox(
                  height: 15,
                ),//SizedBox
                Container(
                    width: size.width,
                    padding: const EdgeInsets.all(8),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: DefaultTextStyle.merge(
                                style: const TextStyle(fontFamily: 'OpenSans'),
                                child: ReadMoreText(
                                  'Genres : ' + inf.genres,
                                  trimLines: 1,
                                  colorClickableText: Colors.pink,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: 'Show less',
                                  textAlign: TextAlign.left,
                                  moreStyle: const TextStyle(fontFamily: 'OpenSans', fontSize: 14, color: Color.fromRGBO(165, 132, 250, 1.0)),
                                  lessStyle: const TextStyle(fontFamily: 'OpenSans', fontSize: 14, color: Color.fromRGBO(165, 132, 250, 1.0)),
                                  style: const TextStyle(fontFamily: 'OpenSans', fontSize: 14, color: Colors.white),
                                ),
                              ),

                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ReadMoreText(
                                'Categories : ' + inf.categories,
                                trimLines: 2,
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: const TextStyle(fontFamily: 'OpenSans', fontSize: 14, color: Color.fromRGBO(165, 132, 250, 1.0)),
                                lessStyle: const TextStyle(fontFamily: 'OpenSans', fontSize: 14, color: Color.fromRGBO(165, 132, 250, 1.0)),
                                style: const TextStyle(fontFamily: 'OpenSans', fontSize: 14, color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                DefaultTextStyle(
                                  style: const TextStyle(fontFamily: 'OpenSans', fontSize: 14, color: Colors.white),
                                  child: Text('Price : '+inf.price.toString() +'\$',
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.visible,),
                                ),
                              ],
                            )
                          ],
                        )
                    ) //BoxDecoration
                ), //Flexible
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                  height: 25,
                ),
                IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                          height: 80,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                const Spacer(),
                                const Icon(
                                  Icons.download,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                DefaultTextStyle(
                                  style: const TextStyle(fontFamily: 'OpenSans', fontSize: 14, color: Colors.white),
                                  child: Text(downloads(inf.owners.split('-').last),
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.visible,),
                                ),
                                const Spacer(),
                              ],
                            ),
                          )
                        ), //Container
                      ),
                      const VerticalDivider(
                        width: 10,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                        color: Colors.white,
                      ),//SizedBox
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                            height: 80,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  const Spacer(),
                                  const Icon(
                                    Icons.thumb_up,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  DefaultTextStyle(
                                    style: const TextStyle(fontFamily: 'OpenSans', fontSize: 14, color: Colors.white),
                                    child: Text(rating(inf.positiveRatings),
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.visible,),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            )
                        ), //Container
                      ),
                      const VerticalDivider(
                        width: 10,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                        color: Colors.white,
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                            height: 80,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  const Spacer(),
                                  const Icon(
                                    Icons.thumb_down,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  DefaultTextStyle(
                                    style: const TextStyle(fontFamily: 'OpenSans', fontSize: 14, color: Colors.white),
                                    child: Text(rating(inf.negativeRatings),
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.visible,),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            )
                        ),
                      )//Flexible
                    ], //<Widget>[]
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ], //<Widget
            )
          ),
        )
        )//Padding
    );//Container;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
            width: size.width,
            top: 1.2,
            left: 0,
            child: Container(
              height: size.height*0.40,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(165, 132, 250, 1.0),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18.0), bottomRight: Radius.circular(18.0)),
              ),
            ),
          ),
          Positioned(
            width: size.width,
            top: 0,
            left: 0,
            child: Container(
              height: size.height*0.40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18.0), bottomRight: Radius.circular(18.0)),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.7), BlendMode.darken),
                    image: AssetImage("assets/images/apex.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            width: size.width,
            height: size.height*0.90,
            top: size.height*0.40,
            left: 0,
            child: textShape(context),
          ),
          Positioned(
            height: size.height*0.1,
            width: size.width,
            bottom: 0,
            left: 0,
            child: BottomNavBar(size: size,),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
              padding: const EdgeInsets.all(32),
              alignment: Alignment.centerLeft,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 32,
              ),
              onPressed: (){
                navigationService.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
