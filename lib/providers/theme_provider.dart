import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/theme_service.dart';

/// Provider for managing app theme state
class ThemeProvider extends ChangeNotifier {
  AppTheme _currentTheme = AppTheme.gold; // Default to Gold theme for jewellery app

  AppTheme get currentTheme => _currentTheme;
  ThemeData get themeData => ThemeService.getThemeData(_currentTheme);

  ThemeProvider() {
    _loadTheme();
  }

  /// Load saved theme from storage
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('app_theme');
    if (savedTheme != null) {
      try {
        _currentTheme = AppTheme.values.firstWhere(
          (theme) => theme.name == savedTheme,
          orElse: () => AppTheme.gold,
        );
        notifyListeners();
      } catch (e) {
        // If theme not found, use default
        debugPrint('Error loading theme: $e. Using default theme.');
        _currentTheme = AppTheme.gold;
      }
    }
  }

  /// Set new theme and save to storage
  Future<void> setTheme(AppTheme theme) async {
    _currentTheme = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_theme', theme.name);
    notifyListeners();
  }
}
