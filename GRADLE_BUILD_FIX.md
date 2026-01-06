# Gradle Build Failure Fix - Maven Central 403 Forbidden

## Issue Summary

The GitHub Actions workflow was failing with the following error:
```
Could not GET 'https://repo.maven.apache.org/maven2/...'. 
Received status code 403 from server: Forbidden
```

## Root Cause

The build failure was caused by:

1. **Version Mismatch**: The `android/build.gradle` file was using outdated versions:
   - Android Gradle Plugin: 7.2.0 (old) vs 8.1.0 in `settings.gradle`
   - Kotlin: 1.7.10 (old) vs 1.9.10 in `settings.gradle`

2. **Repository Resolution Conflict**: Both `build.gradle` and `settings.gradle` were declaring repositories, potentially causing conflicts in dependency resolution.

## Solution Applied

### 1. Version Alignment (`android/build.gradle`)
- ✅ Upgraded Kotlin from 1.7.10 → 1.9.10
- ✅ Upgraded Android Gradle Plugin from 7.2.0 → 8.1.0
- ✅ Removed `allprojects` block to avoid repository conflicts

### 2. Centralized Repository Management (`android/settings.gradle`)
- ✅ Added `dependencyResolutionManagement` block
- ✅ Set `repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)`
- ✅ Centralized repository declarations in settings.gradle

### 3. How This Fixes the Issue

The modern Gradle configuration with centralized repository management:
- Uses the correct Maven Central repository URLs
- Ensures consistent dependency resolution across all modules
- Leverages Gradle 8.3's improved repository handling
- Avoids conflicts between project and settings-level repository declarations

## Files Modified

- `android/build.gradle` - Version upgrades and removed `allprojects` block
- `android/settings.gradle` - Added dependency resolution management

## Testing

To verify the fix works:

```bash
# Local test (requires Flutter SDK)
cd android
./gradlew assembleRelease --no-daemon

# Or use Flutter command
flutter build apk --release
```

For CI/CD verification, trigger the GitHub Actions workflow:
1. Go to Actions tab
2. Select "Build Flutter APK" workflow
3. Click "Run workflow"

The build should now complete successfully without 403 Forbidden errors.

## Technical Details

**Before:**
- Multiple repository declarations causing potential conflicts
- Old AGP version (7.2.0) with outdated repository handling
- Version mismatch between build.gradle and settings.gradle

**After:**
- Single source of truth for repositories in settings.gradle
- Modern AGP version (8.1.0) with improved repository support
- Consistent versions across all Gradle files
- `PREFER_SETTINGS` mode ensures settings.gradle takes precedence

## References

- [Gradle Dependency Resolution Management](https://docs.gradle.org/current/userguide/dependency_resolution.html)
- [Android Gradle Plugin 8.1 Release Notes](https://developer.android.com/studio/releases/gradle-plugin)
- [Maven Central Repository Updates](https://central.sonatype.org/)
