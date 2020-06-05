import 'package:easy_bmi/models/UserInputModel.dart';
import 'package:easy_bmi/pages/ResultsPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './pages/HomePage.dart';
import './pages/SettingsPage.dart';
import './pages/HistoryPage.dart';
import './models/SystemModel.dart';
import './utils/globals.dart' as Globals;

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SystemModel>(
          create: (context) => SystemModel(),
        ),
        ChangeNotifierProvider<UserInputModel>(
          create: (context) => UserInputModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Globals.appName,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Globals.mainColor,
          accentColor: Globals.mainColor.withOpacity(0.9),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.montserratTextTheme(textTheme).copyWith(
            headline5: TextStyle(color: Colors.black),
            headline6: TextStyle(color: Colors.black87),
            caption: TextStyle(color: Colors.grey[600]),
          ),
          dividerColor: Colors.grey[250],
          bottomAppBarColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black87,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.grey[300],
          textTheme: GoogleFonts.montserratTextTheme(textTheme).copyWith(
            headline5: TextStyle(color: Colors.white),
            headline6: TextStyle(color: Colors.grey[200]),
            caption: TextStyle(color: Colors.grey[600]),
          ),
          dividerColor: Colors.grey[600],
          bottomAppBarColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.grey,
          ),
          textSelectionColor: Colors.grey[200],
          textSelectionHandleColor: Colors.grey[200],
        ),
        home: MainPage(),
        routes: {
          "/home": (_) => HomePage(),
          "/results": (_) => ResultsPage(),
          "/settings": (_) => SettingsPage(),
          "/history": (_) => HistoryPage(),
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _controller;
  int _index = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SettingsPage(),
  ];
  List<String> _pageTitles = <String>[
    Globals.appName,
    "Settings",
  ];
  @override
  void initState() {
    super.initState();
    _controller = new PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _controller.jumpToPage(index);
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageTitles[_index],
          style: GoogleFonts.montserrat(),
        ),
        backgroundColor: Globals.mainColor,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: PageView(
          controller: _controller,
          children: _widgetOptions,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
          currentIndex: _index,
          selectedItemColor: Globals.mainColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
