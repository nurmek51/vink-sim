# Changelog

## [Unreleased]

### Added
- **In-App Payment Checkout (WebView)**:
  - Payment checkout now opens inside app using internal WebView instead of external browser handoff.
  - Added checkout return interception for deep-link and backend `back_link` / `failure_back_link` callbacks.
- **Payment Return Deep Link**:
  - Added configurable `FeatureConfig.paymentReturnDeepLinkBase` (default: `vinksim://payment-return`).
  - Registered deep-link scheme for both standalone `vink_sim` mobile targets (Android/iOS).
- **ePay Integration (Top-up & Purchase)**:
  - Integrated `POST /api/v1/payments/initiate` and `GET /api/v1/payments/status/{payment_id}` into feature payment flow.
  - Added checkout launch using backend `checkout_url` with final status polling until terminal state.
  - Added locale-to-payment language mapping for backend contract values (`rus | kaz | eng`).
- **Saved Cards & Recurrent API Support**:
  - Added support for `GET /api/v1/payments/saved-cards` and `DELETE /api/v1/payments/saved-cards/{card_id}`.
  - Added support for `POST /api/v1/payments/recurrent`.
  - Added saved-card selection UI (selector + modal) in top-up screen using existing feature styling.
- **eSIM Activation Logic**:
  - Implemented deterministic activation string generation (`LPA:1$smdp.io$<ACTIVATION_CODE>`).
  - Added support for direct eSIM installation links:
    - Android: `https://esimsetup.android.com/esim_qrcode_provisioning?carddata=`
    - iOS: `https://esimsetup.apple.com/esim_qrcode_provisioning?carddata=`
  - Updated `FastSelectedBody` to handle platform-specific installation links.
  - Enabled "Fast" installation option for Android devices in `EsimSetupPage`.

### Changed
- **Top-Up Payment Logic (Finalized)**:
  - Auto top-up is now an active toggle (no longer a coming-soon placeholder).
  - `save_card` is sent as `true` only when auto top-up is enabled; standard card payment keeps `save_card=false`.
  - Recurrent payment is attempted only when auto top-up is enabled and a saved card is explicitly selected.
  - Saved card selector defaults to `none` (`Choose from saved card`) and supports `Other card` option for acquiring-page entry.
  - Removed redundant saved-card API calls during payment submit path.
- **Top-Up eSIM Synchronization**:
  - Main flow top-up action now passes current page eSIM IMSI to top-up screen to prevent UI/request mismatch (including inactive eSIM cards).
- **Android Build Compatibility (`vink_sim`)**:
  - Upgraded Android Gradle Plugin to `8.9.1` and Gradle wrapper to `8.12`.
  - Aligned debug `applicationId` with existing Firebase config (`google-services.json`) to restore successful APK build.
- **Top-up Submit Logic (`top_up_balance_screen`)**:
  - Added selected SIM validation for existing eSIM top-up flow.
  - Credit-card top-up now tries recurrent payment with saved cards first, then falls back to hosted checkout.
  - Apple Pay / Google Pay continue via hosted checkout initiation flow.
  - Success navigation now depends on flow type (`isNewEsim`) to prevent incorrect post-payment routing.
- **Payment State Defaults**:
  - Default payment method changed to `credit_card` to avoid invalid initial method on non-iOS devices.
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
