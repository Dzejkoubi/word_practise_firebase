import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:word_practise_firebase/pages/screens/wordsDatabase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _textFieldInput = TextEditingController();
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  String realTimeValue = "null";
  String getOnceValue = "null";
  final String firebaseDirectory = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => wordsDatabase()),
          );
        },
        label: Text('Add Words'),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: const Text(
          'Word Practise',
          style: TextStyle(
            color: Color(0xFF90CAF9),
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _fApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return content();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    ));
  }

  Widget content() {
    // real Time values
    DatabaseReference ref = FirebaseDatabase(
            databaseURL:
                "https://word-pracise-cz-en-default-rtdb.europe-west1.firebasedatabase.app/")
        .ref();
    ref.child("test").onValue.listen((event) {
      setState(() {
        realTimeValue = event.snapshot.value.toString();
      });
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[300],
              ),
              onPressed: () {},
              child: const Text(
                'Start game',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Enter the translation of the word below: $realTimeValue",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 200,
                    height: 70,
                    child: TextField(
                      controller: _textFieldInput,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      decoration: InputDecoration(
                        suffix: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _textFieldInput.clear();
                            }),
                        border: OutlineInputBorder(),
                        labelText: 'Translation',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    )),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[300],
                  ),
                  onPressed: () {
                    print(_textFieldInput.text);
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
                onPressed: () async {
                  DatabaseReference getOnceTest = FirebaseDatabase(
                          databaseURL:
                              "https://word-pracise-cz-en-default-rtdb.europe-west1.firebasedatabase.app/")
                      .ref("words/94/english/0");
                  final snapshot = await getOnceTest.get();
                  if (snapshot != null) {
                    setState(() {
                      getOnceValue = snapshot.value.toString();
                    });
                  } else {
                    setState(() {
                      getOnceValue = "null";
                    });
                  }
                },
                child: const Text('Update OnceValue')),
            TextButton(
                onPressed: () async {
                  ref.child("words/348/").set("new value");
                },
                child: Text('Change value')),
            Text("realTimeValue: $realTimeValue",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            Text("getOnceValue: $getOnceValue",
                style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
