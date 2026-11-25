// const domain = 'http://13.212.104.165';

const domain = 'https://loyalty.carrefour.mn';

// E-commerce хэсгийг асаах flag. Анхдагч утга нь false (одоогийн loyalty апп).
// Асаах: flutter run --dart-define=ECOM=true
// VS Code дээр Run and Debug цэснээс "Carrefour (ecom)" тохиргоог сонгоно.
const bool ecom = bool.fromEnvironment('ECOM');

// const domain = 'http://192.168.0.24:8000';
// const domain = 'http://13.212.104.165/';

const kTurnstileSiteKey = '0x4AAAAAACgueGPKCHPgO3iu';

const String kTurnstileSiteKeyTestPass = '1x00000000000000000000AA';
const String kTurnstileSiteKeyTestFail = '2x00000000000000000000AB';
const String kTurnstileSiteKeyTestChallenge = '3x00000000000000000000FF';

/* Store constants */
const kStoreUser = 'kStoreUser';
const kStoreDevice = 'kStoreDevice';
const kUser = 'kUser';
const kToken = 'kToken';
const kFcmToken = 'kFcmToken';
const kWalkthroughShowed = 'kWalkthroughShowed';
const kBiometricEnabledPin = 'kBiometricEnabledPin';
const kNotificationCount = 'kNotificationCount';
const kAppToken = 'kAppToken';
