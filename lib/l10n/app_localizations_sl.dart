// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core';

  @override
  String get nav_contacts => 'Stiki';

  @override
  String get nav_channels => 'Kanali';

  @override
  String get nav_map => 'Karta';

  @override
  String get nav_messages => 'Sporočila';

  @override
  String get nav_nodes => 'Vozlišča';

  @override
  String get nav_radio => 'Radio';

  @override
  String get messages_title => 'Sporočila';

  @override
  String get messages_filterAll => 'Vsi';

  @override
  String get messages_filterDirect => 'Neposredni';

  @override
  String get messages_filterChannels => 'Kanali';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'Išči sporočila';

  @override
  String get messages_searchHint => 'Išči pogovore';

  @override
  String get messages_closeSearch => 'Zapri iskanje';

  @override
  String get messages_manageChannels => 'Upravljaj kanale';

  @override
  String get messages_new => 'Novo';

  @override
  String get messages_newDirect => 'Piši vozlišču';

  @override
  String get messages_newChannel => 'Dodaj kanal ali se mu pridruži';

  @override
  String get messages_empty => 'Še ni pogovorov';

  @override
  String get messages_emptyHint =>
      'Tu se prikazujejo sporočila vozlišč in kanalov.';

  @override
  String get messages_noMatches => 'Iskanju ne ustreza noben pogovor';

  @override
  String messages_you(String text) {
    return 'Vi: $text';
  }

  @override
  String get messages_yesterday => 'Včeraj';

  @override
  String messages_unreadCount(int count) {
    return 'Neprebrana: $count';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return 'Povezano prek $transport';
  }

  @override
  String get radioStatus_bluetooth => 'Bluetooth';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'Wi‑Fi (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return 'Baterija $percent %';
  }

  @override
  String get radioStatus_openRadio => 'Odpri podrobnosti radia';

  @override
  String get radioOverview_battery => 'Baterija';

  @override
  String radioOverview_firmware(String version) {
    return 'Strojna programska oprema $version';
  }

  @override
  String get radioOverview_sendAdvert => 'Pošlji oznanilo';

  @override
  String get radioOverview_stats => 'Statistika radia';

  @override
  String get accessControl_title => 'Nadzor dostopa';

  @override
  String get accessControl_hubSubtitle => 'Kdo se lahko prijavi brez gesla';

  @override
  String get accessControl_explainRepeater =>
      'Ljudje s tega seznama se prijavijo brez gesla. Skrbniki lahko spreminjajo nastavitve; Samo branje ter Branje in pisanje prejmeta tudi celotno telemetrijo.';

  @override
  String get accessControl_explainRoom =>
      'Skrbniki s tega seznama se prijavijo brez gesla in lahko upravljajo sobo. Člani sobe se pridružijo z geslom sobe.';

  @override
  String get accessControl_roleReadOnly => 'Samo branje';

  @override
  String get accessControl_roleReadWrite => 'Branje in pisanje';

  @override
  String get accessControl_roleAdmin => 'Skrbnik';

  @override
  String get accessControl_you => 'Vi';

  @override
  String get accessControl_unknownNode => 'Neznano vozlišče';

  @override
  String get accessControl_add => 'Dodaj';

  @override
  String get accessControl_addTitle => 'Dodaj na seznam dostopa';

  @override
  String get accessControl_pickContact => 'Izberite stik';

  @override
  String get accessControl_noContacts =>
      'Ni stikov za dodajanje. Vozlišča se prikažejo tukaj, ko prejmete njihovo oznanilo.';

  @override
  String get accessControl_changeRole => 'Spremeni vlogo';

  @override
  String get accessControl_remove => 'Odvzemi dostop';

  @override
  String accessControl_removeConfirm(String name) {
    return 'Odstranim $name s seznama dostopa? Za prijavo bo potrebno geslo.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'To ste vi. Če se odstranite, boste za ponovno upravljanje vozlišča potrebovali skrbniško geslo.';

  @override
  String get accessControl_unknownKeyNote =>
      'Ni med vašimi stiki. Za spremembo vloge je potrebna novejša strojna programska oprema vozlišča; odstranitev deluje vedno.';

  @override
  String get accessControl_prefixUnsupported =>
      'Strojna programska oprema tega vozlišča ne more spremeniti vloge nekoga, ki ni med vašimi stiki. Še vedno ga lahko odstranite.';

  @override
  String get accessControl_empty => 'Na seznamu dostopa ni nikogar';

  @override
  String get accessControl_emptyHint =>
      'Dodajte ljudi, da se lahko prijavijo brez gesla.';

  @override
  String get accessControl_loading => 'Vozlišče sprašujem po seznamu dostopa…';

  @override
  String get accessControl_timeout =>
      'Vozlišče se ni odzvalo. Preverite pot in poskusite znova.';

  @override
  String get accessControl_maybeIncomplete =>
      'Vozlišče je poslalo eno polno stran, njegova strojna programska oprema pa ne more poslati več, zato lahko nekateri vnosi manjkajo.';

  @override
  String get accessControl_saved => 'Seznam dostopa posodobljen';

  @override
  String accessControl_failed(String reply) {
    return 'Vozlišče je zavrnilo spremembo: $reply';
  }

  @override
  String get companionCli_title => 'Ukazna vrstica';

  @override
  String get companionCli_tileSubtitle => 'Zaganjajte ukaze na radiu';

  @override
  String get companionCli_warning =>
      'Ukazi se izvajajo na povezanem radiu in lahko spremenijo njegove nastavitve ali ga znova zaženejo.';

  @override
  String get companionCli_hint => 'Vnesite ukaz, npr. ver';

  @override
  String get companionCli_send => 'Zaženi ukaz';

  @override
  String get companionCli_noReply =>
      'Ni odgovora. Radio se morda znova zaganja.';

  @override
  String get companionCli_empty =>
      'Poskusite enega od zgornjih ukazov ali vnesite svojega.';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle => 'Povežite radio z omrežjem Wi‑Fi';

  @override
  String get wifi_unsupported =>
      'Strojna programska oprema tega radia ne vključuje Wi‑Fi.';

  @override
  String get wifi_enabled => 'Uporabi Wi‑Fi';

  @override
  String get wifi_status => 'Stanje';

  @override
  String get wifi_connected => 'Povezano';

  @override
  String wifi_connectedIp(String ip) {
    return 'Povezano · $ip';
  }

  @override
  String get wifi_disconnected => 'Ni povezano';

  @override
  String get wifi_network => 'Ime omrežja (SSID)';

  @override
  String get wifi_password => 'Geslo';

  @override
  String get wifi_passwordKeep => 'Pustite prazno, da ohranite trenutno geslo';

  @override
  String get wifi_save => 'Shrani';

  @override
  String get wifi_forget => 'Pozabi omrežje';

  @override
  String get wifi_forgetConfirm =>
      'Odstranim shranjeno omrežje in geslo iz radia?';

  @override
  String get wifi_rebootNeeded =>
      'Shranjeno. Znova zaženite radio, da uveljavite spremembe Wi‑Fi.';

  @override
  String get wifi_rebootNow => 'Znova zaženi radio';

  @override
  String get wifi_rebootConfirm =>
      'Znova zaženem radio zdaj? Aplikacija se bo odklopila in znova se boste morali povezati.';

  @override
  String get wifi_loadFailed =>
      'Nastavitev Wi‑Fi ni bilo mogoče prebrati iz radia.';

  @override
  String get wifi_retry => 'Poskusi znova';

  @override
  String wifi_saveFailed(String reply) {
    return 'Radio spremembe ni sprejel: $reply';
  }

  @override
  String get accessControl_refresh => 'Osveži';

  @override
  String get common_cancel => 'Prekliči';

  @override
  String get common_ok => 'V redu';

  @override
  String get common_connect => 'Poveži se';

  @override
  String get common_unknownDevice => 'Nepoznano naprave';

  @override
  String get common_save => 'Shrani';

  @override
  String get common_delete => 'Izbrisati';

  @override
  String get common_deleteAll => 'Izbriši vse';

  @override
  String get common_close => 'Zapri';

  @override
  String get common_done => 'Done';

  @override
  String get common_edit => 'Uredi';

  @override
  String get common_add => 'Dodaj';

  @override
  String get common_settings => 'Nastavitve';

  @override
  String get common_disconnect => 'Odklopiti';

  @override
  String get common_connected => 'Povezano';

  @override
  String get common_disconnected => 'Odprto';

  @override
  String get common_create => 'Ustvari';

  @override
  String get common_continue => 'Poudarki';

  @override
  String get common_share => 'Deliti';

  @override
  String get common_copy => 'Kopiraj';

  @override
  String get common_retry => 'Ponoviti';

  @override
  String get common_hide => 'Skrita';

  @override
  String get common_remove => 'Izbrisati';

  @override
  String get common_enable => 'Omogoči';

  @override
  String get common_disable => 'Izklopiti';

  @override
  String get common_undo => 'Preobrn';

  @override
  String get messageStatus_sent => 'Pošljeno';

  @override
  String get messageStatus_delivered => 'Dostavljeno';

  @override
  String get messageStatus_pending => 'Pošiljanje';

  @override
  String get messageStatus_failed =>
      'Uspešno ni bilo mogo, da se sporočilo pošlje';

  @override
  String get messageStatus_repeated => 'Slišal sem večkrat';

  @override
  String get urlImage_enable => 'Omogoči slike URL';

  @override
  String get urlImage_possible =>
      'Morda slika URL; omogočite jo v Nastavitvah.';

  @override
  String get common_reboot => 'Ponoviti';

  @override
  String get common_loading => 'Naložanje...';

  @override
  String get common_notAvailable => '—';

  @override
  String common_voltageValue(String volts) {
    return '$volts V';
  }

  @override
  String common_percentValue(int percent) {
    return '$percent %';
  }

  @override
  String get common_autoRefresh => 'Samodejno osveževanje';

  @override
  String get common_interval => 'Časovni interval';

  @override
  String get scanner_title => 'MeshCore – Odprto';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'Komunicirajte preko protokola TCP';

  @override
  String get tcpHostLabel => 'IP naslov';

  @override
  String get tcpHostHint => '192.168.40.10';

  @override
  String get tcpPortLabel => 'Vrata';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => 'Vnesite končni naslov in se povežite';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return 'Povezava z $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => 'Potrebna je IP-naslov.';

  @override
  String get tcpErrorPortInvalid => 'Port mora biti med 1 in 65535.';

  @override
  String get tcpErrorUnsupported =>
      'Transport preko protokola TCP ni podprt na tej platformi.';

  @override
  String get tcpErrorTimedOut => 'Povezava TCP je presegla časovno obdobje.';

  @override
  String tcpConnectionFailed(String error) {
    return 'Napaka pri povezavi TCP: $error';
  }

  @override
  String get usbScreenTitle => 'Povežite preko USB';

  @override
  String get usbScreenSubtitle =>
      'Izberite zaznano serijsko napravo in se neposredno povežite z vašo MeshCore napravo.';

  @override
  String get usbScreenStatus => 'Izberite USB naprave';

  @override
  String get usbScreenNote =>
      'USB serijska povezava je aktivna na podprtih napravah Android in na desktop platformah.';

  @override
  String get usbScreenEmptyState =>
      'Niti en USB naprave niso najdeni. Povežite eno in posodobite.';

  @override
  String get usbErrorPermissionDenied =>
      'Dovoljenje za dostop preko USB-ja je bilo zavrnjeno.';

  @override
  String get usbErrorDeviceMissing => 'Izbrani USB napravej je več ne.';

  @override
  String get usbErrorInvalidPort => 'Izberite veljavno USB naprave.';

  @override
  String get usbErrorBusy => 'Že je v teku zahteva za povezavo preko USB.';

  @override
  String get usbErrorNotConnected => 'Ni priklopljenih USB naprave.';

  @override
  String get usbErrorOpenFailed =>
      'Uspešno ni bilo mogo, da se odpre izbran naprave USB.';

  @override
  String get usbErrorConnectFailed =>
      'Niso bilo mogoče uskladiti povezave z izbranim USB napom.';

  @override
  String get usbErrorUnsupported =>
      'USB serijska komunikacija ni podprta na tej platformi.';

  @override
  String get usbErrorAlreadyActive => 'USB povezava je že aktivirana.';

  @override
  String get usbErrorNoDeviceSelected => 'Ni bilo izbranega USB naprave.';

  @override
  String get usbErrorPortClosed => 'USB povezava ni aktivirana.';

  @override
  String get usbErrorConnectTimedOut =>
      'Vzpostavitve ni bilo mogo. Prosimo, da se prepričate, da ima naprave trenutno nameštan firmware USB Companion.';

  @override
  String get usbFallbackDeviceName =>
      'Naprave za serijsko komunikacijo preko spleta';

  @override
  String get usbStatus_notConnected => 'Izberite USB naprave.';

  @override
  String get usbStatus_connecting => 'Povezava z USB napravo...';

  @override
  String get usbStatus_searching => 'Iskanje USB naprav...';

  @override
  String usbConnectionFailed(String error) {
    return 'Napaka pri povezavi preko USB: $error';
  }

  @override
  String get scanner_scanning => 'Skeniram za naprave...';

  @override
  String get scanner_connecting => 'Povezujem se...';

  @override
  String get scanner_disconnecting => 'Odklapljam se...';

  @override
  String get scanner_notConnected => 'Nezavezan';

  @override
  String scanner_connectedTo(String deviceName) {
    return 'Povezan s $deviceName';
  }

  @override
  String get scanner_searchingDevices => 'Iskanje naprav MeshCore...';

  @override
  String get scanner_tapToScan =>
      'Nagneš na skeniranje za najdene naprave MeshCore.';

  @override
  String scanner_connectionFailed(String error) {
    return 'Pošlo je z povezavo: $error';
  }

  @override
  String get scanner_stop => 'Prekliči';

  @override
  String get scanner_scan => 'Skeniraj';

  @override
  String get scanner_bluetoothOff => 'Bluetooth je izklopljen';

  @override
  String get scanner_bluetoothOffMessage =>
      'Prosimo, vklopite Bluetooth, da lahko poiščete naprave.';

  @override
  String get scanner_chromeRequired => 'Zahtevan brskalnik Chrome';

  @override
  String get scanner_chromeRequiredMessage =>
      'Ta spletna aplikacija za podporo Bluetooth zahteva Google Chrome ali brskalnik na osnovi Chromiuma.';

  @override
  String get scanner_enableBluetooth => 'Omogočite Bluetooth';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'Funkcija Bluetooth v brskalniku ni na voljo. Povežite se preko USB-ja namesto tega.';

  @override
  String get device_quickSwitch => 'Hitro preklop';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => 'Nastavitve';

  @override
  String get settings_deviceInfo => 'Informacije o napravei';

  @override
  String get settings_appSettings => 'Nastavitve aplikacije';

  @override
  String get settings_appSettingsSubtitle =>
      'Obveščanja, sporoščanje in zemljevidi.';

  @override
  String get settings_nodeSettings => 'Nastavitev časa';

  @override
  String get settings_nodeName => 'Ime node-a';

  @override
  String get settings_nodeNameNotSet => 'Ni nastavljeno';

  @override
  String get settings_nodeNameHint => 'Vnesite ime node-a';

  @override
  String get settings_nodeNameUpdated => 'Ime posodobljeno';

  @override
  String get settings_radioSettings => 'Nastavitve radija';

  @override
  String get settings_radioSettingsSubtitle =>
      'Frekvenca, moč, razširitveni faktor';

  @override
  String get settings_radioSettingsUpdated => 'Radio nastavitve posodobljene';

  @override
  String get settings_regionSettings => 'Regioni';

  @override
  String get settings_regionSettingsSubtitle => 'Upravljanje opisanih regionov';

  @override
  String get settings_corridorRegion => 'Regija koridorja';

  @override
  String get settings_corridorRegionDefault => '#corridor (privzeto)';

  @override
  String get settings_corridorRegionHelp =>
      'Paketi flood koridorja so označeni s to regijo. Repetitorji brez strojne programske opreme za koridorje jih posredujejo le, če dovoljujejo to regijo. Pustite prazno za privzeto oznako #corridor.';

  @override
  String get settings_corridorRegionHint => 'Ime regije';

  @override
  String get settings_corridorRegionUseDefault => 'Uporabi privzeto';

  @override
  String get settings_corridorRegionUpdated => 'Regija koridorja posodobljena';

  @override
  String get settings_corridorRegionFailed =>
      'Regije koridorja ni bilo mogoče posodobiti';

  @override
  String get settings_regionManagement_screenTitle => 'Regijonsko upravljanje';

  @override
  String get settings_regionNameHint => 'Naslov občine';

  @override
  String get settings_regionAddRegion => 'Dodaj region';

  @override
  String get settings_regionFetchRegions =>
      'Pobražujte izvajne področja iz ponavljalnikov';

  @override
  String get settings_regionFetchRegionsFail => 'Nižnih občin ni izkrali';

  @override
  String get settings_regionFetchRegionsAlreadyExists =>
      'Taj oblasi je več pomanjkan.';

  @override
  String get settings_regionName => 'Naziv Regiona';

  @override
  String get settings_regionDeleted => 'Oblikačena regija';

  @override
  String get settings_deleteRegion => 'Prihoda Region';

  @override
  String settings_deleteRegionConfirm(String region) {
    return 'Ostani $region iz listy regionov?';
  }

  @override
  String get settings_location => 'Lokacija';

  @override
  String get settings_locationSubtitle => 'GPS koordinate';

  @override
  String get settings_locationUpdated => 'Lokacija posodobljena';

  @override
  String get settings_locationBothRequired => 'Vnesite širino in dolžino.';

  @override
  String get settings_locationInvalid =>
      'Neveljavna zemeljska širina ali dolžina.';

  @override
  String get settings_locationGPSEnable => 'Omogoči GPS';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'Omogoči samodejno posodabljanje lokacije z GPS-jem.';

  @override
  String get settings_locationIntervalSec => 'Interval za GPS (Sekunde)';

  @override
  String get settings_locationIntervalInvalid =>
      'Intervallo mora biti vsaj 60 sekund in manj kot 86400 sekund.';

  @override
  String get settings_latitude => 'Širina';

  @override
  String get settings_longitude => 'Dolžina';

  @override
  String get settings_contactSettings => 'Nastavitve stika';

  @override
  String get settings_contactSettingsSubtitle =>
      'Nastavitve za dodajanje stikov.';

  @override
  String get settings_privacyMode => 'Zasebnost';

  @override
  String get settings_privacyModeSubtitle => 'Skrita imena/lokacije v oglasih';

  @override
  String get settings_privacyModeToggle =>
      'Omogoči način zasebnosti, da skrijemo tvoje ime in lokacijo v oglasih.';

  @override
  String get settings_privacyModeEnabled => 'Privatni način je omogočen.';

  @override
  String get settings_privacyModeDisabled => 'Privatni način je onemogočen.';

  @override
  String get settings_privacy => 'Nastavitve zasebnosti';

  @override
  String get settings_privacySubtitle =>
      'Kontrolirajte, katere informacije so deljene.';

  @override
  String get settings_privacySettingsDescription =>
      'Izberite, katere informacije vaš naprava deli z drugimi.';

  @override
  String get settings_denyAll => 'Zavrniti vse';

  @override
  String get settings_allowByContact => 'Dovoli po kontaktnih zastavah';

  @override
  String get settings_allowAll => 'Dovoli vse';

  @override
  String get settings_telemetryBaseMode => 'Osnovni način telemetrije';

  @override
  String get settings_telemetryLocationMode => 'Način delovanja telemetrije';

  @override
  String get settings_telemetryEnvironmentMode =>
      'Način delovanja okolja telemetrije';

  @override
  String get settings_advertLocation => 'Lokacija oglasa';

  @override
  String get settings_advertLocationSubtitle => 'Vključi lokacijo v oglas.';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'Samodejni zero-hop oglas ob posodobitvi GPS';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'Ko se GPS lokacija spremeni, pošlji zero-hop oglas (zahteva lokacijo v oglasu).';

  @override
  String get settings_multiAck => 'Več potrdil';

  @override
  String get settings_telemetryModeUpdated => 'Način telemetrije posodobljen';

  @override
  String get settings_actions => 'Akcije';

  @override
  String get settings_deleteAllPaths => 'Delete All Paths';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Clear all path data from contacts.';

  @override
  String get settings_sendAdvertisement => 'Pošlji Oglas';

  @override
  String get settings_sendAdvertisementSubtitle =>
      'Trenutna prisotnost v oddajah';

  @override
  String get settings_advertisementSent => 'Oglas poslan';

  @override
  String get settings_syncTime => 'Nastavi uro';

  @override
  String get settings_syncTimeSubtitle => 'Nastavi uro naprave na čas telefona';

  @override
  String get settings_timeSynchronized => 'Ura sinhronizirana';

  @override
  String get settings_refreshContacts => 'Ponovno obišči kontakte';

  @override
  String get settings_refreshContactsSubtitle =>
      'Ponovno naloži seznam stikov v napravi';

  @override
  String get settings_rebootDevice => 'Ponovni zagon naprave';

  @override
  String get settings_rebootDeviceSubtitle => 'Ponovno zaženi MeshCore napravo';

  @override
  String get settings_rebootDeviceConfirm =>
      'Ste prepričani, da želite ponovno zagnati napravo? Povezava bo prekinjena.';

  @override
  String get settings_debug => 'Odpravljanje napak';

  @override
  String get settings_companionDebugLog => 'Log zapis za odpravljanje napak';

  @override
  String get settings_companionDebugLogSubtitle =>
      'Navodila, odgovori in surova podatka za BLE/TCP/USB.';

  @override
  String get settings_appDebugLog => 'Logi aplikacije';

  @override
  String get settings_appDebugLogSubtitle => 'Debug sporočila aplikacije';

  @override
  String get settings_about => 'Oglejte si';

  @override
  String settings_aboutVersion(String version) {
    return 'MeshCore, različ $version';
  }

  @override
  String get settings_aboutLegalese => 'Odprtokodni projekt MeshCore 2024';

  @override
  String get settings_aboutDescription =>
      'Odprtokodni Flutter klient za naprave za LoRa omrežje MeshCore.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'Podatki o višini LOS: Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => 'Ime';

  @override
  String get settings_infoId => 'ID';

  @override
  String get settings_infoStatus => 'Stanje';

  @override
  String get settings_infoBattery => 'Baterija';

  @override
  String get settings_infoPublicKey => 'Javni ključ';

  @override
  String get settings_infoContactsCount => 'Število stikov';

  @override
  String get settings_infoChannelCount => 'Število kanalov';

  @override
  String get settings_infoHardware => 'Hardver';

  @override
  String get settings_infoFirmware => 'Pravilnik';

  @override
  String get settings_presets => 'Prednastavitve';

  @override
  String get settings_frequency => 'Frekvenca (MHz)';

  @override
  String get settings_frequencyHelper => '300,00 - 2500,00';

  @override
  String get settings_frequencyInvalid => 'Neveljavna frekvenca (300-2500 MHz)';

  @override
  String get settings_bandwidth => 'Pasovna širina';

  @override
  String get settings_spreadingFactor => 'Razširitveni faktor';

  @override
  String get settings_codingRate => 'Programska hitrost';

  @override
  String get settings_txPower => 'TX Moč (dBm)';

  @override
  String get settings_txPowerHelper => '0 – 22';

  @override
  String get settings_txPowerInvalid => 'Neveljavna TX moč (0-22 dBm)';

  @override
  String get settings_clientRepeat => 'Neovadno ponavljanje';

  @override
  String get settings_clientRepeatSubtitle =>
      'Omogočite temu naprave, da ponavlja paketne sporočila za druge.';

  @override
  String get settings_clientRepeatFreqWarning =>
      'Za ponovni prenos na brezžični način so potrebne frekvence 433, 869 ali 918 MHz.';

  @override
  String settings_error(String message) {
    return 'Napaka: $message';
  }

  @override
  String get appSettings_title => 'Nastavitve aplikacije';

  @override
  String get appSettings_appearance => 'Prikaži';

  @override
  String get appSettings_theme => 'Tema';

  @override
  String get appSettings_themeSystem => 'Sistemska tema';

  @override
  String get appSettings_themeLight => 'Svetlo';

  @override
  String get appSettings_themeDark => 'Temno';

  @override
  String get appSettings_language => 'Jezik';

  @override
  String get appSettings_languageSystem => 'Sistemska privzeta vrednost';

  @override
  String get appSettings_languageEn => 'Angleščina';

  @override
  String get appSettings_languageFr => 'Francija';

  @override
  String get appSettings_languageEs => 'Španščina';

  @override
  String get appSettings_languageDe => 'Nemščina';

  @override
  String get appSettings_languagePl => 'Poljski';

  @override
  String get appSettings_languageSl => 'Slovenščina';

  @override
  String get appSettings_languagePt => 'Portugalski';

  @override
  String get appSettings_languageIt => 'Italijanščina';

  @override
  String get appSettings_languageZh => '中文';

  @override
  String get appSettings_languageSv => 'Švedska';

  @override
  String get appSettings_languageNl => 'Nizozemsko';

  @override
  String get appSettings_languageSk => 'Slovenščina';

  @override
  String get appSettings_languageBg => 'Български';

  @override
  String get appSettings_languageRu => 'Ruščina';

  @override
  String get appSettings_languageUk => 'Ukrajinsko';

  @override
  String get repeater_pathHashModeOption0 => '0 - 1 bajt';

  @override
  String get repeater_pathHashModeOption1 => '1 - 2 bite';

  @override
  String get repeater_pathHashModeOption2 => '2 - 3 bite';

  @override
  String get repeater_pathHashModeOption3 => '3 - 4 bite';

  @override
  String get appSettings_enableMessageTracing => 'Omogoči sledenje sporočilom';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'Prikaži podrobne metapodatke o usmerjanju in časovnem usklajevanju sporočil';

  @override
  String get appSettings_notifications => 'Obvestila';

  @override
  String get appSettings_enableNotifications => 'Omogoči obvestila';

  @override
  String get appSettings_enableNotificationsSubtitle =>
      'Prejmite obvestila o sporočilih in oglasih';

  @override
  String get appSettings_notificationPermissionDenied =>
      'Odobritev obvestila zavrnjena';

  @override
  String get appSettings_notificationsEnabled => 'Obvestila omogočena';

  @override
  String get appSettings_notificationsDisabled => 'Obvestila so izklopljena';

  @override
  String get appSettings_messageNotifications => 'Obvestila';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      'Pokaži obvestilo ob prejemu novih sporočil.';

  @override
  String get appSettings_channelMessageNotifications =>
      'Obvestila o sporočilih kanala';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'Pokaži obvestilo ob prejemanju sporočil kanala';

  @override
  String get appSettings_advertisementNotifications => 'Opozorila o oglasih';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      'Pokaži obvestilo, ko so najdene nove naprave.';

  @override
  String get appSettings_messaging => 'Komuniciranje';

  @override
  String get appSettings_clearPathOnMaxRetry =>
      'Ponovite pot do cilja na največjem štetju';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      'Ponovi pot zimske obveščevalne poti po 5 neuspešnih poskusih pošiljanja';

  @override
  String get appSettings_pathsWillBeCleared =>
      'Počisti pot po 5 neuspešnih poskusih.';

  @override
  String get appSettings_pathsWillNotBeCleared =>
      'Poti ne bodo samodejno čiščene.';

  @override
  String get appSettings_autoRouteRotation =>
      'Avtomatsko rotacija prenosne poti';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      'Menjaj med boljšo potjo in flood načinom';

  @override
  String get appSettings_autoRouteRotationEnabled =>
      'Samodejno krmilno rotiranje omogočeno';

  @override
  String get appSettings_autoRouteRotationDisabled =>
      'Samodejno krmilno rotiranje je onemogočeno';

  @override
  String get appSettings_maxRouteWeight => 'Največja dovoljena teža poti';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      'Največja teža, ki jo lahko pot doseže s uspešnimi dostavnami.';

  @override
  String get appSettings_initialRouteWeight => 'Izvirna teža poti';

  @override
  String get appSettings_initialRouteWeightSubtitle =>
      'Izguba teže za nove, odkriti poti';

  @override
  String get appSettings_routeWeightSuccessIncrement =>
      'Učinkovitost: povečanje';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      'Težava, dodana poti po uspešni dostavi';

  @override
  String get appSettings_routeWeightFailureDecrement =>
      'Zmanjšanje teže, ki je povezana s pomanjkanjem';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      'Težo, ki ni bila uspešno dostavljena, odstranili s poti.';

  @override
  String get appSettings_maxMessageRetries =>
      'Najve število poskusov pošiljanja sporočil';

  @override
  String get appSettings_maxMessageRetriesSubtitle =>
      'Število poskusov ponovnega poslanja, preden se sporočilo označuje kot neuspešno';

  @override
  String get appSettings_battery => 'Baterija';

  @override
  String get appSettings_batteryChemistry => 'Kemija baterije';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return 'Nastavitev za napravo ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      'Za izbiro se poveži z napravo';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3,0-4,2V)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2,6–3,65 V)';

  @override
  String get appSettings_batteryLipo => 'LiPo (3,0-4,2V)';

  @override
  String get appSettings_batteryLipoHv => 'LiPo HV (3,0–4,35 V)';

  @override
  String get appSettings_mapDisplay => 'Prikaz zemljevida';

  @override
  String get appSettings_showRepeaters => 'Prikaži repetitorje';

  @override
  String get appSettings_showRepeatersSubtitle => 'Prikaži repetitorje na mapi';

  @override
  String get appSettings_showChatNodes => 'Prikaži naprave za klepet';

  @override
  String get appSettings_showChatNodesSubtitle =>
      'Prikaži naprave na zemljevidu';

  @override
  String get appSettings_showOtherNodes => 'Pokaži druge naprave';

  @override
  String get appSettings_showOtherNodesSubtitle =>
      'Pokaži druge vrste naprav na zemljevidu.';

  @override
  String get appSettings_timeFilter => 'Filter po času';

  @override
  String get appSettings_timeFilterShowAll => 'Pokaži vse naprave';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return 'Pokaži naprave v zadnjih $hours urah';
  }

  @override
  String get appSettings_mapTimeFilter => 'Filter časa na zemljevidu';

  @override
  String get appSettings_showNodesDiscoveredWithin =>
      'Pokaži naprave odkrite v:';

  @override
  String get appSettings_allTime => 'Brez omejitev';

  @override
  String get appSettings_lastHour => 'V zadnji uri';

  @override
  String get appSettings_last6Hours => 'Zadnjih 6 ur';

  @override
  String get appSettings_last24Hours => 'Zadnjih 24 ur';

  @override
  String get appSettings_lastWeek => 'Prejšnji teden';

  @override
  String get appSettings_rasterTileSource => 'Vir rastrskih ploščic';

  @override
  String get appSettings_stadiaEndpoint => 'Končna točka Stadia';

  @override
  String get appSettings_stadiaApiKey => 'Ključ API Stadia';

  @override
  String get appSettings_stadiaApiKeyRequired =>
      'Obvezno za uporabo Stadia Maps';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return 'Nastavljeno: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Vnesite svoj ključ API za Stadia Maps. Aplikacija ga uporablja za zahteve rastrskih ploščic.';

  @override
  String get appSettings_offlineMapCache => 'Shramba zemljevidov brez povezave';

  @override
  String get appSettings_unitsTitle => 'Enote';

  @override
  String get appSettings_unitsMetric => 'Metrična (m/km)';

  @override
  String get appSettings_unitsImperial => 'Imperialno (ft / mi)';

  @override
  String get appSettings_noAreaSelected => 'Območje ni izbrano';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'Izbrano območje (povečava $minZoom-$maxZoom)';
  }

  @override
  String get appSettings_debugCard => 'Razhroščevanje';

  @override
  String get appSettings_appDebugLogging => 'Programski dnevnik';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'Dnevnik debug sporočil za odpravljanje težav';

  @override
  String get appSettings_appDebugLoggingEnabled =>
      'Beleženje napak v aplikaciji omogočeno';

  @override
  String get appSettings_appDebugLoggingDisabled =>
      'Beleženje napak v aplikacije onemogočeno.';

  @override
  String get contacts_title => 'Stiki';

  @override
  String get contacts_noContacts => 'Ni stikov.';

  @override
  String get contacts_contactsWillAppear =>
      'Stiki se bodo prikazali, ko se naprave oglasijo.';

  @override
  String get contacts_unread => 'Neprebrano';

  @override
  String get contacts_searchContactsNoNumber => 'Iskanje stikov...';

  @override
  String contacts_searchContacts(int number, String str) {
    return 'Iskanje stikov...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'Iskanje $number$str priljubljenih...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'Išči $number$str uporabnikov...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'Išči $number$str ponavljalnike...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'Išči $number$str strežnikov sob...';
  }

  @override
  String get contacts_noUnreadContacts => 'Ne prebrani stiki.';

  @override
  String get contacts_noContactsFound => 'Stiki niso najdeni.';

  @override
  String get contacts_deleteContact => 'Izbriši stik';

  @override
  String contacts_removeConfirm(String contactName) {
    return 'Izbrišem $contactName iz stikov?';
  }

  @override
  String get contacts_manageRepeater => 'Upravljaj Ponovitve';

  @override
  String get contacts_manageRoom => 'Upravljajte strežnik sobe';

  @override
  String get contacts_roomLogin => 'Prijava v sobo';

  @override
  String get contacts_openChat => 'Odpri klepet';

  @override
  String get contacts_editGroup => 'Uredi skupino';

  @override
  String get contacts_deleteGroup => 'Izbriši skupino';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return 'Izbriši $groupName?';
  }

  @override
  String get contacts_newGroup => 'Nova skupina';

  @override
  String get contacts_moreOptions => 'Več možnosti';

  @override
  String get contacts_searchOpen => 'Iskanje kontaktov';

  @override
  String get contacts_searchClose => 'Izklopi iskanje';

  @override
  String get contacts_groupName => 'Ime skupine';

  @override
  String get contacts_groupNameRequired => 'Ime skupine je obvezno.';

  @override
  String get contacts_groupNameReserved => 'To ime skupine je rezervirano';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'Skupina \"$name\" že obstaja';
  }

  @override
  String get contacts_filterContacts => 'Filtriraj stik\\,...';

  @override
  String get contacts_noContactsMatchFilter =>
      'Noben stik ne ustreza vašemu kriteriju.';

  @override
  String get contacts_noMembers => 'Ni članov.';

  @override
  String get contacts_lastSeenNow => 'Nazadnje viden zdaj';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return 'Zadnjič viden pred $minutes minutami';
  }

  @override
  String get contacts_lastSeenHourAgo => 'Zadnjič viden pred 1 uro.';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return 'Zadnjič viden pred $hours urami';
  }

  @override
  String get contacts_lastSeenDayAgo => 'Zadnjič viden pred 1 dnem';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return 'Zadnjič viden pred $days dnem';
  }

  @override
  String get contact_info => 'Kontaktni podatki';

  @override
  String get contact_settings => 'Nastavitve stika';

  @override
  String get contact_telemetry => 'Telemetrija';

  @override
  String get contact_lastSeen => 'Zadnjič videno';

  @override
  String get contact_clearChat => 'Počisti klepet';

  @override
  String get contact_teleBase => 'Baza telemetrije';

  @override
  String get contact_teleBaseSubtitle =>
      'Dovoli deljenje stanja baterije in osnovne telemetrije';

  @override
  String get contact_teleLoc => 'Lokacija telemetrije';

  @override
  String get contact_teleLocSubtitle => 'Dovoli deljenje podatkov o lokaciji';

  @override
  String get contact_teleEnv => 'Okolje telemetrije';

  @override
  String get contact_teleEnvSubtitle =>
      'Dovoli deljenje podatkov okoljskih senzorjev';

  @override
  String get channels_title => 'Kanali';

  @override
  String get channels_noChannelsConfigured => 'Kanali še niso konfigurirani';

  @override
  String get channels_addPublicChannel => 'Dodaj javni kanal';

  @override
  String get channels_searchChannels => 'Poišči kanale...';

  @override
  String get channels_noChannelsFound => 'Ne najdem kanalov.';

  @override
  String channels_channelIndex(int index) {
    return 'Kanal $index';
  }

  @override
  String get channels_public => 'Javni';

  @override
  String channels_via(String path) {
    return 'via $path';
  }

  @override
  String get channels_viaMqtt => 'prek MQTT';

  @override
  String get channels_viaMqttSemantics =>
      'Prejeto prek MQTT, vaš radio ga ni slišal';

  @override
  String get channels_private => 'Zasebni';

  @override
  String get channels_editChannel => 'Uredi kanal';

  @override
  String get channels_muteChannel => 'Utišaj kanal';

  @override
  String get channels_unmuteChannel => 'Vklopi obvestila kanala';

  @override
  String get channels_deleteChannel => 'Pošlji kanal';

  @override
  String channels_deleteChannelConfirm(String name) {
    return 'Izbrišem \"$name\"? To se ne da povrniti.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'Kanala $name ni bilo mogoče izbrisati';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'Kanal \"$name\" izbrisan.';
  }

  @override
  String get channels_addChannel => 'Dodaj Kanal';

  @override
  String get channels_channelIndexLabel => 'Indeks kanala';

  @override
  String get channels_channelName => 'Ime kanala';

  @override
  String get channels_usePublicChannel => 'Uporabi javni kanal';

  @override
  String get channels_standardPublicPsk => 'Standardni javni PSK';

  @override
  String get channels_pskHex => 'PSK (Šestnajstbinska)';

  @override
  String get channels_generateRandomPsk => 'Generiraj naključni PSK';

  @override
  String get channels_enterChannelName => 'Vnesi ime kanala';

  @override
  String get channels_pskMustBe32Hex =>
      'PSK mora biti 32 heksadecimalnih znakov.';

  @override
  String channels_channelAdded(String name) {
    return 'Kanal \"$name\" dodan';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'Uredi Kanal $index';
  }

  @override
  String get channels_smazCompression => 'Kompresija SMAZ';

  @override
  String get channels_cyr2latCompression => 'Kompresija Cyr2Lat';

  @override
  String get channels_cyr2latCompressionDscr =>
      'Pri pošiljanju nekatere cirilice nadomesti z latiničnimi.';

  @override
  String get channels_cyr2latSettingsHeading => 'Nastavitve Cyr2Lat';

  @override
  String get channels_cyr2latSettingsSubheading => 'Seznam zamenjav';

  @override
  String get channels_cyr2latSettingsDscr =>
      'Uredi JSON-konfiguracijo zamenjav znakov';

  @override
  String get channels_cyr2latSettingsDialogHint => 'JSON-tabela zamenjav';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'Nepravilen JSON: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'Kanal $name je bil posodobljen';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Dodaj profil Cyr2Lat';

  @override
  String get settings_cyr2latProfileName => 'Ime profila';

  @override
  String get settings_cyr2latProfileNameEmpty =>
      'Ime profila ne sme biti prazno';

  @override
  String get settings_cyr2latProfileAdded => 'Profil je bil uspešno dodan';

  @override
  String get settings_cyr2latProfileUpdated =>
      'Profil je bil uspešno posodobljen';

  @override
  String get settings_cyr2latProfileEdit => 'Uredi profil Cyr2Lat';

  @override
  String get settings_cyr2latProfileDelete => 'Izbriši profil Cyr2Lat';

  @override
  String get settings_cyr2latProfileDeleted => 'Profil je bil uspešno izbrisan';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return 'Ali res želite izbrisati profil \"$name\"?';
  }

  @override
  String get channels_publicChannelAdded => 'javna skupnost dodana';

  @override
  String get channels_sortBy => 'Sortiraj po';

  @override
  String get channels_sortManual => 'Ročno';

  @override
  String get channels_sortAZ => 'A do Z';

  @override
  String get channels_sortLatestMessages => 'Najnovejše sporočilo';

  @override
  String get channels_sortUnread => 'Nerešeno';

  @override
  String get channels_createPrivateChannel => 'Ustvari zasebno kanal.';

  @override
  String get channels_createPrivateChannelDesc =>
      'Varno zaklenjeno s skrivnim ključem.';

  @override
  String get channels_joinPrivateChannel => 'Pridružite se zasebni skupini';

  @override
  String get channels_joinPrivateChannelDesc => 'Ročno vnesite zaporni ključ.';

  @override
  String get channels_joinPublicChannel => 'Pridružite se javnemu kanalu';

  @override
  String get channels_joinPublicChannelDesc =>
      'Kdor karkoli je, lahko se pridruži tej skupini.';

  @override
  String get channels_joinHashtagChannel => 'Pridružite se Kanalu z Hashtagom';

  @override
  String get channels_joinHashtagChannelDesc =>
      'Kdor karkoli, lahko se pridruži hashtag kanalom.';

  @override
  String get channels_scanQrCode => 'Skeniraj QR kodo';

  @override
  String get channels_scanQrCodeComingSoon => 'Prihajajoča';

  @override
  String get channels_enterHashtag => 'Vnesite hashtag';

  @override
  String get channels_hashtagHint => 'npr. #ekipa';

  @override
  String channels_regionSetTo(String region) {
    return 'Osebno: $region';
  }

  @override
  String get channels_regionNotSet => 'Region: brak';

  @override
  String get channels_regionSelect_Title => 'Vablajte region';

  @override
  String get channels_clearRegion => 'Jasna regija';

  @override
  String get chat_noMessages => 'Še ni sporočil.';

  @override
  String get chat_sendMessage => 'Pošlji sporočilo';

  @override
  String chat_sendMessageTo(String contactName) {
    return 'Pošlji sporočilo $contactName';
  }

  @override
  String get chat_sendMessageToStart => 'Pošlji sporočilo za začetek.';

  @override
  String get chat_originalMessageNotFound =>
      'Opozorilo: Sporočilo ni bilo najdeno';

  @override
  String chat_replyingTo(String name) {
    return 'Odgovarjanje $name';
  }

  @override
  String chat_replyTo(String name) {
    return 'Odpošlji odgovor $name';
  }

  @override
  String get chat_location => 'Lokacija';

  @override
  String get chat_typeMessage => 'Vnesi sporočilo...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'Pošiljanje sporočila je onemogočeno, saj je preveliko (maksimalno $maxBytes byte-ov).';
  }

  @override
  String get chat_messageCopied => 'Sporočilo poslano';

  @override
  String get chat_messageDeleted => 'Sporočilo izbrisano';

  @override
  String get chat_retryingMessage => 'Ponovni poskus.';

  @override
  String chat_retryCount(int current, int max) {
    return 'Ponovit $current/$max';
  }

  @override
  String get chat_selectSendAction => 'Izberite dejanje pošiljanja';

  @override
  String get chat_sendGif => 'Pošlji GIF';

  @override
  String get chat_limitToArea => 'Omeji na območje';

  @override
  String get chat_limitToAreaTitle => 'Pošlji samo znotraj…';

  @override
  String get chat_limitToAreaHelp =>
      'Repetitorji s strojno programsko opremo za flood koridorje sporočilo posredujejo le znotraj tega območja. Drugi repetitorji ga zavržejo, razen če dovoljujejo vašo regijo koridorja.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '$km km od vas';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return 'Samo do $km km od vas';
  }

  @override
  String get chat_limitToAreaOff => 'Brez omejitve';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'Nastavite položaj radia, da lahko sporočila omejite na območje.';

  @override
  String get chat_sendImageLora => 'Pošlji sliko prek MeshCore';

  @override
  String get chat_imagePickFailed => 'Nispeval sem tega ta slik';

  @override
  String get chat_receivedGif => 'Otrvljen GIF';

  @override
  String get chat_reply => 'Odgovori';

  @override
  String get chat_addReaction => 'Dodaj reakcijo';

  @override
  String get chat_me => 'jaz';

  @override
  String get reaction_report => 'Odzivi z emodžiji';

  @override
  String get emojiCategorySmileys => 'Emoji';

  @override
  String get emojiCategoryGestures => 'Gestikulacije';

  @override
  String get emojiCategoryHearts => 'Srce';

  @override
  String get emojiCategoryObjects => 'Predmeti';

  @override
  String get gifPicker_title => 'Izberi GIF';

  @override
  String get gifPicker_searchHint => 'Išči GIF-e...';

  @override
  String get gifPicker_poweredBy => 'Napredno z GIPHY';

  @override
  String get gifPicker_noGifsFound => 'Ne najdem GIF-ov.';

  @override
  String get gifPicker_failedLoad => 'Neuspešno nalaganje GIF-a';

  @override
  String get gifPicker_failedSearch => 'Iskanje neuspešno.';

  @override
  String get gifPicker_noInternet => 'Ni internetne povezave';

  @override
  String get debugLog_appTitle => 'Log zapiske aplikacije';

  @override
  String get debugLog_bleTitle => 'Log zapis BLE';

  @override
  String get debugLog_copyLog => 'Kopiraj dnevnik';

  @override
  String get debugLog_clearLog => 'Briši log';

  @override
  String get debugLog_copied => 'Beležka kopirana.';

  @override
  String get debugLog_bleCopied => 'Kopirana beležka iz BLE';

  @override
  String get debugLog_noEntries => 'Ni ustvarjenih debug zapisov.';

  @override
  String get debugLog_enableInSettings =>
      'Omogoči beleženje napak v nastavitvah aplikacije';

  @override
  String get debugLog_frames => 'Okvirji';

  @override
  String get debugLog_rawLogRx => 'Svež Log-RX';

  @override
  String get debugLog_noBleActivity => 'Ni BLE aktivnosti.';

  @override
  String debugFrame_length(int count) {
    return 'Izhodni rob: $count bajtov';
  }

  @override
  String debugFrame_command(String value) {
    return 'Navodilo: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'Obvestilo:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- Destinirano Ključno Besedilo: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- Časovnik: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- Ploki: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- Tip besedila: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'CLI (Command Line Interface)';

  @override
  String get debugFrame_textTypePlain => 'Preprosto';

  @override
  String debugFrame_text(String text) {
    return '- Tekst: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => 'Izpis heksadecimalnih vrednosti:';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'skoki',
      one: 'skok',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => 'Izbriši pot';

  @override
  String get chat_noPathHistoryYet =>
      'Ni shranjenih poti.\nPošlji sporočilo za odkrivanje poti.';

  @override
  String get chat_pathCleared =>
      'Pot je očiščena. Naslednje sporočilo bo ponovno odkril pot.';

  @override
  String get chat_fullPath => 'Polna pot';

  @override
  String get routing_title => 'Navigacija';

  @override
  String get routing_modeAuto => 'Avto';

  @override
  String get routing_modeFlood => 'Poplavo';

  @override
  String get routing_modeManual => 'Navodilo';

  @override
  String get routing_modeAutoHint =>
      'Samodejno izbere najbolj poznano pot, in sicer, ko ni na voljo nobena.';

  @override
  String get routing_modeFloodHint =>
      'Prenosi preko vseh repetitorjev. Najzanesljivejši način, vendar zahteva več časa.';

  @override
  String get routing_modeManualHint =>
      'Vedno sledi natančni poti, ki jo ste določili.';

  @override
  String get routing_currentRoute => 'Trenutna pot';

  @override
  String get routing_directNoHops => 'Neposredno – brez prehodov';

  @override
  String get routing_noPathYet =>
      'Žep trenutno ni mogoče najti. Naslednje sporočilo bo posredovano, dokler ne bo ugotovljeno, kje je pot.';

  @override
  String get routing_floodBroadcast => 'Prenos preko vseh repetitiv';

  @override
  String get routing_editPath => 'Uredi pot';

  @override
  String get routing_forgetPath => 'Pozabi na pot';

  @override
  String get routing_knownPaths => 'Poznati poti';

  @override
  String get routing_knownPathsHint => 'Kliknite na pot, da jo izberete.';

  @override
  String get routing_inUse => 'V uporabi';

  @override
  String get routing_qualityStrong => 'Močan prvi korak';

  @override
  String get routing_qualityGood => 'Prva uspešna faza';

  @override
  String get routing_qualityFair => 'Prva, uspešna faza';

  @override
  String get routing_qualityWorked => 'Izpolnil';

  @override
  String get routing_qualityFlood => 'Slišano preko poplave';

  @override
  String get routing_qualityUntested => 'Ne preizkušen';

  @override
  String routing_lastWorked(String when) {
    return 'delal/a $when';
  }

  @override
  String get routing_neverWorked => 'nikoli ni bilo potrjeno';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes delivered, $failures failed';
  }

  @override
  String get routing_floodDelivery => 'Dostava zaradi poplave';

  @override
  String get pathEditor_title => 'Izgradnja poti';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count od 64 različnih sort hropa';
  }

  @override
  String get pathEditor_noHops =>
      'Še niso dodani hmelji. Za dodajanje hmelja v vrstnem redu kliknite na povezavo spodaj, ali pa shranite brez dodanega hmelja, da ga lahko posredujete neposredno.';

  @override
  String get pathEditor_addHops => 'Dodajte suho travo v skladu s postopkom.';

  @override
  String get pathEditor_searchRepeaters => 'Iskanje ponovitev';

  @override
  String get pathEditor_advancedHex => 'Napredno: surovi šestnajstni pot';

  @override
  String get pathEditor_hexLabel => 'Predfiks za heksadecimalno šifro';

  @override
  String get pathEditor_hexHelper =>
      'Dva šestbitna znaka na vsak skok, ločena z vejico';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return 'Neveljaven: $tokens';
  }

  @override
  String get pathEditor_tooManyHops => 'Največ 64 hopov';

  @override
  String get pathEditor_usePath => 'Uporabite to poto';

  @override
  String get pathEditor_removeHop => 'Odstranite hmelj';

  @override
  String get pathEditor_unknownHop => 'Neznani ponovitelj';

  @override
  String get chat_pathSavedLocally =>
      'Shrano lokalno. Povežite se za sinhronizacijo.';

  @override
  String get chat_pathDeviceConfirmed => 'Naprave potrjeno.';

  @override
  String get chat_pathDeviceNotConfirmed => 'Naprave še niso potrdile.';

  @override
  String get chat_type => 'Vnesite';

  @override
  String get chat_path => 'Pot';

  @override
  String get chat_publicKey => 'Ključ javnega tipa';

  @override
  String get chat_compressOutgoingMessages => 'Stisnite izhodne sporočila';

  @override
  String get chat_floodForced => 'Porolni (nasilje).';

  @override
  String get chat_directForced => 'Nezglašen (nasilje)';

  @override
  String chat_hopsForced(int count) {
    return '$count skoki (nasilje)';
  }

  @override
  String get chat_floodAuto => 'Preplavljenje (avtomatizirano)';

  @override
  String get chat_direct => 'Neposredni';

  @override
  String get chat_poiShared => 'Deljeno točke MN';

  @override
  String chat_unread(int count) {
    return 'Nerešeno: $count';
  }

  @override
  String get chat_markAsUnread => 'Označiti kot neneobdelano';

  @override
  String get chat_newMessages => 'Nove novice';

  @override
  String get chat_openLink => 'Odpreti povezavo?';

  @override
  String get chat_openLinkConfirmation =>
      'Ali želite odpreti to povezavo v brskalniku?';

  @override
  String get chat_open => 'Odpri';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'Povezave ni bilo mogoče odpreti: $url';
  }

  @override
  String get chat_invalidLink => 'Neveljavna oblika povezave';

  @override
  String get map_title => 'Mapa omrežja';

  @override
  String get map_searchHint => 'Iščite ime ali ID vozlišča';

  @override
  String get map_activity => 'Dejavnost';

  @override
  String get map_online => 'V omrežju';

  @override
  String get map_recent => 'Nedavni';

  @override
  String get map_stale => 'Zastarelo';

  @override
  String get map_visible => 'Vidno';

  @override
  String get map_hidden => 'Skrit';

  @override
  String get map_centerOnNode => 'Centriraj na vozlišče';

  @override
  String get map_details => 'Podrobnosti';

  @override
  String get map_noGps => 'Brez GPS';

  @override
  String get map_noResults => 'Ni ujemajočih se vozlišč';

  @override
  String get map_lineOfSight => 'Linija vida';

  @override
  String get map_losScreenTitle => 'Linija vida';

  @override
  String get map_noNodesWithLocation =>
      'Nihče od notranjih elementov nima podatkov o lokaciji.';

  @override
  String get map_nodesNeedGps =>
      'Omrežje morajo deliti svoje GPS koordinate,\nda se prikazao na zemljeobrazniku.';

  @override
  String map_nodesCount(int count) {
    return 'Omize: $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'Žigovi: $count';
  }

  @override
  String get map_chat => 'Čistemar';

  @override
  String get map_repeater => 'Ponovitelj';

  @override
  String get map_room => 'Soba';

  @override
  String get map_sensor => 'Senzor';

  @override
  String get map_pinDm => 'Zavežite (DM)';

  @override
  String get map_pinPrivate => 'Zasebno označit';

  @override
  String get map_pinPublic => 'Oznaka (javna)';

  @override
  String get map_lastSeen => 'Zadnjič Zazet';

  @override
  String get map_disconnectConfirm =>
      'Ste prepričani, da želite se odklopiti s tega naprave?';

  @override
  String get map_from => 'Od';

  @override
  String get map_source => 'Vir';

  @override
  String get map_flags => 'Zapestnice';

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
  String get map_shareMarkerHere => 'Delite točke tukaj.';

  @override
  String get map_setAsMyLocation => 'Nastavite to kot mojo lokacijo';

  @override
  String get floodCorridor_title => 'Flood koridor';

  @override
  String get floodCorridor_previewToHere => 'Predogled flood koridorja do sem';

  @override
  String get floodCorridor_requesting => 'Radio sprašujem za koridor…';

  @override
  String get floodCorridor_unsupported =>
      'Strojna programska oprema vašega radia ne podpira flood koridorjev.';

  @override
  String get floodCorridor_noProposal =>
      'Radio ni mogel predlagati koridorja. Preverite, ali ima nastavljen položaj.';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count krogov',
      few: '$count krogi',
      two: '2 kroga',
      one: '1 krog',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return '$inside od $total znanih repetitorjev znotraj';
  }

  @override
  String get floodCorridor_straightLine =>
      'Ravna črta: na poti ni znanih repetitorjev';

  @override
  String get floodCorridor_followsRepeaters => 'Sledi znanim repetitorjem';

  @override
  String get floodCorridor_horizonLimited =>
      'Znani repetitorji ne sežejo do cilja; preostanek je ravna črta';

  @override
  String get floodCorridor_thinStretch =>
      'Del koridorja ima malo znanih repetitorjev';

  @override
  String get floodCorridor_moreCoverage =>
      'Zahtevaj večjo pokritost z repetitorji';

  @override
  String get floodCorridor_previewNote =>
      'Samo predogled. Repetitorji brez strojne programske opreme za koridorje jih ne upoštevajo.';

  @override
  String get map_pinLabel => 'Oznaka za pritrditev';

  @override
  String get map_label => 'Oznaka';

  @override
  String get map_pointOfInterest => 'Točka zanimivosti';

  @override
  String get map_sendToContact => 'Pošlji v kontakt';

  @override
  String get map_sendToChannel => 'Pošlji v kanal';

  @override
  String get map_noChannelsAvailable => 'Nihče kanalov na voljo.';

  @override
  String get map_publicLocationShare => 'Deljenje javne lokacije';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return 'Kljubite boste delili lokacijo v $channelLabel. Ta kanal je javno dostopen in vsak, ki ima PSK, ga lahko vidi.';
  }

  @override
  String get map_connectToShareMarkers =>
      'Povežite se z napravo za deljenje oznak.';

  @override
  String get map_filterNodes => 'Filtirirajte člene';

  @override
  String get map_nodeTypes => 'Vrste knope';

  @override
  String get map_chatNodes => 'Čuti zvezde';

  @override
  String get map_repeaters => 'Ponovljalniki';

  @override
  String get map_otherNodes => 'Druge vozlišča';

  @override
  String get map_showOverlaps => 'Prekrivanje ključa ponovnega predvajanja';

  @override
  String get map_keyPrefix => 'Predpona ključa';

  @override
  String get map_filterByKeyPrefix => 'Filtri po predpomniku ključa';

  @override
  String get map_publicKeyPrefix => 'Predifika javnega ključa';

  @override
  String get map_markers => 'Označitelji';

  @override
  String get map_showSharedMarkers => 'Pokaži skupno označenja';

  @override
  String get map_showGuessedLocations => 'Pokaži lokacije domnevnih not.';

  @override
  String get map_showDiscoveryContacts => 'Prikaži odkritja kontaktov';

  @override
  String get map_guessedLocation => 'Predpostavljena lokacija';

  @override
  String get map_lastSeenTime => 'Datum zadnjega vpogleda';

  @override
  String get map_sharedPin => 'Deljeno naslovno geslo';

  @override
  String get map_sharedAt => 'Deljeno';

  @override
  String get map_joinRoom => 'Pridružiti sobo';

  @override
  String get map_manageRepeater => 'Upravljajte Ponovitve';

  @override
  String get map_tapToAdd => 'Pritisnite na vozlišča, da jih dodate poti.';

  @override
  String get map_runTrace => 'Zaženi sledenje poti';

  @override
  String get map_runTraceWithReturnPath => 'Vrni se nazaj po isti poti.';

  @override
  String get map_removeLast => 'Odstrani Zadnji';

  @override
  String get map_pathTraceCancelled => 'Spremljanje poti je prekinjeno.';

  @override
  String get mapCache_title =>
      'Omrezni predpomnilnik zemljeških zemljejevskih slik';

  @override
  String get mapCache_selectAreaFirst =>
      'Izberite območje za prvo predpomnilnik.';

  @override
  String get mapCache_noTilesToDownload =>
      'Nihče slik ne bo naložil za to območje.';

  @override
  String get mapCache_downloadTilesTitle => 'Naloži ploščice';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return 'Naložiť $count plošč za uporabo v režimu brez povezave?';
  }

  @override
  String get mapCache_downloadAction => 'Naloži';

  @override
  String mapCache_cachedTiles(int count) {
    return 'Pospešeno shranjeni $count plošč';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return 'Shranjeni $downloaded ploščad ($failed neuspešno)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle =>
      'Ponovite arhiv za offline način';

  @override
  String get mapCache_clearOfflineCachePrompt =>
      'Izbriši vse predpomnilnikovane kartografske ploščice?';

  @override
  String get mapCache_offlineCacheCleared =>
      'Omrezni predpomnik je bil izbrisal.';

  @override
  String get mapCache_noAreaSelected => 'Nizona označena površina';

  @override
  String get mapCache_cacheArea => 'Omanski prostor';

  @override
  String get mapCache_useCurrentView => 'Uporabi trenutni prikaz';

  @override
  String get mapCache_zoomRange => 'Občutek razpona';

  @override
  String mapCache_estimatedTiles(int count) {
    return 'Predvideni ploščadi: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return 'Naloženo $completed / $total';
  }

  @override
  String get mapCache_downloadTilesButton => 'Naloži ploščice';

  @override
  String get mapCache_clearCacheButton => 'Ponoviti arhiv';

  @override
  String mapCache_failedDownloads(int count) {
    return 'Poslovniški izniki: $count';
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
  String get time_justNow => 'Takoj';

  @override
  String time_minutesAgo(int minutes) {
    return '$minutes minut nazaj';
  }

  @override
  String time_hoursAgo(int hours) {
    return '${hours}h nazaj';
  }

  @override
  String time_daysAgo(int days) {
    return '$days dni nazaj';
  }

  @override
  String get time_hour => 'ure';

  @override
  String get time_hours => 'ure';

  @override
  String get time_day => 'dan';

  @override
  String get time_days => 'dani';

  @override
  String get time_week => 'teden';

  @override
  String get time_weeks => 'tedne';

  @override
  String get time_month => 'mesec';

  @override
  String get time_months => 'mesi';

  @override
  String get time_minutes => 'minute';

  @override
  String get time_allTime => 'Vse časovno obdobje';

  @override
  String get dialog_disconnect => 'Odklopiti';

  @override
  String get dialog_disconnectConfirm =>
      'Ste prepričani, da želite se odklopiti s tega naprave?';

  @override
  String get login_repeaterLogin => 'Ponovni vnos';

  @override
  String get login_roomLogin => 'Vnos v sobo';

  @override
  String get login_password => 'Geslo';

  @override
  String get login_enterPassword => 'Vnesite geslo';

  @override
  String get login_savePassword => 'Shrani geslo';

  @override
  String get login_savePasswordSubtitle =>
      'Geslo bo shranjeno varno na tem pripravem.';

  @override
  String get login_repeaterDescription =>
      'Vnesite geslo za ponovljalnik, da dostopite do nastavitev in statusa.';

  @override
  String get login_roomDescription =>
      'Vnesite geslo v sobo za dostop do nastavitev in statusa.';

  @override
  String get login_routing => 'Usmerjanje';

  @override
  String get login_routingMode => 'Navodilo za usmerjevalni način';

  @override
  String get login_autoUseSavedPath => 'Avto (uporabi shranjeno pot)';

  @override
  String get login_forceFloodMode => 'Nasilje obvezati v način';

  @override
  String get login_managePaths => 'Upravljajte Potniške Proti';

  @override
  String get login_login => 'Prijava';

  @override
  String login_attempt(int current, int max) {
    return 'Poskušajo $current/$max';
  }

  @override
  String login_failed(String error) {
    return 'Prijava je bila neuspešna: $error';
  }

  @override
  String get login_failedMessage =>
      'Prijava je bila neuspešna. Geslo je napačno ali pa je repetitor nedosegljiv.';

  @override
  String get common_reload => 'Ponovno naloži';

  @override
  String get common_clear => 'Ponoviti';

  @override
  String get path_currentPathLabel => 'Trenutna pot';

  @override
  String get path_noRepeatersFound =>
      'Ne najdenih ponoviteljev ali strežnikov sob.';

  @override
  String get repeater_management => 'Upravljanje ponovitve';

  @override
  String get room_management => 'Upravljanje stremlišča';

  @override
  String get repeater_guest => 'Informacije o ponovljalniku';

  @override
  String get room_guest => 'Informacije o strežniku';

  @override
  String get repeater_managementTools => 'Upravne orodje';

  @override
  String get repeater_guestTools => 'Naložila za goste';

  @override
  String get repeater_status => 'Stanje';

  @override
  String get repeater_statusSubtitle =>
      'Pogledati stanje, statistike in sosede repeatera';

  @override
  String get repeater_telemetry => 'Telemetrija';

  @override
  String get repeater_telemetrySubtitle =>
      'Pogledate telemetrijo senzorjev in sistemske statistike';

  @override
  String get repeater_cli => 'CLI (Command Line Interface)';

  @override
  String get repeater_cliSubtitle =>
      'Pošlji ukazne povelje na ponovitveno enoto.';

  @override
  String get repeater_neighbors => 'Sosedi';

  @override
  String get repeater_neighborsSubtitle => 'Pogledati nič sosednjih hopjev.';

  @override
  String get repeater_settings => 'Nastavitve';

  @override
  String get repeater_settingsSubtitle =>
      'Konfigurirajte parametre ponovitelja';

  @override
  String get repeater_clockSyncAfterLogin => 'Sinhronizacija ure po prijavi';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      'Samodejno po uspešnem vstopu pošljite obvestilo o sinhronizaciji časa.';

  @override
  String get repeater_statusTitle => 'Status ponovitelja';

  @override
  String get repeater_routingMode => 'Navodilo za usmerjevalni način';

  @override
  String get repeater_refresh => 'Ponovno obnavljati';

  @override
  String get repeater_statusRequestTimeout => 'Zahtev statusa je iztekla.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'Napaka pri obnašanju: $error';
  }

  @override
  String get repeater_systemInformation => 'Informacije o sistemu';

  @override
  String get repeater_battery => 'Baterija';

  @override
  String get repeater_clockAtLogin => 'Ure (pri prijavi)';

  @override
  String get repeater_uptime => 'Čas delovanja';

  @override
  String get repeater_queueLength => 'Dolžina čakalne vrste';

  @override
  String get repeater_debugFlags => 'Nastavitve odpravilnosti';

  @override
  String get repeater_radioStatistics => 'Radio Statistika';

  @override
  String get repeater_lastRssi => 'Potredno RSSI';

  @override
  String get repeater_lastSnr => 'Nazadnje zabeležena SNR';

  @override
  String get repeater_noiseFloor => 'Šumovita raven';

  @override
  String get repeater_txAirtime => 'TX Airtime';

  @override
  String get repeater_rxAirtime => 'RX Airtime';

  @override
  String get repeater_chanUtil => 'Uporaba kanala';

  @override
  String get repeater_packetStatistics => 'Statistika paketa';

  @override
  String get repeater_sent => 'Pošljeno';

  @override
  String get repeater_received => 'Prejeto';

  @override
  String get repeater_duplicates => 'Duplikati';

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
    return 'Skupno: $total, Poplava: $flood, Neposredno: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return 'Skupno: $total, Poplava: $flood, Neposredno: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return 'Prah: $flood, Neposredni: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return 'Skupno: $total';
  }

  @override
  String get repeater_settingsTitle => 'Nastavitve ponovitelja';

  @override
  String get repeater_basicSettings => 'Osnovne nastavitve';

  @override
  String get repeater_repeaterName => 'Ime ponovitelja';

  @override
  String get repeater_repeaterNameHelper => 'Prikaz imena za ta ponovitelj.';

  @override
  String get repeater_adminPassword => 'Admin geslo';

  @override
  String get repeater_adminPasswordHelper => 'Polni dostopno geslo';

  @override
  String get repeater_guestPassword => 'Geslo gostača';

  @override
  String get repeater_guestPasswordHelper => 'Odpovedni dostopni geslo';

  @override
  String get repeater_radioSettings => 'Nastavitve Radija';

  @override
  String get repeater_frequencyMhz => 'Frekvenca (MHz)';

  @override
  String get repeater_frequencyHelper => '300–2500 MHz';

  @override
  String get repeater_txPower => 'TX Moč';

  @override
  String get repeater_txPowerHelper => '1-30 dBm';

  @override
  String get repeater_bandwidth => 'Pasovna širina';

  @override
  String get repeater_spreadingFactor => 'Razširitveni faktor';

  @override
  String get repeater_codingRate => 'Programska hitrost';

  @override
  String get repeater_locationSettings => 'Nastavitve lokacije';

  @override
  String get repeater_latitude => 'Širina';

  @override
  String get repeater_latitudeHelper => 'Desetbinske protiure (npr. 37.7749)';

  @override
  String get repeater_longitude => 'Dolžina';

  @override
  String get repeater_longitudeHelper =>
      'Desetbinske protiure (npr. -122,4194)';

  @override
  String get repeater_features => 'Značilnosti';

  @override
  String get repeater_packetForwarding => 'Usmerjanje paketa';

  @override
  String get repeater_packetForwardingSubtitle =>
      'Omogoči ponovitelja za usmerjanje paketov.';

  @override
  String get repeater_guestAccess => 'Prijemnik';

  @override
  String get repeater_guestAccessSubtitle =>
      'Omogoči dostop gostom v samo bralni načinu.';

  @override
  String get repeater_privacyMode => 'Privatni način';

  @override
  String get repeater_privacyModeSubtitle => 'Skrita imena/lokacije v oglasih';

  @override
  String get repeater_advertisementSettings => 'Nastavitve oglasnika';

  @override
  String get repeater_localAdvertInterval => 'Lokalen Oglasovni Razpon';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes minut';
  }

  @override
  String get repeater_floodAdvertInterval => 'Razpon Obvestil o Poplavah';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours ur';
  }

  @override
  String get repeater_encryptedAdvertInterval =>
      'Šifrirana Oglasovalska Trajanje';

  @override
  String get repeater_dangerZone => 'Opozorilo';

  @override
  String get repeater_rebootRepeater => 'Ponovni zagon Repeaterja';

  @override
  String get repeater_rebootRepeaterSubtitle => 'Ponovni zagon ponovitelja.';

  @override
  String get repeater_rebootRepeaterConfirm =>
      'Ste prepričani, da želite ponovno zagon tega ponovitelja?';

  @override
  String get repeater_regenerateIdentityKey => 'Ponovite Ključ Identnosti';

  @override
  String get repeater_regenerateIdentityKeySubtitle =>
      'Ustvarite novo par javnih/zasebnih ključev';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'To bo ustvaril novo identiteto za ponavljalnik. Prijavite se?';

  @override
  String get repeater_eraseFileSystem => 'Počisti Sustav Vajah';

  @override
  String get repeater_eraseFileSystemSubtitle =>
      'Oblikuj datoteko ponovitve sistema';

  @override
  String get repeater_eraseFileSystemConfirm =>
      'OPOZORILO: To bo izbrisal/a vsa dejstva na ponovilu. To ni mogoče povzvrniti!';

  @override
  String get repeater_eraseSerialOnly =>
      'Brisanje je na voljo samo preko serijske konzole.';

  @override
  String repeater_commandSent(String command) {
    return 'Navodilo poslano: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'Napaka pri pošiljanju ukaznega: $error';
  }

  @override
  String get repeater_confirm => 'Potrdit';

  @override
  String get repeater_settingsSaved => 'Nastavitve so shranjene uspešno.';

  @override
  String get repeater_rxGain => 'Povečana dobitka RX';

  @override
  String get repeater_rxGainHelper =>
      'Veća občutljivost, večji porabljeni tok (velja samo za SX1262/SX1268)';

  @override
  String get repeater_refreshRxGain => 'Povečana dobitka RX, posodobit';

  @override
  String get repeater_multiAcks => 'Več potrdil';

  @override
  String get repeater_multiAcksSubtitle =>
      'Potrdite sporočila po več poti za boljši dostop';

  @override
  String get repeater_refreshMultiAcks => 'Ponovite več potrdil';

  @override
  String get repeater_networkHealth => 'Zdravilo omrežja';

  @override
  String get repeater_loopDetect => 'Detekcija ciklov';

  @override
  String get repeater_loopDetectHelper =>
      'Izpišite pakete, ki izgledajo kot pete v omrežju.';

  @override
  String get repeater_loopDetectOff => 'Izklopljeno';

  @override
  String get repeater_loopDetectMinimal => 'Minimalen';

  @override
  String get repeater_loopDetectModerate => 'Umiren';

  @override
  String get repeater_loopDetectStrict => 'Strogi';

  @override
  String get repeater_dutyCycle => 'Ciklus delovanja';

  @override
  String get repeater_dutyCycleHelper =>
      'Najvišji odstotek časa, ki ga lahko posreduje.';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent %';
  }

  @override
  String get repeater_ownerInfo => 'Informacije o operaterju';

  @override
  String get repeater_ownerInfoHelper => 'javni podatki o tej napravi';

  @override
  String get repeater_refreshOwnerInfo => 'Prejmi informacije o operaterju';

  @override
  String get repeater_floodMax => 'Največji možni odmerek';

  @override
  String get repeater_floodMaxHelper =>
      'Največje število paketov, ki lahko potujejo v enem plovilnem paketu (0-64)';

  @override
  String get repeater_advancedSettings => 'Napredno';

  @override
  String get repeater_advancedSettingsSubtitle =>
      'Gumbi za nastavljanje za izkušene uporabnike';

  @override
  String get repeater_pathHashMode => 'Način ustvarjanja hash-a poti';

  @override
  String get repeater_pathHashModeHelper =>
      'Bajti, uporabljeni za kodiranje ID-ja tega repetitorja v oznakah flood poti/zaznavanja zank. 0=1 bajt (256 ID-jev, do 64 skokov), 1=2 bajta (65.000 ID-jev, do 32 skokov), 2=3 bajti (16 milijonov ID-jev, do 21 skokov). Vdelana programska oprema pred v1.14 je vedno uporabljala 1-bajtne poti; v1.14 in novejše je mogoče nastaviti na 2- ali 3-bajtne poti.';

  @override
  String get repeater_keySettings => 'Zmeničke ključe identitete';

  @override
  String get repeater_keySettingsSubtitle =>
      'Zamenjajte publican ali privatni ključni par';

  @override
  String get repeater_prvKey => 'Privarna ključa';

  @override
  String get repeater_prvKeyHelper =>
      'Nova privatna ključa za prekaznik, 128- znakovni šestnastik.';

  @override
  String get repeater_generatePrvKey => 'Sporočna ključna para';

  @override
  String get repeater_stopGeneratingPrvKey =>
      'Prekajanje odkrivanja ključne paro';

  @override
  String get repeater_pubKey => 'Public key (publična ključa)';

  @override
  String get repeater_pubKeyHelper =>
      'Taj je publicna ključ, ki pomeni pripovedno privatno ključ. Ne možeš to vrediti direktno.';

  @override
  String get repeater_pubKeyPrefix => 'Poželana prefiks';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'Najdi publicen ključ, ki začne s tih hexnih čitov. Očekivani pokusi: $tries.';
  }

  @override
  String get repeater_txDelay => 'Zatemnitevanje zaradi poplav v Texasu';

  @override
  String get repeater_txDelayHelper =>
      'Uporaba intervalov za ponovno pošiljanje v primeru prometa zaradi poplav, kot pomnožnik časovne trajanje paketa (0-2, privzeto 0,5). Veje vrednost = manjše kolizije, vendar počasnejše dostavo.';

  @override
  String get repeater_directTxDelay => 'Neposredni časovno odlašanje';

  @override
  String get repeater_directTxDelayHelper =>
      'Razdalja za ponovno pošiljanje za neposredno (neobvezen) promet, kot pomnožnik časovne trajanja paketa (0-2, privzeto 0,3).';

  @override
  String get repeater_intThresh => 'Meja, pri kateri nastane motnja';

  @override
  String get repeater_intThreshHelper =>
      'Tretja stopnja se uporablja za kalibracijo šumnega nivoja radija, kar omogoča, da se izklaplja pri šumu, ki presega to raven. 0 izklopi – uporabite le, če zaznate napake v šumnem pasu.';

  @override
  String get repeater_agcResetInterval => 'Interval ponovne kalibracije AGC';

  @override
  String get repeater_agcResetIntervalHelper =>
      'Kako pogosto je treba ponovno nastaviti samodejno regulacijo občutljivosti, da se vrnete v normalno stanje? Interval je nastavljen na nekaj sekund, natančno na 4. 0 izklopi periodično ponovno nastavljanje.';

  @override
  String get repeater_actionsTitle => 'Dejanja';

  @override
  String get repeater_sendAdvert => 'Pošlji oglas o poplavah';

  @override
  String get repeater_sendAdvertSubtitle =>
      'Razpustite oglas o poplavah preko omrežja.';

  @override
  String get repeater_sendAdvertZeroHop =>
      'Pošlji oglas, ki ne potrebuje posrednika.';

  @override
  String get repeater_sendAdvertZeroHopSubtitle =>
      'Premejte oglas, ki uporablja eno povezavo (brez posrednikov).';

  @override
  String get repeater_clockSync => 'Sinerizirajte uro zdaj';

  @override
  String get repeater_clockSyncSubtitle =>
      'Nastavite čas na telefonu, da se sinhronizira s repeatrom.';

  @override
  String repeater_actionSucceeded(String action) {
    return '$action je uspel';
  }

  @override
  String repeater_actionFailed(String action, String error) {
    return '$action ni bilo uspešno: $error';
  }

  @override
  String get repeater_settingsSavedRebootNeeded =>
      'Nastavitve shranjene – ponovni zagon repetitorja za uporabo';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return 'Nekatna nastavitva niso uspešna: $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return 'Napaka pri shranjevanju nastavitev: $error';
  }

  @override
  String get repeater_refreshBasicSettings =>
      'Ponovno nastavi osnovne nastavitve';

  @override
  String get repeater_refreshRadioSettings => 'Ponovno Nastavitve Radija';

  @override
  String get repeater_refreshTxPower => 'Ponovno nastavi TX moč';

  @override
  String get repeater_refreshPacketForwarding =>
      'Ponovno nastavitve usmerjevanja paketa';

  @override
  String get repeater_refreshGuestAccess => 'Ponovno nastavitve dostopa gostov';

  @override
  String get repeater_refreshPrivacyMode =>
      'Ponovno aktiviraj način zasebnosti';

  @override
  String repeater_refreshed(String label) {
    return '$label je bil/a posodobljen/a';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return 'Napaka pri osveževanju $label';
  }

  @override
  String get repeater_cliTitle => 'Ponovitelj CLI';

  @override
  String get repeater_debugNextCommand => 'Popravi naslednje ukazne možnosti';

  @override
  String get repeater_commandHelp => 'Pomoc';

  @override
  String get repeater_clearHistory => 'Ponovi zgodovino';

  @override
  String get repeater_noCommandsSent =>
      'Niti ena ukazne povratne informacije še ni poslana.';

  @override
  String get repeater_typeCommandOrUseQuick =>
      'Vnesite ukaz spodaj ali uporabite hitre ukaze';

  @override
  String get repeater_enterCommandHint => 'Vnesite ukaz...';

  @override
  String get repeater_previousCommand => 'Prejšnji ukaz';

  @override
  String get repeater_nextCommand => 'Naslednja ukazna';

  @override
  String get repeater_enterCommandFirst => 'Vnesite ukaz najprej';

  @override
  String get repeater_cliCommandFrameTitle => 'Okno ukazne vrstice';

  @override
  String repeater_cliCommandError(String error) {
    return 'Napaka: $error';
  }

  @override
  String get repeater_cliQuickGetName => 'Pridobi ime';

  @override
  String get repeater_cliQuickGetRadio => 'Dobiti Radiopravo';

  @override
  String get repeater_cliQuickGetTx => 'Pridobi TX';

  @override
  String get repeater_cliQuickNeighbors => 'Sosedi';

  @override
  String get repeater_cliQuickVersion => 'Različica';

  @override
  String get repeater_cliQuickAdvertise => 'Oglasite';

  @override
  String get repeater_cliQuickClock => 'Ura';

  @override
  String get repeater_cliQuickClockSync => 'Usklajevanje ure';

  @override
  String get repeater_cliQuickDiscovery => 'Odkrijte sosede';

  @override
  String get repeater_cliHelpAdvert => 'Pošlje paket oglasov';

  @override
  String get repeater_cliHelpReboot =>
      'Ponastavi naprave. (Opomba, lahko pride do \'Timeouta\', kar je normalno)';

  @override
  String get repeater_cliHelpClock => 'Prikaže trenutno uro po uri naprave.';

  @override
  String get repeater_cliHelpPassword =>
      'Nastavi novo administracijsko geslo za naprave.';

  @override
  String get repeater_cliHelpVersion =>
      'Prikaže različico naprave in datum izrabe strojne opreme.';

  @override
  String get repeater_cliHelpClearStats =>
      'Ponastavi različne statistične števke na nič.';

  @override
  String get repeater_cliHelpSetAf => 'Nastavi časovni koeficient.';

  @override
  String get repeater_cliHelpSetTx =>
      'Nastavi moč LoRa oddajanja v dBm. (za ponovni zagon za uporabo)';

  @override
  String get repeater_cliHelpSetRepeat =>
      'Omogoči ali onemogoči vlogo ponovitelja za tono.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(Osebni strežnik) Če je \'vklopljeno\', potem bo dovoljeno prijavo z praznim geslom, vendar ne bo mogoče objaviti v sobo. (samo branje).';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'Nastavi največjo število skokov za vstopne poplave (če je >= maks, paket ni usmerjen)';

  @override
  String get repeater_cliHelpSetIntThresh =>
      'Nastavi Prag Interferencij (v dB). Privzeto je 14. Nastavi na 0 za onemogočitev zaznavanja interferenc kanalov.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'Nastavi časovno razdaljo za ponovni zagon nadzornika Avtomatske uteži. Nastavi na 0 za onemogočanje.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      'Omogoči ali onemogoči funkcijo \"dvojakih potrdil\".';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'Nastavi časovno obmesto v minutah za pošiljanje lokalnega (brezposrednega) napovednega paketa. Nastavi na 0 za onemogočiti.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'Nastavi časovno obmesto v urah za pošiljanje plovilnega oglasnega paketa. Nastavi na 0 za onemogočanje.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'Nastavi/posodobi geslo gosta. (za ponovitve lahko gostov prijavi pošiljajo zahtevo \"Get Stats\")';

  @override
  String get repeater_cliHelpSetName => 'Nastavi ime oglasnika.';

  @override
  String get repeater_cliHelpSetLat =>
      'Nastavi zemljepisno širino oglaševalskega zemljevida (desetdeljne).';

  @override
  String get repeater_cliHelpSetLon =>
      'Nastavi zemljevidno širino oglasnika. (desetdelne stopnje)';

  @override
  String get repeater_cliHelpSetRadio =>
      'Nastavi popolnoma nove radijske parametre in jih shranjuje v nastavitve. Za uporabo je potrebna \"restart\" ukaz.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      'Nastavitve (eksperimentalne) osnova (mora biti > 1 za učinkovanje) za uporabo rahle zakasnitve prejetih paketov, glede na moč signala/rezultat. Nastavite na 0 za onemogočanje.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      'Nastavi faktor, ki se množi s časom delovanja za paket v načinu poplavnega režima in z randomiziranim sistemom slotov, da odvrne njegovo posredovanje. (da se zmanjša verjetnost kolizij)';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'Ima podobno vrednost kot txdelay, vendar jo lahko uporabite za dodajanje naknadnega zamika pri posredovanju paketov v režimu neposredne prevodi.';

  @override
  String get repeater_cliHelpSetBridgeEnabled => 'Omogoči/Preklopi most.';

  @override
  String get repeater_cliHelpSetBridgeDelay =>
      'Nastavi zamik pred ponovnim poslanjem paketov.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      'Izberite, ali bodo most ponavljali prejeto ali poslan paket.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'Nastavi hitrost serijske povezave za mostove rs232.';

  @override
  String get repeater_cliHelpSetBridgeSecret =>
      'Nastavi skrivni dostop za mostove ESPNOW.';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      'Nastavi prilagoditev faktorja za prilagoditev poravnalnega napetosti baterije (podprt le na izbranih ploščah).';

  @override
  String get repeater_cliHelpTempRadio =>
      'Nastavi začasne radio parametre za določeno časovno obdobje, kar po preteku časa vrne originalne radio parametre. (ne shranjuje v preferencije).';

  @override
  String get repeater_cliHelpSetPerm =>
      'Modificira ACL. Odstrani ustrezen vnos (po predponi pubkeyja), če je \"permissions\" enako nič. Dodaja nov vnos, če je pubkey-hex v celoti in trenutno ni v ACL. Posodobi vnos po ustreznem predponi pubkeyja. Bitje dovoljenj se razlikuje glede na firmware vlogo, vendar so prvi dve bitki: 0 (Gost), 1 (Lezenje samo), 2 (Lezenje in pisanje), 3 (Administrator).';

  @override
  String get repeater_cliHelpGetBridgeType =>
      'Dobrodošli pri izbiri vrste mostu: brez, rs232, espnow';

  @override
  String get repeater_cliHelpLogStart =>
      'Začnete beleženje paketov v datotekovni sistem.';

  @override
  String get repeater_cliHelpLogStop =>
      'Ustavite beleženje paketov v datotečno sistem.';

  @override
  String get repeater_cliHelpLogErase =>
      'Izbriše pakete zapisov iz datotek sistema.';

  @override
  String get repeater_cliHelpNeighbors =>
      'Prikaže seznam drugih ponovnih knopov, do katerih je prišlo preko brezposrednih oglasov. Vsaka vrstica je id-prefix-hex:timestamp:snr-times-4';

  @override
  String get repeater_cliHelpNeighborRemove =>
      'Izbriše prvo ustreznu postavko (po predpomnilku pubkey (heks),) iz seznama sosedov.';

  @override
  String get repeater_cliHelpRegion =>
      '(Serija samo) Navaja vse definirane regije in trenutne poplave dovolilnosti.';

  @override
  String get repeater_cliHelpRegionLoad =>
      'Opomba: to je posebna več ukazna pozivna operacija. Vsak naslednji ukaz je ime regije (z lezijami za prikaz hierarhije, z enim ustvarjenim razmislom). Zaključena s pošiljanjem praznega reda/ukaza.';

  @override
  String get repeater_cliHelpRegionGet =>
      'Išče regijo s podanimi imenimi prefiksom (ali \"\\\" za globalni obseg). Odgovori se s \"-> regija-ime (rodič-ime) \'F\'\"';

  @override
  String get repeater_cliHelpRegionPut =>
      'Dodaja ali posodobi regijsko definicijo s podanim imenom.';

  @override
  String get repeater_cliHelpRegionRemove =>
      'Izbriše definicijo regije s podanim imenom. (mora se popolnoma ujemati in ne sme imeti podregij)';

  @override
  String get repeater_cliHelpRegionAllowf =>
      'Nastavi dovoljenje \'Nere\' za podano regijo. (\'\' za globalni/dedni obseg)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      'Odstrani dovoljenje \'F\'lood\' za podano regijo. (OPOZORILO: na tem koraku ni priporočljivo ga uporabljati na globalnem/dednem obsegu!!)';

  @override
  String get repeater_cliHelpRegionHome =>
      'Odgovori z trenutnim \'domovim\' območjem. (Opomba je bila še nujno uporabljena, rezervirano za prihodnost)';

  @override
  String get repeater_cliHelpRegionHomeSet => 'Nastavi regijo \'domov\'.';

  @override
  String get repeater_cliHelpRegionSave =>
      'Shrani seznam/ zemljevzemi regij v shranjevanje.';

  @override
  String get repeater_cliHelpGps =>
      'Pokaže status GPS-ja. Če je GPS izklopljen, odgovarja samo \"off\", če je vklopljen, odgovarja z \"on\", statusom, \"fix\" in štetjem satelitiv.';

  @override
  String get repeater_cliHelpGpsOnOff => 'Omogoči/onameni GPS način delovanja.';

  @override
  String get repeater_cliHelpGpsSync =>
      'Sinhronizira čas časa ničala z gps uro.';

  @override
  String get repeater_cliHelpGpsSetLoc =>
      'Nastavi položaj časa na GPS koordinate in shranjevanje preferencij.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'Omogoča konfiguracijo oglasi za notranjost člana:\n- none: ne vključevati lokacije v oglasih\n- share: deliti gps lokacijo (iz SensorManager)\n- prefs: oglaševati lokacijo shranjeno v preferencah';

  @override
  String get repeater_cliHelpGpsAdvertSet =>
      'Nastavi konfiguracijo oglasa na določenem mestu.';

  @override
  String get repeater_commandsListTitle => 'Seznam ukazov';

  @override
  String get repeater_commandsListNote =>
      'Opomba: za različne ukaze \"nastavi ...\" obstaja tudi ukaz \"dobi ...\".';

  @override
  String get repeater_general => 'Općenito';

  @override
  String get repeater_settingsCategory => 'Nastavitve';

  @override
  String get repeater_bridge => 'Most';

  @override
  String get repeater_logging => 'Logiranje';

  @override
  String get repeater_neighborsRepeaterOnly => 'Sosedi (le za repetitorje)';

  @override
  String get repeater_regionManagementRepeaterOnly =>
      'Upravljanje regij (zgolj za repetitorje)';

  @override
  String get repeater_regionNote =>
      'Regionske ukazi so bili uvedeni za upravljanje z regijskimi definicijami in dovolili.';

  @override
  String get repeater_gpsManagement => 'Upravljanje GPS';

  @override
  String get repeater_gpsNote =>
      'GPS ukaz je bil uveden za upravljanje z vprašanji, povezanimi z lokacijo.';

  @override
  String get repeater_getCategory => 'Dobite vrednosti';

  @override
  String get repeater_powerMgmt => 'Upravljanje z energijo';

  @override
  String get repeater_sensors => 'Senzori';

  @override
  String get repeater_cliHelpPowerOff =>
      'Izklopi naprave. (ne pričakujemo odziva)';

  @override
  String get repeater_cliHelpClkReboot =>
      'Ponovno nastavi uro na znano točko in ponovno vklopi naprave.';

  @override
  String get repeater_cliHelpAdvertZeroHop =>
      'Pošlje oglas, ki doseže samo neposredne sosede (brez posredovanja).';

  @override
  String get repeater_cliHelpStartOta =>
      'Začne nadstrekovno ažuriranje programne opreme na podprtih ploščah.';

  @override
  String get repeater_cliHelpTime =>
      'Nastavi časovni ukaz naprave na podano število sekund od Unixovega začetka. Časovni ukaz ne more iti nazaj.';

  @override
  String get repeater_cliHelpBoard =>
      'Prikaže proizvajalca plošče / identifikator strojne opreme.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      'Pošlje zahtevo za odkrivanje sosednjih naprav. (Samo za repeatere)';

  @override
  String get repeater_cliHelpPowersaving =>
      'Prikaže, ali je vklopljen način varčevanja z energijo.';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      'Omogoča ali onemogoča način varčevanja z energijo (če je podprt).';

  @override
  String get repeater_cliHelpErase =>
      '(Samo za serijske naprave) Formira datotapno sistemsko okolje. Izbriše vse nastavitve in kontakte.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      'Določi maksimalni dovoljeni čas, ki ga naprave lahko posredujejo, v odstotkih (1-100). Samodejno prilagodi faktor, ki odvisen je od časa, ki ga naprave lahko posredujejo.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '(Samo za serijske naprave) Nadomesti zasebni ključ za identifikacijo naprave. Za uporabo je potrebna ponovna aktivacija. Ustvari nov javni ključ.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(Samo za SX126x) Vklopi povečano občutljivost RX za izboljšano delovanje pri večjih navorih.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      'Določi niz z informacijami o kontaktni osebi, ki je v oglasih. Za uporabo novih vrstic uporabite \'|\'.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'Nastavlja način \"hash poti\". 0 = za stare sisteme, 1 = za standard, 2 = za stroge. Vpliva na to, kako so poti uskladene.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'Nastavlja občutljivost detekcije ponavljajočih se povezav: izklopljeno, minimalno, umeren, ali strogo.';

  @override
  String get repeater_cliHelpSetFreq =>
      '(Samo za serijske naprave) Hitro nastavi samo frekvenco. Potrebna je ponovna aktivacija. Za popolno nastavitev radio parametrov je priporočljivo uporabiti možnost \"nastavitev radia\".';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(Samo za most ESPNow) Nastavlja kanal WiFi-ja (1-14), ki ga uporablja most.';

  @override
  String get repeater_cliHelpGetName => 'Prikaže ime konfigurirane notranje.';

  @override
  String get repeater_cliHelpGetRole =>
      'Prikaže vlogo programskega oprema (repeater, strežnik za sobo itd.).';

  @override
  String get repeater_cliHelpGetPublicKey => 'Prikazuje javni ključ naprave.';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '(Samo za serijske naprave) Prikazuje zasebni ključ naprave. Sprejemajte ga kot skrivno informacijo.';

  @override
  String get repeater_cliHelpGetRepeat =>
      'Pokaže, ali je omogočeno posredovanje paketov (delovanje kot repetitor).';

  @override
  String get repeater_cliHelpGetTx => 'Prikazuje trenutno moč TX v dBm.';

  @override
  String get repeater_cliHelpGetFreq => 'Prikaže nastavljeno frekvenco v MHz.';

  @override
  String get repeater_cliHelpGetRadio =>
      'Prikaže vse parametre radija: frekvenco, širino pasu, faktor razširjanja, raven kodiranja.';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(Samo za SX126x) Prikazuje stanje povečanega dobiča na RX.';

  @override
  String get repeater_cliHelpGetAf =>
      'Prikazuje trenutni faktor, ki določa časovno obdobje.';

  @override
  String get repeater_cliHelpGetDutyCycle =>
      'Prikazuje trenutno dovoljeno stopnjo delovanja kot odstotek.';

  @override
  String get repeater_cliHelpGetIntThresh =>
      'Prikazuje prag medsebojnega vpliva kanala v dB.';

  @override
  String get repeater_cliHelpGetAgcResetInterval =>
      'Prikazuje interval ponovne kalibracije AGC v sekundah.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      'Pokaže, ali je vklopljen način dvojnega potrdila (1) ali je izklopljen (0).';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'Pokaže, ali je omogočen le brani dostop za goste.';

  @override
  String get repeater_cliHelpGetAdvertInterval =>
      'Prikazuje časovno obdobje lokalne reklame v minutah.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'Prikaže časovno obdobje, ko se prikazuje oglas o poplavah, v urah.';

  @override
  String get repeater_cliHelpGetGuestPassword =>
      'Prikaže nastavljeno geslo za gostitelja.';

  @override
  String get repeater_cliHelpGetLat => 'Prikaže določeno zemljepisno širino.';

  @override
  String get repeater_cliHelpGetLon => 'Prikaže določeno merilo dolžine.';

  @override
  String get repeater_cliHelpGetRxDelay =>
      'Prikazuje osnovno vrednost RX odlašanja.';

  @override
  String get repeater_cliHelpGetTxDelay =>
      'Prikazuje faktor zamude v načinu delovanja pri plavlju.';

  @override
  String get repeater_cliHelpGetDirectTxDelay =>
      'Prikazuje faktor odlašanja signala v režimu neposredne komunikacije.';

  @override
  String get repeater_cliHelpGetFloodMax =>
      'Prikazuje največjo število, kolikokrat lahko voda doseže najvišjo višino.';

  @override
  String get repeater_cliHelpGetOwnerInfo =>
      'Prikazuje niz z informacijami o lastniku.';

  @override
  String get repeater_cliHelpGetPathHashMode =>
      'Prikaže način delovanja z hashjem poti (0/1/2).';

  @override
  String get repeater_cliHelpGetLoopDetect =>
      'Prikazuje občutljivost na zaznavanje ciklov.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(Samo za serije) Navaja vnos za nadzor dostopa na ponovljalniku.';

  @override
  String get repeater_cliHelpGetBridgeEnabled =>
      'Pokaže, ali je most omogočen.';

  @override
  String get repeater_cliHelpGetBridgeDelay =>
      'Prikazuje zamik mosta v milisekundah.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'Pokaže, ali most prenaša pakete RX ali TX.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(Samo za most RS232) Prikazuje hitrost prenosa podatkov na mostu.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(Samo za most ESPNow) Prikazuje kanal WiFi mosta.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(Samo za most ESPNow) Prikazuje tajno, ki jo deli most.';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '(Samo za NRF52) Prikazuje različico programskega orodja.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'Prikazuje pomnoževalnik ADC (skaliranje napetosti baterije).';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      'Navaja, ali ima uprava področje za upravljanje z energijo.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      'Prikaže trenutni vir napajanja: zunanji ali baterija.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      'Prikazuje najnovejšo razlog za ponovno nastavitve in izklop.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv =>
      'Prikazuje napetost baterije v mV ob zagonu.';

  @override
  String get repeater_cliHelpSensorGet =>
      'Prebere določeno vrednost senzorja preko tipke.';

  @override
  String get repeater_cliHelpSensorSet =>
      'Ustvari prilagojeno nastavitev za senzor.';

  @override
  String get repeater_cliHelpSensorList =>
      'Navaja vse nastavitve za uporabniške senzorje, razvrščene po želeni začetni indeksu.';

  @override
  String get repeater_cliHelpRegionDefault =>
      'Prikaže trenutno privzeto območje.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'Določi privzeto območje. Za izbris uporabite \"<null>\".';

  @override
  String get repeater_cliHelpRegionListAllowed =>
      'Navaja regije, ki dovoljujejo promet v času poplav.';

  @override
  String get repeater_cliHelpRegionListDenied =>
      'Navaja regije, ki preprečujejo promet zaradi poplav.';

  @override
  String get repeater_cliHelpStatsPackets =>
      '(Samo za serijske povezave) Prikazuje statistiko na nivoju paketov.';

  @override
  String get repeater_cliHelpStatsRadio =>
      '(Samo za serije) Prikazuje statistične podatke o radiju.';

  @override
  String get repeater_cliHelpStatsCore =>
      '(Samo za serijske naprave) Prikazuje osnovne statistične podatke.';

  @override
  String get telemetry_receivedData => 'Prejeto Telemetrično podatke';

  @override
  String get telemetry_requestTimeout => 'Zahtev telemetrije je iztekla.';

  @override
  String telemetry_errorLoading(String error) {
    return 'Napaka pri obnašanju telemetrije: $error';
  }

  @override
  String get telemetry_noData => 'Niso na voljo podatki o telemetriji.';

  @override
  String telemetry_channelTitle(int channel) {
    return 'Kanal $channel';
  }

  @override
  String get telemetry_batteryLabel => 'Baterija';

  @override
  String get telemetry_voltageLabel => 'Napetost';

  @override
  String get telemetry_mcuTemperatureLabel => 'MCU Temperatura';

  @override
  String get telemetry_temperatureLabel => 'Temperatura';

  @override
  String get telemetry_currentLabel => 'Trenutno';

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
  String get telemetry_digitalInputLabel => 'Digitalni vhod';

  @override
  String get telemetry_digitalOutputLabel => 'Digitalni izhod';

  @override
  String get telemetry_analogInputLabel => 'Analogni vhod';

  @override
  String get telemetry_analogOutputLabel => 'Analogni izhod';

  @override
  String get telemetry_genericLabel => 'Splošni senzor';

  @override
  String get telemetry_luminosityLabel => 'Osvetljenost';

  @override
  String get telemetry_presenceLabel => 'Prisotnost';

  @override
  String get telemetry_humidityLabel => 'Vlažnost';

  @override
  String get telemetry_accelerometerLabel => 'Merilnik pospeška';

  @override
  String get telemetry_pressureLabel => 'Tlak';

  @override
  String get telemetry_altitudeLabel => 'Nadmorska višina';

  @override
  String get telemetry_frequencyLabel => 'Frekvenca';

  @override
  String get telemetry_percentageLabel => 'Odstotek';

  @override
  String get telemetry_concentrationLabel => 'Koncentracija';

  @override
  String get telemetry_powerLabel => 'Moč';

  @override
  String get telemetry_distanceLabel => 'Razdalja';

  @override
  String get telemetry_energyLabel => 'Energija';

  @override
  String get telemetry_directionLabel => 'Smer';

  @override
  String get telemetry_timeLabel => 'Čas';

  @override
  String get telemetry_gyrometerLabel => 'Žiroskop';

  @override
  String get telemetry_colourLabel => 'Barva';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'Stikalo';

  @override
  String get telemetry_polylineLabel => 'Polilinija';

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
  String get telemetry_autoFetchQuantity => 'Število zahtev';

  @override
  String get telemetry_error => 'Podatkov ni bilo mogoče pridobiti';

  @override
  String get neighbors_receivedData => 'Prejeto podatke o sosedih';

  @override
  String get neighbors_requestTimedOut =>
      'Sosedi zahtevajo izklop po dogovoru.';

  @override
  String neighbors_errorLoading(String error) {
    return 'Napaka pri obnašanju sosedov: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => 'Ponovitve Sosedi';

  @override
  String get neighbors_noData => 'Niso na voljo podatki o sosedih.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return 'Nepoznano $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return 'Udeleženec je prejel sporočilo $time nazaj.';
  }

  @override
  String get channelPath_title => 'Pot do paketa';

  @override
  String get channelPath_viewMap => 'Prikaži zemljeznico';

  @override
  String get channelPath_otherObservedPaths => 'Drugi opazovani poti';

  @override
  String get channelPath_repeaterHops => 'Skoki ponovitelja';

  @override
  String get channelPath_noHopDetails =>
      'Podrobnosti o paketu za dostavo niso navedene.';

  @override
  String get channelPath_sourceLabel => 'Vir';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'To sporočilo je prispelo prek MQTT. Vaš radio ga ni slišal, zato ni radijske poti od vašega radia.';

  @override
  String get channelPath_messageDetails => 'Podrobnosti sporočila';

  @override
  String get channelPath_senderLabel => 'Pošiljatelj';

  @override
  String get channelPath_timeLabel => 'Ura';

  @override
  String get channelPath_repeatsLabel => 'Ponovitve';

  @override
  String channelPath_pathLabel(int index) {
    return 'Pot $index';
  }

  @override
  String get channelPath_observedLabel => 'Opazovani';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return 'Opazovana pot $index • $hops';
  }

  @override
  String get channelPath_noLocationData => 'Nihče ni določil lokacije.';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => 'Neznano';

  @override
  String get channelPath_floodPath => 'Prebivalstvo';

  @override
  String get channelPath_directPath => 'Neposredni';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 iz $total skokov';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed iz $total skokov';
  }

  @override
  String get channelPath_mapTitle => 'Potni zemljevid';

  @override
  String get channelPath_noRepeaterLocations =>
      'Ni na voljo nobenih lokacij za ponovitelja za to pot.';

  @override
  String channelPath_primaryPath(int index) {
    return 'Pot $index (Glavni)';
  }

  @override
  String get channelPath_pathLabelTitle => 'Pot';

  @override
  String get channelPath_observedPathHeader => 'Opazovana pot';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable =>
      'Niso na voljo podrobnosti o letu.';

  @override
  String get channelPath_unknownRepeater => 'Nepoznati ponovitelj';

  @override
  String get community_title => 'Skupnost';

  @override
  String get community_create => 'Ustvari skupnost';

  @override
  String get community_createDesc =>
      'Ustvari novo skupnost in jo deli preko QR kode.';

  @override
  String get community_join => 'Pridružiti se';

  @override
  String get community_joinTitle => 'Pridružite se skupnosti';

  @override
  String community_joinConfirmation(String name) {
    return 'Želiš se pridružiti skupnosti \"$name\"?';
  }

  @override
  String get community_scanQr => 'Skeniraj QR kode skupnosti';

  @override
  String get community_scanInstructions =>
      'Nasmerite kamero s skupnostnim QR kodom.';

  @override
  String get community_showQr => 'Pokaži QR kodo';

  @override
  String get community_publicChannel => 'Skupnostna javna';

  @override
  String get community_hashtagChannel => 'Skupnostni hashtag';

  @override
  String get community_name => 'Komunitarne ime';

  @override
  String get community_enterName => 'Vnesite ime skupnosti';

  @override
  String community_created(String name) {
    return 'Skupnost \"$name\" je bila ustvarila.';
  }

  @override
  String community_joined(String name) {
    return 'Prilojen k skupnosti \"$name\"';
  }

  @override
  String get community_qrTitle => 'Delite skupnost';

  @override
  String community_qrInstructions(String name) {
    return 'Skenirajte to QR kodo za vključitev $name.';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'Hashtag kanali skupnosti so dostopni samo članom skupnosti';

  @override
  String get community_invalidQrCode => 'Neveljaven QR koden skupnosti';

  @override
  String get community_alreadyMember => 'Že član';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'Kljub temu ste že član/ka $name.';
  }

  @override
  String get community_addPublicChannel => 'Dodaj Objavni Kanal Komunitarja';

  @override
  String get community_addPublicChannelHint =>
      'Samodejno dodaj javni kanal za to skupnost.';

  @override
  String get community_noCommunities => 'Še nobena skupnost se ni pridružila.';

  @override
  String get community_scanOrCreate =>
      'Skeniraj QR kodo ali ustvari skupnost za začetek.';

  @override
  String get community_manageCommunities => 'Upravljanje skupnosti';

  @override
  String get community_delete => 'Opusti skupnost';

  @override
  String community_deleteConfirm(String name) {
    return 'Zapusti \"$name\"?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return 'To bo izbrisalo tudi $count kanal/kanalov in njihova sporočila.';
  }

  @override
  String community_deleted(String name) {
    return 'Zapustil skupnost \"$name\"';
  }

  @override
  String get community_regenerateSecret => 'Ponovno ustvari geslo';

  @override
  String community_regenerateSecretConfirm(String name) {
    return 'Preberite novo tajno geslo za \"$name\"? Vsi članici morajo prebrati novo QR kodo, da lahko nadaljujejo s komunikacijo.';
  }

  @override
  String get community_regenerate => 'Preberi znova';

  @override
  String community_secretRegenerated(String name) {
    return 'Geslo za \"$name\" ponovno ustvarjeno';
  }

  @override
  String get community_updateSecret => 'Ažuriraj ključ';

  @override
  String community_secretUpdated(String name) {
    return 'Skrivnostno spremembo za \"$name\"';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return 'Skeniraj novo QR kodo za posodabljanje ključa za $name';
  }

  @override
  String get community_addHashtagChannel => 'Dodaj hashtag kanal';

  @override
  String get community_addHashtagChannelDesc =>
      'Dodajte hashtag kanal za to skupnost.';

  @override
  String get community_selectCommunity => 'Izberi skupnost';

  @override
  String get community_regularHashtag => 'Oznaka s hashtagom';

  @override
  String get community_regularHashtagDesc =>
      'javna oznaka (kdorkoli lahko sodeluje)';

  @override
  String get community_communityHashtag => 'Skupnostni hashtag';

  @override
  String get community_communityHashtagDesc =>
      'Izključeno za uporabnike skupnosti';

  @override
  String community_forCommunity(String name) {
    return 'Za $name';
  }

  @override
  String get listFilter_tooltip => 'Filtri in vrstiči';

  @override
  String get listFilter_sortBy => 'Sortiraj po';

  @override
  String get listFilter_latestMessages => 'Najnovejše sporočilo';

  @override
  String get listFilter_heardRecently => 'Nedavno slišan';

  @override
  String get listFilter_az => 'A do Z';

  @override
  String get listFilter_filters => 'Filtri';

  @override
  String get listFilter_all => 'Vse';

  @override
  String get listFilter_favorites => 'Priljubljene';

  @override
  String get listFilter_addToFavorites => 'Dodaj v priljubljene';

  @override
  String get listFilter_removeFromFavorites => 'Odstrani iz priljubljenih';

  @override
  String get listFilter_users => 'Uporabniki';

  @override
  String get listFilter_repeaters => 'Ponovitve';

  @override
  String get listFilter_roomServers => 'Smeti za prostore';

  @override
  String get listFilter_unreadOnly => 'Nezbrani samo';

  @override
  String get listFilter_newGroup => 'Nova skupina';

  @override
  String get pathTrace_you => 'Ti';

  @override
  String get pathTrace_failed => 'Sledenje poti ni uspelo.';

  @override
  String get pathTrace_notAvailable => 'Potni sled ni na voljo.';

  @override
  String get pathTrace_refreshTooltip => 'Osveži Path Trace.';

  @override
  String get pathTrace_someHopsNoLocation =>
      'Ena ali več hmelju manjka lokacija!';

  @override
  String get pathTrace_clearTooltip => 'Počisti pot';

  @override
  String get losSelectStartEnd => 'Izberite začetno in končno vozlišče za LOS.';

  @override
  String losRunFailed(String error) {
    return 'Preverjanje vidnega polja ni uspelo: $error';
  }

  @override
  String get losClearAllPoints => 'Počisti vse točke';

  @override
  String get losRunToViewElevationProfile =>
      'Zaženite LOS za ogled višinskega profila';

  @override
  String get losMenuTitle => 'LOS meni';

  @override
  String get losMenuSubtitle =>
      'Tapnite vozlišča ali dolgo pritisnite na zemljevid za točke po meri';

  @override
  String get losShowDisplayNodes => 'Pokaži prikazna vozlišča';

  @override
  String get losCustomPoints => 'Točke po meri';

  @override
  String losCustomPointLabel(int index) {
    return 'Po meri $index';
  }

  @override
  String get losPointA => 'Točka A';

  @override
  String get losPointB => 'Točka B';

  @override
  String losAntennaA(String value, String unit) {
    return 'Antena A: $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return 'Antena B: $value $unit';
  }

  @override
  String get losRun => 'Zaženi LOS';

  @override
  String get losNoElevationData => 'Ni podatkov o višini';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, čisti LOS, najmanjša razdalja $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, blokiral $obstruction $heightUnit';
  }

  @override
  String get losStatusChecking => 'LOS: preverjam ...';

  @override
  String get losStatusNoData => 'LOS: ni podatkov';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS: $clear/$total jasno, $blocked blokirano, $unknown neznano';
  }

  @override
  String get losErrorElevationUnavailable =>
      'Podatki o nadmorski višini niso na voljo za enega ali več vzorcev.';

  @override
  String get losErrorInvalidInput =>
      'Neveljavni podatki o točkah/višini za izračun LOS.';

  @override
  String get losRenameCustomPoint => 'Preimenujte točko po meri';

  @override
  String get losPointName => 'Ime točke';

  @override
  String get losShowPanelTooltip => 'Pokaži ploščo LOS';

  @override
  String get losHidePanelTooltip => 'Skrij ploščo LOS';

  @override
  String get losElevationAttribution =>
      'Podatki o višini: Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'Radijski horizont';

  @override
  String get losLegendLosBeam => 'Linija vidnosti';

  @override
  String get losLegendTerrain => 'Teren';

  @override
  String get losBlockedSpotsTitle => 'Zasedena parkirišča';

  @override
  String get losBlockedSpotsHint =>
      'Dotaknite blokirano točko, da jo označite na zemljeplati.';

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
  String get losSelectedObstructionTitle => 'Izbrano ovire';

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
  String get losFrequencyLabel => 'Frekvenca';

  @override
  String get losFrequencyInfoTooltip => 'Prikaži podrobnosti izračuna';

  @override
  String get losFrequencyDialogTitle => 'Izračun radijskega horizonta';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'Začenši od k=$baselineK pri $baselineFreq MHz, izračun prilagodi k-faktor za trenutni pas $frequencyMHz MHz, ki določa ukrivljeno zgornjo mejo radijskega horizonta.';
  }

  @override
  String get contacts_pathTrace => 'Sledenje poti';

  @override
  String get contacts_ping => 'Pingati';

  @override
  String get contacts_repeaterPathTrace => 'Sledi poti do ponavljalnika';

  @override
  String get contacts_repeaterPing => 'Pinguj ponavljalnik';

  @override
  String get contacts_roomPathTrace => 'Sledenje poti do strežnika sobe';

  @override
  String get contacts_roomPing => 'Ping strežnik sobe';

  @override
  String get contacts_chatTraceRoute => 'Slediti poti žarkov';

  @override
  String contacts_pathTraceTo(String name) {
    return 'Trace route to $name';
  }

  @override
  String get contacts_clipboardEmpty => 'Odložišče je prazno.';

  @override
  String get contacts_invalidAdvertFormat => 'Neveljavni kontaktne podatke';

  @override
  String get contacts_contactImported => 'Kontakt je bil uvožen.';

  @override
  String get contacts_contactImportFailed => 'Kontakt ni bil uspešno uvožen.';

  @override
  String get contacts_zeroHopAdvert => 'Reklama brez posrednikov';

  @override
  String get contacts_floodAdvert => 'Poplavna oglás';

  @override
  String get contacts_copyAdvertToClipboard => 'Kopiraj oglas v odložišče';

  @override
  String get contacts_addContactFromClipboard => 'Dodaj stik iz odložišča';

  @override
  String get contacts_ShareContact => 'Kopiraj stik v Odložišče';

  @override
  String get contacts_ShareContactZeroHop => 'Deliti kontakt prek oglasa';

  @override
  String get contacts_zeroHopContactAdvertSent => 'Poslano po oglasu.';

  @override
  String get contacts_zeroHopContactAdvertFailed =>
      'Pošiljanje kontakta ni uspelo.';

  @override
  String get contacts_contactAdvertCopied =>
      'Oglas je bil kopiran v odložišče.';

  @override
  String get contacts_contactAdvertCopyFailed =>
      'Kopiranje oglasa v odložišče je spodletelo.';

  @override
  String get notification_activityTitle => 'Aktivnost MeshCore';

  @override
  String notification_messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sporočil',
      few: 'sporočila',
      two: 'sporočili',
      one: 'sporočilo',
    );
    return '$count $_temp0';
  }

  @override
  String notification_channelMessagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sporočil kanala',
      few: 'sporočila kanala',
      two: 'sporočili kanala',
      one: 'sporočilo kanala',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'novih vozlišč',
      few: 'nova vozlišča',
      two: 'novi vozlišči',
      one: 'novo vozlišče',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return 'Odkrito novo $contactType';
  }

  @override
  String get notification_receivedNewMessage => 'Prejeto novo sporočilo';

  @override
  String get settings_gpxExportRepeaters =>
      'Izvoz ponoviteljev / strežnika sobe v GPX';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'Izvozi ponovljene oddajnike / strežnik sobe z lokacijo v datoteko GPX.';

  @override
  String get settings_gpxExportContacts => 'Izvoz spremljevalcev v GPX';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'Izvozi spremljevalce z lokacijo v datoteko GPX.';

  @override
  String get settings_gpxExportAll => 'Izvozi vse kontakte v GPX';

  @override
  String get settings_gpxExportAllSubtitle =>
      'Izvozi vse kontakte z lokacijo v datoteko GPX.';

  @override
  String get settings_gpxExportSuccess => 'Uspešno izvoz GPX datoteke.';

  @override
  String get settings_gpxExportNoContacts => 'Ni stikov za izvoz.';

  @override
  String get settings_gpxExportNotAvailable =>
      'Ni podprto na vašem napravi/operacijskem sistemu';

  @override
  String get settings_gpxExportError => 'Pri izvozu je prišlo do napake.';

  @override
  String get settings_gpxExportRepeatersRoom =>
      'Lokacije ponovljivca in strežnika sobe';

  @override
  String get settings_gpxExportChat => 'Lokacije spremljevalcev';

  @override
  String get settings_gpxExportAllContacts => 'Lokacije vseh stikov';

  @override
  String get settings_gpxExportShareText =>
      'Podatki kart izvoženi iz NOTORYX Core';

  @override
  String get settings_gpxExportShareSubject =>
      'NOTORYX Core izvoz podatkov GPX karte';

  @override
  String get snrIndicator_nearByRepeaters => 'Bližnji ponovitelji';

  @override
  String get snrIndicator_lastSeen => 'Zadnjič videno';

  @override
  String get contactsSettings_title => 'Nastavitve stikov';

  @override
  String get contactsSettings_autoAddTitle => 'Avtomatsko odkrivanje';

  @override
  String get contactsSettings_otherTitle => 'Druge nastavitve v zvezi s stiki';

  @override
  String get contactsSettings_autoAddUsersTitle =>
      'Avtomatsko dodaj uporabnike';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      'Dovoli spremljevalcu, da samodejno doda odkrite uporabnike.';

  @override
  String get contactsSettings_autoAddRepeatersTitle =>
      'Avtomatsko dodaj ponovitelje';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      'Dovoli spremljevalcu, da samodejno doda odkrite ponovitelje.';

  @override
  String get contactsSettings_autoAddRoomServersTitle =>
      'Avtomatsko dodaj strežnike sob';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      'Dovoli spremljevalcu, da samodejno doda odkrite strežnike sob.';

  @override
  String get contactsSettings_autoAddSensorsTitle =>
      'Avtomatsko dodaj senzorje';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      'Dovoli spremljevalcu, da samodejno doda odkrite senzorje.';

  @override
  String get contactsSettings_overwriteOldestTitle => 'Prepiši najstarejše';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      'Ko je seznam stikov poln, bo najstarejši nestarševski stik zamenjan.';

  @override
  String get discoveredContacts_Title => 'Odkriti stiki';

  @override
  String get discoveredContacts_noMatching => 'Ni ujemajočih stikov';

  @override
  String get discoveredContacts_searchHint => 'Najdeni stiki po iskanju';

  @override
  String get discoveredContacts_contactAdded => 'Kontakt dodan';

  @override
  String get discoveredContacts_addContact => 'Dodaj stik';

  @override
  String get discoveredContacts_copyContact => 'Kopiraj stik v odložišče';

  @override
  String get discoveredContacts_deleteContact => 'Izbriši stik';

  @override
  String get discoveredContacts_deleteContactAll =>
      'Izbriši vse odkrite kontakte';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      'Ste prepričani, da želite izbrisati vse odkrite kontakte?';

  @override
  String get chat_sendCooldown =>
      'Prosimo, počakajte trenutek, preden pošljete ponovno.';

  @override
  String get appSettings_jumpToOldestUnread =>
      'Pritisnite za najstarejše nepročitano sporočilo';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      'Ko odpirate klepet z neprebranimi sporočili, se premaknite na prvo neprebrano sporočilo, namesto najnovejšega.';

  @override
  String get appSettings_languageHu => 'Madžarski';

  @override
  String get appSettings_languageJa => 'Japonski';

  @override
  String get appSettings_languageKo => 'Korejski';

  @override
  String get radioStats_tooltip => 'Statistike za radio in mrežo';

  @override
  String get radioStats_screenTitle => 'Radijske statistike';

  @override
  String get radioStats_notConnected =>
      'Povežite se z napravo, da si ogledate statistiko o radiju.';

  @override
  String get radioStats_firmwareTooOld =>
      'Statistika za radio zahteva združljivo programsko opremo v8 ali kasnejše.';

  @override
  String get radioStats_waiting => 'Čakam na podatke…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'Število šuma: $noiseDbm dBm';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return 'Najkasnejše vrednost RSSI: $rssiDbm dBm';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return 'Najkasnejše vrednost SNR: $snr dB';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'Čas na TX (skupno): $seconds s';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'Čas, namenjen RX-ju (skupno): $seconds s';
  }

  @override
  String get radioStats_chartCaption =>
      'Ravnovredna raven šuma (dBm) za nedavne vzorce.';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'Število šuma: $noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting => 'Prejemanje statistike o radiju…';

  @override
  String get radioStats_settingsTile => 'Radijske statistike';

  @override
  String get radioStats_settingsSubtitle =>
      'Število šumov, RSSI, SNR in čas, ki ga je napolnila oprema';

  @override
  String get translation_title => 'Prevod';

  @override
  String get imageMessages_enableTitle => 'Pozivni izkričile slike';

  @override
  String get imageMessages_enableSubtitle =>
      'Prešli vzorce pre mrežo. Potrebno je jednokratno stworiti model vzorca.';

  @override
  String get imageMessages_modelSectionTitle => 'Obrazni model';

  @override
  String get imageMessages_downloadModel => 'Storba';

  @override
  String get imageMessages_cancelDownload => 'Odločite';

  @override
  String get imageMessages_removeModel => 'Ubrani model';

  @override
  String get imageMessages_modelReady => 'Gotov';

  @override
  String get imageMessages_modelNotPublished =>
      'Jo še niso izdana — ta izdelka te ne može prebaviti.';

  @override
  String get imageMessages_downloadFailed =>
      'Obrazni model ne može biti preuzet.';

  @override
  String get imageMessages_autoProcessTitle => 'Avtomatizirane slike';

  @override
  String get imageMessages_autoProcessSubtitle =>
      'Katero je oblikovanje svega oblikov, ko se pošteva. Za drugo okolo časa se koristi ok. 2 GB pamične prostore; odločite se za oblikovanje s tukom.';

  @override
  String get translation_enableTitle => 'Omogočite prevod';

  @override
  String get translation_enableSubtitle =>
      'Prevedite vstopne sporočila in omogočite predhodno prevajanje.';

  @override
  String get translation_composerTitle => 'Preprištejte, preden pošljete';

  @override
  String get translation_composerSubtitle =>
      'Ureja privzeto stanje ikone za prevod, ki jo uporablja avtor.';

  @override
  String get translation_autoIncomingTitle => 'Samodejno prevajaj sporočila';

  @override
  String get translation_autoIncomingSubtitle =>
      'Samodejno prevaja sporočila za obvestila ter za klepete ali kanale.';

  @override
  String get translation_translateMessage => 'Prevedi sporočilo';

  @override
  String get translation_targetLanguage => 'Ciljna jezika';

  @override
  String get translation_useAppLanguage => 'Uporabite jezik aplikacije';

  @override
  String get translation_downloadedModelLabel => 'Naložen model';

  @override
  String get translation_presetModelLabel =>
      'Prednastavljeni model Hugging Face';

  @override
  String get translation_manualUrlLabel => 'URL za ročni model';

  @override
  String get translation_downloadModel => 'Prenesite model';

  @override
  String get translation_downloading => 'Izvajanje...';

  @override
  String get translation_working => 'Delo...';

  @override
  String get translation_stop => 'Prekliji';

  @override
  String get translation_mergingChunks =>
      'Sklapljanje prenesenih delov v končni datoteko...';

  @override
  String get translation_downloadedModels => 'Naloženi modeli';

  @override
  String get translation_deleteModel => 'Izbrisati model';

  @override
  String get translation_modelDownloaded =>
      'Model za prevajanje je bil naložen.';

  @override
  String get translation_downloadStopped => 'Prenos je bil prekinjen.';

  @override
  String translation_downloadFailed(String error) {
    return 'Izgovoritev ni bila uspešna: $error';
  }

  @override
  String get translation_enterUrlFirst => 'Najprej vnesite URL model.';

  @override
  String get scanner_linuxPairingShowPin => 'Prikaži PIN';

  @override
  String get scanner_linuxPairingHidePin => 'Skrij PIN';

  @override
  String get scanner_linuxPairingPinTitle => 'Bluetooth PIN za seznanjanje';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return 'Vnesite PIN za $deviceName (pustite prazno, če ga ni).';
  }

  @override
  String get translation_messageTranslation => 'Prevod sporočila';

  @override
  String get translation_translateBeforeSending =>
      'Preprištejte, preden pošljete';

  @override
  String get translation_composerEnabledHint =>
      'Vsebina sporočil bo prevedena, preden jih pošljemo.';

  @override
  String get translation_composerDisabledHint =>
      'Pošljite sporočila v originalnem tipkanem jeziku.';

  @override
  String translation_translateTo(String language) {
    return 'Prevesti v $language';
  }

  @override
  String get translation_translationOptions => 'Možnosti prevoda';

  @override
  String get translation_systemLanguage => 'Jezik sistema';

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
  String get map_zoomIn => 'Povečaj';

  @override
  String get map_zoomOut => 'Povečajte pogled';

  @override
  String get map_centerMap => 'Krajšarska karta';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'Web Bluetooth zahteva brskalnik Chromium.';

  @override
  String channels_communityShortId(String id) {
    return 'ID: $id...';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'GPS potrdilo';

  @override
  String get pathTrace_legendInferred => 'Izpeljana lokacija';

  @override
  String get pathMap_viewSingle => 'Posamično';

  @override
  String get pathMap_viewCombined => 'Skupno';

  @override
  String get pathMap_play => 'Predvajaj';

  @override
  String get pathMap_pause => 'Premor';

  @override
  String get pathMap_replay => 'Ponovitev';

  @override
  String get pathMap_stepBack => 'Prejšnji skok';

  @override
  String get pathMap_stepForward => 'Naslednji skok';

  @override
  String get pathMap_animationOn => 'Prikaži animacijo paketa';

  @override
  String get pathMap_animationOff => 'Skrij animacijo paketa';

  @override
  String pathMap_hopOf(int current, int total) {
    return 'Skok $current od $total';
  }

  @override
  String pathMap_observedPaths(int count) {
    return 'Opazovane poti: $count';
  }

  @override
  String get pathMap_primary => 'Primarna';

  @override
  String pathMap_alternate(int index) {
    return 'Alternativa $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skokov',
      few: '$count skoki',
      two: '2 skoka',
      one: '1 skok',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => 'Deljen segment';

  @override
  String get pathMap_legendEstimated => 'Ocenjen segment';

  @override
  String pathMap_sharedNodeCount(int count) {
    return 'Uporablja $count poti';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skokov nima lokacije — prikazana pot je delna',
      few: '$count skoki nimajo lokacije — prikazana pot je delna',
      two: '2 skoka nimata lokacije — prikazana pot je delna',
      one: '1 skok nima lokacije — prikazana pot je delna',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'Pokaži vse';

  @override
  String get pathMap_hidePath => 'Skrij pot';

  @override
  String get pathMap_showPath => 'Pokaži pot';

  @override
  String get pathMap_collapsePanel => 'Strni ploščo';

  @override
  String get pathMap_expandPanel => 'Razširi ploščo';

  @override
  String get pathMap_noLocation => 'Brez lokacije';

  @override
  String get pathMap_followPacket => 'Zakleni pogled na paket';

  @override
  String get pathMap_unfollowPacket => 'Odkleni pogled od paketa';

  @override
  String get imageSend_title => 'Sločaji slik';

  @override
  String get imageSend_cropNote =>
      'Zadovoljno izmenjeno na 512 × 512 · vzorovni odnos ne ohranjen';

  @override
  String get imageSend_originalSize =>
      'Original text:\n\nThe early bird catches the worm.\n\nTranslation:\n\nPojdi prvi, zlati v kroku.';

  @override
  String get imageSend_onAirSize => 'Na vodi';

  @override
  String get imageSend_quality => 'Kakovost';

  @override
  String get imageSend_qualityStandard => 'Standard';

  @override
  String get imageSend_qualityHigh => 'Vysoko';

  @override
  String get imageSend_packetsLabel => 'Pakete';

  @override
  String get imageSend_airtimeLabel => 'Čas v eteru';

  @override
  String get imageSend_sizeLabel => 'Napravo';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'paketov',
      one: 'paket',
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
  String get imageSend_radioUnknownTitle => 'Naslušniki radio neznane';

  @override
  String get imageSend_radioUnknownBody =>
      'Poučajte se na stroj, da se lahko izračunuje čas v prikazu.';

  @override
  String get imageSend_longSendTitle => 'Dluga preposlana';

  @override
  String imageSend_longSendBody(String duration) {
    return 'Ovo bo ohranilo kanal prihodno za obliko $duration.';
  }

  @override
  String get imageSend_floodNote =>
      'Povlatni potok: sve repeaterje v območju pretrasirajo svak paket, pa kanál ostane zanudnejši od tega.';

  @override
  String get imageSend_parityTitle => 'Pobavni paket zdržbe';

  @override
  String get imageSend_paritySubtitle =>
      'Jedna dodatna paczka. Grupni izjasi ne izvajajo potvarnosti, pa ta izdelka omogoča preuzimanju ponovno izgleda, če je zgubjen pojedni paket.';

  @override
  String get imageSend_send => 'Posyłaj';

  @override
  String get imageSend_cancel => 'Odločite';

  @override
  String get imageSend_encodeFailed => 'Ovo slikovo ne more biti zakodirano.';

  @override
  String get imageSend_codecDownloading =>
      'Obrazni model še pospeva preborjanje.';

  @override
  String get imageSend_codecUnavailable =>
      'Poslanje slike nema na tem zelo naročnem naročnem.';

  @override
  String get imageSend_codecDisabled => 'Obrazi s pomanjkanjem so v nastavnih.';

  @override
  String get imageSend_deviceUnsupported =>
      'Taj radio ne može posredovati slike pakuete. Prepoštijo izbirni napravnik s kompanijskimi programi na čevem 13 ali novšejšim.';

  @override
  String get imageSend_directMessagesUnsupported =>
      'Obrazy se pojavijo kot skupnih podatkov, pa lahko ih poslujejo samo na kanal — ne v prilogih.';

  @override
  String get imageSend_tooLarge =>
      'Taj slik je zakodiran v viših pakotnih od športne formate, ki omogoča mrežni format.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'paketov',
      one: 'paket',
    );
    return 'Slika poslana kot $count $_temp0.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return 'Obraz ne može biti poslany: $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return 'Prekazivanje izkaza — paket $sent od $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'Vrtitev $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return 'Otrteno od $received na $total poslovanih potokov';
  }

  @override
  String get receivedImage_queued => 'Čekanje, da se dekodira';

  @override
  String get receivedImage_tapToDecode => 'Kliknite, da razkrivete';

  @override
  String get receivedImage_decoding =>
      'Ostvarjanje… o prihodnosti za okolo 1 s';

  @override
  String receivedImage_incomplete(int received, int total) {
    return 'Obraz nije kompletan — $received od $total poslaničev je prishodil';
  }

  @override
  String get receivedImage_corrupt => 'Obraz ne more lahko rekonstruirati';

  @override
  String get receivedImage_decoderMissing =>
      'Otrgena slika — dekodirana slika je izključena';

  @override
  String get receivedImage_evicted => 'Obraz ni več niso zakajiren';

  @override
  String get receivedImage_retry => 'Pokušajte znova';

  @override
  String get receivedImage_decodeAgain => 'Dekodiraj ponovno';

  @override
  String get receivedImage_openSettings => 'Nastavite';

  @override
  String get receivedImage_tapToProcess => 'Kliknij za obravnavanje';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'paketov',
      one: 'paket',
    );
    return '$bytes bajtov · $packets $_temp0';
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
  String get bastion_tagline => 'Komunikacija brez infrastrukture.';

  @override
  String get bastion_nodes => 'VOZLIŠČA';

  @override
  String get bastion_repeaters => 'REPETITORJI';

  @override
  String get bastion_active1h => 'AKTIVNI 1 H';

  @override
  String get bastion_mapCoverage => 'ZEMLJEVID + POKRITOST';

  @override
  String get bastion_routeIntelligence => 'ANALIZA POTI';

  @override
  String get bastion_repeaterTools => 'ORODJA ZA REPETITOR';

  @override
  String get bastion_fieldStats => 'TERENSKA STATISTIKA';

  @override
  String get bastion_fieldOps => 'TURA + TERENSKE OPERACIJE';

  @override
  String get bastion_coverageCapture => 'ZAJEM POKRITOSTI';

  @override
  String get bastion_mapAttribution =>
      'Podatki zemljevida © sodelavci OpenStreetMap; ploščice izbranega ponudnika';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count opažanj',
      few: '$count opažanja',
      two: '$count opažanji',
      one: '$count opažanje',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count edinstvenih vozlišč',
      few: '$count edinstvena vozlišča',
      two: '$count edinstveni vozlišči',
      one: '$count edinstveno vozlišče',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skokov',
      few: '$count skoki',
      two: '$count skoka',
      one: '$count skok',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minut',
      few: '$count minute',
      two: '$count minuti',
      one: '$count minuta',
    );
    return '$_temp0';
  }

  @override
  String get sos_holdHint =>
      'Pridržite 2 sekundi. Vsakih 5 minut pošlje vaš položaj stikom na turi, dokler se nekdo ne odzove.';

  @override
  String sos_holdHintChannel(String channel) {
    return 'Pridržite 2 sekundi. Vsakih 5 minut pošlje vaš položaj stikom na turi in na $channel, dokler se nekdo ne odzove.';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS ni bil poslan: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return 'Potrdil(a) $name. Ponavljanje ustavljeno.';
  }

  @override
  String get sos_waitingForRadio => 'Čakanje, da radio pošlje…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return 'Poslano $sends od $max-krat. Ponavljanje končano; odgovora še ni.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return 'Poslano $sends od $max-krat. Naslednje ob $time.';
  }

  @override
  String get sos_active => 'SOS AKTIVEN';

  @override
  String get sos_stop => 'USTAVI';

  @override
  String get sos_imSafe => 'NA VARNEM SEM';

  @override
  String get sos_holdSemantics => 'SOS. Pridržite za pošiljanje.';

  @override
  String get sos_keepHolding => 'DRŽITE NAPREJ…';

  @override
  String get sos_holdForSos => 'PRIDRŽITE ZA SOS';

  @override
  String get sos_blockStorage =>
      'Najprej odpravite napako shranjevanja terenskega dnevnika.';

  @override
  String get sos_blockNotConnected =>
      'Povežite radio MeshCore, da pošljete SOS.';

  @override
  String get sos_blockNoTarget =>
      'Izberite stike na turi ali kanal SOS v razdelku Načrtuj turo.';

  @override
  String get checkIn_labelOk => 'V redu sem';

  @override
  String get checkIn_labelAtCamp => 'V taboru';

  @override
  String get checkIn_labelDelayed => 'Zamujam';

  @override
  String get checkIn_labelHeadingBack => 'Vračam se';

  @override
  String get checkIn_blockLoading => 'Nalaganje ture…';

  @override
  String get checkIn_blockStorage =>
      'Pred pošiljanjem odpravite napako shranjevanja terenskega dnevnika.';

  @override
  String get checkIn_blockBusy => 'Javljanje se pošilja. Počakajte.';

  @override
  String get checkIn_blockNoContacts =>
      'Izberite stike na turi v razdelku Načrtuj turo.';

  @override
  String get checkIn_blockRosterIncomplete =>
      'Nekateri stiki na turi niso na voljo. Preglejte seznam.';

  @override
  String get checkIn_blockNotConnected =>
      'Povežite radio MeshCore, da se javite.';

  @override
  String get checkIn_blockNotActive => 'Začnite turo, da omogočite javljanja.';

  @override
  String get checkIn_notSent => 'Ni poslano';

  @override
  String checkIn_deliveredToOne(String name) {
    return 'Dostavljeno: $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return 'Dostavljeno vsem stikom ($count)';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return 'Dostavljeno $delivered od $total';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return 'Ni dostavljeno: $names';
  }

  @override
  String get checkIn_waitingForRest => 'Čakanje na ostale';

  @override
  String get checkIn_aContact => 'stik';

  @override
  String get checkIn_statusPending => 'Čaka';

  @override
  String get checkIn_statusSent => 'Poslano';

  @override
  String get checkIn_statusDelivered => 'Dostavljeno';

  @override
  String get checkIn_statusFailed => 'Ni uspelo';

  @override
  String get checkIn_explainPending =>
      'Lokalno v čakalni vrsti. To ne potrjuje radijskega oddajanja ali prejema.';

  @override
  String get checkIn_explainSent =>
      'Radio je sprejel pošiljanje. Potrdilo o dostavi ni bilo zabeleženo.';

  @override
  String get checkIn_explainDelivered =>
      'Aplikacija je zabeležila potrdilo o dostavi. To ne dokazuje, da je oseba sporočilo prebrala.';

  @override
  String get checkIn_explainFailed =>
      'Ni potrjene dostave. Preverite radijsko povezavo, dosegljivost prejemnika in zgodovino ponovnih poskusov.';

  @override
  String get checkIn_explainUnknown =>
      'Stanje dostave ni na voljo. Ne predpostavljajte, da je sporočilo prispelo.';

  @override
  String get tripBrief_heading => 'NOTORYX • Povzetek ture MeshCore';

  @override
  String tripBrief_trip(String name) {
    return 'Tura: $name';
  }

  @override
  String tripBrief_status(String status) {
    return 'Stanje: $status';
  }

  @override
  String get tripBrief_active => 'Aktivna';

  @override
  String get tripBrief_stopped => 'Ustavljena';

  @override
  String tripBrief_contacts(String names) {
    return 'Stiki: $names';
  }

  @override
  String get tripBrief_noneSelected => 'Ni izbranih';

  @override
  String get tripBrief_unavailableContact =>
      'Nedosegljiv stik (preglejte seznam)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return 'Dejavnost zamuja po: $minutes min (ta telefon opozori, ko stik utihne)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'Opomnik za javljanje: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return 'vsakih $minutes min brez javljanja';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'Možnosti javljanja: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'Položaj radia v javljanjih: $value';
  }

  @override
  String get tripBrief_includedMayBeStale => 'Vključen; morda zastarel';

  @override
  String tripBrief_battery(String value) {
    return 'Baterija radia v javljanjih: $value';
  }

  @override
  String get tripBrief_included => 'Vključena';

  @override
  String get tripBrief_off => 'Izklop.';

  @override
  String get tripBrief_review =>
      'Pred pošiljanjem javljanja preglejte prejemnike in sporočilo.';

  @override
  String get tripBrief_noProof =>
      'V čakalni vrsti ali poslano ne dokazuje dostave. Potrdilo ne dokazuje, da je bilo prebrano.';

  @override
  String get tripBrief_overdueMeaning =>
      'Zamuda pomeni, da ni nedavne dejavnosti stika; to ni potrjena nujna situacija.';

  @override
  String get tripBrief_automations =>
      'Terenske avtomatizacije delujejo samo, ko je aplikacija aktivna. Dogovorite se za ločen načrt za primer izgubljenega stika.';

  @override
  String get tripBrief_sharesOnly =>
      'Ta povzetek samo deli informacije; ne pošlje radijskega sporočila in ne začne ture.';

  @override
  String get fieldOps_title => 'Terenske operacije NOTORYX Core';

  @override
  String get fieldOps_tabTrip => 'TURA';

  @override
  String get fieldOps_tabReady => 'PRIPRAVLJENOST';

  @override
  String get fieldOps_tabLog => 'DNEVNIK';

  @override
  String get fieldOps_tabAuto => 'AVTO';

  @override
  String get fieldOps_tabCoverage => 'POKRITOST';

  @override
  String get fieldOps_tabConnection => 'POVEZAVA';

  @override
  String get fieldOps_diagnostics => 'Diagnostika';

  @override
  String get fieldOps_storageLoadError =>
      'Terenskih podatkov ni bilo mogoče naložiti. Shranjeni podatki so ohranjeni; avtomatizacije ostajajo izklopljene.';

  @override
  String get fieldOps_storageSaveError =>
      'Terenskih podatkov ni bilo mogoče shraniti. Avtomatizacije ustavljene; obstoječi shranjeni podatki so ohranjeni.';

  @override
  String get fieldOps_regionHint =>
      'Izberite območje in ravni povečave v razdelku Zemljevidi brez povezave.';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • povečava $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return 'Območja zemljevida ni bilo mogoče preveriti: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tura aktivna • $count stikov',
      few: 'Tura aktivna • $count stiki',
      two: 'Tura aktivna • $count stika',
      one: 'Tura aktivna • $count stik',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped =>
      'Tura je ustavljena. Začnite jo, ko boste pripravljeni.';

  @override
  String fieldOps_reminderAt(String time) {
    return 'Opomnik za javljanje ob $time';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return 'Predolgo tiho: $names';
  }

  @override
  String get fieldOps_planTrip => 'Načrtuj turo';

  @override
  String get fieldOps_endTrip => 'Končaj turo';

  @override
  String get fieldOps_startTrip => 'Začni turo';

  @override
  String get fieldOps_tripBrief => 'Povzetek ture';

  @override
  String get fieldOps_connectRadio => 'Poveži radio';

  @override
  String get fieldOps_previewedCheckIns => 'Javljanja s predogledom';

  @override
  String get fieldOps_previewedCheckInsHint =>
      'Izberite stanje, preglejte dejanske prejemnike in sporočilo ter nato pošljite. V čakalni vrsti ne pomeni dostavljeno.';

  @override
  String get fieldOps_tripRoster => 'Seznam ture';

  @override
  String get fieldOps_rosterEmpty =>
      'V razdelku Načrtuj turo izberite do šest znanih stikov za klepet.';

  @override
  String get fieldOps_rosterCaveat =>
      '»Nazadnje slišan« je dokaz pretekle dejavnosti. Ne potrjuje trenutne dosegljivosti. Oznake zamude pomenijo, da ni nedavne dejavnosti stika, ne pa potrjene nujne situacije.';

  @override
  String get fieldOps_offlineMaps => 'Zemljevidi brez povezave';

  @override
  String get fieldOps_checkingTiles => 'Preverjanje shranjenih ploščic…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ploščic v predpomnilniku.',
      few: '$count ploščice v predpomnilniku.',
      two: '$count ploščici v predpomnilniku.',
      one: '$count ploščica v predpomnilniku.',
    );
    return '$_temp0 To ne zagotavlja, da je pokrita celotna pot.';
  }

  @override
  String get fieldOps_downloadAreas =>
      'Prenesi / preglej območja brez povezave';

  @override
  String fieldOps_lastCheckIn(String time) {
    return 'Zadnje javljanje, $time';
  }

  @override
  String fieldOps_deliveryChip(String name, String status) {
    return '$name: $status';
  }

  @override
  String get fieldOps_contactFallback => 'Stik';

  @override
  String fieldOps_resendFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Znova pošlji $count nedostavljenim',
      few: 'Znova pošlji $count nedostavljenim',
      two: 'Znova pošlji $count nedostavljenima',
      one: 'Znova pošlji $count nedostavljenemu',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable => 'Izbrani stik ni na voljo';

  @override
  String get fieldOps_memberUnavailableHint =>
      'Pred pošiljanjem preglejte to turo.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return 'Zadnja dejavnost pred $minutes min';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return 'Zadnja dejavnost pred $minutes min • zamuja';
  }

  @override
  String get fieldOps_noCheckInRecorded =>
      'V tem dnevniku ni zabeleženega javljanja.';

  @override
  String get fieldOps_tripMap => 'Zemljevid ture';

  @override
  String get fieldOps_tripMapEmpty =>
      'Nobeden od izbranih stikov še ni oddal koordinat.';

  @override
  String get fieldOps_lastPositions => 'Nazadnje oddani položaji';

  @override
  String get fieldOps_positionsCaveat =>
      'Položaji so morda zastareli. Ta zemljevid ne sledi GPS-u telefona in ne dokazuje, da so člani trenutno tukaj.';

  @override
  String get fieldOps_briefPreviewTitle => 'Predogled povzetka ture';

  @override
  String get fieldOps_briefPreviewHint =>
      'Vsebuje imena ture in stikov. Pred deljenjem preglejte. Koordinate, ključi in zgodovina sporočil so izpuščeni.';

  @override
  String get fieldOps_shareBrief => 'Deli povzetek';

  @override
  String get fieldOps_briefSubject => 'Povzetek ture NOTORYX Core';

  @override
  String get fieldOps_tripName => 'Ime ture';

  @override
  String get fieldOps_defaultTripName => 'Moja tura';

  @override
  String get fieldOps_includePosition => 'Vključi oddani položaj radia';

  @override
  String get fieldOps_includePositionHint =>
      'Morda zastarel; deljenje je privzeto izklopljeno.';

  @override
  String get fieldOps_includeBattery => 'Vključi baterijo radia';

  @override
  String get fieldOps_overdueLabel => 'Opozori me, ko je stik tiho dlje kot';

  @override
  String get fieldOps_reminderLabel => 'Opomni me na javljanje';

  @override
  String get fieldOps_reminderHelper =>
      'Obvestilo na telefonu, tudi ko je NOTORYX Core zaprt.';

  @override
  String get fieldOps_reminderOff => 'Izklop.';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Po $count minutah brez javljanja',
      few: 'Po $count minutah brez javljanja',
      two: 'Po $count minutah brez javljanja',
      one: 'Po $count minuti brez javljanja',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'SOS gre tudi na kanal';

  @override
  String get fieldOps_sosChannelNone => 'Brez';

  @override
  String get fieldOps_selectContacts =>
      'Izberite do šest znanih stikov za klepet';

  @override
  String get fieldOps_sendCheckInTitle => 'Pošljem javljanje?';

  @override
  String fieldOps_recipients(String names) {
    return 'Za: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      'Uporablja običajna neposredna sporočila. Dostava se bo spremljala v terenskem dnevniku.';

  @override
  String get fieldOps_send => 'Pošlji';

  @override
  String get fieldOps_beforeYouLeave => 'Pred odhodom';

  @override
  String get fieldOps_radioConnected => 'Radio povezan';

  @override
  String get fieldOps_connectHint =>
      'Povežite se prek Bluetootha, USB ali TCP.';

  @override
  String get fieldOps_radioBattery => 'Baterija radia';

  @override
  String get fieldOps_batteryUnknown => 'Neznano; preverite radio.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent % • napolnite za načrtovano turo.';
  }

  @override
  String get fieldOps_tripContacts => 'Stiki na turi';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return 'Na voljo $available/$selected. Preverite, ali imajo združljive radie in kanale.';
  }

  @override
  String get fieldOps_offlineArea => 'Izbrano območje zemljevida brez povezave';

  @override
  String get fieldOps_checkingFiles => 'Preverjanje lokalnih datotek…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return 'Na voljo datotek ploščic: $available/$expected; manjka: $missing. To je posnetek stanja; pred odhodom odprite območje brez povezave.';
  }

  @override
  String get fieldOps_locationChoice => 'Deljenje lokacije';

  @override
  String get fieldOps_locationOptedIn =>
      'Vklopljeno: koordinate, ki jih odda radio, so morda zastarele.';

  @override
  String get fieldOps_locationOff =>
      'Deljenje je izklopljeno. Vaša javljanja ne vsebujejo koordinat.';

  @override
  String get fieldOps_automationAvailability =>
      'Razpoložljivost avtomatizacije';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'Deluje samo, ko je ta aplikacija aktivna. Spanje, zaprtje ali izguba radia lahko preprečijo načrtovana dejanja.';

  @override
  String get fieldOps_readinessCaveat =>
      'Preverjanja pripravljenosti so svetovalna; ne dokazujejo dosega radia in ne zagotavljajo dostave sporočil.';

  @override
  String get fieldOps_radio => 'Radio';

  @override
  String get fieldOps_refreshChecks => 'Osveži preverjanja';

  @override
  String get fieldOps_searchLog => 'Iskanje v terenskem dnevniku';

  @override
  String get fieldOps_kindAll => 'Vse';

  @override
  String get fieldOps_kindCheckIn => 'Javljanje';

  @override
  String get fieldOps_kindReceived => 'Prejeto';

  @override
  String get fieldOps_kindNote => 'Opomba';

  @override
  String get fieldOps_kindDeadZone => 'Mrtva cona';

  @override
  String get fieldOps_kindRadio => 'Radio';

  @override
  String get fieldOps_kindAutomation => 'Avtomatizacija';

  @override
  String get fieldOps_kindMissed => 'Zamujeno';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => 'Tura';

  @override
  String get fieldOps_kindOverdue => 'Zamuja';

  @override
  String get fieldOps_addNote => 'Dodaj opombo';

  @override
  String get fieldOps_exportJson => 'Izvozi JSON';

  @override
  String get fieldOps_deleteLog => 'Izbriši dnevnik';

  @override
  String get fieldOps_logSubject => 'Terenski dnevnik NOTORYX Core';

  @override
  String get fieldOps_logCaveat =>
      'Shranjeno lokalno, do 1000 vnosov. Izvozi lahko vsebujejo ključe stikov, sporočila in lokacije; pred deljenjem preglejte.';

  @override
  String get fieldOps_noEntries => 'Ni ustreznih vnosov.';

  @override
  String get fieldOps_tripUnspecified => 'Tura ni navedena';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return 'Zabeležen oddani položaj radia $latitude, $longitude (morda zastarel)';
  }

  @override
  String get fieldOps_noteTitle => 'Terensko opažanje';

  @override
  String get fieldOps_noteLabel => 'Kaj ste opazili?';

  @override
  String get fieldOps_deadZone => 'Prijavljena mrtva cona';

  @override
  String get fieldOps_deadZoneHint =>
      'Vaše opažanje, ne preverjena napoved pokritosti.';

  @override
  String get fieldOps_savePosition => 'Shrani oddani položaj radia';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • morda zastarel; ni GPS telefona';
  }

  @override
  String get fieldOps_noPosition => 'Ni uporabnih oddanih koordinat';

  @override
  String get fieldOps_deleteLogTitle => 'Izbrišem terenski dnevnik?';

  @override
  String get fieldOps_deleteLogBody =>
      'S tem odstranite vse shranjene vnose v tem telefonu. Nastavitve ture ostanejo.';

  @override
  String get fieldOps_localAutomations => 'Lokalne avtomatizacije';

  @override
  String get fieldOps_enableForTrip => 'Omogoči za to turo';

  @override
  String get fieldOps_automationsCaveat =>
      'Po vsakem ponovnem zagonu aplikacije so izklopljene. Pravila delujejo samo, ko je aplikacija aktivna. Zamujena načrtovana dejanja se prikažejo v terenskem dnevniku in se nikoli ne izvedejo naknadno v nizu. Samodejna javljanja so omejena na en paket na 10 minut.';

  @override
  String get fieldOps_openBotMode => 'Odpri način bota NOTORYX';

  @override
  String get fieldOps_ruleEnabled => 'Pravilo omogočeno';

  @override
  String get fieldOps_dryRun => 'Poskusni zagon';

  @override
  String get fieldOps_dryRunHint =>
      'Zabeleži dejanje brez pošiljanja ali obveščanja.';

  @override
  String get fieldOps_then => 'POTEM';

  @override
  String get fieldOps_actionLog => 'Zapiši v terenski dnevnik';

  @override
  String get fieldOps_actionNotify => 'Pokaži lokalno obvestilo';

  @override
  String get fieldOps_actionCheckIn => 'Pošlji »I\'m OK« stikom na turi';

  @override
  String get fieldOps_batteryThreshold => 'Baterija na ali pod';

  @override
  String fieldOps_nextDue(String time) {
    return 'Naslednje: $time';
  }

  @override
  String get fieldOps_nextDueNone => 'Naslednje: ni načrtovano';

  @override
  String get fieldOps_previewInLog => 'Predogled v dnevniku';

  @override
  String get fieldOps_allowNotifications => 'Dovoli obvestila';

  @override
  String get fieldOps_triggerReconnect => 'KO se radio znova poveže';

  @override
  String get fieldOps_triggerDisconnect => 'KO se radio prekine';

  @override
  String get fieldOps_triggerLowBattery => 'KO baterija radia prestopi prag';

  @override
  String get fieldOps_triggerNewNode => 'KO je dodano novo vozlišče';

  @override
  String get fieldOps_triggerRepeater => 'KO je dodan nov repetitor';

  @override
  String get fieldOps_triggerScheduled => 'KO je na vrsti načrtovano javljanje';

  @override
  String get fieldOps_explainConnection => 'Razloži mojo povezavo';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return 'Stanje: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      'Telefon ima povezavo z radiem. To samo po sebi ne zagotavlja poti do vaših prejemnikov.';

  @override
  String get fieldOps_disconnectedHint =>
      'Ni aktivne radijske povezave. Preverite dovoljenja za Bluetooth, napajanje in doseg radia; USB/TCP sta na voljo v razdelku Poveži radio.';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return 'Javljanja ture, ki čakajo na potrditev: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'Časi zadnje zaznave in oddani položaji vozlišč so morda zastareli. Analiza poti prikazuje poti, naučene iz opaženih poskusov; poti si ne izmišljuje.';

  @override
  String get fieldOps_routeIntelligence => 'Analiza poti';

  @override
  String get fieldOps_coverageIntelligence => 'Analiza pokritosti';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      'Primerjajte zabeležena opažanja dveh terenskih sej. Pike označujejo oddane položaje radia snemalca, kjer so bila slišana vozlišča. Ne pomenijo neprekinjene pokritosti. Posnetki RSSI/SNR niso meritve za posamezna vozlišča.';

  @override
  String get fieldOps_captureSession => 'Zajemi sejo';

  @override
  String get fieldOps_refreshHistory => 'Osveži zgodovino';

  @override
  String get fieldOps_noCoverageSessions => 'Shranjenih sej pokritosti še ni.';

  @override
  String get fieldOps_sessionA => 'Seja A • modrozelena';

  @override
  String get fieldOps_sessionB => 'Seja B • jantarna';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: edinstvena vozlišča $a • B: edinstvena vozlišča $b';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return 'Skupna: $shared • Samo A: $onlyA • Samo B: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'Če vozlišča v eni seji ni slišati, to ne potrjuje mrtve cone. Pogoji in trajanje opazovanja se razlikujejo.';

  @override
  String get fieldOps_heardTooltip =>
      'Opažanje slišanega vozlišča; ni dokaz uspešne povezave';

  @override
  String get fieldOps_noteTooltip =>
      'Lokalna opomba pri koordinatah, ki jih je oddal radio; morda zastarela.';

  @override
  String get bastionHome_aboutTooltip => 'O aplikaciji NOTORYX Core';

  @override
  String get bastionHome_getStarted => 'ZAČNITE';

  @override
  String get bastionHome_getStartedHint =>
      'Povežite radio in preverite prvo sporočilo';

  @override
  String get bastionHome_planYourTrip => 'NAČRTUJTE TURO';

  @override
  String get bastionHome_tripActive => 'Tura aktivna';

  @override
  String get bastionHome_tripStopped => 'Tura ustavljena';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • stiki: $contacts • neprebrana: $unread';
  }

  @override
  String get bastionHome_checkInOk => 'JAVLJANJE: V REDU SEM';

  @override
  String get bastionHome_checkInHint =>
      'Pred pošiljanjem preglejte stike in sporočilo. Potrdila spremljajte v terenskem dnevniku.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return 'Zadnje javljanje: $summary';
  }

  @override
  String get bastionHome_connectRadio => 'POVEŽI RADIO';

  @override
  String get bastionHome_connectRadioHint =>
      'Povezave MeshCore prek Bluetootha, USB in TCP';

  @override
  String get bastionHome_liveDiagnostics => 'DIAGNOSTIKA V ŽIVO';

  @override
  String get bastionHome_liveDiagnosticsHint =>
      'Stanje radia, signal, naprava in orodja za okvirje';

  @override
  String get bastionHome_meshDiscovery => 'ODKRIVANJE OMREŽJA';

  @override
  String get bastionHome_meshDiscoveryHint =>
      'Poiščite vozlišča in raziščite omrežje okoli sebe';

  @override
  String get bastionHome_fieldOpsHint =>
      'Povzetek ture, pripravljenost, terenski dnevnik, avtomatizacije in primerjava pokritosti';

  @override
  String get bastionHome_fieldTools => 'TERENSKA ORODJA NOTORYX';

  @override
  String get bastionHome_statusActive => 'AKTIVNO';

  @override
  String get bastionHome_consoleOnline => 'TERENSKA KONZOLA POVEZANA';

  @override
  String get bastionHome_consoleReady => 'TERENSKA KONZOLA PRIPRAVLJENA';

  @override
  String get bastionHome_consoleHint =>
      'Povežite radio, da vklopite nadzorno ploščo v živo.';

  @override
  String bastionHome_battery(String value) {
    return 'BAT $value';
  }

  @override
  String get bastionTools_title => 'Terenska orodja';

  @override
  String get bastionTools_backup => 'ŠIFRIRANA VARNOSTNA KOPIJA';

  @override
  String get bastionTools_backupHint =>
      'Shranite nastavitve, stike in ključe, po želji z zgodovino klepetov';

  @override
  String get bastionTools_fieldOpsHint =>
      'Javljanja, pripravljenost, terenski dnevnik, avtomatizacije in primerjave';

  @override
  String get bastionTools_mapHint =>
      'Zemljevid v živo, seje zajema, orodja za zemljevide brez povezave in regije';

  @override
  String get bastionTools_pathAnalysis => 'ANALIZA POTI';

  @override
  String get bastionTools_pathHint => 'Poti, odkrivanje in analiza poti';

  @override
  String get bastionTools_repeaterHint =>
      'Stanje, prijava, telemetrija, sosedje in upravljanje';

  @override
  String get bastionTools_statsHint =>
      'Števci omrežja v živo in dejavnost stikov';

  @override
  String get bastionTools_diagnostics => 'DIAGNOSTIKA';

  @override
  String get bastionTools_diagnosticsHint =>
      'Stanje radia, podatki o napravi, surovi okvirji in izvoz';

  @override
  String get bastionTools_about => 'O APLIKACIJI + ZAHVALE';

  @override
  String get bastionTools_aboutHint =>
      'Različica NOTORYX Core, izjava o neodvisnosti in odprtokodne licence';

  @override
  String get bastionAbout_title => 'O aplikaciji + Zahvale';

  @override
  String get bastionAbout_intro =>
      'Neodvisna skupnostna spremljevalna aplikacija za omrežja MeshCore. NOTORYX Core ni uradna aplikacija MeshCore in vključitev virov skupnosti ne pomeni partnerstva ali podpore.';

  @override
  String get bastionAbout_version => 'RAZLIČICA';

  @override
  String get bastionAbout_openSource => 'ODPRTOKODNA OSNOVA';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core temelji na odprti kodi MeshCore Open z licenco MIT in jo spreminja. Delo na poteku pokritosti priznava tudi, kjer je primerno, aplikacijo MeshMapper Flutter App z licenco MIT.';

  @override
  String get bastionAbout_community => 'SKUPNOST NA PRVEM MESTU';

  @override
  String get bastionAbout_communityBody =>
      'Viri tretjih ustvarjalcev ostajajo last njihovih ustvarjalcev. Lastništvo ali partnerstvo ni implicirano.';

  @override
  String get bastionAbout_legalese =>
      'NOTORYX Core • Neodvisni spremljevalec MeshCore';

  @override
  String get bastionAbout_licenses => 'ODPRTOKODNE LICENCE';

  @override
  String get bastionSetup_title => 'Začetek z aplikacijo NOTORYX Core';

  @override
  String get bastionSetup_intro =>
      'Povežite se, izberite stik in nato preverite sporočilo. K temu vodniku se lahko kadar koli vrnete z nadzorne plošče.';

  @override
  String get bastionSetup_step1 => '1. Povežite radio MeshCore';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return 'Povezano z $device prek $transport.';
  }

  @override
  String get bastionSetup_noRadio => 'Radio še ni povezan.';

  @override
  String get bastionSetup_step1Power =>
      'Vklopite spremljevalni radio MeshCore. Odprite Poveži radio in izberite Bluetooth, USB ali TCP. Dovolite dovoljenja, zahtevana za izbrano povezavo.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Če je iskanje Bluetooth prazno, preverite, ali je Bluetooth vklopljen in ali ima NOTORYX Core dovoljenje Naprave v bližini v nastavitvah aplikacij Android. Sledite morebitnim dodatnim zahtevam za dovoljenja, ki jih prikaže iskalnik.';

  @override
  String get bastionSetup_connectionDiagnostics => 'Diagnostika povezave';

  @override
  String get bastionSetup_step2 => '2. Izberite stik za klepet';

  @override
  String get bastionSetup_step2Body =>
      'Prosite bližnjega partnerja z združljivimi nastavitvami radia MeshCore, naj oglasi svoje vozlišče. Spodaj izberite znan stik za klepet; repetitorji se upravljajo ločeno.';

  @override
  String get bastionSetup_noContacts =>
      'Ni razpoložljivih stikov za klepet. Povežite radio in odprite Odkrivanje omrežja.';

  @override
  String get bastionSetup_testRecipient => 'Testni prejemnik';

  @override
  String get bastionSetup_meshDiscovery => 'Odkrivanje omrežja';

  @override
  String get bastionSetup_step3 => '3. Pošljite in preverite sporočilo';

  @override
  String get bastionSetup_step3Body =>
      'Odprite klepet, napišite kratko testno sporočilo, preglejte prejemnika in tapnite Pošlji. Vrnite se sem, da vidite zadnje odhodno sporočilo, zabeleženo od odprtja vodnika.';

  @override
  String get bastionSetup_openTestChat => 'Odpri testni klepet';

  @override
  String get bastionSetup_connectFirst =>
      'Povežite radio, da odprete testni klepet.';

  @override
  String get bastionSetup_chooseRecipient => 'Najprej izberite prejemnika.';

  @override
  String get bastionSetup_noTestMessage =>
      'V tej seji vodnika ni zabeleženega odhodnega testnega sporočila.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return 'Zadnje sporočilo: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'Prosite partnerja, naj potrdi prejem ali odgovori. Zabeleženo potrdilo ne dokazuje, da je sporočilo prebral. Če sporočilo ne uspe, znova preverite povezavo in prejemnika.';

  @override
  String get bastionSetup_step4 => '4. Pripravite se na teren';

  @override
  String get bastionSetup_step4Body =>
      'Načrtujte stike na turi in preglejte prenesena območja zemljevidov. Način bota in terenske avtomatizacije so na začetku izklopljeni; terenske avtomatizacije delujejo samo, ko je aplikacija aktivna.';

  @override
  String get bastionSetup_tripTools => 'Orodja za turo in pripravljenost';

  @override
  String get bastionDiag_title => 'Diagnostika';

  @override
  String get bastionDiag_export => 'Izvozi diagnostiko';

  @override
  String get bastionDiag_channels => 'KANALI';

  @override
  String get bastionDiag_radio => 'RADIO';

  @override
  String get bastionDiag_frequency => 'Frekvenca';

  @override
  String get bastionDiag_bandwidth => 'Pasovna širina';

  @override
  String get bastionDiag_spreadingFactor => 'Faktor razširjanja';

  @override
  String get bastionDiag_codingRate => 'Kodno razmerje';

  @override
  String get bastionDiag_txPower => 'Oddajna moč';

  @override
  String get bastionDiag_noiseFloor => 'Raven šuma';

  @override
  String get bastionDiag_device => 'NAPRAVA';

  @override
  String get bastionDiag_name => 'Ime';

  @override
  String get bastionDiag_manufacturer => 'Proizvajalec';

  @override
  String get bastionDiag_firmware => 'Vdelana programska oprema';

  @override
  String get bastionDiag_battery => 'Baterija';

  @override
  String get bastionDiag_transport => 'Povezava';

  @override
  String get bastionDiag_deepTools => 'NAPREDNA ORODJA';

  @override
  String get bastionDiag_liveStats => 'STATISTIKA RADIA V ŽIVO';

  @override
  String get bastionDiag_liveStatsHint => 'Šum, RSSI, SNR in čas oddajanja';

  @override
  String get bastionDiag_frameDebug => 'RAZHROŠČEVANJE OKVIRJEV / BLE';

  @override
  String get bastionDiag_frameDebugHint =>
      'Raziščite dekodirane in surove prejete okvirje';

  @override
  String get bastionDiag_appLog => 'DNEVNIK RAZHROŠČEVANJA APLIKACIJE';

  @override
  String get bastionDiag_appLogHint =>
      'Preglejte diagnostične dogodke aplikacije';

  @override
  String get bastionDiag_online => 'RADIO POVEZAN';

  @override
  String get bastionDiag_offline => 'RADIO NI POVEZAN';

  @override
  String get bastionDiag_offlineHint =>
      'Povežite spremljevalca MeshCore, da napolnite diagnostiko v živo.';

  @override
  String get coverage_title => 'Zajem pokritosti';

  @override
  String get coverage_leaveBlocked => 'Pred odhodom ustavite in shranite sejo.';

  @override
  String get coverage_savedSessions => 'SHRANJENE SEJE';

  @override
  String get coverage_caveat =>
      'RSSI/SNR so posnetki radia in morda pripadajo drugemu paketu. Položaji so koordinate, ki jih je oddal radio, ne GPS telefona ali dokaz pokritosti. Cian: snemalec; jantarna: oddano vozlišče. Interpolacija se ne izvaja.';

  @override
  String get coverage_captureActive => 'ZAJEM AKTIVEN';

  @override
  String get coverage_fieldSession => 'TERENSKA SEJA POKRITOSTI';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core med to sejo beleži na novo slišana vozlišča, vključno s podatki o poti, metapodatki vozlišča/lokacije in najbližjim razpoložljivim posnetkom RSSI/SNR radia.';

  @override
  String get coverage_disconnectedBody =>
      'Pred začetkom povežite radio. Zajem pokritosti beleži opažanja omrežja v živo iz povezanega spremljevalnega radia.';

  @override
  String get coverage_observations => 'OPAŽANJA';

  @override
  String get coverage_uniqueNodes => 'EDINSTVENA VOZLIŠČA';

  @override
  String get coverage_elapsed => 'PRETEKLO';

  @override
  String get coverage_radioConnected => 'RADIO POVEZAN';

  @override
  String get coverage_noRadio => 'NI RADIA';

  @override
  String get coverage_gpsReady => 'GPS RADIA PRIPRAVLJEN';

  @override
  String get coverage_noGps => 'NI GPS RADIA';

  @override
  String get coverage_stopSave => 'USTAVI + SHRANI SEJO';

  @override
  String get coverage_start => 'ZAČNI SEJO POKRITOSTI';

  @override
  String get coverage_exportJson => 'IZVOZI JSON';

  @override
  String get coverage_exportCsv => 'IZVOZI CSV';

  @override
  String get coverage_liveObservations => 'OPAŽANJA V ŽIVO';

  @override
  String get coverage_waiting => 'ČAKANJE NA DEJAVNOST OMREŽJA';

  @override
  String get coverage_waitingBody =>
      'Začnite sejo in na novo slišana aktivna vozlišča se bodo prikazala tukaj. Vrednosti RSSI/SNR so posnetki radia in jih ni vedno mogoče nedvoumno pripisati določenemu paketu.';

  @override
  String get coverage_signalNa => 'signal n/a';

  @override
  String get coverage_snrNa => 'SNR n/a';

  @override
  String get coverage_gpsUnavailable => 'GPS radia ni na voljo';

  @override
  String coverage_pathLine(String path, String location) {
    return 'Pot: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'flood';

  @override
  String get coverage_pathDirect => 'neposredno';

  @override
  String get coverage_shareSubject => 'Seja pokritosti NOTORYX Core';

  @override
  String get coverage_shareText => 'Izvoz zajema pokritosti NOTORYX Core';

  @override
  String get coverage_historyTitle => 'Shranjene seje pokritosti';

  @override
  String coverage_loadFailed(String error) {
    return 'Sej ni bilo mogoče naložiti: $error';
  }

  @override
  String get coverage_deleteTitle => 'Izbrišem shranjeno sejo?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count opažanj bo odstranjenih s te naprave.',
      few: '$count opažanja bodo odstranjena s te naprave.',
      two: '$count opažanji bosta odstranjeni s te naprave.',
      one: '$count opažanje bo odstranjeno s te naprave.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'Seje ni bilo mogoče izbrisati: $error';
  }

  @override
  String get coverage_retention =>
      'Ohrani se 20 najnovejših dokončanih sej. Delite seje, ki jih želite obdržati. Prekinjene zajeme lahko znova odprete spodaj.';

  @override
  String get coverage_noSessions =>
      'Shranjenih sej še ni. Ustavite zajem, da ga shranite.';

  @override
  String get coverage_interrupted => 'Prekinjen zajem';

  @override
  String get coverage_saved => 'Shranjeno';

  @override
  String get coverage_deleteTooltip => 'Izbriši sejo';

  @override
  String coverage_exportFailed(String error) {
    return 'Izvoz ni uspel: $error';
  }

  @override
  String get coverage_sessionTitle => 'Seja pokritosti';

  @override
  String get coverage_shareJson => 'Deli JSON';

  @override
  String get coverage_shareCsv => 'Deli CSV';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • starost posnetka $age ms';
  }

  @override
  String get coverage_unknown => 'neznano';

  @override
  String coverage_pathValue(String path) {
    return 'pot $path';
  }

  @override
  String get coverage_recorder => 'Snemalec';

  @override
  String get coverage_noCoordinates =>
      'V tej seji ni uporabnih koordinat. Opažanja ostajajo na voljo spodaj.';

  @override
  String get coverage_osmAttribution =>
      '© sodelavci OpenStreetMap • spletni osnovni zemljevid';

  @override
  String get fieldStats_title => 'TERENSKA ANALIZA';

  @override
  String get fieldStats_snapshot => 'POSNETEK OMREŽJA V ŽIVO';

  @override
  String get fieldStats_headline => 'Kaj NOTORYX Core ve ta trenutek.';

  @override
  String get fieldStats_body =>
      'Ti števci so izračunani iz tabele stikov povezanega MeshCore, lokacij, poti in časov zadnje zaznave.';

  @override
  String get fieldStats_total => 'SKUPAJ';

  @override
  String get fieldStats_chatNodes => 'VOZLIŠČA ZA KLEPET';

  @override
  String get fieldStats_rooms => 'SOBE';

  @override
  String get fieldStats_sensors => 'SENZORJI';

  @override
  String get fieldStats_located => 'Z LOKACIJO';

  @override
  String get fieldStats_favorites => 'PRILJUBLJENI';

  @override
  String get fieldStats_routeSnapshot => 'POSNETEK POTI';

  @override
  String get fieldStats_routed => 'S POTJO';

  @override
  String get fieldStats_direct => 'NEPOSREDNO';

  @override
  String get fieldStats_flood => 'FLOOD';

  @override
  String get fieldStats_pathIntel => 'ANALIZA POTI';

  @override
  String get fieldStats_pathIntelBody =>
      'Analiza poti v NOTORYX Core uporablja shranjene poskuse poti, število skokov, uspehe/neuspehe, čas potovanja in uteži poti za prikaz naučenih poti.';

  @override
  String get fieldStats_coverageSessions => 'SEJE POKRITOSTI';

  @override
  String get fieldStats_coverageSessionsBody =>
      'Zajem pokritosti zdaj shranjuje terenske seje, obnovi prekinjeno delo, izvaža opažanja in na zemljevidu prikaže zabeležene točke pokritosti. RSSI/SNR ostajata najbližji razpoložljivi posnetek radia.';

  @override
  String get mapHub_title => 'TERENSKI ZEMLJEVID NOTORYX';

  @override
  String get mapHub_intro =>
      'Zemljevidi v živo, območja brez povezave, regionalni profili in terenske seje pokritosti NOTORYX Core.';

  @override
  String get mapHub_captureHint =>
      'Začnite in ustavite terensko sejo pokritosti';

  @override
  String get mapHub_badgeNew => 'NOVO';

  @override
  String get mapHub_liveMap => 'ZEMLJEVID OMREŽJA V ŽIVO';

  @override
  String get mapHub_liveMapHint =>
      'Vozlišča, repetitorji, položaji, poti in orodja zemljevida';

  @override
  String get mapHub_badgeLive => 'V ŽIVO';

  @override
  String get mapHub_offlinePacks => 'PAKETI ZEMLJEVIDOV BREZ POVEZAVE';

  @override
  String get mapHub_offlinePacksHint =>
      'Predpomnite ploščice zemljevida za ture in območja brez signala';

  @override
  String get mapHub_badgeOffline => 'BREZ POVEZAVE';

  @override
  String get mapHub_regions => 'PROFILI REGIJ';

  @override
  String get mapHub_regionsHint =>
      'Upravljajte in pridobite regionalne definicije omrežja';

  @override
  String get mapHub_badgeRegions => 'REGIJE';

  @override
  String get routes_title => 'Analiza poti';

  @override
  String get routes_headline => 'Poglejte, kako promet potuje skozi omrežje.';

  @override
  String get routes_body =>
      'NOTORYX Core razvršča shranjene poti z zgodovino poti, ki se je že naučil iz resničnih poskusov sporočil in odkrivanj.';

  @override
  String get routes_routes => 'POTI';

  @override
  String get routes_success => 'USPEHI';

  @override
  String get routes_failed => 'NEUSPEHI';

  @override
  String get routes_routeMap => 'ZEMLJEVID POTI';

  @override
  String get routes_routeMapHint => 'Raziščite vozlišča in poti';

  @override
  String get routes_discover => 'ODKRIJ';

  @override
  String get routes_discoverHint => 'Poiščite nove poti';

  @override
  String get routes_learned => 'NAUČENE POTI';

  @override
  String get routes_none => 'ZGODOVINE POTI ŠE NI';

  @override
  String get routes_noneBody =>
      'Uporabljajte omrežje kot običajno ali zaženite odkrivanje. NOTORYX Core bo tukaj prikazal naučene poti, ko bo na voljo zgodovina poti.';

  @override
  String get routes_direct => 'NEPOSREDNO';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poti',
      few: '$count poti',
      two: '$count poti',
      one: '$count pot',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return 'NAJBOLJŠA  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  utež $weight  •  uspehi: $success / neuspehi: $fail';
  }

  @override
  String routes_fastest(String ms) {
    return 'Najhitrejša znana: $ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'Flood: uspehi: $success / neuspehi: $fail';
  }

  @override
  String get repeaterTools_heroLabel => 'UPRAVLJANJE REPETITORJEV';

  @override
  String get repeaterTools_headline =>
      'Upravljajte infrastrukturo za vašim omrežjem.';

  @override
  String get repeaterTools_body =>
      'Izberite odkrit repetitor, da se prijavite in odprete njegova obstoječa orodja MeshCore za stanje, telemetrijo, sosede, nastavitve in CLI.';

  @override
  String get repeaterTools_discovered => 'ODKRITI';

  @override
  String get repeaterTools_tools => 'ORODJA';

  @override
  String get repeaterTools_available => 'RAZPOLOŽLJIVI REPETITORJI';

  @override
  String get repeaterTools_unnamed => 'Neimenovan repetitor';

  @override
  String get repeaterTools_statusTelemetry => 'STANJE + TELEMETRIJA';

  @override
  String get repeaterTools_statusTelemetryBody =>
      'Preverite stanje in telemetrijo repetitorja z obstoječimi orodji za upravljanje.';

  @override
  String get repeaterTools_neighbors => 'SOSEDJE';

  @override
  String get repeaterTools_neighborsBody =>
      'Raziščite sosednjo infrastrukturo in odnose v omrežju.';

  @override
  String get repeaterTools_cli => 'CLI + NASTAVITVE';

  @override
  String get repeaterTools_cliBody =>
      'Prijavljeni skrbniki lahko dostopajo do obstoječega CLI repetitorja in orodij za nastavitve.';

  @override
  String get repeaterTools_empty =>
      'Repetitorji še niso bili odkriti. Povežite radio in najprej raziščite omrežje.';

  @override
  String get notification_fieldAlertTitle => 'Terensko opozorilo NOTORYX';

  @override
  String get notification_checkInReminderTitle =>
      'Opomnik za javljanje NOTORYX Core';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return 'Že $minutes min ni javljanja na turi $trip. Odprite NOTORYX Core, da se javite.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return '$name se ni oglasil(a) že $minutes min. To ni potrjena nujna situacija.';
  }

  @override
  String get notification_aTripContact => 'Stik na turi';

  @override
  String notification_checkInNotDelivered(String name) {
    return 'Javljanje ni bilo dostavljeno: $name. Znova ga lahko pošljete na zavihku Tura.';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return 'SOS potrdil(a) $name';
  }

  @override
  String get settings_batterySaver => 'Varčevanje z baterijo';

  @override
  String get settings_batterySaverOn =>
      'Vklopljeno: baterija radia vsakih 10 min, GPS vsakih 5 min, statistika največ enkrat na minuto, preverjanja ture vsakih 1–2 min. Sporočila, opozorila in SOS ostanejo nespremenjeni.';

  @override
  String get settings_batterySaverOff =>
      'Redkeje preverjaj radio in turo, da prihraniš baterijo telefona in radia. Sporočila, opozorila in SOS ostanejo nespremenjeni.';

  @override
  String get settings_readAloud => 'Glasno beri nova sporočila';

  @override
  String get settings_readAloudHelper =>
      'Ko je NOTORYX Core odprt. Utišani kanali ostanejo tihi. Vsako sporočilo lahko preberete tudi iz njegovega menija.';

  @override
  String get settings_readAloudOff => 'Izklop.';

  @override
  String get settings_readAloudDirect => 'Neposredna sporočila';

  @override
  String get settings_readAloudAll =>
      'Neposredna sporočila in sporočila kanalov';

  @override
  String get chat_readAloud => 'Preberi na glas';

  @override
  String get messageSearch_title => 'Iskanje sporočil';

  @override
  String get messageSearch_intro =>
      'Iščite po vseh neposrednih sporočilih in sporočilih kanalov, shranjenih v tem telefonu.';

  @override
  String messageSearch_noResults(String query) {
    return 'Nobeno sporočilo ne vsebuje »$query«.';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zadetkov',
      few: '$count zadetki',
      two: '$count zadetka',
      one: '$count zadetek',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return 'Prikazanih je najnovejših $count zadetkov';
  }

  @override
  String get shortcuts_checkIn => 'Javi se';

  @override
  String get shortcuts_trip => 'Tura';

  @override
  String get shortcuts_chats => 'Klepeti';

  @override
  String get shortcuts_map => 'Zemljevid';

  @override
  String get sensor_liveUpdates => 'Posodobitve v živo';

  @override
  String get sensor_intro =>
      'Naj senzor sam pošilja meritve, ko se spremenijo, namesto da vsakič sprašujete. Zahteva prijavo z dostopom za branje.';

  @override
  String get sensor_watch => 'Spremljaj spremembe';

  @override
  String get sensor_loadFirst =>
      'Najprej naložite telemetrijo, da izberete meritve.';

  @override
  String sensor_watching(String readings, String time) {
    return 'Spremljano: $readings do $time.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return 'Spremljano: $readings do $time • regija $region.';
  }

  @override
  String get sensor_noChanges => 'Sprememb še ni bilo sporočenih.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return 'Zadnja posodobitev $time • prejeto: $count';
  }

  @override
  String get sensor_stop => 'Ustavi posodobitve v živo';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'Ustavljeno tukaj; senzor ni potrdil in se bo ustavil, ko poteče čas. $error';
  }

  @override
  String get sensor_dialogBody =>
      'Senzor preverja približno enkrat na minuto in pošlje posodobitev, ko se izbrana meritev spremeni bolj kot njen prag.';

  @override
  String sensor_readingTitle(String label, String channel) {
    return '$label (kanal $channel)';
  }

  @override
  String sensor_readingValue(String label, String channel, String value) {
    return '$label (kanal $channel): $value';
  }

  @override
  String sensor_watchItem(String label, String channel, String delta) {
    return '$label (kanal $channel) ±$delta';
  }

  @override
  String sensor_updateOn(String delta) {
    return 'Posodobi ob spremembi za $delta';
  }

  @override
  String get sensor_changeThreshold => 'Spremeni prag';

  @override
  String sensor_capacity(int max, String used) {
    return 'Senzor lahko spremlja do $max bajtov meritev (porabljeno: $used).';
  }

  @override
  String get sensor_for => 'Za';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ur',
      few: '$count ure',
      two: '$count uri',
      one: '$count uro',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => 'Začni';

  @override
  String sensor_thresholdTitle(String label) {
    return 'Prag: $label';
  }

  @override
  String get sensor_typeTemperature => 'Temperatura';

  @override
  String get sensor_typeHumidity => 'Vlažnost';

  @override
  String get sensor_typePressure => 'Tlak';

  @override
  String get sensor_typeVoltage => 'Napetost';

  @override
  String get sensor_typeCurrent => 'Tok';

  @override
  String get sensor_typeLight => 'Svetloba';

  @override
  String get sensor_typeConcentration => 'Koncentracija';

  @override
  String get sensor_typePercentage => 'Odstotek';

  @override
  String get sensor_typeAnalogInput => 'Analogni vhod';

  @override
  String get sensor_typeAltitude => 'Nadmorska višina';

  @override
  String get setupWizard_title => 'Povežite radio';

  @override
  String get setupWizard_choose => '1. Izberite povezavo';

  @override
  String get setupWizard_prepare => '2. Pripravite radio';

  @override
  String get setupWizard_intro =>
      'Izberite, kako se bo ta telefon ali računalnik povezal z radiem. Radio prenaša sporočila po omrežju mesh.';

  @override
  String get setupWizard_bluetooth =>
      'Brezžična povezava z združljivim radiem v bližini.';

  @override
  String get setupWizard_noBluetooth =>
      'Bluetooth v tem brskalniku ni na voljo. Uporabite izvorno aplikacijo ali podprto povezavo USB.';

  @override
  String get setupWizard_usb => 'Žična povezava s podatkovnim kablom USB.';

  @override
  String get setupWizard_noUsb =>
      'Serijski USB tu ni na voljo. Uporabite podprto namizno ali Android aplikacijo ali Chrome z Web Serial.';

  @override
  String get setupWizard_bluetoothSteps =>
      'Vklopite radio in ga imejte blizu. Vklopite Bluetooth in aplikaciji dovolite uporabo. Zaprite druge aplikacije, povezane z radiem, odprite seznam naprav in poiščite.';

  @override
  String get setupWizard_usbSteps =>
      'Vklopljen radio povežite s podatkovnim kablom USB; kabel samo za polnjenje ne bo deloval. Zaprite druge serijske aplikacije. Odprite seznam naprav USB, izberite radio in dovolite dostop, če se prikaže poziv.';

  @override
  String get setupWizard_firmwareTitle =>
      'Pred menjavo strojne programske opreme preverite združljivost';

  @override
  String get setupWizard_firmware =>
      'Radio potrebuje strojno programsko opremo MeshCore companion, ki podpira izbrano povezavo. Podpora je odvisna od plošče in različice; sama vrata USB še ne pomenijo podpore za serijski USB. Preverite navodila za svojo ploščo in nameščeno različico. Strojna programska oprema repetitorja ali strežnika sobe ni companion. Neuspešna povezava sama po sebi ne pomeni, da morate znova zapisati strojno programsko opremo.';

  @override
  String get setupWizard_settings =>
      'Ta vodnik ne zapisuje strojne programske opreme in ne spreminja nastavitev radia. Po povezavi uporabite Nastavitve za regijo, frekvenco in napredne možnosti. Nastavitve uskladite z lokalnim omrežjem, preden jih spremenite.';

  @override
  String get setupWizard_openBluetooth => 'Odpri naprave Bluetooth';

  @override
  String get setupWizard_openUsb => 'Odpri naprave USB';

  @override
  String get setupWizard_change => 'Spremeni vrsto povezave';

  @override
  String get setupWizard_later => 'Nastavi pozneje';

  @override
  String get setupWizard_bluetoothError =>
      'Povezava z radiem ni uspela. Imejte ga vklopljenega in blizu, preverite dovoljenja za Bluetooth in zaprite druge povezane aplikacije. Nato znova poiščite.';

  @override
  String get setupWizard_scanError =>
      'Iskanje radiev ni uspelo. Vklopite Bluetooth in v sistemskih nastavitvah dovolite dostop do Bluetootha ali naprav v bližini, nato znova poiščite.';

  @override
  String get setupWizard_usbError =>
      'Povezava prek USB ni uspela. Preverite podatkovni kabel in izbrano napravo, dovolite dostop do USB in zaprite druge serijske aplikacije. Znova priključite kabel in poskusite še enkrat.';

  @override
  String get connections_title => 'Povezave';

  @override
  String get connections_radioTitle => 'Povezava z radiem';

  @override
  String get connections_bluetoothOffNotice =>
      'Bluetooth je izklopljen. Vklopite ga za ponovno povezavo; aplikacija bo poskusila znova, ko bo spet vklopljen.';

  @override
  String get connections_transport => 'Vrsta povezave';

  @override
  String connections_lastError(String error) {
    return 'Zadnja napaka: $error';
  }

  @override
  String get connections_disconnectRadio => 'Prekini radio';

  @override
  String connections_reconnectTo(String name) {
    return 'Znova poveži z $name';
  }

  @override
  String get connections_forgetRadio => 'Pozabi radio';

  @override
  String get connections_connectAnother => 'Poveži drug radio';

  @override
  String get connections_usbSerial => 'Serijski USB';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'Naprava';

  @override
  String get connections_publicKey => 'Javni ključ';

  @override
  String get connections_firmware => 'Strojna programska oprema';

  @override
  String connections_firmwareProtocol(String code) {
    return 'protokol v$code';
  }

  @override
  String get connections_battery => 'Baterija';

  @override
  String get connections_lastRx => 'Zadnji sprejem';

  @override
  String get connections_reconnectFailed =>
      'Ponovna povezava z radiem ni uspela';

  @override
  String get connections_statusBluetoothOff => 'Bluetooth je izklopljen';

  @override
  String get connections_statusConnected => 'Povezano';

  @override
  String get connections_statusConnecting => 'Povezovanje…';

  @override
  String get connections_statusDisconnecting => 'Prekinjanje…';

  @override
  String get connections_statusScanning => 'Iskanje radiev…';

  @override
  String get connections_statusReconnectingSoon => 'Kmalu ponovna povezava…';

  @override
  String get connections_statusNotConnected => 'Ni povezano';

  @override
  String get mqtt_cardTitle => 'Povezava MQTT';

  @override
  String get mqtt_statusNotConfigured => 'Ni nastavljeno';

  @override
  String get mqtt_statusDisconnected => 'Prekinjeno';

  @override
  String get mqtt_statusConnecting => 'Povezovanje';

  @override
  String get mqtt_statusConnected => 'Povezano';

  @override
  String get mqtt_statusReconnecting => 'Ponovno povezovanje';

  @override
  String get mqtt_statusError => 'Napaka povezave';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'Posrednik: $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn => 'Prijava z žetonom, ki ga podpiše radio';

  @override
  String mqtt_tokenSignInAs(String username) {
    return 'Prijava z žetonom, ki ga podpiše radio, kot $username…';
  }

  @override
  String get mqtt_connectRadioToSignIn => 'Povežite radio za prijavo';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'Žeton se obnovi ob $time';
  }

  @override
  String mqtt_signedInAs(String username) {
    return 'Prijavljeni kot $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return 'Poslušanje na $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'Paketi: novi $accepted, podvojeni $duplicate, neveljavni $invalid';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return 'Poskus $attempt od $max';
  }

  @override
  String get mqtt_sharingWaitsForRadio => 'Deljenje čaka na povezavo z radiem';

  @override
  String mqtt_sharingOn(String topic) {
    return 'Deljenje na $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return 'Delilo bo na $topic';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'Stanje povezave na $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return 'Deljeno $shared, zadržano $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'Dodajte posrednika za povezovanje prometa MeshCore prek interneta. Povezava z radiem deluje neodvisno.';

  @override
  String get mqtt_disconnect => 'Prekini MQTT';

  @override
  String get mqtt_connect => 'Poveži MQTT';

  @override
  String get mqtt_packetFeed => 'Tok paketov';

  @override
  String get mqtt_setUpBroker => 'Nastavi posrednika';

  @override
  String get mqtt_brokerSettings => 'Nastavitve posrednika';

  @override
  String get mqtt_settingsTitle => 'Nastavitve posrednika MQTT';

  @override
  String get mqtt_presetLabel => 'Začni s predlogo';

  @override
  String get mqtt_presetCustom => 'Lasten posrednik';

  @override
  String get mqtt_presetLocal => 'Lokalni posrednik (vnesite naslov)';

  @override
  String get mqtt_presetLetsMeshUs => 'Analizator LetsMesh (ZDA, skupnost)';

  @override
  String get mqtt_presetLetsMeshEu => 'Analizator LetsMesh (EU, skupnost)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh je analizator paketov MeshCore, ki ga vodi skupnost; ni del NOTORYX in ga NOTORYX ne podpira. Deljenje potrebuje povezan radio in ostane izklopljeno, dokler ga ne vklopite.';

  @override
  String get mqtt_hostname => 'Ime gostitelja posrednika';

  @override
  String get mqtt_port => 'Vrata';

  @override
  String get mqtt_useTls => 'Uporabi TLS';

  @override
  String get mqtt_allowCleartext =>
      'Dovoli nešifrirano povezavo z lokalnim posrednikom';

  @override
  String get mqtt_allowCleartextHint =>
      'Samo localhost, .local in zasebni gostitelji 10.x / 192.168.x.';

  @override
  String get mqtt_useWebSocket => 'Uporabi WebSocket';

  @override
  String get mqtt_webSocketPath => 'Pot WebSocket';

  @override
  String get mqtt_topicPrefix => 'Predpona teme';

  @override
  String get mqtt_region => 'Regija (neobvezno)';

  @override
  String get mqtt_regionHelp =>
      'Koda regije opazovalca, npr. PHL. Pustite prazno za vse.';

  @override
  String get mqtt_deliverChannel =>
      'Dodajaj sporočila kanalov, prejeta prek MQTT';

  @override
  String get mqtt_deliverChannelHint =>
      'Sporočila v vaših kanalih, ki so jih slišali opazovalci, se prikažejo v klepetih. Niso poslana prek vašega radia.';

  @override
  String get mqtt_sharingTitle => 'Deljenje kot opazovalec';

  @override
  String get mqtt_share => 'Deli pakete, ki jih sliši moj radio';

  @override
  String get mqtt_shareHint =>
      'Objavlja oznanila in promet kanalov, ki jih radio sprejme, z njegovim javnim ključem, močjo signala in regijo. Sporočila kanalov ostanejo šifrirana. Zahteva regijo.';

  @override
  String get mqtt_shareDirect => 'Vključi promet neposrednih sporočil';

  @override
  String get mqtt_shareDirectHint =>
      'Zahteve, odgovori in neposredna sporočila. Vsebina ostane šifrirana, vendar se vidi, katera vozlišča se pogovarjajo.';

  @override
  String get mqtt_shareOwn => 'Vključi moja sporočila in oznanila';

  @override
  String get mqtt_signInTitle => 'Prijava';

  @override
  String get mqtt_authPassword => 'Uporabniško ime in geslo';

  @override
  String get mqtt_authToken => 'Žeton, ki ga podpiše radio';

  @override
  String get mqtt_tokenExplain =>
      'Radio z lastnim ključem podpiše enourni žeton za prijavo, aplikacija pa ga obnovi pred iztekom. Ključ nikoli ne zapusti radia. Uporabniško ime je v1_ in javni ključ vašega radia.';

  @override
  String get mqtt_radioReady => 'Radio povezan: pripravljen na prijavo.';

  @override
  String get mqtt_radioNeeded => 'Povežite radio za prijavo. MQTT ga čaka.';

  @override
  String get mqtt_username => 'Uporabniško ime (neobvezno)';

  @override
  String get mqtt_password => 'Geslo';

  @override
  String get mqtt_keepPassword =>
      'Pustite prazno, da ohranite shranjeno geslo.';

  @override
  String get mqtt_credentialsWeb =>
      'V brskalniku se poverilnice hranijo le, dokler je stran odprta.';

  @override
  String get mqtt_credentialsKeychain =>
      'Poverilnice se hranijo v sistemski verigi ključev, nikoli v nastavitvah aplikacije ali dnevnikih.';

  @override
  String get mqtt_saveSettings => 'Shrani nastavitve';

  @override
  String get mqtt_feedTitle => 'Tok paketov MQTT';

  @override
  String get mqtt_feedConnect =>
      'Povežite se s posrednikom, da vidite pakete opazovalcev.';

  @override
  String mqtt_feedWaiting(String topic) {
    return 'Čakanje na pakete na $topic';
  }

  @override
  String get mqtt_feedUnknownObserver => 'Neznan opazovalec';

  @override
  String mqtt_feedHeardBy(String observer) {
    return 'Slišal $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return 'Skoki: $hops · bajti: $bytes';
  }

  @override
  String get mqtt_packetRequest => 'Zahteva';

  @override
  String get mqtt_packetResponse => 'Odgovor';

  @override
  String get mqtt_packetDirectMessage => 'Neposredno sporočilo';

  @override
  String get mqtt_packetAck => 'Potrditev';

  @override
  String get mqtt_packetAdvert => 'Oznanilo';

  @override
  String get mqtt_packetChannelMessage => 'Sporočilo kanala';

  @override
  String get mqtt_packetChannelData => 'Podatki kanala';

  @override
  String get mqtt_packetAnonymousRequest => 'Anonimna zahteva';

  @override
  String get mqtt_packetPath => 'Pot';

  @override
  String get mqtt_packetTrace => 'Sledenje';

  @override
  String get mqtt_packetMultipart => 'Večdelni';

  @override
  String get mqtt_packetControl => 'Upravljanje';

  @override
  String mqtt_packetType(int type) {
    return 'Vrsta $type';
  }

  @override
  String get mqtt_routeTransportFlood => 'Flood s transportom';

  @override
  String get mqtt_routeFlood => 'Flood';

  @override
  String get mqtt_routeDirect => 'Neposredna';

  @override
  String get mqtt_routeTransportDirect => 'Neposredna s transportom';

  @override
  String get mqtt_noticeInvalidHost =>
      'Vnesite ime gostitelja ali naslov IPv4 brez sheme in vrat.';

  @override
  String get mqtt_noticeInvalidPort => 'Vrata morajo biti med 1 in 65535.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'Pot WebSocket se mora začeti z / in ne sme vsebovati poizvedbe ali fragmenta.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'Predpona teme mora biti neprazna pot MQTT brez nadomestnih znakov.';

  @override
  String get mqtt_noticeInvalidRegion =>
      'Regija mora imeti 2–8 črk ali številk, npr. PHL.';

  @override
  String get mqtt_noticeTlsRequired =>
      'TLS je obvezen, razen če je nevaren dostop do lokalnega posrednika izrecno dovoljen.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      'Nešifriran MQTT je dovoljen samo za izrecno odobrene lokalne gostitelje.';

  @override
  String get mqtt_noticeRegionNeededToShare =>
      'Nastavite regijo za deljenje paketov kot opazovalec.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return 'Vnesite geslo za $username.';
  }

  @override
  String get mqtt_noticeNoNetwork =>
      'Ni omrežne povezave. MQTT se bo znova povezal, ko bo spet na voljo.';

  @override
  String get mqtt_noticeSubscriptionRefused =>
      'Posrednik je zavrnil naročnino na pakete.';

  @override
  String get mqtt_noticeBadCredentials =>
      'Posrednik je zavrnil uporabniško ime ali geslo.';

  @override
  String get mqtt_noticeNotAuthorized =>
      'Ta račun na posredniku nima pooblastil.';

  @override
  String get mqtt_noticeConnectionRefused => 'Posrednik je zavrnil povezavo.';

  @override
  String get mqtt_noticeUnreachable => 'Posrednik ni dosegljiv.';

  @override
  String get mqtt_noticeTlsFailed =>
      'Varne povezave (TLS) ni bilo mogoče vzpostaviti.';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'Ta platforma podpira MQTT samo prek WebSocket.';

  @override
  String get mqtt_noticeRadioNotConnected =>
      'Povežite radio za prijavo z njegovim ključem.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'Strojna programska oprema tega radia ne podpira podpisovanja z njegovim ključem.';

  @override
  String get mqtt_noticeSigningTimeout =>
      'Radio se ni odzval na zahtevo za podpis. Njegova strojna programska oprema morda ne podpira podpisovanja.';

  @override
  String get mqtt_noticeSigningTooLong =>
      'Podatki so predolgi, da bi jih radio podpisal.';

  @override
  String get mqtt_noticeSigningRejected => 'Radio je zavrnil podpis podatkov.';

  @override
  String get scanner_signalStrong => 'Močan';

  @override
  String get scanner_signalGood => 'Dober';

  @override
  String get scanner_signalFair => 'Srednji';

  @override
  String get scanner_signalWeak => 'Šibek';

  @override
  String get scanner_nearbyRadios => 'Radii v bližini';

  @override
  String get scanner_lastRadio => 'Zadnji radio';

  @override
  String get scanner_reconnect => 'Ponovno poveži';

  @override
  String get scanner_tcpHint =>
      'Radio z Wi‑Fi strojno programsko opremo v vašem omrežju.';

  @override
  String get scanner_otherWays => 'Drugi načini povezave';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count radiev v bližini',
      few: '$count radii v bližini',
      two: '$count radia v bližini',
      one: '1 radio v bližini',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => 'Iskanje radiev…';

  @override
  String get scanner_findTitle => 'Poiščite svoj radio';

  @override
  String get scanner_heroHint =>
      'Vklopite radio in ga imejte nekaj metrov stran. Potrebuje MeshCore companion strojno programsko opremo.';

  @override
  String get scanner_tipsTitle => 'Ne vidite svojega radia?';

  @override
  String get scanner_tipPower => 'Preverite, ali je vklopljen in aktiven.';

  @override
  String get scanner_tipFirmware =>
      'Potrebuje MeshCore companion strojno programsko opremo. Repetitorji in strežniki sob tukaj niso prikazani.';

  @override
  String get scanner_tipOtherDevice =>
      'Radio se hkrati poveže le z eno napravo. Odklopite ga od drugih telefonov ali računalnikov.';

  @override
  String get connections_internetBridge => 'Internetni most';

  @override
  String get connections_noRadio => 'Ni radia';

  @override
  String get connections_radioSettings => 'Nastavitve radia';

  @override
  String get connections_viewDashboard => 'Prikaži pregled povezav';

  @override
  String get prefixTool_title => 'ID-ji repetitorjev';

  @override
  String get prefixTool_subtitle =>
      'Kdo uporablja ID, kateri ID-ji se ujemajo in prosti ID-ji za nov repetitor';

  @override
  String get prefixTool_width => 'Velikost ID poti';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes B';
  }

  @override
  String get prefixTool_includeCompanions => 'Vključi companione in senzorje';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return 'Znanih vozlišč: $nodes · zasedenih ID: $used · skupnih: $shared';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return 'Prostih ID: $free od $space';
  }

  @override
  String get prefixTool_lookupHint => 'Poišči ID, npr. 3D';

  @override
  String prefixTool_lookupFree(String id) {
    return 'Noben znan vozel ne uporablja $id.';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$id uporablja $count vozlov',
      few: '$id uporabljajo $count vozli',
      two: '$id uporabljata $count vozla',
      one: '$id uporablja 1 vozel',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => 'Skupni ID-ji';

  @override
  String get prefixTool_sharedHint =>
      'Poti prek teh ID-jev so videti enako, razen če omrežje uporablja daljše ID-je.';

  @override
  String get prefixTool_noShared => 'Med znanimi vozlišči ni skupnih ID-jev.';

  @override
  String get prefixTool_free => 'Prosti ID-ji';

  @override
  String get prefixTool_shuffle => 'Več predlogov';

  @override
  String get prefixTool_makeKey => 'Ustvari ključ';

  @override
  String get prefixTool_onlyKnown =>
      'Le na podlagi vozlišč, ki jih je slišal radio. Prost ID tukaj lahko pripada repetitorju, ki ga niste slišali.';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id že uporablja $name.';
  }

  @override
  String get prefixTool_pickFree => 'Izberi prost ID';

  @override
  String keyGen_title(String id) {
    return 'Ključ za ID $id';
  }

  @override
  String keyGen_searching(int tries) {
    return 'Iskanje… preizkušenih ključev: $tries';
  }

  @override
  String get keyGen_publicKey => 'Javni ključ';

  @override
  String get keyGen_privateKey => 'Zasebni ključ';

  @override
  String get keyGen_copy => 'Kopiraj';

  @override
  String get keyGen_copied => 'Kopirano';

  @override
  String get keyGen_secretWarning =>
      'Zasebni ključ hranite v tajnosti. Kdor ga ima, se lahko predstavlja kot to vozlišče.';

  @override
  String get keyGen_howToUse =>
      'Za repetitor: odprite njegove nastavitve, ga prilepite kot zasebni ključ in shranite. Radii companion potrebujejo strojno programsko opremo, ki dovoljuje uvoz ključa.';

  @override
  String get keyGen_tryAgain => 'Ustvari še enega';
}
