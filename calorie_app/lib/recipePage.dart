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
      drawer: Container(
          height: 600,
          width: 150,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                    height: 100,
                    width: 10,
                    child: DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Text(
                          'Navigation',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.5,
                              height: 0.3),
                        ))),
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
          )),
      body: _buildBody(), //this will be changed
    );
  }

  //flesh out with item grid list
  Widget _buildBody() {
    return Container();
  }
}
