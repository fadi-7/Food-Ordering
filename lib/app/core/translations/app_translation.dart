import 'package:get/get.dart';

import 'languages/ar_language.dart';
import 'languages/en_language.dart';

class AppTranslation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>
      {"en_US": ENLanguage.map, "ar_SA": ARLanguage.map};
}

tr(String key) => key.tr;
