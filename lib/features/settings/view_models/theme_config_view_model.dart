import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piece_of_happiness/features/settings/models/theme_config_model.dart';
import 'package:piece_of_happiness/features/settings/repos/theme_config_repo.dart';

class ThemeConfigViewModel extends Notifier<ThemeConfigModel> {
  final ThemeConfigRepo _themeConfigRepo;

  ThemeConfigViewModel(this._themeConfigRepo);

  @override
  ThemeConfigModel build() {
    return ThemeConfigModel(darkMode: _themeConfigRepo.isDarkMode());
  }

  void setDarkMode(bool value) {
    state = ThemeConfigModel(darkMode: value);
    _themeConfigRepo.setDarkMode(value);
  }
}

final themeConfigProvider =
    NotifierProvider<ThemeConfigViewModel, ThemeConfigModel>(
  () => throw UnimplementedError(),
);
