# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Language

- Talk to the user in Mongolian (Cyrillic). Keep technical terms (widget, controller, API, commit, build and so on) in English.
- Write code comments and test descriptions in Mongolian. Identifiers stay in English.

## Project

Carrefour Mongolia loyalty app (Flutter, package name `carrefour`). Ships to Android (`mn.io.carrefour`) and iOS (App Store id `6504396133`). User-facing strings are in Mongolian (Cyrillic) and are hard-coded in widgets. There is no localization layer.

## Commands

```bash
flutter pub get
flutter run                      # needs Firebase config present for the target platform
flutter analyze                  # lints: package:flutter_lints/flutter.yaml
flutter test                     # run all tests
flutter test test/widget_test.dart --plain-name "<test name>"   # run one test
flutter build apk --release
flutter build ipa --release
dart run flutter_launcher_icons  # regenerate the iOS icon only (android: false)
dart run flutter_native_splash:create
```

Tests under `test/` are pure unit tests (validators, `IOResponse`, models, extensions, `CaptchaRequirement`). They avoid anything that touches Firebase, `GetStorage` or `HelperManager` because those need platform channels. Import individual files instead of `library.dart` where possible. `CaptchaRequirement` is a singleton, so its state leaks between tests.

Releases bump `version:` in `pubspec.yaml` (for example `1.0.15+17`). The backend reads the version through the `X-App-Version` header and forces an update when it is too old (see `MainController.checkAppVersion`).

## Configuration

`lib/library/utils/constants.dart` holds the environment switches. Change them deliberately:
- `domain` is the API base URL (production: `https://loyalty.carrefour.mn`). Dev/staging URLs are left there commented out.
- `ecom` is a compile-time feature flag for the e-commerce extension, which is being developed on the same codebase as the live loyalty app:
  - `ecom = false` builds the current loyalty app as it is in production. Bug fixes and small changes to the loyalty app are released this way.
  - `ecom = true` shows the in-progress e-commerce features.
  - Every e-com addition (screens, menu items, routes, tabs, home sections) must be gated with `if (ecom)`, so loyalty-app fixes and e-com work live in one branch without diverging. Never change existing loyalty behaviour unconditionally for e-com purposes. Branch on `ecom` instead.
  - The value comes from `bool.fromEnvironment('ECOM')` and defaults to false. Turn it on with `flutter run --dart-define=ECOM=true` (same flag for `flutter build`), or pick the "Carrefour (ecom)" configuration in `.vscode/launch.json`. Do not hard-code `true`.
- Cloudflare Turnstile site keys, with test keys for pass, fail and challenge.
- `k*` keys used by the local storage stores.

## Architecture

**State management and navigation: GetX.** Every screen follows this pattern:
`<feature>/<feature>_screen.dart` (a `GetView`), `_controller.dart` (extends `IOController`), `_binding.dart` (calls `Get.lazyPut`), and a barrel file `<feature>.dart` that exports all of them plus `models/` and `widgets/`. Parameters are passed to a screen through the binding's constructor, for example `CatalogInfoBinding(catalogId: id)`, not through route arguments.

**Routing:**
- `library/pages/io_pages.dart` registers only the root named routes: walkthrough, sign-in and tabbar. `IOPages.initial` chooses one of them from the stored state (walkthrough already shown, logged in or not).
- All other navigation goes through static helpers in `library/routes/` (`AppRoute`, `AuthRoute`, `MenuRoute`), which call `Get.to(() => Screen(), binding: ...)`. Add new screens to these helpers rather than to `getPages`.
- `DynamicRoute` maps push-notification payloads (`action_type`, `action_id`, `url`, `jump_feedback`) to navigation. It handles foreground messages, taps on a notification, and taps on a local notification.

**Barrel imports.** Code imports `package:carrefour/library/library.dart` and `package:carrefour/screens/screens.dart`, and each folder re-exports its contents. When you add a file, export it from the nearest barrel.

**Networking (`library/client/`, `library/shared/dio_manager.dart`):**
- API classes such as `CustomerApi` and `InfoApi` extend `IOClient` and call `sendGetRequest`, `sendPostRequest` and the other `send*` methods. Every call returns an `IOResponse` (`success`, `msg`, `data`, `json`), parsed with `g_json` (`JSON`). Errors are returned as an `IOResponse` and never thrown, so check `response.isSuccess`.
- `DioManager` is a singleton with two Dio instances. `hasToken: true` (the default) uses `mainDio`, which adds `Authorization: Bearer` and refreshes an expired access token in its request interceptor before sending. `hasToken: false` uses `customDio`. Both add the `X-App-Version`, `X-App-Platform` and `X-device-token` headers.
- Captcha: when `IOResponse.isCaptchaRequired` is true, the backend wants a Turnstile token. The `components/turnstile/` widgets obtain it, and it is sent as `validation_token`.

**Persistence:** `UserStoreManager.shared` (user, token, notification count; cleared on logout) and `DeviceStoreManager.shared` (FCM token, app device token, walkthrough flag, biometric settings) are two `GetStorage` boxes. They are read through the static getters in `HelperManager` (`isLogged`, `token`, `user`, `os`, `version` and so on).

**Startup (`main.dart` → `MainConfig`):** initialize the stores (and generate a UUID app token once), then Firebase and FCM plus `flutter_local_notifications`, then lock the app to portrait. `MainController` is a permanent controller that checks the app version and saves the FCM token.

**UI kit (`library/components/`, `library/theme/`):** these are the in-house `IO*` widgets (`IOScaffold`, `IOAppBar`, `IOButtonWidget` + `IOButtonModel`, `IOTextField`, `IOAlert`, `IOPopup`, `IOOtp`, dropdowns and others) and the theme tokens `IOColors`, `IOStyles` and `IOFonts` (the Gilroy font families are declared in `pubspec.yaml`). Use these instead of raw Material widgets. `IOController` provides `isLoading`, `user`, the notification `count` and the `showSuccess`, `showError` and `showWarning` alert helpers.
