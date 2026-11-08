// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core Ham';

  @override
  String get nav_contacts => 'Contacts';

  @override
  String get nav_channels => 'Channels';

  @override
  String get nav_map => 'Map';

  @override
  String get nav_messages => 'Messages';

  @override
  String get nav_nodes => 'Nodes';

  @override
  String get nav_radio => 'Radio';

  @override
  String get messages_title => 'Messages';

  @override
  String get messages_filterAll => 'All';

  @override
  String get messages_filterDirect => 'Direct';

  @override
  String get messages_filterChannels => 'Channels';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'Search messages';

  @override
  String get messages_searchHint => 'Search conversations';

  @override
  String get messages_closeSearch => 'Close search';

  @override
  String get messages_manageChannels => 'Manage channels';

  @override
  String get messages_new => 'New';

  @override
  String get messages_newDirect => 'Message a node';

  @override
  String get messages_newChannel => 'Add or join a channel';

  @override
  String get messages_empty => 'No conversations yet';

  @override
  String get messages_emptyHint =>
      'Messages from nodes and channels show up here.';

  @override
  String get messages_noMatches => 'No conversations match your search';

  @override
  String messages_you(String text) {
    return 'You: $text';
  }

  @override
  String get messages_yesterday => 'Yesterday';

  @override
  String messages_unreadCount(int count) {
    return '$count unread';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return 'Connected over $transport';
  }

  @override
  String get radioStatus_bluetooth => 'Bluetooth';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'Wi‑Fi (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return 'Battery $percent%';
  }

  @override
  String get radioStatus_openRadio => 'Open radio details';

  @override
  String get radioOverview_battery => 'Battery';

  @override
  String radioOverview_firmware(String version) {
    return 'Firmware $version';
  }

  @override
  String get radioOverview_sendAdvert => 'Send advert';

  @override
  String get radioOverview_stats => 'Radio stats';

  @override
  String get accessControl_title => 'Access control';

  @override
  String get accessControl_hubSubtitle => 'Who can log in without the password';

  @override
  String get accessControl_explainRepeater =>
      'People on this list log in without a password. Admins can change settings; Read only and Read & write also get full telemetry.';

  @override
  String get accessControl_explainRoom =>
      'Admins on this list log in without a password and can manage the room. Room members join with the room password instead.';

  @override
  String get accessControl_roleReadOnly => 'Read only';

  @override
  String get accessControl_roleReadWrite => 'Read & write';

  @override
  String get accessControl_roleAdmin => 'Admin';

  @override
  String get accessControl_you => 'You';

  @override
  String get accessControl_unknownNode => 'Unknown node';

  @override
  String get accessControl_add => 'Add';

  @override
  String get accessControl_addTitle => 'Add to access list';

  @override
  String get accessControl_pickContact => 'Choose a contact';

  @override
  String get accessControl_noContacts =>
      'No contacts to add. Nodes appear here once you have heard their advert.';

  @override
  String get accessControl_changeRole => 'Change role';

  @override
  String get accessControl_remove => 'Remove access';

  @override
  String accessControl_removeConfirm(String name) {
    return 'Remove $name from the access list? They will need the password to log in.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'This is you. If you remove yourself you will need the admin password to manage this node again.';

  @override
  String get accessControl_unknownKeyNote =>
      'Not in your contacts. Changing its role needs newer node firmware; removing it always works.';

  @override
  String get accessControl_prefixUnsupported =>
      'This node\'s firmware can\'t change the role of someone who isn\'t in your contacts. You can still remove them.';

  @override
  String get accessControl_empty => 'Nobody is on the access list';

  @override
  String get accessControl_emptyHint =>
      'Add people so they can log in without the password.';

  @override
  String get accessControl_loading => 'Asking the node for its access list…';

  @override
  String get accessControl_timeout =>
      'The node didn\'t answer. Check the path and try again.';

  @override
  String get accessControl_maybeIncomplete =>
      'This node sent one full page and its firmware can\'t send more, so some entries may be missing.';

  @override
  String get accessControl_saved => 'Access list updated';

  @override
  String accessControl_failed(String reply) {
    return 'The node refused the change: $reply';
  }

  @override
  String get companionCli_title => 'Command line';

  @override
  String get companionCli_tileSubtitle => 'Run commands on your radio';

  @override
  String get companionCli_warning =>
      'Commands run on your connected radio and can change its settings or restart it.';

  @override
  String get companionCli_hint => 'Type a command, e.g. ver';

  @override
  String get companionCli_send => 'Run command';

  @override
  String get companionCli_noReply => 'No reply. The radio may be restarting.';

  @override
  String get companionCli_empty =>
      'Try one of the commands above, or type your own.';

  @override
  String get wifi_title => 'WiFi';

  @override
  String get wifi_tileSubtitle => 'Connect your radio to a WiFi network';

  @override
  String get wifi_unsupported =>
      'This radio\'s firmware doesn\'t include WiFi.';

  @override
  String get wifi_enabled => 'Use WiFi';

  @override
  String get wifi_status => 'Status';

  @override
  String get wifi_connected => 'Connected';

  @override
  String wifi_connectedIp(String ip) {
    return 'Connected · $ip';
  }

  @override
  String get wifi_disconnected => 'Not connected';

  @override
  String get wifi_network => 'Network name (SSID)';

  @override
  String get wifi_password => 'Password';

  @override
  String get wifi_passwordKeep => 'Leave blank to keep the current password';

  @override
  String get wifi_save => 'Save';

  @override
  String get wifi_forget => 'Forget network';

  @override
  String get wifi_forgetConfirm =>
      'Remove the saved network and password from the radio?';

  @override
  String get wifi_rebootNeeded =>
      'Saved. Restart the radio to apply WiFi changes.';

  @override
  String get wifi_rebootNow => 'Restart radio';

  @override
  String get wifi_rebootConfirm =>
      'Restart the radio now? The app will disconnect and you\'ll need to reconnect.';

  @override
  String get wifi_loadFailed =>
      'Couldn\'t read the WiFi settings from the radio.';

  @override
  String get wifi_retry => 'Try again';

  @override
  String wifi_saveFailed(String reply) {
    return 'The radio didn\'t accept the change: $reply';
  }

  @override
  String get accessControl_refresh => 'Refresh';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get common_ok => 'OK';

  @override
  String get common_connect => 'Connect';

  @override
  String get common_unknownDevice => 'Unknown Device';

  @override
  String get common_save => 'Save';

  @override
  String get common_delete => 'Delete';

  @override
  String get common_deleteAll => 'Delete All';

  @override
  String get common_close => 'Close';

  @override
  String get common_done => 'Done';

  @override
  String get common_edit => 'Edit';

  @override
  String get common_add => 'Add';

  @override
  String get common_settings => 'Settings';

  @override
  String get common_disconnect => 'Disconnect';

  @override
  String get common_connected => 'Connected';

  @override
  String get common_disconnected => 'Disconnected';

  @override
  String get common_create => 'Create';

  @override
  String get common_continue => 'Continue';

  @override
  String get common_share => 'Share';

  @override
  String get common_copy => 'Copy';

  @override
  String get common_retry => 'Retry';

  @override
  String get common_hide => 'Hide';

  @override
  String get common_remove => 'Remove';

  @override
  String get common_enable => 'Enable';

  @override
  String get common_disable => 'Disable';

  @override
  String get common_undo => 'Undo';

  @override
  String get messageStatus_sent => 'Sent';

  @override
  String get messageStatus_delivered => 'Delivered';

  @override
  String get messageStatus_pending => 'Sending';

  @override
  String get messageStatus_failed => 'Failed to send';

  @override
  String get messageStatus_repeated => 'Heard repeated';

  @override
  String get urlImage_enable => 'Enable URL images';

  @override
  String get urlImage_possible => 'Possible URL image; enable it in Settings.';

  @override
  String get common_reboot => 'Reboot';

  @override
  String get common_loading => 'Loading...';

  @override
  String get common_notAvailable => '—';

  @override
  String common_voltageValue(String volts) {
    return '$volts V';
  }

  @override
  String common_percentValue(int percent) {
    return '$percent%';
  }

  @override
  String get common_autoRefresh => 'Autorefresh';

  @override
  String get common_interval => 'Interval';

  @override
  String get scanner_title => 'Connect Radio';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'Connect over TCP';

  @override
  String get tcpHostLabel => 'Endpoint';

  @override
  String get tcpHostHint => '192.168.40.10 / example.com';

  @override
  String get tcpPortLabel => 'Port';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => 'Enter endpoint and connect';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return 'Connecting to $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => 'Host is required.';

  @override
  String get tcpErrorPortInvalid => 'Port must be between 1 and 65535.';

  @override
  String get tcpErrorUnsupported =>
      'TCP transport is not supported on this platform.';

  @override
  String get tcpErrorTimedOut => 'TCP connection timed out.';

  @override
  String tcpConnectionFailed(String error) {
    return 'TCP connection failed: $error';
  }

  @override
  String get usbScreenTitle => 'Connect over USB';

  @override
  String get usbScreenSubtitle =>
      'Choose a detected serial device and connect directly to your MeshCore node.';

  @override
  String get usbScreenStatus => 'Select a USB device';

  @override
  String get usbScreenNote =>
      'USB serial is active on supported Android devices and desktop platforms.';

  @override
  String get usbScreenEmptyState =>
      'No USB devices found. Plug one in and refresh.';

  @override
  String get usbErrorPermissionDenied => 'USB permission was denied.';

  @override
  String get usbErrorDeviceMissing =>
      'The selected USB device is no longer available.';

  @override
  String get usbErrorInvalidPort => 'Select a valid USB device.';

  @override
  String get usbErrorBusy =>
      'Another USB connection request is already in progress.';

  @override
  String get usbErrorNotConnected => 'No USB device is connected.';

  @override
  String get usbErrorOpenFailed => 'Failed to open the selected USB device.';

  @override
  String get usbErrorConnectFailed =>
      'Failed to connect to the selected USB device.';

  @override
  String get usbErrorUnsupported =>
      'USB serial is not supported on this platform.';

  @override
  String get usbErrorAlreadyActive => 'A USB connection is already active.';

  @override
  String get usbErrorNoDeviceSelected => 'No USB device was selected.';

  @override
  String get usbErrorPortClosed => 'The USB connection is not open.';

  @override
  String get usbErrorConnectTimedOut =>
      'Connection timed out. Make sure the device has USB Companion firmware.';

  @override
  String get usbFallbackDeviceName => 'Web Serial Device';

  @override
  String get usbStatus_notConnected => 'Select a USB device';

  @override
  String get usbStatus_connecting => 'Connecting to USB device...';

  @override
  String get usbStatus_searching => 'Searching for USB devices...';

  @override
  String usbConnectionFailed(String error) {
    return 'USB connection failed: $error';
  }

  @override
  String get scanner_scanning => 'Scanning for devices...';

  @override
  String get scanner_connecting => 'Connecting...';

  @override
  String get scanner_disconnecting => 'Disconnecting...';

  @override
  String get scanner_notConnected => 'Not connected';

  @override
  String scanner_connectedTo(String deviceName) {
    return 'Connected to $deviceName';
  }

  @override
  String get scanner_searchingDevices => 'Searching for MeshCore devices...';

  @override
  String get scanner_tapToScan => 'Tap Scan to find MeshCore devices';

  @override
  String scanner_connectionFailed(String error) {
    return 'Connection failed: $error';
  }

  @override
  String get scanner_stop => 'Stop';

  @override
  String get scanner_scan => 'Scan';

  @override
  String get scanner_bluetoothOff => 'Bluetooth is off';

  @override
  String get scanner_bluetoothOffMessage =>
      'Please turn on Bluetooth to scan for devices';

  @override
  String get scanner_chromeRequired => 'Chrome Browser Required';

  @override
  String get scanner_chromeRequiredMessage =>
      'This web application requires Google Chrome or a Chromium-based browser for Bluetooth support.';

  @override
  String get scanner_enableBluetooth => 'Enable Bluetooth';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'Bluetooth isn\'t available in the browser. Connect over USB instead.';

  @override
  String get device_quickSwitch => 'Quick switch';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_deviceInfo => 'Device Info';

  @override
  String get settings_appSettings => 'App Settings';

  @override
  String get settings_appSettingsSubtitle =>
      'Notifications, messaging, and map preferences';

  @override
  String get settings_nodeSettings => 'Node Settings';

  @override
  String get settings_nodeName => 'Node Name';

  @override
  String get settings_nodeNameNotSet => 'Not set';

  @override
  String get settings_nodeNameHint => 'Enter node name';

  @override
  String get settings_nodeNameUpdated => 'Name updated';

  @override
  String get settings_radioSettings => 'Radio Settings';

  @override
  String get settings_radioSettingsSubtitle =>
      'Frequency, power, spreading factor';

  @override
  String get settings_radioSettingsUpdated => 'Radio settings updated';

  @override
  String get settings_regionSettings => 'Regions';

  @override
  String get settings_regionSettingsSubtitle => 'Manage stored regions';

  @override
  String get settings_corridorRegion => 'Corridor region';

  @override
  String get settings_corridorRegionDefault => '#corridor (default)';

  @override
  String get settings_corridorRegionHelp =>
      'Flood corridor packets are tagged with this region. Repeaters without corridor firmware forward them only if they allow this region. Leave empty for the default #corridor tag.';

  @override
  String get settings_corridorRegionHint => 'Region name';

  @override
  String get settings_corridorRegionUseDefault => 'Use default';

  @override
  String get settings_corridorRegionUpdated => 'Corridor region updated';

  @override
  String get settings_corridorRegionFailed =>
      'Couldn\'t update the corridor region';

  @override
  String get settings_regionManagement_screenTitle => 'Region Management';

  @override
  String get settings_regionNameHint => 'Enter region name';

  @override
  String get settings_regionAddRegion => 'Add region';

  @override
  String get settings_regionFetchRegions => 'Fetch regions from repeaters';

  @override
  String get settings_regionFetchRegionsFail => 'No regions were found';

  @override
  String get settings_regionFetchRegionsAlreadyExists =>
      'This region has already been added';

  @override
  String get settings_regionName => 'Region Name';

  @override
  String get settings_regionDeleted => 'Region deleted';

  @override
  String get settings_deleteRegion => 'Delete Region';

  @override
  String settings_deleteRegionConfirm(String region) {
    return 'Remove \"$region\" from region list?';
  }

  @override
  String get settings_location => 'Location';

  @override
  String get settings_locationSubtitle => 'GPS coordinates';

  @override
  String get settings_locationUpdated => 'Location and GPS settings updated';

  @override
  String get settings_locationBothRequired =>
      'Enter both latitude and longitude.';

  @override
  String get settings_locationInvalid => 'Invalid latitude or longitude.';

  @override
  String get settings_locationGPSEnable => 'GPS Enable';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'Enables GPS to automatically update location.';

  @override
  String get settings_locationIntervalSec => 'Interval for GPS (Seconds)';

  @override
  String get settings_locationIntervalInvalid =>
      'Interval must be at least 60 seconds, and less than 86400 seconds.';

  @override
  String get settings_latitude => 'Latitude';

  @override
  String get settings_longitude => 'Longitude';

  @override
  String get settings_contactSettings => 'Contact Settings';

  @override
  String get settings_contactSettingsSubtitle =>
      'Settings for how contacts are added.';

  @override
  String get settings_privacyMode => 'Privacy Mode';

  @override
  String get settings_privacyModeSubtitle =>
      'Hide name/location in advertisements';

  @override
  String get settings_privacyModeToggle =>
      'Toggle privacy mode to hide your name and location in advertisements.';

  @override
  String get settings_privacyModeEnabled => 'Privacy mode enabled';

  @override
  String get settings_privacyModeDisabled => 'Privacy mode disabled';

  @override
  String get settings_privacy => 'Privacy Settings';

  @override
  String get settings_privacySubtitle => 'Control what information is shared.';

  @override
  String get settings_privacySettingsDescription =>
      'Choose what information your device shares with others.';

  @override
  String get settings_denyAll => 'Deny all';

  @override
  String get settings_allowByContact => 'Allow by contact flags';

  @override
  String get settings_allowAll => 'Allow all';

  @override
  String get settings_telemetryBaseMode => 'Telemetry Base Mode';

  @override
  String get settings_telemetryLocationMode => 'Telemetry Location Mode';

  @override
  String get settings_telemetryEnvironmentMode => 'Telemetry Environment Mode';

  @override
  String get settings_advertLocation => 'Advert Location';

  @override
  String get settings_advertLocationSubtitle => 'Include location in advert.';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'Auto Zero-Hop Advert On GPS Update';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'When GPS location changes, send a zero-hop advert (requires Advert Location).';

  @override
  String get settings_multiAck => 'Multi-ACKs';

  @override
  String get settings_telemetryModeUpdated => 'Telemetry mode updated';

  @override
  String get settings_actions => 'Actions';

  @override
  String get settings_deleteAllPaths => 'Delete All Paths';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Clear all path data from contacts.';

  @override
  String get settings_sendAdvertisement => 'Send Advertisement';

  @override
  String get settings_sendAdvertisementSubtitle => 'Broadcast presence now';

  @override
  String get settings_advertisementSent => 'Advertisement sent';

  @override
  String get settings_syncTime => 'Sync Time';

  @override
  String get settings_syncTimeSubtitle => 'Set device clock to phone time';

  @override
  String get settings_timeSynchronized => 'Time synchronized';

  @override
  String get settings_refreshContacts => 'Refresh Contacts';

  @override
  String get settings_refreshContactsSubtitle =>
      'Reload contact list from device';

  @override
  String get settings_rebootDevice => 'Reboot Device';

  @override
  String get settings_rebootDeviceSubtitle => 'Restart the MeshCore device';

  @override
  String get settings_rebootDeviceConfirm =>
      'Are you sure you want to reboot the device? You will be disconnected.';

  @override
  String get settings_debug => 'Debug';

  @override
  String get settings_companionDebugLog => 'Companion Debug Log';

  @override
  String get settings_companionDebugLogSubtitle =>
      'BLE/TCP/USB commands, responses, and raw data';

  @override
  String get settings_appDebugLog => 'App Debug Log';

  @override
  String get settings_appDebugLogSubtitle => 'Application debug messages';

  @override
  String get settings_about => 'About';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core Ham v$version';
  }

  @override
  String get settings_aboutLegalese =>
      'NOTORYX Core Ham • Built with open-source MeshCore Open components';

  @override
  String get settings_aboutDescription =>
      'NOTORYX Core Ham is a community-focused MeshCore companion app. It includes and builds on open-source components from MeshCore Open and other credited projects.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'LOS elevation data: Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => 'Name';

  @override
  String get settings_infoId => 'ID';

  @override
  String get settings_infoStatus => 'Status';

  @override
  String get settings_infoBattery => 'Battery';

  @override
  String get settings_infoPublicKey => 'Public Key';

  @override
  String get settings_infoContactsCount => 'Contacts Count';

  @override
  String get settings_infoChannelCount => 'Channel Count';

  @override
  String get settings_infoHardware => 'Hardware';

  @override
  String get settings_infoFirmware => 'Firmware';

  @override
  String get settings_presets => 'Presets';

  @override
  String get settings_frequency => 'Frequency (MHz)';

  @override
  String get settings_frequencyHelper => '420–450 / 902–928';

  @override
  String get settings_frequencyInvalid =>
      'Invalid frequency (420–450 / 902–928 MHz)';

  @override
  String get settings_bandwidth => 'Bandwidth';

  @override
  String get settings_spreadingFactor => 'Spreading Factor';

  @override
  String get settings_codingRate => 'Coding Rate';

  @override
  String get settings_txPower => 'TX Power (dBm)';

  @override
  String get settings_txPowerHelper => '0 - 22';

  @override
  String get settings_txPowerInvalid => 'Invalid TX power (0-22 dBm)';

  @override
  String get settings_clientRepeat => 'Off-Grid Repeat';

  @override
  String get settings_clientRepeatSubtitle =>
      'Allow this device to repeat mesh packets for others';

  @override
  String get settings_clientRepeatFreqWarning =>
      'Off-grid repeat requires 433, 869, or 918 MHz frequency';

  @override
  String settings_error(String message) {
    return 'Error: $message';
  }

  @override
  String get appSettings_title => 'App Settings';

  @override
  String get appSettings_appearance => 'Appearance';

  @override
  String get appSettings_theme => 'Theme';

  @override
  String get appSettings_themeSystem => 'System default';

  @override
  String get appSettings_themeLight => 'Light';

  @override
  String get appSettings_themeDark => 'Dark';

  @override
  String get appSettings_language => 'Language';

  @override
  String get appSettings_languageSystem => 'System default';

  @override
  String get appSettings_languageEn => 'English';

  @override
  String get appSettings_languageFr => 'Français';

  @override
  String get appSettings_languageEs => 'Español';

  @override
  String get appSettings_languageDe => 'Deutsch';

  @override
  String get appSettings_languagePl => 'Polski';

  @override
  String get appSettings_languageSl => 'Slovenščina';

  @override
  String get appSettings_languagePt => 'Português';

  @override
  String get appSettings_languageIt => 'Italiano';

  @override
  String get appSettings_languageZh => '中文';

  @override
  String get appSettings_languageSv => 'Svenska';

  @override
  String get appSettings_languageNl => 'Nederlands';

  @override
  String get appSettings_languageSk => 'Slovenčina';

  @override
  String get appSettings_languageBg => 'Български';

  @override
  String get appSettings_languageRu => 'Русский';

  @override
  String get appSettings_languageUk => 'Українська';

  @override
  String get repeater_pathHashModeOption0 => '0 - 1 byte';

  @override
  String get repeater_pathHashModeOption1 => '1 - 2 bytes';

  @override
  String get repeater_pathHashModeOption2 => '2 - 3 bytes';

  @override
  String get repeater_pathHashModeOption3 => '3 - 4 bytes';

  @override
  String get appSettings_enableMessageTracing => 'Enable Message Tracing';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'Show detailed routing and timing metadata for messages';

  @override
  String get appSettings_notifications => 'Notifications';

  @override
  String get appSettings_enableNotifications => 'Enable Notifications';

  @override
  String get appSettings_enableNotificationsSubtitle =>
      'Receive notifications for messages and adverts';

  @override
  String get appSettings_notificationPermissionDenied =>
      'Notification permission denied';

  @override
  String get appSettings_notificationsEnabled => 'Notifications enabled';

  @override
  String get appSettings_notificationsDisabled => 'Notifications disabled';

  @override
  String get appSettings_messageNotifications => 'Message Notifications';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      'Show notification when receiving new messages';

  @override
  String get appSettings_channelMessageNotifications =>
      'Channel Message Notifications';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'Show notification when receiving channel messages';

  @override
  String get appSettings_advertisementNotifications =>
      'Advertisement Notifications';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      'Show notification when new nodes are discovered';

  @override
  String get appSettings_messaging => 'Messaging';

  @override
  String get appSettings_clearPathOnMaxRetry => 'Clear Path on Max Retry';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      'Reset contact path after 5 failed send attempts';

  @override
  String get appSettings_pathsWillBeCleared =>
      'Paths will be cleared after 5 failed retries';

  @override
  String get appSettings_pathsWillNotBeCleared =>
      'Paths will not be auto-cleared';

  @override
  String get appSettings_autoRouteRotation => 'Auto Route Rotation';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      'Cycle between best paths and flood mode';

  @override
  String get appSettings_autoRouteRotationEnabled =>
      'Auto route rotation enabled';

  @override
  String get appSettings_autoRouteRotationDisabled =>
      'Auto route rotation disabled';

  @override
  String get appSettings_maxRouteWeight => 'Max Route Weight';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      'Maximum weight a path can accumulate from successful deliveries';

  @override
  String get appSettings_initialRouteWeight => 'Initial Route Weight';

  @override
  String get appSettings_initialRouteWeightSubtitle =>
      'Starting weight for newly discovered paths';

  @override
  String get appSettings_routeWeightSuccessIncrement =>
      'Success Weight Increment';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      'Weight added to a path after successful delivery';

  @override
  String get appSettings_routeWeightFailureDecrement =>
      'Failure Weight Decrement';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      'Weight removed from a path after failed delivery';

  @override
  String get appSettings_maxMessageRetries => 'Max Message Retries';

  @override
  String get appSettings_maxMessageRetriesSubtitle =>
      'Number of retry attempts before marking a message as failed';

  @override
  String get appSettings_battery => 'Battery';

  @override
  String get appSettings_batteryChemistry => 'Battery Chemistry';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return 'Set per device ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      'Connect to a device to choose';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3.0-4.2V)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2.6-3.65V)';

  @override
  String get appSettings_batteryLipo => 'LiPo (3.0-4.2V)';

  @override
  String get appSettings_batteryLipoHv => 'LiPo HV (3.0-4.35V)';

  @override
  String get appSettings_mapDisplay => 'Map Display';

  @override
  String get appSettings_showRepeaters => 'Show Repeaters';

  @override
  String get appSettings_showRepeatersSubtitle =>
      'Display repeater nodes on the map';

  @override
  String get appSettings_showChatNodes => 'Show Chat Nodes';

  @override
  String get appSettings_showChatNodesSubtitle =>
      'Display chat nodes on the map';

  @override
  String get appSettings_showOtherNodes => 'Show Other Nodes';

  @override
  String get appSettings_showOtherNodesSubtitle =>
      'Display other node types on the map';

  @override
  String get appSettings_timeFilter => 'Time Filter';

  @override
  String get appSettings_timeFilterShowAll => 'Show all nodes';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return 'Show nodes from last $hours hours';
  }

  @override
  String get appSettings_mapTimeFilter => 'Map Time Filter';

  @override
  String get appSettings_showNodesDiscoveredWithin =>
      'Show nodes discovered within:';

  @override
  String get appSettings_allTime => 'All time';

  @override
  String get appSettings_lastHour => 'Last hour';

  @override
  String get appSettings_last6Hours => 'Last 6 hours';

  @override
  String get appSettings_last24Hours => 'Last 24 hours';

  @override
  String get appSettings_lastWeek => 'Last week';

  @override
  String get appSettings_rasterTileSource => 'Raster Tile Source';

  @override
  String get appSettings_stadiaEndpoint => 'Stadia Endpoint';

  @override
  String get appSettings_stadiaApiKey => 'Stadia API Key';

  @override
  String get appSettings_stadiaApiKeyRequired =>
      'Required for Stadia Maps usage';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return 'Configured: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Enter your Stadia Maps API key. This app uses it for raster tile requests.';

  @override
  String get appSettings_offlineMapCache => 'Offline Map Cache';

  @override
  String get appSettings_unitsTitle => 'Units';

  @override
  String get appSettings_unitsMetric => 'Metric (m / km / °C)';

  @override
  String get appSettings_unitsImperial => 'Imperial (ft / mi / °F)';

  @override
  String get appSettings_noAreaSelected => 'No area selected';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'Area selected (zoom $minZoom-$maxZoom)';
  }

  @override
  String get appSettings_debugCard => 'Debug';

  @override
  String get appSettings_appDebugLogging => 'App Debug Logging';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'Log app debug messages for troubleshooting';

  @override
  String get appSettings_appDebugLoggingEnabled => 'App debug logging enabled';

  @override
  String get appSettings_appDebugLoggingDisabled =>
      'App debug logging disabled';

  @override
  String get contacts_title => 'Nodes';

  @override
  String get contacts_noContacts => 'No contacts yet';

  @override
  String get contacts_contactsWillAppear =>
      'Contacts will appear when devices advertise';

  @override
  String get contacts_unread => 'Unread';

  @override
  String get contacts_searchContactsNoNumber => 'Search Contacts...';

  @override
  String contacts_searchContacts(int number, String str) {
    return 'Search $number$str Contacts...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'Search $number$str Favorites...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'Search $number$str Users...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'Search $number$str Repeaters...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'Search $number$str Room servers...';
  }

  @override
  String get contacts_noUnreadContacts => 'No unread contacts';

  @override
  String get contacts_noContactsFound => 'No contacts or groups found';

  @override
  String get contacts_deleteContact => 'Delete Contact';

  @override
  String contacts_removeConfirm(String contactName) {
    return 'Remove $contactName from contacts?';
  }

  @override
  String get contacts_manageRepeater => 'Manage Repeater';

  @override
  String get contacts_manageRoom => 'Manage Room Server';

  @override
  String get contacts_roomLogin => 'Room Server Login';

  @override
  String get contacts_openChat => 'Open Chat';

  @override
  String get contacts_editGroup => 'Edit Group';

  @override
  String get contacts_deleteGroup => 'Delete Group';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return 'Remove \"$groupName\"?';
  }

  @override
  String get contacts_newGroup => 'New Group';

  @override
  String get contacts_moreOptions => 'More options';

  @override
  String get contacts_searchOpen => 'Search contacts';

  @override
  String get contacts_searchClose => 'Close search';

  @override
  String get contacts_groupName => 'Group name';

  @override
  String get contacts_groupNameRequired => 'Group name is required';

  @override
  String get contacts_groupNameReserved => 'This group name is reserved';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'Group \"$name\" already exists';
  }

  @override
  String get contacts_filterContacts => 'Filter contacts...';

  @override
  String get contacts_noContactsMatchFilter => 'No contacts match your filter';

  @override
  String get contacts_noMembers => 'No members';

  @override
  String get contacts_lastSeenNow => 'just now';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return '$minutes min ago';
  }

  @override
  String get contacts_lastSeenHourAgo => '1 hour ago';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return '$hours hours ago';
  }

  @override
  String get contacts_lastSeenDayAgo => '1 day ago';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return '$days days ago';
  }

  @override
  String get contact_info => 'Contact Info';

  @override
  String get contact_settings => 'Contact Settings';

  @override
  String get contact_telemetry => 'Telemetry';

  @override
  String get contact_lastSeen => 'Last seen';

  @override
  String get contact_clearChat => 'Clear Chat';

  @override
  String get contact_teleBase => 'Telemetry Base';

  @override
  String get contact_teleBaseSubtitle =>
      'Allow sharing battery level and basic telemetry';

  @override
  String get contact_teleLoc => 'Telemetry Location';

  @override
  String get contact_teleLocSubtitle => 'Allow sharing location data';

  @override
  String get contact_teleEnv => 'Telemetry Environment';

  @override
  String get contact_teleEnvSubtitle => 'Allow sharing environment sensor data';

  @override
  String get channels_title => 'Chats & Channels';

  @override
  String get channels_noChannelsConfigured => 'No channels configured';

  @override
  String get channels_addPublicChannel => 'Add Public Channel';

  @override
  String get channels_searchChannels => 'Search channels...';

  @override
  String get channels_noChannelsFound => 'No channels found';

  @override
  String channels_channelIndex(int index) {
    return 'Channel $index';
  }

  @override
  String get channels_public => 'Public';

  @override
  String channels_via(String path) {
    return 'via $path';
  }

  @override
  String get channels_viaMqtt => 'via MQTT';

  @override
  String get channels_viaMqttSemantics =>
      'Received via MQTT, not heard by your radio';

  @override
  String get channels_private => 'Keyed';

  @override
  String get channels_editChannel => 'Edit channel';

  @override
  String get channels_muteChannel => 'Mute channel';

  @override
  String get channels_unmuteChannel => 'Unmute channel';

  @override
  String get channels_deleteChannel => 'Delete channel';

  @override
  String channels_deleteChannelConfirm(String name) {
    return 'Delete \"$name\"? This cannot be undone.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'Failed to delete channel \"$name\"';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'Channel \"$name\" deleted';
  }

  @override
  String get channels_addChannel => 'Add Channel';

  @override
  String get channels_channelIndexLabel => 'Channel Index';

  @override
  String get channels_channelName => 'Channel Name';

  @override
  String get channels_usePublicChannel => 'Use Public Channel';

  @override
  String get channels_standardPublicPsk => 'Standard public PSK';

  @override
  String get channels_pskHex => 'PSK (Hex)';

  @override
  String get channels_generateRandomPsk => 'Generate random PSK';

  @override
  String get channels_enterChannelName => 'Please enter a channel name';

  @override
  String get channels_pskMustBe32Hex => 'PSK must be 32 hex characters';

  @override
  String channels_channelAdded(String name) {
    return 'Channel \"$name\" added';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'Edit Channel $index';
  }

  @override
  String get channels_smazCompression => 'SMAZ compression';

  @override
  String get channels_cyr2latCompression => 'Cyr2Lat compression';

  @override
  String get channels_cyr2latCompressionDscr =>
      'Replaces some Cyrillic characters with Latin characters when sending.';

  @override
  String get channels_cyr2latSettingsHeading => 'Cyr2Lat Setup';

  @override
  String get channels_cyr2latSettingsSubheading => 'List of replacements';

  @override
  String get channels_cyr2latSettingsDscr =>
      'Edit the JSON configuration of character replacement';

  @override
  String get channels_cyr2latSettingsDialogHint => 'JSON replacement map';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'Invalid JSON: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'Channel \"$name\" updated';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Add Cyr2Lat Profile';

  @override
  String get settings_cyr2latProfileName => 'Profile Name';

  @override
  String get settings_cyr2latProfileNameEmpty => 'Profile name cannot be empty';

  @override
  String get settings_cyr2latProfileAdded => 'Profile added successfully';

  @override
  String get settings_cyr2latProfileUpdated => 'Profile updated successfully';

  @override
  String get settings_cyr2latProfileEdit => 'Edit Cyr2Lat Profile';

  @override
  String get settings_cyr2latProfileDelete => 'Delete Cyr2Lat Profile';

  @override
  String get settings_cyr2latProfileDeleted => 'Profile deleted successfully';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return 'Are you sure you want to delete the profile \"$name\"?';
  }

  @override
  String get channels_publicChannelAdded => 'Public channel added';

  @override
  String get channels_sortBy => 'Sort by';

  @override
  String get channels_sortManual => 'Manual';

  @override
  String get channels_sortAZ => 'A-Z';

  @override
  String get channels_sortLatestMessages => 'Latest messages';

  @override
  String get channels_sortUnread => 'Unread';

  @override
  String get channels_createPrivateChannel => 'Create a keyed channel';

  @override
  String get channels_createPrivateChannelDesc =>
      'Uses a shared key to pick the channel. Messages are still readable by anyone.';

  @override
  String get channels_joinPrivateChannel => 'Join a keyed channel';

  @override
  String get channels_joinPrivateChannelDesc =>
      'Enter the channel\'s shared key.';

  @override
  String get channels_joinPublicChannel => 'Join the Public Channel';

  @override
  String get channels_joinPublicChannelDesc => 'Anyone can join this channel.';

  @override
  String get channels_joinHashtagChannel => 'Join a Hashtag Channel';

  @override
  String get channels_joinHashtagChannelDesc =>
      'Anyone can join hashtag channels.';

  @override
  String get channels_scanQrCode => 'Scan a QR Code';

  @override
  String get channels_scanQrCodeComingSoon => 'Coming soon';

  @override
  String get channels_enterHashtag => 'Enter hashtag';

  @override
  String get channels_hashtagHint => 'e.g. #team';

  @override
  String channels_regionSetTo(String region) {
    return 'Region: $region';
  }

  @override
  String get channels_regionNotSet => 'Region: none';

  @override
  String get channels_regionSelect_Title => 'Select a region';

  @override
  String get channels_clearRegion => 'Clear region';

  @override
  String get chat_noMessages => 'No messages yet';

  @override
  String get chat_sendMessage => 'Send message';

  @override
  String chat_sendMessageTo(String contactName) {
    return 'Send a message to $contactName';
  }

  @override
  String get chat_sendMessageToStart => 'Send a message to get started';

  @override
  String get chat_originalMessageNotFound => 'Original message not found';

  @override
  String chat_replyingTo(String name) {
    return 'Replying to $name';
  }

  @override
  String chat_replyTo(String name) {
    return 'Reply to $name';
  }

  @override
  String get chat_location => 'Location';

  @override
  String get chat_typeMessage => 'Type a message...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'Message too long (max $maxBytes bytes).';
  }

  @override
  String get chat_messageCopied => 'Message copied';

  @override
  String get chat_messageDeleted => 'Message deleted';

  @override
  String get chat_retryingMessage => 'Retrying message';

  @override
  String chat_retryCount(int current, int max) {
    return 'Retry $current/$max';
  }

  @override
  String get chat_selectSendAction => 'Select send action';

  @override
  String get chat_sendGif => 'Send GIF';

  @override
  String get chat_limitToArea => 'Limit to an area';

  @override
  String get chat_limitToAreaTitle => 'Only send within…';

  @override
  String get chat_limitToAreaHelp =>
      'Repeaters with flood corridor firmware only relay the message inside this area. Other repeaters drop it unless they allow your corridor region.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '$km km of you';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return 'Only within $km km of you';
  }

  @override
  String get chat_limitToAreaOff => 'No limit';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'Set your radio\'s position to limit messages to an area.';

  @override
  String get chat_sendImageLora => 'Send image via meshcore';

  @override
  String get chat_imagePickFailed => 'Couldn\'t open that image';

  @override
  String get chat_receivedGif => 'Received a GIF';

  @override
  String get chat_reply => 'Reply';

  @override
  String get chat_addReaction => 'Add Reaction';

  @override
  String get chat_me => 'Me';

  @override
  String get reaction_report => 'Emoji Reactions';

  @override
  String get emojiCategorySmileys => 'Smileys';

  @override
  String get emojiCategoryGestures => 'Gestures';

  @override
  String get emojiCategoryHearts => 'Hearts';

  @override
  String get emojiCategoryObjects => 'Objects';

  @override
  String get gifPicker_title => 'Choose a GIF';

  @override
  String get gifPicker_searchHint => 'Search GIFs...';

  @override
  String get gifPicker_poweredBy => 'Powered by GIPHY';

  @override
  String get gifPicker_noGifsFound => 'No GIFs found';

  @override
  String get gifPicker_failedLoad => 'Failed to load GIFs';

  @override
  String get gifPicker_failedSearch => 'Failed to search GIFs';

  @override
  String get gifPicker_noInternet => 'No internet connection';

  @override
  String get debugLog_appTitle => 'App Debug Log';

  @override
  String get debugLog_bleTitle => 'BLE Debug Log';

  @override
  String get debugLog_copyLog => 'Copy log';

  @override
  String get debugLog_clearLog => 'Clear log';

  @override
  String get debugLog_copied => 'Debug log copied';

  @override
  String get debugLog_bleCopied => 'BLE log copied';

  @override
  String get debugLog_noEntries => 'No debug logs yet';

  @override
  String get debugLog_enableInSettings =>
      'Enable app debug logging in settings';

  @override
  String get debugLog_frames => 'Frames';

  @override
  String get debugLog_rawLogRx => 'Raw Log-RX';

  @override
  String get debugLog_noBleActivity => 'No BLE activity yet';

  @override
  String debugFrame_length(int count) {
    return 'Frame Length: $count bytes';
  }

  @override
  String debugFrame_command(String value) {
    return 'Command: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'Text Message Frame:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- Destination PubKey: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- Timestamp: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- Flags: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- Text Type: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'CLI';

  @override
  String get debugFrame_textTypePlain => 'Plain';

  @override
  String debugFrame_text(String text) {
    return '- Text: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => 'Hex Dump:';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hops',
      one: 'hop',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => 'Remove path';

  @override
  String get chat_noPathHistoryYet =>
      'No path history yet.\nSend a message to discover paths.';

  @override
  String get chat_pathCleared =>
      'Path cleared. Next message will rediscover route.';

  @override
  String get chat_fullPath => 'Full Path';

  @override
  String get routing_title => 'Routing';

  @override
  String get routing_modeAuto => 'Auto';

  @override
  String get routing_modeFlood => 'Flood';

  @override
  String get routing_modeManual => 'Manual';

  @override
  String get routing_modeAutoHint =>
      'Picks the best known path automatically, flooding when none is known.';

  @override
  String get routing_modeFloodHint =>
      'Broadcasts through every repeater. Most reliable, but uses more airtime.';

  @override
  String get routing_modeManualHint =>
      'Always sends along the exact path you set.';

  @override
  String get routing_currentRoute => 'Current route';

  @override
  String get routing_directNoHops => 'Direct — no repeater hops';

  @override
  String get routing_noPathYet =>
      'No path yet. The next message floods until a route is discovered.';

  @override
  String get routing_floodBroadcast => 'Broadcast through every repeater';

  @override
  String get routing_editPath => 'Edit path';

  @override
  String get routing_forgetPath => 'Forget path';

  @override
  String get routing_knownPaths => 'Known paths';

  @override
  String get routing_knownPathsHint => 'Tap a path to switch to it.';

  @override
  String get routing_inUse => 'In use';

  @override
  String get routing_qualityStrong => 'Strong first hop';

  @override
  String get routing_qualityGood => 'Good first hop';

  @override
  String get routing_qualityFair => 'Fair first hop';

  @override
  String get routing_qualityWorked => 'Has delivered';

  @override
  String get routing_qualityFlood => 'Heard via flood';

  @override
  String get routing_qualityUntested => 'Untested';

  @override
  String routing_lastWorked(String when) {
    return 'worked $when';
  }

  @override
  String get routing_neverWorked => 'never confirmed';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes delivered, $failures failed';
  }

  @override
  String get routing_floodDelivery => 'Flood delivery';

  @override
  String get pathEditor_title => 'Build Path';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count of 64 hops';
  }

  @override
  String get pathEditor_noHops =>
      'No hops yet. Tap repeaters below to add them in order, or save with no hops to send direct.';

  @override
  String get pathEditor_addHops => 'Add hops in order';

  @override
  String get pathEditor_searchRepeaters => 'Search repeaters';

  @override
  String get pathEditor_advancedHex => 'Advanced: raw hex path';

  @override
  String get pathEditor_hexLabel => 'Hex prefixes';

  @override
  String get pathEditor_hexHelper =>
      'Two hex characters per hop, separated by commas';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return 'Invalid: $tokens';
  }

  @override
  String get pathEditor_tooManyHops => 'Maximum 64 hops';

  @override
  String get pathEditor_usePath => 'Use this path';

  @override
  String get pathEditor_removeHop => 'Remove hop';

  @override
  String get pathEditor_unknownHop => 'Unknown repeater';

  @override
  String get chat_pathSavedLocally => 'Saved locally. Connect to sync.';

  @override
  String get chat_pathDeviceConfirmed => 'Device confirmed.';

  @override
  String get chat_pathDeviceNotConfirmed => 'Device not confirmed yet.';

  @override
  String get chat_type => 'Type';

  @override
  String get chat_path => 'Path';

  @override
  String get chat_publicKey => 'Public Key';

  @override
  String get chat_compressOutgoingMessages => 'Compress outgoing messages';

  @override
  String get chat_floodForced => 'Flood (forced)';

  @override
  String get chat_directForced => 'Direct (forced)';

  @override
  String chat_hopsForced(int count) {
    return '$count hops (forced)';
  }

  @override
  String get chat_floodAuto => 'Flood (auto)';

  @override
  String get chat_direct => 'Direct';

  @override
  String get chat_poiShared => 'POI Shared';

  @override
  String chat_unread(int count) {
    return 'Unread: $count';
  }

  @override
  String get chat_markAsUnread => 'Mark as Unread';

  @override
  String get chat_newMessages => 'New messages';

  @override
  String get chat_openLink => 'Open Link?';

  @override
  String get chat_openLinkConfirmation =>
      'Do you want to open this link in your browser?';

  @override
  String get chat_open => 'Open';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'Could not open link: $url';
  }

  @override
  String get chat_invalidLink => 'Invalid link format';

  @override
  String get map_title => 'Node Map';

  @override
  String get map_searchHint => 'Search node name or ID';

  @override
  String get map_activity => 'Activity';

  @override
  String get map_online => 'Online';

  @override
  String get map_recent => 'Recent';

  @override
  String get map_stale => 'Stale';

  @override
  String get map_visible => 'Visible';

  @override
  String get map_hidden => 'Hidden';

  @override
  String get map_centerOnNode => 'Center on node';

  @override
  String get map_details => 'Details';

  @override
  String get map_noGps => 'No GPS';

  @override
  String get map_noResults => 'No matching nodes';

  @override
  String get map_lineOfSight => 'Line of Sight';

  @override
  String get map_losScreenTitle => 'Line of Sight';

  @override
  String get map_noNodesWithLocation => 'No nodes with location data';

  @override
  String get map_nodesNeedGps =>
      'Nodes need to share their GPS coordinates\nto appear on the map';

  @override
  String map_nodesCount(int count) {
    return 'Nodes: $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'Pins: $count';
  }

  @override
  String get map_chat => 'Chat';

  @override
  String get map_repeater => 'Repeater';

  @override
  String get map_room => 'Room';

  @override
  String get map_sensor => 'Sensor';

  @override
  String get map_pinDm => 'Pin (DM)';

  @override
  String get map_pinPrivate => 'Pin (Private)';

  @override
  String get map_pinPublic => 'Pin (Public)';

  @override
  String get map_lastSeen => 'Last Seen';

  @override
  String get map_disconnectConfirm =>
      'Are you sure you want to disconnect from this device?';

  @override
  String get map_from => 'From';

  @override
  String get map_source => 'Source';

  @override
  String get map_flags => 'Flags';

  @override
  String get map_type => 'Type';

  @override
  String get map_path => 'Path';

  @override
  String get map_location => 'Location';

  @override
  String get map_estLocation => 'Est. Location';

  @override
  String get map_publicKey => 'Public Key';

  @override
  String get map_publicKeyPrefixHint => 'e.g. ab12';

  @override
  String get map_shareMarkerHere => 'Share marker here';

  @override
  String get map_setAsMyLocation => 'Set as my location';

  @override
  String get floodCorridor_title => 'Flood Corridor';

  @override
  String get floodCorridor_previewToHere => 'Preview flood corridor to here';

  @override
  String get floodCorridor_requesting => 'Asking your radio for a corridor…';

  @override
  String get floodCorridor_unsupported =>
      'Your radio\'s firmware doesn\'t support flood corridors.';

  @override
  String get floodCorridor_noProposal =>
      'Your radio couldn\'t propose a corridor. Make sure it has a position set.';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count circles',
      one: '1 circle',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return '$inside of $total known repeaters inside';
  }

  @override
  String get floodCorridor_straightLine =>
      'Straight line: no known repeaters along the way';

  @override
  String get floodCorridor_followsRepeaters => 'Follows your known repeaters';

  @override
  String get floodCorridor_horizonLimited =>
      'Known repeaters don\'t reach the target; the rest is a straight line';

  @override
  String get floodCorridor_thinStretch =>
      'Part of the corridor has few known repeaters';

  @override
  String get floodCorridor_moreCoverage => 'Require more repeater coverage';

  @override
  String get floodCorridor_previewNote =>
      'Preview only. Repeaters without corridor firmware don\'t apply corridors.';

  @override
  String get map_pinLabel => 'Pin label';

  @override
  String get map_label => 'Label';

  @override
  String get map_pointOfInterest => 'Point of interest';

  @override
  String get map_sendToContact => 'Send to contact';

  @override
  String get map_sendToChannel => 'Send to channel';

  @override
  String get map_noChannelsAvailable => 'No channels available';

  @override
  String get map_publicLocationShare => 'Public location share';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return 'You are about to share a location in $channelLabel. This channel is public and anyone with the PSK can see it.';
  }

  @override
  String get map_connectToShareMarkers =>
      'Connect to a device to share markers';

  @override
  String get map_filterNodes => 'Filter Nodes';

  @override
  String get map_nodeTypes => 'Node Types';

  @override
  String get map_chatNodes => 'Chat Nodes';

  @override
  String get map_repeaters => 'Repeaters';

  @override
  String get map_otherNodes => 'Other Nodes';

  @override
  String get map_showOverlaps => 'Repeater Key Overlaps';

  @override
  String get map_keyPrefix => 'Key Prefix';

  @override
  String get map_filterByKeyPrefix => 'Filter by key prefix';

  @override
  String get map_publicKeyPrefix => 'Public key prefix';

  @override
  String get map_markers => 'Markers';

  @override
  String get map_showSharedMarkers => 'Show shared markers';

  @override
  String get map_showGuessedLocations => 'Show guessed node locations';

  @override
  String get map_showDiscoveryContacts => 'Show Discovery Contacts';

  @override
  String get map_guessedLocation => 'Guessed location';

  @override
  String get map_lastSeenTime => 'Last Seen Time';

  @override
  String get map_sharedPin => 'Shared pin';

  @override
  String get map_sharedAt => 'Shared';

  @override
  String get map_joinRoom => 'Join Room';

  @override
  String get map_manageRepeater => 'Manage Repeater';

  @override
  String get map_tapToAdd => 'Tap on nodes to add them to the path.';

  @override
  String get map_runTrace => 'Run path trace';

  @override
  String get map_runTraceWithReturnPath => 'Return back on the same path.';

  @override
  String get map_removeLast => 'Remove Last';

  @override
  String get map_pathTraceCancelled => 'Path trace cancelled.';

  @override
  String get mapCache_title => 'Offline Map Cache';

  @override
  String get mapCache_selectAreaFirst => 'Select an area to cache first';

  @override
  String get mapCache_noTilesToDownload => 'No tiles to download for this area';

  @override
  String get mapCache_downloadTilesTitle => 'Download tiles';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return 'Download $count tiles for offline use?';
  }

  @override
  String get mapCache_downloadAction => 'Download';

  @override
  String mapCache_cachedTiles(int count) {
    return 'Cached $count tiles';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return 'Cached $downloaded tiles ($failed failed)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => 'Clear offline cache';

  @override
  String get mapCache_clearOfflineCachePrompt => 'Remove all cached map tiles?';

  @override
  String get mapCache_offlineCacheCleared => 'Offline cache cleared';

  @override
  String get mapCache_noAreaSelected => 'No area selected';

  @override
  String get mapCache_cacheArea => 'Cache Area';

  @override
  String get mapCache_useCurrentView => 'Use Current View';

  @override
  String get mapCache_zoomRange => 'Zoom Range';

  @override
  String mapCache_estimatedTiles(int count) {
    return 'Estimated tiles: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return 'Downloaded $completed / $total';
  }

  @override
  String get mapCache_downloadTilesButton => 'Download Tiles';

  @override
  String get mapCache_clearCacheButton => 'Clear Cache';

  @override
  String mapCache_failedDownloads(int count) {
    return 'Failed downloads: $count';
  }

  @override
  String get mapCache_cachedTilesLabel => 'Cached tiles';

  @override
  String get mapCache_cachedTileSummaryLabel => 'Cached tile summary';

  @override
  String mapCache_bulkDownloadDisabledForSource(String source) {
    return 'Offline bulk downloads are disabled for $source.';
  }

  @override
  String mapCache_bulkDownloadDisabledInConfig(String source) {
    return 'Offline bulk downloads are disabled for $source in this app configuration.';
  }

  @override
  String mapCache_summarySource(String source) {
    return 'Source: $source';
  }

  @override
  String mapCache_summaryCachedTilesForSource(int count) {
    return 'Cached tiles for source: $count';
  }

  @override
  String mapCache_summaryCachedInSelection(int count) {
    return 'Cached in selected area/zoom: $count';
  }

  @override
  String mapCache_summaryApproxCacheSize(String size) {
    return 'Approx cache size: $size';
  }

  @override
  String mapCache_boundsLabel(
    String north,
    String south,
    String east,
    String west,
  ) {
    return 'N $north, S $south, E $east, W $west';
  }

  @override
  String get time_justNow => 'Just now';

  @override
  String time_minutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String time_hoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String time_daysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String get time_hour => 'hour';

  @override
  String get time_hours => 'hours';

  @override
  String get time_day => 'day';

  @override
  String get time_days => 'days';

  @override
  String get time_week => 'week';

  @override
  String get time_weeks => 'weeks';

  @override
  String get time_month => 'month';

  @override
  String get time_months => 'months';

  @override
  String get time_minutes => 'minutes';

  @override
  String get time_allTime => 'All Time';

  @override
  String get dialog_disconnect => 'Disconnect';

  @override
  String get dialog_disconnectConfirm =>
      'Are you sure you want to disconnect from this device?';

  @override
  String get login_repeaterLogin => 'Repeater Login';

  @override
  String get login_roomLogin => 'Room Server Login';

  @override
  String get login_password => 'Password';

  @override
  String get login_enterPassword => 'Enter password';

  @override
  String get login_savePassword => 'Save password';

  @override
  String get login_savePasswordSubtitle =>
      'Password will be stored securely on this device';

  @override
  String get login_repeaterDescription =>
      'Enter the repeater password for guest or admin access.';

  @override
  String get login_roomDescription =>
      'Enter the room password for guest or admin access.';

  @override
  String get login_routing => 'Routing';

  @override
  String get login_routingMode => 'Routing mode';

  @override
  String get login_autoUseSavedPath => 'Auto (use saved path)';

  @override
  String get login_forceFloodMode => 'Force Flood Mode';

  @override
  String get login_managePaths => 'Manage Paths';

  @override
  String get login_login => 'Login';

  @override
  String login_attempt(int current, int max) {
    return 'Attempt $current/$max';
  }

  @override
  String login_failed(String error) {
    return 'Login failed: $error';
  }

  @override
  String get login_failedMessage =>
      'Login failed. Either the password is incorrect or the repeater is unreachable.';

  @override
  String get common_reload => 'Reload';

  @override
  String get common_clear => 'Clear';

  @override
  String get path_currentPathLabel => 'Current path';

  @override
  String get path_noRepeatersFound => 'No repeaters or room servers found.';

  @override
  String get repeater_management => 'Repeater Management';

  @override
  String get room_management => 'Room Server Management';

  @override
  String get repeater_guest => 'Repeater Information';

  @override
  String get room_guest => 'Room Server Information';

  @override
  String get repeater_managementTools => 'Management Tools';

  @override
  String get repeater_guestTools => 'Guest Tools';

  @override
  String get repeater_status => 'Status';

  @override
  String get repeater_statusSubtitle =>
      'View repeater status, stats, and neighbors';

  @override
  String get repeater_telemetry => 'Telemetry';

  @override
  String get repeater_telemetrySubtitle =>
      'View telemetry of sensors and system stats';

  @override
  String get repeater_cli => 'CLI';

  @override
  String get repeater_cliSubtitle => 'Send commands to the repeater';

  @override
  String get repeater_neighbors => 'Neighbors';

  @override
  String get repeater_neighborsSubtitle => 'View zero hop neighbors.';

  @override
  String get repeater_settings => 'Settings';

  @override
  String get repeater_settingsSubtitle => 'Configure repeater parameters';

  @override
  String get repeater_clockSyncAfterLogin => 'Clock sync after login';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      'Automatically send \"clock sync\" after a successful login';

  @override
  String get repeater_statusTitle => 'Repeater Status';

  @override
  String get repeater_routingMode => 'Routing mode';

  @override
  String get repeater_refresh => 'Refresh';

  @override
  String get repeater_statusRequestTimeout => 'Status request timed out.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'Error loading status: $error';
  }

  @override
  String get repeater_systemInformation => 'System Information';

  @override
  String get repeater_battery => 'Battery';

  @override
  String get repeater_clockAtLogin => 'Clock (at login)';

  @override
  String get repeater_uptime => 'Uptime';

  @override
  String get repeater_queueLength => 'Queue Length';

  @override
  String get repeater_debugFlags => 'Debug Flags';

  @override
  String get repeater_radioStatistics => 'Radio Statistics';

  @override
  String get repeater_lastRssi => 'Last RSSI';

  @override
  String get repeater_lastSnr => 'Last SNR';

  @override
  String get repeater_noiseFloor => 'Noise Floor';

  @override
  String get repeater_txAirtime => 'TX Airtime';

  @override
  String get repeater_rxAirtime => 'RX Airtime';

  @override
  String get repeater_chanUtil => 'Channel Utilization';

  @override
  String get repeater_packetStatistics => 'Packet Statistics';

  @override
  String get repeater_sent => 'Sent';

  @override
  String get repeater_received => 'Received';

  @override
  String get repeater_duplicates => 'Duplicates';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days days ${hours}h ${minutes}m ${seconds}s';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return 'Total: $total, Flood: $flood, Direct: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return 'Total: $total, Flood: $flood, Direct: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return 'Flood: $flood, Direct: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return 'Total: $total';
  }

  @override
  String get repeater_settingsTitle => 'Repeater Settings';

  @override
  String get repeater_basicSettings => 'Basic Settings';

  @override
  String get repeater_repeaterName => 'Repeater Name';

  @override
  String get repeater_repeaterNameHelper => 'Display name for this repeater';

  @override
  String get repeater_adminPassword => 'Admin Password';

  @override
  String get repeater_adminPasswordHelper => 'Full access password';

  @override
  String get repeater_guestPassword => 'Guest Password';

  @override
  String get repeater_guestPasswordHelper => 'Read-only access password';

  @override
  String get repeater_radioSettings => 'Radio Settings';

  @override
  String get repeater_frequencyMhz => 'Frequency (MHz)';

  @override
  String get repeater_frequencyHelper => '420–450 / 902–928 MHz';

  @override
  String get repeater_txPower => 'TX Power';

  @override
  String get repeater_txPowerHelper => '1-30 dBm';

  @override
  String get repeater_bandwidth => 'Bandwidth';

  @override
  String get repeater_spreadingFactor => 'Spreading Factor';

  @override
  String get repeater_codingRate => 'Coding Rate';

  @override
  String get repeater_locationSettings => 'Location Settings';

  @override
  String get repeater_latitude => 'Latitude';

  @override
  String get repeater_latitudeHelper => 'Decimal degrees (e.g., 37.7749)';

  @override
  String get repeater_longitude => 'Longitude';

  @override
  String get repeater_longitudeHelper => 'Decimal degrees (e.g., -122.4194)';

  @override
  String get repeater_features => 'Features';

  @override
  String get repeater_packetForwarding => 'Packet Forwarding';

  @override
  String get repeater_packetForwardingSubtitle =>
      'Enable repeater to forward packets';

  @override
  String get repeater_guestAccess => 'Guest Access';

  @override
  String get repeater_guestAccessSubtitle => 'Allow read-only guest access';

  @override
  String get repeater_privacyMode => 'Privacy Mode';

  @override
  String get repeater_privacyModeSubtitle =>
      'Hide name/location in advertisements';

  @override
  String get repeater_advertisementSettings => 'Advertisement Settings';

  @override
  String get repeater_localAdvertInterval => 'Local Advertisement Interval';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes minutes';
  }

  @override
  String get repeater_floodAdvertInterval => 'Flood Advertisement Interval';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours hours';
  }

  @override
  String get repeater_encryptedAdvertInterval =>
      'Encrypted Advertisement Interval';

  @override
  String get repeater_dangerZone => 'Danger Zone';

  @override
  String get repeater_rebootRepeater => 'Reboot Repeater';

  @override
  String get repeater_rebootRepeaterSubtitle => 'Restart the repeater device';

  @override
  String get repeater_rebootRepeaterConfirm =>
      'Are you sure you want to reboot this repeater?';

  @override
  String get repeater_regenerateIdentityKey => 'Regenerate Identity Key';

  @override
  String get repeater_regenerateIdentityKeySubtitle =>
      'Generate new public/private key pair';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'This will generate a new identity for the repeater. Continue?';

  @override
  String get repeater_eraseFileSystem => 'Erase File System';

  @override
  String get repeater_eraseFileSystemSubtitle =>
      'Format the repeater file system';

  @override
  String get repeater_eraseFileSystemConfirm =>
      'WARNING: This will erase all data on the repeater. This cannot be undone!';

  @override
  String get repeater_eraseSerialOnly =>
      'Erase is only available over serial console.';

  @override
  String repeater_commandSent(String command) {
    return 'Command sent: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'Error sending command: $error';
  }

  @override
  String get repeater_confirm => 'Confirm';

  @override
  String get repeater_settingsSaved => 'Settings saved successfully';

  @override
  String get repeater_rxGain => 'Boosted RX gain';

  @override
  String get repeater_rxGainHelper =>
      'Higher sensitivity, more current draw (SX1262/SX1268 only)';

  @override
  String get repeater_refreshRxGain => 'Refresh boosted RX gain';

  @override
  String get repeater_multiAcks => 'Multi-ACKs';

  @override
  String get repeater_multiAcksSubtitle =>
      'Acknowledge messages over multiple paths for better delivery';

  @override
  String get repeater_refreshMultiAcks => 'Refresh multi-ACKs';

  @override
  String get repeater_networkHealth => 'Network health';

  @override
  String get repeater_loopDetect => 'Loop detection';

  @override
  String get repeater_loopDetectHelper =>
      'Drop flood packets that look like routing loops';

  @override
  String get repeater_loopDetectOff => 'Off';

  @override
  String get repeater_loopDetectMinimal => 'Minimal';

  @override
  String get repeater_loopDetectModerate => 'Moderate';

  @override
  String get repeater_loopDetectStrict => 'Strict';

  @override
  String get repeater_dutyCycle => 'Duty cycle';

  @override
  String get repeater_dutyCycleHelper => 'Maximum percentage of airtime';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => 'Operator info';

  @override
  String get repeater_ownerInfoHelper => 'Public metadata for this repeater';

  @override
  String get repeater_refreshOwnerInfo => 'Refresh operator info';

  @override
  String get repeater_floodMax => 'Flood max hops';

  @override
  String get repeater_floodMaxHelper =>
      'Maximum hops a flood packet may travel (0-64)';

  @override
  String get repeater_advancedSettings => 'Advanced';

  @override
  String get repeater_advancedSettingsSubtitle =>
      'Tuning knobs for experienced operators';

  @override
  String get repeater_pathHashMode => 'Path hash mode';

  @override
  String get repeater_pathHashModeHelper =>
      'Bytes used to encode this repeater\'s ID in flood path/loop-detect tags. 0=1 byte (256 IDs, up to 64 hops), 1=2 bytes (65K IDs, up to 32 hops), 2=3 bytes (16M IDs, up to 21 hops). Firmware before v1.14 always used 1-byte paths; v1.14 and newer can be configured for 2- or 3-byte paths.';

  @override
  String get repeater_keySettings => 'Change Identity Keys';

  @override
  String get repeater_keySettingsSubtitle =>
      'Change the public/private keypair';

  @override
  String get repeater_prvKey => 'Private key';

  @override
  String get repeater_prvKeyHelper =>
      'A new private key for the repeater, a 128-character hex string.';

  @override
  String get repeater_generatePrvKey => 'Generate a random keypair';

  @override
  String get repeater_stopGeneratingPrvKey => 'Interrupt search for keypair';

  @override
  String get repeater_pubKey => 'Public key';

  @override
  String get repeater_pubKeyHelper =>
      'This is the public key that goes with the generated private key. You can\'t set this directly.';

  @override
  String get repeater_pubKeyPrefix => 'Desired prefix';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'Find a public key that starts with these hex digits. Expected tries needed: $tries.';
  }

  @override
  String get repeater_txDelay => 'Flood TX delay';

  @override
  String get repeater_txDelayHelper =>
      'Retransmit spacing for flood traffic, as a multiplier of the packet\'s airtime (0-2, default 0.5). Higher = fewer collisions but slower delivery.';

  @override
  String get repeater_directTxDelay => 'Direct TX delay';

  @override
  String get repeater_directTxDelayHelper =>
      'Retransmit spacing for direct (non-flood) traffic, as a multiplier of the packet\'s airtime (0-2, default 0.3).';

  @override
  String get repeater_intThresh => 'Interference threshold';

  @override
  String get repeater_intThreshHelper =>
      'Threshold passed to the radio\'s noise-floor calibration so it rejects interference above this level. 0 disables — only raise if you see RX errors in a noisy band.';

  @override
  String get repeater_agcResetInterval => 'AGC reset interval';

  @override
  String get repeater_agcResetIntervalHelper =>
      'How often to reset the radio\'s automatic gain control to recover from a stuck gain state. Seconds, snapped down to a multiple of 4. 0 disables periodic resets.';

  @override
  String get repeater_actionsTitle => 'Actions';

  @override
  String get repeater_sendAdvert => 'Send flood advert';

  @override
  String get repeater_sendAdvertSubtitle =>
      'Broadcast a flood advert through the network';

  @override
  String get repeater_sendAdvertZeroHop => 'Send zero-hop advert';

  @override
  String get repeater_sendAdvertZeroHopSubtitle =>
      'Broadcast a one-hop advert (no relays)';

  @override
  String get repeater_clockSync => 'Sync clock now';

  @override
  String get repeater_clockSyncSubtitle =>
      'Push your phone\'s time to the repeater';

  @override
  String repeater_actionSucceeded(String action) {
    return '$action succeeded';
  }

  @override
  String repeater_actionFailed(String action, String error) {
    return '$action failed: $error';
  }

  @override
  String get repeater_settingsSavedRebootNeeded =>
      'Settings saved — reboot the repeater to apply';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return 'Some settings failed: $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return 'Error saving settings: $error';
  }

  @override
  String get repeater_refreshBasicSettings => 'Refresh Basic Settings';

  @override
  String get repeater_refreshRadioSettings => 'Refresh Radio Settings';

  @override
  String get repeater_refreshTxPower => 'Refresh TX power';

  @override
  String get repeater_refreshPacketForwarding => 'Refresh Packet Forwarding';

  @override
  String get repeater_refreshGuestAccess => 'Refresh Guest Access';

  @override
  String get repeater_refreshPrivacyMode => 'Refresh Privacy Mode';

  @override
  String repeater_refreshed(String label) {
    return '$label refreshed';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return 'Error refreshing $label';
  }

  @override
  String get repeater_cliTitle => 'Repeater CLI';

  @override
  String get repeater_debugNextCommand => 'Debug Next Command';

  @override
  String get repeater_commandHelp => 'Command Help';

  @override
  String get repeater_clearHistory => 'Clear History';

  @override
  String get repeater_noCommandsSent => 'No commands sent yet';

  @override
  String get repeater_typeCommandOrUseQuick =>
      'Type a command below or use quick commands';

  @override
  String get repeater_enterCommandHint => 'Enter command...';

  @override
  String get repeater_previousCommand => 'Previous command';

  @override
  String get repeater_nextCommand => 'Next command';

  @override
  String get repeater_enterCommandFirst => 'Enter a command first';

  @override
  String get repeater_cliCommandFrameTitle => 'CLI Command Frame';

  @override
  String repeater_cliCommandError(String error) {
    return 'Error: $error';
  }

  @override
  String get repeater_cliQuickGetName => 'Get Name';

  @override
  String get repeater_cliQuickGetRadio => 'Get Radio';

  @override
  String get repeater_cliQuickGetTx => 'Get TX';

  @override
  String get repeater_cliQuickNeighbors => 'Neighbors';

  @override
  String get repeater_cliQuickVersion => 'Version';

  @override
  String get repeater_cliQuickAdvertise => 'Advertise';

  @override
  String get repeater_cliQuickClock => 'Clock';

  @override
  String get repeater_cliQuickClockSync => 'Clock Sync';

  @override
  String get repeater_cliQuickDiscovery => 'Discover Neighbors';

  @override
  String get repeater_cliHelpAdvert => 'Sends an advertisement packet';

  @override
  String get repeater_cliHelpReboot =>
      'Reboots the device. (note, you\'ll prob get \'Timeout\' which is normal)';

  @override
  String get repeater_cliHelpClock =>
      'Displays current time per device\'s clock.';

  @override
  String get repeater_cliHelpPassword =>
      'Sets a new admin password for the device.';

  @override
  String get repeater_cliHelpVersion =>
      'Shows the device version and firmware build date.';

  @override
  String get repeater_cliHelpClearStats =>
      'Resets various stats counters to zero.';

  @override
  String get repeater_cliHelpSetAf => 'Sets the air-time-factor.';

  @override
  String get repeater_cliHelpSetTx =>
      'Sets LoRa transmit power in dBm. (reboot to apply)';

  @override
  String get repeater_cliHelpSetRepeat =>
      'Enables or disables the repeater role for this node.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(Room server) If \'on\', then login in blank password will be allowed, but cannot Post to room. (just read only)';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'Sets the maximum number of hops of inbound flood packet (if >= max, packet is not forwarded)';

  @override
  String get repeater_cliHelpSetIntThresh =>
      'Sets the Interference Threshold (in DB). Default is 14. Set to 0 to disable channel interference detection.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'Sets the interval to reset the Auto Gain Controller. Set to 0 to disable.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      'Enables or disables the \'double ACKs\' feature.';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'Sets the timer interval in minutes to send a local (zero-hop) advertisement packet. Set to 0 to disable.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'Sets the timer interval in hours to send a flood advertisement packet. Set to 0 to disable.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'Sets/updates the guest password. (for repeaters, guest logins can send the \"Get Stats\" request)';

  @override
  String get repeater_cliHelpSetName => 'Sets the advertisement name.';

  @override
  String get repeater_cliHelpSetLat =>
      'Sets the advertisement map latitude. (decimal degrees)';

  @override
  String get repeater_cliHelpSetLon =>
      'Sets the advertisement map longitude. (decimal degrees)';

  @override
  String get repeater_cliHelpSetRadio =>
      'Sets completely new radio params, and saves to preferences. Requires a \"reboot\" command to apply.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      'Sets (experimental) base (must be > 1 for effect) for applying slight delay to received packets, based on signal strength/score. Set to 0 to disable.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      'Sets a factor multiplied with time-on-air for a flood-mode packet and with a randomized slot system, to delay its forwarding. (to decrease likelihood of collisions)';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'Same as txdelay, but for applying a random delay to the forwarding of direct-mode packets.';

  @override
  String get repeater_cliHelpSetBridgeEnabled => 'Enable/Disable bridge.';

  @override
  String get repeater_cliHelpSetBridgeDelay =>
      'Set delay before retransmitting packets.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      'Choose wether the bridge will retransmit received packets or transmitted packets.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'Set serial link baudrate for rs232 bridges.';

  @override
  String get repeater_cliHelpSetBridgeSecret =>
      'Set bridge secret for espnow bridges.';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      'Sets custom factor to adjust reported battery voltage (only supported on select boards).';

  @override
  String get repeater_cliHelpTempRadio =>
      'Sets temporary radio params for the given number of minutes, reverting to original radio params afterward. (does NOT save to preferences).';

  @override
  String get repeater_cliHelpSetPerm =>
      'Modifies the ACL. Removes matching entry (by pubkey prefix) if \"permissions\" is zero. Adds new entry if pubkey-hex is full length and is not currently in ACL. Updates entry by matching pubkey prefix. Permission bits vary per firmware role, but low 2 bits are: 0 (Guest), 1 (Read only), 2 (Read write), 3 (Admin)';

  @override
  String get repeater_cliHelpGetBridgeType =>
      'Gets bridge type none, rs232, espnow';

  @override
  String get repeater_cliHelpLogStart =>
      'Starts packet logging to file system.';

  @override
  String get repeater_cliHelpLogStop => 'Stops packet logging to file system.';

  @override
  String get repeater_cliHelpLogErase =>
      'Erases the packet logs from file system.';

  @override
  String get repeater_cliHelpNeighbors =>
      'Shows a list of other repeater nodes heard via zero-hop adverts. Each line is id-prefix-hex:timestamp:snr-times-4';

  @override
  String get repeater_cliHelpNeighborRemove =>
      'Removes first matching entry (by pubkey prefix (hex)), from neighbors list.';

  @override
  String get repeater_cliHelpRegion =>
      '(serial only) Lists all defined regions and current flood permissions.';

  @override
  String get repeater_cliHelpRegionLoad =>
      'NOTE: this is a special multi-command invocation. Each subsequent command is a region name (indented with spaces to indicate parent hierarchy, with one space at minimum). Terminated by sending a blank line/command.';

  @override
  String get repeater_cliHelpRegionGet =>
      'Searches for region with given name prefix (or \"*\" for the global scope). Replies with \"-> region-name (parent-name) \'F\'\"';

  @override
  String get repeater_cliHelpRegionPut =>
      'Adds or updates a region definition with given name.';

  @override
  String get repeater_cliHelpRegionRemove =>
      'Removes a region definition with given name. (must match exactly, and have no child regions)';

  @override
  String get repeater_cliHelpRegionAllowf =>
      'Sets the \'F\'lood permission for the given region. (\'*\' for the global/legacy scope)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      'Removes the \'F\'lood permission for the given region. (NOTE: at this stage NOT advised to use this on the global/legacy scope!!)';

  @override
  String get repeater_cliHelpRegionHome =>
      'Replies with the current \'home\' region. (Note applied anywhere yet, reserved for future)';

  @override
  String get repeater_cliHelpRegionHomeSet => 'Sets the \'home\' region.';

  @override
  String get repeater_cliHelpRegionSave =>
      'Persists the region list/map to storage.';

  @override
  String get repeater_cliHelpGps =>
      'Gives status of gps. When gps is off, it replies only off, if on it replies with on, status, fix, sat count';

  @override
  String get repeater_cliHelpGpsOnOff => 'Toggles gps power state.';

  @override
  String get repeater_cliHelpGpsSync => 'Syncs node time with gps clock.';

  @override
  String get repeater_cliHelpGpsSetLoc =>
      'Sets node\'s position to gps coordinates and save preferences.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'Gives location advert configuration of the node:\n- none: don\'t include location in adverts\n- share: share gps location (from SensorManager)\n- prefs: advert the location stored in preferences';

  @override
  String get repeater_cliHelpGpsAdvertSet =>
      'Sets location advert configuration.';

  @override
  String get repeater_commandsListTitle => 'Commands List';

  @override
  String get repeater_commandsListNote =>
      'NOTE: for the various \"set ...\" commands, there is also a \"get ...\" command.';

  @override
  String get repeater_general => 'General';

  @override
  String get repeater_settingsCategory => 'Settings';

  @override
  String get repeater_bridge => 'Bridge';

  @override
  String get repeater_logging => 'Logging';

  @override
  String get repeater_neighborsRepeaterOnly => 'Neighbors (Repeater only)';

  @override
  String get repeater_regionManagementRepeaterOnly =>
      'Region Management (Repeater only)';

  @override
  String get repeater_regionNote =>
      'Region commands have been introduced to manage region definitions and permissions.';

  @override
  String get repeater_gpsManagement => 'GPS Management';

  @override
  String get repeater_gpsNote =>
      'gps command has been introduced to manage location related topics.';

  @override
  String get repeater_getCategory => 'Get Values';

  @override
  String get repeater_powerMgmt => 'Power Management';

  @override
  String get repeater_sensors => 'Sensors';

  @override
  String get repeater_cliHelpPowerOff =>
      'Powers the device off. (no response expected)';

  @override
  String get repeater_cliHelpClkReboot =>
      'Resets the clock to a known epoch and reboots the device.';

  @override
  String get repeater_cliHelpAdvertZeroHop =>
      'Sends a zero-hop advertisement (immediate neighbors only).';

  @override
  String get repeater_cliHelpStartOta =>
      'Starts an over-the-air firmware update on supported boards.';

  @override
  String get repeater_cliHelpTime =>
      'Sets the device clock to the given Unix epoch seconds. Clock cannot move backwards.';

  @override
  String get repeater_cliHelpBoard =>
      'Shows the board manufacturer / hardware identifier.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      'Sends a node-discovery request to nearby neighbors. (Repeater only)';

  @override
  String get repeater_cliHelpPowersaving =>
      'Shows whether powersaving mode is on or off.';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      'Enables or disables powersaving mode (where supported).';

  @override
  String get repeater_cliHelpErase =>
      '(Serial only) Formats the device file system. Wipes all settings and contacts.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      'Sets the maximum allowed transmit duty cycle as a percentage (1-100). Internally adjusts the airtime factor.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      'Replaces the device identity private key. Reboot required to apply. Generates a new public key.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(SX126x only) Toggles boosted RX gain for improved sensitivity at higher current draw.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      'Sets the owner contact info string included in adverts. Use \'|\' for newlines.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'Sets the path-hash mode. 0 = legacy, 1 = standard, 2 = strict. Affects how routing paths are matched.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'Sets the routing loop-detection sensitivity: off, minimal, moderate, or strict.';

  @override
  String get repeater_cliHelpSetFreq =>
      '(Serial only) Quickly sets just the frequency. Reboot required. Prefer \"set radio\" for full radio params.';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(ESPNow bridge only) Sets the WiFi channel (1-14) used by the bridge.';

  @override
  String get repeater_cliHelpGetName => 'Shows the configured node name.';

  @override
  String get repeater_cliHelpGetRole =>
      'Shows the firmware role (Repeater, Room Server, etc.).';

  @override
  String get repeater_cliHelpGetPublicKey => 'Shows the device public key.';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '(Serial only) Shows the device private key. Treat as a secret.';

  @override
  String get repeater_cliHelpGetRepeat =>
      'Shows whether packet forwarding (repeater role) is on or off.';

  @override
  String get repeater_cliHelpGetTx => 'Shows the current TX power in dBm.';

  @override
  String get repeater_cliHelpGetFreq =>
      'Shows the configured radio frequency in MHz.';

  @override
  String get repeater_cliHelpGetRadio =>
      'Shows full radio params: freq, bandwidth, spreading factor, coding rate.';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(SX126x only) Shows the RX boosted gain state.';

  @override
  String get repeater_cliHelpGetAf => 'Shows the current airtime factor.';

  @override
  String get repeater_cliHelpGetDutyCycle =>
      'Shows the current allowed duty cycle as a percentage.';

  @override
  String get repeater_cliHelpGetIntThresh =>
      'Shows the channel interference threshold in dB.';

  @override
  String get repeater_cliHelpGetAgcResetInterval =>
      'Shows the AGC reset interval in seconds.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      'Shows whether double-ACK mode is on (1) or off (0).';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'Shows whether guest read-only access is allowed.';

  @override
  String get repeater_cliHelpGetAdvertInterval =>
      'Shows the local advertisement interval in minutes.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'Shows the flood advertisement interval in hours.';

  @override
  String get repeater_cliHelpGetGuestPassword =>
      'Shows the configured guest password.';

  @override
  String get repeater_cliHelpGetLat => 'Shows the configured latitude.';

  @override
  String get repeater_cliHelpGetLon => 'Shows the configured longitude.';

  @override
  String get repeater_cliHelpGetRxDelay => 'Shows the rxdelay base value.';

  @override
  String get repeater_cliHelpGetTxDelay =>
      'Shows the flood-mode txdelay factor.';

  @override
  String get repeater_cliHelpGetDirectTxDelay =>
      'Shows the direct-mode txdelay factor.';

  @override
  String get repeater_cliHelpGetFloodMax =>
      'Shows the maximum flood hop count.';

  @override
  String get repeater_cliHelpGetOwnerInfo =>
      'Shows the owner contact info string.';

  @override
  String get repeater_cliHelpGetPathHashMode =>
      'Shows the path-hash mode (0/1/2).';

  @override
  String get repeater_cliHelpGetLoopDetect =>
      'Shows the loop-detection sensitivity.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(Serial only) Lists the access-control entries on a repeater.';

  @override
  String get repeater_cliHelpGetBridgeEnabled =>
      'Shows whether the bridge is enabled.';

  @override
  String get repeater_cliHelpGetBridgeDelay => 'Shows the bridge delay in ms.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'Shows whether the bridge logs RX or TX packets.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(RS232 bridge only) Shows the bridge baud rate.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(ESPNow bridge only) Shows the bridge WiFi channel.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(ESPNow bridge only) Shows the bridge shared secret.';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '(NRF52 only) Shows the bootloader version.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'Shows the ADC multiplier (battery-voltage scaling).';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      'Reports whether the board has power-management support.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      'Shows the current power source: external or battery.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      'Shows the most recent reset and shutdown reasons.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv =>
      'Shows the boot-time battery voltage in mV.';

  @override
  String get repeater_cliHelpSensorGet =>
      'Reads a custom sensor setting by key.';

  @override
  String get repeater_cliHelpSensorSet => 'Writes a custom sensor setting.';

  @override
  String get repeater_cliHelpSensorList =>
      'Lists all custom sensor settings, paginated from optional start index.';

  @override
  String get repeater_cliHelpRegionDefault =>
      'Shows the current default region scope.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'Sets the default region scope. Use \"<null>\" to clear.';

  @override
  String get repeater_cliHelpRegionListAllowed =>
      'Lists regions that allow flood traffic.';

  @override
  String get repeater_cliHelpRegionListDenied =>
      'Lists regions that deny flood traffic.';

  @override
  String get repeater_cliHelpStatsPackets =>
      '(Serial only) Shows packet-level statistics.';

  @override
  String get repeater_cliHelpStatsRadio =>
      '(Serial only) Shows radio statistics.';

  @override
  String get repeater_cliHelpStatsCore =>
      '(Serial only) Shows core firmware statistics.';

  @override
  String get telemetry_receivedData => 'Received Telemetry Data';

  @override
  String get telemetry_requestTimeout => 'Telemetry request timed out.';

  @override
  String telemetry_errorLoading(String error) {
    return 'Error loading telemetry: $error';
  }

  @override
  String get telemetry_noData => 'No telemetry data available.';

  @override
  String telemetry_channelTitle(int channel) {
    return 'Channel $channel';
  }

  @override
  String get telemetry_batteryLabel => 'Battery';

  @override
  String get telemetry_voltageLabel => 'Voltage';

  @override
  String get telemetry_mcuTemperatureLabel => 'MCU Temperature';

  @override
  String get telemetry_temperatureLabel => 'Temperature';

  @override
  String get telemetry_currentLabel => 'Current';

  @override
  String telemetry_batteryValue(int percent, String volts) {
    return '$percent% / ${volts}V';
  }

  @override
  String telemetry_voltageValue(String volts) {
    return '${volts}V';
  }

  @override
  String telemetry_currentValue(String amps) {
    return '${amps}A';
  }

  @override
  String telemetry_temperatureValue(String celsius, String fahrenheit) {
    return '$celsius°C / $fahrenheit°F';
  }

  @override
  String get telemetry_digitalInputLabel => 'Digital Input';

  @override
  String get telemetry_digitalOutputLabel => 'Digital Output';

  @override
  String get telemetry_analogInputLabel => 'Analog Input';

  @override
  String get telemetry_analogOutputLabel => 'Analog Output';

  @override
  String get telemetry_genericLabel => 'Generic Sensor';

  @override
  String get telemetry_luminosityLabel => 'Luminosity';

  @override
  String get telemetry_presenceLabel => 'Presence';

  @override
  String get telemetry_humidityLabel => 'Humidity';

  @override
  String get telemetry_accelerometerLabel => 'Accelerometer';

  @override
  String get telemetry_pressureLabel => 'Pressure';

  @override
  String get telemetry_altitudeLabel => 'Altitude';

  @override
  String get telemetry_frequencyLabel => 'Frequency';

  @override
  String get telemetry_percentageLabel => 'Percentage';

  @override
  String get telemetry_concentrationLabel => 'Concentration';

  @override
  String get telemetry_powerLabel => 'Power';

  @override
  String get telemetry_distanceLabel => 'Distance';

  @override
  String get telemetry_energyLabel => 'Energy';

  @override
  String get telemetry_directionLabel => 'Direction';

  @override
  String get telemetry_timeLabel => 'Time';

  @override
  String get telemetry_gyrometerLabel => 'Gyrometer';

  @override
  String get telemetry_colourLabel => 'Colour';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'Switch';

  @override
  String get telemetry_polylineLabel => 'Polyline';

  @override
  String telemetry_altitudeValue(String meters) {
    return '$meters m';
  }

  @override
  String telemetry_frequencyValue(String hertz) {
    return '$hertz Hz';
  }

  @override
  String telemetry_pressureValue(String hpa) {
    return '$hpa hPa';
  }

  @override
  String telemetry_luminosityValue(String lux) {
    return '$lux lx';
  }

  @override
  String telemetry_powerValue(String watts) {
    return '$watts W';
  }

  @override
  String telemetry_distanceValue(String meters) {
    return '$meters m';
  }

  @override
  String telemetry_energyValue(String kilowattHours) {
    return '$kilowattHours kWh';
  }

  @override
  String telemetry_directionValue(String degrees) {
    return '$degrees°';
  }

  @override
  String telemetry_concentrationValue(String ppm) {
    return '$ppm ppm';
  }

  @override
  String telemetry_percentageValue(String percent) {
    return '$percent%';
  }

  @override
  String telemetry_analogValue(String value) {
    return '$value';
  }

  @override
  String get telemetry_autoFetchQuantity => 'Requests quantity';

  @override
  String get telemetry_error => 'Unable to retrieve data';

  @override
  String get neighbors_receivedData => 'Received Neighbors Data';

  @override
  String get neighbors_requestTimedOut => 'Neighbors request timed out.';

  @override
  String neighbors_errorLoading(String error) {
    return 'Error loading neighbors: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => 'Repeaters Neighbors';

  @override
  String get neighbors_noData => 'No neighbors data available.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return 'Unknown $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return 'Heard: $time ago';
  }

  @override
  String get channelPath_title => 'Packet Path';

  @override
  String get channelPath_viewMap => 'View map';

  @override
  String get channelPath_otherObservedPaths => 'Other Observed Paths';

  @override
  String get channelPath_repeaterHops => 'Repeater Hops';

  @override
  String get channelPath_noHopDetails =>
      'Hop details are not provided for this packet.';

  @override
  String get channelPath_sourceLabel => 'Source';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'This message arrived via MQTT. Your radio has not heard it, so there is no RF path from your radio.';

  @override
  String get channelPath_messageDetails => 'Message Details';

  @override
  String get channelPath_senderLabel => 'Sender';

  @override
  String get channelPath_timeLabel => 'Time';

  @override
  String get channelPath_repeatsLabel => 'Repeats';

  @override
  String channelPath_pathLabel(int index) {
    return 'Path $index';
  }

  @override
  String get channelPath_observedLabel => 'Observed';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return 'Observed path $index • $hops';
  }

  @override
  String get channelPath_noLocationData => 'No location data';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => 'Unknown';

  @override
  String get channelPath_floodPath => 'Flood';

  @override
  String get channelPath_directPath => 'Direct';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 of $total hops';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed of $total hops';
  }

  @override
  String get channelPath_mapTitle => 'Path Map';

  @override
  String get channelPath_noRepeaterLocations =>
      'No repeater locations available for this path.';

  @override
  String channelPath_primaryPath(int index) {
    return 'Path $index (Primary)';
  }

  @override
  String get channelPath_pathLabelTitle => 'Path';

  @override
  String get channelPath_observedPathHeader => 'Observed Path';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable =>
      'No hop details available for this packet.';

  @override
  String get channelPath_unknownRepeater => 'Unknown Repeater';

  @override
  String get community_title => 'Community';

  @override
  String get community_create => 'Create Community';

  @override
  String get community_createDesc =>
      'Create a new community and share via QR code.';

  @override
  String get community_join => 'Join';

  @override
  String get community_joinTitle => 'Join Community';

  @override
  String community_joinConfirmation(String name) {
    return 'Do you want to join the community \"$name\"?';
  }

  @override
  String get community_scanQr => 'Scan Community QR';

  @override
  String get community_scanInstructions =>
      'Point the camera at a community QR code';

  @override
  String get community_showQr => 'Show QR Code';

  @override
  String get community_publicChannel => 'Community Public';

  @override
  String get community_hashtagChannel => 'Community Hashtag';

  @override
  String get community_name => 'Community Name';

  @override
  String get community_enterName => 'Enter community name';

  @override
  String community_created(String name) {
    return 'Community \"$name\" created';
  }

  @override
  String community_joined(String name) {
    return 'Joined community \"$name\"';
  }

  @override
  String get community_qrTitle => 'Share Community';

  @override
  String community_qrInstructions(String name) {
    return 'Scan this QR code to join \"$name\"';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'Community hashtag channels are only joinable by members of the community';

  @override
  String get community_invalidQrCode => 'Invalid community QR code';

  @override
  String get community_alreadyMember => 'Already a Member';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'You are already a member of \"$name\".';
  }

  @override
  String get community_addPublicChannel => 'Add Community Public Channel';

  @override
  String get community_addPublicChannelHint =>
      'Automatically add the public channel for this community';

  @override
  String get community_noCommunities => 'No communities joined yet';

  @override
  String get community_scanOrCreate =>
      'Scan a QR code or create a community to get started';

  @override
  String get community_manageCommunities => 'Manage Communities';

  @override
  String get community_delete => 'Leave Community';

  @override
  String community_deleteConfirm(String name) {
    return 'Leave \"$name\"?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return 'This will also delete $count channel(s) and their messages.';
  }

  @override
  String community_deleted(String name) {
    return 'Left community \"$name\"';
  }

  @override
  String get community_regenerateSecret => 'Regenerate Secret';

  @override
  String community_regenerateSecretConfirm(String name) {
    return 'Regenerate the secret key for \"$name\"? All members will need to scan the new QR code to continue communicating.';
  }

  @override
  String get community_regenerate => 'Regenerate';

  @override
  String community_secretRegenerated(String name) {
    return 'Secret regenerated for \"$name\"';
  }

  @override
  String get community_updateSecret => 'Update Secret';

  @override
  String community_secretUpdated(String name) {
    return 'Secret updated for \"$name\"';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return 'Scan the new QR code to update the secret for \"$name\"';
  }

  @override
  String get community_addHashtagChannel => 'Add Community Hashtag';

  @override
  String get community_addHashtagChannelDesc =>
      'Add a hashtag channel for this community';

  @override
  String get community_selectCommunity => 'Select Community';

  @override
  String get community_regularHashtag => 'Regular Hashtag';

  @override
  String get community_regularHashtagDesc => 'Public hashtag (anyone can join)';

  @override
  String get community_communityHashtag => 'Community Hashtag';

  @override
  String get community_communityHashtagDesc => 'Private to community members';

  @override
  String community_forCommunity(String name) {
    return 'For $name';
  }

  @override
  String get listFilter_tooltip => 'Filter and sort';

  @override
  String get listFilter_sortBy => 'Sort by';

  @override
  String get listFilter_latestMessages => 'Latest messages';

  @override
  String get listFilter_heardRecently => 'Heard recently';

  @override
  String get listFilter_az => 'A-Z';

  @override
  String get listFilter_filters => 'Filters';

  @override
  String get listFilter_all => 'All';

  @override
  String get listFilter_favorites => 'Favorites';

  @override
  String get listFilter_addToFavorites => 'Add to favorites';

  @override
  String get listFilter_removeFromFavorites => 'Remove from favorites';

  @override
  String get listFilter_users => 'Users';

  @override
  String get listFilter_repeaters => 'Repeaters';

  @override
  String get listFilter_roomServers => 'Room servers';

  @override
  String get listFilter_unreadOnly => 'Unread only';

  @override
  String get listFilter_newGroup => 'New group';

  @override
  String get pathTrace_you => 'You';

  @override
  String get pathTrace_failed => 'Path trace failed.';

  @override
  String get pathTrace_notAvailable => 'Path trace not available.';

  @override
  String get pathTrace_refreshTooltip => 'Refresh Path Trace.';

  @override
  String get pathTrace_someHopsNoLocation =>
      'One or more of the hops is missing a location!';

  @override
  String get pathTrace_clearTooltip => 'Clear path.';

  @override
  String get losSelectStartEnd => 'Select start and end nodes for LOS.';

  @override
  String losRunFailed(String error) {
    return 'Line-of-sight check failed: $error';
  }

  @override
  String get losClearAllPoints => 'Clear all points';

  @override
  String get losRunToViewElevationProfile =>
      'Run LOS to view elevation profile';

  @override
  String get losMenuTitle => 'LOS Menu';

  @override
  String get losMenuSubtitle => 'Tap nodes or long-press map for custom points';

  @override
  String get losShowDisplayNodes => 'Show display nodes';

  @override
  String get losCustomPoints => 'Custom points';

  @override
  String losCustomPointLabel(int index) {
    return 'Custom $index';
  }

  @override
  String get losPointA => 'Point A';

  @override
  String get losPointB => 'Point B';

  @override
  String losAntennaA(String value, String unit) {
    return 'Antenna A: $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return 'Antenna B: $value $unit';
  }

  @override
  String get losRun => 'Run LOS';

  @override
  String get losNoElevationData => 'No elevation data';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, clear LOS, min clearance $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, blocked by $obstruction $heightUnit';
  }

  @override
  String get losStatusChecking => 'LOS: checking...';

  @override
  String get losStatusNoData => 'LOS: no data';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS: $clear/$total clear, $blocked blocked, $unknown unknown';
  }

  @override
  String get losErrorElevationUnavailable =>
      'Elevation data unavailable for one or more samples.';

  @override
  String get losErrorInvalidInput =>
      'Invalid points/elevation data for LOS calculation.';

  @override
  String get losRenameCustomPoint => 'Rename custom point';

  @override
  String get losPointName => 'Point name';

  @override
  String get losShowPanelTooltip => 'Show LOS panel';

  @override
  String get losHidePanelTooltip => 'Hide LOS panel';

  @override
  String get losElevationAttribution =>
      'Elevation data: Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'Radio horizon';

  @override
  String get losLegendLosBeam => 'LOS beam';

  @override
  String get losLegendTerrain => 'Terrain';

  @override
  String get losBlockedSpotsTitle => 'Blocked spots';

  @override
  String get losBlockedSpotsHint =>
      'Tap a blocked spot to highlight it on the map.';

  @override
  String losBlockedSpotChip(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit • $obstruction $heightUnit';
  }

  @override
  String get losSelectedObstructionTitle => 'Selected obstruction';

  @override
  String losSelectedObstructionDetails(
    String obstruction,
    String heightUnit,
    String distanceFromA,
    String distanceUnit,
    String distanceFromB,
  ) {
    return 'Blocked by $obstruction $heightUnit, $distanceFromA from A and $distanceFromB from B ($distanceUnit).';
  }

  @override
  String get losFrequencyLabel => 'Frequency';

  @override
  String get losFrequencyInfoTooltip => 'View calculation details';

  @override
  String get losFrequencyDialogTitle => 'Radio horizon calculation';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'Starting from k=$baselineK at $baselineFreq MHz, the calculation adjusts the k-factor for the current $frequencyMHz MHz band, which defines the curved radio horizon cap.';
  }

  @override
  String get contacts_pathTrace => 'Path Trace';

  @override
  String get contacts_ping => 'Ping';

  @override
  String get contacts_repeaterPathTrace => 'Path trace to repeater';

  @override
  String get contacts_repeaterPing => 'Ping repeater';

  @override
  String get contacts_roomPathTrace => 'Path trace to room server';

  @override
  String get contacts_roomPing => 'Ping room server';

  @override
  String get contacts_chatTraceRoute => 'Path trace route';

  @override
  String contacts_pathTraceTo(String name) {
    return 'Trace route to $name';
  }

  @override
  String get contacts_clipboardEmpty => 'Clipboard is empty.';

  @override
  String get contacts_pasteNotContact =>
      'That isn’t a MeshCore contact. Copy a meshcore:// contact link or advert, then try again.';

  @override
  String get contacts_invalidAdvertFormat => 'Invalid contact data';

  @override
  String get contacts_contactImported => 'Contact has been imported.';

  @override
  String get contacts_contactImportFailed => 'Failed to import contact.';

  @override
  String get contacts_zeroHopAdvert => 'Zero Hop Advert';

  @override
  String get contacts_floodAdvert => 'Flood Advert';

  @override
  String get contacts_copyAdvertToClipboard => 'Copy Advert to Clipboard';

  @override
  String get contacts_addContactFromClipboard => 'Add Contact from Clipboard';

  @override
  String get contacts_ShareContact => 'Copy contact to Clipboard';

  @override
  String get contacts_ShareContactZeroHop => 'Share contact by advert';

  @override
  String get contacts_zeroHopContactAdvertSent => 'Sent contact by advert.';

  @override
  String get contacts_zeroHopContactAdvertFailed => 'Failed to send contact.';

  @override
  String get contacts_contactAdvertCopied => 'Advert copied to Clipboard.';

  @override
  String get contacts_contactAdvertCopyFailed =>
      'Copying advert to Clipboard failed.';

  @override
  String get notification_activityTitle => 'NOTORYX Core Ham Activity';

  @override
  String notification_messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'messages',
      one: 'message',
    );
    return '$count $_temp0';
  }

  @override
  String notification_channelMessagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'channel messages',
      one: 'channel message',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'new nodes',
      one: 'new node',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return 'New $contactType discovered';
  }

  @override
  String get notification_receivedNewMessage => 'Received new message';

  @override
  String get settings_gpxExportRepeaters =>
      'Export repeaters / room server to GPX';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'Exports repeaters / roomserver with a location to GPX file.';

  @override
  String get settings_gpxExportContacts => 'Export companions to GPX';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'Exports companions with a location to GPX file.';

  @override
  String get settings_gpxExportAll => 'Export all contacts to GPX';

  @override
  String get settings_gpxExportAllSubtitle =>
      'Exports all contacts with a location to GPX file.';

  @override
  String get settings_gpxExportSuccess => 'Successfully exported GPX file.';

  @override
  String get settings_gpxExportNoContacts => 'No contacts to export.';

  @override
  String get settings_gpxExportNotAvailable =>
      'Not supported on your device/OS';

  @override
  String get settings_gpxExportError => 'There was an error when exporting.';

  @override
  String get settings_gpxExportRepeatersRoom =>
      'Repeater & room server locations';

  @override
  String get settings_gpxExportChat => 'Companion locations';

  @override
  String get settings_gpxExportAllContacts => 'All contacts locations';

  @override
  String get settings_gpxExportShareText =>
      'Map data exported from NOTORYX Core Ham';

  @override
  String get settings_gpxExportShareSubject =>
      'NOTORYX Core Ham GPX map data export';

  @override
  String get snrIndicator_nearByRepeaters => 'Nearby Repeaters';

  @override
  String get snrIndicator_lastSeen => 'Last seen';

  @override
  String get contactsSettings_title => 'Contacts settings';

  @override
  String get contactsSettings_autoAddTitle => 'Automatic Discovery';

  @override
  String get contactsSettings_otherTitle => 'Other contact related settings';

  @override
  String get contactsSettings_autoAddUsersTitle => 'Auto-add users';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      'Allow the companion to automatically add discovered users.';

  @override
  String get contactsSettings_autoAddRepeatersTitle => 'Auto-add repeaters';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      'Allow the companion to automatically add discovered repeaters.';

  @override
  String get contactsSettings_autoAddRoomServersTitle =>
      'Auto-add room servers';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      'Allow the companion to automatically add discovered room servers.';

  @override
  String get contactsSettings_autoAddSensorsTitle => 'Auto-add sensors';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      'Allow the companion to automatically add discovered sensors.';

  @override
  String get contactsSettings_overwriteOldestTitle => 'Overwrite Oldest';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      'When the contact list is full, the oldest non-favorited contact will be replaced.';

  @override
  String get discoveredContacts_Title => 'Discovered Contacts';

  @override
  String get discoveredContacts_noMatching => 'No matching contacts';

  @override
  String get discoveredContacts_searchHint => 'Search discovered contacts';

  @override
  String get discoveredContacts_contactAdded => 'Contact added';

  @override
  String get discoveredContacts_addContact => 'Add Contact';

  @override
  String get discoveredContacts_copyContact => 'Copy Contact to clipboard';

  @override
  String get discoveredContacts_deleteContact => 'Delete Discovered Contact';

  @override
  String get discoveredContacts_deleteContactAll =>
      'Delete All Discovered Contacts';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      'Are you sure you want to delete all discovered contacts?';

  @override
  String get chat_sendCooldown => 'Please wait a moment before sending again.';

  @override
  String get appSettings_jumpToOldestUnread => 'Jump to oldest unread';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      'When opening a chat with unread messages, scroll to the first unread instead of the latest.';

  @override
  String get appSettings_languageHu => 'Hungarian';

  @override
  String get appSettings_languageJa => 'Japanese';

  @override
  String get appSettings_languageKo => 'Korean';

  @override
  String get radioStats_tooltip => 'Radio & mesh stats';

  @override
  String get radioStats_screenTitle => 'Radio stats';

  @override
  String get radioStats_notConnected =>
      'Connect to a device to view radio statistics.';

  @override
  String get radioStats_firmwareTooOld =>
      'Radio statistics require companion firmware v8 or newer.';

  @override
  String get radioStats_waiting => 'Waiting for data…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'Noise floor: $noiseDbm dBm';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return 'Last RSSI: $rssiDbm dBm';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return 'Last SNR: $snr dB';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'TX airtime (total): $seconds s';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'RX airtime (total): $seconds s';
  }

  @override
  String get radioStats_chartCaption =>
      'Noise floor (dBm) over recent samples.';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'Noise floor: $noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting => 'Fetching radio stats…';

  @override
  String get radioStats_settingsTile => 'Radio stats';

  @override
  String get radioStats_settingsSubtitle =>
      'Noise floor, RSSI, SNR, and airtime';

  @override
  String get translation_title => 'Translation';

  @override
  String get imageMessages_enableTitle => 'Enable image messages';

  @override
  String get imageMessages_enableSubtitle =>
      'Send images over the mesh. Requires a one-time image model download.';

  @override
  String get imageMessages_modelSectionTitle => 'Image model';

  @override
  String get imageMessages_downloadModel => 'Download';

  @override
  String get imageMessages_cancelDownload => 'Cancel';

  @override
  String get imageMessages_removeModel => 'Remove model';

  @override
  String get imageMessages_modelReady => 'Ready';

  @override
  String get imageMessages_modelNotPublished =>
      'Not published yet — this build cannot download it.';

  @override
  String get imageMessages_downloadFailed =>
      'The image model could not be downloaded.';

  @override
  String get imageMessages_autoProcessTitle => 'Process images automatically';

  @override
  String get imageMessages_autoProcessSubtitle =>
      'Reconstruct every image as soon as it arrives. Uses about 2 GB of memory for a second each time; leave off to reconstruct with a tap instead.';

  @override
  String get translation_enableTitle => 'Enable translation';

  @override
  String get translation_enableSubtitle =>
      'Translate incoming messages and allow pre-send translation.';

  @override
  String get translation_composerTitle => 'Translate before sending';

  @override
  String get translation_composerSubtitle =>
      'Controls the default state of the composer translation icon.';

  @override
  String get translation_autoIncomingTitle =>
      'Auto-translate incoming messages';

  @override
  String get translation_autoIncomingSubtitle =>
      'Translates Messages for notification and for chat or channel automatically.';

  @override
  String get translation_translateMessage => 'Translate message';

  @override
  String get translation_targetLanguage => 'Target language';

  @override
  String get translation_useAppLanguage => 'Use app language';

  @override
  String get translation_downloadedModelLabel => 'Downloaded model';

  @override
  String get translation_presetModelLabel => 'Preset Hugging Face model';

  @override
  String get translation_manualUrlLabel => 'Manual model URL';

  @override
  String get translation_downloadModel => 'Download model';

  @override
  String get translation_downloading => 'Downloading...';

  @override
  String get translation_working => 'Working...';

  @override
  String get translation_stop => 'Stop';

  @override
  String get translation_mergingChunks =>
      'Merging downloaded chunks into final file...';

  @override
  String get translation_downloadedModels => 'Downloaded models';

  @override
  String get translation_deleteModel => 'Delete model';

  @override
  String get translation_modelDownloaded => 'Translation model downloaded.';

  @override
  String get translation_downloadStopped => 'Download stopped.';

  @override
  String translation_downloadFailed(String error) {
    return 'Download failed: $error';
  }

  @override
  String get translation_enterUrlFirst => 'Enter a model URL first.';

  @override
  String get scanner_linuxPairingShowPin => 'Show PIN';

  @override
  String get scanner_linuxPairingHidePin => 'Hide PIN';

  @override
  String get scanner_linuxPairingPinTitle => 'Bluetooth Pairing PIN';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return 'Enter PIN for $deviceName (leave blank if none).';
  }

  @override
  String get translation_messageTranslation => 'Message translation';

  @override
  String get translation_translateBeforeSending => 'Translate before sending';

  @override
  String get translation_composerEnabledHint =>
      'Messages will be translated before send.';

  @override
  String get translation_composerDisabledHint =>
      'Send messages in the original typed language.';

  @override
  String translation_translateTo(String language) {
    return 'Translate to $language';
  }

  @override
  String get translation_translationOptions => 'Translation options';

  @override
  String get translation_systemLanguage => 'System language';

  @override
  String get background_serviceTitle => 'NOTORYX Core Ham running';

  @override
  String get background_serviceText => 'Keeping BLE connected';

  @override
  String appSettings_translationModelDeleted(String name) {
    return 'Deleted $name';
  }

  @override
  String appSettings_translationModelDeleteFailed(String error) {
    return 'Failed to delete: $error';
  }

  @override
  String channels_channelUpdateFailed(String error) {
    return 'Failed to update channel: $error';
  }

  @override
  String get contact_typeChat => 'Chat';

  @override
  String get contact_typeRepeater => 'Repeater';

  @override
  String get contact_typeRoom => 'Room';

  @override
  String get contact_typeSensor => 'Sensor';

  @override
  String get contact_typeUnknown => 'Unknown';

  @override
  String get map_zoomIn => 'Zoom in';

  @override
  String get map_zoomOut => 'Zoom out';

  @override
  String get map_centerMap => 'Center map';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'Web Bluetooth requires a Chromium browser';

  @override
  String channels_communityShortId(String id) {
    return 'ID: $id...';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'GPS confirmed';

  @override
  String get pathTrace_legendInferred => 'Inferred position';

  @override
  String get pathMap_viewSingle => 'Single';

  @override
  String get pathMap_viewCombined => 'Combined';

  @override
  String get pathMap_play => 'Play';

  @override
  String get pathMap_pause => 'Pause';

  @override
  String get pathMap_replay => 'Replay';

  @override
  String get pathMap_stepBack => 'Previous hop';

  @override
  String get pathMap_stepForward => 'Next hop';

  @override
  String get pathMap_animationOn => 'Show packet animation';

  @override
  String get pathMap_animationOff => 'Hide packet animation';

  @override
  String pathMap_hopOf(int current, int total) {
    return 'Hop $current of $total';
  }

  @override
  String pathMap_observedPaths(int count) {
    return 'Observed paths: $count';
  }

  @override
  String get pathMap_primary => 'Primary';

  @override
  String pathMap_alternate(int index) {
    return 'Alt $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hops',
      one: '1 hop',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => 'Shared segment';

  @override
  String get pathMap_legendEstimated => 'Estimated segment';

  @override
  String pathMap_sharedNodeCount(int count) {
    return 'Used by $count paths';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hops have no location — the shown path is partial',
      one: '1 hop has no location — the shown path is partial',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'Show all';

  @override
  String get pathMap_hidePath => 'Hide path';

  @override
  String get pathMap_showPath => 'Show path';

  @override
  String get pathMap_collapsePanel => 'Collapse panel';

  @override
  String get pathMap_expandPanel => 'Expand panel';

  @override
  String get pathMap_noLocation => 'No location';

  @override
  String get pathMap_followPacket => 'Lock view to packet';

  @override
  String get pathMap_unfollowPacket => 'Unlock view from packet';

  @override
  String get imageSend_title => 'Send image';

  @override
  String get imageSend_cropNote =>
      'Resized to 512 × 512 · aspect ratio not preserved';

  @override
  String get imageSend_originalSize => 'Original';

  @override
  String get imageSend_onAirSize => 'On air';

  @override
  String get imageSend_quality => 'Quality';

  @override
  String get imageSend_qualityStandard => 'Standard';

  @override
  String get imageSend_qualityHigh => 'High';

  @override
  String get imageSend_packetsLabel => 'Packets';

  @override
  String get imageSend_airtimeLabel => 'Time on air';

  @override
  String get imageSend_sizeLabel => 'Payload';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'packets',
      one: 'packet',
    );
    return '$count $_temp0';
  }

  @override
  String imageSend_range(String min, String max) {
    return '$min–$max';
  }

  @override
  String get imageSend_unknownValue => '—';

  @override
  String get imageSend_radioUnknownTitle => 'Radio settings unknown';

  @override
  String get imageSend_radioUnknownBody =>
      'Connect to a device so the time on air can be calculated.';

  @override
  String get imageSend_longSendTitle => 'Long transmission';

  @override
  String imageSend_longSendBody(String duration) {
    return 'This will hold the channel for about $duration.';
  }

  @override
  String get imageSend_floodNote =>
      'Flood routing: every repeater in range retransmits each packet, so the channel stays busy longer than this.';

  @override
  String get imageSend_parityTitle => 'Add recovery packet';

  @override
  String get imageSend_paritySubtitle =>
      'One extra packet. Group messages are not acknowledged, so this lets the receiver rebuild the image if a single packet is lost.';

  @override
  String get imageSend_send => 'Send';

  @override
  String get imageSend_cancel => 'Cancel';

  @override
  String get imageSend_encodeFailed => 'This image could not be encoded.';

  @override
  String get imageSend_codecDownloading =>
      'The image model is still downloading.';

  @override
  String get imageSend_codecUnavailable =>
      'Image sending is not available on this device.';

  @override
  String get imageSend_codecDisabled =>
      'Image messages are turned off in settings.';

  @override
  String get imageSend_deviceUnsupported =>
      'This radio cannot send image packets. Connect a device running companion firmware 13 or newer.';

  @override
  String get imageSend_directMessagesUnsupported =>
      'Images travel as group data, so they can only be sent to a channel — not in a direct message.';

  @override
  String get imageSend_tooLarge =>
      'That image encoded to more packets than the mesh format allows.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'packets',
      one: 'packet',
    );
    return 'Image sent as $count $_temp0.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return 'The image could not be sent: $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return 'Sending image — packet $sent of $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'Node $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return '$received of $total packets';
  }

  @override
  String get receivedImage_queued => 'Waiting to decode';

  @override
  String get receivedImage_tapToDecode => 'Tap to decode';

  @override
  String get receivedImage_decoding => 'Reconstructing… about 1 s';

  @override
  String receivedImage_incomplete(int received, int total) {
    return 'Image incomplete — $received of $total packets arrived';
  }

  @override
  String get receivedImage_corrupt => 'Image could not be reconstructed';

  @override
  String get receivedImage_decoderMissing =>
      'Image received — image decoding is off';

  @override
  String get receivedImage_evicted => 'Image no longer stored';

  @override
  String get receivedImage_retry => 'Try again';

  @override
  String get receivedImage_decodeAgain => 'Decode again';

  @override
  String get receivedImage_openSettings => 'Set up';

  @override
  String get receivedImage_tapToProcess => 'Tap to process';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'packets',
      one: 'packet',
    );
    return '$bytes bytes · $packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds s';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes m $seconds s';
  }

  @override
  String get bastion_tagline => 'Communication without infrastructure.';

  @override
  String get bastion_nodes => 'Nodes';

  @override
  String get bastion_repeaters => 'Repeaters';

  @override
  String get bastion_active1h => 'Active 1h';

  @override
  String get bastion_mapCoverage => 'Map + coverage';

  @override
  String get bastion_routeIntelligence => 'Route intelligence';

  @override
  String get bastion_repeaterTools => 'Repeater tools';

  @override
  String get bastion_fieldStats => 'Field stats';

  @override
  String get bastion_fieldOps => 'Trip + field operations';

  @override
  String get bastion_coverageCapture => 'Coverage capture';

  @override
  String get bastion_mapAttribution =>
      'Map data © OpenStreetMap contributors; tiles by selected provider';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count observations',
      one: '1 observation',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count unique nodes',
      one: '1 unique node',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hops',
      one: '1 hop',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '1 minute',
    );
    return '$_temp0';
  }

  @override
  String get sos_holdHint =>
      'Hold 2 seconds. Sends your position to your trip contacts every 5 minutes until someone replies.';

  @override
  String sos_holdHintChannel(String channel) {
    return 'Hold 2 seconds. Sends your position to your trip contacts and $channel every 5 minutes until someone replies.';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS not sent: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return 'Acknowledged by $name. Repeats stopped.';
  }

  @override
  String get sos_waitingForRadio => 'Waiting for the radio to send…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return 'Sent $sends of $max times. Repeats finished; no reply yet.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return 'Sent $sends of $max times. Next at $time.';
  }

  @override
  String get sos_active => 'SOS ACTIVE';

  @override
  String get sos_stop => 'STOP';

  @override
  String get sos_imSafe => 'I\'M SAFE';

  @override
  String get sos_holdSemantics => 'SOS. Hold to send.';

  @override
  String get sos_keepHolding => 'KEEP HOLDING…';

  @override
  String get sos_holdForSos => 'HOLD FOR SOS';

  @override
  String get sos_blockStorage => 'Resolve the Field Log storage error first.';

  @override
  String get sos_blockNotConnected =>
      'Connect your MeshCore radio to send an SOS.';

  @override
  String get sos_blockNoTarget =>
      'Choose trip contacts or an SOS channel in Plan trip.';

  @override
  String get checkIn_labelOk => 'I\'m OK';

  @override
  String get checkIn_labelAtCamp => 'At Camp';

  @override
  String get checkIn_labelDelayed => 'Delayed';

  @override
  String get checkIn_labelHeadingBack => 'Heading Back';

  @override
  String get checkIn_blockLoading => 'Loading your trip…';

  @override
  String get checkIn_blockStorage =>
      'Resolve the Field Log storage error before sending.';

  @override
  String get checkIn_blockBusy => 'A check-in is being sent. Please wait.';

  @override
  String get checkIn_blockNoContacts => 'Choose trip contacts in Plan trip.';

  @override
  String get checkIn_blockRosterIncomplete =>
      'Some trip contacts are unavailable. Review your roster.';

  @override
  String get checkIn_blockNotConnected =>
      'Connect your MeshCore radio to check in.';

  @override
  String get checkIn_blockNotActive => 'Start your trip to enable check-ins.';

  @override
  String get checkIn_notSent => 'Not sent';

  @override
  String checkIn_deliveredToOne(String name) {
    return 'Delivered to $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return 'Delivered to all $count contacts';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return 'Delivered to $delivered of $total';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return 'Not delivered: $names';
  }

  @override
  String get checkIn_waitingForRest => 'Waiting for the rest';

  @override
  String get checkIn_aContact => 'a contact';

  @override
  String get checkIn_statusPending => 'Pending';

  @override
  String get checkIn_statusSent => 'Sent';

  @override
  String get checkIn_statusDelivered => 'Delivered';

  @override
  String get checkIn_statusFailed => 'Failed';

  @override
  String get checkIn_explainPending =>
      'Queued locally. This does not confirm radio transmission or receipt.';

  @override
  String get checkIn_explainSent =>
      'The radio accepted the send. No delivery acknowledgment has been recorded.';

  @override
  String get checkIn_explainDelivered =>
      'The app recorded a delivery acknowledgment. It does not prove the person read it.';

  @override
  String get checkIn_explainFailed =>
      'No confirmed delivery. Check radio connection, recipient reachability and retry history.';

  @override
  String get checkIn_explainUnknown =>
      'Delivery state is unavailable. Do not assume this message arrived.';

  @override
  String get tripBrief_heading => 'NOTORYX • MeshCore Trip Brief';

  @override
  String tripBrief_trip(String name) {
    return 'Trip: $name';
  }

  @override
  String tripBrief_status(String status) {
    return 'Status: $status';
  }

  @override
  String get tripBrief_active => 'Active';

  @override
  String get tripBrief_stopped => 'Stopped';

  @override
  String tripBrief_contacts(String names) {
    return 'Contacts: $names';
  }

  @override
  String get tripBrief_noneSelected => 'None selected';

  @override
  String get tripBrief_unavailableContact =>
      'Unavailable contact (review roster)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return 'Activity overdue after: $minutes minutes (this phone alerts when a contact goes quiet)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'Check-in reminder: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return 'every $minutes minutes without a check-in';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'Check-in choices: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'Radio position in check-ins: $value';
  }

  @override
  String get tripBrief_includedMayBeStale => 'Included; may be stale';

  @override
  String tripBrief_battery(String value) {
    return 'Radio battery in check-ins: $value';
  }

  @override
  String get tripBrief_included => 'Included';

  @override
  String get tripBrief_off => 'Off';

  @override
  String get tripBrief_review =>
      'Review recipients and message before sending a check-in.';

  @override
  String get tripBrief_noProof =>
      'Queued or sent does not prove delivery. An acknowledgment does not prove it was read.';

  @override
  String get tripBrief_overdueMeaning =>
      'Overdue means no recent contact activity; it is not a confirmed emergency.';

  @override
  String get tripBrief_automations =>
      'Field automations run only while the app is active. Agree on a separate plan for missed contact.';

  @override
  String get tripBrief_sharesOnly =>
      'This brief shares information only; it does not send a radio message or start a trip.';

  @override
  String get fieldOps_title => 'NOTORYX Core Ham Field Operations';

  @override
  String get fieldOps_tabTrip => 'Trip';

  @override
  String get fieldOps_tabReady => 'Ready';

  @override
  String get fieldOps_tabLog => 'Log';

  @override
  String get fieldOps_tabAuto => 'Auto';

  @override
  String get fieldOps_tabCoverage => 'Coverage';

  @override
  String get fieldOps_tabConnection => 'Connection';

  @override
  String get fieldOps_diagnostics => 'Diagnostics';

  @override
  String get fieldOps_storageLoadError =>
      'Field data could not be loaded. Saved data was retained; automations remain off.';

  @override
  String get fieldOps_storageSaveError =>
      'Field data could not be saved. Automations stopped; existing stored data is retained.';

  @override
  String get fieldOps_regionHint =>
      'Select an area and zoom levels in Offline maps.';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • zoom $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return 'Map area could not be verified: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Trip active • $count contacts',
      one: 'Trip active • 1 contact',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped =>
      'Trip stopped. Start it when you are ready.';

  @override
  String fieldOps_reminderAt(String time) {
    return 'Check-in reminder at $time';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return 'Quiet too long: $names';
  }

  @override
  String get fieldOps_planTrip => 'Plan trip';

  @override
  String get fieldOps_endTrip => 'End trip';

  @override
  String get fieldOps_startTrip => 'Start trip';

  @override
  String get fieldOps_tripBrief => 'Trip brief';

  @override
  String get fieldOps_connectRadio => 'Connect radio';

  @override
  String get fieldOps_previewedCheckIns => 'Previewed check-ins';

  @override
  String get fieldOps_previewedCheckInsHint =>
      'Choose a status, review the actual recipients and message, then send. Queued does not mean delivered.';

  @override
  String get fieldOps_tripRoster => 'Trip roster';

  @override
  String get fieldOps_rosterEmpty =>
      'Choose up to six known chat contacts in Plan trip.';

  @override
  String get fieldOps_rosterCaveat =>
      'Last heard is evidence of past activity. It does not establish current reachability. Overdue badges mean no recent contact activity, not a confirmed emergency.';

  @override
  String get fieldOps_offlineMaps => 'Offline maps';

  @override
  String get fieldOps_checkingTiles => 'Checking saved tiles…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cached tiles.',
      one: '1 cached tile.',
    );
    return '$_temp0 This does not guarantee your entire route is covered.';
  }

  @override
  String get fieldOps_downloadAreas => 'Download / inspect offline areas';

  @override
  String fieldOps_lastCheckIn(String time) {
    return 'Last check-in, $time';
  }

  @override
  String fieldOps_deliveryChip(String name, String status) {
    return '$name: $status';
  }

  @override
  String get fieldOps_contactFallback => 'Contact';

  @override
  String fieldOps_resendFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Resend to $count not delivered',
      one: 'Resend to 1 not delivered',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable => 'Selected contact unavailable';

  @override
  String get fieldOps_memberUnavailableHint =>
      'Review this trip before sending.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return 'Last activity ${minutes}m ago';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return 'Last activity ${minutes}m ago • overdue';
  }

  @override
  String get fieldOps_noCheckInRecorded => 'No check-in recorded in this log.';

  @override
  String get fieldOps_tripMap => 'Trip map';

  @override
  String get fieldOps_tripMapEmpty =>
      'No selected contacts have advertised coordinates yet.';

  @override
  String get fieldOps_lastPositions => 'Last advertised positions';

  @override
  String get fieldOps_positionsCaveat =>
      'Positions can be stale. This map does not track phone GPS or prove members are currently here.';

  @override
  String get fieldOps_briefPreviewTitle => 'Preview Trip Brief';

  @override
  String get fieldOps_briefPreviewHint =>
      'Includes trip and contact names. Review before sharing. Coordinates, keys and message history are omitted.';

  @override
  String get fieldOps_shareBrief => 'Share brief';

  @override
  String get fieldOps_briefSubject => 'NOTORYX Core Ham Trip Brief';

  @override
  String get fieldOps_tripName => 'Trip name';

  @override
  String get fieldOps_defaultTripName => 'My trip';

  @override
  String get fieldOps_includePosition => 'Include advertised radio position';

  @override
  String get fieldOps_includePositionHint =>
      'May be stale; sharing is off by default.';

  @override
  String get fieldOps_includeBattery => 'Include radio battery';

  @override
  String get fieldOps_overdueLabel => 'Alert me when a contact is quiet for';

  @override
  String get fieldOps_reminderLabel => 'Remind me to check in';

  @override
  String get fieldOps_reminderHelper =>
      'A phone notification, even if NOTORYX Core Ham is closed.';

  @override
  String get fieldOps_reminderOff => 'Off';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'After $count minutes without one',
      one: 'After 1 minute without one',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'SOS also goes to channel';

  @override
  String get fieldOps_sosChannelNone => 'None';

  @override
  String get fieldOps_selectContacts => 'Select up to six known chat contacts';

  @override
  String get fieldOps_sendCheckInTitle => 'Send check-in?';

  @override
  String fieldOps_recipients(String names) {
    return 'To: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      'This uses normal direct-message sends. Delivery will be tracked in Field Log.';

  @override
  String get fieldOps_send => 'Send';

  @override
  String get sosRelay_title => 'SOS relay';

  @override
  String get sosRelay_enable => 'Relay SOS no repeater carried';

  @override
  String get sosRelay_needsFirmware => 'Needs radio firmware v1.16 or newer';

  @override
  String get sosRelay_noneYet => 'No SOS relayed yet';

  @override
  String sosRelay_relayedCount(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Relayed $count SOS packets, last at $time',
      one: 'Relayed 1 SOS packet, last at $time',
    );
    return '$_temp0';
  }

  @override
  String get sosRelay_explainer =>
      'When your radio hears an SOS straight from the sender and no repeater passes it on within about 15 seconds, NOTORYX sends it once more, unchanged, so it can reach a repeater you can hear and they can\'t. Only SOS on channels you have are relayed. Uses some battery and airtime, so it\'s off by default.';

  @override
  String get fieldOps_beforeYouLeave => 'Before you leave';

  @override
  String get fieldOps_radioConnected => 'Radio connected';

  @override
  String get fieldOps_connectHint => 'Connect with Bluetooth, USB or TCP.';

  @override
  String get fieldOps_radioBattery => 'Radio battery';

  @override
  String get fieldOps_batteryUnknown => 'Unknown; inspect the radio.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent% • charge for your planned trip.';
  }

  @override
  String get fieldOps_tripContacts => 'Trip contacts';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return '$available/$selected available. Check they have compatible radios and channels.';
  }

  @override
  String get fieldOps_offlineArea => 'Selected offline map area';

  @override
  String get fieldOps_checkingFiles => 'Checking local files…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return '$available/$expected tile files available; $missing missing. This is a snapshot; open the area offline before leaving.';
  }

  @override
  String get fieldOps_locationChoice => 'Location-sharing choice';

  @override
  String get fieldOps_locationOptedIn =>
      'Opted in: radio advertised coordinates may be stale.';

  @override
  String get fieldOps_locationOff =>
      'Sharing is off. Your check-ins omit coordinates.';

  @override
  String get fieldOps_automationAvailability => 'Automation availability';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'Runs only while this app is active. Sleep, closure or loss of radio can prevent scheduled actions.';

  @override
  String get fieldOps_readinessCaveat =>
      'Readiness checks are advisory; they do not prove radio range or guarantee message delivery.';

  @override
  String get fieldOps_radio => 'Radio';

  @override
  String get fieldOps_refreshChecks => 'Refresh checks';

  @override
  String get fieldOps_searchLog => 'Search Field Log';

  @override
  String get fieldOps_kindAll => 'All';

  @override
  String get fieldOps_kindCheckIn => 'Check-in';

  @override
  String get fieldOps_kindReceived => 'Received';

  @override
  String get fieldOps_kindNote => 'Note';

  @override
  String get fieldOps_kindDeadZone => 'Dead zone';

  @override
  String get fieldOps_kindRadio => 'Radio';

  @override
  String get fieldOps_kindAutomation => 'Automation';

  @override
  String get fieldOps_kindMissed => 'Missed';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => 'Trip';

  @override
  String get fieldOps_kindOverdue => 'Overdue';

  @override
  String get fieldOps_addNote => 'Add note';

  @override
  String get fieldOps_exportJson => 'Export JSON';

  @override
  String get fieldOps_deleteLog => 'Delete log';

  @override
  String get fieldOps_logSubject => 'NOTORYX Core Ham Field Log';

  @override
  String get fieldOps_logCaveat =>
      'Stored locally, up to 1,000 entries. Exports may contain contact keys, messages and locations; review before sharing.';

  @override
  String get fieldOps_noEntries => 'No matching entries.';

  @override
  String get fieldOps_tripUnspecified => 'Trip unspecified';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return 'Recorded radio-advertised position $latitude, $longitude (may be stale)';
  }

  @override
  String get fieldOps_noteTitle => 'Field observation';

  @override
  String get fieldOps_noteLabel => 'What did you observe?';

  @override
  String get fieldOps_deadZone => 'Reported dead zone';

  @override
  String get fieldOps_deadZoneHint =>
      'Your observation, not a verified coverage prediction.';

  @override
  String get fieldOps_savePosition => 'Save radio-advertised position';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • may be stale; not phone GPS';
  }

  @override
  String get fieldOps_noPosition => 'No usable advertised coordinates';

  @override
  String get fieldOps_deleteLogTitle => 'Delete Field Log?';

  @override
  String get fieldOps_deleteLogBody =>
      'This removes all saved entries on this phone. Trip settings are kept.';

  @override
  String get fieldOps_localAutomations => 'Local automations';

  @override
  String get fieldOps_enableForTrip => 'Enable for this trip';

  @override
  String get fieldOps_automationsCaveat =>
      'Starts off after every app restart. Rules run only while the app is active. Missed scheduled actions appear in Field Log and are never replayed in a burst. Automatic check-ins are limited to one batch per 10 minutes.';

  @override
  String get fieldOps_openBotMode => 'Open NOTORYX Bot Mode';

  @override
  String get fieldOps_ruleEnabled => 'Rule enabled';

  @override
  String get fieldOps_dryRun => 'Dry run';

  @override
  String get fieldOps_dryRunHint =>
      'Record the action without sending or notifying.';

  @override
  String get fieldOps_then => 'Then';

  @override
  String get fieldOps_actionLog => 'Write to Field Log';

  @override
  String get fieldOps_actionNotify => 'Show local notification';

  @override
  String get fieldOps_actionCheckIn => 'Send I\'m OK to trip contacts';

  @override
  String get fieldOps_batteryThreshold => 'Battery at or below';

  @override
  String fieldOps_nextDue(String time) {
    return 'Next due: $time';
  }

  @override
  String get fieldOps_nextDueNone => 'Next due: not scheduled';

  @override
  String get fieldOps_previewInLog => 'Preview in log';

  @override
  String get fieldOps_allowNotifications => 'Allow notifications';

  @override
  String get fieldOps_triggerReconnect => 'WHEN radio reconnects';

  @override
  String get fieldOps_triggerDisconnect => 'WHEN radio disconnects';

  @override
  String get fieldOps_triggerLowBattery =>
      'WHEN radio battery crosses threshold';

  @override
  String get fieldOps_triggerNewNode => 'WHEN a new node is added';

  @override
  String get fieldOps_triggerRepeater => 'WHEN a new repeater is added';

  @override
  String get fieldOps_triggerScheduled => 'WHEN a scheduled check-in is due';

  @override
  String get fieldOps_explainConnection => 'Explain my connection';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return 'State: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      'The phone has a radio connection. That alone does not establish a route to your recipients.';

  @override
  String get fieldOps_disconnectedHint =>
      'No active radio connection. Check Bluetooth permissions, radio power and range; USB/TCP are available from Connect radio.';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return 'Trip check-ins awaiting confirmation: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'Node last-seen times and advertised positions can be stale. Route intelligence shows routes learned from observed attempts; it does not invent paths.';

  @override
  String get fieldOps_routeIntelligence => 'Route intelligence';

  @override
  String get fieldOps_coverageIntelligence => 'Coverage intelligence';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      'Compare recorded observations between two field sessions. Dots mark recorder radio-advertised positions where nodes were heard. They do not imply continuous coverage. RSSI/SNR snapshots are not per-node measurements.';

  @override
  String get fieldOps_captureSession => 'Capture a session';

  @override
  String get fieldOps_refreshHistory => 'Refresh history';

  @override
  String get fieldOps_noCoverageSessions => 'No saved coverage sessions yet.';

  @override
  String get fieldOps_sessionA => 'Session A • teal';

  @override
  String get fieldOps_sessionB => 'Session B • amber';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: $a unique nodes • B: $b unique nodes';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return 'Shared: $shared • Only A: $onlyA • Only B: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'Not hearing a node during one session does not establish a dead zone. Conditions and observation duration differ.';

  @override
  String get fieldOps_heardTooltip =>
      'Heard-node observation; not proof of a successful link';

  @override
  String get fieldOps_noteTooltip =>
      'Local note at radio-advertised coordinates; may be stale.';

  @override
  String get bastionHome_aboutTooltip => 'About NOTORYX Core Ham';

  @override
  String get bastionHome_getStarted => 'Get started';

  @override
  String get bastionHome_getStartedHint =>
      'Connect your radio and verify your first message';

  @override
  String get bastionHome_planYourTrip => 'Plan your trip';

  @override
  String get bastionHome_tripActive => 'Trip active';

  @override
  String get bastionHome_tripStopped => 'Trip stopped';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • $contacts contacts • $unread unread messages';
  }

  @override
  String get bastionHome_checkInOk => 'Check in: I\'m OK';

  @override
  String get bastionHome_checkInHint =>
      'Review contacts and message before sending. Track acknowledgements in Field Log.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return 'Last check-in: $summary';
  }

  @override
  String get bastionHome_connectRadio => 'Connect radio';

  @override
  String get bastionHome_connectRadioHint =>
      'Bluetooth, USB and TCP MeshCore connections';

  @override
  String get bastionHome_liveDiagnostics => 'Live diagnostics';

  @override
  String get bastionHome_liveDiagnosticsHint =>
      'Radio health, signal, device and frame tools';

  @override
  String get bastionHome_meshDiscovery => 'Mesh discovery';

  @override
  String get bastionHome_meshDiscoveryHint =>
      'Find nodes and inspect the mesh around you';

  @override
  String get bastionHome_fieldOpsHint =>
      'Trip brief, readiness, Field Log, automations and coverage comparison';

  @override
  String get bastionHome_fieldTools => 'Field tools';

  @override
  String get bastionHome_statusActive => 'ACTIVE';

  @override
  String get bastionHome_consoleOnline => 'Field console online';

  @override
  String get bastionHome_consoleReady => 'Field console ready';

  @override
  String get bastionHome_consoleHint =>
      'Connect a radio to light up the live dashboard.';

  @override
  String bastionHome_battery(String value) {
    return 'Battery $value';
  }

  @override
  String get bastionTools_title => 'Field Tools';

  @override
  String get bastionTools_backup => 'Encrypted backup';

  @override
  String get bastionTools_backupHint =>
      'Save settings, contacts and keys with optional chat history';

  @override
  String get bastionTools_fieldOpsHint =>
      'Check-ins, readiness, Field Log, automations and comparisons';

  @override
  String get bastionTools_mapHint =>
      'Live map, capture sessions, offline map tools and regions';

  @override
  String get bastionTools_pathAnalysis => 'Path analysis';

  @override
  String get bastionTools_pathHint => 'Routes, discovery and path intelligence';

  @override
  String get bastionTools_repeaterHint =>
      'Status, login, telemetry, neighbors and administration';

  @override
  String get bastionTools_statsHint => 'Live mesh counts and contact activity';

  @override
  String get bastionTools_diagnostics => 'Diagnostics';

  @override
  String get bastionTools_diagnosticsHint =>
      'Radio health, device information, raw frames and export';

  @override
  String get bastionTools_about => 'About + credits';

  @override
  String get bastionTools_aboutHint =>
      'NOTORYX Core Ham version, independence statement and open-source licenses';

  @override
  String get bastionAbout_title => 'About + Credits';

  @override
  String get bastionAbout_intro =>
      'An independent community companion app for MeshCore networks. NOTORYX Core Ham is not an official MeshCore app and inclusion of community resources does not imply partnership or endorsement.';

  @override
  String get bastionAbout_version => 'Version';

  @override
  String get bastionAbout_openSource => 'Open source foundation';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core Ham is built from and modifies open-source MeshCore Open code under the MIT License. Coverage workflow work also credits the MIT-licensed MeshMapper Flutter App where applicable.';

  @override
  String get bastionAbout_community => 'Community first';

  @override
  String get bastionAbout_communityBody =>
      'Third-party creator resources remain the property of their respective creators. No ownership or partnership is implied.';

  @override
  String get bastionAbout_legalese =>
      'NOTORYX Core Ham • Independent MeshCore companion';

  @override
  String get bastionAbout_licenses => 'Open source licenses';

  @override
  String get bastionSetup_title => 'Get started with NOTORYX Core Ham';

  @override
  String get bastionSetup_intro =>
      'Connect, choose a contact, then verify a message. You can return to this guide from the dashboard at any time.';

  @override
  String get bastionSetup_step1 => '1. Connect your MeshCore radio';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return 'Connected to $device using $transport.';
  }

  @override
  String get bastionSetup_noRadio => 'No radio connected yet.';

  @override
  String get bastionSetup_step1Power =>
      'Power on a MeshCore companion radio. Open Connect radio and choose Bluetooth, USB or TCP. Allow the permissions requested for your chosen connection.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'If Bluetooth discovery is empty, check Bluetooth is enabled and NOTORYX Core Ham has Nearby devices permission in Android app settings. Follow any additional permission prompt shown by the scanner.';

  @override
  String get bastionSetup_connectionDiagnostics => 'Connection diagnostics';

  @override
  String get bastionSetup_step2 => '2. Choose a chat contact';

  @override
  String get bastionSetup_step2Body =>
      'Ask a nearby partner with compatible MeshCore radio settings to advertise their node. Choose a known chat contact below; repeaters are managed separately.';

  @override
  String get bastionSetup_noContacts =>
      'No chat contacts available. Connect your radio and open Mesh discovery.';

  @override
  String get bastionSetup_testRecipient => 'Test recipient';

  @override
  String get bastionSetup_meshDiscovery => 'Mesh discovery';

  @override
  String get bastionSetup_step3 => '3. Send and verify a message';

  @override
  String get bastionSetup_step3Body =>
      'Open chat, write a short test message, review the recipient and tap Send. Return here to see the latest outgoing message recorded since opening this guide.';

  @override
  String get bastionSetup_openTestChat => 'Open test chat';

  @override
  String get bastionSetup_connectFirst =>
      'Connect your radio to open test chat.';

  @override
  String get bastionSetup_chooseRecipient => 'Choose a recipient first.';

  @override
  String get bastionSetup_noTestMessage =>
      'No outgoing test message recorded in this guide session.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return 'Latest message: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'Ask your partner to confirm receipt or reply. A recorded acknowledgment does not prove they read it. Recheck the connection and recipient if a message fails.';

  @override
  String get bastionSetup_step4 => '4. Prepare for the field';

  @override
  String get bastionSetup_step4Body =>
      'Plan your trip contacts and inspect downloaded map areas. Bot Mode and field automations start off; field automations run only while the app is active.';

  @override
  String get bastionSetup_tripTools => 'Trip and readiness tools';

  @override
  String get bastionDiag_title => 'Diagnostics';

  @override
  String get bastionDiag_export => 'Export diagnostics';

  @override
  String get bastionDiag_channels => 'Channels';

  @override
  String get bastionDiag_radio => 'Radio';

  @override
  String get bastionDiag_frequency => 'Frequency';

  @override
  String get bastionDiag_bandwidth => 'Bandwidth';

  @override
  String get bastionDiag_spreadingFactor => 'Spreading factor';

  @override
  String get bastionDiag_codingRate => 'Coding rate';

  @override
  String get bastionDiag_txPower => 'TX power';

  @override
  String get bastionDiag_noiseFloor => 'Noise floor';

  @override
  String get bastionDiag_device => 'Device';

  @override
  String get bastionDiag_name => 'Name';

  @override
  String get bastionDiag_manufacturer => 'Manufacturer';

  @override
  String get bastionDiag_firmware => 'Firmware';

  @override
  String get bastionDiag_battery => 'Battery';

  @override
  String get bastionDiag_transport => 'Transport';

  @override
  String get bastionDiag_deepTools => 'Deep tools';

  @override
  String get bastionDiag_liveStats => 'Live radio stats';

  @override
  String get bastionDiag_liveStatsHint => 'Noise, RSSI, SNR and airtime';

  @override
  String get bastionDiag_frameDebug => 'Frame / BLE debug';

  @override
  String get bastionDiag_frameDebugHint =>
      'Inspect decoded and raw received frames';

  @override
  String get bastionDiag_appLog => 'App debug log';

  @override
  String get bastionDiag_appLogHint => 'Review application diagnostic events';

  @override
  String get bastionDiag_online => 'Radio online';

  @override
  String get bastionDiag_offline => 'Radio offline';

  @override
  String get bastionDiag_offlineHint =>
      'Connect a MeshCore companion to populate live diagnostics.';

  @override
  String get coverage_title => 'Coverage Capture';

  @override
  String get coverage_leaveBlocked =>
      'Stop and save the session before leaving.';

  @override
  String get coverage_savedSessions => 'Saved sessions';

  @override
  String get coverage_caveat =>
      'RSSI/SNR are radio snapshots and may belong to another packet. Positions are radio-advertised coordinates, not phone GPS or proof of coverage. Cyan: recorder; amber: advertised node. No interpolation is performed.';

  @override
  String get coverage_captureActive => 'Capture active';

  @override
  String get coverage_fieldSession => 'Field coverage session';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core Ham records newly heard nodes during this session, including route data, node/location metadata and the nearest available radio RSSI/SNR snapshot.';

  @override
  String get coverage_disconnectedBody =>
      'Connect a radio before starting. Coverage capture records live mesh observations from the connected companion radio.';

  @override
  String get coverage_observations => 'Observations';

  @override
  String get coverage_uniqueNodes => 'Unique nodes';

  @override
  String get coverage_elapsed => 'Elapsed';

  @override
  String get coverage_radioConnected => 'Radio connected';

  @override
  String get coverage_noRadio => 'No radio';

  @override
  String get coverage_gpsReady => 'Radio GPS ready';

  @override
  String get coverage_noGps => 'No radio GPS';

  @override
  String get coverage_stopSave => 'Stop + save session';

  @override
  String get coverage_start => 'Start coverage session';

  @override
  String get coverage_exportJson => 'Export JSON';

  @override
  String get coverage_exportCsv => 'Export CSV';

  @override
  String get coverage_liveObservations => 'Live observations';

  @override
  String get coverage_waiting => 'Waiting for mesh activity';

  @override
  String get coverage_waitingBody =>
      'Start a session and newly heard active nodes will appear here. RSSI/SNR values are radio snapshots and may not always be uniquely attributable to a specific packet.';

  @override
  String get coverage_signalNa => 'signal n/a';

  @override
  String get coverage_snrNa => 'SNR n/a';

  @override
  String get coverage_gpsUnavailable => 'radio GPS unavailable';

  @override
  String coverage_pathLine(String path, String location) {
    return 'Path: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'flood';

  @override
  String get coverage_pathDirect => 'direct';

  @override
  String get coverage_shareSubject => 'NOTORYX Core Ham Coverage Session';

  @override
  String get coverage_shareText => 'NOTORYX Core Ham coverage capture export';

  @override
  String get coverage_historyTitle => 'Saved coverage sessions';

  @override
  String coverage_loadFailed(String error) {
    return 'Could not load sessions: $error';
  }

  @override
  String get coverage_deleteTitle => 'Delete saved session?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count observations will be removed from this device.',
      one: '1 observation will be removed from this device.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'Could not delete session: $error';
  }

  @override
  String get coverage_retention =>
      'The newest 20 completed sessions are retained. Share sessions you want to keep. Interrupted captures can be reopened below.';

  @override
  String get coverage_noSessions =>
      'No saved sessions yet. Stop a capture to save it.';

  @override
  String get coverage_interrupted => 'Interrupted capture';

  @override
  String get coverage_saved => 'Saved';

  @override
  String get coverage_deleteTooltip => 'Delete session';

  @override
  String coverage_exportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String get coverage_sessionTitle => 'Coverage session';

  @override
  String get coverage_shareJson => 'Share JSON';

  @override
  String get coverage_shareCsv => 'Share CSV';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • snapshot age $age ms';
  }

  @override
  String get coverage_unknown => 'unknown';

  @override
  String coverage_pathValue(String path) {
    return 'path $path';
  }

  @override
  String get coverage_recorder => 'Recorder';

  @override
  String get coverage_noCoordinates =>
      'No usable coordinates in this session. Observations remain available below.';

  @override
  String get coverage_osmAttribution =>
      '© OpenStreetMap contributors • online basemap';

  @override
  String get fieldStats_title => 'Field intelligence';

  @override
  String get fieldStats_snapshot => 'Live mesh snapshot';

  @override
  String get fieldStats_headline => 'What NOTORYX Core Ham knows right now.';

  @override
  String get fieldStats_body =>
      'These counters are calculated from the connected MeshCore contact table, locations, paths and last-seen timestamps.';

  @override
  String get fieldStats_total => 'Total';

  @override
  String get fieldStats_chatNodes => 'Chat nodes';

  @override
  String get fieldStats_rooms => 'Rooms';

  @override
  String get fieldStats_sensors => 'Sensors';

  @override
  String get fieldStats_located => 'Located';

  @override
  String get fieldStats_favorites => 'Favorites';

  @override
  String get fieldStats_routeSnapshot => 'Route snapshot';

  @override
  String get fieldStats_routed => 'Routed';

  @override
  String get fieldStats_direct => 'Direct';

  @override
  String get fieldStats_flood => 'Flood';

  @override
  String get fieldStats_pathIntel => 'Path intelligence';

  @override
  String get fieldStats_pathIntelBody =>
      'NOTORYX Core Ham’s Route Intelligence uses persisted path attempts, hop counts, success/failure, trip time and route weighting to surface learned routes.';

  @override
  String get fieldStats_coverageSessions => 'Coverage sessions';

  @override
  String get fieldStats_coverageSessionsBody =>
      'Coverage Capture now saves field sessions, restores interrupted work, exports observations and maps recorded coverage points. RSSI/SNR remain the nearest available radio snapshot.';

  @override
  String get mapHub_title => 'NOTORYX field map';

  @override
  String get mapHub_intro =>
      'Live maps, offline areas, regional profiles and NOTORYX Core Ham field coverage sessions.';

  @override
  String get mapHub_captureHint => 'Start and stop a field coverage session';

  @override
  String get mapHub_badgeNew => 'NEW';

  @override
  String get mapHub_liveMap => 'Live mesh map';

  @override
  String get mapHub_liveMapHint =>
      'Nodes, repeaters, positions, routes and map tools';

  @override
  String get mapHub_badgeLive => 'LIVE';

  @override
  String get mapHub_offlinePacks => 'Offline map packs';

  @override
  String get mapHub_offlinePacksHint =>
      'Cache map tiles for trips and no-service areas';

  @override
  String get mapHub_badgeOffline => 'OFFLINE';

  @override
  String get mapHub_regions => 'Region profiles';

  @override
  String get mapHub_regionsHint => 'Manage and fetch regional mesh definitions';

  @override
  String get mapHub_badgeRegions => 'REGIONS';

  @override
  String get routes_title => 'Route Intelligence';

  @override
  String get routes_headline => 'See how traffic moves through the mesh.';

  @override
  String get routes_body =>
      'NOTORYX Core Ham ranks saved routes using the path history already learned from real message attempts and discoveries.';

  @override
  String get routes_routes => 'Routes';

  @override
  String get routes_success => 'Success';

  @override
  String get routes_failed => 'Failed';

  @override
  String get routes_routeMap => 'Route map';

  @override
  String get routes_routeMapHint => 'Inspect nodes and paths';

  @override
  String get routes_discover => 'Discover';

  @override
  String get routes_discoverHint => 'Find fresh routes';

  @override
  String get routes_learned => 'Learned routes';

  @override
  String get routes_none => 'No route history yet';

  @override
  String get routes_noneBody =>
      'Use the mesh normally or run discovery. NOTORYX Core Ham will surface learned routes here as path history becomes available.';

  @override
  String get routes_direct => 'DIRECT';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count routes',
      one: '1 route',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return 'BEST  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  weight $weight  •  $success success / $fail fail';
  }

  @override
  String routes_fastest(String ms) {
    return 'Fastest known: $ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'Flood: $success success / $fail fail';
  }

  @override
  String get repeaterTools_heroLabel => 'Repeater command';

  @override
  String get repeaterTools_headline =>
      'Manage the infrastructure behind your mesh.';

  @override
  String get repeaterTools_body =>
      'Select a discovered repeater to authenticate and open its existing MeshCore status, telemetry, neighbors, settings and CLI tools.';

  @override
  String get repeaterTools_discovered => 'Discovered';

  @override
  String get repeaterTools_tools => 'Tools';

  @override
  String get repeaterTools_available => 'Available repeaters';

  @override
  String get repeaterTools_unnamed => 'Unnamed repeater';

  @override
  String get repeaterTools_statusTelemetry => 'Status + telemetry';

  @override
  String get repeaterTools_statusTelemetryBody =>
      'Inspect repeater health and telemetry using the existing management stack.';

  @override
  String get repeaterTools_neighbors => 'Neighbors';

  @override
  String get repeaterTools_neighborsBody =>
      'Inspect neighboring infrastructure and mesh relationships.';

  @override
  String get repeaterTools_cli => 'CLI + settings';

  @override
  String get repeaterTools_cliBody =>
      'Authenticated administrators can reach the existing repeater CLI and configuration tools.';

  @override
  String get repeaterTools_empty =>
      'No repeaters discovered yet. Connect a radio and discover the mesh first.';

  @override
  String get notification_fieldAlertTitle => 'NOTORYX Field Alert';

  @override
  String get notification_checkInReminderTitle =>
      'NOTORYX Core Ham check-in reminder';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return 'No check-in for $minutes minutes on $trip. Open NOTORYX Core Ham to check in.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return '$name not heard from in $minutes minutes. This is not a confirmed emergency.';
  }

  @override
  String get notification_aTripContact => 'A trip contact';

  @override
  String notification_checkInNotDelivered(String name) {
    return 'Check-in not delivered to $name. You can resend it from Trip.';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return 'SOS acknowledged by $name';
  }

  @override
  String get settings_batterySaver => 'Battery saver';

  @override
  String get settings_batterySaverOn =>
      'On: radio battery every 10 min, GPS every 5 min, stats at most once a minute, trip checks every 1–2 min. Messages, alerts and SOS are unchanged.';

  @override
  String get settings_batterySaverOff =>
      'Check the radio and trip less often to save phone and radio battery. Messages, alerts and SOS are unchanged.';

  @override
  String get settings_readAloud => 'Read new messages aloud';

  @override
  String get settings_readAloudHelper =>
      'While NOTORYX Core Ham is open. Muted channels stay quiet. Any message can also be read from its menu.';

  @override
  String get settings_readAloudOff => 'Off';

  @override
  String get settings_readAloudDirect => 'Direct messages';

  @override
  String get settings_readAloudAll => 'Direct and channel messages';

  @override
  String get chat_readAloud => 'Read aloud';

  @override
  String get messageSearch_title => 'Search messages';

  @override
  String get messageSearch_intro =>
      'Search every direct and channel message saved on this phone.';

  @override
  String messageSearch_noResults(String query) {
    return 'No messages contain \"$query\".';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count matches',
      one: '1 match',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return 'Showing the newest $count matches';
  }

  @override
  String get shortcuts_checkIn => 'Check in';

  @override
  String get shortcuts_trip => 'Trip';

  @override
  String get shortcuts_chats => 'Chats';

  @override
  String get shortcuts_map => 'Map';

  @override
  String get sensor_liveUpdates => 'Live updates';

  @override
  String get sensor_intro =>
      'Have the sensor send readings by itself when they change, instead of asking each time. Needs a login with read access.';

  @override
  String get sensor_watch => 'Watch for changes';

  @override
  String get sensor_loadFirst => 'Load telemetry first to choose readings.';

  @override
  String sensor_watching(String readings, String time) {
    return 'Watching $readings until $time.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return 'Watching $readings until $time • region $region.';
  }

  @override
  String get sensor_noChanges => 'No changes reported yet.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return 'Last update $time • $count received';
  }

  @override
  String get sensor_stop => 'Stop live updates';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'Stopped here; the sensor did not confirm and will stop when the time runs out. $error';
  }

  @override
  String get sensor_dialogBody =>
      'The sensor checks about once a minute and sends an update when a chosen reading changes by more than its threshold.';

  @override
  String sensor_readingTitle(String label, String channel) {
    return '$label (ch $channel)';
  }

  @override
  String sensor_readingValue(String label, String channel, String value) {
    return '$label (ch $channel): $value';
  }

  @override
  String sensor_watchItem(String label, String channel, String delta) {
    return '$label (ch $channel) ±$delta';
  }

  @override
  String sensor_updateOn(String delta) {
    return 'Update on a change of $delta';
  }

  @override
  String get sensor_changeThreshold => 'Change threshold';

  @override
  String sensor_capacity(int max, String used) {
    return 'The sensor can watch up to $max bytes of readings ($used used).';
  }

  @override
  String get sensor_for => 'For';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours',
      one: '1 hour',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => 'Start';

  @override
  String sensor_thresholdTitle(String label) {
    return '$label threshold';
  }

  @override
  String get sensor_typeTemperature => 'Temperature';

  @override
  String get sensor_typeHumidity => 'Humidity';

  @override
  String get sensor_typePressure => 'Pressure';

  @override
  String get sensor_typeVoltage => 'Voltage';

  @override
  String get sensor_typeCurrent => 'Current';

  @override
  String get sensor_typeLight => 'Light';

  @override
  String get sensor_typeConcentration => 'Concentration';

  @override
  String get sensor_typePercentage => 'Percentage';

  @override
  String get sensor_typeAnalogInput => 'Analog input';

  @override
  String get sensor_typeAltitude => 'Altitude';

  @override
  String get setupWizard_title => 'Connect your radio';

  @override
  String get setupWizard_choose => '1. Choose a connection';

  @override
  String get setupWizard_prepare => '2. Prepare your radio';

  @override
  String get setupWizard_intro =>
      'Choose how this phone or computer will connect to your radio. The radio carries messages over the mesh.';

  @override
  String get setupWizard_bluetooth =>
      'Wireless connection to a nearby compatible radio.';

  @override
  String get setupWizard_noBluetooth =>
      'Bluetooth is unavailable in this browser. Use the native app or a supported USB connection.';

  @override
  String get setupWizard_usb => 'A wired connection using a USB data cable.';

  @override
  String get setupWizard_noUsb =>
      'USB serial is unavailable here. Use a supported desktop or Android app, or Chrome with Web Serial.';

  @override
  String get setupWizard_bluetoothSteps =>
      'Power on your radio and keep it nearby. Enable Bluetooth and allow the app permission to use it. Close other apps connected to the radio, then open the device list and scan.';

  @override
  String get setupWizard_usbSteps =>
      'Connect a powered radio with a USB data cable; a charge-only cable will not work. Close other serial apps. Open the USB device list, select your radio, and allow access if prompted.';

  @override
  String get setupWizard_firmwareTitle =>
      'Check compatibility before changing firmware';

  @override
  String get setupWizard_firmware =>
      'Your radio needs NOTORYX Ham companion firmware that supports the selected connection. Support varies by board and firmware build; a USB socket alone does not confirm USB serial support. Check the instructions for your exact board and installed build. Repeater or room-server firmware is not a companion. A failed connection does not by itself mean you need to reflash.';

  @override
  String get setupWizard_settings =>
      'This guide does not flash firmware or change radio settings. After connecting, use Settings for region, frequency, and advanced options. Confirm settings with your local mesh before changing them.';

  @override
  String get setupWizard_openBluetooth => 'Open Bluetooth devices';

  @override
  String get setupWizard_openUsb => 'Open USB devices';

  @override
  String get setupWizard_change => 'Change connection type';

  @override
  String get setupWizard_later => 'Set up later';

  @override
  String get setupWizard_bluetoothError =>
      'Could not connect to the radio. Keep it powered and nearby, check Bluetooth permissions, and close other connected apps. Then scan and try again.';

  @override
  String get setupWizard_scanError =>
      'Could not scan for radios. Turn on Bluetooth and allow Bluetooth or Nearby devices access in system settings, then try scanning again.';

  @override
  String get setupWizard_usbError =>
      'Could not connect over USB. Check the data cable and selected device, allow USB access, and close other serial apps. Reconnect the cable and try again.';

  @override
  String get connections_title => 'Connections';

  @override
  String get connections_radioTitle => 'Radio connection';

  @override
  String get connections_bluetoothOffNotice =>
      'Bluetooth is off. Turn it on to reconnect; the app will retry once it is back.';

  @override
  String get connections_transport => 'Transport';

  @override
  String connections_lastError(String error) {
    return 'Last error: $error';
  }

  @override
  String get connections_disconnectRadio => 'Disconnect radio';

  @override
  String connections_reconnectTo(String name) {
    return 'Reconnect to $name';
  }

  @override
  String get connections_forgetRadio => 'Forget radio';

  @override
  String get connections_connectAnother => 'Connect another radio';

  @override
  String get connections_usbSerial => 'USB serial';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'Device';

  @override
  String get connections_publicKey => 'Public key';

  @override
  String get connections_firmware => 'Firmware';

  @override
  String connections_firmwareProtocol(String code) {
    return 'protocol v$code';
  }

  @override
  String get connections_battery => 'Battery';

  @override
  String get connections_lastRx => 'Last RX';

  @override
  String get connections_reconnectFailed => 'Could not reconnect to the radio';

  @override
  String get connections_statusBluetoothOff => 'Bluetooth is off';

  @override
  String get connections_statusConnected => 'Connected';

  @override
  String get connections_statusConnecting => 'Connecting…';

  @override
  String get connections_statusDisconnecting => 'Disconnecting…';

  @override
  String get connections_statusScanning => 'Scanning for radios…';

  @override
  String get connections_statusReconnectingSoon => 'Reconnecting soon…';

  @override
  String get connections_statusNotConnected => 'Not connected';

  @override
  String get mqtt_cardTitle => 'MQTT connection';

  @override
  String get mqtt_statusNotConfigured => 'Not configured';

  @override
  String get mqtt_statusDisconnected => 'Disconnected';

  @override
  String get mqtt_statusConnecting => 'Connecting';

  @override
  String get mqtt_statusConnected => 'Connected';

  @override
  String get mqtt_statusReconnecting => 'Reconnecting';

  @override
  String get mqtt_statusError => 'Connection error';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'Broker: $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn => 'Signs in with a radio-signed token';

  @override
  String mqtt_tokenSignInAs(String username) {
    return 'Signs in with a radio-signed token as $username…';
  }

  @override
  String get mqtt_connectRadioToSignIn => 'Connect your radio to sign in';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'Token renews at $time';
  }

  @override
  String mqtt_signedInAs(String username) {
    return 'Signed in as $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return 'Listening on $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'Packets: $accepted new, $duplicate duplicate, $invalid invalid';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return 'Retry $attempt of $max';
  }

  @override
  String get mqtt_sharingWaitsForRadio =>
      'Sharing waits for a radio connection';

  @override
  String mqtt_sharingOn(String topic) {
    return 'Sharing on $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return 'Will share on $topic';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'Online status on $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return 'Shared $shared, held back $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'Add a broker to bridge MeshCore traffic over the internet. Radio connection works independently.';

  @override
  String get mqtt_disconnect => 'Disconnect MQTT';

  @override
  String get mqtt_connect => 'Connect MQTT';

  @override
  String get mqtt_packetFeed => 'Packet feed';

  @override
  String get mqtt_setUpBroker => 'Set up broker';

  @override
  String get mqtt_brokerSettings => 'Broker settings';

  @override
  String get mqtt_settingsTitle => 'MQTT broker settings';

  @override
  String get mqtt_presetLabel => 'Start from a preset';

  @override
  String get mqtt_presetCustom => 'Custom broker';

  @override
  String get mqtt_presetLocal => 'Local broker (configure address)';

  @override
  String get mqtt_presetLetsMeshUs => 'LetsMesh analyzer (US, community)';

  @override
  String get mqtt_presetLetsMeshEu => 'LetsMesh analyzer (EU, community)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh is a community-run MeshCore packet analyzer, not part of NOTORYX and not endorsed by it. Sharing needs your radio connected and stays off until you turn it on.';

  @override
  String get mqtt_hostname => 'Broker hostname';

  @override
  String get mqtt_port => 'Port';

  @override
  String get mqtt_useTls => 'Use TLS';

  @override
  String get mqtt_allowCleartext => 'Allow cleartext to a local broker';

  @override
  String get mqtt_allowCleartextHint =>
      'Only localhost, .local and private 10.x / 192.168.x hosts.';

  @override
  String get mqtt_useWebSocket => 'Use WebSocket';

  @override
  String get mqtt_webSocketPath => 'WebSocket path';

  @override
  String get mqtt_topicPrefix => 'Topic prefix';

  @override
  String get mqtt_region => 'Region (optional)';

  @override
  String get mqtt_regionHelp =>
      'Observer region code such as PHL. Leave blank for all.';

  @override
  String get mqtt_deliverChannel => 'Add channel messages heard via MQTT';

  @override
  String get mqtt_deliverChannelHint =>
      'Messages on your channels that observers heard show up in your chats. They are not sent over your radio.';

  @override
  String get mqtt_sharingTitle => 'Sharing as an observer';

  @override
  String get mqtt_share => 'Share packets my radio hears';

  @override
  String get mqtt_shareHint =>
      'Publishes adverts and channel traffic your radio receives, with its public key, signal strength and region. Channel messages stay encrypted. Needs a region.';

  @override
  String get mqtt_shareDirect => 'Include direct-message traffic';

  @override
  String get mqtt_shareDirectHint =>
      'Requests, replies and direct messages. Contents stay encrypted, but this shows which nodes talk to each other.';

  @override
  String get mqtt_shareOwn => 'Include my own messages and adverts';

  @override
  String get mqtt_signInTitle => 'Sign-in';

  @override
  String get mqtt_authPassword => 'Username and password';

  @override
  String get mqtt_authToken => 'Radio-signed token';

  @override
  String get mqtt_tokenExplain =>
      'Your radio signs a one-hour sign-in token with its own key, and the app renews it before it runs out. The key never leaves the radio. The username is v1_ and your radio\'s public key.';

  @override
  String get mqtt_radioReady => 'Radio connected: ready to sign in.';

  @override
  String get mqtt_radioNeeded =>
      'Connect your radio to sign in. MQTT waits for it.';

  @override
  String get mqtt_username => 'Username (optional)';

  @override
  String get mqtt_password => 'Password';

  @override
  String get mqtt_keepPassword => 'Leave blank to keep the saved password.';

  @override
  String get mqtt_credentialsWeb =>
      'In the browser, credentials are kept only until the page is closed.';

  @override
  String get mqtt_credentialsKeychain =>
      'Credentials are stored in the system keychain, never in app settings or logs.';

  @override
  String get mqtt_saveSettings => 'Save settings';

  @override
  String get mqtt_feedTitle => 'MQTT packet feed';

  @override
  String get mqtt_feedConnect =>
      'Connect to a broker to see packets from observers.';

  @override
  String mqtt_feedWaiting(String topic) {
    return 'Waiting for packets on $topic';
  }

  @override
  String get mqtt_feedUnknownObserver => 'Unknown observer';

  @override
  String mqtt_feedHeardBy(String observer) {
    return 'Heard by $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return '$hops hops · $bytes bytes';
  }

  @override
  String get mqtt_packetRequest => 'Request';

  @override
  String get mqtt_packetResponse => 'Response';

  @override
  String get mqtt_packetDirectMessage => 'Direct message';

  @override
  String get mqtt_packetAck => 'Ack';

  @override
  String get mqtt_packetAdvert => 'Advert';

  @override
  String get mqtt_packetChannelMessage => 'Channel message';

  @override
  String get mqtt_packetChannelData => 'Channel data';

  @override
  String get mqtt_packetAnonymousRequest => 'Anonymous request';

  @override
  String get mqtt_packetPath => 'Path';

  @override
  String get mqtt_packetTrace => 'Trace';

  @override
  String get mqtt_packetMultipart => 'Multipart';

  @override
  String get mqtt_packetControl => 'Control';

  @override
  String mqtt_packetType(int type) {
    return 'Type $type';
  }

  @override
  String get mqtt_routeTransportFlood => 'Transport flood';

  @override
  String get mqtt_routeFlood => 'Flood';

  @override
  String get mqtt_routeDirect => 'Direct';

  @override
  String get mqtt_routeTransportDirect => 'Transport direct';

  @override
  String get mqtt_noticeInvalidHost =>
      'Enter a hostname or IPv4 address without a scheme or port.';

  @override
  String get mqtt_noticeInvalidPort => 'Port must be between 1 and 65535.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'WebSocket path must begin with / and contain no query or fragment.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'Topic prefix must be a nonempty MQTT path without wildcards.';

  @override
  String get mqtt_noticeInvalidRegion =>
      'Region must be 2-8 letters or digits, such as PHL.';

  @override
  String get mqtt_noticeTlsRequired =>
      'TLS is required unless insecure local broker access is explicitly enabled.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      'Cleartext MQTT is restricted to explicitly approved local hosts.';

  @override
  String get mqtt_noticeRegionNeededToShare =>
      'Set a region to share packets as an observer.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return 'Enter the password for $username.';
  }

  @override
  String get mqtt_noticeNoNetwork =>
      'No network connection. MQTT reconnects when it is back.';

  @override
  String get mqtt_noticeSubscriptionRefused =>
      'The broker refused the packet subscription.';

  @override
  String get mqtt_noticeBadCredentials =>
      'The broker rejected the username or password.';

  @override
  String get mqtt_noticeNotAuthorized =>
      'This account is not authorized on the broker.';

  @override
  String get mqtt_noticeConnectionRefused =>
      'The broker refused the connection.';

  @override
  String get mqtt_noticeUnreachable => 'The broker could not be reached.';

  @override
  String get mqtt_noticeTlsFailed =>
      'The secure (TLS) connection could not be established.';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'This platform only supports MQTT over WebSocket.';

  @override
  String get mqtt_noticeRadioNotConnected =>
      'Connect your radio to sign in with its key.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'This radio\'s firmware does not support signing with its key.';

  @override
  String get mqtt_noticeSigningTimeout =>
      'The radio did not answer the signing request. Its firmware may not support signing.';

  @override
  String get mqtt_noticeSigningTooLong =>
      'The data is too long for the radio to sign.';

  @override
  String get mqtt_noticeSigningRejected =>
      'The radio refused to sign the data.';

  @override
  String get scanner_signalStrong => 'Strong';

  @override
  String get scanner_signalGood => 'Good';

  @override
  String get scanner_signalFair => 'Fair';

  @override
  String get scanner_signalWeak => 'Weak';

  @override
  String get scanner_nearbyRadios => 'Nearby radios';

  @override
  String get scanner_lastRadio => 'Last radio';

  @override
  String get scanner_reconnect => 'Reconnect';

  @override
  String get scanner_tcpHint => 'A radio with Wi‑Fi firmware on your network.';

  @override
  String get scanner_otherWays => 'Other ways to connect';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count radios nearby',
      one: '1 radio nearby',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => 'Looking for radios…';

  @override
  String get scanner_findTitle => 'Find your radio';

  @override
  String get scanner_heroHint =>
      'Turn your radio on and keep it within a few meters. It needs NOTORYX Ham companion firmware.';

  @override
  String get scanner_tipsTitle => 'Can\'t see your radio?';

  @override
  String get scanner_tipPower => 'Check that it\'s switched on and awake.';

  @override
  String get scanner_tipFirmware =>
      'It needs NOTORYX Ham companion firmware. Repeaters and room servers don\'t show up here.';

  @override
  String get scanner_tipOtherDevice =>
      'A radio connects to one device at a time. Disconnect it from other phones or computers.';

  @override
  String get connections_internetBridge => 'Internet bridge';

  @override
  String get connections_noRadio => 'No radio';

  @override
  String get connections_radioSettings => 'Radio settings';

  @override
  String get connections_viewDashboard => 'View connection dashboard';

  @override
  String get channelDirectory_title => 'Channel directory';

  @override
  String get channelDirectory_subtitle =>
      'Find public hashtag channels near you';

  @override
  String get channelDirectory_search => 'Search channels or places';

  @override
  String get channelDirectory_nearYou => 'Near you';

  @override
  String get channelDirectory_all => 'All channels';

  @override
  String get channelDirectory_catAll => 'All';

  @override
  String get channelDirectory_catEmergency => 'Emergency';

  @override
  String get channelDirectory_catLocal => 'Local';

  @override
  String get channelDirectory_catGeneral => 'General';

  @override
  String get channelDirectory_catInterest => 'Interests';

  @override
  String get channelDirectory_catTest => 'Testing';

  @override
  String get channelDirectory_join => 'Join';

  @override
  String get channelDirectory_joined => 'Joined';

  @override
  String get channelDirectory_noMatches => 'No channels match your search.';

  @override
  String get channelDirectory_connectFirst =>
      'Connect your radio to join channels.';

  @override
  String get channelDirectory_slotsFull =>
      'All channel slots on your radio are in use. Remove a channel first.';

  @override
  String get channelDirectory_joinFailed =>
      'Could not add the channel. Try again.';

  @override
  String get channelDirectory_addHint =>
      'Missing a channel? Anyone can suggest one by editing the shared list on GitHub.';

  @override
  String get prefixTool_title => 'Repeater IDs';

  @override
  String get prefixTool_subtitle =>
      'Who uses an ID, which IDs clash, and free ones for a new repeater';

  @override
  String get prefixTool_width => 'Path ID size';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes-byte';
  }

  @override
  String get prefixTool_includeCompanions => 'Include companions and sensors';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return '$nodes nodes known · $used IDs in use · $shared shared';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return '$free of $space IDs free';
  }

  @override
  String get prefixTool_lookupHint => 'Look up an ID, e.g. 3D';

  @override
  String prefixTool_lookupFree(String id) {
    return 'No known node uses $id.';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nodes use $id',
      one: '1 node uses $id',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => 'Shared IDs';

  @override
  String get prefixTool_sharedHint =>
      'Paths through these IDs look the same unless the mesh uses longer IDs.';

  @override
  String get prefixTool_noShared => 'No shared IDs among the nodes you know.';

  @override
  String get prefixTool_free => 'Free IDs';

  @override
  String get prefixTool_shuffle => 'More suggestions';

  @override
  String get prefixTool_makeKey => 'Make a key';

  @override
  String get prefixTool_onlyKnown =>
      'Based only on nodes your radio has heard. A free ID here may still belong to a repeater you haven\'t heard.';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id is already used by $name.';
  }

  @override
  String get prefixTool_pickFree => 'Pick a free ID';

  @override
  String keyGen_title(String id) {
    return 'Key for ID $id';
  }

  @override
  String keyGen_searching(int tries) {
    return 'Searching… $tries keys tried';
  }

  @override
  String get keyGen_publicKey => 'Public key';

  @override
  String get keyGen_privateKey => 'Private key';

  @override
  String get keyGen_copy => 'Copy';

  @override
  String get keyGen_copied => 'Copied';

  @override
  String get keyGen_secretWarning =>
      'Keep the private key secret. Anyone who has it can pose as this node.';

  @override
  String get keyGen_howToUse =>
      'To use it on a repeater, open the repeater\'s settings, paste it as the private key and save. Companion radios need firmware that allows key import.';

  @override
  String get keyGen_tryAgain => 'Make another';

  @override
  String get regionSetup_title => 'Region setup';

  @override
  String get regionSetup_hubSubtitle =>
      'Place this repeater in your area\'s region tree';

  @override
  String get regionSetup_intro =>
      'Regions keep a message within an area instead of flooding the whole mesh. A repeater only forwards a region\'s messages if it carries that region, so give it its own region and every region above it.';

  @override
  String get regionSetup_where => 'Where is the repeater?';

  @override
  String get regionSetup_tree => 'Region tree';

  @override
  String get regionSetup_custom => 'Custom';

  @override
  String get regionSetup_region => 'Most local region';

  @override
  String get regionSetup_customLabel => 'Regions, broadest first';

  @override
  String regionSetup_invalidName(String name) {
    return '\"$name\" isn\'t a valid region name. Use lowercase letters, digits and hyphens, up to 29 characters.';
  }

  @override
  String regionSetup_tooMany(int max) {
    return 'A repeater can carry at most $max regions.';
  }

  @override
  String get regionSetup_options => 'Options';

  @override
  String get regionSetup_setDefault => 'Make the most local region the default';

  @override
  String get regionSetup_setDefaultBody =>
      'The repeater\'s own adverts stay in that region.';

  @override
  String get regionSetup_legacy => 'Firmware 1.14';

  @override
  String get regionSetup_legacyBody =>
      'Adds region allowf after each region. Not needed on 1.15 or newer.';

  @override
  String get regionSetup_denyUnscoped =>
      'Stop forwarding messages without a region';

  @override
  String get regionSetup_denyUnscopedBody =>
      'Only turn this on once your whole area uses regions, or messages from older apps won\'t get through.';

  @override
  String get regionSetup_commands => 'Commands';

  @override
  String get regionSetup_copyAll => 'Copy all';

  @override
  String get regionSetup_copied => 'Copied';

  @override
  String get regionSetup_pickFirst => 'Pick a region to see the commands.';

  @override
  String regionSetup_sendTo(String name) {
    return 'Send to $name';
  }

  @override
  String get regionSetup_howToSend =>
      'To send these, log in to the repeater and open Region setup from its menu, or paste them into its command line.';

  @override
  String get regionSetup_noReply => 'No reply. Stopped here.';

  @override
  String get regionSetup_addToMine => 'Add these regions to my list';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count regions added to your list',
      one: '1 region added to your list',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => 'Track log';

  @override
  String get trackLog_subtitle =>
      'Record a breadcrumb trail from your radio\'s GPS';

  @override
  String get trackLog_recording => 'Recording';

  @override
  String get trackLog_notRecording => 'Not recording';

  @override
  String get trackLog_noGps =>
      'Your radio isn\'t reporting a GPS position. The track log needs a radio with GPS turned on.';

  @override
  String get trackLog_start => 'Start recording';

  @override
  String get trackLog_stop => 'Stop recording';

  @override
  String get trackLog_howItWorks =>
      'Uses the position your radio reports, about once a minute, while NOTORYX Core Ham is open. A point is added after you move 25 m, or every 15 minutes when you stay put.';

  @override
  String get trackLog_snap => 'Round positions to about 100 m';

  @override
  String get trackLog_snapBody => 'For privacy when you share a track.';

  @override
  String get trackLog_saved => 'Saved tracks';

  @override
  String get trackLog_none => 'No tracks yet.';

  @override
  String get trackLog_export => 'Export as GPX';

  @override
  String get trackLog_exportFailed => 'Could not export the track.';

  @override
  String get trackLog_deleteTitle => 'Delete this track?';

  @override
  String get trackLog_deleteBody =>
      'It\'s removed from this device. Exported GPX files aren\'t affected.';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km km · $duration · $points points';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'NOTORYX track $when';
  }

  @override
  String get routes_nearbyTitle => 'Best repeaters near you';

  @override
  String get routes_nearbyEmptyTitle => 'No repeaters heard yet';

  @override
  String get routes_nearbyEmpty =>
      'Repeaters your radio hears directly show up here, strongest first, as it receives traffic. The list covers the last hour.';

  @override
  String get routes_unknownRepeater => 'Unknown repeater';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'heard $count times',
      one: 'heard once',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes min ago',
      one: '1 min ago',
      zero: 'just now',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return 'via $names';
  }

  @override
  String get nav_home => 'Home';

  @override
  String get nav_chats => 'Chats';

  @override
  String get nav_tools => 'Tools';

  @override
  String get nav_settings => 'Settings';

  @override
  String get nav_more => 'More';

  @override
  String get tools_groupApp => 'App & settings';

  @override
  String get tools_groupField => 'In the field';

  @override
  String get tools_groupMaps => 'Maps & coverage';

  @override
  String get tools_groupRouting => 'Routes & repeaters';

  @override
  String get tools_pathGraph => 'Path graph';

  @override
  String get tools_pathGraphHint =>
      'How messages reach you: every path heard, with the busiest repeaters';

  @override
  String get tools_antenna => 'Antenna coverage';

  @override
  String get tools_antennaHint =>
      'Estimate where an antenna can reach over the terrain';

  @override
  String routes_repeaterWithId(String id) {
    return 'Repeater $id';
  }

  @override
  String get coverageHex_title => 'Coverage hexagons';

  @override
  String get coverageHex_toolSubtitle =>
      'Map where your radio hears the mesh and share it';

  @override
  String get coverageHex_mapCoverage => 'Map coverage';

  @override
  String get coverageHex_statusOff =>
      'Off. Turn on while you drive or walk to map where your radio hears the mesh.';

  @override
  String get coverageHex_waitingGps => 'Waiting for GPS…';

  @override
  String coverageHex_gpsTooRough(String meters) {
    return 'GPS accuracy $meters m: too rough, not recording.';
  }

  @override
  String coverageHex_recording(String meters) {
    return 'Recording. GPS accuracy $meters m.';
  }

  @override
  String get coverageHex_hexagons => 'Hexagons';

  @override
  String get coverageHex_samples => 'Samples';

  @override
  String get coverageHex_privacyNote =>
      'Uses the phone’s GPS while this switch is on. Only hexagon IDs (about 0.9 km across) are shared, never your exact position.';

  @override
  String get coverageHex_uploadSection => 'Upload to coverage maps';

  @override
  String get coverageHex_wifiOnly => 'Upload on Wi-Fi only';

  @override
  String get coverageHex_wifiOnlyHint =>
      'Samples wait on the phone (up to 7 days) until Wi-Fi.';

  @override
  String coverageHex_waiting(String count) {
    return '$count waiting';
  }

  @override
  String get coverageHex_addMap => 'Add a coverage map';

  @override
  String get coverageHex_addMapHint =>
      'Any HTTPS endpoint that accepts coverage uploads.';

  @override
  String get coverageHex_uploadNow => 'Upload now';

  @override
  String get coverageHex_mapDialogTitle => 'Coverage map';

  @override
  String get coverageHex_nameMissing => 'Give it a name.';

  @override
  String get coverageHex_url => 'Upload URL';

  @override
  String get coverageHex_urlInvalid => 'Must be an https:// URL.';

  @override
  String get coverageHex_apiKey => 'API key (optional)';

  @override
  String get coverageHex_apiKeyHint => 'Sent as X-API-Key.';

  @override
  String get coverageHex_format => 'Format';

  @override
  String get coverageHex_formatHex => 'Hexagon IDs (NOTORYX)';

  @override
  String get coverageHex_formatMeshMapper => 'MeshMapper-compatible';

  @override
  String get coverageHex_privacy => 'Privacy';

  @override
  String get coverageHex_privacyLive => 'Live';

  @override
  String get coverageHex_privacyDelayed => 'Delayed 3 h';

  @override
  String get coverageHex_privacyAnonymous => 'Anonymous, 24 h';

  @override
  String get coverageHex_privacyLiveHint => 'Sent within about 15 minutes.';

  @override
  String get coverageHex_privacyDelayedHint =>
      'Held 3 hours so the map can’t show where you are now.';

  @override
  String get coverageHex_privacyAnonymousHint =>
      'Held 24 hours, dated by day only, and unsigned so uploads can’t be linked.';

  @override
  String get coverageHex_uploadsOn => 'Uploads on';

  @override
  String coverageHex_sent(String count, String time) {
    return 'Sent $count cells at $time.';
  }

  @override
  String coverageHex_httpError(String code) {
    return 'The map answered $code; will retry.';
  }

  @override
  String get coverageHex_unreachable => 'Couldn’t reach the map; will retry.';

  @override
  String get coverageHex_noPermission => 'Location permission was not granted.';

  @override
  String get coverageHex_noGps => 'GPS isn’t available.';

  @override
  String get coverageHex_loadFailed =>
      'Saved coverage couldn’t be read; starting fresh.';

  @override
  String get mqttExtra_wifiOnly => 'Connect on Wi-Fi only';

  @override
  String mqttExtra_backlog(String count) {
    return '$count packets waiting to upload (kept up to 72 hours).';
  }

  @override
  String get mqttExtra_add => 'Add another broker';

  @override
  String get mqttExtra_addBody =>
      'Shares what your radio hears with one more MQTT broker, beside your main one. It only uploads; it never feeds packets back into the app.';

  @override
  String get mqttExtra_separateKey => 'Use a separate key';

  @override
  String get mqttExtra_separateKeyHint =>
      'Signs in with a key made on this phone instead of the radio’s, so this broker can’t tie uploads to your radio.';

  @override
  String mqttExtra_removeTitle(String name) {
    return 'Remove $name?';
  }

  @override
  String get mqttExtra_removeBody =>
      'Disconnects and forgets its settings, password, key and any packets still waiting to upload.';

  @override
  String mqttExtra_ownKey(String key) {
    return 'Signs in with its own key: $key…';
  }

  @override
  String get botWx_title => 'Post weather alerts to a channel';

  @override
  String get botWx_body =>
      'Checks the US National Weather Service every 10 minutes for severe and extreme warnings at the radio’s GPS position (rounded to about 1 km), and posts each new one once. Needs phone internet.';

  @override
  String get botWx_channel => 'Post to channel';

  @override
  String get botWx_moderate => 'Include moderate alerts';

  @override
  String get botWx_moderateHint => 'Advisories as well as warnings. Busier.';

  @override
  String botWx_lastChecked(String time) {
    return 'Last checked $time.';
  }

  @override
  String get botWx_noPosition =>
      'The radio hasn’t reported a GPS position yet.';

  @override
  String get botWx_noChannel => 'Choose a channel to post alerts to.';

  @override
  String get botWx_channelGone => 'The chosen channel no longer exists.';

  @override
  String botWx_httpError(String code) {
    return 'Weather Service answered $code.';
  }

  @override
  String get botWx_unreachable => 'Couldn’t reach the Weather Service.';

  @override
  String get botCmd_sun => 'Sunrise and sunset at the radio’s GPS position.';

  @override
  String get botCmd_moon => 'Moon phase and how much is lit.';

  @override
  String get botCmd_weather =>
      'Current weather at the radio (Open-Meteo). Sends the position, rounded to about 1 km.';

  @override
  String get botCmd_dice => 'Rolls dice: !dice, !dice 20 or !dice 2d6.';

  @override
  String get botCmd_trace =>
      'Lists the repeaters the sender’s message came through.';

  @override
  String get ping_title => 'Repeater ping';

  @override
  String get ping_toolSubtitle =>
      'Round-trip time and signal both ways to a nearby repeater';

  @override
  String get ping_noRepeaters => 'No repeaters known yet';

  @override
  String get ping_choose => 'Choose a repeater';

  @override
  String get ping_avgMs => 'ms round trip';

  @override
  String get ping_snrThere => 'SNR there';

  @override
  String get ping_snrBack => 'SNR back';

  @override
  String get ping_loss => 'Lost';

  @override
  String ping_running(int done, int total) {
    return 'Pinging $done of $total…';
  }

  @override
  String ping_start(int count) {
    return 'Ping $count times';
  }

  @override
  String get ping_results => 'Probes';

  @override
  String get ping_noReply => 'No reply';

  @override
  String ping_resultLine(String ms, String snr) {
    return '$ms ms · SNR there $snr';
  }

  @override
  String get ping_explainer =>
      'Each probe is a one-hop path trace: the repeater notes how well it heard you and repeats it back. It works for repeaters your radio hears directly.';

  @override
  String get hunt_title => 'Antenna hunt';

  @override
  String get hunt_toolSubtitle =>
      'A big live signal meter that clicks faster as it gets stronger';

  @override
  String get hunt_noSignal => 'No signal yet';

  @override
  String get hunt_noReply => 'No reply — move or turn the antenna';

  @override
  String get hunt_heardHere => 'dB heard here';

  @override
  String get hunt_best => 'Best';

  @override
  String get hunt_sound => 'Click as it gets stronger';

  @override
  String get hunt_soundHint =>
      'With a vibration on each click, so you can aim without looking.';

  @override
  String get hunt_stop => 'Stop';

  @override
  String get hunt_start => 'Start hunting';

  @override
  String get hunt_explainer =>
      'Probes the repeater about once a second. Point a directional antenna or walk around: the number is how well your radio hears it.';

  @override
  String get settings_refreshRate => 'Radio refresh rate';

  @override
  String get settings_refreshFast => 'Fast';

  @override
  String get settings_refreshNormal => 'Normal';

  @override
  String get settings_refreshSlow => 'Slow';

  @override
  String get settings_refreshFastHint =>
      'Battery every minute, GPS every 30 s. Fresher numbers, more battery.';

  @override
  String get settings_refreshNormalHint =>
      'Battery every 2 minutes, GPS every minute.';

  @override
  String get settings_refreshSlowHint =>
      'Battery every 6 minutes, GPS every 3 minutes. Saves battery.';

  @override
  String get settings_refreshSaverOn =>
      'Battery saver is on, so it sets the pace (battery every 10 minutes).';

  @override
  String get reach_check => 'Check observer reach';

  @override
  String get reach_title => 'Observer reach';

  @override
  String get reach_noHash =>
      'This message can’t be looked up yet: no repeater has echoed it back to your radio, so its packet ID isn’t known.';

  @override
  String get reach_unreachable =>
      'Couldn’t reach the analyzer. Check your internet connection or the analyzer address in Settings.';

  @override
  String get reach_none =>
      'No observer has heard it yet. Observers upload a little after hearing a packet, so check again in a minute.';

  @override
  String get reach_observers => 'observers';

  @override
  String get reach_maxHops => 'max hops';

  @override
  String get reach_bestSnr => 'best SNR';

  @override
  String reach_hops(int count) {
    return '$count hops away';
  }

  @override
  String get reach_explainer =>
      'From the online analyzer: observers that heard this packet and uploaded it.';

  @override
  String get reach_checkAgain => 'Check again';

  @override
  String get analyzer_title => 'Online analyzer';

  @override
  String get analyzer_url => 'Analyzer address';

  @override
  String get analyzer_urlHint =>
      'A CoreScope analyzer (https://). Use the one that covers your region.';

  @override
  String get analyzer_reset => 'Default';

  @override
  String get analyzer_hint =>
      'Used to check which observers heard your messages. A check sends only the packet ID.';

  @override
  String get analyzer_hopLookup => 'Name unknown repeaters online';

  @override
  String get analyzer_hopLookupHint =>
      'When a repeater ID isn’t in your contacts, ask the analyzer for its name. Sends the short IDs only. A name ending in “?” means several repeaters share that ID.';

  @override
  String discovered_tray(int count) {
    return 'Channels heard nearby: $count';
  }

  @override
  String get discovered_title => 'Heard nearby, not joined';

  @override
  String discovered_heard(int count, String time) {
    return 'Heard $count× · last $time';
  }

  @override
  String get discovered_ignore => 'Ignore';

  @override
  String get discovered_ignoreAll => 'Ignore all';

  @override
  String get discovered_joinAll => 'Join all';

  @override
  String get discovered_explainer =>
      'These are public channels from the channel directory that your radio has heard traffic on. Each was confirmed by decrypting a message with its key. Ignored channels stay hidden.';

  @override
  String get mqtt_presetMeshRank => 'MeshRank (community)';

  @override
  String get mqtt_presetMeshRankNote =>
      'MeshRank is a community-run MeshCore network ranking, not part of NOTORYX and not endorsed by it. No sign-in: packets are shared under your radio’s key and region code, and only once you turn sharing on.';

  @override
  String get pathFilter_title => 'Path-width filter';

  @override
  String get pathFilter_firmwareNote =>
      'Needs repeater firmware with forwarding rules (mikecarper/MeshCore). Official MeshCore firmware rejects these commands.';

  @override
  String get pathFilter_width => 'Path width';

  @override
  String get pathFilter_anyWidth => 'Any width';

  @override
  String pathFilter_bytes(int n) {
    return '$n-byte paths';
  }

  @override
  String get pathFilter_twoOrMore => '2 or 3 bytes (2+)';

  @override
  String get pathFilter_path => 'Applies to';

  @override
  String get pathFilter_radio => 'Radio floods';

  @override
  String get pathFilter_bridge => 'Bridge';

  @override
  String get pathFilter_cross => 'Crossover';

  @override
  String get pathFilter_bridgeCross => 'Bridge and crossover';

  @override
  String get pathFilter_limit => 'Limit instead of drop';

  @override
  String get pathFilter_limitOn => 'Forwards up to a set number per minute.';

  @override
  String get pathFilter_drop => 'Matching floods are dropped, not forwarded.';

  @override
  String get pathFilter_perMinute => 'Per minute';

  @override
  String get pathFilter_rateInvalid => 'Enter 1 to 65534.';

  @override
  String get pathFilter_reviewNote =>
      'This only fills in the command line. Check it, then press Send. Use “get fr” first to see existing rules.';

  @override
  String get pathFilter_useCommand => 'Use command';

  @override
  String get settings_linkPreviews => 'Link previews';

  @override
  String get settings_linkPreviewsHint =>
      'Shows the title of a link in a message. Off by default: fetching the page tells that site your IP address.';

  @override
  String get guide_title => 'Field guide';

  @override
  String get guide_subtitle =>
      'Basics, cold-weather batteries, solar and antennas';

  @override
  String get guide_secMesh => 'Getting on the mesh';

  @override
  String get guide_mesh1 =>
      'Your phone talks to your radio over Bluetooth, USB or Wi-Fi; the radio talks to the mesh over LoRa. Messages still work with no phone signal.';

  @override
  String get guide_mesh2 =>
      'Repeaters pass messages along; each relay is a hop. Fewer hops means faster, more reliable delivery.';

  @override
  String get guide_mesh3 =>
      'Keep messages short and avoid flooding busy channels: every message uses shared airtime.';

  @override
  String get guide_secCold => 'Batteries in the cold';

  @override
  String get guide_cold1 =>
      'Don’t charge lithium batteries below freezing (0 °C / 32 °F): it damages them permanently.';

  @override
  String get guide_cold2 =>
      'Carry the radio inside your jacket. Cold cuts capacity, but it comes back once the battery warms up.';

  @override
  String get guide_cold3 =>
      'For fixed sites in cold climates, LiFePO4 copes better than lithium-ion; a heated or insulated box helps either.';

  @override
  String get guide_secSolar => 'Solar for repeaters';

  @override
  String get guide_solar1 =>
      'A repeater uses very little power, but size the panel and battery for your darkest winter week, not a summer day.';

  @override
  String get guide_solar2 =>
      'Face the panel toward the equator and tilt it steeply in winter; keep snow and shade off it.';

  @override
  String get guide_secAntenna => 'Antennas and placement';

  @override
  String get guide_ant1 =>
      'Height beats power: a radio a few metres up reaches far more than one on a desk.';

  @override
  String get guide_ant2 =>
      'Keep the antenna vertical and clear of metal, and use one made for your band (for example 915 MHz in North America).';

  @override
  String get guide_secMore => 'Learn more';

  @override
  String get guide_moreMeshcore => 'The official MeshCore project';

  @override
  String get guide_moreCascadia =>
      'Community guides: getting started, wardriving, regions, solar';

  @override
  String get post_signed => 'Signed';

  @override
  String get post_unverified => 'Unverified';

  @override
  String post_signedKnown(String name) {
    return 'Signed by $name, one of your contacts.';
  }

  @override
  String get post_signedUnknownKey =>
      'Signed, but not by any of your contacts. Add the sender as a contact to see who it is.';

  @override
  String get post_unverifiedHint =>
      'A signature came with this post but didn’t match it. The post may have been changed on the way, or it may not be from who it says.';

  @override
  String get settings_signPosts => 'Sign all my channel posts';

  @override
  String get settings_signPostsHint =>
      'An SOS on a channel is always signed. This signs every post, so other NOTORYX users can tell it’s really you. Each signature is one extra packet on air.';

  @override
  String get tools_search => 'Search tools and settings';

  @override
  String get tools_noMatches => 'No tools match your search.';

  @override
  String get tools_bot => 'Bot Mode';

  @override
  String get tools_botHint =>
      'Auto replies, !commands and weather alerts on channels';

  @override
  String get botChannels_title => 'Channels';

  @override
  String get botChannels_hint =>
      'The bot also answers !commands in the channels you turn on, in that channel. It never sends away replies there.';

  @override
  String get botChannels_none => 'No channels on this radio yet.';

  @override
  String get advert_zeroHopHint =>
      'Only radios that hear you directly. Repeaters don’t pass it on.';

  @override
  String get advert_floodHint =>
      'Repeaters pass it across the whole mesh. Uses more airtime.';

  @override
  String get radioPresets_custom => 'Custom';

  @override
  String get radioPresets_search => 'Search presets';

  @override
  String get radioPresets_suggested => 'Suggested for your region';

  @override
  String get radioPresets_community => 'Community presets';

  @override
  String get radioPresets_hint =>
      'These are the presets the MeshCore community suggests. Pick the one your local mesh runs. A preset sets frequency, bandwidth, spreading factor and coding rate; your transmit power stays as it is.';

  @override
  String get mySensors_title => 'Sensors';

  @override
  String get mySensors_refresh => 'Read sensors';

  @override
  String get mySensors_reading => 'Reading your radio’s sensors…';

  @override
  String get mySensors_failed =>
      'Your radio didn’t answer. Tap refresh to try again.';

  @override
  String get mySensors_none => 'No sensor readings from your radio.';

  @override
  String get activeChannels_title => 'Active online';

  @override
  String activeChannels_messages(int count) {
    return '$count messages';
  }

  @override
  String activeChannels_source(String host) {
    return 'Channels people are using, as heard by the observers of $host. Change the analyzer in Settings to see your area.';
  }

  @override
  String get fieldOps_checkInChannelLabel => 'Check-ins also go to channel';

  @override
  String get fieldOps_checkInChannelHint =>
      'Signed with your radio’s key, so others on the channel can see it’s really you. Trip contacts still get it directly.';

  @override
  String get channels_regionUnknown => 'Regional';

  @override
  String channels_regionSemantics(String region) {
    return 'Sent to region $region';
  }

  @override
  String get channels_regionUnknownSemantics =>
      'Sent to a region this app doesn’t know';

  @override
  String get wardrive_title => 'Wardrive';

  @override
  String get wardrive_hint =>
      'Ping from where you are and map which repeaters hear you';

  @override
  String get wardrive_start => 'Start';

  @override
  String get wardrive_stop => 'Stop';

  @override
  String get wardrive_pings => 'pings';

  @override
  String get wardrive_heard => 'heard';

  @override
  String get wardrive_pinging => 'Pinging…';

  @override
  String get wardrive_waitPosition =>
      'Waiting for a GPS fix from your phone or radio.';

  @override
  String get wardrive_waitRadio => 'Connect a radio to ping.';

  @override
  String get wardrive_history => 'History';

  @override
  String get wardrive_noSessions => 'No drives yet.';

  @override
  String wardrive_sessionSummary(int pings, int heard) {
    return '$pings pings · $heard heard';
  }

  @override
  String get wardrive_delete => 'Delete';

  @override
  String get wardrive_recentre => 'Back to my position';

  @override
  String get wardrive_youAreHere => 'You are here';

  @override
  String get wardrive_backToLive => 'Back to live drive';

  @override
  String get wardrive_noReplies => 'No repeater heard this ping.';

  @override
  String wardrive_replyDetail(String there, String here) {
    return 'Heard you at $there dB · you heard it at $here dB';
  }

  @override
  String get wardrive_explainer =>
      'Each ping is a zero-hop discover request: only repeaters in direct range answer, and nothing is posted to a channel. Positions come from your phone’s GPS, or your radio’s when the phone has none.';

  @override
  String get mapTelemetry_policy =>
      'Cached readings dim after 1 hour and disappear after 24 hours. Refresh sends one request; the node must allow telemetry and sensors may require login. The map never requests updates automatically.';

  @override
  String get autoConnect_title => 'Connect to my radio automatically';

  @override
  String get autoConnect_hint =>
      'When the app opens, reconnect to your last radio without a tap. It tries a few times if the radio isn’t in range yet.';

  @override
  String get ham_licensedOperator => 'Licensed operator';

  @override
  String get ham_operatorIntro =>
      'NOTORYX Core Ham radios transmit under an amateur licence (FCC Part 97). Everything sent is readable by anyone, and every frame carries the call sign at the start of the radio\'s name.';

  @override
  String get ham_yourStation => 'Your station';

  @override
  String get ham_callSign => 'Call sign';

  @override
  String get ham_notUsCallsign => 'Not a US call sign';

  @override
  String get ham_licenceClass => 'Licence class';

  @override
  String get ham_licenceClassHelper =>
      'Every class has full 33 cm and 70 cm privileges';

  @override
  String get ham_antennaSystem => 'Antenna system';

  @override
  String get ham_antennaSystemHint =>
      'For the power estimate below. Leave 0 for anything you don\'t have.';

  @override
  String get ham_externalAmpGain => 'External amplifier gain';

  @override
  String get ham_feedlineLoss => 'Feedline loss';

  @override
  String get ham_antennaGain => 'Antenna gain';

  @override
  String get ham_coordination => 'Coordination';

  @override
  String get ham_coordinationNotice =>
      'Use NOTORYX Core Ham only after a great deal of coordination. Radios and repeaters transmit automatically on shared bands, so before any radio goes on the air, talk to your frequency coordinator, follow the local band plan and agree one channel with every operator in your area.';

  @override
  String get ham_readCoordinationGuide => 'Read the coordination guide';

  @override
  String get ham_acknowledgment =>
      'I hold this licence, I have read the coordination guide, and I will coordinate before transmitting.';

  @override
  String get ham_operatorSaved => 'Operator saved';

  @override
  String get ham_connectedRadio => 'Connected radio';

  @override
  String get ham_nodeName => 'Node name';

  @override
  String get ham_nodeNameOk => 'Starts with your call sign';

  @override
  String get ham_nodeNameBad =>
      'Must start with your call sign, or the radio stays silent';

  @override
  String ham_setNameTo(String callsign) {
    return 'Set to $callsign';
  }

  @override
  String get ham_frequency => 'Frequency';

  @override
  String get ham_inHamBand => 'In a ham band';

  @override
  String get ham_outsideHamBands => 'Outside 420–450 / 902–928 MHz';

  @override
  String get ham_txPowerSetting => 'TX power setting';

  @override
  String get ham_chipSetting => 'The radio chip\'s setting';

  @override
  String get ham_firmware => 'Firmware';

  @override
  String get ham_estimatedOutput => 'Estimated output';

  @override
  String get ham_estimatedErp => 'Estimated ERP';

  @override
  String get ham_unknown => 'unknown';

  @override
  String get ham_unknownBoard => 'Unknown board: counted as no amplifier';

  @override
  String get ham_ampNone => 'no amplifier';

  @override
  String ham_ampGain(String db) {
    return 'about +$db dB from its amplifier';
  }

  @override
  String get ham_ampVariable => 'depends on its amplifier level setting';

  @override
  String ham_boardNote(String board, String note) {
    return '$board: $note';
  }

  @override
  String ham_measureFirst(String board) {
    return '$board. Measure it before relying on any estimate.';
  }

  @override
  String ham_outputNote(String board) {
    return '$board. An estimate: measure to be sure, and use the least power that works.';
  }

  @override
  String get ham_overSpreadSpectrum =>
      'Above 10 W PEP, the limit for spread spectrum such as LoRa (§97.311). Turn it down.';

  @override
  String get ham_erpNote =>
      'After feedline loss and antenna gain, relative to a dipole. Check RF exposure (§97.13) at higher power.';

  @override
  String get ham_location => 'Location';

  @override
  String get ham_noLocationLimits => 'no band limits found';

  @override
  String get ham_locationOkNote =>
      'From the radio\'s position. Check §97.303 to be sure.';

  @override
  String get ham_check => 'check';

  @override
  String get ham_positionUnknown =>
      'Position unknown: check §97.303 for limits where you operate.';

  @override
  String get ham_exclusion33cm =>
      'This area appears to be inside a §97.303(g) exclusion: amateur stations may not transmit on 33 cm here.';

  @override
  String get ham_lineA =>
      'If you are north of Line A (near the Canadian border), 420–430 MHz isn\'t available. Check §97.303.';

  @override
  String get ham_statusOk => 'OK';

  @override
  String get ham_needsAttention => 'Needs attention';

  @override
  String get ham_setupBanner =>
      'Finish licensed operator setup before transmitting';

  @override
  String get ham_setUp => 'Set up';

  @override
  String get ham_operatorCardIncomplete =>
      'Set your call sign and read the coordination guide';

  @override
  String get ham_nodeNameCallsignHelper =>
      'Start with your call sign, like \"W1AW\" or \"W1AW Base\"';

  @override
  String get ham_repeaterNameNeedsCall =>
      'The name must start with the repeater\'s call sign, like \"N0RPT Hilltop\".';

  @override
  String get ham_repeaterPasswordsSerial =>
      'Set passwords on the repeater\'s USB serial console. Sent over the air, anyone could read them.';

  @override
  String get networks_title => 'Networks';

  @override
  String get networks_hint => 'Scan for networks nearby and keep a log';

  @override
  String get networks_yourNetwork => 'Your network';

  @override
  String get networks_scanTitle => 'Scan for networks';

  @override
  String get networks_scanExplainer =>
      'Your radio only hears networks that use its exact settings, so a scan switches it to each one in turn, listens, then switches it back. You\'re off your own mesh while it scans.';

  @override
  String get networks_listenFor => 'Listen on each';

  @override
  String networks_choose(int count) {
    return 'Networks to scan: $count';
  }

  @override
  String get networks_suggested => 'Suggested';

  @override
  String get networks_start => 'Start scan';

  @override
  String get networks_cancel => 'Stop scan';

  @override
  String networks_listening(String name, int step, int steps) {
    return 'Listening on $name ($step of $steps)';
  }

  @override
  String get networks_blockNoRadio => 'Connect a radio to scan.';

  @override
  String get networks_blockSettings => 'Waiting for your radio\'s settings.';

  @override
  String get networks_blockSos =>
      'Not while an SOS is active: a scan takes you off your mesh.';

  @override
  String get networks_blockTrip =>
      'Not during a trip: a scan takes you off your mesh.';

  @override
  String get networks_nearby => 'Networks nearby';

  @override
  String get networks_nothingYet =>
      'No networks heard yet. Run a scan to look for some.';

  @override
  String networks_heardSummary(int nodes, int packets, String snr) {
    return 'Nodes $nodes · packets $packets · SNR $snr dB';
  }

  @override
  String networks_lastHeard(String time) {
    return 'Last heard $time';
  }

  @override
  String networks_timesHeard(int count) {
    return 'Times heard: $count';
  }

  @override
  String get networks_saved => 'Saved networks';

  @override
  String get networks_noSaved => 'No saved networks yet.';

  @override
  String get networks_add => 'Add a network';

  @override
  String get networks_join => 'Join';

  @override
  String networks_joinConfirm(String name) {
    return 'Switch your radio to $name? You\'ll leave your current network. Your transmit power stays the same.';
  }

  @override
  String networks_joined(String name) {
    return 'Your radio is on $name now.';
  }

  @override
  String get networks_log => 'Network log';

  @override
  String get networks_logEmpty => 'Nothing logged yet.';

  @override
  String get networks_showMap => 'Map';

  @override
  String get networks_exportCsv => 'Export CSV';

  @override
  String get networks_exportGpx => 'Export GPX';

  @override
  String get networks_clearLog => 'Clear log';

  @override
  String get networks_clearLogConfirm =>
      'Delete every logged network sighting?';

  @override
  String get networks_name => 'Name';

  @override
  String get networks_invalid =>
      'Check the settings: they\'re outside what MeshCore radios accept.';

  @override
  String get networks_nodesHeard => 'Nodes heard';

  @override
  String get chat_resendNeedsRadio =>
      'Not sent: connect your radio, then try again. The message is kept.';

  @override
  String get quick_title => 'Quick messages';

  @override
  String get quick_ok => 'OK';

  @override
  String get quick_onMyWay => 'On my way';

  @override
  String get quick_atCamp => 'At camp';

  @override
  String get quick_runningLate => 'Running late';

  @override
  String get quick_needHelp => 'Need help';

  @override
  String get quick_copyThat => 'Copy that';

  @override
  String get quick_empty => 'No quick messages. Tap Edit to add one.';

  @override
  String get quick_add => 'New quick message';

  @override
  String get quick_reset => 'Reset to the defaults';

  @override
  String get chat_stopRetrying => 'Stop retrying';

  @override
  String chat_addFirstBanner(String name) {
    return '$name can only read and answer your direct messages after adding you as a contact. If they haven\'t, send your advert or share your contact with them.';
  }

  @override
  String get map_goToMyPosition => 'Go to my position';

  @override
  String get map_positionUnavailable =>
      'Your position isn\'t available. Turn on location, or set your radio\'s position.';

  @override
  String get contact_forgetAdvert => 'Forget last advert';

  @override
  String get contact_forgetAdvertHint =>
      'If this node\'s adverts stopped updating after its clock was reset, Forget last advert lets the next one through.';

  @override
  String get contact_forgetAdvertDone =>
      'Done. The next advert from this node will be accepted.';

  @override
  String get networks_modeQuick => 'Quick';

  @override
  String get networks_modeThorough => 'Thorough';

  @override
  String get networks_modeQuickHint =>
      'Sends one short zero-hop ping on each network and listens a few seconds. Finds networks with a repeater in range.';

  @override
  String get networks_modeThoroughHint =>
      'Only listens, longer on each network. Sends nothing, and also finds networks without a repeater in range if someone transmits.';

  @override
  String networks_estimate(String time) {
    return 'about $time';
  }

  @override
  String discoveredContacts_selected(int count) {
    return '$count selected';
  }

  @override
  String get discoveredContacts_selectAll => 'Select all';

  @override
  String get discoveredContacts_addSelected => 'Add selected';

  @override
  String discoveredContacts_addAllShown(int count) {
    return 'Add all shown ($count)';
  }

  @override
  String discoveredContacts_addManyTitle(int count) {
    return 'Add $count contacts?';
  }

  @override
  String discoveredContacts_roomLeft(int room) {
    return 'Your radio has room for $room more contacts.';
  }

  @override
  String discoveredContacts_roomLimit(int room, int count) {
    return 'Your radio has room for $room more contacts, so only the first $room of $count will be added.';
  }

  @override
  String discoveredContacts_adding(int done, int total) {
    return 'Adding $done of $total…';
  }

  @override
  String discoveredContacts_addedMany(int count) {
    return 'Contacts added: $count';
  }

  @override
  String discoveredContacts_addedSome(int added, int failed) {
    return 'Contacts added: $added. Not added: $failed.';
  }

  @override
  String get discoveredContacts_radioFull =>
      'Your radio\'s contact list is full. Remove some contacts first.';

  @override
  String get fieldIntel_radioNow => 'Radio right now';

  @override
  String get fieldIntel_noRadio => 'Connect your radio for live readings.';

  @override
  String get fieldIntel_noise => 'noise dBm';

  @override
  String get fieldIntel_lastSnr => 'last SNR';

  @override
  String get fieldIntel_lastRssi => 'last RSSI';

  @override
  String get fieldIntel_battery => 'battery V';

  @override
  String fieldIntel_airtime(String sent, String received) {
    return 'Airtime since the radio started: sent $sent, received $received';
  }

  @override
  String get fieldIntel_whoAround => 'Who\'s around';

  @override
  String get fieldIntel_m15 => '15 min';

  @override
  String get fieldIntel_h1 => '1 hour';

  @override
  String get fieldIntel_h24 => '24 hours';

  @override
  String get fieldIntel_older => 'Older';

  @override
  String get fieldIntel_lastHour => 'Last hour';

  @override
  String get fieldIntel_chartHint =>
      'When each node was last heard, hour by hour, over the past day. Tap a bar to see who.';

  @override
  String get fieldIntel_mix => 'Node mix';

  @override
  String get fieldIntel_reach => 'Reach';

  @override
  String get fieldIntel_hops1 => '1 hop';

  @override
  String get fieldIntel_hops2 => '2 hops';

  @override
  String get fieldIntel_hops3 => '3+ hops';

  @override
  String get fieldIntel_noRoute => 'No route yet';

  @override
  String get fieldIntel_distance => 'Nearest and farthest';

  @override
  String get fieldIntel_noneLocated => 'None of your contacts has a position.';

  @override
  String get fieldIntel_noPosition =>
      'Your radio has no position yet, so distances can\'t be worked out.';

  @override
  String get fieldIntel_bestRepeaters => 'Best repeaters you hear directly';

  @override
  String get fieldIntel_noneDirect =>
      'No repeater heard directly in the last 30 minutes.';

  @override
  String get fieldIntel_attention => 'Needs attention';

  @override
  String get fieldIntel_allGood => 'Nothing needs attention.';

  @override
  String fieldIntel_lowBattery(String volts) {
    return 'Battery low: $volts V';
  }

  @override
  String fieldIntel_quietFavorite(String ago) {
    return 'Favourite not heard since $ago';
  }

  @override
  String get fieldIntel_moreTools => 'More tools';

  @override
  String fieldIntel_nodeCount(int count) {
    return 'Nodes: $count';
  }

  @override
  String get fieldIntel_none => 'No nodes here.';

  @override
  String fieldIntel_lastHeard(String ago) {
    return 'Last heard $ago';
  }

  @override
  String get fieldIntel_showOnMap => 'Show on map';

  @override
  String get fieldIntel_openChat => 'Open chat';

  @override
  String get repeaterTools_login => 'Log in';

  @override
  String get repeaterTools_heardDirect => 'Heard directly';

  @override
  String get repeaterTools_filterAll => 'All';

  @override
  String get repeaterTools_filterLowBattery => 'Low battery';

  @override
  String get repeaterTools_hint =>
      'Tap a repeater for its details, and log in from there for status, neighbours, telemetry and the command line.';

  @override
  String get repeaterTools_noneMatch => 'No repeaters here.';

  @override
  String get repeaterTools_toolsTitle => 'Tools';

  @override
  String get repeaterTools_regionSetupHint =>
      'Look up your area\'s region tree and copy its commands';

  @override
  String get routes_failingOnly => 'Only routes that failed';

  @override
  String get routes_contactDetails => 'Contact details';

  @override
  String get links_contactTitle => 'Add a contact?';

  @override
  String get links_importAdvert => 'Add this contact to your radio?';

  @override
  String get links_connectFirst =>
      'Connect your radio first, then open the link again.';

  @override
  String get links_added => 'Contact added';

  @override
  String get links_notContact => 'This link isn\'t a MeshCore contact.';

  @override
  String get radioBuzzer_title => 'Radio buzzer';

  @override
  String get radioBuzzer_hint =>
      'Beeps on the radio for new messages. Only shown for radios with a buzzer.';

  @override
  String get radioBuzzer_failed =>
      'The radio didn\'t accept the change. Try again.';

  @override
  String get appSettings_floodAttempts => 'Flood attempts';

  @override
  String get appSettings_floodAttemptsSubtitle =>
      'Extra tries sent as a flood after the direct ones fail, in case the route has changed. Each one uses more airtime. 0 turns them off.';

  @override
  String get pathGraph_you => 'You';

  @override
  String pathGraph_relayed(int count) {
    return 'Relayed $count messages';
  }

  @override
  String get pathGraph_ambiguousNote =>
      'This short ID matches more than one repeater, so it can\'t be pinned to one.';

  @override
  String get pathGraph_comesFrom => 'Comes from';

  @override
  String get pathGraph_goesTo => 'Goes to';

  @override
  String get pathGraph_repeaterDetails => 'Repeater details';

  @override
  String get pathGraph_days7 => '7 days';

  @override
  String get pathGraph_empty =>
      'No channel message paths in this period yet. Paths are collected from channel messages you receive while message tracing is on.';

  @override
  String pathGraph_summary(int paths, int repeaters) {
    return '$paths paths heard · $repeaters repeaters';
  }

  @override
  String get pathGraph_hashOnly =>
      'Each hop is shown by its hash prefix, or its name when you know the repeater.';

  @override
  String pathGraph_matched(int count) {
    return '$count short (1-byte) hops matched to a specific repeater using longer paths.';
  }

  @override
  String pathGraph_matchedAmbiguous(int matched, int ambiguous) {
    return '$matched short (1-byte) hops matched to a specific repeater using longer paths · $ambiguous still ambiguous (marked ?).';
  }

  @override
  String get pathGraph_chartHint =>
      'Left: repeaters farther away. Right: you. Band width is how many messages took that hop. Tap a box to see that repeater.';

  @override
  String get pathGraph_busiest => 'Busiest repeaters';

  @override
  String pathGraph_chartSemantics(String name, int count) {
    return 'Path graph. Busiest repeater $name, relayed $count messages.';
  }

  @override
  String diag_copied(String label) {
    return 'Copied: $label';
  }

  @override
  String get diag_noChannels => 'No channels on this radio.';

  @override
  String get diag_tapToCopy =>
      'Tap any value to copy it. Pull down to refresh.';

  @override
  String get diag_storage => 'Storage';

  @override
  String diag_storageValue(int used, int total) {
    return '$used of $total KB';
  }

  @override
  String get favReturn_setting => 'Favorites back in range';

  @override
  String get favReturn_settingHint =>
      'Notify when a favorite is heard again after a quiet spell';

  @override
  String get favReturn_off => 'Off';

  @override
  String favReturn_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'After $count hours',
      one: 'After 1 hour',
    );
    return '$_temp0';
  }

  @override
  String get favReturn_title => 'Back in range';

  @override
  String favReturn_body(String name, int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours hours',
      one: '1 hour',
    );
    return '$name heard again after $_temp0 quiet';
  }

  @override
  String get ham_heardFrom => 'Heard from';

  @override
  String get ham_lastHeard => 'Last frame heard from';

  @override
  String get ham_nothingHeardYet => 'nothing yet';

  @override
  String get ham_readyToTransmit => 'Ready to transmit';

  @override
  String get ham_notReadyToTransmit =>
      'Check the items marked below before transmitting';

  @override
  String get ham_bannerNameMismatch =>
      'Name the radio with your call sign before transmitting';

  @override
  String get ham_bannerOutOfBand => 'The radio is set outside the ham bands';

  @override
  String get a11y_showPassword => 'Show password';

  @override
  String get a11y_hidePassword => 'Hide password';

  @override
  String get a11y_sendLocation => 'Send my location';

  @override
  String get a11y_toggleFlash => 'Flashlight';

  @override
  String get a11y_switchCamera => 'Switch camera';

  @override
  String get los_worst => 'WORST';

  @override
  String get los_selectedObstruction => 'Selected obstruction';

  @override
  String get bastionHome_stationOk => 'Node name and band check out';

  @override
  String get bastionHome_stationConnectToCheck =>
      'Connect a radio to check its name and band';

  @override
  String get theme_selected => 'Selected';

  @override
  String get theme_desc_blaze =>
      'Charcoal slate with hi-vis orange. The default.';

  @override
  String get theme_desc_neon_anarchy =>
      'Toxic green and electric purple on black';

  @override
  String get theme_desc_tactical =>
      'Olive, gunmetal and earth tones for the field';

  @override
  String get theme_desc_pink_overload => 'Hot pink, bubblegum and lavender';

  @override
  String get theme_desc_bare_beauty => 'Warm nude, dusty rose, cocoa and sage';

  @override
  String get theme_desc_okabe_ito => 'Colour-vision friendly, on blue-grey';

  @override
  String get theme_desc_night_ops => 'Dim red for working in the dark';

  @override
  String get theme_desc_seasonal => 'Follows the season, or pick one';

  @override
  String theme_seasonNow(String season) {
    return 'Now: $season';
  }

  @override
  String get theme_season => 'Season';

  @override
  String get theme_seasonAuto => 'Automatic';

  @override
  String get season_spring => 'Spring';

  @override
  String get season_summer => 'Summer';

  @override
  String get season_autumn => 'Autumn';

  @override
  String get season_winter => 'Winter';

  @override
  String get season_halloween => 'Halloween';

  @override
  String get season_christmas => 'Christmas';

  @override
  String get season_valentine => 'Valentine\'s Day';

  @override
  String get theme_holidays => 'Holiday colours';

  @override
  String get theme_holidaysHint =>
      'Halloween, Christmas and Valentine\'s Day, when the season is Automatic';

  @override
  String get rxLog_title => 'RX log';

  @override
  String get rxLog_hint => 'Every packet your radio hears, live';

  @override
  String get rxLog_empty =>
      'No packets yet. Packets your radio hears show up here as they arrive.';

  @override
  String get rxLog_note =>
      'Kept in memory only, the last 2,000 packets. Nothing is saved or sent.';

  @override
  String get rxLog_pause => 'Pause';

  @override
  String get rxLog_resume => 'Resume';

  @override
  String get rxLog_export => 'Export CSV';

  @override
  String get rxLog_clearConfirm => 'Clear the RX log?';

  @override
  String rxLog_count(int shown, int total) {
    return '$shown shown · $total heard';
  }

  @override
  String get rxLog_paused => 'Paused: new packets aren\'t being logged';

  @override
  String get rxLog_kindAll => 'All';

  @override
  String get rxLog_kindAdvert => 'Adverts';

  @override
  String get rxLog_kindChannel => 'Channel';

  @override
  String get rxLog_kindDirect => 'Direct';

  @override
  String get rxLog_kindAck => 'ACKs';

  @override
  String get rxLog_kindPath => 'Paths';

  @override
  String get rxLog_kindTrace => 'Traces';

  @override
  String get rxLog_kindControl => 'Control';

  @override
  String get rxLog_kindOther => 'Other';

  @override
  String get rxLog_routeFlood => 'Flood';

  @override
  String get rxLog_routeDirect => 'Direct route';

  @override
  String get rxLog_heardDirectly => 'Heard directly';

  @override
  String rxLog_hops(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hops',
      one: '1 hop',
    );
    return '$_temp0';
  }

  @override
  String rxLog_bytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bytes',
      one: '1 byte',
    );
    return '$_temp0';
  }

  @override
  String get rxLog_own => 'Your radio';

  @override
  String rxLog_signal(String snr, int rssi) {
    return 'SNR $snr · $rssi dBm';
  }

  @override
  String get rxLog_signalTitle => 'Signal';

  @override
  String get rxLog_route => 'Route';

  @override
  String get rxLog_path => 'Path';

  @override
  String get rxLog_payloadType => 'Payload type';

  @override
  String get rxLog_hash => 'Packet hash';

  @override
  String get rxLog_raw => 'Raw packet';

  @override
  String get rxLog_copyHex => 'Copy hex';

  @override
  String get deliv_title => 'Delivery details';

  @override
  String get deliv_note => 'Worked out from what\'s saved with this message.';

  @override
  String get deliv_queued => 'Queued';

  @override
  String get deliv_sent => 'Sent by your radio';

  @override
  String get deliv_notSent => 'Not taken by your radio';

  @override
  String get deliv_attempts => 'Attempts';

  @override
  String deliv_attemptsValue(int made, int total) {
    return '$made of $total';
  }

  @override
  String deliv_plan(int direct, int flood) {
    return 'Plan: $direct direct, then $flood flood';
  }

  @override
  String get deliv_lastRoute => 'Last route';

  @override
  String get deliv_routeFlood => 'Flood, through every repeater';

  @override
  String get deliv_routeNeighbor => 'Direct, no repeaters';

  @override
  String deliv_routeVia(String path) {
    return 'Direct via $path';
  }

  @override
  String get deliv_confirmed => 'Confirmed received';

  @override
  String deliv_tripTime(String seconds) {
    return 'Round trip $seconds s';
  }

  @override
  String get deliv_waiting => 'Waiting for confirmation';

  @override
  String get deliv_noConfirm => 'No confirmation';

  @override
  String deliv_lastHeard(String name) {
    return '$name last heard';
  }

  @override
  String deliv_hoursAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String deliv_vDelivered(String name) {
    return 'Delivered. $name confirmed it.';
  }

  @override
  String deliv_vDeliveredFlood(String name) {
    return 'Delivered by flood after the direct tries failed. The saved route to $name may be out of date.';
  }

  @override
  String deliv_vPending(int attempt, int total) {
    return 'Still trying: attempt $attempt of $total.';
  }

  @override
  String get deliv_vNotSent =>
      'Your radio never took this message. Check it\'s connected, then retry.';

  @override
  String deliv_vQuiet(String name, int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours hours',
      one: '1 hour',
    );
    return 'No confirmation. $name hasn\'t been heard for $_temp0, so they may be out of range or switched off.';
  }

  @override
  String get deliv_vNoFlood =>
      'No confirmation over the saved route, and flood attempts are off. Turn them on in Settings → App Settings → Messaging, or retry.';

  @override
  String get deliv_vNoAck =>
      'No confirmation from any route. They may be out of range, or their confirmation couldn\'t get back to you.';

  @override
  String get batteryOpt_title => 'Battery optimisation';

  @override
  String get batteryOpt_off =>
      'Off for NOTORYX Core Ham, so alerts keep working in the background.';

  @override
  String get batteryOpt_on =>
      'On. Android may stop the app in the background, so SOS, check-in and message alerts can be late or missed.';

  @override
  String get batteryOpt_fix => 'Turn off';

  @override
  String block_sender(String name) {
    return 'Block $name';
  }

  @override
  String get block_confirmBody =>
      'Their channel messages are hidden on this device and never notify you. They can still see your messages. You can unblock them in Settings.';

  @override
  String get block_action => 'Block';

  @override
  String block_done(String name) {
    return '$name blocked';
  }

  @override
  String get mention_suggestions => 'Name suggestions';

  @override
  String get block_listTitle => 'Blocked senders';

  @override
  String get block_listHint =>
      'Messages from these names are hidden in channels and never notify you.';

  @override
  String get block_listEmpty => 'No one is blocked.';

  @override
  String get block_unblock => 'Unblock';

  @override
  String block_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count blocked',
      one: '1 blocked',
      zero: 'No one blocked',
    );
    return '$_temp0';
  }

  @override
  String contactTable_nearlyFull(int percent) {
    return 'Radio contact list $percent% full';
  }

  @override
  String get contactTable_full => 'Radio contact list is full';

  @override
  String contactTable_count(int used, int max) {
    return '$used of $max contacts';
  }

  @override
  String get contactTable_overwriteHint =>
      'When it\'s full, the radio replaces the contact heard least recently. Favorites are kept.';

  @override
  String get contactTable_stopHint =>
      'When it\'s full, the radio stops adding new contacts it hears.';

  @override
  String get contactTable_freeUp => 'Free up space';

  @override
  String get contactTable_sheetBody =>
      'Heard least recently first. Favorites aren\'t listed.';

  @override
  String contactTable_lastHeard(String when) {
    return 'Last heard $when';
  }

  @override
  String contactTable_remove(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Remove $count contacts',
      one: 'Remove 1 contact',
    );
    return '$_temp0';
  }

  @override
  String get contactTable_confirmBody =>
      'They\'re removed from the radio, and their messages on this device are deleted. This can\'t be undone.';

  @override
  String contactTable_removed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Removed $count contacts',
      one: 'Removed 1 contact',
    );
    return '$_temp0';
  }

  @override
  String get contactTable_noneToSuggest =>
      'Every contact is a favorite, so there\'s nothing to suggest.';

  @override
  String get adminWait_waiting => 'Waiting for a reply';

  @override
  String adminWait_retrying(int attempt, int total) {
    return 'No reply yet. Trying again ($attempt of $total)';
  }

  @override
  String adminWait_direct(int hops) {
    String _temp0 = intl.Intl.pluralLogic(
      hops,
      locale: localeName,
      other: 'Direct, $hops hops',
      one: 'Direct, 1 hop',
      zero: 'Direct',
    );
    return '$_temp0';
  }

  @override
  String adminWait_upTo(int seconds) {
    return 'up to $seconds s';
  }

  @override
  String get seasonal_holidays => 'Holiday colors';

  @override
  String get coords_setting => 'Coordinate format';

  @override
  String get coords_decimal => 'Decimal degrees';

  @override
  String get coords_dms => 'Degrees, minutes, seconds';

  @override
  String get coords_utm => 'UTM';

  @override
  String get coords_mgrs => 'MGRS';

  @override
  String get coords_copyTitle => 'Copy position';

  @override
  String coords_copied(String format) {
    return 'Copied as $format';
  }

  @override
  String pathHash_badge(int width) {
    return 'Route uses $width-byte path hashes';
  }

  @override
  String pathHash_mismatch(int width) {
    return 'Your radio uses $width-byte';
  }

  @override
  String ham_idMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count station IDs don\'t match their names',
      one: '1 station ID doesn\'t match its name',
    );
    return '$_temp0';
  }

  @override
  String get ham_idMismatchBody =>
      'Heard directly, these adverts carried a station ID other than the call sign their name starts with. It may be a misconfigured radio; check with the operator before relying on it.';

  @override
  String ham_idMismatchSentAs(String station) {
    return 'sent with station ID $station';
  }

  @override
  String get ham_idMismatchNoCall =>
      'This name doesn\'t start with a call sign';

  @override
  String get ham_composerPlainText =>
      'Plain text: anyone listening can read this';

  @override
  String get ham_bannerStockFirmware =>
      'This radio runs stock MeshCore. Don\'t transmit with it on the ham bands';

  @override
  String get ham_firmwareOk =>
      'NOTORYX Ham firmware: station ID, plain text, ham bands only';

  @override
  String get ham_firmwareStock =>
      'Stock MeshCore encrypts and sends no station ID. Flash the NOTORYX Ham firmware before transmitting';

  @override
  String get ham_stationLog => 'Station log';

  @override
  String get ham_stationLogExport => 'Export the log';

  @override
  String get ham_exportAdif => 'Export ADIF (.adi)';

  @override
  String get ham_exportCsv => 'Export CSV';

  @override
  String get ham_stationLogClear => 'Clear the log';

  @override
  String get ham_stationLogClearConfirm =>
      'Delete every entry in the station log? This can\'t be undone.';

  @override
  String get ham_stationLogEmpty => 'No stations logged yet';

  @override
  String get ham_stationLogHint =>
      'Direct messages with stations whose names start with a call sign are logged here, on this phone only.';

  @override
  String ham_stationLogCounts(int sent, int received) {
    return '$sent sent, $received received';
  }
}
