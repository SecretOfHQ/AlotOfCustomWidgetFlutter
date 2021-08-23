import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app12/p_view.dart';
import 'package:toast/toast.dart';
import 'package:flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget _screen = (prefs.getBool('x') == false || prefs.getBool('x') == null) ? PView() : MainSplashScreen();
  runApp(_screen);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.blueAccent,
        canvasColor: Colors.black54,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _x = GlobalKey<ScaffoldState>();

  String str = "Flutter Demo";

  int _currentIndex;
  List imgList = [
    'images/s1.jpg',
    'images/s2.jpg',
    'images/s3.jpg',
  ];

  int _radioVal = 0;
  String result;
  Color resultColor;

  bool cPlusPlus = false;
  bool cSharp = false;
  bool java = false;
  bool dart = false;

  String get txt {
    String str = "You Selected:\n";
    if (cPlusPlus) str += "C++\n";
    if (cSharp) str += "C#\n";
    if (dart) str += "Dart\n";
    if (java) str += "Java\n";
    return str;
  }

  ThemeMode tm = ThemeMode.light;
  bool _swVal = false;

  String _selectedLetter;

  List _letterList = ['A','B','C','D','E','F','G'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: tm,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.blueAccent,
        canvasColor: Colors.pink,
      ),
      home: Scaffold(
        key: _x,
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.account_circle),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.account_circle),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle),
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.deepPurpleAccent,
                Colors.pink,
                Colors.deepPurple,
              ],
            )),
          ),
          centerTitle: true,
          title: Text(
            str,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
        body: null,
      ),
    );
  }

  ListView buildExpansionTile() {
    return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ExpansionTile(
              backgroundColor: Colors.blueGrey,
              leading: Icon(Icons.perm_identity),
              title: Text("Account"),
              children: [
                Divider(color: Colors.green),
                Card(
                  color: Colors.grey,
                  child: ListTile(
                    leading: Icon(Icons.add),
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text("Sign Up!"),
                    subtitle: Text("Where You Can Register An Account"),
                    onTap: buildSnackBar,
                  ),
                ),
                Card(
                  color: Colors.grey,
                  child: ListTile(
                    leading: Icon(Icons.account_circle),
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text("Sign In!"),
                    subtitle: Text("Where You Can Login With Your Account"),
                    onTap: buildSnackBar,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ExpansionTile(
              backgroundColor: Colors.blueGrey,
              leading: Icon(Icons.message),
              title: Text("More Info"),
              children: [
                Divider(color: Colors.green),
                Card(
                  color: Colors.grey,
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text("Contact"),
                    subtitle: Text("Where You Can call Us"),
                    onTap: buildSnackBar,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }

  Center buildDropdownButton() {
    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Select A Latter!"),
            DropdownButton(
              hint: Text("Select A Latter!"),
              value: _selectedLetter,
              items: _letterList.map((item){
                return DropdownMenuItem(child: Text(item),value: item,);
              }).toList(),
              onChanged: (newVal){
                setState(() {
                  _selectedLetter = newVal;
                });
              },
            )
          ],
        ),
      );
  }

  Center buildSwitch() {
    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text("Light"),
            ),
            Switch(
              value: _swVal,
              onChanged: (bool value){
                setState(() {
                  _swVal = value;
                  tm = _swVal ? ThemeMode.dark : ThemeMode.light;
                });
              },
              activeColor: Colors.black,
              inactiveThumbColor: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text("Dark"),
            ),
          ]
        ),
      );
  }

  Column callCheckBoxbuilder(BuildContext context) {
    return Column(
      children: [
        buildCheckboxListTile(cPlusPlus, "C++"),
        buildCheckboxListTile(cSharp, "C#"),
        buildCheckboxListTile(dart, "Dart"),
        buildCheckboxListTile(java, "Java"),
        RaisedButton(
          child: Text("Apply!"),
          onPressed: () {
            var ad = AlertDialog(
              title: Text("Thank You For Applying!"),
              content: Text(txt),
            );
            showDialog(
              context: context,
              builder: (BuildContext ctx) => ad,
            );
          },
        )
      ],
    );
  }

  CheckboxListTile buildCheckboxListTile(val, text) {
    return CheckboxListTile(
      value: val,
      controlAffinity: ListTileControlAffinity.platform,
      onChanged: (value) {
        setState(() {
          val = value;
        });
      },
      title: Text(
        "$text Programming Language",
        style: TextStyle(color: Colors.deepPurpleAccent),
      ),
      subtitle: Text(
        "Check this if you know $text Programming Language",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Container buildContainerRadioListTile() {
    return Container(
      color: _radioVal == 0
          ? Colors.brown
          : _radioVal == 1
              ? Colors.blueAccent
              : _radioVal == 2
                  ? Colors.red
                  : _radioVal == 3
                      ? Colors.yellowAccent
                      : Colors.white,
      padding: EdgeInsets.all(32),
      child: Column(
        children: [
          buildRadioListTile(0, "Brown", "Change Bg To Brown"),
          buildRadioListTile(1, "Blue", "Change Bg To Blue"),
          buildRadioListTile(2, "Red", "Change Bg To Red"),
          buildRadioListTile(3, "Yellow", "Change Bg To Yellow"),
        ],
      ),
    );
  }

  RadioListTile buildRadioListTile(val, String txt, String subTxt) {
    return RadioListTile(
      value: val,
      groupValue: _radioVal,
      controlAffinity: ListTileControlAffinity.trailing,
      onChanged: (value) {
        setState(() {
          _radioVal = value;
        });
      },
      title: Text(txt),
      subtitle: Text(
        subTxt,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Padding buildRadio() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Guess The Answer : 2=2=?",
            style: TextStyle(
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          buildRow(3),
          buildRow(4, r: true),
          buildRow(5),
        ],
      ),
    );
  }

  myDialog() {
    var ad = AlertDialog(
      content: Container(
        height: 100,
        child: Column(
          children: [
            Text(
              "$result",
              style: TextStyle(color: resultColor),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text("Answer Is: 4"),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (_) => ad);
  }

  Row buildRow(int value, {bool r = false}) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _radioVal,
          onChanged: (value) {
            setState(() {
              _radioVal = value;
              result = r ? "Correct Answer!" : "Wrong Answer!";
              resultColor = r ? Colors.green : Colors.red;
              myDialog();
            });
          },
        ),
        Text("$value"),
      ],
    );
  }

  ListView buildCarousel() {
    return ListView(
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Slider 1: Initial Page Index 0\n\n",
          textAlign: TextAlign.center,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 190,
            initialPage: 0,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 1),
            enableInfiniteScroll: false,
            pauseAutoPlayOnTouch: false,
            onPageChanged: (index, _) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: imgList.map((imageUrl) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fill,
              ),
            );
          }).toList(),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildContainer(0),
            buildContainer(1),
            buildContainer(2),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Slider 2: Initial Page Index 1\n\n",
          textAlign: TextAlign.center,
        ),
        CarouselSlider.builder(
          itemCount: imgList.length,
          itemBuilder: (_, int index, __) {
            return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(
                  imgList[index],
                  fit: BoxFit.fill,
                ));
          },
          options: CarouselOptions(
            height: 190,
            initialPage: 1,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            reverse: true,
            scrollDirection: Axis.vertical,
          ),
        ),
      ],
    );
  }

  Container buildContainer(index) {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.redAccent : Colors.green,
      ),
    );
  }

  Column someTextProperty() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SelectableText(
            "I'm A Copiable Text Select Me And "
            "See What Gonna Happen!",
            showCursor: true,
            cursorColor: Colors.green,
            cursorWidth: 2,
            toolbarOptions: ToolbarOptions(
              copy: true,
              selectAll: true,
            ),
          ),
          Container(
            width: 206,
            height: 40,
            color: Colors.green,
            child: Text(
              "This Is A Clipped Text, This Is A Clipped Text, This Is A Clipped Text, This Is A Clipped Text",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 206,
            height: 40,
            color: Colors.green,
            child: Text(
              "This Is A Clipped Text, This Is A Clipped Text, This Is A Clipped Text, This Is A Clipped Text",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 206,
            height: 40,
            color: Colors.green,
            child: Text(
              "This Is A Clipped Text, This Is A Clipped Text, This Is A Clipped Text, This Is A Clipped Text",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              overflow: TextOverflow.fade,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 206,
            height: 40,
            color: Colors.green,
            child: Text(
              "This Is A Clipped Text, This Is A Clipped Text, This Is A Clipped Text, This Is A Clipped Text",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              overflow: TextOverflow.visible,
            ),
          ),
          SizedBox(height: 8),
        ]);
  }

  void buildFlushBar(BuildContext context) {
    Flushbar(
      duration: Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      mainButton: FlatButton(
        child: Text("Close!"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      icon: Icon(
        Icons.info,
        color: Colors.white,
      ),
      title: "This Is The Title",
      messageText: Text(
        "This Is The Message",
        style: TextStyle(
          color: Colors.pink,
          backgroundColor: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    ).show(context);
  }

  void buildSnackBar() {
    final sBar = SnackBar(
      action: SnackBarAction(
        textColor: Colors.black,
        label: "Undo!",
        onPressed: () {
          setState(() {
            str = "Flutter Demo";
          });
        },
      ),
      content: Text("SnackBar Text"),
      duration: Duration(milliseconds: 3000),
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
    _x.currentState.showSnackBar(sBar);
  }

  FlatButton buildFlatButton(BuildContext context) {
    return FlatButton(
      onPressed: () => showToast(context),
      child: buildRichText(),
    );
  }

  void showToast(BuildContext context) {
    Toast.show(
      "Fuck",
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.amber,
      textColor: Colors.pink,
      backgroundRadius: 8,
    );
  }

  RichText buildRichText() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: "Pink",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.pink,
          ),
        ),
        TextSpan(
          text: "/",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.black,
          ),
        ),
        TextSpan(
          text: "Amber",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.amber,
          ),
        ),
      ]),
    );
  }

  CustomScrollView buildCustomScrollView() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 150,
          leading: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.account_circle),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.account_circle),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle),
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.deepPurpleAccent,
                Colors.pink,
                Colors.deepPurple,
              ],
            )),
          ),
          centerTitle: true,
          title: Text(
            'Flutter Demo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            // Body Elements
          ]),
        ),
      ],
    );
  }

  RaisedButton buildRaisedButton(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
      child: Text("Click Me !"),
      onPressed: () {
        buildDialog(context);
      },
    );
  }

  void buildDialog(BuildContext context) {
    final AlertDialog alert = AlertDialog(
      title: Text("Dialog Title"),
      content: Container(
        height: 150,
        child: Column(
          children: [
            Divider(
              color: Colors.black54,
            ),
            Text(
              "this is Dialog, Dialog Text Appear Here You Can type AnyThing You Want !",
            ),
            SizedBox(
              height: 13,
            ),
            SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  color: Colors.redAccent,
                  child: Text(
                    "Close !",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ))
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.deepPurpleAccent.withOpacity(0.3),
      builder: (BuildContext ctx) => alert,
    );
  }
}
