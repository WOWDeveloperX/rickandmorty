import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Person {
  int id = 0;
  String name = " ";
  String status = " ";
}

Future<List<Person>> loadPersons() async {
  var response =
      await http.get(Uri.parse("https://rickandmortyapi.com/api/character"));
  var json = convert.jsonDecode(response.body);

  List<dynamic> jsonPerson = json["results"];
  List<Person> results = [];

  try {
    for (var jsonPerson in jsonPerson) {
      Person person = Person();
      person.id = jsonPerson["id"];
      person.name = jsonPerson["name"];
      person.status = jsonPerson["status"];

      results.add(person);
    }
  } catch (e) {
    rethrow;
  }
    return results;
  }

