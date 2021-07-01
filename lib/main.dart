import 'package:flutter/material.dart';
import 'package:rickandmorty/dataLoader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

  void _incrementCounter() {}

  void loadData() async {
    try {
      var personLoad = await loadPersons();
      setState(() {
        this.persons = personLoad;
      });
    } on Exception catch (exeption) {
      setState(() {
        error = exeption;
      });
    }

    var personLoad = await loadPersons();
    setState(() {
      this.persons = personLoad;
    });
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget personsList(BuildContext context, List<Person> persons) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'persons list leght is ${persons.length}',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }

  Widget loader(BuildContext context, List<Person> persons) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'load data...',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }

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
