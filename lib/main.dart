import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rickandmorty/personwidget.dart';
import 'package:rickandmorty/dataLoader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person>? persons = null;
  Exception? error = null;

  void loadData() async {
    try {
      var personLoad = await loadPersons();
      setState(() {
        persons = personLoad;
      });
    } on Exception catch (exeption) {
      setState(() {
        error = exeption;
        print("Oops, we catch warning");
      });
    }
    print("End of loading");
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    final List<Person>? currentPersons = persons;
    final Exception? exception = error;

    if (currentPersons != null)
      content = personsList(context, currentPersons);
    else if (exception != null)
      content = exceptionStub(context, exception);
    else
      content = loader(context);

    return Scaffold(
      body: Center(child: content),
    );
  }

//  Изменил
  Widget personsList(BuildContext context, List<Person> persons) {
    return SafeArea(
        child: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: persons.length,
            itemBuilder: (context, index) => InkWell(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PersonDetailsPage(id: persons[index].id)))
                  },
                  child: Row(
                    children: [
                      if (persons[index].status == "Alive")
                        Icon(
                          Icons.person,
                          color: Colors.greenAccent,
                        ),
                      if (persons[index].status == "Dead")
                        Icon(
                          Icons.person,
                          color: Colors.redAccent,
                        ),
                      if (persons[index].status == "unknown")
                        Icon(
                          Icons.person,
                          color: Colors.black12,
                        ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: 0, bottom: 4, left: 8, right: 0),
                                child: Text(persons[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 0, bottom: 4, left: 8, right: 0),
                                child: Text(
                                  persons[index].status,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                )));
  }

//  изменил
  Widget loader(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          "images/loading.gif",
          height: 900.0,
        ),
      ],
    );
  }

// не требует изменений
  Widget exceptionStub(BuildContext context, Exception exception) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'OOOPS ERROR IS ${exception.toString()}',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}
