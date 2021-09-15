//Class to contain the FoodItemPage
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'recipePage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class FoodItemPage extends StatefulWidget {
  final Barcode? barcode;

  const FoodItemPage({Key? key, this.barcode}) : super(key: key);

  @override
  _FoodItemPageState createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  Barcode? barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //this line throws unexpected null value
        title: Text('Recipe Page'),
      ),
      drawer: _buildDrawer(),
      body: _buildFoodItem(),
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

  //make authenticated JSON request here
  Widget _buildJsonRequest() {
    return Container();
  }

  //parse JSON and flesh out clases here?
  Widget _buildFoodClasses() {
    return Container();
  }

  Widget _buildFoodItem() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text("Name"),
              ),
              Expanded(
                flex: 2,
                child: Text("UPC"),
              ),
              Expanded(
                child: Text("Calories"),
              ),
            ],
          )
        ]));
  }
}

//Class to contain the "Food Item"
class Foods {
  String name = '';
  int upc = 0;
  List<FoodNutrients> foodNutrient = null as List<FoodNutrients>;

  Foods({
    required this.name,
    required this.upc,
    required this.foodNutrient,
  });

  factory Foods.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['images'] as List;
    List<FoodNutrients> nutrientsList =
        list.map((i) => FoodNutrients.fromJson(i)).toList();

    return Foods(
      name: parsedJson['description'],
      upc: parsedJson['gtinUpc'],
      foodNutrient: parsedJson['foodNutrients'],
    );
  }
}

//Class to help with the Nested JSON parsing
class FoodNutrients {
  int nutrientID = 0;
  String nutrientName = '';
  int nutrientValue = 0;

  FoodNutrients({
    required this.nutrientID,
    required this.nutrientName,
    required this.nutrientValue,
  });

  factory FoodNutrients.fromJson(Map<String, dynamic> parsedJson) {
    return FoodNutrients(
        nutrientID: parsedJson['nutrientId'],
        nutrientName: parsedJson['nutrientName'],
        nutrientValue: parsedJson['nutrientNumber']);
  }
}
