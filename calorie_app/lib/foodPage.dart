//Class to contain the FoodItemPage
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'recipePage.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'dart:developer';

class FoodItemPage extends StatefulWidget {
  final String? upcCode;

  const FoodItemPage({Key? key, this.upcCode}) : super(key: key);

  @override
  _FoodItemPageState createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  late Future<FoodSuper> futureFoods;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //this line throws unexpected null value
        title: Text(this.widget.upcCode!),
      ),
      drawer: _buildDrawer(context),
      body: _buildFoodItem(context),
    );
  }

  Widget _buildDrawer(BuildContext context) {
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

  //parse JSON and flesh out clases here?
  Future<FoodSuper> fetchFood() async {
    await DotEnv.load(fileName: ".env");
    var apiKey = DotEnv.env['SUPER_SECRET_API_KEY'];

    final response = await http.get(Uri.parse(
        'https://api.nal.usda.gov/fdc/v1/food/' +
            this.widget.upcCode! +
            apiKey!));

    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    log(responseJson.toString());
    return FoodSuper.fromJson(responseJson);
  }

  void initState() {
    super.initState();
    futureFoods = fetchFood();
  }

  Widget _buildFoodItem(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(children: [
          FutureBuilder<FoodSuper>(
            future: futureFoods,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.foods.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ]));
  }
}

//Class to contain the "Food Item"
class FoodSuper {
  List<Foods> foods;

  FoodSuper({required this.foods});

  factory FoodSuper.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['foods'] as List;

    List<Foods> foodsList = list.map((i) => Foods.fromJson(i)).toList();

    return FoodSuper(
      foods: foodsList,
    );
  }
}

class Foods {
  String description;
  String gtinUpc;
  List<FoodNutrients> foodNutrients;

  Foods(
      {required this.description,
      required this.gtinUpc,
      required this.foodNutrients});

  factory Foods.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['foodNutrients'] as List;

    List<FoodNutrients> foodNutrientsList =
        list.map((i) => FoodNutrients.fromJson(i)).toList();

    return Foods(
      description: parsedJson['id'],
      gtinUpc: parsedJson['imageName'],
      foodNutrients: foodNutrientsList,
    );
  }
}

//Class to help with the Nested JSON parsing
class FoodNutrients {
  int nutrientID = 0;
  String nutrientName = '';
  double nutrientValue = 0;

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
