import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() => runApp(MaterialApp(home: MyHome()));

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
              title: const Text('Favorites'),
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
          semanticLabel: 'scan a barcode',
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

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key, barcode}) : super(key: key);

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
                  MaterialPageRoute(builder: (context) => RecipePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
/* class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
} */

/* class _ItemPageState extends State<ItemPage> {
  void _pushedSaved() {}
} */

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

class QRScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  //Scanned Barcodes and QRCodes return the type BARCODE which contains a string class
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: Text('pause', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: Text('resume', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Back'),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Barcode Scanned')));

      Navigator.pushReplacement(
        (context),
        MaterialPageRoute(builder: (context) => RecipePage()),
      );
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
