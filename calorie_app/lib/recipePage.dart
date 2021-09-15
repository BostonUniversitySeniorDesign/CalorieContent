import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'main.dart';

class RecipePage extends StatefulWidget {
  final Barcode? barcode;

  const RecipePage({Key? key, this.barcode}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  Barcode? barcode;

  //final _biggerFont = const TextStyle(fontSize: 20.0);
  //void _pushedSaved() {} //function will push saved FoodItems to a dynamic list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //this line throws unexpected null value
        title: Text('Recipe Page'),
      ),
      drawer: _buildDrawer(),
      body: _buildBody(), //this will be changed
    );
  }

  Widget _buildDrawer() {
    return Drawer(
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
    );
  }

  //flesh out with item grid list
  Widget _buildBody() {
    return Container();
  }
}
