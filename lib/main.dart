import 'package:code_with_patel/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'CardScreen.dart';
import 'Dbhelper/mongodb.dart';
import 'HomeScreen.dart';
import 'ui/home_page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(title: 'Flutter Login UI'),

    );
  }
}
class WalletApp extends StatefulWidget {
  @override
  _WalletAppState createState() => _WalletAppState();
}
class _WalletAppState extends State<WalletApp> {
  var screens = [
    HomeScreen(),
    CardScreen(),
  ]; //screens for each tab

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 81, 158, 1),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home")
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              title: Text("Card")
          ),
        ],
        onTap: (index){
          setState(() {
            selectedTab = index;
          });
        },
        showUnselectedLabels: true,
        iconSize: 30,
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: (){},
        elevation: 0,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
      body: screens[selectedTab],
    );
  }
}