import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bg.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
    Locale('bg'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hu'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('sk'),
    Locale('sl'),
    Locale('sv'),
    Locale('uk'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core'**
  String get appTitle;

  /// No description provided for @nav_contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get nav_contacts;

  /// No description provided for @nav_channels.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get nav_channels;

  /// No description provided for @nav_map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get nav_map;

  /// No description provided for @nav_messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get nav_messages;

  /// No description provided for @nav_nodes.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get nav_nodes;

  /// No description provided for @nav_radio.
  ///
  /// In en, this message translates to:
  /// **'Radio'**
  String get nav_radio;

  /// No description provided for @messages_title.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages_title;

  /// No description provided for @messages_filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get messages_filterAll;

  /// No description provided for @messages_filterDirect.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get messages_filterDirect;

  /// No description provided for @messages_filterChannels.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get messages_filterChannels;

  /// No description provided for @messages_filterWithUnread.
  ///
  /// In en, this message translates to:
  /// **'{label} · {count}'**
  String messages_filterWithUnread(String label, int count);

  /// No description provided for @messages_search.
  ///
  /// In en, this message translates to:
  /// **'Search messages'**
  String get messages_search;

  /// No description provided for @messages_searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search conversations'**
  String get messages_searchHint;

  /// No description provided for @messages_closeSearch.
  ///
  /// In en, this message translates to:
  /// **'Close search'**
  String get messages_closeSearch;

  /// No description provided for @messages_manageChannels.
  ///
  /// In en, this message translates to:
  /// **'Manage channels'**
  String get messages_manageChannels;

  /// No description provided for @messages_new.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get messages_new;

  /// No description provided for @messages_newDirect.
  ///
  /// In en, this message translates to:
  /// **'Message a node'**
  String get messages_newDirect;

  /// No description provided for @messages_newChannel.
  ///
  /// In en, this message translates to:
  /// **'Add or join a channel'**
  String get messages_newChannel;

  /// No description provided for @messages_empty.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get messages_empty;

  /// No description provided for @messages_emptyHint.
  ///
  /// In en, this message translates to:
  /// **'Messages from nodes and channels show up here.'**
  String get messages_emptyHint;

  /// No description provided for @messages_noMatches.
  ///
  /// In en, this message translates to:
  /// **'No conversations match your search'**
  String get messages_noMatches;

  /// No description provided for @messages_you.
  ///
  /// In en, this message translates to:
  /// **'You: {text}'**
  String messages_you(String text);

  /// No description provided for @messages_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get messages_yesterday;

  /// No description provided for @messages_unreadCount.
  ///
  /// In en, this message translates to:
  /// **'{count} unread'**
  String messages_unreadCount(int count);

  /// No description provided for @radioStatus_connectedVia.
  ///
  /// In en, this message translates to:
  /// **'Connected over {transport}'**
  String radioStatus_connectedVia(String transport);

  /// No description provided for @radioStatus_bluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get radioStatus_bluetooth;

  /// No description provided for @radioStatus_usb.
  ///
  /// In en, this message translates to:
  /// **'USB'**
  String get radioStatus_usb;

  /// No description provided for @radioStatus_tcp.
  ///
  /// In en, this message translates to:
  /// **'Wi‑Fi (TCP)'**
  String get radioStatus_tcp;

  /// No description provided for @radioStatus_battery.
  ///
  /// In en, this message translates to:
  /// **'Battery {percent}%'**
  String radioStatus_battery(int percent);

  /// No description provided for @radioStatus_openRadio.
  ///
  /// In en, this message translates to:
  /// **'Open radio details'**
  String get radioStatus_openRadio;

  /// No description provided for @radioOverview_battery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get radioOverview_battery;

  /// No description provided for @radioOverview_firmware.
  ///
  /// In en, this message translates to:
  /// **'Firmware {version}'**
  String radioOverview_firmware(String version);

  /// No description provided for @radioOverview_sendAdvert.
  ///
  /// In en, this message translates to:
  /// **'Send advert'**
  String get radioOverview_sendAdvert;

  /// No description provided for @radioOverview_stats.
  ///
  /// In en, this message translates to:
  /// **'Radio stats'**
  String get radioOverview_stats;

  /// No description provided for @accessControl_title.
  ///
  /// In en, this message translates to:
  /// **'Access control'**
  String get accessControl_title;

  /// No description provided for @accessControl_hubSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Who can log in without the password'**
  String get accessControl_hubSubtitle;

  /// No description provided for @accessControl_explainRepeater.
  ///
  /// In en, this message translates to:
  /// **'People on this list log in without a password. Admins can change settings; Read only and Read & write also get full telemetry.'**
  String get accessControl_explainRepeater;

  /// No description provided for @accessControl_explainRoom.
  ///
  /// In en, this message translates to:
  /// **'Admins on this list log in without a password and can manage the room. Room members join with the room password instead.'**
  String get accessControl_explainRoom;

  /// No description provided for @accessControl_roleReadOnly.
  ///
  /// In en, this message translates to:
  /// **'Read only'**
  String get accessControl_roleReadOnly;

  /// No description provided for @accessControl_roleReadWrite.
  ///
  /// In en, this message translates to:
  /// **'Read & write'**
  String get accessControl_roleReadWrite;

  /// No description provided for @accessControl_roleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get accessControl_roleAdmin;

  /// No description provided for @accessControl_you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get accessControl_you;

  /// No description provided for @accessControl_unknownNode.
  ///
  /// In en, this message translates to:
  /// **'Unknown node'**
  String get accessControl_unknownNode;

  /// No description provided for @accessControl_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get accessControl_add;

  /// No description provided for @accessControl_addTitle.
  ///
  /// In en, this message translates to:
  /// **'Add to access list'**
  String get accessControl_addTitle;

  /// No description provided for @accessControl_pickContact.
  ///
  /// In en, this message translates to:
  /// **'Choose a contact'**
  String get accessControl_pickContact;

  /// No description provided for @accessControl_noContacts.
  ///
  /// In en, this message translates to:
  /// **'No contacts to add. Nodes appear here once you have heard their advert.'**
  String get accessControl_noContacts;

  /// No description provided for @accessControl_changeRole.
  ///
  /// In en, this message translates to:
  /// **'Change role'**
  String get accessControl_changeRole;

  /// No description provided for @accessControl_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove access'**
  String get accessControl_remove;

  /// No description provided for @accessControl_removeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from the access list? They will need the password to log in.'**
  String accessControl_removeConfirm(String name);

  /// No description provided for @accessControl_removeSelfWarning.
  ///
  /// In en, this message translates to:
  /// **'This is you. If you remove yourself you will need the admin password to manage this node again.'**
  String get accessControl_removeSelfWarning;

  /// No description provided for @accessControl_unknownKeyNote.
  ///
  /// In en, this message translates to:
  /// **'Not in your contacts. Changing its role needs newer node firmware; removing it always works.'**
  String get accessControl_unknownKeyNote;

  /// No description provided for @accessControl_prefixUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This node\'s firmware can\'t change the role of someone who isn\'t in your contacts. You can still remove them.'**
  String get accessControl_prefixUnsupported;

  /// No description provided for @accessControl_empty.
  ///
  /// In en, this message translates to:
  /// **'Nobody is on the access list'**
  String get accessControl_empty;

  /// No description provided for @accessControl_emptyHint.
  ///
  /// In en, this message translates to:
  /// **'Add people so they can log in without the password.'**
  String get accessControl_emptyHint;

  /// No description provided for @accessControl_loading.
  ///
  /// In en, this message translates to:
  /// **'Asking the node for its access list…'**
  String get accessControl_loading;

  /// No description provided for @accessControl_timeout.
  ///
  /// In en, this message translates to:
  /// **'The node didn\'t answer. Check the path and try again.'**
  String get accessControl_timeout;

  /// No description provided for @accessControl_maybeIncomplete.
  ///
  /// In en, this message translates to:
  /// **'This node sent one full page and its firmware can\'t send more, so some entries may be missing.'**
  String get accessControl_maybeIncomplete;

  /// No description provided for @accessControl_saved.
  ///
  /// In en, this message translates to:
  /// **'Access list updated'**
  String get accessControl_saved;

  /// No description provided for @accessControl_failed.
  ///
  /// In en, this message translates to:
  /// **'The node refused the change: {reply}'**
  String accessControl_failed(String reply);

  /// No description provided for @companionCli_title.
  ///
  /// In en, this message translates to:
  /// **'Command line'**
  String get companionCli_title;

  /// No description provided for @companionCli_tileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Run commands on your radio'**
  String get companionCli_tileSubtitle;

  /// No description provided for @companionCli_warning.
  ///
  /// In en, this message translates to:
  /// **'Commands run on your connected radio and can change its settings or restart it.'**
  String get companionCli_warning;

  /// No description provided for @companionCli_hint.
  ///
  /// In en, this message translates to:
  /// **'Type a command, e.g. ver'**
  String get companionCli_hint;

  /// No description provided for @companionCli_send.
  ///
  /// In en, this message translates to:
  /// **'Run command'**
  String get companionCli_send;

  /// No description provided for @companionCli_noReply.
  ///
  /// In en, this message translates to:
  /// **'No reply. The radio may be restarting.'**
  String get companionCli_noReply;

  /// No description provided for @companionCli_empty.
  ///
  /// In en, this message translates to:
  /// **'Try one of the commands above, or type your own.'**
  String get companionCli_empty;

  /// No description provided for @wifi_title.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get wifi_title;

  /// No description provided for @wifi_tileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect your radio to a WiFi network'**
  String get wifi_tileSubtitle;

  /// No description provided for @wifi_unsupported.
  ///
  /// In en, this message translates to:
  /// **'This radio\'s firmware doesn\'t include WiFi.'**
  String get wifi_unsupported;

  /// No description provided for @wifi_enabled.
  ///
  /// In en, this message translates to:
  /// **'Use WiFi'**
  String get wifi_enabled;

  /// No description provided for @wifi_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get wifi_status;

  /// No description provided for @wifi_connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get wifi_connected;

  /// No description provided for @wifi_connectedIp.
  ///
  /// In en, this message translates to:
  /// **'Connected · {ip}'**
  String wifi_connectedIp(String ip);

  /// No description provided for @wifi_disconnected.
  ///
  /// In en, this message translates to:
  /// **'Not connected'**
  String get wifi_disconnected;

  /// No description provided for @wifi_network.
  ///
  /// In en, this message translates to:
  /// **'Network name (SSID)'**
  String get wifi_network;

  /// No description provided for @wifi_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get wifi_password;

  /// No description provided for @wifi_passwordKeep.
  ///
  /// In en, this message translates to:
  /// **'Leave blank to keep the current password'**
  String get wifi_passwordKeep;

  /// No description provided for @wifi_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get wifi_save;

  /// No description provided for @wifi_forget.
  ///
  /// In en, this message translates to:
  /// **'Forget network'**
  String get wifi_forget;

  /// No description provided for @wifi_forgetConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove the saved network and password from the radio?'**
  String get wifi_forgetConfirm;

  /// No description provided for @wifi_rebootNeeded.
  ///
  /// In en, this message translates to:
  /// **'Saved. Restart the radio to apply WiFi changes.'**
  String get wifi_rebootNeeded;

  /// No description provided for @wifi_rebootNow.
  ///
  /// In en, this message translates to:
  /// **'Restart radio'**
  String get wifi_rebootNow;

  /// No description provided for @wifi_rebootConfirm.
  ///
  /// In en, this message translates to:
  /// **'Restart the radio now? The app will disconnect and you\'ll need to reconnect.'**
  String get wifi_rebootConfirm;

  /// No description provided for @wifi_loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t read the WiFi settings from the radio.'**
  String get wifi_loadFailed;

  /// No description provided for @wifi_retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get wifi_retry;

  /// No description provided for @wifi_saveFailed.
  ///
  /// In en, this message translates to:
  /// **'The radio didn\'t accept the change: {reply}'**
  String wifi_saveFailed(String reply);

  /// No description provided for @accessControl_refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get accessControl_refresh;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @common_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get common_ok;

  /// No description provided for @common_connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get common_connect;

  /// No description provided for @common_unknownDevice.
  ///
  /// In en, this message translates to:
  /// **'Unknown Device'**
  String get common_unknownDevice;

  /// No description provided for @common_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_save;

  /// No description provided for @common_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_delete;

  /// No description provided for @common_deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get common_deleteAll;

  /// No description provided for @common_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get common_close;

  /// No description provided for @common_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get common_done;

  /// No description provided for @common_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get common_edit;

  /// No description provided for @common_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get common_add;

  /// No description provided for @common_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get common_settings;

  /// No description provided for @common_disconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get common_disconnect;

  /// No description provided for @common_connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get common_connected;

  /// No description provided for @common_disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get common_disconnected;

  /// No description provided for @common_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get common_create;

  /// No description provided for @common_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get common_continue;

  /// No description provided for @common_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get common_share;

  /// No description provided for @common_copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get common_copy;

  /// No description provided for @common_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get common_retry;

  /// No description provided for @common_hide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get common_hide;

  /// No description provided for @common_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get common_remove;

  /// No description provided for @common_enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get common_enable;

  /// No description provided for @common_disable.
  ///
  /// In en, this message translates to:
  /// **'Disable'**
  String get common_disable;

  /// No description provided for @common_undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get common_undo;

  /// No description provided for @messageStatus_sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get messageStatus_sent;

  /// No description provided for @messageStatus_delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get messageStatus_delivered;

  /// No description provided for @messageStatus_pending.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get messageStatus_pending;

  /// No description provided for @messageStatus_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send'**
  String get messageStatus_failed;

  /// No description provided for @messageStatus_repeated.
  ///
  /// In en, this message translates to:
  /// **'Heard repeated'**
  String get messageStatus_repeated;

  /// No description provided for @urlImage_enable.
  ///
  /// In en, this message translates to:
  /// **'Enable URL images'**
  String get urlImage_enable;

  /// No description provided for @urlImage_possible.
  ///
  /// In en, this message translates to:
  /// **'Possible URL image; enable it in Settings.'**
  String get urlImage_possible;

  /// No description provided for @common_reboot.
  ///
  /// In en, this message translates to:
  /// **'Reboot'**
  String get common_reboot;

  /// No description provided for @common_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get common_loading;

  /// No description provided for @common_notAvailable.
  ///
  /// In en, this message translates to:
  /// **'—'**
  String get common_notAvailable;

  /// No description provided for @common_voltageValue.
  ///
  /// In en, this message translates to:
  /// **'{volts} V'**
  String common_voltageValue(String volts);

  /// No description provided for @common_percentValue.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String common_percentValue(int percent);

  /// No description provided for @common_autoRefresh.
  ///
  /// In en, this message translates to:
  /// **'Autorefresh'**
  String get common_autoRefresh;

  /// No description provided for @common_interval.
  ///
  /// In en, this message translates to:
  /// **'Interval'**
  String get common_interval;

  /// No description provided for @scanner_title.
  ///
  /// In en, this message translates to:
  /// **'Connect Radio'**
  String get scanner_title;

  /// No description provided for @connectionChoiceUsbLabel.
  ///
  /// In en, this message translates to:
  /// **'USB'**
  String get connectionChoiceUsbLabel;

  /// No description provided for @connectionChoiceBluetoothLabel.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get connectionChoiceBluetoothLabel;

  /// No description provided for @connectionChoiceTcpLabel.
  ///
  /// In en, this message translates to:
  /// **'TCP'**
  String get connectionChoiceTcpLabel;

  /// No description provided for @tcpScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect over TCP'**
  String get tcpScreenTitle;

  /// No description provided for @tcpHostLabel.
  ///
  /// In en, this message translates to:
  /// **'Endpoint'**
  String get tcpHostLabel;

  /// No description provided for @tcpHostHint.
  ///
  /// In en, this message translates to:
  /// **'192.168.40.10 / example.com'**
  String get tcpHostHint;

  /// No description provided for @tcpPortLabel.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get tcpPortLabel;

  /// No description provided for @tcpPortHint.
  ///
  /// In en, this message translates to:
  /// **'5000'**
  String get tcpPortHint;

  /// No description provided for @tcpStatus_notConnected.
  ///
  /// In en, this message translates to:
  /// **'Enter endpoint and connect'**
  String get tcpStatus_notConnected;

  /// No description provided for @tcpStatus_connectingTo.
  ///
  /// In en, this message translates to:
  /// **'Connecting to {endpoint}...'**
  String tcpStatus_connectingTo(String endpoint);

  /// No description provided for @tcpErrorHostRequired.
  ///
  /// In en, this message translates to:
  /// **'Host is required.'**
  String get tcpErrorHostRequired;

  /// No description provided for @tcpErrorPortInvalid.
  ///
  /// In en, this message translates to:
  /// **'Port must be between 1 and 65535.'**
  String get tcpErrorPortInvalid;

  /// No description provided for @tcpErrorUnsupported.
  ///
  /// In en, this message translates to:
  /// **'TCP transport is not supported on this platform.'**
  String get tcpErrorUnsupported;

  /// No description provided for @tcpErrorTimedOut.
  ///
  /// In en, this message translates to:
  /// **'TCP connection timed out.'**
  String get tcpErrorTimedOut;

  /// No description provided for @tcpConnectionFailed.
  ///
  /// In en, this message translates to:
  /// **'TCP connection failed: {error}'**
  String tcpConnectionFailed(String error);

  /// No description provided for @usbScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect over USB'**
  String get usbScreenTitle;

  /// No description provided for @usbScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a detected serial device and connect directly to your MeshCore node.'**
  String get usbScreenSubtitle;

  /// No description provided for @usbScreenStatus.
  ///
  /// In en, this message translates to:
  /// **'Select a USB device'**
  String get usbScreenStatus;

  /// No description provided for @usbScreenNote.
  ///
  /// In en, this message translates to:
  /// **'USB serial is active on supported Android devices and desktop platforms.'**
  String get usbScreenNote;

  /// No description provided for @usbScreenEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No USB devices found. Plug one in and refresh.'**
  String get usbScreenEmptyState;

  /// No description provided for @usbErrorPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'USB permission was denied.'**
  String get usbErrorPermissionDenied;

  /// No description provided for @usbErrorDeviceMissing.
  ///
  /// In en, this message translates to:
  /// **'The selected USB device is no longer available.'**
  String get usbErrorDeviceMissing;

  /// No description provided for @usbErrorInvalidPort.
  ///
  /// In en, this message translates to:
  /// **'Select a valid USB device.'**
  String get usbErrorInvalidPort;

  /// No description provided for @usbErrorBusy.
  ///
  /// In en, this message translates to:
  /// **'Another USB connection request is already in progress.'**
  String get usbErrorBusy;

  /// No description provided for @usbErrorNotConnected.
  ///
  /// In en, this message translates to:
  /// **'No USB device is connected.'**
  String get usbErrorNotConnected;

  /// No description provided for @usbErrorOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to open the selected USB device.'**
  String get usbErrorOpenFailed;

  /// No description provided for @usbErrorConnectFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to the selected USB device.'**
  String get usbErrorConnectFailed;

  /// No description provided for @usbErrorUnsupported.
  ///
  /// In en, this message translates to:
  /// **'USB serial is not supported on this platform.'**
  String get usbErrorUnsupported;

  /// No description provided for @usbErrorAlreadyActive.
  ///
  /// In en, this message translates to:
  /// **'A USB connection is already active.'**
  String get usbErrorAlreadyActive;

  /// No description provided for @usbErrorNoDeviceSelected.
  ///
  /// In en, this message translates to:
  /// **'No USB device was selected.'**
  String get usbErrorNoDeviceSelected;

  /// No description provided for @usbErrorPortClosed.
  ///
  /// In en, this message translates to:
  /// **'The USB connection is not open.'**
  String get usbErrorPortClosed;

  /// No description provided for @usbErrorConnectTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. Make sure the device has USB Companion firmware.'**
  String get usbErrorConnectTimedOut;

  /// No description provided for @usbFallbackDeviceName.
  ///
  /// In en, this message translates to:
  /// **'Web Serial Device'**
  String get usbFallbackDeviceName;

  /// No description provided for @usbStatus_notConnected.
  ///
  /// In en, this message translates to:
  /// **'Select a USB device'**
  String get usbStatus_notConnected;

  /// No description provided for @usbStatus_connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting to USB device...'**
  String get usbStatus_connecting;

  /// No description provided for @usbStatus_searching.
  ///
  /// In en, this message translates to:
  /// **'Searching for USB devices...'**
  String get usbStatus_searching;

  /// No description provided for @usbConnectionFailed.
  ///
  /// In en, this message translates to:
  /// **'USB connection failed: {error}'**
  String usbConnectionFailed(String error);

  /// No description provided for @scanner_scanning.
  ///
  /// In en, this message translates to:
  /// **'Scanning for devices...'**
  String get scanner_scanning;

  /// No description provided for @scanner_connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get scanner_connecting;

  /// No description provided for @scanner_disconnecting.
  ///
  /// In en, this message translates to:
  /// **'Disconnecting...'**
  String get scanner_disconnecting;

  /// No description provided for @scanner_notConnected.
  ///
  /// In en, this message translates to:
  /// **'Not connected'**
  String get scanner_notConnected;

  /// No description provided for @scanner_connectedTo.
  ///
  /// In en, this message translates to:
  /// **'Connected to {deviceName}'**
  String scanner_connectedTo(String deviceName);

  /// No description provided for @scanner_searchingDevices.
  ///
  /// In en, this message translates to:
  /// **'Searching for MeshCore devices...'**
  String get scanner_searchingDevices;

  /// No description provided for @scanner_tapToScan.
  ///
  /// In en, this message translates to:
  /// **'Tap Scan to find MeshCore devices'**
  String get scanner_tapToScan;

  /// No description provided for @scanner_connectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection failed: {error}'**
  String scanner_connectionFailed(String error);

  /// No description provided for @scanner_stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get scanner_stop;

  /// No description provided for @scanner_scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scanner_scan;

  /// No description provided for @scanner_bluetoothOff.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth is off'**
  String get scanner_bluetoothOff;

  /// No description provided for @scanner_bluetoothOffMessage.
  ///
  /// In en, this message translates to:
  /// **'Please turn on Bluetooth to scan for devices'**
  String get scanner_bluetoothOffMessage;

  /// No description provided for @scanner_chromeRequired.
  ///
  /// In en, this message translates to:
  /// **'Chrome Browser Required'**
  String get scanner_chromeRequired;

  /// No description provided for @scanner_chromeRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'This web application requires Google Chrome or a Chromium-based browser for Bluetooth support.'**
  String get scanner_chromeRequiredMessage;

  /// No description provided for @scanner_enableBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Enable Bluetooth'**
  String get scanner_enableBluetooth;

  /// No description provided for @scanner_bluetoothWebUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth isn\'t available in the browser. Connect over USB instead.'**
  String get scanner_bluetoothWebUnsupported;

  /// No description provided for @device_quickSwitch.
  ///
  /// In en, this message translates to:
  /// **'Quick switch'**
  String get device_quickSwitch;

  /// No description provided for @device_meshcore.
  ///
  /// In en, this message translates to:
  /// **'MeshCore'**
  String get device_meshcore;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_deviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Device Info'**
  String get settings_deviceInfo;

  /// No description provided for @settings_appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get settings_appSettings;

  /// No description provided for @settings_appSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications, messaging, and map preferences'**
  String get settings_appSettingsSubtitle;

  /// No description provided for @settings_nodeSettings.
  ///
  /// In en, this message translates to:
  /// **'Node Settings'**
  String get settings_nodeSettings;

  /// No description provided for @settings_nodeName.
  ///
  /// In en, this message translates to:
  /// **'Node Name'**
  String get settings_nodeName;

  /// No description provided for @settings_nodeNameNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get settings_nodeNameNotSet;

  /// No description provided for @settings_nodeNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter node name'**
  String get settings_nodeNameHint;

  /// No description provided for @settings_nodeNameUpdated.
  ///
  /// In en, this message translates to:
  /// **'Name updated'**
  String get settings_nodeNameUpdated;

  /// No description provided for @settings_radioSettings.
  ///
  /// In en, this message translates to:
  /// **'Radio Settings'**
  String get settings_radioSettings;

  /// No description provided for @settings_radioSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Frequency, power, spreading factor'**
  String get settings_radioSettingsSubtitle;

  /// No description provided for @settings_radioSettingsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Radio settings updated'**
  String get settings_radioSettingsUpdated;

  /// No description provided for @settings_regionSettings.
  ///
  /// In en, this message translates to:
  /// **'Regions'**
  String get settings_regionSettings;

  /// No description provided for @settings_regionSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage stored regions'**
  String get settings_regionSettingsSubtitle;

  /// No description provided for @settings_corridorRegion.
  ///
  /// In en, this message translates to:
  /// **'Corridor region'**
  String get settings_corridorRegion;

  /// No description provided for @settings_corridorRegionDefault.
  ///
  /// In en, this message translates to:
  /// **'#corridor (default)'**
  String get settings_corridorRegionDefault;

  /// No description provided for @settings_corridorRegionHelp.
  ///
  /// In en, this message translates to:
  /// **'Flood corridor packets are tagged with this region. Repeaters without corridor firmware forward them only if they allow this region. Leave empty for the default #corridor tag.'**
  String get settings_corridorRegionHelp;

  /// No description provided for @settings_corridorRegionHint.
  ///
  /// In en, this message translates to:
  /// **'Region name'**
  String get settings_corridorRegionHint;

  /// No description provided for @settings_corridorRegionUseDefault.
  ///
  /// In en, this message translates to:
  /// **'Use default'**
  String get settings_corridorRegionUseDefault;

  /// No description provided for @settings_corridorRegionUpdated.
  ///
  /// In en, this message translates to:
  /// **'Corridor region updated'**
  String get settings_corridorRegionUpdated;

  /// No description provided for @settings_corridorRegionFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update the corridor region'**
  String get settings_corridorRegionFailed;

  /// No description provided for @settings_regionManagement_screenTitle.
  ///
  /// In en, this message translates to:
  /// **'Region Management'**
  String get settings_regionManagement_screenTitle;

  /// No description provided for @settings_regionNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter region name'**
  String get settings_regionNameHint;

  /// No description provided for @settings_regionAddRegion.
  ///
  /// In en, this message translates to:
  /// **'Add region'**
  String get settings_regionAddRegion;

  /// No description provided for @settings_regionFetchRegions.
  ///
  /// In en, this message translates to:
  /// **'Fetch regions from repeaters'**
  String get settings_regionFetchRegions;

  /// No description provided for @settings_regionFetchRegionsFail.
  ///
  /// In en, this message translates to:
  /// **'No regions were found'**
  String get settings_regionFetchRegionsFail;

  /// No description provided for @settings_regionFetchRegionsAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'This region has already been added'**
  String get settings_regionFetchRegionsAlreadyExists;

  /// No description provided for @settings_regionName.
  ///
  /// In en, this message translates to:
  /// **'Region Name'**
  String get settings_regionName;

  /// No description provided for @settings_regionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Region deleted'**
  String get settings_regionDeleted;

  /// No description provided for @settings_deleteRegion.
  ///
  /// In en, this message translates to:
  /// **'Delete Region'**
  String get settings_deleteRegion;

  /// No description provided for @settings_deleteRegionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{region}\" from region list?'**
  String settings_deleteRegionConfirm(String region);

  /// No description provided for @settings_location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get settings_location;

  /// No description provided for @settings_locationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'GPS coordinates'**
  String get settings_locationSubtitle;

  /// No description provided for @settings_locationUpdated.
  ///
  /// In en, this message translates to:
  /// **'Location and GPS settings updated'**
  String get settings_locationUpdated;

  /// No description provided for @settings_locationBothRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter both latitude and longitude.'**
  String get settings_locationBothRequired;

  /// No description provided for @settings_locationInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid latitude or longitude.'**
  String get settings_locationInvalid;

  /// No description provided for @settings_locationGPSEnable.
  ///
  /// In en, this message translates to:
  /// **'GPS Enable'**
  String get settings_locationGPSEnable;

  /// No description provided for @settings_locationGPSEnableSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enables GPS to automatically update location.'**
  String get settings_locationGPSEnableSubtitle;

  /// No description provided for @settings_locationIntervalSec.
  ///
  /// In en, this message translates to:
  /// **'Interval for GPS (Seconds)'**
  String get settings_locationIntervalSec;

  /// No description provided for @settings_locationIntervalInvalid.
  ///
  /// In en, this message translates to:
  /// **'Interval must be at least 60 seconds, and less than 86400 seconds.'**
  String get settings_locationIntervalInvalid;

  /// No description provided for @settings_latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get settings_latitude;

  /// No description provided for @settings_longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get settings_longitude;

  /// No description provided for @settings_contactSettings.
  ///
  /// In en, this message translates to:
  /// **'Contact Settings'**
  String get settings_contactSettings;

  /// No description provided for @settings_contactSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Settings for how contacts are added.'**
  String get settings_contactSettingsSubtitle;

  /// No description provided for @settings_privacyMode.
  ///
  /// In en, this message translates to:
  /// **'Privacy Mode'**
  String get settings_privacyMode;

  /// No description provided for @settings_privacyModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hide name/location in advertisements'**
  String get settings_privacyModeSubtitle;

  /// No description provided for @settings_privacyModeToggle.
  ///
  /// In en, this message translates to:
  /// **'Toggle privacy mode to hide your name and location in advertisements.'**
  String get settings_privacyModeToggle;

  /// No description provided for @settings_privacyModeEnabled.
  ///
  /// In en, this message translates to:
  /// **'Privacy mode enabled'**
  String get settings_privacyModeEnabled;

  /// No description provided for @settings_privacyModeDisabled.
  ///
  /// In en, this message translates to:
  /// **'Privacy mode disabled'**
  String get settings_privacyModeDisabled;

  /// No description provided for @settings_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get settings_privacy;

  /// No description provided for @settings_privacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Control what information is shared.'**
  String get settings_privacySubtitle;

  /// No description provided for @settings_privacySettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose what information your device shares with others.'**
  String get settings_privacySettingsDescription;

  /// No description provided for @settings_denyAll.
  ///
  /// In en, this message translates to:
  /// **'Deny all'**
  String get settings_denyAll;

  /// No description provided for @settings_allowByContact.
  ///
  /// In en, this message translates to:
  /// **'Allow by contact flags'**
  String get settings_allowByContact;

  /// No description provided for @settings_allowAll.
  ///
  /// In en, this message translates to:
  /// **'Allow all'**
  String get settings_allowAll;

  /// No description provided for @settings_telemetryBaseMode.
  ///
  /// In en, this message translates to:
  /// **'Telemetry Base Mode'**
  String get settings_telemetryBaseMode;

  /// No description provided for @settings_telemetryLocationMode.
  ///
  /// In en, this message translates to:
  /// **'Telemetry Location Mode'**
  String get settings_telemetryLocationMode;

  /// No description provided for @settings_telemetryEnvironmentMode.
  ///
  /// In en, this message translates to:
  /// **'Telemetry Environment Mode'**
  String get settings_telemetryEnvironmentMode;

  /// No description provided for @settings_advertLocation.
  ///
  /// In en, this message translates to:
  /// **'Advert Location'**
  String get settings_advertLocation;

  /// No description provided for @settings_advertLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Include location in advert.'**
  String get settings_advertLocationSubtitle;

  /// No description provided for @settings_autoZeroHopAdvertOnGpsUpdate.
  ///
  /// In en, this message translates to:
  /// **'Auto Zero-Hop Advert On GPS Update'**
  String get settings_autoZeroHopAdvertOnGpsUpdate;

  /// No description provided for @settings_autoZeroHopAdvertOnGpsUpdateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'When GPS location changes, send a zero-hop advert (requires Advert Location).'**
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle;

  /// No description provided for @settings_multiAck.
  ///
  /// In en, this message translates to:
  /// **'Multi-ACKs'**
  String get settings_multiAck;

  /// No description provided for @settings_telemetryModeUpdated.
  ///
  /// In en, this message translates to:
  /// **'Telemetry mode updated'**
  String get settings_telemetryModeUpdated;

  /// No description provided for @settings_actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get settings_actions;

  /// No description provided for @settings_deleteAllPaths.
  ///
  /// In en, this message translates to:
  /// **'Delete All Paths'**
  String get settings_deleteAllPaths;

  /// No description provided for @settings_deleteAllPathsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all path data from contacts.'**
  String get settings_deleteAllPathsSubtitle;

  /// No description provided for @settings_sendAdvertisement.
  ///
  /// In en, this message translates to:
  /// **'Send Advertisement'**
  String get settings_sendAdvertisement;

  /// No description provided for @settings_sendAdvertisementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Broadcast presence now'**
  String get settings_sendAdvertisementSubtitle;

  /// No description provided for @settings_advertisementSent.
  ///
  /// In en, this message translates to:
  /// **'Advertisement sent'**
  String get settings_advertisementSent;

  /// No description provided for @settings_syncTime.
  ///
  /// In en, this message translates to:
  /// **'Sync Time'**
  String get settings_syncTime;

  /// No description provided for @settings_syncTimeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set device clock to phone time'**
  String get settings_syncTimeSubtitle;

  /// No description provided for @settings_timeSynchronized.
  ///
  /// In en, this message translates to:
  /// **'Time synchronized'**
  String get settings_timeSynchronized;

  /// No description provided for @settings_refreshContacts.
  ///
  /// In en, this message translates to:
  /// **'Refresh Contacts'**
  String get settings_refreshContacts;

  /// No description provided for @settings_refreshContactsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reload contact list from device'**
  String get settings_refreshContactsSubtitle;

  /// No description provided for @settings_rebootDevice.
  ///
  /// In en, this message translates to:
  /// **'Reboot Device'**
  String get settings_rebootDevice;

  /// No description provided for @settings_rebootDeviceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Restart the MeshCore device'**
  String get settings_rebootDeviceSubtitle;

  /// No description provided for @settings_rebootDeviceConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reboot the device? You will be disconnected.'**
  String get settings_rebootDeviceConfirm;

  /// No description provided for @settings_debug.
  ///
  /// In en, this message translates to:
  /// **'Debug'**
  String get settings_debug;

  /// No description provided for @settings_companionDebugLog.
  ///
  /// In en, this message translates to:
  /// **'Companion Debug Log'**
  String get settings_companionDebugLog;

  /// No description provided for @settings_companionDebugLogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'BLE/TCP/USB commands, responses, and raw data'**
  String get settings_companionDebugLogSubtitle;

  /// No description provided for @settings_appDebugLog.
  ///
  /// In en, this message translates to:
  /// **'App Debug Log'**
  String get settings_appDebugLog;

  /// No description provided for @settings_appDebugLogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Application debug messages'**
  String get settings_appDebugLogSubtitle;

  /// No description provided for @settings_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_about;

  /// No description provided for @settings_aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core v{version}'**
  String settings_aboutVersion(String version);

  /// No description provided for @settings_aboutLegalese.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core • Built with open-source MeshCore Open components'**
  String get settings_aboutLegalese;

  /// No description provided for @settings_aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core is a community-focused MeshCore companion app. It includes and builds on open-source components from MeshCore Open and other credited projects.'**
  String get settings_aboutDescription;

  /// No description provided for @settings_aboutOpenMeteoAttribution.
  ///
  /// In en, this message translates to:
  /// **'LOS elevation data: Open-Meteo (CC BY 4.0)'**
  String get settings_aboutOpenMeteoAttribution;

  /// No description provided for @settings_infoName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get settings_infoName;

  /// No description provided for @settings_infoId.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get settings_infoId;

  /// No description provided for @settings_infoStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get settings_infoStatus;

  /// No description provided for @settings_infoBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get settings_infoBattery;

  /// No description provided for @settings_infoPublicKey.
  ///
  /// In en, this message translates to:
  /// **'Public Key'**
  String get settings_infoPublicKey;

  /// No description provided for @settings_infoContactsCount.
  ///
  /// In en, this message translates to:
  /// **'Contacts Count'**
  String get settings_infoContactsCount;

  /// No description provided for @settings_infoChannelCount.
  ///
  /// In en, this message translates to:
  /// **'Channel Count'**
  String get settings_infoChannelCount;

  /// No description provided for @settings_infoHardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get settings_infoHardware;

  /// No description provided for @settings_infoFirmware.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get settings_infoFirmware;

  /// No description provided for @settings_presets.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get settings_presets;

  /// No description provided for @settings_frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency (MHz)'**
  String get settings_frequency;

  /// No description provided for @settings_frequencyHelper.
  ///
  /// In en, this message translates to:
  /// **'300.0 - 2500.0'**
  String get settings_frequencyHelper;

  /// No description provided for @settings_frequencyInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid frequency (300-2500 MHz)'**
  String get settings_frequencyInvalid;

  /// No description provided for @settings_bandwidth.
  ///
  /// In en, this message translates to:
  /// **'Bandwidth'**
  String get settings_bandwidth;

  /// No description provided for @settings_spreadingFactor.
  ///
  /// In en, this message translates to:
  /// **'Spreading Factor'**
  String get settings_spreadingFactor;

  /// No description provided for @settings_codingRate.
  ///
  /// In en, this message translates to:
  /// **'Coding Rate'**
  String get settings_codingRate;

  /// No description provided for @settings_txPower.
  ///
  /// In en, this message translates to:
  /// **'TX Power (dBm)'**
  String get settings_txPower;

  /// No description provided for @settings_txPowerHelper.
  ///
  /// In en, this message translates to:
  /// **'0 - 22'**
  String get settings_txPowerHelper;

  /// No description provided for @settings_txPowerInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid TX power (0-22 dBm)'**
  String get settings_txPowerInvalid;

  /// No description provided for @settings_clientRepeat.
  ///
  /// In en, this message translates to:
  /// **'Off-Grid Repeat'**
  String get settings_clientRepeat;

  /// No description provided for @settings_clientRepeatSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow this device to repeat mesh packets for others'**
  String get settings_clientRepeatSubtitle;

  /// No description provided for @settings_clientRepeatFreqWarning.
  ///
  /// In en, this message translates to:
  /// **'Off-grid repeat requires 433, 869, or 918 MHz frequency'**
  String get settings_clientRepeatFreqWarning;

  /// No description provided for @settings_error.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String settings_error(String message);

  /// No description provided for @appSettings_title.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings_title;

  /// No description provided for @appSettings_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appSettings_appearance;

  /// No description provided for @appSettings_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get appSettings_theme;

  /// No description provided for @appSettings_themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get appSettings_themeSystem;

  /// No description provided for @appSettings_themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get appSettings_themeLight;

  /// No description provided for @appSettings_themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get appSettings_themeDark;

  /// No description provided for @appSettings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get appSettings_language;

  /// No description provided for @appSettings_languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get appSettings_languageSystem;

  /// No description provided for @appSettings_languageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get appSettings_languageEn;

  /// No description provided for @appSettings_languageFr.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get appSettings_languageFr;

  /// No description provided for @appSettings_languageEs.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get appSettings_languageEs;

  /// No description provided for @appSettings_languageDe.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get appSettings_languageDe;

  /// No description provided for @appSettings_languagePl.
  ///
  /// In en, this message translates to:
  /// **'Polski'**
  String get appSettings_languagePl;

  /// No description provided for @appSettings_languageSl.
  ///
  /// In en, this message translates to:
  /// **'Slovenščina'**
  String get appSettings_languageSl;

  /// No description provided for @appSettings_languagePt.
  ///
  /// In en, this message translates to:
  /// **'Português'**
  String get appSettings_languagePt;

  /// No description provided for @appSettings_languageIt.
  ///
  /// In en, this message translates to:
  /// **'Italiano'**
  String get appSettings_languageIt;

  /// No description provided for @appSettings_languageZh.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get appSettings_languageZh;

  /// No description provided for @appSettings_languageSv.
  ///
  /// In en, this message translates to:
  /// **'Svenska'**
  String get appSettings_languageSv;

  /// No description provided for @appSettings_languageNl.
  ///
  /// In en, this message translates to:
  /// **'Nederlands'**
  String get appSettings_languageNl;

  /// No description provided for @appSettings_languageSk.
  ///
  /// In en, this message translates to:
  /// **'Slovenčina'**
  String get appSettings_languageSk;

  /// No description provided for @appSettings_languageBg.
  ///
  /// In en, this message translates to:
  /// **'Български'**
  String get appSettings_languageBg;

  /// No description provided for @appSettings_languageRu.
  ///
  /// In en, this message translates to:
  /// **'Русский'**
  String get appSettings_languageRu;

  /// No description provided for @appSettings_languageUk.
  ///
  /// In en, this message translates to:
  /// **'Українська'**
  String get appSettings_languageUk;

  /// No description provided for @repeater_pathHashModeOption0.
  ///
  /// In en, this message translates to:
  /// **'0 - 1 byte'**
  String get repeater_pathHashModeOption0;

  /// No description provided for @repeater_pathHashModeOption1.
  ///
  /// In en, this message translates to:
  /// **'1 - 2 bytes'**
  String get repeater_pathHashModeOption1;

  /// No description provided for @repeater_pathHashModeOption2.
  ///
  /// In en, this message translates to:
  /// **'2 - 3 bytes'**
  String get repeater_pathHashModeOption2;

  /// No description provided for @repeater_pathHashModeOption3.
  ///
  /// In en, this message translates to:
  /// **'3 - 4 bytes'**
  String get repeater_pathHashModeOption3;

  /// No description provided for @appSettings_enableMessageTracing.
  ///
  /// In en, this message translates to:
  /// **'Enable Message Tracing'**
  String get appSettings_enableMessageTracing;

  /// No description provided for @appSettings_enableMessageTracingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show detailed routing and timing metadata for messages'**
  String get appSettings_enableMessageTracingSubtitle;

  /// No description provided for @appSettings_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get appSettings_notifications;

  /// No description provided for @appSettings_enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get appSettings_enableNotifications;

  /// No description provided for @appSettings_enableNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive notifications for messages and adverts'**
  String get appSettings_enableNotificationsSubtitle;

  /// No description provided for @appSettings_notificationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission denied'**
  String get appSettings_notificationPermissionDenied;

  /// No description provided for @appSettings_notificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications enabled'**
  String get appSettings_notificationsEnabled;

  /// No description provided for @appSettings_notificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications disabled'**
  String get appSettings_notificationsDisabled;

  /// No description provided for @appSettings_messageNotifications.
  ///
  /// In en, this message translates to:
  /// **'Message Notifications'**
  String get appSettings_messageNotifications;

  /// No description provided for @appSettings_messageNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show notification when receiving new messages'**
  String get appSettings_messageNotificationsSubtitle;

  /// No description provided for @appSettings_channelMessageNotifications.
  ///
  /// In en, this message translates to:
  /// **'Channel Message Notifications'**
  String get appSettings_channelMessageNotifications;

  /// No description provided for @appSettings_channelMessageNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show notification when receiving channel messages'**
  String get appSettings_channelMessageNotificationsSubtitle;

  /// No description provided for @appSettings_advertisementNotifications.
  ///
  /// In en, this message translates to:
  /// **'Advertisement Notifications'**
  String get appSettings_advertisementNotifications;

  /// No description provided for @appSettings_advertisementNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show notification when new nodes are discovered'**
  String get appSettings_advertisementNotificationsSubtitle;

  /// No description provided for @appSettings_messaging.
  ///
  /// In en, this message translates to:
  /// **'Messaging'**
  String get appSettings_messaging;

  /// No description provided for @appSettings_clearPathOnMaxRetry.
  ///
  /// In en, this message translates to:
  /// **'Clear Path on Max Retry'**
  String get appSettings_clearPathOnMaxRetry;

  /// No description provided for @appSettings_clearPathOnMaxRetrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reset contact path after 5 failed send attempts'**
  String get appSettings_clearPathOnMaxRetrySubtitle;

  /// No description provided for @appSettings_pathsWillBeCleared.
  ///
  /// In en, this message translates to:
  /// **'Paths will be cleared after 5 failed retries'**
  String get appSettings_pathsWillBeCleared;

  /// No description provided for @appSettings_pathsWillNotBeCleared.
  ///
  /// In en, this message translates to:
  /// **'Paths will not be auto-cleared'**
  String get appSettings_pathsWillNotBeCleared;

  /// No description provided for @appSettings_autoRouteRotation.
  ///
  /// In en, this message translates to:
  /// **'Auto Route Rotation'**
  String get appSettings_autoRouteRotation;

  /// No description provided for @appSettings_autoRouteRotationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Cycle between best paths and flood mode'**
  String get appSettings_autoRouteRotationSubtitle;

  /// No description provided for @appSettings_autoRouteRotationEnabled.
  ///
  /// In en, this message translates to:
  /// **'Auto route rotation enabled'**
  String get appSettings_autoRouteRotationEnabled;

  /// No description provided for @appSettings_autoRouteRotationDisabled.
  ///
  /// In en, this message translates to:
  /// **'Auto route rotation disabled'**
  String get appSettings_autoRouteRotationDisabled;

  /// No description provided for @appSettings_maxRouteWeight.
  ///
  /// In en, this message translates to:
  /// **'Max Route Weight'**
  String get appSettings_maxRouteWeight;

  /// No description provided for @appSettings_maxRouteWeightSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Maximum weight a path can accumulate from successful deliveries'**
  String get appSettings_maxRouteWeightSubtitle;

  /// No description provided for @appSettings_initialRouteWeight.
  ///
  /// In en, this message translates to:
  /// **'Initial Route Weight'**
  String get appSettings_initialRouteWeight;

  /// No description provided for @appSettings_initialRouteWeightSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Starting weight for newly discovered paths'**
  String get appSettings_initialRouteWeightSubtitle;

  /// No description provided for @appSettings_routeWeightSuccessIncrement.
  ///
  /// In en, this message translates to:
  /// **'Success Weight Increment'**
  String get appSettings_routeWeightSuccessIncrement;

  /// No description provided for @appSettings_routeWeightSuccessIncrementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Weight added to a path after successful delivery'**
  String get appSettings_routeWeightSuccessIncrementSubtitle;

  /// No description provided for @appSettings_routeWeightFailureDecrement.
  ///
  /// In en, this message translates to:
  /// **'Failure Weight Decrement'**
  String get appSettings_routeWeightFailureDecrement;

  /// No description provided for @appSettings_routeWeightFailureDecrementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Weight removed from a path after failed delivery'**
  String get appSettings_routeWeightFailureDecrementSubtitle;

  /// No description provided for @appSettings_maxMessageRetries.
  ///
  /// In en, this message translates to:
  /// **'Max Message Retries'**
  String get appSettings_maxMessageRetries;

  /// No description provided for @appSettings_maxMessageRetriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Number of retry attempts before marking a message as failed'**
  String get appSettings_maxMessageRetriesSubtitle;

  /// No description provided for @appSettings_battery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get appSettings_battery;

  /// No description provided for @appSettings_batteryChemistry.
  ///
  /// In en, this message translates to:
  /// **'Battery Chemistry'**
  String get appSettings_batteryChemistry;

  /// No description provided for @appSettings_batteryChemistryPerDevice.
  ///
  /// In en, this message translates to:
  /// **'Set per device ({deviceName})'**
  String appSettings_batteryChemistryPerDevice(String deviceName);

  /// No description provided for @appSettings_batteryChemistryConnectFirst.
  ///
  /// In en, this message translates to:
  /// **'Connect to a device to choose'**
  String get appSettings_batteryChemistryConnectFirst;

  /// No description provided for @appSettings_batteryNmc.
  ///
  /// In en, this message translates to:
  /// **'18650 NMC (3.0-4.2V)'**
  String get appSettings_batteryNmc;

  /// No description provided for @appSettings_batteryLifepo4.
  ///
  /// In en, this message translates to:
  /// **'LiFePO4 (2.6-3.65V)'**
  String get appSettings_batteryLifepo4;

  /// No description provided for @appSettings_batteryLipo.
  ///
  /// In en, this message translates to:
  /// **'LiPo (3.0-4.2V)'**
  String get appSettings_batteryLipo;

  /// No description provided for @appSettings_batteryLipoHv.
  ///
  /// In en, this message translates to:
  /// **'LiPo HV (3.0-4.35V)'**
  String get appSettings_batteryLipoHv;

  /// No description provided for @appSettings_mapDisplay.
  ///
  /// In en, this message translates to:
  /// **'Map Display'**
  String get appSettings_mapDisplay;

  /// No description provided for @appSettings_showRepeaters.
  ///
  /// In en, this message translates to:
  /// **'Show Repeaters'**
  String get appSettings_showRepeaters;

  /// No description provided for @appSettings_showRepeatersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Display repeater nodes on the map'**
  String get appSettings_showRepeatersSubtitle;

  /// No description provided for @appSettings_showChatNodes.
  ///
  /// In en, this message translates to:
  /// **'Show Chat Nodes'**
  String get appSettings_showChatNodes;

  /// No description provided for @appSettings_showChatNodesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Display chat nodes on the map'**
  String get appSettings_showChatNodesSubtitle;

  /// No description provided for @appSettings_showOtherNodes.
  ///
  /// In en, this message translates to:
  /// **'Show Other Nodes'**
  String get appSettings_showOtherNodes;

  /// No description provided for @appSettings_showOtherNodesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Display other node types on the map'**
  String get appSettings_showOtherNodesSubtitle;

  /// No description provided for @appSettings_timeFilter.
  ///
  /// In en, this message translates to:
  /// **'Time Filter'**
  String get appSettings_timeFilter;

  /// No description provided for @appSettings_timeFilterShowAll.
  ///
  /// In en, this message translates to:
  /// **'Show all nodes'**
  String get appSettings_timeFilterShowAll;

  /// No description provided for @appSettings_timeFilterShowLast.
  ///
  /// In en, this message translates to:
  /// **'Show nodes from last {hours} hours'**
  String appSettings_timeFilterShowLast(int hours);

  /// No description provided for @appSettings_mapTimeFilter.
  ///
  /// In en, this message translates to:
  /// **'Map Time Filter'**
  String get appSettings_mapTimeFilter;

  /// No description provided for @appSettings_showNodesDiscoveredWithin.
  ///
  /// In en, this message translates to:
  /// **'Show nodes discovered within:'**
  String get appSettings_showNodesDiscoveredWithin;

  /// No description provided for @appSettings_allTime.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get appSettings_allTime;

  /// No description provided for @appSettings_lastHour.
  ///
  /// In en, this message translates to:
  /// **'Last hour'**
  String get appSettings_lastHour;

  /// No description provided for @appSettings_last6Hours.
  ///
  /// In en, this message translates to:
  /// **'Last 6 hours'**
  String get appSettings_last6Hours;

  /// No description provided for @appSettings_last24Hours.
  ///
  /// In en, this message translates to:
  /// **'Last 24 hours'**
  String get appSettings_last24Hours;

  /// No description provided for @appSettings_lastWeek.
  ///
  /// In en, this message translates to:
  /// **'Last week'**
  String get appSettings_lastWeek;

  /// No description provided for @appSettings_rasterTileSource.
  ///
  /// In en, this message translates to:
  /// **'Raster Tile Source'**
  String get appSettings_rasterTileSource;

  /// No description provided for @appSettings_stadiaEndpoint.
  ///
  /// In en, this message translates to:
  /// **'Stadia Endpoint'**
  String get appSettings_stadiaEndpoint;

  /// No description provided for @appSettings_stadiaApiKey.
  ///
  /// In en, this message translates to:
  /// **'Stadia API Key'**
  String get appSettings_stadiaApiKey;

  /// No description provided for @appSettings_stadiaApiKeyRequired.
  ///
  /// In en, this message translates to:
  /// **'Required for Stadia Maps usage'**
  String get appSettings_stadiaApiKeyRequired;

  /// No description provided for @appSettings_stadiaApiKeyConfigured.
  ///
  /// In en, this message translates to:
  /// **'Configured: {maskedKey}'**
  String appSettings_stadiaApiKeyConfigured(String maskedKey);

  /// No description provided for @appSettings_stadiaApiKeyDialogDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your Stadia Maps API key. This app uses it for raster tile requests.'**
  String get appSettings_stadiaApiKeyDialogDescription;

  /// No description provided for @appSettings_offlineMapCache.
  ///
  /// In en, this message translates to:
  /// **'Offline Map Cache'**
  String get appSettings_offlineMapCache;

  /// No description provided for @appSettings_unitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get appSettings_unitsTitle;

  /// No description provided for @appSettings_unitsMetric.
  ///
  /// In en, this message translates to:
  /// **'Metric (m / km)'**
  String get appSettings_unitsMetric;

  /// No description provided for @appSettings_unitsImperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial (ft / mi)'**
  String get appSettings_unitsImperial;

  /// No description provided for @appSettings_noAreaSelected.
  ///
  /// In en, this message translates to:
  /// **'No area selected'**
  String get appSettings_noAreaSelected;

  /// No description provided for @appSettings_areaSelectedZoom.
  ///
  /// In en, this message translates to:
  /// **'Area selected (zoom {minZoom}-{maxZoom})'**
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom);

  /// No description provided for @appSettings_debugCard.
  ///
  /// In en, this message translates to:
  /// **'Debug'**
  String get appSettings_debugCard;

  /// No description provided for @appSettings_appDebugLogging.
  ///
  /// In en, this message translates to:
  /// **'App Debug Logging'**
  String get appSettings_appDebugLogging;

  /// No description provided for @appSettings_appDebugLoggingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log app debug messages for troubleshooting'**
  String get appSettings_appDebugLoggingSubtitle;

  /// No description provided for @appSettings_appDebugLoggingEnabled.
  ///
  /// In en, this message translates to:
  /// **'App debug logging enabled'**
  String get appSettings_appDebugLoggingEnabled;

  /// No description provided for @appSettings_appDebugLoggingDisabled.
  ///
  /// In en, this message translates to:
  /// **'App debug logging disabled'**
  String get appSettings_appDebugLoggingDisabled;

  /// No description provided for @contacts_title.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get contacts_title;

  /// No description provided for @contacts_noContacts.
  ///
  /// In en, this message translates to:
  /// **'No contacts yet'**
  String get contacts_noContacts;

  /// No description provided for @contacts_contactsWillAppear.
  ///
  /// In en, this message translates to:
  /// **'Contacts will appear when devices advertise'**
  String get contacts_contactsWillAppear;

  /// No description provided for @contacts_unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get contacts_unread;

  /// No description provided for @contacts_searchContactsNoNumber.
  ///
  /// In en, this message translates to:
  /// **'Search Contacts...'**
  String get contacts_searchContactsNoNumber;

  /// No description provided for @contacts_searchContacts.
  ///
  /// In en, this message translates to:
  /// **'Search {number}{str} Contacts...'**
  String contacts_searchContacts(int number, String str);

  /// No description provided for @contacts_searchFavorites.
  ///
  /// In en, this message translates to:
  /// **'Search {number}{str} Favorites...'**
  String contacts_searchFavorites(int number, String str);

  /// No description provided for @contacts_searchUsers.
  ///
  /// In en, this message translates to:
  /// **'Search {number}{str} Users...'**
  String contacts_searchUsers(int number, String str);

  /// No description provided for @contacts_searchRepeaters.
  ///
  /// In en, this message translates to:
  /// **'Search {number}{str} Repeaters...'**
  String contacts_searchRepeaters(int number, String str);

  /// No description provided for @contacts_searchRoomServers.
  ///
  /// In en, this message translates to:
  /// **'Search {number}{str} Room servers...'**
  String contacts_searchRoomServers(int number, String str);

  /// No description provided for @contacts_noUnreadContacts.
  ///
  /// In en, this message translates to:
  /// **'No unread contacts'**
  String get contacts_noUnreadContacts;

  /// No description provided for @contacts_noContactsFound.
  ///
  /// In en, this message translates to:
  /// **'No contacts or groups found'**
  String get contacts_noContactsFound;

  /// No description provided for @contacts_deleteContact.
  ///
  /// In en, this message translates to:
  /// **'Delete Contact'**
  String get contacts_deleteContact;

  /// No description provided for @contacts_removeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove {contactName} from contacts?'**
  String contacts_removeConfirm(String contactName);

  /// No description provided for @contacts_manageRepeater.
  ///
  /// In en, this message translates to:
  /// **'Manage Repeater'**
  String get contacts_manageRepeater;

  /// No description provided for @contacts_manageRoom.
  ///
  /// In en, this message translates to:
  /// **'Manage Room Server'**
  String get contacts_manageRoom;

  /// No description provided for @contacts_roomLogin.
  ///
  /// In en, this message translates to:
  /// **'Room Server Login'**
  String get contacts_roomLogin;

  /// No description provided for @contacts_openChat.
  ///
  /// In en, this message translates to:
  /// **'Open Chat'**
  String get contacts_openChat;

  /// No description provided for @contacts_editGroup.
  ///
  /// In en, this message translates to:
  /// **'Edit Group'**
  String get contacts_editGroup;

  /// No description provided for @contacts_deleteGroup.
  ///
  /// In en, this message translates to:
  /// **'Delete Group'**
  String get contacts_deleteGroup;

  /// No description provided for @contacts_deleteGroupConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{groupName}\"?'**
  String contacts_deleteGroupConfirm(String groupName);

  /// No description provided for @contacts_newGroup.
  ///
  /// In en, this message translates to:
  /// **'New Group'**
  String get contacts_newGroup;

  /// No description provided for @contacts_moreOptions.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get contacts_moreOptions;

  /// No description provided for @contacts_searchOpen.
  ///
  /// In en, this message translates to:
  /// **'Search contacts'**
  String get contacts_searchOpen;

  /// No description provided for @contacts_searchClose.
  ///
  /// In en, this message translates to:
  /// **'Close search'**
  String get contacts_searchClose;

  /// No description provided for @contacts_groupName.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get contacts_groupName;

  /// No description provided for @contacts_groupNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Group name is required'**
  String get contacts_groupNameRequired;

  /// No description provided for @contacts_groupNameReserved.
  ///
  /// In en, this message translates to:
  /// **'This group name is reserved'**
  String get contacts_groupNameReserved;

  /// No description provided for @contacts_groupAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Group \"{name}\" already exists'**
  String contacts_groupAlreadyExists(String name);

  /// No description provided for @contacts_filterContacts.
  ///
  /// In en, this message translates to:
  /// **'Filter contacts...'**
  String get contacts_filterContacts;

  /// No description provided for @contacts_noContactsMatchFilter.
  ///
  /// In en, this message translates to:
  /// **'No contacts match your filter'**
  String get contacts_noContactsMatchFilter;

  /// No description provided for @contacts_noMembers.
  ///
  /// In en, this message translates to:
  /// **'No members'**
  String get contacts_noMembers;

  /// No description provided for @contacts_lastSeenNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get contacts_lastSeenNow;

  /// No description provided for @contacts_lastSeenMinsAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min ago'**
  String contacts_lastSeenMinsAgo(int minutes);

  /// No description provided for @contacts_lastSeenHourAgo.
  ///
  /// In en, this message translates to:
  /// **'1 hour ago'**
  String get contacts_lastSeenHourAgo;

  /// No description provided for @contacts_lastSeenHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours ago'**
  String contacts_lastSeenHoursAgo(int hours);

  /// No description provided for @contacts_lastSeenDayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get contacts_lastSeenDayAgo;

  /// No description provided for @contacts_lastSeenDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String contacts_lastSeenDaysAgo(int days);

  /// No description provided for @contact_info.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get contact_info;

  /// No description provided for @contact_settings.
  ///
  /// In en, this message translates to:
  /// **'Contact Settings'**
  String get contact_settings;

  /// No description provided for @contact_telemetry.
  ///
  /// In en, this message translates to:
  /// **'Telemetry'**
  String get contact_telemetry;

  /// No description provided for @contact_lastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last seen'**
  String get contact_lastSeen;

  /// No description provided for @contact_clearChat.
  ///
  /// In en, this message translates to:
  /// **'Clear Chat'**
  String get contact_clearChat;

  /// No description provided for @contact_teleBase.
  ///
  /// In en, this message translates to:
  /// **'Telemetry Base'**
  String get contact_teleBase;

  /// No description provided for @contact_teleBaseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow sharing battery level and basic telemetry'**
  String get contact_teleBaseSubtitle;

  /// No description provided for @contact_teleLoc.
  ///
  /// In en, this message translates to:
  /// **'Telemetry Location'**
  String get contact_teleLoc;

  /// No description provided for @contact_teleLocSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow sharing location data'**
  String get contact_teleLocSubtitle;

  /// No description provided for @contact_teleEnv.
  ///
  /// In en, this message translates to:
  /// **'Telemetry Environment'**
  String get contact_teleEnv;

  /// No description provided for @contact_teleEnvSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow sharing environment sensor data'**
  String get contact_teleEnvSubtitle;

  /// No description provided for @channels_title.
  ///
  /// In en, this message translates to:
  /// **'Chats & Channels'**
  String get channels_title;

  /// No description provided for @channels_noChannelsConfigured.
  ///
  /// In en, this message translates to:
  /// **'No channels configured'**
  String get channels_noChannelsConfigured;

  /// No description provided for @channels_addPublicChannel.
  ///
  /// In en, this message translates to:
  /// **'Add Public Channel'**
  String get channels_addPublicChannel;

  /// No description provided for @channels_searchChannels.
  ///
  /// In en, this message translates to:
  /// **'Search channels...'**
  String get channels_searchChannels;

  /// No description provided for @channels_noChannelsFound.
  ///
  /// In en, this message translates to:
  /// **'No channels found'**
  String get channels_noChannelsFound;

  /// No description provided for @channels_channelIndex.
  ///
  /// In en, this message translates to:
  /// **'Channel {index}'**
  String channels_channelIndex(int index);

  /// No description provided for @channels_public.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get channels_public;

  /// No description provided for @channels_via.
  ///
  /// In en, this message translates to:
  /// **'via {path}'**
  String channels_via(String path);

  /// Small label on a channel message that reached the app only over MQTT, not over the user's radio.
  ///
  /// In en, this message translates to:
  /// **'via MQTT'**
  String get channels_viaMqtt;

  /// Screen reader label for the via MQTT marker on a channel message.
  ///
  /// In en, this message translates to:
  /// **'Received via MQTT, not heard by your radio'**
  String get channels_viaMqttSemantics;

  /// No description provided for @channels_private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get channels_private;

  /// No description provided for @channels_editChannel.
  ///
  /// In en, this message translates to:
  /// **'Edit channel'**
  String get channels_editChannel;

  /// No description provided for @channels_muteChannel.
  ///
  /// In en, this message translates to:
  /// **'Mute channel'**
  String get channels_muteChannel;

  /// No description provided for @channels_unmuteChannel.
  ///
  /// In en, this message translates to:
  /// **'Unmute channel'**
  String get channels_unmuteChannel;

  /// No description provided for @channels_deleteChannel.
  ///
  /// In en, this message translates to:
  /// **'Delete channel'**
  String get channels_deleteChannel;

  /// No description provided for @channels_deleteChannelConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"? This cannot be undone.'**
  String channels_deleteChannelConfirm(String name);

  /// No description provided for @channels_channelDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete channel \"{name}\"'**
  String channels_channelDeleteFailed(String name);

  /// No description provided for @channels_channelDeleted.
  ///
  /// In en, this message translates to:
  /// **'Channel \"{name}\" deleted'**
  String channels_channelDeleted(String name);

  /// No description provided for @channels_addChannel.
  ///
  /// In en, this message translates to:
  /// **'Add Channel'**
  String get channels_addChannel;

  /// No description provided for @channels_channelIndexLabel.
  ///
  /// In en, this message translates to:
  /// **'Channel Index'**
  String get channels_channelIndexLabel;

  /// No description provided for @channels_channelName.
  ///
  /// In en, this message translates to:
  /// **'Channel Name'**
  String get channels_channelName;

  /// No description provided for @channels_usePublicChannel.
  ///
  /// In en, this message translates to:
  /// **'Use Public Channel'**
  String get channels_usePublicChannel;

  /// No description provided for @channels_standardPublicPsk.
  ///
  /// In en, this message translates to:
  /// **'Standard public PSK'**
  String get channels_standardPublicPsk;

  /// No description provided for @channels_pskHex.
  ///
  /// In en, this message translates to:
  /// **'PSK (Hex)'**
  String get channels_pskHex;

  /// No description provided for @channels_generateRandomPsk.
  ///
  /// In en, this message translates to:
  /// **'Generate random PSK'**
  String get channels_generateRandomPsk;

  /// No description provided for @channels_enterChannelName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a channel name'**
  String get channels_enterChannelName;

  /// No description provided for @channels_pskMustBe32Hex.
  ///
  /// In en, this message translates to:
  /// **'PSK must be 32 hex characters'**
  String get channels_pskMustBe32Hex;

  /// No description provided for @channels_channelAdded.
  ///
  /// In en, this message translates to:
  /// **'Channel \"{name}\" added'**
  String channels_channelAdded(String name);

  /// No description provided for @channels_editChannelTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Channel {index}'**
  String channels_editChannelTitle(int index);

  /// No description provided for @channels_smazCompression.
  ///
  /// In en, this message translates to:
  /// **'SMAZ compression'**
  String get channels_smazCompression;

  /// No description provided for @channels_cyr2latCompression.
  ///
  /// In en, this message translates to:
  /// **'Cyr2Lat compression'**
  String get channels_cyr2latCompression;

  /// No description provided for @channels_cyr2latCompressionDscr.
  ///
  /// In en, this message translates to:
  /// **'Replaces some Cyrillic characters with Latin characters when sending.'**
  String get channels_cyr2latCompressionDscr;

  /// No description provided for @channels_cyr2latSettingsHeading.
  ///
  /// In en, this message translates to:
  /// **'Cyr2Lat Setup'**
  String get channels_cyr2latSettingsHeading;

  /// No description provided for @channels_cyr2latSettingsSubheading.
  ///
  /// In en, this message translates to:
  /// **'List of replacements'**
  String get channels_cyr2latSettingsSubheading;

  /// No description provided for @channels_cyr2latSettingsDscr.
  ///
  /// In en, this message translates to:
  /// **'Edit the JSON configuration of character replacement'**
  String get channels_cyr2latSettingsDscr;

  /// No description provided for @channels_cyr2latSettingsDialogHint.
  ///
  /// In en, this message translates to:
  /// **'JSON replacement map'**
  String get channels_cyr2latSettingsDialogHint;

  /// No description provided for @channels_cyr2latSettingsDialogWrongJSON.
  ///
  /// In en, this message translates to:
  /// **'Invalid JSON: {error}'**
  String channels_cyr2latSettingsDialogWrongJSON(Object error);

  /// No description provided for @channels_channelUpdated.
  ///
  /// In en, this message translates to:
  /// **'Channel \"{name}\" updated'**
  String channels_channelUpdated(String name);

  /// No description provided for @settings_cyr2latProfileAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Cyr2Lat Profile'**
  String get settings_cyr2latProfileAdd;

  /// No description provided for @settings_cyr2latProfileName.
  ///
  /// In en, this message translates to:
  /// **'Profile Name'**
  String get settings_cyr2latProfileName;

  /// No description provided for @settings_cyr2latProfileNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Profile name cannot be empty'**
  String get settings_cyr2latProfileNameEmpty;

  /// No description provided for @settings_cyr2latProfileAdded.
  ///
  /// In en, this message translates to:
  /// **'Profile added successfully'**
  String get settings_cyr2latProfileAdded;

  /// No description provided for @settings_cyr2latProfileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get settings_cyr2latProfileUpdated;

  /// No description provided for @settings_cyr2latProfileEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Cyr2Lat Profile'**
  String get settings_cyr2latProfileEdit;

  /// No description provided for @settings_cyr2latProfileDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete Cyr2Lat Profile'**
  String get settings_cyr2latProfileDelete;

  /// No description provided for @settings_cyr2latProfileDeleted.
  ///
  /// In en, this message translates to:
  /// **'Profile deleted successfully'**
  String get settings_cyr2latProfileDeleted;

  /// No description provided for @settings_cyr2latProfileDeleteDscr.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the profile \"{name}\"?'**
  String settings_cyr2latProfileDeleteDscr(String name);

  /// No description provided for @channels_publicChannelAdded.
  ///
  /// In en, this message translates to:
  /// **'Public channel added'**
  String get channels_publicChannelAdded;

  /// No description provided for @channels_sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get channels_sortBy;

  /// No description provided for @channels_sortManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get channels_sortManual;

  /// No description provided for @channels_sortAZ.
  ///
  /// In en, this message translates to:
  /// **'A-Z'**
  String get channels_sortAZ;

  /// No description provided for @channels_sortLatestMessages.
  ///
  /// In en, this message translates to:
  /// **'Latest messages'**
  String get channels_sortLatestMessages;

  /// No description provided for @channels_sortUnread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get channels_sortUnread;

  /// No description provided for @channels_createPrivateChannel.
  ///
  /// In en, this message translates to:
  /// **'Create a Private Channel'**
  String get channels_createPrivateChannel;

  /// No description provided for @channels_createPrivateChannelDesc.
  ///
  /// In en, this message translates to:
  /// **'Secured with a secret key.'**
  String get channels_createPrivateChannelDesc;

  /// No description provided for @channels_joinPrivateChannel.
  ///
  /// In en, this message translates to:
  /// **'Join a Private Channel'**
  String get channels_joinPrivateChannel;

  /// No description provided for @channels_joinPrivateChannelDesc.
  ///
  /// In en, this message translates to:
  /// **'Manually enter a secret key.'**
  String get channels_joinPrivateChannelDesc;

  /// No description provided for @channels_joinPublicChannel.
  ///
  /// In en, this message translates to:
  /// **'Join the Public Channel'**
  String get channels_joinPublicChannel;

  /// No description provided for @channels_joinPublicChannelDesc.
  ///
  /// In en, this message translates to:
  /// **'Anyone can join this channel.'**
  String get channels_joinPublicChannelDesc;

  /// No description provided for @channels_joinHashtagChannel.
  ///
  /// In en, this message translates to:
  /// **'Join a Hashtag Channel'**
  String get channels_joinHashtagChannel;

  /// No description provided for @channels_joinHashtagChannelDesc.
  ///
  /// In en, this message translates to:
  /// **'Anyone can join hashtag channels.'**
  String get channels_joinHashtagChannelDesc;

  /// No description provided for @channels_scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan a QR Code'**
  String get channels_scanQrCode;

  /// No description provided for @channels_scanQrCodeComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get channels_scanQrCodeComingSoon;

  /// No description provided for @channels_enterHashtag.
  ///
  /// In en, this message translates to:
  /// **'Enter hashtag'**
  String get channels_enterHashtag;

  /// No description provided for @channels_hashtagHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. #team'**
  String get channels_hashtagHint;

  /// No description provided for @channels_regionSetTo.
  ///
  /// In en, this message translates to:
  /// **'Region: {region}'**
  String channels_regionSetTo(String region);

  /// No description provided for @channels_regionNotSet.
  ///
  /// In en, this message translates to:
  /// **'Region: none'**
  String get channels_regionNotSet;

  /// No description provided for @channels_regionSelect_Title.
  ///
  /// In en, this message translates to:
  /// **'Select a region'**
  String get channels_regionSelect_Title;

  /// No description provided for @channels_clearRegion.
  ///
  /// In en, this message translates to:
  /// **'Clear region'**
  String get channels_clearRegion;

  /// No description provided for @chat_noMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get chat_noMessages;

  /// No description provided for @chat_sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get chat_sendMessage;

  /// No description provided for @chat_sendMessageTo.
  ///
  /// In en, this message translates to:
  /// **'Send a message to {contactName}'**
  String chat_sendMessageTo(String contactName);

  /// No description provided for @chat_sendMessageToStart.
  ///
  /// In en, this message translates to:
  /// **'Send a message to get started'**
  String get chat_sendMessageToStart;

  /// No description provided for @chat_originalMessageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Original message not found'**
  String get chat_originalMessageNotFound;

  /// No description provided for @chat_replyingTo.
  ///
  /// In en, this message translates to:
  /// **'Replying to {name}'**
  String chat_replyingTo(String name);

  /// No description provided for @chat_replyTo.
  ///
  /// In en, this message translates to:
  /// **'Reply to {name}'**
  String chat_replyTo(String name);

  /// No description provided for @chat_location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get chat_location;

  /// No description provided for @chat_typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get chat_typeMessage;

  /// No description provided for @chat_messageTooLong.
  ///
  /// In en, this message translates to:
  /// **'Message too long (max {maxBytes} bytes).'**
  String chat_messageTooLong(int maxBytes);

  /// No description provided for @chat_messageCopied.
  ///
  /// In en, this message translates to:
  /// **'Message copied'**
  String get chat_messageCopied;

  /// No description provided for @chat_messageDeleted.
  ///
  /// In en, this message translates to:
  /// **'Message deleted'**
  String get chat_messageDeleted;

  /// No description provided for @chat_retryingMessage.
  ///
  /// In en, this message translates to:
  /// **'Retrying message'**
  String get chat_retryingMessage;

  /// No description provided for @chat_retryCount.
  ///
  /// In en, this message translates to:
  /// **'Retry {current}/{max}'**
  String chat_retryCount(int current, int max);

  /// No description provided for @chat_selectSendAction.
  ///
  /// In en, this message translates to:
  /// **'Select send action'**
  String get chat_selectSendAction;

  /// No description provided for @chat_sendGif.
  ///
  /// In en, this message translates to:
  /// **'Send GIF'**
  String get chat_sendGif;

  /// No description provided for @chat_limitToArea.
  ///
  /// In en, this message translates to:
  /// **'Limit to an area'**
  String get chat_limitToArea;

  /// No description provided for @chat_limitToAreaTitle.
  ///
  /// In en, this message translates to:
  /// **'Only send within…'**
  String get chat_limitToAreaTitle;

  /// No description provided for @chat_limitToAreaHelp.
  ///
  /// In en, this message translates to:
  /// **'Repeaters with flood corridor firmware only relay the message inside this area. Other repeaters drop it unless they allow your corridor region.'**
  String get chat_limitToAreaHelp;

  /// No description provided for @chat_limitToAreaRadius.
  ///
  /// In en, this message translates to:
  /// **'{km} km of you'**
  String chat_limitToAreaRadius(int km);

  /// No description provided for @chat_limitToAreaActive.
  ///
  /// In en, this message translates to:
  /// **'Only within {km} km of you'**
  String chat_limitToAreaActive(int km);

  /// No description provided for @chat_limitToAreaOff.
  ///
  /// In en, this message translates to:
  /// **'No limit'**
  String get chat_limitToAreaOff;

  /// No description provided for @chat_limitToAreaNeedsPosition.
  ///
  /// In en, this message translates to:
  /// **'Set your radio\'s position to limit messages to an area.'**
  String get chat_limitToAreaNeedsPosition;

  /// No description provided for @chat_sendImageLora.
  ///
  /// In en, this message translates to:
  /// **'Send image via meshcore'**
  String get chat_sendImageLora;

  /// Shown when picking or reading a photo to send fails
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open that image'**
  String get chat_imagePickFailed;

  /// No description provided for @chat_receivedGif.
  ///
  /// In en, this message translates to:
  /// **'Received a GIF'**
  String get chat_receivedGif;

  /// No description provided for @chat_reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get chat_reply;

  /// No description provided for @chat_addReaction.
  ///
  /// In en, this message translates to:
  /// **'Add Reaction'**
  String get chat_addReaction;

  /// No description provided for @chat_me.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get chat_me;

  /// No description provided for @reaction_report.
  ///
  /// In en, this message translates to:
  /// **'Emoji Reactions'**
  String get reaction_report;

  /// No description provided for @emojiCategorySmileys.
  ///
  /// In en, this message translates to:
  /// **'Smileys'**
  String get emojiCategorySmileys;

  /// No description provided for @emojiCategoryGestures.
  ///
  /// In en, this message translates to:
  /// **'Gestures'**
  String get emojiCategoryGestures;

  /// No description provided for @emojiCategoryHearts.
  ///
  /// In en, this message translates to:
  /// **'Hearts'**
  String get emojiCategoryHearts;

  /// No description provided for @emojiCategoryObjects.
  ///
  /// In en, this message translates to:
  /// **'Objects'**
  String get emojiCategoryObjects;

  /// No description provided for @gifPicker_title.
  ///
  /// In en, this message translates to:
  /// **'Choose a GIF'**
  String get gifPicker_title;

  /// No description provided for @gifPicker_searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search GIFs...'**
  String get gifPicker_searchHint;

  /// No description provided for @gifPicker_poweredBy.
  ///
  /// In en, this message translates to:
  /// **'Powered by GIPHY'**
  String get gifPicker_poweredBy;

  /// No description provided for @gifPicker_noGifsFound.
  ///
  /// In en, this message translates to:
  /// **'No GIFs found'**
  String get gifPicker_noGifsFound;

  /// No description provided for @gifPicker_failedLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load GIFs'**
  String get gifPicker_failedLoad;

  /// No description provided for @gifPicker_failedSearch.
  ///
  /// In en, this message translates to:
  /// **'Failed to search GIFs'**
  String get gifPicker_failedSearch;

  /// No description provided for @gifPicker_noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get gifPicker_noInternet;

  /// No description provided for @debugLog_appTitle.
  ///
  /// In en, this message translates to:
  /// **'App Debug Log'**
  String get debugLog_appTitle;

  /// No description provided for @debugLog_bleTitle.
  ///
  /// In en, this message translates to:
  /// **'BLE Debug Log'**
  String get debugLog_bleTitle;

  /// No description provided for @debugLog_copyLog.
  ///
  /// In en, this message translates to:
  /// **'Copy log'**
  String get debugLog_copyLog;

  /// No description provided for @debugLog_clearLog.
  ///
  /// In en, this message translates to:
  /// **'Clear log'**
  String get debugLog_clearLog;

  /// No description provided for @debugLog_copied.
  ///
  /// In en, this message translates to:
  /// **'Debug log copied'**
  String get debugLog_copied;

  /// No description provided for @debugLog_bleCopied.
  ///
  /// In en, this message translates to:
  /// **'BLE log copied'**
  String get debugLog_bleCopied;

  /// No description provided for @debugLog_noEntries.
  ///
  /// In en, this message translates to:
  /// **'No debug logs yet'**
  String get debugLog_noEntries;

  /// No description provided for @debugLog_enableInSettings.
  ///
  /// In en, this message translates to:
  /// **'Enable app debug logging in settings'**
  String get debugLog_enableInSettings;

  /// No description provided for @debugLog_frames.
  ///
  /// In en, this message translates to:
  /// **'Frames'**
  String get debugLog_frames;

  /// No description provided for @debugLog_rawLogRx.
  ///
  /// In en, this message translates to:
  /// **'Raw Log-RX'**
  String get debugLog_rawLogRx;

  /// No description provided for @debugLog_noBleActivity.
  ///
  /// In en, this message translates to:
  /// **'No BLE activity yet'**
  String get debugLog_noBleActivity;

  /// No description provided for @debugFrame_length.
  ///
  /// In en, this message translates to:
  /// **'Frame Length: {count} bytes'**
  String debugFrame_length(int count);

  /// No description provided for @debugFrame_command.
  ///
  /// In en, this message translates to:
  /// **'Command: 0x{value}'**
  String debugFrame_command(String value);

  /// No description provided for @debugFrame_textMessageHeader.
  ///
  /// In en, this message translates to:
  /// **'Text Message Frame:'**
  String get debugFrame_textMessageHeader;

  /// No description provided for @debugFrame_destinationPubKey.
  ///
  /// In en, this message translates to:
  /// **'- Destination PubKey: {pubKey}'**
  String debugFrame_destinationPubKey(String pubKey);

  /// No description provided for @debugFrame_timestamp.
  ///
  /// In en, this message translates to:
  /// **'- Timestamp: {timestamp}'**
  String debugFrame_timestamp(int timestamp);

  /// No description provided for @debugFrame_flags.
  ///
  /// In en, this message translates to:
  /// **'- Flags: 0x{value}'**
  String debugFrame_flags(String value);

  /// No description provided for @debugFrame_textType.
  ///
  /// In en, this message translates to:
  /// **'- Text Type: {type} ({label})'**
  String debugFrame_textType(int type, String label);

  /// No description provided for @debugFrame_textTypeCli.
  ///
  /// In en, this message translates to:
  /// **'CLI'**
  String get debugFrame_textTypeCli;

  /// No description provided for @debugFrame_textTypePlain.
  ///
  /// In en, this message translates to:
  /// **'Plain'**
  String get debugFrame_textTypePlain;

  /// No description provided for @debugFrame_text.
  ///
  /// In en, this message translates to:
  /// **'- Text: \"{text}\"'**
  String debugFrame_text(String text);

  /// No description provided for @debugFrame_hexDump.
  ///
  /// In en, this message translates to:
  /// **'Hex Dump:'**
  String get debugFrame_hexDump;

  /// No description provided for @chat_hopsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1{hop} other{hops}}'**
  String chat_hopsCount(int count);

  /// No description provided for @chat_removePath.
  ///
  /// In en, this message translates to:
  /// **'Remove path'**
  String get chat_removePath;

  /// No description provided for @chat_noPathHistoryYet.
  ///
  /// In en, this message translates to:
  /// **'No path history yet.\nSend a message to discover paths.'**
  String get chat_noPathHistoryYet;

  /// No description provided for @chat_pathCleared.
  ///
  /// In en, this message translates to:
  /// **'Path cleared. Next message will rediscover route.'**
  String get chat_pathCleared;

  /// No description provided for @chat_fullPath.
  ///
  /// In en, this message translates to:
  /// **'Full Path'**
  String get chat_fullPath;

  /// No description provided for @routing_title.
  ///
  /// In en, this message translates to:
  /// **'Routing'**
  String get routing_title;

  /// No description provided for @routing_modeAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get routing_modeAuto;

  /// No description provided for @routing_modeFlood.
  ///
  /// In en, this message translates to:
  /// **'Flood'**
  String get routing_modeFlood;

  /// No description provided for @routing_modeManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get routing_modeManual;

  /// No description provided for @routing_modeAutoHint.
  ///
  /// In en, this message translates to:
  /// **'Picks the best known path automatically, flooding when none is known.'**
  String get routing_modeAutoHint;

  /// No description provided for @routing_modeFloodHint.
  ///
  /// In en, this message translates to:
  /// **'Broadcasts through every repeater. Most reliable, but uses more airtime.'**
  String get routing_modeFloodHint;

  /// No description provided for @routing_modeManualHint.
  ///
  /// In en, this message translates to:
  /// **'Always sends along the exact path you set.'**
  String get routing_modeManualHint;

  /// No description provided for @routing_currentRoute.
  ///
  /// In en, this message translates to:
  /// **'Current route'**
  String get routing_currentRoute;

  /// No description provided for @routing_directNoHops.
  ///
  /// In en, this message translates to:
  /// **'Direct — no repeater hops'**
  String get routing_directNoHops;

  /// No description provided for @routing_noPathYet.
  ///
  /// In en, this message translates to:
  /// **'No path yet. The next message floods until a route is discovered.'**
  String get routing_noPathYet;

  /// No description provided for @routing_floodBroadcast.
  ///
  /// In en, this message translates to:
  /// **'Broadcast through every repeater'**
  String get routing_floodBroadcast;

  /// No description provided for @routing_editPath.
  ///
  /// In en, this message translates to:
  /// **'Edit path'**
  String get routing_editPath;

  /// No description provided for @routing_forgetPath.
  ///
  /// In en, this message translates to:
  /// **'Forget path'**
  String get routing_forgetPath;

  /// No description provided for @routing_knownPaths.
  ///
  /// In en, this message translates to:
  /// **'Known paths'**
  String get routing_knownPaths;

  /// No description provided for @routing_knownPathsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a path to switch to it.'**
  String get routing_knownPathsHint;

  /// No description provided for @routing_inUse.
  ///
  /// In en, this message translates to:
  /// **'In use'**
  String get routing_inUse;

  /// No description provided for @routing_qualityStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong first hop'**
  String get routing_qualityStrong;

  /// No description provided for @routing_qualityGood.
  ///
  /// In en, this message translates to:
  /// **'Good first hop'**
  String get routing_qualityGood;

  /// No description provided for @routing_qualityFair.
  ///
  /// In en, this message translates to:
  /// **'Fair first hop'**
  String get routing_qualityFair;

  /// No description provided for @routing_qualityWorked.
  ///
  /// In en, this message translates to:
  /// **'Has delivered'**
  String get routing_qualityWorked;

  /// No description provided for @routing_qualityFlood.
  ///
  /// In en, this message translates to:
  /// **'Heard via flood'**
  String get routing_qualityFlood;

  /// No description provided for @routing_qualityUntested.
  ///
  /// In en, this message translates to:
  /// **'Untested'**
  String get routing_qualityUntested;

  /// No description provided for @routing_lastWorked.
  ///
  /// In en, this message translates to:
  /// **'worked {when}'**
  String routing_lastWorked(String when);

  /// No description provided for @routing_neverWorked.
  ///
  /// In en, this message translates to:
  /// **'never confirmed'**
  String get routing_neverWorked;

  /// No description provided for @routing_deliveryCounts.
  ///
  /// In en, this message translates to:
  /// **'{successes} delivered, {failures} failed'**
  String routing_deliveryCounts(int successes, int failures);

  /// No description provided for @routing_floodDelivery.
  ///
  /// In en, this message translates to:
  /// **'Flood delivery'**
  String get routing_floodDelivery;

  /// No description provided for @pathEditor_title.
  ///
  /// In en, this message translates to:
  /// **'Build Path'**
  String get pathEditor_title;

  /// No description provided for @pathEditor_hopCounter.
  ///
  /// In en, this message translates to:
  /// **'{count} of 64 hops'**
  String pathEditor_hopCounter(int count);

  /// No description provided for @pathEditor_noHops.
  ///
  /// In en, this message translates to:
  /// **'No hops yet. Tap repeaters below to add them in order, or save with no hops to send direct.'**
  String get pathEditor_noHops;

  /// No description provided for @pathEditor_addHops.
  ///
  /// In en, this message translates to:
  /// **'Add hops in order'**
  String get pathEditor_addHops;

  /// No description provided for @pathEditor_searchRepeaters.
  ///
  /// In en, this message translates to:
  /// **'Search repeaters'**
  String get pathEditor_searchRepeaters;

  /// No description provided for @pathEditor_advancedHex.
  ///
  /// In en, this message translates to:
  /// **'Advanced: raw hex path'**
  String get pathEditor_advancedHex;

  /// No description provided for @pathEditor_hexLabel.
  ///
  /// In en, this message translates to:
  /// **'Hex prefixes'**
  String get pathEditor_hexLabel;

  /// No description provided for @pathEditor_hexHelper.
  ///
  /// In en, this message translates to:
  /// **'Two hex characters per hop, separated by commas'**
  String get pathEditor_hexHelper;

  /// No description provided for @pathEditor_invalidTokens.
  ///
  /// In en, this message translates to:
  /// **'Invalid: {tokens}'**
  String pathEditor_invalidTokens(String tokens);

  /// No description provided for @pathEditor_tooManyHops.
  ///
  /// In en, this message translates to:
  /// **'Maximum 64 hops'**
  String get pathEditor_tooManyHops;

  /// No description provided for @pathEditor_usePath.
  ///
  /// In en, this message translates to:
  /// **'Use this path'**
  String get pathEditor_usePath;

  /// No description provided for @pathEditor_removeHop.
  ///
  /// In en, this message translates to:
  /// **'Remove hop'**
  String get pathEditor_removeHop;

  /// No description provided for @pathEditor_unknownHop.
  ///
  /// In en, this message translates to:
  /// **'Unknown repeater'**
  String get pathEditor_unknownHop;

  /// No description provided for @chat_pathSavedLocally.
  ///
  /// In en, this message translates to:
  /// **'Saved locally. Connect to sync.'**
  String get chat_pathSavedLocally;

  /// No description provided for @chat_pathDeviceConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Device confirmed.'**
  String get chat_pathDeviceConfirmed;

  /// No description provided for @chat_pathDeviceNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Device not confirmed yet.'**
  String get chat_pathDeviceNotConfirmed;

  /// No description provided for @chat_type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get chat_type;

  /// No description provided for @chat_path.
  ///
  /// In en, this message translates to:
  /// **'Path'**
  String get chat_path;

  /// No description provided for @chat_publicKey.
  ///
  /// In en, this message translates to:
  /// **'Public Key'**
  String get chat_publicKey;

  /// No description provided for @chat_compressOutgoingMessages.
  ///
  /// In en, this message translates to:
  /// **'Compress outgoing messages'**
  String get chat_compressOutgoingMessages;

  /// No description provided for @chat_floodForced.
  ///
  /// In en, this message translates to:
  /// **'Flood (forced)'**
  String get chat_floodForced;

  /// No description provided for @chat_directForced.
  ///
  /// In en, this message translates to:
  /// **'Direct (forced)'**
  String get chat_directForced;

  /// No description provided for @chat_hopsForced.
  ///
  /// In en, this message translates to:
  /// **'{count} hops (forced)'**
  String chat_hopsForced(int count);

  /// No description provided for @chat_floodAuto.
  ///
  /// In en, this message translates to:
  /// **'Flood (auto)'**
  String get chat_floodAuto;

  /// No description provided for @chat_direct.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get chat_direct;

  /// No description provided for @chat_poiShared.
  ///
  /// In en, this message translates to:
  /// **'POI Shared'**
  String get chat_poiShared;

  /// No description provided for @chat_unread.
  ///
  /// In en, this message translates to:
  /// **'Unread: {count}'**
  String chat_unread(int count);

  /// No description provided for @chat_markAsUnread.
  ///
  /// In en, this message translates to:
  /// **'Mark as Unread'**
  String get chat_markAsUnread;

  /// No description provided for @chat_newMessages.
  ///
  /// In en, this message translates to:
  /// **'New messages'**
  String get chat_newMessages;

  /// No description provided for @chat_openLink.
  ///
  /// In en, this message translates to:
  /// **'Open Link?'**
  String get chat_openLink;

  /// No description provided for @chat_openLinkConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Do you want to open this link in your browser?'**
  String get chat_openLinkConfirmation;

  /// No description provided for @chat_open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get chat_open;

  /// No description provided for @chat_couldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open link: {url}'**
  String chat_couldNotOpenLink(String url);

  /// No description provided for @chat_invalidLink.
  ///
  /// In en, this message translates to:
  /// **'Invalid link format'**
  String get chat_invalidLink;

  /// No description provided for @map_title.
  ///
  /// In en, this message translates to:
  /// **'Node Map'**
  String get map_title;

  /// No description provided for @map_searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search node name or ID'**
  String get map_searchHint;

  /// No description provided for @map_activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get map_activity;

  /// No description provided for @map_online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get map_online;

  /// No description provided for @map_recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get map_recent;

  /// No description provided for @map_stale.
  ///
  /// In en, this message translates to:
  /// **'Stale'**
  String get map_stale;

  /// No description provided for @map_visible.
  ///
  /// In en, this message translates to:
  /// **'Visible'**
  String get map_visible;

  /// No description provided for @map_hidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get map_hidden;

  /// No description provided for @map_centerOnNode.
  ///
  /// In en, this message translates to:
  /// **'Center on node'**
  String get map_centerOnNode;

  /// No description provided for @map_details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get map_details;

  /// No description provided for @map_noGps.
  ///
  /// In en, this message translates to:
  /// **'No GPS'**
  String get map_noGps;

  /// No description provided for @map_noResults.
  ///
  /// In en, this message translates to:
  /// **'No matching nodes'**
  String get map_noResults;

  /// No description provided for @map_lineOfSight.
  ///
  /// In en, this message translates to:
  /// **'Line of Sight'**
  String get map_lineOfSight;

  /// No description provided for @map_losScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Line of Sight'**
  String get map_losScreenTitle;

  /// No description provided for @map_noNodesWithLocation.
  ///
  /// In en, this message translates to:
  /// **'No nodes with location data'**
  String get map_noNodesWithLocation;

  /// No description provided for @map_nodesNeedGps.
  ///
  /// In en, this message translates to:
  /// **'Nodes need to share their GPS coordinates\nto appear on the map'**
  String get map_nodesNeedGps;

  /// No description provided for @map_nodesCount.
  ///
  /// In en, this message translates to:
  /// **'Nodes: {count}'**
  String map_nodesCount(int count);

  /// No description provided for @map_pinsCount.
  ///
  /// In en, this message translates to:
  /// **'Pins: {count}'**
  String map_pinsCount(int count);

  /// No description provided for @map_chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get map_chat;

  /// No description provided for @map_repeater.
  ///
  /// In en, this message translates to:
  /// **'Repeater'**
  String get map_repeater;

  /// No description provided for @map_room.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get map_room;

  /// No description provided for @map_sensor.
  ///
  /// In en, this message translates to:
  /// **'Sensor'**
  String get map_sensor;

  /// No description provided for @map_pinDm.
  ///
  /// In en, this message translates to:
  /// **'Pin (DM)'**
  String get map_pinDm;

  /// No description provided for @map_pinPrivate.
  ///
  /// In en, this message translates to:
  /// **'Pin (Private)'**
  String get map_pinPrivate;

  /// No description provided for @map_pinPublic.
  ///
  /// In en, this message translates to:
  /// **'Pin (Public)'**
  String get map_pinPublic;

  /// No description provided for @map_lastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last Seen'**
  String get map_lastSeen;

  /// No description provided for @map_disconnectConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to disconnect from this device?'**
  String get map_disconnectConfirm;

  /// No description provided for @map_from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get map_from;

  /// No description provided for @map_source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get map_source;

  /// No description provided for @map_flags.
  ///
  /// In en, this message translates to:
  /// **'Flags'**
  String get map_flags;

  /// No description provided for @map_type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get map_type;

  /// No description provided for @map_path.
  ///
  /// In en, this message translates to:
  /// **'Path'**
  String get map_path;

  /// No description provided for @map_location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get map_location;

  /// No description provided for @map_estLocation.
  ///
  /// In en, this message translates to:
  /// **'Est. Location'**
  String get map_estLocation;

  /// No description provided for @map_publicKey.
  ///
  /// In en, this message translates to:
  /// **'Public Key'**
  String get map_publicKey;

  /// No description provided for @map_publicKeyPrefixHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. ab12'**
  String get map_publicKeyPrefixHint;

  /// No description provided for @map_shareMarkerHere.
  ///
  /// In en, this message translates to:
  /// **'Share marker here'**
  String get map_shareMarkerHere;

  /// No description provided for @map_setAsMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Set as my location'**
  String get map_setAsMyLocation;

  /// No description provided for @floodCorridor_title.
  ///
  /// In en, this message translates to:
  /// **'Flood Corridor'**
  String get floodCorridor_title;

  /// No description provided for @floodCorridor_previewToHere.
  ///
  /// In en, this message translates to:
  /// **'Preview flood corridor to here'**
  String get floodCorridor_previewToHere;

  /// No description provided for @floodCorridor_requesting.
  ///
  /// In en, this message translates to:
  /// **'Asking your radio for a corridor…'**
  String get floodCorridor_requesting;

  /// No description provided for @floodCorridor_unsupported.
  ///
  /// In en, this message translates to:
  /// **'Your radio\'s firmware doesn\'t support flood corridors.'**
  String get floodCorridor_unsupported;

  /// No description provided for @floodCorridor_noProposal.
  ///
  /// In en, this message translates to:
  /// **'Your radio couldn\'t propose a corridor. Make sure it has a position set.'**
  String get floodCorridor_noProposal;

  /// No description provided for @floodCorridor_circleCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 circle} other{{count} circles}}'**
  String floodCorridor_circleCount(int count);

  /// No description provided for @floodCorridor_repeatersInside.
  ///
  /// In en, this message translates to:
  /// **'{inside} of {total} known repeaters inside'**
  String floodCorridor_repeatersInside(int inside, int total);

  /// No description provided for @floodCorridor_straightLine.
  ///
  /// In en, this message translates to:
  /// **'Straight line: no known repeaters along the way'**
  String get floodCorridor_straightLine;

  /// No description provided for @floodCorridor_followsRepeaters.
  ///
  /// In en, this message translates to:
  /// **'Follows your known repeaters'**
  String get floodCorridor_followsRepeaters;

  /// No description provided for @floodCorridor_horizonLimited.
  ///
  /// In en, this message translates to:
  /// **'Known repeaters don\'t reach the target; the rest is a straight line'**
  String get floodCorridor_horizonLimited;

  /// No description provided for @floodCorridor_thinStretch.
  ///
  /// In en, this message translates to:
  /// **'Part of the corridor has few known repeaters'**
  String get floodCorridor_thinStretch;

  /// No description provided for @floodCorridor_moreCoverage.
  ///
  /// In en, this message translates to:
  /// **'Require more repeater coverage'**
  String get floodCorridor_moreCoverage;

  /// No description provided for @floodCorridor_previewNote.
  ///
  /// In en, this message translates to:
  /// **'Preview only. Repeaters without corridor firmware don\'t apply corridors.'**
  String get floodCorridor_previewNote;

  /// No description provided for @map_pinLabel.
  ///
  /// In en, this message translates to:
  /// **'Pin label'**
  String get map_pinLabel;

  /// No description provided for @map_label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get map_label;

  /// No description provided for @map_pointOfInterest.
  ///
  /// In en, this message translates to:
  /// **'Point of interest'**
  String get map_pointOfInterest;

  /// No description provided for @map_sendToContact.
  ///
  /// In en, this message translates to:
  /// **'Send to contact'**
  String get map_sendToContact;

  /// No description provided for @map_sendToChannel.
  ///
  /// In en, this message translates to:
  /// **'Send to channel'**
  String get map_sendToChannel;

  /// No description provided for @map_noChannelsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No channels available'**
  String get map_noChannelsAvailable;

  /// No description provided for @map_publicLocationShare.
  ///
  /// In en, this message translates to:
  /// **'Public location share'**
  String get map_publicLocationShare;

  /// No description provided for @map_publicLocationShareConfirm.
  ///
  /// In en, this message translates to:
  /// **'You are about to share a location in {channelLabel}. This channel is public and anyone with the PSK can see it.'**
  String map_publicLocationShareConfirm(String channelLabel);

  /// No description provided for @map_connectToShareMarkers.
  ///
  /// In en, this message translates to:
  /// **'Connect to a device to share markers'**
  String get map_connectToShareMarkers;

  /// No description provided for @map_filterNodes.
  ///
  /// In en, this message translates to:
  /// **'Filter Nodes'**
  String get map_filterNodes;

  /// No description provided for @map_nodeTypes.
  ///
  /// In en, this message translates to:
  /// **'Node Types'**
  String get map_nodeTypes;

  /// No description provided for @map_chatNodes.
  ///
  /// In en, this message translates to:
  /// **'Chat Nodes'**
  String get map_chatNodes;

  /// No description provided for @map_repeaters.
  ///
  /// In en, this message translates to:
  /// **'Repeaters'**
  String get map_repeaters;

  /// No description provided for @map_otherNodes.
  ///
  /// In en, this message translates to:
  /// **'Other Nodes'**
  String get map_otherNodes;

  /// No description provided for @map_showOverlaps.
  ///
  /// In en, this message translates to:
  /// **'Repeater Key Overlaps'**
  String get map_showOverlaps;

  /// No description provided for @map_keyPrefix.
  ///
  /// In en, this message translates to:
  /// **'Key Prefix'**
  String get map_keyPrefix;

  /// No description provided for @map_filterByKeyPrefix.
  ///
  /// In en, this message translates to:
  /// **'Filter by key prefix'**
  String get map_filterByKeyPrefix;

  /// No description provided for @map_publicKeyPrefix.
  ///
  /// In en, this message translates to:
  /// **'Public key prefix'**
  String get map_publicKeyPrefix;

  /// No description provided for @map_markers.
  ///
  /// In en, this message translates to:
  /// **'Markers'**
  String get map_markers;

  /// No description provided for @map_showSharedMarkers.
  ///
  /// In en, this message translates to:
  /// **'Show shared markers'**
  String get map_showSharedMarkers;

  /// No description provided for @map_showGuessedLocations.
  ///
  /// In en, this message translates to:
  /// **'Show guessed node locations'**
  String get map_showGuessedLocations;

  /// No description provided for @map_showDiscoveryContacts.
  ///
  /// In en, this message translates to:
  /// **'Show Discovery Contacts'**
  String get map_showDiscoveryContacts;

  /// No description provided for @map_guessedLocation.
  ///
  /// In en, this message translates to:
  /// **'Guessed location'**
  String get map_guessedLocation;

  /// No description provided for @map_lastSeenTime.
  ///
  /// In en, this message translates to:
  /// **'Last Seen Time'**
  String get map_lastSeenTime;

  /// No description provided for @map_sharedPin.
  ///
  /// In en, this message translates to:
  /// **'Shared pin'**
  String get map_sharedPin;

  /// No description provided for @map_sharedAt.
  ///
  /// In en, this message translates to:
  /// **'Shared'**
  String get map_sharedAt;

  /// No description provided for @map_joinRoom.
  ///
  /// In en, this message translates to:
  /// **'Join Room'**
  String get map_joinRoom;

  /// No description provided for @map_manageRepeater.
  ///
  /// In en, this message translates to:
  /// **'Manage Repeater'**
  String get map_manageRepeater;

  /// No description provided for @map_tapToAdd.
  ///
  /// In en, this message translates to:
  /// **'Tap on nodes to add them to the path.'**
  String get map_tapToAdd;

  /// No description provided for @map_runTrace.
  ///
  /// In en, this message translates to:
  /// **'Run path trace'**
  String get map_runTrace;

  /// No description provided for @map_runTraceWithReturnPath.
  ///
  /// In en, this message translates to:
  /// **'Return back on the same path.'**
  String get map_runTraceWithReturnPath;

  /// No description provided for @map_removeLast.
  ///
  /// In en, this message translates to:
  /// **'Remove Last'**
  String get map_removeLast;

  /// No description provided for @map_pathTraceCancelled.
  ///
  /// In en, this message translates to:
  /// **'Path trace cancelled.'**
  String get map_pathTraceCancelled;

  /// No description provided for @mapCache_title.
  ///
  /// In en, this message translates to:
  /// **'Offline Map Cache'**
  String get mapCache_title;

  /// No description provided for @mapCache_selectAreaFirst.
  ///
  /// In en, this message translates to:
  /// **'Select an area to cache first'**
  String get mapCache_selectAreaFirst;

  /// No description provided for @mapCache_noTilesToDownload.
  ///
  /// In en, this message translates to:
  /// **'No tiles to download for this area'**
  String get mapCache_noTilesToDownload;

  /// No description provided for @mapCache_downloadTilesTitle.
  ///
  /// In en, this message translates to:
  /// **'Download tiles'**
  String get mapCache_downloadTilesTitle;

  /// No description provided for @mapCache_downloadTilesPrompt.
  ///
  /// In en, this message translates to:
  /// **'Download {count} tiles for offline use?'**
  String mapCache_downloadTilesPrompt(int count);

  /// No description provided for @mapCache_downloadAction.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get mapCache_downloadAction;

  /// No description provided for @mapCache_cachedTiles.
  ///
  /// In en, this message translates to:
  /// **'Cached {count} tiles'**
  String mapCache_cachedTiles(int count);

  /// No description provided for @mapCache_cachedTilesWithFailed.
  ///
  /// In en, this message translates to:
  /// **'Cached {downloaded} tiles ({failed} failed)'**
  String mapCache_cachedTilesWithFailed(int downloaded, int failed);

  /// No description provided for @mapCache_clearOfflineCacheTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear offline cache'**
  String get mapCache_clearOfflineCacheTitle;

  /// No description provided for @mapCache_clearOfflineCachePrompt.
  ///
  /// In en, this message translates to:
  /// **'Remove all cached map tiles?'**
  String get mapCache_clearOfflineCachePrompt;

  /// No description provided for @mapCache_offlineCacheCleared.
  ///
  /// In en, this message translates to:
  /// **'Offline cache cleared'**
  String get mapCache_offlineCacheCleared;

  /// No description provided for @mapCache_noAreaSelected.
  ///
  /// In en, this message translates to:
  /// **'No area selected'**
  String get mapCache_noAreaSelected;

  /// No description provided for @mapCache_cacheArea.
  ///
  /// In en, this message translates to:
  /// **'Cache Area'**
  String get mapCache_cacheArea;

  /// No description provided for @mapCache_useCurrentView.
  ///
  /// In en, this message translates to:
  /// **'Use Current View'**
  String get mapCache_useCurrentView;

  /// No description provided for @mapCache_zoomRange.
  ///
  /// In en, this message translates to:
  /// **'Zoom Range'**
  String get mapCache_zoomRange;

  /// No description provided for @mapCache_estimatedTiles.
  ///
  /// In en, this message translates to:
  /// **'Estimated tiles: {count}'**
  String mapCache_estimatedTiles(int count);

  /// No description provided for @mapCache_downloadedTiles.
  ///
  /// In en, this message translates to:
  /// **'Downloaded {completed} / {total}'**
  String mapCache_downloadedTiles(int completed, int total);

  /// No description provided for @mapCache_downloadTilesButton.
  ///
  /// In en, this message translates to:
  /// **'Download Tiles'**
  String get mapCache_downloadTilesButton;

  /// No description provided for @mapCache_clearCacheButton.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get mapCache_clearCacheButton;

  /// No description provided for @mapCache_failedDownloads.
  ///
  /// In en, this message translates to:
  /// **'Failed downloads: {count}'**
  String mapCache_failedDownloads(int count);

  /// No description provided for @mapCache_cachedTilesLabel.
  ///
  /// In en, this message translates to:
  /// **'Cached tiles'**
  String get mapCache_cachedTilesLabel;

  /// No description provided for @mapCache_cachedTileSummaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Cached tile summary'**
  String get mapCache_cachedTileSummaryLabel;

  /// No description provided for @mapCache_bulkDownloadDisabledForSource.
  ///
  /// In en, this message translates to:
  /// **'Offline bulk downloads are disabled for {source}.'**
  String mapCache_bulkDownloadDisabledForSource(String source);

  /// No description provided for @mapCache_bulkDownloadDisabledInConfig.
  ///
  /// In en, this message translates to:
  /// **'Offline bulk downloads are disabled for {source} in this app configuration.'**
  String mapCache_bulkDownloadDisabledInConfig(String source);

  /// No description provided for @mapCache_summarySource.
  ///
  /// In en, this message translates to:
  /// **'Source: {source}'**
  String mapCache_summarySource(String source);

  /// No description provided for @mapCache_summaryCachedTilesForSource.
  ///
  /// In en, this message translates to:
  /// **'Cached tiles for source: {count}'**
  String mapCache_summaryCachedTilesForSource(int count);

  /// No description provided for @mapCache_summaryCachedInSelection.
  ///
  /// In en, this message translates to:
  /// **'Cached in selected area/zoom: {count}'**
  String mapCache_summaryCachedInSelection(int count);

  /// No description provided for @mapCache_summaryApproxCacheSize.
  ///
  /// In en, this message translates to:
  /// **'Approx cache size: {size}'**
  String mapCache_summaryApproxCacheSize(String size);

  /// No description provided for @mapCache_boundsLabel.
  ///
  /// In en, this message translates to:
  /// **'N {north}, S {south}, E {east}, W {west}'**
  String mapCache_boundsLabel(
    String north,
    String south,
    String east,
    String west,
  );

  /// No description provided for @time_justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get time_justNow;

  /// No description provided for @time_minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String time_minutesAgo(int minutes);

  /// No description provided for @time_hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String time_hoursAgo(int hours);

  /// No description provided for @time_daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String time_daysAgo(int days);

  /// No description provided for @time_hour.
  ///
  /// In en, this message translates to:
  /// **'hour'**
  String get time_hour;

  /// No description provided for @time_hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get time_hours;

  /// No description provided for @time_day.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get time_day;

  /// No description provided for @time_days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get time_days;

  /// No description provided for @time_week.
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get time_week;

  /// No description provided for @time_weeks.
  ///
  /// In en, this message translates to:
  /// **'weeks'**
  String get time_weeks;

  /// No description provided for @time_month.
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get time_month;

  /// No description provided for @time_months.
  ///
  /// In en, this message translates to:
  /// **'months'**
  String get time_months;

  /// No description provided for @time_minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get time_minutes;

  /// No description provided for @time_allTime.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get time_allTime;

  /// No description provided for @dialog_disconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get dialog_disconnect;

  /// No description provided for @dialog_disconnectConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to disconnect from this device?'**
  String get dialog_disconnectConfirm;

  /// No description provided for @login_repeaterLogin.
  ///
  /// In en, this message translates to:
  /// **'Repeater Login'**
  String get login_repeaterLogin;

  /// No description provided for @login_roomLogin.
  ///
  /// In en, this message translates to:
  /// **'Room Server Login'**
  String get login_roomLogin;

  /// No description provided for @login_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_password;

  /// No description provided for @login_enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get login_enterPassword;

  /// No description provided for @login_savePassword.
  ///
  /// In en, this message translates to:
  /// **'Save password'**
  String get login_savePassword;

  /// No description provided for @login_savePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Password will be stored securely on this device'**
  String get login_savePasswordSubtitle;

  /// No description provided for @login_repeaterDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the repeater password for guest or admin access.'**
  String get login_repeaterDescription;

  /// No description provided for @login_roomDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the room password for guest or admin access.'**
  String get login_roomDescription;

  /// No description provided for @login_routing.
  ///
  /// In en, this message translates to:
  /// **'Routing'**
  String get login_routing;

  /// No description provided for @login_routingMode.
  ///
  /// In en, this message translates to:
  /// **'Routing mode'**
  String get login_routingMode;

  /// No description provided for @login_autoUseSavedPath.
  ///
  /// In en, this message translates to:
  /// **'Auto (use saved path)'**
  String get login_autoUseSavedPath;

  /// No description provided for @login_forceFloodMode.
  ///
  /// In en, this message translates to:
  /// **'Force Flood Mode'**
  String get login_forceFloodMode;

  /// No description provided for @login_managePaths.
  ///
  /// In en, this message translates to:
  /// **'Manage Paths'**
  String get login_managePaths;

  /// No description provided for @login_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_login;

  /// No description provided for @login_attempt.
  ///
  /// In en, this message translates to:
  /// **'Attempt {current}/{max}'**
  String login_attempt(int current, int max);

  /// No description provided for @login_failed.
  ///
  /// In en, this message translates to:
  /// **'Login failed: {error}'**
  String login_failed(String error);

  /// No description provided for @login_failedMessage.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Either the password is incorrect or the repeater is unreachable.'**
  String get login_failedMessage;

  /// No description provided for @common_reload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get common_reload;

  /// No description provided for @common_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get common_clear;

  /// No description provided for @path_currentPathLabel.
  ///
  /// In en, this message translates to:
  /// **'Current path'**
  String get path_currentPathLabel;

  /// No description provided for @path_noRepeatersFound.
  ///
  /// In en, this message translates to:
  /// **'No repeaters or room servers found.'**
  String get path_noRepeatersFound;

  /// No description provided for @repeater_management.
  ///
  /// In en, this message translates to:
  /// **'Repeater Management'**
  String get repeater_management;

  /// No description provided for @room_management.
  ///
  /// In en, this message translates to:
  /// **'Room Server Management'**
  String get room_management;

  /// No description provided for @repeater_guest.
  ///
  /// In en, this message translates to:
  /// **'Repeater Information'**
  String get repeater_guest;

  /// No description provided for @room_guest.
  ///
  /// In en, this message translates to:
  /// **'Room Server Information'**
  String get room_guest;

  /// No description provided for @repeater_managementTools.
  ///
  /// In en, this message translates to:
  /// **'Management Tools'**
  String get repeater_managementTools;

  /// No description provided for @repeater_guestTools.
  ///
  /// In en, this message translates to:
  /// **'Guest Tools'**
  String get repeater_guestTools;

  /// No description provided for @repeater_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get repeater_status;

  /// No description provided for @repeater_statusSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View repeater status, stats, and neighbors'**
  String get repeater_statusSubtitle;

  /// No description provided for @repeater_telemetry.
  ///
  /// In en, this message translates to:
  /// **'Telemetry'**
  String get repeater_telemetry;

  /// No description provided for @repeater_telemetrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'View telemetry of sensors and system stats'**
  String get repeater_telemetrySubtitle;

  /// No description provided for @repeater_cli.
  ///
  /// In en, this message translates to:
  /// **'CLI'**
  String get repeater_cli;

  /// No description provided for @repeater_cliSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send commands to the repeater'**
  String get repeater_cliSubtitle;

  /// No description provided for @repeater_neighbors.
  ///
  /// In en, this message translates to:
  /// **'Neighbors'**
  String get repeater_neighbors;

  /// No description provided for @repeater_neighborsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View zero hop neighbors.'**
  String get repeater_neighborsSubtitle;

  /// No description provided for @repeater_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get repeater_settings;

  /// No description provided for @repeater_settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure repeater parameters'**
  String get repeater_settingsSubtitle;

  /// Repeater setting: auto sync device clock after successful login
  ///
  /// In en, this message translates to:
  /// **'Clock sync after login'**
  String get repeater_clockSyncAfterLogin;

  /// Repeater setting subtitle: describes the clock sync after login behavior
  ///
  /// In en, this message translates to:
  /// **'Automatically send \"clock sync\" after a successful login'**
  String get repeater_clockSyncAfterLoginSubtitle;

  /// No description provided for @repeater_statusTitle.
  ///
  /// In en, this message translates to:
  /// **'Repeater Status'**
  String get repeater_statusTitle;

  /// No description provided for @repeater_routingMode.
  ///
  /// In en, this message translates to:
  /// **'Routing mode'**
  String get repeater_routingMode;

  /// No description provided for @repeater_refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get repeater_refresh;

  /// No description provided for @repeater_statusRequestTimeout.
  ///
  /// In en, this message translates to:
  /// **'Status request timed out.'**
  String get repeater_statusRequestTimeout;

  /// No description provided for @repeater_errorLoadingStatus.
  ///
  /// In en, this message translates to:
  /// **'Error loading status: {error}'**
  String repeater_errorLoadingStatus(String error);

  /// No description provided for @repeater_systemInformation.
  ///
  /// In en, this message translates to:
  /// **'System Information'**
  String get repeater_systemInformation;

  /// No description provided for @repeater_battery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get repeater_battery;

  /// No description provided for @repeater_clockAtLogin.
  ///
  /// In en, this message translates to:
  /// **'Clock (at login)'**
  String get repeater_clockAtLogin;

  /// No description provided for @repeater_uptime.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get repeater_uptime;

  /// No description provided for @repeater_queueLength.
  ///
  /// In en, this message translates to:
  /// **'Queue Length'**
  String get repeater_queueLength;

  /// No description provided for @repeater_debugFlags.
  ///
  /// In en, this message translates to:
  /// **'Debug Flags'**
  String get repeater_debugFlags;

  /// No description provided for @repeater_radioStatistics.
  ///
  /// In en, this message translates to:
  /// **'Radio Statistics'**
  String get repeater_radioStatistics;

  /// No description provided for @repeater_lastRssi.
  ///
  /// In en, this message translates to:
  /// **'Last RSSI'**
  String get repeater_lastRssi;

  /// No description provided for @repeater_lastSnr.
  ///
  /// In en, this message translates to:
  /// **'Last SNR'**
  String get repeater_lastSnr;

  /// No description provided for @repeater_noiseFloor.
  ///
  /// In en, this message translates to:
  /// **'Noise Floor'**
  String get repeater_noiseFloor;

  /// No description provided for @repeater_txAirtime.
  ///
  /// In en, this message translates to:
  /// **'TX Airtime'**
  String get repeater_txAirtime;

  /// No description provided for @repeater_rxAirtime.
  ///
  /// In en, this message translates to:
  /// **'RX Airtime'**
  String get repeater_rxAirtime;

  /// No description provided for @repeater_chanUtil.
  ///
  /// In en, this message translates to:
  /// **'Channel Utilization'**
  String get repeater_chanUtil;

  /// No description provided for @repeater_packetStatistics.
  ///
  /// In en, this message translates to:
  /// **'Packet Statistics'**
  String get repeater_packetStatistics;

  /// No description provided for @repeater_sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get repeater_sent;

  /// No description provided for @repeater_received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get repeater_received;

  /// No description provided for @repeater_duplicates.
  ///
  /// In en, this message translates to:
  /// **'Duplicates'**
  String get repeater_duplicates;

  /// No description provided for @repeater_daysHoursMinsSecs.
  ///
  /// In en, this message translates to:
  /// **'{days} days {hours}h {minutes}m {seconds}s'**
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  );

  /// No description provided for @repeater_packetTxTotal.
  ///
  /// In en, this message translates to:
  /// **'Total: {total}, Flood: {flood}, Direct: {direct}'**
  String repeater_packetTxTotal(int total, String flood, String direct);

  /// No description provided for @repeater_packetRxTotal.
  ///
  /// In en, this message translates to:
  /// **'Total: {total}, Flood: {flood}, Direct: {direct}'**
  String repeater_packetRxTotal(int total, String flood, String direct);

  /// No description provided for @repeater_duplicatesFloodDirect.
  ///
  /// In en, this message translates to:
  /// **'Flood: {flood}, Direct: {direct}'**
  String repeater_duplicatesFloodDirect(String flood, String direct);

  /// No description provided for @repeater_duplicatesTotal.
  ///
  /// In en, this message translates to:
  /// **'Total: {total}'**
  String repeater_duplicatesTotal(int total);

  /// No description provided for @repeater_settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Repeater Settings'**
  String get repeater_settingsTitle;

  /// No description provided for @repeater_basicSettings.
  ///
  /// In en, this message translates to:
  /// **'Basic Settings'**
  String get repeater_basicSettings;

  /// No description provided for @repeater_repeaterName.
  ///
  /// In en, this message translates to:
  /// **'Repeater Name'**
  String get repeater_repeaterName;

  /// No description provided for @repeater_repeaterNameHelper.
  ///
  /// In en, this message translates to:
  /// **'Display name for this repeater'**
  String get repeater_repeaterNameHelper;

  /// No description provided for @repeater_adminPassword.
  ///
  /// In en, this message translates to:
  /// **'Admin Password'**
  String get repeater_adminPassword;

  /// No description provided for @repeater_adminPasswordHelper.
  ///
  /// In en, this message translates to:
  /// **'Full access password'**
  String get repeater_adminPasswordHelper;

  /// No description provided for @repeater_guestPassword.
  ///
  /// In en, this message translates to:
  /// **'Guest Password'**
  String get repeater_guestPassword;

  /// No description provided for @repeater_guestPasswordHelper.
  ///
  /// In en, this message translates to:
  /// **'Read-only access password'**
  String get repeater_guestPasswordHelper;

  /// No description provided for @repeater_radioSettings.
  ///
  /// In en, this message translates to:
  /// **'Radio Settings'**
  String get repeater_radioSettings;

  /// No description provided for @repeater_frequencyMhz.
  ///
  /// In en, this message translates to:
  /// **'Frequency (MHz)'**
  String get repeater_frequencyMhz;

  /// No description provided for @repeater_frequencyHelper.
  ///
  /// In en, this message translates to:
  /// **'300-2500 MHz'**
  String get repeater_frequencyHelper;

  /// No description provided for @repeater_txPower.
  ///
  /// In en, this message translates to:
  /// **'TX Power'**
  String get repeater_txPower;

  /// No description provided for @repeater_txPowerHelper.
  ///
  /// In en, this message translates to:
  /// **'1-30 dBm'**
  String get repeater_txPowerHelper;

  /// No description provided for @repeater_bandwidth.
  ///
  /// In en, this message translates to:
  /// **'Bandwidth'**
  String get repeater_bandwidth;

  /// No description provided for @repeater_spreadingFactor.
  ///
  /// In en, this message translates to:
  /// **'Spreading Factor'**
  String get repeater_spreadingFactor;

  /// No description provided for @repeater_codingRate.
  ///
  /// In en, this message translates to:
  /// **'Coding Rate'**
  String get repeater_codingRate;

  /// No description provided for @repeater_locationSettings.
  ///
  /// In en, this message translates to:
  /// **'Location Settings'**
  String get repeater_locationSettings;

  /// No description provided for @repeater_latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get repeater_latitude;

  /// No description provided for @repeater_latitudeHelper.
  ///
  /// In en, this message translates to:
  /// **'Decimal degrees (e.g., 37.7749)'**
  String get repeater_latitudeHelper;

  /// No description provided for @repeater_longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get repeater_longitude;

  /// No description provided for @repeater_longitudeHelper.
  ///
  /// In en, this message translates to:
  /// **'Decimal degrees (e.g., -122.4194)'**
  String get repeater_longitudeHelper;

  /// No description provided for @repeater_features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get repeater_features;

  /// No description provided for @repeater_packetForwarding.
  ///
  /// In en, this message translates to:
  /// **'Packet Forwarding'**
  String get repeater_packetForwarding;

  /// No description provided for @repeater_packetForwardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable repeater to forward packets'**
  String get repeater_packetForwardingSubtitle;

  /// No description provided for @repeater_guestAccess.
  ///
  /// In en, this message translates to:
  /// **'Guest Access'**
  String get repeater_guestAccess;

  /// No description provided for @repeater_guestAccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow read-only guest access'**
  String get repeater_guestAccessSubtitle;

  /// No description provided for @repeater_privacyMode.
  ///
  /// In en, this message translates to:
  /// **'Privacy Mode'**
  String get repeater_privacyMode;

  /// No description provided for @repeater_privacyModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hide name/location in advertisements'**
  String get repeater_privacyModeSubtitle;

  /// No description provided for @repeater_advertisementSettings.
  ///
  /// In en, this message translates to:
  /// **'Advertisement Settings'**
  String get repeater_advertisementSettings;

  /// No description provided for @repeater_localAdvertInterval.
  ///
  /// In en, this message translates to:
  /// **'Local Advertisement Interval'**
  String get repeater_localAdvertInterval;

  /// No description provided for @repeater_localAdvertIntervalMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes'**
  String repeater_localAdvertIntervalMinutes(int minutes);

  /// No description provided for @repeater_floodAdvertInterval.
  ///
  /// In en, this message translates to:
  /// **'Flood Advertisement Interval'**
  String get repeater_floodAdvertInterval;

  /// No description provided for @repeater_floodAdvertIntervalHours.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours'**
  String repeater_floodAdvertIntervalHours(int hours);

  /// No description provided for @repeater_encryptedAdvertInterval.
  ///
  /// In en, this message translates to:
  /// **'Encrypted Advertisement Interval'**
  String get repeater_encryptedAdvertInterval;

  /// No description provided for @repeater_dangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get repeater_dangerZone;

  /// No description provided for @repeater_rebootRepeater.
  ///
  /// In en, this message translates to:
  /// **'Reboot Repeater'**
  String get repeater_rebootRepeater;

  /// No description provided for @repeater_rebootRepeaterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Restart the repeater device'**
  String get repeater_rebootRepeaterSubtitle;

  /// No description provided for @repeater_rebootRepeaterConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reboot this repeater?'**
  String get repeater_rebootRepeaterConfirm;

  /// No description provided for @repeater_regenerateIdentityKey.
  ///
  /// In en, this message translates to:
  /// **'Regenerate Identity Key'**
  String get repeater_regenerateIdentityKey;

  /// No description provided for @repeater_regenerateIdentityKeySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Generate new public/private key pair'**
  String get repeater_regenerateIdentityKeySubtitle;

  /// No description provided for @repeater_regenerateIdentityKeyConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will generate a new identity for the repeater. Continue?'**
  String get repeater_regenerateIdentityKeyConfirm;

  /// No description provided for @repeater_eraseFileSystem.
  ///
  /// In en, this message translates to:
  /// **'Erase File System'**
  String get repeater_eraseFileSystem;

  /// No description provided for @repeater_eraseFileSystemSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Format the repeater file system'**
  String get repeater_eraseFileSystemSubtitle;

  /// No description provided for @repeater_eraseFileSystemConfirm.
  ///
  /// In en, this message translates to:
  /// **'WARNING: This will erase all data on the repeater. This cannot be undone!'**
  String get repeater_eraseFileSystemConfirm;

  /// No description provided for @repeater_eraseSerialOnly.
  ///
  /// In en, this message translates to:
  /// **'Erase is only available over serial console.'**
  String get repeater_eraseSerialOnly;

  /// No description provided for @repeater_commandSent.
  ///
  /// In en, this message translates to:
  /// **'Command sent: {command}'**
  String repeater_commandSent(String command);

  /// No description provided for @repeater_errorSendingCommand.
  ///
  /// In en, this message translates to:
  /// **'Error sending command: {error}'**
  String repeater_errorSendingCommand(String error);

  /// No description provided for @repeater_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get repeater_confirm;

  /// No description provided for @repeater_settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully'**
  String get repeater_settingsSaved;

  /// No description provided for @repeater_rxGain.
  ///
  /// In en, this message translates to:
  /// **'Boosted RX gain'**
  String get repeater_rxGain;

  /// No description provided for @repeater_rxGainHelper.
  ///
  /// In en, this message translates to:
  /// **'Higher sensitivity, more current draw (SX1262/SX1268 only)'**
  String get repeater_rxGainHelper;

  /// No description provided for @repeater_refreshRxGain.
  ///
  /// In en, this message translates to:
  /// **'Refresh boosted RX gain'**
  String get repeater_refreshRxGain;

  /// No description provided for @repeater_multiAcks.
  ///
  /// In en, this message translates to:
  /// **'Multi-ACKs'**
  String get repeater_multiAcks;

  /// No description provided for @repeater_multiAcksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Acknowledge messages over multiple paths for better delivery'**
  String get repeater_multiAcksSubtitle;

  /// No description provided for @repeater_refreshMultiAcks.
  ///
  /// In en, this message translates to:
  /// **'Refresh multi-ACKs'**
  String get repeater_refreshMultiAcks;

  /// No description provided for @repeater_networkHealth.
  ///
  /// In en, this message translates to:
  /// **'Network health'**
  String get repeater_networkHealth;

  /// No description provided for @repeater_loopDetect.
  ///
  /// In en, this message translates to:
  /// **'Loop detection'**
  String get repeater_loopDetect;

  /// No description provided for @repeater_loopDetectHelper.
  ///
  /// In en, this message translates to:
  /// **'Drop flood packets that look like routing loops'**
  String get repeater_loopDetectHelper;

  /// No description provided for @repeater_loopDetectOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get repeater_loopDetectOff;

  /// No description provided for @repeater_loopDetectMinimal.
  ///
  /// In en, this message translates to:
  /// **'Minimal'**
  String get repeater_loopDetectMinimal;

  /// No description provided for @repeater_loopDetectModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get repeater_loopDetectModerate;

  /// No description provided for @repeater_loopDetectStrict.
  ///
  /// In en, this message translates to:
  /// **'Strict'**
  String get repeater_loopDetectStrict;

  /// No description provided for @repeater_dutyCycle.
  ///
  /// In en, this message translates to:
  /// **'Duty cycle'**
  String get repeater_dutyCycle;

  /// No description provided for @repeater_dutyCycleHelper.
  ///
  /// In en, this message translates to:
  /// **'Maximum percentage of airtime'**
  String get repeater_dutyCycleHelper;

  /// No description provided for @repeater_dutyCyclePercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String repeater_dutyCyclePercent(int percent);

  /// No description provided for @repeater_ownerInfo.
  ///
  /// In en, this message translates to:
  /// **'Operator info'**
  String get repeater_ownerInfo;

  /// No description provided for @repeater_ownerInfoHelper.
  ///
  /// In en, this message translates to:
  /// **'Public metadata for this repeater'**
  String get repeater_ownerInfoHelper;

  /// No description provided for @repeater_refreshOwnerInfo.
  ///
  /// In en, this message translates to:
  /// **'Refresh operator info'**
  String get repeater_refreshOwnerInfo;

  /// No description provided for @repeater_floodMax.
  ///
  /// In en, this message translates to:
  /// **'Flood max hops'**
  String get repeater_floodMax;

  /// No description provided for @repeater_floodMaxHelper.
  ///
  /// In en, this message translates to:
  /// **'Maximum hops a flood packet may travel (0-64)'**
  String get repeater_floodMaxHelper;

  /// No description provided for @repeater_advancedSettings.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get repeater_advancedSettings;

  /// No description provided for @repeater_advancedSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tuning knobs for experienced operators'**
  String get repeater_advancedSettingsSubtitle;

  /// No description provided for @repeater_pathHashMode.
  ///
  /// In en, this message translates to:
  /// **'Path hash mode'**
  String get repeater_pathHashMode;

  /// No description provided for @repeater_pathHashModeHelper.
  ///
  /// In en, this message translates to:
  /// **'Bytes used to encode this repeater\'s ID in flood path/loop-detect tags. 0=1 byte (256 IDs, up to 64 hops), 1=2 bytes (65K IDs, up to 32 hops), 2=3 bytes (16M IDs, up to 21 hops). Firmware before v1.14 always used 1-byte paths; v1.14 and newer can be configured for 2- or 3-byte paths.'**
  String get repeater_pathHashModeHelper;

  /// No description provided for @repeater_keySettings.
  ///
  /// In en, this message translates to:
  /// **'Change Identity Keys'**
  String get repeater_keySettings;

  /// No description provided for @repeater_keySettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change the public/private keypair'**
  String get repeater_keySettingsSubtitle;

  /// No description provided for @repeater_prvKey.
  ///
  /// In en, this message translates to:
  /// **'Private key'**
  String get repeater_prvKey;

  /// No description provided for @repeater_prvKeyHelper.
  ///
  /// In en, this message translates to:
  /// **'A new private key for the repeater, a 128-character hex string.'**
  String get repeater_prvKeyHelper;

  /// No description provided for @repeater_generatePrvKey.
  ///
  /// In en, this message translates to:
  /// **'Generate a random keypair'**
  String get repeater_generatePrvKey;

  /// No description provided for @repeater_stopGeneratingPrvKey.
  ///
  /// In en, this message translates to:
  /// **'Interrupt search for keypair'**
  String get repeater_stopGeneratingPrvKey;

  /// No description provided for @repeater_pubKey.
  ///
  /// In en, this message translates to:
  /// **'Public key'**
  String get repeater_pubKey;

  /// No description provided for @repeater_pubKeyHelper.
  ///
  /// In en, this message translates to:
  /// **'This is the public key that goes with the generated private key. You can\'t set this directly.'**
  String get repeater_pubKeyHelper;

  /// No description provided for @repeater_pubKeyPrefix.
  ///
  /// In en, this message translates to:
  /// **'Desired prefix'**
  String get repeater_pubKeyPrefix;

  /// No description provided for @repeater_pubKeyPrefixHelper.
  ///
  /// In en, this message translates to:
  /// **'Find a public key that starts with these hex digits. Expected tries needed: {tries}.'**
  String repeater_pubKeyPrefixHelper(int tries);

  /// No description provided for @repeater_txDelay.
  ///
  /// In en, this message translates to:
  /// **'Flood TX delay'**
  String get repeater_txDelay;

  /// No description provided for @repeater_txDelayHelper.
  ///
  /// In en, this message translates to:
  /// **'Retransmit spacing for flood traffic, as a multiplier of the packet\'s airtime (0-2, default 0.5). Higher = fewer collisions but slower delivery.'**
  String get repeater_txDelayHelper;

  /// No description provided for @repeater_directTxDelay.
  ///
  /// In en, this message translates to:
  /// **'Direct TX delay'**
  String get repeater_directTxDelay;

  /// No description provided for @repeater_directTxDelayHelper.
  ///
  /// In en, this message translates to:
  /// **'Retransmit spacing for direct (non-flood) traffic, as a multiplier of the packet\'s airtime (0-2, default 0.3).'**
  String get repeater_directTxDelayHelper;

  /// No description provided for @repeater_intThresh.
  ///
  /// In en, this message translates to:
  /// **'Interference threshold'**
  String get repeater_intThresh;

  /// No description provided for @repeater_intThreshHelper.
  ///
  /// In en, this message translates to:
  /// **'Threshold passed to the radio\'s noise-floor calibration so it rejects interference above this level. 0 disables — only raise if you see RX errors in a noisy band.'**
  String get repeater_intThreshHelper;

  /// No description provided for @repeater_agcResetInterval.
  ///
  /// In en, this message translates to:
  /// **'AGC reset interval'**
  String get repeater_agcResetInterval;

  /// No description provided for @repeater_agcResetIntervalHelper.
  ///
  /// In en, this message translates to:
  /// **'How often to reset the radio\'s automatic gain control to recover from a stuck gain state. Seconds, snapped down to a multiple of 4. 0 disables periodic resets.'**
  String get repeater_agcResetIntervalHelper;

  /// No description provided for @repeater_actionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get repeater_actionsTitle;

  /// No description provided for @repeater_sendAdvert.
  ///
  /// In en, this message translates to:
  /// **'Send flood advert'**
  String get repeater_sendAdvert;

  /// No description provided for @repeater_sendAdvertSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Broadcast a flood advert through the network'**
  String get repeater_sendAdvertSubtitle;

  /// No description provided for @repeater_sendAdvertZeroHop.
  ///
  /// In en, this message translates to:
  /// **'Send zero-hop advert'**
  String get repeater_sendAdvertZeroHop;

  /// No description provided for @repeater_sendAdvertZeroHopSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Broadcast a one-hop advert (no relays)'**
  String get repeater_sendAdvertZeroHopSubtitle;

  /// No description provided for @repeater_clockSync.
  ///
  /// In en, this message translates to:
  /// **'Sync clock now'**
  String get repeater_clockSync;

  /// No description provided for @repeater_clockSyncSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Push your phone\'s time to the repeater'**
  String get repeater_clockSyncSubtitle;

  /// No description provided for @repeater_actionSucceeded.
  ///
  /// In en, this message translates to:
  /// **'{action} succeeded'**
  String repeater_actionSucceeded(String action);

  /// No description provided for @repeater_actionFailed.
  ///
  /// In en, this message translates to:
  /// **'{action} failed: {error}'**
  String repeater_actionFailed(String action, String error);

  /// No description provided for @repeater_settingsSavedRebootNeeded.
  ///
  /// In en, this message translates to:
  /// **'Settings saved — reboot the repeater to apply'**
  String get repeater_settingsSavedRebootNeeded;

  /// No description provided for @repeater_settingsPartialFailure.
  ///
  /// In en, this message translates to:
  /// **'Some settings failed: {failures}'**
  String repeater_settingsPartialFailure(String failures);

  /// No description provided for @repeater_errorSavingSettings.
  ///
  /// In en, this message translates to:
  /// **'Error saving settings: {error}'**
  String repeater_errorSavingSettings(String error);

  /// No description provided for @repeater_refreshBasicSettings.
  ///
  /// In en, this message translates to:
  /// **'Refresh Basic Settings'**
  String get repeater_refreshBasicSettings;

  /// No description provided for @repeater_refreshRadioSettings.
  ///
  /// In en, this message translates to:
  /// **'Refresh Radio Settings'**
  String get repeater_refreshRadioSettings;

  /// No description provided for @repeater_refreshTxPower.
  ///
  /// In en, this message translates to:
  /// **'Refresh TX power'**
  String get repeater_refreshTxPower;

  /// No description provided for @repeater_refreshPacketForwarding.
  ///
  /// In en, this message translates to:
  /// **'Refresh Packet Forwarding'**
  String get repeater_refreshPacketForwarding;

  /// No description provided for @repeater_refreshGuestAccess.
  ///
  /// In en, this message translates to:
  /// **'Refresh Guest Access'**
  String get repeater_refreshGuestAccess;

  /// No description provided for @repeater_refreshPrivacyMode.
  ///
  /// In en, this message translates to:
  /// **'Refresh Privacy Mode'**
  String get repeater_refreshPrivacyMode;

  /// No description provided for @repeater_refreshed.
  ///
  /// In en, this message translates to:
  /// **'{label} refreshed'**
  String repeater_refreshed(String label);

  /// No description provided for @repeater_errorRefreshing.
  ///
  /// In en, this message translates to:
  /// **'Error refreshing {label}'**
  String repeater_errorRefreshing(String label);

  /// No description provided for @repeater_cliTitle.
  ///
  /// In en, this message translates to:
  /// **'Repeater CLI'**
  String get repeater_cliTitle;

  /// No description provided for @repeater_debugNextCommand.
  ///
  /// In en, this message translates to:
  /// **'Debug Next Command'**
  String get repeater_debugNextCommand;

  /// No description provided for @repeater_commandHelp.
  ///
  /// In en, this message translates to:
  /// **'Command Help'**
  String get repeater_commandHelp;

  /// No description provided for @repeater_clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get repeater_clearHistory;

  /// No description provided for @repeater_noCommandsSent.
  ///
  /// In en, this message translates to:
  /// **'No commands sent yet'**
  String get repeater_noCommandsSent;

  /// No description provided for @repeater_typeCommandOrUseQuick.
  ///
  /// In en, this message translates to:
  /// **'Type a command below or use quick commands'**
  String get repeater_typeCommandOrUseQuick;

  /// No description provided for @repeater_enterCommandHint.
  ///
  /// In en, this message translates to:
  /// **'Enter command...'**
  String get repeater_enterCommandHint;

  /// No description provided for @repeater_previousCommand.
  ///
  /// In en, this message translates to:
  /// **'Previous command'**
  String get repeater_previousCommand;

  /// No description provided for @repeater_nextCommand.
  ///
  /// In en, this message translates to:
  /// **'Next command'**
  String get repeater_nextCommand;

  /// No description provided for @repeater_enterCommandFirst.
  ///
  /// In en, this message translates to:
  /// **'Enter a command first'**
  String get repeater_enterCommandFirst;

  /// No description provided for @repeater_cliCommandFrameTitle.
  ///
  /// In en, this message translates to:
  /// **'CLI Command Frame'**
  String get repeater_cliCommandFrameTitle;

  /// No description provided for @repeater_cliCommandError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String repeater_cliCommandError(String error);

  /// No description provided for @repeater_cliQuickGetName.
  ///
  /// In en, this message translates to:
  /// **'Get Name'**
  String get repeater_cliQuickGetName;

  /// No description provided for @repeater_cliQuickGetRadio.
  ///
  /// In en, this message translates to:
  /// **'Get Radio'**
  String get repeater_cliQuickGetRadio;

  /// No description provided for @repeater_cliQuickGetTx.
  ///
  /// In en, this message translates to:
  /// **'Get TX'**
  String get repeater_cliQuickGetTx;

  /// No description provided for @repeater_cliQuickNeighbors.
  ///
  /// In en, this message translates to:
  /// **'Neighbors'**
  String get repeater_cliQuickNeighbors;

  /// No description provided for @repeater_cliQuickVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get repeater_cliQuickVersion;

  /// No description provided for @repeater_cliQuickAdvertise.
  ///
  /// In en, this message translates to:
  /// **'Advertise'**
  String get repeater_cliQuickAdvertise;

  /// No description provided for @repeater_cliQuickClock.
  ///
  /// In en, this message translates to:
  /// **'Clock'**
  String get repeater_cliQuickClock;

  /// No description provided for @repeater_cliQuickClockSync.
  ///
  /// In en, this message translates to:
  /// **'Clock Sync'**
  String get repeater_cliQuickClockSync;

  /// No description provided for @repeater_cliQuickDiscovery.
  ///
  /// In en, this message translates to:
  /// **'Discover Neighbors'**
  String get repeater_cliQuickDiscovery;

  /// No description provided for @repeater_cliHelpAdvert.
  ///
  /// In en, this message translates to:
  /// **'Sends an advertisement packet'**
  String get repeater_cliHelpAdvert;

  /// No description provided for @repeater_cliHelpReboot.
  ///
  /// In en, this message translates to:
  /// **'Reboots the device. (note, you\'ll prob get \'Timeout\' which is normal)'**
  String get repeater_cliHelpReboot;

  /// No description provided for @repeater_cliHelpClock.
  ///
  /// In en, this message translates to:
  /// **'Displays current time per device\'s clock.'**
  String get repeater_cliHelpClock;

  /// No description provided for @repeater_cliHelpPassword.
  ///
  /// In en, this message translates to:
  /// **'Sets a new admin password for the device.'**
  String get repeater_cliHelpPassword;

  /// No description provided for @repeater_cliHelpVersion.
  ///
  /// In en, this message translates to:
  /// **'Shows the device version and firmware build date.'**
  String get repeater_cliHelpVersion;

  /// No description provided for @repeater_cliHelpClearStats.
  ///
  /// In en, this message translates to:
  /// **'Resets various stats counters to zero.'**
  String get repeater_cliHelpClearStats;

  /// No description provided for @repeater_cliHelpSetAf.
  ///
  /// In en, this message translates to:
  /// **'Sets the air-time-factor.'**
  String get repeater_cliHelpSetAf;

  /// No description provided for @repeater_cliHelpSetTx.
  ///
  /// In en, this message translates to:
  /// **'Sets LoRa transmit power in dBm. (reboot to apply)'**
  String get repeater_cliHelpSetTx;

  /// No description provided for @repeater_cliHelpSetRepeat.
  ///
  /// In en, this message translates to:
  /// **'Enables or disables the repeater role for this node.'**
  String get repeater_cliHelpSetRepeat;

  /// No description provided for @repeater_cliHelpSetAllowReadOnly.
  ///
  /// In en, this message translates to:
  /// **'(Room server) If \'on\', then login in blank password will be allowed, but cannot Post to room. (just read only)'**
  String get repeater_cliHelpSetAllowReadOnly;

  /// No description provided for @repeater_cliHelpSetFloodMax.
  ///
  /// In en, this message translates to:
  /// **'Sets the maximum number of hops of inbound flood packet (if >= max, packet is not forwarded)'**
  String get repeater_cliHelpSetFloodMax;

  /// No description provided for @repeater_cliHelpSetIntThresh.
  ///
  /// In en, this message translates to:
  /// **'Sets the Interference Threshold (in DB). Default is 14. Set to 0 to disable channel interference detection.'**
  String get repeater_cliHelpSetIntThresh;

  /// No description provided for @repeater_cliHelpSetAgcResetInterval.
  ///
  /// In en, this message translates to:
  /// **'Sets the interval to reset the Auto Gain Controller. Set to 0 to disable.'**
  String get repeater_cliHelpSetAgcResetInterval;

  /// No description provided for @repeater_cliHelpSetMultiAcks.
  ///
  /// In en, this message translates to:
  /// **'Enables or disables the \'double ACKs\' feature.'**
  String get repeater_cliHelpSetMultiAcks;

  /// No description provided for @repeater_cliHelpSetAdvertInterval.
  ///
  /// In en, this message translates to:
  /// **'Sets the timer interval in minutes to send a local (zero-hop) advertisement packet. Set to 0 to disable.'**
  String get repeater_cliHelpSetAdvertInterval;

  /// No description provided for @repeater_cliHelpSetFloodAdvertInterval.
  ///
  /// In en, this message translates to:
  /// **'Sets the timer interval in hours to send a flood advertisement packet. Set to 0 to disable.'**
  String get repeater_cliHelpSetFloodAdvertInterval;

  /// No description provided for @repeater_cliHelpSetGuestPassword.
  ///
  /// In en, this message translates to:
  /// **'Sets/updates the guest password. (for repeaters, guest logins can send the \"Get Stats\" request)'**
  String get repeater_cliHelpSetGuestPassword;

  /// No description provided for @repeater_cliHelpSetName.
  ///
  /// In en, this message translates to:
  /// **'Sets the advertisement name.'**
  String get repeater_cliHelpSetName;

  /// No description provided for @repeater_cliHelpSetLat.
  ///
  /// In en, this message translates to:
  /// **'Sets the advertisement map latitude. (decimal degrees)'**
  String get repeater_cliHelpSetLat;

  /// No description provided for @repeater_cliHelpSetLon.
  ///
  /// In en, this message translates to:
  /// **'Sets the advertisement map longitude. (decimal degrees)'**
  String get repeater_cliHelpSetLon;

  /// No description provided for @repeater_cliHelpSetRadio.
  ///
  /// In en, this message translates to:
  /// **'Sets completely new radio params, and saves to preferences. Requires a \"reboot\" command to apply.'**
  String get repeater_cliHelpSetRadio;

  /// No description provided for @repeater_cliHelpSetRxDelay.
  ///
  /// In en, this message translates to:
  /// **'Sets (experimental) base (must be > 1 for effect) for applying slight delay to received packets, based on signal strength/score. Set to 0 to disable.'**
  String get repeater_cliHelpSetRxDelay;

  /// No description provided for @repeater_cliHelpSetTxDelay.
  ///
  /// In en, this message translates to:
  /// **'Sets a factor multiplied with time-on-air for a flood-mode packet and with a randomized slot system, to delay its forwarding. (to decrease likelihood of collisions)'**
  String get repeater_cliHelpSetTxDelay;

  /// No description provided for @repeater_cliHelpSetDirectTxDelay.
  ///
  /// In en, this message translates to:
  /// **'Same as txdelay, but for applying a random delay to the forwarding of direct-mode packets.'**
  String get repeater_cliHelpSetDirectTxDelay;

  /// No description provided for @repeater_cliHelpSetBridgeEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enable/Disable bridge.'**
  String get repeater_cliHelpSetBridgeEnabled;

  /// No description provided for @repeater_cliHelpSetBridgeDelay.
  ///
  /// In en, this message translates to:
  /// **'Set delay before retransmitting packets.'**
  String get repeater_cliHelpSetBridgeDelay;

  /// No description provided for @repeater_cliHelpSetBridgeSource.
  ///
  /// In en, this message translates to:
  /// **'Choose wether the bridge will retransmit received packets or transmitted packets.'**
  String get repeater_cliHelpSetBridgeSource;

  /// No description provided for @repeater_cliHelpSetBridgeBaud.
  ///
  /// In en, this message translates to:
  /// **'Set serial link baudrate for rs232 bridges.'**
  String get repeater_cliHelpSetBridgeBaud;

  /// No description provided for @repeater_cliHelpSetBridgeSecret.
  ///
  /// In en, this message translates to:
  /// **'Set bridge secret for espnow bridges.'**
  String get repeater_cliHelpSetBridgeSecret;

  /// No description provided for @repeater_cliHelpSetAdcMultiplier.
  ///
  /// In en, this message translates to:
  /// **'Sets custom factor to adjust reported battery voltage (only supported on select boards).'**
  String get repeater_cliHelpSetAdcMultiplier;

  /// No description provided for @repeater_cliHelpTempRadio.
  ///
  /// In en, this message translates to:
  /// **'Sets temporary radio params for the given number of minutes, reverting to original radio params afterward. (does NOT save to preferences).'**
  String get repeater_cliHelpTempRadio;

  /// No description provided for @repeater_cliHelpSetPerm.
  ///
  /// In en, this message translates to:
  /// **'Modifies the ACL. Removes matching entry (by pubkey prefix) if \"permissions\" is zero. Adds new entry if pubkey-hex is full length and is not currently in ACL. Updates entry by matching pubkey prefix. Permission bits vary per firmware role, but low 2 bits are: 0 (Guest), 1 (Read only), 2 (Read write), 3 (Admin)'**
  String get repeater_cliHelpSetPerm;

  /// No description provided for @repeater_cliHelpGetBridgeType.
  ///
  /// In en, this message translates to:
  /// **'Gets bridge type none, rs232, espnow'**
  String get repeater_cliHelpGetBridgeType;

  /// No description provided for @repeater_cliHelpLogStart.
  ///
  /// In en, this message translates to:
  /// **'Starts packet logging to file system.'**
  String get repeater_cliHelpLogStart;

  /// No description provided for @repeater_cliHelpLogStop.
  ///
  /// In en, this message translates to:
  /// **'Stops packet logging to file system.'**
  String get repeater_cliHelpLogStop;

  /// No description provided for @repeater_cliHelpLogErase.
  ///
  /// In en, this message translates to:
  /// **'Erases the packet logs from file system.'**
  String get repeater_cliHelpLogErase;

  /// No description provided for @repeater_cliHelpNeighbors.
  ///
  /// In en, this message translates to:
  /// **'Shows a list of other repeater nodes heard via zero-hop adverts. Each line is id-prefix-hex:timestamp:snr-times-4'**
  String get repeater_cliHelpNeighbors;

  /// No description provided for @repeater_cliHelpNeighborRemove.
  ///
  /// In en, this message translates to:
  /// **'Removes first matching entry (by pubkey prefix (hex)), from neighbors list.'**
  String get repeater_cliHelpNeighborRemove;

  /// No description provided for @repeater_cliHelpRegion.
  ///
  /// In en, this message translates to:
  /// **'(serial only) Lists all defined regions and current flood permissions.'**
  String get repeater_cliHelpRegion;

  /// No description provided for @repeater_cliHelpRegionLoad.
  ///
  /// In en, this message translates to:
  /// **'NOTE: this is a special multi-command invocation. Each subsequent command is a region name (indented with spaces to indicate parent hierarchy, with one space at minimum). Terminated by sending a blank line/command.'**
  String get repeater_cliHelpRegionLoad;

  /// No description provided for @repeater_cliHelpRegionGet.
  ///
  /// In en, this message translates to:
  /// **'Searches for region with given name prefix (or \"*\" for the global scope). Replies with \"-> region-name (parent-name) \'F\'\"'**
  String get repeater_cliHelpRegionGet;

  /// No description provided for @repeater_cliHelpRegionPut.
  ///
  /// In en, this message translates to:
  /// **'Adds or updates a region definition with given name.'**
  String get repeater_cliHelpRegionPut;

  /// No description provided for @repeater_cliHelpRegionRemove.
  ///
  /// In en, this message translates to:
  /// **'Removes a region definition with given name. (must match exactly, and have no child regions)'**
  String get repeater_cliHelpRegionRemove;

  /// No description provided for @repeater_cliHelpRegionAllowf.
  ///
  /// In en, this message translates to:
  /// **'Sets the \'F\'lood permission for the given region. (\'*\' for the global/legacy scope)'**
  String get repeater_cliHelpRegionAllowf;

  /// No description provided for @repeater_cliHelpRegionDenyf.
  ///
  /// In en, this message translates to:
  /// **'Removes the \'F\'lood permission for the given region. (NOTE: at this stage NOT advised to use this on the global/legacy scope!!)'**
  String get repeater_cliHelpRegionDenyf;

  /// No description provided for @repeater_cliHelpRegionHome.
  ///
  /// In en, this message translates to:
  /// **'Replies with the current \'home\' region. (Note applied anywhere yet, reserved for future)'**
  String get repeater_cliHelpRegionHome;

  /// No description provided for @repeater_cliHelpRegionHomeSet.
  ///
  /// In en, this message translates to:
  /// **'Sets the \'home\' region.'**
  String get repeater_cliHelpRegionHomeSet;

  /// No description provided for @repeater_cliHelpRegionSave.
  ///
  /// In en, this message translates to:
  /// **'Persists the region list/map to storage.'**
  String get repeater_cliHelpRegionSave;

  /// No description provided for @repeater_cliHelpGps.
  ///
  /// In en, this message translates to:
  /// **'Gives status of gps. When gps is off, it replies only off, if on it replies with on, status, fix, sat count'**
  String get repeater_cliHelpGps;

  /// No description provided for @repeater_cliHelpGpsOnOff.
  ///
  /// In en, this message translates to:
  /// **'Toggles gps power state.'**
  String get repeater_cliHelpGpsOnOff;

  /// No description provided for @repeater_cliHelpGpsSync.
  ///
  /// In en, this message translates to:
  /// **'Syncs node time with gps clock.'**
  String get repeater_cliHelpGpsSync;

  /// No description provided for @repeater_cliHelpGpsSetLoc.
  ///
  /// In en, this message translates to:
  /// **'Sets node\'s position to gps coordinates and save preferences.'**
  String get repeater_cliHelpGpsSetLoc;

  /// No description provided for @repeater_cliHelpGpsAdvert.
  ///
  /// In en, this message translates to:
  /// **'Gives location advert configuration of the node:\n- none: don\'t include location in adverts\n- share: share gps location (from SensorManager)\n- prefs: advert the location stored in preferences'**
  String get repeater_cliHelpGpsAdvert;

  /// No description provided for @repeater_cliHelpGpsAdvertSet.
  ///
  /// In en, this message translates to:
  /// **'Sets location advert configuration.'**
  String get repeater_cliHelpGpsAdvertSet;

  /// No description provided for @repeater_commandsListTitle.
  ///
  /// In en, this message translates to:
  /// **'Commands List'**
  String get repeater_commandsListTitle;

  /// No description provided for @repeater_commandsListNote.
  ///
  /// In en, this message translates to:
  /// **'NOTE: for the various \"set ...\" commands, there is also a \"get ...\" command.'**
  String get repeater_commandsListNote;

  /// No description provided for @repeater_general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get repeater_general;

  /// No description provided for @repeater_settingsCategory.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get repeater_settingsCategory;

  /// No description provided for @repeater_bridge.
  ///
  /// In en, this message translates to:
  /// **'Bridge'**
  String get repeater_bridge;

  /// No description provided for @repeater_logging.
  ///
  /// In en, this message translates to:
  /// **'Logging'**
  String get repeater_logging;

  /// No description provided for @repeater_neighborsRepeaterOnly.
  ///
  /// In en, this message translates to:
  /// **'Neighbors (Repeater only)'**
  String get repeater_neighborsRepeaterOnly;

  /// No description provided for @repeater_regionManagementRepeaterOnly.
  ///
  /// In en, this message translates to:
  /// **'Region Management (Repeater only)'**
  String get repeater_regionManagementRepeaterOnly;

  /// No description provided for @repeater_regionNote.
  ///
  /// In en, this message translates to:
  /// **'Region commands have been introduced to manage region definitions and permissions.'**
  String get repeater_regionNote;

  /// No description provided for @repeater_gpsManagement.
  ///
  /// In en, this message translates to:
  /// **'GPS Management'**
  String get repeater_gpsManagement;

  /// No description provided for @repeater_gpsNote.
  ///
  /// In en, this message translates to:
  /// **'gps command has been introduced to manage location related topics.'**
  String get repeater_gpsNote;

  /// No description provided for @repeater_getCategory.
  ///
  /// In en, this message translates to:
  /// **'Get Values'**
  String get repeater_getCategory;

  /// No description provided for @repeater_powerMgmt.
  ///
  /// In en, this message translates to:
  /// **'Power Management'**
  String get repeater_powerMgmt;

  /// No description provided for @repeater_sensors.
  ///
  /// In en, this message translates to:
  /// **'Sensors'**
  String get repeater_sensors;

  /// No description provided for @repeater_cliHelpPowerOff.
  ///
  /// In en, this message translates to:
  /// **'Powers the device off. (no response expected)'**
  String get repeater_cliHelpPowerOff;

  /// No description provided for @repeater_cliHelpClkReboot.
  ///
  /// In en, this message translates to:
  /// **'Resets the clock to a known epoch and reboots the device.'**
  String get repeater_cliHelpClkReboot;

  /// No description provided for @repeater_cliHelpAdvertZeroHop.
  ///
  /// In en, this message translates to:
  /// **'Sends a zero-hop advertisement (immediate neighbors only).'**
  String get repeater_cliHelpAdvertZeroHop;

  /// No description provided for @repeater_cliHelpStartOta.
  ///
  /// In en, this message translates to:
  /// **'Starts an over-the-air firmware update on supported boards.'**
  String get repeater_cliHelpStartOta;

  /// No description provided for @repeater_cliHelpTime.
  ///
  /// In en, this message translates to:
  /// **'Sets the device clock to the given Unix epoch seconds. Clock cannot move backwards.'**
  String get repeater_cliHelpTime;

  /// No description provided for @repeater_cliHelpBoard.
  ///
  /// In en, this message translates to:
  /// **'Shows the board manufacturer / hardware identifier.'**
  String get repeater_cliHelpBoard;

  /// No description provided for @repeater_cliHelpDiscoverNeighbors.
  ///
  /// In en, this message translates to:
  /// **'Sends a node-discovery request to nearby neighbors. (Repeater only)'**
  String get repeater_cliHelpDiscoverNeighbors;

  /// No description provided for @repeater_cliHelpPowersaving.
  ///
  /// In en, this message translates to:
  /// **'Shows whether powersaving mode is on or off.'**
  String get repeater_cliHelpPowersaving;

  /// No description provided for @repeater_cliHelpPowersavingOnOff.
  ///
  /// In en, this message translates to:
  /// **'Enables or disables powersaving mode (where supported).'**
  String get repeater_cliHelpPowersavingOnOff;

  /// No description provided for @repeater_cliHelpErase.
  ///
  /// In en, this message translates to:
  /// **'(Serial only) Formats the device file system. Wipes all settings and contacts.'**
  String get repeater_cliHelpErase;

  /// No description provided for @repeater_cliHelpSetDutyCycle.
  ///
  /// In en, this message translates to:
  /// **'Sets the maximum allowed transmit duty cycle as a percentage (1-100). Internally adjusts the airtime factor.'**
  String get repeater_cliHelpSetDutyCycle;

  /// No description provided for @repeater_cliHelpSetPrvKey.
  ///
  /// In en, this message translates to:
  /// **'Replaces the device identity private key. Reboot required to apply. Generates a new public key.'**
  String get repeater_cliHelpSetPrvKey;

  /// No description provided for @repeater_cliHelpSetRadioRxGain.
  ///
  /// In en, this message translates to:
  /// **'(SX126x only) Toggles boosted RX gain for improved sensitivity at higher current draw.'**
  String get repeater_cliHelpSetRadioRxGain;

  /// No description provided for @repeater_cliHelpSetOwnerInfo.
  ///
  /// In en, this message translates to:
  /// **'Sets the owner contact info string included in adverts. Use \'|\' for newlines.'**
  String get repeater_cliHelpSetOwnerInfo;

  /// No description provided for @repeater_cliHelpSetPathHashMode.
  ///
  /// In en, this message translates to:
  /// **'Sets the path-hash mode. 0 = legacy, 1 = standard, 2 = strict. Affects how routing paths are matched.'**
  String get repeater_cliHelpSetPathHashMode;

  /// No description provided for @repeater_cliHelpSetLoopDetect.
  ///
  /// In en, this message translates to:
  /// **'Sets the routing loop-detection sensitivity: off, minimal, moderate, or strict.'**
  String get repeater_cliHelpSetLoopDetect;

  /// No description provided for @repeater_cliHelpSetFreq.
  ///
  /// In en, this message translates to:
  /// **'(Serial only) Quickly sets just the frequency. Reboot required. Prefer \"set radio\" for full radio params.'**
  String get repeater_cliHelpSetFreq;

  /// No description provided for @repeater_cliHelpSetBridgeChannel.
  ///
  /// In en, this message translates to:
  /// **'(ESPNow bridge only) Sets the WiFi channel (1-14) used by the bridge.'**
  String get repeater_cliHelpSetBridgeChannel;

  /// No description provided for @repeater_cliHelpGetName.
  ///
  /// In en, this message translates to:
  /// **'Shows the configured node name.'**
  String get repeater_cliHelpGetName;

  /// No description provided for @repeater_cliHelpGetRole.
  ///
  /// In en, this message translates to:
  /// **'Shows the firmware role (Repeater, Room Server, etc.).'**
  String get repeater_cliHelpGetRole;

  /// No description provided for @repeater_cliHelpGetPublicKey.
  ///
  /// In en, this message translates to:
  /// **'Shows the device public key.'**
  String get repeater_cliHelpGetPublicKey;

  /// No description provided for @repeater_cliHelpGetPrvKey.
  ///
  /// In en, this message translates to:
  /// **'(Serial only) Shows the device private key. Treat as a secret.'**
  String get repeater_cliHelpGetPrvKey;

  /// No description provided for @repeater_cliHelpGetRepeat.
  ///
  /// In en, this message translates to:
  /// **'Shows whether packet forwarding (repeater role) is on or off.'**
  String get repeater_cliHelpGetRepeat;

  /// No description provided for @repeater_cliHelpGetTx.
  ///
  /// In en, this message translates to:
  /// **'Shows the current TX power in dBm.'**
  String get repeater_cliHelpGetTx;

  /// No description provided for @repeater_cliHelpGetFreq.
  ///
  /// In en, this message translates to:
  /// **'Shows the configured radio frequency in MHz.'**
  String get repeater_cliHelpGetFreq;

  /// No description provided for @repeater_cliHelpGetRadio.
  ///
  /// In en, this message translates to:
  /// **'Shows full radio params: freq, bandwidth, spreading factor, coding rate.'**
  String get repeater_cliHelpGetRadio;

  /// No description provided for @repeater_cliHelpGetRadioRxGain.
  ///
  /// In en, this message translates to:
  /// **'(SX126x only) Shows the RX boosted gain state.'**
  String get repeater_cliHelpGetRadioRxGain;

  /// No description provided for @repeater_cliHelpGetAf.
  ///
  /// In en, this message translates to:
  /// **'Shows the current airtime factor.'**
  String get repeater_cliHelpGetAf;

  /// No description provided for @repeater_cliHelpGetDutyCycle.
  ///
  /// In en, this message translates to:
  /// **'Shows the current allowed duty cycle as a percentage.'**
  String get repeater_cliHelpGetDutyCycle;

  /// No description provided for @repeater_cliHelpGetIntThresh.
  ///
  /// In en, this message translates to:
  /// **'Shows the channel interference threshold in dB.'**
  String get repeater_cliHelpGetIntThresh;

  /// No description provided for @repeater_cliHelpGetAgcResetInterval.
  ///
  /// In en, this message translates to:
  /// **'Shows the AGC reset interval in seconds.'**
  String get repeater_cliHelpGetAgcResetInterval;

  /// No description provided for @repeater_cliHelpGetMultiAcks.
  ///
  /// In en, this message translates to:
  /// **'Shows whether double-ACK mode is on (1) or off (0).'**
  String get repeater_cliHelpGetMultiAcks;

  /// No description provided for @repeater_cliHelpGetAllowReadOnly.
  ///
  /// In en, this message translates to:
  /// **'Shows whether guest read-only access is allowed.'**
  String get repeater_cliHelpGetAllowReadOnly;

  /// No description provided for @repeater_cliHelpGetAdvertInterval.
  ///
  /// In en, this message translates to:
  /// **'Shows the local advertisement interval in minutes.'**
  String get repeater_cliHelpGetAdvertInterval;

  /// No description provided for @repeater_cliHelpGetFloodAdvertInterval.
  ///
  /// In en, this message translates to:
  /// **'Shows the flood advertisement interval in hours.'**
  String get repeater_cliHelpGetFloodAdvertInterval;

  /// No description provided for @repeater_cliHelpGetGuestPassword.
  ///
  /// In en, this message translates to:
  /// **'Shows the configured guest password.'**
  String get repeater_cliHelpGetGuestPassword;

  /// No description provided for @repeater_cliHelpGetLat.
  ///
  /// In en, this message translates to:
  /// **'Shows the configured latitude.'**
  String get repeater_cliHelpGetLat;

  /// No description provided for @repeater_cliHelpGetLon.
  ///
  /// In en, this message translates to:
  /// **'Shows the configured longitude.'**
  String get repeater_cliHelpGetLon;

  /// No description provided for @repeater_cliHelpGetRxDelay.
  ///
  /// In en, this message translates to:
  /// **'Shows the rxdelay base value.'**
  String get repeater_cliHelpGetRxDelay;

  /// No description provided for @repeater_cliHelpGetTxDelay.
  ///
  /// In en, this message translates to:
  /// **'Shows the flood-mode txdelay factor.'**
  String get repeater_cliHelpGetTxDelay;

  /// No description provided for @repeater_cliHelpGetDirectTxDelay.
  ///
  /// In en, this message translates to:
  /// **'Shows the direct-mode txdelay factor.'**
  String get repeater_cliHelpGetDirectTxDelay;

  /// No description provided for @repeater_cliHelpGetFloodMax.
  ///
  /// In en, this message translates to:
  /// **'Shows the maximum flood hop count.'**
  String get repeater_cliHelpGetFloodMax;

  /// No description provided for @repeater_cliHelpGetOwnerInfo.
  ///
  /// In en, this message translates to:
  /// **'Shows the owner contact info string.'**
  String get repeater_cliHelpGetOwnerInfo;

  /// No description provided for @repeater_cliHelpGetPathHashMode.
  ///
  /// In en, this message translates to:
  /// **'Shows the path-hash mode (0/1/2).'**
  String get repeater_cliHelpGetPathHashMode;

  /// No description provided for @repeater_cliHelpGetLoopDetect.
  ///
  /// In en, this message translates to:
  /// **'Shows the loop-detection sensitivity.'**
  String get repeater_cliHelpGetLoopDetect;

  /// No description provided for @repeater_cliHelpGetAcl.
  ///
  /// In en, this message translates to:
  /// **'(Serial only) Lists the access-control entries on a repeater.'**
  String get repeater_cliHelpGetAcl;

  /// No description provided for @repeater_cliHelpGetBridgeEnabled.
  ///
  /// In en, this message translates to:
  /// **'Shows whether the bridge is enabled.'**
  String get repeater_cliHelpGetBridgeEnabled;

  /// No description provided for @repeater_cliHelpGetBridgeDelay.
  ///
  /// In en, this message translates to:
  /// **'Shows the bridge delay in ms.'**
  String get repeater_cliHelpGetBridgeDelay;

  /// No description provided for @repeater_cliHelpGetBridgeSource.
  ///
  /// In en, this message translates to:
  /// **'Shows whether the bridge logs RX or TX packets.'**
  String get repeater_cliHelpGetBridgeSource;

  /// No description provided for @repeater_cliHelpGetBridgeBaud.
  ///
  /// In en, this message translates to:
  /// **'(RS232 bridge only) Shows the bridge baud rate.'**
  String get repeater_cliHelpGetBridgeBaud;

  /// No description provided for @repeater_cliHelpGetBridgeChannel.
  ///
  /// In en, this message translates to:
  /// **'(ESPNow bridge only) Shows the bridge WiFi channel.'**
  String get repeater_cliHelpGetBridgeChannel;

  /// No description provided for @repeater_cliHelpGetBridgeSecret.
  ///
  /// In en, this message translates to:
  /// **'(ESPNow bridge only) Shows the bridge shared secret.'**
  String get repeater_cliHelpGetBridgeSecret;

  /// No description provided for @repeater_cliHelpGetBootloaderVer.
  ///
  /// In en, this message translates to:
  /// **'(NRF52 only) Shows the bootloader version.'**
  String get repeater_cliHelpGetBootloaderVer;

  /// No description provided for @repeater_cliHelpGetAdcMultiplier.
  ///
  /// In en, this message translates to:
  /// **'Shows the ADC multiplier (battery-voltage scaling).'**
  String get repeater_cliHelpGetAdcMultiplier;

  /// No description provided for @repeater_cliHelpGetPwrMgtSupport.
  ///
  /// In en, this message translates to:
  /// **'Reports whether the board has power-management support.'**
  String get repeater_cliHelpGetPwrMgtSupport;

  /// No description provided for @repeater_cliHelpGetPwrMgtSource.
  ///
  /// In en, this message translates to:
  /// **'Shows the current power source: external or battery.'**
  String get repeater_cliHelpGetPwrMgtSource;

  /// No description provided for @repeater_cliHelpGetPwrMgtBootReason.
  ///
  /// In en, this message translates to:
  /// **'Shows the most recent reset and shutdown reasons.'**
  String get repeater_cliHelpGetPwrMgtBootReason;

  /// No description provided for @repeater_cliHelpGetPwrMgtBootMv.
  ///
  /// In en, this message translates to:
  /// **'Shows the boot-time battery voltage in mV.'**
  String get repeater_cliHelpGetPwrMgtBootMv;

  /// No description provided for @repeater_cliHelpSensorGet.
  ///
  /// In en, this message translates to:
  /// **'Reads a custom sensor setting by key.'**
  String get repeater_cliHelpSensorGet;

  /// No description provided for @repeater_cliHelpSensorSet.
  ///
  /// In en, this message translates to:
  /// **'Writes a custom sensor setting.'**
  String get repeater_cliHelpSensorSet;

  /// No description provided for @repeater_cliHelpSensorList.
  ///
  /// In en, this message translates to:
  /// **'Lists all custom sensor settings, paginated from optional start index.'**
  String get repeater_cliHelpSensorList;

  /// No description provided for @repeater_cliHelpRegionDefault.
  ///
  /// In en, this message translates to:
  /// **'Shows the current default region scope.'**
  String get repeater_cliHelpRegionDefault;

  /// No description provided for @repeater_cliHelpRegionDefaultSet.
  ///
  /// In en, this message translates to:
  /// **'Sets the default region scope. Use \"<null>\" to clear.'**
  String get repeater_cliHelpRegionDefaultSet;

  /// No description provided for @repeater_cliHelpRegionListAllowed.
  ///
  /// In en, this message translates to:
  /// **'Lists regions that allow flood traffic.'**
  String get repeater_cliHelpRegionListAllowed;

  /// No description provided for @repeater_cliHelpRegionListDenied.
  ///
  /// In en, this message translates to:
  /// **'Lists regions that deny flood traffic.'**
  String get repeater_cliHelpRegionListDenied;

  /// No description provided for @repeater_cliHelpStatsPackets.
  ///
  /// In en, this message translates to:
  /// **'(Serial only) Shows packet-level statistics.'**
  String get repeater_cliHelpStatsPackets;

  /// No description provided for @repeater_cliHelpStatsRadio.
  ///
  /// In en, this message translates to:
  /// **'(Serial only) Shows radio statistics.'**
  String get repeater_cliHelpStatsRadio;

  /// No description provided for @repeater_cliHelpStatsCore.
  ///
  /// In en, this message translates to:
  /// **'(Serial only) Shows core firmware statistics.'**
  String get repeater_cliHelpStatsCore;

  /// No description provided for @telemetry_receivedData.
  ///
  /// In en, this message translates to:
  /// **'Received Telemetry Data'**
  String get telemetry_receivedData;

  /// No description provided for @telemetry_requestTimeout.
  ///
  /// In en, this message translates to:
  /// **'Telemetry request timed out.'**
  String get telemetry_requestTimeout;

  /// No description provided for @telemetry_errorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading telemetry: {error}'**
  String telemetry_errorLoading(String error);

  /// No description provided for @telemetry_noData.
  ///
  /// In en, this message translates to:
  /// **'No telemetry data available.'**
  String get telemetry_noData;

  /// No description provided for @telemetry_channelTitle.
  ///
  /// In en, this message translates to:
  /// **'Channel {channel}'**
  String telemetry_channelTitle(int channel);

  /// No description provided for @telemetry_batteryLabel.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get telemetry_batteryLabel;

  /// No description provided for @telemetry_voltageLabel.
  ///
  /// In en, this message translates to:
  /// **'Voltage'**
  String get telemetry_voltageLabel;

  /// No description provided for @telemetry_mcuTemperatureLabel.
  ///
  /// In en, this message translates to:
  /// **'MCU Temperature'**
  String get telemetry_mcuTemperatureLabel;

  /// No description provided for @telemetry_temperatureLabel.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get telemetry_temperatureLabel;

  /// No description provided for @telemetry_currentLabel.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get telemetry_currentLabel;

  /// No description provided for @telemetry_batteryValue.
  ///
  /// In en, this message translates to:
  /// **'{percent}% / {volts}V'**
  String telemetry_batteryValue(int percent, String volts);

  /// No description provided for @telemetry_voltageValue.
  ///
  /// In en, this message translates to:
  /// **'{volts}V'**
  String telemetry_voltageValue(String volts);

  /// No description provided for @telemetry_currentValue.
  ///
  /// In en, this message translates to:
  /// **'{amps}A'**
  String telemetry_currentValue(String amps);

  /// No description provided for @telemetry_temperatureValue.
  ///
  /// In en, this message translates to:
  /// **'{celsius}°C / {fahrenheit}°F'**
  String telemetry_temperatureValue(String celsius, String fahrenheit);

  /// No description provided for @telemetry_digitalInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Digital Input'**
  String get telemetry_digitalInputLabel;

  /// No description provided for @telemetry_digitalOutputLabel.
  ///
  /// In en, this message translates to:
  /// **'Digital Output'**
  String get telemetry_digitalOutputLabel;

  /// No description provided for @telemetry_analogInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Analog Input'**
  String get telemetry_analogInputLabel;

  /// No description provided for @telemetry_analogOutputLabel.
  ///
  /// In en, this message translates to:
  /// **'Analog Output'**
  String get telemetry_analogOutputLabel;

  /// No description provided for @telemetry_genericLabel.
  ///
  /// In en, this message translates to:
  /// **'Generic Sensor'**
  String get telemetry_genericLabel;

  /// No description provided for @telemetry_luminosityLabel.
  ///
  /// In en, this message translates to:
  /// **'Luminosity'**
  String get telemetry_luminosityLabel;

  /// No description provided for @telemetry_presenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Presence'**
  String get telemetry_presenceLabel;

  /// No description provided for @telemetry_humidityLabel.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get telemetry_humidityLabel;

  /// No description provided for @telemetry_accelerometerLabel.
  ///
  /// In en, this message translates to:
  /// **'Accelerometer'**
  String get telemetry_accelerometerLabel;

  /// No description provided for @telemetry_pressureLabel.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get telemetry_pressureLabel;

  /// No description provided for @telemetry_altitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get telemetry_altitudeLabel;

  /// No description provided for @telemetry_frequencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get telemetry_frequencyLabel;

  /// No description provided for @telemetry_percentageLabel.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get telemetry_percentageLabel;

  /// No description provided for @telemetry_concentrationLabel.
  ///
  /// In en, this message translates to:
  /// **'Concentration'**
  String get telemetry_concentrationLabel;

  /// No description provided for @telemetry_powerLabel.
  ///
  /// In en, this message translates to:
  /// **'Power'**
  String get telemetry_powerLabel;

  /// No description provided for @telemetry_distanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get telemetry_distanceLabel;

  /// No description provided for @telemetry_energyLabel.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get telemetry_energyLabel;

  /// No description provided for @telemetry_directionLabel.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get telemetry_directionLabel;

  /// No description provided for @telemetry_timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get telemetry_timeLabel;

  /// No description provided for @telemetry_gyrometerLabel.
  ///
  /// In en, this message translates to:
  /// **'Gyrometer'**
  String get telemetry_gyrometerLabel;

  /// No description provided for @telemetry_colourLabel.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get telemetry_colourLabel;

  /// No description provided for @telemetry_gpsLabel.
  ///
  /// In en, this message translates to:
  /// **'GPS'**
  String get telemetry_gpsLabel;

  /// No description provided for @telemetry_switchLabel.
  ///
  /// In en, this message translates to:
  /// **'Switch'**
  String get telemetry_switchLabel;

  /// No description provided for @telemetry_polylineLabel.
  ///
  /// In en, this message translates to:
  /// **'Polyline'**
  String get telemetry_polylineLabel;

  /// No description provided for @telemetry_altitudeValue.
  ///
  /// In en, this message translates to:
  /// **'{meters} m'**
  String telemetry_altitudeValue(String meters);

  /// No description provided for @telemetry_frequencyValue.
  ///
  /// In en, this message translates to:
  /// **'{hertz} Hz'**
  String telemetry_frequencyValue(String hertz);

  /// No description provided for @telemetry_pressureValue.
  ///
  /// In en, this message translates to:
  /// **'{hpa} hPa'**
  String telemetry_pressureValue(String hpa);

  /// No description provided for @telemetry_luminosityValue.
  ///
  /// In en, this message translates to:
  /// **'{lux} lx'**
  String telemetry_luminosityValue(String lux);

  /// No description provided for @telemetry_powerValue.
  ///
  /// In en, this message translates to:
  /// **'{watts} W'**
  String telemetry_powerValue(String watts);

  /// No description provided for @telemetry_distanceValue.
  ///
  /// In en, this message translates to:
  /// **'{meters} m'**
  String telemetry_distanceValue(String meters);

  /// No description provided for @telemetry_energyValue.
  ///
  /// In en, this message translates to:
  /// **'{kilowattHours} kWh'**
  String telemetry_energyValue(String kilowattHours);

  /// No description provided for @telemetry_directionValue.
  ///
  /// In en, this message translates to:
  /// **'{degrees}°'**
  String telemetry_directionValue(String degrees);

  /// No description provided for @telemetry_concentrationValue.
  ///
  /// In en, this message translates to:
  /// **'{ppm} ppm'**
  String telemetry_concentrationValue(String ppm);

  /// No description provided for @telemetry_percentageValue.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String telemetry_percentageValue(String percent);

  /// No description provided for @telemetry_analogValue.
  ///
  /// In en, this message translates to:
  /// **'{value}'**
  String telemetry_analogValue(String value);

  /// No description provided for @telemetry_autoFetchQuantity.
  ///
  /// In en, this message translates to:
  /// **'Requests quantity'**
  String get telemetry_autoFetchQuantity;

  /// No description provided for @telemetry_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to retrieve data'**
  String get telemetry_error;

  /// No description provided for @neighbors_receivedData.
  ///
  /// In en, this message translates to:
  /// **'Received Neighbors Data'**
  String get neighbors_receivedData;

  /// No description provided for @neighbors_requestTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Neighbors request timed out.'**
  String get neighbors_requestTimedOut;

  /// No description provided for @neighbors_errorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading neighbors: {error}'**
  String neighbors_errorLoading(String error);

  /// No description provided for @neighbors_repeatersNeighbors.
  ///
  /// In en, this message translates to:
  /// **'Repeaters Neighbors'**
  String get neighbors_repeatersNeighbors;

  /// No description provided for @neighbors_noData.
  ///
  /// In en, this message translates to:
  /// **'No neighbors data available.'**
  String get neighbors_noData;

  /// No description provided for @neighbors_unknownContact.
  ///
  /// In en, this message translates to:
  /// **'Unknown {pubkey}'**
  String neighbors_unknownContact(String pubkey);

  /// No description provided for @neighbors_heardAgo.
  ///
  /// In en, this message translates to:
  /// **'Heard: {time} ago'**
  String neighbors_heardAgo(String time);

  /// No description provided for @channelPath_title.
  ///
  /// In en, this message translates to:
  /// **'Packet Path'**
  String get channelPath_title;

  /// No description provided for @channelPath_viewMap.
  ///
  /// In en, this message translates to:
  /// **'View map'**
  String get channelPath_viewMap;

  /// No description provided for @channelPath_otherObservedPaths.
  ///
  /// In en, this message translates to:
  /// **'Other Observed Paths'**
  String get channelPath_otherObservedPaths;

  /// No description provided for @channelPath_repeaterHops.
  ///
  /// In en, this message translates to:
  /// **'Repeater Hops'**
  String get channelPath_repeaterHops;

  /// No description provided for @channelPath_noHopDetails.
  ///
  /// In en, this message translates to:
  /// **'Hop details are not provided for this packet.'**
  String get channelPath_noHopDetails;

  /// No description provided for @channelPath_sourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get channelPath_sourceLabel;

  /// No description provided for @channelPath_sourceMqtt.
  ///
  /// In en, this message translates to:
  /// **'MQTT'**
  String get channelPath_sourceMqtt;

  /// No description provided for @channelPath_viaMqttNoRfPath.
  ///
  /// In en, this message translates to:
  /// **'This message arrived via MQTT. Your radio has not heard it, so there is no RF path from your radio.'**
  String get channelPath_viaMqttNoRfPath;

  /// No description provided for @channelPath_messageDetails.
  ///
  /// In en, this message translates to:
  /// **'Message Details'**
  String get channelPath_messageDetails;

  /// No description provided for @channelPath_senderLabel.
  ///
  /// In en, this message translates to:
  /// **'Sender'**
  String get channelPath_senderLabel;

  /// No description provided for @channelPath_timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get channelPath_timeLabel;

  /// No description provided for @channelPath_repeatsLabel.
  ///
  /// In en, this message translates to:
  /// **'Repeats'**
  String get channelPath_repeatsLabel;

  /// No description provided for @channelPath_pathLabel.
  ///
  /// In en, this message translates to:
  /// **'Path {index}'**
  String channelPath_pathLabel(int index);

  /// No description provided for @channelPath_observedLabel.
  ///
  /// In en, this message translates to:
  /// **'Observed'**
  String get channelPath_observedLabel;

  /// No description provided for @channelPath_observedPathTitle.
  ///
  /// In en, this message translates to:
  /// **'Observed path {index} • {hops}'**
  String channelPath_observedPathTitle(int index, String hops);

  /// No description provided for @channelPath_noLocationData.
  ///
  /// In en, this message translates to:
  /// **'No location data'**
  String get channelPath_noLocationData;

  /// No description provided for @channelPath_timeWithDate.
  ///
  /// In en, this message translates to:
  /// **'{day}/{month} {time}'**
  String channelPath_timeWithDate(int day, int month, String time);

  /// No description provided for @channelPath_timeOnly.
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String channelPath_timeOnly(String time);

  /// No description provided for @channelPath_unknownPath.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get channelPath_unknownPath;

  /// No description provided for @channelPath_floodPath.
  ///
  /// In en, this message translates to:
  /// **'Flood'**
  String get channelPath_floodPath;

  /// No description provided for @channelPath_directPath.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get channelPath_directPath;

  /// No description provided for @channelPath_observedZeroOf.
  ///
  /// In en, this message translates to:
  /// **'0 of {total} hops'**
  String channelPath_observedZeroOf(int total);

  /// No description provided for @channelPath_observedSomeOf.
  ///
  /// In en, this message translates to:
  /// **'{observed} of {total} hops'**
  String channelPath_observedSomeOf(int observed, int total);

  /// No description provided for @channelPath_mapTitle.
  ///
  /// In en, this message translates to:
  /// **'Path Map'**
  String get channelPath_mapTitle;

  /// No description provided for @channelPath_noRepeaterLocations.
  ///
  /// In en, this message translates to:
  /// **'No repeater locations available for this path.'**
  String get channelPath_noRepeaterLocations;

  /// No description provided for @channelPath_primaryPath.
  ///
  /// In en, this message translates to:
  /// **'Path {index} (Primary)'**
  String channelPath_primaryPath(int index);

  /// No description provided for @channelPath_pathLabelTitle.
  ///
  /// In en, this message translates to:
  /// **'Path'**
  String get channelPath_pathLabelTitle;

  /// No description provided for @channelPath_observedPathHeader.
  ///
  /// In en, this message translates to:
  /// **'Observed Path'**
  String get channelPath_observedPathHeader;

  /// No description provided for @channelPath_selectedPathLabel.
  ///
  /// In en, this message translates to:
  /// **'{label} • {prefixes}'**
  String channelPath_selectedPathLabel(String label, String prefixes);

  /// No description provided for @channelPath_noHopDetailsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No hop details available for this packet.'**
  String get channelPath_noHopDetailsAvailable;

  /// No description provided for @channelPath_unknownRepeater.
  ///
  /// In en, this message translates to:
  /// **'Unknown Repeater'**
  String get channelPath_unknownRepeater;

  /// No description provided for @community_title.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community_title;

  /// No description provided for @community_create.
  ///
  /// In en, this message translates to:
  /// **'Create Community'**
  String get community_create;

  /// No description provided for @community_createDesc.
  ///
  /// In en, this message translates to:
  /// **'Create a new community and share via QR code.'**
  String get community_createDesc;

  /// No description provided for @community_join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get community_join;

  /// No description provided for @community_joinTitle.
  ///
  /// In en, this message translates to:
  /// **'Join Community'**
  String get community_joinTitle;

  /// No description provided for @community_joinConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Do you want to join the community \"{name}\"?'**
  String community_joinConfirmation(String name);

  /// No description provided for @community_scanQr.
  ///
  /// In en, this message translates to:
  /// **'Scan Community QR'**
  String get community_scanQr;

  /// No description provided for @community_scanInstructions.
  ///
  /// In en, this message translates to:
  /// **'Point the camera at a community QR code'**
  String get community_scanInstructions;

  /// No description provided for @community_showQr.
  ///
  /// In en, this message translates to:
  /// **'Show QR Code'**
  String get community_showQr;

  /// No description provided for @community_publicChannel.
  ///
  /// In en, this message translates to:
  /// **'Community Public'**
  String get community_publicChannel;

  /// No description provided for @community_hashtagChannel.
  ///
  /// In en, this message translates to:
  /// **'Community Hashtag'**
  String get community_hashtagChannel;

  /// No description provided for @community_name.
  ///
  /// In en, this message translates to:
  /// **'Community Name'**
  String get community_name;

  /// No description provided for @community_enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter community name'**
  String get community_enterName;

  /// No description provided for @community_created.
  ///
  /// In en, this message translates to:
  /// **'Community \"{name}\" created'**
  String community_created(String name);

  /// No description provided for @community_joined.
  ///
  /// In en, this message translates to:
  /// **'Joined community \"{name}\"'**
  String community_joined(String name);

  /// No description provided for @community_qrTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Community'**
  String get community_qrTitle;

  /// No description provided for @community_qrInstructions.
  ///
  /// In en, this message translates to:
  /// **'Scan this QR code to join \"{name}\"'**
  String community_qrInstructions(String name);

  /// No description provided for @community_hashtagPrivacyHint.
  ///
  /// In en, this message translates to:
  /// **'Community hashtag channels are only joinable by members of the community'**
  String get community_hashtagPrivacyHint;

  /// No description provided for @community_invalidQrCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid community QR code'**
  String get community_invalidQrCode;

  /// No description provided for @community_alreadyMember.
  ///
  /// In en, this message translates to:
  /// **'Already a Member'**
  String get community_alreadyMember;

  /// No description provided for @community_alreadyMemberMessage.
  ///
  /// In en, this message translates to:
  /// **'You are already a member of \"{name}\".'**
  String community_alreadyMemberMessage(String name);

  /// No description provided for @community_addPublicChannel.
  ///
  /// In en, this message translates to:
  /// **'Add Community Public Channel'**
  String get community_addPublicChannel;

  /// No description provided for @community_addPublicChannelHint.
  ///
  /// In en, this message translates to:
  /// **'Automatically add the public channel for this community'**
  String get community_addPublicChannelHint;

  /// No description provided for @community_noCommunities.
  ///
  /// In en, this message translates to:
  /// **'No communities joined yet'**
  String get community_noCommunities;

  /// No description provided for @community_scanOrCreate.
  ///
  /// In en, this message translates to:
  /// **'Scan a QR code or create a community to get started'**
  String get community_scanOrCreate;

  /// No description provided for @community_manageCommunities.
  ///
  /// In en, this message translates to:
  /// **'Manage Communities'**
  String get community_manageCommunities;

  /// No description provided for @community_delete.
  ///
  /// In en, this message translates to:
  /// **'Leave Community'**
  String get community_delete;

  /// No description provided for @community_deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Leave \"{name}\"?'**
  String community_deleteConfirm(String name);

  /// No description provided for @community_deleteChannelsWarning.
  ///
  /// In en, this message translates to:
  /// **'This will also delete {count} channel(s) and their messages.'**
  String community_deleteChannelsWarning(int count);

  /// No description provided for @community_deleted.
  ///
  /// In en, this message translates to:
  /// **'Left community \"{name}\"'**
  String community_deleted(String name);

  /// No description provided for @community_regenerateSecret.
  ///
  /// In en, this message translates to:
  /// **'Regenerate Secret'**
  String get community_regenerateSecret;

  /// No description provided for @community_regenerateSecretConfirm.
  ///
  /// In en, this message translates to:
  /// **'Regenerate the secret key for \"{name}\"? All members will need to scan the new QR code to continue communicating.'**
  String community_regenerateSecretConfirm(String name);

  /// No description provided for @community_regenerate.
  ///
  /// In en, this message translates to:
  /// **'Regenerate'**
  String get community_regenerate;

  /// No description provided for @community_secretRegenerated.
  ///
  /// In en, this message translates to:
  /// **'Secret regenerated for \"{name}\"'**
  String community_secretRegenerated(String name);

  /// No description provided for @community_updateSecret.
  ///
  /// In en, this message translates to:
  /// **'Update Secret'**
  String get community_updateSecret;

  /// No description provided for @community_secretUpdated.
  ///
  /// In en, this message translates to:
  /// **'Secret updated for \"{name}\"'**
  String community_secretUpdated(String name);

  /// No description provided for @community_scanToUpdateSecret.
  ///
  /// In en, this message translates to:
  /// **'Scan the new QR code to update the secret for \"{name}\"'**
  String community_scanToUpdateSecret(String name);

  /// No description provided for @community_addHashtagChannel.
  ///
  /// In en, this message translates to:
  /// **'Add Community Hashtag'**
  String get community_addHashtagChannel;

  /// No description provided for @community_addHashtagChannelDesc.
  ///
  /// In en, this message translates to:
  /// **'Add a hashtag channel for this community'**
  String get community_addHashtagChannelDesc;

  /// No description provided for @community_selectCommunity.
  ///
  /// In en, this message translates to:
  /// **'Select Community'**
  String get community_selectCommunity;

  /// No description provided for @community_regularHashtag.
  ///
  /// In en, this message translates to:
  /// **'Regular Hashtag'**
  String get community_regularHashtag;

  /// No description provided for @community_regularHashtagDesc.
  ///
  /// In en, this message translates to:
  /// **'Public hashtag (anyone can join)'**
  String get community_regularHashtagDesc;

  /// No description provided for @community_communityHashtag.
  ///
  /// In en, this message translates to:
  /// **'Community Hashtag'**
  String get community_communityHashtag;

  /// No description provided for @community_communityHashtagDesc.
  ///
  /// In en, this message translates to:
  /// **'Private to community members'**
  String get community_communityHashtagDesc;

  /// No description provided for @community_forCommunity.
  ///
  /// In en, this message translates to:
  /// **'For {name}'**
  String community_forCommunity(String name);

  /// No description provided for @listFilter_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Filter and sort'**
  String get listFilter_tooltip;

  /// No description provided for @listFilter_sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get listFilter_sortBy;

  /// No description provided for @listFilter_latestMessages.
  ///
  /// In en, this message translates to:
  /// **'Latest messages'**
  String get listFilter_latestMessages;

  /// No description provided for @listFilter_heardRecently.
  ///
  /// In en, this message translates to:
  /// **'Heard recently'**
  String get listFilter_heardRecently;

  /// No description provided for @listFilter_az.
  ///
  /// In en, this message translates to:
  /// **'A-Z'**
  String get listFilter_az;

  /// No description provided for @listFilter_filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get listFilter_filters;

  /// No description provided for @listFilter_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get listFilter_all;

  /// No description provided for @listFilter_favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get listFilter_favorites;

  /// No description provided for @listFilter_addToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get listFilter_addToFavorites;

  /// No description provided for @listFilter_removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get listFilter_removeFromFavorites;

  /// No description provided for @listFilter_users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get listFilter_users;

  /// No description provided for @listFilter_repeaters.
  ///
  /// In en, this message translates to:
  /// **'Repeaters'**
  String get listFilter_repeaters;

  /// No description provided for @listFilter_roomServers.
  ///
  /// In en, this message translates to:
  /// **'Room servers'**
  String get listFilter_roomServers;

  /// No description provided for @listFilter_unreadOnly.
  ///
  /// In en, this message translates to:
  /// **'Unread only'**
  String get listFilter_unreadOnly;

  /// No description provided for @listFilter_newGroup.
  ///
  /// In en, this message translates to:
  /// **'New group'**
  String get listFilter_newGroup;

  /// No description provided for @pathTrace_you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get pathTrace_you;

  /// No description provided for @pathTrace_failed.
  ///
  /// In en, this message translates to:
  /// **'Path trace failed.'**
  String get pathTrace_failed;

  /// No description provided for @pathTrace_notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Path trace not available.'**
  String get pathTrace_notAvailable;

  /// No description provided for @pathTrace_refreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh Path Trace.'**
  String get pathTrace_refreshTooltip;

  /// No description provided for @pathTrace_someHopsNoLocation.
  ///
  /// In en, this message translates to:
  /// **'One or more of the hops is missing a location!'**
  String get pathTrace_someHopsNoLocation;

  /// No description provided for @pathTrace_clearTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear path.'**
  String get pathTrace_clearTooltip;

  /// No description provided for @losSelectStartEnd.
  ///
  /// In en, this message translates to:
  /// **'Select start and end nodes for LOS.'**
  String get losSelectStartEnd;

  /// No description provided for @losRunFailed.
  ///
  /// In en, this message translates to:
  /// **'Line-of-sight check failed: {error}'**
  String losRunFailed(String error);

  /// No description provided for @losClearAllPoints.
  ///
  /// In en, this message translates to:
  /// **'Clear all points'**
  String get losClearAllPoints;

  /// No description provided for @losRunToViewElevationProfile.
  ///
  /// In en, this message translates to:
  /// **'Run LOS to view elevation profile'**
  String get losRunToViewElevationProfile;

  /// No description provided for @losMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'LOS Menu'**
  String get losMenuTitle;

  /// No description provided for @losMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap nodes or long-press map for custom points'**
  String get losMenuSubtitle;

  /// No description provided for @losShowDisplayNodes.
  ///
  /// In en, this message translates to:
  /// **'Show display nodes'**
  String get losShowDisplayNodes;

  /// No description provided for @losCustomPoints.
  ///
  /// In en, this message translates to:
  /// **'Custom points'**
  String get losCustomPoints;

  /// No description provided for @losCustomPointLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom {index}'**
  String losCustomPointLabel(int index);

  /// No description provided for @losPointA.
  ///
  /// In en, this message translates to:
  /// **'Point A'**
  String get losPointA;

  /// No description provided for @losPointB.
  ///
  /// In en, this message translates to:
  /// **'Point B'**
  String get losPointB;

  /// No description provided for @losAntennaA.
  ///
  /// In en, this message translates to:
  /// **'Antenna A: {value} {unit}'**
  String losAntennaA(String value, String unit);

  /// No description provided for @losAntennaB.
  ///
  /// In en, this message translates to:
  /// **'Antenna B: {value} {unit}'**
  String losAntennaB(String value, String unit);

  /// No description provided for @losRun.
  ///
  /// In en, this message translates to:
  /// **'Run LOS'**
  String get losRun;

  /// No description provided for @losNoElevationData.
  ///
  /// In en, this message translates to:
  /// **'No elevation data'**
  String get losNoElevationData;

  /// No description provided for @losProfileClear.
  ///
  /// In en, this message translates to:
  /// **'{distance} {distanceUnit}, clear LOS, min clearance {clearance} {heightUnit}'**
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  );

  /// No description provided for @losProfileBlocked.
  ///
  /// In en, this message translates to:
  /// **'{distance} {distanceUnit}, blocked by {obstruction} {heightUnit}'**
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  );

  /// No description provided for @losStatusChecking.
  ///
  /// In en, this message translates to:
  /// **'LOS: checking...'**
  String get losStatusChecking;

  /// No description provided for @losStatusNoData.
  ///
  /// In en, this message translates to:
  /// **'LOS: no data'**
  String get losStatusNoData;

  /// No description provided for @losStatusSummary.
  ///
  /// In en, this message translates to:
  /// **'LOS: {clear}/{total} clear, {blocked} blocked, {unknown} unknown'**
  String losStatusSummary(int clear, int total, int blocked, int unknown);

  /// No description provided for @losErrorElevationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Elevation data unavailable for one or more samples.'**
  String get losErrorElevationUnavailable;

  /// No description provided for @losErrorInvalidInput.
  ///
  /// In en, this message translates to:
  /// **'Invalid points/elevation data for LOS calculation.'**
  String get losErrorInvalidInput;

  /// No description provided for @losRenameCustomPoint.
  ///
  /// In en, this message translates to:
  /// **'Rename custom point'**
  String get losRenameCustomPoint;

  /// No description provided for @losPointName.
  ///
  /// In en, this message translates to:
  /// **'Point name'**
  String get losPointName;

  /// No description provided for @losShowPanelTooltip.
  ///
  /// In en, this message translates to:
  /// **'Show LOS panel'**
  String get losShowPanelTooltip;

  /// No description provided for @losHidePanelTooltip.
  ///
  /// In en, this message translates to:
  /// **'Hide LOS panel'**
  String get losHidePanelTooltip;

  /// No description provided for @losElevationAttribution.
  ///
  /// In en, this message translates to:
  /// **'Elevation data: Open-Meteo (CC BY 4.0)'**
  String get losElevationAttribution;

  /// No description provided for @losLegendRadioHorizon.
  ///
  /// In en, this message translates to:
  /// **'Radio horizon'**
  String get losLegendRadioHorizon;

  /// No description provided for @losLegendLosBeam.
  ///
  /// In en, this message translates to:
  /// **'LOS beam'**
  String get losLegendLosBeam;

  /// No description provided for @losLegendTerrain.
  ///
  /// In en, this message translates to:
  /// **'Terrain'**
  String get losLegendTerrain;

  /// No description provided for @losBlockedSpotsTitle.
  ///
  /// In en, this message translates to:
  /// **'Blocked spots'**
  String get losBlockedSpotsTitle;

  /// No description provided for @losBlockedSpotsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a blocked spot to highlight it on the map.'**
  String get losBlockedSpotsHint;

  /// No description provided for @losBlockedSpotChip.
  ///
  /// In en, this message translates to:
  /// **'{distance} {distanceUnit} • {obstruction} {heightUnit}'**
  String losBlockedSpotChip(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  );

  /// No description provided for @losSelectedObstructionTitle.
  ///
  /// In en, this message translates to:
  /// **'Selected obstruction'**
  String get losSelectedObstructionTitle;

  /// No description provided for @losSelectedObstructionDetails.
  ///
  /// In en, this message translates to:
  /// **'Blocked by {obstruction} {heightUnit}, {distanceFromA} from A and {distanceFromB} from B ({distanceUnit}).'**
  String losSelectedObstructionDetails(
    String obstruction,
    String heightUnit,
    String distanceFromA,
    String distanceUnit,
    String distanceFromB,
  );

  /// No description provided for @losFrequencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get losFrequencyLabel;

  /// No description provided for @losFrequencyInfoTooltip.
  ///
  /// In en, this message translates to:
  /// **'View calculation details'**
  String get losFrequencyInfoTooltip;

  /// No description provided for @losFrequencyDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Radio horizon calculation'**
  String get losFrequencyDialogTitle;

  /// Explain how the calculation uses the baseline frequency and derived k-factor.
  ///
  /// In en, this message translates to:
  /// **'Starting from k={baselineK} at {baselineFreq} MHz, the calculation adjusts the k-factor for the current {frequencyMHz} MHz band, which defines the curved radio horizon cap.'**
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  );

  /// No description provided for @contacts_pathTrace.
  ///
  /// In en, this message translates to:
  /// **'Path Trace'**
  String get contacts_pathTrace;

  /// No description provided for @contacts_ping.
  ///
  /// In en, this message translates to:
  /// **'Ping'**
  String get contacts_ping;

  /// No description provided for @contacts_repeaterPathTrace.
  ///
  /// In en, this message translates to:
  /// **'Path trace to repeater'**
  String get contacts_repeaterPathTrace;

  /// No description provided for @contacts_repeaterPing.
  ///
  /// In en, this message translates to:
  /// **'Ping repeater'**
  String get contacts_repeaterPing;

  /// No description provided for @contacts_roomPathTrace.
  ///
  /// In en, this message translates to:
  /// **'Path trace to room server'**
  String get contacts_roomPathTrace;

  /// No description provided for @contacts_roomPing.
  ///
  /// In en, this message translates to:
  /// **'Ping room server'**
  String get contacts_roomPing;

  /// No description provided for @contacts_chatTraceRoute.
  ///
  /// In en, this message translates to:
  /// **'Path trace route'**
  String get contacts_chatTraceRoute;

  /// No description provided for @contacts_pathTraceTo.
  ///
  /// In en, this message translates to:
  /// **'Trace route to {name}'**
  String contacts_pathTraceTo(String name);

  /// No description provided for @contacts_clipboardEmpty.
  ///
  /// In en, this message translates to:
  /// **'Clipboard is empty.'**
  String get contacts_clipboardEmpty;

  /// No description provided for @contacts_invalidAdvertFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid contact data'**
  String get contacts_invalidAdvertFormat;

  /// No description provided for @contacts_contactImported.
  ///
  /// In en, this message translates to:
  /// **'Contact has been imported.'**
  String get contacts_contactImported;

  /// No description provided for @contacts_contactImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to import contact.'**
  String get contacts_contactImportFailed;

  /// No description provided for @contacts_zeroHopAdvert.
  ///
  /// In en, this message translates to:
  /// **'Zero Hop Advert'**
  String get contacts_zeroHopAdvert;

  /// No description provided for @contacts_floodAdvert.
  ///
  /// In en, this message translates to:
  /// **'Flood Advert'**
  String get contacts_floodAdvert;

  /// No description provided for @contacts_copyAdvertToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copy Advert to Clipboard'**
  String get contacts_copyAdvertToClipboard;

  /// No description provided for @contacts_addContactFromClipboard.
  ///
  /// In en, this message translates to:
  /// **'Add Contact from Clipboard'**
  String get contacts_addContactFromClipboard;

  /// No description provided for @contacts_ShareContact.
  ///
  /// In en, this message translates to:
  /// **'Copy contact to Clipboard'**
  String get contacts_ShareContact;

  /// No description provided for @contacts_ShareContactZeroHop.
  ///
  /// In en, this message translates to:
  /// **'Share contact by advert'**
  String get contacts_ShareContactZeroHop;

  /// No description provided for @contacts_zeroHopContactAdvertSent.
  ///
  /// In en, this message translates to:
  /// **'Sent contact by advert.'**
  String get contacts_zeroHopContactAdvertSent;

  /// No description provided for @contacts_zeroHopContactAdvertFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send contact.'**
  String get contacts_zeroHopContactAdvertFailed;

  /// No description provided for @contacts_contactAdvertCopied.
  ///
  /// In en, this message translates to:
  /// **'Advert copied to Clipboard.'**
  String get contacts_contactAdvertCopied;

  /// No description provided for @contacts_contactAdvertCopyFailed.
  ///
  /// In en, this message translates to:
  /// **'Copying advert to Clipboard failed.'**
  String get contacts_contactAdvertCopyFailed;

  /// No description provided for @notification_activityTitle.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core Activity'**
  String get notification_activityTitle;

  /// No description provided for @notification_messagesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1{message} other{messages}}'**
  String notification_messagesCount(int count);

  /// No description provided for @notification_channelMessagesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1{channel message} other{channel messages}}'**
  String notification_channelMessagesCount(int count);

  /// No description provided for @notification_newNodesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1{new node} other{new nodes}}'**
  String notification_newNodesCount(int count);

  /// No description provided for @notification_newTypeDiscovered.
  ///
  /// In en, this message translates to:
  /// **'New {contactType} discovered'**
  String notification_newTypeDiscovered(String contactType);

  /// No description provided for @notification_receivedNewMessage.
  ///
  /// In en, this message translates to:
  /// **'Received new message'**
  String get notification_receivedNewMessage;

  /// No description provided for @settings_gpxExportRepeaters.
  ///
  /// In en, this message translates to:
  /// **'Export repeaters / room server to GPX'**
  String get settings_gpxExportRepeaters;

  /// No description provided for @settings_gpxExportRepeatersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Exports repeaters / roomserver with a location to GPX file.'**
  String get settings_gpxExportRepeatersSubtitle;

  /// No description provided for @settings_gpxExportContacts.
  ///
  /// In en, this message translates to:
  /// **'Export companions to GPX'**
  String get settings_gpxExportContacts;

  /// No description provided for @settings_gpxExportContactsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Exports companions with a location to GPX file.'**
  String get settings_gpxExportContactsSubtitle;

  /// No description provided for @settings_gpxExportAll.
  ///
  /// In en, this message translates to:
  /// **'Export all contacts to GPX'**
  String get settings_gpxExportAll;

  /// No description provided for @settings_gpxExportAllSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Exports all contacts with a location to GPX file.'**
  String get settings_gpxExportAllSubtitle;

  /// No description provided for @settings_gpxExportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully exported GPX file.'**
  String get settings_gpxExportSuccess;

  /// No description provided for @settings_gpxExportNoContacts.
  ///
  /// In en, this message translates to:
  /// **'No contacts to export.'**
  String get settings_gpxExportNoContacts;

  /// No description provided for @settings_gpxExportNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not supported on your device/OS'**
  String get settings_gpxExportNotAvailable;

  /// No description provided for @settings_gpxExportError.
  ///
  /// In en, this message translates to:
  /// **'There was an error when exporting.'**
  String get settings_gpxExportError;

  /// No description provided for @settings_gpxExportRepeatersRoom.
  ///
  /// In en, this message translates to:
  /// **'Repeater & room server locations'**
  String get settings_gpxExportRepeatersRoom;

  /// No description provided for @settings_gpxExportChat.
  ///
  /// In en, this message translates to:
  /// **'Companion locations'**
  String get settings_gpxExportChat;

  /// No description provided for @settings_gpxExportAllContacts.
  ///
  /// In en, this message translates to:
  /// **'All contacts locations'**
  String get settings_gpxExportAllContacts;

  /// No description provided for @settings_gpxExportShareText.
  ///
  /// In en, this message translates to:
  /// **'Map data exported from NOTORYX Core'**
  String get settings_gpxExportShareText;

  /// No description provided for @settings_gpxExportShareSubject.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core GPX map data export'**
  String get settings_gpxExportShareSubject;

  /// No description provided for @snrIndicator_nearByRepeaters.
  ///
  /// In en, this message translates to:
  /// **'Nearby Repeaters'**
  String get snrIndicator_nearByRepeaters;

  /// No description provided for @snrIndicator_lastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last seen'**
  String get snrIndicator_lastSeen;

  /// No description provided for @contactsSettings_title.
  ///
  /// In en, this message translates to:
  /// **'Contacts settings'**
  String get contactsSettings_title;

  /// No description provided for @contactsSettings_autoAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Automatic Discovery'**
  String get contactsSettings_autoAddTitle;

  /// No description provided for @contactsSettings_otherTitle.
  ///
  /// In en, this message translates to:
  /// **'Other contact related settings'**
  String get contactsSettings_otherTitle;

  /// No description provided for @contactsSettings_autoAddUsersTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto-add users'**
  String get contactsSettings_autoAddUsersTitle;

  /// No description provided for @contactsSettings_autoAddUsersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow the companion to automatically add discovered users.'**
  String get contactsSettings_autoAddUsersSubtitle;

  /// No description provided for @contactsSettings_autoAddRepeatersTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto-add repeaters'**
  String get contactsSettings_autoAddRepeatersTitle;

  /// No description provided for @contactsSettings_autoAddRepeatersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow the companion to automatically add discovered repeaters.'**
  String get contactsSettings_autoAddRepeatersSubtitle;

  /// No description provided for @contactsSettings_autoAddRoomServersTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto-add room servers'**
  String get contactsSettings_autoAddRoomServersTitle;

  /// No description provided for @contactsSettings_autoAddRoomServersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow the companion to automatically add discovered room servers.'**
  String get contactsSettings_autoAddRoomServersSubtitle;

  /// No description provided for @contactsSettings_autoAddSensorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto-add sensors'**
  String get contactsSettings_autoAddSensorsTitle;

  /// No description provided for @contactsSettings_autoAddSensorsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow the companion to automatically add discovered sensors.'**
  String get contactsSettings_autoAddSensorsSubtitle;

  /// No description provided for @contactsSettings_overwriteOldestTitle.
  ///
  /// In en, this message translates to:
  /// **'Overwrite Oldest'**
  String get contactsSettings_overwriteOldestTitle;

  /// No description provided for @contactsSettings_overwriteOldestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'When the contact list is full, the oldest non-favorited contact will be replaced.'**
  String get contactsSettings_overwriteOldestSubtitle;

  /// No description provided for @discoveredContacts_Title.
  ///
  /// In en, this message translates to:
  /// **'Discovered Contacts'**
  String get discoveredContacts_Title;

  /// No description provided for @discoveredContacts_noMatching.
  ///
  /// In en, this message translates to:
  /// **'No matching contacts'**
  String get discoveredContacts_noMatching;

  /// No description provided for @discoveredContacts_searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search discovered contacts'**
  String get discoveredContacts_searchHint;

  /// No description provided for @discoveredContacts_contactAdded.
  ///
  /// In en, this message translates to:
  /// **'Contact added'**
  String get discoveredContacts_contactAdded;

  /// No description provided for @discoveredContacts_addContact.
  ///
  /// In en, this message translates to:
  /// **'Add Contact'**
  String get discoveredContacts_addContact;

  /// No description provided for @discoveredContacts_copyContact.
  ///
  /// In en, this message translates to:
  /// **'Copy Contact to clipboard'**
  String get discoveredContacts_copyContact;

  /// No description provided for @discoveredContacts_deleteContact.
  ///
  /// In en, this message translates to:
  /// **'Delete Discovered Contact'**
  String get discoveredContacts_deleteContact;

  /// No description provided for @discoveredContacts_deleteContactAll.
  ///
  /// In en, this message translates to:
  /// **'Delete All Discovered Contacts'**
  String get discoveredContacts_deleteContactAll;

  /// No description provided for @discoveredContacts_deleteContactAllContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all discovered contacts?'**
  String get discoveredContacts_deleteContactAllContent;

  /// No description provided for @chat_sendCooldown.
  ///
  /// In en, this message translates to:
  /// **'Please wait a moment before sending again.'**
  String get chat_sendCooldown;

  /// No description provided for @appSettings_jumpToOldestUnread.
  ///
  /// In en, this message translates to:
  /// **'Jump to oldest unread'**
  String get appSettings_jumpToOldestUnread;

  /// No description provided for @appSettings_jumpToOldestUnreadSubtitle.
  ///
  /// In en, this message translates to:
  /// **'When opening a chat with unread messages, scroll to the first unread instead of the latest.'**
  String get appSettings_jumpToOldestUnreadSubtitle;

  /// No description provided for @appSettings_languageHu.
  ///
  /// In en, this message translates to:
  /// **'Hungarian'**
  String get appSettings_languageHu;

  /// No description provided for @appSettings_languageJa.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get appSettings_languageJa;

  /// No description provided for @appSettings_languageKo.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get appSettings_languageKo;

  /// No description provided for @radioStats_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Radio & mesh stats'**
  String get radioStats_tooltip;

  /// No description provided for @radioStats_screenTitle.
  ///
  /// In en, this message translates to:
  /// **'Radio stats'**
  String get radioStats_screenTitle;

  /// No description provided for @radioStats_notConnected.
  ///
  /// In en, this message translates to:
  /// **'Connect to a device to view radio statistics.'**
  String get radioStats_notConnected;

  /// No description provided for @radioStats_firmwareTooOld.
  ///
  /// In en, this message translates to:
  /// **'Radio statistics require companion firmware v8 or newer.'**
  String get radioStats_firmwareTooOld;

  /// No description provided for @radioStats_waiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting for data…'**
  String get radioStats_waiting;

  /// No description provided for @radioStats_noiseFloor.
  ///
  /// In en, this message translates to:
  /// **'Noise floor: {noiseDbm} dBm'**
  String radioStats_noiseFloor(int noiseDbm);

  /// No description provided for @radioStats_lastRssi.
  ///
  /// In en, this message translates to:
  /// **'Last RSSI: {rssiDbm} dBm'**
  String radioStats_lastRssi(int rssiDbm);

  /// No description provided for @radioStats_lastSnr.
  ///
  /// In en, this message translates to:
  /// **'Last SNR: {snr} dB'**
  String radioStats_lastSnr(String snr);

  /// No description provided for @radioStats_txAir.
  ///
  /// In en, this message translates to:
  /// **'TX airtime (total): {seconds} s'**
  String radioStats_txAir(int seconds);

  /// No description provided for @radioStats_rxAir.
  ///
  /// In en, this message translates to:
  /// **'RX airtime (total): {seconds} s'**
  String radioStats_rxAir(int seconds);

  /// No description provided for @radioStats_chartCaption.
  ///
  /// In en, this message translates to:
  /// **'Noise floor (dBm) over recent samples.'**
  String get radioStats_chartCaption;

  /// No description provided for @radioStats_stripNoise.
  ///
  /// In en, this message translates to:
  /// **'Noise floor: {noiseDbm} dBm'**
  String radioStats_stripNoise(int noiseDbm);

  /// No description provided for @radioStats_stripWaiting.
  ///
  /// In en, this message translates to:
  /// **'Fetching radio stats…'**
  String get radioStats_stripWaiting;

  /// No description provided for @radioStats_settingsTile.
  ///
  /// In en, this message translates to:
  /// **'Radio stats'**
  String get radioStats_settingsTile;

  /// No description provided for @radioStats_settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Noise floor, RSSI, SNR, and airtime'**
  String get radioStats_settingsSubtitle;

  /// No description provided for @translation_title.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translation_title;

  /// No description provided for @imageMessages_enableTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable image messages'**
  String get imageMessages_enableTitle;

  /// No description provided for @imageMessages_enableSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send images over the mesh. Requires a one-time image model download.'**
  String get imageMessages_enableSubtitle;

  /// No description provided for @imageMessages_modelSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Image model'**
  String get imageMessages_modelSectionTitle;

  /// No description provided for @imageMessages_downloadModel.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get imageMessages_downloadModel;

  /// No description provided for @imageMessages_cancelDownload.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get imageMessages_cancelDownload;

  /// No description provided for @imageMessages_removeModel.
  ///
  /// In en, this message translates to:
  /// **'Remove model'**
  String get imageMessages_removeModel;

  /// No description provided for @imageMessages_modelReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get imageMessages_modelReady;

  /// No description provided for @imageMessages_modelNotPublished.
  ///
  /// In en, this message translates to:
  /// **'Not published yet — this build cannot download it.'**
  String get imageMessages_modelNotPublished;

  /// No description provided for @imageMessages_downloadFailed.
  ///
  /// In en, this message translates to:
  /// **'The image model could not be downloaded.'**
  String get imageMessages_downloadFailed;

  /// No description provided for @imageMessages_autoProcessTitle.
  ///
  /// In en, this message translates to:
  /// **'Process images automatically'**
  String get imageMessages_autoProcessTitle;

  /// No description provided for @imageMessages_autoProcessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reconstruct every image as soon as it arrives. Uses about 2 GB of memory for a second each time; leave off to reconstruct with a tap instead.'**
  String get imageMessages_autoProcessSubtitle;

  /// No description provided for @translation_enableTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable translation'**
  String get translation_enableTitle;

  /// No description provided for @translation_enableSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Translate incoming messages and allow pre-send translation.'**
  String get translation_enableSubtitle;

  /// No description provided for @translation_composerTitle.
  ///
  /// In en, this message translates to:
  /// **'Translate before sending'**
  String get translation_composerTitle;

  /// No description provided for @translation_composerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Controls the default state of the composer translation icon.'**
  String get translation_composerSubtitle;

  /// No description provided for @translation_autoIncomingTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto-translate incoming messages'**
  String get translation_autoIncomingTitle;

  /// No description provided for @translation_autoIncomingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Translates Messages for notification and for chat or channel automatically.'**
  String get translation_autoIncomingSubtitle;

  /// No description provided for @translation_translateMessage.
  ///
  /// In en, this message translates to:
  /// **'Translate message'**
  String get translation_translateMessage;

  /// No description provided for @translation_targetLanguage.
  ///
  /// In en, this message translates to:
  /// **'Target language'**
  String get translation_targetLanguage;

  /// No description provided for @translation_useAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'Use app language'**
  String get translation_useAppLanguage;

  /// No description provided for @translation_downloadedModelLabel.
  ///
  /// In en, this message translates to:
  /// **'Downloaded model'**
  String get translation_downloadedModelLabel;

  /// No description provided for @translation_presetModelLabel.
  ///
  /// In en, this message translates to:
  /// **'Preset Hugging Face model'**
  String get translation_presetModelLabel;

  /// No description provided for @translation_manualUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'Manual model URL'**
  String get translation_manualUrlLabel;

  /// No description provided for @translation_downloadModel.
  ///
  /// In en, this message translates to:
  /// **'Download model'**
  String get translation_downloadModel;

  /// No description provided for @translation_downloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading...'**
  String get translation_downloading;

  /// No description provided for @translation_working.
  ///
  /// In en, this message translates to:
  /// **'Working...'**
  String get translation_working;

  /// No description provided for @translation_stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get translation_stop;

  /// No description provided for @translation_mergingChunks.
  ///
  /// In en, this message translates to:
  /// **'Merging downloaded chunks into final file...'**
  String get translation_mergingChunks;

  /// No description provided for @translation_downloadedModels.
  ///
  /// In en, this message translates to:
  /// **'Downloaded models'**
  String get translation_downloadedModels;

  /// No description provided for @translation_deleteModel.
  ///
  /// In en, this message translates to:
  /// **'Delete model'**
  String get translation_deleteModel;

  /// No description provided for @translation_modelDownloaded.
  ///
  /// In en, this message translates to:
  /// **'Translation model downloaded.'**
  String get translation_modelDownloaded;

  /// No description provided for @translation_downloadStopped.
  ///
  /// In en, this message translates to:
  /// **'Download stopped.'**
  String get translation_downloadStopped;

  /// No description provided for @translation_downloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Download failed: {error}'**
  String translation_downloadFailed(String error);

  /// No description provided for @translation_enterUrlFirst.
  ///
  /// In en, this message translates to:
  /// **'Enter a model URL first.'**
  String get translation_enterUrlFirst;

  /// No description provided for @scanner_linuxPairingShowPin.
  ///
  /// In en, this message translates to:
  /// **'Show PIN'**
  String get scanner_linuxPairingShowPin;

  /// No description provided for @scanner_linuxPairingHidePin.
  ///
  /// In en, this message translates to:
  /// **'Hide PIN'**
  String get scanner_linuxPairingHidePin;

  /// No description provided for @scanner_linuxPairingPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Pairing PIN'**
  String get scanner_linuxPairingPinTitle;

  /// No description provided for @scanner_linuxPairingPinPrompt.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN for {deviceName} (leave blank if none).'**
  String scanner_linuxPairingPinPrompt(String deviceName);

  /// No description provided for @translation_messageTranslation.
  ///
  /// In en, this message translates to:
  /// **'Message translation'**
  String get translation_messageTranslation;

  /// No description provided for @translation_translateBeforeSending.
  ///
  /// In en, this message translates to:
  /// **'Translate before sending'**
  String get translation_translateBeforeSending;

  /// No description provided for @translation_composerEnabledHint.
  ///
  /// In en, this message translates to:
  /// **'Messages will be translated before send.'**
  String get translation_composerEnabledHint;

  /// No description provided for @translation_composerDisabledHint.
  ///
  /// In en, this message translates to:
  /// **'Send messages in the original typed language.'**
  String get translation_composerDisabledHint;

  /// No description provided for @translation_translateTo.
  ///
  /// In en, this message translates to:
  /// **'Translate to {language}'**
  String translation_translateTo(String language);

  /// No description provided for @translation_translationOptions.
  ///
  /// In en, this message translates to:
  /// **'Translation options'**
  String get translation_translationOptions;

  /// No description provided for @translation_systemLanguage.
  ///
  /// In en, this message translates to:
  /// **'System language'**
  String get translation_systemLanguage;

  /// No description provided for @background_serviceTitle.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core running'**
  String get background_serviceTitle;

  /// No description provided for @background_serviceText.
  ///
  /// In en, this message translates to:
  /// **'Keeping BLE connected'**
  String get background_serviceText;

  /// No description provided for @appSettings_translationModelDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted {name}'**
  String appSettings_translationModelDeleted(String name);

  /// No description provided for @appSettings_translationModelDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete: {error}'**
  String appSettings_translationModelDeleteFailed(String error);

  /// No description provided for @channels_channelUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update channel: {error}'**
  String channels_channelUpdateFailed(String error);

  /// No description provided for @contact_typeChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get contact_typeChat;

  /// No description provided for @contact_typeRepeater.
  ///
  /// In en, this message translates to:
  /// **'Repeater'**
  String get contact_typeRepeater;

  /// No description provided for @contact_typeRoom.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get contact_typeRoom;

  /// No description provided for @contact_typeSensor.
  ///
  /// In en, this message translates to:
  /// **'Sensor'**
  String get contact_typeSensor;

  /// No description provided for @contact_typeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get contact_typeUnknown;

  /// No description provided for @map_zoomIn.
  ///
  /// In en, this message translates to:
  /// **'Zoom in'**
  String get map_zoomIn;

  /// No description provided for @map_zoomOut.
  ///
  /// In en, this message translates to:
  /// **'Zoom out'**
  String get map_zoomOut;

  /// No description provided for @map_centerMap.
  ///
  /// In en, this message translates to:
  /// **'Center map'**
  String get map_centerMap;

  /// No description provided for @chrome_bluetoothRequiresChromium.
  ///
  /// In en, this message translates to:
  /// **'Web Bluetooth requires a Chromium browser'**
  String get chrome_bluetoothRequiresChromium;

  /// No description provided for @channels_communityShortId.
  ///
  /// In en, this message translates to:
  /// **'ID: {id}...'**
  String channels_communityShortId(String id);

  /// No description provided for @pathTrace_legendGpsConfirmed.
  ///
  /// In en, this message translates to:
  /// **'GPS confirmed'**
  String get pathTrace_legendGpsConfirmed;

  /// No description provided for @pathTrace_legendInferred.
  ///
  /// In en, this message translates to:
  /// **'Inferred position'**
  String get pathTrace_legendInferred;

  /// No description provided for @pathMap_viewSingle.
  ///
  /// In en, this message translates to:
  /// **'Single'**
  String get pathMap_viewSingle;

  /// No description provided for @pathMap_viewCombined.
  ///
  /// In en, this message translates to:
  /// **'Combined'**
  String get pathMap_viewCombined;

  /// No description provided for @pathMap_play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get pathMap_play;

  /// No description provided for @pathMap_pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pathMap_pause;

  /// No description provided for @pathMap_replay.
  ///
  /// In en, this message translates to:
  /// **'Replay'**
  String get pathMap_replay;

  /// No description provided for @pathMap_stepBack.
  ///
  /// In en, this message translates to:
  /// **'Previous hop'**
  String get pathMap_stepBack;

  /// No description provided for @pathMap_stepForward.
  ///
  /// In en, this message translates to:
  /// **'Next hop'**
  String get pathMap_stepForward;

  /// No description provided for @pathMap_animationOn.
  ///
  /// In en, this message translates to:
  /// **'Show packet animation'**
  String get pathMap_animationOn;

  /// No description provided for @pathMap_animationOff.
  ///
  /// In en, this message translates to:
  /// **'Hide packet animation'**
  String get pathMap_animationOff;

  /// No description provided for @pathMap_hopOf.
  ///
  /// In en, this message translates to:
  /// **'Hop {current} of {total}'**
  String pathMap_hopOf(int current, int total);

  /// No description provided for @pathMap_observedPaths.
  ///
  /// In en, this message translates to:
  /// **'Observed paths: {count}'**
  String pathMap_observedPaths(int count);

  /// No description provided for @pathMap_primary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get pathMap_primary;

  /// No description provided for @pathMap_alternate.
  ///
  /// In en, this message translates to:
  /// **'Alt {index}'**
  String pathMap_alternate(int index);

  /// No description provided for @pathMap_hopCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hop} other{{count} hops}}'**
  String pathMap_hopCount(int count);

  /// No description provided for @pathMap_gpsCount.
  ///
  /// In en, this message translates to:
  /// **'{confirmed}/{total} GPS'**
  String pathMap_gpsCount(int confirmed, int total);

  /// No description provided for @pathMap_legendShared.
  ///
  /// In en, this message translates to:
  /// **'Shared segment'**
  String get pathMap_legendShared;

  /// No description provided for @pathMap_legendEstimated.
  ///
  /// In en, this message translates to:
  /// **'Estimated segment'**
  String get pathMap_legendEstimated;

  /// No description provided for @pathMap_sharedNodeCount.
  ///
  /// In en, this message translates to:
  /// **'Used by {count} paths'**
  String pathMap_sharedNodeCount(int count);

  /// No description provided for @pathMap_partialAnimation.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hop has no location — the shown path is partial} other{{count} hops have no location — the shown path is partial}}'**
  String pathMap_partialAnimation(int count);

  /// No description provided for @pathMap_showAllPaths.
  ///
  /// In en, this message translates to:
  /// **'Show all'**
  String get pathMap_showAllPaths;

  /// No description provided for @pathMap_hidePath.
  ///
  /// In en, this message translates to:
  /// **'Hide path'**
  String get pathMap_hidePath;

  /// No description provided for @pathMap_showPath.
  ///
  /// In en, this message translates to:
  /// **'Show path'**
  String get pathMap_showPath;

  /// No description provided for @pathMap_collapsePanel.
  ///
  /// In en, this message translates to:
  /// **'Collapse panel'**
  String get pathMap_collapsePanel;

  /// No description provided for @pathMap_expandPanel.
  ///
  /// In en, this message translates to:
  /// **'Expand panel'**
  String get pathMap_expandPanel;

  /// No description provided for @pathMap_noLocation.
  ///
  /// In en, this message translates to:
  /// **'No location'**
  String get pathMap_noLocation;

  /// No description provided for @pathMap_followPacket.
  ///
  /// In en, this message translates to:
  /// **'Lock view to packet'**
  String get pathMap_followPacket;

  /// No description provided for @pathMap_unfollowPacket.
  ///
  /// In en, this message translates to:
  /// **'Unlock view from packet'**
  String get pathMap_unfollowPacket;

  /// No description provided for @imageSend_title.
  ///
  /// In en, this message translates to:
  /// **'Send image'**
  String get imageSend_title;

  /// No description provided for @imageSend_cropNote.
  ///
  /// In en, this message translates to:
  /// **'Resized to 512 × 512 · aspect ratio not preserved'**
  String get imageSend_cropNote;

  /// No description provided for @imageSend_originalSize.
  ///
  /// In en, this message translates to:
  /// **'Original'**
  String get imageSend_originalSize;

  /// No description provided for @imageSend_onAirSize.
  ///
  /// In en, this message translates to:
  /// **'On air'**
  String get imageSend_onAirSize;

  /// No description provided for @imageSend_quality.
  ///
  /// In en, this message translates to:
  /// **'Quality'**
  String get imageSend_quality;

  /// No description provided for @imageSend_qualityStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get imageSend_qualityStandard;

  /// No description provided for @imageSend_qualityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get imageSend_qualityHigh;

  /// No description provided for @imageSend_packetsLabel.
  ///
  /// In en, this message translates to:
  /// **'Packets'**
  String get imageSend_packetsLabel;

  /// No description provided for @imageSend_airtimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time on air'**
  String get imageSend_airtimeLabel;

  /// No description provided for @imageSend_sizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Payload'**
  String get imageSend_sizeLabel;

  /// No description provided for @imageSend_packetsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1{packet} other{packets}}'**
  String imageSend_packetsCount(int count);

  /// No description provided for @imageSend_range.
  ///
  /// In en, this message translates to:
  /// **'{min}–{max}'**
  String imageSend_range(String min, String max);

  /// No description provided for @imageSend_unknownValue.
  ///
  /// In en, this message translates to:
  /// **'—'**
  String get imageSend_unknownValue;

  /// No description provided for @imageSend_radioUnknownTitle.
  ///
  /// In en, this message translates to:
  /// **'Radio settings unknown'**
  String get imageSend_radioUnknownTitle;

  /// No description provided for @imageSend_radioUnknownBody.
  ///
  /// In en, this message translates to:
  /// **'Connect to a device so the time on air can be calculated.'**
  String get imageSend_radioUnknownBody;

  /// No description provided for @imageSend_longSendTitle.
  ///
  /// In en, this message translates to:
  /// **'Long transmission'**
  String get imageSend_longSendTitle;

  /// No description provided for @imageSend_longSendBody.
  ///
  /// In en, this message translates to:
  /// **'This will hold the channel for about {duration}.'**
  String imageSend_longSendBody(String duration);

  /// No description provided for @imageSend_floodNote.
  ///
  /// In en, this message translates to:
  /// **'Flood routing: every repeater in range retransmits each packet, so the channel stays busy longer than this.'**
  String get imageSend_floodNote;

  /// No description provided for @imageSend_parityTitle.
  ///
  /// In en, this message translates to:
  /// **'Add recovery packet'**
  String get imageSend_parityTitle;

  /// No description provided for @imageSend_paritySubtitle.
  ///
  /// In en, this message translates to:
  /// **'One extra packet. Group messages are not acknowledged, so this lets the receiver rebuild the image if a single packet is lost.'**
  String get imageSend_paritySubtitle;

  /// No description provided for @imageSend_send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get imageSend_send;

  /// No description provided for @imageSend_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get imageSend_cancel;

  /// No description provided for @imageSend_encodeFailed.
  ///
  /// In en, this message translates to:
  /// **'This image could not be encoded.'**
  String get imageSend_encodeFailed;

  /// No description provided for @imageSend_codecDownloading.
  ///
  /// In en, this message translates to:
  /// **'The image model is still downloading.'**
  String get imageSend_codecDownloading;

  /// No description provided for @imageSend_codecUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Image sending is not available on this device.'**
  String get imageSend_codecUnavailable;

  /// No description provided for @imageSend_codecDisabled.
  ///
  /// In en, this message translates to:
  /// **'Image messages are turned off in settings.'**
  String get imageSend_codecDisabled;

  /// No description provided for @imageSend_deviceUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This radio cannot send image packets. Connect a device running companion firmware 13 or newer.'**
  String get imageSend_deviceUnsupported;

  /// No description provided for @imageSend_directMessagesUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Images travel as group data, so they can only be sent to a channel — not in a direct message.'**
  String get imageSend_directMessagesUnsupported;

  /// No description provided for @imageSend_tooLarge.
  ///
  /// In en, this message translates to:
  /// **'That image encoded to more packets than the mesh format allows.'**
  String get imageSend_tooLarge;

  /// No description provided for @imageSend_sentConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Image sent as {count} {count, plural, =1{packet} other{packets}}.'**
  String imageSend_sentConfirmation(int count);

  /// No description provided for @imageSend_sendFailed.
  ///
  /// In en, this message translates to:
  /// **'The image could not be sent: {error}'**
  String imageSend_sendFailed(String error);

  /// No description provided for @imageSend_sendingProgress.
  ///
  /// In en, this message translates to:
  /// **'Sending image — packet {sent} of {total}'**
  String imageSend_sendingProgress(int sent, int total);

  /// No description provided for @receivedImage_senderPrefix.
  ///
  /// In en, this message translates to:
  /// **'Node {prefix}'**
  String receivedImage_senderPrefix(String prefix);

  /// No description provided for @receivedImage_incoming.
  ///
  /// In en, this message translates to:
  /// **'{received} of {total} packets'**
  String receivedImage_incoming(int received, int total);

  /// No description provided for @receivedImage_queued.
  ///
  /// In en, this message translates to:
  /// **'Waiting to decode'**
  String get receivedImage_queued;

  /// No description provided for @receivedImage_tapToDecode.
  ///
  /// In en, this message translates to:
  /// **'Tap to decode'**
  String get receivedImage_tapToDecode;

  /// No description provided for @receivedImage_decoding.
  ///
  /// In en, this message translates to:
  /// **'Reconstructing… about 1 s'**
  String get receivedImage_decoding;

  /// No description provided for @receivedImage_incomplete.
  ///
  /// In en, this message translates to:
  /// **'Image incomplete — {received} of {total} packets arrived'**
  String receivedImage_incomplete(int received, int total);

  /// No description provided for @receivedImage_corrupt.
  ///
  /// In en, this message translates to:
  /// **'Image could not be reconstructed'**
  String get receivedImage_corrupt;

  /// No description provided for @receivedImage_decoderMissing.
  ///
  /// In en, this message translates to:
  /// **'Image received — image decoding is off'**
  String get receivedImage_decoderMissing;

  /// No description provided for @receivedImage_evicted.
  ///
  /// In en, this message translates to:
  /// **'Image no longer stored'**
  String get receivedImage_evicted;

  /// No description provided for @receivedImage_retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get receivedImage_retry;

  /// No description provided for @receivedImage_decodeAgain.
  ///
  /// In en, this message translates to:
  /// **'Decode again'**
  String get receivedImage_decodeAgain;

  /// No description provided for @receivedImage_openSettings.
  ///
  /// In en, this message translates to:
  /// **'Set up'**
  String get receivedImage_openSettings;

  /// No description provided for @receivedImage_tapToProcess.
  ///
  /// In en, this message translates to:
  /// **'Tap to process'**
  String get receivedImage_tapToProcess;

  /// No description provided for @receivedImage_awaiting.
  ///
  /// In en, this message translates to:
  /// **'{bytes} bytes · {packets} {packets, plural, =1{packet} other{packets}}'**
  String receivedImage_awaiting(int bytes, int packets);

  /// No description provided for @imageSend_secondsValue.
  ///
  /// In en, this message translates to:
  /// **'{seconds} s'**
  String imageSend_secondsValue(String seconds);

  /// No description provided for @imageSend_minutesSecondsValue.
  ///
  /// In en, this message translates to:
  /// **'{minutes} m {seconds} s'**
  String imageSend_minutesSecondsValue(String minutes, String seconds);

  /// No description provided for @bastion_tagline.
  ///
  /// In en, this message translates to:
  /// **'Communication without infrastructure.'**
  String get bastion_tagline;

  /// No description provided for @bastion_nodes.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get bastion_nodes;

  /// No description provided for @bastion_repeaters.
  ///
  /// In en, this message translates to:
  /// **'Repeaters'**
  String get bastion_repeaters;

  /// No description provided for @bastion_active1h.
  ///
  /// In en, this message translates to:
  /// **'Active 1h'**
  String get bastion_active1h;

  /// No description provided for @bastion_mapCoverage.
  ///
  /// In en, this message translates to:
  /// **'Map + coverage'**
  String get bastion_mapCoverage;

  /// No description provided for @bastion_routeIntelligence.
  ///
  /// In en, this message translates to:
  /// **'Route intelligence'**
  String get bastion_routeIntelligence;

  /// No description provided for @bastion_repeaterTools.
  ///
  /// In en, this message translates to:
  /// **'Repeater tools'**
  String get bastion_repeaterTools;

  /// No description provided for @bastion_fieldStats.
  ///
  /// In en, this message translates to:
  /// **'Field stats'**
  String get bastion_fieldStats;

  /// No description provided for @bastion_fieldOps.
  ///
  /// In en, this message translates to:
  /// **'Trip + field operations'**
  String get bastion_fieldOps;

  /// No description provided for @bastion_coverageCapture.
  ///
  /// In en, this message translates to:
  /// **'Coverage capture'**
  String get bastion_coverageCapture;

  /// No description provided for @bastion_mapAttribution.
  ///
  /// In en, this message translates to:
  /// **'Map data © OpenStreetMap contributors; tiles by selected provider'**
  String get bastion_mapAttribution;

  /// No description provided for @bastion_observationsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 observation} other{{count} observations}}'**
  String bastion_observationsCount(int count);

  /// No description provided for @bastion_uniqueNodesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 unique node} other{{count} unique nodes}}'**
  String bastion_uniqueNodesCount(int count);

  /// No description provided for @bastion_hopsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hop} other{{count} hops}}'**
  String bastion_hopsCount(int count);

  /// No description provided for @bastion_minutesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 minute} other{{count} minutes}}'**
  String bastion_minutesCount(int count);

  /// No description provided for @sos_holdHint.
  ///
  /// In en, this message translates to:
  /// **'Hold 2 seconds. Sends your position to your trip contacts every 5 minutes until someone replies.'**
  String get sos_holdHint;

  /// No description provided for @sos_holdHintChannel.
  ///
  /// In en, this message translates to:
  /// **'Hold 2 seconds. Sends your position to your trip contacts and {channel} every 5 minutes until someone replies.'**
  String sos_holdHintChannel(String channel);

  /// No description provided for @sos_notSent.
  ///
  /// In en, this message translates to:
  /// **'SOS not sent: {error}'**
  String sos_notSent(String error);

  /// No description provided for @sos_acknowledged.
  ///
  /// In en, this message translates to:
  /// **'Acknowledged by {name}. Repeats stopped.'**
  String sos_acknowledged(String name);

  /// No description provided for @sos_waitingForRadio.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the radio to send…'**
  String get sos_waitingForRadio;

  /// No description provided for @sos_repeatsFinished.
  ///
  /// In en, this message translates to:
  /// **'Sent {sends} of {max} times. Repeats finished; no reply yet.'**
  String sos_repeatsFinished(int sends, int max);

  /// No description provided for @sos_nextAt.
  ///
  /// In en, this message translates to:
  /// **'Sent {sends} of {max} times. Next at {time}.'**
  String sos_nextAt(int sends, int max, String time);

  /// No description provided for @sos_active.
  ///
  /// In en, this message translates to:
  /// **'SOS ACTIVE'**
  String get sos_active;

  /// No description provided for @sos_stop.
  ///
  /// In en, this message translates to:
  /// **'STOP'**
  String get sos_stop;

  /// No description provided for @sos_imSafe.
  ///
  /// In en, this message translates to:
  /// **'I\'M SAFE'**
  String get sos_imSafe;

  /// No description provided for @sos_holdSemantics.
  ///
  /// In en, this message translates to:
  /// **'SOS. Hold to send.'**
  String get sos_holdSemantics;

  /// No description provided for @sos_keepHolding.
  ///
  /// In en, this message translates to:
  /// **'KEEP HOLDING…'**
  String get sos_keepHolding;

  /// No description provided for @sos_holdForSos.
  ///
  /// In en, this message translates to:
  /// **'HOLD FOR SOS'**
  String get sos_holdForSos;

  /// No description provided for @sos_blockStorage.
  ///
  /// In en, this message translates to:
  /// **'Resolve the Field Log storage error first.'**
  String get sos_blockStorage;

  /// No description provided for @sos_blockNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Connect your MeshCore radio to send an SOS.'**
  String get sos_blockNotConnected;

  /// No description provided for @sos_blockNoTarget.
  ///
  /// In en, this message translates to:
  /// **'Choose trip contacts or an SOS channel in Plan trip.'**
  String get sos_blockNoTarget;

  /// No description provided for @checkIn_labelOk.
  ///
  /// In en, this message translates to:
  /// **'I\'m OK'**
  String get checkIn_labelOk;

  /// No description provided for @checkIn_labelAtCamp.
  ///
  /// In en, this message translates to:
  /// **'At Camp'**
  String get checkIn_labelAtCamp;

  /// No description provided for @checkIn_labelDelayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get checkIn_labelDelayed;

  /// No description provided for @checkIn_labelHeadingBack.
  ///
  /// In en, this message translates to:
  /// **'Heading Back'**
  String get checkIn_labelHeadingBack;

  /// No description provided for @checkIn_blockLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading your trip…'**
  String get checkIn_blockLoading;

  /// No description provided for @checkIn_blockStorage.
  ///
  /// In en, this message translates to:
  /// **'Resolve the Field Log storage error before sending.'**
  String get checkIn_blockStorage;

  /// No description provided for @checkIn_blockBusy.
  ///
  /// In en, this message translates to:
  /// **'A check-in is being sent. Please wait.'**
  String get checkIn_blockBusy;

  /// No description provided for @checkIn_blockNoContacts.
  ///
  /// In en, this message translates to:
  /// **'Choose trip contacts in Plan trip.'**
  String get checkIn_blockNoContacts;

  /// No description provided for @checkIn_blockRosterIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Some trip contacts are unavailable. Review your roster.'**
  String get checkIn_blockRosterIncomplete;

  /// No description provided for @checkIn_blockNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Connect your MeshCore radio to check in.'**
  String get checkIn_blockNotConnected;

  /// No description provided for @checkIn_blockNotActive.
  ///
  /// In en, this message translates to:
  /// **'Start your trip to enable check-ins.'**
  String get checkIn_blockNotActive;

  /// No description provided for @checkIn_notSent.
  ///
  /// In en, this message translates to:
  /// **'Not sent'**
  String get checkIn_notSent;

  /// No description provided for @checkIn_deliveredToOne.
  ///
  /// In en, this message translates to:
  /// **'Delivered to {name}'**
  String checkIn_deliveredToOne(String name);

  /// No description provided for @checkIn_deliveredToAll.
  ///
  /// In en, this message translates to:
  /// **'Delivered to all {count} contacts'**
  String checkIn_deliveredToAll(int count);

  /// No description provided for @checkIn_deliveredSome.
  ///
  /// In en, this message translates to:
  /// **'Delivered to {delivered} of {total}'**
  String checkIn_deliveredSome(String delivered, String total);

  /// No description provided for @checkIn_notDeliveredTo.
  ///
  /// In en, this message translates to:
  /// **'Not delivered: {names}'**
  String checkIn_notDeliveredTo(String names);

  /// No description provided for @checkIn_waitingForRest.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the rest'**
  String get checkIn_waitingForRest;

  /// No description provided for @checkIn_aContact.
  ///
  /// In en, this message translates to:
  /// **'a contact'**
  String get checkIn_aContact;

  /// No description provided for @checkIn_statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get checkIn_statusPending;

  /// No description provided for @checkIn_statusSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get checkIn_statusSent;

  /// No description provided for @checkIn_statusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get checkIn_statusDelivered;

  /// No description provided for @checkIn_statusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get checkIn_statusFailed;

  /// No description provided for @checkIn_explainPending.
  ///
  /// In en, this message translates to:
  /// **'Queued locally. This does not confirm radio transmission or receipt.'**
  String get checkIn_explainPending;

  /// No description provided for @checkIn_explainSent.
  ///
  /// In en, this message translates to:
  /// **'The radio accepted the send. No delivery acknowledgment has been recorded.'**
  String get checkIn_explainSent;

  /// No description provided for @checkIn_explainDelivered.
  ///
  /// In en, this message translates to:
  /// **'The app recorded a delivery acknowledgment. It does not prove the person read it.'**
  String get checkIn_explainDelivered;

  /// No description provided for @checkIn_explainFailed.
  ///
  /// In en, this message translates to:
  /// **'No confirmed delivery. Check radio connection, recipient reachability and retry history.'**
  String get checkIn_explainFailed;

  /// No description provided for @checkIn_explainUnknown.
  ///
  /// In en, this message translates to:
  /// **'Delivery state is unavailable. Do not assume this message arrived.'**
  String get checkIn_explainUnknown;

  /// No description provided for @tripBrief_heading.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX • MeshCore Trip Brief'**
  String get tripBrief_heading;

  /// No description provided for @tripBrief_trip.
  ///
  /// In en, this message translates to:
  /// **'Trip: {name}'**
  String tripBrief_trip(String name);

  /// No description provided for @tripBrief_status.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String tripBrief_status(String status);

  /// No description provided for @tripBrief_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get tripBrief_active;

  /// No description provided for @tripBrief_stopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped'**
  String get tripBrief_stopped;

  /// No description provided for @tripBrief_contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts: {names}'**
  String tripBrief_contacts(String names);

  /// No description provided for @tripBrief_noneSelected.
  ///
  /// In en, this message translates to:
  /// **'None selected'**
  String get tripBrief_noneSelected;

  /// No description provided for @tripBrief_unavailableContact.
  ///
  /// In en, this message translates to:
  /// **'Unavailable contact (review roster)'**
  String get tripBrief_unavailableContact;

  /// No description provided for @tripBrief_overdueAfter.
  ///
  /// In en, this message translates to:
  /// **'Activity overdue after: {minutes} minutes (this phone alerts when a contact goes quiet)'**
  String tripBrief_overdueAfter(int minutes);

  /// No description provided for @tripBrief_reminder.
  ///
  /// In en, this message translates to:
  /// **'Check-in reminder: {value}'**
  String tripBrief_reminder(String value);

  /// No description provided for @tripBrief_reminderEvery.
  ///
  /// In en, this message translates to:
  /// **'every {minutes} minutes without a check-in'**
  String tripBrief_reminderEvery(int minutes);

  /// No description provided for @tripBrief_choices.
  ///
  /// In en, this message translates to:
  /// **'Check-in choices: {choices}'**
  String tripBrief_choices(String choices);

  /// No description provided for @tripBrief_position.
  ///
  /// In en, this message translates to:
  /// **'Radio position in check-ins: {value}'**
  String tripBrief_position(String value);

  /// No description provided for @tripBrief_includedMayBeStale.
  ///
  /// In en, this message translates to:
  /// **'Included; may be stale'**
  String get tripBrief_includedMayBeStale;

  /// No description provided for @tripBrief_battery.
  ///
  /// In en, this message translates to:
  /// **'Radio battery in check-ins: {value}'**
  String tripBrief_battery(String value);

  /// No description provided for @tripBrief_included.
  ///
  /// In en, this message translates to:
  /// **'Included'**
  String get tripBrief_included;

  /// No description provided for @tripBrief_off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get tripBrief_off;

  /// No description provided for @tripBrief_review.
  ///
  /// In en, this message translates to:
  /// **'Review recipients and message before sending a check-in.'**
  String get tripBrief_review;

  /// No description provided for @tripBrief_noProof.
  ///
  /// In en, this message translates to:
  /// **'Queued or sent does not prove delivery. An acknowledgment does not prove it was read.'**
  String get tripBrief_noProof;

  /// No description provided for @tripBrief_overdueMeaning.
  ///
  /// In en, this message translates to:
  /// **'Overdue means no recent contact activity; it is not a confirmed emergency.'**
  String get tripBrief_overdueMeaning;

  /// No description provided for @tripBrief_automations.
  ///
  /// In en, this message translates to:
  /// **'Field automations run only while the app is active. Agree on a separate plan for missed contact.'**
  String get tripBrief_automations;

  /// No description provided for @tripBrief_sharesOnly.
  ///
  /// In en, this message translates to:
  /// **'This brief shares information only; it does not send a radio message or start a trip.'**
  String get tripBrief_sharesOnly;

  /// No description provided for @fieldOps_title.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core Field Operations'**
  String get fieldOps_title;

  /// No description provided for @fieldOps_tabTrip.
  ///
  /// In en, this message translates to:
  /// **'Trip'**
  String get fieldOps_tabTrip;

  /// No description provided for @fieldOps_tabReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get fieldOps_tabReady;

  /// No description provided for @fieldOps_tabLog.
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get fieldOps_tabLog;

  /// No description provided for @fieldOps_tabAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get fieldOps_tabAuto;

  /// No description provided for @fieldOps_tabCoverage.
  ///
  /// In en, this message translates to:
  /// **'Coverage'**
  String get fieldOps_tabCoverage;

  /// No description provided for @fieldOps_tabConnection.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get fieldOps_tabConnection;

  /// No description provided for @fieldOps_diagnostics.
  ///
  /// In en, this message translates to:
  /// **'Diagnostics'**
  String get fieldOps_diagnostics;

  /// No description provided for @fieldOps_storageLoadError.
  ///
  /// In en, this message translates to:
  /// **'Field data could not be loaded. Saved data was retained; automations remain off.'**
  String get fieldOps_storageLoadError;

  /// No description provided for @fieldOps_storageSaveError.
  ///
  /// In en, this message translates to:
  /// **'Field data could not be saved. Automations stopped; existing stored data is retained.'**
  String get fieldOps_storageSaveError;

  /// No description provided for @fieldOps_regionHint.
  ///
  /// In en, this message translates to:
  /// **'Select an area and zoom levels in Offline maps.'**
  String get fieldOps_regionHint;

  /// No description provided for @fieldOps_regionLabel.
  ///
  /// In en, this message translates to:
  /// **'{source} • zoom {minZoom}–{maxZoom}'**
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom);

  /// No description provided for @fieldOps_mapVerifyFailed.
  ///
  /// In en, this message translates to:
  /// **'Map area could not be verified: {error}'**
  String fieldOps_mapVerifyFailed(String error);

  /// No description provided for @fieldOps_tripActive.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Trip active • 1 contact} other{Trip active • {count} contacts}}'**
  String fieldOps_tripActive(int count);

  /// No description provided for @fieldOps_tripStopped.
  ///
  /// In en, this message translates to:
  /// **'Trip stopped. Start it when you are ready.'**
  String get fieldOps_tripStopped;

  /// No description provided for @fieldOps_reminderAt.
  ///
  /// In en, this message translates to:
  /// **'Check-in reminder at {time}'**
  String fieldOps_reminderAt(String time);

  /// No description provided for @fieldOps_quietTooLong.
  ///
  /// In en, this message translates to:
  /// **'Quiet too long: {names}'**
  String fieldOps_quietTooLong(String names);

  /// No description provided for @fieldOps_planTrip.
  ///
  /// In en, this message translates to:
  /// **'Plan trip'**
  String get fieldOps_planTrip;

  /// No description provided for @fieldOps_endTrip.
  ///
  /// In en, this message translates to:
  /// **'End trip'**
  String get fieldOps_endTrip;

  /// No description provided for @fieldOps_startTrip.
  ///
  /// In en, this message translates to:
  /// **'Start trip'**
  String get fieldOps_startTrip;

  /// No description provided for @fieldOps_tripBrief.
  ///
  /// In en, this message translates to:
  /// **'Trip brief'**
  String get fieldOps_tripBrief;

  /// No description provided for @fieldOps_connectRadio.
  ///
  /// In en, this message translates to:
  /// **'Connect radio'**
  String get fieldOps_connectRadio;

  /// No description provided for @fieldOps_previewedCheckIns.
  ///
  /// In en, this message translates to:
  /// **'Previewed check-ins'**
  String get fieldOps_previewedCheckIns;

  /// No description provided for @fieldOps_previewedCheckInsHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a status, review the actual recipients and message, then send. Queued does not mean delivered.'**
  String get fieldOps_previewedCheckInsHint;

  /// No description provided for @fieldOps_tripRoster.
  ///
  /// In en, this message translates to:
  /// **'Trip roster'**
  String get fieldOps_tripRoster;

  /// No description provided for @fieldOps_rosterEmpty.
  ///
  /// In en, this message translates to:
  /// **'Choose up to six known chat contacts in Plan trip.'**
  String get fieldOps_rosterEmpty;

  /// No description provided for @fieldOps_rosterCaveat.
  ///
  /// In en, this message translates to:
  /// **'Last heard is evidence of past activity. It does not establish current reachability. Overdue badges mean no recent contact activity, not a confirmed emergency.'**
  String get fieldOps_rosterCaveat;

  /// No description provided for @fieldOps_offlineMaps.
  ///
  /// In en, this message translates to:
  /// **'Offline maps'**
  String get fieldOps_offlineMaps;

  /// No description provided for @fieldOps_checkingTiles.
  ///
  /// In en, this message translates to:
  /// **'Checking saved tiles…'**
  String get fieldOps_checkingTiles;

  /// No description provided for @fieldOps_cachedTiles.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 cached tile.} other{{count} cached tiles.}} This does not guarantee your entire route is covered.'**
  String fieldOps_cachedTiles(int count);

  /// No description provided for @fieldOps_downloadAreas.
  ///
  /// In en, this message translates to:
  /// **'Download / inspect offline areas'**
  String get fieldOps_downloadAreas;

  /// No description provided for @fieldOps_lastCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Last check-in, {time}'**
  String fieldOps_lastCheckIn(String time);

  /// No description provided for @fieldOps_deliveryChip.
  ///
  /// In en, this message translates to:
  /// **'{name}: {status}'**
  String fieldOps_deliveryChip(String name, String status);

  /// No description provided for @fieldOps_contactFallback.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get fieldOps_contactFallback;

  /// No description provided for @fieldOps_resendFailed.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Resend to 1 not delivered} other{Resend to {count} not delivered}}'**
  String fieldOps_resendFailed(int count);

  /// No description provided for @fieldOps_memberUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Selected contact unavailable'**
  String get fieldOps_memberUnavailable;

  /// No description provided for @fieldOps_memberUnavailableHint.
  ///
  /// In en, this message translates to:
  /// **'Review this trip before sending.'**
  String get fieldOps_memberUnavailableHint;

  /// No description provided for @fieldOps_lastActivity.
  ///
  /// In en, this message translates to:
  /// **'Last activity {minutes}m ago'**
  String fieldOps_lastActivity(int minutes);

  /// No description provided for @fieldOps_lastActivityOverdue.
  ///
  /// In en, this message translates to:
  /// **'Last activity {minutes}m ago • overdue'**
  String fieldOps_lastActivityOverdue(int minutes);

  /// No description provided for @fieldOps_noCheckInRecorded.
  ///
  /// In en, this message translates to:
  /// **'No check-in recorded in this log.'**
  String get fieldOps_noCheckInRecorded;

  /// No description provided for @fieldOps_tripMap.
  ///
  /// In en, this message translates to:
  /// **'Trip map'**
  String get fieldOps_tripMap;

  /// No description provided for @fieldOps_tripMapEmpty.
  ///
  /// In en, this message translates to:
  /// **'No selected contacts have advertised coordinates yet.'**
  String get fieldOps_tripMapEmpty;

  /// No description provided for @fieldOps_lastPositions.
  ///
  /// In en, this message translates to:
  /// **'Last advertised positions'**
  String get fieldOps_lastPositions;

  /// No description provided for @fieldOps_positionsCaveat.
  ///
  /// In en, this message translates to:
  /// **'Positions can be stale. This map does not track phone GPS or prove members are currently here.'**
  String get fieldOps_positionsCaveat;

  /// No description provided for @fieldOps_briefPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview Trip Brief'**
  String get fieldOps_briefPreviewTitle;

  /// No description provided for @fieldOps_briefPreviewHint.
  ///
  /// In en, this message translates to:
  /// **'Includes trip and contact names. Review before sharing. Coordinates, keys and message history are omitted.'**
  String get fieldOps_briefPreviewHint;

  /// No description provided for @fieldOps_shareBrief.
  ///
  /// In en, this message translates to:
  /// **'Share brief'**
  String get fieldOps_shareBrief;

  /// No description provided for @fieldOps_briefSubject.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core Trip Brief'**
  String get fieldOps_briefSubject;

  /// No description provided for @fieldOps_tripName.
  ///
  /// In en, this message translates to:
  /// **'Trip name'**
  String get fieldOps_tripName;

  /// No description provided for @fieldOps_defaultTripName.
  ///
  /// In en, this message translates to:
  /// **'My trip'**
  String get fieldOps_defaultTripName;

  /// No description provided for @fieldOps_includePosition.
  ///
  /// In en, this message translates to:
  /// **'Include advertised radio position'**
  String get fieldOps_includePosition;

  /// No description provided for @fieldOps_includePositionHint.
  ///
  /// In en, this message translates to:
  /// **'May be stale; sharing is off by default.'**
  String get fieldOps_includePositionHint;

  /// No description provided for @fieldOps_includeBattery.
  ///
  /// In en, this message translates to:
  /// **'Include radio battery'**
  String get fieldOps_includeBattery;

  /// No description provided for @fieldOps_overdueLabel.
  ///
  /// In en, this message translates to:
  /// **'Alert me when a contact is quiet for'**
  String get fieldOps_overdueLabel;

  /// No description provided for @fieldOps_reminderLabel.
  ///
  /// In en, this message translates to:
  /// **'Remind me to check in'**
  String get fieldOps_reminderLabel;

  /// No description provided for @fieldOps_reminderHelper.
  ///
  /// In en, this message translates to:
  /// **'A phone notification, even if NOTORYX Core is closed.'**
  String get fieldOps_reminderHelper;

  /// No description provided for @fieldOps_reminderOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get fieldOps_reminderOff;

  /// No description provided for @fieldOps_reminderAfter.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{After 1 minute without one} other{After {count} minutes without one}}'**
  String fieldOps_reminderAfter(int count);

  /// No description provided for @fieldOps_sosChannelLabel.
  ///
  /// In en, this message translates to:
  /// **'SOS also goes to channel'**
  String get fieldOps_sosChannelLabel;

  /// No description provided for @fieldOps_sosChannelNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get fieldOps_sosChannelNone;

  /// No description provided for @fieldOps_selectContacts.
  ///
  /// In en, this message translates to:
  /// **'Select up to six known chat contacts'**
  String get fieldOps_selectContacts;

  /// No description provided for @fieldOps_sendCheckInTitle.
  ///
  /// In en, this message translates to:
  /// **'Send check-in?'**
  String get fieldOps_sendCheckInTitle;

  /// No description provided for @fieldOps_recipients.
  ///
  /// In en, this message translates to:
  /// **'To: {names}'**
  String fieldOps_recipients(String names);

  /// No description provided for @fieldOps_sendCheckInHint.
  ///
  /// In en, this message translates to:
  /// **'This uses normal direct-message sends. Delivery will be tracked in Field Log.'**
  String get fieldOps_sendCheckInHint;

  /// No description provided for @fieldOps_send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get fieldOps_send;

  /// No description provided for @fieldOps_beforeYouLeave.
  ///
  /// In en, this message translates to:
  /// **'Before you leave'**
  String get fieldOps_beforeYouLeave;

  /// No description provided for @fieldOps_radioConnected.
  ///
  /// In en, this message translates to:
  /// **'Radio connected'**
  String get fieldOps_radioConnected;

  /// No description provided for @fieldOps_connectHint.
  ///
  /// In en, this message translates to:
  /// **'Connect with Bluetooth, USB or TCP.'**
  String get fieldOps_connectHint;

  /// No description provided for @fieldOps_radioBattery.
  ///
  /// In en, this message translates to:
  /// **'Radio battery'**
  String get fieldOps_radioBattery;

  /// No description provided for @fieldOps_batteryUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown; inspect the radio.'**
  String get fieldOps_batteryUnknown;

  /// No description provided for @fieldOps_batteryDetail.
  ///
  /// In en, this message translates to:
  /// **'{percent}% • charge for your planned trip.'**
  String fieldOps_batteryDetail(String percent);

  /// No description provided for @fieldOps_tripContacts.
  ///
  /// In en, this message translates to:
  /// **'Trip contacts'**
  String get fieldOps_tripContacts;

  /// No description provided for @fieldOps_tripContactsDetail.
  ///
  /// In en, this message translates to:
  /// **'{available}/{selected} available. Check they have compatible radios and channels.'**
  String fieldOps_tripContactsDetail(String available, String selected);

  /// No description provided for @fieldOps_offlineArea.
  ///
  /// In en, this message translates to:
  /// **'Selected offline map area'**
  String get fieldOps_offlineArea;

  /// No description provided for @fieldOps_checkingFiles.
  ///
  /// In en, this message translates to:
  /// **'Checking local files…'**
  String get fieldOps_checkingFiles;

  /// No description provided for @fieldOps_regionStatus.
  ///
  /// In en, this message translates to:
  /// **'{available}/{expected} tile files available; {missing} missing. This is a snapshot; open the area offline before leaving.'**
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  );

  /// No description provided for @fieldOps_locationChoice.
  ///
  /// In en, this message translates to:
  /// **'Location-sharing choice'**
  String get fieldOps_locationChoice;

  /// No description provided for @fieldOps_locationOptedIn.
  ///
  /// In en, this message translates to:
  /// **'Opted in: radio advertised coordinates may be stale.'**
  String get fieldOps_locationOptedIn;

  /// No description provided for @fieldOps_locationOff.
  ///
  /// In en, this message translates to:
  /// **'Sharing is off. Your check-ins omit coordinates.'**
  String get fieldOps_locationOff;

  /// No description provided for @fieldOps_automationAvailability.
  ///
  /// In en, this message translates to:
  /// **'Automation availability'**
  String get fieldOps_automationAvailability;

  /// No description provided for @fieldOps_automationAvailabilityDetail.
  ///
  /// In en, this message translates to:
  /// **'Runs only while this app is active. Sleep, closure or loss of radio can prevent scheduled actions.'**
  String get fieldOps_automationAvailabilityDetail;

  /// No description provided for @fieldOps_readinessCaveat.
  ///
  /// In en, this message translates to:
  /// **'Readiness checks are advisory; they do not prove radio range or guarantee message delivery.'**
  String get fieldOps_readinessCaveat;

  /// No description provided for @fieldOps_radio.
  ///
  /// In en, this message translates to:
  /// **'Radio'**
  String get fieldOps_radio;

  /// No description provided for @fieldOps_refreshChecks.
  ///
  /// In en, this message translates to:
  /// **'Refresh checks'**
  String get fieldOps_refreshChecks;

  /// No description provided for @fieldOps_searchLog.
  ///
  /// In en, this message translates to:
  /// **'Search Field Log'**
  String get fieldOps_searchLog;

  /// No description provided for @fieldOps_kindAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get fieldOps_kindAll;

  /// No description provided for @fieldOps_kindCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get fieldOps_kindCheckIn;

  /// No description provided for @fieldOps_kindReceived.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get fieldOps_kindReceived;

  /// No description provided for @fieldOps_kindNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get fieldOps_kindNote;

  /// No description provided for @fieldOps_kindDeadZone.
  ///
  /// In en, this message translates to:
  /// **'Dead zone'**
  String get fieldOps_kindDeadZone;

  /// No description provided for @fieldOps_kindRadio.
  ///
  /// In en, this message translates to:
  /// **'Radio'**
  String get fieldOps_kindRadio;

  /// No description provided for @fieldOps_kindAutomation.
  ///
  /// In en, this message translates to:
  /// **'Automation'**
  String get fieldOps_kindAutomation;

  /// No description provided for @fieldOps_kindMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get fieldOps_kindMissed;

  /// No description provided for @fieldOps_kindSos.
  ///
  /// In en, this message translates to:
  /// **'SOS'**
  String get fieldOps_kindSos;

  /// No description provided for @fieldOps_kindTrip.
  ///
  /// In en, this message translates to:
  /// **'Trip'**
  String get fieldOps_kindTrip;

  /// No description provided for @fieldOps_kindOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get fieldOps_kindOverdue;

  /// No description provided for @fieldOps_addNote.
  ///
  /// In en, this message translates to:
  /// **'Add note'**
  String get fieldOps_addNote;

  /// No description provided for @fieldOps_exportJson.
  ///
  /// In en, this message translates to:
  /// **'Export JSON'**
  String get fieldOps_exportJson;

  /// No description provided for @fieldOps_deleteLog.
  ///
  /// In en, this message translates to:
  /// **'Delete log'**
  String get fieldOps_deleteLog;

  /// No description provided for @fieldOps_logSubject.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core Field Log'**
  String get fieldOps_logSubject;

  /// No description provided for @fieldOps_logCaveat.
  ///
  /// In en, this message translates to:
  /// **'Stored locally, up to 1,000 entries. Exports may contain contact keys, messages and locations; review before sharing.'**
  String get fieldOps_logCaveat;

  /// No description provided for @fieldOps_noEntries.
  ///
  /// In en, this message translates to:
  /// **'No matching entries.'**
  String get fieldOps_noEntries;

  /// No description provided for @fieldOps_tripUnspecified.
  ///
  /// In en, this message translates to:
  /// **'Trip unspecified'**
  String get fieldOps_tripUnspecified;

  /// No description provided for @fieldOps_entryStatus.
  ///
  /// In en, this message translates to:
  /// **'{status}: {explanation}'**
  String fieldOps_entryStatus(String status, String explanation);

  /// No description provided for @fieldOps_entryPosition.
  ///
  /// In en, this message translates to:
  /// **'Recorded radio-advertised position {latitude}, {longitude} (may be stale)'**
  String fieldOps_entryPosition(String latitude, String longitude);

  /// No description provided for @fieldOps_noteTitle.
  ///
  /// In en, this message translates to:
  /// **'Field observation'**
  String get fieldOps_noteTitle;

  /// No description provided for @fieldOps_noteLabel.
  ///
  /// In en, this message translates to:
  /// **'What did you observe?'**
  String get fieldOps_noteLabel;

  /// No description provided for @fieldOps_deadZone.
  ///
  /// In en, this message translates to:
  /// **'Reported dead zone'**
  String get fieldOps_deadZone;

  /// No description provided for @fieldOps_deadZoneHint.
  ///
  /// In en, this message translates to:
  /// **'Your observation, not a verified coverage prediction.'**
  String get fieldOps_deadZoneHint;

  /// No description provided for @fieldOps_savePosition.
  ///
  /// In en, this message translates to:
  /// **'Save radio-advertised position'**
  String get fieldOps_savePosition;

  /// No description provided for @fieldOps_positionDetail.
  ///
  /// In en, this message translates to:
  /// **'{latitude}, {longitude} • may be stale; not phone GPS'**
  String fieldOps_positionDetail(String latitude, String longitude);

  /// No description provided for @fieldOps_noPosition.
  ///
  /// In en, this message translates to:
  /// **'No usable advertised coordinates'**
  String get fieldOps_noPosition;

  /// No description provided for @fieldOps_deleteLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Field Log?'**
  String get fieldOps_deleteLogTitle;

  /// No description provided for @fieldOps_deleteLogBody.
  ///
  /// In en, this message translates to:
  /// **'This removes all saved entries on this phone. Trip settings are kept.'**
  String get fieldOps_deleteLogBody;

  /// No description provided for @fieldOps_localAutomations.
  ///
  /// In en, this message translates to:
  /// **'Local automations'**
  String get fieldOps_localAutomations;

  /// No description provided for @fieldOps_enableForTrip.
  ///
  /// In en, this message translates to:
  /// **'Enable for this trip'**
  String get fieldOps_enableForTrip;

  /// No description provided for @fieldOps_automationsCaveat.
  ///
  /// In en, this message translates to:
  /// **'Starts off after every app restart. Rules run only while the app is active. Missed scheduled actions appear in Field Log and are never replayed in a burst. Automatic check-ins are limited to one batch per 10 minutes.'**
  String get fieldOps_automationsCaveat;

  /// No description provided for @fieldOps_openBotMode.
  ///
  /// In en, this message translates to:
  /// **'Open NOTORYX Bot Mode'**
  String get fieldOps_openBotMode;

  /// No description provided for @fieldOps_ruleEnabled.
  ///
  /// In en, this message translates to:
  /// **'Rule enabled'**
  String get fieldOps_ruleEnabled;

  /// No description provided for @fieldOps_dryRun.
  ///
  /// In en, this message translates to:
  /// **'Dry run'**
  String get fieldOps_dryRun;

  /// No description provided for @fieldOps_dryRunHint.
  ///
  /// In en, this message translates to:
  /// **'Record the action without sending or notifying.'**
  String get fieldOps_dryRunHint;

  /// No description provided for @fieldOps_then.
  ///
  /// In en, this message translates to:
  /// **'Then'**
  String get fieldOps_then;

  /// No description provided for @fieldOps_actionLog.
  ///
  /// In en, this message translates to:
  /// **'Write to Field Log'**
  String get fieldOps_actionLog;

  /// No description provided for @fieldOps_actionNotify.
  ///
  /// In en, this message translates to:
  /// **'Show local notification'**
  String get fieldOps_actionNotify;

  /// No description provided for @fieldOps_actionCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Send I\'m OK to trip contacts'**
  String get fieldOps_actionCheckIn;

  /// No description provided for @fieldOps_batteryThreshold.
  ///
  /// In en, this message translates to:
  /// **'Battery at or below'**
  String get fieldOps_batteryThreshold;

  /// No description provided for @fieldOps_nextDue.
  ///
  /// In en, this message translates to:
  /// **'Next due: {time}'**
  String fieldOps_nextDue(String time);

  /// No description provided for @fieldOps_nextDueNone.
  ///
  /// In en, this message translates to:
  /// **'Next due: not scheduled'**
  String get fieldOps_nextDueNone;

  /// No description provided for @fieldOps_previewInLog.
  ///
  /// In en, this message translates to:
  /// **'Preview in log'**
  String get fieldOps_previewInLog;

  /// No description provided for @fieldOps_allowNotifications.
  ///
  /// In en, this message translates to:
  /// **'Allow notifications'**
  String get fieldOps_allowNotifications;

  /// No description provided for @fieldOps_triggerReconnect.
  ///
  /// In en, this message translates to:
  /// **'WHEN radio reconnects'**
  String get fieldOps_triggerReconnect;

  /// No description provided for @fieldOps_triggerDisconnect.
  ///
  /// In en, this message translates to:
  /// **'WHEN radio disconnects'**
  String get fieldOps_triggerDisconnect;

  /// No description provided for @fieldOps_triggerLowBattery.
  ///
  /// In en, this message translates to:
  /// **'WHEN radio battery crosses threshold'**
  String get fieldOps_triggerLowBattery;

  /// No description provided for @fieldOps_triggerNewNode.
  ///
  /// In en, this message translates to:
  /// **'WHEN a new node is added'**
  String get fieldOps_triggerNewNode;

  /// No description provided for @fieldOps_triggerRepeater.
  ///
  /// In en, this message translates to:
  /// **'WHEN a new repeater is added'**
  String get fieldOps_triggerRepeater;

  /// No description provided for @fieldOps_triggerScheduled.
  ///
  /// In en, this message translates to:
  /// **'WHEN a scheduled check-in is due'**
  String get fieldOps_triggerScheduled;

  /// No description provided for @fieldOps_explainConnection.
  ///
  /// In en, this message translates to:
  /// **'Explain my connection'**
  String get fieldOps_explainConnection;

  /// No description provided for @fieldOps_connectionState.
  ///
  /// In en, this message translates to:
  /// **'State: {state} • {transport}'**
  String fieldOps_connectionState(String state, String transport);

  /// No description provided for @fieldOps_connectedCaveat.
  ///
  /// In en, this message translates to:
  /// **'The phone has a radio connection. That alone does not establish a route to your recipients.'**
  String get fieldOps_connectedCaveat;

  /// No description provided for @fieldOps_disconnectedHint.
  ///
  /// In en, this message translates to:
  /// **'No active radio connection. Check Bluetooth permissions, radio power and range; USB/TCP are available from Connect radio.'**
  String get fieldOps_disconnectedHint;

  /// No description provided for @fieldOps_awaitingConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Trip check-ins awaiting confirmation: {count}'**
  String fieldOps_awaitingConfirmation(int count);

  /// No description provided for @fieldOps_staleCaveat.
  ///
  /// In en, this message translates to:
  /// **'Node last-seen times and advertised positions can be stale. Route intelligence shows routes learned from observed attempts; it does not invent paths.'**
  String get fieldOps_staleCaveat;

  /// No description provided for @fieldOps_routeIntelligence.
  ///
  /// In en, this message translates to:
  /// **'Route intelligence'**
  String get fieldOps_routeIntelligence;

  /// No description provided for @fieldOps_coverageIntelligence.
  ///
  /// In en, this message translates to:
  /// **'Coverage intelligence'**
  String get fieldOps_coverageIntelligence;

  /// No description provided for @fieldOps_coverageIntelligenceHint.
  ///
  /// In en, this message translates to:
  /// **'Compare recorded observations between two field sessions. Dots mark recorder radio-advertised positions where nodes were heard. They do not imply continuous coverage. RSSI/SNR snapshots are not per-node measurements.'**
  String get fieldOps_coverageIntelligenceHint;

  /// No description provided for @fieldOps_captureSession.
  ///
  /// In en, this message translates to:
  /// **'Capture a session'**
  String get fieldOps_captureSession;

  /// No description provided for @fieldOps_refreshHistory.
  ///
  /// In en, this message translates to:
  /// **'Refresh history'**
  String get fieldOps_refreshHistory;

  /// No description provided for @fieldOps_noCoverageSessions.
  ///
  /// In en, this message translates to:
  /// **'No saved coverage sessions yet.'**
  String get fieldOps_noCoverageSessions;

  /// No description provided for @fieldOps_sessionA.
  ///
  /// In en, this message translates to:
  /// **'Session A • teal'**
  String get fieldOps_sessionA;

  /// No description provided for @fieldOps_sessionB.
  ///
  /// In en, this message translates to:
  /// **'Session B • amber'**
  String get fieldOps_sessionB;

  /// No description provided for @fieldOps_uniqueCompare.
  ///
  /// In en, this message translates to:
  /// **'A: {a} unique nodes • B: {b} unique nodes'**
  String fieldOps_uniqueCompare(String a, String b);

  /// No description provided for @fieldOps_overlap.
  ///
  /// In en, this message translates to:
  /// **'Shared: {shared} • Only A: {onlyA} • Only B: {onlyB}'**
  String fieldOps_overlap(String shared, String onlyA, String onlyB);

  /// No description provided for @fieldOps_compareCaveat.
  ///
  /// In en, this message translates to:
  /// **'Not hearing a node during one session does not establish a dead zone. Conditions and observation duration differ.'**
  String get fieldOps_compareCaveat;

  /// No description provided for @fieldOps_heardTooltip.
  ///
  /// In en, this message translates to:
  /// **'Heard-node observation; not proof of a successful link'**
  String get fieldOps_heardTooltip;

  /// No description provided for @fieldOps_noteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Local note at radio-advertised coordinates; may be stale.'**
  String get fieldOps_noteTooltip;

  /// No description provided for @bastionHome_aboutTooltip.
  ///
  /// In en, this message translates to:
  /// **'About NOTORYX Core'**
  String get bastionHome_aboutTooltip;

  /// No description provided for @bastionHome_getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get bastionHome_getStarted;

  /// No description provided for @bastionHome_getStartedHint.
  ///
  /// In en, this message translates to:
  /// **'Connect your radio and verify your first message'**
  String get bastionHome_getStartedHint;

  /// No description provided for @bastionHome_planYourTrip.
  ///
  /// In en, this message translates to:
  /// **'Plan your trip'**
  String get bastionHome_planYourTrip;

  /// No description provided for @bastionHome_tripActive.
  ///
  /// In en, this message translates to:
  /// **'Trip active'**
  String get bastionHome_tripActive;

  /// No description provided for @bastionHome_tripStopped.
  ///
  /// In en, this message translates to:
  /// **'Trip stopped'**
  String get bastionHome_tripStopped;

  /// No description provided for @bastionHome_tripSummary.
  ///
  /// In en, this message translates to:
  /// **'{state} • {contacts} contacts • {unread} unread messages'**
  String bastionHome_tripSummary(String state, String contacts, String unread);

  /// No description provided for @bastionHome_checkInOk.
  ///
  /// In en, this message translates to:
  /// **'Check in: I\'m OK'**
  String get bastionHome_checkInOk;

  /// No description provided for @bastionHome_checkInHint.
  ///
  /// In en, this message translates to:
  /// **'Review contacts and message before sending. Track acknowledgements in Field Log.'**
  String get bastionHome_checkInHint;

  /// No description provided for @bastionHome_lastCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Last check-in: {summary}'**
  String bastionHome_lastCheckIn(String summary);

  /// No description provided for @bastionHome_connectRadio.
  ///
  /// In en, this message translates to:
  /// **'Connect radio'**
  String get bastionHome_connectRadio;

  /// No description provided for @bastionHome_connectRadioHint.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth, USB and TCP MeshCore connections'**
  String get bastionHome_connectRadioHint;

  /// No description provided for @bastionHome_liveDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'Live diagnostics'**
  String get bastionHome_liveDiagnostics;

  /// No description provided for @bastionHome_liveDiagnosticsHint.
  ///
  /// In en, this message translates to:
  /// **'Radio health, signal, device and frame tools'**
  String get bastionHome_liveDiagnosticsHint;

  /// No description provided for @bastionHome_meshDiscovery.
  ///
  /// In en, this message translates to:
  /// **'Mesh discovery'**
  String get bastionHome_meshDiscovery;

  /// No description provided for @bastionHome_meshDiscoveryHint.
  ///
  /// In en, this message translates to:
  /// **'Find nodes and inspect the mesh around you'**
  String get bastionHome_meshDiscoveryHint;

  /// No description provided for @bastionHome_fieldOpsHint.
  ///
  /// In en, this message translates to:
  /// **'Trip brief, readiness, Field Log, automations and coverage comparison'**
  String get bastionHome_fieldOpsHint;

  /// No description provided for @bastionHome_fieldTools.
  ///
  /// In en, this message translates to:
  /// **'Field tools'**
  String get bastionHome_fieldTools;

  /// No description provided for @bastionHome_statusActive.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get bastionHome_statusActive;

  /// No description provided for @bastionHome_consoleOnline.
  ///
  /// In en, this message translates to:
  /// **'Field console online'**
  String get bastionHome_consoleOnline;

  /// No description provided for @bastionHome_consoleReady.
  ///
  /// In en, this message translates to:
  /// **'Field console ready'**
  String get bastionHome_consoleReady;

  /// No description provided for @bastionHome_consoleHint.
  ///
  /// In en, this message translates to:
  /// **'Connect a radio to light up the live dashboard.'**
  String get bastionHome_consoleHint;

  /// No description provided for @bastionHome_battery.
  ///
  /// In en, this message translates to:
  /// **'Battery {value}'**
  String bastionHome_battery(String value);

  /// No description provided for @bastionTools_title.
  ///
  /// In en, this message translates to:
  /// **'Field Tools'**
  String get bastionTools_title;

  /// No description provided for @bastionTools_backup.
  ///
  /// In en, this message translates to:
  /// **'Encrypted backup'**
  String get bastionTools_backup;

  /// No description provided for @bastionTools_backupHint.
  ///
  /// In en, this message translates to:
  /// **'Save settings, contacts and keys with optional chat history'**
  String get bastionTools_backupHint;

  /// No description provided for @bastionTools_fieldOpsHint.
  ///
  /// In en, this message translates to:
  /// **'Check-ins, readiness, Field Log, automations and comparisons'**
  String get bastionTools_fieldOpsHint;

  /// No description provided for @bastionTools_mapHint.
  ///
  /// In en, this message translates to:
  /// **'Live map, capture sessions, offline map tools and regions'**
  String get bastionTools_mapHint;

  /// No description provided for @bastionTools_pathAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Path analysis'**
  String get bastionTools_pathAnalysis;

  /// No description provided for @bastionTools_pathHint.
  ///
  /// In en, this message translates to:
  /// **'Routes, discovery and path intelligence'**
  String get bastionTools_pathHint;

  /// No description provided for @bastionTools_repeaterHint.
  ///
  /// In en, this message translates to:
  /// **'Status, login, telemetry, neighbors and administration'**
  String get bastionTools_repeaterHint;

  /// No description provided for @bastionTools_statsHint.
  ///
  /// In en, this message translates to:
  /// **'Live mesh counts and contact activity'**
  String get bastionTools_statsHint;

  /// No description provided for @bastionTools_diagnostics.
  ///
  /// In en, this message translates to:
  /// **'Diagnostics'**
  String get bastionTools_diagnostics;

  /// No description provided for @bastionTools_diagnosticsHint.
  ///
  /// In en, this message translates to:
  /// **'Radio health, device information, raw frames and export'**
  String get bastionTools_diagnosticsHint;

  /// No description provided for @bastionTools_about.
  ///
  /// In en, this message translates to:
  /// **'About + credits'**
  String get bastionTools_about;

  /// No description provided for @bastionTools_aboutHint.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core version, independence statement and open-source licenses'**
  String get bastionTools_aboutHint;

  /// No description provided for @bastionAbout_title.
  ///
  /// In en, this message translates to:
  /// **'About + Credits'**
  String get bastionAbout_title;

  /// No description provided for @bastionAbout_intro.
  ///
  /// In en, this message translates to:
  /// **'An independent community companion app for MeshCore networks. NOTORYX Core is not an official MeshCore app and inclusion of community resources does not imply partnership or endorsement.'**
  String get bastionAbout_intro;

  /// No description provided for @bastionAbout_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get bastionAbout_version;

  /// No description provided for @bastionAbout_openSource.
  ///
  /// In en, this message translates to:
  /// **'Open source foundation'**
  String get bastionAbout_openSource;

  /// No description provided for @bastionAbout_openSourceBody.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core is built from and modifies open-source MeshCore Open code under the MIT License. Coverage workflow work also credits the MIT-licensed MeshMapper Flutter App where applicable.'**
  String get bastionAbout_openSourceBody;

  /// No description provided for @bastionAbout_community.
  ///
  /// In en, this message translates to:
  /// **'Community first'**
  String get bastionAbout_community;

  /// No description provided for @bastionAbout_communityBody.
  ///
  /// In en, this message translates to:
  /// **'Third-party creator resources remain the property of their respective creators. No ownership or partnership is implied.'**
  String get bastionAbout_communityBody;

  /// No description provided for @bastionAbout_legalese.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core • Independent MeshCore companion'**
  String get bastionAbout_legalese;

  /// No description provided for @bastionAbout_licenses.
  ///
  /// In en, this message translates to:
  /// **'Open source licenses'**
  String get bastionAbout_licenses;

  /// No description provided for @bastionSetup_title.
  ///
  /// In en, this message translates to:
  /// **'Get started with NOTORYX Core'**
  String get bastionSetup_title;

  /// No description provided for @bastionSetup_intro.
  ///
  /// In en, this message translates to:
  /// **'Connect, choose a contact, then verify a message. You can return to this guide from the dashboard at any time.'**
  String get bastionSetup_intro;

  /// No description provided for @bastionSetup_step1.
  ///
  /// In en, this message translates to:
  /// **'1. Connect your MeshCore radio'**
  String get bastionSetup_step1;

  /// No description provided for @bastionSetup_connectedTo.
  ///
  /// In en, this message translates to:
  /// **'Connected to {device} using {transport}.'**
  String bastionSetup_connectedTo(String device, String transport);

  /// No description provided for @bastionSetup_noRadio.
  ///
  /// In en, this message translates to:
  /// **'No radio connected yet.'**
  String get bastionSetup_noRadio;

  /// No description provided for @bastionSetup_step1Power.
  ///
  /// In en, this message translates to:
  /// **'Power on a MeshCore companion radio. Open Connect radio and choose Bluetooth, USB or TCP. Allow the permissions requested for your chosen connection.'**
  String get bastionSetup_step1Power;

  /// No description provided for @bastionSetup_step1Bluetooth.
  ///
  /// In en, this message translates to:
  /// **'If Bluetooth discovery is empty, check Bluetooth is enabled and NOTORYX Core has Nearby devices permission in Android app settings. Follow any additional permission prompt shown by the scanner.'**
  String get bastionSetup_step1Bluetooth;

  /// No description provided for @bastionSetup_connectionDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'Connection diagnostics'**
  String get bastionSetup_connectionDiagnostics;

  /// No description provided for @bastionSetup_step2.
  ///
  /// In en, this message translates to:
  /// **'2. Choose a chat contact'**
  String get bastionSetup_step2;

  /// No description provided for @bastionSetup_step2Body.
  ///
  /// In en, this message translates to:
  /// **'Ask a nearby partner with compatible MeshCore radio settings to advertise their node. Choose a known chat contact below; repeaters are managed separately.'**
  String get bastionSetup_step2Body;

  /// No description provided for @bastionSetup_noContacts.
  ///
  /// In en, this message translates to:
  /// **'No chat contacts available. Connect your radio and open Mesh discovery.'**
  String get bastionSetup_noContacts;

  /// No description provided for @bastionSetup_testRecipient.
  ///
  /// In en, this message translates to:
  /// **'Test recipient'**
  String get bastionSetup_testRecipient;

  /// No description provided for @bastionSetup_meshDiscovery.
  ///
  /// In en, this message translates to:
  /// **'Mesh discovery'**
  String get bastionSetup_meshDiscovery;

  /// No description provided for @bastionSetup_step3.
  ///
  /// In en, this message translates to:
  /// **'3. Send and verify a message'**
  String get bastionSetup_step3;

  /// No description provided for @bastionSetup_step3Body.
  ///
  /// In en, this message translates to:
  /// **'Open chat, write a short test message, review the recipient and tap Send. Return here to see the latest outgoing message recorded since opening this guide.'**
  String get bastionSetup_step3Body;

  /// No description provided for @bastionSetup_openTestChat.
  ///
  /// In en, this message translates to:
  /// **'Open test chat'**
  String get bastionSetup_openTestChat;

  /// No description provided for @bastionSetup_connectFirst.
  ///
  /// In en, this message translates to:
  /// **'Connect your radio to open test chat.'**
  String get bastionSetup_connectFirst;

  /// No description provided for @bastionSetup_chooseRecipient.
  ///
  /// In en, this message translates to:
  /// **'Choose a recipient first.'**
  String get bastionSetup_chooseRecipient;

  /// No description provided for @bastionSetup_noTestMessage.
  ///
  /// In en, this message translates to:
  /// **'No outgoing test message recorded in this guide session.'**
  String get bastionSetup_noTestMessage;

  /// No description provided for @bastionSetup_latestMessage.
  ///
  /// In en, this message translates to:
  /// **'Latest message: {status} • {time}'**
  String bastionSetup_latestMessage(String status, String time);

  /// No description provided for @bastionSetup_confirmReceipt.
  ///
  /// In en, this message translates to:
  /// **'Ask your partner to confirm receipt or reply. A recorded acknowledgment does not prove they read it. Recheck the connection and recipient if a message fails.'**
  String get bastionSetup_confirmReceipt;

  /// No description provided for @bastionSetup_step4.
  ///
  /// In en, this message translates to:
  /// **'4. Prepare for the field'**
  String get bastionSetup_step4;

  /// No description provided for @bastionSetup_step4Body.
  ///
  /// In en, this message translates to:
  /// **'Plan your trip contacts and inspect downloaded map areas. Bot Mode and field automations start off; field automations run only while the app is active.'**
  String get bastionSetup_step4Body;

  /// No description provided for @bastionSetup_tripTools.
  ///
  /// In en, this message translates to:
  /// **'Trip and readiness tools'**
  String get bastionSetup_tripTools;

  /// No description provided for @bastionDiag_title.
  ///
  /// In en, this message translates to:
  /// **'Diagnostics'**
  String get bastionDiag_title;

  /// No description provided for @bastionDiag_export.
  ///
  /// In en, this message translates to:
  /// **'Export diagnostics'**
  String get bastionDiag_export;

  /// No description provided for @bastionDiag_channels.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get bastionDiag_channels;

  /// No description provided for @bastionDiag_radio.
  ///
  /// In en, this message translates to:
  /// **'Radio'**
  String get bastionDiag_radio;

  /// No description provided for @bastionDiag_frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get bastionDiag_frequency;

  /// No description provided for @bastionDiag_bandwidth.
  ///
  /// In en, this message translates to:
  /// **'Bandwidth'**
  String get bastionDiag_bandwidth;

  /// No description provided for @bastionDiag_spreadingFactor.
  ///
  /// In en, this message translates to:
  /// **'Spreading factor'**
  String get bastionDiag_spreadingFactor;

  /// No description provided for @bastionDiag_codingRate.
  ///
  /// In en, this message translates to:
  /// **'Coding rate'**
  String get bastionDiag_codingRate;

  /// No description provided for @bastionDiag_txPower.
  ///
  /// In en, this message translates to:
  /// **'TX power'**
  String get bastionDiag_txPower;

  /// No description provided for @bastionDiag_noiseFloor.
  ///
  /// In en, this message translates to:
  /// **'Noise floor'**
  String get bastionDiag_noiseFloor;

  /// No description provided for @bastionDiag_device.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get bastionDiag_device;

  /// No description provided for @bastionDiag_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get bastionDiag_name;

  /// No description provided for @bastionDiag_manufacturer.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer'**
  String get bastionDiag_manufacturer;

  /// No description provided for @bastionDiag_firmware.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get bastionDiag_firmware;

  /// No description provided for @bastionDiag_battery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get bastionDiag_battery;

  /// No description provided for @bastionDiag_transport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get bastionDiag_transport;

  /// No description provided for @bastionDiag_deepTools.
  ///
  /// In en, this message translates to:
  /// **'Deep tools'**
  String get bastionDiag_deepTools;

  /// No description provided for @bastionDiag_liveStats.
  ///
  /// In en, this message translates to:
  /// **'Live radio stats'**
  String get bastionDiag_liveStats;

  /// No description provided for @bastionDiag_liveStatsHint.
  ///
  /// In en, this message translates to:
  /// **'Noise, RSSI, SNR and airtime'**
  String get bastionDiag_liveStatsHint;

  /// No description provided for @bastionDiag_frameDebug.
  ///
  /// In en, this message translates to:
  /// **'Frame / BLE debug'**
  String get bastionDiag_frameDebug;

  /// No description provided for @bastionDiag_frameDebugHint.
  ///
  /// In en, this message translates to:
  /// **'Inspect decoded and raw received frames'**
  String get bastionDiag_frameDebugHint;

  /// No description provided for @bastionDiag_appLog.
  ///
  /// In en, this message translates to:
  /// **'App debug log'**
  String get bastionDiag_appLog;

  /// No description provided for @bastionDiag_appLogHint.
  ///
  /// In en, this message translates to:
  /// **'Review application diagnostic events'**
  String get bastionDiag_appLogHint;

  /// No description provided for @bastionDiag_online.
  ///
  /// In en, this message translates to:
  /// **'Radio online'**
  String get bastionDiag_online;

  /// No description provided for @bastionDiag_offline.
  ///
  /// In en, this message translates to:
  /// **'Radio offline'**
  String get bastionDiag_offline;

  /// No description provided for @bastionDiag_offlineHint.
  ///
  /// In en, this message translates to:
  /// **'Connect a MeshCore companion to populate live diagnostics.'**
  String get bastionDiag_offlineHint;

  /// No description provided for @coverage_title.
  ///
  /// In en, this message translates to:
  /// **'Coverage Capture'**
  String get coverage_title;

  /// No description provided for @coverage_leaveBlocked.
  ///
  /// In en, this message translates to:
  /// **'Stop and save the session before leaving.'**
  String get coverage_leaveBlocked;

  /// No description provided for @coverage_savedSessions.
  ///
  /// In en, this message translates to:
  /// **'Saved sessions'**
  String get coverage_savedSessions;

  /// No description provided for @coverage_caveat.
  ///
  /// In en, this message translates to:
  /// **'RSSI/SNR are radio snapshots and may belong to another packet. Positions are radio-advertised coordinates, not phone GPS or proof of coverage. Cyan: recorder; amber: advertised node. No interpolation is performed.'**
  String get coverage_caveat;

  /// No description provided for @coverage_captureActive.
  ///
  /// In en, this message translates to:
  /// **'Capture active'**
  String get coverage_captureActive;

  /// No description provided for @coverage_fieldSession.
  ///
  /// In en, this message translates to:
  /// **'Field coverage session'**
  String get coverage_fieldSession;

  /// No description provided for @coverage_connectedBody.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core records newly heard nodes during this session, including route data, node/location metadata and the nearest available radio RSSI/SNR snapshot.'**
  String get coverage_connectedBody;

  /// No description provided for @coverage_disconnectedBody.
  ///
  /// In en, this message translates to:
  /// **'Connect a radio before starting. Coverage capture records live mesh observations from the connected companion radio.'**
  String get coverage_disconnectedBody;

  /// No description provided for @coverage_observations.
  ///
  /// In en, this message translates to:
  /// **'Observations'**
  String get coverage_observations;

  /// No description provided for @coverage_uniqueNodes.
  ///
  /// In en, this message translates to:
  /// **'Unique nodes'**
  String get coverage_uniqueNodes;

  /// No description provided for @coverage_elapsed.
  ///
  /// In en, this message translates to:
  /// **'Elapsed'**
  String get coverage_elapsed;

  /// No description provided for @coverage_radioConnected.
  ///
  /// In en, this message translates to:
  /// **'Radio connected'**
  String get coverage_radioConnected;

  /// No description provided for @coverage_noRadio.
  ///
  /// In en, this message translates to:
  /// **'No radio'**
  String get coverage_noRadio;

  /// No description provided for @coverage_gpsReady.
  ///
  /// In en, this message translates to:
  /// **'Radio GPS ready'**
  String get coverage_gpsReady;

  /// No description provided for @coverage_noGps.
  ///
  /// In en, this message translates to:
  /// **'No radio GPS'**
  String get coverage_noGps;

  /// No description provided for @coverage_stopSave.
  ///
  /// In en, this message translates to:
  /// **'Stop + save session'**
  String get coverage_stopSave;

  /// No description provided for @coverage_start.
  ///
  /// In en, this message translates to:
  /// **'Start coverage session'**
  String get coverage_start;

  /// No description provided for @coverage_exportJson.
  ///
  /// In en, this message translates to:
  /// **'Export JSON'**
  String get coverage_exportJson;

  /// No description provided for @coverage_exportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get coverage_exportCsv;

  /// No description provided for @coverage_liveObservations.
  ///
  /// In en, this message translates to:
  /// **'Live observations'**
  String get coverage_liveObservations;

  /// No description provided for @coverage_waiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting for mesh activity'**
  String get coverage_waiting;

  /// No description provided for @coverage_waitingBody.
  ///
  /// In en, this message translates to:
  /// **'Start a session and newly heard active nodes will appear here. RSSI/SNR values are radio snapshots and may not always be uniquely attributable to a specific packet.'**
  String get coverage_waitingBody;

  /// No description provided for @coverage_signalNa.
  ///
  /// In en, this message translates to:
  /// **'signal n/a'**
  String get coverage_signalNa;

  /// No description provided for @coverage_snrNa.
  ///
  /// In en, this message translates to:
  /// **'SNR n/a'**
  String get coverage_snrNa;

  /// No description provided for @coverage_gpsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'radio GPS unavailable'**
  String get coverage_gpsUnavailable;

  /// No description provided for @coverage_pathLine.
  ///
  /// In en, this message translates to:
  /// **'Path: {path}  •  {location}'**
  String coverage_pathLine(String path, String location);

  /// No description provided for @coverage_pathFlood.
  ///
  /// In en, this message translates to:
  /// **'flood'**
  String get coverage_pathFlood;

  /// No description provided for @coverage_pathDirect.
  ///
  /// In en, this message translates to:
  /// **'direct'**
  String get coverage_pathDirect;

  /// No description provided for @coverage_shareSubject.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core Coverage Session'**
  String get coverage_shareSubject;

  /// No description provided for @coverage_shareText.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core coverage capture export'**
  String get coverage_shareText;

  /// No description provided for @coverage_historyTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved coverage sessions'**
  String get coverage_historyTitle;

  /// No description provided for @coverage_loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load sessions: {error}'**
  String coverage_loadFailed(String error);

  /// No description provided for @coverage_deleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete saved session?'**
  String get coverage_deleteTitle;

  /// No description provided for @coverage_deleteBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 observation will be removed from this device.} other{{count} observations will be removed from this device.}}'**
  String coverage_deleteBody(int count);

  /// No description provided for @coverage_deleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not delete session: {error}'**
  String coverage_deleteFailed(String error);

  /// No description provided for @coverage_retention.
  ///
  /// In en, this message translates to:
  /// **'The newest 20 completed sessions are retained. Share sessions you want to keep. Interrupted captures can be reopened below.'**
  String get coverage_retention;

  /// No description provided for @coverage_noSessions.
  ///
  /// In en, this message translates to:
  /// **'No saved sessions yet. Stop a capture to save it.'**
  String get coverage_noSessions;

  /// No description provided for @coverage_interrupted.
  ///
  /// In en, this message translates to:
  /// **'Interrupted capture'**
  String get coverage_interrupted;

  /// No description provided for @coverage_saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get coverage_saved;

  /// No description provided for @coverage_deleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete session'**
  String get coverage_deleteTooltip;

  /// No description provided for @coverage_exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String coverage_exportFailed(String error);

  /// No description provided for @coverage_sessionTitle.
  ///
  /// In en, this message translates to:
  /// **'Coverage session'**
  String get coverage_sessionTitle;

  /// No description provided for @coverage_shareJson.
  ///
  /// In en, this message translates to:
  /// **'Share JSON'**
  String get coverage_shareJson;

  /// No description provided for @coverage_shareCsv.
  ///
  /// In en, this message translates to:
  /// **'Share CSV'**
  String get coverage_shareCsv;

  /// No description provided for @coverage_snapshotDetail.
  ///
  /// In en, this message translates to:
  /// **'{rssi} dBm • SNR {snr} dB • snapshot age {age} ms'**
  String coverage_snapshotDetail(String rssi, String snr, String age);

  /// No description provided for @coverage_unknown.
  ///
  /// In en, this message translates to:
  /// **'unknown'**
  String get coverage_unknown;

  /// No description provided for @coverage_pathValue.
  ///
  /// In en, this message translates to:
  /// **'path {path}'**
  String coverage_pathValue(String path);

  /// No description provided for @coverage_recorder.
  ///
  /// In en, this message translates to:
  /// **'Recorder'**
  String get coverage_recorder;

  /// No description provided for @coverage_noCoordinates.
  ///
  /// In en, this message translates to:
  /// **'No usable coordinates in this session. Observations remain available below.'**
  String get coverage_noCoordinates;

  /// No description provided for @coverage_osmAttribution.
  ///
  /// In en, this message translates to:
  /// **'© OpenStreetMap contributors • online basemap'**
  String get coverage_osmAttribution;

  /// No description provided for @fieldStats_title.
  ///
  /// In en, this message translates to:
  /// **'Field intelligence'**
  String get fieldStats_title;

  /// No description provided for @fieldStats_snapshot.
  ///
  /// In en, this message translates to:
  /// **'Live mesh snapshot'**
  String get fieldStats_snapshot;

  /// No description provided for @fieldStats_headline.
  ///
  /// In en, this message translates to:
  /// **'What NOTORYX Core knows right now.'**
  String get fieldStats_headline;

  /// No description provided for @fieldStats_body.
  ///
  /// In en, this message translates to:
  /// **'These counters are calculated from the connected MeshCore contact table, locations, paths and last-seen timestamps.'**
  String get fieldStats_body;

  /// No description provided for @fieldStats_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get fieldStats_total;

  /// No description provided for @fieldStats_chatNodes.
  ///
  /// In en, this message translates to:
  /// **'Chat nodes'**
  String get fieldStats_chatNodes;

  /// No description provided for @fieldStats_rooms.
  ///
  /// In en, this message translates to:
  /// **'Rooms'**
  String get fieldStats_rooms;

  /// No description provided for @fieldStats_sensors.
  ///
  /// In en, this message translates to:
  /// **'Sensors'**
  String get fieldStats_sensors;

  /// No description provided for @fieldStats_located.
  ///
  /// In en, this message translates to:
  /// **'Located'**
  String get fieldStats_located;

  /// No description provided for @fieldStats_favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get fieldStats_favorites;

  /// No description provided for @fieldStats_routeSnapshot.
  ///
  /// In en, this message translates to:
  /// **'Route snapshot'**
  String get fieldStats_routeSnapshot;

  /// No description provided for @fieldStats_routed.
  ///
  /// In en, this message translates to:
  /// **'Routed'**
  String get fieldStats_routed;

  /// No description provided for @fieldStats_direct.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get fieldStats_direct;

  /// No description provided for @fieldStats_flood.
  ///
  /// In en, this message translates to:
  /// **'Flood'**
  String get fieldStats_flood;

  /// No description provided for @fieldStats_pathIntel.
  ///
  /// In en, this message translates to:
  /// **'Path intelligence'**
  String get fieldStats_pathIntel;

  /// No description provided for @fieldStats_pathIntelBody.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core’s Route Intelligence uses persisted path attempts, hop counts, success/failure, trip time and route weighting to surface learned routes.'**
  String get fieldStats_pathIntelBody;

  /// No description provided for @fieldStats_coverageSessions.
  ///
  /// In en, this message translates to:
  /// **'Coverage sessions'**
  String get fieldStats_coverageSessions;

  /// No description provided for @fieldStats_coverageSessionsBody.
  ///
  /// In en, this message translates to:
  /// **'Coverage Capture now saves field sessions, restores interrupted work, exports observations and maps recorded coverage points. RSSI/SNR remain the nearest available radio snapshot.'**
  String get fieldStats_coverageSessionsBody;

  /// No description provided for @mapHub_title.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX field map'**
  String get mapHub_title;

  /// No description provided for @mapHub_intro.
  ///
  /// In en, this message translates to:
  /// **'Live maps, offline areas, regional profiles and NOTORYX Core field coverage sessions.'**
  String get mapHub_intro;

  /// No description provided for @mapHub_captureHint.
  ///
  /// In en, this message translates to:
  /// **'Start and stop a field coverage session'**
  String get mapHub_captureHint;

  /// No description provided for @mapHub_badgeNew.
  ///
  /// In en, this message translates to:
  /// **'NEW'**
  String get mapHub_badgeNew;

  /// No description provided for @mapHub_liveMap.
  ///
  /// In en, this message translates to:
  /// **'Live mesh map'**
  String get mapHub_liveMap;

  /// No description provided for @mapHub_liveMapHint.
  ///
  /// In en, this message translates to:
  /// **'Nodes, repeaters, positions, routes and map tools'**
  String get mapHub_liveMapHint;

  /// No description provided for @mapHub_badgeLive.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get mapHub_badgeLive;

  /// No description provided for @mapHub_offlinePacks.
  ///
  /// In en, this message translates to:
  /// **'Offline map packs'**
  String get mapHub_offlinePacks;

  /// No description provided for @mapHub_offlinePacksHint.
  ///
  /// In en, this message translates to:
  /// **'Cache map tiles for trips and no-service areas'**
  String get mapHub_offlinePacksHint;

  /// No description provided for @mapHub_badgeOffline.
  ///
  /// In en, this message translates to:
  /// **'OFFLINE'**
  String get mapHub_badgeOffline;

  /// No description provided for @mapHub_regions.
  ///
  /// In en, this message translates to:
  /// **'Region profiles'**
  String get mapHub_regions;

  /// No description provided for @mapHub_regionsHint.
  ///
  /// In en, this message translates to:
  /// **'Manage and fetch regional mesh definitions'**
  String get mapHub_regionsHint;

  /// No description provided for @mapHub_badgeRegions.
  ///
  /// In en, this message translates to:
  /// **'REGIONS'**
  String get mapHub_badgeRegions;

  /// No description provided for @routes_title.
  ///
  /// In en, this message translates to:
  /// **'Route Intelligence'**
  String get routes_title;

  /// No description provided for @routes_headline.
  ///
  /// In en, this message translates to:
  /// **'See how traffic moves through the mesh.'**
  String get routes_headline;

  /// No description provided for @routes_body.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core ranks saved routes using the path history already learned from real message attempts and discoveries.'**
  String get routes_body;

  /// No description provided for @routes_routes.
  ///
  /// In en, this message translates to:
  /// **'Routes'**
  String get routes_routes;

  /// No description provided for @routes_success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get routes_success;

  /// No description provided for @routes_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get routes_failed;

  /// No description provided for @routes_routeMap.
  ///
  /// In en, this message translates to:
  /// **'Route map'**
  String get routes_routeMap;

  /// No description provided for @routes_routeMapHint.
  ///
  /// In en, this message translates to:
  /// **'Inspect nodes and paths'**
  String get routes_routeMapHint;

  /// No description provided for @routes_discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get routes_discover;

  /// No description provided for @routes_discoverHint.
  ///
  /// In en, this message translates to:
  /// **'Find fresh routes'**
  String get routes_discoverHint;

  /// No description provided for @routes_learned.
  ///
  /// In en, this message translates to:
  /// **'Learned routes'**
  String get routes_learned;

  /// No description provided for @routes_none.
  ///
  /// In en, this message translates to:
  /// **'No route history yet'**
  String get routes_none;

  /// No description provided for @routes_noneBody.
  ///
  /// In en, this message translates to:
  /// **'Use the mesh normally or run discovery. NOTORYX Core will surface learned routes here as path history becomes available.'**
  String get routes_noneBody;

  /// No description provided for @routes_direct.
  ///
  /// In en, this message translates to:
  /// **'DIRECT'**
  String get routes_direct;

  /// No description provided for @routes_routeCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 route} other{{count} routes}}'**
  String routes_routeCount(int count);

  /// No description provided for @routes_best.
  ///
  /// In en, this message translates to:
  /// **'BEST  {path}'**
  String routes_best(String path);

  /// No description provided for @routes_bestDetail.
  ///
  /// In en, this message translates to:
  /// **'{hops}  •  weight {weight}  •  {success} success / {fail} fail'**
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  );

  /// No description provided for @routes_fastest.
  ///
  /// In en, this message translates to:
  /// **'Fastest known: {ms} ms'**
  String routes_fastest(String ms);

  /// No description provided for @routes_flood.
  ///
  /// In en, this message translates to:
  /// **'Flood: {success} success / {fail} fail'**
  String routes_flood(String success, String fail);

  /// No description provided for @repeaterTools_heroLabel.
  ///
  /// In en, this message translates to:
  /// **'Repeater command'**
  String get repeaterTools_heroLabel;

  /// No description provided for @repeaterTools_headline.
  ///
  /// In en, this message translates to:
  /// **'Manage the infrastructure behind your mesh.'**
  String get repeaterTools_headline;

  /// No description provided for @repeaterTools_body.
  ///
  /// In en, this message translates to:
  /// **'Select a discovered repeater to authenticate and open its existing MeshCore status, telemetry, neighbors, settings and CLI tools.'**
  String get repeaterTools_body;

  /// No description provided for @repeaterTools_discovered.
  ///
  /// In en, this message translates to:
  /// **'Discovered'**
  String get repeaterTools_discovered;

  /// No description provided for @repeaterTools_tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get repeaterTools_tools;

  /// No description provided for @repeaterTools_available.
  ///
  /// In en, this message translates to:
  /// **'Available repeaters'**
  String get repeaterTools_available;

  /// No description provided for @repeaterTools_unnamed.
  ///
  /// In en, this message translates to:
  /// **'Unnamed repeater'**
  String get repeaterTools_unnamed;

  /// No description provided for @repeaterTools_statusTelemetry.
  ///
  /// In en, this message translates to:
  /// **'Status + telemetry'**
  String get repeaterTools_statusTelemetry;

  /// No description provided for @repeaterTools_statusTelemetryBody.
  ///
  /// In en, this message translates to:
  /// **'Inspect repeater health and telemetry using the existing management stack.'**
  String get repeaterTools_statusTelemetryBody;

  /// No description provided for @repeaterTools_neighbors.
  ///
  /// In en, this message translates to:
  /// **'Neighbors'**
  String get repeaterTools_neighbors;

  /// No description provided for @repeaterTools_neighborsBody.
  ///
  /// In en, this message translates to:
  /// **'Inspect neighboring infrastructure and mesh relationships.'**
  String get repeaterTools_neighborsBody;

  /// No description provided for @repeaterTools_cli.
  ///
  /// In en, this message translates to:
  /// **'CLI + settings'**
  String get repeaterTools_cli;

  /// No description provided for @repeaterTools_cliBody.
  ///
  /// In en, this message translates to:
  /// **'Authenticated administrators can reach the existing repeater CLI and configuration tools.'**
  String get repeaterTools_cliBody;

  /// No description provided for @repeaterTools_empty.
  ///
  /// In en, this message translates to:
  /// **'No repeaters discovered yet. Connect a radio and discover the mesh first.'**
  String get repeaterTools_empty;

  /// No description provided for @notification_fieldAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Field Alert'**
  String get notification_fieldAlertTitle;

  /// No description provided for @notification_checkInReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX Core check-in reminder'**
  String get notification_checkInReminderTitle;

  /// No description provided for @notification_checkInReminderBody.
  ///
  /// In en, this message translates to:
  /// **'No check-in for {minutes} minutes on {trip}. Open NOTORYX Core to check in.'**
  String notification_checkInReminderBody(int minutes, String trip);

  /// No description provided for @notification_overdueBody.
  ///
  /// In en, this message translates to:
  /// **'{name} not heard from in {minutes} minutes. This is not a confirmed emergency.'**
  String notification_overdueBody(String name, int minutes);

  /// No description provided for @notification_aTripContact.
  ///
  /// In en, this message translates to:
  /// **'A trip contact'**
  String get notification_aTripContact;

  /// No description provided for @notification_checkInNotDelivered.
  ///
  /// In en, this message translates to:
  /// **'Check-in not delivered to {name}. You can resend it from Trip.'**
  String notification_checkInNotDelivered(String name);

  /// No description provided for @notification_sosAcknowledged.
  ///
  /// In en, this message translates to:
  /// **'SOS acknowledged by {name}'**
  String notification_sosAcknowledged(String name);

  /// No description provided for @settings_batterySaver.
  ///
  /// In en, this message translates to:
  /// **'Battery saver'**
  String get settings_batterySaver;

  /// No description provided for @settings_batterySaverOn.
  ///
  /// In en, this message translates to:
  /// **'On: radio battery every 10 min, GPS every 5 min, stats at most once a minute, trip checks every 1–2 min. Messages, alerts and SOS are unchanged.'**
  String get settings_batterySaverOn;

  /// No description provided for @settings_batterySaverOff.
  ///
  /// In en, this message translates to:
  /// **'Check the radio and trip less often to save phone and radio battery. Messages, alerts and SOS are unchanged.'**
  String get settings_batterySaverOff;

  /// No description provided for @settings_readAloud.
  ///
  /// In en, this message translates to:
  /// **'Read new messages aloud'**
  String get settings_readAloud;

  /// No description provided for @settings_readAloudHelper.
  ///
  /// In en, this message translates to:
  /// **'While NOTORYX Core is open. Muted channels stay quiet. Any message can also be read from its menu.'**
  String get settings_readAloudHelper;

  /// No description provided for @settings_readAloudOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settings_readAloudOff;

  /// No description provided for @settings_readAloudDirect.
  ///
  /// In en, this message translates to:
  /// **'Direct messages'**
  String get settings_readAloudDirect;

  /// No description provided for @settings_readAloudAll.
  ///
  /// In en, this message translates to:
  /// **'Direct and channel messages'**
  String get settings_readAloudAll;

  /// No description provided for @chat_readAloud.
  ///
  /// In en, this message translates to:
  /// **'Read aloud'**
  String get chat_readAloud;

  /// No description provided for @messageSearch_title.
  ///
  /// In en, this message translates to:
  /// **'Search messages'**
  String get messageSearch_title;

  /// No description provided for @messageSearch_intro.
  ///
  /// In en, this message translates to:
  /// **'Search every direct and channel message saved on this phone.'**
  String get messageSearch_intro;

  /// No description provided for @messageSearch_noResults.
  ///
  /// In en, this message translates to:
  /// **'No messages contain \"{query}\".'**
  String messageSearch_noResults(String query);

  /// No description provided for @messageSearch_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 match} other{{count} matches}}'**
  String messageSearch_count(int count);

  /// No description provided for @messageSearch_capped.
  ///
  /// In en, this message translates to:
  /// **'Showing the newest {count} matches'**
  String messageSearch_capped(int count);

  /// No description provided for @shortcuts_checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get shortcuts_checkIn;

  /// No description provided for @shortcuts_trip.
  ///
  /// In en, this message translates to:
  /// **'Trip'**
  String get shortcuts_trip;

  /// No description provided for @shortcuts_chats.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get shortcuts_chats;

  /// No description provided for @shortcuts_map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get shortcuts_map;

  /// No description provided for @sensor_liveUpdates.
  ///
  /// In en, this message translates to:
  /// **'Live updates'**
  String get sensor_liveUpdates;

  /// No description provided for @sensor_intro.
  ///
  /// In en, this message translates to:
  /// **'Have the sensor send readings by itself when they change, instead of asking each time. Needs a login with read access.'**
  String get sensor_intro;

  /// No description provided for @sensor_watch.
  ///
  /// In en, this message translates to:
  /// **'Watch for changes'**
  String get sensor_watch;

  /// No description provided for @sensor_loadFirst.
  ///
  /// In en, this message translates to:
  /// **'Load telemetry first to choose readings.'**
  String get sensor_loadFirst;

  /// No description provided for @sensor_watching.
  ///
  /// In en, this message translates to:
  /// **'Watching {readings} until {time}.'**
  String sensor_watching(String readings, String time);

  /// No description provided for @sensor_watchingRegion.
  ///
  /// In en, this message translates to:
  /// **'Watching {readings} until {time} • region {region}.'**
  String sensor_watchingRegion(String readings, String time, String region);

  /// No description provided for @sensor_noChanges.
  ///
  /// In en, this message translates to:
  /// **'No changes reported yet.'**
  String get sensor_noChanges;

  /// No description provided for @sensor_lastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last update {time} • {count} received'**
  String sensor_lastUpdate(String time, int count);

  /// No description provided for @sensor_stop.
  ///
  /// In en, this message translates to:
  /// **'Stop live updates'**
  String get sensor_stop;

  /// No description provided for @sensor_stopUnconfirmed.
  ///
  /// In en, this message translates to:
  /// **'Stopped here; the sensor did not confirm and will stop when the time runs out. {error}'**
  String sensor_stopUnconfirmed(String error);

  /// No description provided for @sensor_dialogBody.
  ///
  /// In en, this message translates to:
  /// **'The sensor checks about once a minute and sends an update when a chosen reading changes by more than its threshold.'**
  String get sensor_dialogBody;

  /// No description provided for @sensor_readingTitle.
  ///
  /// In en, this message translates to:
  /// **'{label} (ch {channel})'**
  String sensor_readingTitle(String label, String channel);

  /// No description provided for @sensor_readingValue.
  ///
  /// In en, this message translates to:
  /// **'{label} (ch {channel}): {value}'**
  String sensor_readingValue(String label, String channel, String value);

  /// No description provided for @sensor_watchItem.
  ///
  /// In en, this message translates to:
  /// **'{label} (ch {channel}) ±{delta}'**
  String sensor_watchItem(String label, String channel, String delta);

  /// No description provided for @sensor_updateOn.
  ///
  /// In en, this message translates to:
  /// **'Update on a change of {delta}'**
  String sensor_updateOn(String delta);

  /// No description provided for @sensor_changeThreshold.
  ///
  /// In en, this message translates to:
  /// **'Change threshold'**
  String get sensor_changeThreshold;

  /// No description provided for @sensor_capacity.
  ///
  /// In en, this message translates to:
  /// **'The sensor can watch up to {max} bytes of readings ({used} used).'**
  String sensor_capacity(int max, String used);

  /// No description provided for @sensor_for.
  ///
  /// In en, this message translates to:
  /// **'For'**
  String get sensor_for;

  /// No description provided for @sensor_hours.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hour} other{{count} hours}}'**
  String sensor_hours(int count);

  /// No description provided for @sensor_start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get sensor_start;

  /// No description provided for @sensor_thresholdTitle.
  ///
  /// In en, this message translates to:
  /// **'{label} threshold'**
  String sensor_thresholdTitle(String label);

  /// No description provided for @sensor_typeTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get sensor_typeTemperature;

  /// No description provided for @sensor_typeHumidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get sensor_typeHumidity;

  /// No description provided for @sensor_typePressure.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get sensor_typePressure;

  /// No description provided for @sensor_typeVoltage.
  ///
  /// In en, this message translates to:
  /// **'Voltage'**
  String get sensor_typeVoltage;

  /// No description provided for @sensor_typeCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get sensor_typeCurrent;

  /// No description provided for @sensor_typeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get sensor_typeLight;

  /// No description provided for @sensor_typeConcentration.
  ///
  /// In en, this message translates to:
  /// **'Concentration'**
  String get sensor_typeConcentration;

  /// No description provided for @sensor_typePercentage.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get sensor_typePercentage;

  /// No description provided for @sensor_typeAnalogInput.
  ///
  /// In en, this message translates to:
  /// **'Analog input'**
  String get sensor_typeAnalogInput;

  /// No description provided for @sensor_typeAltitude.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get sensor_typeAltitude;

  /// No description provided for @setupWizard_title.
  ///
  /// In en, this message translates to:
  /// **'Connect your radio'**
  String get setupWizard_title;

  /// No description provided for @setupWizard_choose.
  ///
  /// In en, this message translates to:
  /// **'1. Choose a connection'**
  String get setupWizard_choose;

  /// No description provided for @setupWizard_prepare.
  ///
  /// In en, this message translates to:
  /// **'2. Prepare your radio'**
  String get setupWizard_prepare;

  /// No description provided for @setupWizard_intro.
  ///
  /// In en, this message translates to:
  /// **'Choose how this phone or computer will connect to your radio. The radio carries messages over the mesh.'**
  String get setupWizard_intro;

  /// No description provided for @setupWizard_bluetooth.
  ///
  /// In en, this message translates to:
  /// **'Wireless connection to a nearby compatible radio.'**
  String get setupWizard_bluetooth;

  /// No description provided for @setupWizard_noBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth is unavailable in this browser. Use the native app or a supported USB connection.'**
  String get setupWizard_noBluetooth;

  /// No description provided for @setupWizard_usb.
  ///
  /// In en, this message translates to:
  /// **'A wired connection using a USB data cable.'**
  String get setupWizard_usb;

  /// No description provided for @setupWizard_noUsb.
  ///
  /// In en, this message translates to:
  /// **'USB serial is unavailable here. Use a supported desktop or Android app, or Chrome with Web Serial.'**
  String get setupWizard_noUsb;

  /// No description provided for @setupWizard_bluetoothSteps.
  ///
  /// In en, this message translates to:
  /// **'Power on your radio and keep it nearby. Enable Bluetooth and allow the app permission to use it. Close other apps connected to the radio, then open the device list and scan.'**
  String get setupWizard_bluetoothSteps;

  /// No description provided for @setupWizard_usbSteps.
  ///
  /// In en, this message translates to:
  /// **'Connect a powered radio with a USB data cable; a charge-only cable will not work. Close other serial apps. Open the USB device list, select your radio, and allow access if prompted.'**
  String get setupWizard_usbSteps;

  /// No description provided for @setupWizard_firmwareTitle.
  ///
  /// In en, this message translates to:
  /// **'Check compatibility before changing firmware'**
  String get setupWizard_firmwareTitle;

  /// No description provided for @setupWizard_firmware.
  ///
  /// In en, this message translates to:
  /// **'Your radio needs MeshCore companion firmware that supports the selected connection. Support varies by board and firmware build; a USB socket alone does not confirm USB serial support. Check the instructions for your exact board and installed build. Repeater or room-server firmware is not a companion. A failed connection does not by itself mean you need to reflash.'**
  String get setupWizard_firmware;

  /// No description provided for @setupWizard_settings.
  ///
  /// In en, this message translates to:
  /// **'This guide does not flash firmware or change radio settings. After connecting, use Settings for region, frequency, and advanced options. Confirm settings with your local mesh before changing them.'**
  String get setupWizard_settings;

  /// No description provided for @setupWizard_openBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Open Bluetooth devices'**
  String get setupWizard_openBluetooth;

  /// No description provided for @setupWizard_openUsb.
  ///
  /// In en, this message translates to:
  /// **'Open USB devices'**
  String get setupWizard_openUsb;

  /// No description provided for @setupWizard_change.
  ///
  /// In en, this message translates to:
  /// **'Change connection type'**
  String get setupWizard_change;

  /// No description provided for @setupWizard_later.
  ///
  /// In en, this message translates to:
  /// **'Set up later'**
  String get setupWizard_later;

  /// No description provided for @setupWizard_bluetoothError.
  ///
  /// In en, this message translates to:
  /// **'Could not connect to the radio. Keep it powered and nearby, check Bluetooth permissions, and close other connected apps. Then scan and try again.'**
  String get setupWizard_bluetoothError;

  /// No description provided for @setupWizard_scanError.
  ///
  /// In en, this message translates to:
  /// **'Could not scan for radios. Turn on Bluetooth and allow Bluetooth or Nearby devices access in system settings, then try scanning again.'**
  String get setupWizard_scanError;

  /// No description provided for @setupWizard_usbError.
  ///
  /// In en, this message translates to:
  /// **'Could not connect over USB. Check the data cable and selected device, allow USB access, and close other serial apps. Reconnect the cable and try again.'**
  String get setupWizard_usbError;

  /// No description provided for @connections_title.
  ///
  /// In en, this message translates to:
  /// **'Connections'**
  String get connections_title;

  /// No description provided for @connections_radioTitle.
  ///
  /// In en, this message translates to:
  /// **'Radio connection'**
  String get connections_radioTitle;

  /// No description provided for @connections_bluetoothOffNotice.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth is off. Turn it on to reconnect; the app will retry once it is back.'**
  String get connections_bluetoothOffNotice;

  /// No description provided for @connections_transport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get connections_transport;

  /// No description provided for @connections_lastError.
  ///
  /// In en, this message translates to:
  /// **'Last error: {error}'**
  String connections_lastError(String error);

  /// No description provided for @connections_disconnectRadio.
  ///
  /// In en, this message translates to:
  /// **'Disconnect radio'**
  String get connections_disconnectRadio;

  /// No description provided for @connections_reconnectTo.
  ///
  /// In en, this message translates to:
  /// **'Reconnect to {name}'**
  String connections_reconnectTo(String name);

  /// No description provided for @connections_forgetRadio.
  ///
  /// In en, this message translates to:
  /// **'Forget radio'**
  String get connections_forgetRadio;

  /// No description provided for @connections_connectAnother.
  ///
  /// In en, this message translates to:
  /// **'Connect another radio'**
  String get connections_connectAnother;

  /// No description provided for @connections_usbSerial.
  ///
  /// In en, this message translates to:
  /// **'USB serial'**
  String get connections_usbSerial;

  /// No description provided for @connections_tcpIp.
  ///
  /// In en, this message translates to:
  /// **'TCP/IP'**
  String get connections_tcpIp;

  /// No description provided for @connections_device.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get connections_device;

  /// No description provided for @connections_publicKey.
  ///
  /// In en, this message translates to:
  /// **'Public key'**
  String get connections_publicKey;

  /// No description provided for @connections_firmware.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get connections_firmware;

  /// No description provided for @connections_firmwareProtocol.
  ///
  /// In en, this message translates to:
  /// **'protocol v{code}'**
  String connections_firmwareProtocol(String code);

  /// No description provided for @connections_battery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get connections_battery;

  /// No description provided for @connections_lastRx.
  ///
  /// In en, this message translates to:
  /// **'Last RX'**
  String get connections_lastRx;

  /// No description provided for @connections_reconnectFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not reconnect to the radio'**
  String get connections_reconnectFailed;

  /// No description provided for @connections_statusBluetoothOff.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth is off'**
  String get connections_statusBluetoothOff;

  /// No description provided for @connections_statusConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connections_statusConnected;

  /// No description provided for @connections_statusConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting…'**
  String get connections_statusConnecting;

  /// No description provided for @connections_statusDisconnecting.
  ///
  /// In en, this message translates to:
  /// **'Disconnecting…'**
  String get connections_statusDisconnecting;

  /// No description provided for @connections_statusScanning.
  ///
  /// In en, this message translates to:
  /// **'Scanning for radios…'**
  String get connections_statusScanning;

  /// No description provided for @connections_statusReconnectingSoon.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting soon…'**
  String get connections_statusReconnectingSoon;

  /// No description provided for @connections_statusNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Not connected'**
  String get connections_statusNotConnected;

  /// No description provided for @mqtt_cardTitle.
  ///
  /// In en, this message translates to:
  /// **'MQTT connection'**
  String get mqtt_cardTitle;

  /// No description provided for @mqtt_statusNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Not configured'**
  String get mqtt_statusNotConfigured;

  /// No description provided for @mqtt_statusDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get mqtt_statusDisconnected;

  /// No description provided for @mqtt_statusConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting'**
  String get mqtt_statusConnecting;

  /// No description provided for @mqtt_statusConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get mqtt_statusConnected;

  /// No description provided for @mqtt_statusReconnecting.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting'**
  String get mqtt_statusReconnecting;

  /// No description provided for @mqtt_statusError.
  ///
  /// In en, this message translates to:
  /// **'Connection error'**
  String get mqtt_statusError;

  /// No description provided for @mqtt_broker.
  ///
  /// In en, this message translates to:
  /// **'Broker: {host}:{port} ({transport})'**
  String mqtt_broker(String host, int port, String transport);

  /// No description provided for @mqtt_tokenSignIn.
  ///
  /// In en, this message translates to:
  /// **'Signs in with a radio-signed token'**
  String get mqtt_tokenSignIn;

  /// No description provided for @mqtt_tokenSignInAs.
  ///
  /// In en, this message translates to:
  /// **'Signs in with a radio-signed token as {username}…'**
  String mqtt_tokenSignInAs(String username);

  /// No description provided for @mqtt_connectRadioToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Connect your radio to sign in'**
  String get mqtt_connectRadioToSignIn;

  /// No description provided for @mqtt_tokenRenewsAt.
  ///
  /// In en, this message translates to:
  /// **'Token renews at {time}'**
  String mqtt_tokenRenewsAt(String time);

  /// No description provided for @mqtt_signedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {username}'**
  String mqtt_signedInAs(String username);

  /// No description provided for @mqtt_listeningOn.
  ///
  /// In en, this message translates to:
  /// **'Listening on {topic}'**
  String mqtt_listeningOn(String topic);

  /// No description provided for @mqtt_packetCounts.
  ///
  /// In en, this message translates to:
  /// **'Packets: {accepted} new, {duplicate} duplicate, {invalid} invalid'**
  String mqtt_packetCounts(int accepted, int duplicate, int invalid);

  /// No description provided for @mqtt_retryCount.
  ///
  /// In en, this message translates to:
  /// **'Retry {attempt} of {max}'**
  String mqtt_retryCount(int attempt, int max);

  /// No description provided for @mqtt_sharingWaitsForRadio.
  ///
  /// In en, this message translates to:
  /// **'Sharing waits for a radio connection'**
  String get mqtt_sharingWaitsForRadio;

  /// No description provided for @mqtt_sharingOn.
  ///
  /// In en, this message translates to:
  /// **'Sharing on {topic}'**
  String mqtt_sharingOn(String topic);

  /// No description provided for @mqtt_willShareOn.
  ///
  /// In en, this message translates to:
  /// **'Will share on {topic}'**
  String mqtt_willShareOn(String topic);

  /// No description provided for @mqtt_onlineStatusOn.
  ///
  /// In en, this message translates to:
  /// **'Online status on {topic}'**
  String mqtt_onlineStatusOn(String topic);

  /// No description provided for @mqtt_sharedCounts.
  ///
  /// In en, this message translates to:
  /// **'Shared {shared}, held back {held}'**
  String mqtt_sharedCounts(int shared, int held);

  /// No description provided for @mqtt_addBrokerHint.
  ///
  /// In en, this message translates to:
  /// **'Add a broker to bridge MeshCore traffic over the internet. Radio connection works independently.'**
  String get mqtt_addBrokerHint;

  /// No description provided for @mqtt_disconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect MQTT'**
  String get mqtt_disconnect;

  /// No description provided for @mqtt_connect.
  ///
  /// In en, this message translates to:
  /// **'Connect MQTT'**
  String get mqtt_connect;

  /// No description provided for @mqtt_packetFeed.
  ///
  /// In en, this message translates to:
  /// **'Packet feed'**
  String get mqtt_packetFeed;

  /// No description provided for @mqtt_setUpBroker.
  ///
  /// In en, this message translates to:
  /// **'Set up broker'**
  String get mqtt_setUpBroker;

  /// No description provided for @mqtt_brokerSettings.
  ///
  /// In en, this message translates to:
  /// **'Broker settings'**
  String get mqtt_brokerSettings;

  /// No description provided for @mqtt_settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'MQTT broker settings'**
  String get mqtt_settingsTitle;

  /// No description provided for @mqtt_presetLabel.
  ///
  /// In en, this message translates to:
  /// **'Start from a preset'**
  String get mqtt_presetLabel;

  /// No description provided for @mqtt_presetCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom broker'**
  String get mqtt_presetCustom;

  /// No description provided for @mqtt_presetLocal.
  ///
  /// In en, this message translates to:
  /// **'Local broker (configure address)'**
  String get mqtt_presetLocal;

  /// No description provided for @mqtt_presetLetsMeshUs.
  ///
  /// In en, this message translates to:
  /// **'LetsMesh analyzer (US, community)'**
  String get mqtt_presetLetsMeshUs;

  /// No description provided for @mqtt_presetLetsMeshEu.
  ///
  /// In en, this message translates to:
  /// **'LetsMesh analyzer (EU, community)'**
  String get mqtt_presetLetsMeshEu;

  /// No description provided for @mqtt_presetLetsMeshNote.
  ///
  /// In en, this message translates to:
  /// **'LetsMesh is a community-run MeshCore packet analyzer, not part of NOTORYX and not endorsed by it. Sharing needs your radio connected and stays off until you turn it on.'**
  String get mqtt_presetLetsMeshNote;

  /// No description provided for @mqtt_hostname.
  ///
  /// In en, this message translates to:
  /// **'Broker hostname'**
  String get mqtt_hostname;

  /// No description provided for @mqtt_port.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get mqtt_port;

  /// No description provided for @mqtt_useTls.
  ///
  /// In en, this message translates to:
  /// **'Use TLS'**
  String get mqtt_useTls;

  /// No description provided for @mqtt_allowCleartext.
  ///
  /// In en, this message translates to:
  /// **'Allow cleartext to a local broker'**
  String get mqtt_allowCleartext;

  /// No description provided for @mqtt_allowCleartextHint.
  ///
  /// In en, this message translates to:
  /// **'Only localhost, .local and private 10.x / 192.168.x hosts.'**
  String get mqtt_allowCleartextHint;

  /// No description provided for @mqtt_useWebSocket.
  ///
  /// In en, this message translates to:
  /// **'Use WebSocket'**
  String get mqtt_useWebSocket;

  /// No description provided for @mqtt_webSocketPath.
  ///
  /// In en, this message translates to:
  /// **'WebSocket path'**
  String get mqtt_webSocketPath;

  /// No description provided for @mqtt_topicPrefix.
  ///
  /// In en, this message translates to:
  /// **'Topic prefix'**
  String get mqtt_topicPrefix;

  /// No description provided for @mqtt_region.
  ///
  /// In en, this message translates to:
  /// **'Region (optional)'**
  String get mqtt_region;

  /// No description provided for @mqtt_regionHelp.
  ///
  /// In en, this message translates to:
  /// **'Observer region code such as PHL. Leave blank for all.'**
  String get mqtt_regionHelp;

  /// No description provided for @mqtt_deliverChannel.
  ///
  /// In en, this message translates to:
  /// **'Add channel messages heard via MQTT'**
  String get mqtt_deliverChannel;

  /// No description provided for @mqtt_deliverChannelHint.
  ///
  /// In en, this message translates to:
  /// **'Messages on your channels that observers heard show up in your chats. They are not sent over your radio.'**
  String get mqtt_deliverChannelHint;

  /// No description provided for @mqtt_sharingTitle.
  ///
  /// In en, this message translates to:
  /// **'Sharing as an observer'**
  String get mqtt_sharingTitle;

  /// No description provided for @mqtt_share.
  ///
  /// In en, this message translates to:
  /// **'Share packets my radio hears'**
  String get mqtt_share;

  /// No description provided for @mqtt_shareHint.
  ///
  /// In en, this message translates to:
  /// **'Publishes adverts and channel traffic your radio receives, with its public key, signal strength and region. Channel messages stay encrypted. Needs a region.'**
  String get mqtt_shareHint;

  /// No description provided for @mqtt_shareDirect.
  ///
  /// In en, this message translates to:
  /// **'Include direct-message traffic'**
  String get mqtt_shareDirect;

  /// No description provided for @mqtt_shareDirectHint.
  ///
  /// In en, this message translates to:
  /// **'Requests, replies and direct messages. Contents stay encrypted, but this shows which nodes talk to each other.'**
  String get mqtt_shareDirectHint;

  /// No description provided for @mqtt_shareOwn.
  ///
  /// In en, this message translates to:
  /// **'Include my own messages and adverts'**
  String get mqtt_shareOwn;

  /// No description provided for @mqtt_signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign-in'**
  String get mqtt_signInTitle;

  /// No description provided for @mqtt_authPassword.
  ///
  /// In en, this message translates to:
  /// **'Username and password'**
  String get mqtt_authPassword;

  /// No description provided for @mqtt_authToken.
  ///
  /// In en, this message translates to:
  /// **'Radio-signed token'**
  String get mqtt_authToken;

  /// No description provided for @mqtt_tokenExplain.
  ///
  /// In en, this message translates to:
  /// **'Your radio signs a one-hour sign-in token with its own key, and the app renews it before it runs out. The key never leaves the radio. The username is v1_ and your radio\'s public key.'**
  String get mqtt_tokenExplain;

  /// No description provided for @mqtt_radioReady.
  ///
  /// In en, this message translates to:
  /// **'Radio connected: ready to sign in.'**
  String get mqtt_radioReady;

  /// No description provided for @mqtt_radioNeeded.
  ///
  /// In en, this message translates to:
  /// **'Connect your radio to sign in. MQTT waits for it.'**
  String get mqtt_radioNeeded;

  /// No description provided for @mqtt_username.
  ///
  /// In en, this message translates to:
  /// **'Username (optional)'**
  String get mqtt_username;

  /// No description provided for @mqtt_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get mqtt_password;

  /// No description provided for @mqtt_keepPassword.
  ///
  /// In en, this message translates to:
  /// **'Leave blank to keep the saved password.'**
  String get mqtt_keepPassword;

  /// No description provided for @mqtt_credentialsWeb.
  ///
  /// In en, this message translates to:
  /// **'In the browser, credentials are kept only until the page is closed.'**
  String get mqtt_credentialsWeb;

  /// No description provided for @mqtt_credentialsKeychain.
  ///
  /// In en, this message translates to:
  /// **'Credentials are stored in the system keychain, never in app settings or logs.'**
  String get mqtt_credentialsKeychain;

  /// No description provided for @mqtt_saveSettings.
  ///
  /// In en, this message translates to:
  /// **'Save settings'**
  String get mqtt_saveSettings;

  /// No description provided for @mqtt_feedTitle.
  ///
  /// In en, this message translates to:
  /// **'MQTT packet feed'**
  String get mqtt_feedTitle;

  /// No description provided for @mqtt_feedConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect to a broker to see packets from observers.'**
  String get mqtt_feedConnect;

  /// No description provided for @mqtt_feedWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting for packets on {topic}'**
  String mqtt_feedWaiting(String topic);

  /// No description provided for @mqtt_feedUnknownObserver.
  ///
  /// In en, this message translates to:
  /// **'Unknown observer'**
  String get mqtt_feedUnknownObserver;

  /// No description provided for @mqtt_feedHeardBy.
  ///
  /// In en, this message translates to:
  /// **'Heard by {observer}'**
  String mqtt_feedHeardBy(String observer);

  /// No description provided for @mqtt_feedHopsBytes.
  ///
  /// In en, this message translates to:
  /// **'{hops} hops · {bytes} bytes'**
  String mqtt_feedHopsBytes(int hops, int bytes);

  /// No description provided for @mqtt_packetRequest.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get mqtt_packetRequest;

  /// No description provided for @mqtt_packetResponse.
  ///
  /// In en, this message translates to:
  /// **'Response'**
  String get mqtt_packetResponse;

  /// No description provided for @mqtt_packetDirectMessage.
  ///
  /// In en, this message translates to:
  /// **'Direct message'**
  String get mqtt_packetDirectMessage;

  /// No description provided for @mqtt_packetAck.
  ///
  /// In en, this message translates to:
  /// **'Ack'**
  String get mqtt_packetAck;

  /// No description provided for @mqtt_packetAdvert.
  ///
  /// In en, this message translates to:
  /// **'Advert'**
  String get mqtt_packetAdvert;

  /// No description provided for @mqtt_packetChannelMessage.
  ///
  /// In en, this message translates to:
  /// **'Channel message'**
  String get mqtt_packetChannelMessage;

  /// No description provided for @mqtt_packetChannelData.
  ///
  /// In en, this message translates to:
  /// **'Channel data'**
  String get mqtt_packetChannelData;

  /// No description provided for @mqtt_packetAnonymousRequest.
  ///
  /// In en, this message translates to:
  /// **'Anonymous request'**
  String get mqtt_packetAnonymousRequest;

  /// No description provided for @mqtt_packetPath.
  ///
  /// In en, this message translates to:
  /// **'Path'**
  String get mqtt_packetPath;

  /// No description provided for @mqtt_packetTrace.
  ///
  /// In en, this message translates to:
  /// **'Trace'**
  String get mqtt_packetTrace;

  /// No description provided for @mqtt_packetMultipart.
  ///
  /// In en, this message translates to:
  /// **'Multipart'**
  String get mqtt_packetMultipart;

  /// No description provided for @mqtt_packetControl.
  ///
  /// In en, this message translates to:
  /// **'Control'**
  String get mqtt_packetControl;

  /// No description provided for @mqtt_packetType.
  ///
  /// In en, this message translates to:
  /// **'Type {type}'**
  String mqtt_packetType(int type);

  /// No description provided for @mqtt_routeTransportFlood.
  ///
  /// In en, this message translates to:
  /// **'Transport flood'**
  String get mqtt_routeTransportFlood;

  /// No description provided for @mqtt_routeFlood.
  ///
  /// In en, this message translates to:
  /// **'Flood'**
  String get mqtt_routeFlood;

  /// No description provided for @mqtt_routeDirect.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get mqtt_routeDirect;

  /// No description provided for @mqtt_routeTransportDirect.
  ///
  /// In en, this message translates to:
  /// **'Transport direct'**
  String get mqtt_routeTransportDirect;

  /// No description provided for @mqtt_noticeInvalidHost.
  ///
  /// In en, this message translates to:
  /// **'Enter a hostname or IPv4 address without a scheme or port.'**
  String get mqtt_noticeInvalidHost;

  /// No description provided for @mqtt_noticeInvalidPort.
  ///
  /// In en, this message translates to:
  /// **'Port must be between 1 and 65535.'**
  String get mqtt_noticeInvalidPort;

  /// No description provided for @mqtt_noticeInvalidWebSocketPath.
  ///
  /// In en, this message translates to:
  /// **'WebSocket path must begin with / and contain no query or fragment.'**
  String get mqtt_noticeInvalidWebSocketPath;

  /// No description provided for @mqtt_noticeInvalidTopicPrefix.
  ///
  /// In en, this message translates to:
  /// **'Topic prefix must be a nonempty MQTT path without wildcards.'**
  String get mqtt_noticeInvalidTopicPrefix;

  /// No description provided for @mqtt_noticeInvalidRegion.
  ///
  /// In en, this message translates to:
  /// **'Region must be 2-8 letters or digits, such as PHL.'**
  String get mqtt_noticeInvalidRegion;

  /// No description provided for @mqtt_noticeTlsRequired.
  ///
  /// In en, this message translates to:
  /// **'TLS is required unless insecure local broker access is explicitly enabled.'**
  String get mqtt_noticeTlsRequired;

  /// No description provided for @mqtt_noticeCleartextLocalOnly.
  ///
  /// In en, this message translates to:
  /// **'Cleartext MQTT is restricted to explicitly approved local hosts.'**
  String get mqtt_noticeCleartextLocalOnly;

  /// No description provided for @mqtt_noticeRegionNeededToShare.
  ///
  /// In en, this message translates to:
  /// **'Set a region to share packets as an observer.'**
  String get mqtt_noticeRegionNeededToShare;

  /// No description provided for @mqtt_noticePasswordNeeded.
  ///
  /// In en, this message translates to:
  /// **'Enter the password for {username}.'**
  String mqtt_noticePasswordNeeded(String username);

  /// No description provided for @mqtt_noticeNoNetwork.
  ///
  /// In en, this message translates to:
  /// **'No network connection. MQTT reconnects when it is back.'**
  String get mqtt_noticeNoNetwork;

  /// No description provided for @mqtt_noticeSubscriptionRefused.
  ///
  /// In en, this message translates to:
  /// **'The broker refused the packet subscription.'**
  String get mqtt_noticeSubscriptionRefused;

  /// No description provided for @mqtt_noticeBadCredentials.
  ///
  /// In en, this message translates to:
  /// **'The broker rejected the username or password.'**
  String get mqtt_noticeBadCredentials;

  /// No description provided for @mqtt_noticeNotAuthorized.
  ///
  /// In en, this message translates to:
  /// **'This account is not authorized on the broker.'**
  String get mqtt_noticeNotAuthorized;

  /// No description provided for @mqtt_noticeConnectionRefused.
  ///
  /// In en, this message translates to:
  /// **'The broker refused the connection.'**
  String get mqtt_noticeConnectionRefused;

  /// No description provided for @mqtt_noticeUnreachable.
  ///
  /// In en, this message translates to:
  /// **'The broker could not be reached.'**
  String get mqtt_noticeUnreachable;

  /// No description provided for @mqtt_noticeTlsFailed.
  ///
  /// In en, this message translates to:
  /// **'The secure (TLS) connection could not be established.'**
  String get mqtt_noticeTlsFailed;

  /// No description provided for @mqtt_noticeWebSocketOnly.
  ///
  /// In en, this message translates to:
  /// **'This platform only supports MQTT over WebSocket.'**
  String get mqtt_noticeWebSocketOnly;

  /// No description provided for @mqtt_noticeRadioNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Connect your radio to sign in with its key.'**
  String get mqtt_noticeRadioNotConnected;

  /// No description provided for @mqtt_noticeSigningUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This radio\'s firmware does not support signing with its key.'**
  String get mqtt_noticeSigningUnsupported;

  /// No description provided for @mqtt_noticeSigningTimeout.
  ///
  /// In en, this message translates to:
  /// **'The radio did not answer the signing request. Its firmware may not support signing.'**
  String get mqtt_noticeSigningTimeout;

  /// No description provided for @mqtt_noticeSigningTooLong.
  ///
  /// In en, this message translates to:
  /// **'The data is too long for the radio to sign.'**
  String get mqtt_noticeSigningTooLong;

  /// No description provided for @mqtt_noticeSigningRejected.
  ///
  /// In en, this message translates to:
  /// **'The radio refused to sign the data.'**
  String get mqtt_noticeSigningRejected;

  /// No description provided for @scanner_signalStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get scanner_signalStrong;

  /// No description provided for @scanner_signalGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get scanner_signalGood;

  /// No description provided for @scanner_signalFair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get scanner_signalFair;

  /// No description provided for @scanner_signalWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get scanner_signalWeak;

  /// No description provided for @scanner_nearbyRadios.
  ///
  /// In en, this message translates to:
  /// **'Nearby radios'**
  String get scanner_nearbyRadios;

  /// No description provided for @scanner_lastRadio.
  ///
  /// In en, this message translates to:
  /// **'Last radio'**
  String get scanner_lastRadio;

  /// No description provided for @scanner_reconnect.
  ///
  /// In en, this message translates to:
  /// **'Reconnect'**
  String get scanner_reconnect;

  /// No description provided for @scanner_tcpHint.
  ///
  /// In en, this message translates to:
  /// **'A radio with Wi‑Fi firmware on your network.'**
  String get scanner_tcpHint;

  /// No description provided for @scanner_otherWays.
  ///
  /// In en, this message translates to:
  /// **'Other ways to connect'**
  String get scanner_otherWays;

  /// No description provided for @scanner_radiosFound.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 radio nearby} other{{count} radios nearby}}'**
  String scanner_radiosFound(int count);

  /// No description provided for @scanner_searchingTitle.
  ///
  /// In en, this message translates to:
  /// **'Looking for radios…'**
  String get scanner_searchingTitle;

  /// No description provided for @scanner_findTitle.
  ///
  /// In en, this message translates to:
  /// **'Find your radio'**
  String get scanner_findTitle;

  /// No description provided for @scanner_heroHint.
  ///
  /// In en, this message translates to:
  /// **'Turn your radio on and keep it within a few meters. It needs MeshCore companion firmware.'**
  String get scanner_heroHint;

  /// No description provided for @scanner_tipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Can\'t see your radio?'**
  String get scanner_tipsTitle;

  /// No description provided for @scanner_tipPower.
  ///
  /// In en, this message translates to:
  /// **'Check that it\'s switched on and awake.'**
  String get scanner_tipPower;

  /// No description provided for @scanner_tipFirmware.
  ///
  /// In en, this message translates to:
  /// **'It needs MeshCore companion firmware. Repeaters and room servers don\'t show up here.'**
  String get scanner_tipFirmware;

  /// No description provided for @scanner_tipOtherDevice.
  ///
  /// In en, this message translates to:
  /// **'A radio connects to one device at a time. Disconnect it from other phones or computers.'**
  String get scanner_tipOtherDevice;

  /// No description provided for @connections_internetBridge.
  ///
  /// In en, this message translates to:
  /// **'Internet bridge'**
  String get connections_internetBridge;

  /// No description provided for @connections_noRadio.
  ///
  /// In en, this message translates to:
  /// **'No radio'**
  String get connections_noRadio;

  /// No description provided for @connections_radioSettings.
  ///
  /// In en, this message translates to:
  /// **'Radio settings'**
  String get connections_radioSettings;

  /// No description provided for @connections_viewDashboard.
  ///
  /// In en, this message translates to:
  /// **'View connection dashboard'**
  String get connections_viewDashboard;

  /// No description provided for @channelDirectory_title.
  ///
  /// In en, this message translates to:
  /// **'Channel directory'**
  String get channelDirectory_title;

  /// No description provided for @channelDirectory_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Find public hashtag channels near you'**
  String get channelDirectory_subtitle;

  /// No description provided for @channelDirectory_search.
  ///
  /// In en, this message translates to:
  /// **'Search channels or places'**
  String get channelDirectory_search;

  /// No description provided for @channelDirectory_nearYou.
  ///
  /// In en, this message translates to:
  /// **'Near you'**
  String get channelDirectory_nearYou;

  /// No description provided for @channelDirectory_all.
  ///
  /// In en, this message translates to:
  /// **'All channels'**
  String get channelDirectory_all;

  /// No description provided for @channelDirectory_catAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get channelDirectory_catAll;

  /// No description provided for @channelDirectory_catEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get channelDirectory_catEmergency;

  /// No description provided for @channelDirectory_catLocal.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get channelDirectory_catLocal;

  /// No description provided for @channelDirectory_catGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get channelDirectory_catGeneral;

  /// No description provided for @channelDirectory_catInterest.
  ///
  /// In en, this message translates to:
  /// **'Interests'**
  String get channelDirectory_catInterest;

  /// No description provided for @channelDirectory_catTest.
  ///
  /// In en, this message translates to:
  /// **'Testing'**
  String get channelDirectory_catTest;

  /// No description provided for @channelDirectory_join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get channelDirectory_join;

  /// No description provided for @channelDirectory_joined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get channelDirectory_joined;

  /// No description provided for @channelDirectory_noMatches.
  ///
  /// In en, this message translates to:
  /// **'No channels match your search.'**
  String get channelDirectory_noMatches;

  /// No description provided for @channelDirectory_connectFirst.
  ///
  /// In en, this message translates to:
  /// **'Connect your radio to join channels.'**
  String get channelDirectory_connectFirst;

  /// No description provided for @channelDirectory_slotsFull.
  ///
  /// In en, this message translates to:
  /// **'All channel slots on your radio are in use. Remove a channel first.'**
  String get channelDirectory_slotsFull;

  /// No description provided for @channelDirectory_joinFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not add the channel. Try again.'**
  String get channelDirectory_joinFailed;

  /// No description provided for @channelDirectory_addHint.
  ///
  /// In en, this message translates to:
  /// **'Missing a channel? Anyone can suggest one by editing the shared list on GitHub.'**
  String get channelDirectory_addHint;

  /// No description provided for @prefixTool_title.
  ///
  /// In en, this message translates to:
  /// **'Repeater IDs'**
  String get prefixTool_title;

  /// No description provided for @prefixTool_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Who uses an ID, which IDs clash, and free ones for a new repeater'**
  String get prefixTool_subtitle;

  /// No description provided for @prefixTool_width.
  ///
  /// In en, this message translates to:
  /// **'Path ID size'**
  String get prefixTool_width;

  /// No description provided for @prefixTool_widthBytes.
  ///
  /// In en, this message translates to:
  /// **'{bytes}-byte'**
  String prefixTool_widthBytes(int bytes);

  /// No description provided for @prefixTool_includeCompanions.
  ///
  /// In en, this message translates to:
  /// **'Include companions and sensors'**
  String get prefixTool_includeCompanions;

  /// No description provided for @prefixTool_summary.
  ///
  /// In en, this message translates to:
  /// **'{nodes} nodes known · {used} IDs in use · {shared} shared'**
  String prefixTool_summary(int nodes, int used, int shared);

  /// No description provided for @prefixTool_freeOfSpace.
  ///
  /// In en, this message translates to:
  /// **'{free} of {space} IDs free'**
  String prefixTool_freeOfSpace(int free, int space);

  /// No description provided for @prefixTool_lookupHint.
  ///
  /// In en, this message translates to:
  /// **'Look up an ID, e.g. 3D'**
  String get prefixTool_lookupHint;

  /// No description provided for @prefixTool_lookupFree.
  ///
  /// In en, this message translates to:
  /// **'No known node uses {id}.'**
  String prefixTool_lookupFree(String id);

  /// No description provided for @prefixTool_lookupUsed.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 node uses {id}} other{{count} nodes use {id}}}'**
  String prefixTool_lookupUsed(int count, String id);

  /// No description provided for @prefixTool_shared.
  ///
  /// In en, this message translates to:
  /// **'Shared IDs'**
  String get prefixTool_shared;

  /// No description provided for @prefixTool_sharedHint.
  ///
  /// In en, this message translates to:
  /// **'Paths through these IDs look the same unless the mesh uses longer IDs.'**
  String get prefixTool_sharedHint;

  /// No description provided for @prefixTool_noShared.
  ///
  /// In en, this message translates to:
  /// **'No shared IDs among the nodes you know.'**
  String get prefixTool_noShared;

  /// No description provided for @prefixTool_free.
  ///
  /// In en, this message translates to:
  /// **'Free IDs'**
  String get prefixTool_free;

  /// No description provided for @prefixTool_shuffle.
  ///
  /// In en, this message translates to:
  /// **'More suggestions'**
  String get prefixTool_shuffle;

  /// No description provided for @prefixTool_makeKey.
  ///
  /// In en, this message translates to:
  /// **'Make a key'**
  String get prefixTool_makeKey;

  /// No description provided for @prefixTool_onlyKnown.
  ///
  /// In en, this message translates to:
  /// **'Based only on nodes your radio has heard. A free ID here may still belong to a repeater you haven\'t heard.'**
  String get prefixTool_onlyKnown;

  /// No description provided for @prefixTool_inUseWarning.
  ///
  /// In en, this message translates to:
  /// **'{id} is already used by {name}.'**
  String prefixTool_inUseWarning(String id, String name);

  /// No description provided for @prefixTool_pickFree.
  ///
  /// In en, this message translates to:
  /// **'Pick a free ID'**
  String get prefixTool_pickFree;

  /// No description provided for @keyGen_title.
  ///
  /// In en, this message translates to:
  /// **'Key for ID {id}'**
  String keyGen_title(String id);

  /// No description provided for @keyGen_searching.
  ///
  /// In en, this message translates to:
  /// **'Searching… {tries} keys tried'**
  String keyGen_searching(int tries);

  /// No description provided for @keyGen_publicKey.
  ///
  /// In en, this message translates to:
  /// **'Public key'**
  String get keyGen_publicKey;

  /// No description provided for @keyGen_privateKey.
  ///
  /// In en, this message translates to:
  /// **'Private key'**
  String get keyGen_privateKey;

  /// No description provided for @keyGen_copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get keyGen_copy;

  /// No description provided for @keyGen_copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get keyGen_copied;

  /// No description provided for @keyGen_secretWarning.
  ///
  /// In en, this message translates to:
  /// **'Keep the private key secret. Anyone who has it can pose as this node.'**
  String get keyGen_secretWarning;

  /// No description provided for @keyGen_howToUse.
  ///
  /// In en, this message translates to:
  /// **'To use it on a repeater, open the repeater\'s settings, paste it as the private key and save. Companion radios need firmware that allows key import.'**
  String get keyGen_howToUse;

  /// No description provided for @keyGen_tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Make another'**
  String get keyGen_tryAgain;

  /// No description provided for @regionSetup_title.
  ///
  /// In en, this message translates to:
  /// **'Region setup'**
  String get regionSetup_title;

  /// No description provided for @regionSetup_hubSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Place this repeater in your area\'s region tree'**
  String get regionSetup_hubSubtitle;

  /// No description provided for @regionSetup_intro.
  ///
  /// In en, this message translates to:
  /// **'Regions keep a message within an area instead of flooding the whole mesh. A repeater only forwards a region\'s messages if it carries that region, so give it its own region and every region above it.'**
  String get regionSetup_intro;

  /// No description provided for @regionSetup_where.
  ///
  /// In en, this message translates to:
  /// **'Where is the repeater?'**
  String get regionSetup_where;

  /// No description provided for @regionSetup_tree.
  ///
  /// In en, this message translates to:
  /// **'Region tree'**
  String get regionSetup_tree;

  /// No description provided for @regionSetup_custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get regionSetup_custom;

  /// No description provided for @regionSetup_region.
  ///
  /// In en, this message translates to:
  /// **'Most local region'**
  String get regionSetup_region;

  /// No description provided for @regionSetup_customLabel.
  ///
  /// In en, this message translates to:
  /// **'Regions, broadest first'**
  String get regionSetup_customLabel;

  /// No description provided for @regionSetup_invalidName.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" isn\'t a valid region name. Use lowercase letters, digits and hyphens, up to 29 characters.'**
  String regionSetup_invalidName(String name);

  /// No description provided for @regionSetup_tooMany.
  ///
  /// In en, this message translates to:
  /// **'A repeater can carry at most {max} regions.'**
  String regionSetup_tooMany(int max);

  /// No description provided for @regionSetup_options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get regionSetup_options;

  /// No description provided for @regionSetup_setDefault.
  ///
  /// In en, this message translates to:
  /// **'Make the most local region the default'**
  String get regionSetup_setDefault;

  /// No description provided for @regionSetup_setDefaultBody.
  ///
  /// In en, this message translates to:
  /// **'The repeater\'s own adverts stay in that region.'**
  String get regionSetup_setDefaultBody;

  /// No description provided for @regionSetup_legacy.
  ///
  /// In en, this message translates to:
  /// **'Firmware 1.14'**
  String get regionSetup_legacy;

  /// No description provided for @regionSetup_legacyBody.
  ///
  /// In en, this message translates to:
  /// **'Adds region allowf after each region. Not needed on 1.15 or newer.'**
  String get regionSetup_legacyBody;

  /// No description provided for @regionSetup_denyUnscoped.
  ///
  /// In en, this message translates to:
  /// **'Stop forwarding messages without a region'**
  String get regionSetup_denyUnscoped;

  /// No description provided for @regionSetup_denyUnscopedBody.
  ///
  /// In en, this message translates to:
  /// **'Only turn this on once your whole area uses regions, or messages from older apps won\'t get through.'**
  String get regionSetup_denyUnscopedBody;

  /// No description provided for @regionSetup_commands.
  ///
  /// In en, this message translates to:
  /// **'Commands'**
  String get regionSetup_commands;

  /// No description provided for @regionSetup_copyAll.
  ///
  /// In en, this message translates to:
  /// **'Copy all'**
  String get regionSetup_copyAll;

  /// No description provided for @regionSetup_copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get regionSetup_copied;

  /// No description provided for @regionSetup_pickFirst.
  ///
  /// In en, this message translates to:
  /// **'Pick a region to see the commands.'**
  String get regionSetup_pickFirst;

  /// No description provided for @regionSetup_sendTo.
  ///
  /// In en, this message translates to:
  /// **'Send to {name}'**
  String regionSetup_sendTo(String name);

  /// No description provided for @regionSetup_howToSend.
  ///
  /// In en, this message translates to:
  /// **'To send these, log in to the repeater and open Region setup from its menu, or paste them into its command line.'**
  String get regionSetup_howToSend;

  /// No description provided for @regionSetup_noReply.
  ///
  /// In en, this message translates to:
  /// **'No reply. Stopped here.'**
  String get regionSetup_noReply;

  /// No description provided for @regionSetup_addToMine.
  ///
  /// In en, this message translates to:
  /// **'Add these regions to my list'**
  String get regionSetup_addToMine;

  /// No description provided for @regionSetup_addedToMine.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 region added to your list} other{{count} regions added to your list}}'**
  String regionSetup_addedToMine(int count);

  /// No description provided for @trackLog_title.
  ///
  /// In en, this message translates to:
  /// **'Track log'**
  String get trackLog_title;

  /// No description provided for @trackLog_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Record a breadcrumb trail from your radio\'s GPS'**
  String get trackLog_subtitle;

  /// No description provided for @trackLog_recording.
  ///
  /// In en, this message translates to:
  /// **'Recording'**
  String get trackLog_recording;

  /// No description provided for @trackLog_notRecording.
  ///
  /// In en, this message translates to:
  /// **'Not recording'**
  String get trackLog_notRecording;

  /// No description provided for @trackLog_noGps.
  ///
  /// In en, this message translates to:
  /// **'Your radio isn\'t reporting a GPS position. The track log needs a radio with GPS turned on.'**
  String get trackLog_noGps;

  /// No description provided for @trackLog_start.
  ///
  /// In en, this message translates to:
  /// **'Start recording'**
  String get trackLog_start;

  /// No description provided for @trackLog_stop.
  ///
  /// In en, this message translates to:
  /// **'Stop recording'**
  String get trackLog_stop;

  /// No description provided for @trackLog_howItWorks.
  ///
  /// In en, this message translates to:
  /// **'Uses the position your radio reports, about once a minute, while NOTORYX Core is open. A point is added after you move 25 m, or every 15 minutes when you stay put.'**
  String get trackLog_howItWorks;

  /// No description provided for @trackLog_snap.
  ///
  /// In en, this message translates to:
  /// **'Round positions to about 100 m'**
  String get trackLog_snap;

  /// No description provided for @trackLog_snapBody.
  ///
  /// In en, this message translates to:
  /// **'For privacy when you share a track.'**
  String get trackLog_snapBody;

  /// No description provided for @trackLog_saved.
  ///
  /// In en, this message translates to:
  /// **'Saved tracks'**
  String get trackLog_saved;

  /// No description provided for @trackLog_none.
  ///
  /// In en, this message translates to:
  /// **'No tracks yet.'**
  String get trackLog_none;

  /// No description provided for @trackLog_export.
  ///
  /// In en, this message translates to:
  /// **'Export as GPX'**
  String get trackLog_export;

  /// No description provided for @trackLog_exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not export the track.'**
  String get trackLog_exportFailed;

  /// No description provided for @trackLog_deleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this track?'**
  String get trackLog_deleteTitle;

  /// No description provided for @trackLog_deleteBody.
  ///
  /// In en, this message translates to:
  /// **'It\'s removed from this device. Exported GPX files aren\'t affected.'**
  String get trackLog_deleteBody;

  /// No description provided for @trackLog_stats.
  ///
  /// In en, this message translates to:
  /// **'{km} km · {duration} · {points} points'**
  String trackLog_stats(String km, String duration, int points);

  /// No description provided for @trackLog_gpxName.
  ///
  /// In en, this message translates to:
  /// **'NOTORYX track {when}'**
  String trackLog_gpxName(String when);

  /// No description provided for @routes_nearbyTitle.
  ///
  /// In en, this message translates to:
  /// **'Best repeaters near you'**
  String get routes_nearbyTitle;

  /// No description provided for @routes_nearbyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No repeaters heard yet'**
  String get routes_nearbyEmptyTitle;

  /// No description provided for @routes_nearbyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Repeaters your radio hears directly show up here, strongest first, as it receives traffic. The list covers the last hour.'**
  String get routes_nearbyEmpty;

  /// No description provided for @routes_unknownRepeater.
  ///
  /// In en, this message translates to:
  /// **'Unknown repeater'**
  String get routes_unknownRepeater;

  /// No description provided for @routes_nearbyDetail.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{heard once} other{heard {count} times}} · {ago}'**
  String routes_nearbyDetail(int count, String ago);

  /// No description provided for @routes_minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, =0{just now} =1{1 min ago} other{{minutes} min ago}}'**
  String routes_minutesAgo(int minutes);

  /// No description provided for @routes_via.
  ///
  /// In en, this message translates to:
  /// **'via {names}'**
  String routes_via(String names);

  /// Bottom bar tab: home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// Bottom bar tab: chats and channels
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get nav_chats;

  /// Bottom bar tab: field tools
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get nav_tools;

  /// Bottom bar tab: settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get nav_settings;

  /// Bottom bar tab: tools and settings
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get nav_more;

  /// No description provided for @tools_groupApp.
  ///
  /// In en, this message translates to:
  /// **'App & settings'**
  String get tools_groupApp;

  /// No description provided for @tools_groupField.
  ///
  /// In en, this message translates to:
  /// **'In the field'**
  String get tools_groupField;

  /// No description provided for @tools_groupMaps.
  ///
  /// In en, this message translates to:
  /// **'Maps & coverage'**
  String get tools_groupMaps;

  /// No description provided for @tools_groupRouting.
  ///
  /// In en, this message translates to:
  /// **'Routes & repeaters'**
  String get tools_groupRouting;

  /// No description provided for @tools_pathGraph.
  ///
  /// In en, this message translates to:
  /// **'Path graph'**
  String get tools_pathGraph;

  /// No description provided for @tools_pathGraphHint.
  ///
  /// In en, this message translates to:
  /// **'How messages reach you: every path heard, with the busiest repeaters'**
  String get tools_pathGraphHint;

  /// No description provided for @tools_antenna.
  ///
  /// In en, this message translates to:
  /// **'Antenna coverage'**
  String get tools_antenna;

  /// No description provided for @tools_antennaHint.
  ///
  /// In en, this message translates to:
  /// **'Estimate where an antenna can reach over the terrain'**
  String get tools_antennaHint;

  /// A repeater whose name is unknown, by its ID prefix
  ///
  /// In en, this message translates to:
  /// **'Repeater {id}'**
  String routes_repeaterWithId(String id);

  /// No description provided for @coverageHex_title.
  ///
  /// In en, this message translates to:
  /// **'Coverage hexagons'**
  String get coverageHex_title;

  /// No description provided for @coverageHex_toolSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Map where your radio hears the mesh and share it'**
  String get coverageHex_toolSubtitle;

  /// No description provided for @coverageHex_mapCoverage.
  ///
  /// In en, this message translates to:
  /// **'Map coverage'**
  String get coverageHex_mapCoverage;

  /// No description provided for @coverageHex_statusOff.
  ///
  /// In en, this message translates to:
  /// **'Off. Turn on while you drive or walk to map where your radio hears the mesh.'**
  String get coverageHex_statusOff;

  /// No description provided for @coverageHex_waitingGps.
  ///
  /// In en, this message translates to:
  /// **'Waiting for GPS…'**
  String get coverageHex_waitingGps;

  /// No description provided for @coverageHex_gpsTooRough.
  ///
  /// In en, this message translates to:
  /// **'GPS accuracy {meters} m: too rough, not recording.'**
  String coverageHex_gpsTooRough(String meters);

  /// No description provided for @coverageHex_recording.
  ///
  /// In en, this message translates to:
  /// **'Recording. GPS accuracy {meters} m.'**
  String coverageHex_recording(String meters);

  /// No description provided for @coverageHex_hexagons.
  ///
  /// In en, this message translates to:
  /// **'Hexagons'**
  String get coverageHex_hexagons;

  /// No description provided for @coverageHex_samples.
  ///
  /// In en, this message translates to:
  /// **'Samples'**
  String get coverageHex_samples;

  /// No description provided for @coverageHex_privacyNote.
  ///
  /// In en, this message translates to:
  /// **'Uses the phone’s GPS while this switch is on. Only hexagon IDs (about 0.9 km across) are shared, never your exact position.'**
  String get coverageHex_privacyNote;

  /// No description provided for @coverageHex_uploadSection.
  ///
  /// In en, this message translates to:
  /// **'Upload to coverage maps'**
  String get coverageHex_uploadSection;

  /// No description provided for @coverageHex_wifiOnly.
  ///
  /// In en, this message translates to:
  /// **'Upload on Wi-Fi only'**
  String get coverageHex_wifiOnly;

  /// No description provided for @coverageHex_wifiOnlyHint.
  ///
  /// In en, this message translates to:
  /// **'Samples wait on the phone (up to 7 days) until Wi-Fi.'**
  String get coverageHex_wifiOnlyHint;

  /// No description provided for @coverageHex_waiting.
  ///
  /// In en, this message translates to:
  /// **'{count} waiting'**
  String coverageHex_waiting(String count);

  /// No description provided for @coverageHex_addMap.
  ///
  /// In en, this message translates to:
  /// **'Add a coverage map'**
  String get coverageHex_addMap;

  /// No description provided for @coverageHex_addMapHint.
  ///
  /// In en, this message translates to:
  /// **'Any HTTPS endpoint that accepts coverage uploads.'**
  String get coverageHex_addMapHint;

  /// No description provided for @coverageHex_uploadNow.
  ///
  /// In en, this message translates to:
  /// **'Upload now'**
  String get coverageHex_uploadNow;

  /// No description provided for @coverageHex_mapDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Coverage map'**
  String get coverageHex_mapDialogTitle;

  /// No description provided for @coverageHex_nameMissing.
  ///
  /// In en, this message translates to:
  /// **'Give it a name.'**
  String get coverageHex_nameMissing;

  /// No description provided for @coverageHex_url.
  ///
  /// In en, this message translates to:
  /// **'Upload URL'**
  String get coverageHex_url;

  /// No description provided for @coverageHex_urlInvalid.
  ///
  /// In en, this message translates to:
  /// **'Must be an https:// URL.'**
  String get coverageHex_urlInvalid;

  /// No description provided for @coverageHex_apiKey.
  ///
  /// In en, this message translates to:
  /// **'API key (optional)'**
  String get coverageHex_apiKey;

  /// No description provided for @coverageHex_apiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Sent as X-API-Key.'**
  String get coverageHex_apiKeyHint;

  /// No description provided for @coverageHex_format.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get coverageHex_format;

  /// No description provided for @coverageHex_formatHex.
  ///
  /// In en, this message translates to:
  /// **'Hexagon IDs (NOTORYX)'**
  String get coverageHex_formatHex;

  /// No description provided for @coverageHex_formatMeshMapper.
  ///
  /// In en, this message translates to:
  /// **'MeshMapper-compatible'**
  String get coverageHex_formatMeshMapper;

  /// No description provided for @coverageHex_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get coverageHex_privacy;

  /// No description provided for @coverageHex_privacyLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get coverageHex_privacyLive;

  /// No description provided for @coverageHex_privacyDelayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed 3 h'**
  String get coverageHex_privacyDelayed;

  /// No description provided for @coverageHex_privacyAnonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous, 24 h'**
  String get coverageHex_privacyAnonymous;

  /// No description provided for @coverageHex_privacyLiveHint.
  ///
  /// In en, this message translates to:
  /// **'Sent within about 15 minutes.'**
  String get coverageHex_privacyLiveHint;

  /// No description provided for @coverageHex_privacyDelayedHint.
  ///
  /// In en, this message translates to:
  /// **'Held 3 hours so the map can’t show where you are now.'**
  String get coverageHex_privacyDelayedHint;

  /// No description provided for @coverageHex_privacyAnonymousHint.
  ///
  /// In en, this message translates to:
  /// **'Held 24 hours, dated by day only, and unsigned so uploads can’t be linked.'**
  String get coverageHex_privacyAnonymousHint;

  /// No description provided for @coverageHex_uploadsOn.
  ///
  /// In en, this message translates to:
  /// **'Uploads on'**
  String get coverageHex_uploadsOn;

  /// No description provided for @coverageHex_sent.
  ///
  /// In en, this message translates to:
  /// **'Sent {count} cells at {time}.'**
  String coverageHex_sent(String count, String time);

  /// No description provided for @coverageHex_httpError.
  ///
  /// In en, this message translates to:
  /// **'The map answered {code}; will retry.'**
  String coverageHex_httpError(String code);

  /// No description provided for @coverageHex_unreachable.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t reach the map; will retry.'**
  String get coverageHex_unreachable;

  /// No description provided for @coverageHex_noPermission.
  ///
  /// In en, this message translates to:
  /// **'Location permission was not granted.'**
  String get coverageHex_noPermission;

  /// No description provided for @coverageHex_noGps.
  ///
  /// In en, this message translates to:
  /// **'GPS isn’t available.'**
  String get coverageHex_noGps;

  /// No description provided for @coverageHex_loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Saved coverage couldn’t be read; starting fresh.'**
  String get coverageHex_loadFailed;

  /// No description provided for @mqttExtra_wifiOnly.
  ///
  /// In en, this message translates to:
  /// **'Connect on Wi-Fi only'**
  String get mqttExtra_wifiOnly;

  /// No description provided for @mqttExtra_backlog.
  ///
  /// In en, this message translates to:
  /// **'{count} packets waiting to upload (kept up to 72 hours).'**
  String mqttExtra_backlog(String count);

  /// No description provided for @mqttExtra_add.
  ///
  /// In en, this message translates to:
  /// **'Add another broker'**
  String get mqttExtra_add;

  /// No description provided for @mqttExtra_addBody.
  ///
  /// In en, this message translates to:
  /// **'Shares what your radio hears with one more MQTT broker, beside your main one. It only uploads; it never feeds packets back into the app.'**
  String get mqttExtra_addBody;

  /// No description provided for @mqttExtra_separateKey.
  ///
  /// In en, this message translates to:
  /// **'Use a separate key'**
  String get mqttExtra_separateKey;

  /// No description provided for @mqttExtra_separateKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Signs in with a key made on this phone instead of the radio’s, so this broker can’t tie uploads to your radio.'**
  String get mqttExtra_separateKeyHint;

  /// No description provided for @mqttExtra_removeTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}?'**
  String mqttExtra_removeTitle(String name);

  /// No description provided for @mqttExtra_removeBody.
  ///
  /// In en, this message translates to:
  /// **'Disconnects and forgets its settings, password, key and any packets still waiting to upload.'**
  String get mqttExtra_removeBody;

  /// No description provided for @mqttExtra_ownKey.
  ///
  /// In en, this message translates to:
  /// **'Signs in with its own key: {key}…'**
  String mqttExtra_ownKey(String key);

  /// No description provided for @botWx_title.
  ///
  /// In en, this message translates to:
  /// **'Post weather alerts to a channel'**
  String get botWx_title;

  /// No description provided for @botWx_body.
  ///
  /// In en, this message translates to:
  /// **'Checks the US National Weather Service every 10 minutes for severe and extreme warnings at the radio’s GPS position (rounded to about 1 km), and posts each new one once. Needs phone internet.'**
  String get botWx_body;

  /// No description provided for @botWx_channel.
  ///
  /// In en, this message translates to:
  /// **'Post to channel'**
  String get botWx_channel;

  /// No description provided for @botWx_moderate.
  ///
  /// In en, this message translates to:
  /// **'Include moderate alerts'**
  String get botWx_moderate;

  /// No description provided for @botWx_moderateHint.
  ///
  /// In en, this message translates to:
  /// **'Advisories as well as warnings. Busier.'**
  String get botWx_moderateHint;

  /// No description provided for @botWx_lastChecked.
  ///
  /// In en, this message translates to:
  /// **'Last checked {time}.'**
  String botWx_lastChecked(String time);

  /// No description provided for @botWx_noPosition.
  ///
  /// In en, this message translates to:
  /// **'The radio hasn’t reported a GPS position yet.'**
  String get botWx_noPosition;

  /// No description provided for @botWx_noChannel.
  ///
  /// In en, this message translates to:
  /// **'Choose a channel to post alerts to.'**
  String get botWx_noChannel;

  /// No description provided for @botWx_channelGone.
  ///
  /// In en, this message translates to:
  /// **'The chosen channel no longer exists.'**
  String get botWx_channelGone;

  /// No description provided for @botWx_httpError.
  ///
  /// In en, this message translates to:
  /// **'Weather Service answered {code}.'**
  String botWx_httpError(String code);

  /// No description provided for @botWx_unreachable.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t reach the Weather Service.'**
  String get botWx_unreachable;

  /// No description provided for @botCmd_sun.
  ///
  /// In en, this message translates to:
  /// **'Sunrise and sunset at the radio’s GPS position.'**
  String get botCmd_sun;

  /// No description provided for @botCmd_moon.
  ///
  /// In en, this message translates to:
  /// **'Moon phase and how much is lit.'**
  String get botCmd_moon;

  /// No description provided for @botCmd_weather.
  ///
  /// In en, this message translates to:
  /// **'Current weather at the radio (Open-Meteo). Sends the position, rounded to about 1 km.'**
  String get botCmd_weather;

  /// No description provided for @botCmd_dice.
  ///
  /// In en, this message translates to:
  /// **'Rolls dice: !dice, !dice 20 or !dice 2d6.'**
  String get botCmd_dice;

  /// No description provided for @botCmd_trace.
  ///
  /// In en, this message translates to:
  /// **'Lists the repeaters the sender’s message came through.'**
  String get botCmd_trace;

  /// No description provided for @ping_title.
  ///
  /// In en, this message translates to:
  /// **'Repeater ping'**
  String get ping_title;

  /// No description provided for @ping_toolSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Round-trip time and signal both ways to a nearby repeater'**
  String get ping_toolSubtitle;

  /// No description provided for @ping_noRepeaters.
  ///
  /// In en, this message translates to:
  /// **'No repeaters known yet'**
  String get ping_noRepeaters;

  /// No description provided for @ping_choose.
  ///
  /// In en, this message translates to:
  /// **'Choose a repeater'**
  String get ping_choose;

  /// No description provided for @ping_avgMs.
  ///
  /// In en, this message translates to:
  /// **'ms round trip'**
  String get ping_avgMs;

  /// No description provided for @ping_snrThere.
  ///
  /// In en, this message translates to:
  /// **'SNR there'**
  String get ping_snrThere;

  /// No description provided for @ping_snrBack.
  ///
  /// In en, this message translates to:
  /// **'SNR back'**
  String get ping_snrBack;

  /// No description provided for @ping_loss.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get ping_loss;

  /// No description provided for @ping_running.
  ///
  /// In en, this message translates to:
  /// **'Pinging {done} of {total}…'**
  String ping_running(int done, int total);

  /// No description provided for @ping_start.
  ///
  /// In en, this message translates to:
  /// **'Ping {count} times'**
  String ping_start(int count);

  /// No description provided for @ping_results.
  ///
  /// In en, this message translates to:
  /// **'Probes'**
  String get ping_results;

  /// No description provided for @ping_noReply.
  ///
  /// In en, this message translates to:
  /// **'No reply'**
  String get ping_noReply;

  /// No description provided for @ping_resultLine.
  ///
  /// In en, this message translates to:
  /// **'{ms} ms · SNR there {snr}'**
  String ping_resultLine(String ms, String snr);

  /// No description provided for @ping_explainer.
  ///
  /// In en, this message translates to:
  /// **'Each probe is a one-hop path trace: the repeater notes how well it heard you and repeats it back. It works for repeaters your radio hears directly.'**
  String get ping_explainer;

  /// No description provided for @hunt_title.
  ///
  /// In en, this message translates to:
  /// **'Antenna hunt'**
  String get hunt_title;

  /// No description provided for @hunt_toolSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A big live signal meter that clicks faster as it gets stronger'**
  String get hunt_toolSubtitle;

  /// No description provided for @hunt_noSignal.
  ///
  /// In en, this message translates to:
  /// **'No signal yet'**
  String get hunt_noSignal;

  /// No description provided for @hunt_noReply.
  ///
  /// In en, this message translates to:
  /// **'No reply — move or turn the antenna'**
  String get hunt_noReply;

  /// No description provided for @hunt_heardHere.
  ///
  /// In en, this message translates to:
  /// **'dB heard here'**
  String get hunt_heardHere;

  /// No description provided for @hunt_best.
  ///
  /// In en, this message translates to:
  /// **'Best'**
  String get hunt_best;

  /// No description provided for @hunt_sound.
  ///
  /// In en, this message translates to:
  /// **'Click as it gets stronger'**
  String get hunt_sound;

  /// No description provided for @hunt_soundHint.
  ///
  /// In en, this message translates to:
  /// **'With a vibration on each click, so you can aim without looking.'**
  String get hunt_soundHint;

  /// No description provided for @hunt_stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get hunt_stop;

  /// No description provided for @hunt_start.
  ///
  /// In en, this message translates to:
  /// **'Start hunting'**
  String get hunt_start;

  /// No description provided for @hunt_explainer.
  ///
  /// In en, this message translates to:
  /// **'Probes the repeater about once a second. Point a directional antenna or walk around: the number is how well your radio hears it.'**
  String get hunt_explainer;

  /// No description provided for @settings_refreshRate.
  ///
  /// In en, this message translates to:
  /// **'Radio refresh rate'**
  String get settings_refreshRate;

  /// No description provided for @settings_refreshFast.
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get settings_refreshFast;

  /// No description provided for @settings_refreshNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get settings_refreshNormal;

  /// No description provided for @settings_refreshSlow.
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get settings_refreshSlow;

  /// No description provided for @settings_refreshFastHint.
  ///
  /// In en, this message translates to:
  /// **'Battery every minute, GPS every 30 s. Fresher numbers, more battery.'**
  String get settings_refreshFastHint;

  /// No description provided for @settings_refreshNormalHint.
  ///
  /// In en, this message translates to:
  /// **'Battery every 2 minutes, GPS every minute.'**
  String get settings_refreshNormalHint;

  /// No description provided for @settings_refreshSlowHint.
  ///
  /// In en, this message translates to:
  /// **'Battery every 6 minutes, GPS every 3 minutes. Saves battery.'**
  String get settings_refreshSlowHint;

  /// No description provided for @settings_refreshSaverOn.
  ///
  /// In en, this message translates to:
  /// **'Battery saver is on, so it sets the pace (battery every 10 minutes).'**
  String get settings_refreshSaverOn;

  /// No description provided for @reach_check.
  ///
  /// In en, this message translates to:
  /// **'Check observer reach'**
  String get reach_check;

  /// No description provided for @reach_title.
  ///
  /// In en, this message translates to:
  /// **'Observer reach'**
  String get reach_title;

  /// No description provided for @reach_noHash.
  ///
  /// In en, this message translates to:
  /// **'This message can’t be looked up yet: no repeater has echoed it back to your radio, so its packet ID isn’t known.'**
  String get reach_noHash;

  /// No description provided for @reach_unreachable.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t reach the analyzer. Check your internet connection or the analyzer address in Settings.'**
  String get reach_unreachable;

  /// No description provided for @reach_none.
  ///
  /// In en, this message translates to:
  /// **'No observer has heard it yet. Observers upload a little after hearing a packet, so check again in a minute.'**
  String get reach_none;

  /// No description provided for @reach_observers.
  ///
  /// In en, this message translates to:
  /// **'observers'**
  String get reach_observers;

  /// No description provided for @reach_maxHops.
  ///
  /// In en, this message translates to:
  /// **'max hops'**
  String get reach_maxHops;

  /// No description provided for @reach_bestSnr.
  ///
  /// In en, this message translates to:
  /// **'best SNR'**
  String get reach_bestSnr;

  /// No description provided for @reach_hops.
  ///
  /// In en, this message translates to:
  /// **'{count} hops away'**
  String reach_hops(int count);

  /// No description provided for @reach_explainer.
  ///
  /// In en, this message translates to:
  /// **'From the online analyzer: observers that heard this packet and uploaded it.'**
  String get reach_explainer;

  /// No description provided for @reach_checkAgain.
  ///
  /// In en, this message translates to:
  /// **'Check again'**
  String get reach_checkAgain;

  /// No description provided for @analyzer_title.
  ///
  /// In en, this message translates to:
  /// **'Online analyzer'**
  String get analyzer_title;

  /// No description provided for @analyzer_url.
  ///
  /// In en, this message translates to:
  /// **'Analyzer address'**
  String get analyzer_url;

  /// No description provided for @analyzer_urlHint.
  ///
  /// In en, this message translates to:
  /// **'A CoreScope analyzer (https://). Use the one that covers your region.'**
  String get analyzer_urlHint;

  /// No description provided for @analyzer_reset.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get analyzer_reset;

  /// No description provided for @analyzer_hint.
  ///
  /// In en, this message translates to:
  /// **'Used to check which observers heard your messages. A check sends only the packet ID.'**
  String get analyzer_hint;

  /// No description provided for @analyzer_hopLookup.
  ///
  /// In en, this message translates to:
  /// **'Name unknown repeaters online'**
  String get analyzer_hopLookup;

  /// No description provided for @analyzer_hopLookupHint.
  ///
  /// In en, this message translates to:
  /// **'When a repeater ID isn’t in your contacts, ask the analyzer for its name. Sends the short IDs only. A name ending in “?” means several repeaters share that ID.'**
  String get analyzer_hopLookupHint;

  /// No description provided for @discovered_tray.
  ///
  /// In en, this message translates to:
  /// **'Channels heard nearby: {count}'**
  String discovered_tray(int count);

  /// No description provided for @discovered_title.
  ///
  /// In en, this message translates to:
  /// **'Heard nearby, not joined'**
  String get discovered_title;

  /// No description provided for @discovered_heard.
  ///
  /// In en, this message translates to:
  /// **'Heard {count}× · last {time}'**
  String discovered_heard(int count, String time);

  /// No description provided for @discovered_ignore.
  ///
  /// In en, this message translates to:
  /// **'Ignore'**
  String get discovered_ignore;

  /// No description provided for @discovered_ignoreAll.
  ///
  /// In en, this message translates to:
  /// **'Ignore all'**
  String get discovered_ignoreAll;

  /// No description provided for @discovered_joinAll.
  ///
  /// In en, this message translates to:
  /// **'Join all'**
  String get discovered_joinAll;

  /// No description provided for @discovered_explainer.
  ///
  /// In en, this message translates to:
  /// **'These are public channels from the channel directory that your radio has heard traffic on. Each was confirmed by decrypting a message with its key. Ignored channels stay hidden.'**
  String get discovered_explainer;

  /// No description provided for @mqtt_presetMeshRank.
  ///
  /// In en, this message translates to:
  /// **'MeshRank (community)'**
  String get mqtt_presetMeshRank;

  /// No description provided for @mqtt_presetMeshRankNote.
  ///
  /// In en, this message translates to:
  /// **'MeshRank is a community-run MeshCore network ranking, not part of NOTORYX and not endorsed by it. No sign-in: packets are shared under your radio’s key and region code, and only once you turn sharing on.'**
  String get mqtt_presetMeshRankNote;

  /// No description provided for @pathFilter_title.
  ///
  /// In en, this message translates to:
  /// **'Path-width filter'**
  String get pathFilter_title;

  /// No description provided for @pathFilter_firmwareNote.
  ///
  /// In en, this message translates to:
  /// **'Needs repeater firmware with forwarding rules (mikecarper/MeshCore). Official MeshCore firmware rejects these commands.'**
  String get pathFilter_firmwareNote;

  /// No description provided for @pathFilter_width.
  ///
  /// In en, this message translates to:
  /// **'Path width'**
  String get pathFilter_width;

  /// No description provided for @pathFilter_anyWidth.
  ///
  /// In en, this message translates to:
  /// **'Any width'**
  String get pathFilter_anyWidth;

  /// No description provided for @pathFilter_bytes.
  ///
  /// In en, this message translates to:
  /// **'{n}-byte paths'**
  String pathFilter_bytes(int n);

  /// No description provided for @pathFilter_twoOrMore.
  ///
  /// In en, this message translates to:
  /// **'2 or 3 bytes (2+)'**
  String get pathFilter_twoOrMore;

  /// No description provided for @pathFilter_path.
  ///
  /// In en, this message translates to:
  /// **'Applies to'**
  String get pathFilter_path;

  /// No description provided for @pathFilter_radio.
  ///
  /// In en, this message translates to:
  /// **'Radio floods'**
  String get pathFilter_radio;

  /// No description provided for @pathFilter_bridge.
  ///
  /// In en, this message translates to:
  /// **'Bridge'**
  String get pathFilter_bridge;

  /// No description provided for @pathFilter_cross.
  ///
  /// In en, this message translates to:
  /// **'Crossover'**
  String get pathFilter_cross;

  /// No description provided for @pathFilter_bridgeCross.
  ///
  /// In en, this message translates to:
  /// **'Bridge and crossover'**
  String get pathFilter_bridgeCross;

  /// No description provided for @pathFilter_limit.
  ///
  /// In en, this message translates to:
  /// **'Limit instead of drop'**
  String get pathFilter_limit;

  /// No description provided for @pathFilter_limitOn.
  ///
  /// In en, this message translates to:
  /// **'Forwards up to a set number per minute.'**
  String get pathFilter_limitOn;

  /// No description provided for @pathFilter_drop.
  ///
  /// In en, this message translates to:
  /// **'Matching floods are dropped, not forwarded.'**
  String get pathFilter_drop;

  /// No description provided for @pathFilter_perMinute.
  ///
  /// In en, this message translates to:
  /// **'Per minute'**
  String get pathFilter_perMinute;

  /// No description provided for @pathFilter_rateInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter 1 to 65534.'**
  String get pathFilter_rateInvalid;

  /// No description provided for @pathFilter_reviewNote.
  ///
  /// In en, this message translates to:
  /// **'This only fills in the command line. Check it, then press Send. Use “get fr” first to see existing rules.'**
  String get pathFilter_reviewNote;

  /// No description provided for @pathFilter_useCommand.
  ///
  /// In en, this message translates to:
  /// **'Use command'**
  String get pathFilter_useCommand;

  /// No description provided for @settings_linkPreviews.
  ///
  /// In en, this message translates to:
  /// **'Link previews'**
  String get settings_linkPreviews;

  /// No description provided for @settings_linkPreviewsHint.
  ///
  /// In en, this message translates to:
  /// **'Shows the title of a link in a message. Off by default: fetching the page tells that site your IP address.'**
  String get settings_linkPreviewsHint;

  /// No description provided for @guide_title.
  ///
  /// In en, this message translates to:
  /// **'Field guide'**
  String get guide_title;

  /// No description provided for @guide_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Basics, cold-weather batteries, solar and antennas'**
  String get guide_subtitle;

  /// No description provided for @guide_secMesh.
  ///
  /// In en, this message translates to:
  /// **'Getting on the mesh'**
  String get guide_secMesh;

  /// No description provided for @guide_mesh1.
  ///
  /// In en, this message translates to:
  /// **'Your phone talks to your radio over Bluetooth, USB or Wi-Fi; the radio talks to the mesh over LoRa. Messages still work with no phone signal.'**
  String get guide_mesh1;

  /// No description provided for @guide_mesh2.
  ///
  /// In en, this message translates to:
  /// **'Repeaters pass messages along; each relay is a hop. Fewer hops means faster, more reliable delivery.'**
  String get guide_mesh2;

  /// No description provided for @guide_mesh3.
  ///
  /// In en, this message translates to:
  /// **'Keep messages short and avoid flooding busy channels: every message uses shared airtime.'**
  String get guide_mesh3;

  /// No description provided for @guide_secCold.
  ///
  /// In en, this message translates to:
  /// **'Batteries in the cold'**
  String get guide_secCold;

  /// No description provided for @guide_cold1.
  ///
  /// In en, this message translates to:
  /// **'Don’t charge lithium batteries below freezing (0 °C / 32 °F): it damages them permanently.'**
  String get guide_cold1;

  /// No description provided for @guide_cold2.
  ///
  /// In en, this message translates to:
  /// **'Carry the radio inside your jacket. Cold cuts capacity, but it comes back once the battery warms up.'**
  String get guide_cold2;

  /// No description provided for @guide_cold3.
  ///
  /// In en, this message translates to:
  /// **'For fixed sites in cold climates, LiFePO4 copes better than lithium-ion; a heated or insulated box helps either.'**
  String get guide_cold3;

  /// No description provided for @guide_secSolar.
  ///
  /// In en, this message translates to:
  /// **'Solar for repeaters'**
  String get guide_secSolar;

  /// No description provided for @guide_solar1.
  ///
  /// In en, this message translates to:
  /// **'A repeater uses very little power, but size the panel and battery for your darkest winter week, not a summer day.'**
  String get guide_solar1;

  /// No description provided for @guide_solar2.
  ///
  /// In en, this message translates to:
  /// **'Face the panel toward the equator and tilt it steeply in winter; keep snow and shade off it.'**
  String get guide_solar2;

  /// No description provided for @guide_secAntenna.
  ///
  /// In en, this message translates to:
  /// **'Antennas and placement'**
  String get guide_secAntenna;

  /// No description provided for @guide_ant1.
  ///
  /// In en, this message translates to:
  /// **'Height beats power: a radio a few metres up reaches far more than one on a desk.'**
  String get guide_ant1;

  /// No description provided for @guide_ant2.
  ///
  /// In en, this message translates to:
  /// **'Keep the antenna vertical and clear of metal, and use one made for your band (for example 915 MHz in North America).'**
  String get guide_ant2;

  /// No description provided for @guide_secMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get guide_secMore;

  /// No description provided for @guide_moreMeshcore.
  ///
  /// In en, this message translates to:
  /// **'The official MeshCore project'**
  String get guide_moreMeshcore;

  /// No description provided for @guide_moreCascadia.
  ///
  /// In en, this message translates to:
  /// **'Community guides: getting started, wardriving, regions, solar'**
  String get guide_moreCascadia;

  /// No description provided for @post_signed.
  ///
  /// In en, this message translates to:
  /// **'Signed'**
  String get post_signed;

  /// No description provided for @post_unverified.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get post_unverified;

  /// No description provided for @post_signedKnown.
  ///
  /// In en, this message translates to:
  /// **'Signed by {name}, one of your contacts.'**
  String post_signedKnown(String name);

  /// No description provided for @post_signedUnknownKey.
  ///
  /// In en, this message translates to:
  /// **'Signed, but not by any of your contacts. Add the sender as a contact to see who it is.'**
  String get post_signedUnknownKey;

  /// No description provided for @post_unverifiedHint.
  ///
  /// In en, this message translates to:
  /// **'A signature came with this post but didn’t match it. The post may have been changed on the way, or it may not be from who it says.'**
  String get post_unverifiedHint;

  /// No description provided for @settings_signPosts.
  ///
  /// In en, this message translates to:
  /// **'Sign all my channel posts'**
  String get settings_signPosts;

  /// No description provided for @settings_signPostsHint.
  ///
  /// In en, this message translates to:
  /// **'An SOS on a channel is always signed. This signs every post, so other NOTORYX users can tell it’s really you. Each signature is one extra packet on air.'**
  String get settings_signPostsHint;

  /// No description provided for @tools_search.
  ///
  /// In en, this message translates to:
  /// **'Search tools and settings'**
  String get tools_search;

  /// No description provided for @tools_noMatches.
  ///
  /// In en, this message translates to:
  /// **'No tools match your search.'**
  String get tools_noMatches;

  /// No description provided for @tools_bot.
  ///
  /// In en, this message translates to:
  /// **'Bot Mode'**
  String get tools_bot;

  /// No description provided for @tools_botHint.
  ///
  /// In en, this message translates to:
  /// **'Auto replies, !commands and weather alerts on channels'**
  String get tools_botHint;

  /// No description provided for @botChannels_title.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get botChannels_title;

  /// No description provided for @botChannels_hint.
  ///
  /// In en, this message translates to:
  /// **'The bot also answers !commands in the channels you turn on, in that channel. It never sends away replies there.'**
  String get botChannels_hint;

  /// No description provided for @botChannels_none.
  ///
  /// In en, this message translates to:
  /// **'No channels on this radio yet.'**
  String get botChannels_none;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'bg',
    'de',
    'en',
    'es',
    'fr',
    'hu',
    'it',
    'ja',
    'ko',
    'nl',
    'pl',
    'pt',
    'ru',
    'sk',
    'sl',
    'sv',
    'uk',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bg':
      return AppLocalizationsBg();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hu':
      return AppLocalizationsHu();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'sk':
      return AppLocalizationsSk();
    case 'sl':
      return AppLocalizationsSl();
    case 'sv':
      return AppLocalizationsSv();
    case 'uk':
      return AppLocalizationsUk();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
