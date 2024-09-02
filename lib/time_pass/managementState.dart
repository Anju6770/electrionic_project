import 'package:electrionic_project/time_pass/time_services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ManageState extends GetxController {
  RxBool _isLightTheme = true.obs;
  final PlacesServices _themeService = PlacesServices();

  bool get isLightTheme => _isLightTheme.value;

  void toggleTheme(String userId) async {
    _isLightTheme.value = !_isLightTheme.value;
    await _themeService.saveThemePreference(userId, _isLightTheme.value);
    update();
  }

  Future<void> loadThemePreference(String userId) async {
    final isLightTheme = await _themeService.fetchThemePreference(userId);
    if (isLightTheme != null) {
      _isLightTheme.value = isLightTheme;
    }
    update();
  }

}