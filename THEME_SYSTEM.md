# Theme System Documentation

## Overview

The Jewel Calc app now includes a comprehensive, modern theming system inspired by the LedgerViewer app, with multiple colorful themes and persistent theme selection.

## Features

### Available Themes

The app includes **6 professionally designed themes**:

1. **Light Theme** - Clean, modern light theme with indigo accents
2. **Dark Theme** - Eye-friendly dark theme for low-light environments
3. **Ocean Blue** - Vibrant cyan/blue theme evoking the ocean
4. **Emerald Green** - Fresh green theme representing nature and growth
5. **Royal Purple** - Elegant purple theme for a premium feel
6. **Gold Elegance** *(Default)* - Warm gold/amber theme perfect for a jewellery app

### Theme Components

Each theme includes customized:
- **AppBar**: Themed background color with white text
- **Cards**: Rounded corners (16px) with elevation
- **Buttons**: Rounded (12px) with consistent padding
- **Text Fields**: Filled style with themed borders and focus states
- **Typography**: Google Fonts' Poppins for a modern, professional look
- **Color Scheme**: Full Material 3 color scheme derived from primary color

### Theme-Aware UI Components

The following UI components automatically adapt to the selected theme:

- **Added Items List**: Success color for totals, themed surface for item cards
- **Final Amount Section**: Primary container color for background, themed success color for amounts
- **Exchange Items**: Orange highlighting for exchange values
- **All Buttons**: Consistent themed styling
- **Input Fields**: Themed fill colors and focus borders

## Implementation Details

### Architecture

The theming system uses the **Provider** state management pattern:

```
lib/
├── services/
│   └── theme_service.dart      # Theme definitions and utilities
├── providers/
│   └── theme_provider.dart     # Theme state management
└── main.dart                    # Theme integration
```

### Key Files

#### 1. `theme_service.dart`
- Defines `AppTheme` enum with all available themes
- Provides `ThemeData` objects for each theme
- Includes utility methods:
  - `getThemeName()` - Get display name for theme
  - `getThemeIcon()` - Get icon for theme
  - `getPrimaryColor()` - Get primary color for theme
  - `getSuccessColor()` - Get success/accent color for theme

#### 2. `theme_provider.dart`
- Manages theme state using `ChangeNotifier`
- Persists theme selection to `SharedPreferences`
- Loads saved theme on app startup
- Default theme: **Gold Elegance** (appropriate for jewellery app)

#### 3. `main.dart` Integration
- Wraps app with `ChangeNotifierProvider`
- Uses `Consumer` widget to rebuild on theme changes
- Applies theme to `MaterialApp`

### Theme Selection UI

Theme selection is available in the Settings dialog:

1. Open Settings (⚙️ icon in AppBar)
2. Scroll to "App Theme" section
3. Select theme from dropdown
4. Theme changes immediately
5. Selection is automatically saved

## Usage

### For Users

**To change the app theme:**

1. Tap the Settings icon (⚙️) in the top-right corner
2. Scroll down to the "App Theme" section
3. Tap the dropdown to see all available themes
4. Select your preferred theme
5. The theme applies immediately across the entire app
6. Your selection is saved and will persist even after closing the app

**Recommended Themes:**
- **Gold Elegance**: Best for jewellery/premium feel (default)
- **Light**: Clean and bright for well-lit environments
- **Dark**: Easy on eyes in low-light conditions
- **Ocean Blue**: Professional and calming
- **Emerald Green**: Fresh and vibrant
- **Royal Purple**: Elegant and distinctive

### For Developers

**To access theme colors in widgets:**

```dart
// Get theme provider
final themeProvider = Provider.of<ThemeProvider>(context);

// Get current theme
AppTheme currentTheme = themeProvider.currentTheme;

// Get theme-specific colors
Color primaryColor = ThemeService.getPrimaryColor(currentTheme);
Color successColor = ThemeService.getSuccessColor(currentTheme);

// Use theme colors
Text(
  'Total: ₹1000',
  style: TextStyle(color: successColor),
)
```

**To add a new theme:**

1. Add new enum value to `AppTheme` in `theme_service.dart`
2. Add theme name in `getThemeName()`
3. Add theme icon in `getThemeIcon()`
4. Add primary color in `getPrimaryColor()`
5. Add success color in `getSuccessColor()`
6. Create theme method (e.g., `_getNewTheme()`)
7. Add case in `getThemeData()` switch statement

## Technical Specifications

### Dependencies

```yaml
dependencies:
  provider: ^6.1.1          # State management
  google_fonts: ^6.1.0      # Poppins font family
```

### Material Design 3

All themes use **Material Design 3** (`useMaterial3: true`) for:
- Modern component designs
- Dynamic color schemes
- Enhanced accessibility
- Consistent elevation system

### Typography

All themes use **Google Fonts' Poppins**:
- Clean, modern sans-serif font
- Excellent readability
- Professional appearance
- Multiple weights for hierarchy

### Color Schemes

Each theme generates a full Material 3 `ColorScheme` from a seed color:
- Primary colors and variants
- Surface colors
- On-colors (contrasting text)
- Error colors
- Container colors

### Persistence

Theme selection is stored using `SharedPreferences`:
- Key: `'app_theme'`
- Value: Theme enum name (e.g., `'gold'`, `'oceanBlue'`)
- Loaded on app startup
- Survives app restarts

## Best Practices

### For Theme Consistency

1. **Use theme colors**: Always use `Theme.of(context)` or `ThemeService` methods instead of hardcoding colors
2. **Test all themes**: Verify your UI looks good in all available themes
3. **Use semantic colors**: Use success/error/warning colors appropriately
4. **Respect dark mode**: Ensure text is readable on theme backgrounds

### For Performance

1. **Use const constructors**: Make theme constants `const` where possible
2. **Minimize rebuilds**: Only wrap widgets that need theme updates with `Consumer`
3. **Cache colors**: Store frequently accessed colors in local variables

### For Accessibility

1. **Color contrast**: All themes meet WCAG AA standards for contrast
2. **Don't rely on color alone**: Use icons and text along with colors
3. **Test with screen readers**: Ensure theme changes don't break accessibility

## Future Enhancements

Possible future additions to the theming system:

- [ ] System theme detection (light/dark based on device settings)
- [ ] Custom color picker for users to create their own themes
- [ ] Theme preview before applying
- [ ] Animation transitions when switching themes
- [ ] More theme variations (Rose Gold, Sapphire Blue, etc.)
- [ ] Export/import theme settings

## Comparison with Reference App

This implementation is based on the **LedgerViewer** app's theming system with enhancements:

**Similarities:**
- Same theme service architecture
- Provider-based state management
- Persistent theme storage
- Google Fonts integration
- Material 3 design

**Improvements:**
- Added **Gold Elegance** theme (perfect for jewellery app)
- Enhanced color helper methods (`getSuccessColor`)
- More descriptive theme names
- Better default theme selection
- Additional UI components use theme colors

## Troubleshooting

### Theme not applying
- Ensure you've called `flutter pub get` after adding dependencies
- Check that `ChangeNotifierProvider` wraps `MaterialApp`
- Verify `Consumer` is used correctly

### Colors look wrong
- Check that you're using theme colors via `ThemeService` methods
- Ensure Material 3 is enabled (`useMaterial3: true`)
- Test with different themes to identify theme-specific issues

### Theme not persisting
- Verify `SharedPreferences` permission in Android manifest
- Check that `setTheme()` is being called when theme changes
- Look for errors in theme loading on app startup

## Credits

- Inspired by **LedgerViewer** app's theming implementation
- Uses **Provider** package for state management
- **Google Fonts** for typography
- **Material Design 3** principles
