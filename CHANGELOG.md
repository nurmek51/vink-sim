# Changelog

## [Unreleased]

### Added
- **eSIM Activation Logic**:
  - Implemented deterministic activation string generation (`LPA:1$smdp.io$<ACTIVATION_CODE>`).
  - Added support for direct eSIM installation links:
    - Android: `https://esimsetup.android.com/esim_qrcode_provisioning?carddata=`
    - iOS: `https://esimsetup.apple.com/esim_qrcode_provisioning?carddata=`
  - Updated `FastSelectedBody` to handle platform-specific installation links.
  - Enabled "Fast" installation option for Android devices in `EsimSetupPage`.

### Changed
- **EsimSetupPage**:
  - Refactored `_baseActivationPrefix` constant.
  - Updated `getRowOptions` to include "Fast Option" (Direct Install) on Android.
  - Logic now constructs the full activation string (`fullActivationString`) from the `activationCode` in `SubscriberBloc` and passes it to child widgets.
  - Removed dependency on pre-existing `qr` field from backend `ImsiModel` in favor of client-side generation to ensure consistency.
- **FastSelectedBody**:
  - Updated `_installEsim` to prioritize `fullActivationString` and direct URL schemes for both Android and iOS.
- **GuidePage**:
  - Standardized specific navigation calls to use `NavigationService`.

### Fixed
- Ensured consistent activation string format across QR codes and direct links.
