library pirate_badge.services.pirate_name;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:angular2/angular2.dart';

@Injectable()
class PirateNameService {
  static final Random indexGen = new Random();

  static List<String> names = [];
  static List<String> appellations = [];

  String _firstName;
  String _appellation;

  PirateNameService({String firstName, String appellation}) {
    if (firstName == null) {
      _firstName = names[indexGen.nextInt(names.length)];
    } else {
      _firstName = firstName;
    }
    if (appellation == null) {
      _appellation = appellations[indexGen.nextInt(appellations.length)];
    } else {
      _appellation = appellation;
    }
  }

  String get pirateName =>
      _firstName.isEmpty ? '' : '$_firstName the $_appellation';

  String toString() => pirateName;

  static Future readyThePirates() async {
    String path =
        'https://www.dartlang.org/codelabs/darrrt/files/piratenames.json';
    String jsonString = await HttpRequest.getString(path);
    _parsePirateNamesFromJSON(jsonString);
  }

  static void _parsePirateNamesFromJSON(String jsonString) {
    Map pirateNames = JSON.decode(jsonString);
    names = pirateNames['names'];
    appellations = pirateNames['appellations'];
  }
}
