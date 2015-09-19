library pirate_badge.components.pirate_badge;

import 'package:angular2/angular2.dart';
import 'package:pirate_badge/services/pirate_name.dart';

@Component(selector: 'pirate-badge')
@View(
    template: '''
    <h1>Pirate badge</h1>
    <div class="widgets">
      <div>
        <input [disabled]="!enableInput" #input (input)="updateBadge(input.value)" type="text" maxlength="15">
      </div>
      <div>
        <button [disabled]="!enableButton" (click)="generateBadge()">{{ buttonText }}</button>
      </div>
    </div>
    <div class="badge">
      <div class="greeting">
        Arrr! Me name is
      </div>
      <div class="name">
        {{ badgeName }}
      </div>
    </div>
    ''')
class PirateBadge {
  String badgeName = "";
  String buttonText = "Aye! Gimme a name!";
  bool enableButton = false;
  bool enableInput = false;

  PirateBadge() {
    // not sure how to write this with await/async in constructor
    PirateNameService.readyThePirates().then((_) {
      enableButton = true;
      enableInput = true;
    }).catchError((arrr) {
      badgeName = 'Arrr! No names.';
      print('Error initializing pirate names: $arrr');
    });
  }

  void generateBadge() => setBadgeName(new PirateNameService());

  void setBadgeName(PirateNameService newName) {
    if (newName == null) return;
    badgeName = newName.pirateName;
  }

  void updateBadge(String inputName) {
    setBadgeName(new PirateNameService(firstName: inputName));
    if (inputName.trim().isEmpty) {
      buttonText = 'Aye! Gimme a name!';
      enableButton = true;
    } else {
      buttonText = 'Arrr! Write yer name!';
      enableButton = false;
    }
  }
}
