// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core';

  @override
  String get nav_contacts => 'Kapcsolatok';

  @override
  String get nav_channels => 'Csatornák';

  @override
  String get nav_map => 'Térkép';

  @override
  String get nav_messages => 'Üzenetek';

  @override
  String get nav_nodes => 'Csomópontok';

  @override
  String get nav_radio => 'Rádió';

  @override
  String get messages_title => 'Üzenetek';

  @override
  String get messages_filterAll => 'Mind';

  @override
  String get messages_filterDirect => 'Közvetlen';

  @override
  String get messages_filterChannels => 'Csatornák';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'Üzenetek keresése';

  @override
  String get messages_searchHint => 'Beszélgetések keresése';

  @override
  String get messages_closeSearch => 'Keresés bezárása';

  @override
  String get messages_manageChannels => 'Csatornák kezelése';

  @override
  String get messages_new => 'Új';

  @override
  String get messages_newDirect => 'Üzenet egy csomópontnak';

  @override
  String get messages_newChannel => 'Csatorna hozzáadása vagy csatlakozás';

  @override
  String get messages_empty => 'Még nincsenek beszélgetések';

  @override
  String get messages_emptyHint =>
      'A csomópontok és csatornák üzenetei itt jelennek meg.';

  @override
  String get messages_noMatches => 'Egy beszélgetés sem felel meg a keresésnek';

  @override
  String messages_you(String text) {
    return 'Ön: $text';
  }

  @override
  String get messages_yesterday => 'Tegnap';

  @override
  String messages_unreadCount(int count) {
    return '$count olvasatlan';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return 'Kapcsolódva: $transport';
  }

  @override
  String get radioStatus_bluetooth => 'Bluetooth';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'Wi‑Fi (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return 'Akkumulátor $percent%';
  }

  @override
  String get radioStatus_openRadio => 'Rádió részleteinek megnyitása';

  @override
  String get radioOverview_battery => 'Akkumulátor';

  @override
  String radioOverview_firmware(String version) {
    return 'Firmware $version';
  }

  @override
  String get radioOverview_sendAdvert => 'Hirdetés küldése';

  @override
  String get radioOverview_stats => 'Rádióstatisztika';

  @override
  String get accessControl_title => 'Hozzáférés-kezelés';

  @override
  String get accessControl_hubSubtitle => 'Ki jelentkezhet be jelszó nélkül';

  @override
  String get accessControl_explainRepeater =>
      'A listán szereplők jelszó nélkül jelentkeznek be. Az adminok módosíthatják a beállításokat; a Csak olvasás és az Olvasás és írás a teljes telemetriát is megkapja.';

  @override
  String get accessControl_explainRoom =>
      'A listán szereplő adminok jelszó nélkül jelentkeznek be, és kezelhetik a szobát. A szoba tagjai a szoba jelszavával csatlakoznak.';

  @override
  String get accessControl_roleReadOnly => 'Csak olvasás';

  @override
  String get accessControl_roleReadWrite => 'Olvasás és írás';

  @override
  String get accessControl_roleAdmin => 'Admin';

  @override
  String get accessControl_you => 'Ön';

  @override
  String get accessControl_unknownNode => 'Ismeretlen csomópont';

  @override
  String get accessControl_add => 'Hozzáadás';

  @override
  String get accessControl_addTitle => 'Hozzáadás a hozzáférési listához';

  @override
  String get accessControl_pickContact => 'Válasszon kapcsolatot';

  @override
  String get accessControl_noContacts =>
      'Nincs hozzáadható kapcsolat. A csomópontok akkor jelennek meg itt, amikor megkapta a hirdetésüket.';

  @override
  String get accessControl_changeRole => 'Szerepkör módosítása';

  @override
  String get accessControl_remove => 'Hozzáférés megvonása';

  @override
  String accessControl_removeConfirm(String name) {
    return 'Eltávolítja $name felhasználót a hozzáférési listáról? A bejelentkezéshez jelszó kell majd.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'Ez Ön. Ha eltávolítja magát, a csomópont ismételt kezeléséhez az admin jelszó kell.';

  @override
  String get accessControl_unknownKeyNote =>
      'Nincs a kapcsolatai között. A szerepkör módosításához újabb csomópont-firmware kell; az eltávolítás mindig működik.';

  @override
  String get accessControl_prefixUnsupported =>
      'A csomópont firmware-je nem tudja módosítani olyan valaki szerepkörét, aki nincs a kapcsolatai között. Eltávolítani továbbra is lehet.';

  @override
  String get accessControl_empty => 'A hozzáférési lista üres';

  @override
  String get accessControl_emptyHint =>
      'Adjon hozzá embereket, hogy jelszó nélkül bejelentkezhessenek.';

  @override
  String get accessControl_loading =>
      'Hozzáférési lista lekérése a csomóponttól…';

  @override
  String get accessControl_timeout =>
      'A csomópont nem válaszolt. Ellenőrizze az útvonalat, és próbálja újra.';

  @override
  String get accessControl_maybeIncomplete =>
      'A csomópont egy teljes oldalt küldött, és a firmware-je többet nem tud küldeni, ezért egyes bejegyzések hiányozhatnak.';

  @override
  String get accessControl_saved => 'Hozzáférési lista frissítve';

  @override
  String accessControl_failed(String reply) {
    return 'A csomópont elutasította a módosítást: $reply';
  }

  @override
  String get companionCli_title => 'Parancssor';

  @override
  String get companionCli_tileSubtitle => 'Parancsok futtatása a rádión';

  @override
  String get companionCli_warning =>
      'A parancsok a csatlakoztatott rádión futnak, és módosíthatják a beállításait vagy újraindíthatják.';

  @override
  String get companionCli_hint => 'Írjon be egy parancsot, pl. ver';

  @override
  String get companionCli_send => 'Parancs futtatása';

  @override
  String get companionCli_noReply =>
      'Nincs válasz. Lehet, hogy a rádió újraindul.';

  @override
  String get companionCli_empty =>
      'Próbálja ki a fenti parancsok egyikét, vagy írjon sajátot.';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle =>
      'Csatlakoztassa a rádiót egy Wi‑Fi-hálózathoz';

  @override
  String get wifi_unsupported => 'A rádió firmware-je nem tartalmaz Wi‑Fit.';

  @override
  String get wifi_enabled => 'Wi‑Fi használata';

  @override
  String get wifi_status => 'Állapot';

  @override
  String get wifi_connected => 'Csatlakoztatva';

  @override
  String wifi_connectedIp(String ip) {
    return 'Csatlakoztatva · $ip';
  }

  @override
  String get wifi_disconnected => 'Nincs csatlakoztatva';

  @override
  String get wifi_network => 'Hálózat neve (SSID)';

  @override
  String get wifi_password => 'Jelszó';

  @override
  String get wifi_passwordKeep =>
      'Hagyja üresen a jelenlegi jelszó megtartásához';

  @override
  String get wifi_save => 'Mentés';

  @override
  String get wifi_forget => 'Hálózat elfelejtése';

  @override
  String get wifi_forgetConfirm =>
      'Eltávolítja a mentett hálózatot és jelszót a rádióról?';

  @override
  String get wifi_rebootNeeded =>
      'Mentve. Indítsa újra a rádiót a Wi‑Fi-módosítások alkalmazásához.';

  @override
  String get wifi_rebootNow => 'Rádió újraindítása';

  @override
  String get wifi_rebootConfirm =>
      'Újraindítja most a rádiót? Az alkalmazás leválik, és újra csatlakoznia kell.';

  @override
  String get wifi_loadFailed =>
      'Nem sikerült beolvasni a Wi‑Fi-beállításokat a rádióról.';

  @override
  String get wifi_retry => 'Próbálja újra';

  @override
  String wifi_saveFailed(String reply) {
    return 'A rádió nem fogadta el a módosítást: $reply';
  }

  @override
  String get accessControl_refresh => 'Frissítés';

  @override
  String get common_cancel => 'Mégsem';

  @override
  String get common_ok => 'RENDBEN';

  @override
  String get common_connect => 'Csatlakozás';

  @override
  String get common_unknownDevice => 'Ismeretlen eszköz';

  @override
  String get common_save => 'Megtakarítás';

  @override
  String get common_delete => 'Töröl';

  @override
  String get common_deleteAll => 'Összes törlése';

  @override
  String get common_close => 'Közeli';

  @override
  String get common_done => 'Kész';

  @override
  String get common_edit => 'Szerkesztés';

  @override
  String get common_add => 'Hozzáadás';

  @override
  String get common_settings => 'Beállítások elemre';

  @override
  String get common_disconnect => 'Leválasztás';

  @override
  String get common_connected => 'Csatlakozva';

  @override
  String get common_disconnected => 'Szétkapcsolt';

  @override
  String get common_create => 'Teremt';

  @override
  String get common_continue => 'Folytatás';

  @override
  String get common_share => 'Részesedés';

  @override
  String get common_copy => 'Másolat';

  @override
  String get common_retry => 'Próbálja újra';

  @override
  String get common_hide => 'Elrejt';

  @override
  String get common_remove => 'Távolítsa el';

  @override
  String get common_enable => 'Engedélyezés';

  @override
  String get common_disable => 'Letiltás';

  @override
  String get common_undo => 'Visszavonás';

  @override
  String get messageStatus_sent => 'Küldött';

  @override
  String get messageStatus_delivered => 'Szállítva';

  @override
  String get messageStatus_pending => 'Küldés';

  @override
  String get messageStatus_failed => 'Nem sikerült elküldeni';

  @override
  String get messageStatus_repeated => '– ismételte Heard';

  @override
  String get urlImage_enable => 'URL-képek engedélyezése';

  @override
  String get urlImage_possible =>
      'Lehetséges URL-kép; engedélyezze a Beállításokban.';

  @override
  String get common_reboot => 'Indítsa újra';

  @override
  String get common_loading => 'Terhelés...';

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
  String get common_autoRefresh => 'Automatikus frissítés';

  @override
  String get common_interval => 'Intervallum';

  @override
  String get scanner_title => 'NOTORYX Core';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'Csatlakozzon TCP-n keresztül';

  @override
  String get tcpHostLabel => 'Végpont';

  @override
  String get tcpHostHint => '192.168.40.10 / example.com';

  @override
  String get tcpPortLabel => 'Kikötő';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => 'Adja meg a végpontot, és csatlakozzon';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return 'Csatlakozás a következőhöz: $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => 'Házigazda szükséges.';

  @override
  String get tcpErrorPortInvalid => 'A portnak 1 és 65535 között kell lennie.';

  @override
  String get tcpErrorUnsupported =>
      'A TCP-átvitel nem támogatott ezen a platformon.';

  @override
  String get tcpErrorTimedOut => 'A TCP-kapcsolat időtúllépése lejárt.';

  @override
  String tcpConnectionFailed(String error) {
    return 'A TCP-kapcsolat sikertelen: $error';
  }

  @override
  String get usbScreenTitle => 'Csatlakoztassa USB-n keresztül';

  @override
  String get usbScreenSubtitle =>
      'Válasszon egy észlelt soros eszközt, és csatlakozzon közvetlenül a MeshCore csomóponthoz.';

  @override
  String get usbScreenStatus => 'Válasszon ki egy USB-eszközt';

  @override
  String get usbScreenNote =>
      'Az USB-soros aktív a támogatott Android-eszközökön és asztali platformokon.';

  @override
  String get usbScreenEmptyState =>
      'Nem található USB-eszköz. Csatlakoztasson egyet, és frissítse.';

  @override
  String get usbErrorPermissionDenied => 'Az USB-engedély megtagadva.';

  @override
  String get usbErrorDeviceMissing =>
      'A kiválasztott USB-eszköz már nem érhető el.';

  @override
  String get usbErrorInvalidPort => 'Válasszon ki egy érvényes USB-eszközt.';

  @override
  String get usbErrorBusy =>
      'Egy másik USB-csatlakozási kérelem már folyamatban van.';

  @override
  String get usbErrorNotConnected => 'Nincs USB-eszköz csatlakoztatva.';

  @override
  String get usbErrorOpenFailed =>
      'Nem sikerült megnyitni a kiválasztott USB-eszközt.';

  @override
  String get usbErrorConnectFailed =>
      'Nem sikerült csatlakozni a kiválasztott USB-eszközhöz.';

  @override
  String get usbErrorUnsupported =>
      'Az USB-soros nem támogatott ezen a platformon.';

  @override
  String get usbErrorAlreadyActive => 'Az USB-kapcsolat már aktív.';

  @override
  String get usbErrorNoDeviceSelected => 'Nem lett kiválasztva USB-eszköz.';

  @override
  String get usbErrorPortClosed => 'Az USB-csatlakozás nincs nyitva.';

  @override
  String get usbErrorConnectTimedOut =>
      'A kapcsolat időtúllépése lejárt. Győződjön meg arról, hogy az eszköz rendelkezik USB Companion firmware-rel.';

  @override
  String get usbFallbackDeviceName => 'Web soros eszköz';

  @override
  String get usbStatus_notConnected => 'Válasszon ki egy USB-eszközt';

  @override
  String get usbStatus_connecting => 'Csatlakozás USB-eszközhöz...';

  @override
  String get usbStatus_searching => 'USB-eszközök keresése...';

  @override
  String usbConnectionFailed(String error) {
    return 'USB csatlakozás sikertelen: $error';
  }

  @override
  String get scanner_scanning => 'Eszközök keresése...';

  @override
  String get scanner_connecting => 'Csatlakozás...';

  @override
  String get scanner_disconnecting => 'Leválasztás...';

  @override
  String get scanner_notConnected => 'Nincs csatlakoztatva';

  @override
  String scanner_connectedTo(String deviceName) {
    return 'Csatlakozva a következőhöz: $deviceName';
  }

  @override
  String get scanner_searchingDevices => 'MeshCore eszközök keresése...';

  @override
  String get scanner_tapToScan =>
      'Koppintson a Scan elemre a MeshCore-eszközök megkereséséhez';

  @override
  String scanner_connectionFailed(String error) {
    return 'A csatlakozás sikertelen: $error';
  }

  @override
  String get scanner_stop => 'Stop';

  @override
  String get scanner_scan => 'Letapogatás';

  @override
  String get scanner_bluetoothOff => 'Bluetooth ki van kapcsolva';

  @override
  String get scanner_bluetoothOffMessage =>
      'Kérjük, kapcsolja be a Bluetooth-t az eszközök kereséséhez';

  @override
  String get scanner_chromeRequired => 'Chrome böngésző szükséges';

  @override
  String get scanner_chromeRequiredMessage =>
      'Ehhez a webes alkalmazáshoz Google Chrome vagy Chromium-alapú böngésző szükséges a Bluetooth támogatásához.';

  @override
  String get scanner_enableBluetooth => 'Bluetooth engedélyezése';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'A Bluetooth nem érhető el a böngészőben. Inkább csatlakoztasson USB-n keresztül.';

  @override
  String get device_quickSwitch => 'Gyors váltás';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => 'Beállítások elemre';

  @override
  String get settings_deviceInfo => 'Készülék Info';

  @override
  String get settings_appSettings => 'Alkalmazásbeállítások';

  @override
  String get settings_appSettingsSubtitle =>
      'Értesítések, üzenetküldés és térképbeállítások';

  @override
  String get settings_nodeSettings => 'Csomópont beállításai';

  @override
  String get settings_nodeName => 'Csomópont neve';

  @override
  String get settings_nodeNameNotSet => 'Nincs beállítva';

  @override
  String get settings_nodeNameHint => 'Írja be a csomópont nevét';

  @override
  String get settings_nodeNameUpdated => 'Név frissítve';

  @override
  String get settings_radioSettings => 'Rádióbeállítások';

  @override
  String get settings_radioSettingsSubtitle =>
      'Frekvencia, teljesítmény, szórási tényező';

  @override
  String get settings_radioSettingsUpdated => 'A rádió beállításai frissítve';

  @override
  String get settings_regionSettings => 'Tájak';

  @override
  String get settings_regionSettingsSubtitle =>
      'Kincstani megjelenítette gyakorlatos területeket';

  @override
  String get settings_corridorRegion => 'Folyosórégió';

  @override
  String get settings_corridorRegionDefault => '#corridor (alapértelmezett)';

  @override
  String get settings_corridorRegionHelp =>
      'A flood folyosó csomagjai ezzel a régióval vannak megjelölve. A folyosó-firmware nélküli ismétlők csak akkor továbbítják őket, ha engedélyezik ezt a régiót. Hagyja üresen az alapértelmezett #corridor címkéhez.';

  @override
  String get settings_corridorRegionHint => 'Régió neve';

  @override
  String get settings_corridorRegionUseDefault => 'Alapértelmezett használata';

  @override
  String get settings_corridorRegionUpdated => 'Folyosórégió frissítve';

  @override
  String get settings_corridorRegionFailed =>
      'Nem sikerült frissíteni a folyosórégiót';

  @override
  String get settings_regionManagement_screenTitle => 'Regionális Kezelés';

  @override
  String get settings_regionNameHint => 'Felhasználja a regioni név';

  @override
  String get settings_regionAddRegion => 'Egyes region';

  @override
  String get settings_regionFetchRegions => 'Féregelmezők a repeaterekból';

  @override
  String get settings_regionFetchRegionsFail => 'Nem található egyéb területek';

  @override
  String get settings_regionFetchRegionsAlreadyExists =>
      'Ez a terítet nemisértették meg.';

  @override
  String get settings_regionName => 'Feldúr Neve';

  @override
  String get settings_regionDeleted => 'Felült region';

  @override
  String get settings_deleteRegion => 'Felajánlatos Tér';

  @override
  String settings_deleteRegionConfirm(String region) {
    return 'Kell kiszámítsd a ${region}ot a részekre?';
  }

  @override
  String get settings_location => 'hely';

  @override
  String get settings_locationSubtitle => 'GPS koordináták';

  @override
  String get settings_locationUpdated => 'A hely- és GPS-beállítások frissítve';

  @override
  String get settings_locationBothRequired =>
      'Adja meg a szélességi és hosszúsági fokokat is.';

  @override
  String get settings_locationInvalid =>
      'Érvénytelen szélesség vagy hosszúság.';

  @override
  String get settings_locationGPSEnable => 'GPS engedélyezése';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'Lehetővé teszi a GPS számára a hely automatikus frissítését.';

  @override
  String get settings_locationIntervalSec => 'GPS intervallum (másodperc)';

  @override
  String get settings_locationIntervalInvalid =>
      'Az intervallumnak legalább 60 másodpercnek kell lennie, és kevesebbnek kell lennie 86 400 másodpercnél.';

  @override
  String get settings_latitude => 'Szélesség';

  @override
  String get settings_longitude => 'Hosszúság';

  @override
  String get settings_contactSettings => 'Kapcsolati beállítások';

  @override
  String get settings_contactSettingsSubtitle =>
      'A névjegyek hozzáadásának beállításai.';

  @override
  String get settings_privacyMode => 'Adatvédelmi mód';

  @override
  String get settings_privacyModeSubtitle =>
      'Név/hely elrejtése a hirdetésekben';

  @override
  String get settings_privacyModeToggle =>
      'Kapcsolja be az adatvédelmi módot, hogy elrejtse nevét és tartózkodási helyét a hirdetésekben.';

  @override
  String get settings_privacyModeEnabled => 'Az adatvédelmi mód engedélyezve';

  @override
  String get settings_privacyModeDisabled => 'Az adatvédelmi mód letiltva';

  @override
  String get settings_privacy => 'Adatvédelmi beállítások';

  @override
  String get settings_privacySubtitle =>
      'Szabályozza, hogy milyen információkat osztanak meg.';

  @override
  String get settings_privacySettingsDescription =>
      'Válassza ki, hogy eszköze milyen információkat ossza meg másokkal.';

  @override
  String get settings_denyAll => 'Mindent tagadni';

  @override
  String get settings_allowByContact => 'Engedélyezés kapcsolatjelző jelzőkkel';

  @override
  String get settings_allowAll => 'Minden engedélyezése';

  @override
  String get settings_telemetryBaseMode => 'Telemetriai alapmód';

  @override
  String get settings_telemetryLocationMode =>
      'Telemetriás helymeghatározási mód';

  @override
  String get settings_telemetryEnvironmentMode => 'Telemetriás környezeti mód';

  @override
  String get settings_advertLocation => 'Hirdetés helye';

  @override
  String get settings_advertLocationSubtitle =>
      'A hirdetésben szerepeljen a helyszín.';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'Automatikus zero-hop hirdetés GPS-frissítéskor';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'Ha a GPS-helyzet megváltozik, küldjön zero-hop hirdetést (a hirdetésben helymegadás szükséges).';

  @override
  String get settings_multiAck => 'Multi-ACK';

  @override
  String get settings_telemetryModeUpdated => 'Telemetriai mód frissítve';

  @override
  String get settings_actions => 'Akciók';

  @override
  String get settings_deleteAllPaths => 'Az összes elérési út törlése';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Törölje az összes elérési utat a névjegyekből.';

  @override
  String get settings_sendAdvertisement => 'Hirdetés küldése';

  @override
  String get settings_sendAdvertisementSubtitle =>
      'Jelenlét a közvetítésben most';

  @override
  String get settings_advertisementSent => 'Reklám elküldve';

  @override
  String get settings_syncTime => 'Szinkronizálási idő';

  @override
  String get settings_syncTimeSubtitle =>
      'Az eszköz órájának beállítása a telefon idejére';

  @override
  String get settings_timeSynchronized => 'Idő szinkronizálva';

  @override
  String get settings_refreshContacts => 'Névjegyek frissítése';

  @override
  String get settings_refreshContactsSubtitle =>
      'Névjegylista újratöltése az eszközről';

  @override
  String get settings_rebootDevice => 'Eszköz újraindítása';

  @override
  String get settings_rebootDeviceSubtitle => 'Indítsa újra a MeshCore eszközt';

  @override
  String get settings_rebootDeviceConfirm =>
      'Biztosan újra akarja indítani az eszközt? Megszakad a kapcsolat.';

  @override
  String get settings_debug => 'Hibakeresés';

  @override
  String get settings_companionDebugLog => 'Companion Debug Log';

  @override
  String get settings_companionDebugLogSubtitle =>
      'BLE/TCP/USB parancsok, válaszok és nyers adatok';

  @override
  String get settings_appDebugLog => 'Alkalmazás hibakeresési naplója';

  @override
  String get settings_appDebugLogSubtitle => 'Alkalmazás hibakeresési üzenetei';

  @override
  String get settings_about => 'Körülbelül';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core v$version';
  }

  @override
  String get settings_aboutLegalese => '2026 MeshCore nyílt forráskódú projekt';

  @override
  String get settings_aboutDescription =>
      'Nyílt forráskódú Flutter kliens MeshCore LoRa mesh hálózati eszközökhöz.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'LOS magassági adatok: Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => 'Név';

  @override
  String get settings_infoId => 'ID';

  @override
  String get settings_infoStatus => 'Állapot';

  @override
  String get settings_infoBattery => 'Akkumulátor';

  @override
  String get settings_infoPublicKey => 'Nyilvános kulcs';

  @override
  String get settings_infoContactsCount => 'Névjegyek száma';

  @override
  String get settings_infoChannelCount => 'Csatornaszám';

  @override
  String get settings_infoHardware => 'Hardverő';

  @override
  String get settings_infoFirmware => 'Firmver';

  @override
  String get settings_presets => 'Előbeállítások';

  @override
  String get settings_frequency => 'Frekvencia (MHz)';

  @override
  String get settings_frequencyHelper => '300,0 - 2500,0';

  @override
  String get settings_frequencyInvalid =>
      'Érvénytelen frekvencia (300-2500 MHz)';

  @override
  String get settings_bandwidth => 'Sávszélesség';

  @override
  String get settings_spreadingFactor => 'Spreading Factor';

  @override
  String get settings_codingRate => 'Kódolási sebesség';

  @override
  String get settings_txPower => 'TX teljesítmény (dBm)';

  @override
  String get settings_txPowerHelper => '0-22';

  @override
  String get settings_txPowerInvalid =>
      'Érvénytelen TX teljesítmény (0-22 dBm)';

  @override
  String get settings_clientRepeat => 'Hálózaton kívüli ismétlés';

  @override
  String get settings_clientRepeatSubtitle =>
      'Engedélyezze az eszköznek, hogy megismételje a mesh-csomagokat mások számára';

  @override
  String get settings_clientRepeatFreqWarning =>
      'A hálózaton kívüli ismétlés 433, 869 vagy 918 MHz frekvenciát igényel';

  @override
  String settings_error(String message) {
    return 'Hiba: $message';
  }

  @override
  String get appSettings_title => 'Alkalmazásbeállítások';

  @override
  String get appSettings_appearance => 'Megjelenés';

  @override
  String get appSettings_theme => 'Téma';

  @override
  String get appSettings_themeSystem => 'Rendszer alapértelmezett';

  @override
  String get appSettings_themeLight => 'Fény';

  @override
  String get appSettings_themeDark => 'Sötét';

  @override
  String get appSettings_language => 'Nyelv';

  @override
  String get appSettings_languageSystem => 'Rendszer alapértelmezett';

  @override
  String get appSettings_languageEn => 'angol';

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
  String get repeater_pathHashModeOption1 => '1 - 2 szavak';

  @override
  String get repeater_pathHashModeOption2 => '2 - 3 bajt';

  @override
  String get repeater_pathHashModeOption3 => '3 - 4 bajt';

  @override
  String get appSettings_enableMessageTracing => 'Üzenetkövetés engedélyezése';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'Az üzenetek részletes útválasztási és időzítési metaadatainak megjelenítése';

  @override
  String get appSettings_notifications => 'Értesítések';

  @override
  String get appSettings_enableNotifications => 'Értesítések engedélyezése';

  @override
  String get appSettings_enableNotificationsSubtitle =>
      'Értesítések fogadása üzenetekről és hirdetésekről';

  @override
  String get appSettings_notificationPermissionDenied =>
      'Értesítési engedély megtagadva';

  @override
  String get appSettings_notificationsEnabled => 'Értesítések engedélyezve';

  @override
  String get appSettings_notificationsDisabled => 'Az értesítések letiltva';

  @override
  String get appSettings_messageNotifications => 'Üzenetértesítések';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      'Értesítés megjelenítése új üzenetek fogadásakor';

  @override
  String get appSettings_channelMessageNotifications =>
      'Csatorna üzenetek értesítései';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'Értesítés megjelenítése csatornaüzenetek fogadásakor';

  @override
  String get appSettings_advertisementNotifications => 'Reklám Értesítések';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      'Értesítés megjelenítése új csomópontok felfedezésekor';

  @override
  String get appSettings_messaging => 'Üzenetküldés';

  @override
  String get appSettings_clearPathOnMaxRetry =>
      'Útvonal törlése a Max. újrapróbálkozásnál';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      'Állítsa vissza a kapcsolati elérési utat 5 sikertelen küldési kísérlet után';

  @override
  String get appSettings_pathsWillBeCleared =>
      'Az elérési utak 5 sikertelen újrapróbálkozás után törlődnek';

  @override
  String get appSettings_pathsWillNotBeCleared =>
      'Az útvonalak nem törlődnek automatikusan';

  @override
  String get appSettings_autoRouteRotation => 'Auto Route Rotation';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      'Váltson a legjobb útvonalak és az elárasztási mód között';

  @override
  String get appSettings_autoRouteRotationEnabled =>
      'Az automatikus útvonalforgatás engedélyezve';

  @override
  String get appSettings_autoRouteRotationDisabled =>
      'Az automatikus útvonalforgatás letiltva';

  @override
  String get appSettings_maxRouteWeight => 'Maximális útvonalsúly';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      'Maximális súly, amelyet egy útvonal felhalmozhat a sikeres szállításokból';

  @override
  String get appSettings_initialRouteWeight => 'Az útvonal kezdeti súlya';

  @override
  String get appSettings_initialRouteWeightSubtitle =>
      'Kezdősúly az újonnan felfedezett utakhoz';

  @override
  String get appSettings_routeWeightSuccessIncrement => 'Siker súlynövekedés';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      'Súly hozzáadva egy útvonalhoz a sikeres szállítás után';

  @override
  String get appSettings_routeWeightFailureDecrement => 'Hiba súlycsökkentés';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      'Sikertelen szállítás után eltávolított súly az útvonalról';

  @override
  String get appSettings_maxMessageRetries =>
      'Üzenet újrapróbálkozások maximális száma';

  @override
  String get appSettings_maxMessageRetriesSubtitle =>
      'Az üzenet sikertelenként való megjelölése előtti újrapróbálkozások száma';

  @override
  String get appSettings_battery => 'Akkumulátor';

  @override
  String get appSettings_batteryChemistry => 'Akkumulátor kémia';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return 'Beállítás eszközenként ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      'A választáshoz csatlakozzon egy eszközhöz';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3,0-4,2 V)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2,6-3,65 V)';

  @override
  String get appSettings_batteryLipo => 'LiPo (3,0-4,2 V)';

  @override
  String get appSettings_batteryLipoHv => 'LiPo HV (3.0-4.35V)';

  @override
  String get appSettings_mapDisplay => 'Térkép megjelenítése';

  @override
  String get appSettings_showRepeaters => 'Ismétlők megjelenítése';

  @override
  String get appSettings_showRepeatersSubtitle =>
      'Az átjátszó csomópontok megjelenítése a térképen';

  @override
  String get appSettings_showChatNodes => 'Chat csomópontok megjelenítése';

  @override
  String get appSettings_showChatNodesSubtitle =>
      'A csevegési csomópontok megjelenítése a térképen';

  @override
  String get appSettings_showOtherNodes => 'Más csomópontok megjelenítése';

  @override
  String get appSettings_showOtherNodesSubtitle =>
      'Más csomóponttípusok megjelenítése a térképen';

  @override
  String get appSettings_timeFilter => 'Időszűrő';

  @override
  String get appSettings_timeFilterShowAll =>
      'Az összes csomópont megjelenítése';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return 'Az elmúlt $hours óra csomópontjainak megjelenítése';
  }

  @override
  String get appSettings_mapTimeFilter => 'Térkép időszűrő';

  @override
  String get appSettings_showNodesDiscoveredWithin =>
      'Itt talált csomópontok megjelenítése:';

  @override
  String get appSettings_allTime => 'Minden alkalommal';

  @override
  String get appSettings_lastHour => 'Utolsó óra';

  @override
  String get appSettings_last6Hours => 'Utolsó 6 óra';

  @override
  String get appSettings_last24Hours => 'Az elmúlt 24 óra';

  @override
  String get appSettings_lastWeek => 'Múlt héten';

  @override
  String get appSettings_rasterTileSource => 'Raszteres csempeforrás';

  @override
  String get appSettings_stadiaEndpoint => 'Stadia végpont';

  @override
  String get appSettings_stadiaApiKey => 'Stadia API-kulcs';

  @override
  String get appSettings_stadiaApiKeyRequired =>
      'A Stadia Maps használatához kötelező';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return 'Konfigurálva: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Adja meg a Stadia Maps API-kulcsát. Az alkalmazás ezt használja raszteres csempekérésekhez.';

  @override
  String get appSettings_offlineMapCache => 'Offline térképgyorsítótár';

  @override
  String get appSettings_unitsTitle => 'Egységek';

  @override
  String get appSettings_unitsMetric => 'Metrikus (m/km/°C)';

  @override
  String get appSettings_unitsImperial => 'birodalmi (ft/mi/°F)';

  @override
  String get appSettings_noAreaSelected => 'Nincs kiválasztott terület';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'Kijelölt terület (nagyítás $minZoom-$maxZoom)';
  }

  @override
  String get appSettings_debugCard => 'Hibakeresés';

  @override
  String get appSettings_appDebugLogging =>
      'Alkalmazások hibakeresési naplózása';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'A hibaelhárításhoz naplózza az alkalmazás hibakeresési üzeneteit';

  @override
  String get appSettings_appDebugLoggingEnabled =>
      'Alkalmazások hibakeresési naplózása engedélyezve';

  @override
  String get appSettings_appDebugLoggingDisabled =>
      'Az alkalmazáshibakeresési naplózás letiltva';

  @override
  String get contacts_title => 'Kapcsolatok';

  @override
  String get contacts_noContacts => 'Még nincsenek elérhetőségek';

  @override
  String get contacts_contactsWillAppear =>
      'A névjegyek akkor jelennek meg, amikor az eszközök hirdetnek';

  @override
  String get contacts_unread => 'Nem olvasott';

  @override
  String get contacts_searchContactsNoNumber => 'Névjegyek keresése...';

  @override
  String contacts_searchContacts(int number, String str) {
    return 'Keresés a $number$str névjegyekben...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'Keresés a $number$str Kedvencek között...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'Keresés a $number$str felhasználók között...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'Keresés a $number$str átjátszók között...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'Keresés a $number$str szobaszervereken...';
  }

  @override
  String get contacts_noUnreadContacts => 'Nincsenek olvasatlan névjegyek';

  @override
  String get contacts_noContactsFound => 'Nem található névjegy vagy csoport';

  @override
  String get contacts_deleteContact => 'Névjegy törlése';

  @override
  String contacts_removeConfirm(String contactName) {
    return 'Eltávolítja a $contactName alkalmazást a névjegyek közül?';
  }

  @override
  String get contacts_manageRepeater => 'Repeater kezelése';

  @override
  String get contacts_manageRoom => 'Szobaszerver kezelése';

  @override
  String get contacts_roomLogin => 'Szobaszerver bejelentkezés';

  @override
  String get contacts_openChat => 'Nyissa meg a Chat lehetőséget';

  @override
  String get contacts_editGroup => 'Csoport szerkesztése';

  @override
  String get contacts_deleteGroup => 'Csoport törlése';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return 'Eltávolítja a következőt: \"$groupName\"?';
  }

  @override
  String get contacts_newGroup => 'Új csoport';

  @override
  String get contacts_moreOptions => 'További lehetőségek';

  @override
  String get contacts_searchOpen => 'Névjegyek keresése';

  @override
  String get contacts_searchClose => 'Keresés bezárása';

  @override
  String get contacts_groupName => 'Csoport neve';

  @override
  String get contacts_groupNameRequired => 'A csoportnév megadása kötelező';

  @override
  String get contacts_groupNameReserved => 'Ez a csoportnév fenntartva';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'A \"$name\" csoport már létezik';
  }

  @override
  String get contacts_filterContacts => 'Névjegyek szűrése...';

  @override
  String get contacts_noContactsMatchFilter =>
      'Egyetlen névjegy sem felel meg a szűrőnek';

  @override
  String get contacts_noMembers => 'Nincsenek tagok';

  @override
  String get contacts_lastSeenNow => 'nemrég';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return '~ $minutes min.';
  }

  @override
  String get contacts_lastSeenHourAgo => '~ 1 óra';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return '~ $hours óra';
  }

  @override
  String get contacts_lastSeenDayAgo => '~ 1 nap';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return '~ $days nap';
  }

  @override
  String get contact_info => 'Elérhetőségi adatok';

  @override
  String get contact_settings => 'Kapcsolati beállítások';

  @override
  String get contact_telemetry => 'Telemetria';

  @override
  String get contact_lastSeen => 'Utoljára látott';

  @override
  String get contact_clearChat => 'Csevegés törlése';

  @override
  String get contact_teleBase => 'Telemetriai bázis';

  @override
  String get contact_teleBaseSubtitle =>
      'Az akkumulátor töltöttségi szintjének és az alapvető telemetria megosztásának engedélyezése';

  @override
  String get contact_teleLoc => 'Telemetriás hely';

  @override
  String get contact_teleLocSubtitle =>
      'Helyadatok megosztásának engedélyezése';

  @override
  String get contact_teleEnv => 'Telemetriai környezet';

  @override
  String get contact_teleEnvSubtitle =>
      'A környezetérzékelő adatainak megosztásának engedélyezése';

  @override
  String get channels_title => 'Csatornák';

  @override
  String get channels_noChannelsConfigured =>
      'Nincsenek konfigurálva csatornák';

  @override
  String get channels_addPublicChannel => 'Nyilvános csatorna hozzáadása';

  @override
  String get channels_searchChannels => 'Csatornák keresése...';

  @override
  String get channels_noChannelsFound => 'Nem található csatorna';

  @override
  String channels_channelIndex(int index) {
    return 'Csatorna $index';
  }

  @override
  String get channels_public => 'Nyilvános';

  @override
  String channels_via(String path) {
    return 'ezen keresztül: $path';
  }

  @override
  String get channels_viaMqtt => 'MQTT-n át';

  @override
  String get channels_viaMqttSemantics =>
      'MQTT-n keresztül érkezett, a rádiója nem hallotta';

  @override
  String get channels_private => 'Magán';

  @override
  String get channels_editChannel => 'Csatorna szerkesztése';

  @override
  String get channels_muteChannel => 'Csatorna némítása';

  @override
  String get channels_unmuteChannel => 'Csatorna némításának feloldása';

  @override
  String get channels_deleteChannel => 'Csatorna törlése';

  @override
  String channels_deleteChannelConfirm(String name) {
    return 'Törli a következőt: \"$name\"? Ezt nem lehet visszavonni.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'Nem sikerült törölni a \"$name\" csatornát';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'A \"$name\" csatorna törölve';
  }

  @override
  String get channels_addChannel => 'Csatorna hozzáadása lehetőségre';

  @override
  String get channels_channelIndexLabel => 'Csatorna indexe';

  @override
  String get channels_channelName => 'Csatorna neve';

  @override
  String get channels_usePublicChannel => 'Nyilvános csatorna használata';

  @override
  String get channels_standardPublicPsk => 'Normál nyilvános PSK';

  @override
  String get channels_pskHex => 'PSK (Hex)';

  @override
  String get channels_generateRandomPsk => 'Véletlenszerű PSK generálása';

  @override
  String get channels_enterChannelName => 'Kérjük, adja meg a csatorna nevét';

  @override
  String get channels_pskMustBe32Hex =>
      'A PSK-nak 32 hexadecimális karakterből kell állnia';

  @override
  String channels_channelAdded(String name) {
    return 'A \"$name\" csatorna hozzáadva';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'Csatorna szerkesztése $index';
  }

  @override
  String get channels_smazCompression => 'SMAZ tömörítés';

  @override
  String get channels_cyr2latCompression => 'Cyr2Lat tömörítés';

  @override
  String get channels_cyr2latCompressionDscr =>
      'Küldéskor egyes cirill karaktereket latin karakterekre cserél.';

  @override
  String get channels_cyr2latSettingsHeading => 'Cyr2Lat beállítás';

  @override
  String get channels_cyr2latSettingsSubheading => 'A helyettesítők listája';

  @override
  String get channels_cyr2latSettingsDscr =>
      'Szerkessze a karaktercsere JSON-konfigurációját';

  @override
  String get channels_cyr2latSettingsDialogHint => 'JSON cseretérkép';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'Érvénytelen JSON: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'A \"$name\" csatorna frissítve';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Cyr2Lat profil hozzáadása';

  @override
  String get settings_cyr2latProfileName => 'Profil neve';

  @override
  String get settings_cyr2latProfileNameEmpty => 'A profilnév nem lehet üres';

  @override
  String get settings_cyr2latProfileAdded => 'A profil sikeresen hozzáadva';

  @override
  String get settings_cyr2latProfileUpdated => 'A profil sikeresen frissítve';

  @override
  String get settings_cyr2latProfileEdit => 'Szerkessze a Cyr2Lat profilt';

  @override
  String get settings_cyr2latProfileDelete => 'Cyr2Lat profil törlése';

  @override
  String get settings_cyr2latProfileDeleted => 'A profil sikeresen törölve';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return 'Biztos benne, hogy törölni kívánja a(z) \"$name\" profilt?';
  }

  @override
  String get channels_publicChannelAdded => 'Nyilvános csatorna hozzáadva';

  @override
  String get channels_sortBy => 'Rendezés';

  @override
  String get channels_sortManual => 'Kézikönyv';

  @override
  String get channels_sortAZ => 'A-Z';

  @override
  String get channels_sortLatestMessages => 'Legújabb üzenetek';

  @override
  String get channels_sortUnread => 'Nem olvasott';

  @override
  String get channels_createPrivateChannel =>
      'Hozzon létre egy privát csatornát';

  @override
  String get channels_createPrivateChannelDesc => 'Titkos kulccsal biztosítva.';

  @override
  String get channels_joinPrivateChannel => 'Csatlakozz egy privát csatornához';

  @override
  String get channels_joinPrivateChannelDesc =>
      'Adjon meg kézzel egy titkos kulcsot.';

  @override
  String get channels_joinPublicChannel =>
      'Csatlakozzon a nyilvános csatornához';

  @override
  String get channels_joinPublicChannelDesc =>
      'Bárki csatlakozhat ehhez a csatornához.';

  @override
  String get channels_joinHashtagChannel =>
      'Csatlakozz egy Hashtag csatornához';

  @override
  String get channels_joinHashtagChannelDesc =>
      'Bárki csatlakozhat a hashtag csatornákhoz.';

  @override
  String get channels_scanQrCode => 'QR-kód beolvasása';

  @override
  String get channels_scanQrCodeComingSoon => 'Hamarosan';

  @override
  String get channels_enterHashtag => 'Írja be a hashtaget';

  @override
  String get channels_hashtagHint => 'például #csapat';

  @override
  String channels_regionSetTo(String region) {
    return 'Tájékoztatás: A $region -t\n\nEz a tájékoztatás a magyar nyelvben a következően kell szóva:\n\nTájékoztatás: A $region -t';
  }

  @override
  String get channels_regionNotSet => 'Tájékoztetés: nem';

  @override
  String get channels_regionSelect_Title => 'Válassz egy regionot';

  @override
  String get channels_clearRegion => 'Kéres kör';

  @override
  String get chat_noMessages => 'Még nincsenek üzenetek';

  @override
  String get chat_sendMessage => 'Üzenet küldése';

  @override
  String chat_sendMessageTo(String contactName) {
    return 'Üzenet küldése a következő címre: $contactName';
  }

  @override
  String get chat_sendMessageToStart => 'A kezdéshez küldjön üzenetet';

  @override
  String get chat_originalMessageNotFound => 'Az eredeti üzenet nem található';

  @override
  String chat_replyingTo(String name) {
    return 'Válasz erre: $name';
  }

  @override
  String chat_replyTo(String name) {
    return 'Válasz erre: $name';
  }

  @override
  String get chat_location => 'hely';

  @override
  String get chat_typeMessage => 'Írjon be egy üzenetet...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'Az üzenet túl hosszú (max. $maxBytes bájt).';
  }

  @override
  String get chat_messageCopied => 'Üzenet másolva';

  @override
  String get chat_messageDeleted => 'Üzenet törölve';

  @override
  String get chat_retryingMessage => 'Üzenet újrapróbálkozása';

  @override
  String chat_retryCount(int current, int max) {
    return 'Próbálja újra $current/$max';
  }

  @override
  String get chat_selectSendAction => 'Küldési művelet kiválasztása';

  @override
  String get chat_sendGif => 'GIF küldése';

  @override
  String get chat_limitToArea => 'Korlátozás egy területre';

  @override
  String get chat_limitToAreaTitle => 'Küldés csak ezen belül…';

  @override
  String get chat_limitToAreaHelp =>
      'A flood folyosó firmware-rel rendelkező ismétlők csak ezen a területen belül továbbítják az üzenetet. A többi ismétlő eldobja, hacsak nem engedélyezi az Ön folyosórégióját.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '$km km-es körzet';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return 'Csak $km km-en belül';
  }

  @override
  String get chat_limitToAreaOff => 'Nincs korlát';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'Állítsa be a rádió pozícióját, hogy az üzeneteket területre korlátozhassa.';

  @override
  String get chat_sendImageLora => 'Kép küldése MeshCore-on keresztül';

  @override
  String get chat_imagePickFailed => 'Nem tudtam ezt a fenti fényre kapni';

  @override
  String get chat_receivedGif => 'GIF-ot kapott';

  @override
  String get chat_reply => 'Válasz';

  @override
  String get chat_addReaction => 'Reakció hozzáadása';

  @override
  String get chat_me => 'Nekem';

  @override
  String get reaction_report => 'Emoji-reakciók';

  @override
  String get emojiCategorySmileys => 'Hangulatjelek';

  @override
  String get emojiCategoryGestures => 'Gesztusok';

  @override
  String get emojiCategoryHearts => 'Szívek';

  @override
  String get emojiCategoryObjects => 'Objektumok';

  @override
  String get gifPicker_title => 'Válassz egy GIF-et';

  @override
  String get gifPicker_searchHint => 'GIF-ek keresése...';

  @override
  String get gifPicker_poweredBy => 'Üzemeltető: GIPHY';

  @override
  String get gifPicker_noGifsFound => 'Nem található GIF';

  @override
  String get gifPicker_failedLoad => 'Nem sikerült betölteni a GIF-eket';

  @override
  String get gifPicker_failedSearch => 'Nem sikerült a GIF-ek keresése';

  @override
  String get gifPicker_noInternet => 'Nincs internet kapcsolat';

  @override
  String get debugLog_appTitle => 'Alkalmazás hibakeresési naplója';

  @override
  String get debugLog_bleTitle => 'BLE hibakeresési napló';

  @override
  String get debugLog_copyLog => 'Napló másolása';

  @override
  String get debugLog_clearLog => 'Napló törlése';

  @override
  String get debugLog_copied => 'Hibakeresési napló másolva';

  @override
  String get debugLog_bleCopied => 'BLE napló másolva';

  @override
  String get debugLog_noEntries => 'Még nincsenek hibakeresési naplók';

  @override
  String get debugLog_enableInSettings =>
      'Engedélyezze az alkalmazás hibakeresési bejelentkezési beállításait';

  @override
  String get debugLog_frames => 'Keretek';

  @override
  String get debugLog_rawLogRx => 'Nyers Log-RX';

  @override
  String get debugLog_noBleActivity => 'Még nincs BLE tevékenység';

  @override
  String debugFrame_length(int count) {
    return 'Keret hossza: $count bájt';
  }

  @override
  String debugFrame_command(String value) {
    return 'Parancs: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'Szöveges üzenet keret:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- Cél PubKey: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- Időbélyeg: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- Zászlók: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- Szöveg típusa: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'CLI';

  @override
  String get debugFrame_textTypePlain => 'Egyszerű';

  @override
  String debugFrame_text(String text) {
    return '- Szöveg: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => 'Hex dump:';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ugrások',
      one: 'ugrás',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => 'Távolítsa el az útvonalat';

  @override
  String get chat_noPathHistoryYet =>
      'Még nincs úttörténet.\nÜzenet küldése utak felfedezéséhez.';

  @override
  String get chat_pathCleared =>
      'Út megtisztítva. A következő üzenet újra felfedezi az útvonalat.';

  @override
  String get chat_fullPath => 'Teljes útvonal';

  @override
  String get routing_title => 'Útválasztás';

  @override
  String get routing_modeAuto => 'Auto';

  @override
  String get routing_modeFlood => 'Árvíz';

  @override
  String get routing_modeManual => 'Kézikönyv';

  @override
  String get routing_modeAutoHint =>
      'Automatikusan kiválasztja a legismertebb utat, és elárasztja, ha nem ismert.';

  @override
  String get routing_modeFloodHint =>
      'Minden átjátszón keresztül sugároz. A legmegbízhatóbb, de több műsoridőt használ.';

  @override
  String get routing_modeManualHint =>
      'Mindig pontosan az Ön által megadott útvonalon küld.';

  @override
  String get routing_currentRoute => 'Jelenlegi útvonal';

  @override
  String get routing_directNoHops => 'Közvetlen – nincs átjátszó ugrás';

  @override
  String get routing_noPathYet =>
      'Még nincs út. A következő üzenet elárasztja az útvonalat.';

  @override
  String get routing_floodBroadcast => 'Minden átjátszón keresztül sugározd';

  @override
  String get routing_editPath => 'Útvonal szerkesztése';

  @override
  String get routing_forgetPath => 'Felejtsd el az utat';

  @override
  String get routing_knownPaths => 'Ismert utak';

  @override
  String get routing_knownPathsHint =>
      'Koppintson egy elérési útra a váltáshoz.';

  @override
  String get routing_inUse => 'Használatban';

  @override
  String get routing_qualityStrong => 'Erős első ugrás';

  @override
  String get routing_qualityGood => 'Jó első ugrás';

  @override
  String get routing_qualityFair => 'Tisztességes első ugrás';

  @override
  String get routing_qualityWorked => 'Szállított';

  @override
  String get routing_qualityFlood => 'Árvízen keresztül hallatszott';

  @override
  String get routing_qualityUntested => 'Nem tesztelt';

  @override
  String routing_lastWorked(String when) {
    return 'dolgozott $when';
  }

  @override
  String get routing_neverWorked => 'soha nem erősítették meg';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes kézbesítve, $failures sikertelen';
  }

  @override
  String get routing_floodDelivery => 'Árvízi szállítás';

  @override
  String get pathEditor_title => 'Építsd meg az útvonalat';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count 64 ugrásból';
  }

  @override
  String get pathEditor_noHops =>
      'Még nincs ugrás. Koppintson az alábbi ismétlőkre, ha sorrendben szeretné felvenni őket, vagy mentse ugrás nélkül a közvetlen küldéshez.';

  @override
  String get pathEditor_addHops => 'Sorrendben adjuk hozzá a komlót';

  @override
  String get pathEditor_searchRepeaters => 'Ismétlő keresése';

  @override
  String get pathEditor_advancedHex => 'Haladó: nyers hexadecimális útvonal';

  @override
  String get pathEditor_hexLabel => 'Hexadecimális előtagok';

  @override
  String get pathEditor_hexHelper =>
      'Két hexadecimális karakter ugrásonként, vesszővel elválasztva';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return 'Érvénytelen: $tokens';
  }

  @override
  String get pathEditor_tooManyHops => 'Maximum 64 ugrás';

  @override
  String get pathEditor_usePath => 'Használja ezt az utat';

  @override
  String get pathEditor_removeHop => 'Távolítsa el az ugrást';

  @override
  String get pathEditor_unknownHop => 'Ismeretlen átjátszó';

  @override
  String get chat_pathSavedLocally =>
      'Helyben mentve. Csatlakozás a szinkronizáláshoz.';

  @override
  String get chat_pathDeviceConfirmed => 'Az eszköz megerősítve.';

  @override
  String get chat_pathDeviceNotConfirmed => 'Az eszköz még nincs megerősítve.';

  @override
  String get chat_type => 'Írja be';

  @override
  String get chat_path => 'Útvonal';

  @override
  String get chat_publicKey => 'Nyilvános kulcs';

  @override
  String get chat_compressOutgoingMessages => 'A kimenő üzenetek tömörítése';

  @override
  String get chat_floodForced => 'Árvíz (kényszerített)';

  @override
  String get chat_directForced => 'Közvetlen (kényszerített)';

  @override
  String chat_hopsForced(int count) {
    return '$count ugrás (kényszerített)';
  }

  @override
  String get chat_floodAuto => 'Árvíz (automatikus)';

  @override
  String get chat_direct => 'Közvetlen';

  @override
  String get chat_poiShared => 'POI megosztva';

  @override
  String chat_unread(int count) {
    return 'Olvasatlan: $count';
  }

  @override
  String get chat_markAsUnread => 'Megjelölés olvasatlanként';

  @override
  String get chat_newMessages => 'Új üzenetek';

  @override
  String get chat_openLink => 'Link megnyitása?';

  @override
  String get chat_openLinkConfirmation =>
      'Meg akarja nyitni ezt a hivatkozást a böngészőjében?';

  @override
  String get chat_open => 'Nyitott';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'Nem sikerült megnyitni a linket: $url';
  }

  @override
  String get chat_invalidLink => 'Érvénytelen linkformátum';

  @override
  String get map_title => 'Csomópont térkép';

  @override
  String get map_searchHint =>
      'Keresés a csomópont nevében vagy azonosítójában';

  @override
  String get map_activity => 'Tevékenység';

  @override
  String get map_online => 'Online';

  @override
  String get map_recent => 'Legutóbbi';

  @override
  String get map_stale => 'Állott';

  @override
  String get map_visible => 'Látható';

  @override
  String get map_hidden => 'Rejtett';

  @override
  String get map_centerOnNode => 'Középre a csomóponton';

  @override
  String get map_details => 'Részletek';

  @override
  String get map_noGps => 'Nincs GPS';

  @override
  String get map_noResults => 'Nincsenek megfelelő csomópontok';

  @override
  String get map_lineOfSight => 'Látóvonal';

  @override
  String get map_losScreenTitle => 'Látóvonal';

  @override
  String get map_noNodesWithLocation =>
      'Nincsenek helyadatokkal rendelkező csomópontok';

  @override
  String get map_nodesNeedGps =>
      'A csomópontoknak meg kell osztaniuk GPS-koordinátáikat\nhogy megjelenjen a térképen';

  @override
  String map_nodesCount(int count) {
    return 'Csomópontok: $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'Pins: $count';
  }

  @override
  String get map_chat => 'Csevegés';

  @override
  String get map_repeater => 'Ismétlő';

  @override
  String get map_room => 'Szoba';

  @override
  String get map_sensor => 'Érzékelő';

  @override
  String get map_pinDm => 'Pin (DM)';

  @override
  String get map_pinPrivate => 'Pin (privát)';

  @override
  String get map_pinPublic => 'Pin (nyilvános)';

  @override
  String get map_lastSeen => 'Utoljára látott';

  @override
  String get map_disconnectConfirm =>
      'Biztosan le akarja kapcsolni ezt az eszközt?';

  @override
  String get map_from => 'Tól';

  @override
  String get map_source => 'Forrás';

  @override
  String get map_flags => 'Zászlók';

  @override
  String get map_type => 'Írja be';

  @override
  String get map_path => 'Útvonal';

  @override
  String get map_location => 'hely';

  @override
  String get map_estLocation => 'Becsült hely';

  @override
  String get map_publicKey => 'Nyilvános kulcs';

  @override
  String get map_publicKeyPrefixHint => 'pl. ab12';

  @override
  String get map_shareMarkerHere => 'Oszd meg a jelölőt itt';

  @override
  String get map_setAsMyLocation => 'Beállítás helyemként';

  @override
  String get floodCorridor_title => 'Flood folyosó';

  @override
  String get floodCorridor_previewToHere => 'Flood folyosó előnézete idáig';

  @override
  String get floodCorridor_requesting => 'Folyosó kérése a rádiótól…';

  @override
  String get floodCorridor_unsupported =>
      'A rádió firmware-je nem támogatja a flood folyosókat.';

  @override
  String get floodCorridor_noProposal =>
      'A rádió nem tudott folyosót javasolni. Ellenőrizze, hogy be van-e állítva a pozíció.';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kör',
      one: '1 kör',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return '$total ismert ismétlőből $inside van belül';
  }

  @override
  String get floodCorridor_straightLine =>
      'Egyenes vonal: nincs ismert ismétlő az útvonalon';

  @override
  String get floodCorridor_followsRepeaters => 'Az ismert ismétlőket követi';

  @override
  String get floodCorridor_horizonLimited =>
      'Az ismert ismétlők nem érik el a célt; a maradék egyenes vonal';

  @override
  String get floodCorridor_thinStretch =>
      'A folyosó egy részén kevés az ismert ismétlő';

  @override
  String get floodCorridor_moreCoverage =>
      'Nagyobb ismétlőlefedettség megkövetelése';

  @override
  String get floodCorridor_previewNote =>
      'Csak előnézet. A folyosó-firmware nélküli ismétlők nem alkalmazzák a folyosókat.';

  @override
  String get map_pinLabel => 'Kitűzött címke';

  @override
  String get map_label => 'Címke';

  @override
  String get map_pointOfInterest => 'Érdekes pont';

  @override
  String get map_sendToContact => 'Elküldés a kapcsolattartónak';

  @override
  String get map_sendToChannel => 'Küldés a csatornára';

  @override
  String get map_noChannelsAvailable => 'Nincs elérhető csatorna';

  @override
  String get map_publicLocationShare => 'Nyilvános helymegosztás';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return 'Arra készül, hogy megosszon egy helyet itt: $channelLabel. Ez a csatorna nyilvános, és a PSK birtokában bárki láthatja.';
  }

  @override
  String get map_connectToShareMarkers =>
      'Csatlakozzon egy eszközhöz a jelölők megosztásához';

  @override
  String get map_filterNodes => 'Csomópontok szűrése';

  @override
  String get map_nodeTypes => 'Csomópont típusok';

  @override
  String get map_chatNodes => 'Chat csomópontok';

  @override
  String get map_repeaters => 'Ismétlők';

  @override
  String get map_otherNodes => 'Egyéb csomópontok';

  @override
  String get map_showOverlaps => 'Repeater Key átfedések';

  @override
  String get map_keyPrefix => 'Kulcselőtag';

  @override
  String get map_filterByKeyPrefix => 'Szűrés kulcs előtagja szerint';

  @override
  String get map_publicKeyPrefix => 'Nyilvános kulcs előtagja';

  @override
  String get map_markers => 'Jelölők';

  @override
  String get map_showSharedMarkers => 'Megosztott jelölők megjelenítése';

  @override
  String get map_showGuessedLocations =>
      'Talált csomópont-helyek megjelenítése';

  @override
  String get map_showDiscoveryContacts => 'Felfedezési névjegyek megjelenítése';

  @override
  String get map_guessedLocation => 'Talált hely';

  @override
  String get map_lastSeenTime => 'Utoljára látott időpont';

  @override
  String get map_sharedPin => 'Megosztott gombostű';

  @override
  String get map_sharedAt => 'Megosztva';

  @override
  String get map_joinRoom => 'Csatlakozz a szobához';

  @override
  String get map_manageRepeater => 'Repeater kezelése';

  @override
  String get map_tapToAdd =>
      'Érintse meg a csomópontokat, hogy hozzáadja őket az útvonalhoz.';

  @override
  String get map_runTrace => 'Futtatási útvonal nyomkövetése';

  @override
  String get map_runTraceWithReturnPath => 'Térj vissza ugyanazon az úton.';

  @override
  String get map_removeLast => 'Utolsó eltávolítása';

  @override
  String get map_pathTraceCancelled => 'Útvonal nyomkövetés törölve.';

  @override
  String get mapCache_title => 'Offline térképgyorsítótár';

  @override
  String get mapCache_selectAreaFirst =>
      'Válassza ki a gyorsítótárba helyezendő területet';

  @override
  String get mapCache_noTilesToDownload =>
      'Ehhez a területhez nem lehet letölteni csempét';

  @override
  String get mapCache_downloadTilesTitle => 'Csempe letöltése';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return 'Letölti a $count csempét offline használatra?';
  }

  @override
  String get mapCache_downloadAction => 'Letöltés';

  @override
  String mapCache_cachedTiles(int count) {
    return 'Gyorsítótárazott $count csempe';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return 'Gyorsítótárazott $downloaded csempe ($failed sikertelen)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => 'Offline gyorsítótár törlése';

  @override
  String get mapCache_clearOfflineCachePrompt =>
      'Eltávolítja az összes gyorsítótárazott térképcsempét?';

  @override
  String get mapCache_offlineCacheCleared => 'Offline gyorsítótár törölve';

  @override
  String get mapCache_noAreaSelected => 'Nincs kiválasztott terület';

  @override
  String get mapCache_cacheArea => 'Gyorsítótár terület';

  @override
  String get mapCache_useCurrentView => 'Az aktuális nézet használata';

  @override
  String get mapCache_zoomRange => 'Zoom tartomány';

  @override
  String mapCache_estimatedTiles(int count) {
    return 'Becsült csempék: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return 'Letöltve $completed / $total';
  }

  @override
  String get mapCache_downloadTilesButton => 'Letöltés csempe';

  @override
  String get mapCache_clearCacheButton => 'Törölje a gyorsítótárat';

  @override
  String mapCache_failedDownloads(int count) {
    return 'Sikertelen letöltések: $count';
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
    return 'É $north, D $south, K $east, Ny $west';
  }

  @override
  String get time_justNow => 'Éppen most';

  @override
  String time_minutesAgo(int minutes) {
    return '$minutes perce';
  }

  @override
  String time_hoursAgo(int hours) {
    return '$hoursórája';
  }

  @override
  String time_daysAgo(int days) {
    return '${days}napja';
  }

  @override
  String get time_hour => 'óra';

  @override
  String get time_hours => 'óra';

  @override
  String get time_day => 'nap';

  @override
  String get time_days => 'napokon';

  @override
  String get time_week => 'hét';

  @override
  String get time_weeks => 'hét';

  @override
  String get time_month => 'hónap';

  @override
  String get time_months => 'hónap';

  @override
  String get time_minutes => 'jegyzőkönyv';

  @override
  String get time_allTime => 'Minden idők';

  @override
  String get dialog_disconnect => 'Leválasztás';

  @override
  String get dialog_disconnectConfirm =>
      'Biztosan le akarja kapcsolni ezt az eszközt?';

  @override
  String get login_repeaterLogin => 'Ismétlő bejelentkezés';

  @override
  String get login_roomLogin => 'Szobaszerver bejelentkezés';

  @override
  String get login_password => 'Jelszó';

  @override
  String get login_enterPassword => 'Adja meg a jelszót';

  @override
  String get login_savePassword => 'Jelszó mentése';

  @override
  String get login_savePasswordSubtitle =>
      'A jelszó biztonságosan lesz tárolva ezen az eszközön';

  @override
  String get login_repeaterDescription =>
      'Adja meg az ismétlő jelszavát a vendég vagy adminisztrátori hozzáféréshez.';

  @override
  String get login_roomDescription =>
      'Adja meg a szoba jelszavát a vendég vagy adminisztrátori hozzáféréshez.';

  @override
  String get login_routing => 'Útválasztás';

  @override
  String get login_routingMode => 'Útválasztási mód';

  @override
  String get login_autoUseSavedPath =>
      'Automatikus (mentett útvonal használata)';

  @override
  String get login_forceFloodMode => 'Force Flood mód';

  @override
  String get login_managePaths => 'Útvonalak kezelése';

  @override
  String get login_login => 'Bejelentkezés';

  @override
  String login_attempt(int current, int max) {
    return 'Kísérlet $current/$max';
  }

  @override
  String login_failed(String error) {
    return 'Sikertelen bejelentkezés: $error';
  }

  @override
  String get login_failedMessage =>
      'Sikertelen bejelentkezés. Vagy hibás a jelszó, vagy az átjátszó nem érhető el.';

  @override
  String get common_reload => 'Újratöltés';

  @override
  String get common_clear => 'Világos';

  @override
  String get path_currentPathLabel => 'Jelenlegi útvonal';

  @override
  String get path_noRepeatersFound =>
      'Nem található átjátszó vagy szobaszerver.';

  @override
  String get repeater_management => 'Repeater Management';

  @override
  String get room_management => 'Szobaszerver-kezelés';

  @override
  String get repeater_guest => 'Ismétlő információ';

  @override
  String get room_guest => 'Szobaszerver információ';

  @override
  String get repeater_managementTools => 'Kezelőeszközök';

  @override
  String get repeater_guestTools => 'Vendégeszközök';

  @override
  String get repeater_status => 'Állapot';

  @override
  String get repeater_statusSubtitle =>
      'Tekintse meg az átjátszó állapotát, a statisztikákat és a szomszédokat';

  @override
  String get repeater_telemetry => 'Telemetria';

  @override
  String get repeater_telemetrySubtitle =>
      'Tekintse meg az érzékelők telemetriáját és a rendszerstatisztikát';

  @override
  String get repeater_cli => 'CLI';

  @override
  String get repeater_cliSubtitle => 'Parancsok küldése az átjátszónak';

  @override
  String get repeater_neighbors => 'Szomszédok';

  @override
  String get repeater_neighborsSubtitle =>
      'Tekintse meg a zero hop szomszédokat.';

  @override
  String get repeater_settings => 'Beállítások elemre';

  @override
  String get repeater_settingsSubtitle => 'Állítsa be az ismétlő paramétereit';

  @override
  String get repeater_clockSyncAfterLogin =>
      'Óra szinkronizálás bejelentkezés után';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      '„Óraszinkronizálás” automatikus küldése sikeres bejelentkezés után';

  @override
  String get repeater_statusTitle => 'Repeater állapota';

  @override
  String get repeater_routingMode => 'Útválasztási mód';

  @override
  String get repeater_refresh => 'Frissítés';

  @override
  String get repeater_statusRequestTimeout =>
      'Az állapotkérelem időtúllépése lejárt.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'Hiba az állapot betöltésekor: $error';
  }

  @override
  String get repeater_systemInformation => 'Rendszerinformációk';

  @override
  String get repeater_battery => 'Akkumulátor';

  @override
  String get repeater_clockAtLogin => 'Óra (bejelentkezéskor)';

  @override
  String get repeater_uptime => 'Üzemidő';

  @override
  String get repeater_queueLength => 'Sor hossza';

  @override
  String get repeater_debugFlags => 'Debug Flags';

  @override
  String get repeater_radioStatistics => 'Rádióstatisztika';

  @override
  String get repeater_lastRssi => 'Utolsó RSSI';

  @override
  String get repeater_lastSnr => 'Utolsó SNR';

  @override
  String get repeater_noiseFloor => 'Zajpadló';

  @override
  String get repeater_txAirtime => 'TX műsoridő';

  @override
  String get repeater_rxAirtime => 'RX műsoridő';

  @override
  String get repeater_chanUtil => 'Csatornahasználat';

  @override
  String get repeater_packetStatistics => 'Csomagstatisztika';

  @override
  String get repeater_sent => 'Küldött';

  @override
  String get repeater_received => 'Fogadva';

  @override
  String get repeater_duplicates => 'Ismétlődések';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days nap $hoursó ${minutes}p ${seconds}s';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return 'Összesen: $total, Árvíz: $flood, Közvetlen: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return 'Összesen: $total, Árvíz: $flood, Közvetlen: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return 'Árvíz: $flood, Közvetlen: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return 'Összesen: $total';
  }

  @override
  String get repeater_settingsTitle => 'Repeater beállítások';

  @override
  String get repeater_basicSettings => 'Alapbeállítások';

  @override
  String get repeater_repeaterName => 'Ismétlő neve';

  @override
  String get repeater_repeaterNameHelper => 'Az átjátszó megjelenítési neve';

  @override
  String get repeater_adminPassword => 'Admin jelszó';

  @override
  String get repeater_adminPasswordHelper => 'Teljes hozzáférési jelszó';

  @override
  String get repeater_guestPassword => 'Vendégjelszó';

  @override
  String get repeater_guestPasswordHelper =>
      'Csak olvasható hozzáférési jelszó';

  @override
  String get repeater_radioSettings => 'Rádióbeállítások';

  @override
  String get repeater_frequencyMhz => 'Frekvencia (MHz)';

  @override
  String get repeater_frequencyHelper => '300-2500 MHz';

  @override
  String get repeater_txPower => 'TX teljesítmény';

  @override
  String get repeater_txPowerHelper => '1-30 dBm';

  @override
  String get repeater_bandwidth => 'Sávszélesség';

  @override
  String get repeater_spreadingFactor => 'Spreading Factor';

  @override
  String get repeater_codingRate => 'Kódolási sebesség';

  @override
  String get repeater_locationSettings => 'Helybeállítások';

  @override
  String get repeater_latitude => 'Szélesség';

  @override
  String get repeater_latitudeHelper => 'Tizedes fokozatok (pl. 37,7749)';

  @override
  String get repeater_longitude => 'Hosszúság';

  @override
  String get repeater_longitudeHelper => 'Tizedes fokok (pl. -122,4194)';

  @override
  String get repeater_features => 'Jellemzők';

  @override
  String get repeater_packetForwarding => 'Csomagtovábbítás';

  @override
  String get repeater_packetForwardingSubtitle =>
      'Ismétlő engedélyezése a csomagok továbbításához';

  @override
  String get repeater_guestAccess => 'Vendég hozzáférés';

  @override
  String get repeater_guestAccessSubtitle =>
      'Csak olvasási hozzáférés engedélyezése a vendégek számára';

  @override
  String get repeater_privacyMode => 'Adatvédelmi mód';

  @override
  String get repeater_privacyModeSubtitle =>
      'Név/hely elrejtése a hirdetésekben';

  @override
  String get repeater_advertisementSettings => 'Reklámbeállítások';

  @override
  String get repeater_localAdvertInterval => 'Helyi hirdetési intervallum';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes perc';
  }

  @override
  String get repeater_floodAdvertInterval => 'Árvízi hirdetési intervallum';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours óra';
  }

  @override
  String get repeater_encryptedAdvertInterval => 'Titkosított hirdetési időköz';

  @override
  String get repeater_dangerZone => 'Veszélyzóna';

  @override
  String get repeater_rebootRepeater => 'Reboot Repeater';

  @override
  String get repeater_rebootRepeaterSubtitle =>
      'Indítsa újra az átjátszó eszközt';

  @override
  String get repeater_rebootRepeaterConfirm =>
      'Biztosan újraindítja ezt az átjátszót?';

  @override
  String get repeater_regenerateIdentityKey => 'Identitáskulcs újragenerálása';

  @override
  String get repeater_regenerateIdentityKeySubtitle =>
      'Új nyilvános/privát kulcspár létrehozása';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'Ez új identitást generál az átjátszó számára. Folytatja?';

  @override
  String get repeater_eraseFileSystem => 'Fájlrendszer törlése';

  @override
  String get repeater_eraseFileSystemSubtitle =>
      'Formázza meg az átjátszó fájlrendszert';

  @override
  String get repeater_eraseFileSystemConfirm =>
      'FIGYELMEZTETÉS: Ezzel törli az átjátszón lévő összes adatot. Ezt nem lehet visszavonni!';

  @override
  String get repeater_eraseSerialOnly =>
      'A törlés csak soros konzolon érhető el.';

  @override
  String repeater_commandSent(String command) {
    return 'Parancs elküldve: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'Hiba a parancs küldésekor: $error';
  }

  @override
  String get repeater_confirm => 'Erősítse meg';

  @override
  String get repeater_settingsSaved => 'A beállítások sikeresen elmentve';

  @override
  String get repeater_rxGain => 'Megnövelt RX nyereség';

  @override
  String get repeater_rxGainHelper =>
      'Nagyobb érzékenység, nagyobb áramfelvétel (csak SX1262/SX1268)';

  @override
  String get repeater_refreshRxGain => 'Frissítse a megnövelt RX-erősítést';

  @override
  String get repeater_multiAcks => 'Multi-ACK';

  @override
  String get repeater_multiAcksSubtitle =>
      'Nyugtázza az üzeneteket több úton a jobb kézbesítés érdekében';

  @override
  String get repeater_refreshMultiAcks => 'Többszörös ACK-ek frissítése';

  @override
  String get repeater_networkHealth => 'Hálózat állapota';

  @override
  String get repeater_loopDetect => 'Hurokérzékelés';

  @override
  String get repeater_loopDetectHelper =>
      'Dobd el az útválasztó huroknak tűnő árvízcsomagokat';

  @override
  String get repeater_loopDetectOff => 'Le';

  @override
  String get repeater_loopDetectMinimal => 'Minimális';

  @override
  String get repeater_loopDetectModerate => 'Mérsékelt';

  @override
  String get repeater_loopDetectStrict => 'Szigorú';

  @override
  String get repeater_dutyCycle => 'Üzemi ciklus';

  @override
  String get repeater_dutyCycleHelper => 'A műsoridő maximális százaléka';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => 'Üzemeltető információ';

  @override
  String get repeater_ownerInfoHelper =>
      'Nyilvános metaadatok ehhez az átjátszóhoz';

  @override
  String get repeater_refreshOwnerInfo => 'Frissítse az operátor adatait';

  @override
  String get repeater_floodMax => 'Árvíz max ugrás';

  @override
  String get repeater_floodMaxHelper =>
      'Maximum ugrások, amelyeket egy árvízcsomag utazhat (0-64)';

  @override
  String get repeater_advancedSettings => 'Fejlett';

  @override
  String get repeater_advancedSettingsSubtitle =>
      'Hangológombok tapasztalt kezelőknek';

  @override
  String get repeater_pathHashMode => 'Útvonal hash mód';

  @override
  String get repeater_pathHashModeHelper =>
      'Az átjátszó azonosítójának elárasztási útvonal/hurokészlelési címkékbe való kódolására használt bájtok. 0 = 1 bájt (256 azonosító, legfeljebb 64 ugrás), 1 = 2 bájt (65 000 azonosító, legfeljebb 32 ugrás), 2 = 3 bájt (16 millió azonosító, legfeljebb 21 ugrás). A v1.13 és régebbi firmware eldobja a többbájtos elérési utat – csak akkor emelje meg, ha a hálózat a v1.14+ verziót használja.';

  @override
  String get repeater_keySettings => 'Képzőítsekei jelölt';

  @override
  String get repeater_keySettingsSubtitle =>
      'Közelítse a közlekedési/private képlékt';

  @override
  String get repeater_prvKey => 'Kis házas';

  @override
  String get repeater_prvKeyHelper =>
      'Kínai nyelvben:\n\nA repeteróhoz új képes kód, 128 karakteri hex-kód.';

  @override
  String get repeater_generatePrvKey => 'Egy random képléktár generáld meg';

  @override
  String get repeater_stopGeneratingPrvKey =>
      'Kéypair szavakat kérdéset kaphatás';

  @override
  String get repeater_pubKey => 'Kiváló kiegészítő';

  @override
  String get repeater_pubKeyHelper =>
      'Ez a kiváló kód, amely tükrözi a gyártott kiegészítő kódot. Ezet nem lehet megjelenítani direktusan.';

  @override
  String get repeater_pubKeyPrefix => 'Kiváló prefix';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'Kiválasztsa meg a közös kódot, amely az alábbi hex-kifüggőnek előre van. Várható kiválasztások száma: $tries.';
  }

  @override
  String get repeater_txDelay => 'Áradási TX késleltetés';

  @override
  String get repeater_txDelayHelper =>
      'Újraküldési térköz az árvízi forgalomhoz, a csomag sugárzási idejének szorzójaként (0-2, alapértelmezett 0,5). Magasabb = kevesebb ütközés, de lassabb szállítás.';

  @override
  String get repeater_directTxDelay => 'Közvetlen TX késleltetés';

  @override
  String get repeater_directTxDelayHelper =>
      'A közvetlen (nem elárasztásos) forgalom újraküldési távolsága a csomag sugárzási idejének szorzójaként (0-2, alapértelmezett 0,3).';

  @override
  String get repeater_intThresh => 'Interferencia küszöb';

  @override
  String get repeater_intThreshHelper =>
      'A küszöbérték átkerült a rádió zajszint-kalibrációjához, így az e szint feletti interferenciát elutasítja. 0 letilt – csak akkor emel, ha zajos sávban RX hibákat lát.';

  @override
  String get repeater_agcResetInterval => 'AGC reset intervallum';

  @override
  String get repeater_agcResetIntervalHelper =>
      'Milyen gyakran kell visszaállítani a rádió automatikus erősítésszabályozását, hogy helyreálljon a beragadt erősítési állapotból. A másodpercek, 4 többszörösére csökkentve. 0 letiltja az időszakos visszaállításokat.';

  @override
  String get repeater_actionsTitle => 'Akciók';

  @override
  String get repeater_sendAdvert => 'Árvízhirdetés küldése';

  @override
  String get repeater_sendAdvertSubtitle =>
      'Adjon árvízreklámot a hálózaton keresztül';

  @override
  String get repeater_sendAdvertZeroHop => 'Zéró ugrású hirdetés küldése';

  @override
  String get repeater_sendAdvertZeroHopSubtitle =>
      'Egyugrásos hirdetés sugárzása (közvetítés nélkül)';

  @override
  String get repeater_clockSync => 'Óra szinkronizálása most';

  @override
  String get repeater_clockSyncSubtitle =>
      'Tolja a telefon idejét az átjátszóhoz';

  @override
  String repeater_actionSucceeded(String action) {
    return '$action sikerült';
  }

  @override
  String repeater_actionFailed(String action, String error) {
    return '$action sikertelen: $error';
  }

  @override
  String get repeater_settingsSavedRebootNeeded =>
      'A beállítások mentve – az átjátszó újraindítása az alkalmazáshoz';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return 'Néhány beállítás nem sikerült: $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return 'Hiba a beállítások mentésekor: $error';
  }

  @override
  String get repeater_refreshBasicSettings =>
      'Frissítse az alapvető beállításokat';

  @override
  String get repeater_refreshRadioSettings => 'Frissítse a rádióbeállításokat';

  @override
  String get repeater_refreshTxPower => 'TX teljesítmény frissítése';

  @override
  String get repeater_refreshPacketForwarding => 'Csomagtovábbítás frissítése';

  @override
  String get repeater_refreshGuestAccess => 'Vendég hozzáférés frissítése';

  @override
  String get repeater_refreshPrivacyMode => 'Frissítse az adatvédelmi módot';

  @override
  String repeater_refreshed(String label) {
    return '$label frissítve';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return 'Hiba a $label frissítésekor';
  }

  @override
  String get repeater_cliTitle => 'Repeater CLI';

  @override
  String get repeater_debugNextCommand => 'Debug Next Command';

  @override
  String get repeater_commandHelp => 'Command Help';

  @override
  String get repeater_clearHistory => 'Törölje az előzményeket';

  @override
  String get repeater_noCommandsSent => 'Még nem küldtek parancsot';

  @override
  String get repeater_typeCommandOrUseQuick =>
      'Írjon be egy parancsot alább, vagy használjon gyorsparancsokat';

  @override
  String get repeater_enterCommandHint => 'Írja be a parancsot...';

  @override
  String get repeater_previousCommand => 'Előző parancs';

  @override
  String get repeater_nextCommand => 'Következő parancs';

  @override
  String get repeater_enterCommandFirst => 'Először írjon be egy parancsot';

  @override
  String get repeater_cliCommandFrameTitle => 'CLI parancskeret';

  @override
  String repeater_cliCommandError(String error) {
    return 'Hiba: $error';
  }

  @override
  String get repeater_cliQuickGetName => 'Get Name';

  @override
  String get repeater_cliQuickGetRadio => 'Szerezz rádiót';

  @override
  String get repeater_cliQuickGetTx => 'Szerezd meg a TX-et';

  @override
  String get repeater_cliQuickNeighbors => 'Szomszédok';

  @override
  String get repeater_cliQuickVersion => 'Változat';

  @override
  String get repeater_cliQuickAdvertise => 'Hirdet';

  @override
  String get repeater_cliQuickClock => 'Óra';

  @override
  String get repeater_cliQuickClockSync => 'Óra szinkronizálás';

  @override
  String get repeater_cliQuickDiscovery => 'Fedezze fel a szomszédokat';

  @override
  String get repeater_cliHelpAdvert => 'Reklámcsomagot küld';

  @override
  String get repeater_cliHelpReboot =>
      'Újraindítja az eszközt. (megjegyzendő, hogy \"Időtúllépés\" jelenik meg, ami normális)';

  @override
  String get repeater_cliHelpClock =>
      'Megjeleníti az aktuális időt az eszköz órájánként.';

  @override
  String get repeater_cliHelpPassword =>
      'Új rendszergazdai jelszót állít be az eszközhöz.';

  @override
  String get repeater_cliHelpVersion =>
      'Megmutatja az eszköz verzióját és a firmware felépítési dátumát.';

  @override
  String get repeater_cliHelpClearStats =>
      'Nullára állítja a különböző statisztikai számlálókat.';

  @override
  String get repeater_cliHelpSetAf => 'Beállítja a műsoridő-tényezőt.';

  @override
  String get repeater_cliHelpSetTx =>
      'A LoRa adási teljesítményét dBm-ben állítja be. (újraindítás az alkalmazáshoz)';

  @override
  String get repeater_cliHelpSetRepeat =>
      'Engedélyezi vagy letiltja a csomópont ismétlő szerepét.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(Szobaszerver) Ha \'be\', akkor az üres jelszó bejelentkezés engedélyezett, de nem lehet postázni a szobába. (csak olvasható)';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'Beállítja a bejövő árvízcsomag ugrásainak maximális számát (ha >= max, a csomag nem kerül továbbításra)';

  @override
  String get repeater_cliHelpSetIntThresh =>
      'Beállítja az interferencia küszöböt (DB-ben). Az alapértelmezett érték 14. Állítsa 0-ra a csatornainterferencia-érzékelés letiltásához.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'Beállítja az Auto Gain Controller alaphelyzetbe állításának intervallumát. A letiltáshoz állítsa 0-ra.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      'Engedélyezi vagy letiltja a „dupla ACK” funkciót.';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'Beállítja a helyi (nulla ugrású) hirdetési csomag küldésének időzítési időközét percekben. A letiltáshoz állítsa 0-ra.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'Beállítja az időzítő intervallumát órákban az árvízhirdetési csomag küldéséhez. A letiltáshoz állítsa 0-ra.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'Beállítja/frissíti a vendég jelszavát. (Repeaterek esetén a vendégbejelentkezés elküldheti a \"Statisztikák lekérése\" kérést)';

  @override
  String get repeater_cliHelpSetName => 'Beállítja a hirdetés nevét.';

  @override
  String get repeater_cliHelpSetLat =>
      'Beállítja a hirdetéstérkép szélességi fokát. (tizedes fok)';

  @override
  String get repeater_cliHelpSetLon =>
      'Beállítja a hirdetési térkép hosszúsági fokát. (tizedes fok)';

  @override
  String get repeater_cliHelpSetRadio =>
      'Teljesen új rádióparamétereket állít be, és elmenti a beállításokhoz. Az alkalmazáshoz \"reboot\" parancs szükséges.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      'Beállítja a (kísérleti) bázist (az effektushoz > 1-nek kell lennie) a fogadott csomagok enyhe késleltetéséhez, a jelerősség/pontszám alapján. A letiltáshoz állítsa 0-ra.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      'Beállít egy tényezőt, megszorozva az adásidővel egy elárasztásos módú csomaghoz és egy véletlenszerű résrendszerhez, hogy késleltesse a továbbítását. (az ütközések valószínűségének csökkentése érdekében)';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'Ugyanaz, mint a txdelay, de véletlenszerű késleltetés alkalmazására a közvetlen módú csomagok továbbítására.';

  @override
  String get repeater_cliHelpSetBridgeEnabled =>
      'Bridge engedélyezése/letiltása.';

  @override
  String get repeater_cliHelpSetBridgeDelay =>
      'Állítsa be a késleltetést a csomagok újraküldése előtt.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      'Válassza ki, hogy a híd újraküldje-e a fogadott vagy továbbított csomagokat.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'Soros kapcsolat átviteli sebességének beállítása rs232 hidakhoz.';

  @override
  String get repeater_cliHelpSetBridgeSecret =>
      'Állítsa be a hídtitkot espnow hidakhoz.';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      'Egyéni tényezőt állít be a jelentett akkumulátorfeszültség beállításához (csak bizonyos kártyákon támogatott).';

  @override
  String get repeater_cliHelpTempRadio =>
      'Ideiglenes rádióparamétereket állít be a megadott számú percre, majd visszaáll az eredeti rádióparaméterekre. (NEM menti a beállításokba).';

  @override
  String get repeater_cliHelpSetPerm =>
      'Módosítja az ACL-t. Eltávolítja a megfelelő bejegyzést (pubkey előtag alapján), ha az „engedélyek” értéke nulla. Új bejegyzést ad hozzá, ha a pubkey-hex teljes hosszúságú, és jelenleg nincs az ACL-ben. Frissíti a bejegyzést a pubkey előtag egyeztetésével. Az engedélybitek firmware-szerepkörönként változnak, de az alacsony 2 bit a következő: 0 (Vendég), 1 (Csak olvasható), 2 (Olvasás, írás), 3 (Adminisztrátor)';

  @override
  String get repeater_cliHelpGetBridgeType =>
      'Hidatípust nem kap, rs232, espnow';

  @override
  String get repeater_cliHelpLogStart =>
      'Elindítja a csomagnaplózást a fájlrendszerbe.';

  @override
  String get repeater_cliHelpLogStop =>
      'Leállítja a csomagok naplózását a fájlrendszerbe.';

  @override
  String get repeater_cliHelpLogErase =>
      'Törli a csomagnaplókat a fájlrendszerből.';

  @override
  String get repeater_cliHelpNeighbors =>
      'Megjeleníti a nulla ugrású hirdetéseken keresztül hallható egyéb átjátszó csomópontok listáját. Minden sor id-prefix-hex:timestamp:snr-times-4';

  @override
  String get repeater_cliHelpNeighborRemove =>
      'Eltávolítja az első egyező bejegyzést (a pubkey előtag (hex) alapján) a szomszédok listájából.';

  @override
  String get repeater_cliHelpRegion =>
      '(csak soros) Felsorolja az összes meghatározott régiót és az aktuális árvízi engedélyeket.';

  @override
  String get repeater_cliHelpRegionLoad =>
      'MEGJEGYZÉS: ez egy speciális többparancsos hívás. Minden következő parancs egy régiónév (szóközökkel behúzva a szülőhierarchiát jelölve, legalább egy szóközzel). Üres sor/parancs küldésével megszűnik.';

  @override
  String get repeater_cliHelpRegionGet =>
      'Régiót keres adott név előtaggal (vagy \"*\" a globális hatókörhöz). A válasz a következővel: \"-> régiónév (szülőnév) \'F\'\"';

  @override
  String get repeater_cliHelpRegionPut =>
      'Adott névvel rendelkező régiódefiníció hozzáadása vagy frissítése.';

  @override
  String get repeater_cliHelpRegionRemove =>
      'Eltávolítja a megadott nevű régiódefiníciót. (pontosan meg kell egyeznie, és nem lehetnek alárendelt régiók)';

  @override
  String get repeater_cliHelpRegionAllowf =>
      'Beállítja az \'F\'lood engedélyt az adott régióhoz. (\"*\" a globális/örökölt hatókörre)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      'Eltávolítja az \'F\'lood engedélyt az adott régióhoz. (MEGJEGYZÉS: ebben a szakaszban NEM tanácsos ezt használni a globális/örökölt hatókörön!!)';

  @override
  String get repeater_cliHelpRegionHome =>
      'Az aktuális „otthoni” régióval válaszol. (A megjegyzés még bárhol érvényes, jövőre fenntartva)';

  @override
  String get repeater_cliHelpRegionHomeSet => 'Beállítja az „otthoni” régiót.';

  @override
  String get repeater_cliHelpRegionSave =>
      'Megőrzi a régiólistát/leképezést a tárhelyen.';

  @override
  String get repeater_cliHelpGps =>
      'Megadja a gps állapotát. Ha a gps ki van kapcsolva, akkor csak kikapcsolva válaszol, ha be van kapcsolva, akkor válaszol: be, állapot, javítás, sat count';

  @override
  String get repeater_cliHelpGpsOnOff =>
      'Bekapcsolja a gps tápellátási állapotát.';

  @override
  String get repeater_cliHelpGpsSync =>
      'Szinkronizálja a csomópont idejét a gps órával.';

  @override
  String get repeater_cliHelpGpsSetLoc =>
      'Beállítja a csomópont pozícióját a gps koordinátákra és menti a beállításokat.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'Megadja a csomópont helyhirdetési konfigurációját:\n- nincs: ne adja meg a helyet a hirdetésekben\n- megosztás: GPS hely megosztása (a SensorManagerből)\n- preferenciák: a beállításokban tárolt hely hirdetése';

  @override
  String get repeater_cliHelpGpsAdvertSet =>
      'Beállítja a helyhirdetés konfigurációját.';

  @override
  String get repeater_commandsListTitle => 'Parancslista';

  @override
  String get repeater_commandsListNote =>
      'MEGJEGYZÉS: a különféle \"set ...\" parancsokhoz van egy \"get ...\" parancs is.';

  @override
  String get repeater_general => 'Általános';

  @override
  String get repeater_settingsCategory => 'Beállítások elemre';

  @override
  String get repeater_bridge => 'Híd';

  @override
  String get repeater_logging => 'Fakitermelés';

  @override
  String get repeater_neighborsRepeaterOnly => 'Szomszédok (csak átjátszó)';

  @override
  String get repeater_regionManagementRepeaterOnly =>
      'Régiókezelés (csak ismétlő)';

  @override
  String get repeater_regionNote =>
      'Régióparancsok kerültek bevezetésre a régiódefiníciók és engedélyek kezelésére.';

  @override
  String get repeater_gpsManagement => 'GPS kezelés';

  @override
  String get repeater_gpsNote =>
      'A gps parancs bevezetésre került a helyhez kapcsolódó témák kezeléséhez.';

  @override
  String get repeater_getCategory => 'Szerezzen értékeket';

  @override
  String get repeater_powerMgmt => 'Energiagazdálkodás';

  @override
  String get repeater_sensors => 'Érzékelők';

  @override
  String get repeater_cliHelpPowerOff =>
      'Kikapcsolja a készüléket. (nem várható válasz)';

  @override
  String get repeater_cliHelpClkReboot =>
      'Visszaállítja az órát egy ismert korszakra, és újraindítja az eszközt.';

  @override
  String get repeater_cliHelpAdvertZeroHop =>
      'Zéró ugrású hirdetést küld (csak a közvetlen szomszédok számára).';

  @override
  String get repeater_cliHelpStartOta =>
      'Elindít egy vezeték nélküli firmware-frissítést a támogatott kártyákon.';

  @override
  String get repeater_cliHelpTime =>
      'Beállítja az eszköz óráját a megadott Unix korszak másodpercekre. Az óra nem tud visszafelé mozogni.';

  @override
  String get repeater_cliHelpBoard =>
      'Megmutatja a kártya gyártóját/hardver azonosítóját.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      'Csomópont-felderítési kérelmet küld a közeli szomszédoknak. (Csak ismétlő)';

  @override
  String get repeater_cliHelpPowersaving =>
      'Megmutatja, hogy az energiatakarékos mód be vagy ki van-e kapcsolva.';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      'Engedélyezi vagy letiltja az energiatakarékos módot (ahol támogatott).';

  @override
  String get repeater_cliHelpErase =>
      '(Csak soros) Formázza az eszköz fájlrendszerét. Törli az összes beállítást és névjegyet.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      'Beállítja a maximális megengedett átviteli munkaciklust százalékban (1-100). Belsőleg állítja be a műsoridőtényezőt.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '(Csak soros) Lecseréli az eszközazonosító privát kulcsot. Újraindítás szükséges az alkalmazáshoz. Új nyilvános kulcsot generál.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(csak SX126x) Bekapcsolja a megnövelt RX-erősítést a jobb érzékenység érdekében nagyobb áramfelvétel mellett.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      'Beállítja a hirdetésekben szereplő tulajdonos elérhetőségi adatait. A \'|\' használata újsorokhoz.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'Beállítja az útvonal-kivonat módot. 0 = örökölt, 1 = szabványos, 2 = szigorú. Befolyásolja az útválasztási útvonalak egyeztetését.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'Beállítja az útválasztási hurok észlelésének érzékenységét: ki, minimális, közepes vagy szigorú.';

  @override
  String get repeater_cliHelpSetFreq =>
      '(Csak soros) Gyorsan beállítja csak a frekvenciát. Újraindítás szükséges. A „rádió beállítása” előnyben részesítse a teljes rádióparamétereket.';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(Csak ESPNow bridge) Beállítja a híd által használt WiFi csatornát (1-14).';

  @override
  String get repeater_cliHelpGetName =>
      'Megjeleníti a konfigurált csomópont nevét.';

  @override
  String get repeater_cliHelpGetRole =>
      'Megmutatja a firmware szerepkörét (Repeater, Room Server stb.).';

  @override
  String get repeater_cliHelpGetPublicKey =>
      'Megjeleníti az eszköz nyilvános kulcsát.';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '(Csak soros) Az eszköz privát kulcsát mutatja. Kezelje titokként.';

  @override
  String get repeater_cliHelpGetRepeat =>
      'Megmutatja, hogy a csomagtovábbítás (ismétlő szerepkör) be vagy ki van-e kapcsolva.';

  @override
  String get repeater_cliHelpGetTx =>
      'Az aktuális TX teljesítményt mutatja dBm-ben.';

  @override
  String get repeater_cliHelpGetFreq =>
      'Megjeleníti a beállított rádiófrekvenciát MHz-ben.';

  @override
  String get repeater_cliHelpGetRadio =>
      'A teljes rádióparamétereket mutatja: frekvencia, sávszélesség, szórási tényező, kódolási sebesség.';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(csak SX126x) Megjeleníti az RX megnövelt erősítési állapotát.';

  @override
  String get repeater_cliHelpGetAf => 'Megmutatja az aktuális műsoridőt.';

  @override
  String get repeater_cliHelpGetDutyCycle =>
      'Megjeleníti az aktuális megengedett munkaciklust százalékban.';

  @override
  String get repeater_cliHelpGetIntThresh =>
      'A csatorna interferencia küszöbértékét mutatja dB-ben.';

  @override
  String get repeater_cliHelpGetAgcResetInterval =>
      'Az AGC reset intervallumát mutatja másodpercben.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      'Megmutatja, hogy a dupla ACK mód be van-e kapcsolva (1) vagy ki (0).';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'Megmutatja, hogy a vendég csak olvasási hozzáférés engedélyezett-e.';

  @override
  String get repeater_cliHelpGetAdvertInterval =>
      'A helyi hirdetési intervallumot mutatja percben.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'Megjeleníti az árvízhirdetés intervallumát órákban.';

  @override
  String get repeater_cliHelpGetGuestPassword =>
      'Megjeleníti a beállított vendégjelszót.';

  @override
  String get repeater_cliHelpGetLat =>
      'Megjeleníti a beállított szélességi fokot.';

  @override
  String get repeater_cliHelpGetLon => 'A beállított hosszúságot mutatja.';

  @override
  String get repeater_cliHelpGetRxDelay => 'Az rxdelay alapértékét mutatja.';

  @override
  String get repeater_cliHelpGetTxDelay =>
      'Megjeleníti az elárasztási mód txdelay tényezőjét.';

  @override
  String get repeater_cliHelpGetDirectTxDelay =>
      'A közvetlen módú txdelay tényezőt mutatja.';

  @override
  String get repeater_cliHelpGetFloodMax =>
      'Megmutatja a maximális elárasztási ugrás számát.';

  @override
  String get repeater_cliHelpGetOwnerInfo =>
      'Megjeleníti a tulajdonos kapcsolatfelvételi adatait.';

  @override
  String get repeater_cliHelpGetPathHashMode =>
      'Az elérési út-kivonat módot mutatja (0/1/2).';

  @override
  String get repeater_cliHelpGetLoopDetect =>
      'A hurokérzékelés érzékenységét mutatja.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(Csak soros) Felsorolja a hozzáférés-vezérlési bejegyzéseket az átjátszón.';

  @override
  String get repeater_cliHelpGetBridgeEnabled =>
      'Megmutatja, hogy a híd engedélyezve van-e.';

  @override
  String get repeater_cliHelpGetBridgeDelay =>
      'A híd késleltetését mutatja ms-ban.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'Megmutatja, hogy a híd RX vagy TX csomagokat naplóz-e.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(csak RS232 híd) A híd adatátviteli sebességét mutatja.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(csak ESPNow bridge) A híd WiFi csatornáját mutatja.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(Csak ESPNow bridge) Megjeleníti a híd megosztott titkát.';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '(Csak NRF52) A rendszerbetöltő verzióját mutatja.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'Az ADC szorzót mutatja (akkumulátor-feszültség skálázás).';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      'Beszámol arról, hogy a testület rendelkezik-e hatalomkezelési támogatással.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      'Az aktuális áramforrást mutatja: külső vagy akkumulátor.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      'Megmutatja a legutóbbi alaphelyzetbe állítás és leállítás okait.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv =>
      'Megmutatja a rendszerindítási akkumulátorfeszültséget mV-ban.';

  @override
  String get repeater_cliHelpSensorGet =>
      'Kulcs segítségével beolvassa az egyéni szenzorbeállítást.';

  @override
  String get repeater_cliHelpSensorSet => 'Egyéni szenzorbeállítást ír.';

  @override
  String get repeater_cliHelpSensorList =>
      'Felsorolja az összes egyéni érzékelőbeállítást, oldalszámozással az opcionális kezdőindexből.';

  @override
  String get repeater_cliHelpRegionDefault =>
      'Megjeleníti az aktuális alapértelmezett régióhatókört.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'Beállítja az alapértelmezett régió hatókört. A törléshez használja a \"<null>\" parancsot.';

  @override
  String get repeater_cliHelpRegionListAllowed =>
      'Felsorolja azokat a régiókat, amelyek lehetővé teszik az árvízi forgalmat.';

  @override
  String get repeater_cliHelpRegionListDenied =>
      'Felsorolja azokat a régiókat, amelyek megtagadják az árvízi forgalmat.';

  @override
  String get repeater_cliHelpStatsPackets =>
      '(Csak soros) Csomag szintű statisztikákat jelenít meg.';

  @override
  String get repeater_cliHelpStatsRadio =>
      '(Csak soros) Rádióstatisztikák megjelenítése.';

  @override
  String get repeater_cliHelpStatsCore =>
      '(Csak soros) Az alapvető firmware-statisztikák megjelenítése.';

  @override
  String get telemetry_receivedData => 'Fogadott telemetriai adatok';

  @override
  String get telemetry_requestTimeout =>
      'A telemetriai kérés időtúllépése lejárt.';

  @override
  String telemetry_errorLoading(String error) {
    return 'Hiba a telemetria betöltésekor: $error';
  }

  @override
  String get telemetry_noData => 'Nincsenek telemetriai adatok.';

  @override
  String telemetry_channelTitle(int channel) {
    return 'Csatorna $channel';
  }

  @override
  String get telemetry_batteryLabel => 'Akkumulátor';

  @override
  String get telemetry_voltageLabel => 'Feszültség';

  @override
  String get telemetry_mcuTemperatureLabel => 'MCU hőmérséklet';

  @override
  String get telemetry_temperatureLabel => 'Hőmérséklet';

  @override
  String get telemetry_currentLabel => 'Jelenlegi';

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
  String get telemetry_digitalInputLabel => 'Digitális bemenet';

  @override
  String get telemetry_digitalOutputLabel => 'Digitális kimenet';

  @override
  String get telemetry_analogInputLabel => 'Analóg bemenet';

  @override
  String get telemetry_analogOutputLabel => 'Analóg kimenet';

  @override
  String get telemetry_genericLabel => 'Általános érzékelő';

  @override
  String get telemetry_luminosityLabel => 'Fényesség';

  @override
  String get telemetry_presenceLabel => 'Jelenlét';

  @override
  String get telemetry_humidityLabel => 'Nedvesség';

  @override
  String get telemetry_accelerometerLabel => 'Gyorsulásmérő';

  @override
  String get telemetry_pressureLabel => 'Nyomás';

  @override
  String get telemetry_altitudeLabel => 'Magasság';

  @override
  String get telemetry_frequencyLabel => 'Frekvencia';

  @override
  String get telemetry_percentageLabel => 'Százalék';

  @override
  String get telemetry_concentrationLabel => 'Koncentráció';

  @override
  String get telemetry_powerLabel => 'Hatalom';

  @override
  String get telemetry_distanceLabel => 'Távolság';

  @override
  String get telemetry_energyLabel => 'Energia';

  @override
  String get telemetry_directionLabel => 'Irány';

  @override
  String get telemetry_timeLabel => 'Idő';

  @override
  String get telemetry_gyrometerLabel => 'Girométer';

  @override
  String get telemetry_colourLabel => 'Szín';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'Kapcsoló';

  @override
  String get telemetry_polylineLabel => 'Vonallánc';

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
  String get telemetry_autoFetchQuantity => 'Mennyiséget kér';

  @override
  String get telemetry_error => 'Nem sikerült lekérni az adatokat';

  @override
  String get neighbors_receivedData => 'Szomszédok adatok fogadása';

  @override
  String get neighbors_requestTimedOut => 'A szomszédok kérése lejárt.';

  @override
  String neighbors_errorLoading(String error) {
    return 'Hiba a szomszédok betöltésekor: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => 'Ismétlők Szomszédok';

  @override
  String get neighbors_noData =>
      'A szomszédokról nem állnak rendelkezésre adatok.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return 'Ismeretlen $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return 'Hallva: $time ezelőtt';
  }

  @override
  String get channelPath_title => 'Csomag elérési útja';

  @override
  String get channelPath_viewMap => 'Térkép megtekintése';

  @override
  String get channelPath_otherObservedPaths => 'Egyéb megfigyelt utak';

  @override
  String get channelPath_repeaterHops => 'Repeater Hops';

  @override
  String get channelPath_noHopDetails =>
      'Ennél a csomagnál a komlórészletek nincsenek megadva.';

  @override
  String get channelPath_sourceLabel => 'Forrás';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'Ez az üzenet MQTT-n keresztül érkezett. A rádiója nem hallotta, így nincs rádiós útvonal a rádiójától.';

  @override
  String get channelPath_messageDetails => 'Üzenet részletei';

  @override
  String get channelPath_senderLabel => 'Feladó';

  @override
  String get channelPath_timeLabel => 'Idő';

  @override
  String get channelPath_repeatsLabel => 'Ismétlődik';

  @override
  String channelPath_pathLabel(int index) {
    return '$index elérési út';
  }

  @override
  String get channelPath_observedLabel => 'Megfigyelt';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return 'Megfigyelt útvonal $index • $hops';
  }

  @override
  String get channelPath_noLocationData => 'Nincsenek helyadatok';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => 'Ismeretlen';

  @override
  String get channelPath_floodPath => 'Árvíz';

  @override
  String get channelPath_directPath => 'Közvetlen';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 / $total ugrás';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed / $total ugrás';
  }

  @override
  String get channelPath_mapTitle => 'Útvonal térkép';

  @override
  String get channelPath_noRepeaterLocations =>
      'Nincs elérhető átjátszó hely ehhez az útvonalhoz.';

  @override
  String channelPath_primaryPath(int index) {
    return '$index elérési út (elsődleges)';
  }

  @override
  String get channelPath_pathLabelTitle => 'Útvonal';

  @override
  String get channelPath_observedPathHeader => 'Megfigyelt ösvény';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable =>
      'Ehhez a csomaghoz nem állnak rendelkezésre ugrási részletek.';

  @override
  String get channelPath_unknownRepeater => 'Ismeretlen Repeater';

  @override
  String get community_title => 'Közösség';

  @override
  String get community_create => 'Közösség létrehozása';

  @override
  String get community_createDesc =>
      'Hozzon létre egy új közösséget, és ossza meg QR-kóddal.';

  @override
  String get community_join => 'Csatlakozik';

  @override
  String get community_joinTitle => 'Csatlakozz a közösséghez';

  @override
  String community_joinConfirmation(String name) {
    return 'Szeretnél csatlakozni a \"$name\" közösséghez?';
  }

  @override
  String get community_scanQr => 'Scan Community QR';

  @override
  String get community_scanInstructions =>
      'Irányítsa a kamerát egy közösségi QR-kódra';

  @override
  String get community_showQr => 'QR-kód megjelenítése';

  @override
  String get community_publicChannel => 'Közösségi Nyilvános';

  @override
  String get community_hashtagChannel => 'Közösségi hashtag';

  @override
  String get community_name => 'Közösség neve';

  @override
  String get community_enterName => 'Adja meg a közösség nevét';

  @override
  String community_created(String name) {
    return 'A \"$name\" közösség létrehozva';
  }

  @override
  String community_joined(String name) {
    return 'Csatlakozott a \"$name\" közösséghez';
  }

  @override
  String get community_qrTitle => 'Közösség megosztása';

  @override
  String community_qrInstructions(String name) {
    return 'Olvassa be ezt a QR-kódot a \"$name\" csoporthoz való csatlakozáshoz';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'A közösségi hashtag csatornákhoz csak a közösség tagjai csatlakozhatnak';

  @override
  String get community_invalidQrCode => 'Érvénytelen közösségi QR-kód';

  @override
  String get community_alreadyMember => 'Már tag';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'Ön már tagja a(z) \"$name\".';
  }

  @override
  String get community_addPublicChannel =>
      'Közösségi nyilvános csatorna hozzáadása';

  @override
  String get community_addPublicChannelHint =>
      'Nyilvános csatorna automatikus hozzáadása ehhez a közösséghez';

  @override
  String get community_noCommunities => 'Még nem csatlakozott közösség';

  @override
  String get community_scanOrCreate =>
      'Olvassa be a QR-kódot, vagy hozzon létre egy közösséget a kezdéshez';

  @override
  String get community_manageCommunities => 'Közösségek kezelése';

  @override
  String get community_delete => 'Kilépés a közösségből';

  @override
  String community_deleteConfirm(String name) {
    return 'Kilép a(z) „$name” programból?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return 'Ezzel $count csatornát és azok üzeneteit is törli.';
  }

  @override
  String community_deleted(String name) {
    return 'Kilépett a \"$name\" közösségből';
  }

  @override
  String get community_regenerateSecret => 'Regeneráld a Titkot';

  @override
  String community_regenerateSecretConfirm(String name) {
    return 'Újragenerálja a titkos kulcsot a következőhöz: \"$name\"? A kommunikáció folytatásához minden tagnak be kell olvasnia az új QR-kódot.';
  }

  @override
  String get community_regenerate => 'Regenerátum';

  @override
  String community_secretRegenerated(String name) {
    return 'Titok újra létrehozva a következőhöz: \"$name\"';
  }

  @override
  String get community_updateSecret => 'Frissítse a Titkot';

  @override
  String community_secretUpdated(String name) {
    return 'Titok frissítve a következőhöz: \"$name\"';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return 'Olvassa be az új QR-kódot a „$name” titkának frissítéséhez';
  }

  @override
  String get community_addHashtagChannel => 'Közösségi hashtag hozzáadása';

  @override
  String get community_addHashtagChannelDesc =>
      'Adj hozzá egy hashtag-csatornát ehhez a közösséghez';

  @override
  String get community_selectCommunity => 'Válassza a Közösség lehetőséget';

  @override
  String get community_regularHashtag => 'Rendszeres hashtag';

  @override
  String get community_regularHashtagDesc =>
      'Nyilvános hashtag (bárki csatlakozhat)';

  @override
  String get community_communityHashtag => 'Közösségi hashtag';

  @override
  String get community_communityHashtagDesc =>
      'Privát a közösség tagjai számára';

  @override
  String community_forCommunity(String name) {
    return '$name';
  }

  @override
  String get listFilter_tooltip => 'Szűrés és rendezés';

  @override
  String get listFilter_sortBy => 'Rendezés';

  @override
  String get listFilter_latestMessages => 'Legújabb üzenetek';

  @override
  String get listFilter_heardRecently => 'Nemrég hallottam';

  @override
  String get listFilter_az => 'A-Z';

  @override
  String get listFilter_filters => 'Szűrők';

  @override
  String get listFilter_all => 'Minden';

  @override
  String get listFilter_favorites => 'Kedvencek';

  @override
  String get listFilter_addToFavorites => 'Hozzáadás a kedvencekhez';

  @override
  String get listFilter_removeFromFavorites => 'Eltávolítás a kedvencek közül';

  @override
  String get listFilter_users => 'Felhasználók';

  @override
  String get listFilter_repeaters => 'Ismétlők';

  @override
  String get listFilter_roomServers => 'Szobaszerverek';

  @override
  String get listFilter_unreadOnly => 'Csak olvasatlan';

  @override
  String get listFilter_newGroup => 'Új csoport';

  @override
  String get pathTrace_you => 'Te';

  @override
  String get pathTrace_failed => 'Az útvonal nyomon követése nem sikerült.';

  @override
  String get pathTrace_notAvailable => 'Útvonal nyomkövetés nem érhető el.';

  @override
  String get pathTrace_refreshTooltip => 'Path Trace frissítése.';

  @override
  String get pathTrace_someHopsNoLocation =>
      'Egy vagy több komló helye hiányzik!';

  @override
  String get pathTrace_clearTooltip => 'Tiszta útvonal.';

  @override
  String get losSelectStartEnd =>
      'Válassza ki a LOS kezdő és záró csomópontját.';

  @override
  String losRunFailed(String error) {
    return 'A rálátás ellenőrzése sikertelen: $error';
  }

  @override
  String get losClearAllPoints => 'Törölje az összes pontot';

  @override
  String get losRunToViewElevationProfile =>
      'Futtassa a LOS-t a magassági profil megtekintéséhez';

  @override
  String get losMenuTitle => 'LOS menü';

  @override
  String get losMenuSubtitle =>
      'Érintse meg a csomópontokat, vagy tartsa lenyomva a térképet az egyéni pontokhoz';

  @override
  String get losShowDisplayNodes => 'Megjelenítési csomópontok megjelenítése';

  @override
  String get losCustomPoints => 'Egyedi pontok';

  @override
  String losCustomPointLabel(int index) {
    return 'Egyéni $index';
  }

  @override
  String get losPointA => 'A pont';

  @override
  String get losPointB => 'B pont';

  @override
  String losAntennaA(String value, String unit) {
    return 'Antenna A: $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return 'B antenna: $value $unit';
  }

  @override
  String get losRun => 'Futtassa a LOS-t';

  @override
  String get losNoElevationData => 'Nincsenek magassági adatok';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, tiszta LOS, minimális távolság $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, blokkolta: $obstruction $heightUnit';
  }

  @override
  String get losStatusChecking => 'LOS: ellenőrzés...';

  @override
  String get losStatusNoData => 'LOS: nincs adat';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS: $clear/$total tiszta, $blocked blokkolva, $unknown ismeretlen';
  }

  @override
  String get losErrorElevationUnavailable =>
      'Egy vagy több mintához nem állnak rendelkezésre magassági adatok.';

  @override
  String get losErrorInvalidInput =>
      'Érvénytelen pontok/emelkedési adatok a LOS számításhoz.';

  @override
  String get losRenameCustomPoint => 'Egyéni pont átnevezése';

  @override
  String get losPointName => 'Pont neve';

  @override
  String get losShowPanelTooltip => 'LOS panel megjelenítése';

  @override
  String get losHidePanelTooltip => 'LOS panel elrejtése';

  @override
  String get losElevationAttribution =>
      'Magassági adatok: Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'Rádióhorizont';

  @override
  String get losLegendLosBeam => 'LOS gerenda';

  @override
  String get losLegendTerrain => 'Terep';

  @override
  String get losBlockedSpotsTitle => 'Blokkolt helyek';

  @override
  String get losBlockedSpotsHint =>
      'Koppintson egy blokkolt helyre, hogy kijelölje azt a térképen.';

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
  String get losSelectedObstructionTitle => 'Kiválasztott akadály';

  @override
  String losSelectedObstructionDetails(
    String obstruction,
    String heightUnit,
    String distanceFromA,
    String distanceUnit,
    String distanceFromB,
  ) {
    return 'Letiltja: $obstruction $heightUnit, $distanceFromA A-tól és $distanceFromB B-től ($distanceUnit).';
  }

  @override
  String get losFrequencyLabel => 'Frekvencia';

  @override
  String get losFrequencyInfoTooltip => 'Tekintse meg a számítás részleteit';

  @override
  String get losFrequencyDialogTitle => 'Rádióhorizont számítás';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'A k=$baselineK értéktől kezdve $baselineFreq MHz-en a számítás az aktuális $frequencyMHz MHz-es sávhoz igazítja a k-tényezőt, amely meghatározza az ívelt rádióhorizont-sapkát.';
  }

  @override
  String get contacts_pathTrace => 'Út nyom';

  @override
  String get contacts_ping => 'Ping';

  @override
  String get contacts_repeaterPathTrace =>
      'Útvonal nyomkövetése az átjátszóhoz';

  @override
  String get contacts_repeaterPing => 'Ping átjátszó';

  @override
  String get contacts_roomPathTrace => 'Útvonal nyomkövetése a szobaszerverhez';

  @override
  String get contacts_roomPing => 'Ping szoba szerver';

  @override
  String get contacts_chatTraceRoute => 'Út nyomvonala';

  @override
  String contacts_pathTraceTo(String name) {
    return 'Útvonal nyomon követése ide: $name';
  }

  @override
  String get contacts_clipboardEmpty => 'A vágólap üres.';

  @override
  String get contacts_pasteNotContact =>
      'Ez nem MeshCore-névjegy. Másolj egy meshcore:// névjegyhivatkozást vagy hirdetést, és próbáld újra.';

  @override
  String get contacts_invalidAdvertFormat =>
      'Érvénytelen kapcsolattartási adatok';

  @override
  String get contacts_contactImported => 'A névjegy importálása megtörtént.';

  @override
  String get contacts_contactImportFailed =>
      'Nem sikerült importálni a névjegyet.';

  @override
  String get contacts_zeroHopAdvert => 'Zero Hop hirdetés';

  @override
  String get contacts_floodAdvert => 'Árvíz hirdetés';

  @override
  String get contacts_copyAdvertToClipboard => 'Hirdetés másolása a vágólapra';

  @override
  String get contacts_addContactFromClipboard =>
      'Névjegy hozzáadása a vágólapról';

  @override
  String get contacts_ShareContact => 'Névjegy másolása a vágólapra';

  @override
  String get contacts_ShareContactZeroHop => 'Kapcsolat megosztása hirdetéssel';

  @override
  String get contacts_zeroHopContactAdvertSent =>
      'Az elérhetőséget hirdetéssel küldték el.';

  @override
  String get contacts_zeroHopContactAdvertFailed =>
      'Nem sikerült elküldeni a névjegyet.';

  @override
  String get contacts_contactAdvertCopied => 'A hirdetés a vágólapra másolva.';

  @override
  String get contacts_contactAdvertCopyFailed =>
      'A hirdetés vágólapra másolása nem sikerült.';

  @override
  String get notification_activityTitle => 'MeshCore tevékenység';

  @override
  String notification_messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'üzenetek',
      one: 'üzenet',
    );
    return '$count $_temp0';
  }

  @override
  String notification_channelMessagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'csatornaüzenetek',
      one: 'csatornaüzenet',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'új csomópontok',
      one: 'új csomópont',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return 'Új $contactType felfedezve';
  }

  @override
  String get notification_receivedNewMessage => 'Új üzenet érkezett';

  @override
  String get settings_gpxExportRepeaters =>
      'Ismétlők / szobaszerver exportálása GPX-be';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'Exportálja az átjátszókat / szobaszervereket a hellyel GPX-fájlba.';

  @override
  String get settings_gpxExportContacts => 'Exportáljon társokat a GPX-be';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'A hellyel rendelkező kísérőket GPX-fájlba exportálja.';

  @override
  String get settings_gpxExportAll => 'Az összes névjegy exportálása a GPX-be';

  @override
  String get settings_gpxExportAllSubtitle =>
      'A hellyel rendelkező összes névjegyet GPX-fájlba exportálja.';

  @override
  String get settings_gpxExportSuccess => 'A GPX fájl sikeresen exportálva.';

  @override
  String get settings_gpxExportNoContacts =>
      'Nincsenek exportálandó névjegyek.';

  @override
  String get settings_gpxExportNotAvailable => 'Az Ön eszköze/OS nem támogatja';

  @override
  String get settings_gpxExportError => 'Hiba történt az exportálás során.';

  @override
  String get settings_gpxExportRepeatersRoom =>
      'Repeater és szobaszerver helyei';

  @override
  String get settings_gpxExportChat => 'Társ helyek';

  @override
  String get settings_gpxExportAllContacts => 'Minden kapcsolattartó hely';

  @override
  String get settings_gpxExportShareText =>
      'A térképadatok a NOTORYX Core-ból exportálva';

  @override
  String get settings_gpxExportShareSubject =>
      'NOTORYX Core GPX térképadatok exportálása';

  @override
  String get snrIndicator_nearByRepeaters => 'Közeli átjátszók';

  @override
  String get snrIndicator_lastSeen => 'Utoljára látott';

  @override
  String get contactsSettings_title => 'Névjegyek beállításai';

  @override
  String get contactsSettings_autoAddTitle => 'Automatikus felfedezés';

  @override
  String get contactsSettings_otherTitle =>
      'Egyéb kapcsolattartási beállítások';

  @override
  String get contactsSettings_autoAddUsersTitle =>
      'Felhasználók automatikus hozzáadása';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      'Engedélyezze a társ számára, hogy automatikusan hozzáadja a felfedezett felhasználókat.';

  @override
  String get contactsSettings_autoAddRepeatersTitle =>
      'Ismétlők automatikus hozzáadása';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      'Engedélyezze a társnak, hogy automatikusan hozzáadja a felfedezett ismétlőket.';

  @override
  String get contactsSettings_autoAddRoomServersTitle =>
      'Szobaszerverek automatikus hozzáadása';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      'Engedélyezze a társ számára, hogy automatikusan hozzáadja a felfedezett szobaszervereket.';

  @override
  String get contactsSettings_autoAddSensorsTitle =>
      'Érzékelők automatikus hozzáadása';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      'Engedélyezze a társ számára a felfedezett érzékelők automatikus hozzáadását.';

  @override
  String get contactsSettings_overwriteOldestTitle => 'A legrégebbi felülírása';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      'Amikor a névjegylista megtelik, a legrégebbi, nem kedvenc névjegy lecserélődik.';

  @override
  String get discoveredContacts_Title => 'Felfedezett kapcsolatok';

  @override
  String get discoveredContacts_noMatching => 'Nincsenek megfelelő névjegyek';

  @override
  String get discoveredContacts_searchHint =>
      'Keresés a talált névjegyek között';

  @override
  String get discoveredContacts_contactAdded => 'Kapcsolat hozzáadva';

  @override
  String get discoveredContacts_addContact => 'Névjegy hozzáadása elemre';

  @override
  String get discoveredContacts_copyContact => 'Névjegy másolása a vágólapra';

  @override
  String get discoveredContacts_deleteContact =>
      'A felfedezett névjegy törlése';

  @override
  String get discoveredContacts_deleteContactAll =>
      'Törölje az összes felfedezett névjegyet';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      'Biztosan törli az összes felfedezett névjegyet?';

  @override
  String get chat_sendCooldown =>
      'Kérjük, várjon egy pillanatot, mielőtt újra elküldi.';

  @override
  String get appSettings_jumpToOldestUnread =>
      'Ugrás a legrégebbi olvasatlanra';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      'Ha olvasatlan üzeneteket tartalmazó csevegést nyit meg, görgessen az első olvasatlanra a legutóbbi helyett.';

  @override
  String get appSettings_languageHu => 'magyar';

  @override
  String get appSettings_languageJa => 'japán';

  @override
  String get appSettings_languageKo => 'koreai';

  @override
  String get radioStats_tooltip => 'Rádió és mesh statisztika';

  @override
  String get radioStats_screenTitle => 'Rádió statisztika';

  @override
  String get radioStats_notConnected =>
      'Csatlakozzon egy eszközhöz a rádióstatisztikák megtekintéséhez.';

  @override
  String get radioStats_firmwareTooOld =>
      'A rádióstatisztikákhoz v8-as vagy újabb firmware szükséges.';

  @override
  String get radioStats_waiting => 'Várakozás az adatokra…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'Zajszint: $noiseDbm dBm';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return 'Utolsó RSSI: $rssiDbm dBm';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return 'Utolsó SNR: $snr dB';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'TX műsoridő (összesen): $seconds s';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'RX műsoridő (összesen): $seconds s';
  }

  @override
  String get radioStats_chartCaption =>
      'Zajszint (dBm) a legutóbbi mintákhoz képest.';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'Zajszint: $noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting => 'Rádióstatisztikák lekérése…';

  @override
  String get radioStats_settingsTile => 'Rádió statisztika';

  @override
  String get radioStats_settingsSubtitle => 'Zajszint, RSSI, SNR és műsoridő';

  @override
  String get translation_title => 'Fordítás';

  @override
  String get imageMessages_enableTitle => 'Fenti hírüket biztosítani';

  @override
  String get imageMessages_enableSubtitle =>
      'Fényokat a hálózatban küldd el. Egyértelmű fénymodell hozzáadásra kell.';

  @override
  String get imageMessages_modelSectionTitle => 'Image model';

  @override
  String get imageMessages_downloadModel => 'Hozzáladás';

  @override
  String get imageMessages_cancelDownload => 'Színviselés';

  @override
  String get imageMessages_removeModel => 'Kisnövezdés';

  @override
  String get imageMessages_modelReady => 'Hozzá';

  @override
  String get imageMessages_modelNotPublished =>
      'Érkeztetve nem — ez a építési módszert nem lehet lejobbítani.';

  @override
  String get imageMessages_downloadFailed => 'Életmódelmát nem tudtam hozni.';

  @override
  String get imageMessages_autoProcessTitle =>
      'Automatikusan kínaltatja fénybetek';

  @override
  String get imageMessages_autoProcessSubtitle =>
      'Minden fenti image-t kiválasztsa meg, amikor érkezik. Minden más esetben 2 GB fényre kell szükséges; megoldja a rekonstruálisi a támogatásra egy klikkel.';

  @override
  String get translation_enableTitle => 'Fordítás engedélyezése';

  @override
  String get translation_enableSubtitle =>
      'Fordítsa le a bejövő üzeneteket, és engedélyezze a küldés előtti fordítást.';

  @override
  String get translation_composerTitle => 'Küldés előtt fordítsa le';

  @override
  String get translation_composerSubtitle =>
      'Szabályozza a zeneszerző fordítási ikonjának alapértelmezett állapotát.';

  @override
  String get translation_autoIncomingTitle =>
      'A bejövő üzenetek automatikus fordítása';

  @override
  String get translation_autoIncomingSubtitle =>
      'Automatikusan lefordítja az üzeneteket értesítésekhez, csevegéshez vagy csatornához.';

  @override
  String get translation_translateMessage => 'Üzenet fordítása';

  @override
  String get translation_targetLanguage => 'Célnyelv';

  @override
  String get translation_useAppLanguage => 'Használja az alkalmazás nyelvét';

  @override
  String get translation_downloadedModelLabel => 'Letöltött modell';

  @override
  String get translation_presetModelLabel =>
      'Előre beállított átölelő arc modell';

  @override
  String get translation_manualUrlLabel => 'Kézi modell URL';

  @override
  String get translation_downloadModel => 'Modell letöltése';

  @override
  String get translation_downloading => 'Letöltés...';

  @override
  String get translation_working => 'Dolgozó...';

  @override
  String get translation_stop => 'Stop';

  @override
  String get translation_mergingChunks =>
      'Letöltött darabok egyesítése a végső fájlba...';

  @override
  String get translation_downloadedModels => 'Letöltött modellek';

  @override
  String get translation_deleteModel => 'Modell törlése';

  @override
  String get translation_modelDownloaded => 'Fordítási modell letöltve.';

  @override
  String get translation_downloadStopped => 'A letöltés leállt.';

  @override
  String translation_downloadFailed(String error) {
    return 'Letöltés sikertelen: $error';
  }

  @override
  String get translation_enterUrlFirst => 'Először adja meg a modell URL-jét.';

  @override
  String get scanner_linuxPairingShowPin => 'PIN-kód megjelenítése';

  @override
  String get scanner_linuxPairingHidePin => 'PIN elrejtése';

  @override
  String get scanner_linuxPairingPinTitle => 'Bluetooth párosítási PIN';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return 'Írja be a $deviceName PIN-kódját (ha nincs, hagyja üresen).';
  }

  @override
  String get translation_messageTranslation => 'Üzenet fordítás';

  @override
  String get translation_translateBeforeSending => 'Küldés előtt fordítsa le';

  @override
  String get translation_composerEnabledHint =>
      'Az üzeneteket elküldés előtt lefordítják.';

  @override
  String get translation_composerDisabledHint =>
      'Üzeneteket küldhet az eredeti gépelt nyelven.';

  @override
  String translation_translateTo(String language) {
    return 'Fordítás $language';
  }

  @override
  String get translation_translationOptions => 'Fordítási lehetőségek';

  @override
  String get translation_systemLanguage => 'Rendszer nyelve';

  @override
  String get background_serviceTitle => 'MeshCore fut';

  @override
  String get background_serviceText => 'A BLE-kapcsolat fenntartása';

  @override
  String appSettings_translationModelDeleted(String name) {
    return 'Törölve $name';
  }

  @override
  String appSettings_translationModelDeleteFailed(String error) {
    return 'Nem sikerült törölni: $error';
  }

  @override
  String channels_channelUpdateFailed(String error) {
    return 'Nem sikerült frissíteni a csatornát: $error';
  }

  @override
  String get contact_typeChat => 'Csevegés';

  @override
  String get contact_typeRepeater => 'Ismétlő';

  @override
  String get contact_typeRoom => 'Szoba';

  @override
  String get contact_typeSensor => 'Érzékelő';

  @override
  String get contact_typeUnknown => 'Ismeretlen';

  @override
  String get map_zoomIn => 'Nagyítás';

  @override
  String get map_zoomOut => 'Kicsinyítés';

  @override
  String get map_centerMap => 'Középső térkép';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'A Web Bluetooth használatához Chromium böngésző szükséges';

  @override
  String channels_communityShortId(String id) {
    return 'ID: $id...';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'GPS megerősítve';

  @override
  String get pathTrace_legendInferred => 'Kikövetkeztetett pozíció';

  @override
  String get pathMap_viewSingle => 'Egyetlen';

  @override
  String get pathMap_viewCombined => 'Kombinált';

  @override
  String get pathMap_play => 'Játék';

  @override
  String get pathMap_pause => 'Szünet';

  @override
  String get pathMap_replay => 'Visszajátszás';

  @override
  String get pathMap_stepBack => 'Előző ugrás';

  @override
  String get pathMap_stepForward => 'Következő ugrás';

  @override
  String get pathMap_animationOn => 'Csomaganimáció megjelenítése';

  @override
  String get pathMap_animationOff => 'Csomaganimáció elrejtése';

  @override
  String pathMap_hopOf(int current, int total) {
    return '$current ugrás / $total';
  }

  @override
  String pathMap_observedPaths(int count) {
    return 'Megfigyelt útvonalak: $count';
  }

  @override
  String get pathMap_primary => 'Elsődleges';

  @override
  String pathMap_alternate(int index) {
    return 'Alt $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ugrás',
      one: '1 ugrás',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => 'Megosztott szegmens';

  @override
  String get pathMap_legendEstimated => 'Becsült szegmens';

  @override
  String pathMap_sharedNodeCount(int count) {
    return '$count elérési út használja';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count ugrásnak nincs helyadata — a megjelenített útvonal részleges',
      one: '1 ugrásnak nincs helyadata — a megjelenített útvonal részleges',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'Összes megjelenítése';

  @override
  String get pathMap_hidePath => 'Útvonal elrejtése';

  @override
  String get pathMap_showPath => 'Útvonal megjelenítése';

  @override
  String get pathMap_collapsePanel => 'Panel összecsukása';

  @override
  String get pathMap_expandPanel => 'Panel kibontása';

  @override
  String get pathMap_noLocation => 'Nincs hely';

  @override
  String get pathMap_followPacket => 'Nézet zárolása a csomaghoz';

  @override
  String get pathMap_unfollowPacket => 'A nézet feloldása a csomagból';

  @override
  String get imageSend_title => 'Felhasználj az image';

  @override
  String get imageSend_cropNote =>
      '512 × 512 órák számára megosztva · képszöget nem biztosítva';

  @override
  String get imageSend_originalSize => 'Következtetés:';

  @override
  String get imageSend_onAirSize => 'Erőben';

  @override
  String get imageSend_quality => 'Hosszú Képesség';

  @override
  String get imageSend_qualityStandard => 'Standard';

  @override
  String get imageSend_qualityHigh => 'High: Magas';

  @override
  String get imageSend_packetsLabel => 'Paketek';

  @override
  String get imageSend_airtimeLabel => 'Kiválasztás a fent';

  @override
  String get imageSend_sizeLabel => 'Kártya';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'csomag',
      one: 'csomag',
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
  String get imageSend_radioUnknownTitle => 'Radiooldalok nem tudom';

  @override
  String get imageSend_radioUnknownBody =>
      'Kizárdhoz kapcsolódd a rendszert, hogy a súly az az álló időt lehet elismerni.';

  @override
  String get imageSend_longSendTitle => 'Uzun hírás';

  @override
  String imageSend_longSendBody(String duration) {
    return 'Ez megbízható a kanal $duration-n.';
  }

  @override
  String get imageSend_floodNote =>
      'Fúró irányozás: Minden repeater a fúró körüléggel megköveti mindkét paketet, ezért a kanal eltartja más a lehetséges időt.';

  @override
  String get imageSend_parityTitle => 'Korzolás paksa';

  @override
  String get imageSend_paritySubtitle =>
      'Egy kibőbbes kapszula. Gruppos hírselek nem érkezik, ezért az empfangó nem kell elismerni a jel, ha egy egyes kapszula kaland, hogy nem teljesen érkezz.';

  @override
  String get imageSend_send => 'Keresés';

  @override
  String get imageSend_cancel => 'Színviselés';

  @override
  String get imageSend_encodeFailed => 'Ez a fényet nem tudtam kódolni.';

  @override
  String get imageSend_codecDownloading =>
      'Érdekesz az image model megstálása még van.';

  @override
  String get imageSend_codecUnavailable =>
      'Felhasználó észintje nem kapható ezen a rendszert.';

  @override
  String get imageSend_codecDisabled =>
      'Image hírletek belsőoldal elkalmáznak a konfigurációban.';

  @override
  String get imageSend_deviceUnsupported =>
      'Ez a radio nem tudja verseni színekfájltakat. Habilítd a kompatibilis firmware 13 vagy újabb versionot kapcsált eszközet.';

  @override
  String get imageSend_directMessagesUnsupported =>
      'Fényiak gyakorolják grupos adatban, ezért nem lehetek versenek egy hozzáfűzésre, csak egy kanalra.';

  @override
  String get imageSend_tooLarge =>
      'A figyelmetes fentet nem kínálhat a körközlettel ismétálás elterjesztésére.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'csomagként',
      one: 'csomagként',
    );
    return 'Kép elküldve $count $_temp0.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return 'Fentami nem tűnik: $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return 'Felhasználó: Lehet a következőkét kifejezetet – $sent paket $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'Node $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return 'Kulcsfontosságú: Kiválasztja meg a $received $total paketot';
  }

  @override
  String get receivedImage_queued => 'Kódoláshoz küldőzve';

  @override
  String get receivedImage_tapToDecode => 'Kódoláshoz klikd el';

  @override
  String get receivedImage_decoding => 'Korlátozás… egy 1 perc után';

  @override
  String receivedImage_incomplete(int received, int total) {
    return 'Kérem, az $received $total paketet kapottak.';
  }

  @override
  String get receivedImage_corrupt => 'Fény nem tudtam megrealítani';

  @override
  String get receivedImage_decoderMissing =>
      'Kezd az image — image decodálás nem kapható';

  @override
  String get receivedImage_evicted => 'Fény nem tartalmazva';

  @override
  String get receivedImage_retry => 'Kérem kell próbálni';

  @override
  String get receivedImage_decodeAgain => 'Kodoldó';

  @override
  String get receivedImage_openSettings => 'Jelzése';

  @override
  String get receivedImage_tapToProcess => 'Klikd a feljelenítést';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'csomag',
      one: 'csomag',
    );
    return '$bytes bájt · $packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds sekünd\n\n(Note: The placeholder $seconds is kept unchanged as requested.)';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes per $seconds sekünd\n\n(Note: The original text appears to be a placeholder format rather than a complete sentence. The translation reflects the literal structure while preserving the placeholders as requested.)';
  }

  @override
  String get bastion_tagline => 'Kommunikáció infrastruktúra nélkül.';

  @override
  String get bastion_nodes => 'Csomópontok';

  @override
  String get bastion_repeaters => 'Ismétlők';

  @override
  String get bastion_active1h => 'Aktív 1 óra';

  @override
  String get bastion_mapCoverage => 'Térkép + lefedettség';

  @override
  String get bastion_routeIntelligence => 'Útvonalelemzés';

  @override
  String get bastion_repeaterTools => 'Ismétlőeszközök';

  @override
  String get bastion_fieldStats => 'Terepi statisztika';

  @override
  String get bastion_fieldOps => 'Túra + terepi műveletek';

  @override
  String get bastion_coverageCapture => 'Lefedettségrögzítés';

  @override
  String get bastion_mapAttribution =>
      'Térképadatok © OpenStreetMap-közreműködők; csempék a választott szolgáltatótól';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count megfigyelés',
      one: '1 megfigyelés',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count egyedi csomópont',
      one: '1 egyedi csomópont',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ugrás',
      one: '1 ugrás',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count perc',
      one: '1 perc',
    );
    return '$_temp0';
  }

  @override
  String get sos_holdHint =>
      'Tartsa nyomva 2 másodpercig. 5 percenként elküldi a pozícióját a túrakapcsolatainak, amíg valaki nem válaszol.';

  @override
  String sos_holdHintChannel(String channel) {
    return 'Tartsa nyomva 2 másodpercig. 5 percenként elküldi a pozícióját a túrakapcsolatainak és a(z) $channel csatornának, amíg valaki nem válaszol.';
  }

  @override
  String sos_notSent(String error) {
    return 'Az SOS nem lett elküldve: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return '$name visszaigazolta. Az ismétlések leálltak.';
  }

  @override
  String get sos_waitingForRadio => 'Várakozás a rádió küldésére…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return 'Elküldve $sends/$max alkalommal. Az ismétlések befejeződtek; még nincs válasz.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return 'Elküldve $sends/$max alkalommal. Következő: $time.';
  }

  @override
  String get sos_active => 'SOS AKTÍV';

  @override
  String get sos_stop => 'LEÁLLÍTÁS';

  @override
  String get sos_imSafe => 'BIZTONSÁGBAN VAGYOK';

  @override
  String get sos_holdSemantics => 'SOS. Tartsa nyomva a küldéshez.';

  @override
  String get sos_keepHolding => 'TARTSA TOVÁBB…';

  @override
  String get sos_holdForSos => 'TARTSA NYOMVA AZ SOS-HEZ';

  @override
  String get sos_blockStorage =>
      'Előbb hárítsa el a terepnapló tárolási hibáját.';

  @override
  String get sos_blockNotConnected =>
      'Csatlakoztassa MeshCore rádióját az SOS küldéséhez.';

  @override
  String get sos_blockNoTarget =>
      'Válasszon túrakapcsolatokat vagy SOS-csatornát a Túra tervezése menüben.';

  @override
  String get checkIn_labelOk => 'Jól vagyok';

  @override
  String get checkIn_labelAtCamp => 'A táborban';

  @override
  String get checkIn_labelDelayed => 'Késésben';

  @override
  String get checkIn_labelHeadingBack => 'Visszafelé tartok';

  @override
  String get checkIn_blockLoading => 'A túra betöltése…';

  @override
  String get checkIn_blockStorage =>
      'Küldés előtt hárítsa el a terepnapló tárolási hibáját.';

  @override
  String get checkIn_blockBusy =>
      'Egy bejelentkezés küldése folyamatban. Kérjük, várjon.';

  @override
  String get checkIn_blockNoContacts =>
      'Válasszon túrakapcsolatokat a Túra tervezése menüben.';

  @override
  String get checkIn_blockRosterIncomplete =>
      'Néhány túrakapcsolat nem érhető el. Ellenőrizze a listát.';

  @override
  String get checkIn_blockNotConnected =>
      'Csatlakoztassa MeshCore rádióját a bejelentkezéshez.';

  @override
  String get checkIn_blockNotActive =>
      'Indítsa el a túrát a bejelentkezések engedélyezéséhez.';

  @override
  String get checkIn_notSent => 'Nincs elküldve';

  @override
  String checkIn_deliveredToOne(String name) {
    return 'Kézbesítve neki: $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return 'Kézbesítve mind a(z) $count kapcsolatnak';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return 'Kézbesítve $delivered/$total kapcsolatnak';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return 'Nincs kézbesítve: $names';
  }

  @override
  String get checkIn_waitingForRest => 'Várakozás a többiekre';

  @override
  String get checkIn_aContact => 'egy kapcsolat';

  @override
  String get checkIn_statusPending => 'Függőben';

  @override
  String get checkIn_statusSent => 'Elküldve';

  @override
  String get checkIn_statusDelivered => 'Kézbesítve';

  @override
  String get checkIn_statusFailed => 'Sikertelen';

  @override
  String get checkIn_explainPending =>
      'Helyben sorba állítva. Ez nem igazolja a rádióadást vagy a vételt.';

  @override
  String get checkIn_explainSent =>
      'A rádió elfogadta a küldést. Kézbesítési visszaigazolás nem érkezett.';

  @override
  String get checkIn_explainDelivered =>
      'Az alkalmazás kézbesítési visszaigazolást rögzített. Ez nem bizonyítja, hogy a címzett el is olvasta.';

  @override
  String get checkIn_explainFailed =>
      'Nincs megerősített kézbesítés. Ellenőrizze a rádiókapcsolatot, a címzett elérhetőségét és az újrapróbálkozások előzményeit.';

  @override
  String get checkIn_explainUnknown =>
      'A kézbesítési állapot nem érhető el. Ne feltételezze, hogy az üzenet megérkezett.';

  @override
  String get tripBrief_heading => 'NOTORYX • MeshCore túraösszefoglaló';

  @override
  String tripBrief_trip(String name) {
    return 'Túra: $name';
  }

  @override
  String tripBrief_status(String status) {
    return 'Állapot: $status';
  }

  @override
  String get tripBrief_active => 'Aktív';

  @override
  String get tripBrief_stopped => 'Leállítva';

  @override
  String tripBrief_contacts(String names) {
    return 'Kapcsolatok: $names';
  }

  @override
  String get tripBrief_noneSelected => 'Nincs kiválasztva';

  @override
  String get tripBrief_unavailableContact =>
      'Nem elérhető kapcsolat (ellenőrizze a listát)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return 'Az aktivitás késik ennyi után: $minutes perc (ez a telefon figyelmeztet, ha egy kapcsolat elhallgat)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'Bejelentkezési emlékeztető: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return '$minutes percenként bejelentkezés nélkül';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'Bejelentkezési lehetőségek: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'Rádiópozíció a bejelentkezésekben: $value';
  }

  @override
  String get tripBrief_includedMayBeStale => 'Benne van; elavult lehet';

  @override
  String tripBrief_battery(String value) {
    return 'Rádióakkumulátor a bejelentkezésekben: $value';
  }

  @override
  String get tripBrief_included => 'Benne van';

  @override
  String get tripBrief_off => 'Ki';

  @override
  String get tripBrief_review =>
      'Bejelentkezés küldése előtt ellenőrizze a címzetteket és az üzenetet.';

  @override
  String get tripBrief_noProof =>
      'A sorba állítás vagy elküldés nem bizonyítja a kézbesítést. A visszaigazolás nem bizonyítja, hogy elolvasták.';

  @override
  String get tripBrief_overdueMeaning =>
      'A késés azt jelenti, hogy nincs friss kapcsolati aktivitás; ez nem megerősített vészhelyzet.';

  @override
  String get tripBrief_automations =>
      'A terepi automatizálások csak akkor futnak, ha az alkalmazás aktív. Egyezzenek meg külön tervben elmaradt kapcsolat esetére.';

  @override
  String get tripBrief_sharesOnly =>
      'Ez az összefoglaló csak információt oszt meg; nem küld rádióüzenetet és nem indít túrát.';

  @override
  String get fieldOps_title => 'NOTORYX Core terepi műveletek';

  @override
  String get fieldOps_tabTrip => 'Túra';

  @override
  String get fieldOps_tabReady => 'Kész';

  @override
  String get fieldOps_tabLog => 'Napló';

  @override
  String get fieldOps_tabAuto => 'Auto';

  @override
  String get fieldOps_tabCoverage => 'Lefedettség';

  @override
  String get fieldOps_tabConnection => 'Kapcsolat';

  @override
  String get fieldOps_diagnostics => 'Diagnosztika';

  @override
  String get fieldOps_storageLoadError =>
      'A terepi adatokat nem sikerült betölteni. A mentett adatok megmaradtak; az automatizálások kikapcsolva maradnak.';

  @override
  String get fieldOps_storageSaveError =>
      'A terepi adatokat nem sikerült menteni. Az automatizálások leálltak; a meglévő mentett adatok megmaradnak.';

  @override
  String get fieldOps_regionHint =>
      'Válasszon területet és nagyítási szinteket az Offline térképek menüben.';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • nagyítás $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return 'A térképterületet nem sikerült ellenőrizni: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Túra aktív • $count kapcsolat',
      one: 'Túra aktív • 1 kapcsolat',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped =>
      'A túra le van állítva. Indítsa el, ha készen áll.';

  @override
  String fieldOps_reminderAt(String time) {
    return 'Bejelentkezési emlékeztető ekkor: $time';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return 'Túl régóta hallgat: $names';
  }

  @override
  String get fieldOps_planTrip => 'Túra tervezése';

  @override
  String get fieldOps_endTrip => 'Túra befejezése';

  @override
  String get fieldOps_startTrip => 'Túra indítása';

  @override
  String get fieldOps_tripBrief => 'Túraösszefoglaló';

  @override
  String get fieldOps_connectRadio => 'Rádió csatlakoztatása';

  @override
  String get fieldOps_previewedCheckIns => 'Előnézetes bejelentkezések';

  @override
  String get fieldOps_previewedCheckInsHint =>
      'Válasszon állapotot, ellenőrizze a tényleges címzetteket és az üzenetet, majd küldje el. A sorba állítás nem jelent kézbesítést.';

  @override
  String get fieldOps_tripRoster => 'Túralista';

  @override
  String get fieldOps_rosterEmpty =>
      'Válasszon legfeljebb hat ismert csevegőkapcsolatot a Túra tervezése menüben.';

  @override
  String get fieldOps_rosterCaveat =>
      'A „legutóbb hallott” korábbi aktivitást bizonyít. Nem igazolja a jelenlegi elérhetőséget. A késés jelzései friss kapcsolati aktivitás hiányát jelentik, nem megerősített vészhelyzetet.';

  @override
  String get fieldOps_offlineMaps => 'Offline térképek';

  @override
  String get fieldOps_checkingTiles => 'Mentett csempék ellenőrzése…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gyorsítótárazott csempe.',
      one: '1 gyorsítótárazott csempe.',
    );
    return '$_temp0 Ez nem garantálja, hogy a teljes útvonal le van fedve.';
  }

  @override
  String get fieldOps_downloadAreas =>
      'Offline területek letöltése / ellenőrzése';

  @override
  String fieldOps_lastCheckIn(String time) {
    return 'Utolsó bejelentkezés, $time';
  }

  @override
  String fieldOps_deliveryChip(String name, String status) {
    return '$name: $status';
  }

  @override
  String get fieldOps_contactFallback => 'Kapcsolat';

  @override
  String fieldOps_resendFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Újraküldés $count kézbesítetlennek',
      one: 'Újraküldés 1 kézbesítetlennek',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable =>
      'A kiválasztott kapcsolat nem érhető el';

  @override
  String get fieldOps_memberUnavailableHint =>
      'Küldés előtt ellenőrizze ezt a túrát.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return 'Utolsó aktivitás $minutes perce';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return 'Utolsó aktivitás $minutes perce • késik';
  }

  @override
  String get fieldOps_noCheckInRecorded =>
      'Ebben a naplóban nincs rögzített bejelentkezés.';

  @override
  String get fieldOps_tripMap => 'Túratérkép';

  @override
  String get fieldOps_tripMapEmpty =>
      'Egyik kiválasztott kapcsolat sem sugárzott még koordinátákat.';

  @override
  String get fieldOps_lastPositions => 'Utoljára sugárzott pozíciók';

  @override
  String get fieldOps_positionsCaveat =>
      'A pozíciók elavultak lehetnek. Ez a térkép nem követi a telefon GPS-ét, és nem bizonyítja, hogy a tagok most itt vannak.';

  @override
  String get fieldOps_briefPreviewTitle => 'Túraösszefoglaló előnézete';

  @override
  String get fieldOps_briefPreviewHint =>
      'Tartalmazza a túra és a kapcsolatok nevét. Megosztás előtt ellenőrizze. A koordináták, kulcsok és üzenetelőzmények kimaradnak.';

  @override
  String get fieldOps_shareBrief => 'Összefoglaló megosztása';

  @override
  String get fieldOps_briefSubject => 'NOTORYX Core túraösszefoglaló';

  @override
  String get fieldOps_tripName => 'Túra neve';

  @override
  String get fieldOps_defaultTripName => 'Saját túra';

  @override
  String get fieldOps_includePosition => 'Sugárzott rádiópozíció hozzáadása';

  @override
  String get fieldOps_includePositionHint =>
      'Elavult lehet; a megosztás alapértelmezetten ki van kapcsolva.';

  @override
  String get fieldOps_includeBattery => 'Rádióakkumulátor hozzáadása';

  @override
  String get fieldOps_overdueLabel =>
      'Figyelmeztessen, ha egy kapcsolat ennyi ideje hallgat';

  @override
  String get fieldOps_reminderLabel => 'Emlékeztessen a bejelentkezésre';

  @override
  String get fieldOps_reminderHelper =>
      'Telefonos értesítés, akkor is, ha a NOTORYX Core be van zárva.';

  @override
  String get fieldOps_reminderOff => 'Ki';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count perc bejelentkezés nélkül után',
      one: '1 perc bejelentkezés nélkül után',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'Az SOS erre a csatornára is megy';

  @override
  String get fieldOps_sosChannelNone => 'Nincs';

  @override
  String get fieldOps_selectContacts =>
      'Válasszon legfeljebb hat ismert csevegőkapcsolatot';

  @override
  String get fieldOps_sendCheckInTitle => 'Elküldi a bejelentkezést?';

  @override
  String fieldOps_recipients(String names) {
    return 'Címzett: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      'Normál közvetlen üzeneteket használ. A kézbesítés a terepnaplóban követhető.';

  @override
  String get fieldOps_send => 'Küldés';

  @override
  String get fieldOps_beforeYouLeave => 'Indulás előtt';

  @override
  String get fieldOps_radioConnected => 'Rádió csatlakoztatva';

  @override
  String get fieldOps_connectHint =>
      'Csatlakozzon Bluetooth, USB vagy TCP kapcsolaton.';

  @override
  String get fieldOps_radioBattery => 'Rádióakkumulátor';

  @override
  String get fieldOps_batteryUnknown => 'Ismeretlen; ellenőrizze a rádiót.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent% • töltse fel a tervezett túrához.';
  }

  @override
  String get fieldOps_tripContacts => 'Túrakapcsolatok';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return '$available/$selected elérhető. Ellenőrizze, hogy kompatibilis rádióik és csatornáik vannak-e.';
  }

  @override
  String get fieldOps_offlineArea => 'Kiválasztott offline térképterület';

  @override
  String get fieldOps_checkingFiles => 'Helyi fájlok ellenőrzése…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return '$available/$expected csempefájl érhető el; $missing hiányzik. Ez pillanatkép; indulás előtt nyissa meg a területet offline.';
  }

  @override
  String get fieldOps_locationChoice => 'Helymegosztás';

  @override
  String get fieldOps_locationOptedIn =>
      'Bekapcsolva: a rádió által sugárzott koordináták elavultak lehetnek.';

  @override
  String get fieldOps_locationOff =>
      'A megosztás ki van kapcsolva. A bejelentkezései nem tartalmaznak koordinátákat.';

  @override
  String get fieldOps_automationAvailability => 'Az automatizálás elérhetősége';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'Csak akkor fut, ha ez az alkalmazás aktív. Alvó mód, bezárás vagy a rádió elvesztése megakadályozhatja az ütemezett műveleteket.';

  @override
  String get fieldOps_readinessCaveat =>
      'A felkészültségi ellenőrzések tájékoztató jellegűek; nem bizonyítják a rádió hatótávolságát és nem garantálják a kézbesítést.';

  @override
  String get fieldOps_radio => 'Rádió';

  @override
  String get fieldOps_refreshChecks => 'Ellenőrzések frissítése';

  @override
  String get fieldOps_searchLog => 'Keresés a terepnaplóban';

  @override
  String get fieldOps_kindAll => 'Mind';

  @override
  String get fieldOps_kindCheckIn => 'Bejelentkezés';

  @override
  String get fieldOps_kindReceived => 'Fogadott';

  @override
  String get fieldOps_kindNote => 'Jegyzet';

  @override
  String get fieldOps_kindDeadZone => 'Holtzóna';

  @override
  String get fieldOps_kindRadio => 'Rádió';

  @override
  String get fieldOps_kindAutomation => 'Automatizálás';

  @override
  String get fieldOps_kindMissed => 'Elmaradt';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => 'Túra';

  @override
  String get fieldOps_kindOverdue => 'Késik';

  @override
  String get fieldOps_addNote => 'Jegyzet hozzáadása';

  @override
  String get fieldOps_exportJson => 'JSON exportálása';

  @override
  String get fieldOps_deleteLog => 'Napló törlése';

  @override
  String get fieldOps_logSubject => 'NOTORYX Core terepnapló';

  @override
  String get fieldOps_logCaveat =>
      'Helyben tárolva, legfeljebb 1000 bejegyzés. Az exportok kapcsolati kulcsokat, üzeneteket és helyeket tartalmazhatnak; megosztás előtt ellenőrizze.';

  @override
  String get fieldOps_noEntries => 'Nincs egyező bejegyzés.';

  @override
  String get fieldOps_tripUnspecified => 'Nem megadott túra';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return 'Rögzített sugárzott rádiópozíció $latitude, $longitude (elavult lehet)';
  }

  @override
  String get fieldOps_noteTitle => 'Terepi megfigyelés';

  @override
  String get fieldOps_noteLabel => 'Mit figyelt meg?';

  @override
  String get fieldOps_deadZone => 'Jelentett holtzóna';

  @override
  String get fieldOps_deadZoneHint =>
      'Az Ön megfigyelése, nem ellenőrzött lefedettségi előrejelzés.';

  @override
  String get fieldOps_savePosition => 'Sugárzott rádiópozíció mentése';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • elavult lehet; nem a telefon GPS-e';
  }

  @override
  String get fieldOps_noPosition => 'Nincs használható sugárzott koordináta';

  @override
  String get fieldOps_deleteLogTitle => 'Törli a terepnaplót?';

  @override
  String get fieldOps_deleteLogBody =>
      'Ez eltávolítja az összes mentett bejegyzést erről a telefonról. A túrabeállítások megmaradnak.';

  @override
  String get fieldOps_localAutomations => 'Helyi automatizálások';

  @override
  String get fieldOps_enableForTrip => 'Engedélyezés ehhez a túrához';

  @override
  String get fieldOps_automationsCaveat =>
      'Minden alkalmazás-újraindítás után kikapcsol. A szabályok csak akkor futnak, ha az alkalmazás aktív. Az elmaradt ütemezett műveletek megjelennek a terepnaplóban, és soha nem pótlódnak egyszerre. Az automatikus bejelentkezések 10 percenként egy körre korlátozódnak.';

  @override
  String get fieldOps_openBotMode => 'NOTORYX botmód megnyitása';

  @override
  String get fieldOps_ruleEnabled => 'Szabály engedélyezve';

  @override
  String get fieldOps_dryRun => 'Próbafuttatás';

  @override
  String get fieldOps_dryRunHint =>
      'A művelet rögzítése küldés és értesítés nélkül.';

  @override
  String get fieldOps_then => 'Akkor';

  @override
  String get fieldOps_actionLog => 'Írás a terepnaplóba';

  @override
  String get fieldOps_actionNotify => 'Helyi értesítés megjelenítése';

  @override
  String get fieldOps_actionCheckIn => '„I\'m OK” küldése a túrakapcsolatoknak';

  @override
  String get fieldOps_batteryThreshold => 'Akkumulátor ennyi vagy kevesebb';

  @override
  String fieldOps_nextDue(String time) {
    return 'Következő: $time';
  }

  @override
  String get fieldOps_nextDueNone => 'Következő: nincs ütemezve';

  @override
  String get fieldOps_previewInLog => 'Előnézet a naplóban';

  @override
  String get fieldOps_allowNotifications => 'Értesítések engedélyezése';

  @override
  String get fieldOps_triggerReconnect => 'HA a rádió újracsatlakozik';

  @override
  String get fieldOps_triggerDisconnect => 'HA a rádió leválik';

  @override
  String get fieldOps_triggerLowBattery =>
      'HA a rádióakkumulátor átlépi a küszöböt';

  @override
  String get fieldOps_triggerNewNode => 'HA új csomópont kerül hozzáadásra';

  @override
  String get fieldOps_triggerRepeater => 'HA új ismétlő kerül hozzáadásra';

  @override
  String get fieldOps_triggerScheduled =>
      'HA esedékes egy ütemezett bejelentkezés';

  @override
  String get fieldOps_explainConnection => 'Kapcsolatom magyarázata';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return 'Állapot: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      'A telefonnak van rádiókapcsolata. Ez önmagában nem biztosít útvonalat a címzettekhez.';

  @override
  String get fieldOps_disconnectedHint =>
      'Nincs aktív rádiókapcsolat. Ellenőrizze a Bluetooth-engedélyeket, a rádió tápellátását és hatótávolságát; USB/TCP a Rádió csatlakoztatása menüben érhető el.';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return 'Visszaigazolásra váró túrabejelentkezések: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'A csomópontok utoljára látott időpontjai és sugárzott pozíciói elavultak lehetnek. Az útvonalelemzés megfigyelt kísérletekből tanult útvonalakat mutat; nem talál ki utakat.';

  @override
  String get fieldOps_routeIntelligence => 'Útvonalelemzés';

  @override
  String get fieldOps_coverageIntelligence => 'Lefedettségelemzés';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      'Hasonlítsa össze két terepi munkamenet rögzített megfigyeléseit. A pontok a rögzítő sugárzott rádiópozícióit jelölik, ahol csomópontokat hallott. Nem jelentenek folyamatos lefedettséget. Az RSSI/SNR pillanatképek nem csomópontonkénti mérések.';

  @override
  String get fieldOps_captureSession => 'Munkamenet rögzítése';

  @override
  String get fieldOps_refreshHistory => 'Előzmények frissítése';

  @override
  String get fieldOps_noCoverageSessions =>
      'Még nincs mentett lefedettségi munkamenet.';

  @override
  String get fieldOps_sessionA => 'A munkamenet • kékeszöld';

  @override
  String get fieldOps_sessionB => 'B munkamenet • borostyán';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: $a egyedi csomópont • B: $b egyedi csomópont';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return 'Közös: $shared • Csak A: $onlyA • Csak B: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'Ha egy csomópont nem hallható egy munkamenetben, az nem igazol holtzónát. A körülmények és a megfigyelés időtartama eltérnek.';

  @override
  String get fieldOps_heardTooltip =>
      'Hallott csomópont megfigyelése; nem bizonyítja a sikeres kapcsolatot';

  @override
  String get fieldOps_noteTooltip =>
      'Helyi jegyzet a rádió által sugárzott koordinátáknál; elavult lehet.';

  @override
  String get bastionHome_aboutTooltip => 'A NOTORYX Core-ról';

  @override
  String get bastionHome_getStarted => 'Első lépések';

  @override
  String get bastionHome_getStartedHint =>
      'Csatlakoztassa a rádiót, és ellenőrizze az első üzenetét';

  @override
  String get bastionHome_planYourTrip => 'Tervezze meg a túrát';

  @override
  String get bastionHome_tripActive => 'Túra aktív';

  @override
  String get bastionHome_tripStopped => 'Túra leállítva';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • $contacts kapcsolat • $unread olvasatlan üzenet';
  }

  @override
  String get bastionHome_checkInOk => 'Bejelentkezés: jól vagyok';

  @override
  String get bastionHome_checkInHint =>
      'Küldés előtt ellenőrizze a kapcsolatokat és az üzenetet. A visszaigazolásokat a terepnaplóban követheti.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return 'Utolsó bejelentkezés: $summary';
  }

  @override
  String get bastionHome_connectRadio => 'Rádió csatlakoztatása';

  @override
  String get bastionHome_connectRadioHint =>
      'MeshCore-kapcsolatok Bluetooth, USB és TCP útján';

  @override
  String get bastionHome_liveDiagnostics => 'Élő diagnosztika';

  @override
  String get bastionHome_liveDiagnosticsHint =>
      'Rádióállapot, jel, eszköz és keretkezelő eszközök';

  @override
  String get bastionHome_meshDiscovery => 'Hálózatfelderítés';

  @override
  String get bastionHome_meshDiscoveryHint =>
      'Keressen csomópontokat, és vizsgálja meg a környező hálózatot';

  @override
  String get bastionHome_fieldOpsHint =>
      'Túraösszefoglaló, felkészültség, terepnapló, automatizálások és lefedettség-összehasonlítás';

  @override
  String get bastionHome_fieldTools => 'NOTORYX terepi eszközök';

  @override
  String get bastionHome_statusActive => 'AKTÍV';

  @override
  String get bastionHome_consoleOnline => 'Terepi konzol online';

  @override
  String get bastionHome_consoleReady => 'Terepi konzol kész';

  @override
  String get bastionHome_consoleHint =>
      'Csatlakoztasson egy rádiót az élő irányítópult bekapcsolásához.';

  @override
  String bastionHome_battery(String value) {
    return 'Akku $value';
  }

  @override
  String get bastionTools_title => 'Terepi eszközök';

  @override
  String get bastionTools_backup => 'Titkosított biztonsági mentés';

  @override
  String get bastionTools_backupHint =>
      'Beállítások, kapcsolatok és kulcsok mentése, opcionálisan csevegési előzményekkel';

  @override
  String get bastionTools_fieldOpsHint =>
      'Bejelentkezések, felkészültség, terepnapló, automatizálások és összehasonlítások';

  @override
  String get bastionTools_mapHint =>
      'Élő térkép, rögzítési munkamenetek, offline térképeszközök és régiók';

  @override
  String get bastionTools_pathAnalysis => 'Útelemzés';

  @override
  String get bastionTools_pathHint => 'Útvonalak, felderítés és útelemzés';

  @override
  String get bastionTools_repeaterHint =>
      'Állapot, bejelentkezés, telemetria, szomszédok és adminisztráció';

  @override
  String get bastionTools_statsHint =>
      'Élő hálózati számok és kapcsolati aktivitás';

  @override
  String get bastionTools_diagnostics => 'Diagnosztika';

  @override
  String get bastionTools_diagnosticsHint =>
      'Rádióállapot, eszközinformációk, nyers keretek és exportálás';

  @override
  String get bastionTools_about => 'Névjegy + köszönet';

  @override
  String get bastionTools_aboutHint =>
      'NOTORYX-Core-verzió, függetlenségi nyilatkozat és nyílt forráskódú licencek';

  @override
  String get bastionAbout_title => 'Névjegy + Köszönet';

  @override
  String get bastionAbout_intro =>
      'Független közösségi kísérőalkalmazás MeshCore-hálózatokhoz. A NOTORYX Core nem hivatalos MeshCore-alkalmazás, és a közösségi források szerepeltetése nem jelent partnerséget vagy jóváhagyást.';

  @override
  String get bastionAbout_version => 'Verzió';

  @override
  String get bastionAbout_openSource => 'Nyílt forráskódú alap';

  @override
  String get bastionAbout_openSourceBody =>
      'A NOTORYX Core a MeshCore Open MIT-licences nyílt forráskódjára épül, és azt módosítja. A lefedettségi munkafolyamat ahol releváns, a MIT-licences MeshMapper Flutter App érdemeit is elismeri.';

  @override
  String get bastionAbout_community => 'A közösség az első';

  @override
  String get bastionAbout_communityBody =>
      'A harmadik féltől származó alkotói források alkotóik tulajdonában maradnak. Sem tulajdonjog, sem partnerség nem értendő bele.';

  @override
  String get bastionAbout_legalese =>
      'NOTORYX Core • Független MeshCore-kísérő';

  @override
  String get bastionAbout_licenses => 'Nyílt forráskódú licencek';

  @override
  String get bastionSetup_title => 'Első lépések a NOTORYX Core-ral';

  @override
  String get bastionSetup_intro =>
      'Csatlakozzon, válasszon kapcsolatot, majd ellenőrizzen egy üzenetet. Az irányítópultról bármikor visszatérhet ehhez az útmutatóhoz.';

  @override
  String get bastionSetup_step1 => '1. Csatlakoztassa MeshCore rádióját';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return 'Csatlakozva: $device, kapcsolat: $transport.';
  }

  @override
  String get bastionSetup_noRadio => 'Még nincs csatlakoztatott rádió.';

  @override
  String get bastionSetup_step1Power =>
      'Kapcsoljon be egy MeshCore kísérőrádiót. Nyissa meg a Rádió csatlakoztatása menüt, és válassza a Bluetooth, USB vagy TCP lehetőséget. Engedélyezze a választott kapcsolathoz kért engedélyeket.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Ha a Bluetooth-keresés üres, ellenőrizze, hogy a Bluetooth be van-e kapcsolva, és hogy a NOTORYX Core rendelkezik-e a Közeli eszközök engedéllyel az Android alkalmazásbeállításaiban. Kövesse a szkenner által megjelenített további engedélykéréseket.';

  @override
  String get bastionSetup_connectionDiagnostics => 'Kapcsolatdiagnosztika';

  @override
  String get bastionSetup_step2 => '2. Válasszon csevegőkapcsolatot';

  @override
  String get bastionSetup_step2Body =>
      'Kérjen meg egy közeli partnert, akinek kompatibilisek a MeshCore rádióbeállításai, hogy hirdesse meg a csomópontját. Válasszon alább egy ismert csevegőkapcsolatot; az ismétlőket külön kezelheti.';

  @override
  String get bastionSetup_noContacts =>
      'Nincs elérhető csevegőkapcsolat. Csatlakoztassa a rádiót, és nyissa meg a Hálózatfelderítést.';

  @override
  String get bastionSetup_testRecipient => 'Tesztcímzett';

  @override
  String get bastionSetup_meshDiscovery => 'Hálózatfelderítés';

  @override
  String get bastionSetup_step3 => '3. Küldjön és ellenőrizzen egy üzenetet';

  @override
  String get bastionSetup_step3Body =>
      'Nyissa meg a csevegést, írjon egy rövid tesztüzenetet, ellenőrizze a címzettet, és koppintson a Küldés gombra. Térjen vissza ide, hogy lássa az útmutató megnyitása óta rögzített legutóbbi kimenő üzenetet.';

  @override
  String get bastionSetup_openTestChat => 'Tesztcsevegés megnyitása';

  @override
  String get bastionSetup_connectFirst =>
      'Csatlakoztassa a rádiót a tesztcsevegés megnyitásához.';

  @override
  String get bastionSetup_chooseRecipient => 'Előbb válasszon címzettet.';

  @override
  String get bastionSetup_noTestMessage =>
      'Ebben az útmutató-munkamenetben nem rögzült kimenő tesztüzenet.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return 'Legutóbbi üzenet: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'Kérje meg partnerét, hogy igazolja vissza a vételt vagy válaszoljon. A rögzített visszaigazolás nem bizonyítja, hogy elolvasta. Ha egy üzenet sikertelen, ellenőrizze újra a kapcsolatot és a címzettet.';

  @override
  String get bastionSetup_step4 => '4. Készüljön fel a terepre';

  @override
  String get bastionSetup_step4Body =>
      'Tervezze meg túrakapcsolatait, és ellenőrizze a letöltött térképterületeket. A botmód és a terepi automatizálások kezdetben ki vannak kapcsolva; a terepi automatizálások csak akkor futnak, ha az alkalmazás aktív.';

  @override
  String get bastionSetup_tripTools => 'Túra- és felkészültségi eszközök';

  @override
  String get bastionDiag_title => 'Diagnosztika';

  @override
  String get bastionDiag_export => 'Diagnosztika exportálása';

  @override
  String get bastionDiag_channels => 'Csatornák';

  @override
  String get bastionDiag_radio => 'Rádió';

  @override
  String get bastionDiag_frequency => 'Frekvencia';

  @override
  String get bastionDiag_bandwidth => 'Sávszélesség';

  @override
  String get bastionDiag_spreadingFactor => 'Szórási tényező';

  @override
  String get bastionDiag_codingRate => 'Kódolási arány';

  @override
  String get bastionDiag_txPower => 'Adóteljesítmény';

  @override
  String get bastionDiag_noiseFloor => 'Zajszint';

  @override
  String get bastionDiag_device => 'Eszköz';

  @override
  String get bastionDiag_name => 'Név';

  @override
  String get bastionDiag_manufacturer => 'Gyártó';

  @override
  String get bastionDiag_firmware => 'Firmware';

  @override
  String get bastionDiag_battery => 'Akkumulátor';

  @override
  String get bastionDiag_transport => 'Kapcsolat';

  @override
  String get bastionDiag_deepTools => 'Haladó eszközök';

  @override
  String get bastionDiag_liveStats => 'Élő rádióstatisztika';

  @override
  String get bastionDiag_liveStatsHint => 'Zaj, RSSI, SNR és adásidő';

  @override
  String get bastionDiag_frameDebug => 'Keret- / BLE-hibakeresés';

  @override
  String get bastionDiag_frameDebugHint =>
      'Dekódolt és nyers fogadott keretek vizsgálata';

  @override
  String get bastionDiag_appLog => 'Alkalmazás hibakeresési napló';

  @override
  String get bastionDiag_appLogHint =>
      'Az alkalmazás diagnosztikai eseményeinek áttekintése';

  @override
  String get bastionDiag_online => 'Rádió online';

  @override
  String get bastionDiag_offline => 'Rádió offline';

  @override
  String get bastionDiag_offlineHint =>
      'Csatlakoztasson egy MeshCore kísérőt az élő diagnosztika feltöltéséhez.';

  @override
  String get coverage_title => 'Lefedettségrögzítés';

  @override
  String get coverage_leaveBlocked =>
      'Kilépés előtt állítsa le és mentse a munkamenetet.';

  @override
  String get coverage_savedSessions => 'Mentett munkamenetek';

  @override
  String get coverage_caveat =>
      'Az RSSI/SNR rádiós pillanatképek, és egy másik csomaghoz is tartozhatnak. A pozíciók a rádió által sugárzott koordináták, nem a telefon GPS-e és nem a lefedettség bizonyítékai. Cián: rögzítő; borostyán: sugárzott csomópont. Interpoláció nem történik.';

  @override
  String get coverage_captureActive => 'Rögzítés aktív';

  @override
  String get coverage_fieldSession => 'Terepi lefedettségi munkamenet';

  @override
  String get coverage_connectedBody =>
      'A NOTORYX Core rögzíti a munkamenet során újonnan hallott csomópontokat, beleértve az útvonaladatokat, a csomópont-/helymetaadatokat és a rádió legközelebbi elérhető RSSI/SNR pillanatképét.';

  @override
  String get coverage_disconnectedBody =>
      'Indítás előtt csatlakoztasson egy rádiót. A lefedettségrögzítés a csatlakoztatott kísérőrádió élő hálózati megfigyeléseit rögzíti.';

  @override
  String get coverage_observations => 'Megfigyelések';

  @override
  String get coverage_uniqueNodes => 'Egyedi csomópontok';

  @override
  String get coverage_elapsed => 'Eltelt';

  @override
  String get coverage_radioConnected => 'Rádió csatlakoztatva';

  @override
  String get coverage_noRadio => 'Nincs rádió';

  @override
  String get coverage_gpsReady => 'Rádió GPS kész';

  @override
  String get coverage_noGps => 'Nincs rádió GPS';

  @override
  String get coverage_stopSave => 'Leállítás + mentés';

  @override
  String get coverage_start => 'Lefedettségi munkamenet indítása';

  @override
  String get coverage_exportJson => 'JSON exportálása';

  @override
  String get coverage_exportCsv => 'CSV exportálása';

  @override
  String get coverage_liveObservations => 'Élő megfigyelések';

  @override
  String get coverage_waiting => 'Hálózati aktivitásra vár';

  @override
  String get coverage_waitingBody =>
      'Indítson munkamenetet, és az újonnan hallott aktív csomópontok itt jelennek meg. Az RSSI/SNR értékek rádiós pillanatképek, és nem mindig rendelhetők egyértelműen egy adott csomaghoz.';

  @override
  String get coverage_signalNa => 'jel n/a';

  @override
  String get coverage_snrNa => 'SNR n/a';

  @override
  String get coverage_gpsUnavailable => 'rádió GPS nem érhető el';

  @override
  String coverage_pathLine(String path, String location) {
    return 'Út: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'flood';

  @override
  String get coverage_pathDirect => 'közvetlen';

  @override
  String get coverage_shareSubject => 'NOTORYX Core lefedettségi munkamenet';

  @override
  String get coverage_shareText => 'NOTORYX Core lefedettségrögzítési export';

  @override
  String get coverage_historyTitle => 'Mentett lefedettségi munkamenetek';

  @override
  String coverage_loadFailed(String error) {
    return 'A munkameneteket nem sikerült betölteni: $error';
  }

  @override
  String get coverage_deleteTitle => 'Törli a mentett munkamenetet?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count megfigyelés törlődik erről az eszközről.',
      one: '1 megfigyelés törlődik erről az eszközről.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'A munkamenetet nem sikerült törölni: $error';
  }

  @override
  String get coverage_retention =>
      'A legutóbbi 20 befejezett munkamenet marad meg. Ossza meg azokat, amelyeket meg szeretne tartani. A megszakított rögzítések alább újra megnyithatók.';

  @override
  String get coverage_noSessions =>
      'Még nincs mentett munkamenet. Állítson le egy rögzítést a mentéshez.';

  @override
  String get coverage_interrupted => 'Megszakított rögzítés';

  @override
  String get coverage_saved => 'Mentve';

  @override
  String get coverage_deleteTooltip => 'Munkamenet törlése';

  @override
  String coverage_exportFailed(String error) {
    return 'Az exportálás sikertelen: $error';
  }

  @override
  String get coverage_sessionTitle => 'Lefedettségi munkamenet';

  @override
  String get coverage_shareJson => 'JSON megosztása';

  @override
  String get coverage_shareCsv => 'CSV megosztása';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • pillanatkép kora $age ms';
  }

  @override
  String get coverage_unknown => 'ismeretlen';

  @override
  String coverage_pathValue(String path) {
    return 'út $path';
  }

  @override
  String get coverage_recorder => 'Rögzítő';

  @override
  String get coverage_noCoordinates =>
      'Ebben a munkamenetben nincsenek használható koordináták. A megfigyelések alább továbbra is elérhetők.';

  @override
  String get coverage_osmAttribution =>
      '© OpenStreetMap-közreműködők • online alaptérkép';

  @override
  String get fieldStats_title => 'Terepi elemzés';

  @override
  String get fieldStats_snapshot => 'Élő hálózati pillanatkép';

  @override
  String get fieldStats_headline => 'Amit a NOTORYX Core most tud.';

  @override
  String get fieldStats_body =>
      'Ezek a számlálók a csatlakoztatott MeshCore kapcsolattáblájából, a helyekből, az utakból és az utoljára látott időbélyegekből számolódnak.';

  @override
  String get fieldStats_total => 'Összesen';

  @override
  String get fieldStats_chatNodes => 'Csevegő csomópontok';

  @override
  String get fieldStats_rooms => 'Szobák';

  @override
  String get fieldStats_sensors => 'Érzékelők';

  @override
  String get fieldStats_located => 'Hellyel';

  @override
  String get fieldStats_favorites => 'Kedvencek';

  @override
  String get fieldStats_routeSnapshot => 'Útvonal-pillanatkép';

  @override
  String get fieldStats_routed => 'Útvonalas';

  @override
  String get fieldStats_direct => 'Közvetlen';

  @override
  String get fieldStats_flood => 'Flood';

  @override
  String get fieldStats_pathIntel => 'Útelemzés';

  @override
  String get fieldStats_pathIntelBody =>
      'A NOTORYX Core útvonalelemzése mentett útkísérleteket, ugrásszámokat, sikereket/hibákat, átfutási időt és útvonalsúlyozást használ a tanult útvonalak megjelenítéséhez.';

  @override
  String get fieldStats_coverageSessions => 'Lefedettségi munkamenetek';

  @override
  String get fieldStats_coverageSessionsBody =>
      'A lefedettségrögzítés mostantól menti a terepi munkameneteket, visszaállítja a megszakított munkát, exportálja a megfigyeléseket és térképre viszi a rögzített lefedettségi pontokat. Az RSSI/SNR továbbra is a legközelebbi elérhető rádiós pillanatkép.';

  @override
  String get mapHub_title => 'NOTORYX terepi térkép';

  @override
  String get mapHub_intro =>
      'Élő térképek, offline területek, regionális profilok és NOTORYX Core terepi lefedettségi munkamenetek.';

  @override
  String get mapHub_captureHint =>
      'Terepi lefedettségi munkamenet indítása és leállítása';

  @override
  String get mapHub_badgeNew => 'ÚJ';

  @override
  String get mapHub_liveMap => 'Élő hálózati térkép';

  @override
  String get mapHub_liveMapHint =>
      'Csomópontok, ismétlők, pozíciók, útvonalak és térképeszközök';

  @override
  String get mapHub_badgeLive => 'ÉLŐ';

  @override
  String get mapHub_offlinePacks => 'Offline térképcsomagok';

  @override
  String get mapHub_offlinePacksHint =>
      'Térképcsempék gyorsítótárazása túrákhoz és lefedetlen területekhez';

  @override
  String get mapHub_badgeOffline => 'OFFLINE';

  @override
  String get mapHub_regions => 'Régióprofilok';

  @override
  String get mapHub_regionsHint =>
      'Regionális hálózati definíciók kezelése és letöltése';

  @override
  String get mapHub_badgeRegions => 'RÉGIÓK';

  @override
  String get routes_title => 'Útvonalelemzés';

  @override
  String get routes_headline =>
      'Nézze meg, hogyan halad a forgalom a hálózaton.';

  @override
  String get routes_body =>
      'A NOTORYX Core a valós üzenetküldési kísérletekből és felderítésekből már megtanult útelőzmények alapján rangsorolja a mentett útvonalakat.';

  @override
  String get routes_routes => 'Útvonalak';

  @override
  String get routes_success => 'Sikeres';

  @override
  String get routes_failed => 'Sikertelen';

  @override
  String get routes_routeMap => 'Útvonaltérkép';

  @override
  String get routes_routeMapHint => 'Csomópontok és utak vizsgálata';

  @override
  String get routes_discover => 'Felderítés';

  @override
  String get routes_discoverHint => 'Új útvonalak keresése';

  @override
  String get routes_learned => 'Tanult útvonalak';

  @override
  String get routes_none => 'Még nincs útvonal-előzmény';

  @override
  String get routes_noneBody =>
      'Használja a hálózatot a szokásos módon, vagy indítson felderítést. A NOTORYX Core itt jeleníti meg a tanult útvonalakat, amint útelőzmények állnak rendelkezésre.';

  @override
  String get routes_direct => 'KÖZVETLEN';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count útvonal',
      one: '1 útvonal',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return 'LEGJOBB  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  súly $weight  •  $success sikeres / $fail sikertelen';
  }

  @override
  String routes_fastest(String ms) {
    return 'Leggyorsabb ismert: $ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'Flood: $success sikeres / $fail sikertelen';
  }

  @override
  String get repeaterTools_heroLabel => 'Ismétlő-irányítás';

  @override
  String get repeaterTools_headline =>
      'Kezelje a hálózata mögötti infrastruktúrát.';

  @override
  String get repeaterTools_body =>
      'Válasszon egy felderített ismétlőt a bejelentkezéshez, és nyissa meg meglévő MeshCore-eszközeit: állapot, telemetria, szomszédok, beállítások és CLI.';

  @override
  String get repeaterTools_discovered => 'Felderítve';

  @override
  String get repeaterTools_tools => 'Eszközök';

  @override
  String get repeaterTools_available => 'Elérhető ismétlők';

  @override
  String get repeaterTools_unnamed => 'Névtelen ismétlő';

  @override
  String get repeaterTools_statusTelemetry => 'Állapot + telemetria';

  @override
  String get repeaterTools_statusTelemetryBody =>
      'Az ismétlő állapotának és telemetriájának vizsgálata a meglévő kezelőeszközökkel.';

  @override
  String get repeaterTools_neighbors => 'Szomszédok';

  @override
  String get repeaterTools_neighborsBody =>
      'Szomszédos infrastruktúra és hálózati kapcsolatok vizsgálata.';

  @override
  String get repeaterTools_cli => 'CLI + beállítások';

  @override
  String get repeaterTools_cliBody =>
      'A bejelentkezett rendszergazdák elérik az ismétlő meglévő CLI-jét és konfigurációs eszközeit.';

  @override
  String get repeaterTools_empty =>
      'Még nincs felderített ismétlő. Csatlakoztasson egy rádiót, és előbb derítse fel a hálózatot.';

  @override
  String get notification_fieldAlertTitle => 'NOTORYX terepi riasztás';

  @override
  String get notification_checkInReminderTitle =>
      'NOTORYX Core bejelentkezési emlékeztető';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return '$minutes perce nincs bejelentkezés a(z) $trip túrán. Nyissa meg a NOTORYX Core-t a bejelentkezéshez.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return '$name $minutes perce nem hallatott magáról. Ez nem megerősített vészhelyzet.';
  }

  @override
  String get notification_aTripContact => 'Egy túrakapcsolat';

  @override
  String notification_checkInNotDelivered(String name) {
    return 'A bejelentkezés nem lett kézbesítve neki: $name. A Túra lapon újraküldheti.';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return '$name visszaigazolta az SOS-t';
  }

  @override
  String get settings_batterySaver => 'Energiatakarékos mód';

  @override
  String get settings_batterySaverOn =>
      'Be: rádióakkumulátor 10 percenként, GPS 5 percenként, statisztika legfeljebb percenként egyszer, túraellenőrzés 1–2 percenként. Az üzenetek, riasztások és az SOS változatlanok.';

  @override
  String get settings_batterySaverOff =>
      'A rádió és a túra ritkább ellenőrzése a telefon és a rádió akkumulátorának kímélésére. Az üzenetek, riasztások és az SOS változatlanok.';

  @override
  String get settings_readAloud => 'Új üzenetek felolvasása';

  @override
  String get settings_readAloudHelper =>
      'Amíg a NOTORYX Core nyitva van. A némított csatornák csendben maradnak. Bármely üzenet felolvasható a menüjéből is.';

  @override
  String get settings_readAloudOff => 'Ki';

  @override
  String get settings_readAloudDirect => 'Közvetlen üzenetek';

  @override
  String get settings_readAloudAll => 'Közvetlen és csatornaüzenetek';

  @override
  String get chat_readAloud => 'Felolvasás';

  @override
  String get messageSearch_title => 'Keresés az üzenetekben';

  @override
  String get messageSearch_intro =>
      'Keresés az ezen a telefonon mentett összes közvetlen és csatornaüzenetben.';

  @override
  String messageSearch_noResults(String query) {
    return 'Egyik üzenet sem tartalmazza ezt: „$query”.';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count találat',
      one: '1 találat',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return 'A legújabb $count találat látható';
  }

  @override
  String get shortcuts_checkIn => 'Bejelentkezés';

  @override
  String get shortcuts_trip => 'Túra';

  @override
  String get shortcuts_chats => 'Csevegések';

  @override
  String get shortcuts_map => 'Térkép';

  @override
  String get sensor_liveUpdates => 'Élő frissítések';

  @override
  String get sensor_intro =>
      'Az érzékelő magától küldje a méréseket, amikor változnak, ahelyett hogy minden alkalommal le kellene kérdezni. Olvasási jogú bejelentkezés szükséges.';

  @override
  String get sensor_watch => 'Változások figyelése';

  @override
  String get sensor_loadFirst =>
      'Előbb töltse be a telemetriát a mérések kiválasztásához.';

  @override
  String sensor_watching(String readings, String time) {
    return 'Figyelt: $readings, eddig: $time.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return 'Figyelt: $readings, eddig: $time • régió: $region.';
  }

  @override
  String get sensor_noChanges => 'Még nem érkezett változás.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return 'Utolsó frissítés $time • $count érkezett';
  }

  @override
  String get sensor_stop => 'Élő frissítések leállítása';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'Itt leállítva; az érzékelő nem igazolta vissza, és az idő lejártával áll le. $error';
  }

  @override
  String get sensor_dialogBody =>
      'Az érzékelő nagyjából percenként ellenőriz, és frissítést küld, ha egy kiválasztott mérés a küszöbénél jobban változik.';

  @override
  String sensor_readingTitle(String label, String channel) {
    return '$label ($channel. csatorna)';
  }

  @override
  String sensor_readingValue(String label, String channel, String value) {
    return '$label ($channel. csatorna): $value';
  }

  @override
  String sensor_watchItem(String label, String channel, String delta) {
    return '$label ($channel. csatorna) ±$delta';
  }

  @override
  String sensor_updateOn(String delta) {
    return 'Frissítés $delta változásnál';
  }

  @override
  String get sensor_changeThreshold => 'Küszöb módosítása';

  @override
  String sensor_capacity(int max, String used) {
    return 'Az érzékelő legfeljebb $max bájtnyi mérést figyelhet ($used foglalt).';
  }

  @override
  String get sensor_for => 'Időtartam';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count óra',
      one: '1 óra',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => 'Indítás';

  @override
  String sensor_thresholdTitle(String label) {
    return '$label küszöb';
  }

  @override
  String get sensor_typeTemperature => 'Hőmérséklet';

  @override
  String get sensor_typeHumidity => 'Páratartalom';

  @override
  String get sensor_typePressure => 'Légnyomás';

  @override
  String get sensor_typeVoltage => 'Feszültség';

  @override
  String get sensor_typeCurrent => 'Áramerősség';

  @override
  String get sensor_typeLight => 'Fény';

  @override
  String get sensor_typeConcentration => 'Koncentráció';

  @override
  String get sensor_typePercentage => 'Százalék';

  @override
  String get sensor_typeAnalogInput => 'Analóg bemenet';

  @override
  String get sensor_typeAltitude => 'Magasság';

  @override
  String get setupWizard_title => 'Rádió csatlakoztatása';

  @override
  String get setupWizard_choose => '1. Válasszon kapcsolatot';

  @override
  String get setupWizard_prepare => '2. Készítse elő a rádiót';

  @override
  String get setupWizard_intro =>
      'Válassza ki, hogyan csatlakozzon ez a telefon vagy számítógép a rádióhoz. A rádió viszi az üzeneteket a mesh hálózaton.';

  @override
  String get setupWizard_bluetooth =>
      'Vezeték nélküli kapcsolat egy közeli kompatibilis rádióval.';

  @override
  String get setupWizard_noBluetooth =>
      'A Bluetooth nem érhető el ebben a böngészőben. Használja a natív alkalmazást vagy egy támogatott USB-kapcsolatot.';

  @override
  String get setupWizard_usb => 'Vezetékes kapcsolat USB-adatkábellel.';

  @override
  String get setupWizard_noUsb =>
      'Az USB-soros kapcsolat itt nem érhető el. Használjon támogatott asztali vagy Android-alkalmazást, vagy Chrome-ot Web Seriallal.';

  @override
  String get setupWizard_bluetoothSteps =>
      'Kapcsolja be a rádiót, és tartsa közel. Kapcsolja be a Bluetootht, és engedélyezze az alkalmazásnak a használatát. Zárja be a rádióhoz csatlakozó többi alkalmazást, nyissa meg az eszközlistát, és keressen.';

  @override
  String get setupWizard_usbSteps =>
      'Csatlakoztassa a bekapcsolt rádiót USB-adatkábellel; a csak töltésre szolgáló kábel nem működik. Zárja be a többi soros alkalmazást. Nyissa meg az USB-eszközlistát, válassza ki a rádiót, és engedélyezze a hozzáférést, ha kéri.';

  @override
  String get setupWizard_firmwareTitle =>
      'Firmware-csere előtt ellenőrizze a kompatibilitást';

  @override
  String get setupWizard_firmware =>
      'A rádiónak a választott kapcsolatot támogató MeshCore companion firmware kell. A támogatás panelenként és firmware-verziónként eltér; egy USB-aljzat önmagában nem jelent USB-soros támogatást. Nézze meg a panelje és a telepített verzió leírását. Az ismétlő vagy szobaszerver firmware nem companion. Egy sikertelen kapcsolódás önmagában nem jelenti, hogy újra kell flashelni.';

  @override
  String get setupWizard_settings =>
      'Ez az útmutató nem flashel firmware-t, és nem módosítja a rádió beállításait. Csatlakozás után a Beállításokban adja meg a régiót, a frekvenciát és a speciális lehetőségeket. Módosítás előtt egyeztesse a beállításokat a helyi mesh hálózattal.';

  @override
  String get setupWizard_openBluetooth => 'Bluetooth-eszközök megnyitása';

  @override
  String get setupWizard_openUsb => 'USB-eszközök megnyitása';

  @override
  String get setupWizard_change => 'Kapcsolattípus módosítása';

  @override
  String get setupWizard_later => 'Beállítás később';

  @override
  String get setupWizard_bluetoothError =>
      'Nem sikerült csatlakozni a rádióhoz. Tartsa bekapcsolva és közel, ellenőrizze a Bluetooth-engedélyeket, és zárja be a többi csatlakozott alkalmazást. Ezután keressen újra.';

  @override
  String get setupWizard_scanError =>
      'Nem sikerült rádiókat keresni. Kapcsolja be a Bluetootht, és a rendszerbeállításokban engedélyezze a Bluetooth vagy a közeli eszközök elérését, majd keressen újra.';

  @override
  String get setupWizard_usbError =>
      'Nem sikerült USB-n csatlakozni. Ellenőrizze az adatkábelt és a kiválasztott eszközt, engedélyezze az USB-hozzáférést, és zárja be a többi soros alkalmazást. Csatlakoztassa újra a kábelt, és próbálja újra.';

  @override
  String get connections_title => 'Kapcsolatok';

  @override
  String get connections_radioTitle => 'Rádiókapcsolat';

  @override
  String get connections_bluetoothOffNotice =>
      'A Bluetooth ki van kapcsolva. Kapcsolja be az újracsatlakozáshoz; az alkalmazás újrapróbálja, amint visszatér.';

  @override
  String get connections_transport => 'Kapcsolat típusa';

  @override
  String connections_lastError(String error) {
    return 'Utolsó hiba: $error';
  }

  @override
  String get connections_disconnectRadio => 'Rádió leválasztása';

  @override
  String connections_reconnectTo(String name) {
    return 'Újracsatlakozás ehhez: $name';
  }

  @override
  String get connections_forgetRadio => 'Rádió elfelejtése';

  @override
  String get connections_connectAnother => 'Másik rádió csatlakoztatása';

  @override
  String get connections_usbSerial => 'USB-soros';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'Eszköz';

  @override
  String get connections_publicKey => 'Nyilvános kulcs';

  @override
  String get connections_firmware => 'Firmware';

  @override
  String connections_firmwareProtocol(String code) {
    return 'protokoll v$code';
  }

  @override
  String get connections_battery => 'Akkumulátor';

  @override
  String get connections_lastRx => 'Utolsó vétel';

  @override
  String get connections_reconnectFailed =>
      'Nem sikerült újracsatlakozni a rádióhoz';

  @override
  String get connections_statusBluetoothOff => 'A Bluetooth ki van kapcsolva';

  @override
  String get connections_statusConnected => 'Csatlakoztatva';

  @override
  String get connections_statusConnecting => 'Csatlakozás…';

  @override
  String get connections_statusDisconnecting => 'Leválasztás…';

  @override
  String get connections_statusScanning => 'Rádiók keresése…';

  @override
  String get connections_statusReconnectingSoon => 'Hamarosan újracsatlakozik…';

  @override
  String get connections_statusNotConnected => 'Nincs csatlakoztatva';

  @override
  String get mqtt_cardTitle => 'MQTT-kapcsolat';

  @override
  String get mqtt_statusNotConfigured => 'Nincs beállítva';

  @override
  String get mqtt_statusDisconnected => 'Leválasztva';

  @override
  String get mqtt_statusConnecting => 'Csatlakozás';

  @override
  String get mqtt_statusConnected => 'Csatlakoztatva';

  @override
  String get mqtt_statusReconnecting => 'Újracsatlakozás';

  @override
  String get mqtt_statusError => 'Kapcsolódási hiba';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'Bróker: $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn => 'Rádió által aláírt tokennel jelentkezik be';

  @override
  String mqtt_tokenSignInAs(String username) {
    return 'Rádió által aláírt tokennel jelentkezik be mint $username…';
  }

  @override
  String get mqtt_connectRadioToSignIn =>
      'Csatlakoztassa a rádiót a bejelentkezéshez';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'A token megújul: $time';
  }

  @override
  String mqtt_signedInAs(String username) {
    return 'Bejelentkezve mint $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return 'Figyelés: $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'Csomagok: $accepted új, $duplicate ismétlődő, $invalid érvénytelen';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return 'Próbálkozás: $attempt/$max';
  }

  @override
  String get mqtt_sharingWaitsForRadio => 'A megosztás rádiókapcsolatra vár';

  @override
  String mqtt_sharingOn(String topic) {
    return 'Megosztás itt: $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return 'Itt fog megosztani: $topic';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'Online állapot itt: $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return 'Megosztva: $shared, visszatartva: $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'Adjon hozzá egy brókert, hogy a MeshCore-forgalmat az interneten át összekösse. A rádiókapcsolat ettől függetlenül működik.';

  @override
  String get mqtt_disconnect => 'MQTT leválasztása';

  @override
  String get mqtt_connect => 'MQTT csatlakoztatása';

  @override
  String get mqtt_packetFeed => 'Csomagfolyam';

  @override
  String get mqtt_setUpBroker => 'Bróker beállítása';

  @override
  String get mqtt_brokerSettings => 'Bróker beállításai';

  @override
  String get mqtt_settingsTitle => 'MQTT-bróker beállításai';

  @override
  String get mqtt_presetLabel => 'Kezdés egy előbeállításból';

  @override
  String get mqtt_presetCustom => 'Egyéni bróker';

  @override
  String get mqtt_presetLocal => 'Helyi bróker (cím megadása)';

  @override
  String get mqtt_presetLetsMeshUs => 'LetsMesh-elemző (USA, közösségi)';

  @override
  String get mqtt_presetLetsMeshEu => 'LetsMesh-elemző (EU, közösségi)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'A LetsMesh egy közösség által üzemeltetett MeshCore-csomagelemző; nem része a NOTORYX-nek, és a NOTORYX nem ajánlja. A megosztáshoz csatlakoztatott rádió kell, és addig ki van kapcsolva, amíg be nem kapcsolja.';

  @override
  String get mqtt_hostname => 'A bróker gazdagépneve';

  @override
  String get mqtt_port => 'Port';

  @override
  String get mqtt_useTls => 'TLS használata';

  @override
  String get mqtt_allowCleartext =>
      'Titkosítatlan kapcsolat engedélyezése helyi brókerhez';

  @override
  String get mqtt_allowCleartextHint =>
      'Csak localhost, .local és privát 10.x / 192.168.x gazdagépek.';

  @override
  String get mqtt_useWebSocket => 'WebSocket használata';

  @override
  String get mqtt_webSocketPath => 'WebSocket-útvonal';

  @override
  String get mqtt_topicPrefix => 'Topic-előtag';

  @override
  String get mqtt_region => 'Régió (nem kötelező)';

  @override
  String get mqtt_regionHelp =>
      'A megfigyelő régiókódja, pl. PHL. Hagyja üresen az összeshez.';

  @override
  String get mqtt_deliverChannel =>
      'MQTT-n érkezett csatornaüzenetek hozzáadása';

  @override
  String get mqtt_deliverChannelHint =>
      'A csatornáiban a megfigyelők által hallott üzenetek megjelennek a csevegésekben. Ezeket nem küldi a rádiója.';

  @override
  String get mqtt_sharingTitle => 'Megosztás megfigyelőként';

  @override
  String get mqtt_share => 'A rádióm által hallott csomagok megosztása';

  @override
  String get mqtt_shareHint =>
      'Közzéteszi a rádió által vett hirdetéseket és csatornaforgalmat a nyilvános kulcsával, a jelerősséggel és a régióval. A csatornaüzenetek titkosítva maradnak. Régió szükséges.';

  @override
  String get mqtt_shareDirect => 'Közvetlen üzenetek forgalmának bevonása';

  @override
  String get mqtt_shareDirectHint =>
      'Kérések, válaszok és közvetlen üzenetek. A tartalom titkosítva marad, de látszik, mely csomópontok beszélnek egymással.';

  @override
  String get mqtt_shareOwn => 'Saját üzeneteim és hirdetéseim bevonása';

  @override
  String get mqtt_signInTitle => 'Bejelentkezés';

  @override
  String get mqtt_authPassword => 'Felhasználónév és jelszó';

  @override
  String get mqtt_authToken => 'Rádió által aláírt token';

  @override
  String get mqtt_tokenExplain =>
      'A rádió a saját kulcsával aláír egy egy óráig érvényes bejelentkezési tokent, az alkalmazás pedig lejárat előtt megújítja. A kulcs sosem hagyja el a rádiót. A felhasználónév v1_ és a rádió nyilvános kulcsa.';

  @override
  String get mqtt_radioReady =>
      'A rádió csatlakoztatva: kész a bejelentkezésre.';

  @override
  String get mqtt_radioNeeded =>
      'Csatlakoztassa a rádiót a bejelentkezéshez. Az MQTT vár rá.';

  @override
  String get mqtt_username => 'Felhasználónév (nem kötelező)';

  @override
  String get mqtt_password => 'Jelszó';

  @override
  String get mqtt_keepPassword =>
      'Hagyja üresen a mentett jelszó megtartásához.';

  @override
  String get mqtt_credentialsWeb =>
      'A böngészőben a hitelesítő adatok csak az oldal bezárásáig maradnak meg.';

  @override
  String get mqtt_credentialsKeychain =>
      'A hitelesítő adatok a rendszer kulcskarikájában tárolódnak, soha nem az alkalmazás beállításaiban vagy a naplókban.';

  @override
  String get mqtt_saveSettings => 'Beállítások mentése';

  @override
  String get mqtt_feedTitle => 'MQTT-csomagfolyam';

  @override
  String get mqtt_feedConnect =>
      'Csatlakozzon egy brókerhez a megfigyelők csomagjainak megtekintéséhez.';

  @override
  String mqtt_feedWaiting(String topic) {
    return 'Csomagokra vár itt: $topic';
  }

  @override
  String get mqtt_feedUnknownObserver => 'Ismeretlen megfigyelő';

  @override
  String mqtt_feedHeardBy(String observer) {
    return 'Hallotta: $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return '$hops ugrás · $bytes bájt';
  }

  @override
  String get mqtt_packetRequest => 'Kérés';

  @override
  String get mqtt_packetResponse => 'Válasz';

  @override
  String get mqtt_packetDirectMessage => 'Közvetlen üzenet';

  @override
  String get mqtt_packetAck => 'Nyugta';

  @override
  String get mqtt_packetAdvert => 'Hirdetés';

  @override
  String get mqtt_packetChannelMessage => 'Csatornaüzenet';

  @override
  String get mqtt_packetChannelData => 'Csatornaadat';

  @override
  String get mqtt_packetAnonymousRequest => 'Névtelen kérés';

  @override
  String get mqtt_packetPath => 'Útvonal';

  @override
  String get mqtt_packetTrace => 'Nyomkövetés';

  @override
  String get mqtt_packetMultipart => 'Többrészes';

  @override
  String get mqtt_packetControl => 'Vezérlés';

  @override
  String mqtt_packetType(int type) {
    return '$type. típus';
  }

  @override
  String get mqtt_routeTransportFlood => 'Transzport flood';

  @override
  String get mqtt_routeFlood => 'Flood';

  @override
  String get mqtt_routeDirect => 'Közvetlen';

  @override
  String get mqtt_routeTransportDirect => 'Transzport közvetlen';

  @override
  String get mqtt_noticeInvalidHost =>
      'Adjon meg egy gazdagépnevet vagy IPv4-címet séma és port nélkül.';

  @override
  String get mqtt_noticeInvalidPort =>
      'A portnak 1 és 65535 között kell lennie.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'A WebSocket-útvonalnak /-rel kell kezdődnie, és nem tartalmazhat lekérdezést vagy töredéket.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'A topic-előtagnak nem üres, helyettesítő karakterek nélküli MQTT-útvonalnak kell lennie.';

  @override
  String get mqtt_noticeInvalidRegion =>
      'A régió 2–8 betű vagy számjegy lehet, pl. PHL.';

  @override
  String get mqtt_noticeTlsRequired =>
      'A TLS kötelező, kivéve ha a helyi bróker nem biztonságos elérése kifejezetten engedélyezett.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      'A titkosítatlan MQTT csak kifejezetten jóváhagyott helyi gazdagépekhez engedélyezett.';

  @override
  String get mqtt_noticeRegionNeededToShare =>
      'Állítson be régiót a csomagok megfigyelőként való megosztásához.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return 'Adja meg $username jelszavát.';
  }

  @override
  String get mqtt_noticeNoNetwork =>
      'Nincs hálózati kapcsolat. Az MQTT újracsatlakozik, amint visszatér.';

  @override
  String get mqtt_noticeSubscriptionRefused =>
      'A bróker elutasította a csomag-előfizetést.';

  @override
  String get mqtt_noticeBadCredentials =>
      'A bróker elutasította a felhasználónevet vagy a jelszót.';

  @override
  String get mqtt_noticeNotAuthorized =>
      'Ennek a fióknak nincs jogosultsága a brókeren.';

  @override
  String get mqtt_noticeConnectionRefused =>
      'A bróker elutasította a kapcsolatot.';

  @override
  String get mqtt_noticeUnreachable => 'A bróker nem érhető el.';

  @override
  String get mqtt_noticeTlsFailed =>
      'Nem sikerült létrehozni a biztonságos (TLS) kapcsolatot.';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'Ez a platform csak WebSocketen keresztül támogatja az MQTT-t.';

  @override
  String get mqtt_noticeRadioNotConnected =>
      'Csatlakoztassa a rádiót, hogy a kulcsával jelentkezhessen be.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'A rádió firmware-je nem támogatja a kulcsával való aláírást.';

  @override
  String get mqtt_noticeSigningTimeout =>
      'A rádió nem válaszolt az aláírási kérésre. Lehet, hogy a firmware-je nem támogatja az aláírást.';

  @override
  String get mqtt_noticeSigningTooLong =>
      'Az adat túl hosszú ahhoz, hogy a rádió aláírja.';

  @override
  String get mqtt_noticeSigningRejected =>
      'A rádió megtagadta az adat aláírását.';

  @override
  String get scanner_signalStrong => 'Erős';

  @override
  String get scanner_signalGood => 'Jó';

  @override
  String get scanner_signalFair => 'Közepes';

  @override
  String get scanner_signalWeak => 'Gyenge';

  @override
  String get scanner_nearbyRadios => 'Közeli rádiók';

  @override
  String get scanner_lastRadio => 'Utolsó rádió';

  @override
  String get scanner_reconnect => 'Újracsatlakozás';

  @override
  String get scanner_tcpHint =>
      'Wi‑Fi firmware-rel működő rádió a hálózatodon.';

  @override
  String get scanner_otherWays => 'Más csatlakozási módok';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rádió a közelben',
      one: '1 rádió a közelben',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => 'Rádiók keresése…';

  @override
  String get scanner_findTitle => 'Keresd meg a rádiódat';

  @override
  String get scanner_heroHint =>
      'Kapcsold be a rádiót, és tartsd néhány méteren belül. MeshCore companion firmware kell hozzá.';

  @override
  String get scanner_tipsTitle => 'Nem látod a rádiódat?';

  @override
  String get scanner_tipPower =>
      'Ellenőrizd, hogy be van-e kapcsolva és aktív-e.';

  @override
  String get scanner_tipFirmware =>
      'MeshCore companion firmware kell hozzá. Az átjátszók és szobaszerverek itt nem jelennek meg.';

  @override
  String get scanner_tipOtherDevice =>
      'Egy rádió egyszerre csak egy eszközhöz csatlakozik. Válaszd le más telefonokról vagy számítógépekről.';

  @override
  String get connections_internetBridge => 'Internethíd';

  @override
  String get connections_noRadio => 'Nincs rádió';

  @override
  String get connections_radioSettings => 'Rádióbeállítások';

  @override
  String get connections_viewDashboard => 'Kapcsolatok áttekintése';

  @override
  String get channelDirectory_title => 'Csatornakönyvtár';

  @override
  String get channelDirectory_subtitle =>
      'Nyilvános hashtag-csatornák a közeledben';

  @override
  String get channelDirectory_search => 'Csatornák vagy helyek keresése';

  @override
  String get channelDirectory_nearYou => 'A közeledben';

  @override
  String get channelDirectory_all => 'Összes csatorna';

  @override
  String get channelDirectory_catAll => 'Összes';

  @override
  String get channelDirectory_catEmergency => 'Vészhelyzet';

  @override
  String get channelDirectory_catLocal => 'Helyi';

  @override
  String get channelDirectory_catGeneral => 'Általános';

  @override
  String get channelDirectory_catInterest => 'Érdeklődés';

  @override
  String get channelDirectory_catTest => 'Teszt';

  @override
  String get channelDirectory_join => 'Csatlakozás';

  @override
  String get channelDirectory_joined => 'Csatlakozva';

  @override
  String get channelDirectory_noMatches =>
      'Egy csatorna sem felel meg a keresésnek.';

  @override
  String get channelDirectory_connectFirst =>
      'Csatlakoztasd a rádiót a csatornákhoz való csatlakozáshoz.';

  @override
  String get channelDirectory_slotsFull =>
      'A rádió összes csatornahelye foglalt. Előbb távolíts el egy csatornát.';

  @override
  String get channelDirectory_joinFailed =>
      'Nem sikerült hozzáadni a csatornát. Próbáld újra.';

  @override
  String get channelDirectory_addHint =>
      'Hiányzik egy csatorna? Bárki javasolhat egyet a közös lista GitHubon való szerkesztésével.';

  @override
  String get prefixTool_title => 'Átjátszó-azonosítók';

  @override
  String get prefixTool_subtitle =>
      'Ki használ egy azonosítót, melyek ütköznek, és szabadok egy új átjátszóhoz';

  @override
  String get prefixTool_width => 'Útvonal-azonosító mérete';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes bájt';
  }

  @override
  String get prefixTool_includeCompanions =>
      'Companion eszközök és érzékelők is';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return '$nodes ismert csomópont · $used foglalt azonosító · $shared közös';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return '$space-ból $free szabad azonosító';
  }

  @override
  String get prefixTool_lookupHint => 'Azonosító keresése, pl. 3D';

  @override
  String prefixTool_lookupFree(String id) {
    return 'Egy ismert csomópont sem használja: $id.';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count csomópont használja: $id',
      one: '1 csomópont használja: $id',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => 'Közös azonosítók';

  @override
  String get prefixTool_sharedHint =>
      'Az ezeken átmenő útvonalak egyformának látszanak, hacsak a háló nem használ hosszabb azonosítókat.';

  @override
  String get prefixTool_noShared =>
      'Nincs közös azonosító az ismert csomópontok között.';

  @override
  String get prefixTool_free => 'Szabad azonosítók';

  @override
  String get prefixTool_shuffle => 'További javaslatok';

  @override
  String get prefixTool_makeKey => 'Kulcs készítése';

  @override
  String get prefixTool_onlyKnown =>
      'Csak a rádió által hallott csomópontok alapján. Egy itt szabad azonosító még tartozhat olyan átjátszóhoz, amelyet nem hallottál.';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return 'A(z) $id azonosítót már használja: $name.';
  }

  @override
  String get prefixTool_pickFree => 'Szabad azonosító választása';

  @override
  String keyGen_title(String id) {
    return 'Kulcs a(z) $id azonosítóhoz';
  }

  @override
  String keyGen_searching(int tries) {
    return 'Keresés… $tries kulcs kipróbálva';
  }

  @override
  String get keyGen_publicKey => 'Nyilvános kulcs';

  @override
  String get keyGen_privateKey => 'Privát kulcs';

  @override
  String get keyGen_copy => 'Másolás';

  @override
  String get keyGen_copied => 'Másolva';

  @override
  String get keyGen_secretWarning =>
      'Tartsd titokban a privát kulcsot. Aki birtokolja, ennek a csomópontnak adhatja ki magát.';

  @override
  String get keyGen_howToUse =>
      'Átjátszóhoz: nyisd meg a beállításait, illeszd be privát kulcsként, és mentsd. A companion rádiókhoz kulcsimportot engedő firmware kell.';

  @override
  String get keyGen_tryAgain => 'Újabb készítése';

  @override
  String get regionSetup_title => 'Régiók beállítása';

  @override
  String get regionSetup_hubSubtitle =>
      'Az átjátszó elhelyezése a környék régiófájában';

  @override
  String get regionSetup_intro =>
      'A régiók egy területen tartják az üzenetet, ahelyett hogy elárasztanák az egész hálót. Az átjátszó csak akkor továbbítja egy régió üzeneteit, ha hordozza azt a régiót, ezért add meg neki a saját régióját és az összes fölötte lévőt.';

  @override
  String get regionSetup_where => 'Hol van az átjátszó?';

  @override
  String get regionSetup_tree => 'Régiófa';

  @override
  String get regionSetup_custom => 'Egyéni';

  @override
  String get regionSetup_region => 'Leghelyibb régió';

  @override
  String get regionSetup_customLabel => 'Régiók, a legtágabbtól';

  @override
  String regionSetup_invalidName(String name) {
    return 'A(z) „$name” nem érvényes régiónév. Használj kisbetűket, számokat és kötőjelet, legfeljebb 29 karaktert.';
  }

  @override
  String regionSetup_tooMany(int max) {
    return 'Egy átjátszó legfeljebb $max régiót hordozhat.';
  }

  @override
  String get regionSetup_options => 'Beállítások';

  @override
  String get regionSetup_setDefault =>
      'A leghelyibb régió legyen az alapértelmezett';

  @override
  String get regionSetup_setDefaultBody =>
      'Az átjátszó saját hirdetései ebben a régióban maradnak.';

  @override
  String get regionSetup_legacy => '1.14-es firmware';

  @override
  String get regionSetup_legacyBody =>
      'Minden régió után region allowf parancsot ad. 1.15-től nem kell.';

  @override
  String get regionSetup_denyUnscoped =>
      'Ne továbbítsa a régió nélküli üzeneteket';

  @override
  String get regionSetup_denyUnscopedBody =>
      'Csak akkor kapcsold be, ha az egész környék régiókat használ, különben a régebbi alkalmazások üzenetei nem jutnak át.';

  @override
  String get regionSetup_commands => 'Parancsok';

  @override
  String get regionSetup_copyAll => 'Összes másolása';

  @override
  String get regionSetup_copied => 'Másolva';

  @override
  String get regionSetup_pickFirst =>
      'Válassz régiót a parancsok megtekintéséhez.';

  @override
  String regionSetup_sendTo(String name) {
    return 'Küldés ide: $name';
  }

  @override
  String get regionSetup_howToSend =>
      'A küldéshez jelentkezz be az átjátszóba, és nyisd meg a menüjében a Régiók beállítása pontot, vagy illeszd be a parancsokat a parancssorába.';

  @override
  String get regionSetup_noReply => 'Nincs válasz. Itt megállt.';

  @override
  String get regionSetup_addToMine => 'Ezek a régiók kerüljenek a listámra';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count régió hozzáadva a listádhoz',
      one: '1 régió hozzáadva a listádhoz',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => 'Útvonalnapló';

  @override
  String get trackLog_subtitle => 'Rögzíts nyomvonalat a rádió GPS-éből';

  @override
  String get trackLog_recording => 'Rögzítés folyamatban';

  @override
  String get trackLog_notRecording => 'Nincs rögzítés';

  @override
  String get trackLog_noGps =>
      'A rádió nem jelent GPS-pozíciót. Az útvonalnaplóhoz bekapcsolt GPS-ű rádió kell.';

  @override
  String get trackLog_start => 'Rögzítés indítása';

  @override
  String get trackLog_stop => 'Rögzítés leállítása';

  @override
  String get trackLog_howItWorks =>
      'A rádió által nagyjából percenként jelentett pozíciót használja, amíg a NOTORYX Core nyitva van. 25 m elmozdulás után vagy egy helyben 15 percenként kerül be új pont.';

  @override
  String get trackLog_snap => 'Pozíciók kerekítése kb. 100 m-re';

  @override
  String get trackLog_snapBody =>
      'Adatvédelem miatt, ha megosztasz egy útvonalat.';

  @override
  String get trackLog_saved => 'Mentett útvonalak';

  @override
  String get trackLog_none => 'Még nincs útvonal.';

  @override
  String get trackLog_export => 'Exportálás GPX-ként';

  @override
  String get trackLog_exportFailed => 'Az útvonalat nem sikerült exportálni.';

  @override
  String get trackLog_deleteTitle => 'Törlöd ezt az útvonalat?';

  @override
  String get trackLog_deleteBody =>
      'Eltűnik erről az eszközről. Az exportált GPX-fájlok megmaradnak.';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km km · $duration · $points pont';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'NOTORYX útvonal $when';
  }

  @override
  String get routes_nearbyTitle => 'Legjobb közeli átjátszók';

  @override
  String get routes_nearbyEmptyTitle => 'Még nem hallatszik átjátszó';

  @override
  String get routes_nearbyEmpty =>
      'A rádió által közvetlenül hallott átjátszók itt jelennek meg, a legerősebb elöl, ahogy forgalmat fogad. A lista az utolsó órát mutatja.';

  @override
  String get routes_unknownRepeater => 'Ismeretlen átjátszó';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alkalommal hallva',
      one: 'egyszer hallva',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes perce',
      one: '1 perce',
      zero: 'épp most',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return 'ezen át: $names';
  }

  @override
  String get nav_home => 'Kezdőlap';

  @override
  String get nav_chats => 'Csevegések';

  @override
  String get nav_tools => 'Eszközök';

  @override
  String get nav_settings => 'Beállítások';

  @override
  String get nav_more => 'Továbbiak';

  @override
  String get tools_groupApp => 'Alkalmazás és beállítások';

  @override
  String get tools_groupField => 'Terepen';

  @override
  String get tools_groupMaps => 'Térképek és lefedettség';

  @override
  String get tools_groupRouting => 'Útvonalak és átjátszók';

  @override
  String get tools_pathGraph => 'Útvonalgráf';

  @override
  String get tools_pathGraphHint =>
      'Hogyan érnek el az üzenetek: minden hallott útvonal a legforgalmasabb átjátszókkal';

  @override
  String get tools_antenna => 'Antennalefedettség';

  @override
  String get tools_antennaHint =>
      'Becsülje meg, meddig ér el egy antenna a terepen';

  @override
  String routes_repeaterWithId(String id) {
    return 'Átjátszó $id';
  }

  @override
  String get coverageHex_title => 'Lefedettségi hatszögek';

  @override
  String get coverageHex_toolSubtitle =>
      'Térképezze fel, hol hallja a rádió a hálózatot, és ossza meg';

  @override
  String get coverageHex_mapCoverage => 'Lefedettség térképezése';

  @override
  String get coverageHex_statusOff =>
      'Kikapcsolva. Kapcsolja be vezetés vagy séta közben, hogy feltérképezze, hol hallja a rádió a hálózatot.';

  @override
  String get coverageHex_waitingGps => 'Várakozás GPS-re…';

  @override
  String coverageHex_gpsTooRough(String meters) {
    return 'GPS-pontosság $meters m: túl pontatlan, nincs rögzítés.';
  }

  @override
  String coverageHex_recording(String meters) {
    return 'Rögzítés. GPS-pontosság $meters m.';
  }

  @override
  String get coverageHex_hexagons => 'Hatszögek';

  @override
  String get coverageHex_samples => 'Minták';

  @override
  String get coverageHex_privacyNote =>
      'A telefon GPS-ét használja, amíg ez a kapcsoló be van kapcsolva. Csak a hatszögazonosítók (kb. 0,9 km) kerülnek megosztásra, a pontos helyzete soha.';

  @override
  String get coverageHex_uploadSection => 'Feltöltés lefedettségi térképekre';

  @override
  String get coverageHex_wifiOnly => 'Feltöltés csak Wi-Fi-n';

  @override
  String get coverageHex_wifiOnlyHint =>
      'A minták a telefonon várnak (legfeljebb 7 napig) a Wi-Fi-re.';

  @override
  String coverageHex_waiting(String count) {
    return '$count várakozik';
  }

  @override
  String get coverageHex_addMap => 'Lefedettségi térkép hozzáadása';

  @override
  String get coverageHex_addMapHint =>
      'Bármely HTTPS-végpont, amely fogad lefedettségi feltöltést.';

  @override
  String get coverageHex_uploadNow => 'Feltöltés most';

  @override
  String get coverageHex_mapDialogTitle => 'Lefedettségi térkép';

  @override
  String get coverageHex_nameMissing => 'Adjon neki nevet.';

  @override
  String get coverageHex_url => 'Feltöltési URL';

  @override
  String get coverageHex_urlInvalid => 'https:// URL-nek kell lennie.';

  @override
  String get coverageHex_apiKey => 'API-kulcs (nem kötelező)';

  @override
  String get coverageHex_apiKeyHint => 'X-API-Key fejlécként küldve.';

  @override
  String get coverageHex_format => 'Formátum';

  @override
  String get coverageHex_formatHex => 'Hatszögazonosítók (NOTORYX)';

  @override
  String get coverageHex_formatMeshMapper => 'MeshMapper-kompatibilis';

  @override
  String get coverageHex_privacy => 'Adatvédelem';

  @override
  String get coverageHex_privacyLive => 'Élő';

  @override
  String get coverageHex_privacyDelayed => '3 órás késleltetés';

  @override
  String get coverageHex_privacyAnonymous => 'Névtelen, 24 óra';

  @override
  String get coverageHex_privacyLiveHint => 'Kb. 15 percen belül elküldve.';

  @override
  String get coverageHex_privacyDelayedHint =>
      '3 órán át visszatartva, hogy a térkép ne mutassa, hol van most.';

  @override
  String get coverageHex_privacyAnonymousHint =>
      '24 órán át visszatartva, csak dátummal és aláírás nélkül, így a feltöltések nem köthetők össze.';

  @override
  String get coverageHex_uploadsOn => 'Feltöltés bekapcsolva';

  @override
  String coverageHex_sent(String count, String time) {
    return '$count cella elküldve, $time.';
  }

  @override
  String coverageHex_httpError(String code) {
    return 'A térkép válasza: $code; újrapróbálja.';
  }

  @override
  String get coverageHex_unreachable => 'A térkép nem érhető el; újrapróbálja.';

  @override
  String get coverageHex_noPermission =>
      'A helymeghatározási engedély nincs megadva.';

  @override
  String get coverageHex_noGps => 'A GPS nem érhető el.';

  @override
  String get coverageHex_loadFailed =>
      'A mentett lefedettség nem olvasható; újrakezdés.';

  @override
  String get mqttExtra_wifiOnly => 'Csatlakozás csak Wi-Fi-n';

  @override
  String mqttExtra_backlog(String count) {
    return '$count csomag vár feltöltésre (legfeljebb 72 óráig tárolva).';
  }

  @override
  String get mqttExtra_add => 'Másik bróker hozzáadása';

  @override
  String get mqttExtra_addBody =>
      'Megosztja a rádió által hallottakat még egy MQTT-brókerrel a fő mellett. Csak feltölt, sosem küld csomagot vissza az alkalmazásba.';

  @override
  String get mqttExtra_separateKey => 'Külön kulcs használata';

  @override
  String get mqttExtra_separateKeyHint =>
      'A rádióé helyett ezen a telefonon készült kulccsal jelentkezik be, így a bróker nem kötheti a feltöltéseket a rádiójához.';

  @override
  String mqttExtra_removeTitle(String name) {
    return 'Eltávolítja: $name?';
  }

  @override
  String get mqttExtra_removeBody =>
      'Bontja a kapcsolatot, és elfelejti a beállításokat, jelszót, kulcsot és a várakozó csomagokat.';

  @override
  String mqttExtra_ownKey(String key) {
    return 'Saját kulccsal jelentkezik be: $key…';
  }

  @override
  String get botWx_title => 'Időjárási riasztások közzététele csatornán';

  @override
  String get botWx_body =>
      '10 percenként lekéri az amerikai Nemzeti Meteorológiai Szolgálat súlyos és szélsőséges figyelmeztetéseit a rádió GPS-helyén (kb. 1 km-re kerekítve), és minden újat egyszer közzétesz. Internet szükséges a telefonon.';

  @override
  String get botWx_channel => 'Közzététel csatornán';

  @override
  String get botWx_moderate => 'Mérsékelt riasztások is';

  @override
  String get botWx_moderateHint =>
      'Tájékoztatók és figyelmeztetések is. Több üzenet.';

  @override
  String botWx_lastChecked(String time) {
    return 'Utolsó ellenőrzés: $time.';
  }

  @override
  String get botWx_noPosition => 'A rádió még nem jelentett GPS-helyet.';

  @override
  String get botWx_noChannel => 'Válasszon csatornát a riasztásokhoz.';

  @override
  String get botWx_channelGone => 'A kiválasztott csatorna már nem létezik.';

  @override
  String botWx_httpError(String code) {
    return 'Az időjárási szolgálat válasza: $code.';
  }

  @override
  String get botWx_unreachable => 'Az időjárási szolgálat nem érhető el.';

  @override
  String get botCmd_sun => 'Napkelte és napnyugta a rádió GPS-helyén.';

  @override
  String get botCmd_moon => 'Holdfázis és megvilágítottság.';

  @override
  String get botCmd_weather =>
      'Aktuális időjárás a rádiónál (Open-Meteo). A helyet kb. 1 km-re kerekítve küldi.';

  @override
  String get botCmd_dice => 'Kockadobás: !dice, !dice 20 vagy !dice 2d6.';

  @override
  String get botCmd_trace =>
      'Felsorolja az átjátszókat, amelyeken az üzenet érkezett.';

  @override
  String get ping_title => 'Átjátszó ping';

  @override
  String get ping_toolSubtitle =>
      'Oda-vissza idő és jel mindkét irányban egy közeli átjátszóhoz';

  @override
  String get ping_noRepeaters => 'Még nincs ismert átjátszó';

  @override
  String get ping_choose => 'Válasszon átjátszót';

  @override
  String get ping_avgMs => 'ms oda-vissza';

  @override
  String get ping_snrThere => 'SNR ott';

  @override
  String get ping_snrBack => 'SNR vissza';

  @override
  String get ping_loss => 'Elveszett';

  @override
  String ping_running(int done, int total) {
    return 'Ping: $done / $total…';
  }

  @override
  String ping_start(int count) {
    return '$count ping';
  }

  @override
  String get ping_results => 'Próbák';

  @override
  String get ping_noReply => 'Nincs válasz';

  @override
  String ping_resultLine(String ms, String snr) {
    return '$ms ms · SNR ott $snr';
  }

  @override
  String get ping_explainer =>
      'Minden próba egyugrásos útvonalkövetés: az átjátszó feljegyzi, mennyire hallotta, és visszaküldi. Közvetlenül hallott átjátszóknál működik.';

  @override
  String get hunt_title => 'Antennakeresés';

  @override
  String get hunt_toolSubtitle =>
      'Nagy élő jelmérő, amely erősebb jelnél gyorsabban kattog';

  @override
  String get hunt_noSignal => 'Még nincs jel';

  @override
  String get hunt_noReply =>
      'Nincs válasz – mozdítsa vagy fordítsa az antennát';

  @override
  String get hunt_heardHere => 'dB itt hallva';

  @override
  String get hunt_best => 'Legjobb';

  @override
  String get hunt_sound => 'Kattogás erősödő jelnél';

  @override
  String get hunt_soundHint =>
      'Minden kattanásnál rezgéssel, hogy nézés nélkül célozhasson.';

  @override
  String get hunt_stop => 'Leállítás';

  @override
  String get hunt_start => 'Keresés indítása';

  @override
  String get hunt_explainer =>
      'Másodpercenként nagyjából egyszer szondázza az átjátszót. Irányítson irányított antennát vagy sétáljon: a szám azt mutatja, mennyire hallja a rádió.';

  @override
  String get settings_refreshRate => 'Frissítési gyakoriság';

  @override
  String get settings_refreshFast => 'Gyors';

  @override
  String get settings_refreshNormal => 'Normál';

  @override
  String get settings_refreshSlow => 'Lassú';

  @override
  String get settings_refreshFastHint =>
      'Akkumulátor percenként, GPS 30 mp-enként. Frissebb adatok, több fogyasztás.';

  @override
  String get settings_refreshNormalHint =>
      'Akkumulátor 2 percenként, GPS percenként.';

  @override
  String get settings_refreshSlowHint =>
      'Akkumulátor 6 percenként, GPS 3 percenként. Kíméli az akkut.';

  @override
  String get settings_refreshSaverOn =>
      'Az energiatakarékos mód be van kapcsolva, ez szabja meg az ütemet (akkumulátor 10 percenként).';

  @override
  String get reach_check => 'Megfigyelői elérés ellenőrzése';

  @override
  String get reach_title => 'Megfigyelői elérés';

  @override
  String get reach_noHash =>
      'Ez az üzenet még nem kereshető: egy átjátszó sem küldte vissza a rádiónak, így a csomagazonosító ismeretlen.';

  @override
  String get reach_unreachable =>
      'Az elemző nem érhető el. Ellenőrizze az internetet vagy az elemző címét a beállításokban.';

  @override
  String get reach_none =>
      'Még egy megfigyelő sem hallotta. A megfigyelők kicsivel a vétel után töltenek fel, nézze meg egy perc múlva.';

  @override
  String get reach_observers => 'megfigyelő';

  @override
  String get reach_maxHops => 'max. ugrás';

  @override
  String get reach_bestSnr => 'legjobb SNR';

  @override
  String reach_hops(int count) {
    return '$count ugrásnyira';
  }

  @override
  String get reach_explainer =>
      'Az online elemzőből: megfigyelők, akik hallották és feltöltötték a csomagot.';

  @override
  String get reach_checkAgain => 'Újra';

  @override
  String get analyzer_title => 'Online elemző';

  @override
  String get analyzer_url => 'Elemző címe';

  @override
  String get analyzer_urlHint =>
      'CoreScope elemző (https://). A régiójához tartozót használja.';

  @override
  String get analyzer_reset => 'Alapértelmezett';

  @override
  String get analyzer_hint =>
      'Annak ellenőrzésére, mely megfigyelők hallották az üzeneteit. Csak a csomagazonosítót küldi.';

  @override
  String get analyzer_hopLookup => 'Ismeretlen átjátszók nevei online';

  @override
  String get analyzer_hopLookupHint =>
      'Ha egy átjátszó-azonosító nincs a névjegyei között, az elemző megadja a nevét. Csak a rövid azonosítókat küldi. A „?” végű név azt jelenti, hogy több átjátszó osztozik az azonosítón.';

  @override
  String discovered_tray(int count) {
    return 'Közelben hallott csatornák: $count';
  }

  @override
  String get discovered_title => 'Közelben hallott, nem csatlakozott';

  @override
  String discovered_heard(int count, String time) {
    return '$count× hallva · utoljára $time';
  }

  @override
  String get discovered_ignore => 'Mellőzés';

  @override
  String get discovered_ignoreAll => 'Összes mellőzése';

  @override
  String get discovered_joinAll => 'Csatlakozás mindhez';

  @override
  String get discovered_explainer =>
      'Ezek a csatornakönyvtár nyilvános csatornái, amelyeken a rádió forgalmat hallott. Mindegyiket egy üzenet visszafejtése igazolta. A mellőzöttek rejtve maradnak.';

  @override
  String get mqtt_presetMeshRank => 'MeshRank (közösségi)';

  @override
  String get mqtt_presetMeshRankNote =>
      'A MeshRank közösségi MeshCore-hálózatrangsor, nem része a NOTORYX-nek, és az nem támogatja. Bejelentkezés nélkül: a csomagok a rádió kulcsával és régiókódjával kerülnek megosztásra, csak ha bekapcsolja a megosztást.';

  @override
  String get pathFilter_title => 'Útvonalszélesség-szűrő';

  @override
  String get pathFilter_firmwareNote =>
      'Továbbítási szabályokat ismerő átjátszó-firmware kell (mikecarper/MeshCore). A hivatalos MeshCore firmware elutasítja ezeket a parancsokat.';

  @override
  String get pathFilter_width => 'Útvonalszélesség';

  @override
  String get pathFilter_anyWidth => 'Bármilyen szélesség';

  @override
  String pathFilter_bytes(int n) {
    return '$n bájtos útvonalak';
  }

  @override
  String get pathFilter_twoOrMore => '2 vagy 3 bájt (2+)';

  @override
  String get pathFilter_path => 'Erre vonatkozik';

  @override
  String get pathFilter_radio => 'Rádiós elárasztás';

  @override
  String get pathFilter_bridge => 'Híd';

  @override
  String get pathFilter_cross => 'Átkötés';

  @override
  String get pathFilter_bridgeCross => 'Híd és átkötés';

  @override
  String get pathFilter_limit => 'Korlátozás eldobás helyett';

  @override
  String get pathFilter_limitOn =>
      'Percenként legfeljebb adott számút továbbít.';

  @override
  String get pathFilter_drop => 'Az egyező elárasztások eldobódnak.';

  @override
  String get pathFilter_perMinute => 'Percenként';

  @override
  String get pathFilter_rateInvalid => 'Adjon meg 1 és 65534 közötti értéket.';

  @override
  String get pathFilter_reviewNote =>
      'Ez csak kitölti a parancssort. Ellenőrizze, majd nyomja meg a Küldést. Előbb a „get fr” mutatja a meglévő szabályokat.';

  @override
  String get pathFilter_useCommand => 'Parancs használata';

  @override
  String get settings_linkPreviews => 'Hivatkozás-előnézetek';

  @override
  String get settings_linkPreviewsHint =>
      'Megjeleníti az üzenetben lévő hivatkozás címét. Alapból ki: az oldal lekérése elárulja az IP-címét a webhelynek.';

  @override
  String get guide_title => 'Terepi útmutató';

  @override
  String get guide_subtitle => 'Alapok, akkuk hidegben, napelem és antennák';

  @override
  String get guide_secMesh => 'Csatlakozás a hálózathoz';

  @override
  String get guide_mesh1 =>
      'A telefon Bluetooth-on, USB-n vagy Wi-Fi-n beszél a rádióval; a rádió LoRán a hálózattal. Az üzenetek térerő nélkül is mennek.';

  @override
  String get guide_mesh2 =>
      'Az átjátszók továbbadják az üzeneteket; minden továbbítás egy ugrás. Kevesebb ugrás gyorsabb, megbízhatóbb kézbesítés.';

  @override
  String get guide_mesh3 =>
      'Írjon röviden, és ne árassza el a forgalmas csatornákat: minden üzenet közös adásidőt használ.';

  @override
  String get guide_secCold => 'Akkuk hidegben';

  @override
  String get guide_cold1 =>
      'Ne töltse a lítiumakkut fagypont alatt (0 °C): maradandóan károsodik.';

  @override
  String get guide_cold2 =>
      'Tartsa a rádiót a kabátja alatt. A hideg csökkenti a kapacitást, ami melegben visszatér.';

  @override
  String get guide_cold3 =>
      'Hideg éghajlatú fix helyeken a LiFePO4 jobban bírja, mint a lítiumion; fűtött vagy szigetelt doboz mindkettőnek segít.';

  @override
  String get guide_secSolar => 'Napelem átjátszókhoz';

  @override
  String get guide_solar1 =>
      'Az átjátszó nagyon keveset fogyaszt, de a panelt és az akkut a legsötétebb téli hétre méretezze, ne nyári napra.';

  @override
  String get guide_solar2 =>
      'Fordítsa a panelt az Egyenlítő felé, télen meredeken döntve; tartsa távol a havat és az árnyékot.';

  @override
  String get guide_secAntenna => 'Antennák és elhelyezés';

  @override
  String get guide_ant1 =>
      'A magasság többet ér a teljesítménynél: néhány méterrel feljebb sokkal messzebb ér a rádió, mint az asztalon.';

  @override
  String get guide_ant2 =>
      'Tartsa az antennát függőlegesen, fémtől távol, és a sávjához valót használjon (pl. 868 MHz Európában).';

  @override
  String get guide_secMore => 'További információ';

  @override
  String get guide_moreMeshcore => 'A hivatalos MeshCore projekt';

  @override
  String get guide_moreCascadia =>
      'Közösségi útmutatók: kezdés, wardriving, régiók, napelem';

  @override
  String get post_signed => 'Aláírt';

  @override
  String get post_unverified => 'Nem ellenőrzött';

  @override
  String post_signedKnown(String name) {
    return 'Aláírta: $name, az egyik névjegye.';
  }

  @override
  String get post_signedUnknownKey =>
      'Aláírt, de nem az egyik névjegye írta alá. Vegye fel a feladót névjegyként, hogy lássa, ki az.';

  @override
  String get post_unverifiedHint =>
      'A bejegyzéssel aláírás érkezett, de nem egyezik. Lehet, hogy útközben megváltozott, vagy nem attól származik, akitől állítja.';

  @override
  String get settings_signPosts => 'Minden csatornabejegyzésem aláírása';

  @override
  String get settings_signPostsHint =>
      'A csatornára küldött SOS mindig aláírt. Ez minden bejegyzést aláír, így más NOTORYX-felhasználók láthatják, hogy valóban Ön az. Minden aláírás egy további csomag az éterben.';

  @override
  String get tools_search => 'Eszközök és beállítások keresése';

  @override
  String get tools_noMatches => 'Nincs a keresésnek megfelelő eszköz.';

  @override
  String get tools_bot => 'Bot mód';

  @override
  String get tools_botHint =>
      'Automatikus válaszok, !parancsok és időjárási riasztások a csatornákon';

  @override
  String get botChannels_title => 'Csatornák';

  @override
  String get botChannels_hint =>
      'A bot a bekapcsolt csatornákon is válaszol a !parancsokra, ugyanabban a csatornában. Távollét-választ ott sosem küld.';

  @override
  String get botChannels_none => 'Ezen a rádión még nincs csatorna.';

  @override
  String get advert_zeroHopHint =>
      'Csak a közvetlenül halló rádiók. Az átjátszók nem továbbítják.';

  @override
  String get advert_floodHint =>
      'Az átjátszók az egész hálózatban továbbítják. Több adásidőt használ.';

  @override
  String get radioPresets_custom => 'Egyéni';

  @override
  String get radioPresets_search => 'Előbeállítás keresése';

  @override
  String get radioPresets_suggested => 'Ajánlott a régiójához';

  @override
  String get radioPresets_community => 'Közösségi előbeállítások';

  @override
  String get radioPresets_hint =>
      'Ezeket az előbeállításokat a MeshCore közösség ajánlja. Válassza a helyi hálózatét. Beállítja a frekvenciát, sávszélességet, SF-et és CR-t; az adóteljesítmény marad.';

  @override
  String get mySensors_title => 'Érzékelők';

  @override
  String get mySensors_refresh => 'Érzékelők olvasása';

  @override
  String get mySensors_reading => 'A rádió érzékelőinek olvasása…';

  @override
  String get mySensors_failed =>
      'A rádió nem válaszolt. Koppintson a frissítésre.';

  @override
  String get mySensors_none => 'Nincs érzékelőadat a rádiótól.';

  @override
  String get activeChannels_title => 'Aktív online';

  @override
  String activeChannels_messages(int count) {
    return '$count üzenet';
  }

  @override
  String activeChannels_source(String host) {
    return 'Használt csatornák $host megfigyelői szerint. A beállításokban válasszon a régiójához tartozó elemzőt.';
  }

  @override
  String get fieldOps_checkInChannelLabel =>
      'A bejelentkezések csatornára is mennek';

  @override
  String get fieldOps_checkInChannelHint =>
      'A rádió kulcsával aláírva, így a csatornán mások látják, hogy tényleg Öntől jön. Az út kontaktjai közvetlenül is megkapják.';

  @override
  String get channels_regionUnknown => 'Regionális';

  @override
  String channels_regionSemantics(String region) {
    return 'Elküldve a(z) $region régiónak';
  }

  @override
  String get channels_regionUnknownSemantics =>
      'Az alkalmazás által nem ismert régiónak küldve';

  @override
  String get wardrive_title => 'Lefedettség-felmérés';

  @override
  String get wardrive_hint =>
      'Pingeljen onnan, ahol van, és térképezze fel, mely átjátszók hallják';

  @override
  String get wardrive_start => 'Indítás';

  @override
  String get wardrive_stop => 'Leállítás';

  @override
  String get wardrive_pings => 'ping';

  @override
  String get wardrive_heard => 'hallott';

  @override
  String get wardrive_pinging => 'Pingelés…';

  @override
  String get wardrive_waitPosition =>
      'Várakozás a telefon vagy a rádió GPS-pozíciójára.';

  @override
  String get wardrive_waitRadio => 'Csatlakoztasson rádiót a pingeléshez.';

  @override
  String get wardrive_history => 'Előzmények';

  @override
  String get wardrive_noSessions => 'Még nincs felmérés.';

  @override
  String wardrive_sessionSummary(int pings, int heard) {
    return '$pings ping · $heard hallott';
  }

  @override
  String get wardrive_delete => 'Törlés';

  @override
  String get wardrive_recentre => 'Vissza a pozíciómhoz';

  @override
  String get wardrive_youAreHere => 'Itt vagy';

  @override
  String get wardrive_backToLive => 'Vissza az aktuálishoz';

  @override
  String get wardrive_noReplies => 'Egy átjátszó sem hallotta ezt a pinget.';

  @override
  String wardrive_replyDetail(String there, String here) {
    return '$there dB-lel hallotta · Ön $here dB-lel hallotta';
  }

  @override
  String get wardrive_explainer =>
      'Minden ping nulla ugrásos felderítő kérés: csak a közvetlen hatótávú átjátszók válaszolnak, csatornára semmi sem kerül. A pozíció a telefon GPS-éből jön, ennek hiányában a rádióéból.';

  @override
  String get mapTelemetry_policy =>
      'A mentett mérések 1 óra után halványulnak, 24 óra után eltűnnek. A frissítés egy kérést küld; a csomópontnak engedélyeznie kell a telemetriát, az érzékelők pedig bejelentkezést kérhetnek. A térkép soha nem kér automatikus frissítést.';

  @override
  String get autoConnect_title => 'Automatikus csatlakozás a rádiómhoz';

  @override
  String get autoConnect_hint =>
      'Az alkalmazás megnyitásakor koppintás nélkül újracsatlakozik az utolsó rádióhoz. Ha még nincs hatótávon belül, többször is próbálkozik.';
}
