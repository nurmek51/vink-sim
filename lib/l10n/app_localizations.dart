import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of SimLocalizations
/// returned by `SimLocalizations.of(context)`.
///
/// Applications need to include `SimLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SimLocalizations.localizationsDelegates,
///   supportedLocales: SimLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the SimLocalizations.supportedLocales
/// property.
abstract class SimLocalizations {
  SimLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SimLocalizations? of(BuildContext context) {
    return Localizations.of<SimLocalizations>(context, SimLocalizations);
  }

  static const LocalizationsDelegate<SimLocalizations> delegate =
      _SimLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @frame_title.
  ///
  /// In en, this message translates to:
  /// **'One eSIM for all\nyour trips'**
  String get frame_title;

  /// No description provided for @storage_header_title.
  ///
  /// In en, this message translates to:
  /// **'Vink Sim'**
  String get storage_header_title;

  /// No description provided for @frame_globus_title.
  ///
  /// In en, this message translates to:
  /// **'One card for all destinations'**
  String get frame_globus_title;

  /// No description provided for @frame_check_title.
  ///
  /// In en, this message translates to:
  /// **'Pay only for what you spend'**
  String get frame_check_title;

  /// No description provided for @infinity_title.
  ///
  /// In en, this message translates to:
  /// **'No expiration date'**
  String get infinity_title;

  /// No description provided for @activation_button_title.
  ///
  /// In en, this message translates to:
  /// **'Login via email'**
  String get activation_button_title;

  /// No description provided for @what_is_esom.
  ///
  /// In en, this message translates to:
  /// **'What is eSIM?'**
  String get what_is_esom;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Your balance: '**
  String get balance;

  /// No description provided for @your_trafic.
  ///
  /// In en, this message translates to:
  /// **'YOUR TRAFFIC'**
  String get your_trafic;

  /// No description provided for @account_settings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get account_settings;

  /// No description provided for @purchase_history.
  ///
  /// In en, this message translates to:
  /// **'Purchase History'**
  String get purchase_history;

  /// No description provided for @traffic_usage.
  ///
  /// In en, this message translates to:
  /// **'Traffic Usage'**
  String get traffic_usage;

  /// No description provided for @app_language.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get app_language;

  /// No description provided for @how_to_install_esim.
  ///
  /// In en, this message translates to:
  /// **'How to install eSIM?'**
  String get how_to_install_esim;

  /// No description provided for @how_to_install_esim2.
  ///
  /// In en, this message translates to:
  /// **'How to install\neSIM?'**
  String get how_to_install_esim2;

  /// No description provided for @support_chat.
  ///
  /// In en, this message translates to:
  /// **'Support\nChat'**
  String get support_chat;

  /// No description provided for @questions_and_answers.
  ///
  /// In en, this message translates to:
  /// **'Questions\nand Answers'**
  String get questions_and_answers;

  /// No description provided for @countries_and_rates.
  ///
  /// In en, this message translates to:
  /// **'Countries\nand Rates'**
  String get countries_and_rates;

  /// No description provided for @top_up_balance.
  ///
  /// In en, this message translates to:
  /// **'Top Up Balance'**
  String get top_up_balance;

  /// No description provided for @telegram_support.
  ///
  /// In en, this message translates to:
  /// **'Telegram Support'**
  String get telegram_support;

  /// No description provided for @whatsapp_support.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp Support'**
  String get whatsapp_support;

  /// No description provided for @email_support.
  ///
  /// In en, this message translates to:
  /// **'Email Support'**
  String get email_support;

  /// No description provided for @my_account.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get my_account;

  /// No description provided for @app_language_title.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get app_language_title;

  /// No description provided for @app_language_ru.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get app_language_ru;

  /// No description provided for @app_language_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get app_language_en;

  /// No description provided for @start_registration.
  ///
  /// In en, this message translates to:
  /// **'Start Registration'**
  String get start_registration;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get download;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @install_esim.
  ///
  /// In en, this message translates to:
  /// **'Install eSIM'**
  String get install_esim;

  /// No description provided for @connection_wait_message.
  ///
  /// In en, this message translates to:
  /// **'The connection process may\ntake from 1 minute to an hour.'**
  String get connection_wait_message;

  /// No description provided for @connection_retry_instruction.
  ///
  /// In en, this message translates to:
  /// **'In case of connection problems –\nturn on \"Airplane Mode ✈\" for 10 seconds and\ntry again.'**
  String get connection_retry_instruction;

  /// No description provided for @support_chat2.
  ///
  /// In en, this message translates to:
  /// **'Support Chat'**
  String get support_chat2;

  /// No description provided for @success_message.
  ///
  /// In en, this message translates to:
  /// **'Done!'**
  String get success_message;

  /// No description provided for @fast_description_step1.
  ///
  /// In en, this message translates to:
  /// **'Press \"Install\" and allow access to profiles on your device'**
  String get fast_description_step1;

  /// No description provided for @fast_description_step2.
  ///
  /// In en, this message translates to:
  /// **'Select \"Primary\" for default number and for \"iMessage and FaceTime\"'**
  String get fast_description_step2;

  /// No description provided for @fast_description_step3.
  ///
  /// In en, this message translates to:
  /// **'Select the recently added eSIM plan for cellular data'**
  String get fast_description_step3;

  /// No description provided for @fast_description_step4.
  ///
  /// In en, this message translates to:
  /// **'Go to Settings > Cellular > Flex eSIM.\n\nEnable \"Data Roaming\"'**
  String get fast_description_step4;

  /// No description provided for @fast_selected_row.
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get fast_selected_row;

  /// No description provided for @manual_selected_row.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get manual_selected_row;

  /// No description provided for @qr_code_selected_row.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qr_code_selected_row;

  /// No description provided for @to_another_device_selected_row.
  ///
  /// In en, this message translates to:
  /// **'To another device'**
  String get to_another_device_selected_row;

  /// No description provided for @coming_soon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get coming_soon;

  /// No description provided for @how_does_it_work.
  ///
  /// In en, this message translates to:
  /// **'How does it work?'**
  String get how_does_it_work;

  /// No description provided for @esim_description1.
  ///
  /// In en, this message translates to:
  /// **'eSIM is a built-in SIM card that doesn\'t need to be inserted manually. Simply select a plan in the app, follow the instructions and activate the eSIM through your phone settings.'**
  String get esim_description1;

  /// No description provided for @esim_description2.
  ///
  /// In en, this message translates to:
  /// **'After activation, you immediately get access to the mobile network. To use the internet abroad – just top up your balance, and the connection will work in most countries without additional settings.'**
  String get esim_description2;

  /// No description provided for @qr_code_description.
  ///
  /// In en, this message translates to:
  /// **'Send QR code to another device'**
  String get qr_code_description;

  /// No description provided for @send_qr.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send_qr;

  /// No description provided for @another_device_description_warning.
  ///
  /// In en, this message translates to:
  /// **'The actions described below need to be\nperformed on the device where you\nwant to activate the Flex eSIM plan'**
  String get another_device_description_warning;

  /// No description provided for @another_device_description1.
  ///
  /// In en, this message translates to:
  /// **'On another device, open Settings > Cellular > Add eSIM > By QR Code'**
  String get another_device_description1;

  /// No description provided for @another_device_description2.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code with another device'**
  String get another_device_description2;

  /// No description provided for @another_device_description3.
  ///
  /// In en, this message translates to:
  /// **'Set a label for the new plan \"Flex Plan\"'**
  String get another_device_description3;

  /// No description provided for @another_device_description5.
  ///
  /// In en, this message translates to:
  /// **'Select the recently added Flex eSIM plan for cellular data'**
  String get another_device_description5;

  /// No description provided for @another_device_description_important.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t want to use eSIM right now, go to Settings > Cellular > Cellular Data and select Primary number.\n\nLater, when you want to use Flex eSIM again – select it on this screen.'**
  String get another_device_description_important;

  /// No description provided for @manual_description1.
  ///
  /// In en, this message translates to:
  /// **'Go to Settings > Cellular > Flex eSIM. Install the plan by entering the \"SM-DP+ Address\" and \"Activation Code\".'**
  String get manual_description1;

  /// No description provided for @adress_sm_dp.
  ///
  /// In en, this message translates to:
  /// **'SM-DP+ Address'**
  String get adress_sm_dp;

  /// No description provided for @activation_code.
  ///
  /// In en, this message translates to:
  /// **'Activation Code'**
  String get activation_code;

  /// No description provided for @tariffs_by_countries.
  ///
  /// In en, this message translates to:
  /// **'Tariffs by Countries'**
  String get tariffs_by_countries;

  /// No description provided for @guide_for_esim_settings.
  ///
  /// In en, this message translates to:
  /// **'eSIM Setup Guide'**
  String get guide_for_esim_settings;

  /// No description provided for @smth_more.
  ///
  /// In en, this message translates to:
  /// **'How to install eSIM'**
  String get smth_more;

  /// No description provided for @tariffs_and_countries.
  ///
  /// In en, this message translates to:
  /// **'Tariffs and Countries'**
  String get tariffs_and_countries;

  /// No description provided for @balance_and_esim_activation.
  ///
  /// In en, this message translates to:
  /// **'Top up your balance in the app and activate the eSIM card'**
  String get balance_and_esim_activation;

  /// No description provided for @profile_setup_guide.
  ///
  /// In en, this message translates to:
  /// **'Set up your profile in your phone settings'**
  String get profile_setup_guide;

  /// No description provided for @ready_to_travel_message.
  ///
  /// In en, this message translates to:
  /// **'Ready! Travel without worrying about your internet!'**
  String get ready_to_travel_message;

  /// No description provided for @high_speed_low_cost.
  ///
  /// In en, this message translates to:
  /// **'High speed and lowest\nprices'**
  String get high_speed_low_cost;

  /// No description provided for @countries_in_one_esim.
  ///
  /// In en, this message translates to:
  /// **'180+ countries in one eSIM'**
  String get countries_in_one_esim;

  /// No description provided for @activate_esim.
  ///
  /// In en, this message translates to:
  /// **'Activate eSIM'**
  String get activate_esim;

  /// No description provided for @auth_with_the_help_of.
  ///
  /// In en, this message translates to:
  /// **'Sign in with'**
  String get auth_with_the_help_of;

  /// No description provided for @whats_app.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whats_app;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get email;

  /// No description provided for @mobile_num_whats_app_description.
  ///
  /// In en, this message translates to:
  /// **'Enter the phone number\nassociated with WhatsApp'**
  String get mobile_num_whats_app_description;

  /// No description provided for @email_description.
  ///
  /// In en, this message translates to:
  /// **'Enter your email - we will send you a code for\nauthorization'**
  String get email_description;

  /// No description provided for @auth_and_registration.
  ///
  /// In en, this message translates to:
  /// **'Sign In / Sign Up'**
  String get auth_and_registration;

  /// No description provided for @continue_with_apple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continue_with_apple;

  /// No description provided for @continue_with_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continue_with_google;

  /// No description provided for @continue_with_email.
  ///
  /// In en, this message translates to:
  /// **'Continue with Email'**
  String get continue_with_email;

  /// No description provided for @esim_is_activated.
  ///
  /// In en, this message translates to:
  /// **'eSIM is activated!'**
  String get esim_is_activated;

  /// No description provided for @important.
  ///
  /// In en, this message translates to:
  /// **'IMPORTANT'**
  String get important;

  /// No description provided for @attention.
  ///
  /// In en, this message translates to:
  /// **'Attention!'**
  String get attention;

  /// No description provided for @now_you_need_to_install_esim.
  ///
  /// In en, this message translates to:
  /// **'Now you need to install eSIM\non your device.'**
  String get now_you_need_to_install_esim;

  /// No description provided for @you_can_activate_esim_only_once.
  ///
  /// In en, this message translates to:
  /// **'You can activate eSIM\nonly once on one device.'**
  String get you_can_activate_esim_only_once;

  /// No description provided for @show_qr.
  ///
  /// In en, this message translates to:
  /// **'Show QR'**
  String get show_qr;

  /// No description provided for @select_country.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get select_country;

  /// No description provided for @search_countries.
  ///
  /// In en, this message translates to:
  /// **'Search countries...'**
  String get search_countries;

  /// No description provided for @add_esim.
  ///
  /// In en, this message translates to:
  /// **'Add eSIM'**
  String get add_esim;

  /// No description provided for @manage_more_esims.
  ///
  /// In en, this message translates to:
  /// **'You can manage multiple\neSIMs on your device'**
  String get manage_more_esims;

  /// No description provided for @to_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get to_add;

  /// No description provided for @top_up.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get top_up;

  /// No description provided for @select_level.
  ///
  /// In en, this message translates to:
  /// **'Select level'**
  String get select_level;

  /// No description provided for @low_level.
  ///
  /// In en, this message translates to:
  /// **'Low — 0 GB'**
  String get low_level;

  /// No description provided for @medium_level.
  ///
  /// In en, this message translates to:
  /// **'Medium — 0.6 GB'**
  String get medium_level;

  /// No description provided for @high_level.
  ///
  /// In en, this message translates to:
  /// **'High — 15 GB'**
  String get high_level;

  /// No description provided for @enter_amount_description.
  ///
  /// In en, this message translates to:
  /// **'Enter amount to connect\nVink Sim'**
  String get enter_amount_description;

  /// No description provided for @balance_15_description.
  ///
  /// In en, this message translates to:
  /// **'{amount}\$ on balance, that\'s:'**
  String balance_15_description(Object amount);

  /// No description provided for @all_countries_and_tariffs.
  ///
  /// In en, this message translates to:
  /// **'All countries and tariffs'**
  String get all_countries_and_tariffs;

  /// No description provided for @choose_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Choose payment method'**
  String get choose_payment_method;

  /// No description provided for @auto_top_up.
  ///
  /// In en, this message translates to:
  /// **'Auto top-up'**
  String get auto_top_up;

  /// No description provided for @auto_top_up_description.
  ///
  /// In en, this message translates to:
  /// **'Balance will be topped up automatically\nby \$15 so you don\'t lose access during\ntravel'**
  String get auto_top_up_description;

  /// No description provided for @enter_code.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get enter_code;

  /// No description provided for @code_sent_message.
  ///
  /// In en, this message translates to:
  /// **'We sent a message with code to the number'**
  String get code_sent_message;

  /// No description provided for @enter_code_below.
  ///
  /// In en, this message translates to:
  /// **'Enter code in the field below'**
  String get enter_code_below;

  /// No description provided for @login_another_way.
  ///
  /// In en, this message translates to:
  /// **'Login another way'**
  String get login_another_way;

  /// No description provided for @resend_code.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resend_code;

  /// No description provided for @resend_code_timer.
  ///
  /// In en, this message translates to:
  /// **'Resend code in {seconds} sec'**
  String resend_code_timer(Object seconds);

  /// No description provided for @step_number.
  ///
  /// In en, this message translates to:
  /// **'Step {step}'**
  String step_number(Object step);

  /// No description provided for @code_sent_to_number.
  ///
  /// In en, this message translates to:
  /// **'We sent a message with code to the number'**
  String get code_sent_to_number;

  /// No description provided for @checking.
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get checking;

  /// No description provided for @confirm_code.
  ///
  /// In en, this message translates to:
  /// **'Confirm code'**
  String get confirm_code;

  /// No description provided for @login_different_way.
  ///
  /// In en, this message translates to:
  /// **'Login different way'**
  String get login_different_way;

  /// No description provided for @resend_code_after_seconds.
  ///
  /// In en, this message translates to:
  /// **'Resend code in {seconds} sec'**
  String resend_code_after_seconds(Object seconds);

  /// No description provided for @account_top_up.
  ///
  /// In en, this message translates to:
  /// **'Account top-up'**
  String get account_top_up;

  /// No description provided for @packages_from_1_dollar.
  ///
  /// In en, this message translates to:
  /// **'Packages from \$1'**
  String get packages_from_1_dollar;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @dollars_on_account.
  ///
  /// In en, this message translates to:
  /// **'\${amount} on account'**
  String dollars_on_account(Object amount);

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// No description provided for @chinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// No description provided for @enter_amount_top_up_description.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount to activate\nVink Sim'**
  String get enter_amount_top_up_description;

  /// No description provided for @flex_travel_esim_works_worldwide.
  ///
  /// In en, this message translates to:
  /// **'Vink Sim works worldwide, according to the tariffs of the country of presence.'**
  String get flex_travel_esim_works_worldwide;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @pay_money.
  ///
  /// In en, this message translates to:
  /// **'Pay \${amount}'**
  String pay_money(Object amount);

  /// No description provided for @in_europe.
  ///
  /// In en, this message translates to:
  /// **'in Europe'**
  String get in_europe;

  /// No description provided for @in_dubai.
  ///
  /// In en, this message translates to:
  /// **'in Dubai'**
  String get in_dubai;

  /// No description provided for @in_asia.
  ///
  /// In en, this message translates to:
  /// **'in Central Asian countries'**
  String get in_asia;

  /// No description provided for @monaco.
  ///
  /// In en, this message translates to:
  /// **'Monaco'**
  String get monaco;

  /// No description provided for @enter_verification_code.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get enter_verification_code;

  /// No description provided for @login_using_another_method.
  ///
  /// In en, this message translates to:
  /// **'Sign in another way'**
  String get login_using_another_method;

  /// No description provided for @send_again.
  ///
  /// In en, this message translates to:
  /// **'Send again'**
  String get send_again;

  /// No description provided for @did_not_receive_the_code.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get did_not_receive_the_code;

  /// No description provided for @sended_six_digit_code.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to {phone}'**
  String sended_six_digit_code(Object phone);

  /// No description provided for @april_2023.
  ///
  /// In en, this message translates to:
  /// **'12 april 2023'**
  String get april_2023;

  /// No description provided for @balance_refill.
  ///
  /// In en, this message translates to:
  /// **'Balance Top-Up'**
  String get balance_refill;

  /// No description provided for @my_esims.
  ///
  /// In en, this message translates to:
  /// **'My eSIMs'**
  String get my_esims;

  /// No description provided for @send_error.
  ///
  /// In en, this message translates to:
  /// **'Sending Error'**
  String get send_error;

  /// No description provided for @otp_resent.
  ///
  /// In en, this message translates to:
  /// **'OTP resent successfully'**
  String get otp_resent;

  /// No description provided for @otp_fail.
  ///
  /// In en, this message translates to:
  /// **'OTP Fail'**
  String get otp_fail;

  /// No description provided for @otp_success.
  ///
  /// In en, this message translates to:
  /// **'OTP verified successfully'**
  String get otp_success;

  /// No description provided for @payment_fail.
  ///
  /// In en, this message translates to:
  /// **'Payment Fail'**
  String get payment_fail;

  /// No description provided for @enter_top_up_amount.
  ///
  /// In en, this message translates to:
  /// **'Enter Top-Up amount'**
  String get enter_top_up_amount;

  /// No description provided for @select_level_title.
  ///
  /// In en, this message translates to:
  /// **'Select Level'**
  String get select_level_title;

  /// No description provided for @low_level_balance.
  ///
  /// In en, this message translates to:
  /// **'Low — 0 GB'**
  String get low_level_balance;

  /// No description provided for @medium_level_balance.
  ///
  /// In en, this message translates to:
  /// **'Medium — 0.6 GB'**
  String get medium_level_balance;

  /// No description provided for @high_level_balance.
  ///
  /// In en, this message translates to:
  /// **'High — 15 GB'**
  String get high_level_balance;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @not_available.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get not_available;

  /// No description provided for @gigabytes.
  ///
  /// In en, this message translates to:
  /// **'GB'**
  String get gigabytes;

  /// No description provided for @balance_prefix.
  ///
  /// In en, this message translates to:
  /// **'on account'**
  String get balance_prefix;

  /// No description provided for @step.
  ///
  /// In en, this message translates to:
  /// **'Step'**
  String get step;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logout_confirmation_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get logout_confirmation_title;

  /// No description provided for @logout_confirmation_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logout_confirmation_message;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @in_country.
  ///
  /// In en, this message translates to:
  /// **'in'**
  String get in_country;

  /// No description provided for @select_sim_card.
  ///
  /// In en, this message translates to:
  /// **'Select SIM card'**
  String get select_sim_card;

  /// No description provided for @sim_card_fallback.
  ///
  /// In en, this message translates to:
  /// **'SIM card'**
  String get sim_card_fallback;

  /// No description provided for @on_balance.
  ///
  /// In en, this message translates to:
  /// **'on balance'**
  String get on_balance;

  /// No description provided for @select_for_top_up.
  ///
  /// In en, this message translates to:
  /// **'Select for top-up'**
  String get select_for_top_up;

  /// No description provided for @sim_card_default.
  ///
  /// In en, this message translates to:
  /// **'SIM card 1'**
  String get sim_card_default;

  /// No description provided for @esim_is_activating.
  ///
  /// In en, this message translates to:
  /// **'eSIM is activating...'**
  String get esim_is_activating;
}

class _SimLocalizationsDelegate
    extends LocalizationsDelegate<SimLocalizations> {
  const _SimLocalizationsDelegate();

  @override
  Future<SimLocalizations> load(Locale locale) {
    return SynchronousFuture<SimLocalizations>(lookupSimLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_SimLocalizationsDelegate old) => false;
}

SimLocalizations lookupSimLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SimLocalizationsEn();
    case 'ru':
      return SimLocalizationsRu();
  }

  throw FlutterError(
      'SimLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
