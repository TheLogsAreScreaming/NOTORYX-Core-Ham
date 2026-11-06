// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core';

  @override
  String get nav_contacts => 'Contatti';

  @override
  String get nav_channels => 'Canali';

  @override
  String get nav_map => 'Mappa';

  @override
  String get nav_messages => 'Messaggi';

  @override
  String get nav_nodes => 'Nodi';

  @override
  String get nav_radio => 'Radio';

  @override
  String get messages_title => 'Messaggi';

  @override
  String get messages_filterAll => 'Tutti';

  @override
  String get messages_filterDirect => 'Diretti';

  @override
  String get messages_filterChannels => 'Canali';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'Cerca messaggi';

  @override
  String get messages_searchHint => 'Cerca conversazioni';

  @override
  String get messages_closeSearch => 'Chiudi ricerca';

  @override
  String get messages_manageChannels => 'Gestisci canali';

  @override
  String get messages_new => 'Nuovo';

  @override
  String get messages_newDirect => 'Scrivi a un nodo';

  @override
  String get messages_newChannel => 'Aggiungi o unisciti a un canale';

  @override
  String get messages_empty => 'Ancora nessuna conversazione';

  @override
  String get messages_emptyHint => 'Qui compaiono i messaggi da nodi e canali.';

  @override
  String get messages_noMatches =>
      'Nessuna conversazione corrisponde alla ricerca';

  @override
  String messages_you(String text) {
    return 'Tu: $text';
  }

  @override
  String get messages_yesterday => 'Ieri';

  @override
  String messages_unreadCount(int count) {
    return '$count non letti';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return 'Connesso tramite $transport';
  }

  @override
  String get radioStatus_bluetooth => 'Bluetooth';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'Wi‑Fi (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return 'Batteria $percent%';
  }

  @override
  String get radioStatus_openRadio => 'Apri dettagli radio';

  @override
  String get radioOverview_battery => 'Batteria';

  @override
  String radioOverview_firmware(String version) {
    return 'Firmware $version';
  }

  @override
  String get radioOverview_sendAdvert => 'Invia annuncio';

  @override
  String get radioOverview_stats => 'Statistiche radio';

  @override
  String get accessControl_title => 'Controllo accessi';

  @override
  String get accessControl_hubSubtitle => 'Chi può accedere senza password';

  @override
  String get accessControl_explainRepeater =>
      'Le persone in questa lista accedono senza password. Gli admin possono modificare le impostazioni; Sola lettura e Lettura e scrittura ricevono anche la telemetria completa.';

  @override
  String get accessControl_explainRoom =>
      'Gli admin in questa lista accedono senza password e possono gestire la stanza. I membri della stanza entrano invece con la password della stanza.';

  @override
  String get accessControl_roleReadOnly => 'Sola lettura';

  @override
  String get accessControl_roleReadWrite => 'Lettura e scrittura';

  @override
  String get accessControl_roleAdmin => 'Admin';

  @override
  String get accessControl_you => 'Tu';

  @override
  String get accessControl_unknownNode => 'Nodo sconosciuto';

  @override
  String get accessControl_add => 'Aggiungi';

  @override
  String get accessControl_addTitle => 'Aggiungi alla lista di accesso';

  @override
  String get accessControl_pickContact => 'Scegli un contatto';

  @override
  String get accessControl_noContacts =>
      'Nessun contatto da aggiungere. I nodi compaiono qui dopo che hai ricevuto il loro annuncio.';

  @override
  String get accessControl_changeRole => 'Cambia ruolo';

  @override
  String get accessControl_remove => 'Rimuovi accesso';

  @override
  String accessControl_removeConfirm(String name) {
    return 'Rimuovere $name dalla lista di accesso? Per accedere servirà la password.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'Sei tu. Se ti rimuovi, ti servirà la password di admin per gestire di nuovo questo nodo.';

  @override
  String get accessControl_unknownKeyNote =>
      'Non è nei tuoi contatti. Per cambiarne il ruolo serve un firmware del nodo più recente; la rimozione funziona sempre.';

  @override
  String get accessControl_prefixUnsupported =>
      'Il firmware di questo nodo non può cambiare il ruolo di chi non è nei tuoi contatti. Puoi comunque rimuoverlo.';

  @override
  String get accessControl_empty => 'Nessuno è nella lista di accesso';

  @override
  String get accessControl_emptyHint =>
      'Aggiungi persone perché possano accedere senza password.';

  @override
  String get accessControl_loading =>
      'Richiesta della lista di accesso al nodo…';

  @override
  String get accessControl_timeout =>
      'Il nodo non ha risposto. Controlla il percorso e riprova.';

  @override
  String get accessControl_maybeIncomplete =>
      'Questo nodo ha inviato una pagina completa e il suo firmware non può inviarne altre, quindi potrebbero mancare voci.';

  @override
  String get accessControl_saved => 'Lista di accesso aggiornata';

  @override
  String accessControl_failed(String reply) {
    return 'Il nodo ha rifiutato la modifica: $reply';
  }

  @override
  String get companionCli_title => 'Riga di comando';

  @override
  String get companionCli_tileSubtitle => 'Esegui comandi sulla tua radio';

  @override
  String get companionCli_warning =>
      'I comandi vengono eseguiti sulla radio collegata e possono modificarne le impostazioni o riavviarla.';

  @override
  String get companionCli_hint => 'Scrivi un comando, ad es. ver';

  @override
  String get companionCli_send => 'Esegui comando';

  @override
  String get companionCli_noReply =>
      'Nessuna risposta. La radio potrebbe essere in riavvio.';

  @override
  String get companionCli_empty =>
      'Prova uno dei comandi qui sopra o scrivine uno tuo.';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle => 'Collega la radio a una rete Wi‑Fi';

  @override
  String get wifi_unsupported =>
      'Il firmware di questa radio non include il Wi‑Fi.';

  @override
  String get wifi_enabled => 'Usa Wi‑Fi';

  @override
  String get wifi_status => 'Stato';

  @override
  String get wifi_connected => 'Connesso';

  @override
  String wifi_connectedIp(String ip) {
    return 'Connesso · $ip';
  }

  @override
  String get wifi_disconnected => 'Non connesso';

  @override
  String get wifi_network => 'Nome rete (SSID)';

  @override
  String get wifi_password => 'Password';

  @override
  String get wifi_passwordKeep =>
      'Lascia vuoto per mantenere la password attuale';

  @override
  String get wifi_save => 'Salva';

  @override
  String get wifi_forget => 'Dimentica rete';

  @override
  String get wifi_forgetConfirm =>
      'Rimuovere dalla radio la rete e la password salvate?';

  @override
  String get wifi_rebootNeeded =>
      'Salvato. Riavvia la radio per applicare le modifiche Wi‑Fi.';

  @override
  String get wifi_rebootNow => 'Riavvia radio';

  @override
  String get wifi_rebootConfirm =>
      'Riavviare la radio ora? L\'app si disconnetterà e dovrai riconnetterti.';

  @override
  String get wifi_loadFailed =>
      'Impossibile leggere le impostazioni Wi‑Fi dalla radio.';

  @override
  String get wifi_retry => 'Riprova';

  @override
  String wifi_saveFailed(String reply) {
    return 'La radio non ha accettato la modifica: $reply';
  }

  @override
  String get accessControl_refresh => 'Aggiorna';

  @override
  String get common_cancel => 'Annulla';

  @override
  String get common_ok => 'OK';

  @override
  String get common_connect => 'Connetti';

  @override
  String get common_unknownDevice => 'Dispositivo sconosciuto';

  @override
  String get common_save => 'Salva';

  @override
  String get common_delete => 'Elimina';

  @override
  String get common_deleteAll => 'Elimina tutto';

  @override
  String get common_close => 'Chiudi';

  @override
  String get common_done => 'Fatto';

  @override
  String get common_edit => 'Modifica';

  @override
  String get common_add => 'Aggiungi';

  @override
  String get common_settings => 'Impostazioni';

  @override
  String get common_disconnect => 'Disconnetti';

  @override
  String get common_connected => 'Connesso';

  @override
  String get common_disconnected => 'Disconnesso';

  @override
  String get common_create => 'Crea';

  @override
  String get common_continue => 'Continua';

  @override
  String get common_share => 'Condividi';

  @override
  String get common_copy => 'Copia';

  @override
  String get common_retry => 'Riprova';

  @override
  String get common_hide => 'Nascondi';

  @override
  String get common_remove => 'Elimina';

  @override
  String get common_enable => 'Abilita';

  @override
  String get common_disable => 'Disattiva';

  @override
  String get common_undo => 'Annulla';

  @override
  String get messageStatus_sent => 'Inviato';

  @override
  String get messageStatus_delivered => 'Consegnato';

  @override
  String get messageStatus_pending => 'Invio';

  @override
  String get messageStatus_failed => 'Impossibile inviare';

  @override
  String get messageStatus_repeated => 'Ricevuto ripetutamente';

  @override
  String get urlImage_enable => 'Attiva immagini da URL';

  @override
  String get urlImage_possible =>
      'Possibile immagine da URL; attivala nelle Impostazioni.';

  @override
  String get common_reboot => 'Riavvia';

  @override
  String get common_loading => 'Caricamento...';

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
  String get common_autoRefresh => 'Aggiornamento automatico';

  @override
  String get common_interval => 'Intervallo';

  @override
  String get scanner_title => 'NOTORYX Core';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'Stabilire una connessione tramite TCP';

  @override
  String get tcpHostLabel => 'Indirizzo IP';

  @override
  String get tcpHostHint => '192.168.40.10';

  @override
  String get tcpPortLabel => 'Porta';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => 'Inserisci l\'endpoint e connettiti.';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return 'Connessione a $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => 'È necessario fornire un indirizzo IP.';

  @override
  String get tcpErrorPortInvalid =>
      'La dimensione della porta deve essere compresa tra 1 e 65535.';

  @override
  String get tcpErrorUnsupported =>
      'Il protocollo TCP non è supportato su questa piattaforma.';

  @override
  String get tcpErrorTimedOut => 'La connessione TCP è scaduta.';

  @override
  String tcpConnectionFailed(String error) {
    return 'Impossibile stabilire la connessione TCP: $error';
  }

  @override
  String get usbScreenTitle => 'Connessione tramite USB';

  @override
  String get usbScreenSubtitle =>
      'Seleziona il dispositivo seriale rilevato e connettilo direttamente al tuo nodo MeshCore.';

  @override
  String get usbScreenStatus => 'Seleziona un dispositivo USB';

  @override
  String get usbScreenNote =>
      'La comunicazione seriale USB è attiva sui dispositivi Android supportati e sulle piattaforme desktop.';

  @override
  String get usbScreenEmptyState =>
      'Nessun dispositivo USB rilevato. Collegare uno e aggiornare.';

  @override
  String get usbErrorPermissionDenied =>
      'È stato negato l\'accesso tramite USB.';

  @override
  String get usbErrorDeviceMissing =>
      'Il dispositivo USB selezionato non è più disponibile.';

  @override
  String get usbErrorInvalidPort => 'Seleziona un dispositivo USB valido.';

  @override
  String get usbErrorBusy =>
      'Un\'altra richiesta di connessione tramite USB è già in corso.';

  @override
  String get usbErrorNotConnected => 'Non è collegato alcun dispositivo USB.';

  @override
  String get usbErrorOpenFailed =>
      'Impossibile aprire il dispositivo USB selezionato.';

  @override
  String get usbErrorConnectFailed =>
      'Impossibile connettersi al dispositivo USB selezionato.';

  @override
  String get usbErrorUnsupported =>
      'La comunicazione seriale tramite USB non è supportata su questa piattaforma.';

  @override
  String get usbErrorAlreadyActive => 'La connessione USB è già attiva.';

  @override
  String get usbErrorNoDeviceSelected =>
      'Non è stato selezionato alcun dispositivo USB.';

  @override
  String get usbErrorPortClosed => 'La connessione USB non è attiva.';

  @override
  String get usbErrorConnectTimedOut =>
      'La connessione è scaduta. Assicurarsi che il dispositivo abbia il firmware USB Companion.';

  @override
  String get usbFallbackDeviceName =>
      'Dispositivo per comunicazione seriale su rete';

  @override
  String get usbStatus_notConnected => 'Seleziona un dispositivo USB';

  @override
  String get usbStatus_connecting => 'Connessione al dispositivo USB...';

  @override
  String get usbStatus_searching => 'Ricerca di dispositivi USB...';

  @override
  String usbConnectionFailed(String error) {
    return 'Errore nella connessione USB: $error';
  }

  @override
  String get scanner_scanning => 'Scansione in corso per i dispositivi...';

  @override
  String get scanner_connecting => 'Connessione...';

  @override
  String get scanner_disconnecting => 'Disconnessione...';

  @override
  String get scanner_notConnected => 'Non connesso';

  @override
  String scanner_connectedTo(String deviceName) {
    return 'Connesso a $deviceName';
  }

  @override
  String get scanner_searchingDevices => 'Ricerca dispositivi MeshCore...';

  @override
  String get scanner_tapToScan =>
      'Tocca Scansiona per trovare i dispositivi MeshCore';

  @override
  String scanner_connectionFailed(String error) {
    return 'Connessione fallita: $error';
  }

  @override
  String get scanner_stop => 'Ferma';

  @override
  String get scanner_scan => 'Scansiona';

  @override
  String get scanner_bluetoothOff => 'Il Bluetooth è disattivato.';

  @override
  String get scanner_bluetoothOffMessage =>
      'Si prega di attivare il Bluetooth per effettuare la scansione dei dispositivi.';

  @override
  String get scanner_chromeRequired => 'Browser Chrome richiesto';

  @override
  String get scanner_chromeRequiredMessage =>
      'Questa applicazione web richiede Google Chrome o un browser basato su Chromium per il supporto Bluetooth.';

  @override
  String get scanner_enableBluetooth => 'Abilita il Bluetooth';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'La funzionalità Bluetooth non è disponibile nel browser. Connettetevi tramite USB invece.';

  @override
  String get device_quickSwitch => 'Passa rapidamente';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => 'Impostazioni';

  @override
  String get settings_deviceInfo => 'Informazioni dispositivo';

  @override
  String get settings_appSettings => 'Impostazioni App';

  @override
  String get settings_appSettingsSubtitle =>
      'Notifiche, messaggi e preferenze della mappa';

  @override
  String get settings_nodeSettings => 'Impostazioni Nodo';

  @override
  String get settings_nodeName => 'Nome Nodo';

  @override
  String get settings_nodeNameNotSet => 'Non impostato';

  @override
  String get settings_nodeNameHint => 'Inserisci nome nodo';

  @override
  String get settings_nodeNameUpdated => 'Nome aggiornato';

  @override
  String get settings_radioSettings => 'Impostazioni Radio';

  @override
  String get settings_radioSettingsSubtitle =>
      'Frequenza, potenza, fattore di diffusione';

  @override
  String get settings_radioSettingsUpdated => 'Impostazioni radio aggiornate';

  @override
  String get settings_regionSettings => 'Regioni';

  @override
  String get settings_regionSettingsSubtitle =>
      'Gestione delle regioni salvate';

  @override
  String get settings_corridorRegion => 'Regione del corridoio';

  @override
  String get settings_corridorRegionDefault => '#corridor (predefinita)';

  @override
  String get settings_corridorRegionHelp =>
      'I pacchetti del corridoio di flood sono contrassegnati con questa regione. I ripetitori senza firmware a corridoio li inoltrano solo se consentono questa regione. Lascia vuoto per il tag predefinito #corridor.';

  @override
  String get settings_corridorRegionHint => 'Nome della regione';

  @override
  String get settings_corridorRegionUseDefault => 'Usa predefinita';

  @override
  String get settings_corridorRegionUpdated =>
      'Regione del corridoio aggiornata';

  @override
  String get settings_corridorRegionFailed =>
      'Impossibile aggiornare la regione del corridoio';

  @override
  String get settings_regionManagement_screenTitle => 'Gestione Regionale';

  @override
  String get settings_regionNameHint => 'Inserisci il nome della regione';

  @override
  String get settings_regionAddRegion => 'Aggiungi regione';

  @override
  String get settings_regionFetchRegions =>
      'Recupera le regioni dai ripetitori';

  @override
  String get settings_regionFetchRegionsFail =>
      'Non sono state trovate regioni';

  @override
  String get settings_regionFetchRegionsAlreadyExists =>
      'Questa regione è già stata aggiunta';

  @override
  String get settings_regionName => 'Nome della Regione';

  @override
  String get settings_regionDeleted => 'Regione cancellata';

  @override
  String get settings_deleteRegion => 'Elimina Regione';

  @override
  String settings_deleteRegionConfirm(String region) {
    return 'Rimuovere \"$region\" dalla lista delle regioni?';
  }

  @override
  String get settings_location => 'Posizione';

  @override
  String get settings_locationSubtitle => 'Coordinate GPS';

  @override
  String get settings_locationUpdated =>
      'Posizione e impostazioni GPS aggiornate';

  @override
  String get settings_locationBothRequired =>
      'Inserire sia la latitudine che la longitudine.';

  @override
  String get settings_locationInvalid => 'Latitudine o longitudine non valide.';

  @override
  String get settings_locationGPSEnable => 'Abilita GPS';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'Abilita l\'aggiornamento automatico della posizione tramite GPS.';

  @override
  String get settings_locationIntervalSec => 'Intervallo GPS (Secondi)';

  @override
  String get settings_locationIntervalInvalid =>
      'L\'intervallo deve essere di almeno 60 secondi e inferiore a 86400 secondi.';

  @override
  String get settings_latitude => 'Latitudine';

  @override
  String get settings_longitude => 'Longitudine';

  @override
  String get settings_contactSettings => 'Impostazioni di contatto';

  @override
  String get settings_contactSettingsSubtitle =>
      'Impostazioni per l\'aggiunta dei contatti';

  @override
  String get settings_privacyMode => 'Modalità Privacy';

  @override
  String get settings_privacyModeSubtitle =>
      'Nascondere nome/luogo negli annunci';

  @override
  String get settings_privacyModeToggle =>
      'Attiva la modalità privacy per nascondere il tuo nome e la tua posizione negli annunci.';

  @override
  String get settings_privacyModeEnabled => 'Modalità privacy abilitata';

  @override
  String get settings_privacyModeDisabled => 'Modalità privacy disabilitata';

  @override
  String get settings_privacy => 'Impostazioni sulla privacy';

  @override
  String get settings_privacySubtitle =>
      'Controlla le informazioni che vengono condivise.';

  @override
  String get settings_privacySettingsDescription =>
      'Scegli le informazioni che il tuo dispositivo condivide con gli altri.';

  @override
  String get settings_denyAll => 'Negare tutto';

  @override
  String get settings_allowByContact => 'Consenti in base ai flag di contatto';

  @override
  String get settings_allowAll => 'Consenti tutto';

  @override
  String get settings_telemetryBaseMode => 'Modalità di base di telemetria';

  @override
  String get settings_telemetryLocationMode =>
      'Modalità di posizionamento telemetrico';

  @override
  String get settings_telemetryEnvironmentMode =>
      'Modalità di ambiente di telemetria';

  @override
  String get settings_advertLocation => 'Posizione dell\'annuncio';

  @override
  String get settings_advertLocationSubtitle =>
      'Includi la posizione nell\'annuncio';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'Annuncio zero-hop automatico all\'aggiornamento GPS';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'Quando la posizione GPS cambia, invia un annuncio zero-hop (richiede la posizione nell\'annuncio).';

  @override
  String get settings_multiAck => 'ACK multipli';

  @override
  String get settings_telemetryModeUpdated => 'Modalità telemetria aggiornata';

  @override
  String get settings_actions => 'Azioni';

  @override
  String get settings_deleteAllPaths => 'Elimina tutti i percorsi';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Cancella tutti i dati di percorso dai contatti.';

  @override
  String get settings_sendAdvertisement => 'Invia annuncio';

  @override
  String get settings_sendAdvertisementSubtitle => 'Trasmetti ora la presenza';

  @override
  String get settings_advertisementSent => 'Annuncio inviato';

  @override
  String get settings_syncTime => 'Sincronizza ora';

  @override
  String get settings_syncTimeSubtitle =>
      'Imposta l\'orologio del dispositivo sull\'ora del telefono';

  @override
  String get settings_timeSynchronized => 'Ora sincronizzata';

  @override
  String get settings_refreshContacts => 'Aggiorna contatti';

  @override
  String get settings_refreshContactsSubtitle =>
      'Ricarica l\'elenco dei contatti dal dispositivo';

  @override
  String get settings_rebootDevice => 'Riavvia dispositivo';

  @override
  String get settings_rebootDeviceSubtitle => 'Riavvia il dispositivo MeshCore';

  @override
  String get settings_rebootDeviceConfirm =>
      'Sei sicuro di voler riavviare il dispositivo? Sarai disconnesso.';

  @override
  String get settings_debug => 'Risoluzione dei problemi';

  @override
  String get settings_companionDebugLog => 'Registro di debug per il supporto';

  @override
  String get settings_companionDebugLogSubtitle =>
      'Comandi, risposte e dati grezzi per protocolli BLE/TCP/USB';

  @override
  String get settings_appDebugLog => 'Log di Debug dell\'App';

  @override
  String get settings_appDebugLogSubtitle =>
      'Messaggi di debug dell\'applicazione';

  @override
  String get settings_about => 'Informazioni';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core v$version';
  }

  @override
  String get settings_aboutLegalese => '2026 Progetto open source MeshCore';

  @override
  String get settings_aboutDescription =>
      'Un client Flutter open source per i dispositivi MeshCore di rete mesh LoRa.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'Dati di elevazione LOS: Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => 'Nome';

  @override
  String get settings_infoId => 'ID';

  @override
  String get settings_infoStatus => 'Stato';

  @override
  String get settings_infoBattery => 'Batteria';

  @override
  String get settings_infoPublicKey => 'Chiave Pubblica';

  @override
  String get settings_infoContactsCount => 'Numero di contatti';

  @override
  String get settings_infoChannelCount => 'Numero di canali';

  @override
  String get settings_infoHardware => 'Hardware';

  @override
  String get settings_infoFirmware => 'Firmware';

  @override
  String get settings_presets => 'Preset';

  @override
  String get settings_frequency => 'Frequenza (MHz)';

  @override
  String get settings_frequencyHelper => '300,0 - 2500,0';

  @override
  String get settings_frequencyInvalid => 'Frequenza non valida (300-2500 MHz)';

  @override
  String get settings_bandwidth => 'Larghezza di banda';

  @override
  String get settings_spreadingFactor => 'Fattore di diffusione';

  @override
  String get settings_codingRate => 'Tasso di Codifica';

  @override
  String get settings_txPower => 'Potenza TX (dBm)';

  @override
  String get settings_txPowerHelper => '0 - 22';

  @override
  String get settings_txPowerInvalid => 'Potenza TX non valida (0-22 dBm)';

  @override
  String get settings_clientRepeat => 'Ripetizione \"fuori dalla rete\"';

  @override
  String get settings_clientRepeatSubtitle =>
      'Permetti a questo dispositivo di ripetere i pacchetti di rete per gli altri.';

  @override
  String get settings_clientRepeatFreqWarning =>
      'Per la comunicazione fuori rete, è necessario utilizzare frequenze di 433, 869 o 918 MHz.';

  @override
  String settings_error(String message) {
    return 'Errore: $message';
  }

  @override
  String get appSettings_title => 'Impostazioni App';

  @override
  String get appSettings_appearance => 'Aspetto';

  @override
  String get appSettings_theme => 'Tema';

  @override
  String get appSettings_themeSystem => 'Predefinito del sistema';

  @override
  String get appSettings_themeLight => 'Chiaro';

  @override
  String get appSettings_themeDark => 'Scuro';

  @override
  String get appSettings_language => 'Lingua';

  @override
  String get appSettings_languageSystem => 'Predefinito del sistema';

  @override
  String get appSettings_languageEn => 'Inglese';

  @override
  String get appSettings_languageFr => 'Francese';

  @override
  String get appSettings_languageEs => 'Spagnolo';

  @override
  String get appSettings_languageDe => 'Tedesco';

  @override
  String get appSettings_languagePl => 'Polacco';

  @override
  String get appSettings_languageSl => 'Sloveno';

  @override
  String get appSettings_languagePt => 'Portoghese';

  @override
  String get appSettings_languageIt => 'Italiano';

  @override
  String get appSettings_languageZh => 'Cinese';

  @override
  String get appSettings_languageSv => 'Svedese';

  @override
  String get appSettings_languageNl => 'Olandese';

  @override
  String get appSettings_languageSk => 'Sloveno';

  @override
  String get appSettings_languageBg => 'Bulgaro';

  @override
  String get appSettings_languageRu => 'Russo';

  @override
  String get appSettings_languageUk => 'Ucraino';

  @override
  String get repeater_pathHashModeOption0 => '0 - 1 byte';

  @override
  String get repeater_pathHashModeOption1 => '1 - 2 byte';

  @override
  String get repeater_pathHashModeOption2 => '2 - 3 byte';

  @override
  String get repeater_pathHashModeOption3 => '3 - 4 byte';

  @override
  String get appSettings_enableMessageTracing =>
      'Abilita tracciamento messaggi';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'Mostra metadati dettagliati su instradamento e tempi per i messaggi';

  @override
  String get appSettings_notifications => 'Notifiche';

  @override
  String get appSettings_enableNotifications => 'Abilita Notifiche';

  @override
  String get appSettings_enableNotificationsSubtitle =>
      'Ricevi notifiche per messaggi e annunci';

  @override
  String get appSettings_notificationPermissionDenied =>
      'Permesso di notifica negato';

  @override
  String get appSettings_notificationsEnabled => 'Notifiche abilitate';

  @override
  String get appSettings_notificationsDisabled => 'Notifiche disattivate';

  @override
  String get appSettings_messageNotifications => 'Notifiche Messaggi';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      'Mostra notifica all\'arrivo di nuovi messaggi';

  @override
  String get appSettings_channelMessageNotifications =>
      'Notifiche Messaggi Canale';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'Mostra notifica all\'arrivo di messaggi nel canale';

  @override
  String get appSettings_advertisementNotifications =>
      'Notifiche Pubblicitarie';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      'Mostra notifica quando vengono scoperti nuovi nodi';

  @override
  String get appSettings_messaging => 'Messaggi';

  @override
  String get appSettings_clearPathOnMaxRetry =>
      'Cancella percorso al massimo dei tentativi';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      'Reimposta il percorso di contatto dopo 5 tentativi di invio falliti';

  @override
  String get appSettings_pathsWillBeCleared =>
      'I percorsi verranno cancellati dopo 5 tentativi falliti.';

  @override
  String get appSettings_pathsWillNotBeCleared =>
      'I percorsi non verranno cancellati automaticamente.';

  @override
  String get appSettings_autoRouteRotation => 'Rotazione Percorso Automatico';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      'Alterna tra i percorsi migliori e la modalità flood';

  @override
  String get appSettings_autoRouteRotationEnabled =>
      'Rotazione percorso automatico abilitata';

  @override
  String get appSettings_autoRouteRotationDisabled =>
      'Rotazione del percorso automatico disabilitata';

  @override
  String get appSettings_maxRouteWeight =>
      'Massimo peso consentito per il percorso';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      'Il peso massimo che un percorso può accumulare grazie a consegne di successo.';

  @override
  String get appSettings_initialRouteWeight => 'Peso iniziale del percorso';

  @override
  String get appSettings_initialRouteWeightSubtitle =>
      'Peso di partenza per nuovi percorsi';

  @override
  String get appSettings_routeWeightSuccessIncrement =>
      'Aumento del peso del successo';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      'Peso aggiunto a un percorso dopo una consegna riuscita.';

  @override
  String get appSettings_routeWeightFailureDecrement =>
      'Riduzione del peso associato al fallimento';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      'Peso rimosso da un percorso dopo un tentativo di consegna fallito.';

  @override
  String get appSettings_maxMessageRetries =>
      'Numero massimo di tentativi di invio del messaggio';

  @override
  String get appSettings_maxMessageRetriesSubtitle =>
      'Numero di tentativi di riprova prima di considerare un messaggio come fallito.';

  @override
  String get appSettings_battery => 'Batteria';

  @override
  String get appSettings_batteryChemistry => 'Chimica della batteria';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return 'Impostazione per dispositivo ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      'Connetti a un dispositivo per scegliere';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3,0-4,2V)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2,6-3,65V)';

  @override
  String get appSettings_batteryLipo => 'LiPo (3,0-4,2V)';

  @override
  String get appSettings_batteryLipoHv => 'LiPo HV (3,0-4,35 V)';

  @override
  String get appSettings_mapDisplay => 'Visualizzazione Mappa';

  @override
  String get appSettings_showRepeaters => 'Mostra Ripetitori';

  @override
  String get appSettings_showRepeatersSubtitle =>
      'Mostra i nodi ripetitori sulla mappa';

  @override
  String get appSettings_showChatNodes => 'Mostra Nodi Chat';

  @override
  String get appSettings_showChatNodesSubtitle =>
      'Mostra i nodi di chat sulla mappa';

  @override
  String get appSettings_showOtherNodes => 'Mostra altri nodi';

  @override
  String get appSettings_showOtherNodesSubtitle =>
      'Mostra altri tipi di nodo sulla mappa';

  @override
  String get appSettings_timeFilter => 'Filtro Temporale';

  @override
  String get appSettings_timeFilterShowAll => 'Mostra tutti i nodi';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return 'Mostra i nodi delle ultime $hours ore';
  }

  @override
  String get appSettings_mapTimeFilter => 'Filtro Tempo Mappa';

  @override
  String get appSettings_showNodesDiscoveredWithin =>
      'Mostra i nodi scoperti all\'interno di:';

  @override
  String get appSettings_allTime => 'Tutto il tempo';

  @override
  String get appSettings_lastHour => 'Ultima ora';

  @override
  String get appSettings_last6Hours => 'Ultimi 6 ore';

  @override
  String get appSettings_last24Hours => 'Ultime 24 ore';

  @override
  String get appSettings_lastWeek => 'La settimana scorsa';

  @override
  String get appSettings_rasterTileSource => 'Sorgente tile raster';

  @override
  String get appSettings_stadiaEndpoint => 'Endpoint Stadia';

  @override
  String get appSettings_stadiaApiKey => 'Chiave API Stadia';

  @override
  String get appSettings_stadiaApiKeyRequired =>
      'Obbligatoria per usare Stadia Maps';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return 'Configurata: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Inserisci la chiave API di Stadia Maps. Questa app la usa per le richieste di tile raster.';

  @override
  String get appSettings_offlineMapCache => 'Cache Mappa Offline';

  @override
  String get appSettings_unitsTitle => 'Unità';

  @override
  String get appSettings_unitsMetric => 'Metrico (m / km / °C)';

  @override
  String get appSettings_unitsImperial => 'Imperiale (ft / mi / °F)';

  @override
  String get appSettings_noAreaSelected => 'Nessun\'area selezionata';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'Area selezionata (zoom $minZoom-$maxZoom)';
  }

  @override
  String get appSettings_debugCard => 'Risoluzione dei problemi';

  @override
  String get appSettings_appDebugLogging => 'Registrazione Debug App';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'Registra i messaggi di debug dell\'app per la risoluzione dei problemi';

  @override
  String get appSettings_appDebugLoggingEnabled =>
      'Registrazione di debug dell\'app abilitata';

  @override
  String get appSettings_appDebugLoggingDisabled =>
      'Registrazione di debug dell\'app disabilitata';

  @override
  String get contacts_title => 'Contatti';

  @override
  String get contacts_noContacts => 'Nessun contatto ancora';

  @override
  String get contacts_contactsWillAppear =>
      'I contatti appariranno quando i dispositivi si annunciano.';

  @override
  String get contacts_unread => 'Non letti';

  @override
  String get contacts_searchContactsNoNumber => 'Cerca contatti...';

  @override
  String contacts_searchContacts(int number, String str) {
    return 'Cerca contatti...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'Cerca $number$str preferiti...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'Cerca $number$str utenti...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'Cerca $number$str ripetitori...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'Cerca $number$str server stanza...';
  }

  @override
  String get contacts_noUnreadContacts => 'Nessun contatto non letto';

  @override
  String get contacts_noContactsFound => 'Nessun contatto o gruppo trovato.';

  @override
  String get contacts_deleteContact => 'Elimina Contatto';

  @override
  String contacts_removeConfirm(String contactName) {
    return 'Eliminare $contactName dai contatti?';
  }

  @override
  String get contacts_manageRepeater => 'Gestisci ripetitore';

  @override
  String get contacts_manageRoom => 'Gestisci server stanza';

  @override
  String get contacts_roomLogin => 'Accesso server stanza';

  @override
  String get contacts_openChat => 'Apri chat';

  @override
  String get contacts_editGroup => 'Modifica gruppo';

  @override
  String get contacts_deleteGroup => 'Elimina gruppo';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return 'Eliminare \"$groupName\"?';
  }

  @override
  String get contacts_newGroup => 'Nuovo gruppo';

  @override
  String get contacts_moreOptions => 'Ulteriori opzioni';

  @override
  String get contacts_searchOpen => 'Apri ricerca';

  @override
  String get contacts_searchClose => 'Chiudi ricerca';

  @override
  String get contacts_groupName => 'Nome gruppo';

  @override
  String get contacts_groupNameRequired => 'Il nome del gruppo è obbligatorio.';

  @override
  String get contacts_groupNameReserved => 'Questo nome del gruppo è riservato';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'Il gruppo \"$name\" esiste già.';
  }

  @override
  String get contacts_filterContacts => 'Filtra i contatti...';

  @override
  String get contacts_noContactsMatchFilter =>
      'Nessun contatto corrisponde al tuo filtro';

  @override
  String get contacts_noMembers => 'Nessun membro';

  @override
  String get contacts_lastSeenNow => 'Poco fa';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return 'Ultimo visto $minutes minuti fa';
  }

  @override
  String get contacts_lastSeenHourAgo => 'Ultimo visto 1 ora fa';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return 'Ultimo visto $hours ore fa';
  }

  @override
  String get contacts_lastSeenDayAgo => 'Ultimo visto 1 giorno fa';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return 'Ultimo visto $days giorni fa';
  }

  @override
  String get contact_info => 'Informazioni di Contatto';

  @override
  String get contact_settings => 'Impostazioni di contatto';

  @override
  String get contact_telemetry => 'Telemetria';

  @override
  String get contact_lastSeen => 'Ultimo accesso';

  @override
  String get contact_clearChat => 'Cancella chat';

  @override
  String get contact_teleBase => 'Base di telemetria';

  @override
  String get contact_teleBaseSubtitle =>
      'Consenti la condivisione del livello della batteria e della telemetria di base';

  @override
  String get contact_teleLoc => 'Posizione telemetria';

  @override
  String get contact_teleLocSubtitle =>
      'Consenti la condivisione dei dati di posizione';

  @override
  String get contact_teleEnv => 'Ambiente di telemetria';

  @override
  String get contact_teleEnvSubtitle =>
      'Consenti la condivisione dei dati del sensore ambientale';

  @override
  String get channels_title => 'Canali';

  @override
  String get channels_noChannelsConfigured => 'Nessun canale configurato';

  @override
  String get channels_addPublicChannel => 'Aggiungi Canale Pubblico';

  @override
  String get channels_searchChannels => 'Cerca canali...';

  @override
  String get channels_noChannelsFound => 'Nessun canale trovato';

  @override
  String channels_channelIndex(int index) {
    return 'Canale $index';
  }

  @override
  String get channels_public => 'Pubblico';

  @override
  String channels_via(String path) {
    return 'tramite $path';
  }

  @override
  String get channels_viaMqtt => 'via MQTT';

  @override
  String get channels_viaMqttSemantics =>
      'Ricevuto via MQTT, non sentito dalla tua radio';

  @override
  String get channels_private => 'Privato';

  @override
  String get channels_editChannel => 'Modifica canale';

  @override
  String get channels_muteChannel => 'Silenzia canale';

  @override
  String get channels_unmuteChannel => 'Attiva notifiche canale';

  @override
  String get channels_deleteChannel => 'Elimina canale';

  @override
  String channels_deleteChannelConfirm(String name) {
    return 'Eliminare \"$name\"? Non può essere annullato.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'Impossibile eliminare il canale \"$name\"';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'Canale \"$name\" eliminato';
  }

  @override
  String get channels_addChannel => 'Aggiungi canale';

  @override
  String get channels_channelIndexLabel => 'Indice canale';

  @override
  String get channels_channelName => 'Nome canale';

  @override
  String get channels_usePublicChannel => 'Usa il canale pubblico';

  @override
  String get channels_standardPublicPsk => 'PSK pubblico standard';

  @override
  String get channels_pskHex => 'PSK (esadecimale)';

  @override
  String get channels_generateRandomPsk => 'Genera una PSK casuale';

  @override
  String get channels_enterChannelName => 'Inserisci un nome per il canale';

  @override
  String get channels_pskMustBe32Hex =>
      'PSK deve essere composto da 32 caratteri esadecimali.';

  @override
  String channels_channelAdded(String name) {
    return 'Canale \"$name\" aggiunto';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'Modifica Canale $index';
  }

  @override
  String get channels_smazCompression => 'Compressione SMAZ';

  @override
  String get channels_cyr2latCompression => 'Compressione Cyr2Lat';

  @override
  String get channels_cyr2latCompressionDscr =>
      'Sostituisce alcuni caratteri cirillici con caratteri latini durante l\'invio.';

  @override
  String get channels_cyr2latSettingsHeading => 'Impostazioni Cyr2Lat';

  @override
  String get channels_cyr2latSettingsSubheading => 'Elenco delle sostituzioni';

  @override
  String get channels_cyr2latSettingsDscr =>
      'Modifica la configurazione JSON delle sostituzioni dei caratteri';

  @override
  String get channels_cyr2latSettingsDialogHint =>
      'Mappa JSON delle sostituzioni';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'JSON non corretto: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'Canale \"$name\" aggiornato';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Aggiungi profilo Cyr2Lat';

  @override
  String get settings_cyr2latProfileName => 'Nome profilo';

  @override
  String get settings_cyr2latProfileNameEmpty =>
      'Il nome del profilo non può essere vuoto';

  @override
  String get settings_cyr2latProfileAdded => 'Profilo aggiunto con successo';

  @override
  String get settings_cyr2latProfileUpdated =>
      'Profilo aggiornato con successo';

  @override
  String get settings_cyr2latProfileEdit => 'Modifica profilo Cyr2Lat';

  @override
  String get settings_cyr2latProfileDelete => 'Elimina profilo Cyr2Lat';

  @override
  String get settings_cyr2latProfileDeleted => 'Profilo eliminato con successo';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return 'Sei sicuro di voler eliminare il profilo \"$name\"?';
  }

  @override
  String get channels_publicChannelAdded => 'Canale pubblico aggiunto';

  @override
  String get channels_sortBy => 'Ordina per';

  @override
  String get channels_sortManual => 'Manuale';

  @override
  String get channels_sortAZ => 'A-Z';

  @override
  String get channels_sortLatestMessages => 'Ultimi messaggi';

  @override
  String get channels_sortUnread => 'Non letto';

  @override
  String get channels_createPrivateChannel => 'Crea un Canale Privato';

  @override
  String get channels_createPrivateChannelDesc =>
      'Protetta con una chiave segreta.';

  @override
  String get channels_joinPrivateChannel => 'Unisciti a un Canale Privato';

  @override
  String get channels_joinPrivateChannelDesc =>
      'Inserire manualmente una chiave segreta.';

  @override
  String get channels_joinPublicChannel => 'Unisciti al Canale Pubblico';

  @override
  String get channels_joinPublicChannelDesc =>
      'Chiunque può unirsi a questo canale.';

  @override
  String get channels_joinHashtagChannel => 'Unisciti a un Canale con Hashtag';

  @override
  String get channels_joinHashtagChannelDesc =>
      'Chiunque può unirsi ai canali hashtag.';

  @override
  String get channels_scanQrCode => 'Scansiona un codice QR';

  @override
  String get channels_scanQrCodeComingSoon => 'Arriverà presto';

  @override
  String get channels_enterHashtag => 'Inserisci hashtag';

  @override
  String get channels_hashtagHint => 'es. #team';

  @override
  String channels_regionSetTo(String region) {
    return 'Regione: $region';
  }

  @override
  String get channels_regionNotSet => 'Regione: nessuna';

  @override
  String get channels_regionSelect_Title => 'Scegli una regione';

  @override
  String get channels_clearRegion => 'Zona chiara';

  @override
  String get chat_noMessages => 'Nessun messaggio ancora';

  @override
  String get chat_sendMessage => 'Invia messaggio';

  @override
  String chat_sendMessageTo(String contactName) {
    return 'Invia un messaggio a $contactName';
  }

  @override
  String get chat_sendMessageToStart => 'Invia un messaggio per iniziare';

  @override
  String get chat_originalMessageNotFound => 'Messaggio originale non trovato';

  @override
  String chat_replyingTo(String name) {
    return 'Rispondere a $name';
  }

  @override
  String chat_replyTo(String name) {
    return 'Rispondi a $name';
  }

  @override
  String get chat_location => 'Posizione';

  @override
  String get chat_typeMessage => 'Digita un messaggio...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'Messaggio troppo lungo (massimo $maxBytes byte).';
  }

  @override
  String get chat_messageCopied => 'Messaggio copiato';

  @override
  String get chat_messageDeleted => 'Messaggio eliminato';

  @override
  String get chat_retryingMessage => 'Riprovo';

  @override
  String chat_retryCount(int current, int max) {
    return 'Riprova $current/$max';
  }

  @override
  String get chat_selectSendAction => 'Seleziona azione di invio';

  @override
  String get chat_sendGif => 'Invia GIF';

  @override
  String get chat_limitToArea => 'Limita a un\'area';

  @override
  String get chat_limitToAreaTitle => 'Invia solo entro…';

  @override
  String get chat_limitToAreaHelp =>
      'I ripetitori con firmware a corridoio di flood ritrasmettono il messaggio solo in quest\'area. Gli altri ripetitori lo scartano, a meno che non consentano la tua regione di corridoio.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '$km km da te';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return 'Solo entro $km km da te';
  }

  @override
  String get chat_limitToAreaOff => 'Nessun limite';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'Imposta la posizione della radio per limitare i messaggi a un\'area.';

  @override
  String get chat_sendImageLora => 'Invia immagine tramite MeshCore';

  @override
  String get chat_imagePickFailed =>
      'Non sono riuscito ad aprire quell\'immagine';

  @override
  String get chat_receivedGif => 'Ricevuto un GIF';

  @override
  String get chat_reply => 'Rispondi';

  @override
  String get chat_addReaction => 'Aggiungi Reazione';

  @override
  String get chat_me => 'Io';

  @override
  String get reaction_report => 'Reazioni emoji';

  @override
  String get emojiCategorySmileys => 'Emoji';

  @override
  String get emojiCategoryGestures => 'Gesti';

  @override
  String get emojiCategoryHearts => 'Cuori';

  @override
  String get emojiCategoryObjects => 'Oggetti';

  @override
  String get gifPicker_title => 'Scegli un GIF';

  @override
  String get gifPicker_searchHint => 'Cerca GIF...';

  @override
  String get gifPicker_poweredBy => 'Potenziato da GIPHY';

  @override
  String get gifPicker_noGifsFound => 'Nessun GIF trovato';

  @override
  String get gifPicker_failedLoad => 'Impossibile caricare i GIF';

  @override
  String get gifPicker_failedSearch => 'Impossibile trovare GIF';

  @override
  String get gifPicker_noInternet => 'Nessuna connessione internet';

  @override
  String get debugLog_appTitle => 'Log di Debug dell\'App';

  @override
  String get debugLog_bleTitle => 'Log di Debug BLE';

  @override
  String get debugLog_copyLog => 'Copia log';

  @override
  String get debugLog_clearLog => 'Cancella log';

  @override
  String get debugLog_copied => 'Log di debug copiato';

  @override
  String get debugLog_bleCopied => 'Log BLE copiato';

  @override
  String get debugLog_noEntries => 'Non ci sono ancora log di debug.';

  @override
  String get debugLog_enableInSettings =>
      'Abilita il logging di debug dell\'app nelle impostazioni';

  @override
  String get debugLog_frames => 'Frame';

  @override
  String get debugLog_rawLogRx => 'Log Raw-RX';

  @override
  String get debugLog_noBleActivity => 'Nessuna attività BLE rilevata ancora.';

  @override
  String debugFrame_length(int count) {
    return 'Lunghezza del Frame: $count byte';
  }

  @override
  String debugFrame_command(String value) {
    return 'Comando: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'Messaggio di testo:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- Chiave pubblica di destinazione: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- Marca temporale: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- Flag: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return 'Tipo di testo: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'CLI';

  @override
  String get debugFrame_textTypePlain => 'Semplice';

  @override
  String debugFrame_text(String text) {
    return '- Testo: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => 'Dumpa Esadecimale:';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'salti',
      one: 'salto',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => 'Rimuovi percorso';

  @override
  String get chat_noPathHistoryYet =>
      'Non c\'è ancora una cronologia del percorso.\nInvia un messaggio per scoprire i percorsi.';

  @override
  String get chat_pathCleared =>
      'Percorso cancellato. Il prossimo messaggio riscoprirà il percorso.';

  @override
  String get chat_fullPath => 'Percorso Completo';

  @override
  String get routing_title => 'Instradamento';

  @override
  String get routing_modeAuto => 'Automatico';

  @override
  String get routing_modeFlood => 'Flood';

  @override
  String get routing_modeManual => 'Manuale';

  @override
  String get routing_modeAutoHint =>
      'Seleziona automaticamente il percorso migliore noto, ricorrendo al flood quando non ne è noto nessuno.';

  @override
  String get routing_modeFloodHint =>
      'Trasmette tramite ogni ripetitore. È il più affidabile, ma usa più airtime.';

  @override
  String get routing_modeManualHint =>
      'Invia sempre lungo il percorso esatto che hai definito.';

  @override
  String get routing_currentRoute => 'Percorso attuale';

  @override
  String get routing_directNoHops =>
      'Diretto — nessun salto tramite ripetitore';

  @override
  String get routing_noPathYet =>
      'Nessun percorso ancora. Il prossimo messaggio userà il flood finché non viene scoperto un percorso.';

  @override
  String get routing_floodBroadcast => 'Trasmissione tramite ogni ripetitore';

  @override
  String get routing_editPath => 'Modifica percorso';

  @override
  String get routing_forgetPath => 'Dimentica percorso';

  @override
  String get routing_knownPaths => 'Percorsi noti';

  @override
  String get routing_knownPathsHint =>
      'Tocca un percorso per passare a quello.';

  @override
  String get routing_inUse => 'In uso';

  @override
  String get routing_qualityStrong => 'Primo hop forte';

  @override
  String get routing_qualityGood => 'Primo hop buono';

  @override
  String get routing_qualityFair => 'Primo hop discreto';

  @override
  String get routing_qualityWorked => 'Ha consegnato';

  @override
  String get routing_qualityFlood => 'Ricevuto via flood';

  @override
  String get routing_qualityUntested => 'Non testato';

  @override
  String routing_lastWorked(String when) {
    return 'ha funzionato $when';
  }

  @override
  String get routing_neverWorked => 'mai confermato';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes consegnati, $failures falliti';
  }

  @override
  String get routing_floodDelivery => 'Consegna flood';

  @override
  String get pathEditor_title => 'Crea percorso';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count su 64 salti';
  }

  @override
  String get pathEditor_noHops =>
      'Nessun salto ancora. Tocca i ripetitori qui sotto per aggiungerli in ordine, oppure salva senza salti per inviare direttamente.';

  @override
  String get pathEditor_addHops => 'Aggiungi salti in ordine';

  @override
  String get pathEditor_searchRepeaters => 'Cerca ripetitori';

  @override
  String get pathEditor_advancedHex => 'Avanzato: percorso esadecimale grezzo';

  @override
  String get pathEditor_hexLabel => 'Prefissi esadecimali';

  @override
  String get pathEditor_hexHelper =>
      'Due caratteri esadecimali per ogni salto, separati da virgole.';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return 'Non valido: $tokens';
  }

  @override
  String get pathEditor_tooManyHops => 'Massimo 64 salti';

  @override
  String get pathEditor_usePath => 'Utilizza questo percorso';

  @override
  String get pathEditor_removeHop => 'Rimuovi salto';

  @override
  String get pathEditor_unknownHop => 'Ripetitore sconosciuto';

  @override
  String get chat_pathSavedLocally =>
      'Salvato localmente. Connettiti per sincronizzare.';

  @override
  String get chat_pathDeviceConfirmed => 'Dispositivo confermato.';

  @override
  String get chat_pathDeviceNotConfirmed =>
      'Dispositivo non confermato ancora.';

  @override
  String get chat_type => 'Tipo';

  @override
  String get chat_path => 'Percorso';

  @override
  String get chat_publicKey => 'Chiave pubblica';

  @override
  String get chat_compressOutgoingMessages => 'Comprimi messaggi in uscita';

  @override
  String get chat_floodForced => 'Flood (forzato)';

  @override
  String get chat_directForced => 'Diretto (forzato)';

  @override
  String chat_hopsForced(int count) {
    return '$count salti (forzati)';
  }

  @override
  String get chat_floodAuto => 'Flood (automatico)';

  @override
  String get chat_direct => 'Diretto';

  @override
  String get chat_poiShared => 'POI condiviso';

  @override
  String chat_unread(int count) {
    return 'Non letti: $count';
  }

  @override
  String get chat_markAsUnread => 'Segna come non letto';

  @override
  String get chat_newMessages => 'Nuovi messaggi';

  @override
  String get chat_openLink => 'Apri il link?';

  @override
  String get chat_openLinkConfirmation =>
      'Vuoi aprire questo link nel tuo browser?';

  @override
  String get chat_open => 'Apri';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'Impossibile aprire il link: $url';
  }

  @override
  String get chat_invalidLink => 'Formato di link non valido';

  @override
  String get map_title => 'Mappa nodi';

  @override
  String get map_searchHint => 'Cerca il nome o l\'ID del nodo';

  @override
  String get map_activity => 'Attività';

  @override
  String get map_online => 'Online';

  @override
  String get map_recent => 'Recente';

  @override
  String get map_stale => 'Obsoleto';

  @override
  String get map_visible => 'Visibile';

  @override
  String get map_hidden => 'Nascosto';

  @override
  String get map_centerOnNode => 'Centra sul nodo';

  @override
  String get map_details => 'Dettagli';

  @override
  String get map_noGps => 'Senza GPS';

  @override
  String get map_noResults => 'Nessun nodo corrispondente trovato.';

  @override
  String get map_lineOfSight => 'Linea di vista';

  @override
  String get map_losScreenTitle => 'Linea di vista';

  @override
  String get map_noNodesWithLocation => 'Nessun nodo con dati di posizione';

  @override
  String get map_nodesNeedGps =>
      'I nodi devono condividere le loro coordinate GPS\nper apparire sulla mappa';

  @override
  String map_nodesCount(int count) {
    return 'Nodi: $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'Pin: $count';
  }

  @override
  String get map_chat => 'Chat';

  @override
  String get map_repeater => 'Ripetitore';

  @override
  String get map_room => 'Stanza';

  @override
  String get map_sensor => 'Sensore';

  @override
  String get map_pinDm => 'Pin (DM)';

  @override
  String get map_pinPrivate => 'Pin (Privato)';

  @override
  String get map_pinPublic => 'Pin (Pubblico)';

  @override
  String get map_lastSeen => 'Ultimo visto';

  @override
  String get map_disconnectConfirm =>
      'Sei sicuro di voler disconnetterti da questo dispositivo?';

  @override
  String get map_from => 'Da';

  @override
  String get map_source => 'Fonte';

  @override
  String get map_flags => 'Bandiere';

  @override
  String get map_type => 'Tipo';

  @override
  String get map_path => 'Percorso';

  @override
  String get map_location => 'Posizione';

  @override
  String get map_estLocation => 'Posizione stimata';

  @override
  String get map_publicKey => 'Chiave pubblica';

  @override
  String get map_publicKeyPrefixHint => 'es. ab12';

  @override
  String get map_shareMarkerHere => 'Condividi segnaposto qui';

  @override
  String get map_setAsMyLocation => 'Imposta come la mia posizione';

  @override
  String get floodCorridor_title => 'Corridoio di flood';

  @override
  String get floodCorridor_previewToHere =>
      'Anteprima del corridoio di flood fino a qui';

  @override
  String get floodCorridor_requesting =>
      'Richiesta di un corridoio alla tua radio…';

  @override
  String get floodCorridor_unsupported =>
      'Il firmware della tua radio non supporta i corridoi di flood.';

  @override
  String get floodCorridor_noProposal =>
      'La tua radio non è riuscita a proporre un corridoio. Assicurati che abbia una posizione impostata.';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cerchi',
      one: '1 cerchio',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return '$inside di $total ripetitori noti all\'interno';
  }

  @override
  String get floodCorridor_straightLine =>
      'Linea retta: nessun ripetitore noto lungo il percorso';

  @override
  String get floodCorridor_followsRepeaters => 'Segue i tuoi ripetitori noti';

  @override
  String get floodCorridor_horizonLimited =>
      'I ripetitori noti non raggiungono la destinazione; il resto è una linea retta';

  @override
  String get floodCorridor_thinStretch =>
      'Una parte del corridoio ha pochi ripetitori noti';

  @override
  String get floodCorridor_moreCoverage =>
      'Richiedi più copertura di ripetitori';

  @override
  String get floodCorridor_previewNote =>
      'Solo anteprima. I ripetitori senza firmware a corridoio non applicano i corridoi.';

  @override
  String get map_pinLabel => 'Etichetta pin';

  @override
  String get map_label => 'Etichetta';

  @override
  String get map_pointOfInterest => 'Punto di interesse';

  @override
  String get map_sendToContact => 'Invia a contatto';

  @override
  String get map_sendToChannel => 'Invia al canale';

  @override
  String get map_noChannelsAvailable => 'Nessun canale disponibile';

  @override
  String get map_publicLocationShare => 'Condivisione pubblica della posizione';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return 'Stai per condividere una posizione in $channelLabel. Questo canale è pubblico e chiunque abbia la PSK può vederlo.';
  }

  @override
  String get map_connectToShareMarkers =>
      'Connettiti a un dispositivo per condividere i segnaposti';

  @override
  String get map_filterNodes => 'Filtra nodi';

  @override
  String get map_nodeTypes => 'Tipi di nodo';

  @override
  String get map_chatNodes => 'Nodi chat';

  @override
  String get map_repeaters => 'Ripetitori';

  @override
  String get map_otherNodes => 'Altri nodi';

  @override
  String get map_showOverlaps => 'Sovrapposizioni chiave ripetitore';

  @override
  String get map_keyPrefix => 'Prefisso chiave';

  @override
  String get map_filterByKeyPrefix => 'Filtra per prefisso chiave';

  @override
  String get map_publicKeyPrefix => 'Prefisso chiave pubblica';

  @override
  String get map_markers => 'Segnaposti';

  @override
  String get map_showSharedMarkers => 'Mostra segnaposti condivisi';

  @override
  String get map_showGuessedLocations => 'Mostra le posizioni stimate dei nodi';

  @override
  String get map_showDiscoveryContacts => 'Mostra contatti di scoperta';

  @override
  String get map_guessedLocation => 'Posizione stimata';

  @override
  String get map_lastSeenTime => 'Ora dell\'ultimo visto';

  @override
  String get map_sharedPin => 'Pin condiviso';

  @override
  String get map_sharedAt => 'Condiviso';

  @override
  String get map_joinRoom => 'Unisciti alla stanza';

  @override
  String get map_manageRepeater => 'Gestisci ripetitore';

  @override
  String get map_tapToAdd => 'Tocca i nodi per aggiungerli al percorso.';

  @override
  String get map_runTrace => 'Esegui tracciamento percorso';

  @override
  String get map_runTraceWithReturnPath => 'Ritorna lungo lo stesso percorso.';

  @override
  String get map_removeLast => 'Rimuovi ultimo';

  @override
  String get map_pathTraceCancelled => 'Tracciamento del percorso annullato.';

  @override
  String get mapCache_title => 'Cache mappa offline';

  @override
  String get mapCache_selectAreaFirst =>
      'Seleziona un\'area da memorizzare nella cache per prima.';

  @override
  String get mapCache_noTilesToDownload =>
      'Nessun tile da scaricare per questa area';

  @override
  String get mapCache_downloadTilesTitle => 'Scarica tessere';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return 'Scarica $count tile per l\'uso offline?';
  }

  @override
  String get mapCache_downloadAction => 'Scarica';

  @override
  String mapCache_cachedTiles(int count) {
    return 'Tessere memorizzate nella cache: $count';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return 'Tessere memorizzate nella cache $downloaded ($failed fallite)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => 'Cancella cache offline';

  @override
  String get mapCache_clearOfflineCachePrompt =>
      'Eliminare tutte le tile di mappa memorizzate nella cache?';

  @override
  String get mapCache_offlineCacheCleared => 'Cache offline eliminata';

  @override
  String get mapCache_noAreaSelected => 'Nessun\'area selezionata';

  @override
  String get mapCache_cacheArea => 'Area cache';

  @override
  String get mapCache_useCurrentView => 'Utilizza la visualizzazione corrente';

  @override
  String get mapCache_zoomRange => 'Intervallo zoom';

  @override
  String mapCache_estimatedTiles(int count) {
    return 'Tessere stimate: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return 'Scaricati $completed / $total';
  }

  @override
  String get mapCache_downloadTilesButton => 'Scarica tessere';

  @override
  String get mapCache_clearCacheButton => 'Svuota cache';

  @override
  String mapCache_failedDownloads(int count) {
    return 'Download falliti: $count';
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
  String get time_justNow => 'Proprio ora';

  @override
  String time_minutesAgo(int minutes) {
    return '$minutes minuti fa';
  }

  @override
  String time_hoursAgo(int hours) {
    return '${hours}h fa';
  }

  @override
  String time_daysAgo(int days) {
    return '$days giorni fa';
  }

  @override
  String get time_hour => 'ora';

  @override
  String get time_hours => 'ore';

  @override
  String get time_day => 'giorno';

  @override
  String get time_days => 'giorni';

  @override
  String get time_week => 'settimana';

  @override
  String get time_weeks => 'settimane';

  @override
  String get time_month => 'mese';

  @override
  String get time_months => 'mesi';

  @override
  String get time_minutes => 'minuti';

  @override
  String get time_allTime => 'Sempre';

  @override
  String get dialog_disconnect => 'Disconnetti';

  @override
  String get dialog_disconnectConfirm =>
      'Sei sicuro di voler disconnetterti da questo dispositivo?';

  @override
  String get login_repeaterLogin => 'Accesso ripetitore';

  @override
  String get login_roomLogin => 'Accesso server stanza';

  @override
  String get login_password => 'Password';

  @override
  String get login_enterPassword => 'Inserisci password';

  @override
  String get login_savePassword => 'Salva password';

  @override
  String get login_savePasswordSubtitle =>
      'La password verrà memorizzata in modo sicuro su questo dispositivo.';

  @override
  String get login_repeaterDescription =>
      'Inserisci la password del ripetitore per accedere alle impostazioni e allo stato.';

  @override
  String get login_roomDescription =>
      'Inserisci la password della stanza per accedere alle impostazioni e allo stato.';

  @override
  String get login_routing => 'Instradamento';

  @override
  String get login_routingMode => 'Modalità di routing';

  @override
  String get login_autoUseSavedPath => 'Utilizza il percorso salvato';

  @override
  String get login_forceFloodMode => 'Modalità flood forzata';

  @override
  String get login_managePaths => 'Gestisci percorsi';

  @override
  String get login_login => 'Accedi';

  @override
  String login_attempt(int current, int max) {
    return 'Prova $current/$max';
  }

  @override
  String login_failed(String error) {
    return 'Accesso fallito: $error';
  }

  @override
  String get login_failedMessage =>
      'Accesso fallito. La password non è corretta oppure il ripetitore non è raggiungibile.';

  @override
  String get common_reload => 'Ricarica';

  @override
  String get common_clear => 'Cancella';

  @override
  String get path_currentPathLabel => 'Percorso corrente';

  @override
  String get path_noRepeatersFound =>
      'Non sono stati trovati ripetitori o server stanza.';

  @override
  String get repeater_management => 'Gestione ripetitori';

  @override
  String get room_management => 'Gestione del Server di Camera';

  @override
  String get repeater_guest => 'Informazioni sul ripetitore';

  @override
  String get room_guest => 'Informazioni sul server';

  @override
  String get repeater_managementTools => 'Strumenti di gestione';

  @override
  String get repeater_guestTools => 'Strumenti per gli ospiti';

  @override
  String get repeater_status => 'Stato';

  @override
  String get repeater_statusSubtitle =>
      'Visualizza lo stato, le statistiche e i vicini del ripetitore';

  @override
  String get repeater_telemetry => 'Telemetria';

  @override
  String get repeater_telemetrySubtitle =>
      'Visualizza i dati di telemetria dei sensori e le statistiche di sistema';

  @override
  String get repeater_cli => 'CLI';

  @override
  String get repeater_cliSubtitle => 'Invia comandi al ripetitore';

  @override
  String get repeater_neighbors => 'Vicini';

  @override
  String get repeater_neighborsSubtitle => 'Visualizza vicini a salto zero.';

  @override
  String get repeater_settings => 'Impostazioni';

  @override
  String get repeater_settingsSubtitle =>
      'Configura i parametri del ripetitore';

  @override
  String get repeater_clockSyncAfterLogin =>
      'Sincronizzazione dell\'orologio dopo il login';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      'Invia automaticamente il comando \"sincronizzazione dell\'orologio\" dopo un login riuscito.';

  @override
  String get repeater_statusTitle => 'Stato del ripetitore';

  @override
  String get repeater_routingMode => 'Modalità di routing';

  @override
  String get repeater_refresh => 'Aggiorna';

  @override
  String get repeater_statusRequestTimeout => 'Richiesta stato scaduta.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'Errore nel caricamento dello stato: $error';
  }

  @override
  String get repeater_systemInformation => 'Informazioni di sistema';

  @override
  String get repeater_battery => 'Batteria';

  @override
  String get repeater_clockAtLogin => 'Orologio (all\'accesso)';

  @override
  String get repeater_uptime => 'Tempo di attività';

  @override
  String get repeater_queueLength => 'Lunghezza coda';

  @override
  String get repeater_debugFlags => 'Flag di debug';

  @override
  String get repeater_radioStatistics => 'Statistiche radio';

  @override
  String get repeater_lastRssi => 'Ultimo RSSI';

  @override
  String get repeater_lastSnr => 'Ultimo SNR';

  @override
  String get repeater_noiseFloor => 'Rumore di fondo';

  @override
  String get repeater_txAirtime => 'Tempo d\'aria TX';

  @override
  String get repeater_rxAirtime => 'Tempo d\'aria RX';

  @override
  String get repeater_chanUtil => 'Utilizzo del canale';

  @override
  String get repeater_packetStatistics => 'Statistiche pacchetti';

  @override
  String get repeater_sent => 'Inviato';

  @override
  String get repeater_received => 'Ricevuto';

  @override
  String get repeater_duplicates => 'Duplicati';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days giorni ${hours}h ${minutes}m ${seconds}s';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return 'Totale: $total, Flood: $flood, Diretto: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return 'Totale: $total, Flood: $flood, Diretto: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return 'Flood: $flood, Diretto: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return 'Totale: $total';
  }

  @override
  String get repeater_settingsTitle => 'Impostazioni Ripetitore';

  @override
  String get repeater_basicSettings => 'Impostazioni di Base';

  @override
  String get repeater_repeaterName => 'Nome Ripetitore';

  @override
  String get repeater_repeaterNameHelper =>
      'Nome visualizzato per questo ripetitore';

  @override
  String get repeater_adminPassword => 'Password amministratore';

  @override
  String get repeater_adminPasswordHelper => 'Password per accesso completo';

  @override
  String get repeater_guestPassword => 'Password ospite';

  @override
  String get repeater_guestPasswordHelper =>
      'Password per accesso in sola lettura';

  @override
  String get repeater_radioSettings => 'Impostazioni Radio';

  @override
  String get repeater_frequencyMhz => 'Frequenza (MHz)';

  @override
  String get repeater_frequencyHelper => '300-2500 MHz';

  @override
  String get repeater_txPower => 'Potenza TX';

  @override
  String get repeater_txPowerHelper => '1-30 dBm';

  @override
  String get repeater_bandwidth => 'Larghezza di banda';

  @override
  String get repeater_spreadingFactor => 'Fattore di diffusione';

  @override
  String get repeater_codingRate => 'Tasso di Codifica';

  @override
  String get repeater_locationSettings => 'Impostazioni posizione';

  @override
  String get repeater_latitude => 'Latitudine';

  @override
  String get repeater_latitudeHelper => 'Grado decimale (ad esempio, 37.7749)';

  @override
  String get repeater_longitude => 'Longitudine';

  @override
  String get repeater_longitudeHelper =>
      'Grado decimale (ad esempio, -122,4194)';

  @override
  String get repeater_features => 'Caratteristiche';

  @override
  String get repeater_packetForwarding => 'Inoltro pacchetti';

  @override
  String get repeater_packetForwardingSubtitle =>
      'Abilita il ripetitore per inoltrare i pacchetti';

  @override
  String get repeater_guestAccess => 'Accesso ospite';

  @override
  String get repeater_guestAccessSubtitle =>
      'Consenti l\'accesso ospite in sola lettura';

  @override
  String get repeater_privacyMode => 'Modalità Privacy';

  @override
  String get repeater_privacyModeSubtitle =>
      'Nascondi nome/posizione negli annunci';

  @override
  String get repeater_advertisementSettings => 'Impostazioni annuncio';

  @override
  String get repeater_localAdvertInterval => 'Intervallo annuncio locale';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes minuti';
  }

  @override
  String get repeater_floodAdvertInterval => 'Intervallo annuncio flood';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours ore';
  }

  @override
  String get repeater_encryptedAdvertInterval =>
      'Intervallo annuncio crittografato';

  @override
  String get repeater_dangerZone => 'Zona Pericolosa';

  @override
  String get repeater_rebootRepeater => 'Riavvia Ripetitore';

  @override
  String get repeater_rebootRepeaterSubtitle =>
      'Riavvia il dispositivo ripetitore';

  @override
  String get repeater_rebootRepeaterConfirm =>
      'Sei sicuro di voler riavviare questo ripetitore?';

  @override
  String get repeater_regenerateIdentityKey => 'Rigenera Chiave Identità';

  @override
  String get repeater_regenerateIdentityKeySubtitle =>
      'Genera una nuova coppia di chiavi pubblica/privata';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'Questo genererà una nuova identità per il ripetitore. Procedere?';

  @override
  String get repeater_eraseFileSystem => 'Elimina File System';

  @override
  String get repeater_eraseFileSystemSubtitle =>
      'Formatta il file system del ripetitore';

  @override
  String get repeater_eraseFileSystemConfirm =>
      'ATTENZIONE: Ciò cancellerà tutti i dati sul ripetitore. Non può essere annullato!';

  @override
  String get repeater_eraseSerialOnly =>
      'Elimina è disponibile solo tramite console seriale.';

  @override
  String repeater_commandSent(String command) {
    return 'Comando inviato: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'Errore nell\'invio del comando: $error';
  }

  @override
  String get repeater_confirm => 'Conferma';

  @override
  String get repeater_settingsSaved => 'Impostazioni salvate con successo';

  @override
  String get repeater_rxGain => 'Aumento del guadagno RX';

  @override
  String get repeater_rxGainHelper =>
      'Maggiore sensibilità, maggiore assorbimento di corrente (solo per SX1262/SX1268)';

  @override
  String get repeater_refreshRxGain => 'Rafforza l\'effetto di RX';

  @override
  String get repeater_multiAcks => 'ACK multipli';

  @override
  String get repeater_multiAcksSubtitle =>
      'Riconoscere i messaggi attraverso percorsi multipli per una migliore consegna.';

  @override
  String get repeater_refreshMultiAcks => 'Riaffermare più ACK';

  @override
  String get repeater_networkHealth => 'Salute della rete';

  @override
  String get repeater_loopDetect => 'Rilevamento di cicli';

  @override
  String get repeater_loopDetectHelper =>
      'Crea pacchetti di dati che simulano loop di routing.';

  @override
  String get repeater_loopDetectOff => 'Offerte';

  @override
  String get repeater_loopDetectMinimal => 'Essenziale';

  @override
  String get repeater_loopDetectModerate => 'Moderato';

  @override
  String get repeater_loopDetectStrict => 'Rigido';

  @override
  String get repeater_dutyCycle => 'Ciclo di lavoro';

  @override
  String get repeater_dutyCycleHelper =>
      'Percentuale massima di utilizzo dello spazio pubblicitario';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => 'Informazioni sull\'operatore';

  @override
  String get repeater_ownerInfoHelper =>
      'Metadati pubblici per questo ripetitore';

  @override
  String get repeater_refreshOwnerInfo =>
      'Aggiorna le informazioni sull\'operatore';

  @override
  String get repeater_floodMax =>
      'Massimo numero di salti in caso di inondazione';

  @override
  String get repeater_floodMaxHelper =>
      'Numero massimo di pacchetti che un flusso può attraversare (0-64)';

  @override
  String get repeater_advancedSettings => 'Avanzato';

  @override
  String get repeater_advancedSettingsSubtitle =>
      'Manopole di regolazione per operatori esperti';

  @override
  String get repeater_pathHashMode => 'Modalità di hashing del percorso';

  @override
  String get repeater_pathHashModeHelper =>
      'Byte utilizzati per codificare l\'ID di questo ripetitore nei tag di percorso flood/rilevamento loop. 0=1 byte (256 ID, fino a 64 salti), 1=2 byte (65.000 ID, fino a 32 salti), 2=3 byte (16 milioni di ID, fino a 21 salti). Il firmware precedente alla v1.14 usava sempre percorsi a 1 byte; v1.14 e versioni successive possono essere configurate per percorsi a 2 o 3 byte.';

  @override
  String get repeater_keySettings => 'Cambia le Chiavi di Identità';

  @override
  String get repeater_keySettingsSubtitle =>
      'Cambia la coppia di chiavi pubblica/privata';

  @override
  String get repeater_prvKey => 'Chiave privata';

  @override
  String get repeater_prvKeyHelper =>
      'Una nuova chiave privata per il ripetitore, una stringa esadecimale di 128 caratteri.';

  @override
  String get repeater_generatePrvKey => 'Genera una coppia di chiavi casuale';

  @override
  String get repeater_stopGeneratingPrvKey =>
      'Interrompi la ricerca della coppia di chiavi';

  @override
  String get repeater_pubKey => 'Chiave pubblica';

  @override
  String get repeater_pubKeyHelper =>
      'Questa è la chiave pubblica che accompagna la chiave privata generata. Non è possibile impostarla direttamente.';

  @override
  String get repeater_pubKeyPrefix => 'Prefisso desiderato';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'Trova una chiave pubblica che inizia con queste cifre esadecimali. Tentativi necessari previsti: $tries.';
  }

  @override
  String get repeater_txDelay => 'Ritardo a Flood, TX';

  @override
  String get repeater_txDelayHelper =>
      'Riassegnare lo spazio tra i pacchetti per gestire il traffico intenso, come un moltiplicatore del tempo di trasmissione (da 0 a 2, valore predefinito 0,5). Un valore più alto significa meno collisioni, ma una trasmissione più lenta.';

  @override
  String get repeater_directTxDelay => 'Ritardo diretto TX';

  @override
  String get repeater_directTxDelayHelper =>
      'Riassegnare lo spazio per il traffico diretto (non di massa), come un moltiplicatore del tempo di trasmissione del pacchetto (da 0 a 2, valore predefinito 0,3).';

  @override
  String get repeater_intThresh => 'Soglia di interferenza';

  @override
  String get repeater_intThreshHelper =>
      'Il limite è stato impostato per la calibrazione del livello di rumore del ricevitore, in modo che esso rifiuti i segnali di interferenza superiori a questo livello. 0 disabilita – aumentalo solo se si verificano errori nel ricevitore in una banda di frequenza rumorosa.';

  @override
  String get repeater_agcResetInterval => 'Intervallo di ripristino di AGC';

  @override
  String get repeater_agcResetIntervalHelper =>
      'Con quale frequenza è necessario resettare il controllo automatico del guadagno per ripristinare il funzionamento dopo un\'interruzione. Impostare su secondi, ridotti a multipli di 4. Disattivare la reimpostazione periodica.';

  @override
  String get repeater_actionsTitle => 'Azioni';

  @override
  String get repeater_sendAdvert =>
      'Inviare annuncio relativo alle inondazioni';

  @override
  String get repeater_sendAdvertSubtitle =>
      'Trasmettere un annuncio pubblicitario relativo alle inondazioni attraverso la rete.';

  @override
  String get repeater_sendAdvertZeroHop =>
      'Inviare un annuncio senza intermediari';

  @override
  String get repeater_sendAdvertZeroHopSubtitle =>
      'Trasmettere un annuncio a un solo hop (senza ripetitori)';

  @override
  String get repeater_clockSync => 'Sincronizza l\'orologio ora';

  @override
  String get repeater_clockSyncSubtitle =>
      'Imposta l\'ora del tuo telefono sul ripetitore.';

  @override
  String repeater_actionSucceeded(String action) {
    return '$action ha avuto successo';
  }

  @override
  String repeater_actionFailed(String action, String error) {
    return '$action failed: $error';
  }

  @override
  String get repeater_settingsSavedRebootNeeded =>
      'Impostazioni salvate — riavviare il ripetitore per applicare le modifiche';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return 'Alcune impostazioni non sono state salvate: $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return 'Errore durante il salvataggio delle impostazioni: $error';
  }

  @override
  String get repeater_refreshBasicSettings => 'Aggiorna Impostazioni Base';

  @override
  String get repeater_refreshRadioSettings => 'Aggiorna le Impostazioni Radio';

  @override
  String get repeater_refreshTxPower => 'Aggiorna TX potenza';

  @override
  String get repeater_refreshPacketForwarding =>
      'Aggiorna il inoltro pacchetti';

  @override
  String get repeater_refreshGuestAccess => 'Aggiorna Accesso Ospite';

  @override
  String get repeater_refreshPrivacyMode => 'Aggiorna Modalità Privacy';

  @override
  String repeater_refreshed(String label) {
    return '$label aggiornato';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return 'Errore durante il ricaricamento di $label';
  }

  @override
  String get repeater_cliTitle => 'CLI del ripetitore';

  @override
  String get repeater_debugNextCommand => 'Riavvia Comando Prossimo';

  @override
  String get repeater_commandHelp => 'Aiuto';

  @override
  String get repeater_clearHistory => 'Cancella Cronologia';

  @override
  String get repeater_noCommandsSent => 'Nessun comando inviato ancora';

  @override
  String get repeater_typeCommandOrUseQuick =>
      'Digita un comando qui sotto o usa comandi rapidi';

  @override
  String get repeater_enterCommandHint => 'Inserisci comando...';

  @override
  String get repeater_previousCommand => 'Comando precedente';

  @override
  String get repeater_nextCommand => 'Prossimo comando';

  @override
  String get repeater_enterCommandFirst => 'Inserisci un comando prima';

  @override
  String get repeater_cliCommandFrameTitle => 'Finestra Comando CLI';

  @override
  String repeater_cliCommandError(String error) {
    return 'Errore: $error';
  }

  @override
  String get repeater_cliQuickGetName => 'Ottieni Nome';

  @override
  String get repeater_cliQuickGetRadio => 'Ottieni Radio';

  @override
  String get repeater_cliQuickGetTx => 'Ottieni TX';

  @override
  String get repeater_cliQuickNeighbors => 'Vicini';

  @override
  String get repeater_cliQuickVersion => 'Versione';

  @override
  String get repeater_cliQuickAdvertise => 'Annuncia';

  @override
  String get repeater_cliQuickClock => 'Orologio';

  @override
  String get repeater_cliQuickClockSync => 'Sincronizza orologio';

  @override
  String get repeater_cliQuickDiscovery => 'Scopri vicini';

  @override
  String get repeater_cliHelpAdvert => 'Invia un pacchetto pubblicitario';

  @override
  String get repeater_cliHelpReboot =>
      'Riavvia il dispositivo. (nota, potresti ottenere \'Timeout\' che è normale)';

  @override
  String get repeater_cliHelpClock =>
      'Mostra l\'ora corrente per l\'orologio di ciascun dispositivo.';

  @override
  String get repeater_cliHelpPassword =>
      'Imposta una nuova password di amministratore per il dispositivo.';

  @override
  String get repeater_cliHelpVersion =>
      'Mostra la versione del dispositivo e la data di costruzione del firmware.';

  @override
  String get repeater_cliHelpClearStats =>
      'Resetta vari numerosi contatori di statistiche a zero.';

  @override
  String get repeater_cliHelpSetAf =>
      'Imposta il fattore di tempo di trasmissione.';

  @override
  String get repeater_cliHelpSetTx =>
      'Imposta la potenza di trasmissione LoRa in dBm (riavvia per applicare).';

  @override
  String get repeater_cliHelpSetRepeat =>
      'Abilita o disabilita il ruolo del ripetitore per questo nodo.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(Server stanza) Se \'on\', allora l\'accesso con una password vuota sarà consentito, ma non sarà possibile pubblicare nella stanza. (solo lettura).';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'Imposta il numero massimo di salti per i pacchetti di inondazione in entrata (se >= max, il pacchetto non viene inoltrato)';

  @override
  String get repeater_cliHelpSetIntThresh =>
      'Imposta il Limite di Interferenza (in dB). Il valore predefinito è 14. Imposta su 0 per disabilitare il rilevamento delle interferenze del canale.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'Imposta l\'intervallo per resettare il controllore Automatico del Guadagno. Imposta su 0 per disabilitare.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      'Abilita o disabilita la funzione \'double ACKs\'.';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'Imposta l\'intervallo del timer in minuti per inviare un pacchetto di pubblicità locale (senza salto). Imposta su 0 per disabilitare.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'Imposta l\'intervallo del timer in ore per inviare un pacchetto pubblicitario di massa. Imposta su 0 per disabilitare.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'Imposta/aggiorna la password dell\'ospite. (per ripetitori, gli accessi degli ospiti possono inviare la richiesta \"Get Stats\")';

  @override
  String get repeater_cliHelpSetName => 'Imposta il nome dell\'annuncio.';

  @override
  String get repeater_cliHelpSetLat =>
      'Imposta la latitudine della mappa pubblicitaria. (gradi decimali)';

  @override
  String get repeater_cliHelpSetLon =>
      'Imposta la longitudine della mappa pubblicitaria. (gradi decimali)';

  @override
  String get repeater_cliHelpSetRadio =>
      'Imposta completamente nuovi parametri radio e li salva nelle preferenze. Richiede un comando \"reboot\" per l\'applicazione.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      'Impostazioni (experimental) base (deve essere > 1 per l\'effetto) per applicare un leggero ritardo ai pacchetti ricevuti, in base alla forza del segnale/punteggio. Imposta a 0 per disabilitare.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      'Imposta un fattore moltiplicativo sul tempo di trasmissione dei pacchetti in modalità flood e su un sistema a slot casuali, per ritardarne l\'inoltro (riducendo la probabilità di collisioni).';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'Uguale a txdelay, ma per applicare un ritardo casuale alla inoltrata di pacchetti in modalità diretta.';

  @override
  String get repeater_cliHelpSetBridgeEnabled =>
      'Abilita/disabilita il bridge.';

  @override
  String get repeater_cliHelpSetBridgeDelay =>
      'Imposta il ritardo prima di ritrasmettere i pacchetti.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      'Scegli se il bridge ritrasmette i pacchetti ricevuti o trasmessi.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'Imposta la velocità di trasmissione per i ponti rs232.';

  @override
  String get repeater_cliHelpSetBridgeSecret =>
      'Imposta il segreto per i ponti espnow.';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      'Imposta un fattore personalizzato per regolare la tensione della batteria riportata (supportato solo su schede selezionate).';

  @override
  String get repeater_cliHelpTempRadio =>
      'Imposta parametri radio temporanei per il numero specificato di minuti, per poi tornare ai parametri radio originali. (non salva nelle preferenze).';

  @override
  String get repeater_cliHelpSetPerm =>
      'Modifica l\'ACL. Rimuove l\'entrata corrispondente (per prefisso di pubkey) se \"permissions\" è zero. Aggiunge una nuova entrata se il pubkey-hex ha lunghezza completa e non è attualmente nell\'ACL. Aggiorna l\'entrata per corrispondenza del prefisso di pubkey. I bit di permesso variano per ogni ruolo di firmware, ma i primi 2 bit sono: 0 (Guest), 1 (solo lettura), 2 (lettura/scrittura), 3 (Admin)';

  @override
  String get repeater_cliHelpGetBridgeType =>
      'Mostra il tipo di bridge: nessuno, rs232, espnow';

  @override
  String get repeater_cliHelpLogStart =>
      'Avvia registrazione pacchetti nel file system.';

  @override
  String get repeater_cliHelpLogStop =>
      'Interrompi la registrazione dei pacchetti al file system.';

  @override
  String get repeater_cliHelpLogErase =>
      'Elimina i log del pacchetto dal file system.';

  @override
  String get repeater_cliHelpNeighbors =>
      'Mostra un elenco di altri nodi repeater ricevuti tramite annunci zero-hop. Ogni riga è id-prefisso-esadecimale:timestamp:snr-volte-4';

  @override
  String get repeater_cliHelpNeighborRemove =>
      'Rimuove la prima corrispondenza in base al prefisso (esadecimale) della pubkey, dalla lista dei vicini.';

  @override
  String get repeater_cliHelpRegion =>
      '(solo serie) Elenca tutte le regioni definite e le autorizzazioni di allagamento correnti.';

  @override
  String get repeater_cliHelpRegionLoad =>
      'NOTA: questo è un\'invocazione multi-comando speciale. Ogni comando successivo è un nome di regione (indentato con spazi per indicare la gerarchia parentale, con almeno uno spazio). Terminata inviando una riga vuota/comando.';

  @override
  String get repeater_cliHelpRegionGet =>
      'Cerca la regione con il prefisso del nome dato (o \"\" per l\'ambito globale). Risponde con \"-> nome-regione (nome-genitore) \'F\'\"';

  @override
  String get repeater_cliHelpRegionPut =>
      'Aggiunge o aggiorna una definizione di regione con il nome specificato.';

  @override
  String get repeater_cliHelpRegionRemove =>
      'Rimuove una definizione di regione con il dato nome. (deve corrispondere esattamente e non avere regioni figlio)';

  @override
  String get repeater_cliHelpRegionAllowf =>
      'Imposta il permesso \'F\'lood per la regione specificata. (\'*\' per lo scope globale/legacy)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      'Rimuove il permesso \'F\'lood per la regione specificata. (NOTA: al momento non è consigliato usarlo sullo scope globale/legacy!!).';

  @override
  String get repeater_cliHelpRegionHome =>
      'Risponde con la regione \'home\' corrente. (Nota non ancora applicata, riservata per il futuro)';

  @override
  String get repeater_cliHelpRegionHomeSet => 'Imposta la regione \'home\'.';

  @override
  String get repeater_cliHelpRegionSave =>
      'Persiste l\'elenco/mappa delle regioni all\'archiviazione.';

  @override
  String get repeater_cliHelpGps =>
      'Mostra lo stato del GPS. Quando il GPS è spento, risponde solo \"spento\", se è acceso risponde con \"acceso\", \"stato\", \"fix\" e numero di satelliti.';

  @override
  String get repeater_cliHelpGpsOnOff =>
      'Attiva/disattiva l\'alimentazione del GPS.';

  @override
  String get repeater_cliHelpGpsSync =>
      'Sincronizza l\'orario del nodo con l\'orologio GPS.';

  @override
  String get repeater_cliHelpGpsSetLoc =>
      'Imposta la posizione del nodo alle coordinate GPS e salva le preferenze.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'Fornisce la configurazione dell\'annuncio per il nodo:\n- nessuno: non includere la posizione negli annunci\n- condividi: condividi la posizione GPS (dal SensorManager)\n- preferenze: annuncia la posizione memorizzata nelle preferenze';

  @override
  String get repeater_cliHelpGpsAdvertSet =>
      'Imposta la configurazione dell\'annuncio sulla posizione.';

  @override
  String get repeater_commandsListTitle => 'Elenco Comandi';

  @override
  String get repeater_commandsListNote =>
      'NOTA: per i vari comandi \"set...\", esiste anche un comando \"get...\".';

  @override
  String get repeater_general => 'Generale';

  @override
  String get repeater_settingsCategory => 'Impostazioni';

  @override
  String get repeater_bridge => 'Ponte';

  @override
  String get repeater_logging => 'Registrazione';

  @override
  String get repeater_neighborsRepeaterOnly => 'Vicini (solo ripetitore)';

  @override
  String get repeater_regionManagementRepeaterOnly =>
      'Gestione Regione (solo Ripetitore)';

  @override
  String get repeater_regionNote =>
      'Sono state introdotte le comandi di regione per gestire le definizioni e le autorizzazioni delle regioni.';

  @override
  String get repeater_gpsManagement => 'Gestione GPS';

  @override
  String get repeater_gpsNote =>
      'è stata introdotta una funzione gps per gestire le tematiche relative alla posizione.';

  @override
  String get repeater_getCategory => 'Ottenere valori';

  @override
  String get repeater_powerMgmt => 'Gestione dell\'energia';

  @override
  String get repeater_sensors => 'Sensori';

  @override
  String get repeater_cliHelpPowerOff =>
      'Disattiva il dispositivo. (non ci si aspetta alcuna risposta)';

  @override
  String get repeater_cliHelpClkReboot =>
      'Riporta l\'orologio a un\'epoca nota e riavvia il dispositivo.';

  @override
  String get repeater_cliHelpAdvertZeroHop =>
      'Invia un annuncio che raggiunge solo i vicini immediati (senza passaggi intermedi).';

  @override
  String get repeater_cliHelpStartOta =>
      'Avvia un aggiornamento del firmware tramite la trasmissione radio su schede supportate.';

  @override
  String get repeater_cliHelpTime =>
      'Imposta l\'orario del dispositivo sui secondi dell\'epoca Unix specificati. L\'orario non può andare indietro.';

  @override
  String get repeater_cliHelpBoard =>
      'Indica il produttore della scheda e l\'identificatore hardware.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      'Invia una richiesta di scoperta di nodi ai vicini. (Solo per ripetitori)';

  @override
  String get repeater_cliHelpPowersaving =>
      'Indica se la modalità di risparmio energetico è attiva o disattivata.';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      'Abilita o disabilita la modalità di risparmio energetico (se supportata).';

  @override
  String get repeater_cliHelpErase =>
      '(Solo per sistemi di serializzazione) Formatta il file system del dispositivo. Elimina tutte le impostazioni e i contatti.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      'Imposta il ciclo di trasmissione massimo consentito in percentuale (da 1 a 100). Regola internamente il fattore di tempo di trasmissione.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '(Solo per serie) Sostituisce la chiave privata di identificazione del dispositivo. È necessario riavviare il dispositivo per applicare la modifica. Genera una nuova chiave pubblica.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(Solo per SX126x) Permette di attivare un guadagno RX potenziato per una maggiore sensibilità a correnti più elevate.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      'Definisce la stringa contenente le informazioni di contatto del proprietario, presente negli annunci. Utilizzare \'|\' per i newline.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'Imposta la modalità di hashing del percorso. 0 = modalità legacy, 1 = modalità standard, 2 = modalità rigorosa. Influisce su come vengono abbinati i percorsi di routing.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'Imposta il livello di sensibilità per il rilevamento dei loop di routing: disattivato, minimo, moderato o rigoroso.';

  @override
  String get repeater_cliHelpSetFreq =>
      '(Solo per la funzione di regolazione della frequenza) Imposta rapidamente la frequenza desiderata. È necessario riavviare il dispositivo. Si consiglia di utilizzare la funzione \"imposta radio\" per impostare tutti i parametri radio.';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(Solo per il bridge ESPNow) Imposta il canale Wi-Fi (da 1 a 14) utilizzato dal bridge.';

  @override
  String get repeater_cliHelpGetName => 'Mostra il nome del nodo configurato.';

  @override
  String get repeater_cliHelpGetRole =>
      'Indica il ruolo del firmware (ripetitore, server per stanza, ecc.).';

  @override
  String get repeater_cliHelpGetPublicKey =>
      'Mostra la chiave pubblica del dispositivo.';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '(Solo per serie) Visualizza la chiave privata del dispositivo. Trattala come una informazione riservata.';

  @override
  String get repeater_cliHelpGetRepeat =>
      'Indica se la funzione di inoltro dei pacchetti (funzione di ripetitore) è attiva o disattivata.';

  @override
  String get repeater_cliHelpGetTx => 'Mostra la potenza attuale in dBm.';

  @override
  String get repeater_cliHelpGetFreq =>
      'Mostra la frequenza radio configurata in MHz.';

  @override
  String get repeater_cliHelpGetRadio =>
      'Visualizza tutti i parametri radio: frequenza, larghezza di banda, fattore di spreading, tasso di codifica.';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(Solo per i moduli SX126x) Mostra lo stato del guadagno potenziato del RX.';

  @override
  String get repeater_cliHelpGetAf =>
      'Mostra il fattore di trasmissione attuale.';

  @override
  String get repeater_cliHelpGetDutyCycle =>
      'Mostra il ciclo di lavoro attuale consentito in percentuale.';

  @override
  String get repeater_cliHelpGetIntThresh =>
      'Mostra il limite di interferenza del canale in dB.';

  @override
  String get repeater_cliHelpGetAgcResetInterval =>
      'Indica l\'intervallo di reset dell\'AGC in secondi.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      'Indica se la modalità \"ACK doppio\" è attiva (1) o disattivata (0).';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'Indica se è consentito l\'accesso in sola lettura per gli ospiti.';

  @override
  String get repeater_cliHelpGetAdvertInterval =>
      'Indica l\'intervallo pubblicitario locale in minuti.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'Indica l\'intervallo dell\'annuncio flood, espresso in ore.';

  @override
  String get repeater_cliHelpGetGuestPassword =>
      'Visualizza la password del guest configurata.';

  @override
  String get repeater_cliHelpGetLat => 'Mostra la latitudine configurata.';

  @override
  String get repeater_cliHelpGetLon => 'Mostra la longitudine impostata.';

  @override
  String get repeater_cliHelpGetRxDelay => 'Mostra il valore base di rxdelay.';

  @override
  String get repeater_cliHelpGetTxDelay =>
      'Mostra il fattore txdelay in modalità flood.';

  @override
  String get repeater_cliHelpGetDirectTxDelay =>
      'Mostra il fattore di ritardo in modalità diretta.';

  @override
  String get repeater_cliHelpGetFloodMax =>
      'Mostra il numero massimo di salti del flood.';

  @override
  String get repeater_cliHelpGetOwnerInfo =>
      'Visualizza la stringa contenente le informazioni di contatto del proprietario.';

  @override
  String get repeater_cliHelpGetPathHashMode =>
      'Mostra la modalità \"hash del percorso\" (0/1/2).';

  @override
  String get repeater_cliHelpGetLoopDetect =>
      'Indica la sensibilità alla rilevazione di loop.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(Solo per serie) Elenca le voci di controllo degli accessi su un ripetitore.';

  @override
  String get repeater_cliHelpGetBridgeEnabled => 'Indica se il ponte è attivo.';

  @override
  String get repeater_cliHelpGetBridgeDelay =>
      'Mostra il ritardo del ponte in millisecondi.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'Indica se il bridge sta inviando pacchetti RX o TX.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(Solo per l\'adattatore RS232) Visualizza la velocità di trasmissione del bridge.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(Solo per il bridge ESPNow) Visualizza il canale WiFi del bridge.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(Solo per il bridge ESPNow) Visualizza la chiave segreta condivisa.';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '(Solo per NRF52) Visualizza la versione del bootloader.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'Mostra il moltiplicatore ADC (adattamento della tensione della batteria).';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      'Indica se il sistema dispone di funzionalità di gestione dell\'energia.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      'Indica la fonte di alimentazione attuale: esterna o batteria.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      'Mostra le ragioni più recenti per il ripristino e lo spegnimento.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv =>
      'Mostra la tensione della batteria al momento dell\'accensione, misurata in millivolt (mV).';

  @override
  String get repeater_cliHelpSensorGet =>
      'Legge un valore di configurazione personalizzato per un sensore tramite un tasto.';

  @override
  String get repeater_cliHelpSensorSet =>
      'Definisce una configurazione personalizzata per un sensore.';

  @override
  String get repeater_cliHelpSensorList =>
      'Elenca tutte le impostazioni personalizzate dei sensori, organizzate in pagine a partire da un indice di inizio opzionale.';

  @override
  String get repeater_cliHelpRegionDefault =>
      'Mostra l\'ambito predefinito corrente.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'Definisce l\'ambito regionale predefinito. Utilizzare \"<null>\" per cancellare.';

  @override
  String get repeater_cliHelpRegionListAllowed =>
      'Elenca le regioni che consentono il traffico flood.';

  @override
  String get repeater_cliHelpRegionListDenied =>
      'Elenca le regioni che negano il traffico flood.';

  @override
  String get repeater_cliHelpStatsPackets =>
      '(Solo per la visualizzazione dei dati seriali) Mostra statistiche a livello di pacchetto.';

  @override
  String get repeater_cliHelpStatsRadio =>
      '(Solo per serie TV) Visualizza statistiche relative alla trasmissione radiofonica.';

  @override
  String get repeater_cliHelpStatsCore =>
      '(Solo per serie) Visualizza le statistiche del firmware di base.';

  @override
  String get telemetry_receivedData => 'Dati Telemetria Ricevuti';

  @override
  String get telemetry_requestTimeout => 'Richiesta di telemetria scaduta.';

  @override
  String telemetry_errorLoading(String error) {
    return 'Errore nel caricamento della telemetria: $error';
  }

  @override
  String get telemetry_noData => 'Nessun dato di telemetria disponibile.';

  @override
  String telemetry_channelTitle(int channel) {
    return 'Canale $channel';
  }

  @override
  String get telemetry_batteryLabel => 'Batteria';

  @override
  String get telemetry_voltageLabel => 'Tensione';

  @override
  String get telemetry_mcuTemperatureLabel => 'Temperatura MCU';

  @override
  String get telemetry_temperatureLabel => 'Temperatura';

  @override
  String get telemetry_currentLabel => 'Attuale';

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
  String get telemetry_digitalInputLabel => 'Ingresso digitale';

  @override
  String get telemetry_digitalOutputLabel => 'Uscita digitale';

  @override
  String get telemetry_analogInputLabel => 'Ingresso analogico';

  @override
  String get telemetry_analogOutputLabel => 'Uscita analogica';

  @override
  String get telemetry_genericLabel => 'Sensore generico';

  @override
  String get telemetry_luminosityLabel => 'Luminosità';

  @override
  String get telemetry_presenceLabel => 'Presenza';

  @override
  String get telemetry_humidityLabel => 'Umidità';

  @override
  String get telemetry_accelerometerLabel => 'Accelerometro';

  @override
  String get telemetry_pressureLabel => 'Pressione';

  @override
  String get telemetry_altitudeLabel => 'Altitudine';

  @override
  String get telemetry_frequencyLabel => 'Frequenza';

  @override
  String get telemetry_percentageLabel => 'Percentuale';

  @override
  String get telemetry_concentrationLabel => 'Concentrazione';

  @override
  String get telemetry_powerLabel => 'Potenza';

  @override
  String get telemetry_distanceLabel => 'Distanza';

  @override
  String get telemetry_energyLabel => 'Energia';

  @override
  String get telemetry_directionLabel => 'Direzione';

  @override
  String get telemetry_timeLabel => 'Ora';

  @override
  String get telemetry_gyrometerLabel => 'Giroscopio';

  @override
  String get telemetry_colourLabel => 'Colore';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'Interruttore';

  @override
  String get telemetry_polylineLabel => 'Polilinea';

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
  String get telemetry_autoFetchQuantity => 'Numero di richieste';

  @override
  String get telemetry_error => 'Impossibile recuperare i dati';

  @override
  String get neighbors_receivedData => 'Dati dei vicini ricevuti';

  @override
  String get neighbors_requestTimedOut => 'Richiesta dei vicini scaduta.';

  @override
  String neighbors_errorLoading(String error) {
    return 'Errore nel caricamento dei vicini: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => 'Vicini dei ripetitori';

  @override
  String get neighbors_noData => 'Nessun dato sui vicini disponibile.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return 'Chiave pubblica sconosciuta $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return 'Sentito: $time fa';
  }

  @override
  String get channelPath_title => 'Percorso Pacchetto';

  @override
  String get channelPath_viewMap => 'Visualizza mappa';

  @override
  String get channelPath_otherObservedPaths => 'Altri percorsi osservati';

  @override
  String get channelPath_repeaterHops => 'Salti del ripetitore';

  @override
  String get channelPath_noHopDetails =>
      'I dettagli relativi a questo pacchetto non sono forniti.';

  @override
  String get channelPath_sourceLabel => 'Origine';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'Questo messaggio è arrivato tramite MQTT. La tua radio non l\'ha ricevuto, quindi non c\'è un percorso radio dalla tua radio.';

  @override
  String get channelPath_messageDetails => 'Dettagli messaggio';

  @override
  String get channelPath_senderLabel => 'Mittente';

  @override
  String get channelPath_timeLabel => 'Ora';

  @override
  String get channelPath_repeatsLabel => 'Ripetizioni';

  @override
  String channelPath_pathLabel(int index) {
    return 'Percorso $index';
  }

  @override
  String get channelPath_observedLabel => 'Osservato';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return 'Percorso osservato $index • $hops';
  }

  @override
  String get channelPath_noLocationData => 'Nessun dato di posizione';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => 'Sconosciuto';

  @override
  String get channelPath_floodPath => 'Flood';

  @override
  String get channelPath_directPath => 'Diretto';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 di $total salti';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed di $total salti';
  }

  @override
  String get channelPath_mapTitle => 'Mappa del percorso';

  @override
  String get channelPath_noRepeaterLocations =>
      'Non sono disponibili posizioni dei ripetitori per questo percorso.';

  @override
  String channelPath_primaryPath(int index) {
    return 'Percorso $index (Primario)';
  }

  @override
  String get channelPath_pathLabelTitle => 'Percorso';

  @override
  String get channelPath_observedPathHeader => 'Percorso Osservato';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable =>
      'Non sono disponibili i dettagli del salto per questo pacchetto.';

  @override
  String get channelPath_unknownRepeater => 'Ripetitore sconosciuto';

  @override
  String get community_title => 'Comunità';

  @override
  String get community_create => 'Crea Comunità';

  @override
  String get community_createDesc =>
      'Crea una nuova comunità e condividila tramite codice QR.';

  @override
  String get community_join => 'Unisciti';

  @override
  String get community_joinTitle => 'Unisciti alla Community';

  @override
  String community_joinConfirmation(String name) {
    return 'Vuoi unirti alla community \"$name\"?';
  }

  @override
  String get community_scanQr => 'Scansiona il QR Code della Community';

  @override
  String get community_scanInstructions =>
      'Punta la fotocamera su un codice QR della comunità';

  @override
  String get community_showQr => 'Mostra il codice QR';

  @override
  String get community_publicChannel => 'Comunità Pubblica';

  @override
  String get community_hashtagChannel => 'Hashtag della Comunità';

  @override
  String get community_name => 'Nome della Comunità';

  @override
  String get community_enterName => 'Inserisci il nome della comunità';

  @override
  String community_created(String name) {
    return 'Comunità \"$name\" creata';
  }

  @override
  String community_joined(String name) {
    return 'Unito alla comunità \"$name\"';
  }

  @override
  String get community_qrTitle => 'Condividi Comunità';

  @override
  String community_qrInstructions(String name) {
    return 'Scansiona questo codice QR per unirti a $name';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'I canali hashtag della community sono accessibili solo ai membri della community';

  @override
  String get community_invalidQrCode => 'Codice QR della community non valido';

  @override
  String get community_alreadyMember => 'Già membro';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'Sei già un membro di \"$name\".';
  }

  @override
  String get community_addPublicChannel =>
      'Aggiungi Canale Pubblico della Comunità';

  @override
  String get community_addPublicChannelHint =>
      'Aggiungi automaticamente il canale pubblico per questa community';

  @override
  String get community_noCommunities => 'Nessun gruppo aggiunto finora';

  @override
  String get community_scanOrCreate =>
      'Scansiona un codice QR o crea una community per iniziare.';

  @override
  String get community_manageCommunities => 'Gestisci Comunità';

  @override
  String get community_delete => 'Lascia la Comunità';

  @override
  String community_deleteConfirm(String name) {
    return 'Uscire da \"$name\"?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return 'Questo eliminerà anche $count canale/i e i loro messaggi.';
  }

  @override
  String community_deleted(String name) {
    return 'Hai lasciato la comunità \"$name\"';
  }

  @override
  String get community_regenerateSecret => 'Ri genera la chiave segreta';

  @override
  String community_regenerateSecretConfirm(String name) {
    return 'Regenera la chiave segreta per \"$name\"? Tutti i membri dovranno scansionare il nuovo codice QR per continuare a comunicare.';
  }

  @override
  String get community_regenerate => 'Rigenera';

  @override
  String community_secretRegenerated(String name) {
    return 'Codice segreto rigenerato per \"$name\"';
  }

  @override
  String get community_updateSecret => 'Aggiorna Segreto';

  @override
  String community_secretUpdated(String name) {
    return 'Segreto aggiornato per \"$name\"';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return 'Scansiona il nuovo codice QR per aggiornare il segreto di \"$name\"';
  }

  @override
  String get community_addHashtagChannel => 'Aggiungi Hashtag della Community';

  @override
  String get community_addHashtagChannelDesc =>
      'Aggiungi un canale con hashtag per questa community';

  @override
  String get community_selectCommunity => 'Seleziona Comunità';

  @override
  String get community_regularHashtag => 'Hashtag regolare';

  @override
  String get community_regularHashtagDesc =>
      'Hashtag pubblico (chiunque può unirsi)';

  @override
  String get community_communityHashtag => 'Hashtag della Comunità';

  @override
  String get community_communityHashtagDesc =>
      'Visibile solo ai membri della comunità';

  @override
  String community_forCommunity(String name) {
    return 'Per $name';
  }

  @override
  String get listFilter_tooltip => 'Filtra e ordina';

  @override
  String get listFilter_sortBy => 'Ordina per';

  @override
  String get listFilter_latestMessages => 'Ultimi messaggi';

  @override
  String get listFilter_heardRecently => 'Rilevato di recente';

  @override
  String get listFilter_az => 'A-Z';

  @override
  String get listFilter_filters => 'Filtri';

  @override
  String get listFilter_all => 'Tutti';

  @override
  String get listFilter_favorites => 'Preferiti';

  @override
  String get listFilter_addToFavorites => 'Aggiungi ai preferiti';

  @override
  String get listFilter_removeFromFavorites => 'Rimuovi dai preferiti';

  @override
  String get listFilter_users => 'Utenti';

  @override
  String get listFilter_repeaters => 'Ripetitori';

  @override
  String get listFilter_roomServers => 'Server stanza';

  @override
  String get listFilter_unreadOnly => 'Solo non letti';

  @override
  String get listFilter_newGroup => 'Nuovo gruppo';

  @override
  String get pathTrace_you => 'Tu';

  @override
  String get pathTrace_failed => 'Tracciamento del percorso fallito.';

  @override
  String get pathTrace_notAvailable =>
      'Tracciamento del percorso non disponibile.';

  @override
  String get pathTrace_refreshTooltip => 'Aggiorna tracciamento percorso.';

  @override
  String get pathTrace_someHopsNoLocation =>
      'Uno o più hop non hanno una posizione!';

  @override
  String get pathTrace_clearTooltip => 'Cancella percorso';

  @override
  String get losSelectStartEnd =>
      'Seleziona i nodi iniziali e finali per la LOS.';

  @override
  String losRunFailed(String error) {
    return 'Controllo della linea di vista fallito: $error';
  }

  @override
  String get losClearAllPoints => 'Cancella tutti i punti';

  @override
  String get losRunToViewElevationProfile =>
      'Eseguire LOS per visualizzare il profilo altimetrico';

  @override
  String get losMenuTitle => 'Menù LOS';

  @override
  String get losMenuSubtitle =>
      'Tocca i nodi o premi a lungo la mappa per punti personalizzati';

  @override
  String get losShowDisplayNodes => 'Mostra i nodi di visualizzazione';

  @override
  String get losCustomPoints => 'Punti personalizzati';

  @override
  String losCustomPointLabel(int index) {
    return 'Personalizzato $index';
  }

  @override
  String get losPointA => 'Punto A';

  @override
  String get losPointB => 'Punto B';

  @override
  String losAntennaA(String value, String unit) {
    return 'Antenna A: $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return 'Antenna B: $value $unit';
  }

  @override
  String get losRun => 'Esegui LOS';

  @override
  String get losNoElevationData => 'Nessun dato di elevazione';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, libera LOS, distanza minima $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, bloccato da $obstruction $heightUnit';
  }

  @override
  String get losStatusChecking => 'LOS: controllo...';

  @override
  String get losStatusNoData => 'LOS: nessun dato';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS: $clear/$total libera, $blocked bloccato, $unknown sconosciuto';
  }

  @override
  String get losErrorElevationUnavailable =>
      'Dati di elevazione non disponibili per uno o più campioni.';

  @override
  String get losErrorInvalidInput =>
      'Dati punti/elevazione non validi per il calcolo della LOS.';

  @override
  String get losRenameCustomPoint => 'Rinomina punto personalizzato';

  @override
  String get losPointName => 'Nome del punto';

  @override
  String get losShowPanelTooltip => 'Mostra il pannello LOS';

  @override
  String get losHidePanelTooltip => 'Nascondi il pannello LOS';

  @override
  String get losElevationAttribution =>
      'Dati di elevazione: Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'Orizzonte radio';

  @override
  String get losLegendLosBeam => 'Linea di vista';

  @override
  String get losLegendTerrain => 'Terreno';

  @override
  String get losBlockedSpotsTitle => 'Posti occupati';

  @override
  String get losBlockedSpotsHint =>
      'Tocca un punto bloccato sulla mappa per evidenziarlo.';

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
  String get losSelectedObstructionTitle => 'Ostacolo selezionato';

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
  String get losFrequencyLabel => 'Frequenza';

  @override
  String get losFrequencyInfoTooltip => 'Visualizza i dettagli del calcolo';

  @override
  String get losFrequencyDialogTitle => 'Calcolo dell’orizzonte radio';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'Partendo da k=$baselineK a $baselineFreq MHz, il calcolo regola il fattore k per l\'attuale banda $frequencyMHz MHz, che definisce il limite curvo dell\'orizzonte radio.';
  }

  @override
  String get contacts_pathTrace => 'Traccia Percorso';

  @override
  String get contacts_ping => 'Ping';

  @override
  String get contacts_repeaterPathTrace => 'Traccia percorso al ripetitore';

  @override
  String get contacts_repeaterPing => 'Ripetitore ping';

  @override
  String get contacts_roomPathTrace =>
      'Traccia del percorso al server della stanza';

  @override
  String get contacts_roomPing => 'Ping al server della stanza';

  @override
  String get contacts_chatTraceRoute => 'Traccia percorso path';

  @override
  String contacts_pathTraceTo(String name) {
    return 'Traccia percorso verso $name';
  }

  @override
  String get contacts_clipboardEmpty => 'La clipboard è vuota.';

  @override
  String get contacts_pasteNotContact =>
      'Non è un contatto MeshCore. Copia un link o un annuncio meshcore:// e riprova.';

  @override
  String get contacts_invalidAdvertFormat => 'Dati di contatto non validi';

  @override
  String get contacts_contactImported => 'Il contatto è stato importato.';

  @override
  String get contacts_contactImportFailed =>
      'Contatto non importato con successo.';

  @override
  String get contacts_zeroHopAdvert => 'Annuncio Zero Hop';

  @override
  String get contacts_floodAdvert => 'Annuncio alluvionale';

  @override
  String get contacts_copyAdvertToClipboard => 'Copia Annuncio negli Appunti';

  @override
  String get contacts_addContactFromClipboard =>
      'Aggiungere contatto dalla clipboard';

  @override
  String get contacts_ShareContact => 'Copia contatto negli Appunti';

  @override
  String get contacts_ShareContactZeroHop =>
      'Condividi contatto tramite annuncio';

  @override
  String get contacts_zeroHopContactAdvertSent =>
      'Inviato contatto tramite annuncio.';

  @override
  String get contacts_zeroHopContactAdvertFailed =>
      'Invio del contatto non riuscito.';

  @override
  String get contacts_contactAdvertCopied => 'Annuncio copiato negli Appunti.';

  @override
  String get contacts_contactAdvertCopyFailed =>
      'Copia dell\'annuncio nella Clipboard non riuscita.';

  @override
  String get notification_activityTitle => 'Attività MeshCore';

  @override
  String notification_messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'messaggi',
      one: 'messaggio',
    );
    return '$count $_temp0';
  }

  @override
  String notification_channelMessagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'messaggi del canale',
      one: 'messaggio del canale',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'nuovi nodi',
      one: 'nuovo nodo',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return 'Nuovo $contactType scoperto';
  }

  @override
  String get notification_receivedNewMessage => 'Nuovo messaggio ricevuto';

  @override
  String get settings_gpxExportRepeaters =>
      'Esporta ripetitori / server di stanza in GPX';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'Esporta ripetitori / roomserver con una posizione in un file GPX.';

  @override
  String get settings_gpxExportContacts => 'Esporta compagni in GPX';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'Esporta i compagni con una posizione in un file GPX.';

  @override
  String get settings_gpxExportAll => 'Esporta tutti i contatti in GPX';

  @override
  String get settings_gpxExportAllSubtitle =>
      'Esporta tutti i contatti con una posizione in un file GPX.';

  @override
  String get settings_gpxExportSuccess =>
      'Esportazione del file GPX completata con successo.';

  @override
  String get settings_gpxExportNoContacts => 'Nessun contatto da esportare.';

  @override
  String get settings_gpxExportNotAvailable =>
      'Non supportato sul tuo dispositivo/Sistema Operativo';

  @override
  String get settings_gpxExportError =>
      'Si è verificato un errore durante l\'esportazione.';

  @override
  String get settings_gpxExportRepeatersRoom =>
      'Posizioni del server ripetitore e della stanza';

  @override
  String get settings_gpxExportChat => 'Posizioni dei compagni';

  @override
  String get settings_gpxExportAllContacts => 'Tutte le posizioni dei contatti';

  @override
  String get settings_gpxExportShareText =>
      'Dati mappa esportati da NOTORYX Core';

  @override
  String get settings_gpxExportShareSubject =>
      'NOTORYX Core esportazione dati mappa GPX';

  @override
  String get snrIndicator_nearByRepeaters => 'Ripetitori vicini';

  @override
  String get snrIndicator_lastSeen => 'Ultimo accesso';

  @override
  String get contactsSettings_title => 'Impostazioni dei contatti';

  @override
  String get contactsSettings_autoAddTitle => 'Scoperta automatica';

  @override
  String get contactsSettings_otherTitle =>
      'Altre impostazioni relative ai contatti';

  @override
  String get contactsSettings_autoAddUsersTitle =>
      'Aggiungere utenti automaticamente';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      'Consenti al compagno di aggiungere automaticamente gli utenti scoperti.';

  @override
  String get contactsSettings_autoAddRepeatersTitle =>
      'Aggiungere ripetitori automaticamente';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      'Consenti al compagno di aggiungere automaticamente i ripetitori scoperti.';

  @override
  String get contactsSettings_autoAddRoomServersTitle =>
      'Aggiungere automaticamente i server delle stanze';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      'Consenti al compagno di aggiungere automaticamente i server delle stanze scoperte.';

  @override
  String get contactsSettings_autoAddSensorsTitle =>
      'Aggiungere automaticamente i sensori';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      'Consenti al compagno di aggiungere automaticamente i sensori scoperti';

  @override
  String get contactsSettings_overwriteOldestTitle =>
      'Sostituisci il più vecchio';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      'Quando l\'elenco dei contatti è pieno, il contatto più vecchio non tra i preferiti verrà sostituito.';

  @override
  String get discoveredContacts_Title => 'Contatti scoperti';

  @override
  String get discoveredContacts_noMatching => 'Nessun contatto corrispondente';

  @override
  String get discoveredContacts_searchHint => 'Cerca contatti scoperti';

  @override
  String get discoveredContacts_contactAdded => 'Contatto aggiunto';

  @override
  String get discoveredContacts_addContact => 'Aggiungi contatto';

  @override
  String get discoveredContacts_copyContact => 'Copia contatto negli appunti';

  @override
  String get discoveredContacts_deleteContact => 'Elimina Contatto';

  @override
  String get discoveredContacts_deleteContactAll =>
      'Eliminare tutti i contatti scoperti';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      'Sei sicuro di voler eliminare tutti i contatti scoperti?';

  @override
  String get chat_sendCooldown =>
      'Si prega di attendere un momento prima di inviare nuovamente.';

  @override
  String get appSettings_jumpToOldestUnread =>
      'Vai al messaggio più vecchio non letto';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      'Quando si apre una chat con messaggi non letti, scorrete verso l\'alto fino al primo messaggio non letto, invece che al più recente.';

  @override
  String get appSettings_languageHu => 'Ungherese';

  @override
  String get appSettings_languageJa => 'Giapponese';

  @override
  String get appSettings_languageKo => 'Coreano';

  @override
  String get radioStats_tooltip => 'Statistiche per radio e reti';

  @override
  String get radioStats_screenTitle => 'Statistiche radio';

  @override
  String get radioStats_notConnected =>
      'Connettiti a un dispositivo per visualizzare le statistiche radio.';

  @override
  String get radioStats_firmwareTooOld =>
      'Le statistiche radio richiedono il firmware versione 8 o successiva.';

  @override
  String get radioStats_waiting => 'In attesa dei dati…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'Livello di rumore: $noiseDbm dBm';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return 'Ultimo valore RSSI: $rssiDbm dBm';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return 'Ultimo SNR: $snr dB';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'Tempo di trasmissione in diretta (totale): $seconds s';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'Tempo di trasmissione RX (totale): $seconds s';
  }

  @override
  String get radioStats_chartCaption =>
      'Livello di rumore (dBm) misurato su campioni recenti.';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'Livello di rumore: $noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting => 'Recupero delle statistiche radio…';

  @override
  String get radioStats_settingsTile => 'Statistiche radio';

  @override
  String get radioStats_settingsSubtitle =>
      'Livello di rumore, RSSI, rapporto segnale/rumore (SNR) e tempo di trasmissione';

  @override
  String get translation_title => 'Traduzione';

  @override
  String get imageMessages_enableTitle => 'Messaggi con immagini';

  @override
  String get imageMessages_enableSubtitle =>
      'Invia le immagini tramite la mesh. È necessario scaricare il modello dell\'immagine una tantum.';

  @override
  String get imageMessages_modelSectionTitle => 'Modello di immagine';

  @override
  String get imageMessages_downloadModel => 'Scarica';

  @override
  String get imageMessages_cancelDownload => 'Annullare';

  @override
  String get imageMessages_removeModel => 'Rimuovi il modello';

  @override
  String get imageMessages_modelReady => 'Pronto';

  @override
  String get imageMessages_modelNotPublished =>
      'Non pubblicato ancora — questa versione non può scaricarlo.';

  @override
  String get imageMessages_downloadFailed =>
      'Il modello di immagine non può essere scaricato.';

  @override
  String get imageMessages_autoProcessTitle =>
      'Elabora automaticamente le immagini';

  @override
  String get imageMessages_autoProcessSubtitle =>
      'Ricostruisci ogni immagine non appena arriva. Utilizza circa 2 GB di memoria per un secondo ogni volta; disattiva la ricostruzione con un semplice tocco.';

  @override
  String get translation_enableTitle => 'Abilitare la traduzione';

  @override
  String get translation_enableSubtitle =>
      'Tradurre i messaggi in arrivo e consentire la traduzione preventiva prima dell\'invio.';

  @override
  String get translation_composerTitle => 'Tradurre prima di inviare';

  @override
  String get translation_composerSubtitle =>
      'Controlla lo stato predefinito dell\'icona di traduzione del compositore.';

  @override
  String get translation_autoIncomingTitle =>
      'Traduci automaticamente i messaggi';

  @override
  String get translation_autoIncomingSubtitle =>
      'Traduce automaticamente i messaggi per le notifiche e per le chat o i canali.';

  @override
  String get translation_translateMessage => 'Traduci messaggio';

  @override
  String get translation_targetLanguage => 'Lingua di destinazione';

  @override
  String get translation_useAppLanguage => 'Utilizza la lingua dell\'app';

  @override
  String get translation_downloadedModelLabel => 'Modello scaricato';

  @override
  String get translation_presetModelLabel =>
      'Modello predefinito di Hugging Face';

  @override
  String get translation_manualUrlLabel => 'URL del modello manuale';

  @override
  String get translation_downloadModel => 'Scarica il modello';

  @override
  String get translation_downloading => 'Inizio download...';

  @override
  String get translation_working => 'Lavoro...';

  @override
  String get translation_stop => 'Smetta';

  @override
  String get translation_mergingChunks =>
      'Unione dei frammenti scaricati in un unico file...';

  @override
  String get translation_downloadedModels => 'Modelli scaricati';

  @override
  String get translation_deleteModel => 'Elimina modello';

  @override
  String get translation_modelDownloaded => 'Modello di traduzione scaricato.';

  @override
  String get translation_downloadStopped => 'Il download è stato interrotto.';

  @override
  String translation_downloadFailed(String error) {
    return 'Download fallito: $error';
  }

  @override
  String get translation_enterUrlFirst =>
      'Inserite innanzitutto l\'URL del modello.';

  @override
  String get scanner_linuxPairingShowPin => 'Mostra PIN';

  @override
  String get scanner_linuxPairingHidePin => 'Nascondi il PIN';

  @override
  String get scanner_linuxPairingPinTitle =>
      'PIN per l\'accoppiamento Bluetooth';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return 'Inserire il codice PIN per $deviceName (lasciare vuoto se non presente).';
  }

  @override
  String get translation_messageTranslation => 'Traduzione del messaggio';

  @override
  String get translation_translateBeforeSending => 'Tradurre prima di inviare';

  @override
  String get translation_composerEnabledHint =>
      'I messaggi verranno tradotti prima di essere inviati.';

  @override
  String get translation_composerDisabledHint =>
      'Invia messaggi utilizzando la lingua originale, scritta.';

  @override
  String translation_translateTo(String language) {
    return 'Tradurre in $language';
  }

  @override
  String get translation_translationOptions => 'Opzioni di traduzione';

  @override
  String get translation_systemLanguage => 'Lingua del sistema';

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
    return 'Impossibile aggiornare il canale: $error';
  }

  @override
  String get contact_typeChat => 'Chat';

  @override
  String get contact_typeRepeater => 'Ripetitore';

  @override
  String get contact_typeRoom => 'Stanza';

  @override
  String get contact_typeSensor => 'Sensore';

  @override
  String get contact_typeUnknown => 'Sconosciuto';

  @override
  String get map_zoomIn => 'Ingrandisci';

  @override
  String get map_zoomOut => 'Riduci la visualizzazione';

  @override
  String get map_centerMap => 'Centra mappa';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'Web Bluetooth richiede un browser basato su Chromium.';

  @override
  String channels_communityShortId(String id) {
    return 'ID: $id...';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'Il GPS conferma';

  @override
  String get pathTrace_legendInferred => 'Posizione dedotta';

  @override
  String get pathMap_viewSingle => 'Singola';

  @override
  String get pathMap_viewCombined => 'Combinata';

  @override
  String get pathMap_play => 'Riproduci';

  @override
  String get pathMap_pause => 'Pausa';

  @override
  String get pathMap_replay => 'Ripeti';

  @override
  String get pathMap_stepBack => 'Salto precedente';

  @override
  String get pathMap_stepForward => 'Salto successivo';

  @override
  String get pathMap_animationOn => 'Mostra l\'animazione del pacchetto';

  @override
  String get pathMap_animationOff => 'Nascondi l\'animazione del pacchetto';

  @override
  String pathMap_hopOf(int current, int total) {
    return 'Salto $current di $total';
  }

  @override
  String pathMap_observedPaths(int count) {
    return 'Percorsi osservati: $count';
  }

  @override
  String get pathMap_primary => 'Primario';

  @override
  String pathMap_alternate(int index) {
    return 'Alternativo $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count salti',
      one: '1 salto',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => 'Segmento condiviso';

  @override
  String get pathMap_legendEstimated => 'Segmento stimato';

  @override
  String pathMap_sharedNodeCount(int count) {
    return 'Utilizzato da $count percorsi';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count salti non hanno una posizione specifica — il percorso mostrato è parziale',
      one:
          '1 salto non ha una posizione specifica — il percorso mostrato è parziale',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'Mostra tutti';

  @override
  String get pathMap_hidePath => 'Nascondi percorso';

  @override
  String get pathMap_showPath => 'Mostra percorso';

  @override
  String get pathMap_collapsePanel => 'Comprimi pannello';

  @override
  String get pathMap_expandPanel => 'Espandi pannello';

  @override
  String get pathMap_noLocation => 'Nessuna posizione';

  @override
  String get pathMap_followPacket => 'Blocca la vista sul pacchetto';

  @override
  String get pathMap_unfollowPacket => 'Sblocca la vista dal pacchetto';

  @override
  String get imageSend_title => 'Invia immagine';

  @override
  String get imageSend_cropNote =>
      'Ridimensionato a 512 × 512 · rapporto d\'aspetto non conservato';

  @override
  String get imageSend_originalSize =>
      'Traduzione:\n\nOriginal text:\n\nPlease translate the following English text into Italian:\n\nOriginal text:\n\n(No original English text provided)';

  @override
  String get imageSend_onAirSize => 'In onda';

  @override
  String get imageSend_quality => 'Qualità';

  @override
  String get imageSend_qualityStandard => 'Standard';

  @override
  String get imageSend_qualityHigh => 'Alto';

  @override
  String get imageSend_packetsLabel => 'Pacchetti';

  @override
  String get imageSend_airtimeLabel => 'Tempo in onda';

  @override
  String get imageSend_sizeLabel => 'Carico utile';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pacchetti',
      one: 'pacchetto',
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
  String get imageSend_radioUnknownTitle => 'Impostazioni radio sconosciute';

  @override
  String get imageSend_radioUnknownBody =>
      'Collegati a un dispositivo in modo che si possa calcolare l\'orario di trasmissione.';

  @override
  String get imageSend_longSendTitle => 'Lunga trasmissione';

  @override
  String imageSend_longSendBody(String duration) {
    return 'Questo manterrà il canale per circa $duration.';
  }

  @override
  String get imageSend_floodNote =>
      'Instradamento delle inondazioni: ogni ripetitore nel raggio ritrasmette ogni pacchetto, quindi il canale rimane occupato più a lungo.';

  @override
  String get imageSend_parityTitle => 'Pacchetto di recupero';

  @override
  String get imageSend_paritySubtitle =>
      'Un pacchetto aggiuntivo. I messaggi di gruppo non vengono riconosciuti, quindi questo permette al destinatario di ricostruire l\'immagine se un singolo pacchetto viene perso.';

  @override
  String get imageSend_send => 'Invia';

  @override
  String get imageSend_cancel => 'Annullare';

  @override
  String get imageSend_encodeFailed =>
      'Questa immagine non può essere codificata.';

  @override
  String get imageSend_codecDownloading =>
      'Il modello di immagine sta ancora scaricando.';

  @override
  String get imageSend_codecUnavailable =>
      'L\'invio di immagini non è disponibile su questo dispositivo.';

  @override
  String get imageSend_codecDisabled =>
      'I messaggi immagine sono disattivati nelle impostazioni.';

  @override
  String get imageSend_deviceUnsupported =>
      'Questa radio non può inviare pacchetti di immagini. Collegare un dispositivo con firmware companion versione 13 o successiva.';

  @override
  String get imageSend_directMessagesUnsupported =>
      'Le immagini viaggiano come dati di gruppo, quindi possono essere inviate solo a un canale — non tramite messaggio diretto.';

  @override
  String get imageSend_tooLarge =>
      'Quella immagine è stata codificata in un numero di pacchetti superiore a quello consentito dal formato mesh.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pacchetti',
      one: 'pacchetto',
    );
    return 'Immagine inviata come $count $_temp0.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return 'L\'immagine non può essere inviata: $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return 'Invio immagine — pacchetto $sent di $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'Nodo $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return '$received di $total pacchetti';
  }

  @override
  String get receivedImage_queued => 'In attesa di decodificare';

  @override
  String get receivedImage_tapToDecode => 'Tocca per decodificare';

  @override
  String get receivedImage_decoding => 'Ricostruire… circa 1 s';

  @override
  String receivedImage_incomplete(int received, int total) {
    return 'Immagine incompleta — $received su $total pacchetti ricevuti';
  }

  @override
  String get receivedImage_corrupt =>
      'L\'immagine non potrebbe essere ricostruita';

  @override
  String get receivedImage_decoderMissing =>
      'Immagine ricevuta — decodifica dell\'immagine non funzionante';

  @override
  String get receivedImage_evicted => 'Immagine non più memorizzata';

  @override
  String get receivedImage_retry => 'Prova ancora';

  @override
  String get receivedImage_decodeAgain => 'Decodifica di nuovo';

  @override
  String get receivedImage_openSettings => 'Imposta';

  @override
  String get receivedImage_tapToProcess => 'Premi per elaborare';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'pacchetti',
      one: 'pacchetto',
    );
    return '$bytes byte · $packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds secondi';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes min $seconds s';
  }

  @override
  String get bastion_tagline => 'Comunicazione senza infrastruttura.';

  @override
  String get bastion_nodes => 'Nodi';

  @override
  String get bastion_repeaters => 'Ripetitori';

  @override
  String get bastion_active1h => 'Attivi 1 h';

  @override
  String get bastion_mapCoverage => 'Mappa + copertura';

  @override
  String get bastion_routeIntelligence => 'Analisi dei percorsi';

  @override
  String get bastion_repeaterTools => 'Strumenti ripetitore';

  @override
  String get bastion_fieldStats => 'Statistiche sul campo';

  @override
  String get bastion_fieldOps => 'Uscita + operazioni sul campo';

  @override
  String get bastion_coverageCapture => 'Rilevamento copertura';

  @override
  String get bastion_mapAttribution =>
      'Dati mappa © contributori di OpenStreetMap; tile del fornitore selezionato';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count osservazioni',
      one: '1 osservazione',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nodi unici',
      one: '1 nodo unico',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count salti',
      one: '1 salto',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuti',
      one: '1 minuto',
    );
    return '$_temp0';
  }

  @override
  String get sos_holdHint =>
      'Tieni premuto 2 secondi. Invia la tua posizione ai contatti dell\'uscita ogni 5 minuti finché qualcuno non risponde.';

  @override
  String sos_holdHintChannel(String channel) {
    return 'Tieni premuto 2 secondi. Invia la tua posizione ai contatti dell\'uscita e a $channel ogni 5 minuti finché qualcuno non risponde.';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS non inviato: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return 'Confermato da $name. Ripetizioni interrotte.';
  }

  @override
  String get sos_waitingForRadio => 'In attesa che la radio invii…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return 'Inviato $sends volte su $max. Ripetizioni terminate; ancora nessuna risposta.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return 'Inviato $sends volte su $max. Prossimo alle $time.';
  }

  @override
  String get sos_active => 'SOS ATTIVO';

  @override
  String get sos_stop => 'FERMA';

  @override
  String get sos_imSafe => 'SONO AL SICURO';

  @override
  String get sos_holdSemantics => 'SOS. Tieni premuto per inviare.';

  @override
  String get sos_keepHolding => 'CONTINUA A TENERE…';

  @override
  String get sos_holdForSos => 'TIENI PER SOS';

  @override
  String get sos_blockStorage =>
      'Risolvi prima l\'errore di archiviazione del registro di campo.';

  @override
  String get sos_blockNotConnected =>
      'Collega la tua radio MeshCore per inviare un SOS.';

  @override
  String get sos_blockNoTarget =>
      'Scegli i contatti dell\'uscita o un canale SOS in Pianifica uscita.';

  @override
  String get checkIn_labelOk => 'Sto bene';

  @override
  String get checkIn_labelAtCamp => 'Al campo';

  @override
  String get checkIn_labelDelayed => 'In ritardo';

  @override
  String get checkIn_labelHeadingBack => 'Sto rientrando';

  @override
  String get checkIn_blockLoading => 'Caricamento dell\'uscita…';

  @override
  String get checkIn_blockStorage =>
      'Risolvi l\'errore di archiviazione del registro di campo prima di inviare.';

  @override
  String get checkIn_blockBusy =>
      'È in corso l\'invio di un check-in. Attendi.';

  @override
  String get checkIn_blockNoContacts =>
      'Scegli i contatti dell\'uscita in Pianifica uscita.';

  @override
  String get checkIn_blockRosterIncomplete =>
      'Alcuni contatti dell\'uscita non sono disponibili. Controlla l\'elenco.';

  @override
  String get checkIn_blockNotConnected =>
      'Collega la tua radio MeshCore per fare il check-in.';

  @override
  String get checkIn_blockNotActive =>
      'Avvia l\'uscita per abilitare i check-in.';

  @override
  String get checkIn_notSent => 'Non inviato';

  @override
  String checkIn_deliveredToOne(String name) {
    return 'Consegnato a $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return 'Consegnato a tutti i $count contatti';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return 'Consegnato a $delivered su $total';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return 'Non consegnato: $names';
  }

  @override
  String get checkIn_waitingForRest => 'In attesa degli altri';

  @override
  String get checkIn_aContact => 'un contatto';

  @override
  String get checkIn_statusPending => 'In attesa';

  @override
  String get checkIn_statusSent => 'Inviato';

  @override
  String get checkIn_statusDelivered => 'Consegnato';

  @override
  String get checkIn_statusFailed => 'Non riuscito';

  @override
  String get checkIn_explainPending =>
      'In coda localmente. Questo non conferma la trasmissione radio né la ricezione.';

  @override
  String get checkIn_explainSent =>
      'La radio ha accettato l\'invio. Non è stata registrata alcuna conferma di consegna.';

  @override
  String get checkIn_explainDelivered =>
      'L\'app ha registrato una conferma di consegna. Non prova che la persona l\'abbia letto.';

  @override
  String get checkIn_explainFailed =>
      'Nessuna consegna confermata. Controlla la connessione radio, la raggiungibilità del destinatario e lo storico dei tentativi.';

  @override
  String get checkIn_explainUnknown =>
      'Lo stato di consegna non è disponibile. Non dare per scontato che il messaggio sia arrivato.';

  @override
  String get tripBrief_heading => 'NOTORYX • Riepilogo uscita MeshCore';

  @override
  String tripBrief_trip(String name) {
    return 'Uscita: $name';
  }

  @override
  String tripBrief_status(String status) {
    return 'Stato: $status';
  }

  @override
  String get tripBrief_active => 'Attiva';

  @override
  String get tripBrief_stopped => 'Interrotta';

  @override
  String tripBrief_contacts(String names) {
    return 'Contatti: $names';
  }

  @override
  String get tripBrief_noneSelected => 'Nessuno selezionato';

  @override
  String get tripBrief_unavailableContact =>
      'Contatto non disponibile (controlla l\'elenco)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return 'Attività in ritardo dopo: $minutes minuti (questo telefono avvisa quando un contatto tace)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'Promemoria check-in: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return 'ogni $minutes minuti senza check-in';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'Opzioni di check-in: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'Posizione radio nei check-in: $value';
  }

  @override
  String get tripBrief_includedMayBeStale =>
      'Inclusa; potrebbe non essere aggiornata';

  @override
  String tripBrief_battery(String value) {
    return 'Batteria della radio nei check-in: $value';
  }

  @override
  String get tripBrief_included => 'Inclusa';

  @override
  String get tripBrief_off => 'Disattivata';

  @override
  String get tripBrief_review =>
      'Controlla destinatari e messaggio prima di inviare un check-in.';

  @override
  String get tripBrief_noProof =>
      'In coda o inviato non prova la consegna. Una conferma non prova la lettura.';

  @override
  String get tripBrief_overdueMeaning =>
      'In ritardo significa nessuna attività recente del contatto; non è un\'emergenza confermata.';

  @override
  String get tripBrief_automations =>
      'Le automazioni sul campo funzionano solo mentre l\'app è attiva. Concordate un piano separato in caso di contatto mancato.';

  @override
  String get tripBrief_sharesOnly =>
      'Questo riepilogo condivide solo informazioni; non invia un messaggio radio e non avvia un\'uscita.';

  @override
  String get fieldOps_title => 'Operazioni sul campo NOTORYX Core';

  @override
  String get fieldOps_tabTrip => 'Uscita';

  @override
  String get fieldOps_tabReady => 'Pronti';

  @override
  String get fieldOps_tabLog => 'Registro';

  @override
  String get fieldOps_tabAuto => 'Auto';

  @override
  String get fieldOps_tabCoverage => 'Copertura';

  @override
  String get fieldOps_tabConnection => 'Connessione';

  @override
  String get fieldOps_diagnostics => 'Diagnostica';

  @override
  String get fieldOps_storageLoadError =>
      'Impossibile caricare i dati di campo. I dati salvati sono stati conservati; le automazioni restano disattivate.';

  @override
  String get fieldOps_storageSaveError =>
      'Impossibile salvare i dati di campo. Automazioni interrotte; i dati già salvati sono conservati.';

  @override
  String get fieldOps_regionHint =>
      'Seleziona un\'area e i livelli di zoom in Mappe offline.';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • zoom $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return 'Impossibile verificare l\'area della mappa: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uscita attiva • $count contatti',
      one: 'Uscita attiva • 1 contatto',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped =>
      'Uscita interrotta. Avviala quando sei pronto.';

  @override
  String fieldOps_reminderAt(String time) {
    return 'Promemoria check-in alle $time';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return 'In silenzio da troppo: $names';
  }

  @override
  String get fieldOps_planTrip => 'Pianifica uscita';

  @override
  String get fieldOps_endTrip => 'Termina uscita';

  @override
  String get fieldOps_startTrip => 'Avvia uscita';

  @override
  String get fieldOps_tripBrief => 'Riepilogo uscita';

  @override
  String get fieldOps_connectRadio => 'Collega radio';

  @override
  String get fieldOps_previewedCheckIns => 'Check-in con anteprima';

  @override
  String get fieldOps_previewedCheckInsHint =>
      'Scegli uno stato, controlla i destinatari effettivi e il messaggio, poi invia. In coda non significa consegnato.';

  @override
  String get fieldOps_tripRoster => 'Elenco dell\'uscita';

  @override
  String get fieldOps_rosterEmpty =>
      'Scegli fino a sei contatti chat noti in Pianifica uscita.';

  @override
  String get fieldOps_rosterCaveat =>
      '«Ultimo contatto» è prova di attività passata. Non stabilisce la raggiungibilità attuale. I badge di ritardo indicano nessuna attività recente del contatto, non un\'emergenza confermata.';

  @override
  String get fieldOps_offlineMaps => 'Mappe offline';

  @override
  String get fieldOps_checkingTiles => 'Controllo delle tile salvate…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tile in cache.',
      one: '1 tile in cache.',
    );
    return '$_temp0 Questo non garantisce che tutto il percorso sia coperto.';
  }

  @override
  String get fieldOps_downloadAreas => 'Scarica / controlla aree offline';

  @override
  String fieldOps_lastCheckIn(String time) {
    return 'Ultimo check-in, $time';
  }

  @override
  String fieldOps_deliveryChip(String name, String status) {
    return '$name: $status';
  }

  @override
  String get fieldOps_contactFallback => 'Contatto';

  @override
  String fieldOps_resendFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Reinvia a $count non consegnati',
      one: 'Reinvia a 1 non consegnato',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable =>
      'Contatto selezionato non disponibile';

  @override
  String get fieldOps_memberUnavailableHint =>
      'Controlla questa uscita prima di inviare.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return 'Ultima attività $minutes min fa';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return 'Ultima attività $minutes min fa • in ritardo';
  }

  @override
  String get fieldOps_noCheckInRecorded =>
      'Nessun check-in registrato in questo registro.';

  @override
  String get fieldOps_tripMap => 'Mappa dell\'uscita';

  @override
  String get fieldOps_tripMapEmpty =>
      'Nessun contatto selezionato ha ancora annunciato coordinate.';

  @override
  String get fieldOps_lastPositions => 'Ultime posizioni annunciate';

  @override
  String get fieldOps_positionsCaveat =>
      'Le posizioni possono non essere aggiornate. Questa mappa non segue il GPS del telefono né prova che i membri siano qui ora.';

  @override
  String get fieldOps_briefPreviewTitle => 'Anteprima riepilogo uscita';

  @override
  String get fieldOps_briefPreviewHint =>
      'Include i nomi dell\'uscita e dei contatti. Controlla prima di condividere. Coordinate, chiavi e cronologia dei messaggi sono omesse.';

  @override
  String get fieldOps_shareBrief => 'Condividi riepilogo';

  @override
  String get fieldOps_briefSubject => 'Riepilogo uscita NOTORYX Core';

  @override
  String get fieldOps_tripName => 'Nome dell\'uscita';

  @override
  String get fieldOps_defaultTripName => 'La mia uscita';

  @override
  String get fieldOps_includePosition =>
      'Includi la posizione annunciata dalla radio';

  @override
  String get fieldOps_includePositionHint =>
      'Potrebbe non essere aggiornata; la condivisione è disattivata per impostazione predefinita.';

  @override
  String get fieldOps_includeBattery => 'Includi batteria della radio';

  @override
  String get fieldOps_overdueLabel => 'Avvisami quando un contatto tace da';

  @override
  String get fieldOps_reminderLabel => 'Ricordami di fare il check-in';

  @override
  String get fieldOps_reminderHelper =>
      'Una notifica del telefono, anche se NOTORYX Core è chiuso.';

  @override
  String get fieldOps_reminderOff => 'Disattivato';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dopo $count minuti senza check-in',
      one: 'Dopo 1 minuto senza check-in',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'L\'SOS va anche al canale';

  @override
  String get fieldOps_sosChannelNone => 'Nessuno';

  @override
  String get fieldOps_selectContacts =>
      'Seleziona fino a sei contatti chat noti';

  @override
  String get fieldOps_sendCheckInTitle => 'Inviare il check-in?';

  @override
  String fieldOps_recipients(String names) {
    return 'A: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      'Usa normali messaggi diretti. La consegna sarà tracciata nel registro di campo.';

  @override
  String get fieldOps_send => 'Invia';

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
  String get fieldOps_beforeYouLeave => 'Prima di partire';

  @override
  String get fieldOps_radioConnected => 'Radio collegata';

  @override
  String get fieldOps_connectHint => 'Collegati via Bluetooth, USB o TCP.';

  @override
  String get fieldOps_radioBattery => 'Batteria della radio';

  @override
  String get fieldOps_batteryUnknown => 'Sconosciuta; controlla la radio.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent% • caricala per l\'uscita prevista.';
  }

  @override
  String get fieldOps_tripContacts => 'Contatti dell\'uscita';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return '$available/$selected disponibili. Verifica che abbiano radio e canali compatibili.';
  }

  @override
  String get fieldOps_offlineArea => 'Area mappa offline selezionata';

  @override
  String get fieldOps_checkingFiles => 'Controllo dei file locali…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return '$available/$expected file di tile disponibili; $missing mancanti. È un\'istantanea; apri l\'area offline prima di partire.';
  }

  @override
  String get fieldOps_locationChoice => 'Condivisione della posizione';

  @override
  String get fieldOps_locationOptedIn =>
      'Attivata: le coordinate annunciate dalla radio potrebbero non essere aggiornate.';

  @override
  String get fieldOps_locationOff =>
      'La condivisione è disattivata. I tuoi check-in omettono le coordinate.';

  @override
  String get fieldOps_automationAvailability =>
      'Disponibilità delle automazioni';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'Funziona solo mentre questa app è attiva. Sospensione, chiusura o perdita della radio possono impedire le azioni programmate.';

  @override
  String get fieldOps_readinessCaveat =>
      'I controlli sono indicativi; non provano la portata radio né garantiscono la consegna dei messaggi.';

  @override
  String get fieldOps_radio => 'Radio';

  @override
  String get fieldOps_refreshChecks => 'Aggiorna controlli';

  @override
  String get fieldOps_searchLog => 'Cerca nel registro di campo';

  @override
  String get fieldOps_kindAll => 'Tutto';

  @override
  String get fieldOps_kindCheckIn => 'Check-in';

  @override
  String get fieldOps_kindReceived => 'Ricevuto';

  @override
  String get fieldOps_kindNote => 'Nota';

  @override
  String get fieldOps_kindDeadZone => 'Zona senza copertura';

  @override
  String get fieldOps_kindRadio => 'Radio';

  @override
  String get fieldOps_kindAutomation => 'Automazione';

  @override
  String get fieldOps_kindMissed => 'Mancato';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => 'Uscita';

  @override
  String get fieldOps_kindOverdue => 'In ritardo';

  @override
  String get fieldOps_addNote => 'Aggiungi nota';

  @override
  String get fieldOps_exportJson => 'Esporta JSON';

  @override
  String get fieldOps_deleteLog => 'Elimina registro';

  @override
  String get fieldOps_logSubject => 'Registro di campo NOTORYX Core';

  @override
  String get fieldOps_logCaveat =>
      'Salvato localmente, fino a 1.000 voci. Le esportazioni possono contenere chiavi dei contatti, messaggi e posizioni; controlla prima di condividere.';

  @override
  String get fieldOps_noEntries => 'Nessuna voce corrispondente.';

  @override
  String get fieldOps_tripUnspecified => 'Uscita non specificata';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return 'Posizione annunciata dalla radio registrata $latitude, $longitude (potrebbe non essere aggiornata)';
  }

  @override
  String get fieldOps_noteTitle => 'Osservazione sul campo';

  @override
  String get fieldOps_noteLabel => 'Cosa hai osservato?';

  @override
  String get fieldOps_deadZone => 'Zona senza copertura segnalata';

  @override
  String get fieldOps_deadZoneHint =>
      'La tua osservazione, non una previsione di copertura verificata.';

  @override
  String get fieldOps_savePosition =>
      'Salva la posizione annunciata dalla radio';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • potrebbe non essere aggiornata; non è il GPS del telefono';
  }

  @override
  String get fieldOps_noPosition =>
      'Nessuna coordinata annunciata utilizzabile';

  @override
  String get fieldOps_deleteLogTitle => 'Eliminare il registro di campo?';

  @override
  String get fieldOps_deleteLogBody =>
      'Questo rimuove tutte le voci salvate su questo telefono. Le impostazioni dell\'uscita vengono conservate.';

  @override
  String get fieldOps_localAutomations => 'Automazioni locali';

  @override
  String get fieldOps_enableForTrip => 'Abilita per questa uscita';

  @override
  String get fieldOps_automationsCaveat =>
      'Disattivate dopo ogni riavvio dell\'app. Le regole funzionano solo mentre l\'app è attiva. Le azioni programmate mancate compaiono nel registro di campo e non vengono mai recuperate a raffica. I check-in automatici sono limitati a un gruppo ogni 10 minuti.';

  @override
  String get fieldOps_openBotMode => 'Apri la modalità bot di NOTORYX';

  @override
  String get fieldOps_ruleEnabled => 'Regola abilitata';

  @override
  String get fieldOps_dryRun => 'Simulazione';

  @override
  String get fieldOps_dryRunHint =>
      'Registra l\'azione senza inviare né notificare.';

  @override
  String get fieldOps_then => 'Allora';

  @override
  String get fieldOps_actionLog => 'Scrivi nel registro di campo';

  @override
  String get fieldOps_actionNotify => 'Mostra notifica locale';

  @override
  String get fieldOps_actionCheckIn =>
      'Invia «I\'m OK» ai contatti dell\'uscita';

  @override
  String get fieldOps_batteryThreshold => 'Batteria pari o inferiore a';

  @override
  String fieldOps_nextDue(String time) {
    return 'Prossima scadenza: $time';
  }

  @override
  String get fieldOps_nextDueNone => 'Prossima scadenza: non programmata';

  @override
  String get fieldOps_previewInLog => 'Anteprima nel registro';

  @override
  String get fieldOps_allowNotifications => 'Consenti notifiche';

  @override
  String get fieldOps_triggerReconnect => 'QUANDO la radio si ricollega';

  @override
  String get fieldOps_triggerDisconnect => 'QUANDO la radio si scollega';

  @override
  String get fieldOps_triggerLowBattery =>
      'QUANDO la batteria della radio supera la soglia';

  @override
  String get fieldOps_triggerNewNode => 'QUANDO viene aggiunto un nuovo nodo';

  @override
  String get fieldOps_triggerRepeater =>
      'QUANDO viene aggiunto un nuovo ripetitore';

  @override
  String get fieldOps_triggerScheduled =>
      'QUANDO è dovuto un check-in programmato';

  @override
  String get fieldOps_explainConnection => 'Spiega la mia connessione';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return 'Stato: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      'Il telefono ha una connessione con la radio. Questo da solo non stabilisce un percorso verso i destinatari.';

  @override
  String get fieldOps_disconnectedHint =>
      'Nessuna connessione radio attiva. Controlla i permessi Bluetooth, l\'alimentazione e la portata della radio; USB/TCP sono disponibili da Collega radio.';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return 'Check-in dell\'uscita in attesa di conferma: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'Gli orari di ultimo avvistamento e le posizioni annunciate dei nodi possono non essere aggiornati. L\'analisi dei percorsi mostra percorsi appresi da tentativi osservati; non inventa percorsi.';

  @override
  String get fieldOps_routeIntelligence => 'Analisi dei percorsi';

  @override
  String get fieldOps_coverageIntelligence => 'Analisi della copertura';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      'Confronta le osservazioni registrate tra due sessioni sul campo. I punti indicano le posizioni annunciate dalla radio del registratore dove sono stati sentiti nodi. Non implicano una copertura continua. Le istantanee RSSI/SNR non sono misure per nodo.';

  @override
  String get fieldOps_captureSession => 'Rileva una sessione';

  @override
  String get fieldOps_refreshHistory => 'Aggiorna cronologia';

  @override
  String get fieldOps_noCoverageSessions =>
      'Nessuna sessione di copertura salvata.';

  @override
  String get fieldOps_sessionA => 'Sessione A • verde acqua';

  @override
  String get fieldOps_sessionB => 'Sessione B • ambra';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: $a nodi unici • B: $b nodi unici';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return 'In comune: $shared • Solo A: $onlyA • Solo B: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'Non sentire un nodo durante una sessione non stabilisce una zona senza copertura. Condizioni e durata dell\'osservazione variano.';

  @override
  String get fieldOps_heardTooltip =>
      'Osservazione di nodo sentito; non prova un collegamento riuscito';

  @override
  String get fieldOps_noteTooltip =>
      'Nota locale alle coordinate annunciate dalla radio; potrebbe non essere aggiornata.';

  @override
  String get bastionHome_aboutTooltip => 'Informazioni su NOTORYX Core';

  @override
  String get bastionHome_getStarted => 'Inizia';

  @override
  String get bastionHome_getStartedHint =>
      'Collega la radio e verifica il tuo primo messaggio';

  @override
  String get bastionHome_planYourTrip => 'Pianifica la tua uscita';

  @override
  String get bastionHome_tripActive => 'Uscita attiva';

  @override
  String get bastionHome_tripStopped => 'Uscita interrotta';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • $contacts contatti • $unread messaggi non letti';
  }

  @override
  String get bastionHome_checkInOk => 'Check-in: sto bene';

  @override
  String get bastionHome_checkInHint =>
      'Controlla contatti e messaggio prima di inviare. Segui le conferme nel registro di campo.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return 'Ultimo check-in: $summary';
  }

  @override
  String get bastionHome_connectRadio => 'Collega radio';

  @override
  String get bastionHome_connectRadioHint =>
      'Connessioni MeshCore via Bluetooth, USB e TCP';

  @override
  String get bastionHome_liveDiagnostics => 'Diagnostica in tempo reale';

  @override
  String get bastionHome_liveDiagnosticsHint =>
      'Stato della radio, segnale, dispositivo e strumenti per i frame';

  @override
  String get bastionHome_meshDiscovery => 'Scoperta della rete mesh';

  @override
  String get bastionHome_meshDiscoveryHint =>
      'Trova nodi ed esamina la rete mesh intorno a te';

  @override
  String get bastionHome_fieldOpsHint =>
      'Riepilogo uscita, preparazione, registro di campo, automazioni e confronto della copertura';

  @override
  String get bastionHome_fieldTools => 'Strumenti da campo NOTORYX';

  @override
  String get bastionHome_statusActive => 'ATTIVO';

  @override
  String get bastionHome_consoleOnline => 'Console da campo online';

  @override
  String get bastionHome_consoleReady => 'Console da campo pronta';

  @override
  String get bastionHome_consoleHint =>
      'Collega una radio per attivare il pannello in tempo reale.';

  @override
  String bastionHome_battery(String value) {
    return 'Bat $value';
  }

  @override
  String get bastionTools_title => 'Strumenti da campo';

  @override
  String get bastionTools_backup => 'Backup crittografato';

  @override
  String get bastionTools_backupHint =>
      'Salva impostazioni, contatti e chiavi, con cronologia chat facoltativa';

  @override
  String get bastionTools_fieldOpsHint =>
      'Check-in, preparazione, registro di campo, automazioni e confronti';

  @override
  String get bastionTools_mapHint =>
      'Mappa in tempo reale, sessioni di rilevamento, strumenti mappe offline e regioni';

  @override
  String get bastionTools_pathAnalysis => 'Analisi dei cammini';

  @override
  String get bastionTools_pathHint =>
      'Percorsi, scoperta e analisi dei cammini';

  @override
  String get bastionTools_repeaterHint =>
      'Stato, accesso, telemetria, vicini e amministrazione';

  @override
  String get bastionTools_statsHint =>
      'Conteggi della rete mesh in tempo reale e attività dei contatti';

  @override
  String get bastionTools_diagnostics => 'Diagnostica';

  @override
  String get bastionTools_diagnosticsHint =>
      'Stato della radio, informazioni sul dispositivo, frame grezzi ed esportazione';

  @override
  String get bastionTools_about => 'Info + riconoscimenti';

  @override
  String get bastionTools_aboutHint =>
      'Versione di NOTORYX Core, dichiarazione di indipendenza e licenze open source';

  @override
  String get bastionAbout_title => 'Info + Riconoscimenti';

  @override
  String get bastionAbout_intro =>
      'Un\'app companion indipendente della community per le reti MeshCore. NOTORYX Core non è un\'app ufficiale MeshCore e l\'inclusione di risorse della community non implica partnership o approvazione.';

  @override
  String get bastionAbout_version => 'Versione';

  @override
  String get bastionAbout_openSource => 'Base open source';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core è costruito a partire dal codice open source di MeshCore Open con licenza MIT, che modifica. Il lavoro sul flusso di copertura riconosce anche, dove applicabile, la MeshMapper Flutter App con licenza MIT.';

  @override
  String get bastionAbout_community => 'Prima la community';

  @override
  String get bastionAbout_communityBody =>
      'Le risorse di creatori terzi restano proprietà dei rispettivi creatori. Non si intende alcuna proprietà o partnership.';

  @override
  String get bastionAbout_legalese =>
      'NOTORYX Core • Companion MeshCore indipendente';

  @override
  String get bastionAbout_licenses => 'Licenze open source';

  @override
  String get bastionSetup_title => 'Inizia con NOTORYX Core';

  @override
  String get bastionSetup_intro =>
      'Collegati, scegli un contatto, poi verifica un messaggio. Puoi tornare a questa guida dal pannello in qualsiasi momento.';

  @override
  String get bastionSetup_step1 => '1. Collega la tua radio MeshCore';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return 'Collegato a $device tramite $transport.';
  }

  @override
  String get bastionSetup_noRadio => 'Nessuna radio ancora collegata.';

  @override
  String get bastionSetup_step1Power =>
      'Accendi una radio companion MeshCore. Apri Collega radio e scegli Bluetooth, USB o TCP. Concedi i permessi richiesti per la connessione scelta.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Se la ricerca Bluetooth è vuota, verifica che il Bluetooth sia attivo e che NOTORYX Core abbia il permesso Dispositivi nelle vicinanze nelle impostazioni delle app Android. Segui eventuali altre richieste di permesso mostrate dallo scanner.';

  @override
  String get bastionSetup_connectionDiagnostics =>
      'Diagnostica della connessione';

  @override
  String get bastionSetup_step2 => '2. Scegli un contatto chat';

  @override
  String get bastionSetup_step2Body =>
      'Chiedi a un compagno vicino con impostazioni radio MeshCore compatibili di annunciare il suo nodo. Scegli qui sotto un contatto chat noto; i ripetitori si gestiscono a parte.';

  @override
  String get bastionSetup_noContacts =>
      'Nessun contatto chat disponibile. Collega la radio e apri Scoperta della rete mesh.';

  @override
  String get bastionSetup_testRecipient => 'Destinatario di prova';

  @override
  String get bastionSetup_meshDiscovery => 'Scoperta della rete mesh';

  @override
  String get bastionSetup_step3 => '3. Invia e verifica un messaggio';

  @override
  String get bastionSetup_step3Body =>
      'Apri la chat, scrivi un breve messaggio di prova, controlla il destinatario e tocca Invia. Torna qui per vedere l\'ultimo messaggio in uscita registrato da quando hai aperto questa guida.';

  @override
  String get bastionSetup_openTestChat => 'Apri chat di prova';

  @override
  String get bastionSetup_connectFirst =>
      'Collega la radio per aprire la chat di prova.';

  @override
  String get bastionSetup_chooseRecipient => 'Scegli prima un destinatario.';

  @override
  String get bastionSetup_noTestMessage =>
      'Nessun messaggio di prova in uscita registrato in questa sessione della guida.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return 'Ultimo messaggio: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'Chiedi al tuo compagno di confermare la ricezione o di rispondere. Una conferma registrata non prova la lettura. Ricontrolla connessione e destinatario se un messaggio non va a buon fine.';

  @override
  String get bastionSetup_step4 => '4. Preparati per il campo';

  @override
  String get bastionSetup_step4Body =>
      'Pianifica i contatti dell\'uscita e controlla le aree di mappa scaricate. Modalità bot e automazioni sul campo partono disattivate; le automazioni sul campo funzionano solo mentre l\'app è attiva.';

  @override
  String get bastionSetup_tripTools => 'Strumenti per uscita e preparazione';

  @override
  String get bastionDiag_title => 'Diagnostica';

  @override
  String get bastionDiag_export => 'Esporta diagnostica';

  @override
  String get bastionDiag_channels => 'Canali';

  @override
  String get bastionDiag_radio => 'Radio';

  @override
  String get bastionDiag_frequency => 'Frequenza';

  @override
  String get bastionDiag_bandwidth => 'Larghezza di banda';

  @override
  String get bastionDiag_spreadingFactor => 'Fattore di spreading';

  @override
  String get bastionDiag_codingRate => 'Coding rate';

  @override
  String get bastionDiag_txPower => 'Potenza TX';

  @override
  String get bastionDiag_noiseFloor => 'Rumore di fondo';

  @override
  String get bastionDiag_device => 'Dispositivo';

  @override
  String get bastionDiag_name => 'Nome';

  @override
  String get bastionDiag_manufacturer => 'Produttore';

  @override
  String get bastionDiag_firmware => 'Firmware';

  @override
  String get bastionDiag_battery => 'Batteria';

  @override
  String get bastionDiag_transport => 'Trasporto';

  @override
  String get bastionDiag_deepTools => 'Strumenti avanzati';

  @override
  String get bastionDiag_liveStats => 'Statistiche radio in tempo reale';

  @override
  String get bastionDiag_liveStatsHint =>
      'Rumore, RSSI, SNR e tempo di trasmissione';

  @override
  String get bastionDiag_frameDebug => 'Debug frame / BLE';

  @override
  String get bastionDiag_frameDebugHint =>
      'Esamina i frame ricevuti decodificati e grezzi';

  @override
  String get bastionDiag_appLog => 'Registro debug dell\'app';

  @override
  String get bastionDiag_appLogHint =>
      'Rivedi gli eventi diagnostici dell\'applicazione';

  @override
  String get bastionDiag_online => 'Radio online';

  @override
  String get bastionDiag_offline => 'Radio offline';

  @override
  String get bastionDiag_offlineHint =>
      'Collega un companion MeshCore per popolare la diagnostica in tempo reale.';

  @override
  String get coverage_title => 'Rilevamento copertura';

  @override
  String get coverage_leaveBlocked =>
      'Ferma e salva la sessione prima di uscire.';

  @override
  String get coverage_savedSessions => 'Sessioni salvate';

  @override
  String get coverage_caveat =>
      'RSSI/SNR sono istantanee della radio e possono appartenere a un altro pacchetto. Le posizioni sono coordinate annunciate dalla radio, non GPS del telefono né prova di copertura. Ciano: registratore; ambra: nodo annunciato. Non viene eseguita alcuna interpolazione.';

  @override
  String get coverage_captureActive => 'Rilevamento attivo';

  @override
  String get coverage_fieldSession => 'Sessione di copertura sul campo';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core registra i nodi appena sentiti durante questa sessione, inclusi dati di percorso, metadati di nodo/posizione e l\'istantanea RSSI/SNR della radio più vicina disponibile.';

  @override
  String get coverage_disconnectedBody =>
      'Collega una radio prima di iniziare. Il rilevamento copertura registra osservazioni della rete mesh in tempo reale dalla radio companion collegata.';

  @override
  String get coverage_observations => 'Osservazioni';

  @override
  String get coverage_uniqueNodes => 'Nodi unici';

  @override
  String get coverage_elapsed => 'Trascorso';

  @override
  String get coverage_radioConnected => 'Radio collegata';

  @override
  String get coverage_noRadio => 'Nessuna radio';

  @override
  String get coverage_gpsReady => 'GPS radio pronto';

  @override
  String get coverage_noGps => 'Nessun GPS radio';

  @override
  String get coverage_stopSave => 'Ferma + salva sessione';

  @override
  String get coverage_start => 'Avvia sessione di copertura';

  @override
  String get coverage_exportJson => 'Esporta JSON';

  @override
  String get coverage_exportCsv => 'Esporta CSV';

  @override
  String get coverage_liveObservations => 'Osservazioni in tempo reale';

  @override
  String get coverage_waiting => 'In attesa di attività della rete';

  @override
  String get coverage_waitingBody =>
      'Avvia una sessione e i nodi attivi appena sentiti compariranno qui. I valori RSSI/SNR sono istantanee della radio e non sempre sono attribuibili in modo univoco a un pacchetto specifico.';

  @override
  String get coverage_signalNa => 'segnale n/d';

  @override
  String get coverage_snrNa => 'SNR n/d';

  @override
  String get coverage_gpsUnavailable => 'GPS radio non disponibile';

  @override
  String coverage_pathLine(String path, String location) {
    return 'Percorso: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'flood';

  @override
  String get coverage_pathDirect => 'diretto';

  @override
  String get coverage_shareSubject => 'Sessione di copertura NOTORYX Core';

  @override
  String get coverage_shareText =>
      'Esportazione rilevamento copertura NOTORYX Core';

  @override
  String get coverage_historyTitle => 'Sessioni di copertura salvate';

  @override
  String coverage_loadFailed(String error) {
    return 'Impossibile caricare le sessioni: $error';
  }

  @override
  String get coverage_deleteTitle => 'Eliminare la sessione salvata?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count osservazioni verranno rimosse da questo dispositivo.',
      one: '1 osservazione verrà rimossa da questo dispositivo.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'Impossibile eliminare la sessione: $error';
  }

  @override
  String get coverage_retention =>
      'Vengono conservate le 20 sessioni completate più recenti. Condividi quelle che vuoi tenere. I rilevamenti interrotti possono essere riaperti qui sotto.';

  @override
  String get coverage_noSessions =>
      'Nessuna sessione salvata. Ferma un rilevamento per salvarlo.';

  @override
  String get coverage_interrupted => 'Rilevamento interrotto';

  @override
  String get coverage_saved => 'Salvata';

  @override
  String get coverage_deleteTooltip => 'Elimina sessione';

  @override
  String coverage_exportFailed(String error) {
    return 'Esportazione non riuscita: $error';
  }

  @override
  String get coverage_sessionTitle => 'Sessione di copertura';

  @override
  String get coverage_shareJson => 'Condividi JSON';

  @override
  String get coverage_shareCsv => 'Condividi CSV';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • età dell\'istantanea $age ms';
  }

  @override
  String get coverage_unknown => 'sconosciuta';

  @override
  String coverage_pathValue(String path) {
    return 'percorso $path';
  }

  @override
  String get coverage_recorder => 'Registratore';

  @override
  String get coverage_noCoordinates =>
      'Nessuna coordinata utilizzabile in questa sessione. Le osservazioni restano disponibili qui sotto.';

  @override
  String get coverage_osmAttribution =>
      '© contributori di OpenStreetMap • mappa di base online';

  @override
  String get fieldStats_title => 'Analisi sul campo';

  @override
  String get fieldStats_snapshot => 'Istantanea della rete mesh';

  @override
  String get fieldStats_headline => 'Cosa sa NOTORYX Core in questo momento.';

  @override
  String get fieldStats_body =>
      'Questi contatori sono calcolati dalla tabella dei contatti MeshCore collegata, dalle posizioni, dai percorsi e dagli orari di ultimo avvistamento.';

  @override
  String get fieldStats_total => 'Totale';

  @override
  String get fieldStats_chatNodes => 'Nodi chat';

  @override
  String get fieldStats_rooms => 'Stanze';

  @override
  String get fieldStats_sensors => 'Sensori';

  @override
  String get fieldStats_located => 'Localizzati';

  @override
  String get fieldStats_favorites => 'Preferiti';

  @override
  String get fieldStats_routeSnapshot => 'Istantanea dei percorsi';

  @override
  String get fieldStats_routed => 'Instradati';

  @override
  String get fieldStats_direct => 'Diretti';

  @override
  String get fieldStats_flood => 'Flood';

  @override
  String get fieldStats_pathIntel => 'Analisi dei cammini';

  @override
  String get fieldStats_pathIntelBody =>
      'L\'analisi dei percorsi di NOTORYX Core usa i tentativi di percorso salvati, il numero di salti, successi/fallimenti, il tempo di percorrenza e la ponderazione per mostrare i percorsi appresi.';

  @override
  String get fieldStats_coverageSessions => 'Sessioni di copertura';

  @override
  String get fieldStats_coverageSessionsBody =>
      'Il rilevamento copertura ora salva le sessioni sul campo, ripristina il lavoro interrotto, esporta le osservazioni e mappa i punti di copertura registrati. RSSI/SNR restano l\'istantanea radio più vicina disponibile.';

  @override
  String get mapHub_title => 'Mappa da campo NOTORYX';

  @override
  String get mapHub_intro =>
      'Mappe in tempo reale, aree offline, profili regionali e sessioni di copertura sul campo di NOTORYX Core.';

  @override
  String get mapHub_captureHint =>
      'Avvia e ferma una sessione di copertura sul campo';

  @override
  String get mapHub_badgeNew => 'NUOVO';

  @override
  String get mapHub_liveMap => 'Mappa mesh in tempo reale';

  @override
  String get mapHub_liveMapHint =>
      'Nodi, ripetitori, posizioni, percorsi e strumenti mappa';

  @override
  String get mapHub_badgeLive => 'LIVE';

  @override
  String get mapHub_offlinePacks => 'Pacchetti mappe offline';

  @override
  String get mapHub_offlinePacksHint =>
      'Salva in cache le tile per uscite e zone senza servizio';

  @override
  String get mapHub_badgeOffline => 'OFFLINE';

  @override
  String get mapHub_regions => 'Profili regionali';

  @override
  String get mapHub_regionsHint =>
      'Gestisci e scarica le definizioni regionali della rete mesh';

  @override
  String get mapHub_badgeRegions => 'REGIONI';

  @override
  String get routes_title => 'Analisi dei percorsi';

  @override
  String get routes_headline =>
      'Guarda come si muove il traffico nella rete mesh.';

  @override
  String get routes_body =>
      'NOTORYX Core classifica i percorsi salvati usando la cronologia già appresa da veri tentativi di messaggio e scoperte.';

  @override
  String get routes_routes => 'Percorsi';

  @override
  String get routes_success => 'Successi';

  @override
  String get routes_failed => 'Falliti';

  @override
  String get routes_routeMap => 'Mappa dei percorsi';

  @override
  String get routes_routeMapHint => 'Esamina nodi e cammini';

  @override
  String get routes_discover => 'Scopri';

  @override
  String get routes_discoverHint => 'Trova nuovi percorsi';

  @override
  String get routes_learned => 'Percorsi appresi';

  @override
  String get routes_none => 'Ancora nessuna cronologia dei percorsi';

  @override
  String get routes_noneBody =>
      'Usa normalmente la rete mesh o avvia una scoperta. NOTORYX Core mostrerà qui i percorsi appresi man mano che la cronologia diventa disponibile.';

  @override
  String get routes_direct => 'DIRETTO';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count percorsi',
      one: '1 percorso',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return 'MIGLIORE  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  peso $weight  •  $success successi / $fail fallimenti';
  }

  @override
  String routes_fastest(String ms) {
    return 'Più veloce noto: $ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'Flood: $success successi / $fail fallimenti';
  }

  @override
  String get repeaterTools_heroLabel => 'Controllo ripetitori';

  @override
  String get repeaterTools_headline =>
      'Gestisci l\'infrastruttura dietro la tua rete mesh.';

  @override
  String get repeaterTools_body =>
      'Seleziona un ripetitore scoperto per autenticarti e aprire i suoi strumenti MeshCore esistenti per stato, telemetria, vicini, impostazioni e CLI.';

  @override
  String get repeaterTools_discovered => 'Scoperti';

  @override
  String get repeaterTools_tools => 'Strumenti';

  @override
  String get repeaterTools_available => 'Ripetitori disponibili';

  @override
  String get repeaterTools_unnamed => 'Ripetitore senza nome';

  @override
  String get repeaterTools_statusTelemetry => 'Stato + telemetria';

  @override
  String get repeaterTools_statusTelemetryBody =>
      'Esamina lo stato e la telemetria del ripetitore con gli strumenti di gestione esistenti.';

  @override
  String get repeaterTools_neighbors => 'Vicini';

  @override
  String get repeaterTools_neighborsBody =>
      'Esamina l\'infrastruttura vicina e le relazioni della rete mesh.';

  @override
  String get repeaterTools_cli => 'CLI + impostazioni';

  @override
  String get repeaterTools_cliBody =>
      'Gli amministratori autenticati possono accedere alla CLI del ripetitore e agli strumenti di configurazione esistenti.';

  @override
  String get repeaterTools_empty =>
      'Nessun ripetitore ancora scoperto. Collega una radio e scopri prima la rete mesh.';

  @override
  String get notification_fieldAlertTitle => 'Avviso sul campo NOTORYX';

  @override
  String get notification_checkInReminderTitle =>
      'Promemoria check-in NOTORYX Core';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return 'Nessun check-in da $minutes minuti su $trip. Apri NOTORYX Core per fare il check-in.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return 'Nessuna notizia da $name da $minutes minuti. Non è un\'emergenza confermata.';
  }

  @override
  String get notification_aTripContact => 'Un contatto dell\'uscita';

  @override
  String notification_checkInNotDelivered(String name) {
    return 'Check-in non consegnato a $name. Puoi reinviarlo da Uscita.';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return 'SOS confermato da $name';
  }

  @override
  String get settings_batterySaver => 'Risparmio batteria';

  @override
  String get settings_batterySaverOn =>
      'Attivo: batteria della radio ogni 10 min, GPS ogni 5 min, statistiche al massimo una volta al minuto, controlli dell\'uscita ogni 1–2 min. Messaggi, avvisi e SOS restano invariati.';

  @override
  String get settings_batterySaverOff =>
      'Controlla radio e uscita meno spesso per risparmiare la batteria di telefono e radio. Messaggi, avvisi e SOS restano invariati.';

  @override
  String get settings_readAloud => 'Leggi ad alta voce i nuovi messaggi';

  @override
  String get settings_readAloudHelper =>
      'Mentre NOTORYX Core è aperto. I canali silenziati restano muti. Qualsiasi messaggio può anche essere letto dal suo menu.';

  @override
  String get settings_readAloudOff => 'Disattivato';

  @override
  String get settings_readAloudDirect => 'Messaggi diretti';

  @override
  String get settings_readAloudAll => 'Messaggi diretti e dei canali';

  @override
  String get chat_readAloud => 'Leggi ad alta voce';

  @override
  String get messageSearch_title => 'Cerca messaggi';

  @override
  String get messageSearch_intro =>
      'Cerca in tutti i messaggi diretti e dei canali salvati su questo telefono.';

  @override
  String messageSearch_noResults(String query) {
    return 'Nessun messaggio contiene «$query».';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count risultati',
      one: '1 risultato',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return 'Vengono mostrati i $count risultati più recenti';
  }

  @override
  String get shortcuts_checkIn => 'Check-in';

  @override
  String get shortcuts_trip => 'Uscita';

  @override
  String get shortcuts_chats => 'Chat';

  @override
  String get shortcuts_map => 'Mappa';

  @override
  String get sensor_liveUpdates => 'Aggiornamenti in tempo reale';

  @override
  String get sensor_intro =>
      'Fai inviare al sensore le letture da solo quando cambiano, invece di chiederle ogni volta. Richiede un accesso con permesso di lettura.';

  @override
  String get sensor_watch => 'Monitora le variazioni';

  @override
  String get sensor_loadFirst =>
      'Carica prima la telemetria per scegliere le letture.';

  @override
  String sensor_watching(String readings, String time) {
    return 'Monitoraggio di $readings fino alle $time.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return 'Monitoraggio di $readings fino alle $time • regione $region.';
  }

  @override
  String get sensor_noChanges => 'Nessuna variazione segnalata finora.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return 'Ultimo aggiornamento $time • $count ricevuti';
  }

  @override
  String get sensor_stop => 'Ferma aggiornamenti in tempo reale';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'Fermato qui; il sensore non ha confermato e si fermerà allo scadere del tempo. $error';
  }

  @override
  String get sensor_dialogBody =>
      'Il sensore controlla circa una volta al minuto e invia un aggiornamento quando una lettura scelta varia più della sua soglia.';

  @override
  String sensor_readingTitle(String label, String channel) {
    return '$label (canale $channel)';
  }

  @override
  String sensor_readingValue(String label, String channel, String value) {
    return '$label (canale $channel): $value';
  }

  @override
  String sensor_watchItem(String label, String channel, String delta) {
    return '$label (canale $channel) ±$delta';
  }

  @override
  String sensor_updateOn(String delta) {
    return 'Aggiorna con una variazione di $delta';
  }

  @override
  String get sensor_changeThreshold => 'Modifica soglia';

  @override
  String sensor_capacity(int max, String used) {
    return 'Il sensore può monitorare fino a $max byte di letture ($used usati).';
  }

  @override
  String get sensor_for => 'Per';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ore',
      one: '1 ora',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => 'Avvia';

  @override
  String sensor_thresholdTitle(String label) {
    return 'Soglia di $label';
  }

  @override
  String get sensor_typeTemperature => 'Temperatura';

  @override
  String get sensor_typeHumidity => 'Umidità';

  @override
  String get sensor_typePressure => 'Pressione';

  @override
  String get sensor_typeVoltage => 'Tensione';

  @override
  String get sensor_typeCurrent => 'Corrente';

  @override
  String get sensor_typeLight => 'Luce';

  @override
  String get sensor_typeConcentration => 'Concentrazione';

  @override
  String get sensor_typePercentage => 'Percentuale';

  @override
  String get sensor_typeAnalogInput => 'Ingresso analogico';

  @override
  String get sensor_typeAltitude => 'Altitudine';

  @override
  String get setupWizard_title => 'Collega la tua radio';

  @override
  String get setupWizard_choose => '1. Scegli una connessione';

  @override
  String get setupWizard_prepare => '2. Prepara la radio';

  @override
  String get setupWizard_intro =>
      'Scegli come questo telefono o computer si collegherà alla tua radio. La radio trasporta i messaggi sulla rete mesh.';

  @override
  String get setupWizard_bluetooth =>
      'Connessione wireless a una radio compatibile nelle vicinanze.';

  @override
  String get setupWizard_noBluetooth =>
      'Il Bluetooth non è disponibile in questo browser. Usa l\'app nativa o una connessione USB supportata.';

  @override
  String get setupWizard_usb => 'Connessione via cavo con un cavo dati USB.';

  @override
  String get setupWizard_noUsb =>
      'L\'USB seriale non è disponibile qui. Usa un\'app desktop o Android supportata, oppure Chrome con Web Serial.';

  @override
  String get setupWizard_bluetoothSteps =>
      'Accendi la radio e tienila vicina. Attiva il Bluetooth e consenti all\'app di usarlo. Chiudi le altre app collegate alla radio, poi apri l\'elenco dispositivi e avvia la ricerca.';

  @override
  String get setupWizard_usbSteps =>
      'Collega una radio accesa con un cavo dati USB; un cavo di sola ricarica non funziona. Chiudi le altre app seriali. Apri l\'elenco dispositivi USB, scegli la radio e consenti l\'accesso se richiesto.';

  @override
  String get setupWizard_firmwareTitle =>
      'Verifica la compatibilità prima di cambiare firmware';

  @override
  String get setupWizard_firmware =>
      'La tua radio necessita di firmware companion MeshCore che supporti la connessione scelta. Il supporto varia in base alla scheda e alla build del firmware; una porta USB da sola non garantisce il supporto USB seriale. Controlla le istruzioni per la tua scheda e la build installata. Il firmware ripetitore o room server non è companion. Una connessione fallita non significa di per sé che devi riflashare.';

  @override
  String get setupWizard_settings =>
      'Questa guida non flasha firmware né cambia le impostazioni radio. Dopo la connessione usa le Impostazioni per regione, frequenza e opzioni avanzate. Concorda le impostazioni con la tua rete mesh locale prima di cambiarle.';

  @override
  String get setupWizard_openBluetooth => 'Apri dispositivi Bluetooth';

  @override
  String get setupWizard_openUsb => 'Apri dispositivi USB';

  @override
  String get setupWizard_change => 'Cambia tipo di connessione';

  @override
  String get setupWizard_later => 'Configura più tardi';

  @override
  String get setupWizard_bluetoothError =>
      'Impossibile connettersi alla radio. Tienila accesa e vicina, controlla i permessi Bluetooth e chiudi le altre app collegate. Poi cerca di nuovo.';

  @override
  String get setupWizard_scanError =>
      'Impossibile cercare radio. Attiva il Bluetooth e consenti l\'accesso a Bluetooth o Dispositivi nelle vicinanze nelle impostazioni di sistema, poi riprova.';

  @override
  String get setupWizard_usbError =>
      'Impossibile connettersi via USB. Controlla il cavo dati e il dispositivo scelto, consenti l\'accesso USB e chiudi le altre app seriali. Ricollega il cavo e riprova.';

  @override
  String get connections_title => 'Connessioni';

  @override
  String get connections_radioTitle => 'Connessione radio';

  @override
  String get connections_bluetoothOffNotice =>
      'Il Bluetooth è spento. Accendilo per riconnetterti; l\'app riproverà appena torna attivo.';

  @override
  String get connections_transport => 'Trasporto';

  @override
  String connections_lastError(String error) {
    return 'Ultimo errore: $error';
  }

  @override
  String get connections_disconnectRadio => 'Disconnetti radio';

  @override
  String connections_reconnectTo(String name) {
    return 'Riconnetti a $name';
  }

  @override
  String get connections_forgetRadio => 'Dimentica radio';

  @override
  String get connections_connectAnother => 'Collega un\'altra radio';

  @override
  String get connections_usbSerial => 'USB seriale';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'Dispositivo';

  @override
  String get connections_publicKey => 'Chiave pubblica';

  @override
  String get connections_firmware => 'Firmware';

  @override
  String connections_firmwareProtocol(String code) {
    return 'protocollo v$code';
  }

  @override
  String get connections_battery => 'Batteria';

  @override
  String get connections_lastRx => 'Ultima ricezione';

  @override
  String get connections_reconnectFailed =>
      'Impossibile riconnettersi alla radio';

  @override
  String get connections_statusBluetoothOff => 'Il Bluetooth è spento';

  @override
  String get connections_statusConnected => 'Connessa';

  @override
  String get connections_statusConnecting => 'Connessione…';

  @override
  String get connections_statusDisconnecting => 'Disconnessione…';

  @override
  String get connections_statusScanning => 'Ricerca di radio…';

  @override
  String get connections_statusReconnectingSoon => 'Riconnessione a breve…';

  @override
  String get connections_statusNotConnected => 'Non connessa';

  @override
  String get mqtt_cardTitle => 'Connessione MQTT';

  @override
  String get mqtt_statusNotConfigured => 'Non configurato';

  @override
  String get mqtt_statusDisconnected => 'Disconnesso';

  @override
  String get mqtt_statusConnecting => 'Connessione';

  @override
  String get mqtt_statusConnected => 'Connesso';

  @override
  String get mqtt_statusReconnecting => 'Riconnessione';

  @override
  String get mqtt_statusError => 'Errore di connessione';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'Broker: $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn => 'Accede con un token firmato dalla radio';

  @override
  String mqtt_tokenSignInAs(String username) {
    return 'Accede con un token firmato dalla radio come $username…';
  }

  @override
  String get mqtt_connectRadioToSignIn => 'Collega la radio per accedere';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'Il token si rinnova alle $time';
  }

  @override
  String mqtt_signedInAs(String username) {
    return 'Accesso effettuato come $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return 'In ascolto su $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'Pacchetti: $accepted nuovi, $duplicate duplicati, $invalid non validi';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return 'Tentativo $attempt di $max';
  }

  @override
  String get mqtt_sharingWaitsForRadio =>
      'La condivisione attende una connessione radio';

  @override
  String mqtt_sharingOn(String topic) {
    return 'Condivisione su $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return 'Condividerà su $topic';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'Stato online su $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return 'Condivisi $shared, trattenuti $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'Aggiungi un broker per collegare il traffico MeshCore via internet. La connessione radio funziona in modo indipendente.';

  @override
  String get mqtt_disconnect => 'Disconnetti MQTT';

  @override
  String get mqtt_connect => 'Connetti MQTT';

  @override
  String get mqtt_packetFeed => 'Feed pacchetti';

  @override
  String get mqtt_setUpBroker => 'Configura broker';

  @override
  String get mqtt_brokerSettings => 'Impostazioni broker';

  @override
  String get mqtt_settingsTitle => 'Impostazioni broker MQTT';

  @override
  String get mqtt_presetLabel => 'Parti da un preset';

  @override
  String get mqtt_presetCustom => 'Broker personalizzato';

  @override
  String get mqtt_presetLocal => 'Broker locale (imposta l\'indirizzo)';

  @override
  String get mqtt_presetLetsMeshUs => 'Analizzatore LetsMesh (USA, community)';

  @override
  String get mqtt_presetLetsMeshEu => 'Analizzatore LetsMesh (UE, community)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh è un analizzatore di pacchetti MeshCore gestito dalla community, non fa parte di NOTORYX e non è approvato da NOTORYX. La condivisione richiede la radio collegata e resta disattivata finché non la attivi.';

  @override
  String get mqtt_hostname => 'Nome host del broker';

  @override
  String get mqtt_port => 'Porta';

  @override
  String get mqtt_useTls => 'Usa TLS';

  @override
  String get mqtt_allowCleartext =>
      'Consenti testo in chiaro verso un broker locale';

  @override
  String get mqtt_allowCleartextHint =>
      'Solo localhost, .local e host privati 10.x / 192.168.x.';

  @override
  String get mqtt_useWebSocket => 'Usa WebSocket';

  @override
  String get mqtt_webSocketPath => 'Percorso WebSocket';

  @override
  String get mqtt_topicPrefix => 'Prefisso topic';

  @override
  String get mqtt_region => 'Regione (facoltativa)';

  @override
  String get mqtt_regionHelp =>
      'Codice regione dell\'osservatore, ad es. PHL. Lascia vuoto per tutte.';

  @override
  String get mqtt_deliverChannel =>
      'Aggiungi i messaggi di canale ricevuti via MQTT';

  @override
  String get mqtt_deliverChannelHint =>
      'I messaggi dei tuoi canali sentiti dagli osservatori compaiono nelle tue chat. Non vengono inviati dalla tua radio.';

  @override
  String get mqtt_sharingTitle => 'Condivisione come osservatore';

  @override
  String get mqtt_share => 'Condividi i pacchetti che la mia radio sente';

  @override
  String get mqtt_shareHint =>
      'Pubblica gli annunci e il traffico di canale ricevuti dalla tua radio, con la sua chiave pubblica, la potenza del segnale e la regione. I messaggi di canale restano cifrati. Richiede una regione.';

  @override
  String get mqtt_shareDirect => 'Includi il traffico dei messaggi diretti';

  @override
  String get mqtt_shareDirectHint =>
      'Richieste, risposte e messaggi diretti. Il contenuto resta cifrato, ma mostra quali nodi comunicano tra loro.';

  @override
  String get mqtt_shareOwn => 'Includi i miei messaggi e annunci';

  @override
  String get mqtt_signInTitle => 'Accesso';

  @override
  String get mqtt_authPassword => 'Nome utente e password';

  @override
  String get mqtt_authToken => 'Token firmato dalla radio';

  @override
  String get mqtt_tokenExplain =>
      'La tua radio firma con la propria chiave un token di accesso valido un\'ora, e l\'app lo rinnova prima della scadenza. La chiave non lascia mai la radio. Il nome utente è v1_ seguito dalla chiave pubblica della radio.';

  @override
  String get mqtt_radioReady => 'Radio collegata: pronta per l\'accesso.';

  @override
  String get mqtt_radioNeeded =>
      'Collega la radio per accedere. MQTT la attende.';

  @override
  String get mqtt_username => 'Nome utente (facoltativo)';

  @override
  String get mqtt_password => 'Password';

  @override
  String get mqtt_keepPassword =>
      'Lascia vuoto per mantenere la password salvata.';

  @override
  String get mqtt_credentialsWeb =>
      'Nel browser le credenziali restano solo finché la pagina è aperta.';

  @override
  String get mqtt_credentialsKeychain =>
      'Le credenziali sono salvate nel portachiavi di sistema, mai nelle impostazioni dell\'app o nei log.';

  @override
  String get mqtt_saveSettings => 'Salva impostazioni';

  @override
  String get mqtt_feedTitle => 'Feed pacchetti MQTT';

  @override
  String get mqtt_feedConnect =>
      'Connettiti a un broker per vedere i pacchetti degli osservatori.';

  @override
  String mqtt_feedWaiting(String topic) {
    return 'In attesa di pacchetti su $topic';
  }

  @override
  String get mqtt_feedUnknownObserver => 'Osservatore sconosciuto';

  @override
  String mqtt_feedHeardBy(String observer) {
    return 'Sentito da $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return '$hops salti · $bytes byte';
  }

  @override
  String get mqtt_packetRequest => 'Richiesta';

  @override
  String get mqtt_packetResponse => 'Risposta';

  @override
  String get mqtt_packetDirectMessage => 'Messaggio diretto';

  @override
  String get mqtt_packetAck => 'Conferma';

  @override
  String get mqtt_packetAdvert => 'Annuncio';

  @override
  String get mqtt_packetChannelMessage => 'Messaggio di canale';

  @override
  String get mqtt_packetChannelData => 'Dati di canale';

  @override
  String get mqtt_packetAnonymousRequest => 'Richiesta anonima';

  @override
  String get mqtt_packetPath => 'Percorso';

  @override
  String get mqtt_packetTrace => 'Traccia';

  @override
  String get mqtt_packetMultipart => 'Multiparte';

  @override
  String get mqtt_packetControl => 'Controllo';

  @override
  String mqtt_packetType(int type) {
    return 'Tipo $type';
  }

  @override
  String get mqtt_routeTransportFlood => 'Flood con trasporto';

  @override
  String get mqtt_routeFlood => 'Flood';

  @override
  String get mqtt_routeDirect => 'Diretto';

  @override
  String get mqtt_routeTransportDirect => 'Diretto con trasporto';

  @override
  String get mqtt_noticeInvalidHost =>
      'Inserisci un nome host o un indirizzo IPv4 senza schema né porta.';

  @override
  String get mqtt_noticeInvalidPort => 'La porta deve essere tra 1 e 65535.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'Il percorso WebSocket deve iniziare con / e non contenere query o frammenti.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'Il prefisso topic deve essere un percorso MQTT non vuoto senza caratteri jolly.';

  @override
  String get mqtt_noticeInvalidRegion =>
      'La regione deve avere da 2 a 8 lettere o cifre, ad es. PHL.';

  @override
  String get mqtt_noticeTlsRequired =>
      'TLS è obbligatorio, salvo che l\'accesso non sicuro a un broker locale sia esplicitamente consentito.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      'MQTT in chiaro è consentito solo verso host locali esplicitamente approvati.';

  @override
  String get mqtt_noticeRegionNeededToShare =>
      'Imposta una regione per condividere pacchetti come osservatore.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return 'Inserisci la password per $username.';
  }

  @override
  String get mqtt_noticeNoNetwork =>
      'Nessuna connessione di rete. MQTT si riconnetterà quando tornerà.';

  @override
  String get mqtt_noticeSubscriptionRefused =>
      'Il broker ha rifiutato l\'iscrizione ai pacchetti.';

  @override
  String get mqtt_noticeBadCredentials =>
      'Il broker ha rifiutato nome utente o password.';

  @override
  String get mqtt_noticeNotAuthorized =>
      'Questo account non è autorizzato sul broker.';

  @override
  String get mqtt_noticeConnectionRefused =>
      'Il broker ha rifiutato la connessione.';

  @override
  String get mqtt_noticeUnreachable => 'Il broker non è raggiungibile.';

  @override
  String get mqtt_noticeTlsFailed =>
      'Impossibile stabilire la connessione sicura (TLS).';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'Questa piattaforma supporta MQTT solo tramite WebSocket.';

  @override
  String get mqtt_noticeRadioNotConnected =>
      'Collega la radio per accedere con la sua chiave.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'Il firmware di questa radio non supporta la firma con la sua chiave.';

  @override
  String get mqtt_noticeSigningTimeout =>
      'La radio non ha risposto alla richiesta di firma. Il suo firmware potrebbe non supportare la firma.';

  @override
  String get mqtt_noticeSigningTooLong =>
      'I dati sono troppo lunghi per essere firmati dalla radio.';

  @override
  String get mqtt_noticeSigningRejected =>
      'La radio ha rifiutato di firmare i dati.';

  @override
  String get scanner_signalStrong => 'Forte';

  @override
  String get scanner_signalGood => 'Buono';

  @override
  String get scanner_signalFair => 'Discreto';

  @override
  String get scanner_signalWeak => 'Debole';

  @override
  String get scanner_nearbyRadios => 'Radio nelle vicinanze';

  @override
  String get scanner_lastRadio => 'Ultima radio';

  @override
  String get scanner_reconnect => 'Riconnetti';

  @override
  String get scanner_tcpHint => 'Una radio con firmware Wi‑Fi sulla tua rete.';

  @override
  String get scanner_otherWays => 'Altri modi per connettersi';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count radio nelle vicinanze',
      one: '1 radio nelle vicinanze',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => 'Ricerca radio…';

  @override
  String get scanner_findTitle => 'Trova la tua radio';

  @override
  String get scanner_heroHint =>
      'Accendi la radio e tienila a pochi metri. Serve il firmware MeshCore companion.';

  @override
  String get scanner_tipsTitle => 'Non vedi la tua radio?';

  @override
  String get scanner_tipPower => 'Controlla che sia accesa e attiva.';

  @override
  String get scanner_tipFirmware =>
      'Serve il firmware MeshCore companion. Ripetitori e room server non compaiono qui.';

  @override
  String get scanner_tipOtherDevice =>
      'Una radio si collega a un solo dispositivo alla volta. Scollegala da altri telefoni o computer.';

  @override
  String get connections_internetBridge => 'Ponte Internet';

  @override
  String get connections_noRadio => 'Nessuna radio';

  @override
  String get connections_radioSettings => 'Impostazioni radio';

  @override
  String get connections_viewDashboard => 'Apri il pannello connessioni';

  @override
  String get channelDirectory_title => 'Elenco canali';

  @override
  String get channelDirectory_subtitle =>
      'Trova canali hashtag pubblici vicino a te';

  @override
  String get channelDirectory_search => 'Cerca canali o luoghi';

  @override
  String get channelDirectory_nearYou => 'Vicino a te';

  @override
  String get channelDirectory_all => 'Tutti i canali';

  @override
  String get channelDirectory_catAll => 'Tutti';

  @override
  String get channelDirectory_catEmergency => 'Emergenza';

  @override
  String get channelDirectory_catLocal => 'Locali';

  @override
  String get channelDirectory_catGeneral => 'Generali';

  @override
  String get channelDirectory_catInterest => 'Interessi';

  @override
  String get channelDirectory_catTest => 'Test';

  @override
  String get channelDirectory_join => 'Unisciti';

  @override
  String get channelDirectory_joined => 'Unito';

  @override
  String get channelDirectory_noMatches =>
      'Nessun canale corrisponde alla ricerca.';

  @override
  String get channelDirectory_connectFirst =>
      'Collega la radio per unirti ai canali.';

  @override
  String get channelDirectory_slotsFull =>
      'Tutti gli slot canale della radio sono occupati. Rimuovi prima un canale.';

  @override
  String get channelDirectory_joinFailed =>
      'Impossibile aggiungere il canale. Riprova.';

  @override
  String get channelDirectory_addHint =>
      'Manca un canale? Chiunque può suggerirlo modificando l’elenco condiviso su GitHub.';

  @override
  String get prefixTool_title => 'ID dei ripetitori';

  @override
  String get prefixTool_subtitle =>
      'Chi usa un ID, quali ID coincidono e ID liberi per un nuovo ripetitore';

  @override
  String get prefixTool_width => 'Dimensione ID percorso';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes byte';
  }

  @override
  String get prefixTool_includeCompanions => 'Includi companion e sensori';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return '$nodes nodi noti · $used ID in uso · $shared condivisi';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return '$free ID liberi su $space';
  }

  @override
  String get prefixTool_lookupHint => 'Cerca un ID, es. 3D';

  @override
  String prefixTool_lookupFree(String id) {
    return 'Nessun nodo noto usa $id.';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nodi usano $id',
      one: '1 nodo usa $id',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => 'ID condivisi';

  @override
  String get prefixTool_sharedHint =>
      'I percorsi tramite questi ID sembrano uguali, a meno che la rete usi ID più lunghi.';

  @override
  String get prefixTool_noShared => 'Nessun ID condiviso tra i nodi noti.';

  @override
  String get prefixTool_free => 'ID liberi';

  @override
  String get prefixTool_shuffle => 'Altri suggerimenti';

  @override
  String get prefixTool_makeKey => 'Crea una chiave';

  @override
  String get prefixTool_onlyKnown =>
      'Solo in base ai nodi sentiti dalla radio. Un ID libero qui potrebbe appartenere a un ripetitore che non hai sentito.';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id è già usato da $name.';
  }

  @override
  String get prefixTool_pickFree => 'Scegli un ID libero';

  @override
  String keyGen_title(String id) {
    return 'Chiave per l’ID $id';
  }

  @override
  String keyGen_searching(int tries) {
    return 'Ricerca… $tries chiavi provate';
  }

  @override
  String get keyGen_publicKey => 'Chiave pubblica';

  @override
  String get keyGen_privateKey => 'Chiave privata';

  @override
  String get keyGen_copy => 'Copia';

  @override
  String get keyGen_copied => 'Copiato';

  @override
  String get keyGen_secretWarning =>
      'Tieni segreta la chiave privata. Chi la possiede può spacciarsi per questo nodo.';

  @override
  String get keyGen_howToUse =>
      'Per un ripetitore: apri le sue impostazioni, incollala come chiave privata e salva. Le radio companion richiedono firmware che consenta l’importazione delle chiavi.';

  @override
  String get keyGen_tryAgain => 'Creane un’altra';

  @override
  String get regionSetup_title => 'Configura regioni';

  @override
  String get regionSetup_hubSubtitle =>
      'Inserisci questo ripetitore nell’albero delle regioni della tua zona';

  @override
  String get regionSetup_intro =>
      'Le regioni mantengono un messaggio in un’area invece di inondare tutta la rete. Un ripetitore inoltra i messaggi di una regione solo se la possiede: assegnagli la sua regione e tutte quelle superiori.';

  @override
  String get regionSetup_where => 'Dove si trova il ripetitore?';

  @override
  String get regionSetup_tree => 'Albero delle regioni';

  @override
  String get regionSetup_custom => 'Personalizzato';

  @override
  String get regionSetup_region => 'Regione più locale';

  @override
  String get regionSetup_customLabel => 'Regioni, dalla più ampia';

  @override
  String regionSetup_invalidName(String name) {
    return '\"$name\" non è un nome di regione valido. Usa minuscole, cifre e trattini, massimo 29 caratteri.';
  }

  @override
  String regionSetup_tooMany(int max) {
    return 'Un ripetitore può avere al massimo $max regioni.';
  }

  @override
  String get regionSetup_options => 'Opzioni';

  @override
  String get regionSetup_setDefault =>
      'Usa la regione più locale come predefinita';

  @override
  String get regionSetup_setDefaultBody =>
      'Gli annunci del ripetitore restano in quella regione.';

  @override
  String get regionSetup_legacy => 'Firmware 1.14';

  @override
  String get regionSetup_legacyBody =>
      'Aggiunge region allowf dopo ogni regione. Non serve dalla 1.15.';

  @override
  String get regionSetup_denyUnscoped => 'Non inoltrare messaggi senza regione';

  @override
  String get regionSetup_denyUnscopedBody =>
      'Attivalo solo quando tutta la zona usa le regioni, altrimenti i messaggi delle app più vecchie non passano.';

  @override
  String get regionSetup_commands => 'Comandi';

  @override
  String get regionSetup_copyAll => 'Copia tutto';

  @override
  String get regionSetup_copied => 'Copiato';

  @override
  String get regionSetup_pickFirst =>
      'Scegli una regione per vedere i comandi.';

  @override
  String regionSetup_sendTo(String name) {
    return 'Invia a $name';
  }

  @override
  String get regionSetup_howToSend =>
      'Per inviarli, accedi al ripetitore e apri Configura regioni dal suo menu, oppure incollali nella sua riga di comando.';

  @override
  String get regionSetup_noReply => 'Nessuna risposta. Interrotto qui.';

  @override
  String get regionSetup_addToMine => 'Aggiungi queste regioni al mio elenco';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count regioni aggiunte al tuo elenco',
      one: '1 regione aggiunta al tuo elenco',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => 'Registro percorso';

  @override
  String get trackLog_subtitle => 'Registra una traccia dal GPS della radio';

  @override
  String get trackLog_recording => 'Registrazione in corso';

  @override
  String get trackLog_notRecording => 'Nessuna registrazione';

  @override
  String get trackLog_noGps =>
      'La radio non fornisce una posizione GPS. Il registro percorso richiede una radio con GPS attivo.';

  @override
  String get trackLog_start => 'Avvia registrazione';

  @override
  String get trackLog_stop => 'Ferma registrazione';

  @override
  String get trackLog_howItWorks =>
      'Usa la posizione fornita dalla radio, circa una volta al minuto, mentre NOTORYX Core è aperta. Un punto viene aggiunto dopo 25 m di spostamento, oppure ogni 15 minuti se resti fermo.';

  @override
  String get trackLog_snap => 'Arrotonda le posizioni a circa 100 m';

  @override
  String get trackLog_snapBody =>
      'Per la privacy quando condividi un percorso.';

  @override
  String get trackLog_saved => 'Percorsi salvati';

  @override
  String get trackLog_none => 'Ancora nessun percorso.';

  @override
  String get trackLog_export => 'Esporta come GPX';

  @override
  String get trackLog_exportFailed => 'Impossibile esportare il percorso.';

  @override
  String get trackLog_deleteTitle => 'Eliminare questo percorso?';

  @override
  String get trackLog_deleteBody =>
      'Viene rimosso da questo dispositivo. I file GPX esportati non cambiano.';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km km · $duration · $points punti';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'Percorso NOTORYX $when';
  }

  @override
  String get routes_nearbyTitle => 'Migliori ripetitori vicini';

  @override
  String get routes_nearbyEmptyTitle => 'Nessun ripetitore sentito finora';

  @override
  String get routes_nearbyEmpty =>
      'I ripetitori che la radio sente direttamente compaiono qui, i più forti per primi, man mano che riceve traffico. L’elenco copre l’ultima ora.';

  @override
  String get routes_unknownRepeater => 'Ripetitore sconosciuto';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sentito $count volte',
      one: 'sentito una volta',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes min fa',
      one: '1 min fa',
      zero: 'proprio ora',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return 'tramite $names';
  }

  @override
  String get nav_home => 'Home';

  @override
  String get nav_chats => 'Chat';

  @override
  String get nav_tools => 'Strumenti';

  @override
  String get nav_settings => 'Impostazioni';

  @override
  String get nav_more => 'Altro';

  @override
  String get tools_groupApp => 'App e impostazioni';

  @override
  String get tools_groupField => 'Sul campo';

  @override
  String get tools_groupMaps => 'Mappe e copertura';

  @override
  String get tools_groupRouting => 'Percorsi e ripetitori';

  @override
  String get tools_pathGraph => 'Grafo dei percorsi';

  @override
  String get tools_pathGraphHint =>
      'Come ti arrivano i messaggi: ogni percorso ascoltato, con i ripetitori più attivi';

  @override
  String get tools_antenna => 'Copertura antenna';

  @override
  String get tools_antennaHint =>
      'Stima fin dove arriva un’antenna sul terreno';

  @override
  String routes_repeaterWithId(String id) {
    return 'Ripetitore $id';
  }

  @override
  String get coverageHex_title => 'Esagoni di copertura';

  @override
  String get coverageHex_toolSubtitle =>
      'Mappa dove la tua radio sente la rete e condividilo';

  @override
  String get coverageHex_mapCoverage => 'Mappa copertura';

  @override
  String get coverageHex_statusOff =>
      'Spento. Attivalo mentre guidi o cammini per mappare dove la radio sente la rete.';

  @override
  String get coverageHex_waitingGps => 'In attesa del GPS…';

  @override
  String coverageHex_gpsTooRough(String meters) {
    return 'Precisione GPS $meters m: troppo imprecisa, non registro.';
  }

  @override
  String coverageHex_recording(String meters) {
    return 'Registrazione. Precisione GPS $meters m.';
  }

  @override
  String get coverageHex_hexagons => 'Esagoni';

  @override
  String get coverageHex_samples => 'Campioni';

  @override
  String get coverageHex_privacyNote =>
      'Usa il GPS del telefono mentre questo interruttore è attivo. Si condividono solo gli ID degli esagoni (circa 0,9 km), mai la tua posizione esatta.';

  @override
  String get coverageHex_uploadSection => 'Carica sulle mappe di copertura';

  @override
  String get coverageHex_wifiOnly => 'Carica solo con Wi-Fi';

  @override
  String get coverageHex_wifiOnlyHint =>
      'I campioni attendono sul telefono (fino a 7 giorni) il Wi-Fi.';

  @override
  String coverageHex_waiting(String count) {
    return '$count in attesa';
  }

  @override
  String get coverageHex_addMap => 'Aggiungi una mappa di copertura';

  @override
  String get coverageHex_addMapHint =>
      'Qualsiasi endpoint HTTPS che accetta dati di copertura.';

  @override
  String get coverageHex_uploadNow => 'Carica ora';

  @override
  String get coverageHex_mapDialogTitle => 'Mappa di copertura';

  @override
  String get coverageHex_nameMissing => 'Dagli un nome.';

  @override
  String get coverageHex_url => 'URL di caricamento';

  @override
  String get coverageHex_urlInvalid => 'Deve essere un URL https://.';

  @override
  String get coverageHex_apiKey => 'Chiave API (facoltativa)';

  @override
  String get coverageHex_apiKeyHint => 'Inviata come X-API-Key.';

  @override
  String get coverageHex_format => 'Formato';

  @override
  String get coverageHex_formatHex => 'ID degli esagoni (NOTORYX)';

  @override
  String get coverageHex_formatMeshMapper => 'Compatibile con MeshMapper';

  @override
  String get coverageHex_privacy => 'Privacy';

  @override
  String get coverageHex_privacyLive => 'In diretta';

  @override
  String get coverageHex_privacyDelayed => 'Ritardato di 3 h';

  @override
  String get coverageHex_privacyAnonymous => 'Anonimo, 24 h';

  @override
  String get coverageHex_privacyLiveHint => 'Inviato entro circa 15 minuti.';

  @override
  String get coverageHex_privacyDelayedHint =>
      'Trattenuto 3 ore perché la mappa non mostri dove sei ora.';

  @override
  String get coverageHex_privacyAnonymousHint =>
      'Trattenuto 24 ore, solo con la data e senza firma, così i caricamenti non sono collegabili.';

  @override
  String get coverageHex_uploadsOn => 'Caricamenti attivi';

  @override
  String coverageHex_sent(String count, String time) {
    return 'Inviate $count celle alle $time.';
  }

  @override
  String coverageHex_httpError(String code) {
    return 'La mappa ha risposto $code; riproverà.';
  }

  @override
  String get coverageHex_unreachable => 'Mappa non raggiungibile; riproverà.';

  @override
  String get coverageHex_noPermission =>
      'Il permesso di posizione non è stato concesso.';

  @override
  String get coverageHex_noGps => 'Il GPS non è disponibile.';

  @override
  String get coverageHex_loadFailed =>
      'Copertura salvata illeggibile; si riparte da zero.';

  @override
  String get mqttExtra_wifiOnly => 'Connetti solo con Wi-Fi';

  @override
  String mqttExtra_backlog(String count) {
    return '$count pacchetti in attesa di caricamento (conservati fino a 72 ore).';
  }

  @override
  String get mqttExtra_add => 'Aggiungi un altro broker';

  @override
  String get mqttExtra_addBody =>
      'Condivide ciò che sente la radio con un altro broker MQTT oltre al principale. Carica soltanto; non rimanda mai pacchetti nell’app.';

  @override
  String get mqttExtra_separateKey => 'Usa una chiave separata';

  @override
  String get mqttExtra_separateKeyHint =>
      'Accede con una chiave creata su questo telefono invece di quella della radio, così il broker non può collegare i caricamenti alla radio.';

  @override
  String mqttExtra_removeTitle(String name) {
    return 'Rimuovere $name?';
  }

  @override
  String get mqttExtra_removeBody =>
      'Disconnette e dimentica impostazioni, password, chiave e pacchetti in attesa.';

  @override
  String mqttExtra_ownKey(String key) {
    return 'Accede con la propria chiave: $key…';
  }

  @override
  String get botWx_title => 'Pubblica allerte meteo in un canale';

  @override
  String get botWx_body =>
      'Controlla ogni 10 minuti il National Weather Service statunitense per avvisi gravi ed estremi nella posizione GPS della radio (arrotondata a circa 1 km) e pubblica ogni nuovo una volta. Serve internet sul telefono.';

  @override
  String get botWx_channel => 'Pubblica nel canale';

  @override
  String get botWx_moderate => 'Includi allerte moderate';

  @override
  String get botWx_moderateHint => 'Avvisi oltre alle allerte. Più messaggi.';

  @override
  String botWx_lastChecked(String time) {
    return 'Ultimo controllo $time.';
  }

  @override
  String get botWx_noPosition =>
      'La radio non ha ancora fornito una posizione GPS.';

  @override
  String get botWx_noChannel => 'Scegli un canale per le allerte.';

  @override
  String get botWx_channelGone => 'Il canale scelto non esiste più.';

  @override
  String botWx_httpError(String code) {
    return 'Il servizio meteo ha risposto $code.';
  }

  @override
  String get botWx_unreachable => 'Servizio meteo non raggiungibile.';

  @override
  String get botCmd_sun => 'Alba e tramonto nella posizione GPS della radio.';

  @override
  String get botCmd_moon => 'Fase lunare e quanto è illuminata.';

  @override
  String get botCmd_weather =>
      'Meteo attuale alla radio (Open-Meteo). Invia la posizione arrotondata a circa 1 km.';

  @override
  String get botCmd_dice => 'Tira dadi: !dice, !dice 20 o !dice 2d6.';

  @override
  String get botCmd_trace =>
      'Elenca i ripetitori attraverso cui è passato il messaggio.';

  @override
  String get ping_title => 'Ping ripetitore';

  @override
  String get ping_toolSubtitle =>
      'Tempo di andata e ritorno e segnale nei due sensi verso un ripetitore vicino';

  @override
  String get ping_noRepeaters => 'Nessun ripetitore noto';

  @override
  String get ping_choose => 'Scegli un ripetitore';

  @override
  String get ping_avgMs => 'ms andata e ritorno';

  @override
  String get ping_snrThere => 'SNR là';

  @override
  String get ping_snrBack => 'SNR ritorno';

  @override
  String get ping_loss => 'Persi';

  @override
  String ping_running(int done, int total) {
    return 'Ping $done di $total…';
  }

  @override
  String ping_start(int count) {
    return 'Ping $count volte';
  }

  @override
  String get ping_results => 'Sonde';

  @override
  String get ping_noReply => 'Nessuna risposta';

  @override
  String ping_resultLine(String ms, String snr) {
    return '$ms ms · SNR là $snr';
  }

  @override
  String get ping_explainer =>
      'Ogni sonda è un tracciamento a un salto: il ripetitore annota quanto bene ti ha sentito e lo rimanda. Funziona con i ripetitori che la radio sente direttamente.';

  @override
  String get hunt_title => 'Ricerca antenna';

  @override
  String get hunt_toolSubtitle =>
      'Grande indicatore di segnale che ticchetta più veloce quando migliora';

  @override
  String get hunt_noSignal => 'Ancora nessun segnale';

  @override
  String get hunt_noReply => 'Nessuna risposta: sposta o ruota l’antenna';

  @override
  String get hunt_heardHere => 'dB ricevuti qui';

  @override
  String get hunt_best => 'Migliore';

  @override
  String get hunt_sound => 'Clic quando il segnale migliora';

  @override
  String get hunt_soundHint =>
      'Con una vibrazione a ogni clic, per orientare senza guardare.';

  @override
  String get hunt_stop => 'Ferma';

  @override
  String get hunt_start => 'Avvia ricerca';

  @override
  String get hunt_explainer =>
      'Sonda il ripetitore circa una volta al secondo. Orienta un’antenna direttiva o muoviti: il numero indica quanto bene la radio lo sente.';

  @override
  String get settings_refreshRate => 'Frequenza di aggiornamento';

  @override
  String get settings_refreshFast => 'Veloce';

  @override
  String get settings_refreshNormal => 'Normale';

  @override
  String get settings_refreshSlow => 'Lenta';

  @override
  String get settings_refreshFastHint =>
      'Batteria ogni minuto, GPS ogni 30 s. Dati più freschi, più consumo.';

  @override
  String get settings_refreshNormalHint =>
      'Batteria ogni 2 minuti, GPS ogni minuto.';

  @override
  String get settings_refreshSlowHint =>
      'Batteria ogni 6 minuti, GPS ogni 3. Risparmia batteria.';

  @override
  String get settings_refreshSaverOn =>
      'Il risparmio batteria è attivo e detta il ritmo (batteria ogni 10 minuti).';

  @override
  String get reach_check => 'Controlla portata osservatori';

  @override
  String get reach_title => 'Portata osservatori';

  @override
  String get reach_noHash =>
      'Questo messaggio non è ancora consultabile: nessun ripetitore l’ha rimandato alla tua radio, quindi l’ID del pacchetto non è noto.';

  @override
  String get reach_unreachable =>
      'Analizzatore non raggiungibile. Controlla la connessione o l’indirizzo dell’analizzatore nelle impostazioni.';

  @override
  String get reach_none =>
      'Nessun osservatore l’ha ancora sentito. Gli osservatori caricano poco dopo, ricontrolla tra un minuto.';

  @override
  String get reach_observers => 'osservatori';

  @override
  String get reach_maxHops => 'salti max';

  @override
  String get reach_bestSnr => 'SNR migliore';

  @override
  String reach_hops(int count) {
    return 'a $count salti';
  }

  @override
  String get reach_explainer =>
      'Dall’analizzatore online: osservatori che hanno sentito e caricato questo pacchetto.';

  @override
  String get reach_checkAgain => 'Ricontrolla';

  @override
  String get analyzer_title => 'Analizzatore online';

  @override
  String get analyzer_url => 'Indirizzo analizzatore';

  @override
  String get analyzer_urlHint =>
      'Un analizzatore CoreScope (https://). Usa quello della tua regione.';

  @override
  String get analyzer_reset => 'Predefinito';

  @override
  String get analyzer_hint =>
      'Serve a controllare quali osservatori hanno sentito i tuoi messaggi. Invia solo l’ID del pacchetto.';

  @override
  String get analyzer_hopLookup => 'Nomina online i ripetitori sconosciuti';

  @override
  String get analyzer_hopLookupHint =>
      'Se un ID di ripetitore non è nei contatti, se ne chiede il nome all’analizzatore. Si inviano solo gli ID brevi. Un nome con «?» indica che più ripetitori condividono l’ID.';

  @override
  String discovered_tray(int count) {
    return 'Canali sentiti nelle vicinanze: $count';
  }

  @override
  String get discovered_title => 'Sentiti vicino, non uniti';

  @override
  String discovered_heard(int count, String time) {
    return 'Sentito $count× · ultimo $time';
  }

  @override
  String get discovered_ignore => 'Ignora';

  @override
  String get discovered_ignoreAll => 'Ignora tutti';

  @override
  String get discovered_joinAll => 'Unisciti a tutti';

  @override
  String get discovered_explainer =>
      'Sono canali pubblici dell’elenco su cui la radio ha sentito traffico. Ognuno è confermato decifrando un messaggio con la sua chiave. Quelli ignorati restano nascosti.';

  @override
  String get mqtt_presetMeshRank => 'MeshRank (comunità)';

  @override
  String get mqtt_presetMeshRankNote =>
      'MeshRank è una classifica comunitaria delle reti MeshCore, non fa parte di NOTORYX e non è approvata da esso. Senza accesso: i pacchetti sono condivisi con la chiave e il codice regione della radio, solo dopo aver attivato la condivisione.';

  @override
  String get pathFilter_title => 'Filtro larghezza percorso';

  @override
  String get pathFilter_firmwareNote =>
      'Richiede un firmware del ripetitore con regole di inoltro (mikecarper/MeshCore). Il firmware ufficiale MeshCore rifiuta questi comandi.';

  @override
  String get pathFilter_width => 'Larghezza percorso';

  @override
  String get pathFilter_anyWidth => 'Qualsiasi larghezza';

  @override
  String pathFilter_bytes(int n) {
    return 'Percorsi da $n byte';
  }

  @override
  String get pathFilter_twoOrMore => '2 o 3 byte (2+)';

  @override
  String get pathFilter_path => 'Si applica a';

  @override
  String get pathFilter_radio => 'Flood radio';

  @override
  String get pathFilter_bridge => 'Bridge';

  @override
  String get pathFilter_cross => 'Incrocio';

  @override
  String get pathFilter_bridgeCross => 'Bridge e incrocio';

  @override
  String get pathFilter_limit => 'Limita invece di scartare';

  @override
  String get pathFilter_limitOn => 'Inoltra fino a un numero fisso al minuto.';

  @override
  String get pathFilter_drop => 'I flood corrispondenti vengono scartati.';

  @override
  String get pathFilter_perMinute => 'Al minuto';

  @override
  String get pathFilter_rateInvalid => 'Inserisci da 1 a 65534.';

  @override
  String get pathFilter_reviewNote =>
      'Compila solo la riga di comando. Controllala, poi premi Invia. Usa prima «get fr» per vedere le regole.';

  @override
  String get pathFilter_useCommand => 'Usa comando';

  @override
  String get settings_linkPreviews => 'Anteprime dei link';

  @override
  String get settings_linkPreviewsHint =>
      'Mostra il titolo di un link in un messaggio. Disattivato di default: caricare la pagina rivela il tuo IP al sito.';

  @override
  String get guide_title => 'Guida da campo';

  @override
  String get guide_subtitle => 'Basi, batterie al freddo, solare e antenne';

  @override
  String get guide_secMesh => 'Entrare nella rete';

  @override
  String get guide_mesh1 =>
      'Il telefono parla con la radio via Bluetooth, USB o Wi-Fi; la radio parla con la rete via LoRa. I messaggi funzionano anche senza campo.';

  @override
  String get guide_mesh2 =>
      'I ripetitori inoltrano i messaggi; ogni inoltro è un salto. Meno salti, consegna più rapida e affidabile.';

  @override
  String get guide_mesh3 =>
      'Messaggi brevi e niente flood sui canali affollati: ogni messaggio usa tempo d’aria condiviso.';

  @override
  String get guide_secCold => 'Batterie al freddo';

  @override
  String get guide_cold1 =>
      'Non caricare batterie al litio sotto zero (0 °C): si danneggiano per sempre.';

  @override
  String get guide_cold2 =>
      'Tieni la radio dentro la giacca. Il freddo riduce la capacità, che torna quando la batteria si scalda.';

  @override
  String get guide_cold3 =>
      'Per siti fissi in climi freddi, le LiFePO4 resistono meglio delle litio-ione; una scatola isolata o riscaldata aiuta entrambe.';

  @override
  String get guide_secSolar => 'Solare per ripetitori';

  @override
  String get guide_solar1 =>
      'Un ripetitore consuma pochissimo, ma dimensiona pannello e batteria per la settimana invernale più buia, non per un giorno estivo.';

  @override
  String get guide_solar2 =>
      'Orienta il pannello verso l’equatore, molto inclinato d’inverno; tienilo libero da neve e ombra.';

  @override
  String get guide_secAntenna => 'Antenne e posizionamento';

  @override
  String get guide_ant1 =>
      'L’altezza conta più della potenza: una radio a qualche metro arriva molto più lontano di una sulla scrivania.';

  @override
  String get guide_ant2 =>
      'Tieni l’antenna verticale e lontana dal metallo, e usane una per la tua banda (per esempio 868 MHz in Europa).';

  @override
  String get guide_secMore => 'Scopri di più';

  @override
  String get guide_moreMeshcore => 'Il progetto ufficiale MeshCore';

  @override
  String get guide_moreCascadia =>
      'Guide della comunità: primi passi, wardriving, regioni, solare';

  @override
  String get post_signed => 'Firmato';

  @override
  String get post_unverified => 'Non verificato';

  @override
  String post_signedKnown(String name) {
    return 'Firmato da $name, uno dei tuoi contatti.';
  }

  @override
  String get post_signedUnknownKey =>
      'Firmato, ma non da uno dei tuoi contatti. Aggiungi il mittente ai contatti per sapere chi è.';

  @override
  String get post_unverifiedHint =>
      'Con questo messaggio è arrivata una firma che non corrisponde. Potrebbe essere stato modificato lungo il percorso o non provenire da chi dice.';

  @override
  String get settings_signPosts => 'Firma tutti i miei messaggi nei canali';

  @override
  String get settings_signPostsHint =>
      'Un SOS su un canale è sempre firmato. Così ogni messaggio viene firmato e gli altri utenti NOTORYX sanno che sei davvero tu. Ogni firma è un pacchetto in più in onda.';

  @override
  String get tools_search => 'Cerca strumenti e impostazioni';

  @override
  String get tools_noMatches => 'Nessuno strumento corrisponde alla ricerca.';

  @override
  String get tools_bot => 'Modalità bot';

  @override
  String get tools_botHint =>
      'Risposte automatiche, !comandi e allerte meteo nei canali';

  @override
  String get botChannels_title => 'Canali';

  @override
  String get botChannels_hint =>
      'Il bot risponde ai !comandi anche nei canali attivati, nello stesso canale. Lì non invia mai risposte di assenza.';

  @override
  String get botChannels_none => 'Nessun canale su questa radio.';

  @override
  String get advert_zeroHopHint =>
      'Solo le radio che ti sentono direttamente. I ripetitori non lo inoltrano.';

  @override
  String get advert_floodHint =>
      'I ripetitori lo diffondono in tutta la mesh. Usa più tempo di trasmissione.';

  @override
  String get radioPresets_custom => 'Personalizzato';

  @override
  String get radioPresets_search => 'Cerca preimpostazioni';

  @override
  String get radioPresets_suggested => 'Suggerito per la tua regione';

  @override
  String get radioPresets_community => 'Preimpostazioni della comunità';

  @override
  String get radioPresets_hint =>
      'Sono le preimpostazioni suggerite dalla comunità MeshCore. Scegli quella della tua mesh locale. Imposta frequenza, larghezza di banda, fattore di spreading e coding rate; la potenza di trasmissione resta invariata.';

  @override
  String get mySensors_title => 'Sensori';

  @override
  String get mySensors_refresh => 'Leggi sensori';

  @override
  String get mySensors_reading => 'Lettura dei sensori della radio…';

  @override
  String get mySensors_failed =>
      'La radio non ha risposto. Tocca aggiorna per riprovare.';

  @override
  String get mySensors_none => 'Nessuna lettura dai sensori della radio.';

  @override
  String get activeChannels_title => 'Attivi online';

  @override
  String activeChannels_messages(int count) {
    return '$count messaggi';
  }

  @override
  String activeChannels_source(String host) {
    return 'Canali in uso, secondo gli osservatori di $host. Cambia analizzatore nelle impostazioni per la tua zona.';
  }

  @override
  String get fieldOps_checkInChannelLabel => 'Check-in anche sul canale';

  @override
  String get fieldOps_checkInChannelHint =>
      'Firmato con la chiave della radio, così gli altri sul canale vedono che sei davvero tu. I contatti del viaggio lo ricevono comunque direttamente.';

  @override
  String get channels_regionUnknown => 'Regionale';

  @override
  String channels_regionSemantics(String region) {
    return 'Inviato alla regione $region';
  }

  @override
  String get channels_regionUnknownSemantics =>
      'Inviato a una regione sconosciuta all’app';

  @override
  String get wardrive_title => 'Wardrive';

  @override
  String get wardrive_hint =>
      'Fai ping da dove sei e mappa quali ripetitori ti sentono';

  @override
  String get wardrive_start => 'Avvia';

  @override
  String get wardrive_stop => 'Ferma';

  @override
  String get wardrive_pings => 'ping';

  @override
  String get wardrive_heard => 'sentiti';

  @override
  String get wardrive_pinging => 'Ping in corso…';

  @override
  String get wardrive_waitPosition =>
      'In attesa della posizione GPS del telefono o della radio.';

  @override
  String get wardrive_waitRadio => 'Collega una radio per fare ping.';

  @override
  String get wardrive_history => 'Cronologia';

  @override
  String get wardrive_noSessions => 'Nessun percorso ancora.';

  @override
  String wardrive_sessionSummary(int pings, int heard) {
    return '$pings ping · $heard sentiti';
  }

  @override
  String get wardrive_delete => 'Elimina';

  @override
  String get wardrive_recentre => 'Torna alla mia posizione';

  @override
  String get wardrive_youAreHere => 'Sei qui';

  @override
  String get wardrive_backToLive => 'Torna al percorso attuale';

  @override
  String get wardrive_noReplies => 'Nessun ripetitore ha sentito questo ping.';

  @override
  String wardrive_replyDetail(String there, String here) {
    return 'Ti ha sentito a $there dB · lo hai sentito a $here dB';
  }

  @override
  String get wardrive_explainer =>
      'Ogni ping è una richiesta di scoperta a zero salti: rispondono solo i ripetitori a portata diretta e nulla viene pubblicato su un canale. Le posizioni vengono dal GPS del telefono o, se manca, della radio.';

  @override
  String get mapTelemetry_policy =>
      'Le letture salvate si attenuano dopo 1 ora e scompaiono dopo 24 ore. Aggiorna invia una richiesta; il nodo deve consentire la telemetria e i sensori possono richiedere l’accesso. La mappa non richiede mai aggiornamenti automatici.';

  @override
  String get autoConnect_title => 'Connetti automaticamente alla mia radio';

  @override
  String get autoConnect_hint =>
      'All’apertura dell’app si riconnette all’ultima radio senza toccare. Riprova alcune volte se non è ancora a portata.';

  @override
  String get networks_title => 'Reti';

  @override
  String get networks_hint => 'Cerca le reti vicine e tienine un registro';

  @override
  String get networks_yourNetwork => 'La tua rete';

  @override
  String get networks_scanTitle => 'Cerca reti';

  @override
  String get networks_scanExplainer =>
      'La radio sente solo le reti con le sue stesse impostazioni, quindi la ricerca la passa a turno su ciascuna, ascolta e poi la riporta indietro. Durante la ricerca sei fuori dalla tua rete.';

  @override
  String get networks_listenFor => 'Ascolto per rete';

  @override
  String networks_choose(int count) {
    return 'Reti da cercare: $count';
  }

  @override
  String get networks_suggested => 'Suggerite';

  @override
  String get networks_start => 'Avvia ricerca';

  @override
  String get networks_cancel => 'Ferma ricerca';

  @override
  String networks_listening(String name, int step, int steps) {
    return 'In ascolto su $name ($step di $steps)';
  }

  @override
  String get networks_blockNoRadio => 'Collega una radio per cercare.';

  @override
  String get networks_blockSettings =>
      'In attesa delle impostazioni della radio.';

  @override
  String get networks_blockSos =>
      'Non con un SOS attivo: la ricerca ti porta fuori dalla rete.';

  @override
  String get networks_blockTrip =>
      'Non durante un\'uscita: la ricerca ti porta fuori dalla rete.';

  @override
  String get networks_nearby => 'Reti vicine';

  @override
  String get networks_nothingYet =>
      'Nessuna rete sentita finora. Avvia una ricerca.';

  @override
  String networks_heardSummary(int nodes, int packets, String snr) {
    return 'Nodi $nodes · pacchetti $packets · SNR $snr dB';
  }

  @override
  String networks_lastHeard(String time) {
    return 'Sentita l\'ultima volta $time';
  }

  @override
  String networks_timesHeard(int count) {
    return 'Volte sentita: $count';
  }

  @override
  String get networks_saved => 'Reti salvate';

  @override
  String get networks_noSaved => 'Nessuna rete salvata.';

  @override
  String get networks_add => 'Aggiungi una rete';

  @override
  String get networks_join => 'Unisciti';

  @override
  String networks_joinConfirm(String name) {
    return 'Passare la radio su $name? Lascerai la rete attuale. La potenza di trasmissione resta la stessa.';
  }

  @override
  String networks_joined(String name) {
    return 'Ora la radio è su $name.';
  }

  @override
  String get networks_log => 'Registro reti';

  @override
  String get networks_logEmpty => 'Ancora nulla di registrato.';

  @override
  String get networks_showMap => 'Mappa';

  @override
  String get networks_exportCsv => 'Esporta CSV';

  @override
  String get networks_exportGpx => 'Esporta GPX';

  @override
  String get networks_clearLog => 'Svuota registro';

  @override
  String get networks_clearLogConfirm => 'Eliminare tutte le reti registrate?';

  @override
  String get networks_name => 'Nome';

  @override
  String get networks_invalid =>
      'Controlla le impostazioni: sono fuori da quanto accettano le radio MeshCore.';

  @override
  String get networks_nodesHeard => 'Nodi sentiti';

  @override
  String get chat_resendNeedsRadio =>
      'Non inviato: collega la radio e riprova. Il messaggio viene conservato.';

  @override
  String get quick_title => 'Messaggi rapidi';

  @override
  String get quick_ok => 'OK';

  @override
  String get quick_onMyWay => 'Sto arrivando';

  @override
  String get quick_atCamp => 'Al campo';

  @override
  String get quick_runningLate => 'Sono in ritardo';

  @override
  String get quick_needHelp => 'Serve aiuto';

  @override
  String get quick_copyThat => 'Ricevuto';

  @override
  String get quick_empty =>
      'Nessun messaggio rapido. Tocca Modifica per aggiungerne uno.';

  @override
  String get quick_add => 'Nuovo messaggio rapido';

  @override
  String get quick_reset => 'Ripristina i predefiniti';

  @override
  String get chat_stopRetrying => 'Smetti di riprovare';

  @override
  String chat_addFirstBanner(String name) {
    return '$name può leggere e rispondere ai tuoi messaggi diretti solo dopo averti aggiunto come contatto. Se non l\'ha fatto, invia il tuo annuncio o condividi il tuo contatto.';
  }

  @override
  String get map_goToMyPosition => 'Vai alla mia posizione';

  @override
  String get map_positionUnavailable =>
      'La tua posizione non è disponibile. Attiva la localizzazione o imposta la posizione della radio.';

  @override
  String get contact_forgetAdvert => 'Dimentica l\'ultimo annuncio';

  @override
  String get contact_forgetAdvertHint =>
      'Se gli annunci di questo nodo hanno smesso di aggiornarsi dopo un azzeramento dell\'orologio, Dimentica l\'ultimo annuncio lascia passare il prossimo.';

  @override
  String get contact_forgetAdvertDone =>
      'Fatto. Il prossimo annuncio di questo nodo sarà accettato.';

  @override
  String get networks_modeQuick => 'Rapida';

  @override
  String get networks_modeThorough => 'Approfondita';

  @override
  String get networks_modeQuickHint =>
      'Invia un breve ping a zero salti su ogni rete e ascolta qualche secondo. Trova le reti con un ripetitore a portata.';

  @override
  String get networks_modeThoroughHint =>
      'Ascolta soltanto, più a lungo su ogni rete. Non invia nulla e trova anche reti senza ripetitore a portata, se qualcuno trasmette.';

  @override
  String networks_estimate(String time) {
    return 'circa $time';
  }
}
