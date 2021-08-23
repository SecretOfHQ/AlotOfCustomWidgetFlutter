import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app12/main.dart';
import 'package:flutter_app12/main_splash_screen.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Data {
  final String title;
  final String description;
  final String imageUrl;
  final IconData iconData;

  Data({
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.iconData,
  });
}

class PView extends StatefulWidget {
  @override
  _PViewState createState() => _PViewState();
}

class Indicator extends StatelessWidget {
  final int index;

  Indicator(this.index);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, .7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(i: 0, color: index == 0 ? Colors.green : Colors.red),
          buildContainer(i: 1, color: index == 1 ? Colors.green : Colors.red),
          buildContainer(i: 2, color: index == 2 ? Colors.green : Colors.red),
          buildContainer(i: 3, color: index == 3 ? Colors.green : Colors.red),
        ],
      ),
    );
  }

  Widget buildContainer({int i, Color color = Colors.red}) {
    return index == i
        ? Icon(Icons.star)
        : Container(
      margin: EdgeInsets.all(4),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _PViewState extends State<PView> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  int _currentIndex = 0;
  final _pageIndexNotifier = ValueNotifier<int>(0);

  final List<Data> myDate = [
    Data(
      title: 'Title 1',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imageUrl: 'images/q1.jpg',
      iconData: Icons.add_box,
    ),
    Data(
      title: 'Title 2',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imageUrl: 'images/q2.jpg',
      iconData: Icons.add_circle,
    ),
    Data(
      title: 'Title 3',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imageUrl: 'images/q3.jpg',
      iconData: Icons.add_circle_outline,
    ),
    Data(
      title: 'Title 4',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imageUrl: 'images/q4.jpg',
      iconData: Icons.add_comment,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      _currentIndex < 3 ? _currentIndex++ : null;
      _controller.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/a': (ctx) => MyHomePage(),
        '/b': (ctx) => MainSplashScreen(),
      },
      home: Scaffold(
        body: Stack(
            alignment:Alignment(0,.7),
            children: [
              Builder(
                builder: (ctx) =>
                    PageView(
                      controller: _controller,
                      onPageChanged: (val) {
                        _pageIndexNotifier.value = val;
                        setState(() {
                          _currentIndex = val;
                          /*if (_currentIndex == 3)
                            Future.delayed(
                              Duration(seconds: 2),
                                  () => Navigator.of(ctx).pushNamed('/b'),*/
                          //  );
                        });
                      },
                      children: myDate
                          .map((item) =>
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                image: DecorationImage(
                                  image: ExactAssetImage(item.imageUrl),
                                  fit: BoxFit.cover,
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(item.iconData, size: 130),
                                SizedBox(height: 50),
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  item.description,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ))
                          .toList(),
                    ),
              ),
              //Indicator(_currentIndex),
              PageViewIndicator(
                pageIndexNotifier: _pageIndexNotifier,
                length: myDate.length,
                normalBuilder: (_, index) =>
                    Circle(
                      size: 8.0,
                      color: Colors.black87,
                    ),
                highlightedBuilder: (animationController, _) =>
                    ScaleTransition(
                      scale: CurvedAnimation(
                        parent: animationController,
                        curve: Curves.ease,
                      ),
                      child: Circle(
                        size: 12.0,
                        color: Colors.white,
                      ),
                    ),
              ),
              Builder(
                builder: (ctx) =>
                    Align(
                      alignment: Alignment(0, 0.9),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          padding: EdgeInsets.all(7),
                          color: Colors.red,
                          child: Text(
                            "GET STARTED",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          onPressed: () async{
                            Navigator.of(ctx).pushNamed('/b');
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setBool('x', true);
                        },
                        ),
                      ),
                    ),
              ),
            ]),
      ),
    );
  }
}
