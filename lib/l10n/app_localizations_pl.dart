// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core';

  @override
  String get nav_contacts => 'Kontakty';

  @override
  String get nav_channels => 'Kanały';

  @override
  String get nav_map => 'Mapa';

  @override
  String get nav_messages => 'Wiadomości';

  @override
  String get nav_nodes => 'Węzły';

  @override
  String get nav_radio => 'Radio';

  @override
  String get messages_title => 'Wiadomości';

  @override
  String get messages_filterAll => 'Wszystkie';

  @override
  String get messages_filterDirect => 'Bezpośrednie';

  @override
  String get messages_filterChannels => 'Kanały';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'Szukaj wiadomości';

  @override
  String get messages_searchHint => 'Szukaj rozmów';

  @override
  String get messages_closeSearch => 'Zamknij wyszukiwanie';

  @override
  String get messages_manageChannels => 'Zarządzaj kanałami';

  @override
  String get messages_new => 'Nowa';

  @override
  String get messages_newDirect => 'Napisz do węzła';

  @override
  String get messages_newChannel => 'Dodaj kanał lub dołącz do niego';

  @override
  String get messages_empty => 'Brak rozmów';

  @override
  String get messages_emptyHint =>
      'Tutaj pojawiają się wiadomości od węzłów i z kanałów.';

  @override
  String get messages_noMatches => 'Żadna rozmowa nie pasuje do wyszukiwania';

  @override
  String messages_you(String text) {
    return 'Ty: $text';
  }

  @override
  String get messages_yesterday => 'Wczoraj';

  @override
  String messages_unreadCount(int count) {
    return 'Nieprzeczytane: $count';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return 'Połączono przez $transport';
  }

  @override
  String get radioStatus_bluetooth => 'Bluetooth';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'Wi‑Fi (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return 'Bateria $percent%';
  }

  @override
  String get radioStatus_openRadio => 'Otwórz szczegóły radia';

  @override
  String get radioOverview_battery => 'Bateria';

  @override
  String radioOverview_firmware(String version) {
    return 'Firmware $version';
  }

  @override
  String get radioOverview_sendAdvert => 'Wyślij ogłoszenie';

  @override
  String get radioOverview_stats => 'Statystyki radia';

  @override
  String get accessControl_title => 'Kontrola dostępu';

  @override
  String get accessControl_hubSubtitle => 'Kto może logować się bez hasła';

  @override
  String get accessControl_explainRepeater =>
      'Osoby z tej listy logują się bez hasła. Administratorzy mogą zmieniać ustawienia; Tylko odczyt oraz Odczyt i zapis otrzymują też pełną telemetrię.';

  @override
  String get accessControl_explainRoom =>
      'Administratorzy z tej listy logują się bez hasła i mogą zarządzać pokojem. Członkowie pokoju dołączają za pomocą hasła pokoju.';

  @override
  String get accessControl_roleReadOnly => 'Tylko odczyt';

  @override
  String get accessControl_roleReadWrite => 'Odczyt i zapis';

  @override
  String get accessControl_roleAdmin => 'Administrator';

  @override
  String get accessControl_you => 'Ty';

  @override
  String get accessControl_unknownNode => 'Nieznany węzeł';

  @override
  String get accessControl_add => 'Dodaj';

  @override
  String get accessControl_addTitle => 'Dodaj do listy dostępu';

  @override
  String get accessControl_pickContact => 'Wybierz kontakt';

  @override
  String get accessControl_noContacts =>
      'Brak kontaktów do dodania. Węzły pojawiają się tutaj, gdy odbierzesz ich ogłoszenie.';

  @override
  String get accessControl_changeRole => 'Zmień rolę';

  @override
  String get accessControl_remove => 'Odbierz dostęp';

  @override
  String accessControl_removeConfirm(String name) {
    return 'Usunąć $name z listy dostępu? Do logowania będzie potrzebne hasło.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'To Ty. Jeśli usuniesz siebie, do ponownego zarządzania tym węzłem będzie potrzebne hasło administratora.';

  @override
  String get accessControl_unknownKeyNote =>
      'Spoza Twoich kontaktów. Zmiana roli wymaga nowszego firmware węzła; usunięcie działa zawsze.';

  @override
  String get accessControl_prefixUnsupported =>
      'Firmware tego węzła nie może zmienić roli kogoś spoza Twoich kontaktów. Nadal możesz go usunąć.';

  @override
  String get accessControl_empty => 'Lista dostępu jest pusta';

  @override
  String get accessControl_emptyHint =>
      'Dodaj osoby, aby mogły logować się bez hasła.';

  @override
  String get accessControl_loading => 'Pobieranie listy dostępu z węzła…';

  @override
  String get accessControl_timeout =>
      'Węzeł nie odpowiedział. Sprawdź trasę i spróbuj ponownie.';

  @override
  String get accessControl_maybeIncomplete =>
      'Ten węzeł wysłał jedną pełną stronę, a jego firmware nie może wysłać więcej, więc może brakować niektórych wpisów.';

  @override
  String get accessControl_saved => 'Zaktualizowano listę dostępu';

  @override
  String accessControl_failed(String reply) {
    return 'Węzeł odrzucił zmianę: $reply';
  }

  @override
  String get companionCli_title => 'Wiersz poleceń';

  @override
  String get companionCli_tileSubtitle => 'Wykonuj polecenia na radiu';

  @override
  String get companionCli_warning =>
      'Polecenia są wykonywane na połączonym radiu i mogą zmienić jego ustawienia lub je zrestartować.';

  @override
  String get companionCli_hint => 'Wpisz polecenie, np. ver';

  @override
  String get companionCli_send => 'Wykonaj polecenie';

  @override
  String get companionCli_noReply =>
      'Brak odpowiedzi. Radio może się uruchamiać ponownie.';

  @override
  String get companionCli_empty =>
      'Wypróbuj jedno z powyższych poleceń lub wpisz własne.';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle => 'Połącz radio z siecią Wi‑Fi';

  @override
  String get wifi_unsupported => 'Firmware tego radia nie obsługuje Wi‑Fi.';

  @override
  String get wifi_enabled => 'Używaj Wi‑Fi';

  @override
  String get wifi_status => 'Stan';

  @override
  String get wifi_connected => 'Połączono';

  @override
  String wifi_connectedIp(String ip) {
    return 'Połączono · $ip';
  }

  @override
  String get wifi_disconnected => 'Nie połączono';

  @override
  String get wifi_network => 'Nazwa sieci (SSID)';

  @override
  String get wifi_password => 'Hasło';

  @override
  String get wifi_passwordKeep => 'Zostaw puste, aby zachować obecne hasło';

  @override
  String get wifi_save => 'Zapisz';

  @override
  String get wifi_forget => 'Zapomnij sieć';

  @override
  String get wifi_forgetConfirm => 'Usunąć z radia zapisaną sieć i hasło?';

  @override
  String get wifi_rebootNeeded =>
      'Zapisano. Zrestartuj radio, aby zastosować zmiany Wi‑Fi.';

  @override
  String get wifi_rebootNow => 'Zrestartuj radio';

  @override
  String get wifi_rebootConfirm =>
      'Zrestartować radio teraz? Aplikacja się rozłączy i trzeba będzie połączyć się ponownie.';

  @override
  String get wifi_loadFailed =>
      'Nie udało się odczytać ustawień Wi‑Fi z radia.';

  @override
  String get wifi_retry => 'Spróbuj ponownie';

  @override
  String wifi_saveFailed(String reply) {
    return 'Radio nie przyjęło zmiany: $reply';
  }

  @override
  String get accessControl_refresh => 'Odśwież';

  @override
  String get common_cancel => 'Anuluj';

  @override
  String get common_ok => 'Dobrze';

  @override
  String get common_connect => 'Połącz';

  @override
  String get common_unknownDevice => 'Nieznane urządzenie';

  @override
  String get common_save => 'Zapisz';

  @override
  String get common_delete => 'Usuń';

  @override
  String get common_deleteAll => 'Usuń wszystko';

  @override
  String get common_close => 'Zamknij';

  @override
  String get common_done => 'Done';

  @override
  String get common_edit => 'Edytuj';

  @override
  String get common_add => 'Dodaj';

  @override
  String get common_settings => 'Ustawienia';

  @override
  String get common_disconnect => 'Odłącz';

  @override
  String get common_connected => 'Połączono';

  @override
  String get common_disconnected => 'Odłączony';

  @override
  String get common_create => 'Utwórz';

  @override
  String get common_continue => 'Kontynuuj';

  @override
  String get common_share => 'Udostępnij';

  @override
  String get common_copy => 'Kopiuj';

  @override
  String get common_retry => 'Ponów';

  @override
  String get common_hide => 'Ukryj';

  @override
  String get common_remove => 'Usuń';

  @override
  String get common_enable => 'Włącz';

  @override
  String get common_disable => 'Wyłącz';

  @override
  String get common_undo => 'Wycofaj';

  @override
  String get messageStatus_sent => 'Wysłane';

  @override
  String get messageStatus_delivered => 'Dostarczone';

  @override
  String get messageStatus_pending => 'Wysyłanie';

  @override
  String get messageStatus_failed => 'Nie udało się wysłać';

  @override
  String get messageStatus_repeated => 'Usłyszałem to wielokrotnie';

  @override
  String get urlImage_enable => 'Włącz obrazy z URL';

  @override
  String get urlImage_possible =>
      'Możliwy obraz z URL; włącz to w Ustawieniach.';

  @override
  String get common_reboot => 'Uruchom ponownie';

  @override
  String get common_loading => 'Ładowanie...';

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
  String get common_autoRefresh => 'Automatyczne odświeżanie';

  @override
  String get common_interval => 'Interwał';

  @override
  String get scanner_title => 'MeshCore – wersja open source';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'Połącz się za pomocą protokołu TCP';

  @override
  String get tcpHostLabel => 'Adres IP';

  @override
  String get tcpHostHint => '192.168.40.10';

  @override
  String get tcpPortLabel => 'Port';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => 'Wprowadź adres URL i połącz';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return 'Połączenie z $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => 'Wymagana jest adresa IP.';

  @override
  String get tcpErrorPortInvalid =>
      'Numer portu musi mieścić się w zakresie od 1 do 65535.';

  @override
  String get tcpErrorUnsupported =>
      'Transport TCP nie jest obsługiwany na tej platformie.';

  @override
  String get tcpErrorTimedOut =>
      'Połączenie TCP zakończyło się bez powodzenia.';

  @override
  String tcpConnectionFailed(String error) {
    return 'Błąd połączenia TCP: $error';
  }

  @override
  String get usbScreenTitle => 'Połącz przez USB';

  @override
  String get usbScreenSubtitle =>
      'Wybierz wykryte urządzenie szeregowe i połącz się bezpośrednio ze swoim węzłem MeshCore.';

  @override
  String get usbScreenStatus => 'Wybierz urządzenie USB';

  @override
  String get usbScreenNote =>
      'Port szeregowy USB jest aktywny na urządzeniach z systemem Android i platformach stacjonarnych, które go obsługują.';

  @override
  String get usbScreenEmptyState =>
      'Nie znaleziono żadnych urządzeń USB. Podłącz jedno i zaktualizuj.';

  @override
  String get usbErrorPermissionDenied =>
      'Zostało odrzucone żądanie dostępu przez USB.';

  @override
  String get usbErrorDeviceMissing =>
      'Wybór urządzenia USB już nie jest dostępny.';

  @override
  String get usbErrorInvalidPort => 'Wybierz prawidłowe urządzenie USB.';

  @override
  String get usbErrorBusy =>
      'Kolejne żądanie połączenia przez USB jest już w trakcie realizacji.';

  @override
  String get usbErrorNotConnected => 'Brak podłączonego urządzenia USB.';

  @override
  String get usbErrorOpenFailed =>
      'Nie udało się otworzyć wybranego urządzenia USB.';

  @override
  String get usbErrorConnectFailed =>
      'Nie udało się połączyć z wybranym urządzeniem USB.';

  @override
  String get usbErrorUnsupported =>
      'Port szeregowy USB nie jest obsługiwany na tym urządzeniu.';

  @override
  String get usbErrorAlreadyActive => 'Połączenie USB jest już aktywne.';

  @override
  String get usbErrorNoDeviceSelected =>
      'Nie został wybrany żaden urządzenie USB.';

  @override
  String get usbErrorPortClosed => 'Połączenie USB nie jest aktywne.';

  @override
  String get usbErrorConnectTimedOut =>
      'Połączenie nie zostało nawiązane. Upewnij się, że urządzenie posiada oprogramowanie \"USB Companion\".';

  @override
  String get usbFallbackDeviceName =>
      'Urządzenie do komunikacji przez sieć (seria)';

  @override
  String get usbStatus_notConnected => 'Wybierz urządzenie USB';

  @override
  String get usbStatus_connecting => 'Połączenie z urządzeniem USB...';

  @override
  String get usbStatus_searching => 'Wyszukiwanie urządzeń USB...';

  @override
  String usbConnectionFailed(String error) {
    return 'Błąd połączenia USB: $error';
  }

  @override
  String get scanner_scanning => 'Skanowanie urządzeń...';

  @override
  String get scanner_connecting => 'Łączenie...';

  @override
  String get scanner_disconnecting => 'Odłączanie...';

  @override
  String get scanner_notConnected => 'Nie połączono';

  @override
  String scanner_connectedTo(String deviceName) {
    return 'Połączono z $deviceName';
  }

  @override
  String get scanner_searchingDevices => 'Wyszukiwanie urządzeń MeshCore...';

  @override
  String get scanner_tapToScan =>
      'Naciśnij Skan, aby znaleźć urządzenia MeshCore';

  @override
  String scanner_connectionFailed(String error) {
    return 'Połączenie nieudane: $error';
  }

  @override
  String get scanner_stop => 'Zatrzymaj';

  @override
  String get scanner_scan => 'Przeskanuj';

  @override
  String get scanner_bluetoothOff => 'Bluetooth jest wyłączony';

  @override
  String get scanner_bluetoothOffMessage =>
      'Prosimy włączyć Bluetooth, aby przeskanować urządzenia.';

  @override
  String get scanner_chromeRequired => 'Wymagana przeglądarka Chrome';

  @override
  String get scanner_chromeRequiredMessage =>
      'Ta aplikacja internetowa wymaga przeglądarki Google Chrome lub opartej na Chromium do obsługi Bluetooth.';

  @override
  String get scanner_enableBluetooth => 'Włącz Bluetooth';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'Bluetooth nie jest dostępny w przeglądarce. Połącz się przez USB.';

  @override
  String get device_quickSwitch => 'Szybka zmiana';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => 'Ustawienia';

  @override
  String get settings_deviceInfo => 'Informacje o urządzeniu';

  @override
  String get settings_appSettings => 'Ustawienia aplikacji';

  @override
  String get settings_appSettingsSubtitle =>
      'Powiadomienia, wiadomości i preferencje mapy';

  @override
  String get settings_nodeSettings => 'Ustawienia węzła';

  @override
  String get settings_nodeName => 'Nazwa węzła';

  @override
  String get settings_nodeNameNotSet => 'Nie ustawione';

  @override
  String get settings_nodeNameHint => 'Wprowadź nazwę węzła';

  @override
  String get settings_nodeNameUpdated => 'Nazwa zaktualizowana';

  @override
  String get settings_radioSettings => 'Ustawienia radia';

  @override
  String get settings_radioSettingsSubtitle =>
      'Częstotliwość, moc, współczynnik rozpraszania';

  @override
  String get settings_radioSettingsUpdated =>
      'Ustawienia radia zostały zaktualizowane';

  @override
  String get settings_regionSettings => 'Regiony';

  @override
  String get settings_regionSettingsSubtitle =>
      'Zarządzanie zapisanymi regionami';

  @override
  String get settings_corridorRegion => 'Region korytarza';

  @override
  String get settings_corridorRegionDefault => '#corridor (domyślny)';

  @override
  String get settings_corridorRegionHelp =>
      'Pakiety korytarza flood są oznaczane tym regionem. Przekaźniki bez firmware korytarza przekazują je tylko wtedy, gdy zezwalają na ten region. Zostaw puste dla domyślnego tagu #corridor.';

  @override
  String get settings_corridorRegionHint => 'Nazwa regionu';

  @override
  String get settings_corridorRegionUseDefault => 'Użyj domyślnego';

  @override
  String get settings_corridorRegionUpdated =>
      'Zaktualizowano region korytarza';

  @override
  String get settings_corridorRegionFailed =>
      'Nie udało się zaktualizować regionu korytarza';

  @override
  String get settings_regionManagement_screenTitle => 'Zarządzanie Regionami';

  @override
  String get settings_regionNameHint => 'Wprowadź nazwę regionu';

  @override
  String get settings_regionAddRegion => 'Dodaj region';

  @override
  String get settings_regionFetchRegions => 'Pobierz regiony z repeaterów';

  @override
  String get settings_regionFetchRegionsFail =>
      'Nie znaleziono żadnych regionów';

  @override
  String get settings_regionFetchRegionsAlreadyExists =>
      'Ten region został już dodany';

  @override
  String get settings_regionName => 'Nazwa Regionu';

  @override
  String get settings_regionDeleted => 'Region usunięto';

  @override
  String get settings_deleteRegion => 'Usuń Region';

  @override
  String settings_deleteRegionConfirm(String region) {
    return 'Czy usunąć \"$region\" z listy regionów?';
  }

  @override
  String get settings_location => 'Lokalizacja';

  @override
  String get settings_locationSubtitle => 'Koordynaty GPS';

  @override
  String get settings_locationUpdated => 'Lokalizacja zaktualizowana';

  @override
  String get settings_locationBothRequired =>
      'Wprowadź zarówno szerokość, jak i długość geograficzną.';

  @override
  String get settings_locationInvalid =>
      'Nieprawidłowa szerokość geograficzna lub długość geograficzna.';

  @override
  String get settings_locationGPSEnable => 'Włącz GPS';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'Włącza automatyczne aktualizowanie pozycji za pomocą GPS.';

  @override
  String get settings_locationIntervalSec => 'Interwał dla GPS (Sekundy)';

  @override
  String get settings_locationIntervalInvalid =>
      'Interwał musi wynosić co najmniej 60 sekund i mniej niż 86400 sekund.';

  @override
  String get settings_latitude => 'Szerokość';

  @override
  String get settings_longitude => 'Długość';

  @override
  String get settings_contactSettings => 'Ustawienia kontaktów';

  @override
  String get settings_contactSettingsSubtitle =>
      'Ustawienia dotyczące sposobu dodawania kontaktów';

  @override
  String get settings_privacyMode => 'Tryb prywatności';

  @override
  String get settings_privacyModeSubtitle =>
      'Ukryj imię/lokalizację w rozgłoszeniach';

  @override
  String get settings_privacyModeToggle =>
      'Włącz tryb prywatności, aby ukryć swoje imię i lokalizację w rozgłoszeniach.';

  @override
  String get settings_privacyModeEnabled => 'Tryb prywatności włączony';

  @override
  String get settings_privacyModeDisabled => 'Tryb prywatności wyłączony';

  @override
  String get settings_privacy => 'Ustawienia prywatności';

  @override
  String get settings_privacySubtitle =>
      'Kontroluj jakie informacje są udostępniane.';

  @override
  String get settings_privacySettingsDescription =>
      'Wybierz jakie informacje urządzenie udostępni innym.';

  @override
  String get settings_denyAll => 'Odmów wszystkim';

  @override
  String get settings_allowByContact => 'Zezwalaj według flag kontaktowych';

  @override
  String get settings_allowAll => 'Zezwalaj na wszystko';

  @override
  String get settings_telemetryBaseMode => 'Tryb podstawowy telemetrii';

  @override
  String get settings_telemetryLocationMode => 'Tryb położenia telemetrycznego';

  @override
  String get settings_telemetryEnvironmentMode =>
      'Tryb środowiska telemetrycznego';

  @override
  String get settings_advertLocation => 'Lokalizacja reklamowa';

  @override
  String get settings_advertLocationSubtitle =>
      'Uwzględnij lokalizację w ogłoszeniu';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'Automatyczne ogłoszenie zero-hop przy aktualizacji GPS';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'Gdy lokalizacja GPS się zmieni, wyślij ogłoszenie zero-hop (wymaga lokalizacji w ogłoszeniu).';

  @override
  String get settings_multiAck => 'Wielokrotne potwierdzenia odbioru';

  @override
  String get settings_telemetryModeUpdated =>
      'Tryb telemetryczny zaktualizowany';

  @override
  String get settings_actions => 'Działania';

  @override
  String get settings_deleteAllPaths => 'Delete All Paths';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Clear all path data from contacts.';

  @override
  String get settings_sendAdvertisement => 'Wyślij rozgłoszenie';

  @override
  String get settings_sendAdvertisementSubtitle => 'Nadaj obecność teraz';

  @override
  String get settings_advertisementSent => 'Rozgłoszenie wysłane';

  @override
  String get settings_syncTime => 'Synchronizacja czasu';

  @override
  String get settings_syncTimeSubtitle =>
      'Ustaw zegar urządzenia na czas telefonu.';

  @override
  String get settings_timeSynchronized => 'Czas zsynchronizowany';

  @override
  String get settings_refreshContacts => 'Odśwież Kontakty';

  @override
  String get settings_refreshContactsSubtitle =>
      'Odśwież listę kontaktów z urządzenia';

  @override
  String get settings_rebootDevice => 'Zrestartuj Urządzenie';

  @override
  String get settings_rebootDeviceSubtitle => 'Zrestartuj urządzenie MeshCore';

  @override
  String get settings_rebootDeviceConfirm =>
      'Czy na pewno chcesz zrestartować urządzenie? Będziesz odłączony.';

  @override
  String get settings_debug => 'Naprawianie błędów';

  @override
  String get settings_companionDebugLog =>
      'Log debugowania (dla pomocy w rozwiązywaniu problemów)';

  @override
  String get settings_companionDebugLogSubtitle =>
      'Polecenia, odpowiedzi i surowe dane związane z protokołami BLE/TCP/USB';

  @override
  String get settings_appDebugLog => 'Dziennik debugowania aplikacji';

  @override
  String get settings_appDebugLogSubtitle => 'Komunikaty debugowania aplikacji';

  @override
  String get settings_about => 'O aplikacji';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core w wersji $version';
  }

  @override
  String get settings_aboutLegalese => 'Projekt MeshCore Open Source 2026';

  @override
  String get settings_aboutDescription =>
      'Otwartoźródłowy klient Flutter dla urządzeń MeshCore LoRa do sieci mesh.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'Dane wysokościowe LOS: Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => 'Nazwa';

  @override
  String get settings_infoId => 'ID';

  @override
  String get settings_infoStatus => 'Stan';

  @override
  String get settings_infoBattery => 'Bateria';

  @override
  String get settings_infoPublicKey => 'Klucz Publiczny';

  @override
  String get settings_infoContactsCount => 'Liczba kontaktów';

  @override
  String get settings_infoChannelCount => 'Liczba kanałów';

  @override
  String get settings_infoHardware => 'Sprzęt';

  @override
  String get settings_infoFirmware => 'Oprogramowanie wbudowane';

  @override
  String get settings_presets => 'Presety';

  @override
  String get settings_frequency => 'Częstotliwość (MHz)';

  @override
  String get settings_frequencyHelper => '300,0 - 2500,0';

  @override
  String get settings_frequencyInvalid =>
      'Nieprawidłowa częstotliwość (300-2500 MHz)';

  @override
  String get settings_bandwidth => 'Przepustowość';

  @override
  String get settings_spreadingFactor => 'Współczynnik rozpraszania';

  @override
  String get settings_codingRate => 'Współczynnik kodowania';

  @override
  String get settings_txPower => 'Moc TX (dBm)';

  @override
  String get settings_txPowerHelper => '0 – 22';

  @override
  String get settings_txPowerInvalid => 'Nieprawidłowa moc TX (0-22 dBm)';

  @override
  String get settings_clientRepeat => 'Powtórzenie: Niezależne od sieci';

  @override
  String get settings_clientRepeatSubtitle =>
      'Pozwól temu urządzeniu powtarzać pakiety danych dla innych urządzeń.';

  @override
  String get settings_clientRepeatFreqWarning =>
      'Powtórka poza siecią wymaga częstotliwości 433, 869 lub 918 MHz.';

  @override
  String settings_error(String message) {
    return 'Błąd: $message';
  }

  @override
  String get appSettings_title => 'Ustawienia aplikacji';

  @override
  String get appSettings_appearance => 'Wygląd';

  @override
  String get appSettings_theme => 'Motyw';

  @override
  String get appSettings_themeSystem => 'Domyślne ustawienia systemu';

  @override
  String get appSettings_themeLight => 'Jasne';

  @override
  String get appSettings_themeDark => 'Ciemny';

  @override
  String get appSettings_language => 'Język';

  @override
  String get appSettings_languageSystem => 'Domyślny systemowy';

  @override
  String get appSettings_languageEn => 'Angielski';

  @override
  String get appSettings_languageFr => 'Francuski';

  @override
  String get appSettings_languageEs => 'Hiszpański';

  @override
  String get appSettings_languageDe => 'Niemiecki';

  @override
  String get appSettings_languagePl => 'Polski';

  @override
  String get appSettings_languageSl => 'Słoweński';

  @override
  String get appSettings_languagePt => 'Portugalski';

  @override
  String get appSettings_languageIt => 'Włoski';

  @override
  String get appSettings_languageZh => 'Chiński';

  @override
  String get appSettings_languageSv => 'Szwedzki';

  @override
  String get appSettings_languageNl => 'Niderlandzki';

  @override
  String get appSettings_languageSk => 'Słoweniština';

  @override
  String get appSettings_languageBg => 'Българский';

  @override
  String get appSettings_languageRu => 'Rosyjski';

  @override
  String get appSettings_languageUk => 'Ukraińska';

  @override
  String get repeater_pathHashModeOption0 => '0 - 1 bajt';

  @override
  String get repeater_pathHashModeOption1 => '1 - 2 bity';

  @override
  String get repeater_pathHashModeOption2 => '2 - 3 bajty';

  @override
  String get repeater_pathHashModeOption3 => '3 - 4 bajty';

  @override
  String get appSettings_enableMessageTracing => 'Włącz śledzenie wiadomości';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'Pokaż szczegółowe metadane trasowania i czasu dla wiadomości';

  @override
  String get appSettings_notifications => 'Powiadomienia';

  @override
  String get appSettings_enableNotifications => 'Włącz Powiadomienia';

  @override
  String get appSettings_enableNotificationsSubtitle =>
      'Otrzymuj powiadomienia o wiadomościach i rozgłoszeniach.';

  @override
  String get appSettings_notificationPermissionDenied =>
      'Odmowa zezwolenia na powiadomienia';

  @override
  String get appSettings_notificationsEnabled => 'Powiadomienia włączone';

  @override
  String get appSettings_notificationsDisabled => 'Powiadomienia wyłączone';

  @override
  String get appSettings_messageNotifications =>
      'Powiadomienia o wiadomościach';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      'Pokaż powiadomienie przy otrzymywaniu nowych wiadomości';

  @override
  String get appSettings_channelMessageNotifications =>
      'Powiadomienia o Wiadomościach na Kanałach';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'Pokaż powiadomienie przy odbieraniu wiadomości z kanału';

  @override
  String get appSettings_advertisementNotifications =>
      'Powiadomienia o rozgłoszeniach';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      'Wyświetl powiadomienie, gdy zostaną wykryte nowe węzły.';

  @override
  String get appSettings_messaging => 'Wiadomości';

  @override
  String get appSettings_clearPathOnMaxRetry =>
      'Wyczyść ścieżkę po maks. liczbie prób';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      'Resetuj ścieżkę kontaktu po 5 nieudanych próbach wysłania';

  @override
  String get appSettings_pathsWillBeCleared =>
      'Ścieżka zostanie wyczyszczona po 5 nieudanych próbach.';

  @override
  String get appSettings_pathsWillNotBeCleared =>
      'Ścieżka nie zostanie automatycznie wyczyszczona.';

  @override
  String get appSettings_autoRouteRotation => 'Automatyczna rotacja trasy';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      'Przełączaj się między najlepszymi ścieżkami a trybem zalewowym.';

  @override
  String get appSettings_autoRouteRotationEnabled =>
      'Automatyczne obracanie tras włączone';

  @override
  String get appSettings_autoRouteRotationDisabled =>
      'Automatyczne obracanie tras wyłączone';

  @override
  String get appSettings_maxRouteWeight =>
      'Maksymalny dopuszczalny ciężar pojazdu';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      'Maksymalna waga, jaką ścieżka może zgromadzić dzięki udanym dostawom.';

  @override
  String get appSettings_initialRouteWeight => 'Początkowa waga trasy';

  @override
  String get appSettings_initialRouteWeightSubtitle =>
      'Początkowa waga dla nowych, odkrytych ścieżek';

  @override
  String get appSettings_routeWeightSuccessIncrement => 'Wzrost wagi sukcesu';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      'Waga dodana do ścieżki po pomyślnym dostarczeniu';

  @override
  String get appSettings_routeWeightFailureDecrement =>
      'Zmniejszenie wagi kary';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      'Waga usunięta z trasy po nieudanej dostawie';

  @override
  String get appSettings_maxMessageRetries =>
      'Maksymalna liczba prób wysłania wiadomości';

  @override
  String get appSettings_maxMessageRetriesSubtitle =>
      'Liczba prób ponownego wysłania wiadomości przed oznaczaniem jej jako nieudanej';

  @override
  String get appSettings_battery => 'Bateria';

  @override
  String get appSettings_batteryChemistry => 'Chemia Baterii';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return 'Ustaw dla urządzenia ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      'Połącz się z urządzeniem, aby wybrać';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3,0-4,2V)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2,6-3,65 V)';

  @override
  String get appSettings_batteryLipo => 'LiPo (3,0-4,2V)';

  @override
  String get appSettings_batteryLipoHv => 'Bateria LiPo HV (3,0-4,35 V)';

  @override
  String get appSettings_mapDisplay => 'Wyświetlanie mapy';

  @override
  String get appSettings_showRepeaters => 'Pokaż przekaźniki';

  @override
  String get appSettings_showRepeatersSubtitle =>
      'Wyświetl węzły przekaźników na mapie';

  @override
  String get appSettings_showChatNodes => 'Pokaż Węzły Rozmowy';

  @override
  String get appSettings_showChatNodesSubtitle =>
      'Wyświetl węzły czatu na mapie';

  @override
  String get appSettings_showOtherNodes => 'Pokaż inne węzły';

  @override
  String get appSettings_showOtherNodesSubtitle =>
      'Wyświetl inne typy węzłów na mapie';

  @override
  String get appSettings_timeFilter => 'Filtrowanie Czasu';

  @override
  String get appSettings_timeFilterShowAll => 'Pokaż wszystkie węzły';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return 'Pokaż węzły z ostatnich $hours godzin';
  }

  @override
  String get appSettings_mapTimeFilter => 'Filtr czasu mapy';

  @override
  String get appSettings_showNodesDiscoveredWithin => 'Pokaż węzły odkryte w:';

  @override
  String get appSettings_allTime => 'Cały czas';

  @override
  String get appSettings_lastHour => 'Ostatnia godzina';

  @override
  String get appSettings_last6Hours => 'Ostatnie 6 godzin';

  @override
  String get appSettings_last24Hours => 'Ostatnie 24 godziny';

  @override
  String get appSettings_lastWeek => 'Ostatni tydzień';

  @override
  String get appSettings_rasterTileSource => 'Źródło kafelków rastrowych';

  @override
  String get appSettings_stadiaEndpoint => 'Punkt końcowy Stadia';

  @override
  String get appSettings_stadiaApiKey => 'Klucz API Stadia';

  @override
  String get appSettings_stadiaApiKeyRequired =>
      'Wymagane do korzystania ze Stadia Maps';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return 'Skonfigurowano: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Wprowadź swój klucz API Stadia Maps. Aplikacja używa go do żądań kafelków rastrowych.';

  @override
  String get appSettings_offlineMapCache => 'Pamięć podręczna map offline';

  @override
  String get appSettings_unitsTitle => 'Jednostki';

  @override
  String get appSettings_unitsMetric => 'Metryczne (m / km)';

  @override
  String get appSettings_unitsImperial => 'Imperialne (ft / mi)';

  @override
  String get appSettings_noAreaSelected => 'Nie wybrano żadnego obszaru.';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'Wybrany obszar (skala $minZoom-$maxZoom)';
  }

  @override
  String get appSettings_debugCard => 'Naprawianie błędów';

  @override
  String get appSettings_appDebugLogging => 'Logowanie Debugowania Aplikacji';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'Rejestruj komunikaty debugowania aplikacji w celu diagnozowania problemów.';

  @override
  String get appSettings_appDebugLoggingEnabled =>
      'Logowanie debugowania aplikacji włączone';

  @override
  String get appSettings_appDebugLoggingDisabled =>
      'Logowanie debugowania aplikacji wyłączone.';

  @override
  String get contacts_title => 'Kontakty';

  @override
  String get contacts_noContacts => 'Brak jeszcze kontaktów.';

  @override
  String get contacts_contactsWillAppear =>
      'Kontakty będą wyświetlane, gdy urządzenia nadają rozgłoszenia.';

  @override
  String get contacts_unread => 'Nieprzeczytane';

  @override
  String get contacts_searchContactsNoNumber => 'Wyszukaj kontakty...';

  @override
  String contacts_searchContacts(int number, String str) {
    String _temp0 = intl.Intl.pluralLogic(
      number,
      locale: localeName,
      other: 'kontaktu',
      many: 'kontaktów',
      few: 'kontakty',
      one: 'kontakt',
    );
    return 'Wyszukaj $number$str $_temp0...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'Wyszukaj $number$str ulubione...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'Wyszukaj $number$str Użytkowników...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'Wyszukaj $number$str przekaźników...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'Wyszukaj $number$str serwerów Room...';
  }

  @override
  String get contacts_noUnreadContacts => 'Brak nieprzeczytanych kontaktów';

  @override
  String get contacts_noContactsFound =>
      'Brak znalezionych kontaktów ani grup.';

  @override
  String get contacts_deleteContact => 'Usuń Kontakt';

  @override
  String contacts_removeConfirm(String contactName) {
    return 'Usunąć $contactName z kontaktów?';
  }

  @override
  String get contacts_manageRepeater => 'Zarządzaj przekaźnikiem';

  @override
  String get contacts_manageRoom => 'Zarządzaj Serwerem Pokoju';

  @override
  String get contacts_roomLogin => 'Logowanie do pokoju';

  @override
  String get contacts_openChat => 'Otwórz czat';

  @override
  String get contacts_editGroup => 'Edytuj Grupę';

  @override
  String get contacts_deleteGroup => 'Usuń Grupę';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return 'Usuń \"$groupName\"?';
  }

  @override
  String get contacts_newGroup => 'Nowa Grupa';

  @override
  String get contacts_moreOptions => 'Więcej opcji';

  @override
  String get contacts_searchOpen => 'Wyszukaj kontakty';

  @override
  String get contacts_searchClose => 'Zaawansowane wyszukiwanie';

  @override
  String get contacts_groupName => 'Nazwa grupy';

  @override
  String get contacts_groupNameRequired => 'Nazwa grupy jest wymagana';

  @override
  String get contacts_groupNameReserved => 'Ta nazwa grupy jest zastrzeżona';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'Grupa \"$name\" już istnieje';
  }

  @override
  String get contacts_filterContacts => 'Filtruj kontakty...';

  @override
  String get contacts_noContactsMatchFilter =>
      'Brak pasujących kontaktów do Twojego filtra';

  @override
  String get contacts_noMembers => 'Brak członków';

  @override
  String get contacts_lastSeenNow => 'niedawno';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return '~ $minutes min';
  }

  @override
  String get contacts_lastSeenHourAgo => '~ 1 godz.';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return '~ $hours godz.';
  }

  @override
  String get contacts_lastSeenDayAgo => '~ 1 dzień';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return '~ $days dni';
  }

  @override
  String get contact_info => 'Informacje kontaktowe';

  @override
  String get contact_settings => 'Ustawienia kontaktowe';

  @override
  String get contact_telemetry => 'Telemetryka';

  @override
  String get contact_lastSeen => 'Ostatnio widziany';

  @override
  String get contact_clearChat => 'Wyczyść czat';

  @override
  String get contact_teleBase => 'Baza telemetryczna';

  @override
  String get contact_teleBaseSubtitle =>
      'Pozwól na udostępnianie poziomu naładowania baterii i podstawowych danych telemetrycznych';

  @override
  String get contact_teleLoc => 'Lokalizacja telemetryczna';

  @override
  String get contact_teleLocSubtitle =>
      'Zezwalaj na udostępnianie danych lokalizacji';

  @override
  String get contact_teleEnv => 'Środowisko telemetryczne';

  @override
  String get contact_teleEnvSubtitle =>
      'Zezwalaj na udostępnianie danych czujników środowiskowych';

  @override
  String get channels_title => 'Kanały';

  @override
  String get channels_noChannelsConfigured => 'Brak skonfigurowanych kanałów';

  @override
  String get channels_addPublicChannel => 'Dodaj kanał publiczny';

  @override
  String get channels_searchChannels => 'Wyszukaj kanały...';

  @override
  String get channels_noChannelsFound => 'Brak znalezionych kanałów';

  @override
  String channels_channelIndex(int index) {
    return 'Kanał $index';
  }

  @override
  String get channels_public => 'Publiczny';

  @override
  String channels_via(String path) {
    return 'via $path';
  }

  @override
  String get channels_viaMqtt => 'przez MQTT';

  @override
  String get channels_viaMqttSemantics =>
      'Odebrano przez MQTT, nie odebrane przez Twoje radio';

  @override
  String get channels_private => 'Prywatny';

  @override
  String get channels_editChannel => 'Edytuj kanał';

  @override
  String get channels_muteChannel => 'Wycisz kanał';

  @override
  String get channels_unmuteChannel => 'Wyłącz wyciszenie kanału';

  @override
  String get channels_deleteChannel => 'Usuń kanał';

  @override
  String channels_deleteChannelConfirm(String name) {
    return 'Usuń \"$name\"? Nie można tego cofnąć.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'Nie udało się usunąć kanału \"$name\"';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'Kanał \"$name\" usunięto';
  }

  @override
  String get channels_addChannel => 'Dodaj Kanał';

  @override
  String get channels_channelIndexLabel => 'Indeks kanału';

  @override
  String get channels_channelName => 'Nazwa kanału';

  @override
  String get channels_usePublicChannel => 'Użyj kanału publicznego';

  @override
  String get channels_standardPublicPsk => 'Standardowy publiczny PSK';

  @override
  String get channels_pskHex => 'PSK (heksadecymalne)';

  @override
  String get channels_generateRandomPsk => 'Wygeneruj losowy klucz PSK';

  @override
  String get channels_enterChannelName => 'Proszę podać nazwę kanału.';

  @override
  String get channels_pskMustBe32Hex =>
      'PSK musi składać się z 32 znaków szesnastkowych.';

  @override
  String channels_channelAdded(String name) {
    return 'Kanał \"$name\" dodany';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'Edytuj Kanał $index';
  }

  @override
  String get channels_smazCompression => 'Kompresja SMAZ';

  @override
  String get channels_cyr2latCompression => 'Kompresja Cyr2Lat';

  @override
  String get channels_cyr2latCompressionDscr =>
      'Zastępuje niektóre znaki cyrylicy alfabetem łacińskim podczas wysyłania.';

  @override
  String get channels_cyr2latSettingsHeading => 'Ustawienia Cyr2Lat';

  @override
  String get channels_cyr2latSettingsSubheading => 'Lista zamian';

  @override
  String get channels_cyr2latSettingsDscr =>
      'Edytuj konfigurację JSON zamiany znaków';

  @override
  String get channels_cyr2latSettingsDialogHint => 'Mapa zamian JSON';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'Nieprawidłowy JSON: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'Kanał \"$name\" został zaktualizowany';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Dodaj profil Cyr2Lat';

  @override
  String get settings_cyr2latProfileName => 'Nazwa profilu';

  @override
  String get settings_cyr2latProfileNameEmpty =>
      'Nazwa profilu nie może być pusta';

  @override
  String get settings_cyr2latProfileAdded => 'Profil dodano pomyślnie';

  @override
  String get settings_cyr2latProfileUpdated =>
      'Profil został pomyślnie zaktualizowany';

  @override
  String get settings_cyr2latProfileEdit => 'Edytuj profil Cyr2Lat';

  @override
  String get settings_cyr2latProfileDelete => 'Usuń profil Cyr2Lat';

  @override
  String get settings_cyr2latProfileDeleted =>
      'Profil został pomyślnie usunięty';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return 'Czy na pewno chcesz usunąć profil \"$name\"?';
  }

  @override
  String get channels_publicChannelAdded => 'Kanał publiczny dodany';

  @override
  String get channels_sortBy => 'Sortuj po';

  @override
  String get channels_sortManual => 'Ręczna';

  @override
  String get channels_sortAZ => 'Od A do Z';

  @override
  String get channels_sortLatestMessages => 'Najnowsze wiadomości';

  @override
  String get channels_sortUnread => 'Nieprzeczytane';

  @override
  String get channels_createPrivateChannel => 'Utwórz Prywatny Kanał';

  @override
  String get channels_createPrivateChannelDesc =>
      'Zabezpieczone kluczem szyfrowym.';

  @override
  String get channels_joinPrivateChannel => 'Dołącz do Prywatnego Kanału';

  @override
  String get channels_joinPrivateChannelDesc => 'Ręcznie wprowadź klucz tajny.';

  @override
  String get channels_joinPublicChannel => 'Dołącz do kanału publicznego.';

  @override
  String get channels_joinPublicChannelDesc =>
      'Każdy może dołączyć do tego kanału.';

  @override
  String get channels_joinHashtagChannel =>
      'Dołącz do kanału oznaczanego hashtagiem';

  @override
  String get channels_joinHashtagChannelDesc =>
      'Każdy może dołączyć do kanałów z hashtagami.';

  @override
  String get channels_scanQrCode => 'Skanuj kod QR';

  @override
  String get channels_scanQrCodeComingSoon => 'Wkrótce';

  @override
  String get channels_enterHashtag => 'Wprowadź hashtag';

  @override
  String get channels_hashtagHint => 'np. #zespół';

  @override
  String channels_regionSetTo(String region) {
    return 'Region: $region';
  }

  @override
  String get channels_regionNotSet => 'Region: brak';

  @override
  String get channels_regionSelect_Title => 'Wybierz region';

  @override
  String get channels_clearRegion => 'Przejrzyste obszar';

  @override
  String get chat_noMessages => 'Brak jeszcze wiadomości';

  @override
  String get chat_sendMessage => 'Wyślij wiadomość';

  @override
  String chat_sendMessageTo(String contactName) {
    return 'Wyślij wiadomość do $contactName';
  }

  @override
  String get chat_sendMessageToStart => 'Wyślij wiadomość, aby rozpocząć.';

  @override
  String get chat_originalMessageNotFound =>
      'Błąd: Nie znaleziono oryginalnego komunikatu';

  @override
  String chat_replyingTo(String name) {
    return 'Odpowiadanie na $name';
  }

  @override
  String chat_replyTo(String name) {
    return 'Odpowiedz do $name';
  }

  @override
  String get chat_location => 'Lokalizacja';

  @override
  String get chat_typeMessage => 'Wpisz wiadomość...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'Wiadomość jest za długa (maksymalnie $maxBytes bajtów).';
  }

  @override
  String get chat_messageCopied => 'Wiadomość skopiowana';

  @override
  String get chat_messageDeleted => 'Wiadomość usunięta';

  @override
  String get chat_retryingMessage => 'Ponawianie wiadomości';

  @override
  String chat_retryCount(int current, int max) {
    return 'Próba $current/$max';
  }

  @override
  String get chat_selectSendAction => 'Wybierz czynność wysyłania';

  @override
  String get chat_sendGif => 'Wyślij GIF';

  @override
  String get chat_limitToArea => 'Ogranicz do obszaru';

  @override
  String get chat_limitToAreaTitle => 'Wysyłaj tylko w promieniu…';

  @override
  String get chat_limitToAreaHelp =>
      'Przekaźniki z firmware korytarza flood przekazują wiadomość tylko w tym obszarze. Inne przekaźniki ją odrzucają, chyba że zezwalają na Twój region korytarza.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '$km km od Ciebie';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return 'Tylko w promieniu $km km od Ciebie';
  }

  @override
  String get chat_limitToAreaOff => 'Bez ograniczeń';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'Ustaw pozycję radia, aby ograniczać wiadomości do obszaru.';

  @override
  String get chat_sendImageLora => 'Wyślij obraz przez MeshCore';

  @override
  String get chat_imagePickFailed => 'Nie mogłem otworzyć tego obrazu';

  @override
  String get chat_receivedGif => 'Otrzymano GIF';

  @override
  String get chat_reply => 'Odpowiedz';

  @override
  String get chat_addReaction => 'Dodaj Reakcję';

  @override
  String get chat_me => 'Ja';

  @override
  String get reaction_report => 'Reakcje emoji';

  @override
  String get emojiCategorySmileys => 'Emoji';

  @override
  String get emojiCategoryGestures => 'Gesty';

  @override
  String get emojiCategoryHearts => 'Serca';

  @override
  String get emojiCategoryObjects => 'Obiekty';

  @override
  String get gifPicker_title => 'Wybierz GIF';

  @override
  String get gifPicker_searchHint => 'Wyszukaj GIF-y...';

  @override
  String get gifPicker_poweredBy => 'Zasilane przez GIPHY';

  @override
  String get gifPicker_noGifsFound => 'Nie znaleziono GIF-ów';

  @override
  String get gifPicker_failedLoad => 'Nie udało się załadować GIF-ów';

  @override
  String get gifPicker_failedSearch => 'Nie udało się znaleźć GIF-ów';

  @override
  String get gifPicker_noInternet => 'Brak połączenia internetowego';

  @override
  String get debugLog_appTitle => 'Log Wykonywania Aplikacji';

  @override
  String get debugLog_bleTitle => 'Log błędów BLE';

  @override
  String get debugLog_copyLog => 'Kopiuj log';

  @override
  String get debugLog_clearLog => 'Wyczyść dziennik';

  @override
  String get debugLog_copied => 'Skopiowano dziennik debugowania';

  @override
  String get debugLog_bleCopied => 'Skopiowany log BLE';

  @override
  String get debugLog_noEntries => 'Nie ma jeszcze żadnych logów debugowania.';

  @override
  String get debugLog_enableInSettings =>
      'Włącz logowanie debugowania aplikacji w ustawieniach';

  @override
  String get debugLog_frames => 'Ramki';

  @override
  String get debugLog_rawLogRx => 'Surowy log RX';

  @override
  String get debugLog_noBleActivity => 'Brak aktywności BLE.';

  @override
  String debugFrame_length(int count) {
    return 'Długość ramy: $count bajtów';
  }

  @override
  String debugFrame_command(String value) {
    return 'Polecenie: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'Wiadomość tekstowa:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- Docelowy klucz publiczny: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- Znacznik czasu: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- Flagi: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- Typ tekstu: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'Interfejs wiersza poleceń';

  @override
  String get debugFrame_textTypePlain => 'Zwykły';

  @override
  String debugFrame_text(String text) {
    return '- Tekst: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => 'Zrzut hex:';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'skoków',
      many: 'skoków',
      few: 'skoki',
      one: 'skok',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => 'Usuń ścieżkę';

  @override
  String get chat_noPathHistoryYet =>
      'Brak historii ścieżek.\nWyślij wiadomość, aby odkryć ścieżki.';

  @override
  String get chat_pathCleared =>
      'Ścieżka wyczyszczona. Następna wiadomość odnajdzie trasę.';

  @override
  String get chat_fullPath => 'Pełna ścieżka';

  @override
  String get routing_title => 'Planowanie tras';

  @override
  String get routing_modeAuto => 'Samochód';

  @override
  String get routing_modeFlood => 'Powódź';

  @override
  String get routing_modeManual => 'Instrukcja obsługi';

  @override
  String get routing_modeAutoHint =>
      'Automatycznie wybiera najpopularniejszą ścieżkę, a w przypadku braku znanej, przechodzi do trybu \"przepływu\".';

  @override
  String get routing_modeFloodHint =>
      'Transmisje za pośrednictwem każdego repeatera. Najbardziej niezawodna metoda, ale zużywa więcej czasu transmisji.';

  @override
  String get routing_modeManualHint =>
      'Zawsze prowadzi dokładnie po trasie, którą określiłeś.';

  @override
  String get routing_currentRoute => 'Obecna trasa';

  @override
  String get routing_directNoHops =>
      'Bezpośrednio – bez pośrednictwa repeaterów';

  @override
  String get routing_noPathYet =>
      'Na razie nie ma żadnej ścieżki. Komunikacja trwa do momentu, gdy zostanie odkryta trasa.';

  @override
  String get routing_floodBroadcast =>
      'Transmisja za pośrednictwem każdego urządzenia powielającego';

  @override
  String get routing_editPath => 'Edytuj ścieżkę';

  @override
  String get routing_forgetPath => 'Zapomnij o ścieżce';

  @override
  String get routing_knownPaths => 'Znane trasy';

  @override
  String get routing_knownPathsHint =>
      'Wybierz ścieżkę, aby przełączyć się na nią.';

  @override
  String get routing_inUse => 'W użyciu';

  @override
  String get routing_qualityStrong => 'Silny pierwszy skok';

  @override
  String get routing_qualityGood => 'Świetny początek';

  @override
  String get routing_qualityFair => 'Świetny pierwszy krzak';

  @override
  String get routing_qualityWorked => 'Zostało dostarczone';

  @override
  String get routing_qualityFlood => 'Usłyszano dzięki doniesieniom';

  @override
  String get routing_qualityUntested => 'Nieużywany';

  @override
  String routing_lastWorked(String when) {
    return 'pracował $when';
  }

  @override
  String get routing_neverWorked => 'nigdy nie zostało potwierdzone';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes delivered, $failures failed';
  }

  @override
  String get routing_floodDelivery => 'Dostawa w przypadku powodzi';

  @override
  String get pathEditor_title => 'Stworzenie ścieżki';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count z 64 rodzajów chmielu';
  }

  @override
  String get pathEditor_noHops =>
      'Na razie nie dodano żadnych chmielu. Aby dodać je w odpowiedniej kolejności, kliknij w odpowiednie przyciski poniżej, lub zapisz przepis bez chmielu, aby wysłać go bezpośrednio.';

  @override
  String get pathEditor_addHops => 'Dodawaj chmiel zgodnie z kolejnością.';

  @override
  String get pathEditor_searchRepeaters => 'Funkcje powtarzania';

  @override
  String get pathEditor_advancedHex =>
      'Zaawansowane: ścieżka w formacie szesnastkowym';

  @override
  String get pathEditor_hexLabel => 'Prefiksy heksadecymalne';

  @override
  String get pathEditor_hexHelper =>
      'Dwa znaki szesnastkowe na każdym kroku, oddzielone przecinkami';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return 'Nieprawidłowe: $tokens';
  }

  @override
  String get pathEditor_tooManyHops => 'Maksymalnie 64 hopów';

  @override
  String get pathEditor_usePath => 'Użyj tej ścieżki.';

  @override
  String get pathEditor_removeHop => 'Usuń dziką psiankę';

  @override
  String get pathEditor_unknownHop => 'Nieznany repeater';

  @override
  String get chat_pathSavedLocally =>
      'Zapisano lokalnie. Połącz się, aby zsynchronizować.';

  @override
  String get chat_pathDeviceConfirmed => 'Urządzenie potwierdzone.';

  @override
  String get chat_pathDeviceNotConfirmed =>
      'Urządzenie nie zostało jeszcze potwierdzone.';

  @override
  String get chat_type => 'Typ';

  @override
  String get chat_path => 'Ścieżka';

  @override
  String get chat_publicKey => 'Klucz Publiczny';

  @override
  String get chat_compressOutgoingMessages => 'Kompresuj wychodzące wiadomości';

  @override
  String get chat_floodForced => 'Zalew (wymuszony)';

  @override
  String get chat_directForced => 'Bezpośrednio (wymuszono)';

  @override
  String chat_hopsForced(int count) {
    return '$count skoków (wymuszonych)';
  }

  @override
  String get chat_floodAuto => 'Zalew (automatyczny)';

  @override
  String get chat_direct => 'Bezpośrednio';

  @override
  String get chat_poiShared => 'Wspólny POI';

  @override
  String chat_unread(int count) {
    return 'Nieprzeczytane: $count';
  }

  @override
  String get chat_markAsUnread => 'Oznacz jako nieprzeczytane';

  @override
  String get chat_newMessages => 'Nowe wiadomości';

  @override
  String get chat_openLink => 'Otworzyć link?';

  @override
  String get chat_openLinkConfirmation =>
      'Czy chcesz otworzyć ten link w przeglądarce?';

  @override
  String get chat_open => 'Otwórz';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'Nie można otworzyć linku: $url';
  }

  @override
  String get chat_invalidLink => 'Nieprawidłowy format linku';

  @override
  String get map_title => 'Mapa węzłów';

  @override
  String get map_searchHint => 'Wyszukaj nazwę lub identyfikator węzła';

  @override
  String get map_activity => 'Aktywność';

  @override
  String get map_online => 'Online';

  @override
  String get map_recent => 'Ostatnie';

  @override
  String get map_stale => 'Nieaktualne';

  @override
  String get map_visible => 'Widoczny';

  @override
  String get map_hidden => 'Ukryty';

  @override
  String get map_centerOnNode => 'Wyśrodkuj na węźle';

  @override
  String get map_details => 'Szczegóły';

  @override
  String get map_noGps => 'Brak GPS';

  @override
  String get map_noResults => 'Brak pasujących węzłów';

  @override
  String get map_lineOfSight => 'Linia wzroku';

  @override
  String get map_losScreenTitle => 'Linia wzroku';

  @override
  String get map_noNodesWithLocation => 'Brak węzłów z danymi lokalizacyjnymi';

  @override
  String get map_nodesNeedGps =>
      'Węzły muszą udostępniać swoje współrzędne GPS,\naby pojawić się na mapie.';

  @override
  String map_nodesCount(int count) {
    return 'Węzły: $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'Pinezki: $count';
  }

  @override
  String get map_chat => 'Rozmowa';

  @override
  String get map_repeater => 'Przekaźnik';

  @override
  String get map_room => 'Pokój';

  @override
  String get map_sensor => 'Czujnik';

  @override
  String get map_pinDm => 'Pinezka (DM)';

  @override
  String get map_pinPrivate => 'Pinezka (prywatna)';

  @override
  String get map_pinPublic => 'Pinezka (publiczna)';

  @override
  String get map_lastSeen => 'Ostatni raz widziany';

  @override
  String get map_disconnectConfirm =>
      'Czy na pewno chcesz się odłączyć od tego urządzenia?';

  @override
  String get map_from => 'Od';

  @override
  String get map_source => 'Źródło';

  @override
  String get map_flags => 'Flagi';

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
  String get map_shareMarkerHere => 'Udostępnij znacznik tutaj';

  @override
  String get map_setAsMyLocation => 'Ustaw jako moją lokalizację';

  @override
  String get floodCorridor_title => 'Korytarz flood';

  @override
  String get floodCorridor_previewToHere =>
      'Podgląd korytarza flood do tego miejsca';

  @override
  String get floodCorridor_requesting => 'Proszenie radia o korytarz…';

  @override
  String get floodCorridor_unsupported =>
      'Firmware Twojego radia nie obsługuje korytarzy flood.';

  @override
  String get floodCorridor_noProposal =>
      'Radio nie mogło zaproponować korytarza. Upewnij się, że ma ustawioną pozycję.';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count okręgu',
      many: '$count okręgów',
      few: '$count okręgi',
      one: '1 okrąg',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return '$inside z $total znanych przekaźników wewnątrz';
  }

  @override
  String get floodCorridor_straightLine =>
      'Linia prosta: brak znanych przekaźników po drodze';

  @override
  String get floodCorridor_followsRepeaters =>
      'Podąża za znanymi przekaźnikami';

  @override
  String get floodCorridor_horizonLimited =>
      'Znane przekaźniki nie sięgają celu; reszta to linia prosta';

  @override
  String get floodCorridor_thinStretch =>
      'Część korytarza ma mało znanych przekaźników';

  @override
  String get floodCorridor_moreCoverage =>
      'Wymagaj większego pokrycia przekaźnikami';

  @override
  String get floodCorridor_previewNote =>
      'Tylko podgląd. Przekaźniki bez firmware korytarza nie stosują korytarzy.';

  @override
  String get map_pinLabel => 'Etykieta pinezki';

  @override
  String get map_label => 'Etykieta';

  @override
  String get map_pointOfInterest => 'Punkt zainteresowań';

  @override
  String get map_sendToContact => 'Wyślij do kontaktu';

  @override
  String get map_sendToChannel => 'Wyślij do kanału';

  @override
  String get map_noChannelsAvailable => 'Brak dostępnych kanałów';

  @override
  String get map_publicLocationShare => 'Udostępnij lokalizację publicznie';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return 'Zamierzasz udostępnić lokalizację w $channelLabel. Ten kanał jest publiczny i każdy z PSK może go zobaczyć.';
  }

  @override
  String get map_connectToShareMarkers =>
      'Połącz się z urządzeniem, aby udostępniać znaczniki.';

  @override
  String get map_filterNodes => 'Filtruj Węzły';

  @override
  String get map_nodeTypes => 'Typy węzłów';

  @override
  String get map_chatNodes => 'Węzły czatu';

  @override
  String get map_repeaters => 'Przekaźniki';

  @override
  String get map_otherNodes => 'Inne węzły';

  @override
  String get map_showOverlaps => 'Nakładające się klucze przekaźników';

  @override
  String get map_keyPrefix => 'Prefiks klucza';

  @override
  String get map_filterByKeyPrefix => 'Filtruj po prefiksie klucza';

  @override
  String get map_publicKeyPrefix => 'Prefiks klucza publicznego';

  @override
  String get map_markers => 'Znaczniki';

  @override
  String get map_showSharedMarkers => 'Pokaż udostępnione znaczniki.';

  @override
  String get map_showGuessedLocations =>
      'Pokaż przypuszczalne lokalizacje węzłów';

  @override
  String get map_showDiscoveryContacts => 'Pokaż odkryte kontakty';

  @override
  String get map_guessedLocation => 'Przypuszczalna lokalizacja';

  @override
  String get map_lastSeenTime => 'Ostatni raz widziany';

  @override
  String get map_sharedPin => 'Udostępniona pinezka';

  @override
  String get map_sharedAt => 'Udostępnione';

  @override
  String get map_joinRoom => 'Dołącz do pokoju';

  @override
  String get map_manageRepeater => 'Zarządzaj przekaźnikiem';

  @override
  String get map_tapToAdd => 'Kliknij na węzły, aby dodać je do ścieżki.';

  @override
  String get map_runTrace => 'Uruchom ślad ścieżki';

  @override
  String get map_runTraceWithReturnPath => 'Wróć tą samą ścieżką';

  @override
  String get map_removeLast => 'Usuń ostatni';

  @override
  String get map_pathTraceCancelled => 'Śledzenie ścieżki anulowano.';

  @override
  String get mapCache_title => 'Pamięć podręczna map offline';

  @override
  String get mapCache_selectAreaFirst =>
      'Najpierw wybierz obszar do zapisania w pamięci podręcznej.';

  @override
  String get mapCache_noTilesToDownload =>
      'Brak kafelków do pobrania dla tego obszaru.';

  @override
  String get mapCache_downloadTilesTitle => 'Pobierz kafelki';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return 'Pobrać $count kafelków do użytku offline?';
  }

  @override
  String get mapCache_downloadAction => 'Pobierz';

  @override
  String mapCache_cachedTiles(int count) {
    return 'Zapisano w pamięci podręcznej $count kafelków';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return 'Zapisano w pamięci podręcznej $downloaded kafelków ($failed nieudanych)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle =>
      'Wyczyść pamięć podręczną offline';

  @override
  String get mapCache_clearOfflineCachePrompt =>
      'Usunąć wszystkie zapisane kafelki mapy?';

  @override
  String get mapCache_offlineCacheCleared =>
      'Wyczyszczono pamięć podręczną offline';

  @override
  String get mapCache_noAreaSelected => 'Nie wybrano żadnego obszaru.';

  @override
  String get mapCache_cacheArea => 'Obszar pamięci podręcznej';

  @override
  String get mapCache_useCurrentView => 'Użyj aktualnego widoku';

  @override
  String get mapCache_zoomRange => 'Zakres przybliżenia';

  @override
  String mapCache_estimatedTiles(int count) {
    return 'Szacowana liczba kafelków: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return 'Pobrano $completed / $total';
  }

  @override
  String get mapCache_downloadTilesButton => 'Pobierz kafelki';

  @override
  String get mapCache_clearCacheButton => 'Wyczyść pamięć podręczną';

  @override
  String mapCache_failedDownloads(int count) {
    return 'Nieudane pobrania: $count';
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
  String get time_justNow => 'Właśnie teraz';

  @override
  String time_minutesAgo(int minutes) {
    return '$minutes minut temu';
  }

  @override
  String time_hoursAgo(int hours) {
    return '${hours}h temu';
  }

  @override
  String time_daysAgo(int days) {
    return '$days dni temu';
  }

  @override
  String get time_hour => 'godzina';

  @override
  String get time_hours => 'godziny';

  @override
  String get time_day => 'dzień';

  @override
  String get time_days => 'dni';

  @override
  String get time_week => 'tydzień';

  @override
  String get time_weeks => 'tygodnie';

  @override
  String get time_month => 'miesiąc';

  @override
  String get time_months => 'miesiące';

  @override
  String get time_minutes => 'minuty';

  @override
  String get time_allTime => 'Cały czas';

  @override
  String get dialog_disconnect => 'Odłącz';

  @override
  String get dialog_disconnectConfirm =>
      'Czy na pewno chcesz się odłączyć od tego urządzenia?';

  @override
  String get login_repeaterLogin => 'Logowanie do przekaźnika';

  @override
  String get login_roomLogin => 'Logowanie do pokoju';

  @override
  String get login_password => 'Hasło';

  @override
  String get login_enterPassword => 'Wprowadź hasło';

  @override
  String get login_savePassword => 'Zapisz hasło';

  @override
  String get login_savePasswordSubtitle =>
      'Hasło będzie bezpiecznie przechowywane na tym urządzeniu.';

  @override
  String get login_repeaterDescription =>
      'Wprowadź hasło do przekaźnika, aby uzyskać dostęp do ustawień i stanu.';

  @override
  String get login_roomDescription =>
      'Wprowadź hasło do pokoju, aby uzyskać dostęp do ustawień i statusu.';

  @override
  String get login_routing => 'Trasowanie';

  @override
  String get login_routingMode => 'Tryb routingu';

  @override
  String get login_autoUseSavedPath => 'Automatycznie (użyj zapisanej ścieżki)';

  @override
  String get login_forceFloodMode => 'Wymuś tryb zalewowy';

  @override
  String get login_managePaths => 'Zarządzaj Ścieżkami';

  @override
  String get login_login => 'Zaloguj się';

  @override
  String login_attempt(int current, int max) {
    return 'Próba $current/$max';
  }

  @override
  String login_failed(String error) {
    return 'Zalogowanie się nie powiodło: $error';
  }

  @override
  String get login_failedMessage =>
      'Logowanie nie powiodło się. Hasło jest nieprawidłowe albo przekaźnik jest nieosiągalny.';

  @override
  String get common_reload => 'Odśwież';

  @override
  String get common_clear => 'Wyczyść';

  @override
  String get path_currentPathLabel => 'Aktualna ścieżka';

  @override
  String get path_noRepeatersFound =>
      'Nie znaleziono przekaźników ani serwerów pokoi.';

  @override
  String get repeater_management => 'Zarządzanie przekaźnikami';

  @override
  String get room_management => 'Zarządzanie Serwerem Pokoju';

  @override
  String get repeater_guest => 'Informacje dotyczące urządzenia powtarzającego';

  @override
  String get room_guest => 'Informacje o serwerze';

  @override
  String get repeater_managementTools => 'Narzędzia Zarządzania';

  @override
  String get repeater_guestTools => 'Narzędzia dla gości';

  @override
  String get repeater_status => 'Stan';

  @override
  String get repeater_statusSubtitle =>
      'Wyświetl status przekaźnika, statystyki i sąsiadów.';

  @override
  String get repeater_telemetry => 'Telemetria';

  @override
  String get repeater_telemetrySubtitle =>
      'Wyświetl dane telemetryczne z czujników i statystyki systemu';

  @override
  String get repeater_cli => 'Interfejs wiersza poleceń';

  @override
  String get repeater_cliSubtitle => 'Wyślij polecenia do przekaźnika';

  @override
  String get repeater_neighbors => 'Sąsiedzi';

  @override
  String get repeater_neighborsSubtitle => 'Wyświetl sąsiadów zero-hop.';

  @override
  String get repeater_settings => 'Ustawienia';

  @override
  String get repeater_settingsSubtitle => 'Skonfiguruj parametry przekaźnika';

  @override
  String get repeater_clockSyncAfterLogin =>
      'Synchronizacja zegara po zalogowaniu';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      'Automatycznie wysyłaj powiadomienie \"synchronizacja zegara\" po pomyślnym zalogowaniu.';

  @override
  String get repeater_statusTitle => 'Status przekaźnika';

  @override
  String get repeater_routingMode => 'Tryb routingu';

  @override
  String get repeater_refresh => 'Odśwież';

  @override
  String get repeater_statusRequestTimeout =>
      'Przekroczono czas oczekiwania na status.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'Błąd podczas ładowania statusu: $error';
  }

  @override
  String get repeater_systemInformation => 'Informacje o systemie';

  @override
  String get repeater_battery => 'Bateria';

  @override
  String get repeater_clockAtLogin => 'Godzina (przy logowaniu)';

  @override
  String get repeater_uptime => 'Czas pracy';

  @override
  String get repeater_queueLength => 'Długość kolejki';

  @override
  String get repeater_debugFlags => 'Opcje debugowania';

  @override
  String get repeater_radioStatistics => 'Statystyki Radia';

  @override
  String get repeater_lastRssi => 'Ostatni RSSI';

  @override
  String get repeater_lastSnr => 'Ostatnie SNR';

  @override
  String get repeater_noiseFloor => 'Poziom Szumów';

  @override
  String get repeater_txAirtime => 'Czas nadawania TX';

  @override
  String get repeater_rxAirtime => 'Czas odbioru RX';

  @override
  String get repeater_chanUtil => 'Wykorzystanie kanału';

  @override
  String get repeater_packetStatistics => 'Statystyki pakietów';

  @override
  String get repeater_sent => 'Wysłane';

  @override
  String get repeater_received => 'Otrzymano';

  @override
  String get repeater_duplicates => 'Powtórzenia';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days dni ${hours}h ${minutes}m ${seconds}s';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return 'Razem: $total, Zalew: $flood, Bezpośrednio: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return 'Razem: $total, Zalew: $flood, Bezpośrednio: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return 'Zalew: $flood, Bezpośrednie: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return 'Razem: $total';
  }

  @override
  String get repeater_settingsTitle => 'Ustawienia przekaźnika';

  @override
  String get repeater_basicSettings => 'Podstawowe Ustawienia';

  @override
  String get repeater_repeaterName => 'Nazwa przekaźnika';

  @override
  String get repeater_repeaterNameHelper => 'Wyświetl nazwę tego przekaźnika';

  @override
  String get repeater_adminPassword => 'Hasło Administracyjne';

  @override
  String get repeater_adminPasswordHelper => 'Hasło z pełnym dostępem';

  @override
  String get repeater_guestPassword => 'Hasło gościa';

  @override
  String get repeater_guestPasswordHelper => 'Hasło tylko do odczytu';

  @override
  String get repeater_radioSettings => 'Ustawienia radia';

  @override
  String get repeater_frequencyMhz => 'Częstotliwość (MHz)';

  @override
  String get repeater_frequencyHelper => '300–2500 MHz';

  @override
  String get repeater_txPower => 'Moc TX';

  @override
  String get repeater_txPowerHelper => '1-30 dBm';

  @override
  String get repeater_bandwidth => 'Przepustowość';

  @override
  String get repeater_spreadingFactor => 'Współczynnik rozpraszania';

  @override
  String get repeater_codingRate => 'Współczynnik kodowania';

  @override
  String get repeater_locationSettings => 'Ustawienia Lokalizacji';

  @override
  String get repeater_latitude => 'Szerokość';

  @override
  String get repeater_latitudeHelper => 'Stopnie dziesiętne (np. 37.7749)';

  @override
  String get repeater_longitude => 'Długość';

  @override
  String get repeater_longitudeHelper => 'Stopnie dziesiętne (np. -122,4194)';

  @override
  String get repeater_features => 'Funkcje';

  @override
  String get repeater_packetForwarding => 'Przekierowanie pakietów';

  @override
  String get repeater_packetForwardingSubtitle =>
      'Włącz przekaźnik, aby przekazywać pakiety.';

  @override
  String get repeater_guestAccess => 'Dostęp dla gości';

  @override
  String get repeater_guestAccessSubtitle =>
      'Umożliw dostęp tylko do odczytu dla gości.';

  @override
  String get repeater_privacyMode => 'Tryb prywatności';

  @override
  String get repeater_privacyModeSubtitle =>
      'Ukryj imię/lokalizację w rozgłoszeniach';

  @override
  String get repeater_advertisementSettings => 'Ustawienia rozgłoszeń';

  @override
  String get repeater_localAdvertInterval => 'Interwał rozgłoszenia lokalnego';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes minut';
  }

  @override
  String get repeater_floodAdvertInterval => 'Interwał rozgłoszenia zalewowego';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours godzin';
  }

  @override
  String get repeater_encryptedAdvertInterval =>
      'Interwał Zaszyfrowanego Rozgłoszenia';

  @override
  String get repeater_dangerZone => 'Strefa Zagrożeń';

  @override
  String get repeater_rebootRepeater => 'Zrestartuj Przekaźnik';

  @override
  String get repeater_rebootRepeaterSubtitle => 'Zrestartuj przekaźnik.';

  @override
  String get repeater_rebootRepeaterConfirm =>
      'Czy na pewno chcesz zrestartować ten przekaźnik?';

  @override
  String get repeater_regenerateIdentityKey => 'Wygeneruj klucz tożsamości';

  @override
  String get repeater_regenerateIdentityKeySubtitle =>
      'Wygeneruj nową parę kluczy publicznych/prywatnych';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'Zostanie wygenerowana nowa tożsamość dla przekaźnika. Kontynuować?';

  @override
  String get repeater_eraseFileSystem => 'Wyczyść System Plików';

  @override
  String get repeater_eraseFileSystemSubtitle =>
      'Sformatuj system plików przekaźnika';

  @override
  String get repeater_eraseFileSystemConfirm =>
      'OSTRZEŻENIE: To spowoduje usunięcie wszystkich danych z przekaźnika. Nie da się tego cofnąć!';

  @override
  String get repeater_eraseSerialOnly =>
      'Usunięcie jest dostępne tylko przez konsolę szeregową.';

  @override
  String repeater_commandSent(String command) {
    return 'Polecenie wysłane: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'Błąd podczas wysyłania polecenia: $error';
  }

  @override
  String get repeater_confirm => 'Potwierdź';

  @override
  String get repeater_settingsSaved => 'Ustawienia zostały pomyślnie zapisane.';

  @override
  String get repeater_rxGain => 'Zwiększony zysk RX';

  @override
  String get repeater_rxGainHelper =>
      'Większa czułość, większe pobieranie prądu (dotyczy tylko SX1262/SX1268)';

  @override
  String get repeater_refreshRxGain => 'Zaktualizuj zwiększone zyski RX';

  @override
  String get repeater_multiAcks => 'Wielokrotne potwierdzenia odbioru';

  @override
  String get repeater_multiAcksSubtitle =>
      'Potwierdź odbiór wiadomości za pomocą różnych ścieżek, aby zapewnić lepszą dostawę.';

  @override
  String get repeater_refreshMultiAcks =>
      'Odświeżanie wielokrotnych potwierdzeń';

  @override
  String get repeater_networkHealth => 'Stan sieci';

  @override
  String get repeater_loopDetect => 'Wykrywanie pętli';

  @override
  String get repeater_loopDetectHelper =>
      'Wysyłaj pakiety, które wyglądają jak pętle routingu.';

  @override
  String get repeater_loopDetectOff => 'Z domu';

  @override
  String get repeater_loopDetectMinimal => 'Minimalny';

  @override
  String get repeater_loopDetectModerate => 'Umiarkowany';

  @override
  String get repeater_loopDetectStrict => 'Surowe';

  @override
  String get repeater_dutyCycle => 'Cykl pracy';

  @override
  String get repeater_dutyCycleHelper =>
      'Maksymalny procent czasu, który stacja może wykorzystać.';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => 'Informacje o operatorze';

  @override
  String get repeater_ownerInfoHelper =>
      'Publiczne metadane dla tego urządzenia powielającego';

  @override
  String get repeater_refreshOwnerInfo =>
      'Aktualizacja danych dotyczących operatora';

  @override
  String get repeater_floodMax => 'Maksymalna liczba skoków podczas powodzi';

  @override
  String get repeater_floodMaxHelper =>
      'Maksymalna liczba pakietów, które mogą przemieszczać się w jednym strumieniu (0-64)';

  @override
  String get repeater_advancedSettings => 'Zaawansowany';

  @override
  String get repeater_advancedSettingsSubtitle =>
      'Regulowane pokrętła dla doświadczonych operatorów';

  @override
  String get repeater_pathHashMode => 'Tryb haszujący ścieżkę';

  @override
  String get repeater_pathHashModeHelper =>
      'Bajty używane do kodowania identyfikatora tego repeatera w tagach ścieżki flood/wykrywania pętli. 0=1 bajt (256 identyfikatorów, do 64 skoków), 1=2 bajty (65 000 identyfikatorów, do 32 skoków), 2=3 bajty (16 milionów identyfikatorów, do 21 skoków). Firmware sprzed v1.14 zawsze używał ścieżek 1-bajtowych; v1.14 i nowsze można skonfigurować na ścieżki 2- lub 3-bajtowe.';

  @override
  String get repeater_keySettings => 'Zmiana kluczy tożsamości';

  @override
  String get repeater_keySettingsSubtitle =>
      'Zmień parę kluczy publiczną/prywatną';

  @override
  String get repeater_prvKey => 'Klucz prywatny';

  @override
  String get repeater_prvKeyHelper =>
      'Nowy klucz prywatny dla wzmacniacza, 128-znakowa string hexadecyimalny.';

  @override
  String get repeater_generatePrvKey => 'Wygeneruj losowy klucz parowy';

  @override
  String get repeater_stopGeneratingPrvKey =>
      'Przerwij wyszukiwanie kluczowego paru';

  @override
  String get repeater_pubKey => 'Klucz publiczny';

  @override
  String get repeater_pubKeyHelper =>
      'To jest klucz publiczny, który odpowiada wygenerowanemu kluczowi prywatnemu. Nie można go ustawić bezpośrednio.';

  @override
  String get repeater_pubKeyPrefix => 'Pożądane przedrostek';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'Znajdź klucz publiczny, który zaczyna się od tych cyfr hex. Oczekiwana liczba prób: $tries.';
  }

  @override
  String get repeater_txDelay => 'Opóźnienie w Flood, TX';

  @override
  String get repeater_txDelayHelper =>
      'Ustawienie odstępu dla ruchu związanego z powodzią, jako mnożnik czasu przesyłania pakietu (0-2, domyślnie 0,5). Wyższe wartości oznaczają mniejszą liczbę kolizji, ale wolniejszą prędkość przesyłania.';

  @override
  String get repeater_directTxDelay => 'Bezpośrednie opóźnienie sygnału TX';

  @override
  String get repeater_directTxDelayHelper =>
      'Ustawienie odstępu dla ruchu bezpośredniego (bez rozgłaszania), jako mnożnika czasu przesyłania pakietu (0-2, domyślnie 0,3).';

  @override
  String get repeater_intThresh => 'Próg zakłóceń';

  @override
  String get repeater_intThreshHelper =>
      'Próg został ustawiony na poziom szumów w radiu, dzięki czemu odrzuca sygnały zakłócające powyżej tego poziomu. 0 oznacza wyłączenie – ustaw tylko wtedy, gdy występują błędy odbierania w szumie.';

  @override
  String get repeater_agcResetInterval => 'Interwał resetowania AGC';

  @override
  String get repeater_agcResetIntervalHelper =>
      'Jak często należy resetować automatyczną regulację głośności radia, aby odzyskać z sytuacji, w której głośność jest ustawiona na stałe. Ustawienie \"0\" dezaktywuje okresowe resetowanie.';

  @override
  String get repeater_actionsTitle => 'Działania';

  @override
  String get repeater_sendAdvert => 'Wysłać reklamę dotyczącą powodzi';

  @override
  String get repeater_sendAdvertSubtitle =>
      'Wyemituj reklamę dotyczącą powodzi w sieci.';

  @override
  String get repeater_sendAdvertZeroHop => 'Wysłać reklamę bez pośrednictwa';

  @override
  String get repeater_sendAdvertZeroHopSubtitle =>
      'Napisz reklamę, która będzie transmitowana bezpośrednio (bez powtarzania).';

  @override
  String get repeater_clockSync => 'Synchronizuj zegar';

  @override
  String get repeater_clockSyncSubtitle =>
      'Przekaż czas z telefonu do urządzenia powielającego';

  @override
  String repeater_actionSucceeded(String action) {
    return '$action zakończyło się pomyślnie';
  }

  @override
  String repeater_actionFailed(String action, String error) {
    return '$action failed: $error';
  }

  @override
  String get repeater_settingsSavedRebootNeeded =>
      'Ustawienia zapisane – uruchom ponownie repeater, aby zastosować zmiany.';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return 'Niektóre ustawienia nie zostały zaimplementowane: $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return 'Błąd zapisu ustawień: $error';
  }

  @override
  String get repeater_refreshBasicSettings => 'Odśwież Podstawowe Ustawienia';

  @override
  String get repeater_refreshRadioSettings => 'Odśwież ustawienia radia';

  @override
  String get repeater_refreshTxPower => 'Odśwież moc TX';

  @override
  String get repeater_refreshPacketForwarding => 'Odśwież trasowanie pakietów';

  @override
  String get repeater_refreshGuestAccess => 'Odśwież dostęp gościa';

  @override
  String get repeater_refreshPrivacyMode => 'Odśwież Tryb Prywatności';

  @override
  String repeater_refreshed(String label) {
    return '$label odświeżone';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return 'Błąd podczas odświeżania $label';
  }

  @override
  String get repeater_cliTitle => 'Przekaźnik CLI';

  @override
  String get repeater_debugNextCommand => 'Debug Następną Komendę';

  @override
  String get repeater_commandHelp => 'Pomoc';

  @override
  String get repeater_clearHistory => 'Wyczyść historię';

  @override
  String get repeater_noCommandsSent => 'Nie wysłano jeszcze żadnych poleceń';

  @override
  String get repeater_typeCommandOrUseQuick =>
      'Wprowadź polecenie poniżej lub użyj szybkich poleceń';

  @override
  String get repeater_enterCommandHint => 'Wprowadź polecenie...';

  @override
  String get repeater_previousCommand => 'Poprzednia komenda';

  @override
  String get repeater_nextCommand => 'Następna komenda';

  @override
  String get repeater_enterCommandFirst => 'Wprowadź najpierw polecenie';

  @override
  String get repeater_cliCommandFrameTitle => 'Ramka polecenia CLI';

  @override
  String repeater_cliCommandError(String error) {
    return 'Błąd: $error';
  }

  @override
  String get repeater_cliQuickGetName => 'Pobierz nazwę';

  @override
  String get repeater_cliQuickGetRadio => 'Pobierz radio';

  @override
  String get repeater_cliQuickGetTx => 'Pobierz TX';

  @override
  String get repeater_cliQuickNeighbors => 'Sąsiedzi';

  @override
  String get repeater_cliQuickVersion => 'Wersja';

  @override
  String get repeater_cliQuickAdvertise => 'Rozgłoś';

  @override
  String get repeater_cliQuickClock => 'Godzina';

  @override
  String get repeater_cliQuickClockSync => 'Synchronizacja zegara';

  @override
  String get repeater_cliQuickDiscovery => 'Odkryj Sąsiadów';

  @override
  String get repeater_cliHelpAdvert => 'Wysyła pakiet rozgłoszeniowy';

  @override
  String get repeater_cliHelpReboot =>
      'Zresetuj urządzenie. (Uwaga, może pojawić się \'Timeout\', co jest normalne)';

  @override
  String get repeater_cliHelpClock =>
      'Wyświetla aktualny czas zgodnie z zegarem urządzenia.';

  @override
  String get repeater_cliHelpPassword =>
      'Ustawia nowe hasło administratora dla urządzenia.';

  @override
  String get repeater_cliHelpVersion =>
      'Wyświetla wersję urządzenia i datę budowy oprogramowania.';

  @override
  String get repeater_cliHelpClearStats =>
      'Resetuje różne wskaźniki statystyk do zera.';

  @override
  String get repeater_cliHelpSetAf => 'Ustawia czynnik czasu powietrznego.';

  @override
  String get repeater_cliHelpSetTx =>
      'Ustawia moc transmisji LoRa w dBm. (zrestartuj, aby zastosować)';

  @override
  String get repeater_cliHelpSetRepeat =>
      'Włącza lub wyłącza rolę przekaźnika dla tego węzła.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(Serwer pokoju) Jeśli \'włączone\', to logowanie z pustym hasłem będzie dozwolone, ale nie można publikować w pokoju (tylko czytać).';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'Ustawia maksymalną liczbę skoków pakietu zalewowego (jeśli >= max, pakiet nie jest przekierowywany)';

  @override
  String get repeater_cliHelpSetIntThresh =>
      'Ustawia Próg Interferencji (w dB). Domyślnie wynosi 14. Ustaw na 0, aby wyłączyć wykrywanie zakłóceń kanału.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'Ustawia interwał do zresetowania automatycznego wzmocnienia (AGC). Ustaw na 0, aby wyłączyć.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      'Włącza lub wyłącza funkcję \'podwójnych potwierdzeń\'.';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'Ustawia interwał timera w minutach do wysyłania pakietu rozgłoszenia lokalnego (bezpośredniego). Ustaw na 0, aby wyłączyć.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'Ustawia interwał timera w godzinach do wysłania pakietu rozgłoszeniowego typu \"flood\". Ustaw na 0, aby wyłączyć.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'Ustawia/aktualizuje hasło gościa. (dla przekaźników loginy gości mogą wysyłać żądanie \"Get Stats\")';

  @override
  String get repeater_cliHelpSetName => 'Ustawia nazwę rozgłoszenia.';

  @override
  String get repeater_cliHelpSetLat =>
      'Ustawia współrzędną geograficzną (w stopniach dziesiętnych) mapy rozgłoszeń.';

  @override
  String get repeater_cliHelpSetLon =>
      'Ustawia współrzędną długościową mapy rozgłoszeń. (stopnie dziesiętne)';

  @override
  String get repeater_cliHelpSetRadio =>
      'Ustawia nowe parametry radia i zapisuje je w preferencjach. Wymaga polecenia \"reboot\" do zastosowania.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      'Ustawienia (eksperymentalne) bazowe (muszą być > 1, aby działać) do stosowania lekkiego opóźnienia dla odebranych pakietów, w oparciu o siłę sygnału/wynik. Ustaw na 0, aby wyłączyć.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      'Ustawia czynnik mnożony przez czas utrzymania w trybie zalewowym dla pakietu oraz z wykorzystaniem losowego systemu slotów, aby opóźnić jego przesyłanie (zmniejszając prawdopodobieństwo kolizji).';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'Taki sam jak txdelay, ale dla stosowania losowej opóźnienia przy przekazywaniu pakietów w trybie bezpośrednim.';

  @override
  String get repeater_cliHelpSetBridgeEnabled => 'Włącz/Wyłącz mostek.';

  @override
  String get repeater_cliHelpSetBridgeDelay =>
      'Ustaw czas opóźnienia przed ponownym wysyłaniem pakietów.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      'Wybierz, czy most będzie ponownie transmitował otrzymywane pakiety, czy też wysyłane.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'Ustaw prędkość transmisji magistrali szeregowej dla mostów rs232.';

  @override
  String get repeater_cliHelpSetBridgeSecret =>
      'Ustaw sekret dla mostów ESPNOW.';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      'Ustawia niestandardowy współczynnik do korekty zgłaszanego napięcia baterii (obsługa tylko na wybranych płytach).';

  @override
  String get repeater_cliHelpTempRadio =>
      'Ustawia tymczasowe parametry radia na podany czas trwania w minutach, a następnie powraca do oryginalnych parametrów radia. (nie zapisuje zmian w preferencjach).';

  @override
  String get repeater_cliHelpSetPerm =>
      'Modyfikuje ACL. Usuwa dopasowaną wpis (z prefiksem pubkey), jeśli \"permissions\" wynosi zero. Dodaje nowy wpis, jeśli pubkey-hex ma pełną długość i nie znajduje się obecnie w ACL. Aktualizuje wpis, dopasowując prefiks pubkey. Bit uprawnień zależy od roli firmware, ale dolne 2 bity to: 0 (Gość), 1 (tylko odczyt), 2 (odczyt i zapis), 3 (administrator).';

  @override
  String get repeater_cliHelpGetBridgeType =>
      'Pobiera typ mostka: brak, rs232, espnow';

  @override
  String get repeater_cliHelpLogStart =>
      'Rozpoczyna się logowanie pakietów do systemu plików.';

  @override
  String get repeater_cliHelpLogStop =>
      'Zatrzymuje logowanie pakietów do systemu plików.';

  @override
  String get repeater_cliHelpLogErase =>
      'Usuwa logi pakietów z systemu plików.';

  @override
  String get repeater_cliHelpNeighbors =>
      'Wyświetla listę innych węzłów przekaźnikowych usłyszanych przez rozgłoszenia zero-hop. Każda linia to: id-prefix-hex:timestamp:snr-times-4';

  @override
  String get repeater_cliHelpNeighborRemove =>
      'Usuwa pierwszy pasujący wpis (z prefiksem pubkey (hex)) z listy sąsiadów.';

  @override
  String get repeater_cliHelpRegion =>
      '(tylko port szeregowy) Wyświetla wszystkie zdefiniowane regiony i aktualne uprawnienia do zalewu.';

  @override
  String get repeater_cliHelpRegionLoad =>
      'UWAGA: to jest specjalne wywołanie wielokomendowe. Każda następna komenda jest nazwą regionu (wcięta spacjami, aby wskazywać hierarchię nadrzędną, z minimum jedną spacją). Zakończona wysłaniem pustej linii/komendy.';

  @override
  String get repeater_cliHelpRegionGet =>
      'Wyszukuje region o podanej nazwie prefiksu (lub \"\" dla zakresu globalnego). Odpowiada \"-> region-name (parent-name) \'F\'\"';

  @override
  String get repeater_cliHelpRegionPut =>
      'Dodaje lub aktualizuje definicję regionu z podaną nazwą.';

  @override
  String get repeater_cliHelpRegionRemove =>
      'Usuwa definicję regionu o podanej nazwie. (musi się dokładnie zgadzać i nie może mieć podregionów).';

  @override
  String get repeater_cliHelpRegionAllowf =>
      'Ustawia uprawnienia \'F\' (zalewowe) dla podanego regionu. (\'\' dla zakresu globalnego/starszego)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      'Usuwa uprawnienie \'F\' (zalewowe) dla podanej strefy. (ZALECANE: na tym etapie NIE zaleca się używania tego na globalnym/starszym zakresie!!).';

  @override
  String get repeater_cliHelpRegionHome =>
      'Odpowiada z aktualnej \'home\' region. (Uwaga: nie zostało jeszcze zastosowane, zarezerwowane na przyszłość).';

  @override
  String get repeater_cliHelpRegionHomeSet => 'Ustawia region \'domowe\'.';

  @override
  String get repeater_cliHelpRegionSave =>
      'Zapisuje listę/mapę regionów do pamięci.';

  @override
  String get repeater_cliHelpGps =>
      'Wyświetla status GPS. Jeśli GPS jest wyłączony, odpowiada tylko \"off\", jeśli jest włączony, odpowiada z \"on\", \"status\", \"fix\", liczbą satelitów.';

  @override
  String get repeater_cliHelpGpsOnOff => 'Włącza/wyłącza nawigację GPS.';

  @override
  String get repeater_cliHelpGpsSync =>
      'Synchronizuje czas węzła z zegarem GPS.';

  @override
  String get repeater_cliHelpGpsSetLoc =>
      'Ustawia pozycję węzła na współrzędne GPS i zapisuje preferencje.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'Udostępnia konfigurację rozgłoszeń lokalizacji węzła:\n- brak: nie uwzględniaj lokalizacji w rozgłoszeniach\n- udostępnia: udostępnia lokalizację GPS (z SensorManager)\n- ustawienia: rozgłaszaj lokalizację przechowywaną w ustawieniach';

  @override
  String get repeater_cliHelpGpsAdvertSet =>
      'Ustawia konfigurację rozgłoszeń lokalizacji.';

  @override
  String get repeater_commandsListTitle => 'Lista poleceń';

  @override
  String get repeater_commandsListNote =>
      'UWAGA: dla różnych poleceń \"set ...\" istnieje również polecenie \"get ...\".';

  @override
  String get repeater_general => 'Ogólne';

  @override
  String get repeater_settingsCategory => 'Ustawienia';

  @override
  String get repeater_bridge => 'Most';

  @override
  String get repeater_logging => 'Rejestrowanie';

  @override
  String get repeater_neighborsRepeaterOnly => 'Sąsiedzi (tylko przekaźnik)';

  @override
  String get repeater_regionManagementRepeaterOnly =>
      'Zarządzanie Regionem (tylko Przekaźnik)';

  @override
  String get repeater_regionNote =>
      'Wprowadzono komendy regionalne w celu zarządzania definicjami i uprawnieniami regionów.';

  @override
  String get repeater_gpsManagement => 'Zarządzanie GPS';

  @override
  String get repeater_gpsNote =>
      'Polecenie GPS zostało wprowadzone w celu zarządzania tematami związanymi z lokalizacją.';

  @override
  String get repeater_getCategory => 'Uzyskaj wartości';

  @override
  String get repeater_powerMgmt => 'Zarządzanie energią';

  @override
  String get repeater_sensors => 'Czujniki';

  @override
  String get repeater_cliHelpPowerOff =>
      'Wyłącza urządzenie. (oczekiwanie na brak reakcji)';

  @override
  String get repeater_cliHelpClkReboot =>
      'Przywraca zegar do znanego punktu odniesienia i resetuje urządzenie.';

  @override
  String get repeater_cliHelpAdvertZeroHop =>
      'Wysyła reklamę, która dociera bezpośrednio do sąsiadów (bez pośrednictwa).';

  @override
  String get repeater_cliHelpStartOta =>
      'Rozpoczyna aktualizację oprogramowania przez sieć (bezpośrednio z urządzenia).';

  @override
  String get repeater_cliHelpTime =>
      'Ustawia zegar urządzenia na określone sekundy od epoki Unix. Zegar nie może się cofać.';

  @override
  String get repeater_cliHelpBoard =>
      'Wyświetla informacje o producencie płyty głównej / identyfikator sprzętu.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      'Wysyła żądanie wykrywania sąsiednich węzłów. (Działa tylko w urządzeniu powielającym sygnał)';

  @override
  String get repeater_cliHelpPowersaving =>
      'Pokazuje, czy tryb oszczędzania energii jest włączony, czy wyłączony.';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      'Umożliwia lub wyłącza tryb oszczędzania energii (jeśli jest obsługiwany).';

  @override
  String get repeater_cliHelpErase =>
      '(Dla urządzeń) Formatuje system plików urządzenia. Usuwa wszystkie ustawienia i kontakty.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      'Ustawia maksymalny dopuszczalny cykl przesyłania w procentach (1-100). Automatycznie dostosowuje współczynnik czasu przesyłania.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '(Dla urządzeń) Zastępuje klucz prywatny identyfikujący urządzenie. Wymagana jest ponowna uruchomienie urządzenia, aby zastosować zmianę. Generuje nowy klucz publiczny.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(tylko SX126x) Włącza wzmocniony sygnał RX, co poprawia czułość przy wyższym poborze prądu.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      'Określa ciąg znaków zawierający dane kontaktowe właściciela, który znajduje się w ogłoszeniach. Użyj \'|\' jako separatora wierszy.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'Ustawia tryb haszowania ścieżki. 0 = stary, 1 = standardowy, 2 = restrykcyjny. Wpływa na sposób dopasowywania ścieżek routingu.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'Ustawia czułość detekcji pętli routingu: wyłączona, minimalna, umiarkowana lub rygorystyczna.';

  @override
  String get repeater_cliHelpSetFreq =>
      '(Dla urządzeń szeregowych) Szybko ustawia tylko częstotliwość. Wymagana ponowna uruchomienie. Zaleca się użycie opcji \"ustawienie radia\" w celu ustawienia wszystkich parametrów radia.';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(Tylko most ESPNow) Ustawia kanał WiFi (od 1 do 14), który jest wykorzystywany przez most.';

  @override
  String get repeater_cliHelpGetName =>
      'Wyświetla nazwę skonfigurowanego węzła.';

  @override
  String get repeater_cliHelpGetRole =>
      'Pokazuje rolę oprogramowania (np. repeater, serwer dla pokoju).';

  @override
  String get repeater_cliHelpGetPublicKey =>
      'Wyświetla publiczny klucz urządzenia.';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '(Tylko dla serialu) Wyświetla prywatny klucz urządzenia. Traktuj go jako poufny.';

  @override
  String get repeater_cliHelpGetRepeat =>
      'Pokazuje, czy funkcja przekierowywania pakietów (funkcja repeatera) jest włączona lub wyłączona.';

  @override
  String get repeater_cliHelpGetTx => 'Pokazuje aktualną moc transmisji w dBm.';

  @override
  String get repeater_cliHelpGetFreq =>
      'Pokazuje skonfigurowaną częstotliwość radiową w MHz.';

  @override
  String get repeater_cliHelpGetRadio =>
      'Wyświetla pełne parametry radia: częstotliwość, szerokość pasma, współczynnik modulacji, stopień kodowania.';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(tylko SX126x) Wyświetla stan wzmocnienia sygnału RX.';

  @override
  String get repeater_cliHelpGetAf =>
      'Pokazuje aktualny współczynnik czasu emisji.';

  @override
  String get repeater_cliHelpGetDutyCycle =>
      'Pokazuje aktualny dopuszczalny cykl pracy w procentach.';

  @override
  String get repeater_cliHelpGetIntThresh =>
      'Pokazuje próg zakłóceń kanału w dB.';

  @override
  String get repeater_cliHelpGetAgcResetInterval =>
      'Pokazuje interwał resetowania AGC w sekundach.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      'Pokazuje, czy tryb podwójnego potwierdzania jest włączony (1) czy wyłączony (0).';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'Pokazuje, czy dostęp dla gości jest ograniczony do odczytu tylko.';

  @override
  String get repeater_cliHelpGetAdvertInterval =>
      'Pokazuje czas trwania lokalnej reklamy w minutach.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'Pokazuje interwał reklamowy dotyczący powodzi w godzinach.';

  @override
  String get repeater_cliHelpGetGuestPassword =>
      'Wyświetla ustawione hasło dla gościa.';

  @override
  String get repeater_cliHelpGetLat =>
      'Pokazuje ustawioną szerokość geograficzną.';

  @override
  String get repeater_cliHelpGetLon =>
      'Pokazuje ustawioną długość geograficzną.';

  @override
  String get repeater_cliHelpGetRxDelay =>
      'Pokazuje bazową wartość opóźnienia RX.';

  @override
  String get repeater_cliHelpGetTxDelay =>
      'Pokazuje współczynnik opóźnienia transmisji w trybie zalewowym.';

  @override
  String get repeater_cliHelpGetDirectTxDelay =>
      'Pokazuje współczynnik opóźnienia w trybie bezpośrednim.';

  @override
  String get repeater_cliHelpGetFloodMax =>
      'Pokazuje maksymalną liczbę skoków spowodowanych powodzią.';

  @override
  String get repeater_cliHelpGetOwnerInfo =>
      'Wyświetla ciąg znaków zawierający dane kontaktowe właściciela.';

  @override
  String get repeater_cliHelpGetPathHashMode =>
      'Pokazuje tryb haszujący ścieżkę (0/1/2).';

  @override
  String get repeater_cliHelpGetLoopDetect =>
      'Pokazuje czułość detekcji pętli.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(Tylko dla seriali) Wyświetla wpisy kontroli dostępu w repeaterze.';

  @override
  String get repeater_cliHelpGetBridgeEnabled =>
      'Pokazuje, czy most jest włączony.';

  @override
  String get repeater_cliHelpGetBridgeDelay =>
      'Pokazuje opóźnienie mostu w milisekundach.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'Pokazuje, czy most odbiera pakiety RX lub TX.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(Tylko interfejs RS232) Wyświetla prędkość transmisji na interfejsie RS232.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(Tylko moduł ESPNow) Wyświetla kanał WiFi modułu.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(Tylko most ESPNow) Wyświetla sekret udostępniony przez most.';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '(tylko dla NRF52) Wyświetla wersję bootloadera.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'Pokazuje wzmacniacz ADC (skalowanie napięcia baterii).';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      'Informuje, czy rada nadzorcza posiada wsparcie w zakresie zarządzania energią.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      'Pokazuje aktualne źródło zasilania: zewnętrzne lub bateryjne.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      'Pokazuje najnowsze przyczyny resetowania i wyłączania.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv =>
      'Pokazuje napięcie baterii podczas uruchamiania systemu w milivoltach (mV).';

  @override
  String get repeater_cliHelpSensorGet =>
      'Odczytuje ustawienie czujnika zdefiniowane za pomocą klawisza.';

  @override
  String get repeater_cliHelpSensorSet =>
      'Tworzy niestandardowe ustawienia dla czujnika.';

  @override
  String get repeater_cliHelpSensorList =>
      'Wyświetla wszystkie ustawienia dla niestandardowych czujników, podzielone na strony, z opcjonalnym indeksem początkowym.';

  @override
  String get repeater_cliHelpRegionDefault =>
      'Pokazuje aktualny domyślny zakres regionu.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'Ustawia domyślny zakres regionu. Użyj wartości \"<null>\", aby go zresetować.';

  @override
  String get repeater_cliHelpRegionListAllowed =>
      'Wymienia regiony, w których dopuszczony jest ruch związany z powodzami.';

  @override
  String get repeater_cliHelpRegionListDenied =>
      'Wymienia regiony, w których ruch związany z powodziami jest ograniczony.';

  @override
  String get repeater_cliHelpStatsPackets =>
      '(Tylko dla serialu) Prezentuje statystyki na poziomie pakietów.';

  @override
  String get repeater_cliHelpStatsRadio =>
      '(Tylko serial) Prezentuje statystyki dotyczące nadawania radiowego.';

  @override
  String get repeater_cliHelpStatsCore =>
      '(Tylko wersja serialowa) Wyświetla podstawowe statystyki o oprogramowaniu.';

  @override
  String get telemetry_receivedData => 'Odebrane dane telemetrii';

  @override
  String get telemetry_requestTimeout =>
      'Przekroczono czas oczekiwania na telemetrię.';

  @override
  String telemetry_errorLoading(String error) {
    return 'Błąd podczas ładowania telemetrii: $error';
  }

  @override
  String get telemetry_noData => 'Brak dostępnych danych telemetrycznych.';

  @override
  String telemetry_channelTitle(int channel) {
    return 'Kanał $channel';
  }

  @override
  String get telemetry_batteryLabel => 'Bateria';

  @override
  String get telemetry_voltageLabel => 'Napięcie';

  @override
  String get telemetry_mcuTemperatureLabel => 'Temperatura MCU';

  @override
  String get telemetry_temperatureLabel => 'Temperatura';

  @override
  String get telemetry_currentLabel => 'Prąd';

  @override
  String telemetry_batteryValue(int percent, String volts) {
    return '$percent% / $volts W';
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
  String get telemetry_digitalInputLabel => 'Wejście cyfrowe';

  @override
  String get telemetry_digitalOutputLabel => 'Wyjście cyfrowe';

  @override
  String get telemetry_analogInputLabel => 'Wejście analogowe';

  @override
  String get telemetry_analogOutputLabel => 'Wyjście analogowe';

  @override
  String get telemetry_genericLabel => 'Czujnik ogólny';

  @override
  String get telemetry_luminosityLabel => 'Jasność';

  @override
  String get telemetry_presenceLabel => 'Obecność';

  @override
  String get telemetry_humidityLabel => 'Wilgotność';

  @override
  String get telemetry_accelerometerLabel => 'Akcelerometr';

  @override
  String get telemetry_pressureLabel => 'Ciśnienie';

  @override
  String get telemetry_altitudeLabel => 'Wysokość';

  @override
  String get telemetry_frequencyLabel => 'Częstotliwość';

  @override
  String get telemetry_percentageLabel => 'Procent';

  @override
  String get telemetry_concentrationLabel => 'Stężenie';

  @override
  String get telemetry_powerLabel => 'Moc';

  @override
  String get telemetry_distanceLabel => 'Odległość';

  @override
  String get telemetry_energyLabel => 'Energia';

  @override
  String get telemetry_directionLabel => 'Kierunek';

  @override
  String get telemetry_timeLabel => 'Czas';

  @override
  String get telemetry_gyrometerLabel => 'Żyrometr';

  @override
  String get telemetry_colourLabel => 'Kolor';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'Przełącznik';

  @override
  String get telemetry_polylineLabel => 'Polilinia';

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
  String get telemetry_autoFetchQuantity => 'Liczba żądań';

  @override
  String get telemetry_error => 'Nie udało się pobrać danych';

  @override
  String get neighbors_receivedData => 'Otrzymano dane sąsiedztwa';

  @override
  String get neighbors_requestTimedOut =>
      'Sąsiedzi proszą o wyłączenie timingu.';

  @override
  String neighbors_errorLoading(String error) {
    return 'Błąd podczas ładowania sąsiadów: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => 'Sąsiedzi przekaźników';

  @override
  String get neighbors_noData => 'Brak danych dotyczących sąsiadów.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return 'Nieznana $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return 'Usłyszano: $time temu';
  }

  @override
  String get channelPath_title => 'Ścieżka pakietu';

  @override
  String get channelPath_viewMap => 'Wyświetl mapę';

  @override
  String get channelPath_otherObservedPaths => 'Inne zaobserwowane ścieżki';

  @override
  String get channelPath_repeaterHops => 'Skoki przekaźników';

  @override
  String get channelPath_noHopDetails =>
      'Szczegóły dotyczące tego pakietu nie zostały podane.';

  @override
  String get channelPath_sourceLabel => 'Źródło';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'Ta wiadomość przyszła przez MQTT. Twoje radio jej nie odebrało, więc nie ma ścieżki radiowej od Twojego radia.';

  @override
  String get channelPath_messageDetails => 'Szczegóły wiadomości';

  @override
  String get channelPath_senderLabel => 'Nadawca';

  @override
  String get channelPath_timeLabel => 'Czas';

  @override
  String get channelPath_repeatsLabel => 'Powtórzenia';

  @override
  String channelPath_pathLabel(int index) {
    return 'Ścieżka $index';
  }

  @override
  String get channelPath_observedLabel => 'Obserwowane';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return 'Obserwowana ścieżka $index • $hops';
  }

  @override
  String get channelPath_noLocationData => 'Brak danych lokalizacyjnych';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => 'Nieznane';

  @override
  String get channelPath_floodPath => 'Zalew';

  @override
  String get channelPath_directPath => 'Bezpośrednio';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 z $total skoków';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed z $total skoków';
  }

  @override
  String get channelPath_mapTitle => 'Mapa ścieżek';

  @override
  String get channelPath_noRepeaterLocations =>
      'Brak dostępnych lokalizacji przekaźników dla tej ścieżki.';

  @override
  String channelPath_primaryPath(int index) {
    return 'Ścieżka $index (Główna)';
  }

  @override
  String get channelPath_pathLabelTitle => 'Ścieżka';

  @override
  String get channelPath_observedPathHeader => 'Obserwowana ścieżka';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable =>
      'Brak dostępnych szczegółów hopa dla tego pakietu.';

  @override
  String get channelPath_unknownRepeater => 'Nieznany Przekaźnik';

  @override
  String get community_title => 'Społeczność';

  @override
  String get community_create => 'Utwórz Społeczność';

  @override
  String get community_createDesc =>
      'Utwórz nową społeczność i udostępnij za pomocą kodu QR.';

  @override
  String get community_join => 'Dołącz';

  @override
  String get community_joinTitle => 'Dołącz do społeczności';

  @override
  String community_joinConfirmation(String name) {
    return 'Czy chcesz dołączyć do społeczności \"$name\"?';
  }

  @override
  String get community_scanQr => 'Skanuj QR kod społeczności';

  @override
  String get community_scanInstructions =>
      'Skieruj kamerę w kierunku kodu QR społeczności.';

  @override
  String get community_showQr => 'Pokaż kod QR';

  @override
  String get community_publicChannel => 'Społeczność Publiczna';

  @override
  String get community_hashtagChannel => 'Hashtag Społeczności';

  @override
  String get community_name => 'Nazwa Społeczności';

  @override
  String get community_enterName => 'Wprowadź nazwę społeczności';

  @override
  String community_created(String name) {
    return 'Społeczność \"$name\" została utworzona';
  }

  @override
  String community_joined(String name) {
    return 'Dołączył do społeczności \"$name\"';
  }

  @override
  String get community_qrTitle => 'Dziel się Społecznością';

  @override
  String community_qrInstructions(String name) {
    return 'Skanuj ten kod QR, aby dołączyć $name';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'Kanały hashtagowe społeczności są dostępne tylko dla członków społeczności';

  @override
  String get community_invalidQrCode => 'Nieprawidłowy kod QR społeczności.';

  @override
  String get community_alreadyMember => 'Już jesteś członkiem.';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'Jesteś już członkiem \"$name\".';
  }

  @override
  String get community_addPublicChannel => 'Dodaj Kanał Publiczny Społeczności';

  @override
  String get community_addPublicChannelHint =>
      'Automatycznie dodaj kanał publiczny dla tej społeczności.';

  @override
  String get community_noCommunities =>
      'Nie dołączono jeszcze żadnych społeczności.';

  @override
  String get community_scanOrCreate =>
      'Skanuj kod QR lub utwórz społeczność, aby zacząć.';

  @override
  String get community_manageCommunities => 'Zarządzaj Grupami';

  @override
  String get community_delete => 'Opuszczenie Społeczności';

  @override
  String community_deleteConfirm(String name) {
    return 'Opuścić \"$name\"?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return 'Spowoduje to również usunięcie $count kanału/kanałów i ich wiadomości.';
  }

  @override
  String community_deleted(String name) {
    return 'Opuszczono społeczność \"$name\"';
  }

  @override
  String get community_regenerateSecret => 'Zregeneruj sekret';

  @override
  String community_regenerateSecretConfirm(String name) {
    return 'Regeneruj tajny klucz dla \"$name\"? Wszyscy członkowie będą musieli zeskanować nowy kod QR, aby kontynuować komunikację.';
  }

  @override
  String get community_regenerate => 'Zregeneruj';

  @override
  String community_secretRegenerated(String name) {
    return 'Hasło ponownie wygenerowane dla \"$name\"';
  }

  @override
  String get community_updateSecret => 'Zaktualizuj tajny klucz';

  @override
  String community_secretUpdated(String name) {
    return 'Hasło zaktualizowane dla \"$name\"';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return 'Skanuj nowy kod QR, aby zaktualizować sekret dla \"$name\"';
  }

  @override
  String get community_addHashtagChannel => 'Dodaj hashtag społeczności';

  @override
  String get community_addHashtagChannelDesc =>
      'Dodaj kanał z hashtagiem dla tej społeczności';

  @override
  String get community_selectCommunity => 'Wybierz społeczność';

  @override
  String get community_regularHashtag => 'Hashtag regular';

  @override
  String get community_regularHashtagDesc =>
      'Publiczny hashtag (każdy może dołączyć)';

  @override
  String get community_communityHashtag => 'Hashtag Społeczności';

  @override
  String get community_communityHashtagDesc =>
      'Dostępne tylko dla członków społeczności';

  @override
  String community_forCommunity(String name) {
    return 'Dla $name';
  }

  @override
  String get listFilter_tooltip => 'Filtruj i sortuj';

  @override
  String get listFilter_sortBy => 'Sortuj po';

  @override
  String get listFilter_latestMessages => 'Najnowsze wiadomości';

  @override
  String get listFilter_heardRecently => 'Słyszano niedawno';

  @override
  String get listFilter_az => 'Od A do Z';

  @override
  String get listFilter_filters => 'Filtry';

  @override
  String get listFilter_all => 'Wszystko';

  @override
  String get listFilter_favorites => 'Ulubione';

  @override
  String get listFilter_addToFavorites => 'Dodaj do ulubionych';

  @override
  String get listFilter_removeFromFavorites => 'Usuń z ulubionych';

  @override
  String get listFilter_users => 'Użytkownicy';

  @override
  String get listFilter_repeaters => 'Przekaźniki';

  @override
  String get listFilter_roomServers => 'Serwery pokoju';

  @override
  String get listFilter_unreadOnly => 'Tylko nieprzeczytane';

  @override
  String get listFilter_newGroup => 'Nowa grupa';

  @override
  String get pathTrace_you => 'Ty';

  @override
  String get pathTrace_failed => 'Śledzenie ścieżki nie powiodło się.';

  @override
  String get pathTrace_notAvailable => 'Ścieżka śledzenia niedostępna.';

  @override
  String get pathTrace_refreshTooltip => 'Odśwież ścieżkę.';

  @override
  String get pathTrace_someHopsNoLocation =>
      'Jeden lub więcej z chmieli nie ma określonej lokalizacji!';

  @override
  String get pathTrace_clearTooltip => 'Wyczyść ścieżkę';

  @override
  String get losSelectStartEnd => 'Wybierz węzły początkowe i końcowe dla LOS.';

  @override
  String losRunFailed(String error) {
    return 'Sprawdzenie pola widzenia nie powiodło się: $error';
  }

  @override
  String get losClearAllPoints => 'Wyczyść wszystkie punkty';

  @override
  String get losRunToViewElevationProfile =>
      'Uruchom LOS, aby wyświetlić profil wysokości';

  @override
  String get losMenuTitle => 'Menu LOS';

  @override
  String get losMenuSubtitle =>
      'Stuknij węzły lub naciśnij i przytrzymaj mapę, aby uzyskać niestandardowe punkty';

  @override
  String get losShowDisplayNodes => 'Pokaż węzły wyświetlające';

  @override
  String get losCustomPoints => 'Punkty niestandardowe';

  @override
  String losCustomPointLabel(int index) {
    return 'Niestandardowe $index';
  }

  @override
  String get losPointA => 'Punkt A';

  @override
  String get losPointB => 'Punkt B';

  @override
  String losAntennaA(String value, String unit) {
    return 'Antena A: $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return 'Antena B: $value $unit';
  }

  @override
  String get losRun => 'Uruchom LOS-a';

  @override
  String get losNoElevationData => 'Brak danych o wysokości';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, czysty LOS, minimalny prześwit $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, zablokowane przez $obstruction $heightUnit';
  }

  @override
  String get losStatusChecking => 'LOS: sprawdzam...';

  @override
  String get losStatusNoData => 'LOS: brak danych';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS: $clear/$total jasne, $blocked zablokowane, $unknown nieznane';
  }

  @override
  String get losErrorElevationUnavailable =>
      'Dane dotyczące wysokości są niedostępne dla jednej lub większej liczby próbek.';

  @override
  String get losErrorInvalidInput =>
      'Nieprawidłowe dane punktów/wysokości do obliczenia LOS.';

  @override
  String get losRenameCustomPoint => 'Zmień nazwę punktu niestandardowego';

  @override
  String get losPointName => 'Nazwa punktu';

  @override
  String get losShowPanelTooltip => 'Pokaż panel LOS';

  @override
  String get losHidePanelTooltip => 'Ukryj panel LOS';

  @override
  String get losElevationAttribution =>
      'Dane dotyczące wysokości: Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'Horyzont radiowy';

  @override
  String get losLegendLosBeam => 'Linia widoczności';

  @override
  String get losLegendTerrain => 'Teren';

  @override
  String get losBlockedSpotsTitle => 'Zablokowane miejsca';

  @override
  String get losBlockedSpotsHint =>
      'Kliknij zablokowane miejsce, aby je zaznaczyć na mapie.';

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
  String get losSelectedObstructionTitle => 'Wybór przeszkody';

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
  String get losFrequencyLabel => 'Częstotliwość';

  @override
  String get losFrequencyInfoTooltip => 'Zobacz szczegóły obliczenia';

  @override
  String get losFrequencyDialogTitle => 'Obliczanie horyzontu radiowego';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'Zaczynając od k=$baselineK przy $baselineFreq MHz, obliczenia korygują współczynnik k dla bieżącego pasma $frequencyMHz MHz, które definiuje zakrzywiony limit horyzontu radiowego.';
  }

  @override
  String get contacts_pathTrace => 'Śledzenie Ścieżek';

  @override
  String get contacts_ping => 'Pingować';

  @override
  String get contacts_repeaterPathTrace => 'Śledzenie ścieżki do przekaźnika';

  @override
  String get contacts_repeaterPing => 'Ping przekaźnika';

  @override
  String get contacts_roomPathTrace =>
      'Śledzenie ścieżki do serwera pokojowego';

  @override
  String get contacts_roomPing => 'Pinguj serwer pokoju';

  @override
  String get contacts_chatTraceRoute => 'Śledź trasę promienia';

  @override
  String contacts_pathTraceTo(String name) {
    return 'Śledź trasę do $name';
  }

  @override
  String get contacts_clipboardEmpty => 'Schowek jest pusty.';

  @override
  String get contacts_invalidAdvertFormat => 'Nieprawidłowe dane kontaktowe';

  @override
  String get contacts_contactImported => 'Kontakt został zaimportowany.';

  @override
  String get contacts_contactImportFailed =>
      'Kontakt nie został zaimportowany.';

  @override
  String get contacts_zeroHopAdvert => 'Rozgłoszenie zero-hop';

  @override
  String get contacts_floodAdvert => 'Rozgłoszenie zalewowe';

  @override
  String get contacts_copyAdvertToClipboard => 'Kopiuj rozgłoszenie do schowka';

  @override
  String get contacts_addContactFromClipboard => 'Dodaj kontakt z schowka';

  @override
  String get contacts_ShareContact => 'Kopiuj kontakt do schowka';

  @override
  String get contacts_ShareContactZeroHop =>
      'Udostępnij kontakt przez rozgłoszenie';

  @override
  String get contacts_zeroHopContactAdvertSent =>
      'Wysłano kontakt przez rozgłoszenie.';

  @override
  String get contacts_zeroHopContactAdvertFailed =>
      'Nie udało się wysłać kontaktu.';

  @override
  String get contacts_contactAdvertCopied =>
      'Rozgłoszenie skopiowano do schowka.';

  @override
  String get contacts_contactAdvertCopyFailed =>
      'Kopiowanie rozgłoszenia do schowka nie powiodło się.';

  @override
  String get notification_activityTitle => 'Aktywność MeshCore';

  @override
  String notification_messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'wiadomości',
      many: 'wiadomości',
      few: 'wiadomości',
      one: 'wiadomość',
    );
    return '$count $_temp0';
  }

  @override
  String notification_channelMessagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'wiadomości kanału',
      many: 'wiadomości kanału',
      few: 'wiadomości kanału',
      one: 'wiadomość kanału',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'nowych węzłów',
      many: 'nowych węzłów',
      few: 'nowe węzły',
      one: 'nowy węzeł',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return 'Nowy $contactType wykryty';
  }

  @override
  String get notification_receivedNewMessage => 'Otrzymano nową wiadomość';

  @override
  String get settings_gpxExportRepeaters =>
      'Eksportuj przekaźniki / roomservery do GPX';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'Eksportuje przekaźniki / roomservery z lokalizacją do pliku GPX.';

  @override
  String get settings_gpxExportContacts => 'Eksportuj towarzyszy do GPX';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'Eksportuje towarzyszy z lokalizacją do pliku GPX.';

  @override
  String get settings_gpxExportAll => 'Eksportuj wszystkie kontakty do GPX';

  @override
  String get settings_gpxExportAllSubtitle =>
      'Eksportuje wszystkie kontakty z lokalizacją do pliku GPX.';

  @override
  String get settings_gpxExportSuccess => 'Pomyślnie wyeksportowano plik GPX.';

  @override
  String get settings_gpxExportNoContacts =>
      'Brak kontaktów do wyeksportowania.';

  @override
  String get settings_gpxExportNotAvailable =>
      'Nie obsługiwane na Twoim urządzeniu/systemie operacyjnym';

  @override
  String get settings_gpxExportError => 'Wystąpił błąd podczas eksportowania.';

  @override
  String get settings_gpxExportRepeatersRoom =>
      'Lokalizacje przekaźników i roomserverów';

  @override
  String get settings_gpxExportChat => 'Lokalizacje towarzyszy';

  @override
  String get settings_gpxExportAllContacts => 'Wszystkie lokalizacje kontaktów';

  @override
  String get settings_gpxExportShareText =>
      'Dane mapy wyeksportowane z NOTORYX Core';

  @override
  String get settings_gpxExportShareSubject =>
      'Eksport danych mapy GPX NOTORYX Core';

  @override
  String get snrIndicator_nearByRepeaters => 'Pobliskie przekaźniki';

  @override
  String get snrIndicator_lastSeen => 'Ostatnio widziany';

  @override
  String get contactsSettings_title => 'Ustawienia kontaktów';

  @override
  String get contactsSettings_autoAddTitle => 'Automatyczne odnajdywanie';

  @override
  String get contactsSettings_otherTitle =>
      'Inne ustawienia związane z kontaktami';

  @override
  String get contactsSettings_autoAddUsersTitle =>
      'Automatycznie dodaj użytkowników';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      'Pozwól towarzyszowi automatycznie dodawać znalezione użytkowników.';

  @override
  String get contactsSettings_autoAddRepeatersTitle =>
      'Automatyczne dodawanie przekaźników';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      'Zezwól towarzyszowi na automatyczne dodawanie odkrytych przekaźników.';

  @override
  String get contactsSettings_autoAddRoomServersTitle =>
      'Automatycznie dodaj roomservery';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      'Zezwól towarzyszowi na automatyczne dodawanie znalezionych roomserverów.';

  @override
  String get contactsSettings_autoAddSensorsTitle =>
      'Automatycznie dodaj czujniki';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      'Zezwól towarzyszowi na automatyczne dodawanie wykrytych czujników.';

  @override
  String get contactsSettings_overwriteOldestTitle => 'Nadpisz najstarszy';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      'Gdy lista kontaktów jest pełna, najstarszy nieulubiony kontakt zostanie zastąpiony.';

  @override
  String get discoveredContacts_Title => 'Odkryte Kontakty';

  @override
  String get discoveredContacts_noMatching => 'Brak pasujących kontaktów';

  @override
  String get discoveredContacts_searchHint => 'Wyszukaj odkryte kontakty';

  @override
  String get discoveredContacts_contactAdded => 'Kontakt dodany';

  @override
  String get discoveredContacts_addContact => 'Dodaj kontakt';

  @override
  String get discoveredContacts_copyContact => 'Kopiuj kontakt do schowka';

  @override
  String get discoveredContacts_deleteContact => 'Usuń kontakt';

  @override
  String get discoveredContacts_deleteContactAll =>
      'Usuń wszystkie odkryte kontakty';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      'Czy na pewno chcesz usunąć wszystkie znalezione kontakty?';

  @override
  String get chat_sendCooldown =>
      'Prosimy o chwilowe oczekiwanie przed ponownym wysłaniem.';

  @override
  String get appSettings_jumpToOldestUnread =>
      'Przejdź do najstarszego nieodczytanej wiadomości';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      'Przy otwieraniu czatu z nieodczytanymi wiadomościami, przewijaj, aby przejść do pierwszej nieodczytanej wiadomości, zamiast do najnowszej.';

  @override
  String get appSettings_languageHu => 'Węgierski';

  @override
  String get appSettings_languageJa => 'Japoński';

  @override
  String get appSettings_languageKo => 'Koreański';

  @override
  String get radioStats_tooltip => 'Statystyki dotyczące radia i siatki';

  @override
  String get radioStats_screenTitle => 'Statystyki radiowe';

  @override
  String get radioStats_notConnected =>
      'Połącz się z urządzeniem, aby wyświetlić statystyki radiowe.';

  @override
  String get radioStats_firmwareTooOld =>
      'Statystyki radiowe wymagają towarzyszącej oprogramowania w wersji 8 lub nowszej.';

  @override
  String get radioStats_waiting => 'Czekam na dane…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'Poziom szumów: $noiseDbm dBm';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return 'Ostatni poziom RSSI: $rssiDbm dBm';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return 'Ostatni poziom SNR: $snr dB';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'Czas emisji w stacji TX (całkowity): $seconds s';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'Czas wykorzystania kanału RX (całkowity): $seconds s';
  }

  @override
  String get radioStats_chartCaption =>
      'Poziom szumów (dBm) w ostatnich próbkach.';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'Poziom szumów: $noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting => 'Pobieranie danych dotyczących radia…';

  @override
  String get radioStats_settingsTile => 'Statystyki radiowe';

  @override
  String get radioStats_settingsSubtitle =>
      'Szum tła, RSSI, SNR oraz czas dostępny';

  @override
  String get translation_title => 'Tłumaczenie';

  @override
  String get imageMessages_enableTitle => 'Włącz wiadomości ze zdjęciami';

  @override
  String get imageMessages_enableSubtitle =>
      'Przesyłaj zdjęcia przez siatkę. Wymaga jednorazowego pobrania modelu obrazu.';

  @override
  String get imageMessages_modelSectionTitle => 'Model obrazowy';

  @override
  String get imageMessages_downloadModel => 'Pobierz';

  @override
  String get imageMessages_cancelDownload => 'Anuluj';

  @override
  String get imageMessages_removeModel => 'Usuń model';

  @override
  String get imageMessages_modelReady => 'Gotowy';

  @override
  String get imageMessages_modelNotPublished =>
      'Nie opublikowane — ten build nie może tego pobrać.';

  @override
  String get imageMessages_downloadFailed =>
      'Model obrazowy nie mógł zostać pobrany.';

  @override
  String get imageMessages_autoProcessTitle =>
      'Obrazki są przetwarzane automatycznie.';

  @override
  String get imageMessages_autoProcessSubtitle =>
      'Odbuduj każde zdjęcie, jak tylko przyjdzie. Zużywa około 2 GB pamięci za każdą drugą sekundę; wyłącz odbudowywanie jednym dotknięciem.';

  @override
  String get translation_enableTitle => 'Włącz tłumaczenie';

  @override
  String get translation_enableSubtitle =>
      'Tłumaczenie otrzymywanych wiadomości oraz umożliwienie tłumaczenia przed wysłaniem.';

  @override
  String get translation_composerTitle => 'Przekład przed wysłaniem';

  @override
  String get translation_composerSubtitle =>
      'Kontroluje domyślny stan ikony tłumaczenia w edytorze.';

  @override
  String get translation_autoIncomingTitle =>
      'Automatycznie tłumacz wiadomości';

  @override
  String get translation_autoIncomingSubtitle =>
      'Automatycznie tłumaczy wiadomości do powiadomień oraz do czatów lub kanałów.';

  @override
  String get translation_translateMessage => 'Przetłumacz wiadomość';

  @override
  String get translation_targetLanguage => 'Język docelowy';

  @override
  String get translation_useAppLanguage => 'Użyj języka aplikacji';

  @override
  String get translation_downloadedModelLabel => 'Pobudowany model';

  @override
  String get translation_presetModelLabel => 'Wspólny model Hugging Face';

  @override
  String get translation_manualUrlLabel => 'Adres URL do wersji manualnej';

  @override
  String get translation_downloadModel => 'Pobierz model';

  @override
  String get translation_downloading => 'Pobieranie...';

  @override
  String get translation_working => 'Praca...';

  @override
  String get translation_stop => 'Zatrzymaj się';

  @override
  String get translation_mergingChunks =>
      'Scalanie pobranych fragmentów w jeden plik końcowy...';

  @override
  String get translation_downloadedModels => 'Pobrane modele';

  @override
  String get translation_deleteModel => 'Usuń model';

  @override
  String get translation_modelDownloaded => 'Model tłumaczenia został pobrany.';

  @override
  String get translation_downloadStopped => 'Pobieranie zakończone.';

  @override
  String translation_downloadFailed(String error) {
    return 'Nie udało się pobrać: $error';
  }

  @override
  String get translation_enterUrlFirst => 'Najpierw wprowadź adres URL modelu.';

  @override
  String get scanner_linuxPairingShowPin => 'Pokaż PIN';

  @override
  String get scanner_linuxPairingHidePin => 'Ukryj PIN';

  @override
  String get scanner_linuxPairingPinTitle => 'Kod PIN parowania Bluetooth';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return 'Wprowadź kod PIN dla $deviceName (pozostaw puste, jeśli brak).';
  }

  @override
  String get translation_messageTranslation => 'Tłumaczenie wiadomości';

  @override
  String get translation_translateBeforeSending => 'Przekład przed wysłaniem';

  @override
  String get translation_composerEnabledHint =>
      'Komunikaty zostaną przetłumaczone przed wysłaniem.';

  @override
  String get translation_composerDisabledHint =>
      'Wysyłaj wiadomości w oryginalnym, wpisanym formacie.';

  @override
  String translation_translateTo(String language) {
    return 'Tłumacz na $language';
  }

  @override
  String get translation_translationOptions => 'Opcje tłumaczenia';

  @override
  String get translation_systemLanguage => 'Język systemu';

  @override
  String get background_serviceTitle => 'MeshCore running';

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
  String get map_zoomIn => 'Przybliż';

  @override
  String get map_zoomOut => 'Przybliż z powrotem';

  @override
  String get map_centerMap => 'Mapa centrum';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'Web Bluetooth wymaga przeglądarki Chromium.';

  @override
  String channels_communityShortId(String id) {
    return 'ID: $id...';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'GPS potwierdzone';

  @override
  String get pathTrace_legendInferred => 'Wywnioskowana pozycja';

  @override
  String get pathMap_viewSingle => 'Pojedyncza';

  @override
  String get pathMap_viewCombined => 'Połączone';

  @override
  String get pathMap_play => 'Odtwórz';

  @override
  String get pathMap_pause => 'Wstrzymaj';

  @override
  String get pathMap_replay => 'Odtwórz ponownie';

  @override
  String get pathMap_stepBack => 'Poprzedni skok';

  @override
  String get pathMap_stepForward => 'Następny skok';

  @override
  String get pathMap_animationOn => 'Pokaż animację pakietu';

  @override
  String get pathMap_animationOff => 'Ukryj animację pakietu';

  @override
  String pathMap_hopOf(int current, int total) {
    return 'Skok $current z $total';
  }

  @override
  String pathMap_observedPaths(int count) {
    return 'Obserwowane trasy: $count';
  }

  @override
  String get pathMap_primary => 'Główna';

  @override
  String pathMap_alternate(int index) {
    return 'Alt. $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skoku',
      many: '$count skoków',
      few: '$count skoki',
      one: '1 skok',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => 'Wspólny segment';

  @override
  String get pathMap_legendEstimated => 'Szacunkowy segment';

  @override
  String pathMap_sharedNodeCount(int count) {
    return 'Wykorzystywane przez $count ścieżek';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count skoku nie ma lokalizacji — pokazana ścieżka jest niekompletna',
      many:
          '$count skoków nie ma lokalizacji — pokazana ścieżka jest niekompletna',
      few:
          '$count skoki nie mają lokalizacji — pokazana ścieżka jest niekompletna',
      one: '1 skok nie ma lokalizacji — pokazana ścieżka jest niekompletna',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'Pokaż wszystkie';

  @override
  String get pathMap_hidePath => 'Ukryj ścieżkę';

  @override
  String get pathMap_showPath => 'Wyświetl trasę';

  @override
  String get pathMap_collapsePanel => 'Zwiń panel';

  @override
  String get pathMap_expandPanel => 'Rozwiń panel';

  @override
  String get pathMap_noLocation => 'Brak lokalizacji';

  @override
  String get pathMap_followPacket => 'Śledź pakiet';

  @override
  String get pathMap_unfollowPacket => 'Przestań śledzić pakiet';

  @override
  String get imageSend_title => 'Wyślij obraz';

  @override
  String get imageSend_cropNote =>
      'Zmniejszone do 512 × 512 · proporcje nie zostały zachowane';

  @override
  String get imageSend_originalSize => 'Oryginalny';

  @override
  String get imageSend_onAirSize => 'W eterze';

  @override
  String get imageSend_quality => 'Jakość';

  @override
  String get imageSend_qualityStandard => 'Standard';

  @override
  String get imageSend_qualityHigh => 'Wysoko';

  @override
  String get imageSend_packetsLabel => 'Pakiet';

  @override
  String get imageSend_airtimeLabel => 'Czas w eterze';

  @override
  String get imageSend_sizeLabel => 'Payload';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pakietów',
      one: 'pakiet',
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
  String get imageSend_radioUnknownTitle => 'Ustawienia radia nieznane';

  @override
  String get imageSend_radioUnknownBody =>
      'Połącz urządzenie, aby można było obliczyć czas trwania transmisji.';

  @override
  String get imageSend_longSendTitle => 'Długa transmisja';

  @override
  String imageSend_longSendBody(String duration) {
    return 'Ten kanał będzie dostępny przez około $duration.';
  }

  @override
  String get imageSend_floodNote =>
      'Przepływ pakietów: każdy retransmitujący w zasięgu przekazuje każdy pakiet, przez co kanał pozostaje zajęty dłużej niż ten czas.';

  @override
  String get imageSend_parityTitle => 'Pakiet odzysku';

  @override
  String get imageSend_paritySubtitle =>
      'Jedna dodatkowa paczka. Wiadomości grupowe nie są potwierdzane, dzięki czemu odbiorca może odbudować obraz, jeśli zostanie utracona pojedyncza paczka.';

  @override
  String get imageSend_send => 'Wyślij';

  @override
  String get imageSend_cancel => 'Anuluj';

  @override
  String get imageSend_encodeFailed => 'Ten obraz nie mógł zostać zakodowany.';

  @override
  String get imageSend_codecDownloading =>
      'Model obrazowy jest nadal pobierany.';

  @override
  String get imageSend_codecUnavailable =>
      'Wysyłanie obrazu nie jest dostępne na tym urządzeniu.';

  @override
  String get imageSend_codecDisabled =>
      'Wiadomości ze zdjęciami są wyłączone w ustawieniach.';

  @override
  String get imageSend_deviceUnsupported =>
      'Ten radiodysk nie może wysyłać pakietów obrazu. Podłącz urządzenie z oprogramowaniem firmware 13 lub nowszym.';

  @override
  String get imageSend_directMessagesUnsupported =>
      'Obrazy są przesyłane jako dane grupowe, więc można je wysłać tylko do kanału — nie w wiadomości prywatnej.';

  @override
  String get imageSend_tooLarge =>
      'Obraz zakodowany do więcej pakietów niż pozwala format siatki.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pakietów',
      one: 'pakiet',
    );
    return 'Obraz wysłany jako $count $_temp0.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return 'Obraz nie mogł zostać wysłany: $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return 'Wysyłanie obrazu — pakiet $sent z $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'Węzeł $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return 'Otrzymano: $received z $total pakietów';
  }

  @override
  String get receivedImage_queued => 'Oczekiwanie na rozszyfrowanie';

  @override
  String get receivedImage_tapToDecode => 'Kliknij, aby odszyfrować';

  @override
  String get receivedImage_decoding => 'Odtwarzanie… około 1 sekundy';

  @override
  String receivedImage_incomplete(int received, int total) {
    return 'Obraz niepełny — $received z $total pakietów dotarło';
  }

  @override
  String get receivedImage_corrupt => 'Obraz nie może zostać zrekonstruowany';

  @override
  String get receivedImage_decoderMissing =>
      'Otrzymano obraz — dekodowanie obrazu jest nieprawidłowe.';

  @override
  String get receivedImage_evicted => 'Obraz nie jest już przechowywany';

  @override
  String get receivedImage_retry => 'Spróbuj ponownie';

  @override
  String get receivedImage_decodeAgain => 'Zdekoduj ponownie';

  @override
  String get receivedImage_openSettings => 'Ustaw';

  @override
  String get receivedImage_tapToProcess => 'Kliknij, aby przetworzyć';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'pakiety',
      one: 'pakiet',
    );
    return '$bytes bajtów · $packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds sekund';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes minut $seconds sekundy';
  }

  @override
  String get bastion_tagline => 'Komunikacja bez infrastruktury.';

  @override
  String get bastion_nodes => 'Węzły';

  @override
  String get bastion_repeaters => 'Przekaźniki';

  @override
  String get bastion_active1h => 'Aktywne 1 h';

  @override
  String get bastion_mapCoverage => 'Mapa + zasięg';

  @override
  String get bastion_routeIntelligence => 'Analiza tras';

  @override
  String get bastion_repeaterTools => 'Narzędzia przekaźnika';

  @override
  String get bastion_fieldStats => 'Statystyki terenowe';

  @override
  String get bastion_fieldOps => 'Wyprawa + działania w terenie';

  @override
  String get bastion_coverageCapture => 'Rejestracja zasięgu';

  @override
  String get bastion_mapAttribution =>
      'Dane mapy © współtwórcy OpenStreetMap; kafelki od wybranego dostawcy';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count obserwacji',
      many: '$count obserwacji',
      few: '$count obserwacje',
      one: '1 obserwacja',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count unikalnych węzłów',
      many: '$count unikalnych węzłów',
      few: '$count unikalne węzły',
      one: '1 unikalny węzeł',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skoków',
      many: '$count skoków',
      few: '$count skoki',
      one: '1 skok',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minut',
      many: '$count minut',
      few: '$count minuty',
      one: '1 minuta',
    );
    return '$_temp0';
  }

  @override
  String get sos_holdHint =>
      'Przytrzymaj 2 sekundy. Wysyła twoją pozycję do kontaktów wyprawy co 5 minut, dopóki ktoś nie odpowie.';

  @override
  String sos_holdHintChannel(String channel) {
    return 'Przytrzymaj 2 sekundy. Wysyła twoją pozycję do kontaktów wyprawy i na $channel co 5 minut, dopóki ktoś nie odpowie.';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS nie wysłano: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return 'Potwierdzone przez $name. Powtórzenia zatrzymane.';
  }

  @override
  String get sos_waitingForRadio => 'Czekam, aż radio wyśle…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return 'Wysłano $sends z $max razy. Powtórzenia zakończone; jeszcze brak odpowiedzi.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return 'Wysłano $sends z $max razy. Następne o $time.';
  }

  @override
  String get sos_active => 'SOS AKTYWNE';

  @override
  String get sos_stop => 'ZATRZYMAJ';

  @override
  String get sos_imSafe => 'JESTEM BEZPIECZNY';

  @override
  String get sos_holdSemantics => 'SOS. Przytrzymaj, aby wysłać.';

  @override
  String get sos_keepHolding => 'TRZYMAJ DALEJ…';

  @override
  String get sos_holdForSos => 'PRZYTRZYMAJ, ABY WYSŁAĆ SOS';

  @override
  String get sos_blockStorage =>
      'Najpierw usuń błąd zapisu dziennika terenowego.';

  @override
  String get sos_blockNotConnected => 'Połącz radio MeshCore, aby wysłać SOS.';

  @override
  String get sos_blockNoTarget =>
      'Wybierz kontakty wyprawy lub kanał SOS w Zaplanuj wyprawę.';

  @override
  String get checkIn_labelOk => 'Wszystko OK';

  @override
  String get checkIn_labelAtCamp => 'W obozie';

  @override
  String get checkIn_labelDelayed => 'Opóźnienie';

  @override
  String get checkIn_labelHeadingBack => 'Wracam';

  @override
  String get checkIn_blockLoading => 'Wczytywanie wyprawy…';

  @override
  String get checkIn_blockStorage =>
      'Przed wysłaniem usuń błąd zapisu dziennika terenowego.';

  @override
  String get checkIn_blockBusy => 'Trwa wysyłanie meldunku. Poczekaj.';

  @override
  String get checkIn_blockNoContacts =>
      'Wybierz kontakty wyprawy w Zaplanuj wyprawę.';

  @override
  String get checkIn_blockRosterIncomplete =>
      'Niektóre kontakty wyprawy są niedostępne. Sprawdź listę.';

  @override
  String get checkIn_blockNotConnected =>
      'Połącz radio MeshCore, aby się zameldować.';

  @override
  String get checkIn_blockNotActive =>
      'Rozpocznij wyprawę, aby włączyć meldunki.';

  @override
  String get checkIn_notSent => 'Nie wysłano';

  @override
  String checkIn_deliveredToOne(String name) {
    return 'Dostarczono do $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return 'Dostarczono do wszystkich kontaktów ($count)';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return 'Dostarczono do $delivered z $total';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return 'Nie dostarczono: $names';
  }

  @override
  String get checkIn_waitingForRest => 'Czekam na pozostałych';

  @override
  String get checkIn_aContact => 'kontakt';

  @override
  String get checkIn_statusPending => 'Oczekuje';

  @override
  String get checkIn_statusSent => 'Wysłano';

  @override
  String get checkIn_statusDelivered => 'Dostarczono';

  @override
  String get checkIn_statusFailed => 'Niepowodzenie';

  @override
  String get checkIn_explainPending =>
      'W kolejce lokalnie. Nie potwierdza to transmisji radiowej ani odbioru.';

  @override
  String get checkIn_explainSent =>
      'Radio przyjęło wysyłkę. Nie zarejestrowano potwierdzenia dostarczenia.';

  @override
  String get checkIn_explainDelivered =>
      'Aplikacja zarejestrowała potwierdzenie dostarczenia. Nie dowodzi to, że osoba je przeczytała.';

  @override
  String get checkIn_explainFailed =>
      'Brak potwierdzonego dostarczenia. Sprawdź połączenie radiowe, osiągalność odbiorcy i historię ponowień.';

  @override
  String get checkIn_explainUnknown =>
      'Stan dostarczenia jest niedostępny. Nie zakładaj, że ta wiadomość dotarła.';

  @override
  String get tripBrief_heading => 'NOTORYX • Podsumowanie wyprawy MeshCore';

  @override
  String tripBrief_trip(String name) {
    return 'Wyprawa: $name';
  }

  @override
  String tripBrief_status(String status) {
    return 'Stan: $status';
  }

  @override
  String get tripBrief_active => 'Aktywna';

  @override
  String get tripBrief_stopped => 'Zatrzymana';

  @override
  String tripBrief_contacts(String names) {
    return 'Kontakty: $names';
  }

  @override
  String get tripBrief_noneSelected => 'Nie wybrano';

  @override
  String get tripBrief_unavailableContact =>
      'Niedostępny kontakt (sprawdź listę)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return 'Aktywność zaległa po: $minutes min (ten telefon ostrzega, gdy kontakt milknie)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'Przypomnienie o meldunku: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return 'co $minutes min bez meldunku';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'Opcje meldunku: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'Pozycja radia w meldunkach: $value';
  }

  @override
  String get tripBrief_includedMayBeStale => 'Dołączona; może być nieaktualna';

  @override
  String tripBrief_battery(String value) {
    return 'Bateria radia w meldunkach: $value';
  }

  @override
  String get tripBrief_included => 'Dołączona';

  @override
  String get tripBrief_off => 'Wyłączona';

  @override
  String get tripBrief_review =>
      'Przed wysłaniem meldunku sprawdź odbiorców i wiadomość.';

  @override
  String get tripBrief_noProof =>
      'W kolejce lub wysłano nie dowodzi dostarczenia. Potwierdzenie nie dowodzi przeczytania.';

  @override
  String get tripBrief_overdueMeaning =>
      'Zaległy oznacza brak niedawnej aktywności kontaktu; to nie jest potwierdzony nagły wypadek.';

  @override
  String get tripBrief_automations =>
      'Automatyzacje terenowe działają tylko, gdy aplikacja jest aktywna. Ustalcie osobny plan na wypadek utraty kontaktu.';

  @override
  String get tripBrief_sharesOnly =>
      'To podsumowanie tylko udostępnia informacje; nie wysyła wiadomości radiowej ani nie rozpoczyna wyprawy.';

  @override
  String get fieldOps_title => 'Działania terenowe NOTORYX Core';

  @override
  String get fieldOps_tabTrip => 'Wyprawa';

  @override
  String get fieldOps_tabReady => 'Gotowość';

  @override
  String get fieldOps_tabLog => 'Dziennik';

  @override
  String get fieldOps_tabAuto => 'Auto';

  @override
  String get fieldOps_tabCoverage => 'Zasięg';

  @override
  String get fieldOps_tabConnection => 'Połączenie';

  @override
  String get fieldOps_diagnostics => 'Diagnostyka';

  @override
  String get fieldOps_storageLoadError =>
      'Nie udało się wczytać danych terenowych. Zapisane dane zachowano; automatyzacje pozostają wyłączone.';

  @override
  String get fieldOps_storageSaveError =>
      'Nie udało się zapisać danych terenowych. Automatyzacje zatrzymane; dotychczas zapisane dane są zachowane.';

  @override
  String get fieldOps_regionHint =>
      'Wybierz obszar i poziomy powiększenia w Mapach offline.';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • powiększenie $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return 'Nie udało się sprawdzić obszaru mapy: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wyprawa aktywna • $count kontaktów',
      many: 'Wyprawa aktywna • $count kontaktów',
      few: 'Wyprawa aktywna • $count kontakty',
      one: 'Wyprawa aktywna • 1 kontakt',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped =>
      'Wyprawa zatrzymana. Rozpocznij ją, gdy będziesz gotowy.';

  @override
  String fieldOps_reminderAt(String time) {
    return 'Przypomnienie o meldunku o $time';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return 'Zbyt długo cicho: $names';
  }

  @override
  String get fieldOps_planTrip => 'Zaplanuj wyprawę';

  @override
  String get fieldOps_endTrip => 'Zakończ wyprawę';

  @override
  String get fieldOps_startTrip => 'Rozpocznij wyprawę';

  @override
  String get fieldOps_tripBrief => 'Podsumowanie wyprawy';

  @override
  String get fieldOps_connectRadio => 'Połącz radio';

  @override
  String get fieldOps_previewedCheckIns => 'Meldunki z podglądem';

  @override
  String get fieldOps_previewedCheckInsHint =>
      'Wybierz stan, sprawdź rzeczywistych odbiorców i wiadomość, a potem wyślij. W kolejce nie znaczy dostarczono.';

  @override
  String get fieldOps_tripRoster => 'Lista wyprawy';

  @override
  String get fieldOps_rosterEmpty =>
      'Wybierz do sześciu znanych kontaktów czatu w Zaplanuj wyprawę.';

  @override
  String get fieldOps_rosterCaveat =>
      '„Ostatnio słyszany” to dowód wcześniejszej aktywności. Nie potwierdza obecnej osiągalności. Oznaczenia zaległości oznaczają brak niedawnej aktywności kontaktu, a nie potwierdzony nagły wypadek.';

  @override
  String get fieldOps_offlineMaps => 'Mapy offline';

  @override
  String get fieldOps_checkingTiles => 'Sprawdzanie zapisanych kafelków…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kafelków w pamięci.',
      many: '$count kafelków w pamięci.',
      few: '$count kafelki w pamięci.',
      one: '1 kafelek w pamięci.',
    );
    return '$_temp0 Nie gwarantuje to, że cała trasa jest pokryta.';
  }

  @override
  String get fieldOps_downloadAreas => 'Pobierz / sprawdź obszary offline';

  @override
  String fieldOps_lastCheckIn(String time) {
    return 'Ostatni meldunek, $time';
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
      other: 'Wyślij ponownie do $count niedostarczonych',
      many: 'Wyślij ponownie do $count niedostarczonych',
      few: 'Wyślij ponownie do $count niedostarczonych',
      one: 'Wyślij ponownie do 1 niedostarczonego',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable => 'Wybrany kontakt jest niedostępny';

  @override
  String get fieldOps_memberUnavailableHint =>
      'Sprawdź tę wyprawę przed wysłaniem.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return 'Ostatnia aktywność $minutes min temu';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return 'Ostatnia aktywność $minutes min temu • zaległy';
  }

  @override
  String get fieldOps_noCheckInRecorded =>
      'W tym dzienniku nie zapisano meldunku.';

  @override
  String get fieldOps_tripMap => 'Mapa wyprawy';

  @override
  String get fieldOps_tripMapEmpty =>
      'Żaden wybrany kontakt nie rozgłosił jeszcze współrzędnych.';

  @override
  String get fieldOps_lastPositions => 'Ostatnio rozgłoszone pozycje';

  @override
  String get fieldOps_positionsCaveat =>
      'Pozycje mogą być nieaktualne. Ta mapa nie śledzi GPS telefonu ani nie dowodzi, że członkowie są teraz tutaj.';

  @override
  String get fieldOps_briefPreviewTitle => 'Podgląd podsumowania wyprawy';

  @override
  String get fieldOps_briefPreviewHint =>
      'Zawiera nazwy wyprawy i kontaktów. Sprawdź przed udostępnieniem. Współrzędne, klucze i historia wiadomości są pominięte.';

  @override
  String get fieldOps_shareBrief => 'Udostępnij podsumowanie';

  @override
  String get fieldOps_briefSubject => 'Podsumowanie wyprawy NOTORYX Core';

  @override
  String get fieldOps_tripName => 'Nazwa wyprawy';

  @override
  String get fieldOps_defaultTripName => 'Moja wyprawa';

  @override
  String get fieldOps_includePosition => 'Dołącz rozgłaszaną pozycję radia';

  @override
  String get fieldOps_includePositionHint =>
      'Może być nieaktualna; udostępnianie jest domyślnie wyłączone.';

  @override
  String get fieldOps_includeBattery => 'Dołącz baterię radia';

  @override
  String get fieldOps_overdueLabel => 'Ostrzeż mnie, gdy kontakt milczy przez';

  @override
  String get fieldOps_reminderLabel => 'Przypomnij mi o meldunku';

  @override
  String get fieldOps_reminderHelper =>
      'Powiadomienie w telefonie, nawet gdy NOTORYX Core jest zamknięty.';

  @override
  String get fieldOps_reminderOff => 'Wyłączone';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Po $count minutach bez meldunku',
      many: 'Po $count minutach bez meldunku',
      few: 'Po $count minutach bez meldunku',
      one: 'Po 1 minucie bez meldunku',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'SOS trafia też na kanał';

  @override
  String get fieldOps_sosChannelNone => 'Brak';

  @override
  String get fieldOps_selectContacts =>
      'Wybierz do sześciu znanych kontaktów czatu';

  @override
  String get fieldOps_sendCheckInTitle => 'Wysłać meldunek?';

  @override
  String fieldOps_recipients(String names) {
    return 'Do: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      'Używa zwykłych wiadomości bezpośrednich. Dostarczenie będzie śledzone w dzienniku terenowym.';

  @override
  String get fieldOps_send => 'Wyślij';

  @override
  String get fieldOps_beforeYouLeave => 'Zanim wyruszysz';

  @override
  String get fieldOps_radioConnected => 'Radio połączone';

  @override
  String get fieldOps_connectHint => 'Połącz przez Bluetooth, USB lub TCP.';

  @override
  String get fieldOps_radioBattery => 'Bateria radia';

  @override
  String get fieldOps_batteryUnknown => 'Nieznana; sprawdź radio.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent% • naładuj na planowaną wyprawę.';
  }

  @override
  String get fieldOps_tripContacts => 'Kontakty wyprawy';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return 'Dostępne: $available/$selected. Sprawdź, czy mają zgodne radia i kanały.';
  }

  @override
  String get fieldOps_offlineArea => 'Wybrany obszar mapy offline';

  @override
  String get fieldOps_checkingFiles => 'Sprawdzanie plików lokalnych…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return 'Dostępne pliki kafelków: $available/$expected; brakuje: $missing. To migawka; otwórz obszar offline przed wyruszeniem.';
  }

  @override
  String get fieldOps_locationChoice => 'Udostępnianie lokalizacji';

  @override
  String get fieldOps_locationOptedIn =>
      'Włączone: rozgłaszane współrzędne radia mogą być nieaktualne.';

  @override
  String get fieldOps_locationOff =>
      'Udostępnianie jest wyłączone. Twoje meldunki nie zawierają współrzędnych.';

  @override
  String get fieldOps_automationAvailability => 'Dostępność automatyzacji';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'Działa tylko, gdy ta aplikacja jest aktywna. Uśpienie, zamknięcie lub utrata radia mogą uniemożliwić zaplanowane działania.';

  @override
  String get fieldOps_readinessCaveat =>
      'Kontrole gotowości są poglądowe; nie dowodzą zasięgu radia ani nie gwarantują dostarczenia wiadomości.';

  @override
  String get fieldOps_radio => 'Radio';

  @override
  String get fieldOps_refreshChecks => 'Odśwież kontrole';

  @override
  String get fieldOps_searchLog => 'Szukaj w dzienniku terenowym';

  @override
  String get fieldOps_kindAll => 'Wszystko';

  @override
  String get fieldOps_kindCheckIn => 'Meldunek';

  @override
  String get fieldOps_kindReceived => 'Odebrane';

  @override
  String get fieldOps_kindNote => 'Notatka';

  @override
  String get fieldOps_kindDeadZone => 'Martwa strefa';

  @override
  String get fieldOps_kindRadio => 'Radio';

  @override
  String get fieldOps_kindAutomation => 'Automatyzacja';

  @override
  String get fieldOps_kindMissed => 'Pominięte';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => 'Wyprawa';

  @override
  String get fieldOps_kindOverdue => 'Zaległy';

  @override
  String get fieldOps_addNote => 'Dodaj notatkę';

  @override
  String get fieldOps_exportJson => 'Eksportuj JSON';

  @override
  String get fieldOps_deleteLog => 'Usuń dziennik';

  @override
  String get fieldOps_logSubject => 'Dziennik terenowy NOTORYX Core';

  @override
  String get fieldOps_logCaveat =>
      'Przechowywany lokalnie, do 1000 wpisów. Eksporty mogą zawierać klucze kontaktów, wiadomości i lokalizacje; sprawdź przed udostępnieniem.';

  @override
  String get fieldOps_noEntries => 'Brak pasujących wpisów.';

  @override
  String get fieldOps_tripUnspecified => 'Wyprawa nieokreślona';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return 'Zapisana rozgłaszana pozycja radia $latitude, $longitude (może być nieaktualna)';
  }

  @override
  String get fieldOps_noteTitle => 'Obserwacja terenowa';

  @override
  String get fieldOps_noteLabel => 'Co zaobserwowałeś?';

  @override
  String get fieldOps_deadZone => 'Zgłoszona martwa strefa';

  @override
  String get fieldOps_deadZoneHint =>
      'Twoja obserwacja, a nie zweryfikowana prognoza zasięgu.';

  @override
  String get fieldOps_savePosition => 'Zapisz rozgłaszaną pozycję radia';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • może być nieaktualna; to nie GPS telefonu';
  }

  @override
  String get fieldOps_noPosition =>
      'Brak użytecznych rozgłoszonych współrzędnych';

  @override
  String get fieldOps_deleteLogTitle => 'Usunąć dziennik terenowy?';

  @override
  String get fieldOps_deleteLogBody =>
      'Usuwa to wszystkie zapisane wpisy na tym telefonie. Ustawienia wyprawy zostaną zachowane.';

  @override
  String get fieldOps_localAutomations => 'Lokalne automatyzacje';

  @override
  String get fieldOps_enableForTrip => 'Włącz dla tej wyprawy';

  @override
  String get fieldOps_automationsCaveat =>
      'Wyłączone po każdym ponownym uruchomieniu aplikacji. Reguły działają tylko, gdy aplikacja jest aktywna. Pominięte zaplanowane działania pojawiają się w dzienniku terenowym i nigdy nie są nadrabiane seryjnie. Automatyczne meldunki są ograniczone do jednej partii na 10 minut.';

  @override
  String get fieldOps_openBotMode => 'Otwórz tryb bota NOTORYX';

  @override
  String get fieldOps_ruleEnabled => 'Reguła włączona';

  @override
  String get fieldOps_dryRun => 'Próba na sucho';

  @override
  String get fieldOps_dryRunHint =>
      'Zapisz działanie bez wysyłania i powiadamiania.';

  @override
  String get fieldOps_then => 'Wtedy';

  @override
  String get fieldOps_actionLog => 'Zapisz w dzienniku terenowym';

  @override
  String get fieldOps_actionNotify => 'Pokaż lokalne powiadomienie';

  @override
  String get fieldOps_actionCheckIn => 'Wyślij „I\'m OK” do kontaktów wyprawy';

  @override
  String get fieldOps_batteryThreshold => 'Bateria równa lub poniżej';

  @override
  String fieldOps_nextDue(String time) {
    return 'Następne: $time';
  }

  @override
  String get fieldOps_nextDueNone => 'Następne: nie zaplanowano';

  @override
  String get fieldOps_previewInLog => 'Podgląd w dzienniku';

  @override
  String get fieldOps_allowNotifications => 'Zezwól na powiadomienia';

  @override
  String get fieldOps_triggerReconnect => 'GDY radio połączy się ponownie';

  @override
  String get fieldOps_triggerDisconnect => 'GDY radio się rozłączy';

  @override
  String get fieldOps_triggerLowBattery => 'GDY bateria radia przekroczy próg';

  @override
  String get fieldOps_triggerNewNode => 'GDY zostanie dodany nowy węzeł';

  @override
  String get fieldOps_triggerRepeater => 'GDY zostanie dodany nowy przekaźnik';

  @override
  String get fieldOps_triggerScheduled =>
      'GDY nadejdzie pora zaplanowanego meldunku';

  @override
  String get fieldOps_explainConnection => 'Wyjaśnij moje połączenie';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return 'Stan: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      'Telefon jest połączony z radiem. Samo to nie zapewnia trasy do twoich odbiorców.';

  @override
  String get fieldOps_disconnectedHint =>
      'Brak aktywnego połączenia radiowego. Sprawdź uprawnienia Bluetooth, zasilanie i zasięg radia; USB/TCP są dostępne w Połącz radio.';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return 'Meldunki wyprawy czekające na potwierdzenie: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'Czasy ostatniego widzenia i rozgłoszone pozycje węzłów mogą być nieaktualne. Analiza tras pokazuje trasy wyuczone z zaobserwowanych prób; nie wymyśla ścieżek.';

  @override
  String get fieldOps_routeIntelligence => 'Analiza tras';

  @override
  String get fieldOps_coverageIntelligence => 'Analiza zasięgu';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      'Porównaj zarejestrowane obserwacje z dwóch sesji terenowych. Kropki oznaczają rozgłoszone pozycje radia rejestrującego, w których słyszano węzły. Nie oznaczają ciągłego zasięgu. Migawki RSSI/SNR nie są pomiarami dla poszczególnych węzłów.';

  @override
  String get fieldOps_captureSession => 'Zarejestruj sesję';

  @override
  String get fieldOps_refreshHistory => 'Odśwież historię';

  @override
  String get fieldOps_noCoverageSessions => 'Brak zapisanych sesji zasięgu.';

  @override
  String get fieldOps_sessionA => 'Sesja A • morska';

  @override
  String get fieldOps_sessionB => 'Sesja B • bursztynowa';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: unikalne węzły $a • B: unikalne węzły $b';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return 'Wspólne: $shared • Tylko A: $onlyA • Tylko B: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'Niesłyszenie węzła w jednej sesji nie potwierdza martwej strefy. Warunki i czas obserwacji się różnią.';

  @override
  String get fieldOps_heardTooltip =>
      'Obserwacja słyszanego węzła; nie dowód udanego łącza';

  @override
  String get fieldOps_noteTooltip =>
      'Notatka lokalna przy rozgłoszonych współrzędnych radia; może być nieaktualna.';

  @override
  String get bastionHome_aboutTooltip => 'O NOTORYX Core';

  @override
  String get bastionHome_getStarted => 'Zacznij';

  @override
  String get bastionHome_getStartedHint =>
      'Połącz radio i sprawdź pierwszą wiadomość';

  @override
  String get bastionHome_planYourTrip => 'Zaplanuj wyprawę';

  @override
  String get bastionHome_tripActive => 'Wyprawa aktywna';

  @override
  String get bastionHome_tripStopped => 'Wyprawa zatrzymana';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • kontakty: $contacts • nieprzeczytane: $unread';
  }

  @override
  String get bastionHome_checkInOk => 'Meldunek: wszystko OK';

  @override
  String get bastionHome_checkInHint =>
      'Przed wysłaniem sprawdź kontakty i wiadomość. Śledź potwierdzenia w dzienniku terenowym.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return 'Ostatni meldunek: $summary';
  }

  @override
  String get bastionHome_connectRadio => 'Połącz radio';

  @override
  String get bastionHome_connectRadioHint =>
      'Połączenia MeshCore przez Bluetooth, USB i TCP';

  @override
  String get bastionHome_liveDiagnostics => 'Diagnostyka na żywo';

  @override
  String get bastionHome_liveDiagnosticsHint =>
      'Stan radia, sygnał, urządzenie i narzędzia ramek';

  @override
  String get bastionHome_meshDiscovery => 'Wykrywanie sieci mesh';

  @override
  String get bastionHome_meshDiscoveryHint =>
      'Znajdź węzły i zbadaj sieć mesh wokół siebie';

  @override
  String get bastionHome_fieldOpsHint =>
      'Podsumowanie wyprawy, gotowość, dziennik terenowy, automatyzacje i porównanie zasięgu';

  @override
  String get bastionHome_fieldTools => 'Narzędzia terenowe NOTORYX';

  @override
  String get bastionHome_statusActive => 'AKTYWNE';

  @override
  String get bastionHome_consoleOnline => 'Konsola terenowa online';

  @override
  String get bastionHome_consoleReady => 'Konsola terenowa gotowa';

  @override
  String get bastionHome_consoleHint =>
      'Połącz radio, aby uruchomić panel na żywo.';

  @override
  String bastionHome_battery(String value) {
    return 'Bat $value';
  }

  @override
  String get bastionTools_title => 'Narzędzia terenowe';

  @override
  String get bastionTools_backup => 'Szyfrowana kopia zapasowa';

  @override
  String get bastionTools_backupHint =>
      'Zapisz ustawienia, kontakty i klucze, opcjonalnie z historią czatów';

  @override
  String get bastionTools_fieldOpsHint =>
      'Meldunki, gotowość, dziennik terenowy, automatyzacje i porównania';

  @override
  String get bastionTools_mapHint =>
      'Mapa na żywo, sesje rejestracji, narzędzia map offline i regiony';

  @override
  String get bastionTools_pathAnalysis => 'Analiza ścieżek';

  @override
  String get bastionTools_pathHint => 'Trasy, wykrywanie i analiza ścieżek';

  @override
  String get bastionTools_repeaterHint =>
      'Stan, logowanie, telemetria, sąsiedzi i administracja';

  @override
  String get bastionTools_statsHint =>
      'Liczniki sieci mesh na żywo i aktywność kontaktów';

  @override
  String get bastionTools_diagnostics => 'Diagnostyka';

  @override
  String get bastionTools_diagnosticsHint =>
      'Stan radia, informacje o urządzeniu, surowe ramki i eksport';

  @override
  String get bastionTools_about => 'O aplikacji + podziękowania';

  @override
  String get bastionTools_aboutHint =>
      'Wersja NOTORYX Core, oświadczenie o niezależności i licencje open source';

  @override
  String get bastionAbout_title => 'O aplikacji + Podziękowania';

  @override
  String get bastionAbout_intro =>
      'Niezależna społecznościowa aplikacja towarzysząca dla sieci MeshCore. NOTORYX Core nie jest oficjalną aplikacją MeshCore, a włączenie zasobów społeczności nie oznacza partnerstwa ani poparcia.';

  @override
  String get bastionAbout_version => 'Wersja';

  @override
  String get bastionAbout_openSource => 'Podstawa open source';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core powstał na bazie otwartego kodu MeshCore Open na licencji MIT i go modyfikuje. Prace nad przepływem zasięgu uznają też, w stosownych przypadkach, aplikację MeshMapper Flutter App na licencji MIT.';

  @override
  String get bastionAbout_community => 'Społeczność przede wszystkim';

  @override
  String get bastionAbout_communityBody =>
      'Zasoby twórców zewnętrznych pozostają własnością ich twórców. Nie sugeruje się własności ani partnerstwa.';

  @override
  String get bastionAbout_legalese =>
      'NOTORYX Core • Niezależny towarzysz MeshCore';

  @override
  String get bastionAbout_licenses => 'Licencje open source';

  @override
  String get bastionSetup_title => 'Pierwsze kroki z NOTORYX Core';

  @override
  String get bastionSetup_intro =>
      'Połącz, wybierz kontakt, a potem sprawdź wiadomość. Możesz w każdej chwili wrócić do tego przewodnika z panelu.';

  @override
  String get bastionSetup_step1 => '1. Połącz radio MeshCore';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return 'Połączono z $device przez $transport.';
  }

  @override
  String get bastionSetup_noRadio => 'Nie połączono jeszcze radia.';

  @override
  String get bastionSetup_step1Power =>
      'Włącz radio towarzyszące MeshCore. Otwórz Połącz radio i wybierz Bluetooth, USB lub TCP. Zezwól na uprawnienia wymagane dla wybranego połączenia.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Jeśli wyszukiwanie Bluetooth nic nie znajduje, sprawdź, czy Bluetooth jest włączony i czy NOTORYX Core ma uprawnienie Urządzenia w pobliżu w ustawieniach aplikacji Androida. Postępuj zgodnie z dodatkowymi prośbami o uprawnienia wyświetlanymi przez skaner.';

  @override
  String get bastionSetup_connectionDiagnostics => 'Diagnostyka połączenia';

  @override
  String get bastionSetup_step2 => '2. Wybierz kontakt czatu';

  @override
  String get bastionSetup_step2Body =>
      'Poproś partnera w pobliżu ze zgodnymi ustawieniami radia MeshCore o rozgłoszenie swojego węzła. Wybierz poniżej znany kontakt czatu; przekaźnikami zarządza się osobno.';

  @override
  String get bastionSetup_noContacts =>
      'Brak dostępnych kontaktów czatu. Połącz radio i otwórz Wykrywanie sieci mesh.';

  @override
  String get bastionSetup_testRecipient => 'Odbiorca testowy';

  @override
  String get bastionSetup_meshDiscovery => 'Wykrywanie sieci mesh';

  @override
  String get bastionSetup_step3 => '3. Wyślij i sprawdź wiadomość';

  @override
  String get bastionSetup_step3Body =>
      'Otwórz czat, napisz krótką wiadomość testową, sprawdź odbiorcę i dotknij Wyślij. Wróć tutaj, aby zobaczyć najnowszą wiadomość wychodzącą zapisaną od otwarcia przewodnika.';

  @override
  String get bastionSetup_openTestChat => 'Otwórz czat testowy';

  @override
  String get bastionSetup_connectFirst =>
      'Połącz radio, aby otworzyć czat testowy.';

  @override
  String get bastionSetup_chooseRecipient => 'Najpierw wybierz odbiorcę.';

  @override
  String get bastionSetup_noTestMessage =>
      'W tej sesji przewodnika nie zapisano wychodzącej wiadomości testowej.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return 'Najnowsza wiadomość: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'Poproś partnera o potwierdzenie odbioru lub odpowiedź. Zapisane potwierdzenie nie dowodzi przeczytania. Jeśli wiadomość się nie powiedzie, sprawdź ponownie połączenie i odbiorcę.';

  @override
  String get bastionSetup_step4 => '4. Przygotuj się do wyjścia w teren';

  @override
  String get bastionSetup_step4Body =>
      'Zaplanuj kontakty wyprawy i sprawdź pobrane obszary map. Tryb bota i automatyzacje terenowe są na początku wyłączone; automatyzacje terenowe działają tylko, gdy aplikacja jest aktywna.';

  @override
  String get bastionSetup_tripTools => 'Narzędzia wyprawy i gotowości';

  @override
  String get bastionDiag_title => 'Diagnostyka';

  @override
  String get bastionDiag_export => 'Eksportuj diagnostykę';

  @override
  String get bastionDiag_channels => 'Kanały';

  @override
  String get bastionDiag_radio => 'Radio';

  @override
  String get bastionDiag_frequency => 'Częstotliwość';

  @override
  String get bastionDiag_bandwidth => 'Szerokość pasma';

  @override
  String get bastionDiag_spreadingFactor => 'Współczynnik rozpraszania';

  @override
  String get bastionDiag_codingRate => 'Współczynnik kodowania';

  @override
  String get bastionDiag_txPower => 'Moc nadawania';

  @override
  String get bastionDiag_noiseFloor => 'Poziom szumu';

  @override
  String get bastionDiag_device => 'Urządzenie';

  @override
  String get bastionDiag_name => 'Nazwa';

  @override
  String get bastionDiag_manufacturer => 'Producent';

  @override
  String get bastionDiag_firmware => 'Oprogramowanie';

  @override
  String get bastionDiag_battery => 'Bateria';

  @override
  String get bastionDiag_transport => 'Połączenie';

  @override
  String get bastionDiag_deepTools => 'Narzędzia zaawansowane';

  @override
  String get bastionDiag_liveStats => 'Statystyki radia na żywo';

  @override
  String get bastionDiag_liveStatsHint => 'Szum, RSSI, SNR i czas nadawania';

  @override
  String get bastionDiag_frameDebug => 'Debugowanie ramek / BLE';

  @override
  String get bastionDiag_frameDebugHint =>
      'Badaj zdekodowane i surowe odebrane ramki';

  @override
  String get bastionDiag_appLog => 'Dziennik debugowania aplikacji';

  @override
  String get bastionDiag_appLogHint =>
      'Przeglądaj zdarzenia diagnostyczne aplikacji';

  @override
  String get bastionDiag_online => 'Radio online';

  @override
  String get bastionDiag_offline => 'Radio offline';

  @override
  String get bastionDiag_offlineHint =>
      'Połącz towarzysza MeshCore, aby wypełnić diagnostykę na żywo.';

  @override
  String get coverage_title => 'Rejestracja zasięgu';

  @override
  String get coverage_leaveBlocked =>
      'Zatrzymaj i zapisz sesję przed wyjściem.';

  @override
  String get coverage_savedSessions => 'Zapisane sesje';

  @override
  String get coverage_caveat =>
      'RSSI/SNR to migawki radia i mogą dotyczyć innego pakietu. Pozycje to rozgłoszone współrzędne radia, a nie GPS telefonu ani dowód zasięgu. Cyjan: rejestrujący; bursztyn: rozgłoszony węzeł. Nie stosuje się interpolacji.';

  @override
  String get coverage_captureActive => 'Rejestracja aktywna';

  @override
  String get coverage_fieldSession => 'Terenowa sesja zasięgu';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core zapisuje w tej sesji nowo usłyszane węzły, w tym dane tras, metadane węzła/lokalizacji i najbliższą dostępną migawkę RSSI/SNR radia.';

  @override
  String get coverage_disconnectedBody =>
      'Przed rozpoczęciem połącz radio. Rejestracja zasięgu zapisuje obserwacje sieci mesh na żywo z połączonego radia towarzyszącego.';

  @override
  String get coverage_observations => 'Obserwacje';

  @override
  String get coverage_uniqueNodes => 'Unikalne węzły';

  @override
  String get coverage_elapsed => 'Upłynęło';

  @override
  String get coverage_radioConnected => 'Radio połączone';

  @override
  String get coverage_noRadio => 'Brak radia';

  @override
  String get coverage_gpsReady => 'GPS radia gotowy';

  @override
  String get coverage_noGps => 'Brak GPS radia';

  @override
  String get coverage_stopSave => 'Zatrzymaj + zapisz sesję';

  @override
  String get coverage_start => 'Rozpocznij sesję zasięgu';

  @override
  String get coverage_exportJson => 'Eksportuj JSON';

  @override
  String get coverage_exportCsv => 'Eksportuj CSV';

  @override
  String get coverage_liveObservations => 'Obserwacje na żywo';

  @override
  String get coverage_waiting => 'Oczekiwanie na aktywność sieci';

  @override
  String get coverage_waitingBody =>
      'Rozpocznij sesję, a nowo usłyszane aktywne węzły pojawią się tutaj. Wartości RSSI/SNR to migawki radia i nie zawsze da się je jednoznacznie przypisać do konkretnego pakietu.';

  @override
  String get coverage_signalNa => 'sygnał b.d.';

  @override
  String get coverage_snrNa => 'SNR b.d.';

  @override
  String get coverage_gpsUnavailable => 'GPS radia niedostępny';

  @override
  String coverage_pathLine(String path, String location) {
    return 'Ścieżka: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'flood';

  @override
  String get coverage_pathDirect => 'bezpośrednia';

  @override
  String get coverage_shareSubject => 'Sesja zasięgu NOTORYX Core';

  @override
  String get coverage_shareText => 'Eksport rejestracji zasięgu NOTORYX Core';

  @override
  String get coverage_historyTitle => 'Zapisane sesje zasięgu';

  @override
  String coverage_loadFailed(String error) {
    return 'Nie udało się wczytać sesji: $error';
  }

  @override
  String get coverage_deleteTitle => 'Usunąć zapisaną sesję?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count obserwacji zostanie usuniętych z tego urządzenia.',
      many: '$count obserwacji zostanie usuniętych z tego urządzenia.',
      few: '$count obserwacje zostaną usunięte z tego urządzenia.',
      one: '1 obserwacja zostanie usunięta z tego urządzenia.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'Nie udało się usunąć sesji: $error';
  }

  @override
  String get coverage_retention =>
      'Przechowywanych jest 20 najnowszych ukończonych sesji. Udostępnij sesje, które chcesz zachować. Przerwane rejestracje można ponownie otworzyć poniżej.';

  @override
  String get coverage_noSessions =>
      'Brak zapisanych sesji. Zatrzymaj rejestrację, aby ją zapisać.';

  @override
  String get coverage_interrupted => 'Przerwana rejestracja';

  @override
  String get coverage_saved => 'Zapisana';

  @override
  String get coverage_deleteTooltip => 'Usuń sesję';

  @override
  String coverage_exportFailed(String error) {
    return 'Eksport nie powiódł się: $error';
  }

  @override
  String get coverage_sessionTitle => 'Sesja zasięgu';

  @override
  String get coverage_shareJson => 'Udostępnij JSON';

  @override
  String get coverage_shareCsv => 'Udostępnij CSV';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • wiek migawki $age ms';
  }

  @override
  String get coverage_unknown => 'nieznany';

  @override
  String coverage_pathValue(String path) {
    return 'ścieżka $path';
  }

  @override
  String get coverage_recorder => 'Rejestrujący';

  @override
  String get coverage_noCoordinates =>
      'Brak użytecznych współrzędnych w tej sesji. Obserwacje pozostają dostępne poniżej.';

  @override
  String get coverage_osmAttribution =>
      '© współtwórcy OpenStreetMap • mapa bazowa online';

  @override
  String get fieldStats_title => 'Analiza terenowa';

  @override
  String get fieldStats_snapshot => 'Migawka sieci mesh na żywo';

  @override
  String get fieldStats_headline => 'Co NOTORYX Core wie w tej chwili.';

  @override
  String get fieldStats_body =>
      'Te liczniki są obliczane z tabeli kontaktów połączonego MeshCore, lokalizacji, ścieżek i znaczników czasu ostatniego widzenia.';

  @override
  String get fieldStats_total => 'Razem';

  @override
  String get fieldStats_chatNodes => 'Węzły czatu';

  @override
  String get fieldStats_rooms => 'Pokoje';

  @override
  String get fieldStats_sensors => 'Czujniki';

  @override
  String get fieldStats_located => 'Z lokalizacją';

  @override
  String get fieldStats_favorites => 'Ulubione';

  @override
  String get fieldStats_routeSnapshot => 'Migawka tras';

  @override
  String get fieldStats_routed => 'Z trasą';

  @override
  String get fieldStats_direct => 'Bezpośrednie';

  @override
  String get fieldStats_flood => 'Flood';

  @override
  String get fieldStats_pathIntel => 'Analiza ścieżek';

  @override
  String get fieldStats_pathIntelBody =>
      'Analiza tras NOTORYX Core wykorzystuje zapisane próby ścieżek, liczbę skoków, sukcesy/niepowodzenia, czas przejścia i wagi tras, aby pokazać wyuczone trasy.';

  @override
  String get fieldStats_coverageSessions => 'Sesje zasięgu';

  @override
  String get fieldStats_coverageSessionsBody =>
      'Rejestracja zasięgu zapisuje teraz sesje terenowe, przywraca przerwaną pracę, eksportuje obserwacje i nanosi zapisane punkty zasięgu na mapę. RSSI/SNR pozostają najbliższą dostępną migawką radia.';

  @override
  String get mapHub_title => 'Mapa terenowa NOTORYX';

  @override
  String get mapHub_intro =>
      'Mapy na żywo, obszary offline, profile regionalne i terenowe sesje zasięgu NOTORYX Core.';

  @override
  String get mapHub_captureHint =>
      'Rozpocznij i zatrzymaj terenową sesję zasięgu';

  @override
  String get mapHub_badgeNew => 'NOWE';

  @override
  String get mapHub_liveMap => 'Mapa sieci mesh na żywo';

  @override
  String get mapHub_liveMapHint =>
      'Węzły, przekaźniki, pozycje, trasy i narzędzia mapy';

  @override
  String get mapHub_badgeLive => 'NA ŻYWO';

  @override
  String get mapHub_offlinePacks => 'Pakiety map offline';

  @override
  String get mapHub_offlinePacksHint =>
      'Zapisz kafelki map na wyprawy i obszary bez zasięgu';

  @override
  String get mapHub_badgeOffline => 'OFFLINE';

  @override
  String get mapHub_regions => 'Profile regionów';

  @override
  String get mapHub_regionsHint =>
      'Zarządzaj regionalnymi definicjami sieci mesh i pobieraj je';

  @override
  String get mapHub_badgeRegions => 'REGIONY';

  @override
  String get routes_title => 'Analiza tras';

  @override
  String get routes_headline => 'Zobacz, jak ruch przepływa przez sieć mesh.';

  @override
  String get routes_body =>
      'NOTORYX Core porządkuje zapisane trasy na podstawie historii ścieżek wyuczonej już z rzeczywistych prób wysyłania wiadomości i wykrywania.';

  @override
  String get routes_routes => 'Trasy';

  @override
  String get routes_success => 'Sukcesy';

  @override
  String get routes_failed => 'Niepowodzenia';

  @override
  String get routes_routeMap => 'Mapa tras';

  @override
  String get routes_routeMapHint => 'Badaj węzły i ścieżki';

  @override
  String get routes_discover => 'Wykryj';

  @override
  String get routes_discoverHint => 'Znajdź nowe trasy';

  @override
  String get routes_learned => 'Wyuczone trasy';

  @override
  String get routes_none => 'Brak historii tras';

  @override
  String get routes_noneBody =>
      'Używaj sieci mesh normalnie lub uruchom wykrywanie. NOTORYX Core pokaże tu wyuczone trasy, gdy pojawi się historia ścieżek.';

  @override
  String get routes_direct => 'BEZPOŚREDNIA';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tras',
      many: '$count tras',
      few: '$count trasy',
      one: '1 trasa',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return 'NAJLEPSZA  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  waga $weight  •  sukcesy: $success / niepowodzenia: $fail';
  }

  @override
  String routes_fastest(String ms) {
    return 'Najszybsza znana: $ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'Flood: sukcesy: $success / niepowodzenia: $fail';
  }

  @override
  String get repeaterTools_heroLabel => 'Centrum przekaźników';

  @override
  String get repeaterTools_headline =>
      'Zarządzaj infrastrukturą swojej sieci mesh.';

  @override
  String get repeaterTools_body =>
      'Wybierz wykryty przekaźnik, aby się uwierzytelnić i otworzyć jego istniejące narzędzia MeshCore: stan, telemetrię, sąsiadów, ustawienia i CLI.';

  @override
  String get repeaterTools_discovered => 'Wykryte';

  @override
  String get repeaterTools_tools => 'Narzędzia';

  @override
  String get repeaterTools_available => 'Dostępne przekaźniki';

  @override
  String get repeaterTools_unnamed => 'Przekaźnik bez nazwy';

  @override
  String get repeaterTools_statusTelemetry => 'Stan + telemetria';

  @override
  String get repeaterTools_statusTelemetryBody =>
      'Sprawdzaj stan i telemetrię przekaźnika za pomocą istniejących narzędzi zarządzania.';

  @override
  String get repeaterTools_neighbors => 'Sąsiedzi';

  @override
  String get repeaterTools_neighborsBody =>
      'Badaj sąsiednią infrastrukturę i powiązania w sieci mesh.';

  @override
  String get repeaterTools_cli => 'CLI + ustawienia';

  @override
  String get repeaterTools_cliBody =>
      'Uwierzytelnieni administratorzy mają dostęp do istniejącego CLI przekaźnika i narzędzi konfiguracji.';

  @override
  String get repeaterTools_empty =>
      'Nie wykryto jeszcze przekaźników. Połącz radio i najpierw zbadaj sieć mesh.';

  @override
  String get notification_fieldAlertTitle => 'Alert terenowy NOTORYX';

  @override
  String get notification_checkInReminderTitle =>
      'Przypomnienie o meldunku NOTORYX Core';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return 'Brak meldunku od $minutes min w wyprawie $trip. Otwórz NOTORYX Core, aby się zameldować.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return 'Brak sygnału od $name od $minutes min. To nie jest potwierdzony nagły wypadek.';
  }

  @override
  String get notification_aTripContact => 'Kontakt wyprawy';

  @override
  String notification_checkInNotDelivered(String name) {
    return 'Meldunek nie dotarł do $name. Możesz wysłać go ponownie w zakładce Wyprawa.';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return 'SOS potwierdzone przez $name';
  }

  @override
  String get settings_batterySaver => 'Oszczędzanie baterii';

  @override
  String get settings_batterySaverOn =>
      'Włączone: bateria radia co 10 min, GPS co 5 min, statystyki najwyżej raz na minutę, kontrole wyprawy co 1–2 min. Wiadomości, alerty i SOS bez zmian.';

  @override
  String get settings_batterySaverOff =>
      'Rzadziej sprawdzaj radio i wyprawę, aby oszczędzać baterię telefonu i radia. Wiadomości, alerty i SOS bez zmian.';

  @override
  String get settings_readAloud => 'Czytaj na głos nowe wiadomości';

  @override
  String get settings_readAloudHelper =>
      'Gdy NOTORYX Core jest otwarty. Wyciszone kanały pozostają ciche. Każdą wiadomość można też odczytać z jej menu.';

  @override
  String get settings_readAloudOff => 'Wyłączone';

  @override
  String get settings_readAloudDirect => 'Wiadomości bezpośrednie';

  @override
  String get settings_readAloudAll => 'Wiadomości bezpośrednie i z kanałów';

  @override
  String get chat_readAloud => 'Czytaj na głos';

  @override
  String get messageSearch_title => 'Szukaj wiadomości';

  @override
  String get messageSearch_intro =>
      'Przeszukaj wszystkie wiadomości bezpośrednie i z kanałów zapisane na tym telefonie.';

  @override
  String messageSearch_noResults(String query) {
    return 'Żadna wiadomość nie zawiera „$query”.';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wyników',
      many: '$count wyników',
      few: '$count wyniki',
      one: '1 wynik',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return 'Wyświetlane są najnowsze wyniki ($count)';
  }

  @override
  String get shortcuts_checkIn => 'Zamelduj się';

  @override
  String get shortcuts_trip => 'Wyprawa';

  @override
  String get shortcuts_chats => 'Czaty';

  @override
  String get shortcuts_map => 'Mapa';

  @override
  String get sensor_liveUpdates => 'Aktualizacje na żywo';

  @override
  String get sensor_intro =>
      'Niech czujnik sam wysyła odczyty, gdy się zmieniają, zamiast pytać za każdym razem. Wymaga logowania z dostępem do odczytu.';

  @override
  String get sensor_watch => 'Obserwuj zmiany';

  @override
  String get sensor_loadFirst =>
      'Najpierw wczytaj telemetrię, aby wybrać odczyty.';

  @override
  String sensor_watching(String readings, String time) {
    return 'Obserwowane: $readings do $time.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return 'Obserwowane: $readings do $time • region $region.';
  }

  @override
  String get sensor_noChanges => 'Nie zgłoszono jeszcze zmian.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return 'Ostatnia aktualizacja $time • odebrano: $count';
  }

  @override
  String get sensor_stop => 'Zatrzymaj aktualizacje na żywo';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'Zatrzymano tutaj; czujnik nie potwierdził i przestanie, gdy minie czas. $error';
  }

  @override
  String get sensor_dialogBody =>
      'Czujnik sprawdza mniej więcej raz na minutę i wysyła aktualizację, gdy wybrany odczyt zmieni się bardziej niż jego próg.';

  @override
  String sensor_readingTitle(String label, String channel) {
    return '$label (kanał $channel)';
  }

  @override
  String sensor_readingValue(String label, String channel, String value) {
    return '$label (kanał $channel): $value';
  }

  @override
  String sensor_watchItem(String label, String channel, String delta) {
    return '$label (kanał $channel) ±$delta';
  }

  @override
  String sensor_updateOn(String delta) {
    return 'Aktualizuj przy zmianie o $delta';
  }

  @override
  String get sensor_changeThreshold => 'Zmień próg';

  @override
  String sensor_capacity(int max, String used) {
    return 'Czujnik może obserwować do $max bajtów odczytów (użyto: $used).';
  }

  @override
  String get sensor_for => 'Przez';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count godzin',
      many: '$count godzin',
      few: '$count godziny',
      one: '1 godzinę',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => 'Rozpocznij';

  @override
  String sensor_thresholdTitle(String label) {
    return 'Próg: $label';
  }

  @override
  String get sensor_typeTemperature => 'Temperatura';

  @override
  String get sensor_typeHumidity => 'Wilgotność';

  @override
  String get sensor_typePressure => 'Ciśnienie';

  @override
  String get sensor_typeVoltage => 'Napięcie';

  @override
  String get sensor_typeCurrent => 'Prąd';

  @override
  String get sensor_typeLight => 'Światło';

  @override
  String get sensor_typeConcentration => 'Stężenie';

  @override
  String get sensor_typePercentage => 'Procent';

  @override
  String get sensor_typeAnalogInput => 'Wejście analogowe';

  @override
  String get sensor_typeAltitude => 'Wysokość';

  @override
  String get setupWizard_title => 'Połącz radio';

  @override
  String get setupWizard_choose => '1. Wybierz połączenie';

  @override
  String get setupWizard_prepare => '2. Przygotuj radio';

  @override
  String get setupWizard_intro =>
      'Wybierz, jak ten telefon lub komputer połączy się z radiem. Radio przenosi wiadomości przez sieć mesh.';

  @override
  String get setupWizard_bluetooth =>
      'Połączenie bezprzewodowe z kompatybilnym radiem w pobliżu.';

  @override
  String get setupWizard_noBluetooth =>
      'Bluetooth jest niedostępny w tej przeglądarce. Użyj aplikacji natywnej lub obsługiwanego połączenia USB.';

  @override
  String get setupWizard_usb => 'Połączenie przewodowe kablem danych USB.';

  @override
  String get setupWizard_noUsb =>
      'USB szeregowe jest tu niedostępne. Użyj obsługiwanej aplikacji na komputer lub Androida albo Chrome z Web Serial.';

  @override
  String get setupWizard_bluetoothSteps =>
      'Włącz radio i trzymaj je w pobliżu. Włącz Bluetooth i zezwól aplikacji na jego użycie. Zamknij inne aplikacje połączone z radiem, otwórz listę urządzeń i wyszukaj.';

  @override
  String get setupWizard_usbSteps =>
      'Podłącz włączone radio kablem danych USB; kabel tylko do ładowania nie zadziała. Zamknij inne aplikacje szeregowe. Otwórz listę urządzeń USB, wybierz radio i zezwól na dostęp, jeśli pojawi się prośba.';

  @override
  String get setupWizard_firmwareTitle =>
      'Sprawdź zgodność przed zmianą firmware';

  @override
  String get setupWizard_firmware =>
      'Radio potrzebuje firmware MeshCore companion obsługującego wybrane połączenie. Obsługa zależy od płytki i wersji firmware; samo gniazdo USB nie oznacza obsługi USB szeregowego. Sprawdź instrukcje dla swojej płytki i zainstalowanej wersji. Firmware przekaźnika lub serwera pokoju to nie companion. Nieudane połączenie samo w sobie nie oznacza, że trzeba wgrać firmware ponownie.';

  @override
  String get setupWizard_settings =>
      'Ten przewodnik nie wgrywa firmware ani nie zmienia ustawień radia. Po połączeniu użyj Ustawień, aby zmienić region, częstotliwość i opcje zaawansowane. Uzgodnij ustawienia z lokalną siecią mesh przed ich zmianą.';

  @override
  String get setupWizard_openBluetooth => 'Otwórz urządzenia Bluetooth';

  @override
  String get setupWizard_openUsb => 'Otwórz urządzenia USB';

  @override
  String get setupWizard_change => 'Zmień typ połączenia';

  @override
  String get setupWizard_later => 'Skonfiguruj później';

  @override
  String get setupWizard_bluetoothError =>
      'Nie udało się połączyć z radiem. Trzymaj je włączone i w pobliżu, sprawdź uprawnienia Bluetooth i zamknij inne połączone aplikacje. Następnie wyszukaj ponownie.';

  @override
  String get setupWizard_scanError =>
      'Nie udało się wyszukać radiów. Włącz Bluetooth i zezwól na dostęp do Bluetooth lub urządzeń w pobliżu w ustawieniach systemu, a potem wyszukaj ponownie.';

  @override
  String get setupWizard_usbError =>
      'Nie udało się połączyć przez USB. Sprawdź kabel danych i wybrane urządzenie, zezwól na dostęp USB i zamknij inne aplikacje szeregowe. Podłącz kabel ponownie i spróbuj jeszcze raz.';

  @override
  String get connections_title => 'Połączenia';

  @override
  String get connections_radioTitle => 'Połączenie z radiem';

  @override
  String get connections_bluetoothOffNotice =>
      'Bluetooth jest wyłączony. Włącz go, aby połączyć się ponownie; aplikacja spróbuje znowu, gdy wróci.';

  @override
  String get connections_transport => 'Rodzaj połączenia';

  @override
  String connections_lastError(String error) {
    return 'Ostatni błąd: $error';
  }

  @override
  String get connections_disconnectRadio => 'Rozłącz radio';

  @override
  String connections_reconnectTo(String name) {
    return 'Połącz ponownie z $name';
  }

  @override
  String get connections_forgetRadio => 'Zapomnij radio';

  @override
  String get connections_connectAnother => 'Połącz inne radio';

  @override
  String get connections_usbSerial => 'USB szeregowe';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'Urządzenie';

  @override
  String get connections_publicKey => 'Klucz publiczny';

  @override
  String get connections_firmware => 'Firmware';

  @override
  String connections_firmwareProtocol(String code) {
    return 'protokół v$code';
  }

  @override
  String get connections_battery => 'Bateria';

  @override
  String get connections_lastRx => 'Ostatni odbiór';

  @override
  String get connections_reconnectFailed =>
      'Nie udało się ponownie połączyć z radiem';

  @override
  String get connections_statusBluetoothOff => 'Bluetooth jest wyłączony';

  @override
  String get connections_statusConnected => 'Połączono';

  @override
  String get connections_statusConnecting => 'Łączenie…';

  @override
  String get connections_statusDisconnecting => 'Rozłączanie…';

  @override
  String get connections_statusScanning => 'Szukanie radiów…';

  @override
  String get connections_statusReconnectingSoon =>
      'Za chwilę ponowne łączenie…';

  @override
  String get connections_statusNotConnected => 'Nie połączono';

  @override
  String get mqtt_cardTitle => 'Połączenie MQTT';

  @override
  String get mqtt_statusNotConfigured => 'Nie skonfigurowano';

  @override
  String get mqtt_statusDisconnected => 'Rozłączono';

  @override
  String get mqtt_statusConnecting => 'Łączenie';

  @override
  String get mqtt_statusConnected => 'Połączono';

  @override
  String get mqtt_statusReconnecting => 'Ponowne łączenie';

  @override
  String get mqtt_statusError => 'Błąd połączenia';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'Broker: $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn => 'Logowanie tokenem podpisanym przez radio';

  @override
  String mqtt_tokenSignInAs(String username) {
    return 'Logowanie tokenem podpisanym przez radio jako $username…';
  }

  @override
  String get mqtt_connectRadioToSignIn => 'Połącz radio, aby się zalogować';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'Token odnowi się o $time';
  }

  @override
  String mqtt_signedInAs(String username) {
    return 'Zalogowano jako $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return 'Nasłuch na $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'Pakiety: nowe $accepted, duplikaty $duplicate, nieprawidłowe $invalid';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return 'Próba $attempt z $max';
  }

  @override
  String get mqtt_sharingWaitsForRadio =>
      'Udostępnianie czeka na połączenie z radiem';

  @override
  String mqtt_sharingOn(String topic) {
    return 'Udostępnianie na $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return 'Będzie udostępniać na $topic';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'Status online na $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return 'Udostępnione: $shared, wstrzymane: $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'Dodaj brokera, aby łączyć ruch MeshCore przez internet. Połączenie z radiem działa niezależnie.';

  @override
  String get mqtt_disconnect => 'Rozłącz MQTT';

  @override
  String get mqtt_connect => 'Połącz MQTT';

  @override
  String get mqtt_packetFeed => 'Strumień pakietów';

  @override
  String get mqtt_setUpBroker => 'Skonfiguruj brokera';

  @override
  String get mqtt_brokerSettings => 'Ustawienia brokera';

  @override
  String get mqtt_settingsTitle => 'Ustawienia brokera MQTT';

  @override
  String get mqtt_presetLabel => 'Zacznij od szablonu';

  @override
  String get mqtt_presetCustom => 'Własny broker';

  @override
  String get mqtt_presetLocal => 'Lokalny broker (podaj adres)';

  @override
  String get mqtt_presetLetsMeshUs => 'Analizator LetsMesh (USA, społeczność)';

  @override
  String get mqtt_presetLetsMeshEu => 'Analizator LetsMesh (UE, społeczność)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh to prowadzony przez społeczność analizator pakietów MeshCore; nie jest częścią NOTORYX ani nie jest przez NOTORYX polecany. Udostępnianie wymaga połączonego radia i pozostaje wyłączone, dopóki go nie włączysz.';

  @override
  String get mqtt_hostname => 'Nazwa hosta brokera';

  @override
  String get mqtt_port => 'Port';

  @override
  String get mqtt_useTls => 'Używaj TLS';

  @override
  String get mqtt_allowCleartext =>
      'Zezwól na nieszyfrowane połączenie z lokalnym brokerem';

  @override
  String get mqtt_allowCleartextHint =>
      'Tylko localhost, .local i prywatne hosty 10.x / 192.168.x.';

  @override
  String get mqtt_useWebSocket => 'Używaj WebSocket';

  @override
  String get mqtt_webSocketPath => 'Ścieżka WebSocket';

  @override
  String get mqtt_topicPrefix => 'Prefiks tematu';

  @override
  String get mqtt_region => 'Region (opcjonalnie)';

  @override
  String get mqtt_regionHelp =>
      'Kod regionu obserwatora, np. PHL. Zostaw puste dla wszystkich.';

  @override
  String get mqtt_deliverChannel =>
      'Dodawaj wiadomości z kanałów odebrane przez MQTT';

  @override
  String get mqtt_deliverChannelHint =>
      'Wiadomości z Twoich kanałów usłyszane przez obserwatorów pojawią się w czatach. Nie są wysyłane przez Twoje radio.';

  @override
  String get mqtt_sharingTitle => 'Udostępnianie jako obserwator';

  @override
  String get mqtt_share => 'Udostępniaj pakiety, które słyszy moje radio';

  @override
  String get mqtt_shareHint =>
      'Publikuje ogłoszenia i ruch kanałów odbierany przez radio, z jego kluczem publicznym, siłą sygnału i regionem. Wiadomości z kanałów pozostają zaszyfrowane. Wymaga regionu.';

  @override
  String get mqtt_shareDirect => 'Uwzględnij ruch wiadomości bezpośrednich';

  @override
  String get mqtt_shareDirectHint =>
      'Żądania, odpowiedzi i wiadomości bezpośrednie. Treść pozostaje zaszyfrowana, ale widać, które węzły ze sobą rozmawiają.';

  @override
  String get mqtt_shareOwn => 'Uwzględnij moje własne wiadomości i ogłoszenia';

  @override
  String get mqtt_signInTitle => 'Logowanie';

  @override
  String get mqtt_authPassword => 'Nazwa użytkownika i hasło';

  @override
  String get mqtt_authToken => 'Token podpisany przez radio';

  @override
  String get mqtt_tokenExplain =>
      'Radio podpisuje własnym kluczem godzinny token logowania, a aplikacja odnawia go przed wygaśnięciem. Klucz nigdy nie opuszcza radia. Nazwa użytkownika to v1_ i klucz publiczny radia.';

  @override
  String get mqtt_radioReady => 'Radio połączone: gotowe do logowania.';

  @override
  String get mqtt_radioNeeded =>
      'Połącz radio, aby się zalogować. MQTT na nie czeka.';

  @override
  String get mqtt_username => 'Nazwa użytkownika (opcjonalnie)';

  @override
  String get mqtt_password => 'Hasło';

  @override
  String get mqtt_keepPassword => 'Zostaw puste, aby zachować zapisane hasło.';

  @override
  String get mqtt_credentialsWeb =>
      'W przeglądarce dane logowania są przechowywane tylko do zamknięcia strony.';

  @override
  String get mqtt_credentialsKeychain =>
      'Dane logowania są przechowywane w systemowym pęku kluczy, nigdy w ustawieniach aplikacji ani w logach.';

  @override
  String get mqtt_saveSettings => 'Zapisz ustawienia';

  @override
  String get mqtt_feedTitle => 'Strumień pakietów MQTT';

  @override
  String get mqtt_feedConnect =>
      'Połącz się z brokerem, aby zobaczyć pakiety od obserwatorów.';

  @override
  String mqtt_feedWaiting(String topic) {
    return 'Czekanie na pakiety na $topic';
  }

  @override
  String get mqtt_feedUnknownObserver => 'Nieznany obserwator';

  @override
  String mqtt_feedHeardBy(String observer) {
    return 'Odebrane przez $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return 'Przeskoki: $hops · bajty: $bytes';
  }

  @override
  String get mqtt_packetRequest => 'Żądanie';

  @override
  String get mqtt_packetResponse => 'Odpowiedź';

  @override
  String get mqtt_packetDirectMessage => 'Wiadomość bezpośrednia';

  @override
  String get mqtt_packetAck => 'Potwierdzenie';

  @override
  String get mqtt_packetAdvert => 'Ogłoszenie';

  @override
  String get mqtt_packetChannelMessage => 'Wiadomość kanału';

  @override
  String get mqtt_packetChannelData => 'Dane kanału';

  @override
  String get mqtt_packetAnonymousRequest => 'Żądanie anonimowe';

  @override
  String get mqtt_packetPath => 'Ścieżka';

  @override
  String get mqtt_packetTrace => 'Śledzenie';

  @override
  String get mqtt_packetMultipart => 'Wieloczęściowy';

  @override
  String get mqtt_packetControl => 'Sterowanie';

  @override
  String mqtt_packetType(int type) {
    return 'Typ $type';
  }

  @override
  String get mqtt_routeTransportFlood => 'Flood z transportem';

  @override
  String get mqtt_routeFlood => 'Flood';

  @override
  String get mqtt_routeDirect => 'Bezpośrednia';

  @override
  String get mqtt_routeTransportDirect => 'Bezpośrednia z transportem';

  @override
  String get mqtt_noticeInvalidHost =>
      'Podaj nazwę hosta lub adres IPv4 bez schematu i portu.';

  @override
  String get mqtt_noticeInvalidPort => 'Port musi być z zakresu od 1 do 65535.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'Ścieżka WebSocket musi zaczynać się od / i nie może zawierać zapytania ani fragmentu.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'Prefiks tematu musi być niepustą ścieżką MQTT bez symboli wieloznacznych.';

  @override
  String get mqtt_noticeInvalidRegion =>
      'Region musi mieć od 2 do 8 liter lub cyfr, np. PHL.';

  @override
  String get mqtt_noticeTlsRequired =>
      'TLS jest wymagany, chyba że wyraźnie zezwolono na niezabezpieczony dostęp do lokalnego brokera.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      'Nieszyfrowane MQTT jest dozwolone tylko dla wyraźnie zatwierdzonych hostów lokalnych.';

  @override
  String get mqtt_noticeRegionNeededToShare =>
      'Ustaw region, aby udostępniać pakiety jako obserwator.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return 'Podaj hasło dla $username.';
  }

  @override
  String get mqtt_noticeNoNetwork =>
      'Brak połączenia z siecią. MQTT połączy się ponownie, gdy wróci.';

  @override
  String get mqtt_noticeSubscriptionRefused =>
      'Broker odrzucił subskrypcję pakietów.';

  @override
  String get mqtt_noticeBadCredentials =>
      'Broker odrzucił nazwę użytkownika lub hasło.';

  @override
  String get mqtt_noticeNotAuthorized =>
      'To konto nie ma uprawnień na brokerze.';

  @override
  String get mqtt_noticeConnectionRefused => 'Broker odrzucił połączenie.';

  @override
  String get mqtt_noticeUnreachable => 'Nie udało się połączyć z brokerem.';

  @override
  String get mqtt_noticeTlsFailed =>
      'Nie udało się nawiązać bezpiecznego połączenia (TLS).';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'Ta platforma obsługuje MQTT tylko przez WebSocket.';

  @override
  String get mqtt_noticeRadioNotConnected =>
      'Połącz radio, aby zalogować się jego kluczem.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'Firmware tego radia nie obsługuje podpisywania jego kluczem.';

  @override
  String get mqtt_noticeSigningTimeout =>
      'Radio nie odpowiedziało na żądanie podpisu. Jego firmware może nie obsługiwać podpisywania.';

  @override
  String get mqtt_noticeSigningTooLong =>
      'Dane są zbyt długie, aby radio mogło je podpisać.';

  @override
  String get mqtt_noticeSigningRejected => 'Radio odmówiło podpisania danych.';

  @override
  String get scanner_signalStrong => 'Silny';

  @override
  String get scanner_signalGood => 'Dobry';

  @override
  String get scanner_signalFair => 'Średni';

  @override
  String get scanner_signalWeak => 'Słaby';

  @override
  String get scanner_nearbyRadios => 'Radia w pobliżu';

  @override
  String get scanner_lastRadio => 'Ostatnie radio';

  @override
  String get scanner_reconnect => 'Połącz ponownie';

  @override
  String get scanner_tcpHint => 'Radio z oprogramowaniem Wi‑Fi w twojej sieci.';

  @override
  String get scanner_otherWays => 'Inne sposoby połączenia';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count radia w pobliżu',
      many: '$count radiów w pobliżu',
      few: '$count radia w pobliżu',
      one: '1 radio w pobliżu',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => 'Szukanie radiów…';

  @override
  String get scanner_findTitle => 'Znajdź swoje radio';

  @override
  String get scanner_heroHint =>
      'Włącz radio i trzymaj je w odległości kilku metrów. Potrzebuje oprogramowania MeshCore companion.';

  @override
  String get scanner_tipsTitle => 'Nie widzisz swojego radia?';

  @override
  String get scanner_tipPower => 'Sprawdź, czy jest włączone i aktywne.';

  @override
  String get scanner_tipFirmware =>
      'Potrzebuje oprogramowania MeshCore companion. Przemienniki i serwery pokojów nie pojawiają się tutaj.';

  @override
  String get scanner_tipOtherDevice =>
      'Radio łączy się naraz tylko z jednym urządzeniem. Odłącz je od innych telefonów lub komputerów.';

  @override
  String get connections_internetBridge => 'Most internetowy';

  @override
  String get connections_noRadio => 'Brak radia';

  @override
  String get connections_radioSettings => 'Ustawienia radia';

  @override
  String get connections_viewDashboard => 'Pokaż panel połączeń';

  @override
  String get channelDirectory_title => 'Katalog kanałów';

  @override
  String get channelDirectory_subtitle =>
      'Znajdź publiczne kanały hashtagowe w pobliżu';

  @override
  String get channelDirectory_search => 'Szukaj kanałów lub miejsc';

  @override
  String get channelDirectory_nearYou => 'W pobliżu';

  @override
  String get channelDirectory_all => 'Wszystkie kanały';

  @override
  String get channelDirectory_catAll => 'Wszystkie';

  @override
  String get channelDirectory_catEmergency => 'Alarmowe';

  @override
  String get channelDirectory_catLocal => 'Lokalne';

  @override
  String get channelDirectory_catGeneral => 'Ogólne';

  @override
  String get channelDirectory_catInterest => 'Zainteresowania';

  @override
  String get channelDirectory_catTest => 'Testowe';

  @override
  String get channelDirectory_join => 'Dołącz';

  @override
  String get channelDirectory_joined => 'Dołączono';

  @override
  String get channelDirectory_noMatches =>
      'Żaden kanał nie pasuje do wyszukiwania.';

  @override
  String get channelDirectory_connectFirst =>
      'Połącz radio, aby dołączać do kanałów.';

  @override
  String get channelDirectory_slotsFull =>
      'Wszystkie miejsca na kanały w radiu są zajęte. Najpierw usuń kanał.';

  @override
  String get channelDirectory_joinFailed =>
      'Nie udało się dodać kanału. Spróbuj ponownie.';

  @override
  String get channelDirectory_addHint =>
      'Brakuje kanału? Każdy może go zaproponować, edytując wspólną listę na GitHubie.';

  @override
  String get prefixTool_title => 'ID przemienników';

  @override
  String get prefixTool_subtitle =>
      'Kto używa ID, które ID się pokrywają i wolne ID dla nowego przemiennika';

  @override
  String get prefixTool_width => 'Rozmiar ID ścieżki';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes B';
  }

  @override
  String get prefixTool_includeCompanions => 'Uwzględnij companiony i czujniki';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return 'Znane węzły: $nodes · używane ID: $used · wspólne: $shared';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return 'Wolne ID: $free z $space';
  }

  @override
  String get prefixTool_lookupHint => 'Wyszukaj ID, np. 3D';

  @override
  String prefixTool_lookupFree(String id) {
    return 'Żaden znany węzeł nie używa $id.';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count węzła używa $id',
      many: '$count węzłów używa $id',
      few: '$count węzły używają $id',
      one: '1 węzeł używa $id',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => 'Wspólne ID';

  @override
  String get prefixTool_sharedHint =>
      'Ścieżki przez te ID wyglądają tak samo, chyba że sieć używa dłuższych ID.';

  @override
  String get prefixTool_noShared => 'Brak wspólnych ID wśród znanych węzłów.';

  @override
  String get prefixTool_free => 'Wolne ID';

  @override
  String get prefixTool_shuffle => 'Więcej propozycji';

  @override
  String get prefixTool_makeKey => 'Utwórz klucz';

  @override
  String get prefixTool_onlyKnown =>
      'Na podstawie tylko węzłów usłyszanych przez radio. Wolne tu ID może należeć do przemiennika, którego nie słyszałeś.';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id jest już używane przez $name.';
  }

  @override
  String get prefixTool_pickFree => 'Wybierz wolne ID';

  @override
  String keyGen_title(String id) {
    return 'Klucz dla ID $id';
  }

  @override
  String keyGen_searching(int tries) {
    return 'Szukanie… wypróbowano kluczy: $tries';
  }

  @override
  String get keyGen_publicKey => 'Klucz publiczny';

  @override
  String get keyGen_privateKey => 'Klucz prywatny';

  @override
  String get keyGen_copy => 'Kopiuj';

  @override
  String get keyGen_copied => 'Skopiowano';

  @override
  String get keyGen_secretWarning =>
      'Chroń klucz prywatny. Kto go ma, może podszyć się pod ten węzeł.';

  @override
  String get keyGen_howToUse =>
      'Dla przemiennika: otwórz jego ustawienia, wklej jako klucz prywatny i zapisz. Radia companion wymagają oprogramowania pozwalającego na import klucza.';

  @override
  String get keyGen_tryAgain => 'Utwórz kolejny';

  @override
  String get regionSetup_title => 'Konfiguracja regionów';

  @override
  String get regionSetup_hubSubtitle =>
      'Umieść ten przemiennik w drzewie regionów twojej okolicy';

  @override
  String get regionSetup_intro =>
      'Regiony zatrzymują wiadomość w danym obszarze zamiast zalewać całą sieć. Przemiennik przekazuje wiadomości regionu tylko wtedy, gdy ma ten region, więc nadaj mu jego region i wszystkie regiony powyżej.';

  @override
  String get regionSetup_where => 'Gdzie jest przemiennik?';

  @override
  String get regionSetup_tree => 'Drzewo regionów';

  @override
  String get regionSetup_custom => 'Własne';

  @override
  String get regionSetup_region => 'Najbardziej lokalny region';

  @override
  String regionSetup_source(String source) {
    return 'Źródło: $source';
  }

  @override
  String get regionSetup_customLabel => 'Regiony, od najszerszego';

  @override
  String regionSetup_invalidName(String name) {
    return '„$name” nie jest prawidłową nazwą regionu. Użyj małych liter, cyfr i łączników, do 29 znaków.';
  }

  @override
  String regionSetup_tooMany(int max) {
    return 'Przemiennik może mieć najwyżej $max regionów.';
  }

  @override
  String get regionSetup_options => 'Opcje';

  @override
  String get regionSetup_setDefault =>
      'Ustaw najbardziej lokalny region jako domyślny';

  @override
  String get regionSetup_setDefaultBody =>
      'Własne ogłoszenia przemiennika zostają w tym regionie.';

  @override
  String get regionSetup_legacy => 'Oprogramowanie 1.14';

  @override
  String get regionSetup_legacyBody =>
      'Dodaje region allowf po każdym regionie. Niepotrzebne od 1.15.';

  @override
  String get regionSetup_denyUnscoped => 'Nie przekazuj wiadomości bez regionu';

  @override
  String get regionSetup_denyUnscopedBody =>
      'Włącz dopiero, gdy cała okolica używa regionów, inaczej wiadomości ze starszych aplikacji nie dotrą.';

  @override
  String get regionSetup_commands => 'Polecenia';

  @override
  String get regionSetup_copyAll => 'Kopiuj wszystko';

  @override
  String get regionSetup_copied => 'Skopiowano';

  @override
  String get regionSetup_pickFirst => 'Wybierz region, aby zobaczyć polecenia.';

  @override
  String regionSetup_sendTo(String name) {
    return 'Wyślij do $name';
  }

  @override
  String get regionSetup_howToSend =>
      'Aby je wysłać, zaloguj się do przemiennika i otwórz Konfiguracja regionów z jego menu albo wklej je w jego wiersz poleceń.';

  @override
  String get regionSetup_noReply => 'Brak odpowiedzi. Zatrzymano tutaj.';

  @override
  String get regionSetup_addToMine => 'Dodaj te regiony do mojej listy';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dodano $count regionu do listy',
      many: 'Dodano $count regionów do listy',
      few: 'Dodano $count regiony do listy',
      one: 'Dodano 1 region do listy',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => 'Dziennik trasy';

  @override
  String get trackLog_subtitle => 'Zapisuj ślad z GPS radia';

  @override
  String get trackLog_recording => 'Nagrywanie';

  @override
  String get trackLog_notRecording => 'Brak nagrywania';

  @override
  String get trackLog_noGps =>
      'Radio nie podaje pozycji GPS. Dziennik trasy wymaga radia z włączonym GPS.';

  @override
  String get trackLog_start => 'Zacznij nagrywać';

  @override
  String get trackLog_stop => 'Zatrzymaj nagrywanie';

  @override
  String get trackLog_howItWorks =>
      'Używa pozycji podawanej przez radio, mniej więcej raz na minutę, gdy NOTORYX Core jest otwarty. Punkt jest dodawany po przejściu 25 m lub co 15 minut na postoju.';

  @override
  String get trackLog_snap => 'Zaokrąglaj pozycje do ok. 100 m';

  @override
  String get trackLog_snapBody => 'Dla prywatności przy udostępnianiu trasy.';

  @override
  String get trackLog_saved => 'Zapisane trasy';

  @override
  String get trackLog_none => 'Brak tras.';

  @override
  String get trackLog_export => 'Eksportuj jako GPX';

  @override
  String get trackLog_exportFailed => 'Nie udało się wyeksportować trasy.';

  @override
  String get trackLog_deleteTitle => 'Usunąć tę trasę?';

  @override
  String get trackLog_deleteBody =>
      'Zostanie usunięta z tego urządzenia. Wyeksportowane pliki GPX pozostaną.';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km km · $duration · punkty: $points';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'Trasa NOTORYX $when';
  }

  @override
  String get routes_nearbyTitle => 'Najlepsze przemienniki w pobliżu';

  @override
  String get routes_nearbyEmptyTitle => 'Nie usłyszano jeszcze przemienników';

  @override
  String get routes_nearbyEmpty =>
      'Przemienniki, które radio słyszy bezpośrednio, pojawiają się tu od najsilniejszego, w miarę odbierania ruchu. Lista obejmuje ostatnią godzinę.';

  @override
  String get routes_unknownRepeater => 'Nieznany przemiennik';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'usłyszany $count razy',
      many: 'usłyszany $count razy',
      few: 'usłyszany $count razy',
      one: 'usłyszany raz',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes min temu',
      one: '1 min temu',
      zero: 'przed chwilą',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return 'przez $names';
  }

  @override
  String get nav_home => 'Start';

  @override
  String get nav_chats => 'Czaty';

  @override
  String get nav_tools => 'Narzędzia';

  @override
  String get nav_settings => 'Ustawienia';

  @override
  String get nav_more => 'Więcej';

  @override
  String get tools_groupApp => 'Aplikacja i ustawienia';

  @override
  String get tools_groupField => 'W terenie';

  @override
  String get tools_groupMaps => 'Mapy i zasięg';

  @override
  String get tools_groupRouting => 'Trasy i przemienniki';

  @override
  String get tools_pathGraph => 'Graf ścieżek';

  @override
  String get tools_pathGraphHint =>
      'Jak docierają do Ciebie wiadomości: każda usłyszana ścieżka i najbardziej obciążone przemienniki';

  @override
  String get tools_antenna => 'Zasięg anteny';

  @override
  String get tools_antennaHint => 'Oszacuj, dokąd sięga antena w terenie';

  @override
  String routes_repeaterWithId(String id) {
    return 'Przemiennik $id';
  }

  @override
  String get coverageHex_title => 'Sześciokąty zasięgu';

  @override
  String get coverageHex_toolSubtitle =>
      'Mapuj, gdzie radio słyszy sieć, i udostępniaj to';

  @override
  String get coverageHex_mapCoverage => 'Mapuj zasięg';

  @override
  String get coverageHex_statusOff =>
      'Wyłączone. Włącz podczas jazdy lub marszu, aby mapować, gdzie radio słyszy sieć.';

  @override
  String get coverageHex_waitingGps => 'Oczekiwanie na GPS…';

  @override
  String coverageHex_gpsTooRough(String meters) {
    return 'Dokładność GPS $meters m: zbyt mała, bez zapisu.';
  }

  @override
  String coverageHex_recording(String meters) {
    return 'Nagrywanie. Dokładność GPS $meters m.';
  }

  @override
  String get coverageHex_hexagons => 'Sześciokąty';

  @override
  String get coverageHex_samples => 'Próbki';

  @override
  String get coverageHex_privacyNote =>
      'Używa GPS telefonu, gdy ten przełącznik jest włączony. Udostępniane są tylko ID sześciokątów (ok. 0,9 km), nigdy dokładna pozycja.';

  @override
  String get coverageHex_uploadSection => 'Wysyłanie do map zasięgu';

  @override
  String get coverageHex_wifiOnly => 'Wysyłaj tylko przez Wi-Fi';

  @override
  String get coverageHex_wifiOnlyHint =>
      'Próbki czekają w telefonie (do 7 dni) na Wi-Fi.';

  @override
  String coverageHex_waiting(String count) {
    return '$count oczekuje';
  }

  @override
  String get coverageHex_addMap => 'Dodaj mapę zasięgu';

  @override
  String get coverageHex_addMapHint =>
      'Dowolny punkt HTTPS przyjmujący dane o zasięgu.';

  @override
  String get coverageHex_uploadNow => 'Wyślij teraz';

  @override
  String get coverageHex_mapDialogTitle => 'Mapa zasięgu';

  @override
  String get coverageHex_nameMissing => 'Nadaj nazwę.';

  @override
  String get coverageHex_url => 'Adres URL wysyłania';

  @override
  String get coverageHex_urlInvalid => 'Musi to być adres https://.';

  @override
  String get coverageHex_apiKey => 'Klucz API (opcjonalnie)';

  @override
  String get coverageHex_apiKeyHint => 'Wysyłany jako X-API-Key.';

  @override
  String get coverageHex_format => 'Format';

  @override
  String get coverageHex_formatHex => 'ID sześciokątów (NOTORYX)';

  @override
  String get coverageHex_formatMeshMapper => 'Zgodny z MeshMapper';

  @override
  String get coverageHex_privacy => 'Prywatność';

  @override
  String get coverageHex_privacyLive => 'Na żywo';

  @override
  String get coverageHex_privacyDelayed => 'Opóźnione o 3 h';

  @override
  String get coverageHex_privacyAnonymous => 'Anonimowo, 24 h';

  @override
  String get coverageHex_privacyLiveHint => 'Wysyłane w ciągu ok. 15 minut.';

  @override
  String get coverageHex_privacyDelayedHint =>
      'Wstrzymywane 3 godziny, by mapa nie pokazała, gdzie jesteś teraz.';

  @override
  String get coverageHex_privacyAnonymousHint =>
      'Wstrzymywane 24 godziny, tylko z datą i bez podpisu, by nie dało się powiązać wysyłek.';

  @override
  String get coverageHex_uploadsOn => 'Wysyłanie włączone';

  @override
  String coverageHex_sent(String count, String time) {
    return 'Wysłano $count komórek o $time.';
  }

  @override
  String coverageHex_httpError(String code) {
    return 'Mapa odpowiedziała $code; ponowię próbę.';
  }

  @override
  String get coverageHex_unreachable =>
      'Brak połączenia z mapą; ponowię próbę.';

  @override
  String get coverageHex_noPermission =>
      'Nie przyznano uprawnień do lokalizacji.';

  @override
  String get coverageHex_noGps => 'GPS jest niedostępny.';

  @override
  String get coverageHex_loadFailed =>
      'Nie można odczytać zapisanego zasięgu; start od nowa.';

  @override
  String get mqttExtra_wifiOnly => 'Łącz tylko przez Wi-Fi';

  @override
  String mqttExtra_backlog(String count) {
    return 'Pakiety czekające na wysłanie: $count (przechowywane do 72 godzin).';
  }

  @override
  String get mqttExtra_add => 'Dodaj kolejnego brokera';

  @override
  String get mqttExtra_addBody =>
      'Udostępnia to, co słyszy radio, kolejnemu brokerowi MQTT obok głównego. Tylko wysyła, nigdy nie przekazuje pakietów z powrotem do aplikacji.';

  @override
  String get mqttExtra_separateKey => 'Użyj osobnego klucza';

  @override
  String get mqttExtra_separateKeyHint =>
      'Loguje się kluczem utworzonym w tym telefonie zamiast klucza radia, więc broker nie powiąże wysyłek z radiem.';

  @override
  String mqttExtra_removeTitle(String name) {
    return 'Usunąć $name?';
  }

  @override
  String get mqttExtra_removeBody =>
      'Rozłącza i usuwa ustawienia, hasło, klucz oraz oczekujące pakiety.';

  @override
  String mqttExtra_ownKey(String key) {
    return 'Loguje się własnym kluczem: $key…';
  }

  @override
  String get botWx_title => 'Publikuj ostrzeżenia pogodowe na kanale';

  @override
  String get botWx_body =>
      'Co 10 minut sprawdza w amerykańskiej National Weather Service poważne i skrajne ostrzeżenia dla pozycji GPS radia (zaokrąglonej do ok. 1 km) i publikuje każde nowe raz. Wymaga internetu w telefonie.';

  @override
  String get botWx_channel => 'Publikuj na kanale';

  @override
  String get botWx_moderate => 'Uwzględnij umiarkowane ostrzeżenia';

  @override
  String get botWx_moderateHint =>
      'Komunikaty i ostrzeżenia. Więcej wiadomości.';

  @override
  String botWx_lastChecked(String time) {
    return 'Ostatnio sprawdzono $time.';
  }

  @override
  String get botWx_noPosition => 'Radio nie zgłosiło jeszcze pozycji GPS.';

  @override
  String get botWx_noChannel => 'Wybierz kanał dla ostrzeżeń.';

  @override
  String get botWx_channelGone => 'Wybrany kanał już nie istnieje.';

  @override
  String botWx_httpError(String code) {
    return 'Służba pogodowa odpowiedziała $code.';
  }

  @override
  String get botWx_unreachable => 'Brak połączenia ze służbą pogodową.';

  @override
  String get botCmd_sun => 'Wschód i zachód słońca w pozycji GPS radia.';

  @override
  String get botCmd_moon => 'Faza Księżyca i stopień oświetlenia.';

  @override
  String get botCmd_weather =>
      'Bieżąca pogoda przy radiu (Open-Meteo). Wysyła pozycję zaokrągloną do ok. 1 km.';

  @override
  String get botCmd_dice => 'Rzut kośćmi: !dice, !dice 20 lub !dice 2d6.';

  @override
  String get botCmd_trace =>
      'Wyświetla przemienniki, przez które przeszła wiadomość.';

  @override
  String get ping_title => 'Ping przemiennika';

  @override
  String get ping_toolSubtitle =>
      'Czas w obie strony i sygnał do pobliskiego przemiennika';

  @override
  String get ping_noRepeaters => 'Brak znanych przemienników';

  @override
  String get ping_choose => 'Wybierz przemiennik';

  @override
  String get ping_avgMs => 'ms w obie strony';

  @override
  String get ping_snrThere => 'SNR tam';

  @override
  String get ping_snrBack => 'SNR z powrotem';

  @override
  String get ping_loss => 'Utracone';

  @override
  String ping_running(int done, int total) {
    return 'Ping $done z $total…';
  }

  @override
  String ping_start(int count) {
    return 'Pinguj $count razy';
  }

  @override
  String get ping_results => 'Próby';

  @override
  String get ping_noReply => 'Brak odpowiedzi';

  @override
  String ping_resultLine(String ms, String snr) {
    return '$ms ms · SNR tam $snr';
  }

  @override
  String get ping_explainer =>
      'Każda próba to śledzenie ścieżki na jeden skok: przemiennik notuje, jak dobrze cię słyszał, i odsyła to. Działa z przemiennikami słyszanymi bezpośrednio.';

  @override
  String get hunt_title => 'Szukanie anteną';

  @override
  String get hunt_toolSubtitle =>
      'Duży miernik sygnału, który klika szybciej, gdy sygnał rośnie';

  @override
  String get hunt_noSignal => 'Brak sygnału';

  @override
  String get hunt_noReply => 'Brak odpowiedzi — przesuń lub obróć antenę';

  @override
  String get hunt_heardHere => 'dB słyszane tutaj';

  @override
  String get hunt_best => 'Najlepszy';

  @override
  String get hunt_sound => 'Klikaj wraz ze wzrostem sygnału';

  @override
  String get hunt_soundHint =>
      'Z wibracją przy każdym kliknięciu, by celować bez patrzenia.';

  @override
  String get hunt_stop => 'Zatrzymaj';

  @override
  String get hunt_start => 'Rozpocznij szukanie';

  @override
  String get hunt_explainer =>
      'Sonduje przemiennik mniej więcej co sekundę. Ustaw antenę kierunkową lub przejdź się: liczba pokazuje, jak dobrze radio go słyszy.';

  @override
  String get settings_refreshRate => 'Częstotliwość odświeżania';

  @override
  String get settings_refreshFast => 'Szybko';

  @override
  String get settings_refreshNormal => 'Normalnie';

  @override
  String get settings_refreshSlow => 'Wolno';

  @override
  String get settings_refreshFastHint =>
      'Bateria co minutę, GPS co 30 s. Świeższe dane, większe zużycie.';

  @override
  String get settings_refreshNormalHint =>
      'Bateria co 2 minuty, GPS co minutę.';

  @override
  String get settings_refreshSlowHint =>
      'Bateria co 6 minut, GPS co 3. Oszczędza baterię.';

  @override
  String get settings_refreshSaverOn =>
      'Oszczędzanie baterii jest włączone i wyznacza tempo (bateria co 10 minut).';
}
