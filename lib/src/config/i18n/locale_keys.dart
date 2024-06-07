import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations.byLocale("en_us") +
      {
        "en_us": {
          "title": "Current Location Map",
          "error": "Error fetching location",
          "no_location": "No location available",
          "change_language": "Change Language",
        },
        "pt_br": {
          "title": "Mapa de Localização Atual",
          "error": "Erro ao obter localização",
          "no_location": "Nenhuma localização disponível",
          "change_language": "Mudar Idioma",
        },
      };

  String get i18n => localize(this, _t);
  String plural(int value) => localizePlural(value, this, _t);
}
