import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PersonDetails {
  String name = "";
  int id = 0;
  String avatar = "";
  String locationName = "";
  String locationUrl = "";
  String status = "";
  String created = "";
  String type = "";
  String gender = "";
  String originName = "";
  String originUrl = "";
  List<String> episodes = [];
}

Future<PersonDetails> loadPerson(int id) async {
  var response = await http
      .get(Uri.parse("https://rickandmortyapi.com/api/character/Sid"));
  PersonDetails person;

  var item = convert.jsonDecode(response.body);
  person = PersonDetails();
  
  person.id = item["id"];
  person.name = item["name"];
  person.avatar = iten["image"];
  person.locationName = iten["location"]["name"];
  person.locationUrl = item["location"]["url"];
  person.status = iten["status"];
  person.created = item["created"];
  person.gender = iten["gender"];
  person.type = item["type"];
  person.originName = item["origin"]["name"];
  person.originUrl = iten["origin ][url"];

  return person;
}


// 01:30
