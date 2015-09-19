import 'package:angular2/bootstrap.dart';

import 'package:pirate_badge/components/pirate_badge.dart';

@Component(selector: 'app')
@View(
    template: '''
    <pirate-badge></pirate-badge>
    ''',
    directives: const [PirateBadge])
class App {}

main() => bootstrap(App);
