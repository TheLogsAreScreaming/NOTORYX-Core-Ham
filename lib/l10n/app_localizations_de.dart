// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core';

  @override
  String get nav_contacts => 'Kontakte';

  @override
  String get nav_channels => 'Kanäle';

  @override
  String get nav_map => 'Karte';

  @override
  String get nav_messages => 'Nachrichten';

  @override
  String get nav_nodes => 'Knoten';

  @override
  String get nav_radio => 'Funk';

  @override
  String get messages_title => 'Nachrichten';

  @override
  String get messages_filterAll => 'Alle';

  @override
  String get messages_filterDirect => 'Direkt';

  @override
  String get messages_filterChannels => 'Kanäle';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'Nachrichten durchsuchen';

  @override
  String get messages_searchHint => 'Unterhaltungen durchsuchen';

  @override
  String get messages_closeSearch => 'Suche schließen';

  @override
  String get messages_manageChannels => 'Kanäle verwalten';

  @override
  String get messages_new => 'Neu';

  @override
  String get messages_newDirect => 'Einem Knoten schreiben';

  @override
  String get messages_newChannel => 'Kanal hinzufügen oder beitreten';

  @override
  String get messages_empty => 'Noch keine Unterhaltungen';

  @override
  String get messages_emptyHint =>
      'Nachrichten von Knoten und Kanälen erscheinen hier.';

  @override
  String get messages_noMatches =>
      'Keine Unterhaltungen passen zu deiner Suche';

  @override
  String messages_you(String text) {
    return 'Du: $text';
  }

  @override
  String get messages_yesterday => 'Gestern';

  @override
  String messages_unreadCount(int count) {
    return '$count ungelesen';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return 'Verbunden über $transport';
  }

  @override
  String get radioStatus_bluetooth => 'Bluetooth';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'WLAN (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return 'Akku $percent %';
  }

  @override
  String get radioStatus_openRadio => 'Funkgerätdetails öffnen';

  @override
  String get radioOverview_battery => 'Akku';

  @override
  String radioOverview_firmware(String version) {
    return 'Firmware $version';
  }

  @override
  String get radioOverview_sendAdvert => 'Advert senden';

  @override
  String get radioOverview_stats => 'Funkstatistik';

  @override
  String get accessControl_title => 'Zugriffskontrolle';

  @override
  String get accessControl_hubSubtitle =>
      'Wer sich ohne Passwort anmelden kann';

  @override
  String get accessControl_explainRepeater =>
      'Personen auf dieser Liste melden sich ohne Passwort an. Admins können Einstellungen ändern; Nur lesen und Lesen & Schreiben erhalten zusätzlich die vollständige Telemetrie.';

  @override
  String get accessControl_explainRoom =>
      'Admins auf dieser Liste melden sich ohne Passwort an und können den Raum verwalten. Raummitglieder treten stattdessen mit dem Raumpasswort bei.';

  @override
  String get accessControl_roleReadOnly => 'Nur lesen';

  @override
  String get accessControl_roleReadWrite => 'Lesen & Schreiben';

  @override
  String get accessControl_roleAdmin => 'Admin';

  @override
  String get accessControl_you => 'Du';

  @override
  String get accessControl_unknownNode => 'Unbekannter Knoten';

  @override
  String get accessControl_add => 'Hinzufügen';

  @override
  String get accessControl_addTitle => 'Zur Zugriffsliste hinzufügen';

  @override
  String get accessControl_pickContact => 'Kontakt auswählen';

  @override
  String get accessControl_noContacts =>
      'Keine Kontakte zum Hinzufügen. Knoten erscheinen hier, sobald du ihr Advert empfangen hast.';

  @override
  String get accessControl_changeRole => 'Rolle ändern';

  @override
  String get accessControl_remove => 'Zugriff entfernen';

  @override
  String accessControl_removeConfirm(String name) {
    return '$name von der Zugriffsliste entfernen? Zum Anmelden wird dann das Passwort benötigt.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'Das bist du. Wenn du dich selbst entfernst, brauchst du das Admin-Passwort, um diesen Knoten wieder zu verwalten.';

  @override
  String get accessControl_unknownKeyNote =>
      'Nicht in deinen Kontakten. Zum Ändern der Rolle ist neuere Knoten-Firmware nötig; Entfernen funktioniert immer.';

  @override
  String get accessControl_prefixUnsupported =>
      'Die Firmware dieses Knotens kann die Rolle von jemandem, der nicht in deinen Kontakten ist, nicht ändern. Entfernen ist weiterhin möglich.';

  @override
  String get accessControl_empty => 'Niemand steht auf der Zugriffsliste';

  @override
  String get accessControl_emptyHint =>
      'Füge Personen hinzu, damit sie sich ohne Passwort anmelden können.';

  @override
  String get accessControl_loading =>
      'Zugriffsliste wird vom Knoten abgefragt…';

  @override
  String get accessControl_timeout =>
      'Der Knoten hat nicht geantwortet. Prüfe den Pfad und versuche es erneut.';

  @override
  String get accessControl_maybeIncomplete =>
      'Dieser Knoten hat eine volle Seite gesendet und seine Firmware kann nicht mehr senden, daher fehlen möglicherweise Einträge.';

  @override
  String get accessControl_saved => 'Zugriffsliste aktualisiert';

  @override
  String accessControl_failed(String reply) {
    return 'Der Knoten hat die Änderung abgelehnt: $reply';
  }

  @override
  String get companionCli_title => 'Kommandozeile';

  @override
  String get companionCli_tileSubtitle =>
      'Befehle auf deinem Funkgerät ausführen';

  @override
  String get companionCli_warning =>
      'Befehle laufen auf deinem verbundenen Funkgerät und können seine Einstellungen ändern oder es neu starten.';

  @override
  String get companionCli_hint => 'Befehl eingeben, z. B. ver';

  @override
  String get companionCli_send => 'Befehl ausführen';

  @override
  String get companionCli_noReply =>
      'Keine Antwort. Das Funkgerät startet möglicherweise neu.';

  @override
  String get companionCli_empty =>
      'Probiere einen der Befehle oben oder gib einen eigenen ein.';

  @override
  String get wifi_title => 'WLAN';

  @override
  String get wifi_tileSubtitle => 'Verbinde dein Funkgerät mit einem WLAN';

  @override
  String get wifi_unsupported =>
      'Die Firmware dieses Funkgeräts enthält kein WLAN.';

  @override
  String get wifi_enabled => 'WLAN verwenden';

  @override
  String get wifi_status => 'Status';

  @override
  String get wifi_connected => 'Verbunden';

  @override
  String wifi_connectedIp(String ip) {
    return 'Verbunden · $ip';
  }

  @override
  String get wifi_disconnected => 'Nicht verbunden';

  @override
  String get wifi_network => 'Netzwerkname (SSID)';

  @override
  String get wifi_password => 'Passwort';

  @override
  String get wifi_passwordKeep =>
      'Leer lassen, um das aktuelle Passwort zu behalten';

  @override
  String get wifi_save => 'Speichern';

  @override
  String get wifi_forget => 'Netzwerk vergessen';

  @override
  String get wifi_forgetConfirm =>
      'Gespeichertes Netzwerk und Passwort vom Funkgerät entfernen?';

  @override
  String get wifi_rebootNeeded =>
      'Gespeichert. Starte das Funkgerät neu, um die WLAN-Änderungen zu übernehmen.';

  @override
  String get wifi_rebootNow => 'Funkgerät neu starten';

  @override
  String get wifi_rebootConfirm =>
      'Funkgerät jetzt neu starten? Die App trennt die Verbindung und du musst dich neu verbinden.';

  @override
  String get wifi_loadFailed =>
      'Die WLAN-Einstellungen konnten nicht vom Funkgerät gelesen werden.';

  @override
  String get wifi_retry => 'Erneut versuchen';

  @override
  String wifi_saveFailed(String reply) {
    return 'Das Funkgerät hat die Änderung nicht angenommen: $reply';
  }

  @override
  String get accessControl_refresh => 'Aktualisieren';

  @override
  String get common_cancel => 'Abbrechen';

  @override
  String get common_ok => 'OK';

  @override
  String get common_connect => 'Verbinden';

  @override
  String get common_unknownDevice => 'Unbekanntes Gerät';

  @override
  String get common_save => 'Speichern';

  @override
  String get common_delete => 'Löschen';

  @override
  String get common_deleteAll => 'Alles löschen';

  @override
  String get common_close => 'Schließen';

  @override
  String get common_done => 'Fertig';

  @override
  String get common_edit => 'Bearbeiten';

  @override
  String get common_add => 'Hinzufügen';

  @override
  String get common_settings => 'Einstellungen';

  @override
  String get common_disconnect => 'Trennen';

  @override
  String get common_connected => 'Verbunden';

  @override
  String get common_disconnected => 'Getrennt';

  @override
  String get common_create => 'Erstellen';

  @override
  String get common_continue => 'Fortfahren';

  @override
  String get common_share => 'Teilen';

  @override
  String get common_copy => 'Kopieren';

  @override
  String get common_retry => 'Wiederholen';

  @override
  String get common_hide => 'Ausblenden';

  @override
  String get common_remove => 'Entfernen';

  @override
  String get common_enable => 'Aktivieren';

  @override
  String get common_disable => 'Deaktivieren';

  @override
  String get common_undo => 'Rückgängig machen';

  @override
  String get messageStatus_sent => 'Gesendet';

  @override
  String get messageStatus_delivered => 'Zugestellt';

  @override
  String get messageStatus_pending => 'Wird gesendet';

  @override
  String get messageStatus_failed => 'Senden fehlgeschlagen';

  @override
  String get messageStatus_repeated => 'Mehrfach gehört';

  @override
  String get urlImage_enable => 'URL-Bilder anzeigen';

  @override
  String get urlImage_possible =>
      'Mögliches URL-Bild; in den Einstellungen aktivieren.';

  @override
  String get common_reboot => 'Neustart';

  @override
  String get common_loading => 'Lädt...';

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
  String get common_autoRefresh => 'Automatische Aktualisierung';

  @override
  String get common_interval => 'Intervall';

  @override
  String get scanner_title => 'NOTORYX Core';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'Verbinden über TCP';

  @override
  String get tcpHostLabel => 'Endpunkt';

  @override
  String get tcpHostHint => '192.168.40.10 / example.com';

  @override
  String get tcpPortLabel => 'Port';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => 'Endpunkt eingeben und verbinden';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return 'Verbindung zu $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => 'Ein Endpunkt ist erforderlich.';

  @override
  String get tcpErrorPortInvalid =>
      'Die Portnummer muss zwischen 1 und 65535 liegen.';

  @override
  String get tcpErrorUnsupported =>
      'TCP wird auf dieser Plattform nicht unterstützt.';

  @override
  String get tcpErrorTimedOut => 'Die TCP-Verbindung ist abgelaufen.';

  @override
  String tcpConnectionFailed(String error) {
    return 'TCP-Verbindung fehlgeschlagen: $error';
  }

  @override
  String get usbScreenTitle => 'Über USB verbinden';

  @override
  String get usbScreenSubtitle =>
      'Wählen Sie ein erkanntes serielles Gerät aus und verbinden Sie es direkt mit Ihrem MeshCore-Knoten.';

  @override
  String get usbScreenStatus => 'Wählen Sie ein USB-Gerät aus';

  @override
  String get usbScreenNote =>
      'USB-Seriell ist auf unterstützten Android-Geräten und Desktop-Plattformen verfügbar.';

  @override
  String get usbScreenEmptyState =>
      'Keine USB-Geräte gefunden. Schließen Sie eines an und aktualisieren Sie.';

  @override
  String get usbErrorPermissionDenied =>
      'Die USB-Berechtigung wurde abgelehnt.';

  @override
  String get usbErrorDeviceMissing =>
      'Das ausgewählte USB-Gerät ist nicht mehr verfügbar.';

  @override
  String get usbErrorInvalidPort => 'Wählen Sie ein gültiges USB-Gerät aus.';

  @override
  String get usbErrorBusy =>
      'Eine weitere Anfrage für eine USB-Verbindung ist bereits in Bearbeitung.';

  @override
  String get usbErrorNotConnected => 'Es ist kein USB-Gerät angeschlossen.';

  @override
  String get usbErrorOpenFailed =>
      'Das ausgewählte USB-Gerät konnte nicht geöffnet werden.';

  @override
  String get usbErrorConnectFailed =>
      'Mit dem ausgewählten USB-Gerät konnte keine Verbindung hergestellt werden.';

  @override
  String get usbErrorUnsupported =>
      'USB-Seriell wird auf dieser Plattform nicht unterstützt.';

  @override
  String get usbErrorAlreadyActive =>
      'Eine USB-Verbindung ist bereits hergestellt.';

  @override
  String get usbErrorNoDeviceSelected => 'Kein USB-Gerät wurde ausgewählt.';

  @override
  String get usbErrorPortClosed => 'Die USB-Verbindung ist nicht aktiv.';

  @override
  String get usbErrorConnectTimedOut =>
      'Verbindung konnte nicht hergestellt werden. Stellen Sie sicher, dass das Gerät über USB-Companion-Firmware verfügt.';

  @override
  String get usbFallbackDeviceName => 'Web-Serial-Gerät';

  @override
  String get usbStatus_notConnected => 'Wählen Sie ein USB-Gerät aus';

  @override
  String get usbStatus_connecting =>
      'Verbindung zum USB-Gerät wird hergestellt...';

  @override
  String get usbStatus_searching => 'Suche nach USB-Geräten...';

  @override
  String usbConnectionFailed(String error) {
    return 'USB-Verbindung fehlgeschlagen: $error';
  }

  @override
  String get scanner_scanning => 'Suche nach Geräten...';

  @override
  String get scanner_connecting => 'Verbinde...';

  @override
  String get scanner_disconnecting => 'Trenne...';

  @override
  String get scanner_notConnected => 'Nicht verbunden';

  @override
  String scanner_connectedTo(String deviceName) {
    return 'Verbunden mit $deviceName';
  }

  @override
  String get scanner_searchingDevices => 'Suche nach MeshCore-Geräten...';

  @override
  String get scanner_tapToScan =>
      'Tippen Sie auf Scannen, um MeshCore-Geräte zu finden.';

  @override
  String scanner_connectionFailed(String error) {
    return 'Verbindung fehlgeschlagen: $error';
  }

  @override
  String get scanner_stop => 'Stopp';

  @override
  String get scanner_scan => 'Scannen';

  @override
  String get scanner_bluetoothOff => 'Bluetooth ist deaktiviert.';

  @override
  String get scanner_bluetoothOffMessage =>
      'Bitte aktivieren Sie Bluetooth, um nach Geräten zu suchen.';

  @override
  String get scanner_chromeRequired => 'Chrome Browser erforderlich';

  @override
  String get scanner_chromeRequiredMessage =>
      'Diese Webanwendung erfordert Google Chrome oder einen Chromium-basierten Browser für die Bluetooth-Unterstützung.';

  @override
  String get scanner_enableBluetooth => 'Bluetooth aktivieren';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'Bluetooth ist im Browser nicht verfügbar. Verwenden Sie stattdessen eine USB-Verbindung.';

  @override
  String get device_quickSwitch => 'Schnellwechsel';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get settings_deviceInfo => 'Geräteinformationen';

  @override
  String get settings_appSettings => 'App-Einstellungen';

  @override
  String get settings_appSettingsSubtitle =>
      'Benachrichtigungen, Nachrichten und Karten-Einstellungen';

  @override
  String get settings_nodeSettings => 'Knoteneinstellungen';

  @override
  String get settings_nodeName => 'Knotenname';

  @override
  String get settings_nodeNameNotSet => 'Nicht festgelegt';

  @override
  String get settings_nodeNameHint => 'Geben Sie den Knotennamen ein';

  @override
  String get settings_nodeNameUpdated => 'Name aktualisiert';

  @override
  String get settings_radioSettings => 'Funk-Einstellungen';

  @override
  String get settings_radioSettingsSubtitle =>
      'Frequenz, Leistung, Spreading-Faktor';

  @override
  String get settings_radioSettingsUpdated => 'Funkparameter aktualisiert';

  @override
  String get settings_regionSettings => 'Regionen';

  @override
  String get settings_regionSettingsSubtitle =>
      'Gespeicherte Regionen verwalten';

  @override
  String get settings_corridorRegion => 'Korridor-Region';

  @override
  String get settings_corridorRegionDefault => '#corridor (Standard)';

  @override
  String get settings_corridorRegionHelp =>
      'Flood-Korridor-Pakete werden mit dieser Region markiert. Repeater ohne Korridor-Firmware leiten sie nur weiter, wenn sie diese Region erlauben. Leer lassen für den Standard-Tag #corridor.';

  @override
  String get settings_corridorRegionHint => 'Regionsname';

  @override
  String get settings_corridorRegionUseDefault => 'Standard verwenden';

  @override
  String get settings_corridorRegionUpdated => 'Korridor-Region aktualisiert';

  @override
  String get settings_corridorRegionFailed =>
      'Korridor-Region konnte nicht aktualisiert werden';

  @override
  String get settings_regionManagement_screenTitle => 'Regions-Verwaltung';

  @override
  String get settings_regionNameHint => 'Regions-Namen eingeben';

  @override
  String get settings_regionAddRegion => 'Region hinzufügen';

  @override
  String get settings_regionFetchRegions => 'Regionen von Wiederholern abrufen';

  @override
  String get settings_regionFetchRegionsFail =>
      'Es wurden keine Regionen gefunden.';

  @override
  String get settings_regionFetchRegionsAlreadyExists =>
      'Diese Region wurde bereits hinzugefügt';

  @override
  String get settings_regionName => 'Regions-Name';

  @override
  String get settings_regionDeleted => 'Region entfernt';

  @override
  String get settings_deleteRegion => 'Region entfernen';

  @override
  String settings_deleteRegionConfirm(String region) {
    return 'Region \"$region\" aus der Liste entfernen?';
  }

  @override
  String get settings_location => 'Ort';

  @override
  String get settings_locationSubtitle => 'GPS-Koordinaten';

  @override
  String get settings_locationUpdated =>
      'Standort und GPS-Einstellungen aktualisiert';

  @override
  String get settings_locationBothRequired =>
      'Bitte geben Sie sowohl Breiten- als auch Längengrad ein.';

  @override
  String get settings_locationInvalid => 'Ungültiger Breiten- oder Längengrad.';

  @override
  String get settings_locationGPSEnable => 'GPS aktivieren';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'Ermöglicht GPS, den Standort automatisch zu aktualisieren.';

  @override
  String get settings_locationIntervalSec => 'GPS-Intervall (Sekunden)';

  @override
  String get settings_locationIntervalInvalid =>
      'Das Intervall muss mindestens 60 Sekunden und weniger als 86400 Sekunden betragen.';

  @override
  String get settings_latitude => 'Breitengrad';

  @override
  String get settings_longitude => 'Längengrad';

  @override
  String get settings_contactSettings => 'Kontakteinstellungen';

  @override
  String get settings_contactSettingsSubtitle =>
      'Einstellungen für das Hinzufügen von Kontakten';

  @override
  String get settings_privacyMode => 'Privatsphärenmodus';

  @override
  String get settings_privacyModeSubtitle =>
      'Name und Standort in Ankündigungen verbergen';

  @override
  String get settings_privacyModeToggle =>
      'Privatsphärenmodus aktivieren, um Namen und Standort in Ankündigungen zu verbergen.';

  @override
  String get settings_privacyModeEnabled => 'Privatsphärenmodus aktiviert';

  @override
  String get settings_privacyModeDisabled => 'Privatsphärenmodus deaktiviert';

  @override
  String get settings_privacy => 'Datenschutzeinstellungen';

  @override
  String get settings_privacySubtitle =>
      'Steuern Sie, welche Informationen freigegeben werden.';

  @override
  String get settings_privacySettingsDescription =>
      'Wählen Sie aus, welche Informationen Ihr Gerät mit anderen teilt.';

  @override
  String get settings_denyAll => 'Alles verweigern';

  @override
  String get settings_allowByContact => 'Nach Kontakt-Flags zulassen';

  @override
  String get settings_allowAll => 'Alles zulassen';

  @override
  String get settings_telemetryBaseMode => 'Telemetrie-Basismodus';

  @override
  String get settings_telemetryLocationMode => 'Telemetrie-Standortmodus';

  @override
  String get settings_telemetryEnvironmentMode => 'Telemetrie-Umgebungsmodus';

  @override
  String get settings_advertLocation => 'Standort in Ankündigung';

  @override
  String get settings_advertLocationSubtitle =>
      'Standort in die Ankündigung einschließen.';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'Automatische Zero-Hop-Ankündigung bei GPS-Update';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'Wenn sich der GPS-Standort ändert, eine Zero-Hop-Ankündigung senden (erfordert Standort in der Ankündigung).';

  @override
  String get settings_multiAck => 'Mehrfach-ACKs';

  @override
  String get settings_telemetryModeUpdated => 'Telemetriemodus aktualisiert';

  @override
  String get settings_actions => 'Aktionen';

  @override
  String get settings_deleteAllPaths => 'Alle Pfade löschen';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Alle Pfaddaten aus den Kontakten entfernen.';

  @override
  String get settings_sendAdvertisement => 'Ankündigung senden';

  @override
  String get settings_sendAdvertisementSubtitle => 'Präsenz jetzt senden';

  @override
  String get settings_advertisementSent => 'Ankündigung gesendet';

  @override
  String get settings_syncTime => 'Zeit synchronisieren';

  @override
  String get settings_syncTimeSubtitle =>
      'Geräteuhr auf die Zeit des Telefons setzen';

  @override
  String get settings_timeSynchronized => 'Zeit synchronisiert';

  @override
  String get settings_refreshContacts => 'Kontakte aktualisieren';

  @override
  String get settings_refreshContactsSubtitle =>
      'Kontaktliste vom Gerät neu laden';

  @override
  String get settings_rebootDevice => 'Gerät neu starten';

  @override
  String get settings_rebootDeviceSubtitle => 'MeshCore-Gerät neu starten';

  @override
  String get settings_rebootDeviceConfirm =>
      'Sind Sie sicher, dass Sie das Gerät neu starten möchten? Sie werden getrennt.';

  @override
  String get settings_debug => 'Fehlerbehebung';

  @override
  String get settings_companionDebugLog =>
      'Debug-Protokoll für die Begleitsoftware';

  @override
  String get settings_companionDebugLogSubtitle =>
      'BLE/TCP/USB-Befehle, Antworten und Rohdaten';

  @override
  String get settings_appDebugLog => 'App-Debug-Protokoll';

  @override
  String get settings_appDebugLogSubtitle => 'App-Debug-Nachrichten';

  @override
  String get settings_about => 'Über';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core v$version';
  }

  @override
  String get settings_aboutLegalese => '2026 MeshCore Open-Source-Projekt';

  @override
  String get settings_aboutDescription =>
      'Ein Open-Source-Flutter-Client für MeshCore LoRa-Meshnetzwerkgeräte.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'LOS-Höhendaten: Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => 'Name';

  @override
  String get settings_infoId => 'ID';

  @override
  String get settings_infoStatus => 'Status';

  @override
  String get settings_infoBattery => 'Akku';

  @override
  String get settings_infoPublicKey => 'Öffentlicher Schlüssel';

  @override
  String get settings_infoContactsCount => 'Kontakte';

  @override
  String get settings_infoChannelCount => 'Kanäle';

  @override
  String get settings_infoHardware => 'Hardware';

  @override
  String get settings_infoFirmware => 'Firmware';

  @override
  String get settings_presets => 'Voreinstellungen';

  @override
  String get settings_frequency => 'Frequenz (MHz)';

  @override
  String get settings_frequencyHelper => '300,0 - 2500,0';

  @override
  String get settings_frequencyInvalid => 'Ungültige Frequenz (300-2500 MHz)';

  @override
  String get settings_bandwidth => 'Bandbreite';

  @override
  String get settings_spreadingFactor => 'Spreading-Faktor';

  @override
  String get settings_codingRate => 'Kodierungsrate';

  @override
  String get settings_txPower => 'Sendeleistung (dBm)';

  @override
  String get settings_txPowerHelper => '0 – 22';

  @override
  String get settings_txPowerInvalid => 'Ungültige Sendeleistung (0-22 dBm)';

  @override
  String get settings_clientRepeat => 'Weiterleitung ohne Netzstrom';

  @override
  String get settings_clientRepeatSubtitle =>
      'Dieses Gerät kann Mesh-Pakete für andere weiterleiten';

  @override
  String get settings_clientRepeatFreqWarning =>
      'Weiterleitung ohne Netzstrom erfordert 433, 869 oder 918 MHz';

  @override
  String settings_error(String message) {
    return 'Fehler: $message';
  }

  @override
  String get appSettings_title => 'App-Einstellungen';

  @override
  String get appSettings_appearance => 'Erscheinungsbild';

  @override
  String get appSettings_theme => 'Design';

  @override
  String get appSettings_themeSystem => 'Systemstandard';

  @override
  String get appSettings_themeLight => 'Hell';

  @override
  String get appSettings_themeDark => 'Dunkel';

  @override
  String get appSettings_language => 'Sprache';

  @override
  String get appSettings_languageSystem => 'Systemstandard';

  @override
  String get appSettings_languageEn => 'Englisch';

  @override
  String get appSettings_languageFr => 'Französisch';

  @override
  String get appSettings_languageEs => 'Spanisch';

  @override
  String get appSettings_languageDe => 'Deutsch';

  @override
  String get appSettings_languagePl => 'Polnisch';

  @override
  String get appSettings_languageSl => 'Slowenisch';

  @override
  String get appSettings_languagePt => 'Portugiesisch';

  @override
  String get appSettings_languageIt => 'Italienisch';

  @override
  String get appSettings_languageZh => 'Chinesisch';

  @override
  String get appSettings_languageSv => 'Schwedisch';

  @override
  String get appSettings_languageNl => 'Niederländisch';

  @override
  String get appSettings_languageSk => 'Slowakisch';

  @override
  String get appSettings_languageBg => 'Bulgarisch';

  @override
  String get appSettings_languageRu => 'Russisch';

  @override
  String get appSettings_languageUk => 'Ukrainisch';

  @override
  String get repeater_pathHashModeOption0 => '0 - 1 Byte';

  @override
  String get repeater_pathHashModeOption1 => '1 - 2 Bytes';

  @override
  String get repeater_pathHashModeOption2 => '2 - 3 Bytes';

  @override
  String get repeater_pathHashModeOption3 => '3 - 4 Bytes';

  @override
  String get appSettings_enableMessageTracing =>
      'Nachrichtenverfolgung aktivieren';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'Detaillierte Routing- und Zeitmetadaten für Nachrichten anzeigen';

  @override
  String get appSettings_notifications => 'Benachrichtigungen';

  @override
  String get appSettings_enableNotifications => 'Benachrichtigungen aktivieren';

  @override
  String get appSettings_enableNotificationsSubtitle =>
      'Benachrichtigungen für Nachrichten und Ankündigungen erhalten';

  @override
  String get appSettings_notificationPermissionDenied =>
      'Benachrichtigungsberechtigung verweigert';

  @override
  String get appSettings_notificationsEnabled => 'Benachrichtigungen aktiviert';

  @override
  String get appSettings_notificationsDisabled =>
      'Benachrichtigungen deaktiviert';

  @override
  String get appSettings_messageNotifications =>
      'Direktnachrichten-Benachrichtigungen';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      'Benachrichtigung anzeigen, wenn neue Direktnachrichten eingehen';

  @override
  String get appSettings_channelMessageNotifications =>
      'Kanalnachrichten-Benachrichtigungen';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'Benachrichtigung anzeigen, wenn neue Kanalnachrichten eingehen';

  @override
  String get appSettings_advertisementNotifications =>
      'Ankündigungsbenachrichtigungen';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      'Benachrichtigung anzeigen, wenn neue Knoten entdeckt werden';

  @override
  String get appSettings_messaging => 'Nachrichten';

  @override
  String get appSettings_clearPathOnMaxRetry =>
      'Pfad bei maximalen Wiederholungsversuchen löschen';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      'Kontaktpfade nach 5 fehlgeschlagenen Sendeversuchen zurücksetzen';

  @override
  String get appSettings_pathsWillBeCleared =>
      'Pfade werden nach 5 fehlgeschlagenen Wiederholungen gelöscht.';

  @override
  String get appSettings_pathsWillNotBeCleared =>
      'Pfade werden nicht automatisch gelöscht.';

  @override
  String get appSettings_autoRouteRotation => 'Automatische Routenrotation';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      'Zwischen den besten Pfaden und dem Flood-Modus wechseln';

  @override
  String get appSettings_autoRouteRotationEnabled =>
      'Automatische Routenrotation aktiviert';

  @override
  String get appSettings_autoRouteRotationDisabled =>
      'Automatische Routenrotation deaktiviert';

  @override
  String get appSettings_maxRouteWeight => 'Maximale Gesamtstreckenlänge';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      'Maximales Gewicht, das ein Weg durch erfolgreiche Lieferungen erreichen kann.';

  @override
  String get appSettings_initialRouteWeight => 'Anfangs-Streckengewicht';

  @override
  String get appSettings_initialRouteWeightSubtitle =>
      'Ausgangsgewicht für neu entdeckte Pfade';

  @override
  String get appSettings_routeWeightSuccessIncrement =>
      'Erhöhung des Erfolgsgewichts';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      'Gewicht, das einem Pfad nach erfolgreicher Lieferung hinzugefügt wird.';

  @override
  String get appSettings_routeWeightFailureDecrement =>
      'Reduzierung des Gewichts bei Fehlern';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      'Gewicht, das nach einem fehlgeschlagenen Versand von einem Weg entfernt wurde';

  @override
  String get appSettings_maxMessageRetries =>
      'Maximale Anzahl an Wiederholungsversuchen';

  @override
  String get appSettings_maxMessageRetriesSubtitle =>
      'Anzahl der Versuche, eine Nachricht erneut zu senden, bevor sie als fehlgeschlagen markiert wird.';

  @override
  String get appSettings_battery => 'Akku';

  @override
  String get appSettings_batteryChemistry => 'Batteriechemie';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return 'Pro Gerät festgelegt ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      'Zum Auswählen mit einem Gerät verbinden';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3,0–4,2 V)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2,6–3,65 V)';

  @override
  String get appSettings_batteryLipo => 'LiPo (3,0–4,2V)';

  @override
  String get appSettings_batteryLipoHv => 'LiPo HV (3,0–4,35 V)';

  @override
  String get appSettings_mapDisplay => 'Kartendarstellung';

  @override
  String get appSettings_showRepeaters => 'Repeater anzeigen';

  @override
  String get appSettings_showRepeatersSubtitle =>
      'Repeater-Knoten auf der Karte anzeigen';

  @override
  String get appSettings_showChatNodes => 'Chat-Knoten anzeigen';

  @override
  String get appSettings_showChatNodesSubtitle =>
      'Chat-Knoten auf der Karte anzeigen';

  @override
  String get appSettings_showOtherNodes => 'Andere Knoten anzeigen';

  @override
  String get appSettings_showOtherNodesSubtitle =>
      'Andere Knotentypen auf der Karte anzeigen';

  @override
  String get appSettings_timeFilter => 'Zeitfilter';

  @override
  String get appSettings_timeFilterShowAll => 'Alle Knoten anzeigen';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return 'Knoten der letzten $hours Stunden anzeigen';
  }

  @override
  String get appSettings_mapTimeFilter => 'Karten-Zeitfilter';

  @override
  String get appSettings_showNodesDiscoveredWithin =>
      'Zeige Knoten, die innerhalb von:';

  @override
  String get appSettings_allTime => 'Gesamter Zeitraum';

  @override
  String get appSettings_lastHour => 'Letzte Stunde';

  @override
  String get appSettings_last6Hours => 'Letzte 6 Stunden';

  @override
  String get appSettings_last24Hours => 'Letzte 24 Stunden';

  @override
  String get appSettings_lastWeek => 'Letzte Woche';

  @override
  String get appSettings_rasterTileSource => 'Quelle für Rasterkacheln';

  @override
  String get appSettings_stadiaEndpoint => 'Stadia-Endpunkt';

  @override
  String get appSettings_stadiaApiKey => 'Stadia-API-Schlüssel';

  @override
  String get appSettings_stadiaApiKeyRequired =>
      'Für die Nutzung von Stadia Maps erforderlich';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return 'Konfiguriert: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Geben Sie Ihren Stadia-Maps-API-Schlüssel ein. Die App verwendet ihn für Rasterkachel-Anfragen.';

  @override
  String get appSettings_offlineMapCache => 'Offline-Karten-Cache';

  @override
  String get appSettings_unitsTitle => 'Einheiten';

  @override
  String get appSettings_unitsMetric => 'Metrisch (m/km)';

  @override
  String get appSettings_unitsImperial => 'Imperial (ft/mi)';

  @override
  String get appSettings_noAreaSelected => 'Kein Bereich ausgewählt';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'Bereich ausgewählt (Zoom $minZoom-$maxZoom)';
  }

  @override
  String get appSettings_debugCard => 'Debug';

  @override
  String get appSettings_appDebugLogging => 'App-Debug-Protokollierung';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'App-Debug-Nachrichten zur Fehlerbehebung protokollieren';

  @override
  String get appSettings_appDebugLoggingEnabled =>
      'App-Debug-Protokollierung aktiviert';

  @override
  String get appSettings_appDebugLoggingDisabled =>
      'App-Debug-Protokollierung deaktiviert';

  @override
  String get contacts_title => 'Kontakte';

  @override
  String get contacts_noContacts => 'Noch keine Kontakte';

  @override
  String get contacts_contactsWillAppear =>
      'Kontakte werden angezeigt, wenn Geräte Ankündigungen senden.';

  @override
  String get contacts_unread => 'Ungelesen';

  @override
  String get contacts_searchContactsNoNumber => 'Kontakte suchen...';

  @override
  String contacts_searchContacts(int number, String str) {
    return 'Kontakte suchen...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'Suche $number$str Favoriten...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'Suche $number$str Benutzer...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'Suche $number$str Repeater...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'Suche $number$str Raumserver...';
  }

  @override
  String get contacts_noUnreadContacts => 'Keine ungelesenen Kontakte';

  @override
  String get contacts_noContactsFound =>
      'Keine Kontakte oder Gruppen gefunden.';

  @override
  String get contacts_deleteContact => 'Kontakt löschen';

  @override
  String contacts_removeConfirm(String contactName) {
    return '$contactName aus den Kontakten entfernen?';
  }

  @override
  String get contacts_manageRepeater => 'Repeater verwalten';

  @override
  String get contacts_manageRoom => 'Raumserver verwalten';

  @override
  String get contacts_roomLogin => 'Raumserver-Login';

  @override
  String get contacts_openChat => 'Chat öffnen';

  @override
  String get contacts_editGroup => 'Gruppe bearbeiten';

  @override
  String get contacts_deleteGroup => 'Gruppe löschen';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return 'Gruppe \"$groupName\" löschen?';
  }

  @override
  String get contacts_newGroup => 'Neue Gruppe';

  @override
  String get contacts_moreOptions => 'Weitere Optionen';

  @override
  String get contacts_searchOpen => 'Suche öffnen';

  @override
  String get contacts_searchClose => 'Suche schließen';

  @override
  String get contacts_groupName => 'Gruppenname';

  @override
  String get contacts_groupNameRequired => 'Der Gruppenname ist erforderlich.';

  @override
  String get contacts_groupNameReserved => 'Dieser Gruppenname ist reserviert';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'Die Gruppe \"$name\" existiert bereits.';
  }

  @override
  String get contacts_filterContacts => 'Kontakte filtern...';

  @override
  String get contacts_noContactsMatchFilter =>
      'Keine Kontakte passen zu Ihrem Filter';

  @override
  String get contacts_noMembers => 'Keine Mitglieder';

  @override
  String get contacts_lastSeenNow => 'gerade eben';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return '~ $minutes Min.';
  }

  @override
  String get contacts_lastSeenHourAgo => '~ 1 Std.';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return '~ $hours Std.';
  }

  @override
  String get contacts_lastSeenDayAgo => '~ 1 Tag';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return '~ $days Tage';
  }

  @override
  String get contact_info => 'Kontaktinformationen';

  @override
  String get contact_settings => 'Kontakteinstellungen';

  @override
  String get contact_telemetry => 'Telemetrie';

  @override
  String get contact_lastSeen => 'Zuletzt gesehen';

  @override
  String get contact_clearChat => 'Chat löschen';

  @override
  String get contact_teleBase => 'Telemetriebasis';

  @override
  String get contact_teleBaseSubtitle =>
      'Erlauben des Freigebens des Batteriestands und der grundlegenden Telemetrie';

  @override
  String get contact_teleLoc => 'Telemetrieort';

  @override
  String get contact_teleLocSubtitle => 'Teilen von Standortdaten zulassen';

  @override
  String get contact_teleEnv => 'Telemetrieumgebung';

  @override
  String get contact_teleEnvSubtitle =>
      'Teilen von Umgebungsensordaten zulassen';

  @override
  String get channels_title => 'Kanäle';

  @override
  String get channels_noChannelsConfigured => 'Keine Kanäle konfiguriert';

  @override
  String get channels_addPublicChannel => 'Öffentlichen Kanal hinzufügen';

  @override
  String get channels_searchChannels => 'Kanäle suchen...';

  @override
  String get channels_noChannelsFound => 'Keine Kanäle gefunden';

  @override
  String channels_channelIndex(int index) {
    return 'Kanal $index';
  }

  @override
  String get channels_public => 'Öffentlich';

  @override
  String channels_via(String path) {
    return 'über $path';
  }

  @override
  String get channels_viaMqtt => 'über MQTT';

  @override
  String get channels_viaMqttSemantics =>
      'Über MQTT empfangen, nicht von deinem Funkgerät gehört';

  @override
  String get channels_private => 'Privat';

  @override
  String get channels_editChannel => 'Kanal bearbeiten';

  @override
  String get channels_muteChannel => 'Kanal stummschalten';

  @override
  String get channels_unmuteChannel => 'Kanal Stummschaltung aufheben';

  @override
  String get channels_deleteChannel => 'Kanal löschen';

  @override
  String channels_deleteChannelConfirm(String name) {
    return 'Kanal \"$name\" löschen? Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'Kanal $name konnte nicht gelöscht werden';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'Kanal \"$name\" gelöscht';
  }

  @override
  String get channels_addChannel => 'Kanal hinzufügen';

  @override
  String get channels_channelIndexLabel => 'Kanalindex';

  @override
  String get channels_channelName => 'Kanalname';

  @override
  String get channels_usePublicChannel => 'Öffentlichen Kanal verwenden';

  @override
  String get channels_standardPublicPsk => 'Öffentlicher Standard-PSK';

  @override
  String get channels_pskHex => 'PSK (Hexadezimal)';

  @override
  String get channels_generateRandomPsk => 'Zufälligen PSK generieren';

  @override
  String get channels_enterChannelName =>
      'Bitte geben Sie einen Kanalnamen ein';

  @override
  String get channels_pskMustBe32Hex =>
      'Der PSK muss 32 hexadezimale Zeichen haben.';

  @override
  String channels_channelAdded(String name) {
    return 'Kanal \"$name\" hinzugefügt';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'Kanal $index bearbeiten';
  }

  @override
  String get channels_smazCompression => 'SMAZ-Komprimierung';

  @override
  String get channels_cyr2latCompression => 'Cyr2Lat-Komprimierung';

  @override
  String get channels_cyr2latCompressionDscr =>
      'Ersetzt beim Senden einige kyrillische Zeichen durch lateinische Zeichen.';

  @override
  String get channels_cyr2latSettingsHeading => 'Cyr2Lat-Einstellungen';

  @override
  String get channels_cyr2latSettingsSubheading => 'Ersetzungsliste';

  @override
  String get channels_cyr2latSettingsDscr =>
      'JSON-Konfiguration für Zeichenersetzungen bearbeiten';

  @override
  String get channels_cyr2latSettingsDialogHint => 'JSON-Ersetzungstabelle';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'Ungültiges JSON: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'Kanal \"$name\" aktualisiert';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Cyr2Lat-Profil hinzufügen';

  @override
  String get settings_cyr2latProfileName => 'Profilname';

  @override
  String get settings_cyr2latProfileNameEmpty =>
      'Der Profilname darf nicht leer sein';

  @override
  String get settings_cyr2latProfileAdded => 'Profil erfolgreich hinzugefügt';

  @override
  String get settings_cyr2latProfileUpdated =>
      'Profil erfolgreich aktualisiert';

  @override
  String get settings_cyr2latProfileEdit => 'Cyr2Lat-Profil bearbeiten';

  @override
  String get settings_cyr2latProfileDelete => 'Cyr2Lat-Profil löschen';

  @override
  String get settings_cyr2latProfileDeleted => 'Profil erfolgreich gelöscht';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return 'Möchten Sie das Profil \"$name\" wirklich löschen?';
  }

  @override
  String get channels_publicChannelAdded => 'Öffentlicher Kanal hinzugefügt';

  @override
  String get channels_sortBy => 'Sortieren nach';

  @override
  String get channels_sortManual => 'Manuell';

  @override
  String get channels_sortAZ => 'A bis Z';

  @override
  String get channels_sortLatestMessages => 'Neueste Nachrichten';

  @override
  String get channels_sortUnread => 'Ungelesen';

  @override
  String get channels_createPrivateChannel => 'Erstelle einen privaten Kanal';

  @override
  String get channels_createPrivateChannelDesc =>
      'Verschlüsselt mit einem geheimen Schlüssel.';

  @override
  String get channels_joinPrivateChannel =>
      'Treten Sie einem privaten Kanal bei';

  @override
  String get channels_joinPrivateChannelDesc =>
      'Manuelle Eingabe eines geheimen Schlüssels.';

  @override
  String get channels_joinPublicChannel => 'Tritt dem öffentlichen Kanal bei';

  @override
  String get channels_joinPublicChannelDesc =>
      'Jeder kann diesem Kanal beitreten.';

  @override
  String get channels_joinHashtagChannel =>
      'Treten Sie einem Hashtag-Kanal bei';

  @override
  String get channels_joinHashtagChannelDesc =>
      'Jeder kann sich bei Hashtag-Kanälen beteiligen.';

  @override
  String get channels_scanQrCode => 'Scannen Sie einen QR-Code';

  @override
  String get channels_scanQrCodeComingSoon => 'Bald verfügbar';

  @override
  String get channels_enterHashtag => 'Gib Hashtag ein';

  @override
  String get channels_hashtagHint => 'z.B. #team';

  @override
  String channels_regionSetTo(String region) {
    return 'Region: $region';
  }

  @override
  String get channels_regionNotSet => 'Region: keine';

  @override
  String get channels_regionSelect_Title => 'Region auswählen';

  @override
  String get channels_clearRegion => 'Region zurücksetzen';

  @override
  String get chat_noMessages => 'Noch keine Nachrichten.';

  @override
  String get chat_sendMessage => 'Nachricht senden';

  @override
  String chat_sendMessageTo(String contactName) {
    return 'Nachricht an $contactName senden';
  }

  @override
  String get chat_sendMessageToStart =>
      'Senden Sie eine Nachricht, um zu beginnen.';

  @override
  String get chat_originalMessageNotFound => 'Originalnachricht nicht gefunden';

  @override
  String chat_replyingTo(String name) {
    return 'Antworten an $name';
  }

  @override
  String chat_replyTo(String name) {
    return 'Antwort an $name';
  }

  @override
  String get chat_location => 'Ort';

  @override
  String get chat_typeMessage => 'Nachricht eingeben...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'Nachricht zu lang (max. $maxBytes Bytes).';
  }

  @override
  String get chat_messageCopied => 'Nachricht kopiert';

  @override
  String get chat_messageDeleted => 'Nachricht gelöscht';

  @override
  String get chat_retryingMessage => 'Nachricht wird erneut gesendet.';

  @override
  String chat_retryCount(int current, int max) {
    return 'Wiederholen $current/$max';
  }

  @override
  String get chat_selectSendAction => 'Sendeaktion auswählen';

  @override
  String get chat_sendGif => 'GIF senden';

  @override
  String get chat_limitToArea => 'Auf ein Gebiet begrenzen';

  @override
  String get chat_limitToAreaTitle => 'Nur senden innerhalb von…';

  @override
  String get chat_limitToAreaHelp =>
      'Repeater mit Flood-Corridor-Firmware leiten die Nachricht nur innerhalb dieses Gebiets weiter. Andere Repeater verwerfen sie, außer sie erlauben deine Korridor-Region.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '$km km um dich';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return 'Nur im Umkreis von $km km';
  }

  @override
  String get chat_limitToAreaOff => 'Keine Begrenzung';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'Lege die Position deines Funkgeräts fest, um Nachrichten auf ein Gebiet zu begrenzen.';

  @override
  String get chat_sendImageLora => 'Bild über MeshCore senden';

  @override
  String get chat_imagePickFailed => 'Konnte dieses Bild nicht öffnen.';

  @override
  String get chat_receivedGif => 'Erhalten eines GIF';

  @override
  String get chat_reply => 'Antworten';

  @override
  String get chat_addReaction => 'Reaktion hinzufügen';

  @override
  String get chat_me => 'Ich';

  @override
  String get reaction_report => 'Emoji-Reaktionen';

  @override
  String get emojiCategorySmileys => 'Emoticons';

  @override
  String get emojiCategoryGestures => 'Gesten';

  @override
  String get emojiCategoryHearts => 'Herz';

  @override
  String get emojiCategoryObjects => 'Objekte';

  @override
  String get gifPicker_title => 'Wähle ein GIF';

  @override
  String get gifPicker_searchHint => 'Suche nach GIFs...';

  @override
  String get gifPicker_poweredBy => 'Bereitgestellt von GIPHY';

  @override
  String get gifPicker_noGifsFound => 'Keine GIFs gefunden';

  @override
  String get gifPicker_failedLoad => 'GIF-Datei konnten nicht geladen werden.';

  @override
  String get gifPicker_failedSearch => 'Suche nach GIFs fehlgeschlagen';

  @override
  String get gifPicker_noInternet => 'Keine Internetverbindung';

  @override
  String get debugLog_appTitle => 'App-Debug-Protokoll';

  @override
  String get debugLog_bleTitle => 'BLE-Debug-Protokoll';

  @override
  String get debugLog_copyLog => 'Kopieren des Protokolls';

  @override
  String get debugLog_clearLog => 'Protokoll löschen';

  @override
  String get debugLog_copied => 'Debug-Protokoll kopiert';

  @override
  String get debugLog_bleCopied => 'BLE-Protokoll kopiert';

  @override
  String get debugLog_noEntries => 'Noch keine Debug-Protokolle vorhanden';

  @override
  String get debugLog_enableInSettings =>
      'App-Debug-Protokollierung in den Einstellungen aktivieren';

  @override
  String get debugLog_frames => 'Rahmen';

  @override
  String get debugLog_rawLogRx => 'Roh-Log-RX';

  @override
  String get debugLog_noBleActivity => 'Bisher keine BLE-Aktivität';

  @override
  String debugFrame_length(int count) {
    return 'Rahmenlänge: $count Bytes';
  }

  @override
  String debugFrame_command(String value) {
    return 'Befehl: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'Textnachrichten Frame:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- Ziel-Public-Schlüssel: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- Zeitstempel: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- Flaggen: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- Textart: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'Befehlszeilen-Schnittstelle';

  @override
  String get debugFrame_textTypePlain => 'Einfach';

  @override
  String debugFrame_text(String text) {
    return '- Text: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => 'Hex-Dump:';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sprünge',
      one: 'Sprung',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => 'Pfad entfernen';

  @override
  String get chat_noPathHistoryYet =>
      'Keine Pfadhistorie vorhanden.\nSende eine Nachricht, um Pfade zu entdecken.';

  @override
  String get chat_pathCleared =>
      'Pfad zurückgesetzt. Nächste Nachricht wird Route neu entdecken.';

  @override
  String get chat_fullPath => 'Vollständiger Pfad';

  @override
  String get routing_title => 'Routenplanung';

  @override
  String get routing_modeAuto => 'Automatisch';

  @override
  String get routing_modeFlood => 'Flut';

  @override
  String get routing_modeManual => 'Manuell';

  @override
  String get routing_modeAutoHint =>
      'Wählt automatisch den besten bekannten Pfad und wechselt auf Flut, wenn keiner bekannt ist.';

  @override
  String get routing_modeFloodHint =>
      'Über alle Repeater senden. Am zuverlässigsten, aber mit höherem Funkzeitbedarf.';

  @override
  String get routing_modeManualHint =>
      'Sendet immer genau den von Ihnen festgelegten Pfad.';

  @override
  String get routing_currentRoute => 'Aktuelle Route';

  @override
  String get routing_directNoHops => 'Direkt - keine Repeater-Sprünge';

  @override
  String get routing_noPathYet =>
      'Noch kein Pfad gefunden. Die nächste Nachricht wird geflutet, bis eine Route entdeckt ist.';

  @override
  String get routing_floodBroadcast => 'Über alle Repeater senden';

  @override
  String get routing_editPath => 'Pfad bearbeiten';

  @override
  String get routing_forgetPath => 'Pfad vergessen';

  @override
  String get routing_knownPaths => 'Bekannte Pfade';

  @override
  String get routing_knownPathsHint =>
      'Tippen Sie auf einen Pfad, um zu ihm zu wechseln.';

  @override
  String get routing_inUse => 'In Verwendung';

  @override
  String get routing_qualityStrong => 'Starker erster Hop';

  @override
  String get routing_qualityGood => 'Guter erster Hop';

  @override
  String get routing_qualityFair => 'Ausreichender erster Hop';

  @override
  String get routing_qualityWorked => 'Hat zugestellt';

  @override
  String get routing_qualityFlood => 'Per Flood gehört';

  @override
  String get routing_qualityUntested => 'Nicht getestet';

  @override
  String routing_lastWorked(String when) {
    return 'funktionierte $when';
  }

  @override
  String get routing_neverWorked => 'nie bestätigt';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes zugestellt, $failures fehlgeschlagen';
  }

  @override
  String get routing_floodDelivery => 'Flood-Zustellung';

  @override
  String get pathEditor_title => 'Pfad erstellen';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count von 64 Sprüngen';
  }

  @override
  String get pathEditor_noHops =>
      'Noch keine Sprünge hinzugefügt. Tippen Sie unten auf Repeater, um sie in Reihenfolge hinzuzufügen, oder speichern Sie ohne Sprünge, um direkt zu senden.';

  @override
  String get pathEditor_addHops => 'Sprünge in Reihenfolge hinzufügen';

  @override
  String get pathEditor_searchRepeaters => 'Repeater suchen';

  @override
  String get pathEditor_advancedHex => 'Erweitert: roher Hex-Pfad';

  @override
  String get pathEditor_hexLabel => 'Hex-Präfixe';

  @override
  String get pathEditor_hexHelper =>
      'Zwei Hex-Zeichen pro Sprung, durch Kommas getrennt';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return 'Ungültig: $tokens';
  }

  @override
  String get pathEditor_tooManyHops => 'Maximal 64 Sprünge';

  @override
  String get pathEditor_usePath => 'Diesen Pfad verwenden';

  @override
  String get pathEditor_removeHop => 'Sprung entfernen';

  @override
  String get pathEditor_unknownHop => 'Unbekannter Repeater';

  @override
  String get chat_pathSavedLocally =>
      'Lokal Gespeichert. Bitte Verbinden zum Synchronisieren.';

  @override
  String get chat_pathDeviceConfirmed => 'Gerät bestätigt.';

  @override
  String get chat_pathDeviceNotConfirmed => 'Gerät noch nicht bestätigt.';

  @override
  String get chat_type => 'Gebe ein';

  @override
  String get chat_path => 'Pfad';

  @override
  String get chat_publicKey => 'Öffentlicher Schlüssel';

  @override
  String get chat_compressOutgoingMessages =>
      'Komprimieren ausgehender Nachrichten';

  @override
  String get chat_floodForced => 'Geflutet (erzwungen)';

  @override
  String get chat_directForced => 'Direkt (erzwungen)';

  @override
  String chat_hopsForced(int count) {
    return '$count Sprünge (erzwungen)';
  }

  @override
  String get chat_floodAuto => 'Geflutet (automatisch)';

  @override
  String get chat_direct => 'Direkt';

  @override
  String get chat_poiShared => 'Geteilter POI';

  @override
  String chat_unread(int count) {
    return 'Ungelesen: $count';
  }

  @override
  String get chat_markAsUnread => 'Als ungelesen markieren';

  @override
  String get chat_newMessages => 'Neue Nachrichten';

  @override
  String get chat_openLink => 'Link öffnen?';

  @override
  String get chat_openLinkConfirmation =>
      'Möchten Sie diesen Link in Ihrem Browser öffnen?';

  @override
  String get chat_open => 'Öffnen';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'Link konnte nicht geöffnet werden: $url';
  }

  @override
  String get chat_invalidLink => 'Ungültiges Link-Format';

  @override
  String get map_title => 'Karte';

  @override
  String get map_searchHint => 'Nach Knotenname oder ID suchen';

  @override
  String get map_activity => 'Aktivität';

  @override
  String get map_online => 'Online';

  @override
  String get map_recent => 'Kürzlich';

  @override
  String get map_stale => 'Veraltet';

  @override
  String get map_visible => 'Sichtbar';

  @override
  String get map_hidden => 'Versteckt';

  @override
  String get map_centerOnNode => 'Auf Knoten zentrieren';

  @override
  String get map_details => 'Details';

  @override
  String get map_noGps => 'Kein GPS';

  @override
  String get map_noResults => 'Keine passenden Knoten gefunden';

  @override
  String get map_lineOfSight => 'Sichtlinie';

  @override
  String get map_losScreenTitle => 'Sichtlinie';

  @override
  String get map_noNodesWithLocation => 'Keine Knoten mit Standortdaten';

  @override
  String get map_nodesNeedGps =>
      'Knoten müssen ihre GPS-Koordinaten teilen,\num auf der Karte zu erscheinen.';

  @override
  String map_nodesCount(int count) {
    return 'Knoten: $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'Nadeln: $count';
  }

  @override
  String get map_chat => 'Chat';

  @override
  String get map_repeater => 'Repeater';

  @override
  String get map_room => 'Raumserver';

  @override
  String get map_sensor => 'Sensor';

  @override
  String get map_pinDm => 'Pin (Kontakt)';

  @override
  String get map_pinPrivate => 'Pin (Channel)';

  @override
  String get map_pinPublic => 'Kennzeichnung (Öffentlich)';

  @override
  String get map_lastSeen => 'Zuletzt gesehen';

  @override
  String get map_disconnectConfirm =>
      'Sind Sie sicher, dass Sie sich von diesem Gerät trennen möchten?';

  @override
  String get map_from => 'Von';

  @override
  String get map_source => 'Quelle';

  @override
  String get map_flags => 'Flaggen';

  @override
  String get map_type => 'Typ';

  @override
  String get map_path => 'Pfad';

  @override
  String get map_location => 'Standort';

  @override
  String get map_estLocation => 'Geschätzter Standort';

  @override
  String get map_publicKey => 'Öffentlicher Schlüssel';

  @override
  String get map_publicKeyPrefixHint => 'z. B. ab12';

  @override
  String get map_shareMarkerHere => 'Marker hier teilen';

  @override
  String get map_setAsMyLocation => 'Als meine aktuelle Position festlegen';

  @override
  String get floodCorridor_title => 'Flood-Korridor';

  @override
  String get floodCorridor_previewToHere =>
      'Flood-Korridor bis hierher anzeigen';

  @override
  String get floodCorridor_requesting =>
      'Korridor wird beim Funkgerät angefragt…';

  @override
  String get floodCorridor_unsupported =>
      'Die Firmware deines Funkgeräts unterstützt keine Flood-Korridore.';

  @override
  String get floodCorridor_noProposal =>
      'Dein Funkgerät konnte keinen Korridor vorschlagen. Stelle sicher, dass eine Position gesetzt ist.';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Kreise',
      one: '1 Kreis',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return '$inside von $total bekannten Repeatern innerhalb';
  }

  @override
  String get floodCorridor_straightLine =>
      'Gerade Linie: keine bekannten Repeater auf dem Weg';

  @override
  String get floodCorridor_followsRepeaters =>
      'Folgt deinen bekannten Repeatern';

  @override
  String get floodCorridor_horizonLimited =>
      'Bekannte Repeater reichen nicht bis zum Ziel; der Rest ist eine gerade Linie';

  @override
  String get floodCorridor_thinStretch =>
      'Ein Teil des Korridors hat wenige bekannte Repeater';

  @override
  String get floodCorridor_moreCoverage => 'Mehr Repeater-Abdeckung verlangen';

  @override
  String get floodCorridor_previewNote =>
      'Nur Vorschau. Repeater ohne Korridor-Firmware wenden keine Korridore an.';

  @override
  String get map_pinLabel => 'Pin-Beschriftung';

  @override
  String get map_label => 'Beschriftung';

  @override
  String get map_pointOfInterest => 'Punkt von Interesse';

  @override
  String get map_sendToContact => 'An Kontakt senden';

  @override
  String get map_sendToChannel => 'An Kanal senden';

  @override
  String get map_noChannelsAvailable => 'Keine Kanäle verfügbar';

  @override
  String get map_publicLocationShare => 'Öffentliche Standortfreigabe';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return 'Sie sind dabei, einen Standort in $channelLabel zu teilen. Dieser Kanal ist öffentlich und jeder mit dem PSK kann ihn sehen.';
  }

  @override
  String get map_connectToShareMarkers =>
      'Mit einem Gerät verbinden, um Marker zu teilen';

  @override
  String get map_filterNodes => 'Knoten filtern';

  @override
  String get map_nodeTypes => 'Knotentypen';

  @override
  String get map_chatNodes => 'Chat-Knoten';

  @override
  String get map_repeaters => 'Repeater';

  @override
  String get map_otherNodes => 'Andere Knoten';

  @override
  String get map_showOverlaps => 'Repeater-Schlüsselüberlappungen';

  @override
  String get map_keyPrefix => 'Schlüsselpräfix';

  @override
  String get map_filterByKeyPrefix => 'Nach Schlüsselpräfix filtern';

  @override
  String get map_publicKeyPrefix => 'Präfix des öffentlichen Schlüssels';

  @override
  String get map_markers => 'Marker';

  @override
  String get map_showSharedMarkers => 'Gemeinsam genutzte Marker anzeigen';

  @override
  String get map_showGuessedLocations => 'Vermutete Knotenstandorte anzeigen';

  @override
  String get map_showDiscoveryContacts => 'Entdeckte Kontakte anzeigen';

  @override
  String get map_guessedLocation => 'Vermuteter Standort';

  @override
  String get map_lastSeenTime => 'Letzte Sichtung';

  @override
  String get map_sharedPin => 'Gemeinsamer Pin';

  @override
  String get map_sharedAt => 'Geteilt am';

  @override
  String get map_joinRoom => 'Raum beitreten';

  @override
  String get map_manageRepeater => 'Repeater verwalten';

  @override
  String get map_tapToAdd =>
      'Tippen Sie auf Knoten, um sie zum Pfad hinzuzufügen.';

  @override
  String get map_runTrace => 'Pfadverlauf ausführen';

  @override
  String get map_runTraceWithReturnPath =>
      'Auf dem gleichen Pfad zurückkehren.';

  @override
  String get map_removeLast => 'Letztes entfernen';

  @override
  String get map_pathTraceCancelled => 'Pfadverfolgung abgebrochen.';

  @override
  String get mapCache_title => 'Offline-Karten-Cache';

  @override
  String get mapCache_selectAreaFirst =>
      'Wählen Sie zuerst einen Bereich zum Zwischenspeichern aus.';

  @override
  String get mapCache_noTilesToDownload =>
      'Keine Kacheln für diese Region zum Herunterladen verfügbar.';

  @override
  String get mapCache_downloadTilesTitle => 'Kacheln herunterladen';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return '$count Kacheln für die Offline-Nutzung herunterladen?';
  }

  @override
  String get mapCache_downloadAction => 'Herunterladen';

  @override
  String mapCache_cachedTiles(int count) {
    return '$count Kacheln zwischengespeichert';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return '$downloaded Kacheln zwischengespeichert ($failed fehlgeschlagen)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => 'Offline-Cache leeren';

  @override
  String get mapCache_clearOfflineCachePrompt =>
      'Alle zwischengespeicherten Kartenkacheln entfernen?';

  @override
  String get mapCache_offlineCacheCleared => 'Offline-Cache gelöscht';

  @override
  String get mapCache_noAreaSelected => 'Kein Bereich ausgewählt';

  @override
  String get mapCache_cacheArea => 'Bereich zwischenspeichern';

  @override
  String get mapCache_useCurrentView => 'Aktuelle Ansicht verwenden';

  @override
  String get mapCache_zoomRange => 'Zoombereich';

  @override
  String mapCache_estimatedTiles(int count) {
    return 'Geschätzte Kacheln: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return 'Heruntergeladen $completed / $total';
  }

  @override
  String get mapCache_downloadTilesButton => 'Kacheln herunterladen';

  @override
  String get mapCache_clearCacheButton => 'Cache leeren';

  @override
  String mapCache_failedDownloads(int count) {
    return 'Fehlgeschlagene Downloads: $count';
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
  String get time_justNow => 'Gerade eben';

  @override
  String time_minutesAgo(int minutes) {
    return 'vor $minutes Min.';
  }

  @override
  String time_hoursAgo(int hours) {
    return 'vor $hours Std.';
  }

  @override
  String time_daysAgo(int days) {
    return 'vor $days Tagen';
  }

  @override
  String get time_hour => 'Stunde';

  @override
  String get time_hours => 'Stunden';

  @override
  String get time_day => 'Tag';

  @override
  String get time_days => 'Tage';

  @override
  String get time_week => 'Woche';

  @override
  String get time_weeks => 'Wochen';

  @override
  String get time_month => 'Monat';

  @override
  String get time_months => 'Monate';

  @override
  String get time_minutes => 'Minuten';

  @override
  String get time_allTime => 'Ganzer Zeitraum';

  @override
  String get dialog_disconnect => 'Trennen';

  @override
  String get dialog_disconnectConfirm =>
      'Sind Sie sicher, dass Sie sich von diesem Gerät trennen möchten?';

  @override
  String get login_repeaterLogin => 'Beim Repeater anmelden';

  @override
  String get login_roomLogin => 'Raum-Login';

  @override
  String get login_password => 'Passwort';

  @override
  String get login_enterPassword => 'Passwort eingeben';

  @override
  String get login_savePassword => 'Passwort speichern';

  @override
  String get login_savePasswordSubtitle =>
      'Das Passwort wird auf diesem Gerät sicher gespeichert.';

  @override
  String get login_repeaterDescription =>
      'Geben Sie das Repeater-Passwort ein, um auf Einstellungen und Status zuzugreifen.';

  @override
  String get login_roomDescription =>
      'Geben Sie das Raumkennwort ein, um auf die Einstellungen und den Status zuzugreifen.';

  @override
  String get login_routing => 'Routen';

  @override
  String get login_routingMode => 'Routenmodus';

  @override
  String get login_autoUseSavedPath =>
      'Automatisch (gespeicherten Pfad verwenden)';

  @override
  String get login_forceFloodMode => 'Flut-Modus erzwingen';

  @override
  String get login_managePaths => 'Pfadverwaltung';

  @override
  String get login_login => 'Anmelden';

  @override
  String login_attempt(int current, int max) {
    return 'Versuche $current/$max';
  }

  @override
  String login_failed(String error) {
    return 'Anmeldung fehlgeschlagen: $error';
  }

  @override
  String get login_failedMessage =>
      'Anmeldung fehlgeschlagen. Entweder ist das Passwort falsch oder der Repeater ist nicht erreichbar.';

  @override
  String get common_reload => 'Neu laden';

  @override
  String get common_clear => 'Leeren';

  @override
  String get path_currentPathLabel => 'Aktueller Pfad';

  @override
  String get path_noRepeatersFound =>
      'Keine Repeater oder Raumserver gefunden.';

  @override
  String get repeater_management => 'Repeater-Verwaltung';

  @override
  String get room_management => 'Raum-Server-Verwaltung';

  @override
  String get repeater_guest => 'Informationen zu Repeatern';

  @override
  String get room_guest => 'Informationen zum Room Server';

  @override
  String get repeater_managementTools => 'Verwaltungstools';

  @override
  String get repeater_guestTools => 'Gastwerkzeuge';

  @override
  String get repeater_status => 'Status';

  @override
  String get repeater_statusSubtitle =>
      'Repeater-Status, Statistiken und Nachbarn anzeigen';

  @override
  String get repeater_telemetry => 'Telemetrie';

  @override
  String get repeater_telemetrySubtitle =>
      'Telemetriedaten und Systemstatistiken anzeigen';

  @override
  String get repeater_cli => 'CLI';

  @override
  String get repeater_cliSubtitle => 'Befehle an den Repeater senden';

  @override
  String get repeater_neighbors => 'Nachbarn';

  @override
  String get repeater_neighborsSubtitle => 'Anzahl der Hop-Nachbarn anzeigen.';

  @override
  String get repeater_settings => 'Einstellungen';

  @override
  String get repeater_settingsSubtitle => 'Repeater-Parameter konfigurieren';

  @override
  String get repeater_clockSyncAfterLogin =>
      'Uhrzeit-Synchronisation nach dem Anmelden';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      'Automatisch \"Uhrzeit-Synchronisierung\" nach erfolgreicher Anmeldung senden.';

  @override
  String get repeater_statusTitle => 'Repeater-Status';

  @override
  String get repeater_routingMode => 'Routing-Modus';

  @override
  String get repeater_refresh => 'Aktualisieren';

  @override
  String get repeater_statusRequestTimeout => 'Statusanfrage abgelaufen.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'Fehler beim Laden des Status: $error';
  }

  @override
  String get repeater_systemInformation => 'Systeminformationen';

  @override
  String get repeater_battery => 'Akku';

  @override
  String get repeater_clockAtLogin => 'Uhr (bei Anmeldung)';

  @override
  String get repeater_uptime => 'Betriebszeit';

  @override
  String get repeater_queueLength => 'Warteschlangenlänge';

  @override
  String get repeater_debugFlags => 'Debug-Flags';

  @override
  String get repeater_radioStatistics => 'Funkstatistiken';

  @override
  String get repeater_lastRssi => 'Letzter RSSI';

  @override
  String get repeater_lastSnr => 'Letzter SNR';

  @override
  String get repeater_noiseFloor => 'Rauschpegel';

  @override
  String get repeater_txAirtime => 'TX Airtime';

  @override
  String get repeater_rxAirtime => 'RX Airtime';

  @override
  String get repeater_chanUtil => 'Nutzung des Kanals';

  @override
  String get repeater_packetStatistics => 'Paketstatistiken';

  @override
  String get repeater_sent => 'Gesendet';

  @override
  String get repeater_received => 'Empfangen';

  @override
  String get repeater_duplicates => 'Duplikate';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days Tage ${hours}h ${minutes}m ${seconds}s';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return 'Gesamt: $total, Flood: $flood, Direkt: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return 'Gesamt: $total, Flood: $flood, Direkt: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return 'Flood: $flood, Direkt: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return 'Gesamt: $total';
  }

  @override
  String get repeater_settingsTitle => 'Repeater-Einstellungen';

  @override
  String get repeater_basicSettings => 'Grundeinstellungen';

  @override
  String get repeater_repeaterName => 'Repeatername';

  @override
  String get repeater_repeaterNameHelper => 'Anzeigename für diesen Repeater';

  @override
  String get repeater_adminPassword => 'Admin-Passwort';

  @override
  String get repeater_adminPasswordHelper => 'Passwort für Vollzugriff';

  @override
  String get repeater_guestPassword => 'Gast-Passwort';

  @override
  String get repeater_guestPasswordHelper => 'Passwort für Lesezugriff';

  @override
  String get repeater_radioSettings => 'Funk-Einstellungen';

  @override
  String get repeater_frequencyMhz => 'Frequenz (MHz)';

  @override
  String get repeater_frequencyHelper => '300–2500 MHz';

  @override
  String get repeater_txPower => 'Sendeleistung';

  @override
  String get repeater_txPowerHelper => '1-30 dBm';

  @override
  String get repeater_bandwidth => 'Bandbreite';

  @override
  String get repeater_spreadingFactor => 'Spreading-Faktor';

  @override
  String get repeater_codingRate => 'Kodierungsrate';

  @override
  String get repeater_locationSettings => 'Standorteinstellungen';

  @override
  String get repeater_latitude => 'Breitengrad';

  @override
  String get repeater_latitudeHelper => 'Dezimalgrad (z.B. 37,7749)';

  @override
  String get repeater_longitude => 'Längengrad';

  @override
  String get repeater_longitudeHelper => 'Dezimalgrad (z.B. -122,4194)';

  @override
  String get repeater_features => 'Funktionen';

  @override
  String get repeater_packetForwarding => 'Paketweiterleitung';

  @override
  String get repeater_packetForwardingSubtitle =>
      'Den Repeater aktivieren, um Pakete weiterzuleiten';

  @override
  String get repeater_guestAccess => 'Gastzugriff';

  @override
  String get repeater_guestAccessSubtitle => 'Nur-Lese-Gastzugriff erlauben';

  @override
  String get repeater_privacyMode => 'Privatsphärenmodus';

  @override
  String get repeater_privacyModeSubtitle =>
      'Name und Standort in Ankündigungen verbergen';

  @override
  String get repeater_advertisementSettings => 'Ankündigungseinstellungen';

  @override
  String get repeater_localAdvertInterval => 'Lokales Ankündigungsintervall';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes Minuten';
  }

  @override
  String get repeater_floodAdvertInterval => 'Flood-Ankündigungsintervall';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours Stunden';
  }

  @override
  String get repeater_encryptedAdvertInterval =>
      'Verschlüsseltes Ankündigungsintervall';

  @override
  String get repeater_dangerZone => 'Gefahrenzone';

  @override
  String get repeater_rebootRepeater => 'Repeater neu starten';

  @override
  String get repeater_rebootRepeaterSubtitle => 'Repeater-Gerät neu starten';

  @override
  String get repeater_rebootRepeaterConfirm =>
      'Sind Sie sicher, dass Sie diesen Repeater neu starten möchten?';

  @override
  String get repeater_regenerateIdentityKey =>
      'Identitätsschlüssel neu erzeugen';

  @override
  String get repeater_regenerateIdentityKeySubtitle =>
      'Neues öffentlich-privates Schlüsselpaar erzeugen';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'Dies erzeugt eine neue Identität für den Repeater. Fortfahren?';

  @override
  String get repeater_eraseFileSystem => 'Dateisystem löschen';

  @override
  String get repeater_eraseFileSystemSubtitle =>
      'Das Dateisystem des Repeaters formatieren';

  @override
  String get repeater_eraseFileSystemConfirm =>
      'WARNUNG: Dies löscht alle Daten auf dem Repeater. Dies kann nicht rückgängig gemacht werden!';

  @override
  String get repeater_eraseSerialOnly =>
      'Löschen ist nur über die serielle Konsole verfügbar.';

  @override
  String repeater_commandSent(String command) {
    return 'Befehl gesendet: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'Fehler beim Senden des Befehls: $error';
  }

  @override
  String get repeater_confirm => 'Bestätigen';

  @override
  String get repeater_settingsSaved => 'Einstellungen erfolgreich gespeichert';

  @override
  String get repeater_rxGain => 'Verstärkter RX-Gewinn';

  @override
  String get repeater_rxGainHelper =>
      'Höhere Empfindlichkeit, höherer Stromverbrauch (nur SX1262/SX1268)';

  @override
  String get repeater_refreshRxGain => 'Verstärkten RX-Gewinn aktualisieren';

  @override
  String get repeater_multiAcks => 'Mehrfach-ACKs';

  @override
  String get repeater_multiAcksSubtitle =>
      'Nachrichten über mehrere Pfade bestätigen, um die Zustellung zu verbessern';

  @override
  String get repeater_refreshMultiAcks => 'Mehrfach-ACKs aktualisieren';

  @override
  String get repeater_networkHealth => 'Netzwerkzustand';

  @override
  String get repeater_loopDetect => 'Schleifenerkennung';

  @override
  String get repeater_loopDetectHelper =>
      'Flood-Pakete verwerfen, die wie Routing-Schleifen aussehen';

  @override
  String get repeater_loopDetectOff => 'Aus';

  @override
  String get repeater_loopDetectMinimal => 'Minimal';

  @override
  String get repeater_loopDetectModerate => 'mäßig';

  @override
  String get repeater_loopDetectStrict => 'Streng';

  @override
  String get repeater_dutyCycle => 'Duty-Cycle';

  @override
  String get repeater_dutyCycleHelper =>
      'Höchster zulässiger Prozentsatz der Sendefläche';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => 'Betreiberinformationen';

  @override
  String get repeater_ownerInfoHelper =>
      'Öffentliche Metadaten für diesen Repeater';

  @override
  String get repeater_refreshOwnerInfo =>
      'Betreiberinformationen aktualisieren';

  @override
  String get repeater_floodMax => 'Maximale Flood-Sprünge';

  @override
  String get repeater_floodMaxHelper =>
      'Maximale Anzahl von Sprüngen, die ein Flood-Paket zurücklegen darf (0-64)';

  @override
  String get repeater_advancedSettings => 'Erweitert';

  @override
  String get repeater_advancedSettingsSubtitle =>
      'Feinabstimmung für erfahrene Betreiber';

  @override
  String get repeater_pathHashMode => 'Hash-Modus für Pfade';

  @override
  String get repeater_pathHashModeHelper =>
      'Bytes, die zur Kodierung der ID dieses Repeaters in Flood-Pfad-/Schleifen-Erkennung-Tags verwendet werden. 0 = 1 Byte (256 IDs, bis zu 64 Hops), 1 = 2 Bytes (65.000 IDs, bis zu 32 Hops), 2 = 3 Bytes (16 Millionen IDs, bis zu 21 Hops). Firmware-Versionen 1.13 und älter verwenden mehrstellige Pfade – ab Version 1.14+ wird nur ein Pfad erstellt, sobald das Netzwerk aktiv ist.';

  @override
  String get repeater_keySettings => 'Identitätsschlüssel ändern';

  @override
  String get repeater_keySettingsSubtitle =>
      'Ändern Sie das öffentliche/private Schlüsselpaar';

  @override
  String get repeater_prvKey => 'Privatschlüssel';

  @override
  String get repeater_prvKeyHelper =>
      'Ein neuer privater Schlüssel für den Repeater, eine 128-stellige Hexadezimalzeichenkette.';

  @override
  String get repeater_generatePrvKey =>
      'Generiere ein zufälliges Schlüsselpaar';

  @override
  String get repeater_stopGeneratingPrvKey =>
      'Suchvorgang für Schlüsselpaar unterbrechen';

  @override
  String get repeater_pubKey => 'Öffentlicher Schlüssel';

  @override
  String get repeater_pubKeyHelper =>
      'Dies ist der öffentliche Schlüssel, der zum generierten privaten Schlüssel gehört. Sie können dies nicht direkt festlegen.';

  @override
  String get repeater_pubKeyPrefix => 'Gewünschtes Präfix';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'Suchen Sie einen öffentlichen Schlüssel, der mit diesen Hexadezimalziffern beginnt. Erwartete Versuche: $tries.';
  }

  @override
  String get repeater_txDelay => 'Flood-TX-Verzögerung';

  @override
  String get repeater_txDelayHelper =>
      'Abstand für Flood-Verkehr als Faktor der Paket-Sendezeit (0-2, Standard 0,5). Höher = weniger Kollisionen, aber langsamere Zustellung.';

  @override
  String get repeater_directTxDelay => 'Direkte TX-Verzögerung';

  @override
  String get repeater_directTxDelayHelper =>
      'Abstand für direkten (Nicht-Flood-)Verkehr als Faktor der Paket-Sendezeit (0-2, Standard 0,3).';

  @override
  String get repeater_intThresh => 'Interferenzschwelle';

  @override
  String get repeater_intThreshHelper =>
      'Schwelle für die Rauschboden-Kalibrierung des Radios; ignoriert Interferenzen oberhalb dieses Werts. 0 deaktiviert - nur erhöhen, wenn in einem lauten Band RX-Fehler auftreten.';

  @override
  String get repeater_agcResetInterval => 'AGC-Reset-Intervall';

  @override
  String get repeater_agcResetIntervalHelper =>
      'Wie oft die automatische Verstärkungsregelung zurückgesetzt werden soll, um aus einem festgefahrenen Verstärkungszustand zu kommen. Sekunden, auf ein Vielfaches von 4 abgerundet. 0 deaktiviert periodische Resets.';

  @override
  String get repeater_actionsTitle => 'Aktionen';

  @override
  String get repeater_sendAdvert => 'Flood-Ankündigung senden';

  @override
  String get repeater_sendAdvertSubtitle =>
      'Eine Flood-Ankündigung über das Netzwerk senden';

  @override
  String get repeater_sendAdvertZeroHop => 'Zero-Hop-Ankündigung senden';

  @override
  String get repeater_sendAdvertZeroHopSubtitle =>
      'Eine Ein-Hop-Ankündigung ohne Weiterleiter senden';

  @override
  String get repeater_clockSync => 'Uhr jetzt synchronisieren';

  @override
  String get repeater_clockSyncSubtitle =>
      'Die Zeit Ihres Telefons an den Repeater übertragen';

  @override
  String repeater_actionSucceeded(String action) {
    return '$action erfolgreich';
  }

  @override
  String repeater_actionFailed(String action, String error) {
    return '$action fehlgeschlagen: $error';
  }

  @override
  String get repeater_settingsSavedRebootNeeded =>
      'Einstellungen gespeichert - starten Sie den Repeater neu, um sie anzuwenden';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return 'Einige Einstellungen sind fehlgeschlagen: $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return 'Fehler beim Speichern der Einstellungen: $error';
  }

  @override
  String get repeater_refreshBasicSettings =>
      'Grundeinstellungen aktualisieren';

  @override
  String get repeater_refreshRadioSettings =>
      'Funk-Einstellungen aktualisieren';

  @override
  String get repeater_refreshTxPower => 'Sendeleistung aktualisieren';

  @override
  String get repeater_refreshPacketForwarding =>
      'Paketweiterleitung aktualisieren';

  @override
  String get repeater_refreshGuestAccess => 'Gastzugriff aktualisieren';

  @override
  String get repeater_refreshPrivacyMode => 'Privatsphärenmodus aktualisieren';

  @override
  String repeater_refreshed(String label) {
    return '$label aktualisiert';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return 'Fehler beim Aktualisieren von $label';
  }

  @override
  String get repeater_cliTitle => 'Repeater-CLI';

  @override
  String get repeater_debugNextCommand => 'Nächsten Befehl debuggen';

  @override
  String get repeater_commandHelp => 'Befehls-Hilfe';

  @override
  String get repeater_clearHistory => 'Verlauf löschen';

  @override
  String get repeater_noCommandsSent => 'Noch keine Befehle gesendet';

  @override
  String get repeater_typeCommandOrUseQuick =>
      'Geben Sie unten einen Befehl ein oder verwenden Sie die Schnellbefehle';

  @override
  String get repeater_enterCommandHint => 'Befehl eingeben...';

  @override
  String get repeater_previousCommand => 'Vorheriger Befehl';

  @override
  String get repeater_nextCommand => 'Nächster Befehl';

  @override
  String get repeater_enterCommandFirst => 'Geben Sie zuerst einen Befehl ein';

  @override
  String get repeater_cliCommandFrameTitle => 'CLI-Befehlsframe';

  @override
  String repeater_cliCommandError(String error) {
    return 'Fehler: $error';
  }

  @override
  String get repeater_cliQuickGetName => 'Name abrufen';

  @override
  String get repeater_cliQuickGetRadio => 'Funkdaten abrufen';

  @override
  String get repeater_cliQuickGetTx => 'TX abrufen';

  @override
  String get repeater_cliQuickNeighbors => 'Nachbarn';

  @override
  String get repeater_cliQuickVersion => 'Version';

  @override
  String get repeater_cliQuickAdvertise => 'Ankündigen';

  @override
  String get repeater_cliQuickClock => 'Uhr';

  @override
  String get repeater_cliQuickClockSync => 'Uhr synchronisieren';

  @override
  String get repeater_cliQuickDiscovery => 'Nachbarn entdecken';

  @override
  String get repeater_cliHelpAdvert => 'Sendet eine Ankündigung';

  @override
  String get repeater_cliHelpReboot =>
      'Startet das Gerät neu. (Beachten Sie, dass es möglicherweise zu einer \'Timeout\'-Situation kommt, was normal ist.)';

  @override
  String get repeater_cliHelpClock =>
      'Zeigt die aktuelle Uhrzeit pro Gerät an.';

  @override
  String get repeater_cliHelpPassword =>
      'Legt ein neues Administrator-Passwort für das Gerät fest.';

  @override
  String get repeater_cliHelpVersion =>
      'Zeigt die Geräteversion und das Datum des Firmware-Builds an.';

  @override
  String get repeater_cliHelpClearStats =>
      'Setzt verschiedene Statistikberechnungen auf Null zurück.';

  @override
  String get repeater_cliHelpSetAf => 'Legt den Luftzeitfaktor fest.';

  @override
  String get repeater_cliHelpSetTx =>
      'Legt die LoRa-Sendeleistung in dBm fest. (Neustart erforderlich, um die Änderungen anzuwenden)';

  @override
  String get repeater_cliHelpSetRepeat =>
      'Aktiviert oder deaktiviert die Repeater-Rolle für diesen Knoten.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(Raumspeicher) Wenn \'an\', dann wird die Anmeldung mit einem leeren Passwort erlaubt sein, aber es kann nicht in den Raum gesendet werden. (nur lesen möglich).';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'Legt die maximale Anzahl an Sprüngen für eingehende Flood-Pakete fest (wenn >= max, wird das Paket nicht weitergeleitet)';

  @override
  String get repeater_cliHelpSetIntThresh =>
      'Legt den Interferenzeniveau (in dB) fest. Der Standardwert ist 14. Auf 0 setzen, um die Erkennung von Kanalinterferenzen zu deaktivieren.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'Legt das Intervall für das Zurücksetzen des Auto Gain Controllers fest. Auf 0 setzen, um die Funktion zu deaktivieren.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      'Aktiviert oder deaktiviert die Funktion \'Doppel-ACKs\'.';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'Legt das Timer-Intervall in Minuten fest, um ein lokales (ohne-Weiterleitung) Ankündigungspaket zu senden. Auf 0 setzen, um die Funktion zu deaktivieren.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'Legt das Timer-Intervall in Stunden für den Versand eines Flut-Ankündigungspacket fest. Auf 0 setzen, um es zu deaktivieren.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'Legt/aktualisiert das Gastpasswort fest. (für Repeater können Gast-Logins die \"Get Stats\"-Anfrage senden)';

  @override
  String get repeater_cliHelpSetName => 'Legt den Anzeigenamen fest.';

  @override
  String get repeater_cliHelpSetLat =>
      'Legt die Breitengrad der Ankündigung fest. (dezimale Grad)';

  @override
  String get repeater_cliHelpSetLon =>
      'Legt die Längengrade der Ankündigung fest. (dezimale Grad)';

  @override
  String get repeater_cliHelpSetRadio =>
      'Legt komplett neue Radio-Parameter fest und speichert diese als Präferenzen. Benötigt einen \"Reboot\"-Befehl, um sie anzuwenden.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      'Fügt eine leichte Verzögerung bei empfangenen Paketen hinzu, basierend auf Signalstärke/Punktzahl. Auf 0 setzen, um die Funktion zu deaktivieren.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      'Legt einen Faktor fest, der mit der Sendezeit eines Flood-Mode-Pakets und mit einem zufälligen Slot-System multipliziert wird, um dessen Weiterleitung zu verzögern (um Kollisionen zu vermeiden).';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'Ähnlich wie txdelay, aber zum Anwenden einer zufälligen Verzögerung bei der Weiterleitung von Direktmodus-Paketen.';

  @override
  String get repeater_cliHelpSetBridgeEnabled =>
      'Brücke aktivieren/deaktivieren.';

  @override
  String get repeater_cliHelpSetBridgeDelay =>
      'Setze Verzögerung vor erneuter Übertragung von Paketen.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      'Wählen Sie, ob über die Brücke empfangene oder gesendete Pakete erneut übertragen soll.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'Setze die serielle Link-Baudrate für RS232-Brücken.';

  @override
  String get repeater_cliHelpSetBridgeSecret =>
      'Richte das Brückenpassword ein.';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      'Legt einen benutzerdefinierten Faktor zur Anpassung der gemeldeten Batteriewirkspannung fest (nur auf ausgewählten Boards unterstützt).';

  @override
  String get repeater_cliHelpTempRadio =>
      'Legt vorübergehende Funkparameter für die angegebene Anzahl von Minuten fest und kehrt anschließend zu den ursprünglichen Funkparametern zurück (wird nicht in den Einstellungen gespeichert).';

  @override
  String get repeater_cliHelpSetPerm =>
      'Ändert die ACL. Entfernt das passende Eintragen (durch Pubkey-Präfix), wenn \"permissions\" auf 0 steht. Fügt ein neues Eintragen hinzu, wenn die Pubkey-Hex-Länge vollständig ist und nicht bereits in der ACL vorhanden ist. Aktualisiert das Eintragen anhand des übereinstimmenden Pubkey-Präfix. Berechtigungsbits variieren je nach Firmware-Rolle, aber die unteren 2 Bits sind: 0 (Gast), 1 (Nur Lesen), 2 (Lesen/Schreiben), 3 (Admin)';

  @override
  String get repeater_cliHelpGetBridgeType =>
      'Ruft Brückentyp: none, rs232, espnow ab.';

  @override
  String get repeater_cliHelpLogStart =>
      'Beginnt die Paketprotokollierung in das Dateisystem.';

  @override
  String get repeater_cliHelpLogStop =>
      'Stoppt das Paketprotokollieren in das Dateisystem.';

  @override
  String get repeater_cliHelpLogErase =>
      'Löscht die Paketprotokolle aus dem Dateisystem.';

  @override
  String get repeater_cliHelpNeighbors =>
      'Zeigt eine Liste anderer Repeater-Knoten an, die über Zero-Hop-Ankündigung gehört wurden. Jede Zeile ist id-prefix-hex:timestamp:snr-times-4';

  @override
  String get repeater_cliHelpNeighborRemove =>
      'Entfernt das erste übereinstimmende Element (über Pubkey-Präfix (hex)) aus der Liste der Nachbarn.';

  @override
  String get repeater_cliHelpRegion => 'Listet alle definierten Regionen auf.';

  @override
  String get repeater_cliHelpRegionLoad =>
      'Hinweis: Dies ist ein spezieller Mehrbefehl-Aufruf. Jeder nachfolgende Befehl ist ein Regionsname (eingerückt mit Leerzeichen zur Angabe der übergeordneten Hierarchie, mit mindestens einem Leerzeichen). Beendet durch das Senden einer Leerzeile.';

  @override
  String get repeater_cliHelpRegionGet =>
      'Sucht die Region mit dem gegebenen Namenspräfix (oder \"\\\" für den globalen Scope) und antwortet mit \"-> region-name (parent-name) \'F\'\".';

  @override
  String get repeater_cliHelpRegionPut =>
      'Fügt eine Region-Definition mit dem angegebenen Namen hinzu oder aktualisiert diese.';

  @override
  String get repeater_cliHelpRegionRemove =>
      'Löscht eine Regiondefinition mit dem angegebenen Namen. (muss genau übereinstimmen und keine Kindregionen haben)';

  @override
  String get repeater_cliHelpRegionAllowf =>
      'Legt die \'Flut\'-Berechtigung für die angegebene Region fest. (\'\' für den globalen/legacy-Bereich)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      'Entfernt die \"F\"lood-Berechtigung für die angegebene Region. (ANMERKUNG: in dieser Phase wird nicht empfohlen, dies auf dem globalen/legacy-Bereich zu verwenden!!)';

  @override
  String get repeater_cliHelpRegionHome =>
      'Antwortet mit der aktuellen \'Home\'-Region. (Hinweis wurde bisher nirgendwo angewendet, für zukünftige Zwecke reserviert)';

  @override
  String get repeater_cliHelpRegionHomeSet => 'Legt die \'Home\'-Region fest.';

  @override
  String get repeater_cliHelpRegionSave =>
      'Speichert die Regionenliste/Karte in den Speicher.';

  @override
  String get repeater_cliHelpGps =>
      'Zeigt GPS-Status an. Wenn GPS deaktiviert ist, antwortet es nur mit \"aus\", wenn es eingeschaltet ist, antwortet es mit \"an\", \"Status\", \"Fix\" und Satellitenanzahl.';

  @override
  String get repeater_cliHelpGpsOnOff => 'Schaltet die GPS-Leistung ein/aus.';

  @override
  String get repeater_cliHelpGpsSync =>
      'Synchronisiert die Knotenzeit mit der GPS-Uhr.';

  @override
  String get repeater_cliHelpGpsSetLoc =>
      'Setze die Position des Knotens auf GPS-Koordinaten und speichere die Präferenzen.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'Gibt Konfiguration für die Standortanzeige des Knotens:\n- none: Standort nicht in Anzeigen einbeziehen\n- share: GPS-Standort teilen (von SensorManager)\n- prefs: Standort aus Einstellungen anzeigen';

  @override
  String get repeater_cliHelpGpsAdvertSet =>
      'Legt die Standort-Anzeigekonfiguration fest.';

  @override
  String get repeater_commandsListTitle => 'Befehlsliste';

  @override
  String get repeater_commandsListNote =>
      'ACHTUNG: Für die verschiedenen „set ...“-Befehle gibt es auch einen „get ...“-Befehl.';

  @override
  String get repeater_general => 'Allgemein';

  @override
  String get repeater_settingsCategory => 'Einstellungen';

  @override
  String get repeater_bridge => 'Brücke';

  @override
  String get repeater_logging => 'Protokollierung';

  @override
  String get repeater_neighborsRepeaterOnly => 'Nachbarn (nur Repeater)';

  @override
  String get repeater_regionManagementRepeaterOnly =>
      'Regionenverwaltung (nur Repeater)';

  @override
  String get repeater_regionNote =>
      'Region-Befehle wurden eingeführt, um Region-Definitionen und Berechtigungen zu verwalten.';

  @override
  String get repeater_gpsManagement => 'GPS-Verwaltung';

  @override
  String get repeater_gpsNote =>
      'Der GPS-Befehl wurde eingeführt, um Standortbezogene Themen zu verwalten.';

  @override
  String get repeater_getCategory => 'Werte erhalten';

  @override
  String get repeater_powerMgmt => 'Energieverwaltung';

  @override
  String get repeater_sensors => 'Sensoren';

  @override
  String get repeater_cliHelpPowerOff =>
      'Schaltet das Gerät aus. (keine Antwort erwartet)';

  @override
  String get repeater_cliHelpClkReboot =>
      'Setzt die Uhr auf einen bekannten Zeitpunkt zurück und startet das Gerät neu.';

  @override
  String get repeater_cliHelpAdvertZeroHop =>
      'Sendet eine Werbeanzeige, die nur an unmittelbare Nachbarn gesendet wird (ohne Zwischenstation).';

  @override
  String get repeater_cliHelpStartOta =>
      'Startet ein Firmware-Update über Funk, das auf unterstützten Boards durchgeführt wird.';

  @override
  String get repeater_cliHelpTime =>
      'Stellt die Gerätuhr auf die angegebene Unix-Epoche in Sekunden ein. Die Uhr kann nicht rückwärts laufen.';

  @override
  String get repeater_cliHelpBoard =>
      'Zeigt den Hersteller/die Hardware-Kennung an.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      'Sendet eine Anfrage zur Entdeckung von Nachbarn in der Nähe. (Nur bei Repeatern)';

  @override
  String get repeater_cliHelpPowersaving =>
      'Zeigt an, ob der Energiesparmodus aktiviert oder deaktiviert ist.';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      'Aktiviert oder deaktiviert den Energiesparmodus (falls unterstützt).';

  @override
  String get repeater_cliHelpErase =>
      '(Nur für serielle Schnittstellen) Formatiert das Dateisystem des Geräts. Löscht alle Einstellungen und Kontakte.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      'Legt den maximal zulässigen Übertragungszyklus als Prozentsatz fest (1-100). Passt den Zeitfaktor intern an.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '(Nur für serielle Anwendungen) Ersetzt den privaten Schlüssel zur Geräteidentifizierung. Nach der Anwendung ist ein Neustart erforderlich. Generiert einen neuen öffentlichen Schlüssel.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(Nur für SX126x) Schaltet die verstärkte RX-Verstärkung ein, um die Empfindlichkeit bei höherem Stromverbrauch zu verbessern.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      'Definiert den String mit den Kontaktinformationen des Eigentümers, der in den Anzeigen enthalten ist. Verwenden Sie \'|\' für Zeilenumbrüche.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'Legt den Modus für die Pfad-Hashes fest. 0 = ältere Version, 1 = Standard, 2 = streng. Beeinflusst, wie Routing-Pfade abgeglichen werden.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'Legt die Empfindlichkeit der Schleifenerkennung fest: aus, minimal, moderat oder streng.';

  @override
  String get repeater_cliHelpSetFreq =>
      '(Nur für die serielle Schnittstelle) Ermöglicht die schnelle Einstellung der Frequenz. Nach der Einstellung ist ein Neustart erforderlich. Für die vollständige Einstellung aller Radio-Parameter wird die Option \"Radio einstellen\" empfohlen.';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(Nur für ESPNow-Brücke) Legt den verwendeten WLAN-Kanal (1-14) für die Brücke fest.';

  @override
  String get repeater_cliHelpGetName =>
      'Zeigt den konfigurierten Knotenamen an.';

  @override
  String get repeater_cliHelpGetRole =>
      'Zeigt die Funktion der Firmware an (Repeater, Raumserver usw.).';

  @override
  String get repeater_cliHelpGetPublicKey =>
      'Zeigt den öffentlichen Schlüssel des Geräts an.';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '(Nur für serielle Kommunikation) Zeigt den privaten Schlüssel des Geräts an. Behandeln Sie diesen als ein Geheimnis.';

  @override
  String get repeater_cliHelpGetRepeat =>
      'Zeigt an, ob die Weiterleitung von Paketen (als Repeater) aktiviert oder deaktiviert ist.';

  @override
  String get repeater_cliHelpGetTx =>
      'Zeigt die aktuelle Sendeleistung in dBm an.';

  @override
  String get repeater_cliHelpGetFreq =>
      'Zeigt die konfigurierte Funkfrequenz in MHz an.';

  @override
  String get repeater_cliHelpGetRadio =>
      'Zeigt alle Funkparameter an: Frequenz, Bandbreite, Spreading-Faktor, Codierungsrate.';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(Nur für SX126x) Zeigt den Zustand des verstärkten Empfangs (RX).';

  @override
  String get repeater_cliHelpGetAf => 'Zeigt den aktuellen Zeitfaktor an.';

  @override
  String get repeater_cliHelpGetDutyCycle =>
      'Zeigt den aktuellen zulässigen Schaltzyklus als Prozentsatz an.';

  @override
  String get repeater_cliHelpGetIntThresh =>
      'Zeigt den Grenzwert für Kanalüberlagerung in dB an.';

  @override
  String get repeater_cliHelpGetAgcResetInterval =>
      'Zeigt das Intervall für die Rücksetzung des AGC in Sekunden an.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      'Zeigt an, ob der Modus \"doppelte ACK\"-Funktion aktiviert (1) oder deaktiviert (0) ist.';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'Zeigt an, ob der Zugriff für Gäste nur in Lesemodus erlaubt ist.';

  @override
  String get repeater_cliHelpGetAdvertInterval =>
      'Zeigt die Dauer des lokalen Werbeintervalls in Minuten an.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'Zeigt die Dauer der Werbeunterbrechung in Stunden an.';

  @override
  String get repeater_cliHelpGetGuestPassword =>
      'Zeigt das konfigurierte Gast-Passwort an.';

  @override
  String get repeater_cliHelpGetLat => 'Zeigt die konfigurierte Breitengrade.';

  @override
  String get repeater_cliHelpGetLon => 'Zeigt die konfigurierte Länge an.';

  @override
  String get repeater_cliHelpGetRxDelay =>
      'Zeigt den Basiswert für die Verzögerungszeit an.';

  @override
  String get repeater_cliHelpGetTxDelay =>
      'Zeigt den Faktor für die Übertragungsverzögerung im Notfallmodus an.';

  @override
  String get repeater_cliHelpGetDirectTxDelay =>
      'Zeigt den Faktor für die Verzögerung im Direktmodus an.';

  @override
  String get repeater_cliHelpGetFloodMax =>
      'Zeigt die maximale Anzahl von Sprüngen für Flood-Pakete an.';

  @override
  String get repeater_cliHelpGetOwnerInfo =>
      'Zeigt die Zeichenkette mit den Kontaktinformationen des Eigentümers an.';

  @override
  String get repeater_cliHelpGetPathHashMode =>
      'Zeigt den Pfad-Hash-Modus (0/1/2) an.';

  @override
  String get repeater_cliHelpGetLoopDetect =>
      'Zeigt die Empfindlichkeit der Schleifenerkennung an.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(Nur für serielle Kommunikation) Zeigt die Zugriffskontrolleinträge auf einem Repeater an.';

  @override
  String get repeater_cliHelpGetBridgeEnabled =>
      'Zeigt an, ob die Brücke aktiviert ist.';

  @override
  String get repeater_cliHelpGetBridgeDelay =>
      'Zeigt die Verzögerung der Brücke in Millisekunden an.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'Zeigt, ob die Brücke RX- oder TX-Pakete empfängt oder sendet.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(Nur für RS232-Verbindungen) Zeigt die Baudrate der Verbindung an.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(Nur für ESPNow-Brücke) Zeigt den WLAN-Kanal der Brücke an.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(Nur für ESPNow-Brücke) Zeigt das gemeinsam genutzte Geheimnis der Brücke.';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '(Nur für NRF52) Zeigt die Version des Bootloaders an.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'Zeigt den ADC-Verstärker (Spannungs-Skalierung) an.';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      'Gibt an, ob der Verwaltungsrat die Funktion zur Energieverwaltung unterstützt.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      'Zeigt die aktuelle Stromquelle an: extern oder Batterie.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      'Zeigt die aktuellsten Gründe für einen Neustart und Herunterfahren an.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv =>
      'Zeigt die Batteriespannung beim Start in Millivolt (mV) an.';

  @override
  String get repeater_cliHelpSensorGet =>
      'Liest eine benutzerdefinierte Sensoreinstellung über eine Taste.';

  @override
  String get repeater_cliHelpSensorSet =>
      'Erstellt eine benutzerdefinierte Sensoreinstellung.';

  @override
  String get repeater_cliHelpSensorList =>
      'Zeigt alle benutzerdefinierten Sensoreinstellungen an, wobei die Seitennummerierung optional von einem Startindex abhängt.';

  @override
  String get repeater_cliHelpRegionDefault =>
      'Zeigt den aktuellen Standard-Region-Bereich an.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'Definiert den Standard-Regionenbereich. Verwenden Sie \"<null>\", um diesen zu löschen.';

  @override
  String get repeater_cliHelpRegionListAllowed =>
      'Nennt die Regionen, die Flood-Verkehr zulassen.';

  @override
  String get repeater_cliHelpRegionListDenied =>
      'Nennt die Regionen, die Flood-Verkehr verbieten.';

  @override
  String get repeater_cliHelpStatsPackets =>
      '(Nur für serielle Verbindungen) Zeigt Statistiken auf Paketebene.';

  @override
  String get repeater_cliHelpStatsRadio =>
      '(Nur für Serien) Zeigt Radiostatistiken an.';

  @override
  String get repeater_cliHelpStatsCore =>
      '(Nur für serielle Schnittstellen) Zeigt grundlegende Firmware-Statistiken.';

  @override
  String get telemetry_receivedData => 'Empfangene Telemetriedaten';

  @override
  String get telemetry_requestTimeout =>
      'Telemetry-Anfrage hat zu lange gedauert.';

  @override
  String telemetry_errorLoading(String error) {
    return 'Fehler beim Laden der Telemetrie: $error';
  }

  @override
  String get telemetry_noData => 'Keine Telemetriedaten verfügbar.';

  @override
  String telemetry_channelTitle(int channel) {
    return 'Kanal $channel';
  }

  @override
  String get telemetry_batteryLabel => 'Akku';

  @override
  String get telemetry_voltageLabel => 'Spannung';

  @override
  String get telemetry_mcuTemperatureLabel => 'MCU Temperatur';

  @override
  String get telemetry_temperatureLabel => 'Temperatur';

  @override
  String get telemetry_currentLabel => 'Aktuell';

  @override
  String telemetry_batteryValue(int percent, String volts) {
    return '$percent% / ${volts}V';
  }

  @override
  String telemetry_voltageValue(String volts) {
    return '$volts Volt';
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
  String get telemetry_digitalInputLabel => 'Digitaleingang';

  @override
  String get telemetry_digitalOutputLabel => 'Digitalausgang';

  @override
  String get telemetry_analogInputLabel => 'Analogeingang';

  @override
  String get telemetry_analogOutputLabel => 'Analogausgang';

  @override
  String get telemetry_genericLabel => 'Allgemeiner Sensor';

  @override
  String get telemetry_luminosityLabel => 'Helligkeit';

  @override
  String get telemetry_presenceLabel => 'Anwesenheit';

  @override
  String get telemetry_humidityLabel => 'Luftfeuchtigkeit';

  @override
  String get telemetry_accelerometerLabel => 'Beschleunigungsmesser';

  @override
  String get telemetry_pressureLabel => 'Druck';

  @override
  String get telemetry_altitudeLabel => 'Höhe';

  @override
  String get telemetry_frequencyLabel => 'Frequenz';

  @override
  String get telemetry_percentageLabel => 'Prozentsatz';

  @override
  String get telemetry_concentrationLabel => 'Konzentration';

  @override
  String get telemetry_powerLabel => 'Leistung';

  @override
  String get telemetry_distanceLabel => 'Entfernung';

  @override
  String get telemetry_energyLabel => 'Energie';

  @override
  String get telemetry_directionLabel => 'Richtung';

  @override
  String get telemetry_timeLabel => 'Zeit';

  @override
  String get telemetry_gyrometerLabel => 'Gyroskop';

  @override
  String get telemetry_colourLabel => 'Farbe';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'Schalter';

  @override
  String get telemetry_polylineLabel => 'Polylinie';

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
  String get telemetry_autoFetchQuantity => 'Anzahl der Anfragen';

  @override
  String get telemetry_error => 'Daten konnten nicht abgerufen werden';

  @override
  String get neighbors_receivedData => 'Empfangene Nachbarsdaten';

  @override
  String get neighbors_requestTimedOut =>
      'Anfrage durch Timeout fehlgeschlagen.';

  @override
  String neighbors_errorLoading(String error) {
    return 'Fehler beim Laden der Nachbarn: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => 'Nachbarn';

  @override
  String get neighbors_noData => 'Keine Nachbarsdaten verfügbar.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return 'Unbekannt $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return 'Gehört vor: $time';
  }

  @override
  String get channelPath_title => 'Paketpfad';

  @override
  String get channelPath_viewMap => 'Karte anzeigen';

  @override
  String get channelPath_otherObservedPaths => 'Sonstige beobachtete Pfade';

  @override
  String get channelPath_repeaterHops => 'Repeater-Sprünge';

  @override
  String get channelPath_noHopDetails =>
      'Die Detailangaben für dieses Paket sind nicht verfügbar.';

  @override
  String get channelPath_sourceLabel => 'Quelle';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'Diese Nachricht kam über MQTT. Dein Funkgerät hat sie nicht empfangen, daher gibt es keinen Funkpfad von deinem Funkgerät.';

  @override
  String get channelPath_messageDetails => 'Nachrichtendetails';

  @override
  String get channelPath_senderLabel => 'Sender';

  @override
  String get channelPath_timeLabel => 'Zeit';

  @override
  String get channelPath_repeatsLabel => 'Wiederholungen';

  @override
  String channelPath_pathLabel(int index) {
    return 'Pfad $index';
  }

  @override
  String get channelPath_observedLabel => 'Beobachtet';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return 'Beobachteter Pfad $index • $hops';
  }

  @override
  String get channelPath_noLocationData => 'Keine Standortdaten';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => 'Unbekannt';

  @override
  String get channelPath_floodPath => 'Geflutet';

  @override
  String get channelPath_directPath => 'Direkt';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 von $total Sprüngen';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed von $total Sprüngen';
  }

  @override
  String get channelPath_mapTitle => 'Pfadkarte';

  @override
  String get channelPath_noRepeaterLocations =>
      'Für diesen Pfad stehen keine Repeater-Positionen zur Verfügung.';

  @override
  String channelPath_primaryPath(int index) {
    return 'Pfad $index (Primär)';
  }

  @override
  String get channelPath_pathLabelTitle => 'Pfad';

  @override
  String get channelPath_observedPathHeader => 'Beobachteter Pfad';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable =>
      'Keine Informationen zu dieser Paketroute verfügbar.';

  @override
  String get channelPath_unknownRepeater => 'Unbekannter Repeater';

  @override
  String get community_title => 'Gemeinschaft';

  @override
  String get community_create => 'Erstelle Community';

  @override
  String get community_createDesc =>
      'Erstelle eine neue Community und teile sie über den QR-Code.';

  @override
  String get community_join => 'Beitreten';

  @override
  String get community_joinTitle => 'Tritt der Community bei';

  @override
  String community_joinConfirmation(String name) {
    return 'Möchten Sie sich der Community \"$name\" anschließen?';
  }

  @override
  String get community_scanQr => 'Scannen Sie die Community QR-Code';

  @override
  String get community_scanInstructions =>
      'Richten Sie die Kamera auf einen Community-QR-Code.';

  @override
  String get community_showQr => 'Zeige QR-Code';

  @override
  String get community_publicChannel => 'Community Öffentlich';

  @override
  String get community_hashtagChannel => 'Gemeinschaftlicher Hashtag';

  @override
  String get community_name => 'Name der Gemeinde';

  @override
  String get community_enterName => 'Bitte Community-Name eingeben';

  @override
  String community_created(String name) {
    return 'Community \"$name\" wurde erstellt';
  }

  @override
  String community_joined(String name) {
    return 'Community \"$name\" beigetreten';
  }

  @override
  String get community_qrTitle => 'Teile Community';

  @override
  String community_qrInstructions(String name) {
    return 'Scannen Sie diesen QR-Code, um sich \"$name\" anzuschließen.';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'Community-Hashtag-Kanäle können nur von Mitgliedern der Community betreten werden';

  @override
  String get community_invalidQrCode => 'Ungültiger Community-QR-Code';

  @override
  String get community_alreadyMember => 'Bereits registriert';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'Sie sind bereits Mitglied von \"$name\".';
  }

  @override
  String get community_addPublicChannel =>
      'Füge einen öffentlichen Community-Kanal hinzu';

  @override
  String get community_addPublicChannelHint =>
      'Automatisch den öffentlichen Kanal für diese Community hinzufügen';

  @override
  String get community_noCommunities => 'Noch keiner Community beigetreten';

  @override
  String get community_scanOrCreate =>
      'Scannen Sie einen QR-Code oder eine Community erstellen, um loszulegen.';

  @override
  String get community_manageCommunities => 'Verwalten von Communities';

  @override
  String get community_delete => 'Verlasse Community';

  @override
  String community_deleteConfirm(String name) {
    return '\"$name\" verlassen?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return 'Dies löscht auch $count Kanal/Kanäle und deren Nachrichten.';
  }

  @override
  String community_deleted(String name) {
    return 'Community \"$name\" verlassen';
  }

  @override
  String get community_regenerateSecret => 'Neugenerierung des Schlüssels';

  @override
  String community_regenerateSecretConfirm(String name) {
    return 'Nehmen Sie den geheimen Schlüssel für \"$name\" neu auf? Alle Mitglieder müssen den neuen QR-Code scannen, um die Kommunikation fortzusetzen.';
  }

  @override
  String get community_regenerate => 'Neu generieren';

  @override
  String community_secretRegenerated(String name) {
    return 'Wiederherstellung des Schlüssels für \"$name\" erfolgreich';
  }

  @override
  String get community_updateSecret => 'Aktualisieren Sie den Schlüssel';

  @override
  String community_secretUpdated(String name) {
    return 'Schlüssel für \"$name\" aktualisiert';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return 'Scannen Sie den neuen QR-Code, um das Geheimnis für \"$name\" zu aktualisieren.';
  }

  @override
  String get community_addHashtagChannel =>
      'Füge einen Community-Hashtag hinzu';

  @override
  String get community_addHashtagChannelDesc =>
      'Füge einen Hashtag-Kanal für diese Community hinzu';

  @override
  String get community_selectCommunity => 'Wählen Sie eine Community';

  @override
  String get community_regularHashtag => 'Regulärer Hashtag';

  @override
  String get community_regularHashtagDesc =>
      'Öffentlicher Hashtag (jeder kann teilnehmen)';

  @override
  String get community_communityHashtag => 'Gemeinschaftlicher Hashtag';

  @override
  String get community_communityHashtagDesc =>
      'Nur für Mitglieder der Community';

  @override
  String community_forCommunity(String name) {
    return 'Für $name';
  }

  @override
  String get listFilter_tooltip => 'Filteren und sortieren';

  @override
  String get listFilter_sortBy => 'Sortiere nach';

  @override
  String get listFilter_latestMessages => 'Letzte Nachrichten';

  @override
  String get listFilter_heardRecently => 'Kürzlich gehört';

  @override
  String get listFilter_az => 'Von A bis Z';

  @override
  String get listFilter_filters => 'Filtere';

  @override
  String get listFilter_all => 'Alle';

  @override
  String get listFilter_favorites => 'Favoriten';

  @override
  String get listFilter_addToFavorites => 'Zu Favoriten hinzufügen';

  @override
  String get listFilter_removeFromFavorites => 'Aus Favoriten entfernen';

  @override
  String get listFilter_users => 'Benutzer';

  @override
  String get listFilter_repeaters => 'Repeater';

  @override
  String get listFilter_roomServers => 'Raumserver';

  @override
  String get listFilter_unreadOnly => 'Nicht gelesen';

  @override
  String get listFilter_newGroup => 'Neue Gruppe';

  @override
  String get pathTrace_you => 'Du';

  @override
  String get pathTrace_failed => 'Pfadverfolgung fehlgeschlagen.';

  @override
  String get pathTrace_notAvailable => 'Pfadverfolgung nicht verfügbar.';

  @override
  String get pathTrace_refreshTooltip => 'Path Trace aktualisieren.';

  @override
  String get pathTrace_someHopsNoLocation =>
      'Bei einer oder mehreren Knoten fehlt der Standort!';

  @override
  String get pathTrace_clearTooltip => 'Pfad löschen';

  @override
  String get losSelectStartEnd =>
      'Wählen Sie Start- und Endknoten für LOS aus.';

  @override
  String losRunFailed(String error) {
    return 'Sichtlinienprüfung fehlgeschlagen: $error';
  }

  @override
  String get losClearAllPoints => 'Löschen Sie alle Punkte';

  @override
  String get losRunToViewElevationProfile =>
      'Führen Sie LOS aus, um das Höhenprofil anzuzeigen';

  @override
  String get losMenuTitle => 'LOS-Menü';

  @override
  String get losMenuSubtitle =>
      'Tippen Sie auf Knoten oder drücken Sie lange auf die Karte, um benutzerdefinierte Punkte anzuzeigen';

  @override
  String get losShowDisplayNodes => 'Anzeigeknoten anzeigen';

  @override
  String get losCustomPoints => 'Benutzerdefinierte Punkte';

  @override
  String losCustomPointLabel(int index) {
    return 'Benutzerdefiniert $index';
  }

  @override
  String get losPointA => 'Punkt A';

  @override
  String get losPointB => 'Punkt B';

  @override
  String losAntennaA(String value, String unit) {
    return 'Antenne A: $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return 'Antenne B: $value $unit';
  }

  @override
  String get losRun => 'Führen Sie LOS aus';

  @override
  String get losNoElevationData => 'Keine Höhendaten';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, freie Sichtlinie, Mindestabstand $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, blockiert durch $obstruction $heightUnit';
  }

  @override
  String get losStatusChecking => 'LOS: Überprüfen...';

  @override
  String get losStatusNoData => 'LOS: keine Daten';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'Sichtlinie: $clear/$total frei, $blocked blockiert, $unknown unbekannt';
  }

  @override
  String get losErrorElevationUnavailable =>
      'Für eine oder mehrere Proben sind keine Höhendaten verfügbar.';

  @override
  String get losErrorInvalidInput =>
      'Ungültige Punkte/Höhendaten für die LOS-Berechnung.';

  @override
  String get losRenameCustomPoint =>
      'Benennen Sie den benutzerdefinierten Punkt um';

  @override
  String get losPointName => 'Punktname';

  @override
  String get losShowPanelTooltip => 'LOS-Panel anzeigen';

  @override
  String get losHidePanelTooltip => 'LOS-Panel ausblenden';

  @override
  String get losElevationAttribution => 'Höhendaten: Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'Funkhorizont';

  @override
  String get losLegendLosBeam => 'Sichtlinie';

  @override
  String get losLegendTerrain => 'Gelände';

  @override
  String get losBlockedSpotsTitle => 'Reservierte Plätze';

  @override
  String get losBlockedSpotsHint =>
      'Klicken Sie auf einen blockierten Bereich, um ihn auf der Karte hervorzuheben.';

  @override
  String losBlockedSpotChip(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance • $distanceUnit • $obstruction $heightUnit';
  }

  @override
  String get losSelectedObstructionTitle => 'Ausgewählte Behinderung';

  @override
  String losSelectedObstructionDetails(
    String obstruction,
    String heightUnit,
    String distanceFromA,
    String distanceUnit,
    String distanceFromB,
  ) {
    return 'Blockiert durch $obstruction in einer Höhe von $heightUnit, $distanceFromA von A und $distanceFromB von B ($distanceUnit).';
  }

  @override
  String get losFrequencyLabel => 'Frequenz';

  @override
  String get losFrequencyInfoTooltip => 'Details zur Berechnung anzeigen';

  @override
  String get losFrequencyDialogTitle => 'Berechnung des Funkhorizonts';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'Ausgehend von k=$baselineK bei $baselineFreq MHz passt die Berechnung den k-Faktor für das aktuelle $frequencyMHz MHz-Band an, das die gekrümmte Funkhorizontobergrenze definiert.';
  }

  @override
  String get contacts_pathTrace => 'Pfadverfolgung';

  @override
  String get contacts_ping => 'Pingen';

  @override
  String get contacts_repeaterPathTrace => 'Pfadverfolgung zum Repeater';

  @override
  String get contacts_repeaterPing => 'Repeater pingen';

  @override
  String get contacts_roomPathTrace => 'Pfadverfolgung zum Raumserver';

  @override
  String get contacts_roomPing => 'Raumserver anpingen';

  @override
  String get contacts_chatTraceRoute => 'Pfadverfolgungsroute';

  @override
  String contacts_pathTraceTo(String name) {
    return 'Route nach $name verfolgen';
  }

  @override
  String get contacts_clipboardEmpty => 'Die Zwischenablage ist leer.';

  @override
  String get contacts_invalidAdvertFormat => 'Ungültige Kontaktdaten';

  @override
  String get contacts_contactImported => 'Kontakt wurde importiert.';

  @override
  String get contacts_contactImportFailed =>
      'Kontakt konnte nicht importiert werden';

  @override
  String get contacts_zeroHopAdvert => 'Zero-Hop-Ankündigung';

  @override
  String get contacts_floodAdvert => 'Flut-Ankündigung';

  @override
  String get contacts_copyAdvertToClipboard =>
      'Ankündigung in die Zwischenablage kopieren';

  @override
  String get contacts_addContactFromClipboard =>
      'Kontakt aus Zwischenablage hinzufügen';

  @override
  String get contacts_ShareContact => 'Kontakt in die Zwischenablage kopieren';

  @override
  String get contacts_ShareContactZeroHop => 'Kontakt über Anzeige teilen';

  @override
  String get contacts_zeroHopContactAdvertSent =>
      'Kontakt über Anzeige gesendet';

  @override
  String get contacts_zeroHopContactAdvertFailed =>
      'Kontakt konnte nicht gesendet werden.';

  @override
  String get contacts_contactAdvertCopied =>
      'Anzeige in die Zwischenablage kopiert.';

  @override
  String get contacts_contactAdvertCopyFailed =>
      'Kopieren der Ankündigung in die Zwischenablage fehlgeschlagen.';

  @override
  String get notification_activityTitle => 'MeshCore Aktivität';

  @override
  String notification_messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nachrichten',
      one: 'Nachricht',
    );
    return '$count $_temp0';
  }

  @override
  String notification_channelMessagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kanalnachrichten',
      one: 'Kanalnachricht',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'neue Knoten',
      one: 'neuer Knoten',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return 'Neuer $contactType entdeckt';
  }

  @override
  String get notification_receivedNewMessage => 'Neue Nachricht empfangen';

  @override
  String get settings_gpxExportRepeaters =>
      'Repeater und Raumserver als GPX exportieren';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'Exportiert Repeater und Raumserver mit einem Standort in eine GPX-Datei.';

  @override
  String get settings_gpxExportContacts => 'Kontakte als GPX exportieren';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'Exportiert Kontakte mit einem Ort in eine GPX-Datei.';

  @override
  String get settings_gpxExportAll => 'Alle Knoten als GPX exportieren';

  @override
  String get settings_gpxExportAllSubtitle =>
      'Exportiert alle Knoten mit einem Standort in eine GPX-Datei.';

  @override
  String get settings_gpxExportSuccess => 'GPX-Datei erfolgreich exportiert.';

  @override
  String get settings_gpxExportNoContacts => 'Keine Kontakte zum Exportieren.';

  @override
  String get settings_gpxExportNotAvailable =>
      'Nicht auf Ihrem Gerät/Betriebssystem unterstützt';

  @override
  String get settings_gpxExportError =>
      'Beim Export ist ein Fehler aufgetreten.';

  @override
  String get settings_gpxExportRepeatersRoom =>
      'Repeater- und Raumserver-Standorte';

  @override
  String get settings_gpxExportChat => 'Kontaktstandorte';

  @override
  String get settings_gpxExportAllContacts => 'Alle Kontaktstandorte';

  @override
  String get settings_gpxExportShareText =>
      'GPX-Kartendaten aus NOTORYX Core exportiert';

  @override
  String get settings_gpxExportShareSubject =>
      'GPX-Kartendaten aus NOTORYX Core exportieren';

  @override
  String get snrIndicator_nearByRepeaters => 'In der Nähe befindliche Repeater';

  @override
  String get snrIndicator_lastSeen => 'Zuletzt gesehen';

  @override
  String get contactsSettings_title => 'Kontakteinstellungen';

  @override
  String get contactsSettings_autoAddTitle => 'Automatische Erkennung';

  @override
  String get contactsSettings_otherTitle =>
      'Weitere Einstellungen zu Kontakten';

  @override
  String get contactsSettings_autoAddUsersTitle =>
      'Automatische Hinzufügung von Benutzern';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      'Ermöglichen Sie dem Begleiter, automatisch entdeckte Benutzer hinzuzufügen';

  @override
  String get contactsSettings_autoAddRepeatersTitle =>
      'Automatisch Repeater hinzufügen';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      'Ermöglichen Sie dem Begleiter, automatisch entdeckte Repeater hinzuzufügen.';

  @override
  String get contactsSettings_autoAddRoomServersTitle =>
      'Automatisch Raumservers hinzufügen';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      'Ermöglichen Sie dem Begleiter, entdeckte Raumserver automatisch hinzuzufügen';

  @override
  String get contactsSettings_autoAddSensorsTitle =>
      'Automatisch Sensoren hinzufügen';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      'Ermöglichen Sie dem Begleiter, automatisch entdeckte Sensoren hinzuzufügen';

  @override
  String get contactsSettings_overwriteOldestTitle =>
      'Überschreiben des Ältesten';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      'Wenn die Kontaktliste voll ist, wird der älteste nicht favorisierte Kontakt ersetzt.';

  @override
  String get discoveredContacts_Title => 'Entdeckte Kontakte';

  @override
  String get discoveredContacts_noMatching => 'Keine passenden Kontakte';

  @override
  String get discoveredContacts_searchHint => 'Entdeckte Kontakte suchen';

  @override
  String get discoveredContacts_contactAdded => 'Kontakt hinzugefügt';

  @override
  String get discoveredContacts_addContact => 'Kontakt hinzufügen';

  @override
  String get discoveredContacts_copyContact =>
      'Kontakt in die Zwischenablage kopieren';

  @override
  String get discoveredContacts_deleteContact => 'Kontakt löschen';

  @override
  String get discoveredContacts_deleteContactAll =>
      'Alle entdeckten Kontakte löschen';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      'Sind Sie sicher, dass Sie alle gefundenen Kontakte löschen möchten?';

  @override
  String get chat_sendCooldown =>
      'Bitte warten Sie einen Moment, bevor Sie erneut senden.';

  @override
  String get appSettings_jumpToOldestUnread =>
      'Zum ältesten, nicht gelesenen Eintrag springen';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      'Wenn Sie ein Chatfenster öffnen, in dem Nachrichten vorhanden sind, die noch nicht gelesen wurden, scrollen Sie zu der ersten unlesenen Nachricht, anstatt zur neuesten.';

  @override
  String get appSettings_languageHu => 'Ungarisch';

  @override
  String get appSettings_languageJa => 'Japanisch';

  @override
  String get appSettings_languageKo => 'Koreanisch';

  @override
  String get radioStats_tooltip => 'Daten zu Radio- und Mesh-Netzwerken';

  @override
  String get radioStats_screenTitle => 'Senderinformationen';

  @override
  String get radioStats_notConnected =>
      'Verbinden Sie ein Gerät, um Radiostatistiken anzuzeigen.';

  @override
  String get radioStats_firmwareTooOld =>
      'Für die Verwendung der Funkstatistiken ist die Firmware-Version 8 oder höher erforderlich.';

  @override
  String get radioStats_waiting => 'Warte auf Daten…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'Rauschpegel: $noiseDbm dBm';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return 'Letzter RSSI-Wert: $rssiDbm dBm';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return 'Letzter SNR: $snr dB';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'Gesamt-TX-Zeit: $seconds s';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'Gesamt-RX-Zeit: $seconds s';
  }

  @override
  String get radioStats_chartCaption =>
      'Rauschpegel (dBm) basierend auf den letzten Messwerten.';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'Rauschpegel: $noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting => 'Abrufen von Radiostatus…';

  @override
  String get radioStats_settingsTile => 'Senderinformationen';

  @override
  String get radioStats_settingsSubtitle =>
      'Rauschpegel, RSSI, Signal-Rausch-Verhältnis (SNR) und Nutzzeit';

  @override
  String get translation_title => 'Übersetzung';

  @override
  String get imageMessages_enableTitle => 'Bildnachrichten aktivieren';

  @override
  String get imageMessages_enableSubtitle =>
      'Bilder über das Netzwerk senden. Einmaliges Herunterladen eines Bildmodells erforderlich.';

  @override
  String get imageMessages_modelSectionTitle => 'Bildmodell';

  @override
  String get imageMessages_downloadModel => 'Herunterladen';

  @override
  String get imageMessages_cancelDownload => 'Stornieren';

  @override
  String get imageMessages_removeModel => 'Modell entfernen';

  @override
  String get imageMessages_modelReady => 'Bereit';

  @override
  String get imageMessages_modelNotPublished =>
      'Noch nicht veröffentlicht – dieser Build kann es nicht herunterladen.';

  @override
  String get imageMessages_downloadFailed =>
      'Das Bildmodell konnte nicht heruntergeladen werden.';

  @override
  String get imageMessages_autoProcessTitle => 'Automatisch Bilder verarbeiten';

  @override
  String get imageMessages_autoProcessSubtitle =>
      'Rekonstruiere jedes Bild sofort nach dem Eintreffen. Verbraucht etwa 2 GB Arbeitsspeicher für jede zweite Wiederherstellung; deaktiviere die automatische Rekonstruktion mit einem Tippen.';

  @override
  String get translation_enableTitle => 'Aktivieren Sie die Übersetzung';

  @override
  String get translation_enableSubtitle =>
      'Nachrichten empfangen und übersetzen sowie die Möglichkeit bieten, Nachrichten vor dem Versenden zu übersetzen.';

  @override
  String get translation_composerTitle => 'Übersetzen Sie vor dem Versenden';

  @override
  String get translation_composerSubtitle =>
      'Steuert den Standardzustand des Icons für die Übersetzung des Komponisten.';

  @override
  String get translation_autoIncomingTitle =>
      'Nachrichten automatisch übersetzen';

  @override
  String get translation_autoIncomingSubtitle =>
      'Übersetzt Nachrichten für Benachrichtigungen sowie für Chats oder Kanäle automatisch.';

  @override
  String get translation_translateMessage => 'Nachricht übersetzen';

  @override
  String get translation_targetLanguage => 'Zielsprache';

  @override
  String get translation_useAppLanguage => 'Verwenden Sie die App-Sprache';

  @override
  String get translation_downloadedModelLabel => 'Heruntergeladenes Modell';

  @override
  String get translation_presetModelLabel =>
      'Vordefinierter Hugging Face-Modell';

  @override
  String get translation_manualUrlLabel => 'URL für das manuelle Modell';

  @override
  String get translation_downloadModel => 'Modell herunterladen';

  @override
  String get translation_downloading => 'Herunterladen...';

  @override
  String get translation_working => 'Arbeiten...';

  @override
  String get translation_stop => 'Stopp';

  @override
  String get translation_mergingChunks =>
      'Zusammenführen der heruntergeladenen Teile in die finale Datei...';

  @override
  String get translation_downloadedModels => 'Heruntergeladene Modelle';

  @override
  String get translation_deleteModel => 'Modell löschen';

  @override
  String get translation_modelDownloaded =>
      'Übersetzungsmotor heruntergeladen.';

  @override
  String get translation_downloadStopped => 'Herunterladen abgebrochen.';

  @override
  String translation_downloadFailed(String error) {
    return 'Download fehlgeschlagen: $error';
  }

  @override
  String get translation_enterUrlFirst =>
      'Geben Sie zunächst die URL eines Modells ein.';

  @override
  String get scanner_linuxPairingShowPin => 'PIN anzeigen';

  @override
  String get scanner_linuxPairingHidePin => 'PIN ausblenden';

  @override
  String get scanner_linuxPairingPinTitle => 'Bluetooth-Paarungs-PIN';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return 'Geben Sie die PIN für $deviceName ein (leer lassen, falls keine).';
  }

  @override
  String get translation_messageTranslation => 'Nachricht übersetzen';

  @override
  String get translation_translateBeforeSending =>
      'Übersetzen Sie vor dem Versenden';

  @override
  String get translation_composerEnabledHint =>
      'Die Nachrichten werden vor dem Versenden übersetzt.';

  @override
  String get translation_composerDisabledHint =>
      'Nachrichten in der ursprünglichen, getippten Sprache senden.';

  @override
  String translation_translateTo(String language) {
    return 'Übersetzen Sie auf $language';
  }

  @override
  String get translation_translationOptions => 'Übersetzungsmöglichkeiten';

  @override
  String get translation_systemLanguage => 'Sprache des Systems';

  @override
  String get background_serviceTitle => 'MeshCore läuft';

  @override
  String get background_serviceText => 'BLE-Verbindung bleibt aktiv';

  @override
  String appSettings_translationModelDeleted(String name) {
    return 'Übersetzungsmodell $name gelöscht';
  }

  @override
  String appSettings_translationModelDeleteFailed(String error) {
    return 'Löschen fehlgeschlagen: $error';
  }

  @override
  String channels_channelUpdateFailed(String error) {
    return 'Kanal konnte nicht aktualisiert werden: $error';
  }

  @override
  String get contact_typeChat => 'Chat';

  @override
  String get contact_typeRepeater => 'Repeater';

  @override
  String get contact_typeRoom => 'Raumserver';

  @override
  String get contact_typeSensor => 'Sensor';

  @override
  String get contact_typeUnknown => 'Unbekannt';

  @override
  String get map_zoomIn => 'Vergrößern';

  @override
  String get map_zoomOut => 'Verkleinern';

  @override
  String get map_centerMap => 'Karte zentrieren';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'Web Bluetooth benötigt einen Chromium-Browser.';

  @override
  String channels_communityShortId(String id) {
    return 'ID: $id…';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'GPS bestätigt';

  @override
  String get pathTrace_legendInferred => 'Abgeleitete Position';

  @override
  String get pathMap_viewSingle => 'Einzeln';

  @override
  String get pathMap_viewCombined => 'Kombiniert';

  @override
  String get pathMap_play => 'Abspielen';

  @override
  String get pathMap_pause => 'Pause';

  @override
  String get pathMap_replay => 'Erneut abspielen';

  @override
  String get pathMap_stepBack => 'Vorheriger Sprung';

  @override
  String get pathMap_stepForward => 'Nächster Sprung';

  @override
  String get pathMap_animationOn => 'Paketanimation anzeigen';

  @override
  String get pathMap_animationOff => 'Paketanimation ausblenden';

  @override
  String pathMap_hopOf(int current, int total) {
    return '$current von $total';
  }

  @override
  String pathMap_observedPaths(int count) {
    return 'Beobachtete Pfade: $count';
  }

  @override
  String get pathMap_primary => 'Primär';

  @override
  String pathMap_alternate(int index) {
    return 'Alternative $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Sprünge',
      one: '1 Sprung',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => 'Gemeinsamer Abschnitt';

  @override
  String get pathMap_legendEstimated => 'Geschätzter Abschnitt';

  @override
  String pathMap_sharedNodeCount(int count) {
    return 'Verwendet von $count Pfaden';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count Sprünge haben keinen Standort - der angezeigte Pfad ist unvollständig',
      one:
          '1 Sprung hat keinen Standort - der angezeigte Pfad ist unvollständig',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'Alle anzeigen';

  @override
  String get pathMap_hidePath => 'Pfad ausblenden';

  @override
  String get pathMap_showPath => 'Pfad anzeigen';

  @override
  String get pathMap_collapsePanel => 'Panel einklappen';

  @override
  String get pathMap_expandPanel => 'Panel ausklappen';

  @override
  String get pathMap_noLocation => 'Keine Standortdaten';

  @override
  String get pathMap_followPacket => 'Ansicht auf Paket fixieren';

  @override
  String get pathMap_unfollowPacket => 'Fixierung aufheben';

  @override
  String get imageSend_title => 'Bild senden';

  @override
  String get imageSend_cropNote =>
      'Für 512 × 512 skaliert · Seitenverhältnis nicht erhalten';

  @override
  String get imageSend_originalSize =>
      'Originaltext:\n\nThe quick brown fox jumps over the lazy dog.\n\nÜbersetzung:\n\nDer schnelle braune Fuchs springt über den faulen Hund.';

  @override
  String get imageSend_onAirSize => 'On air';

  @override
  String get imageSend_quality => 'Qualität';

  @override
  String get imageSend_qualityStandard => 'Standard';

  @override
  String get imageSend_qualityHigh => 'Hoch';

  @override
  String get imageSend_packetsLabel => 'Pakete';

  @override
  String get imageSend_airtimeLabel => 'Sendezeit';

  @override
  String get imageSend_sizeLabel => 'Nutzlast';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pakete',
      one: 'Paket',
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
  String get imageSend_radioUnknownTitle => 'Radioeinstellungen unbekannt';

  @override
  String get imageSend_radioUnknownBody =>
      'Verbinden Sie das Gerät, damit die Sendezeit berechnet werden kann.';

  @override
  String get imageSend_longSendTitle => 'Lange Übertragung';

  @override
  String imageSend_longSendBody(String duration) {
    return 'Dies hält den Kanal für etwa $duration.';
  }

  @override
  String get imageSend_floodNote =>
      'Flutweiterleitung: Jeder Repeater im Bereich leitet jedes Paket weiter, wodurch der Kanal länger als dieser Zeitraum beschäftigt bleibt.';

  @override
  String get imageSend_parityTitle => 'Wiederherstellungspaket';

  @override
  String get imageSend_paritySubtitle =>
      'Ein zusätzliches Paket. Gruppen-Nachrichten werden nicht bestätigt, daher kann der Empfänger das Bild rekonstruieren, falls ein Paket verloren geht.';

  @override
  String get imageSend_send => 'Senden';

  @override
  String get imageSend_cancel => 'Stornieren';

  @override
  String get imageSend_encodeFailed =>
      'Dieses Bild konnte nicht kodiert werden.';

  @override
  String get imageSend_codecDownloading =>
      'Das Bildmodell wird noch heruntergeladen.';

  @override
  String get imageSend_codecUnavailable =>
      'Bildversand ist auf diesem Gerät nicht verfügbar.';

  @override
  String get imageSend_codecDisabled =>
      'Bildnachrichten sind in den Einstellungen deaktiviert.';

  @override
  String get imageSend_deviceUnsupported =>
      'Dieses Radio kann keine Bildpakete senden. Verbinden Sie ein Gerät mit der Companion-Firmware-Version 13 oder neuer.';

  @override
  String get imageSend_directMessagesUnsupported =>
      'Bilder werden als Gruppendaten übertragen, daher können sie nur an einen Kanal gesendet werden – nicht per Direktnachricht.';

  @override
  String get imageSend_tooLarge =>
      'Dieses Bild wurde in mehr Pakete kodiert, als das Mesh-Format zulässt.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pakete',
      one: 'Paket',
    );
    return 'Bild gesendet als $count $_temp0.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return 'Das Bild konnte nicht gesendet werden: $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return 'Bildversand — Paket $sent von $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'Kritisch: Diese Platzhalter $prefix beibehalten.';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return '$received von $total Paketen';
  }

  @override
  String get receivedImage_queued => 'Warten auf die Entschlüsselung';

  @override
  String get receivedImage_tapToDecode => 'Tippen Sie, um zu entschlüsseln';

  @override
  String get receivedImage_decoding => 'Rekonstruktion… ca. 1 s';

  @override
  String receivedImage_incomplete(int received, int total) {
    return 'Bild unvollständig — $received von $total Paketen eingetroffen';
  }

  @override
  String get receivedImage_corrupt =>
      'Das Bild konnte nicht rekonstruiert werden.';

  @override
  String get receivedImage_decoderMissing =>
      'Bild empfangen — Bilddekodierung fehlgeschlagen';

  @override
  String get receivedImage_evicted => 'Bild nicht mehr gespeichert';

  @override
  String get receivedImage_retry => 'Versuchen Sie es erneut';

  @override
  String get receivedImage_decodeAgain => 'Entschlüsseln Sie es erneut';

  @override
  String get receivedImage_openSettings => 'Einrichten';

  @override
  String get receivedImage_tapToProcess => 'Klicken Sie, um fortzufahren';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'Pakete',
      one: 'Paket',
    );
    return '$bytes Bytes · $packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds s';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes Min $seconds Sek';
  }

  @override
  String get bastion_tagline => 'Kommunikation ohne Infrastruktur.';

  @override
  String get bastion_nodes => 'Knoten';

  @override
  String get bastion_repeaters => 'Repeater';

  @override
  String get bastion_active1h => 'Aktiv 1 Std.';

  @override
  String get bastion_mapCoverage => 'Karte + Abdeckung';

  @override
  String get bastion_routeIntelligence => 'Routenanalyse';

  @override
  String get bastion_repeaterTools => 'Repeater-Werkzeuge';

  @override
  String get bastion_fieldStats => 'Feldstatistik';

  @override
  String get bastion_fieldOps => 'Tour + Feldeinsatz';

  @override
  String get bastion_coverageCapture => 'Abdeckungserfassung';

  @override
  String get bastion_mapAttribution =>
      'Kartendaten © OpenStreetMap-Mitwirkende; Kacheln vom gewählten Anbieter';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Beobachtungen',
      one: '1 Beobachtung',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eindeutige Knoten',
      one: '1 eindeutiger Knoten',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Hops',
      one: '1 Hop',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Minuten',
      one: '1 Minute',
    );
    return '$_temp0';
  }

  @override
  String get sos_holdHint =>
      '2 Sekunden halten. Sendet deine Position alle 5 Minuten an deine Tourkontakte, bis jemand antwortet.';

  @override
  String sos_holdHintChannel(String channel) {
    return '2 Sekunden halten. Sendet deine Position alle 5 Minuten an deine Tourkontakte und $channel, bis jemand antwortet.';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS nicht gesendet: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return 'Bestätigt von $name. Wiederholungen gestoppt.';
  }

  @override
  String get sos_waitingForRadio => 'Warte darauf, dass das Funkgerät sendet…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return '$sends von $max Mal gesendet. Wiederholungen beendet; noch keine Antwort.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return '$sends von $max Mal gesendet. Nächste um $time.';
  }

  @override
  String get sos_active => 'SOS AKTIV';

  @override
  String get sos_stop => 'STOPP';

  @override
  String get sos_imSafe => 'ICH BIN IN SICHERHEIT';

  @override
  String get sos_holdSemantics => 'SOS. Zum Senden gedrückt halten.';

  @override
  String get sos_keepHolding => 'WEITER HALTEN…';

  @override
  String get sos_holdForSos => 'FÜR SOS HALTEN';

  @override
  String get sos_blockStorage =>
      'Behebe zuerst den Speicherfehler des Feldprotokolls.';

  @override
  String get sos_blockNotConnected =>
      'Verbinde dein MeshCore-Funkgerät, um ein SOS zu senden.';

  @override
  String get sos_blockNoTarget =>
      'Wähle unter „Tour planen“ Tourkontakte oder einen SOS-Kanal.';

  @override
  String get checkIn_labelOk => 'Mir geht\'s gut';

  @override
  String get checkIn_labelAtCamp => 'Im Lager';

  @override
  String get checkIn_labelDelayed => 'Verspätet';

  @override
  String get checkIn_labelHeadingBack => 'Auf dem Rückweg';

  @override
  String get checkIn_blockLoading => 'Deine Tour wird geladen…';

  @override
  String get checkIn_blockStorage =>
      'Behebe vor dem Senden den Speicherfehler des Feldprotokolls.';

  @override
  String get checkIn_blockBusy => 'Ein Check-in wird gesendet. Bitte warten.';

  @override
  String get checkIn_blockNoContacts =>
      'Wähle unter „Tour planen“ Tourkontakte.';

  @override
  String get checkIn_blockRosterIncomplete =>
      'Einige Tourkontakte sind nicht verfügbar. Prüfe deine Liste.';

  @override
  String get checkIn_blockNotConnected =>
      'Verbinde dein MeshCore-Funkgerät, um einzuchecken.';

  @override
  String get checkIn_blockNotActive =>
      'Starte deine Tour, um Check-ins zu aktivieren.';

  @override
  String get checkIn_notSent => 'Nicht gesendet';

  @override
  String checkIn_deliveredToOne(String name) {
    return 'Zugestellt an $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return 'Zugestellt an alle $count Kontakte';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return 'Zugestellt an $delivered von $total';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return 'Nicht zugestellt: $names';
  }

  @override
  String get checkIn_waitingForRest => 'Warte auf die übrigen';

  @override
  String get checkIn_aContact => 'einen Kontakt';

  @override
  String get checkIn_statusPending => 'Ausstehend';

  @override
  String get checkIn_statusSent => 'Gesendet';

  @override
  String get checkIn_statusDelivered => 'Zugestellt';

  @override
  String get checkIn_statusFailed => 'Fehlgeschlagen';

  @override
  String get checkIn_explainPending =>
      'Lokal in der Warteschlange. Das bestätigt weder Funkübertragung noch Empfang.';

  @override
  String get checkIn_explainSent =>
      'Das Funkgerät hat den Versand angenommen. Es wurde keine Zustellbestätigung erfasst.';

  @override
  String get checkIn_explainDelivered =>
      'Die App hat eine Zustellbestätigung erfasst. Das beweist nicht, dass die Person sie gelesen hat.';

  @override
  String get checkIn_explainFailed =>
      'Keine bestätigte Zustellung. Prüfe Funkverbindung, Erreichbarkeit des Empfängers und Wiederholungsverlauf.';

  @override
  String get checkIn_explainUnknown =>
      'Zustellstatus nicht verfügbar. Geh nicht davon aus, dass diese Nachricht angekommen ist.';

  @override
  String get tripBrief_heading => 'NOTORYX • MeshCore-Tourübersicht';

  @override
  String tripBrief_trip(String name) {
    return 'Tour: $name';
  }

  @override
  String tripBrief_status(String status) {
    return 'Status: $status';
  }

  @override
  String get tripBrief_active => 'Aktiv';

  @override
  String get tripBrief_stopped => 'Gestoppt';

  @override
  String tripBrief_contacts(String names) {
    return 'Kontakte: $names';
  }

  @override
  String get tripBrief_noneSelected => 'Keine ausgewählt';

  @override
  String get tripBrief_unavailableContact =>
      'Nicht verfügbarer Kontakt (Liste prüfen)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return 'Aktivität überfällig nach: $minutes Minuten (dieses Telefon warnt, wenn ein Kontakt still wird)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'Check-in-Erinnerung: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return 'alle $minutes Minuten ohne Check-in';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'Check-in-Optionen: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'Funkposition in Check-ins: $value';
  }

  @override
  String get tripBrief_includedMayBeStale => 'Enthalten; evtl. veraltet';

  @override
  String tripBrief_battery(String value) {
    return 'Funkgerät-Akku in Check-ins: $value';
  }

  @override
  String get tripBrief_included => 'Enthalten';

  @override
  String get tripBrief_off => 'Aus';

  @override
  String get tripBrief_review =>
      'Prüfe Empfänger und Nachricht, bevor du ein Check-in sendest.';

  @override
  String get tripBrief_noProof =>
      'In der Warteschlange oder gesendet beweist keine Zustellung. Eine Bestätigung beweist nicht, dass sie gelesen wurde.';

  @override
  String get tripBrief_overdueMeaning =>
      'Überfällig bedeutet keine aktuelle Kontaktaktivität; es ist kein bestätigter Notfall.';

  @override
  String get tripBrief_automations =>
      'Feldautomatisierungen laufen nur, solange die App aktiv ist. Vereinbart einen separaten Plan für verpassten Kontakt.';

  @override
  String get tripBrief_sharesOnly =>
      'Diese Übersicht teilt nur Informationen; sie sendet keine Funknachricht und startet keine Tour.';

  @override
  String get fieldOps_title => 'NOTORYX-Core-Feldeinsatz';

  @override
  String get fieldOps_tabTrip => 'Tour';

  @override
  String get fieldOps_tabReady => 'Bereit';

  @override
  String get fieldOps_tabLog => 'Protokoll';

  @override
  String get fieldOps_tabAuto => 'Auto';

  @override
  String get fieldOps_tabCoverage => 'Abdeckung';

  @override
  String get fieldOps_tabConnection => 'Verbindung';

  @override
  String get fieldOps_diagnostics => 'Diagnose';

  @override
  String get fieldOps_storageLoadError =>
      'Felddaten konnten nicht geladen werden. Gespeicherte Daten wurden beibehalten; Automatisierungen bleiben aus.';

  @override
  String get fieldOps_storageSaveError =>
      'Felddaten konnten nicht gespeichert werden. Automatisierungen gestoppt; vorhandene gespeicherte Daten bleiben erhalten.';

  @override
  String get fieldOps_regionHint =>
      'Wähle unter „Offline-Karten“ ein Gebiet und Zoomstufen.';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • Zoom $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return 'Kartengebiet konnte nicht geprüft werden: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tour aktiv • $count Kontakte',
      one: 'Tour aktiv • 1 Kontakt',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped =>
      'Tour gestoppt. Starte sie, wenn du bereit bist.';

  @override
  String fieldOps_reminderAt(String time) {
    return 'Check-in-Erinnerung um $time';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return 'Zu lange still: $names';
  }

  @override
  String get fieldOps_planTrip => 'Tour planen';

  @override
  String get fieldOps_endTrip => 'Tour beenden';

  @override
  String get fieldOps_startTrip => 'Tour starten';

  @override
  String get fieldOps_tripBrief => 'Tourübersicht';

  @override
  String get fieldOps_connectRadio => 'Funkgerät verbinden';

  @override
  String get fieldOps_previewedCheckIns => 'Check-ins mit Vorschau';

  @override
  String get fieldOps_previewedCheckInsHint =>
      'Wähle einen Status, prüfe die tatsächlichen Empfänger und die Nachricht und sende dann. In der Warteschlange heißt nicht zugestellt.';

  @override
  String get fieldOps_tripRoster => 'Tourliste';

  @override
  String get fieldOps_rosterEmpty =>
      'Wähle unter „Tour planen“ bis zu sechs bekannte Chat-Kontakte.';

  @override
  String get fieldOps_rosterCaveat =>
      '„Zuletzt gehört“ belegt vergangene Aktivität. Es belegt keine aktuelle Erreichbarkeit. Überfällig-Markierungen bedeuten keine aktuelle Kontaktaktivität, keinen bestätigten Notfall.';

  @override
  String get fieldOps_offlineMaps => 'Offline-Karten';

  @override
  String get fieldOps_checkingTiles => 'Gespeicherte Kacheln werden geprüft…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gespeicherte Kacheln.',
      one: '1 gespeicherte Kachel.',
    );
    return '$_temp0 Das garantiert nicht, dass deine gesamte Route abgedeckt ist.';
  }

  @override
  String get fieldOps_downloadAreas => 'Offline-Gebiete herunterladen / prüfen';

  @override
  String fieldOps_lastCheckIn(String time) {
    return 'Letztes Check-in, $time';
  }

  @override
  String fieldOps_deliveryChip(String name, String status) {
    return '$name: $status';
  }

  @override
  String get fieldOps_contactFallback => 'Kontakt';

  @override
  String fieldOps_resendFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'An $count nicht Zugestellte erneut senden',
      one: 'An 1 nicht Zugestellten erneut senden',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable =>
      'Ausgewählter Kontakt nicht verfügbar';

  @override
  String get fieldOps_memberUnavailableHint =>
      'Prüfe diese Tour vor dem Senden.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return 'Letzte Aktivität vor $minutes Min.';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return 'Letzte Aktivität vor $minutes Min. • überfällig';
  }

  @override
  String get fieldOps_noCheckInRecorded =>
      'Kein Check-in in diesem Protokoll erfasst.';

  @override
  String get fieldOps_tripMap => 'Tourkarte';

  @override
  String get fieldOps_tripMapEmpty =>
      'Noch keine ausgewählten Kontakte haben Koordinaten gesendet.';

  @override
  String get fieldOps_lastPositions => 'Zuletzt gesendete Positionen';

  @override
  String get fieldOps_positionsCaveat =>
      'Positionen können veraltet sein. Diese Karte verfolgt kein Telefon-GPS und beweist nicht, dass Mitglieder gerade hier sind.';

  @override
  String get fieldOps_briefPreviewTitle => 'Vorschau der Tourübersicht';

  @override
  String get fieldOps_briefPreviewHint =>
      'Enthält Tour- und Kontaktnamen. Vor dem Teilen prüfen. Koordinaten, Schlüssel und Nachrichtenverlauf sind nicht enthalten.';

  @override
  String get fieldOps_shareBrief => 'Übersicht teilen';

  @override
  String get fieldOps_briefSubject => 'NOTORYX-Core-Tourübersicht';

  @override
  String get fieldOps_tripName => 'Tourname';

  @override
  String get fieldOps_defaultTripName => 'Meine Tour';

  @override
  String get fieldOps_includePosition => 'Gesendete Funkposition einbeziehen';

  @override
  String get fieldOps_includePositionHint =>
      'Kann veraltet sein; Teilen ist standardmäßig aus.';

  @override
  String get fieldOps_includeBattery => 'Funkgerät-Akku einbeziehen';

  @override
  String get fieldOps_overdueLabel => 'Warnen, wenn ein Kontakt still ist seit';

  @override
  String get fieldOps_reminderLabel => 'Mich ans Einchecken erinnern';

  @override
  String get fieldOps_reminderHelper =>
      'Eine Telefonbenachrichtigung, auch wenn NOTORYX Core geschlossen ist.';

  @override
  String get fieldOps_reminderOff => 'Aus';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nach $count Minuten ohne Check-in',
      one: 'Nach 1 Minute ohne Check-in',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'SOS geht auch an Kanal';

  @override
  String get fieldOps_sosChannelNone => 'Keiner';

  @override
  String get fieldOps_selectContacts =>
      'Wähle bis zu sechs bekannte Chat-Kontakte';

  @override
  String get fieldOps_sendCheckInTitle => 'Check-in senden?';

  @override
  String fieldOps_recipients(String names) {
    return 'An: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      'Dies nutzt normale Direktnachrichten. Die Zustellung wird im Feldprotokoll verfolgt.';

  @override
  String get fieldOps_send => 'Senden';

  @override
  String get fieldOps_beforeYouLeave => 'Bevor du aufbrichst';

  @override
  String get fieldOps_radioConnected => 'Funkgerät verbunden';

  @override
  String get fieldOps_connectHint => 'Über Bluetooth, USB oder TCP verbinden.';

  @override
  String get fieldOps_radioBattery => 'Funkgerät-Akku';

  @override
  String get fieldOps_batteryUnknown => 'Unbekannt; prüfe das Funkgerät.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent % • für deine geplante Tour laden.';
  }

  @override
  String get fieldOps_tripContacts => 'Tourkontakte';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return '$available/$selected verfügbar. Prüfe, ob sie kompatible Funkgeräte und Kanäle haben.';
  }

  @override
  String get fieldOps_offlineArea => 'Ausgewähltes Offline-Kartengebiet';

  @override
  String get fieldOps_checkingFiles => 'Lokale Dateien werden geprüft…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return '$available/$expected Kacheldateien verfügbar; $missing fehlen. Dies ist eine Momentaufnahme; öffne das Gebiet vor dem Aufbruch offline.';
  }

  @override
  String get fieldOps_locationChoice => 'Standortfreigabe';

  @override
  String get fieldOps_locationOptedIn =>
      'Aktiviert: gesendete Funkkoordinaten können veraltet sein.';

  @override
  String get fieldOps_locationOff =>
      'Freigabe ist aus. Deine Check-ins enthalten keine Koordinaten.';

  @override
  String get fieldOps_automationAvailability =>
      'Verfügbarkeit der Automatisierung';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'Läuft nur, solange diese App aktiv ist. Ruhezustand, Schließen oder Verlust des Funkgeräts können geplante Aktionen verhindern.';

  @override
  String get fieldOps_readinessCaveat =>
      'Bereitschaftsprüfungen sind Empfehlungen; sie beweisen weder Funkreichweite noch garantieren sie die Zustellung.';

  @override
  String get fieldOps_radio => 'Funkgerät';

  @override
  String get fieldOps_refreshChecks => 'Prüfungen aktualisieren';

  @override
  String get fieldOps_searchLog => 'Feldprotokoll durchsuchen';

  @override
  String get fieldOps_kindAll => 'Alle';

  @override
  String get fieldOps_kindCheckIn => 'Check-in';

  @override
  String get fieldOps_kindReceived => 'Empfangen';

  @override
  String get fieldOps_kindNote => 'Notiz';

  @override
  String get fieldOps_kindDeadZone => 'Funkloch';

  @override
  String get fieldOps_kindRadio => 'Funk';

  @override
  String get fieldOps_kindAutomation => 'Automatisierung';

  @override
  String get fieldOps_kindMissed => 'Verpasst';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => 'Tour';

  @override
  String get fieldOps_kindOverdue => 'Überfällig';

  @override
  String get fieldOps_addNote => 'Notiz hinzufügen';

  @override
  String get fieldOps_exportJson => 'JSON exportieren';

  @override
  String get fieldOps_deleteLog => 'Protokoll löschen';

  @override
  String get fieldOps_logSubject => 'NOTORYX-Core-Feldprotokoll';

  @override
  String get fieldOps_logCaveat =>
      'Lokal gespeichert, bis zu 1.000 Einträge. Exporte können Kontaktschlüssel, Nachrichten und Standorte enthalten; vor dem Teilen prüfen.';

  @override
  String get fieldOps_noEntries => 'Keine passenden Einträge.';

  @override
  String get fieldOps_tripUnspecified => 'Tour nicht angegeben';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return 'Erfasste gesendete Funkposition $latitude, $longitude (evtl. veraltet)';
  }

  @override
  String get fieldOps_noteTitle => 'Feldbeobachtung';

  @override
  String get fieldOps_noteLabel => 'Was hast du beobachtet?';

  @override
  String get fieldOps_deadZone => 'Gemeldetes Funkloch';

  @override
  String get fieldOps_deadZoneHint =>
      'Deine Beobachtung, keine geprüfte Abdeckungsvorhersage.';

  @override
  String get fieldOps_savePosition => 'Gesendete Funkposition speichern';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • evtl. veraltet; kein Telefon-GPS';
  }

  @override
  String get fieldOps_noPosition => 'Keine verwendbaren gesendeten Koordinaten';

  @override
  String get fieldOps_deleteLogTitle => 'Feldprotokoll löschen?';

  @override
  String get fieldOps_deleteLogBody =>
      'Dies entfernt alle gespeicherten Einträge auf diesem Telefon. Toureinstellungen bleiben erhalten.';

  @override
  String get fieldOps_localAutomations => 'Lokale Automatisierungen';

  @override
  String get fieldOps_enableForTrip => 'Für diese Tour aktivieren';

  @override
  String get fieldOps_automationsCaveat =>
      'Nach jedem App-Neustart aus. Regeln laufen nur, solange die App aktiv ist. Verpasste geplante Aktionen erscheinen im Feldprotokoll und werden nie gesammelt nachgeholt. Automatische Check-ins sind auf einen Durchgang pro 10 Minuten begrenzt.';

  @override
  String get fieldOps_openBotMode => 'NOTORYX-Bot-Modus öffnen';

  @override
  String get fieldOps_ruleEnabled => 'Regel aktiviert';

  @override
  String get fieldOps_dryRun => 'Probelauf';

  @override
  String get fieldOps_dryRunHint =>
      'Die Aktion erfassen, ohne zu senden oder zu benachrichtigen.';

  @override
  String get fieldOps_then => 'Dann';

  @override
  String get fieldOps_actionLog => 'Ins Feldprotokoll schreiben';

  @override
  String get fieldOps_actionNotify => 'Lokale Benachrichtigung anzeigen';

  @override
  String get fieldOps_actionCheckIn => '„I\'m OK“ an Tourkontakte senden';

  @override
  String get fieldOps_batteryThreshold => 'Akku bei oder unter';

  @override
  String fieldOps_nextDue(String time) {
    return 'Nächste Fälligkeit: $time';
  }

  @override
  String get fieldOps_nextDueNone => 'Nächste Fälligkeit: nicht geplant';

  @override
  String get fieldOps_previewInLog => 'Vorschau im Protokoll';

  @override
  String get fieldOps_allowNotifications => 'Benachrichtigungen erlauben';

  @override
  String get fieldOps_triggerReconnect =>
      'WENN das Funkgerät sich neu verbindet';

  @override
  String get fieldOps_triggerDisconnect =>
      'WENN das Funkgerät die Verbindung trennt';

  @override
  String get fieldOps_triggerLowBattery =>
      'WENN der Funkgerät-Akku den Schwellenwert unterschreitet';

  @override
  String get fieldOps_triggerNewNode => 'WENN ein neuer Knoten hinzukommt';

  @override
  String get fieldOps_triggerRepeater => 'WENN ein neuer Repeater hinzukommt';

  @override
  String get fieldOps_triggerScheduled =>
      'WENN ein geplantes Check-in fällig ist';

  @override
  String get fieldOps_explainConnection => 'Meine Verbindung erklären';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return 'Status: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      'Das Telefon hat eine Funkverbindung. Das allein belegt keine Route zu deinen Empfängern.';

  @override
  String get fieldOps_disconnectedHint =>
      'Keine aktive Funkverbindung. Prüfe Bluetooth-Berechtigungen, Stromversorgung und Reichweite des Funkgeräts; USB/TCP gibt es unter „Funkgerät verbinden“.';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return 'Tour-Check-ins, die auf Bestätigung warten: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'Zuletzt-gesehen-Zeiten und gesendete Positionen von Knoten können veraltet sein. Die Routenanalyse zeigt aus beobachteten Versuchen gelernte Routen; sie erfindet keine Pfade.';

  @override
  String get fieldOps_routeIntelligence => 'Routenanalyse';

  @override
  String get fieldOps_coverageIntelligence => 'Abdeckungsanalyse';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      'Vergleiche erfasste Beobachtungen zweier Feldsitzungen. Punkte markieren gesendete Funkpositionen des Aufzeichnenden, an denen Knoten gehört wurden. Sie bedeuten keine durchgehende Abdeckung. RSSI/SNR-Momentaufnahmen sind keine Messungen pro Knoten.';

  @override
  String get fieldOps_captureSession => 'Sitzung erfassen';

  @override
  String get fieldOps_refreshHistory => 'Verlauf aktualisieren';

  @override
  String get fieldOps_noCoverageSessions =>
      'Noch keine gespeicherten Abdeckungssitzungen.';

  @override
  String get fieldOps_sessionA => 'Sitzung A • Türkis';

  @override
  String get fieldOps_sessionB => 'Sitzung B • Bernstein';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: $a eindeutige Knoten • B: $b eindeutige Knoten';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return 'Gemeinsam: $shared • Nur A: $onlyA • Nur B: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'Einen Knoten in einer Sitzung nicht zu hören, belegt kein Funkloch. Bedingungen und Beobachtungsdauer unterscheiden sich.';

  @override
  String get fieldOps_heardTooltip =>
      'Beobachtung eines gehörten Knotens; kein Beweis für eine erfolgreiche Verbindung';

  @override
  String get fieldOps_noteTooltip =>
      'Lokale Notiz an gesendeten Funkkoordinaten; evtl. veraltet.';

  @override
  String get bastionHome_aboutTooltip => 'Über NOTORYX Core';

  @override
  String get bastionHome_getStarted => 'Loslegen';

  @override
  String get bastionHome_getStartedHint =>
      'Verbinde dein Funkgerät und prüfe deine erste Nachricht';

  @override
  String get bastionHome_planYourTrip => 'Plane deine Tour';

  @override
  String get bastionHome_tripActive => 'Tour aktiv';

  @override
  String get bastionHome_tripStopped => 'Tour gestoppt';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • $contacts Kontakte • $unread ungelesene Nachrichten';
  }

  @override
  String get bastionHome_checkInOk => 'Einchecken: mir geht\'s gut';

  @override
  String get bastionHome_checkInHint =>
      'Prüfe Kontakte und Nachricht vor dem Senden. Verfolge Bestätigungen im Feldprotokoll.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return 'Letztes Check-in: $summary';
  }

  @override
  String get bastionHome_connectRadio => 'Funkgerät verbinden';

  @override
  String get bastionHome_connectRadioHint =>
      'MeshCore-Verbindungen über Bluetooth, USB und TCP';

  @override
  String get bastionHome_liveDiagnostics => 'Live-Diagnose';

  @override
  String get bastionHome_liveDiagnosticsHint =>
      'Funkzustand, Signal, Gerät und Frame-Werkzeuge';

  @override
  String get bastionHome_meshDiscovery => 'Mesh-Erkundung';

  @override
  String get bastionHome_meshDiscoveryHint =>
      'Finde Knoten und untersuche das Mesh um dich herum';

  @override
  String get bastionHome_fieldOpsHint =>
      'Tourübersicht, Bereitschaft, Feldprotokoll, Automatisierungen und Abdeckungsvergleich';

  @override
  String get bastionHome_fieldTools => 'NOTORYX-Feldwerkzeuge';

  @override
  String get bastionHome_statusActive => 'AKTIV';

  @override
  String get bastionHome_consoleOnline => 'Feldkonsole online';

  @override
  String get bastionHome_consoleReady => 'Feldkonsole bereit';

  @override
  String get bastionHome_consoleHint =>
      'Verbinde ein Funkgerät, um das Live-Dashboard zu aktivieren.';

  @override
  String bastionHome_battery(String value) {
    return 'Akku $value';
  }

  @override
  String get bastionTools_title => 'Feldwerkzeuge';

  @override
  String get bastionTools_backup => 'Verschlüsselte Sicherung';

  @override
  String get bastionTools_backupHint =>
      'Einstellungen, Kontakte und Schlüssel speichern, optional mit Chatverlauf';

  @override
  String get bastionTools_fieldOpsHint =>
      'Check-ins, Bereitschaft, Feldprotokoll, Automatisierungen und Vergleiche';

  @override
  String get bastionTools_mapHint =>
      'Live-Karte, Erfassungssitzungen, Offline-Kartenwerkzeuge und Regionen';

  @override
  String get bastionTools_pathAnalysis => 'Pfadanalyse';

  @override
  String get bastionTools_pathHint => 'Routen, Erkundung und Pfadanalyse';

  @override
  String get bastionTools_repeaterHint =>
      'Status, Anmeldung, Telemetrie, Nachbarn und Verwaltung';

  @override
  String get bastionTools_statsHint => 'Live-Mesh-Zahlen und Kontaktaktivität';

  @override
  String get bastionTools_diagnostics => 'Diagnose';

  @override
  String get bastionTools_diagnosticsHint =>
      'Funkzustand, Geräteinformationen, Roh-Frames und Export';

  @override
  String get bastionTools_about => 'Info + Danksagungen';

  @override
  String get bastionTools_aboutHint =>
      'NOTORYX-Core-Version, Unabhängigkeitserklärung und Open-Source-Lizenzen';

  @override
  String get bastionAbout_title => 'Info + Danksagungen';

  @override
  String get bastionAbout_intro =>
      'Eine unabhängige Community-Begleit-App für MeshCore-Netze. NOTORYX Core ist keine offizielle MeshCore-App, und die Aufnahme von Community-Ressourcen bedeutet keine Partnerschaft oder Billigung.';

  @override
  String get bastionAbout_version => 'Version';

  @override
  String get bastionAbout_openSource => 'Open-Source-Grundlage';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core basiert auf Open-Source-Code von MeshCore Open unter der MIT-Lizenz und verändert ihn. Die Arbeit am Abdeckungsablauf würdigt außerdem, wo zutreffend, die MIT-lizenzierte MeshMapper Flutter App.';

  @override
  String get bastionAbout_community => 'Community zuerst';

  @override
  String get bastionAbout_communityBody =>
      'Ressourcen Dritter bleiben Eigentum ihrer jeweiligen Urheber. Es wird weder Eigentum noch Partnerschaft impliziert.';

  @override
  String get bastionAbout_legalese =>
      'NOTORYX Core • Unabhängiger MeshCore-Begleiter';

  @override
  String get bastionAbout_licenses => 'Open-Source-Lizenzen';

  @override
  String get bastionSetup_title => 'Erste Schritte mit NOTORYX Core';

  @override
  String get bastionSetup_intro =>
      'Verbinden, einen Kontakt wählen, dann eine Nachricht prüfen. Du kannst jederzeit vom Dashboard zu dieser Anleitung zurückkehren.';

  @override
  String get bastionSetup_step1 => '1. Verbinde dein MeshCore-Funkgerät';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return 'Verbunden mit $device über $transport.';
  }

  @override
  String get bastionSetup_noRadio => 'Noch kein Funkgerät verbunden.';

  @override
  String get bastionSetup_step1Power =>
      'Schalte ein MeshCore-Begleitfunkgerät ein. Öffne „Funkgerät verbinden“ und wähle Bluetooth, USB oder TCP. Erlaube die für deine Verbindung angeforderten Berechtigungen.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Wenn die Bluetooth-Suche leer ist, prüfe, ob Bluetooth aktiviert ist und NOTORYX Core in den Android-App-Einstellungen die Berechtigung „Geräte in der Nähe“ hat. Folge allen weiteren Berechtigungsanfragen des Scanners.';

  @override
  String get bastionSetup_connectionDiagnostics => 'Verbindungsdiagnose';

  @override
  String get bastionSetup_step2 => '2. Wähle einen Chat-Kontakt';

  @override
  String get bastionSetup_step2Body =>
      'Bitte einen Partner in der Nähe mit kompatiblen MeshCore-Funkeinstellungen, seinen Knoten anzukündigen. Wähle unten einen bekannten Chat-Kontakt; Repeater werden separat verwaltet.';

  @override
  String get bastionSetup_noContacts =>
      'Keine Chat-Kontakte verfügbar. Verbinde dein Funkgerät und öffne die Mesh-Erkundung.';

  @override
  String get bastionSetup_testRecipient => 'Testempfänger';

  @override
  String get bastionSetup_meshDiscovery => 'Mesh-Erkundung';

  @override
  String get bastionSetup_step3 => '3. Sende und prüfe eine Nachricht';

  @override
  String get bastionSetup_step3Body =>
      'Öffne den Chat, schreibe eine kurze Testnachricht, prüfe den Empfänger und tippe auf Senden. Kehre hierher zurück, um die neueste seit dem Öffnen dieser Anleitung erfasste ausgehende Nachricht zu sehen.';

  @override
  String get bastionSetup_openTestChat => 'Test-Chat öffnen';

  @override
  String get bastionSetup_connectFirst =>
      'Verbinde dein Funkgerät, um den Test-Chat zu öffnen.';

  @override
  String get bastionSetup_chooseRecipient => 'Wähle zuerst einen Empfänger.';

  @override
  String get bastionSetup_noTestMessage =>
      'In dieser Anleitungssitzung wurde keine ausgehende Testnachricht erfasst.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return 'Neueste Nachricht: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'Bitte deinen Partner, den Empfang zu bestätigen oder zu antworten. Eine erfasste Bestätigung beweist nicht, dass sie gelesen wurde. Prüfe Verbindung und Empfänger, wenn eine Nachricht fehlschlägt.';

  @override
  String get bastionSetup_step4 => '4. Bereite dich auf den Einsatz vor';

  @override
  String get bastionSetup_step4Body =>
      'Plane deine Tourkontakte und prüfe heruntergeladene Kartengebiete. Bot-Modus und Feldautomatisierungen sind anfangs aus; Feldautomatisierungen laufen nur, solange die App aktiv ist.';

  @override
  String get bastionSetup_tripTools => 'Tour- und Bereitschaftswerkzeuge';

  @override
  String get bastionDiag_title => 'Diagnose';

  @override
  String get bastionDiag_export => 'Diagnose exportieren';

  @override
  String get bastionDiag_channels => 'Kanäle';

  @override
  String get bastionDiag_radio => 'Funk';

  @override
  String get bastionDiag_frequency => 'Frequenz';

  @override
  String get bastionDiag_bandwidth => 'Bandbreite';

  @override
  String get bastionDiag_spreadingFactor => 'Spreizfaktor';

  @override
  String get bastionDiag_codingRate => 'Coderate';

  @override
  String get bastionDiag_txPower => 'Sendeleistung';

  @override
  String get bastionDiag_noiseFloor => 'Grundrauschen';

  @override
  String get bastionDiag_device => 'Gerät';

  @override
  String get bastionDiag_name => 'Name';

  @override
  String get bastionDiag_manufacturer => 'Hersteller';

  @override
  String get bastionDiag_firmware => 'Firmware';

  @override
  String get bastionDiag_battery => 'Akku';

  @override
  String get bastionDiag_transport => 'Verbindungsart';

  @override
  String get bastionDiag_deepTools => 'Tiefere Werkzeuge';

  @override
  String get bastionDiag_liveStats => 'Live-Funkstatistik';

  @override
  String get bastionDiag_liveStatsHint => 'Rauschen, RSSI, SNR und Sendezeit';

  @override
  String get bastionDiag_frameDebug => 'Frame- / BLE-Debug';

  @override
  String get bastionDiag_frameDebugHint =>
      'Dekodierte und rohe empfangene Frames untersuchen';

  @override
  String get bastionDiag_appLog => 'App-Debug-Protokoll';

  @override
  String get bastionDiag_appLogHint => 'Diagnoseereignisse der App ansehen';

  @override
  String get bastionDiag_online => 'Funkgerät online';

  @override
  String get bastionDiag_offline => 'Funkgerät offline';

  @override
  String get bastionDiag_offlineHint =>
      'Verbinde einen MeshCore-Begleiter, um die Live-Diagnose zu füllen.';

  @override
  String get coverage_title => 'Abdeckungserfassung';

  @override
  String get coverage_leaveBlocked =>
      'Beende und speichere die Sitzung, bevor du gehst.';

  @override
  String get coverage_savedSessions => 'Gespeicherte Sitzungen';

  @override
  String get coverage_caveat =>
      'RSSI/SNR sind Funk-Momentaufnahmen und können zu einem anderen Paket gehören. Positionen sind gesendete Funkkoordinaten, kein Telefon-GPS und kein Abdeckungsbeweis. Cyan: Aufzeichnender; Bernstein: gesendeter Knoten. Es wird nicht interpoliert.';

  @override
  String get coverage_captureActive => 'Erfassung aktiv';

  @override
  String get coverage_fieldSession => 'Feld-Abdeckungssitzung';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core erfasst in dieser Sitzung neu gehörte Knoten, einschließlich Routendaten, Knoten-/Standort-Metadaten und der nächstgelegenen verfügbaren RSSI/SNR-Momentaufnahme des Funkgeräts.';

  @override
  String get coverage_disconnectedBody =>
      'Verbinde vor dem Start ein Funkgerät. Die Abdeckungserfassung zeichnet Live-Mesh-Beobachtungen des verbundenen Begleitfunkgeräts auf.';

  @override
  String get coverage_observations => 'Beobachtungen';

  @override
  String get coverage_uniqueNodes => 'Eindeutige Knoten';

  @override
  String get coverage_elapsed => 'Verstrichen';

  @override
  String get coverage_radioConnected => 'Funkgerät verbunden';

  @override
  String get coverage_noRadio => 'Kein Funkgerät';

  @override
  String get coverage_gpsReady => 'Funk-GPS bereit';

  @override
  String get coverage_noGps => 'Kein Funk-GPS';

  @override
  String get coverage_stopSave => 'Beenden + Sitzung speichern';

  @override
  String get coverage_start => 'Abdeckungssitzung starten';

  @override
  String get coverage_exportJson => 'JSON exportieren';

  @override
  String get coverage_exportCsv => 'CSV exportieren';

  @override
  String get coverage_liveObservations => 'Live-Beobachtungen';

  @override
  String get coverage_waiting => 'Warte auf Mesh-Aktivität';

  @override
  String get coverage_waitingBody =>
      'Starte eine Sitzung, und neu gehörte aktive Knoten erscheinen hier. RSSI/SNR-Werte sind Funk-Momentaufnahmen und lassen sich nicht immer eindeutig einem bestimmten Paket zuordnen.';

  @override
  String get coverage_signalNa => 'Signal k. A.';

  @override
  String get coverage_snrNa => 'SNR k. A.';

  @override
  String get coverage_gpsUnavailable => 'Funk-GPS nicht verfügbar';

  @override
  String coverage_pathLine(String path, String location) {
    return 'Pfad: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'Flood';

  @override
  String get coverage_pathDirect => 'direkt';

  @override
  String get coverage_shareSubject => 'NOTORYX-Core-Abdeckungssitzung';

  @override
  String get coverage_shareText =>
      'NOTORYX-Core-Export der Abdeckungserfassung';

  @override
  String get coverage_historyTitle => 'Gespeicherte Abdeckungssitzungen';

  @override
  String coverage_loadFailed(String error) {
    return 'Sitzungen konnten nicht geladen werden: $error';
  }

  @override
  String get coverage_deleteTitle => 'Gespeicherte Sitzung löschen?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Beobachtungen werden von diesem Gerät entfernt.',
      one: '1 Beobachtung wird von diesem Gerät entfernt.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'Sitzung konnte nicht gelöscht werden: $error';
  }

  @override
  String get coverage_retention =>
      'Die neuesten 20 abgeschlossenen Sitzungen werden behalten. Teile Sitzungen, die du behalten willst. Unterbrochene Erfassungen können unten wieder geöffnet werden.';

  @override
  String get coverage_noSessions =>
      'Noch keine gespeicherten Sitzungen. Beende eine Erfassung, um sie zu speichern.';

  @override
  String get coverage_interrupted => 'Unterbrochene Erfassung';

  @override
  String get coverage_saved => 'Gespeichert';

  @override
  String get coverage_deleteTooltip => 'Sitzung löschen';

  @override
  String coverage_exportFailed(String error) {
    return 'Export fehlgeschlagen: $error';
  }

  @override
  String get coverage_sessionTitle => 'Abdeckungssitzung';

  @override
  String get coverage_shareJson => 'JSON teilen';

  @override
  String get coverage_shareCsv => 'CSV teilen';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • Alter der Momentaufnahme $age ms';
  }

  @override
  String get coverage_unknown => 'unbekannt';

  @override
  String coverage_pathValue(String path) {
    return 'Pfad $path';
  }

  @override
  String get coverage_recorder => 'Aufzeichnender';

  @override
  String get coverage_noCoordinates =>
      'Keine verwendbaren Koordinaten in dieser Sitzung. Die Beobachtungen bleiben unten verfügbar.';

  @override
  String get coverage_osmAttribution =>
      '© OpenStreetMap-Mitwirkende • Online-Basiskarte';

  @override
  String get fieldStats_title => 'Feldanalyse';

  @override
  String get fieldStats_snapshot => 'Live-Mesh-Momentaufnahme';

  @override
  String get fieldStats_headline => 'Was NOTORYX Core gerade weiß.';

  @override
  String get fieldStats_body =>
      'Diese Zähler werden aus der Kontakttabelle des verbundenen MeshCore-Geräts, Standorten, Pfaden und Zuletzt-gesehen-Zeitstempeln berechnet.';

  @override
  String get fieldStats_total => 'Gesamt';

  @override
  String get fieldStats_chatNodes => 'Chat-Knoten';

  @override
  String get fieldStats_rooms => 'Räume';

  @override
  String get fieldStats_sensors => 'Sensoren';

  @override
  String get fieldStats_located => 'Mit Standort';

  @override
  String get fieldStats_favorites => 'Favoriten';

  @override
  String get fieldStats_routeSnapshot => 'Routen-Momentaufnahme';

  @override
  String get fieldStats_routed => 'Geroutet';

  @override
  String get fieldStats_direct => 'Direkt';

  @override
  String get fieldStats_flood => 'Flood';

  @override
  String get fieldStats_pathIntel => 'Pfadanalyse';

  @override
  String get fieldStats_pathIntelBody =>
      'Die Routenanalyse von NOTORYX Core nutzt gespeicherte Pfadversuche, Hop-Zahlen, Erfolg/Fehlschlag, Laufzeit und Routengewichtung, um gelernte Routen anzuzeigen.';

  @override
  String get fieldStats_coverageSessions => 'Abdeckungssitzungen';

  @override
  String get fieldStats_coverageSessionsBody =>
      'Die Abdeckungserfassung speichert jetzt Feldsitzungen, stellt unterbrochene Arbeit wieder her, exportiert Beobachtungen und kartiert erfasste Abdeckungspunkte. RSSI/SNR bleiben die nächstgelegene verfügbare Funk-Momentaufnahme.';

  @override
  String get mapHub_title => 'NOTORYX-Feldkarte';

  @override
  String get mapHub_intro =>
      'Live-Karten, Offline-Gebiete, regionale Profile und NOTORYX-Core-Abdeckungssitzungen.';

  @override
  String get mapHub_captureHint =>
      'Eine Feld-Abdeckungssitzung starten und beenden';

  @override
  String get mapHub_badgeNew => 'NEU';

  @override
  String get mapHub_liveMap => 'Live-Mesh-Karte';

  @override
  String get mapHub_liveMapHint =>
      'Knoten, Repeater, Positionen, Routen und Kartenwerkzeuge';

  @override
  String get mapHub_badgeLive => 'LIVE';

  @override
  String get mapHub_offlinePacks => 'Offline-Kartenpakete';

  @override
  String get mapHub_offlinePacksHint =>
      'Kartenkacheln für Touren und Gebiete ohne Netz zwischenspeichern';

  @override
  String get mapHub_badgeOffline => 'OFFLINE';

  @override
  String get mapHub_regions => 'Regionsprofile';

  @override
  String get mapHub_regionsHint =>
      'Regionale Mesh-Definitionen verwalten und abrufen';

  @override
  String get mapHub_badgeRegions => 'REGIONEN';

  @override
  String get routes_title => 'Routenanalyse';

  @override
  String get routes_headline =>
      'Sieh, wie sich der Verkehr durch das Mesh bewegt.';

  @override
  String get routes_body =>
      'NOTORYX Core ordnet gespeicherte Routen anhand des Pfadverlaufs, der bereits aus echten Nachrichtenversuchen und Erkundungen gelernt wurde.';

  @override
  String get routes_routes => 'Routen';

  @override
  String get routes_success => 'Erfolg';

  @override
  String get routes_failed => 'Fehlgeschlagen';

  @override
  String get routes_routeMap => 'Routenkarte';

  @override
  String get routes_routeMapHint => 'Knoten und Pfade untersuchen';

  @override
  String get routes_discover => 'Erkunden';

  @override
  String get routes_discoverHint => 'Neue Routen finden';

  @override
  String get routes_learned => 'Gelernte Routen';

  @override
  String get routes_none => 'Noch kein Routenverlauf';

  @override
  String get routes_noneBody =>
      'Nutze das Mesh normal oder starte eine Erkundung. NOTORYX Core zeigt hier gelernte Routen an, sobald Pfadverlauf verfügbar ist.';

  @override
  String get routes_direct => 'DIREKT';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Routen',
      one: '1 Route',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return 'BESTE  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  Gewicht $weight  •  $success Erfolg / $fail Fehlschlag';
  }

  @override
  String routes_fastest(String ms) {
    return 'Schnellste bekannte: $ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'Flood: $success Erfolg / $fail Fehlschlag';
  }

  @override
  String get repeaterTools_heroLabel => 'Repeater-Zentrale';

  @override
  String get repeaterTools_headline =>
      'Verwalte die Infrastruktur hinter deinem Mesh.';

  @override
  String get repeaterTools_body =>
      'Wähle einen gefundenen Repeater, um dich anzumelden und seine vorhandenen MeshCore-Werkzeuge für Status, Telemetrie, Nachbarn, Einstellungen und CLI zu öffnen.';

  @override
  String get repeaterTools_discovered => 'Gefunden';

  @override
  String get repeaterTools_tools => 'Werkzeuge';

  @override
  String get repeaterTools_available => 'Verfügbare Repeater';

  @override
  String get repeaterTools_unnamed => 'Unbenannter Repeater';

  @override
  String get repeaterTools_statusTelemetry => 'Status + Telemetrie';

  @override
  String get repeaterTools_statusTelemetryBody =>
      'Zustand und Telemetrie von Repeatern mit den vorhandenen Verwaltungswerkzeugen untersuchen.';

  @override
  String get repeaterTools_neighbors => 'Nachbarn';

  @override
  String get repeaterTools_neighborsBody =>
      'Benachbarte Infrastruktur und Mesh-Beziehungen untersuchen.';

  @override
  String get repeaterTools_cli => 'CLI + Einstellungen';

  @override
  String get repeaterTools_cliBody =>
      'Angemeldete Administratoren erreichen die vorhandene Repeater-CLI und Konfigurationswerkzeuge.';

  @override
  String get repeaterTools_empty =>
      'Noch keine Repeater gefunden. Verbinde ein Funkgerät und erkunde zuerst das Mesh.';

  @override
  String get notification_fieldAlertTitle => 'NOTORYX-Feldwarnung';

  @override
  String get notification_checkInReminderTitle =>
      'NOTORYX-Core-Check-in-Erinnerung';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return 'Seit $minutes Minuten kein Check-in auf $trip. Öffne NOTORYX Core, um einzuchecken.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return '$name seit $minutes Minuten nicht gehört. Dies ist kein bestätigter Notfall.';
  }

  @override
  String get notification_aTripContact => 'Ein Tourkontakt';

  @override
  String notification_checkInNotDelivered(String name) {
    return 'Check-in an $name nicht zugestellt. Du kannst es unter „Tour“ erneut senden.';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return 'SOS bestätigt von $name';
  }

  @override
  String get settings_batterySaver => 'Energiesparmodus';

  @override
  String get settings_batterySaverOn =>
      'An: Funkgerät-Akku alle 10 Min., GPS alle 5 Min., Statistik höchstens einmal pro Minute, Tourprüfung alle 1–2 Min. Nachrichten, Warnungen und SOS bleiben unverändert.';

  @override
  String get settings_batterySaverOff =>
      'Funkgerät und Tour seltener prüfen, um Telefon- und Funkgerät-Akku zu sparen. Nachrichten, Warnungen und SOS bleiben unverändert.';

  @override
  String get settings_readAloud => 'Neue Nachrichten vorlesen';

  @override
  String get settings_readAloudHelper =>
      'Solange NOTORYX Core geöffnet ist. Stummgeschaltete Kanäle bleiben still. Jede Nachricht kann auch über ihr Menü vorgelesen werden.';

  @override
  String get settings_readAloudOff => 'Aus';

  @override
  String get settings_readAloudDirect => 'Direktnachrichten';

  @override
  String get settings_readAloudAll => 'Direkt- und Kanalnachrichten';

  @override
  String get chat_readAloud => 'Vorlesen';

  @override
  String get messageSearch_title => 'Nachrichten durchsuchen';

  @override
  String get messageSearch_intro =>
      'Durchsuche alle auf diesem Telefon gespeicherten Direkt- und Kanalnachrichten.';

  @override
  String messageSearch_noResults(String query) {
    return 'Keine Nachricht enthält „$query“.';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Treffer',
      one: '1 Treffer',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return 'Die neuesten $count Treffer werden angezeigt';
  }

  @override
  String get shortcuts_checkIn => 'Einchecken';

  @override
  String get shortcuts_trip => 'Tour';

  @override
  String get shortcuts_chats => 'Chats';

  @override
  String get shortcuts_map => 'Karte';

  @override
  String get sensor_liveUpdates => 'Live-Updates';

  @override
  String get sensor_intro =>
      'Lass den Sensor Messwerte selbst senden, wenn sie sich ändern, statt jedes Mal nachzufragen. Erfordert eine Anmeldung mit Lesezugriff.';

  @override
  String get sensor_watch => 'Auf Änderungen achten';

  @override
  String get sensor_loadFirst =>
      'Lade zuerst die Telemetrie, um Messwerte auszuwählen.';

  @override
  String sensor_watching(String readings, String time) {
    return 'Beobachte $readings bis $time.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return 'Beobachte $readings bis $time • Region $region.';
  }

  @override
  String get sensor_noChanges => 'Noch keine Änderungen gemeldet.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return 'Letztes Update $time • $count empfangen';
  }

  @override
  String get sensor_stop => 'Live-Updates beenden';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'Hier beendet; der Sensor hat nicht bestätigt und hört auf, wenn die Zeit abläuft. $error';
  }

  @override
  String get sensor_dialogBody =>
      'Der Sensor prüft etwa einmal pro Minute und sendet ein Update, wenn sich ein gewählter Messwert stärker als sein Schwellenwert ändert.';

  @override
  String sensor_readingTitle(String label, String channel) {
    return '$label (Kanal $channel)';
  }

  @override
  String sensor_readingValue(String label, String channel, String value) {
    return '$label (Kanal $channel): $value';
  }

  @override
  String sensor_watchItem(String label, String channel, String delta) {
    return '$label (Kanal $channel) ±$delta';
  }

  @override
  String sensor_updateOn(String delta) {
    return 'Update bei einer Änderung um $delta';
  }

  @override
  String get sensor_changeThreshold => 'Schwellenwert ändern';

  @override
  String sensor_capacity(int max, String used) {
    return 'Der Sensor kann bis zu $max Byte an Messwerten beobachten ($used belegt).';
  }

  @override
  String get sensor_for => 'Dauer';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Stunden',
      one: '1 Stunde',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => 'Starten';

  @override
  String sensor_thresholdTitle(String label) {
    return 'Schwellenwert für $label';
  }

  @override
  String get sensor_typeTemperature => 'Temperatur';

  @override
  String get sensor_typeHumidity => 'Luftfeuchtigkeit';

  @override
  String get sensor_typePressure => 'Luftdruck';

  @override
  String get sensor_typeVoltage => 'Spannung';

  @override
  String get sensor_typeCurrent => 'Strom';

  @override
  String get sensor_typeLight => 'Licht';

  @override
  String get sensor_typeConcentration => 'Konzentration';

  @override
  String get sensor_typePercentage => 'Prozent';

  @override
  String get sensor_typeAnalogInput => 'Analogeingang';

  @override
  String get sensor_typeAltitude => 'Höhe';

  @override
  String get setupWizard_title => 'Funkgerät verbinden';

  @override
  String get setupWizard_choose => '1. Verbindung wählen';

  @override
  String get setupWizard_prepare => '2. Funkgerät vorbereiten';

  @override
  String get setupWizard_intro =>
      'Wähle, wie sich dieses Telefon oder dieser Computer mit deinem Funkgerät verbindet. Das Funkgerät überträgt Nachrichten über das Mesh.';

  @override
  String get setupWizard_bluetooth =>
      'Drahtlose Verbindung zu einem kompatiblen Funkgerät in der Nähe.';

  @override
  String get setupWizard_noBluetooth =>
      'Bluetooth ist in diesem Browser nicht verfügbar. Nutze die native App oder eine unterstützte USB-Verbindung.';

  @override
  String get setupWizard_usb => 'Kabelverbindung über ein USB-Datenkabel.';

  @override
  String get setupWizard_noUsb =>
      'USB-Seriell ist hier nicht verfügbar. Nutze eine unterstützte Desktop- oder Android-App oder Chrome mit Web Serial.';

  @override
  String get setupWizard_bluetoothSteps =>
      'Schalte dein Funkgerät ein und halte es in der Nähe. Aktiviere Bluetooth und erlaube der App den Zugriff. Schließe andere mit dem Funkgerät verbundene Apps, öffne dann die Geräteliste und suche.';

  @override
  String get setupWizard_usbSteps =>
      'Verbinde ein eingeschaltetes Funkgerät mit einem USB-Datenkabel; ein reines Ladekabel funktioniert nicht. Schließe andere serielle Apps. Öffne die USB-Geräteliste, wähle dein Funkgerät und erlaube den Zugriff, falls gefragt.';

  @override
  String get setupWizard_firmwareTitle =>
      'Vor dem Firmware-Wechsel die Kompatibilität prüfen';

  @override
  String get setupWizard_firmware =>
      'Dein Funkgerät braucht MeshCore-Companion-Firmware, die die gewählte Verbindung unterstützt. Die Unterstützung hängt von Board und Firmware-Build ab; eine USB-Buchse allein bedeutet noch keine USB-Seriell-Unterstützung. Prüfe die Anleitung für dein genaues Board und den installierten Build. Repeater- oder Room-Server-Firmware ist kein Companion. Eine fehlgeschlagene Verbindung heißt nicht automatisch, dass du neu flashen musst.';

  @override
  String get setupWizard_settings =>
      'Diese Anleitung flasht keine Firmware und ändert keine Funkeinstellungen. Nutze nach dem Verbinden die Einstellungen für Region, Frequenz und erweiterte Optionen. Stimme Einstellungen mit deinem lokalen Mesh ab, bevor du sie änderst.';

  @override
  String get setupWizard_openBluetooth => 'Bluetooth-Geräte öffnen';

  @override
  String get setupWizard_openUsb => 'USB-Geräte öffnen';

  @override
  String get setupWizard_change => 'Verbindungsart ändern';

  @override
  String get setupWizard_later => 'Später einrichten';

  @override
  String get setupWizard_bluetoothError =>
      'Verbindung zum Funkgerät fehlgeschlagen. Lass es eingeschaltet und in der Nähe, prüfe die Bluetooth-Berechtigungen und schließe andere verbundene Apps. Suche dann erneut.';

  @override
  String get setupWizard_scanError =>
      'Suche nach Funkgeräten fehlgeschlagen. Schalte Bluetooth ein und erlaube in den Systemeinstellungen den Zugriff auf Bluetooth bzw. Geräte in der Nähe, dann suche erneut.';

  @override
  String get setupWizard_usbError =>
      'USB-Verbindung fehlgeschlagen. Prüfe das Datenkabel und das gewählte Gerät, erlaube den USB-Zugriff und schließe andere serielle Apps. Stecke das Kabel neu ein und versuche es erneut.';

  @override
  String get connections_title => 'Verbindungen';

  @override
  String get connections_radioTitle => 'Funkverbindung';

  @override
  String get connections_bluetoothOffNotice =>
      'Bluetooth ist aus. Schalte es ein, um neu zu verbinden; die App versucht es erneut, sobald es wieder an ist.';

  @override
  String get connections_transport => 'Verbindungsart';

  @override
  String connections_lastError(String error) {
    return 'Letzter Fehler: $error';
  }

  @override
  String get connections_disconnectRadio => 'Funkgerät trennen';

  @override
  String connections_reconnectTo(String name) {
    return 'Neu verbinden mit $name';
  }

  @override
  String get connections_forgetRadio => 'Funkgerät vergessen';

  @override
  String get connections_connectAnother => 'Anderes Funkgerät verbinden';

  @override
  String get connections_usbSerial => 'USB-Seriell';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'Gerät';

  @override
  String get connections_publicKey => 'Öffentlicher Schlüssel';

  @override
  String get connections_firmware => 'Firmware';

  @override
  String connections_firmwareProtocol(String code) {
    return 'Protokoll v$code';
  }

  @override
  String get connections_battery => 'Akku';

  @override
  String get connections_lastRx => 'Letzter Empfang';

  @override
  String get connections_reconnectFailed =>
      'Neuverbindung mit dem Funkgerät fehlgeschlagen';

  @override
  String get connections_statusBluetoothOff => 'Bluetooth ist aus';

  @override
  String get connections_statusConnected => 'Verbunden';

  @override
  String get connections_statusConnecting => 'Verbinde…';

  @override
  String get connections_statusDisconnecting => 'Trenne…';

  @override
  String get connections_statusScanning => 'Suche nach Funkgeräten…';

  @override
  String get connections_statusReconnectingSoon => 'Neuverbindung gleich…';

  @override
  String get connections_statusNotConnected => 'Nicht verbunden';

  @override
  String get mqtt_cardTitle => 'MQTT-Verbindung';

  @override
  String get mqtt_statusNotConfigured => 'Nicht eingerichtet';

  @override
  String get mqtt_statusDisconnected => 'Getrennt';

  @override
  String get mqtt_statusConnecting => 'Verbinde';

  @override
  String get mqtt_statusConnected => 'Verbunden';

  @override
  String get mqtt_statusReconnecting => 'Verbinde neu';

  @override
  String get mqtt_statusError => 'Verbindungsfehler';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'Broker: $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn => 'Anmeldung mit vom Funkgerät signiertem Token';

  @override
  String mqtt_tokenSignInAs(String username) {
    return 'Anmeldung mit vom Funkgerät signiertem Token als $username…';
  }

  @override
  String get mqtt_connectRadioToSignIn =>
      'Verbinde dein Funkgerät, um dich anzumelden';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'Token wird um $time erneuert';
  }

  @override
  String mqtt_signedInAs(String username) {
    return 'Angemeldet als $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return 'Empfange auf $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'Pakete: $accepted neu, $duplicate doppelt, $invalid ungültig';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return 'Versuch $attempt von $max';
  }

  @override
  String get mqtt_sharingWaitsForRadio =>
      'Teilen wartet auf eine Funkverbindung';

  @override
  String mqtt_sharingOn(String topic) {
    return 'Teile auf $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return 'Wird auf $topic teilen';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'Online-Status auf $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return 'Geteilt $shared, zurückgehalten $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'Füge einen Broker hinzu, um MeshCore-Verkehr über das Internet zu verbinden. Die Funkverbindung funktioniert unabhängig davon.';

  @override
  String get mqtt_disconnect => 'MQTT trennen';

  @override
  String get mqtt_connect => 'MQTT verbinden';

  @override
  String get mqtt_packetFeed => 'Paket-Feed';

  @override
  String get mqtt_setUpBroker => 'Broker einrichten';

  @override
  String get mqtt_brokerSettings => 'Broker-Einstellungen';

  @override
  String get mqtt_settingsTitle => 'MQTT-Broker-Einstellungen';

  @override
  String get mqtt_presetLabel => 'Mit einer Vorlage beginnen';

  @override
  String get mqtt_presetCustom => 'Eigener Broker';

  @override
  String get mqtt_presetLocal => 'Lokaler Broker (Adresse eintragen)';

  @override
  String get mqtt_presetLetsMeshUs => 'LetsMesh-Analyzer (USA, Community)';

  @override
  String get mqtt_presetLetsMeshEu => 'LetsMesh-Analyzer (EU, Community)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh ist ein von der Community betriebener MeshCore-Paketanalyzer, kein Teil von NOTORYX und nicht von NOTORYX empfohlen. Teilen braucht ein verbundenes Funkgerät und bleibt aus, bis du es einschaltest.';

  @override
  String get mqtt_hostname => 'Broker-Hostname';

  @override
  String get mqtt_port => 'Port';

  @override
  String get mqtt_useTls => 'TLS verwenden';

  @override
  String get mqtt_allowCleartext => 'Klartext zu einem lokalen Broker erlauben';

  @override
  String get mqtt_allowCleartextHint =>
      'Nur localhost, .local und private 10.x- / 192.168.x-Hosts.';

  @override
  String get mqtt_useWebSocket => 'WebSocket verwenden';

  @override
  String get mqtt_webSocketPath => 'WebSocket-Pfad';

  @override
  String get mqtt_topicPrefix => 'Topic-Präfix';

  @override
  String get mqtt_region => 'Region (optional)';

  @override
  String get mqtt_regionHelp =>
      'Regionscode des Beobachters, z. B. PHL. Leer lassen für alle.';

  @override
  String get mqtt_deliverChannel =>
      'Über MQTT gehörte Kanalnachrichten hinzufügen';

  @override
  String get mqtt_deliverChannelHint =>
      'Nachrichten in deinen Kanälen, die Beobachter gehört haben, erscheinen in deinen Chats. Sie werden nicht über dein Funkgerät gesendet.';

  @override
  String get mqtt_sharingTitle => 'Als Beobachter teilen';

  @override
  String get mqtt_share => 'Pakete teilen, die mein Funkgerät hört';

  @override
  String get mqtt_shareHint =>
      'Veröffentlicht Adverts und Kanalverkehr, die dein Funkgerät empfängt, mit seinem öffentlichen Schlüssel, der Signalstärke und der Region. Kanalnachrichten bleiben verschlüsselt. Braucht eine Region.';

  @override
  String get mqtt_shareDirect => 'Direktnachrichten-Verkehr einschließen';

  @override
  String get mqtt_shareDirectHint =>
      'Anfragen, Antworten und Direktnachrichten. Die Inhalte bleiben verschlüsselt, aber es zeigt, welche Knoten miteinander kommunizieren.';

  @override
  String get mqtt_shareOwn =>
      'Meine eigenen Nachrichten und Adverts einschließen';

  @override
  String get mqtt_signInTitle => 'Anmeldung';

  @override
  String get mqtt_authPassword => 'Benutzername und Passwort';

  @override
  String get mqtt_authToken => 'Vom Funkgerät signiertes Token';

  @override
  String get mqtt_tokenExplain =>
      'Dein Funkgerät signiert mit seinem eigenen Schlüssel ein einstündiges Anmeldetoken, und die App erneuert es, bevor es abläuft. Der Schlüssel verlässt das Funkgerät nie. Der Benutzername ist v1_ plus der öffentliche Schlüssel deines Funkgeräts.';

  @override
  String get mqtt_radioReady => 'Funkgerät verbunden: bereit zur Anmeldung.';

  @override
  String get mqtt_radioNeeded =>
      'Verbinde dein Funkgerät, um dich anzumelden. MQTT wartet darauf.';

  @override
  String get mqtt_username => 'Benutzername (optional)';

  @override
  String get mqtt_password => 'Passwort';

  @override
  String get mqtt_keepPassword =>
      'Leer lassen, um das gespeicherte Passwort zu behalten.';

  @override
  String get mqtt_credentialsWeb =>
      'Im Browser werden Zugangsdaten nur behalten, bis die Seite geschlossen wird.';

  @override
  String get mqtt_credentialsKeychain =>
      'Zugangsdaten werden im Schlüsselbund des Systems gespeichert, nie in App-Einstellungen oder Logs.';

  @override
  String get mqtt_saveSettings => 'Einstellungen speichern';

  @override
  String get mqtt_feedTitle => 'MQTT-Paket-Feed';

  @override
  String get mqtt_feedConnect =>
      'Verbinde dich mit einem Broker, um Pakete von Beobachtern zu sehen.';

  @override
  String mqtt_feedWaiting(String topic) {
    return 'Warte auf Pakete auf $topic';
  }

  @override
  String get mqtt_feedUnknownObserver => 'Unbekannter Beobachter';

  @override
  String mqtt_feedHeardBy(String observer) {
    return 'Gehört von $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return '$hops Hops · $bytes Bytes';
  }

  @override
  String get mqtt_packetRequest => 'Anfrage';

  @override
  String get mqtt_packetResponse => 'Antwort';

  @override
  String get mqtt_packetDirectMessage => 'Direktnachricht';

  @override
  String get mqtt_packetAck => 'Bestätigung';

  @override
  String get mqtt_packetAdvert => 'Advert';

  @override
  String get mqtt_packetChannelMessage => 'Kanalnachricht';

  @override
  String get mqtt_packetChannelData => 'Kanaldaten';

  @override
  String get mqtt_packetAnonymousRequest => 'Anonyme Anfrage';

  @override
  String get mqtt_packetPath => 'Pfad';

  @override
  String get mqtt_packetTrace => 'Trace';

  @override
  String get mqtt_packetMultipart => 'Mehrteilig';

  @override
  String get mqtt_packetControl => 'Steuerung';

  @override
  String mqtt_packetType(int type) {
    return 'Typ $type';
  }

  @override
  String get mqtt_routeTransportFlood => 'Transport-Flood';

  @override
  String get mqtt_routeFlood => 'Flood';

  @override
  String get mqtt_routeDirect => 'Direkt';

  @override
  String get mqtt_routeTransportDirect => 'Transport-Direkt';

  @override
  String get mqtt_noticeInvalidHost =>
      'Gib einen Hostnamen oder eine IPv4-Adresse ohne Schema oder Port ein.';

  @override
  String get mqtt_noticeInvalidPort =>
      'Der Port muss zwischen 1 und 65535 liegen.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'Der WebSocket-Pfad muss mit / beginnen und darf keine Query oder kein Fragment enthalten.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'Das Topic-Präfix muss ein nicht leerer MQTT-Pfad ohne Platzhalter sein.';

  @override
  String get mqtt_noticeInvalidRegion =>
      'Die Region muss aus 2–8 Buchstaben oder Ziffern bestehen, z. B. PHL.';

  @override
  String get mqtt_noticeTlsRequired =>
      'TLS ist Pflicht, außer der unsichere Zugriff auf einen lokalen Broker ist ausdrücklich erlaubt.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      'Klartext-MQTT ist nur für ausdrücklich erlaubte lokale Hosts möglich.';

  @override
  String get mqtt_noticeRegionNeededToShare =>
      'Lege eine Region fest, um Pakete als Beobachter zu teilen.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return 'Gib das Passwort für $username ein.';
  }

  @override
  String get mqtt_noticeNoNetwork =>
      'Keine Netzwerkverbindung. MQTT verbindet sich neu, sobald sie wieder da ist.';

  @override
  String get mqtt_noticeSubscriptionRefused =>
      'Der Broker hat das Paket-Abonnement abgelehnt.';

  @override
  String get mqtt_noticeBadCredentials =>
      'Der Broker hat Benutzername oder Passwort abgelehnt.';

  @override
  String get mqtt_noticeNotAuthorized =>
      'Dieses Konto ist auf dem Broker nicht berechtigt.';

  @override
  String get mqtt_noticeConnectionRefused =>
      'Der Broker hat die Verbindung abgelehnt.';

  @override
  String get mqtt_noticeUnreachable => 'Der Broker war nicht erreichbar.';

  @override
  String get mqtt_noticeTlsFailed =>
      'Die sichere (TLS-)Verbindung konnte nicht aufgebaut werden.';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'Diese Plattform unterstützt MQTT nur über WebSocket.';

  @override
  String get mqtt_noticeRadioNotConnected =>
      'Verbinde dein Funkgerät, um dich mit seinem Schlüssel anzumelden.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'Die Firmware dieses Funkgeräts kann nicht mit seinem Schlüssel signieren.';

  @override
  String get mqtt_noticeSigningTimeout =>
      'Das Funkgerät hat auf die Signieranfrage nicht geantwortet. Seine Firmware unterstützt das Signieren möglicherweise nicht.';

  @override
  String get mqtt_noticeSigningTooLong =>
      'Die Daten sind zu lang, als dass das Funkgerät sie signieren könnte.';

  @override
  String get mqtt_noticeSigningRejected =>
      'Das Funkgerät hat das Signieren der Daten abgelehnt.';

  @override
  String get scanner_signalStrong => 'Stark';

  @override
  String get scanner_signalGood => 'Gut';

  @override
  String get scanner_signalFair => 'Mittel';

  @override
  String get scanner_signalWeak => 'Schwach';

  @override
  String get scanner_nearbyRadios => 'Funkgeräte in der Nähe';

  @override
  String get scanner_lastRadio => 'Letztes Funkgerät';

  @override
  String get scanner_reconnect => 'Neu verbinden';

  @override
  String get scanner_tcpHint =>
      'Ein Funkgerät mit WLAN-Firmware in deinem Netzwerk.';

  @override
  String get scanner_otherWays => 'Andere Verbindungswege';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Funkgeräte in der Nähe',
      one: '1 Funkgerät in der Nähe',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => 'Suche nach Funkgeräten…';

  @override
  String get scanner_findTitle => 'Finde dein Funkgerät';

  @override
  String get scanner_heroHint =>
      'Schalte dein Funkgerät ein und halte es in wenigen Metern Nähe. Es braucht MeshCore-Companion-Firmware.';

  @override
  String get scanner_tipsTitle => 'Funkgerät nicht zu sehen?';

  @override
  String get scanner_tipPower => 'Prüfe, ob es eingeschaltet und aktiv ist.';

  @override
  String get scanner_tipFirmware =>
      'Es braucht MeshCore-Companion-Firmware. Repeater und Room-Server erscheinen hier nicht.';

  @override
  String get scanner_tipOtherDevice =>
      'Ein Funkgerät verbindet sich immer nur mit einem Gerät. Trenne es von anderen Telefonen oder Computern.';

  @override
  String get connections_internetBridge => 'Internet-Brücke';

  @override
  String get connections_noRadio => 'Kein Funkgerät';

  @override
  String get connections_radioSettings => 'Funkeinstellungen';

  @override
  String get connections_viewDashboard => 'Verbindungsübersicht anzeigen';

  @override
  String get channelDirectory_title => 'Kanalverzeichnis';

  @override
  String get channelDirectory_subtitle =>
      'Öffentliche Hashtag-Kanäle in deiner Nähe finden';

  @override
  String get channelDirectory_search => 'Kanäle oder Orte suchen';

  @override
  String get channelDirectory_nearYou => 'In deiner Nähe';

  @override
  String get channelDirectory_all => 'Alle Kanäle';

  @override
  String get channelDirectory_catAll => 'Alle';

  @override
  String get channelDirectory_catEmergency => 'Notfall';

  @override
  String get channelDirectory_catLocal => 'Lokal';

  @override
  String get channelDirectory_catGeneral => 'Allgemein';

  @override
  String get channelDirectory_catInterest => 'Interessen';

  @override
  String get channelDirectory_catTest => 'Test';

  @override
  String get channelDirectory_join => 'Beitreten';

  @override
  String get channelDirectory_joined => 'Beigetreten';

  @override
  String get channelDirectory_noMatches =>
      'Keine Kanäle passen zu deiner Suche.';

  @override
  String get channelDirectory_connectFirst =>
      'Verbinde dein Funkgerät, um Kanälen beizutreten.';

  @override
  String get channelDirectory_slotsFull =>
      'Alle Kanalplätze deines Funkgeräts sind belegt. Entferne zuerst einen Kanal.';

  @override
  String get channelDirectory_joinFailed =>
      'Kanal konnte nicht hinzugefügt werden. Versuche es erneut.';

  @override
  String get channelDirectory_addHint =>
      'Fehlt ein Kanal? Jeder kann einen vorschlagen, indem er die gemeinsame Liste auf GitHub bearbeitet.';

  @override
  String get prefixTool_title => 'Repeater-IDs';

  @override
  String get prefixTool_subtitle =>
      'Wer eine ID nutzt, welche IDs kollidieren und freie IDs für einen neuen Repeater';

  @override
  String get prefixTool_width => 'Größe der Pfad-ID';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes Byte';
  }

  @override
  String get prefixTool_includeCompanions =>
      'Companions und Sensoren einbeziehen';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return '$nodes Knoten bekannt · $used IDs belegt · $shared geteilt';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return '$free von $space IDs frei';
  }

  @override
  String get prefixTool_lookupHint => 'ID nachschlagen, z. B. 3D';

  @override
  String prefixTool_lookupFree(String id) {
    return 'Kein bekannter Knoten nutzt $id.';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Knoten nutzen $id',
      one: '1 Knoten nutzt $id',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => 'Geteilte IDs';

  @override
  String get prefixTool_sharedHint =>
      'Pfade über diese IDs sehen gleich aus, solange das Mesh keine längeren IDs nutzt.';

  @override
  String get prefixTool_noShared =>
      'Keine geteilten IDs unter deinen bekannten Knoten.';

  @override
  String get prefixTool_free => 'Freie IDs';

  @override
  String get prefixTool_shuffle => 'Weitere Vorschläge';

  @override
  String get prefixTool_makeKey => 'Schlüssel erzeugen';

  @override
  String get prefixTool_onlyKnown =>
      'Nur auf Basis der Knoten, die dein Funkgerät gehört hat. Eine hier freie ID kann trotzdem zu einem Repeater gehören, den du nicht gehört hast.';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id wird bereits von $name genutzt.';
  }

  @override
  String get prefixTool_pickFree => 'Freie ID wählen';

  @override
  String keyGen_title(String id) {
    return 'Schlüssel für ID $id';
  }

  @override
  String keyGen_searching(int tries) {
    return 'Suche… $tries Schlüssel probiert';
  }

  @override
  String get keyGen_publicKey => 'Öffentlicher Schlüssel';

  @override
  String get keyGen_privateKey => 'Privater Schlüssel';

  @override
  String get keyGen_copy => 'Kopieren';

  @override
  String get keyGen_copied => 'Kopiert';

  @override
  String get keyGen_secretWarning =>
      'Halte den privaten Schlüssel geheim. Wer ihn hat, kann sich als dieser Knoten ausgeben.';

  @override
  String get keyGen_howToUse =>
      'Für einen Repeater: Öffne seine Einstellungen, füge ihn als privaten Schlüssel ein und speichere. Companion-Funkgeräte brauchen Firmware, die Schlüsselimport erlaubt.';

  @override
  String get keyGen_tryAgain => 'Noch einen erzeugen';

  @override
  String get regionSetup_title => 'Regionen einrichten';

  @override
  String get regionSetup_hubSubtitle =>
      'Diesen Repeater in den Regionsbaum deiner Gegend einordnen';

  @override
  String get regionSetup_intro =>
      'Regionen halten eine Nachricht in einem Gebiet, statt das ganze Mesh zu fluten. Ein Repeater leitet Nachrichten einer Region nur weiter, wenn er diese Region trägt. Gib ihm also seine eigene Region und alle darüber.';

  @override
  String get regionSetup_where => 'Wo steht der Repeater?';

  @override
  String get regionSetup_tree => 'Regionsbaum';

  @override
  String get regionSetup_custom => 'Eigene';

  @override
  String get regionSetup_region => 'Lokalste Region';

  @override
  String regionSetup_source(String source) {
    return 'Quelle: $source';
  }

  @override
  String get regionSetup_customLabel => 'Regionen, die weiteste zuerst';

  @override
  String regionSetup_invalidName(String name) {
    return '„$name“ ist kein gültiger Regionsname. Nutze Kleinbuchstaben, Ziffern und Bindestriche, höchstens 29 Zeichen.';
  }

  @override
  String regionSetup_tooMany(int max) {
    return 'Ein Repeater kann höchstens $max Regionen tragen.';
  }

  @override
  String get regionSetup_options => 'Optionen';

  @override
  String get regionSetup_setDefault => 'Lokalste Region als Standard';

  @override
  String get regionSetup_setDefaultBody =>
      'Die eigenen Adverts des Repeaters bleiben in dieser Region.';

  @override
  String get regionSetup_legacy => 'Firmware 1.14';

  @override
  String get regionSetup_legacyBody =>
      'Fügt nach jeder Region region allowf hinzu. Ab 1.15 nicht nötig.';

  @override
  String get regionSetup_denyUnscoped =>
      'Nachrichten ohne Region nicht weiterleiten';

  @override
  String get regionSetup_denyUnscopedBody =>
      'Nur einschalten, wenn deine ganze Gegend Regionen nutzt, sonst kommen Nachrichten älterer Apps nicht durch.';

  @override
  String get regionSetup_commands => 'Befehle';

  @override
  String get regionSetup_copyAll => 'Alle kopieren';

  @override
  String get regionSetup_copied => 'Kopiert';

  @override
  String get regionSetup_pickFirst =>
      'Wähle eine Region, um die Befehle zu sehen.';

  @override
  String regionSetup_sendTo(String name) {
    return 'An $name senden';
  }

  @override
  String get regionSetup_howToSend =>
      'Melde dich zum Senden beim Repeater an und öffne „Regionen einrichten“ in seinem Menü, oder füge die Befehle in seine Kommandozeile ein.';

  @override
  String get regionSetup_noReply => 'Keine Antwort. Hier abgebrochen.';

  @override
  String get regionSetup_addToMine =>
      'Diese Regionen zu meiner Liste hinzufügen';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Regionen zu deiner Liste hinzugefügt',
      one: '1 Region zu deiner Liste hinzugefügt',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => 'Streckenaufzeichnung';

  @override
  String get trackLog_subtitle =>
      'Eine Spur aus dem GPS deines Funkgeräts aufzeichnen';

  @override
  String get trackLog_recording => 'Aufzeichnung läuft';

  @override
  String get trackLog_notRecording => 'Keine Aufzeichnung';

  @override
  String get trackLog_noGps =>
      'Dein Funkgerät meldet keine GPS-Position. Die Aufzeichnung braucht ein Funkgerät mit eingeschaltetem GPS.';

  @override
  String get trackLog_start => 'Aufzeichnung starten';

  @override
  String get trackLog_stop => 'Aufzeichnung beenden';

  @override
  String get trackLog_howItWorks =>
      'Nutzt die Position, die dein Funkgerät etwa einmal pro Minute meldet, solange NOTORYX Core geöffnet ist. Ein Punkt kommt nach 25 m Bewegung hinzu, oder alle 15 Minuten, wenn du stehst.';

  @override
  String get trackLog_snap => 'Positionen auf etwa 100 m runden';

  @override
  String get trackLog_snapBody =>
      'Für mehr Privatsphäre beim Teilen einer Strecke.';

  @override
  String get trackLog_saved => 'Gespeicherte Strecken';

  @override
  String get trackLog_none => 'Noch keine Strecken.';

  @override
  String get trackLog_export => 'Als GPX exportieren';

  @override
  String get trackLog_exportFailed => 'Strecke konnte nicht exportiert werden.';

  @override
  String get trackLog_deleteTitle => 'Diese Strecke löschen?';

  @override
  String get trackLog_deleteBody =>
      'Sie wird von diesem Gerät entfernt. Exportierte GPX-Dateien bleiben erhalten.';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km km · $duration · $points Punkte';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'NOTORYX-Strecke $when';
  }

  @override
  String get routes_nearbyTitle => 'Beste Repeater in deiner Nähe';

  @override
  String get routes_nearbyEmptyTitle => 'Noch keine Repeater gehört';

  @override
  String get routes_nearbyEmpty =>
      'Repeater, die dein Funkgerät direkt hört, erscheinen hier, die stärksten zuerst, sobald es Verkehr empfängt. Die Liste umfasst die letzte Stunde.';

  @override
  String get routes_unknownRepeater => 'Unbekannter Repeater';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count-mal gehört',
      one: 'einmal gehört',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'vor $minutes Min.',
      one: 'vor 1 Min.',
      zero: 'gerade eben',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return 'über $names';
  }

  @override
  String get nav_home => 'Start';

  @override
  String get nav_chats => 'Chats';

  @override
  String get nav_tools => 'Werkzeuge';

  @override
  String get nav_settings => 'Einstellungen';

  @override
  String get nav_more => 'Mehr';

  @override
  String get tools_groupApp => 'App & Einstellungen';

  @override
  String get tools_groupField => 'Im Gelände';

  @override
  String get tools_groupMaps => 'Karten & Abdeckung';

  @override
  String get tools_groupRouting => 'Routen & Repeater';

  @override
  String get tools_pathGraph => 'Pfadgraph';

  @override
  String get tools_pathGraphHint =>
      'Wie Nachrichten dich erreichen: jeder gehörte Pfad, mit den aktivsten Repeatern';

  @override
  String get tools_antenna => 'Antennenabdeckung';

  @override
  String get tools_antennaHint =>
      'Schätze, wie weit eine Antenne über das Gelände reicht';

  @override
  String routes_repeaterWithId(String id) {
    return 'Repeater $id';
  }

  @override
  String get coverageHex_title => 'Abdeckungs-Sechsecke';

  @override
  String get coverageHex_toolSubtitle =>
      'Kartiere, wo dein Funkgerät das Mesh hört, und teile es';

  @override
  String get coverageHex_mapCoverage => 'Abdeckung kartieren';

  @override
  String get coverageHex_statusOff =>
      'Aus. Schalte es beim Fahren oder Gehen ein, um zu kartieren, wo dein Funkgerät das Mesh hört.';

  @override
  String get coverageHex_waitingGps => 'Warte auf GPS…';

  @override
  String coverageHex_gpsTooRough(String meters) {
    return 'GPS-Genauigkeit $meters m: zu ungenau, keine Aufzeichnung.';
  }

  @override
  String coverageHex_recording(String meters) {
    return 'Aufzeichnung läuft. GPS-Genauigkeit $meters m.';
  }

  @override
  String get coverageHex_hexagons => 'Sechsecke';

  @override
  String get coverageHex_samples => 'Proben';

  @override
  String get coverageHex_privacyNote =>
      'Nutzt das GPS des Telefons, solange dieser Schalter an ist. Geteilt werden nur Sechseck-IDs (etwa 0,9 km breit), nie deine genaue Position.';

  @override
  String get coverageHex_uploadSection => 'Auf Abdeckungskarten hochladen';

  @override
  String get coverageHex_wifiOnly => 'Nur über WLAN hochladen';

  @override
  String get coverageHex_wifiOnlyHint =>
      'Proben warten auf dem Telefon (bis zu 7 Tage) auf WLAN.';

  @override
  String coverageHex_waiting(String count) {
    return '$count wartend';
  }

  @override
  String get coverageHex_addMap => 'Abdeckungskarte hinzufügen';

  @override
  String get coverageHex_addMapHint =>
      'Jeder HTTPS-Endpunkt, der Abdeckungs-Uploads annimmt.';

  @override
  String get coverageHex_uploadNow => 'Jetzt hochladen';

  @override
  String get coverageHex_mapDialogTitle => 'Abdeckungskarte';

  @override
  String get coverageHex_nameMissing => 'Gib ihr einen Namen.';

  @override
  String get coverageHex_url => 'Upload-URL';

  @override
  String get coverageHex_urlInvalid => 'Muss eine https://-URL sein.';

  @override
  String get coverageHex_apiKey => 'API-Schlüssel (optional)';

  @override
  String get coverageHex_apiKeyHint => 'Wird als X-API-Key gesendet.';

  @override
  String get coverageHex_format => 'Format';

  @override
  String get coverageHex_formatHex => 'Sechseck-IDs (NOTORYX)';

  @override
  String get coverageHex_formatMeshMapper => 'MeshMapper-kompatibel';

  @override
  String get coverageHex_privacy => 'Datenschutz';

  @override
  String get coverageHex_privacyLive => 'Live';

  @override
  String get coverageHex_privacyDelayed => 'Verzögert 3 Std.';

  @override
  String get coverageHex_privacyAnonymous => 'Anonym, 24 Std.';

  @override
  String get coverageHex_privacyLiveHint =>
      'Wird innerhalb von etwa 15 Minuten gesendet.';

  @override
  String get coverageHex_privacyDelayedHint =>
      '3 Stunden zurückgehalten, damit die Karte nicht zeigt, wo du gerade bist.';

  @override
  String get coverageHex_privacyAnonymousHint =>
      '24 Stunden zurückgehalten, nur mit Tagesdatum und ohne Signatur, damit Uploads nicht verknüpft werden können.';

  @override
  String get coverageHex_uploadsOn => 'Uploads an';

  @override
  String coverageHex_sent(String count, String time) {
    return '$count Zellen um $time gesendet.';
  }

  @override
  String coverageHex_httpError(String code) {
    return 'Die Karte antwortete mit $code; neuer Versuch folgt.';
  }

  @override
  String get coverageHex_unreachable =>
      'Karte nicht erreichbar; neuer Versuch folgt.';

  @override
  String get coverageHex_noPermission =>
      'Standortberechtigung wurde nicht erteilt.';

  @override
  String get coverageHex_noGps => 'GPS ist nicht verfügbar.';

  @override
  String get coverageHex_loadFailed =>
      'Gespeicherte Abdeckung nicht lesbar; es wird neu begonnen.';

  @override
  String get mqttExtra_wifiOnly => 'Nur über WLAN verbinden';

  @override
  String mqttExtra_backlog(String count) {
    return '$count Pakete warten auf den Upload (bis zu 72 Stunden aufbewahrt).';
  }

  @override
  String get mqttExtra_add => 'Weiteren Broker hinzufügen';

  @override
  String get mqttExtra_addBody =>
      'Teilt, was dein Funkgerät hört, mit einem weiteren MQTT-Broker neben dem Hauptbroker. Er lädt nur hoch und speist nie Pakete in die App zurück.';

  @override
  String get mqttExtra_separateKey => 'Separaten Schlüssel verwenden';

  @override
  String get mqttExtra_separateKeyHint =>
      'Meldet sich mit einem auf diesem Telefon erzeugten Schlüssel statt dem des Funkgeräts an, damit dieser Broker Uploads nicht deinem Funkgerät zuordnen kann.';

  @override
  String mqttExtra_removeTitle(String name) {
    return '$name entfernen?';
  }

  @override
  String get mqttExtra_removeBody =>
      'Trennt die Verbindung und vergisst Einstellungen, Passwort, Schlüssel und alle noch wartenden Pakete.';

  @override
  String mqttExtra_ownKey(String key) {
    return 'Meldet sich mit eigenem Schlüssel an: $key…';
  }

  @override
  String get botWx_title => 'Wetterwarnungen in einem Kanal posten';

  @override
  String get botWx_body =>
      'Prüft alle 10 Minuten beim US National Weather Service auf schwere und extreme Warnungen an der GPS-Position des Funkgeräts (auf etwa 1 km gerundet) und postet jede neue einmal. Braucht Internet auf dem Telefon.';

  @override
  String get botWx_channel => 'In Kanal posten';

  @override
  String get botWx_moderate => 'Mäßige Warnungen einschließen';

  @override
  String get botWx_moderateHint => 'Hinweise und Warnungen. Mehr Meldungen.';

  @override
  String botWx_lastChecked(String time) {
    return 'Zuletzt geprüft $time.';
  }

  @override
  String get botWx_noPosition =>
      'Das Funkgerät hat noch keine GPS-Position gemeldet.';

  @override
  String get botWx_noChannel => 'Wähle einen Kanal für die Warnungen.';

  @override
  String get botWx_channelGone => 'Der gewählte Kanal existiert nicht mehr.';

  @override
  String botWx_httpError(String code) {
    return 'Der Wetterdienst antwortete mit $code.';
  }

  @override
  String get botWx_unreachable => 'Wetterdienst nicht erreichbar.';

  @override
  String get botCmd_sun =>
      'Sonnenauf- und -untergang an der GPS-Position des Funkgeräts.';

  @override
  String get botCmd_moon => 'Mondphase und wie viel beleuchtet ist.';

  @override
  String get botCmd_weather =>
      'Aktuelles Wetter am Funkgerät (Open-Meteo). Sendet die Position, auf etwa 1 km gerundet.';

  @override
  String get botCmd_dice => 'Würfelt: !dice, !dice 20 oder !dice 2d6.';

  @override
  String get botCmd_trace => 'Listet die Repeater, über die die Nachricht kam.';

  @override
  String get ping_title => 'Repeater-Ping';

  @override
  String get ping_toolSubtitle =>
      'Umlaufzeit und Signal in beide Richtungen zu einem nahen Repeater';

  @override
  String get ping_noRepeaters => 'Noch keine Repeater bekannt';

  @override
  String get ping_choose => 'Repeater wählen';

  @override
  String get ping_avgMs => 'ms Umlauf';

  @override
  String get ping_snrThere => 'SNR dort';

  @override
  String get ping_snrBack => 'SNR zurück';

  @override
  String get ping_loss => 'Verloren';

  @override
  String ping_running(int done, int total) {
    return 'Ping $done von $total…';
  }

  @override
  String ping_start(int count) {
    return '$count-mal pingen';
  }

  @override
  String get ping_results => 'Proben';

  @override
  String get ping_noReply => 'Keine Antwort';

  @override
  String ping_resultLine(String ms, String snr) {
    return '$ms ms · SNR dort $snr';
  }

  @override
  String get ping_explainer =>
      'Jede Probe ist eine Pfadverfolgung über einen Hop: Der Repeater notiert, wie gut er dich gehört hat, und sendet es zurück. Funktioniert mit Repeatern, die dein Funkgerät direkt hört.';

  @override
  String get hunt_title => 'Antennensuche';

  @override
  String get hunt_toolSubtitle =>
      'Große Live-Signalanzeige, die schneller klickt, je stärker das Signal';

  @override
  String get hunt_noSignal => 'Noch kein Signal';

  @override
  String get hunt_noReply => 'Keine Antwort – bewege oder drehe die Antenne';

  @override
  String get hunt_heardHere => 'dB hier gehört';

  @override
  String get hunt_best => 'Bester';

  @override
  String get hunt_sound => 'Klicken, je stärker es wird';

  @override
  String get hunt_soundHint =>
      'Mit Vibration bei jedem Klick, damit du ohne Hinsehen ausrichten kannst.';

  @override
  String get hunt_stop => 'Stopp';

  @override
  String get hunt_start => 'Suche starten';

  @override
  String get hunt_explainer =>
      'Prüft den Repeater etwa einmal pro Sekunde. Richte eine Richtantenne aus oder geh herum: Die Zahl zeigt, wie gut dein Funkgerät ihn hört.';

  @override
  String get settings_refreshRate => 'Aktualisierungsrate';

  @override
  String get settings_refreshFast => 'Schnell';

  @override
  String get settings_refreshNormal => 'Normal';

  @override
  String get settings_refreshSlow => 'Langsam';

  @override
  String get settings_refreshFastHint =>
      'Akku jede Minute, GPS alle 30 s. Frischere Werte, mehr Akkuverbrauch.';

  @override
  String get settings_refreshNormalHint =>
      'Akku alle 2 Minuten, GPS jede Minute.';

  @override
  String get settings_refreshSlowHint =>
      'Akku alle 6 Minuten, GPS alle 3 Minuten. Spart Akku.';

  @override
  String get settings_refreshSaverOn =>
      'Der Akkusparmodus ist an und bestimmt das Tempo (Akku alle 10 Minuten).';

  @override
  String discovered_tray(int count) {
    return 'In der Nähe gehörte Kanäle: $count';
  }

  @override
  String get discovered_title => 'In der Nähe gehört, nicht beigetreten';

  @override
  String discovered_heard(int count, String time) {
    return '$count× gehört · zuletzt $time';
  }

  @override
  String get discovered_ignore => 'Ignorieren';

  @override
  String get discovered_ignoreAll => 'Alle ignorieren';

  @override
  String get discovered_joinAll => 'Allen beitreten';

  @override
  String get discovered_explainer =>
      'Das sind öffentliche Kanäle aus dem Kanalverzeichnis, auf denen dein Funkgerät Verkehr gehört hat. Jeder wurde durch Entschlüsseln einer Nachricht bestätigt. Ignorierte Kanäle bleiben ausgeblendet.';

  @override
  String get mqtt_presetMeshRank => 'MeshRank (Community)';

  @override
  String get mqtt_presetMeshRankNote =>
      'MeshRank ist eine von der Community betriebene MeshCore-Netzwerkrangliste, kein Teil von NOTORYX und nicht von ihm empfohlen. Ohne Anmeldung: Pakete werden unter dem Schlüssel und Regionscode deines Funkgeräts geteilt, erst wenn du das Teilen einschaltest.';

  @override
  String get pathFilter_title => 'Pfadbreiten-Filter';

  @override
  String get pathFilter_firmwareNote =>
      'Braucht Repeater-Firmware mit Weiterleitungsregeln (mikecarper/MeshCore). Die offizielle MeshCore-Firmware lehnt diese Befehle ab.';

  @override
  String get pathFilter_width => 'Pfadbreite';

  @override
  String get pathFilter_anyWidth => 'Jede Breite';

  @override
  String pathFilter_bytes(int n) {
    return '$n-Byte-Pfade';
  }

  @override
  String get pathFilter_twoOrMore => '2 oder 3 Byte (2+)';

  @override
  String get pathFilter_path => 'Gilt für';

  @override
  String get pathFilter_radio => 'Funk-Floods';

  @override
  String get pathFilter_bridge => 'Brücke';

  @override
  String get pathFilter_cross => 'Übergang';

  @override
  String get pathFilter_bridgeCross => 'Brücke und Übergang';

  @override
  String get pathFilter_limit => 'Begrenzen statt verwerfen';

  @override
  String get pathFilter_limitOn =>
      'Leitet bis zu einer festen Anzahl pro Minute weiter.';

  @override
  String get pathFilter_drop =>
      'Passende Floods werden verworfen, nicht weitergeleitet.';

  @override
  String get pathFilter_perMinute => 'Pro Minute';

  @override
  String get pathFilter_rateInvalid => 'Gib 1 bis 65534 ein.';

  @override
  String get pathFilter_reviewNote =>
      'Das füllt nur die Befehlszeile aus. Prüfe sie und tippe dann auf Senden. Mit „get fr“ siehst du vorher bestehende Regeln.';

  @override
  String get pathFilter_useCommand => 'Befehl übernehmen';

  @override
  String get settings_linkPreviews => 'Linkvorschauen';

  @override
  String get settings_linkPreviewsHint =>
      'Zeigt den Titel eines Links in einer Nachricht. Standardmäßig aus: Das Abrufen der Seite verrät der Website deine IP-Adresse.';

  @override
  String get guide_title => 'Feldhandbuch';

  @override
  String get guide_subtitle =>
      'Grundlagen, Akkus bei Kälte, Solar und Antennen';

  @override
  String get guide_secMesh => 'Ins Mesh kommen';

  @override
  String get guide_mesh1 =>
      'Dein Telefon spricht per Bluetooth, USB oder WLAN mit dem Funkgerät; das Funkgerät per LoRa mit dem Mesh. Nachrichten gehen auch ohne Mobilfunk.';

  @override
  String get guide_mesh2 =>
      'Repeater reichen Nachrichten weiter; jede Weitergabe ist ein Hop. Weniger Hops heißt schneller und zuverlässiger.';

  @override
  String get guide_mesh3 =>
      'Halte Nachrichten kurz und flute keine vollen Kanäle: Jede Nachricht nutzt gemeinsame Sendezeit.';

  @override
  String get guide_secCold => 'Akkus bei Kälte';

  @override
  String get guide_cold1 =>
      'Lade Lithium-Akkus nicht unter dem Gefrierpunkt (0 °C): Das schädigt sie dauerhaft.';

  @override
  String get guide_cold2 =>
      'Trag das Funkgerät in der Jacke. Kälte senkt die Kapazität, die zurückkommt, sobald der Akku warm ist.';

  @override
  String get guide_cold3 =>
      'Für feste Standorte in kaltem Klima kommt LiFePO4 besser zurecht als Lithium-Ionen; eine beheizte oder isolierte Box hilft beiden.';

  @override
  String get guide_secSolar => 'Solar für Repeater';

  @override
  String get guide_solar1 =>
      'Ein Repeater braucht sehr wenig Strom, doch plane Panel und Akku für deine dunkelste Winterwoche, nicht für einen Sommertag.';

  @override
  String get guide_solar2 =>
      'Richte das Panel zum Äquator aus und neige es im Winter steil; halte Schnee und Schatten fern.';

  @override
  String get guide_secAntenna => 'Antennen und Standort';

  @override
  String get guide_ant1 =>
      'Höhe schlägt Leistung: Ein Funkgerät ein paar Meter höher reicht viel weiter als eines auf dem Tisch.';

  @override
  String get guide_ant2 =>
      'Halte die Antenne senkrecht und fern von Metall und nutze eine für dein Band (z. B. 868 MHz in Europa).';

  @override
  String get guide_secMore => 'Mehr erfahren';

  @override
  String get guide_moreMeshcore => 'Das offizielle MeshCore-Projekt';

  @override
  String get guide_moreCascadia =>
      'Community-Anleitungen: Einstieg, Wardriving, Regionen, Solar';
}
