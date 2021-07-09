import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Person {
  int id = 0;
  String name = "";
  String status = "";
}

Future<List<Person>> loadPersons() async {
  var response =
      await http.get(Uri.parse("https://rickandmortyapi.com/api/character"));
  var json = convert.jsonDecode(response.body);
  List<dynamic> jsonPersons;
  var jsonInfo = json["info"];
  List<Person> results = [];

  for (int i = 1; i <= jsonInfo["pages"]; i++) {
    response = await http.get(Uri.parse(
        "https://rickandmortyapi.com/api/character/?page=${i}")); //скобки интерполяции
    json = convert.jsonDecode(response.body);
    jsonPersons = json["results"];

    for (var jsonPerson in jsonPersons) {
      Person person = Person();
      person.id = jsonPerson["id"];
      person.name = jsonPerson["name"];
      person.status = jsonPerson["status"];

      results.add(person);
    }
  }
  return results;
}
