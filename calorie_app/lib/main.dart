import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'recipePage.dart';
import 'qrPage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  await DotEnv.load(fileName: ".env");

  runApp(MaterialApp(home: MyHome()));
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo Recipe App')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/weighing.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 6,
                )),
          ),
          Text(
            'Welcome! Get Started by scanning a barcode with the camera button!',
          ),
        ],
      )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: null,
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHome()),
                );
              },
            ),
            ListTile(
              title: const Text('Saved Recipes'),
              onTap: () {
                // Update the state of the app
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RecipePage()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => QRScan(),
          ));
        },
        //add a navigator method that pushes the barcode object to the router
        //add a snackbar "code scanned!" message??
        child: Icon(
          Icons.camera,
          color: Colors.white,
          semanticLabel: 'Scan a barcode',
        ),
      ),
    );
  }
}

//commenting this "SAVEDPAGE" route out in case it will be needed later
/*
class SavedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Foods"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: null,
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHome()),
                );
              },
            ),
            ListTile(
              title: const Text('Favorites'),
              onTap: () {
                // Update the state of the app
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SavedPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} */

/* class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
} */

/* class _ItemPageState extends State<ItemPage> {
  void _pushedSaved() {}
} */





