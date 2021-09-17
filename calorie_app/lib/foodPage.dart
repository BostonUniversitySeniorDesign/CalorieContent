//Class to contain the FoodItemPage
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'recipePage.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

class FoodItemPage extends StatefulWidget {
  final String? upcCode;

  const FoodItemPage({Key? key, this.upcCode}) : super(key: key);

  @override
  _FoodItemPageState createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  late Future<Foods> futureFoods;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Item Page"),
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
              color: Colors.red,
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

  void initState() {
    super.initState();
    futureFoods = fetchFood();
  }

  //parse JSON and flesh out clases here?
  Future<Foods> fetchFood() async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['SUPER_SECRET_API_KEY'];

    final response = await http.get(Uri.parse(
        'https://api.nal.usda.gov/fdc/v1/foods/search?api_key=' +
            apiKey! +
            '&query=' +
            this.widget.upcCode!));

    final parsedJson = jsonDecode(response.body);
    print(parsedJson);
    return Foods.fromJson(parsedJson);
  }

  Widget _buildFoodItem(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(children: [
          FutureBuilder<Foods>(
            future: futureFoods,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  Text('Name:' + snapshot.data!.description),
                  Text('UPC:' + snapshot.data!.gtinUpc),
                  Text('Caloric Value:' + '${snapshot.data!.calories}'),
                  Text('FDC ID:' + '${snapshot.data!.fdcId}'),
                ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ]));
  }
}

class Foods {
  final num fdcId;
  final String description;
  final String gtinUpc;
  final num calories;

  Foods({
    required this.fdcId,
    required this.description,
    required this.gtinUpc,
    required this.calories,
  });

  factory Foods.fromJson(Map<String, dynamic> parsedJson) {
    final description = parsedJson['foods'][0]['description'] as String;
    final gtinUpc = parsedJson['foods'][0]['gtinUpc'] as String;
    final fdcId = parsedJson['foods'][0]['fdcId'] as num;
    final calories = parsedJson['foods'][0]['foodNutrients'][3]['value'] as num;

    return Foods(
      calories: calories,
      fdcId: fdcId,
      description: description,
      gtinUpc: gtinUpc,
    );
  }
}
