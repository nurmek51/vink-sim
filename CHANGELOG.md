# Changelog

## [Unreleased]

### Added
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
