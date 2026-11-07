// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core';

  @override
  String get nav_contacts => 'Contacts';

  @override
  String get nav_channels => 'Canaux';

  @override
  String get nav_map => 'Carte';

  @override
  String get nav_messages => 'Messages';

  @override
  String get nav_nodes => 'Nœuds';

  @override
  String get nav_radio => 'Radio';

  @override
  String get messages_title => 'Messages';

  @override
  String get messages_filterAll => 'Tous';

  @override
  String get messages_filterDirect => 'Directs';

  @override
  String get messages_filterChannels => 'Canaux';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'Rechercher des messages';

  @override
  String get messages_searchHint => 'Rechercher des conversations';

  @override
  String get messages_closeSearch => 'Fermer la recherche';

  @override
  String get messages_manageChannels => 'Gérer les canaux';

  @override
  String get messages_new => 'Nouveau';

  @override
  String get messages_newDirect => 'Écrire à un nœud';

  @override
  String get messages_newChannel => 'Ajouter ou rejoindre un canal';

  @override
  String get messages_empty => 'Aucune conversation pour l\'instant';

  @override
  String get messages_emptyHint =>
      'Les messages des nœuds et des canaux s\'affichent ici.';

  @override
  String get messages_noMatches =>
      'Aucune conversation ne correspond à votre recherche';

  @override
  String messages_you(String text) {
    return 'Vous : $text';
  }

  @override
  String get messages_yesterday => 'Hier';

  @override
  String messages_unreadCount(int count) {
    return '$count non lus';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return 'Connecté via $transport';
  }

  @override
  String get radioStatus_bluetooth => 'Bluetooth';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'Wi‑Fi (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return 'Batterie $percent %';
  }

  @override
  String get radioStatus_openRadio => 'Ouvrir les détails de la radio';

  @override
  String get radioOverview_battery => 'Batterie';

  @override
  String radioOverview_firmware(String version) {
    return 'Firmware $version';
  }

  @override
  String get radioOverview_sendAdvert => 'Envoyer une annonce';

  @override
  String get radioOverview_stats => 'Statistiques radio';

  @override
  String get accessControl_title => 'Contrôle d\'accès';

  @override
  String get accessControl_hubSubtitle =>
      'Qui peut se connecter sans mot de passe';

  @override
  String get accessControl_explainRepeater =>
      'Les personnes de cette liste se connectent sans mot de passe. Les admins peuvent modifier les paramètres ; Lecture seule et Lecture et écriture reçoivent aussi la télémétrie complète.';

  @override
  String get accessControl_explainRoom =>
      'Les admins de cette liste se connectent sans mot de passe et peuvent gérer le salon. Les membres du salon rejoignent avec le mot de passe du salon.';

  @override
  String get accessControl_roleReadOnly => 'Lecture seule';

  @override
  String get accessControl_roleReadWrite => 'Lecture et écriture';

  @override
  String get accessControl_roleAdmin => 'Admin';

  @override
  String get accessControl_you => 'Vous';

  @override
  String get accessControl_unknownNode => 'Nœud inconnu';

  @override
  String get accessControl_add => 'Ajouter';

  @override
  String get accessControl_addTitle => 'Ajouter à la liste d\'accès';

  @override
  String get accessControl_pickContact => 'Choisir un contact';

  @override
  String get accessControl_noContacts =>
      'Aucun contact à ajouter. Les nœuds apparaissent ici dès que vous avez reçu leur annonce.';

  @override
  String get accessControl_changeRole => 'Changer le rôle';

  @override
  String get accessControl_remove => 'Retirer l\'accès';

  @override
  String accessControl_removeConfirm(String name) {
    return 'Retirer $name de la liste d\'accès ? Le mot de passe sera alors nécessaire pour se connecter.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'C\'est vous. Si vous vous retirez, il vous faudra le mot de passe admin pour gérer à nouveau ce nœud.';

  @override
  String get accessControl_unknownKeyNote =>
      'Absent de vos contacts. Changer son rôle nécessite un firmware de nœud plus récent ; le retirer fonctionne toujours.';

  @override
  String get accessControl_prefixUnsupported =>
      'Le firmware de ce nœud ne peut pas changer le rôle d\'une personne absente de vos contacts. Vous pouvez toujours la retirer.';

  @override
  String get accessControl_empty => 'Personne n\'est sur la liste d\'accès';

  @override
  String get accessControl_emptyHint =>
      'Ajoutez des personnes pour qu\'elles se connectent sans mot de passe.';

  @override
  String get accessControl_loading => 'Demande de la liste d\'accès au nœud…';

  @override
  String get accessControl_timeout =>
      'Le nœud n\'a pas répondu. Vérifiez le chemin et réessayez.';

  @override
  String get accessControl_maybeIncomplete =>
      'Ce nœud a envoyé une page complète et son firmware ne peut pas en envoyer plus ; des entrées peuvent manquer.';

  @override
  String get accessControl_saved => 'Liste d\'accès mise à jour';

  @override
  String accessControl_failed(String reply) {
    return 'Le nœud a refusé la modification : $reply';
  }

  @override
  String get companionCli_title => 'Ligne de commande';

  @override
  String get companionCli_tileSubtitle =>
      'Exécuter des commandes sur votre radio';

  @override
  String get companionCli_warning =>
      'Les commandes s\'exécutent sur votre radio connectée et peuvent modifier ses paramètres ou la redémarrer.';

  @override
  String get companionCli_hint => 'Saisissez une commande, p. ex. ver';

  @override
  String get companionCli_send => 'Exécuter la commande';

  @override
  String get companionCli_noReply =>
      'Pas de réponse. La radio est peut-être en train de redémarrer.';

  @override
  String get companionCli_empty =>
      'Essayez l\'une des commandes ci-dessus ou saisissez la vôtre.';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle => 'Connecter votre radio à un réseau Wi‑Fi';

  @override
  String get wifi_unsupported =>
      'Le firmware de cette radio n\'inclut pas le Wi‑Fi.';

  @override
  String get wifi_enabled => 'Utiliser le Wi‑Fi';

  @override
  String get wifi_status => 'État';

  @override
  String get wifi_connected => 'Connecté';

  @override
  String wifi_connectedIp(String ip) {
    return 'Connecté · $ip';
  }

  @override
  String get wifi_disconnected => 'Non connecté';

  @override
  String get wifi_network => 'Nom du réseau (SSID)';

  @override
  String get wifi_password => 'Mot de passe';

  @override
  String get wifi_passwordKeep =>
      'Laissez vide pour garder le mot de passe actuel';

  @override
  String get wifi_save => 'Enregistrer';

  @override
  String get wifi_forget => 'Oublier le réseau';

  @override
  String get wifi_forgetConfirm =>
      'Supprimer de la radio le réseau et le mot de passe enregistrés ?';

  @override
  String get wifi_rebootNeeded =>
      'Enregistré. Redémarrez la radio pour appliquer les changements Wi‑Fi.';

  @override
  String get wifi_rebootNow => 'Redémarrer la radio';

  @override
  String get wifi_rebootConfirm =>
      'Redémarrer la radio maintenant ? L\'appli se déconnectera et vous devrez vous reconnecter.';

  @override
  String get wifi_loadFailed =>
      'Impossible de lire les paramètres Wi‑Fi de la radio.';

  @override
  String get wifi_retry => 'Réessayer';

  @override
  String wifi_saveFailed(String reply) {
    return 'La radio n\'a pas accepté la modification : $reply';
  }

  @override
  String get accessControl_refresh => 'Actualiser';

  @override
  String get common_cancel => 'Annuler';

  @override
  String get common_ok => 'D\'accord';

  @override
  String get common_connect => 'Connecter';

  @override
  String get common_unknownDevice => 'Appareil inconnu';

  @override
  String get common_save => 'Enregistrer';

  @override
  String get common_delete => 'Supprimer';

  @override
  String get common_deleteAll => 'Tout supprimer';

  @override
  String get common_close => 'Fermer';

  @override
  String get common_done => 'Terminé';

  @override
  String get common_edit => 'Modifier';

  @override
  String get common_add => 'Ajouter';

  @override
  String get common_settings => 'Paramètres';

  @override
  String get common_disconnect => 'Déconnecter';

  @override
  String get common_connected => 'Connecté';

  @override
  String get common_disconnected => 'Déconnecté';

  @override
  String get common_create => 'Créer';

  @override
  String get common_continue => 'Continuer';

  @override
  String get common_share => 'Partager';

  @override
  String get common_copy => 'Copier';

  @override
  String get common_retry => 'Réessayer';

  @override
  String get common_hide => 'Masquer';

  @override
  String get common_remove => 'Supprimer';

  @override
  String get common_enable => 'Activer';

  @override
  String get common_disable => 'Désactiver';

  @override
  String get common_undo => 'Annuler';

  @override
  String get messageStatus_sent => 'Envoyé';

  @override
  String get messageStatus_delivered => 'Livré';

  @override
  String get messageStatus_pending => 'Envoi en cours';

  @override
  String get messageStatus_failed => 'Échec de l\'envoi';

  @override
  String get messageStatus_repeated => 'Reçu plusieurs fois';

  @override
  String get urlImage_enable => 'Activer les images par URL';

  @override
  String get urlImage_possible =>
      'Image par URL possible ; activez-la dans les Paramètres.';

  @override
  String get common_reboot => 'Redémarrer';

  @override
  String get common_loading => 'Chargement...';

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
  String get common_autoRefresh => 'Actualisation automatique';

  @override
  String get common_interval => 'Intervalle';

  @override
  String get scanner_title => 'NOTORYX Core';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'Établir une connexion via TCP';

  @override
  String get tcpHostLabel => 'Adresse IP';

  @override
  String get tcpHostHint => '192.168.40.10';

  @override
  String get tcpPortLabel => 'Port';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected =>
      'Entrez l\'adresse de destination et connectez-vous.';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return 'Connexion à $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => 'Une adresse IP est obligatoire.';

  @override
  String get tcpErrorPortInvalid =>
      'La taille du port doit être comprise entre 1 et 65535.';

  @override
  String get tcpErrorUnsupported =>
      'Le protocole TCP n\'est pas pris en charge sur cette plateforme.';

  @override
  String get tcpErrorTimedOut => 'La connexion TCP a expiré.';

  @override
  String tcpConnectionFailed(String error) {
    return 'Échec de la connexion TCP : $error';
  }

  @override
  String get usbScreenTitle => 'Connectez via USB';

  @override
  String get usbScreenSubtitle =>
      'Sélectionnez un périphérique série détecté et connectez-vous directement à votre nœud MeshCore.';

  @override
  String get usbScreenStatus => 'Sélectionnez un périphérique USB';

  @override
  String get usbScreenNote =>
      'La communication série USB est active sur les appareils Android et les plateformes de bureau compatibles.';

  @override
  String get usbScreenEmptyState =>
      'Aucun périphérique USB n\'a été trouvé. Veuillez en brancher un et rafraîchir la page.';

  @override
  String get usbErrorPermissionDenied => 'L\'accès via USB a été refusé.';

  @override
  String get usbErrorDeviceMissing =>
      'Le périphérique USB sélectionné n\'est plus disponible.';

  @override
  String get usbErrorInvalidPort => 'Sélectionnez un périphérique USB valide.';

  @override
  String get usbErrorBusy =>
      'Une autre demande de connexion USB est déjà en cours.';

  @override
  String get usbErrorNotConnected => 'Aucun appareil USB n\'est connecté.';

  @override
  String get usbErrorOpenFailed =>
      'Impossible d\'ouvrir l\'appareil USB sélectionné.';

  @override
  String get usbErrorConnectFailed =>
      'Impossible de se connecter à l\'appareil USB sélectionné.';

  @override
  String get usbErrorUnsupported =>
      'La communication série USB n\'est pas prise en charge sur cette plateforme.';

  @override
  String get usbErrorAlreadyActive => 'Une connexion USB est déjà établie.';

  @override
  String get usbErrorNoDeviceSelected =>
      'Aucun appareil USB n\'a été sélectionné.';

  @override
  String get usbErrorPortClosed => 'La connexion USB n\'est pas établie.';

  @override
  String get usbErrorConnectTimedOut =>
      'La connexion a expiré. Assurez-vous que l\'appareil dispose du firmware USB Companion.';

  @override
  String get usbFallbackDeviceName =>
      'Dispositif de communication série sur le Web';

  @override
  String get usbStatus_notConnected => 'Sélectionnez un périphérique USB';

  @override
  String get usbStatus_connecting => 'Connexion au périphérique USB...';

  @override
  String get usbStatus_searching => 'Recherche de périphériques USB...';

  @override
  String usbConnectionFailed(String error) {
    return 'Échec de la connexion USB : $error';
  }

  @override
  String get scanner_scanning => 'Recherche de périphériques...';

  @override
  String get scanner_connecting => 'Connexion en cours...';

  @override
  String get scanner_disconnecting => 'Déconnexion...';

  @override
  String get scanner_notConnected => 'Non connecté';

  @override
  String scanner_connectedTo(String deviceName) {
    return 'Connecté à $deviceName';
  }

  @override
  String get scanner_searchingDevices => 'Recherche des appareils MeshCore...';

  @override
  String get scanner_tapToScan =>
      'Appuyez sur Scanner pour trouver les appareils MeshCore';

  @override
  String scanner_connectionFailed(String error) {
    return 'Échec de la connexion : $error';
  }

  @override
  String get scanner_stop => 'Arrêter';

  @override
  String get scanner_scan => 'Scanner';

  @override
  String get scanner_bluetoothOff => 'Le Bluetooth est désactivé.';

  @override
  String get scanner_bluetoothOffMessage =>
      'Veuillez activer le Bluetooth pour rechercher des appareils.';

  @override
  String get scanner_chromeRequired => 'Navigateur Chrome requis';

  @override
  String get scanner_chromeRequiredMessage =>
      'Cette application web nécessite Google Chrome ou un navigateur basé sur Chromium pour le support Bluetooth.';

  @override
  String get scanner_enableBluetooth => 'Activer le Bluetooth';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'La fonctionnalité Bluetooth n\'est pas disponible dans le navigateur. Veuillez vous connecter via USB à la place.';

  @override
  String get device_quickSwitch => 'Basculement rapide';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => 'Paramètres';

  @override
  String get settings_deviceInfo => 'Informations du périphérique';

  @override
  String get settings_appSettings => 'Paramètres de l\'application';

  @override
  String get settings_appSettingsSubtitle =>
      'Notifications, messagerie et préférences de carte';

  @override
  String get settings_nodeSettings => 'Paramètres du nœud';

  @override
  String get settings_nodeName => 'Nom du nœud';

  @override
  String get settings_nodeNameNotSet => 'Non défini';

  @override
  String get settings_nodeNameHint => 'Entrer le nom du nœud';

  @override
  String get settings_nodeNameUpdated => 'Nom mis à jour';

  @override
  String get settings_radioSettings => 'Paramètres Radio';

  @override
  String get settings_radioSettingsSubtitle =>
      'Fréquence, puissance, facteur d\'espacement';

  @override
  String get settings_radioSettingsUpdated => 'Paramètres radio mis à jour';

  @override
  String get settings_regionSettings => 'Régions';

  @override
  String get settings_regionSettingsSubtitle => 'Gérer les régions stockées';

  @override
  String get settings_corridorRegion => 'Région du corridor';

  @override
  String get settings_corridorRegionDefault => '#corridor (par défaut)';

  @override
  String get settings_corridorRegionHelp =>
      'Les paquets de corridor de diffusion sont marqués avec cette région. Les répéteurs sans firmware de corridor ne les transmettent que s\'ils autorisent cette région. Laissez vide pour l\'étiquette par défaut #corridor.';

  @override
  String get settings_corridorRegionHint => 'Nom de la région';

  @override
  String get settings_corridorRegionUseDefault =>
      'Utiliser la valeur par défaut';

  @override
  String get settings_corridorRegionUpdated => 'Région du corridor mise à jour';

  @override
  String get settings_corridorRegionFailed =>
      'Impossible de mettre à jour la région du corridor';

  @override
  String get settings_regionManagement_screenTitle => 'Gestion de région';

  @override
  String get settings_regionNameHint => 'Entrer le nom de la région';

  @override
  String get settings_regionAddRegion => 'Ajouter une région';

  @override
  String get settings_regionFetchRegions =>
      'Récupérer les régions à partir des répéteurs';

  @override
  String get settings_regionFetchRegionsFail =>
      'Aucune région n\'a été trouvée';

  @override
  String get settings_regionFetchRegionsAlreadyExists =>
      'Cette région a déjà été ajoutée';

  @override
  String get settings_regionName => 'Nom de la région';

  @override
  String get settings_regionDeleted => 'Région supprimée';

  @override
  String get settings_deleteRegion => 'Supprimer la région';

  @override
  String settings_deleteRegionConfirm(String region) {
    return 'Supprimez $region de la liste des régions ?';
  }

  @override
  String get settings_location => 'Emplacement';

  @override
  String get settings_locationSubtitle => 'Coordonnées GPS';

  @override
  String get settings_locationUpdated => 'Emplacement mis à jour';

  @override
  String get settings_locationBothRequired =>
      'Entrez la latitude et la longitude.';

  @override
  String get settings_locationInvalid => 'Latitude ou longitude invalide.';

  @override
  String get settings_locationGPSEnable => 'Activer le GPS';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'Activer la mise à jour automatique de la localisation via GPS';

  @override
  String get settings_locationIntervalSec =>
      'Intervalle de mise à jour du GPS (secondes)';

  @override
  String get settings_locationIntervalInvalid =>
      'L\'intervalle doit être compris entre 60 et 86400 secondes.';

  @override
  String get settings_latitude => 'Latitude';

  @override
  String get settings_longitude => 'Longitude';

  @override
  String get settings_contactSettings => 'Paramètres de contact';

  @override
  String get settings_contactSettingsSubtitle =>
      'Paramètres pour l\'ajout de contacts';

  @override
  String get settings_privacyMode => 'Mode de confidentialité';

  @override
  String get settings_privacyModeSubtitle =>
      'Masquer le nom et la localisation dans les annonces';

  @override
  String get settings_privacyModeToggle =>
      'Activez le mode confidentialité pour masquer votre nom et votre localisation dans les annonces.';

  @override
  String get settings_privacyModeEnabled => 'Mode de confidentialité activé';

  @override
  String get settings_privacyModeDisabled =>
      'Mode de confidentialité désactivé';

  @override
  String get settings_privacy => 'Paramètres de confidentialité';

  @override
  String get settings_privacySubtitle => 'Contrôlez les informations partagées';

  @override
  String get settings_privacySettingsDescription =>
      'Choisissez les informations que votre appareil partage avec les autres.';

  @override
  String get settings_denyAll => 'Refuser tout';

  @override
  String get settings_allowByContact => 'Autoriser par drapeaux de contact';

  @override
  String get settings_allowAll => 'Autoriser tout';

  @override
  String get settings_telemetryBaseMode => 'Mode de base Télémétrie';

  @override
  String get settings_telemetryLocationMode =>
      'Mode de localisation de la télémétrie';

  @override
  String get settings_telemetryEnvironmentMode =>
      'Mode d\'environnement de la télémétrie';

  @override
  String get settings_advertLocation => 'Localisation de l\'annonce';

  @override
  String get settings_advertLocationSubtitle =>
      'Inclure la localisation dans l\'annonce';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'Annonce zéro saut automatique lors de la mise à jour GPS';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'Lorsque la position GPS change, envoyer une annonce zéro saut (nécessite la position dans l\'annonce).';

  @override
  String get settings_multiAck => 'Plusieurs accusés de réception';

  @override
  String get settings_telemetryModeUpdated =>
      'Le mode télémétrie a été mis à jour';

  @override
  String get settings_actions => 'Actions';

  @override
  String get settings_deleteAllPaths => 'Supprimer tous les chemins';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Effacer toutes les données de chemin des contacts.';

  @override
  String get settings_sendAdvertisement => 'S\'annoncer';

  @override
  String get settings_sendAdvertisementSubtitle =>
      'Diffuser la présence maintenant';

  @override
  String get settings_advertisementSent => 'Annonce envoyée';

  @override
  String get settings_syncTime => 'Synchroniser l\'heure';

  @override
  String get settings_syncTimeSubtitle =>
      'Régler l\'heure de l\'appareil sur celle du téléphone.';

  @override
  String get settings_timeSynchronized => 'Heure synchronisée';

  @override
  String get settings_refreshContacts => 'Actualiser les contacts';

  @override
  String get settings_refreshContactsSubtitle =>
      'Recharger la liste des contacts depuis l\'appareil';

  @override
  String get settings_rebootDevice => 'Redémarrer l\'appareil';

  @override
  String get settings_rebootDeviceSubtitle => 'Redémarrer l\'appareil MeshCore';

  @override
  String get settings_rebootDeviceConfirm =>
      'Êtes-vous sûr de vouloir redémarrer l\'appareil ? Vous serez déconnecté.';

  @override
  String get settings_debug => 'Débogage';

  @override
  String get settings_companionDebugLog => 'Journal de débogage associé';

  @override
  String get settings_companionDebugLogSubtitle =>
      'Commandes, réponses et données brutes pour les protocoles BLE/TCP/USB';

  @override
  String get settings_appDebugLog => 'Journal de débogage de l\'application';

  @override
  String get settings_appDebugLogSubtitle =>
      'Messages de débogage de l\'application';

  @override
  String get settings_about => 'À propos';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core v$version';
  }

  @override
  String get settings_aboutLegalese => 'Projet open source MeshCore 2026';

  @override
  String get settings_aboutDescription =>
      'Client Flutter open source pour les appareils de réseau maillé LoRa MeshCore.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'Données d\'élévation LOS : Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => 'Nom';

  @override
  String get settings_infoId => 'ID';

  @override
  String get settings_infoStatus => 'État';

  @override
  String get settings_infoBattery => 'Batterie';

  @override
  String get settings_infoPublicKey => 'Clé publique';

  @override
  String get settings_infoContactsCount => 'Nombre de contacts';

  @override
  String get settings_infoChannelCount => 'Nombre de canaux';

  @override
  String get settings_infoHardware => 'Matériel';

  @override
  String get settings_infoFirmware => 'Firmware';

  @override
  String get settings_presets => 'Préréglages';

  @override
  String get settings_frequency => 'Fréquence (MHz)';

  @override
  String get settings_frequencyHelper => '300,0 - 2 500,0';

  @override
  String get settings_frequencyInvalid => 'Fréquence invalide (300-2500 MHz)';

  @override
  String get settings_bandwidth => 'Bande passante';

  @override
  String get settings_spreadingFactor => 'Facteur d\'étalement (SF)';

  @override
  String get settings_codingRate => 'Taux de codage (CR)';

  @override
  String get settings_txPower => 'Puissance TX (dBm)';

  @override
  String get settings_txPowerHelper => '0 - 22';

  @override
  String get settings_txPowerInvalid => 'Puissance TX invalide (0-22 dBm)';

  @override
  String get settings_clientRepeat => 'Répétition hors réseau';

  @override
  String get settings_clientRepeatSubtitle =>
      'Permettre à cet appareil de relayer les paquets du maillage pour les autres.';

  @override
  String get settings_clientRepeatFreqWarning =>
      'Pour les transmissions hors réseau, il est nécessaire d\'utiliser les fréquences de 433, 869 ou 918 MHz.';

  @override
  String settings_error(String message) {
    return 'Erreur : $message';
  }

  @override
  String get appSettings_title => 'Paramètres de l\'application';

  @override
  String get appSettings_appearance => 'Apparence';

  @override
  String get appSettings_theme => 'Thème';

  @override
  String get appSettings_themeSystem => 'Défaut système';

  @override
  String get appSettings_themeLight => 'Clair';

  @override
  String get appSettings_themeDark => 'Sombre';

  @override
  String get appSettings_language => 'Langue';

  @override
  String get appSettings_languageSystem => 'Par défaut du système';

  @override
  String get appSettings_languageEn => 'Anglais';

  @override
  String get appSettings_languageFr => 'Français';

  @override
  String get appSettings_languageEs => 'Espagnol';

  @override
  String get appSettings_languageDe => 'Allemand';

  @override
  String get appSettings_languagePl => 'Polonais';

  @override
  String get appSettings_languageSl => 'Slovène';

  @override
  String get appSettings_languagePt => 'Portugais';

  @override
  String get appSettings_languageIt => 'Italien';

  @override
  String get appSettings_languageZh => 'Chinois';

  @override
  String get appSettings_languageSv => 'Suédois';

  @override
  String get appSettings_languageNl => 'Néerlandais';

  @override
  String get appSettings_languageSk => 'Slovaque';

  @override
  String get appSettings_languageBg => 'Bulgare';

  @override
  String get appSettings_languageRu => 'Russe';

  @override
  String get appSettings_languageUk => 'Ukrainien';

  @override
  String get repeater_pathHashModeOption0 => '0 - 1 octet';

  @override
  String get repeater_pathHashModeOption1 => '1 à 2 octets';

  @override
  String get repeater_pathHashModeOption2 => '2 à 3 octets';

  @override
  String get repeater_pathHashModeOption3 => '3 à 4 octets';

  @override
  String get appSettings_enableMessageTracing =>
      'Activer le traçage des messages';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'Afficher les métadonnées détaillées de routage et de synchronisation des messages';

  @override
  String get appSettings_notifications => 'Notifications';

  @override
  String get appSettings_enableNotifications => 'Activer les notifications';

  @override
  String get appSettings_enableNotificationsSubtitle =>
      'Recevoir des notifications pour les messages et les annonces';

  @override
  String get appSettings_notificationPermissionDenied =>
      'Permission de notification refusée';

  @override
  String get appSettings_notificationsEnabled => 'Notifications activées';

  @override
  String get appSettings_notificationsDisabled => 'Notifications désactivées';

  @override
  String get appSettings_messageNotifications => 'Notifications de messages';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      'Afficher une notification lors de la réception de nouveaux messages';

  @override
  String get appSettings_channelMessageNotifications =>
      'Notifications des messages de canal';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'Afficher une notification lors de la réception des messages de canal';

  @override
  String get appSettings_advertisementNotifications =>
      'Notifications d\'annonces';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      'Afficher une notification lors de la découverte de nouveaux nœuds';

  @override
  String get appSettings_messaging => 'Messagerie';

  @override
  String get appSettings_clearPathOnMaxRetry =>
      'Effacer le chemin après le nombre maximal de tentatives';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      'Réinitialiser le chemin de contact après 5 tentatives d\'envoi infructueuses';

  @override
  String get appSettings_pathsWillBeCleared =>
      'Les chemins seront effacés après 5 échecs.';

  @override
  String get appSettings_pathsWillNotBeCleared =>
      'Les chemins ne seront pas effacés automatiquement.';

  @override
  String get appSettings_autoRouteRotation => 'Rotation automatique du routage';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      'Alterner entre les meilleurs chemins et le mode flood';

  @override
  String get appSettings_autoRouteRotationEnabled =>
      'Rotation automatique du routage activée';

  @override
  String get appSettings_autoRouteRotationDisabled =>
      'Rotation automatique du routage désactivée';

  @override
  String get appSettings_maxRouteWeight => 'Poids maximal du chemin';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      'Poids maximal qu\'un chemin peut accumuler grâce aux livraisons réussies.';

  @override
  String get appSettings_initialRouteWeight => 'Poids initial de l\'itinéraire';

  @override
  String get appSettings_initialRouteWeightSubtitle =>
      'Poids de départ pour les nouveaux chemins découverts';

  @override
  String get appSettings_routeWeightSuccessIncrement =>
      'Incrément du poids de succès';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      'Poids ajouté à un chemin après une livraison réussie.';

  @override
  String get appSettings_routeWeightFailureDecrement =>
      'Décrément du poids d\'échec';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      'Poids retiré d\'un chemin après une tentative de livraison infructueuse.';

  @override
  String get appSettings_maxMessageRetries =>
      'Nombre maximal de tentatives d\'envoi';

  @override
  String get appSettings_maxMessageRetriesSubtitle =>
      'Nombre de tentatives avant de marquer un message comme ayant échoué.';

  @override
  String get appSettings_battery => 'Batterie';

  @override
  String get appSettings_batteryChemistry => 'Chimie de la batterie';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return 'Définir par appareil ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      'Connectez un appareil pour choisir';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3,0-4,2V)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2,6-3,65V)';

  @override
  String get appSettings_batteryLipo => 'LiPo (3,0-4,2V)';

  @override
  String get appSettings_batteryLipoHv => 'Tension élevée LiPo (3,0-4,35 V)';

  @override
  String get appSettings_mapDisplay => 'Affichage de la carte';

  @override
  String get appSettings_showRepeaters => 'Afficher les répéteurs';

  @override
  String get appSettings_showRepeatersSubtitle =>
      'Afficher les nœuds répéteurs sur la carte';

  @override
  String get appSettings_showChatNodes => 'Afficher les nœuds de discussion';

  @override
  String get appSettings_showChatNodesSubtitle =>
      'Afficher les nœuds de chat sur la carte';

  @override
  String get appSettings_showOtherNodes => 'Afficher d\'autres nœuds';

  @override
  String get appSettings_showOtherNodesSubtitle =>
      'Afficher d\'autres types de nœuds sur la carte';

  @override
  String get appSettings_timeFilter => 'Filtre du temps';

  @override
  String get appSettings_timeFilterShowAll => 'Afficher tous les nœuds';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return 'Afficher les nœuds des $hours dernières heures';
  }

  @override
  String get appSettings_mapTimeFilter => 'Filtre temporel de la carte';

  @override
  String get appSettings_showNodesDiscoveredWithin =>
      'Afficher les nœuds découverts au cours de :';

  @override
  String get appSettings_allTime => 'Tout le temps';

  @override
  String get appSettings_lastHour => 'Dernière heure';

  @override
  String get appSettings_last6Hours => 'Dernières 6 heures';

  @override
  String get appSettings_last24Hours => 'Dernières 24 heures';

  @override
  String get appSettings_lastWeek => 'La semaine dernière';

  @override
  String get appSettings_rasterTileSource => 'Source de tuiles raster';

  @override
  String get appSettings_stadiaEndpoint => 'Point de terminaison Stadia';

  @override
  String get appSettings_stadiaApiKey => 'Clé API Stadia';

  @override
  String get appSettings_stadiaApiKeyRequired =>
      'Requis pour l’utilisation de Stadia Maps';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return 'Configuré : $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Entrez votre clé API Stadia Maps. Cette application l’utilise pour les requêtes de tuiles raster.';

  @override
  String get appSettings_offlineMapCache => 'Cache de carte hors ligne';

  @override
  String get appSettings_unitsTitle => 'Unités';

  @override
  String get appSettings_unitsMetric => 'Métrique (m/km/°C)';

  @override
  String get appSettings_unitsImperial => 'Impérial (ft / mi / °F)';

  @override
  String get appSettings_noAreaSelected => 'Aucune zone sélectionnée';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'Zone sélectionnée (zoom $minZoom-$maxZoom)';
  }

  @override
  String get appSettings_debugCard => 'Débogage';

  @override
  String get appSettings_appDebugLogging =>
      'Journalisation des débogages de l\'application';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'Journaliser les messages de débogage de l\'application pour le dépannage.';

  @override
  String get appSettings_appDebugLoggingEnabled =>
      'Journalisation de débogage de l\'application activée';

  @override
  String get appSettings_appDebugLoggingDisabled =>
      'Journalisation de débogage de l\'application désactivée';

  @override
  String get contacts_title => 'Contacts';

  @override
  String get contacts_noContacts => 'Aucun contact trouvé.';

  @override
  String get contacts_contactsWillAppear =>
      'Les contacts apparaîtront lorsque les appareils diffuseront leur annonce.';

  @override
  String get contacts_unread => 'Non lu';

  @override
  String get contacts_searchContactsNoNumber => 'Rechercher des contacts...';

  @override
  String contacts_searchContacts(int number, String str) {
    return 'Rechercher $number$str contacts...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'Rechercher $number$str Favoris...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'Rechercher $number$str utilisateurs...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'Rechercher $number$str Répéteurs...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'Rechercher $number$str room server...';
  }

  @override
  String get contacts_noUnreadContacts => 'Aucun contact non lu';

  @override
  String get contacts_noContactsFound => 'Aucun contact ou groupe trouvé.';

  @override
  String get contacts_deleteContact => 'Supprimer le contact';

  @override
  String contacts_removeConfirm(String contactName) {
    return 'Supprimer $contactName des contacts ?';
  }

  @override
  String get contacts_manageRepeater => 'Gérer le répéteur';

  @override
  String get contacts_manageRoom => 'Gérer le room server';

  @override
  String get contacts_roomLogin => 'Connexion au room server';

  @override
  String get contacts_openChat => 'Ouvrir le chat';

  @override
  String get contacts_editGroup => 'Modifier le groupe';

  @override
  String get contacts_deleteGroup => 'Supprimer le groupe';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return 'Supprimer le groupe \"$groupName\" ?';
  }

  @override
  String get contacts_newGroup => 'Nouveau groupe';

  @override
  String get contacts_moreOptions => 'Plus d\'options';

  @override
  String get contacts_searchOpen => 'Rechercher des contacts';

  @override
  String get contacts_searchClose => 'Recherche avancée';

  @override
  String get contacts_groupName => 'Nom du groupe';

  @override
  String get contacts_groupNameRequired => 'Le nom du groupe est obligatoire.';

  @override
  String get contacts_groupNameReserved => 'Ce nom de groupe est réservé';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'Le groupe \"$name\" existe déjà.';
  }

  @override
  String get contacts_filterContacts => 'Filtrer les contacts...';

  @override
  String get contacts_noContactsMatchFilter =>
      'Aucun contact ne correspond à votre filtre.';

  @override
  String get contacts_noMembers => 'Aucun membre';

  @override
  String get contacts_lastSeenNow => 'À l\'instant';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return '~ $minutes min';
  }

  @override
  String get contacts_lastSeenHourAgo => '~ 1 heure';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return '~ $hours heures';
  }

  @override
  String get contacts_lastSeenDayAgo => '~ 1 jour';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return '~ $days jours';
  }

  @override
  String get contact_info => 'Informations de contact';

  @override
  String get contact_settings => 'Paramètres de contact';

  @override
  String get contact_telemetry => 'Télémétrie';

  @override
  String get contact_lastSeen => 'Vu pour la dernière fois';

  @override
  String get contact_clearChat => 'Effacer la conversation';

  @override
  String get contact_teleBase => 'Base de télémétrie';

  @override
  String get contact_teleBaseSubtitle =>
      'Autoriser le partage du niveau de batterie et de la télémétrie de base';

  @override
  String get contact_teleLoc => 'Emplacement de télémétrie';

  @override
  String get contact_teleLocSubtitle =>
      'Autoriser le partage des données de localisation';

  @override
  String get contact_teleEnv => 'Environnement Télémétrie';

  @override
  String get contact_teleEnvSubtitle =>
      'Autoriser le partage des données des capteurs d\'environnement';

  @override
  String get channels_title => 'Canaux';

  @override
  String get channels_noChannelsConfigured => 'Aucun canal configuré';

  @override
  String get channels_addPublicChannel => 'Ajouter un canal public';

  @override
  String get channels_searchChannels => 'Rechercher des canaux...';

  @override
  String get channels_noChannelsFound => 'Aucun canal trouvé';

  @override
  String channels_channelIndex(int index) {
    return 'Canal $index';
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
      'Reçu via MQTT, non entendu par votre radio';

  @override
  String get channels_private => 'Privé';

  @override
  String get channels_editChannel => 'Modifier le canal';

  @override
  String get channels_muteChannel => 'Désactiver les notifications du canal';

  @override
  String get channels_unmuteChannel => 'Réactiver les notifications du canal';

  @override
  String get channels_deleteChannel => 'Supprimer le canal';

  @override
  String channels_deleteChannelConfirm(String name) {
    return 'Supprimer \"$name\" ? Cette action est irréversible.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'Échec de la suppression du canal \"$name\"';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'Canal \"$name\" supprimé';
  }

  @override
  String get channels_addChannel => 'Ajouter un canal';

  @override
  String get channels_channelIndexLabel => 'Index du canal';

  @override
  String get channels_channelName => 'Nom du canal';

  @override
  String get channels_usePublicChannel => 'Utiliser le canal public';

  @override
  String get channels_standardPublicPsk => 'PSK public standard';

  @override
  String get channels_pskHex => 'PSK (Hexadécimal)';

  @override
  String get channels_generateRandomPsk => 'Générer une PSK aléatoire';

  @override
  String get channels_enterChannelName => 'Veuillez entrer un nom de canal';

  @override
  String get channels_pskMustBe32Hex =>
      'La PSK doit contenir 32 caractères hexadécimaux.';

  @override
  String channels_channelAdded(String name) {
    return 'Le canal \"$name\" a été ajouté';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'Modifier le Canal $index';
  }

  @override
  String get channels_smazCompression => 'Compression SMAZ';

  @override
  String get channels_cyr2latCompression => 'Compression Cyr2Lat';

  @override
  String get channels_cyr2latCompressionDscr =>
      'Remplace certains caractères cyrilliques par des caractères latins lors de l\'envoi.';

  @override
  String get channels_cyr2latSettingsHeading => 'Paramètres Cyr2Lat';

  @override
  String get channels_cyr2latSettingsSubheading => 'Liste des remplacements';

  @override
  String get channels_cyr2latSettingsDscr =>
      'Modifier la configuration JSON des remplacements de caractères';

  @override
  String get channels_cyr2latSettingsDialogHint =>
      'Tableau de remplacement JSON';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'JSON incorrect : $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'Le canal \"$name\" a été mis à jour';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Ajouter un profil Cyr2Lat';

  @override
  String get settings_cyr2latProfileName => 'Nom du profil';

  @override
  String get settings_cyr2latProfileNameEmpty =>
      'Le nom du profil ne peut pas être vide';

  @override
  String get settings_cyr2latProfileAdded => 'Profil ajouté avec succès';

  @override
  String get settings_cyr2latProfileUpdated => 'Profil mis à jour avec succès';

  @override
  String get settings_cyr2latProfileEdit => 'Modifier le profil Cyr2Lat';

  @override
  String get settings_cyr2latProfileDelete => 'Supprimer le profil Cyr2Lat';

  @override
  String get settings_cyr2latProfileDeleted => 'Profil supprimé avec succès';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return 'Êtes-vous sûr de vouloir supprimer le profil \"$name\" ?';
  }

  @override
  String get channels_publicChannelAdded => 'Canal public ajouté';

  @override
  String get channels_sortBy => 'Trier par';

  @override
  String get channels_sortManual => 'Manuel';

  @override
  String get channels_sortAZ => 'A à Z';

  @override
  String get channels_sortLatestMessages => 'Derniers messages';

  @override
  String get channels_sortUnread => 'Non lus';

  @override
  String get channels_createPrivateChannel => 'Créer un Canal Privé';

  @override
  String get channels_createPrivateChannelDesc =>
      'Sécurisé avec une clé secrète.';

  @override
  String get channels_joinPrivateChannel => 'Rejoindre un Canal Privé';

  @override
  String get channels_joinPrivateChannelDesc =>
      'Entrer manuellement une clé secrète.';

  @override
  String get channels_joinPublicChannel => 'Rejoindre le canal public';

  @override
  String get channels_joinPublicChannelDesc =>
      'Tout le monde peut rejoindre ce canal.';

  @override
  String get channels_joinHashtagChannel => 'Rejoindre un Canal Hashtag';

  @override
  String get channels_joinHashtagChannelDesc =>
      'N\'importe qui peut rejoindre les canaux #hashtag.';

  @override
  String get channels_scanQrCode => 'Scanner un QR code';

  @override
  String get channels_scanQrCodeComingSoon => 'Bientôt disponible';

  @override
  String get channels_enterHashtag => 'Entrez le hashtag';

  @override
  String get channels_hashtagHint => 'ex. #equipe';

  @override
  String channels_regionSetTo(String region) {
    return 'Région : $region';
  }

  @override
  String get channels_regionNotSet => 'Région : aucune';

  @override
  String get channels_regionSelect_Title => 'Choisissez une région';

  @override
  String get channels_clearRegion => 'Zone dégagée';

  @override
  String get chat_noMessages => 'Aucun message pour le moment';

  @override
  String get chat_sendMessage => 'Envoyer un message';

  @override
  String chat_sendMessageTo(String contactName) {
    return 'Envoyer un message à $contactName';
  }

  @override
  String get chat_sendMessageToStart => 'Envoyer un message pour commencer';

  @override
  String get chat_originalMessageNotFound => 'Message d\'origine non trouvé';

  @override
  String chat_replyingTo(String name) {
    return 'Répondre à $name';
  }

  @override
  String chat_replyTo(String name) {
    return 'Répondre à $name';
  }

  @override
  String get chat_location => 'Emplacement';

  @override
  String get chat_typeMessage => 'Saisir un message...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'Message trop long (max $maxBytes octets).';
  }

  @override
  String get chat_messageCopied => 'Message copié';

  @override
  String get chat_messageDeleted => 'Message supprimé';

  @override
  String get chat_retryingMessage => 'Nouvelle tentative d\'envoi du message';

  @override
  String chat_retryCount(int current, int max) {
    return 'Essai $current/$max';
  }

  @override
  String get chat_selectSendAction => 'Sélectionner une action d’envoi';

  @override
  String get chat_sendGif => 'Envoyer un GIF';

  @override
  String get chat_limitToArea => 'Limiter à une zone';

  @override
  String get chat_limitToAreaTitle => 'Envoyer seulement dans…';

  @override
  String get chat_limitToAreaHelp =>
      'Les répéteurs dotés du firmware de corridor de diffusion ne relaient le message que dans cette zone. Les autres répéteurs l\'ignorent, sauf s\'ils autorisent votre région de corridor.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '$km km autour de vous';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return 'Uniquement dans un rayon de $km km';
  }

  @override
  String get chat_limitToAreaOff => 'Aucune limite';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'Définissez la position de votre radio pour limiter les messages à une zone.';

  @override
  String get chat_sendImageLora => 'Envoyer une image via MeshCore';

  @override
  String get chat_imagePickFailed => 'Je n\'ai pas pu ouvrir cette image';

  @override
  String get chat_receivedGif => 'Reçu un GIF';

  @override
  String get chat_reply => 'Répondre';

  @override
  String get chat_addReaction => 'Ajouter une réaction';

  @override
  String get chat_me => 'Moi';

  @override
  String get reaction_report => 'Réactions emoji';

  @override
  String get emojiCategorySmileys => 'Émojis';

  @override
  String get emojiCategoryGestures => 'Gestes';

  @override
  String get emojiCategoryHearts => 'Cœurs';

  @override
  String get emojiCategoryObjects => 'Objets';

  @override
  String get gifPicker_title => 'Choisir un GIF';

  @override
  String get gifPicker_searchHint => 'Rechercher des GIF...';

  @override
  String get gifPicker_poweredBy => 'Propulsé par GIPHY';

  @override
  String get gifPicker_noGifsFound => 'Aucun GIF trouvé';

  @override
  String get gifPicker_failedLoad => 'Impossible de charger les GIFs';

  @override
  String get gifPicker_failedSearch => 'Recherche de GIFs échouée';

  @override
  String get gifPicker_noInternet => 'Aucune connexion internet';

  @override
  String get debugLog_appTitle => 'Journal de débogage de l\'application';

  @override
  String get debugLog_bleTitle => 'Journal de débogage BLE';

  @override
  String get debugLog_copyLog => 'Copier le journal';

  @override
  String get debugLog_clearLog => 'Effacer le journal';

  @override
  String get debugLog_copied => 'Journal de débogage copié';

  @override
  String get debugLog_bleCopied => 'Journal BLE copié';

  @override
  String get debugLog_noEntries => 'Aucun journal de débogage pour le moment.';

  @override
  String get debugLog_enableInSettings =>
      'Activer le débogage de l\'application dans les paramètres';

  @override
  String get debugLog_frames => 'Cadres';

  @override
  String get debugLog_rawLogRx => 'Enregistrement brut - RX';

  @override
  String get debugLog_noBleActivity =>
      'Pas d\'activité BLE enregistrée pour le moment.';

  @override
  String debugFrame_length(int count) {
    return 'Longueur du cadre : $count octets';
  }

  @override
  String debugFrame_command(String value) {
    return 'Commande : 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'Message :';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- Clé publique de destination : $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- Timestamp : $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- Indicateurs : 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- Type de texte : $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'CLI';

  @override
  String get debugFrame_textTypePlain => 'Texte brut';

  @override
  String debugFrame_text(String text) {
    return '- Texte : \"$text\"';
  }

  @override
  String get debugFrame_hexDump => 'Dump hexadécimal :';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sauts',
      one: 'saut',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => 'Supprimer le chemin';

  @override
  String get chat_noPathHistoryYet =>
      'Aucun historique de parcours disponible.\nEnvoyez un message pour découvrir les parcours.';

  @override
  String get chat_pathCleared =>
      'Chemin effacé. Le prochain message redécouvrira la route.';

  @override
  String get chat_fullPath => 'Chemin complet';

  @override
  String get routing_title => 'Routage';

  @override
  String get routing_modeAuto => 'Auto';

  @override
  String get routing_modeFlood => 'Flood';

  @override
  String get routing_modeManual => 'Manuel';

  @override
  String get routing_modeAutoHint =>
      'Sélectionne automatiquement le meilleur chemin connu, et utilise le flood si aucun chemin n\'est connu.';

  @override
  String get routing_modeFloodHint =>
      'Diffusion via tous les répéteurs. La méthode la plus fiable, mais qui utilise plus de temps d\'antenne.';

  @override
  String get routing_modeManualHint =>
      'Envoie toujours selon le chemin exact que vous avez défini.';

  @override
  String get routing_currentRoute => 'Route actuelle';

  @override
  String get routing_directNoHops => 'Direct — sans relais';

  @override
  String get routing_noPathYet =>
      'Aucun chemin pour le moment. Le prochain message passera en flood jusqu\'à ce qu\'une route soit découverte.';

  @override
  String get routing_floodBroadcast => 'Diffusion via tous les répéteurs';

  @override
  String get routing_editPath => 'Modifier le chemin';

  @override
  String get routing_forgetPath => 'Oublier le chemin';

  @override
  String get routing_knownPaths => 'Chemins connus';

  @override
  String get routing_knownPathsHint => 'Touchez un chemin pour l\'utiliser.';

  @override
  String get routing_inUse => 'En cours d\'utilisation';

  @override
  String get routing_qualityStrong => 'Premier saut fort';

  @override
  String get routing_qualityGood => 'Premier saut correct';

  @override
  String get routing_qualityFair => 'Premier saut moyen';

  @override
  String get routing_qualityWorked => 'A déjà fonctionné';

  @override
  String get routing_qualityFlood => 'Entendu via flood';

  @override
  String get routing_qualityUntested => 'Non testé';

  @override
  String routing_lastWorked(String when) {
    return 'a fonctionné $when';
  }

  @override
  String get routing_neverWorked => 'jamais confirmé';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes livrés, $failures échoués';
  }

  @override
  String get routing_floodDelivery => 'Livraison flood';

  @override
  String get pathEditor_title => 'Créer un chemin';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count sur 64 sauts';
  }

  @override
  String get pathEditor_noHops =>
      'Aucun saut pour le moment. Touchez les répéteurs ci-dessous pour les ajouter dans l\'ordre, ou enregistrez sans saut pour envoyer directement.';

  @override
  String get pathEditor_addHops => 'Ajouter les sauts dans l\'ordre';

  @override
  String get pathEditor_searchRepeaters => 'Rechercher des répétiteurs';

  @override
  String get pathEditor_advancedHex => 'Avancé : chemin hexadécimal brut';

  @override
  String get pathEditor_hexLabel => 'Préfixes hexadécimaux';

  @override
  String get pathEditor_hexHelper =>
      'Deux caractères hexadécimaux par saut, séparés par des virgules.';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return 'Invalide : $tokens';
  }

  @override
  String get pathEditor_tooManyHops => 'Maximum 64 sauts';

  @override
  String get pathEditor_usePath => 'Utiliser ce chemin';

  @override
  String get pathEditor_removeHop => 'Supprimer le saut';

  @override
  String get pathEditor_unknownHop => 'Répéteur non identifié';

  @override
  String get chat_pathSavedLocally =>
      'Sauvegardé localement. Connectez-vous pour synchroniser.';

  @override
  String get chat_pathDeviceConfirmed => 'Appareil confirmé.';

  @override
  String get chat_pathDeviceNotConfirmed =>
      'L\'appareil n\'a pas encore été confirmé.';

  @override
  String get chat_type => 'Type';

  @override
  String get chat_path => 'Chemin';

  @override
  String get chat_publicKey => 'Clé publique';

  @override
  String get chat_compressOutgoingMessages =>
      'Compresser les messages sortants';

  @override
  String get chat_floodForced => 'Flood (forcé)';

  @override
  String get chat_directForced => 'Direct (forcé)';

  @override
  String chat_hopsForced(int count) {
    return '$count sauts (forcés)';
  }

  @override
  String get chat_floodAuto => 'Flood (auto)';

  @override
  String get chat_direct => 'Direct';

  @override
  String get chat_poiShared => 'Point d\'intérêt partagé';

  @override
  String chat_unread(int count) {
    return 'Non lu : $count';
  }

  @override
  String get chat_markAsUnread => 'Signaler comme non lu';

  @override
  String get chat_newMessages => 'Nouveaux messages';

  @override
  String get chat_openLink => 'Ouvrir le lien ?';

  @override
  String get chat_openLinkConfirmation =>
      'Voulez-vous ouvrir ce lien dans votre navigateur ?';

  @override
  String get chat_open => 'Ouvrir';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'Impossible d\'ouvrir le lien : $url';
  }

  @override
  String get chat_invalidLink => 'Format de lien invalide';

  @override
  String get map_title => 'Carte des nœuds';

  @override
  String get map_searchHint => 'Rechercher par nom ou ID de nœud';

  @override
  String get map_activity => 'Activité';

  @override
  String get map_online => 'En ligne';

  @override
  String get map_recent => 'Récents';

  @override
  String get map_stale => 'Rancide';

  @override
  String get map_visible => 'Visible';

  @override
  String get map_hidden => 'Masqué';

  @override
  String get map_centerOnNode => 'Centrer sur le nœud';

  @override
  String get map_details => 'Détails';

  @override
  String get map_noGps => 'Aucun GPS';

  @override
  String get map_noResults => 'Aucun nœud correspondant';

  @override
  String get map_lineOfSight => 'Ligne de vue';

  @override
  String get map_losScreenTitle => 'Ligne de vue';

  @override
  String get map_noNodesWithLocation =>
      'Aucun nœud avec des données de localisation';

  @override
  String get map_nodesNeedGps =>
      'Les nœuds doivent partager leurs coordonnées GPS\npour apparaître sur la carte.';

  @override
  String map_nodesCount(int count) {
    return 'Nœuds : $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'Épingles : $count';
  }

  @override
  String get map_chat => 'Conversation';

  @override
  String get map_repeater => 'Répéteur';

  @override
  String get map_room => 'Room server';

  @override
  String get map_sensor => 'Capteur';

  @override
  String get map_pinDm => 'Épingle (DM)';

  @override
  String get map_pinPrivate => 'Épingle (privé)';

  @override
  String get map_pinPublic => 'Épingle (public)';

  @override
  String get map_lastSeen => 'Vu pour la dernière fois';

  @override
  String get map_disconnectConfirm =>
      'Êtes-vous sûr de vouloir vous déconnecter de cet appareil ?';

  @override
  String get map_from => 'Depuis';

  @override
  String get map_source => 'Source';

  @override
  String get map_flags => 'Drapeaux';

  @override
  String get map_type => 'Type';

  @override
  String get map_path => 'Chemin';

  @override
  String get map_location => 'Localisation';

  @override
  String get map_estLocation => 'Localisation estimée';

  @override
  String get map_publicKey => 'Clé publique';

  @override
  String get map_publicKeyPrefixHint => 'p. ex. ab12';

  @override
  String get map_shareMarkerHere => 'Partager le marqueur ici';

  @override
  String get map_setAsMyLocation => 'Définir comme ma localisation';

  @override
  String get floodCorridor_title => 'Corridor de diffusion';

  @override
  String get floodCorridor_previewToHere =>
      'Aperçu du corridor de diffusion jusqu\'ici';

  @override
  String get floodCorridor_requesting =>
      'Demande d\'un corridor à votre radio…';

  @override
  String get floodCorridor_unsupported =>
      'Le firmware de votre radio ne prend pas en charge les corridors de diffusion.';

  @override
  String get floodCorridor_noProposal =>
      'Votre radio n\'a pas pu proposer de corridor. Vérifiez qu\'une position est définie.';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cercles',
      one: '1 cercle',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return '$inside sur $total répéteurs connus à l\'intérieur';
  }

  @override
  String get floodCorridor_straightLine =>
      'Ligne droite : aucun répéteur connu sur le trajet';

  @override
  String get floodCorridor_followsRepeaters => 'Suit vos répéteurs connus';

  @override
  String get floodCorridor_horizonLimited =>
      'Les répéteurs connus n\'atteignent pas la cible ; le reste est une ligne droite';

  @override
  String get floodCorridor_thinStretch =>
      'Une partie du corridor compte peu de répéteurs connus';

  @override
  String get floodCorridor_moreCoverage =>
      'Exiger plus de couverture de répéteurs';

  @override
  String get floodCorridor_previewNote =>
      'Aperçu uniquement. Les répéteurs sans firmware de corridor n\'appliquent pas les corridors.';

  @override
  String get map_pinLabel => 'Libellé de l\'épingle';

  @override
  String get map_label => 'Étiquette';

  @override
  String get map_pointOfInterest => 'Point d\'intérêt';

  @override
  String get map_sendToContact => 'Envoyer au contact';

  @override
  String get map_sendToChannel => 'Envoyer sur le canal';

  @override
  String get map_noChannelsAvailable => 'Aucun canal disponible';

  @override
  String get map_publicLocationShare => 'Partage public de localisation';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return 'Vous êtes sur le point de partager une localisation dans $channelLabel. Ce canal est public et toute personne disposant de la PSK peut la voir.';
  }

  @override
  String get map_connectToShareMarkers =>
      'Connectez-vous à un appareil pour partager des marqueurs';

  @override
  String get map_filterNodes => 'Filtrer les nœuds';

  @override
  String get map_nodeTypes => 'Types de nœuds';

  @override
  String get map_chatNodes => 'Nœuds de chat';

  @override
  String get map_repeaters => 'Répéteurs';

  @override
  String get map_otherNodes => 'Autres nœuds';

  @override
  String get map_showOverlaps => 'Chevauchements de clés de répéteur';

  @override
  String get map_keyPrefix => 'Préfixe de clé';

  @override
  String get map_filterByKeyPrefix => 'Filtrer par préfixe de clé';

  @override
  String get map_publicKeyPrefix => 'Préfixe de clé publique';

  @override
  String get map_markers => 'Marqueurs';

  @override
  String get map_showSharedMarkers => 'Afficher les marqueurs partagés';

  @override
  String get map_showGuessedLocations =>
      'Afficher les emplacements estimés des nœuds';

  @override
  String get map_showDiscoveryContacts => 'Afficher les contacts de découverte';

  @override
  String get map_guessedLocation => 'Localisation estimée';

  @override
  String get map_lastSeenTime => 'Vu pour la dernière fois';

  @override
  String get map_sharedPin => 'Épingle partagée';

  @override
  String get map_sharedAt => 'Partagé';

  @override
  String get map_joinRoom => 'Rejoindre le room server';

  @override
  String get map_manageRepeater => 'Gérer le répéteur';

  @override
  String get map_tapToAdd =>
      'Appuyez sur les nœuds pour les ajouter au chemin.';

  @override
  String get map_runTrace => 'Exécuter la traçage de chemin';

  @override
  String get map_runTraceWithReturnPath => 'Revenir sur le même chemin.';

  @override
  String get map_removeLast => 'Supprimer le dernier';

  @override
  String get map_pathTraceCancelled => 'Traçage de chemin annulé';

  @override
  String get mapCache_title => 'Cache de carte hors ligne';

  @override
  String get mapCache_selectAreaFirst =>
      'Sélectionnez d\'abord une zone à mettre en cache';

  @override
  String get mapCache_noTilesToDownload =>
      'Aucune tuile à télécharger pour cette zone.';

  @override
  String get mapCache_downloadTilesTitle => 'Télécharger les tuiles';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return 'Télécharger $count tuiles pour une utilisation hors ligne ?';
  }

  @override
  String get mapCache_downloadAction => 'Télécharger';

  @override
  String mapCache_cachedTiles(int count) {
    return '$count tuiles mises en cache';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return '$downloaded tuiles mises en cache ($failed en échec)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => 'Effacer le cache hors ligne';

  @override
  String get mapCache_clearOfflineCachePrompt =>
      'Supprimer toutes les tuiles de carte mises en cache ?';

  @override
  String get mapCache_offlineCacheCleared =>
      'Le cache hors ligne a été effacé.';

  @override
  String get mapCache_noAreaSelected => 'Aucune zone sélectionnée';

  @override
  String get mapCache_cacheArea => 'Zone à mettre en cache';

  @override
  String get mapCache_useCurrentView => 'Utiliser la vue actuelle';

  @override
  String get mapCache_zoomRange => 'Plage de zoom';

  @override
  String mapCache_estimatedTiles(int count) {
    return 'Estimation des tuiles : $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return '$completed / $total téléchargées';
  }

  @override
  String get mapCache_downloadTilesButton => 'Télécharger les tuiles';

  @override
  String get mapCache_clearCacheButton => 'Vider le cache';

  @override
  String mapCache_failedDownloads(int count) {
    return 'Téléchargements échoués : $count';
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
    return 'N $north, S $south, E $east, O $west';
  }

  @override
  String get time_justNow => 'Maintenant';

  @override
  String time_minutesAgo(int minutes) {
    return '$minutes minutes auparavant';
  }

  @override
  String time_hoursAgo(int hours) {
    return '${hours}h auparavant';
  }

  @override
  String time_daysAgo(int days) {
    return '$days jours avant';
  }

  @override
  String get time_hour => 'heure';

  @override
  String get time_hours => 'heures';

  @override
  String get time_day => 'jour';

  @override
  String get time_days => 'jours';

  @override
  String get time_week => 'semaine';

  @override
  String get time_weeks => 'semaines';

  @override
  String get time_month => 'mois';

  @override
  String get time_months => 'mois';

  @override
  String get time_minutes => 'minutes';

  @override
  String get time_allTime => 'Tout le temps';

  @override
  String get dialog_disconnect => 'Déconnecter';

  @override
  String get dialog_disconnectConfirm =>
      'Êtes-vous sûr de vouloir vous déconnecter de cet appareil ?';

  @override
  String get login_repeaterLogin => 'Connexion au répéteur';

  @override
  String get login_roomLogin => 'Connexion au room server';

  @override
  String get login_password => 'Mot de passe';

  @override
  String get login_enterPassword => 'Entrez votre mot de passe';

  @override
  String get login_savePassword => 'Sauvegarder le mot de passe';

  @override
  String get login_savePasswordSubtitle =>
      'Le mot de passe sera stocké en toute sécurité sur cet appareil.';

  @override
  String get login_repeaterDescription =>
      'Entrez le mot de passe du répéteur pour accéder aux paramètres et à l\'état.';

  @override
  String get login_roomDescription =>
      'Entrez le mot de passe de la pièce pour accéder aux paramètres et à l\'état.';

  @override
  String get login_routing => 'Redirection';

  @override
  String get login_routingMode => 'Mode de routage';

  @override
  String get login_autoUseSavedPath => 'Auto (utiliser le chemin sauvegardé)';

  @override
  String get login_forceFloodMode => 'Mode tout le réseau forcé';

  @override
  String get login_managePaths => 'Gérer les chemins';

  @override
  String get login_login => 'Connexion';

  @override
  String login_attempt(int current, int max) {
    return 'Essayer $current/$max';
  }

  @override
  String login_failed(String error) {
    return 'Connexion échouée : $error';
  }

  @override
  String get login_failedMessage =>
      'Connexion échouée. Soit le mot de passe est incorrect, soit le relais est injoignable.';

  @override
  String get common_reload => 'Recharger';

  @override
  String get common_clear => 'Effacer';

  @override
  String get path_currentPathLabel => 'Chemin actuel';

  @override
  String get path_noRepeatersFound => 'Aucun répéteur ou room server trouvé.';

  @override
  String get repeater_management => 'Gestion des répéteurs';

  @override
  String get room_management => 'Gestion du room server';

  @override
  String get repeater_guest => 'Informations sur les répéteurs';

  @override
  String get room_guest => 'Informations sur le serveur';

  @override
  String get repeater_managementTools => 'Outils de Gestion';

  @override
  String get repeater_guestTools => 'Outils pour les invités';

  @override
  String get repeater_status => 'État';

  @override
  String get repeater_statusSubtitle =>
      'Afficher l\'état, les statistiques et les voisins du répéteur';

  @override
  String get repeater_telemetry => 'Télémetrie';

  @override
  String get repeater_telemetrySubtitle =>
      'Afficher la télémétrie des capteurs et les statistiques du système';

  @override
  String get repeater_cli => 'CLI';

  @override
  String get repeater_cliSubtitle => 'Envoyer des commandes au répéteur';

  @override
  String get repeater_neighbors => 'Voisins';

  @override
  String get repeater_neighborsSubtitle => 'Afficher les voisins de saut nuls.';

  @override
  String get repeater_settings => 'Paramètres';

  @override
  String get repeater_settingsSubtitle =>
      'Configurer les paramètres du répéteur';

  @override
  String get repeater_clockSyncAfterLogin =>
      'Synchronisation de l\'horloge après la connexion';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      'Envoyer automatiquement une notification \"synchronisation de l\'heure\" après une connexion réussie.';

  @override
  String get repeater_statusTitle => 'État du répéteur';

  @override
  String get repeater_routingMode => 'Mode de routage';

  @override
  String get repeater_refresh => 'Rafraîchir';

  @override
  String get repeater_statusRequestTimeout =>
      'Demande de statut délai dépassé.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'Erreur lors du chargement du statut : $error';
  }

  @override
  String get repeater_systemInformation => 'Informations Système';

  @override
  String get repeater_battery => 'Batterie';

  @override
  String get repeater_clockAtLogin => 'Horloge (au démarrage)';

  @override
  String get repeater_uptime => 'Disponibilité';

  @override
  String get repeater_queueLength => 'Longueur de la file d\'attente';

  @override
  String get repeater_debugFlags => 'Marqueurs de débogage';

  @override
  String get repeater_radioStatistics => 'Statistiques Radio';

  @override
  String get repeater_lastRssi => 'Dernier RSSI';

  @override
  String get repeater_lastSnr => 'Dernier SNR';

  @override
  String get repeater_noiseFloor => 'Niveau de Bruit';

  @override
  String get repeater_txAirtime => 'TX Airtime';

  @override
  String get repeater_rxAirtime => 'RX Airtime';

  @override
  String get repeater_chanUtil => 'Utilisation du canal';

  @override
  String get repeater_packetStatistics => 'Statistiques des paquets';

  @override
  String get repeater_sent => 'Envoyé';

  @override
  String get repeater_received => 'Reçu';

  @override
  String get repeater_duplicates => 'Doublons';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days jours ${hours}h ${minutes}m ${seconds}s';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return 'Total : $total, Tout le réseau : $flood, Direct : $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return 'Total : $total, Tout le réseau : $flood, Direct : $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return 'Tout le réseau : $flood, Direct : $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return 'Total : $total';
  }

  @override
  String get repeater_settingsTitle => 'Paramètres du répéteur';

  @override
  String get repeater_basicSettings => 'Paramètres de base';

  @override
  String get repeater_repeaterName => 'Nom du répéteur';

  @override
  String get repeater_repeaterNameHelper => 'Afficher le nom de ce répéteur';

  @override
  String get repeater_adminPassword => 'Mot de passe Administrateur';

  @override
  String get repeater_adminPasswordHelper => 'Mot de passe d\'accès complet';

  @override
  String get repeater_guestPassword => 'Mot de passe invité';

  @override
  String get repeater_guestPasswordHelper =>
      'Accès en lecture seule avec mot de passe';

  @override
  String get repeater_radioSettings => 'Paramètres Radio';

  @override
  String get repeater_frequencyMhz => 'Fréquence (MHz)';

  @override
  String get repeater_frequencyHelper => '300-2500 MHz';

  @override
  String get repeater_txPower => 'TX Puissance';

  @override
  String get repeater_txPowerHelper => '1 à 30 dBm';

  @override
  String get repeater_bandwidth => 'Bande passante';

  @override
  String get repeater_spreadingFactor => 'Facteur de répartition (SF)';

  @override
  String get repeater_codingRate => 'Taux de codage (CR)';

  @override
  String get repeater_locationSettings => 'Paramètres de localisation';

  @override
  String get repeater_latitude => 'Latitude';

  @override
  String get repeater_latitudeHelper =>
      'Degrés décimaux (par exemple, 37.7749)';

  @override
  String get repeater_longitude => 'Longitude';

  @override
  String get repeater_longitudeHelper =>
      'Degrés décimaux (par exemple, -122,4194)';

  @override
  String get repeater_features => 'Fonctionnalités';

  @override
  String get repeater_packetForwarding => 'Mode répéteur';

  @override
  String get repeater_packetForwardingSubtitle =>
      'Activer le répéteur pour transmettre des paquets';

  @override
  String get repeater_guestAccess => 'Accès Invité';

  @override
  String get repeater_guestAccessSubtitle =>
      'Autoriser l\'accès invité en lecture seule';

  @override
  String get repeater_privacyMode => 'Mode de confidentialité';

  @override
  String get repeater_privacyModeSubtitle =>
      'Masquer le nom et la localisation dans les annonces';

  @override
  String get repeater_advertisementSettings => 'Paramètres d\'annonces';

  @override
  String get repeater_localAdvertInterval =>
      'Intervalle des annonces Locale (0 saut)';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes minutes';
  }

  @override
  String get repeater_floodAdvertInterval =>
      'Intervalle des annonces à tout le réseau (flood)';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours heures';
  }

  @override
  String get repeater_encryptedAdvertInterval =>
      'Intervalle d\'annonces cryptées';

  @override
  String get repeater_dangerZone => 'Zone dangereuse';

  @override
  String get repeater_rebootRepeater => 'Redémarrer Répéteur';

  @override
  String get repeater_rebootRepeaterSubtitle =>
      'Réinitialiser l\'appareil répéteur';

  @override
  String get repeater_rebootRepeaterConfirm =>
      'Êtes-vous sûr de vouloir redémarrer ce répéteur ?';

  @override
  String get repeater_regenerateIdentityKey => 'Ré générer la clé d\'identité';

  @override
  String get repeater_regenerateIdentityKeySubtitle =>
      'Générer une nouvelle paire de clés publique/privée';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'Cela générera une nouvelle identité pour le répéteur. Continuer ?';

  @override
  String get repeater_eraseFileSystem => 'Supprimer le système de fichiers';

  @override
  String get repeater_eraseFileSystemSubtitle =>
      'Formater le système de fichiers du répéteur';

  @override
  String get repeater_eraseFileSystemConfirm =>
      'AVERTISSEMENT : Cela effacera toutes les données du répéteur. Cela ne peut pas être annulé !';

  @override
  String get repeater_eraseSerialOnly =>
      'Erase n\'est disponible que via la console série.';

  @override
  String repeater_commandSent(String command) {
    return 'Commande envoyée : $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'Erreur lors de l\'envoi de la commande : $error';
  }

  @override
  String get repeater_confirm => 'Confirmer';

  @override
  String get repeater_settingsSaved =>
      'Les paramètres ont été enregistrés avec succès.';

  @override
  String get repeater_rxGain => 'Augmentation du rendement de RX';

  @override
  String get repeater_rxGainHelper =>
      'Meilleure sensibilité, consommation de courant plus élevée (uniquement pour les modèles SX1262/SX1268)';

  @override
  String get repeater_refreshRxGain =>
      'Renforcer les gains de RX grâce à la mise à jour';

  @override
  String get repeater_multiAcks => 'Plusieurs accusés de réception';

  @override
  String get repeater_multiAcksSubtitle =>
      'Valider les messages via plusieurs chemins pour une meilleure livraison.';

  @override
  String get repeater_refreshMultiAcks =>
      'Renvoyer plusieurs accusés de réception';

  @override
  String get repeater_networkHealth => 'Santé du réseau';

  @override
  String get repeater_loopDetect => 'Détection de boucles';

  @override
  String get repeater_loopDetectHelper =>
      'Envoyer des paquets de données qui semblent former des boucles de routage.';

  @override
  String get repeater_loopDetectOff => 'Désactivé';

  @override
  String get repeater_loopDetectMinimal => 'Minimal';

  @override
  String get repeater_loopDetectModerate => 'Modéré';

  @override
  String get repeater_loopDetectStrict => 'Strict';

  @override
  String get repeater_dutyCycle => 'Cycle de fonctionnement';

  @override
  String get repeater_dutyCycleHelper =>
      'Pourcentage maximal de temps d\'antenne';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => 'Informations sur le propriétaire';

  @override
  String get repeater_ownerInfoHelper =>
      'Métadonnées publiques pour cet appareil';

  @override
  String get repeater_refreshOwnerInfo =>
      'Rafraîchir les informations du propriétaire';

  @override
  String get repeater_floodMax => 'Nombre maximal de sauts en flood';

  @override
  String get repeater_floodMaxHelper =>
      'Nombre maximal de paquets de données qu\'un flux peut transmettre (0-64)';

  @override
  String get repeater_advancedSettings => 'Avancé';

  @override
  String get repeater_advancedSettingsSubtitle =>
      'Réglages avancés pour les opérateurs expérimentés';

  @override
  String get repeater_pathHashMode => 'Mode de hachage de chemin';

  @override
  String get repeater_pathHashModeHelper =>
      'Octets utilisés pour encoder l\'ID de ce routeur dans les balises de détection de flux/boucles. 0 = 1 octet (256 ID, jusqu\'à 64 sauts), 1 = 2 octets (65 000 ID, jusqu\'à 32 sauts), 2 = 3 octets (16 millions d\'ID, jusqu\'à 21 sauts). Les versions 1.13 et antérieures utilisent des chemins multi-octets ; à partir de la version 1.14, cela n\'est plus nécessaire.';

  @override
  String get repeater_keySettings => 'Modifier les clés d\'identité';

  @override
  String get repeater_keySettingsSubtitle =>
      'Modifier la paire de clés publique/privée';

  @override
  String get repeater_prvKey => 'Clé privée';

  @override
  String get repeater_prvKeyHelper =>
      'Une nouvelle clé privée pour le répéteur, une chaîne hexadécimale de 128 caractères.';

  @override
  String get repeater_generatePrvKey => 'Générez une paire de clés aléatoire';

  @override
  String get repeater_stopGeneratingPrvKey =>
      'Arrêter la recherche de la paire de clés';

  @override
  String get repeater_pubKey => 'Clé publique';

  @override
  String get repeater_pubKeyHelper =>
      'Voici la clé publique associée à la clé privée générée. Vous ne pouvez pas la définir directement.';

  @override
  String get repeater_pubKeyPrefix => 'Préfixe souhaité';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'Trouvez une clé publique qui commence par ces chiffres hexadécimaux. Nombre de tentatives nécessaires : $tries.';
  }

  @override
  String get repeater_txDelay => 'Délai de transmission en flood';

  @override
  String get repeater_txDelayHelper =>
      'Intervalle de retransmission pour le trafic flood, en multipliant le temps d\'émission des paquets (0-2, valeur par défaut : 0,5). Une valeur plus élevée réduit les collisions, mais ralentit la transmission.';

  @override
  String get repeater_directTxDelay => 'Délai de transmission direct';

  @override
  String get repeater_directTxDelayHelper =>
      'Intervalle de retransmission pour le trafic direct (non flood), en multipliant le temps de transmission des paquets (0-2, valeur par défaut : 0,3).';

  @override
  String get repeater_intThresh => 'Seuil de perturbation';

  @override
  String get repeater_intThreshHelper =>
      'Seuil dépassé pour la calibration du niveau de bruit de la radio, afin de rejeter les interférences supérieures à ce niveau. 0 désactive – ne mettez cette valeur que si vous constatez des erreurs RX dans une bande de fréquences bruyante.';

  @override
  String get repeater_agcResetInterval =>
      'Intervalle de réinitialisation de l\'AGC';

  @override
  String get repeater_agcResetIntervalHelper =>
      'À quelle fréquence réinitialiser le contrôle automatique du gain de la radio pour revenir à un état normal ? Chaque seconde, ou à chaque multiple de 4. Désactiver la réinitialisation périodique avec 0.';

  @override
  String get repeater_actionsTitle => 'Actions';

  @override
  String get repeater_sendAdvert => 'Envoyer une annonce flood';

  @override
  String get repeater_sendAdvertSubtitle =>
      'Diffuser une annonce flood via le réseau.';

  @override
  String get repeater_sendAdvertZeroHop => 'Envoyer une annonce sans relais';

  @override
  String get repeater_sendAdvertZeroHopSubtitle =>
      'Diffuser une annonce d\'un seul saut (sans relais)';

  @override
  String get repeater_clockSync => 'Synchroniser l\'heure maintenant';

  @override
  String get repeater_clockSyncSubtitle =>
      'Envoyez l\'heure de votre téléphone au répéteur.';

  @override
  String repeater_actionSucceeded(String action) {
    return '$action a réussi';
  }

  @override
  String repeater_actionFailed(String action, String error) {
    return '$action a échoué : $error';
  }

  @override
  String get repeater_settingsSavedRebootNeeded =>
      'Paramètres sauvegardés — redémarrer le répéteur pour appliquer les modifications.';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return 'Certaines configurations ont échoué : $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return 'Erreur lors de la sauvegarde des paramètres : $error';
  }

  @override
  String get repeater_refreshBasicSettings =>
      'Rafraîchir les paramètres de base';

  @override
  String get repeater_refreshRadioSettings => 'Rafraîchir les paramètres Radio';

  @override
  String get repeater_refreshTxPower => 'Rafraîchir la puissance TX';

  @override
  String get repeater_refreshPacketForwarding =>
      'Rafraîchir le routage des paquets';

  @override
  String get repeater_refreshGuestAccess => 'Rafraîchir l\'accès invité';

  @override
  String get repeater_refreshPrivacyMode =>
      'Rafraîchir le Mode Confidentialité';

  @override
  String repeater_refreshed(String label) {
    return '$label rafraîchi';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return 'Erreur lors du rafraîchissement de $label';
  }

  @override
  String get repeater_cliTitle => 'CLI du répéteur';

  @override
  String get repeater_debugNextCommand => 'Déboguer la prochaine commande';

  @override
  String get repeater_commandHelp => 'Aide';

  @override
  String get repeater_clearHistory => 'Effacer l\'historique';

  @override
  String get repeater_noCommandsSent =>
      'Aucune commande n\'a encore été envoyée.';

  @override
  String get repeater_typeCommandOrUseQuick =>
      'Saisissez une commande ci-dessous ou utilisez les commandes rapides';

  @override
  String get repeater_enterCommandHint => 'Entrer la commande...';

  @override
  String get repeater_previousCommand => 'Commande précédente';

  @override
  String get repeater_nextCommand => 'Prochaine commande';

  @override
  String get repeater_enterCommandFirst => 'Entrez d\'abord une commande';

  @override
  String get repeater_cliCommandFrameTitle => 'Frame de commande CLI';

  @override
  String repeater_cliCommandError(String error) {
    return 'Erreur : $error';
  }

  @override
  String get repeater_cliQuickGetName => 'Obtenir le nom';

  @override
  String get repeater_cliQuickGetRadio => 'Obtenir la radio';

  @override
  String get repeater_cliQuickGetTx => 'Obtenir TX';

  @override
  String get repeater_cliQuickNeighbors => 'Voisins';

  @override
  String get repeater_cliQuickVersion => 'Version';

  @override
  String get repeater_cliQuickAdvertise => 'Diffuser';

  @override
  String get repeater_cliQuickClock => 'Horloge';

  @override
  String get repeater_cliQuickClockSync => 'Synchronisation de l\'horloge';

  @override
  String get repeater_cliQuickDiscovery => 'Découvrir les voisins';

  @override
  String get repeater_cliHelpAdvert => 'Envoie un paquet d\'annonce';

  @override
  String get repeater_cliHelpReboot =>
      'Redémarre l\'appareil. (Note, vous risquez d\'obtenir \'Timeout\' ce qui est normal)';

  @override
  String get repeater_cliHelpClock =>
      'Affiche l\'heure actuelle par l\'horloge de chaque appareil.';

  @override
  String get repeater_cliHelpPassword =>
      'Définit un nouveau mot de passe administrateur pour l\'appareil.';

  @override
  String get repeater_cliHelpVersion =>
      'Affiche la version du périphérique et la date de construction du micrologiciel.';

  @override
  String get repeater_cliHelpClearStats =>
      'Réinitialise divers compteurs de statistiques à zéro.';

  @override
  String get repeater_cliHelpSetAf => 'Définit le facteur de temps d\'air.';

  @override
  String get repeater_cliHelpSetTx =>
      'Définit la puissance de transmission LoRa en dBm (réinitialisation requise pour appliquer).';

  @override
  String get repeater_cliHelpSetRepeat =>
      'Active ou désactive le rôle du répéteur pour ce nœud.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(Room server) Si \"activé\", alors un mot de passe vide permettra la connexion, mais ne permettra pas de publier dans la pièce. (lecture seule uniquement)';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'Définit le nombre maximal de sauts pour les paquets de balayage entrants (si >= max, le paquet n\'est pas acheminé).';

  @override
  String get repeater_cliHelpSetIntThresh =>
      'Définit le seuil d\'interférence (en dB). La valeur par défaut est de 14. Définir sur 0 désactive la détection des interférences de canal.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'Définit l\'intervalle pour réinitialiser le contrôleur de gain automatique. Mettez à 0 pour désactiver.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      'Active ou désactive la fonctionnalité « double ACKs ».';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'Définit l\'intervalle entre chaque émission d\'une annonce locale (sans relais). Définir sur 0 pour désactiver.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'Définit l\'intervalle du minuteur en heures pour envoyer un paquet d\'annonce massive. Définir sur 0 pour désactiver.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'Définit/met à jour le mot de passe de l\'invité. (pour les répéteurs, les connexions d\'invités peuvent envoyer la requête \"Get Stats\")';

  @override
  String get repeater_cliHelpSetName => 'Définit le nom de l\'annonce.';

  @override
  String get repeater_cliHelpSetLat =>
      'Définit la latitude de la carte des annonces. (degrés décimaux)';

  @override
  String get repeater_cliHelpSetLon =>
      'Définit la longitude de la carte de l\'annonce. (degrés décimaux)';

  @override
  String get repeater_cliHelpSetRadio =>
      'Définit complètement de nouveaux paramètres de radio et les enregistre dans les préférences. Nécessite une commande \"redémarrage\" pour les appliquer.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      'Paramètres (expérimental) de base pour appliquer un léger délai aux paquets reçus, en fonction de la force du signal/score. Définir sur 0 pour désactiver.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      'Définit un facteur multiplié par le temps de fonctionnement en mode vers tout le réseau (flood) pour un paquet et avec un système de slot aléatoire, afin de retarder son envoi (pour diminuer la probabilité de collisions).';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'Identique à txdelay, mais pour appliquer un délai aléatoire au transfert des paquets en mode direct.';

  @override
  String get repeater_cliHelpSetBridgeEnabled => 'Activer/Désactiver le pont.';

  @override
  String get repeater_cliHelpSetBridgeDelay =>
      'Définir le délai avant de renvoyer les paquets.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      'Choisissez si le pont retransmettra les paquets reçus ou les paquets transmis.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'Définir la vitesse de communication série pour les ponts Rs232.';

  @override
  String get repeater_cliHelpSetBridgeSecret =>
      'Définir le secret du pont pour les ponts espnow.';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      'Définit un facteur personnalisé pour ajuster la tension de la batterie signalée (uniquement pris en charge sur certains cartes).';

  @override
  String get repeater_cliHelpTempRadio =>
      'Définit des paramètres radio temporaires pour le nombre de minutes donné, puis revient aux paramètres radio d\'origine. (ne sauvegarde pas dans les préférences).';

  @override
  String get repeater_cliHelpSetPerm =>
      'Modifie l’ACL. Supprime l’entrée correspondante (par préfixe de clé publique) si \"permissions\" est égal à zéro. Ajoute une nouvelle entrée si la clé publique hexadécimale a une longueur complète et n’est pas actuellement dans l’ACL. Met à jour l’entrée en fonction du préfixe de clé publique. Les bits de permission varient en fonction du rôle du firmware, mais les 2 bits inférieurs sont : 0 (Invité), 1 (Lecture seule), 2 (Lecture/écriture), 3 (Administrateur).';

  @override
  String get repeater_cliHelpGetBridgeType =>
      'Obtenir le type de pont : aucun, rs232, espnow';

  @override
  String get repeater_cliHelpLogStart =>
      'Démarre l\'enregistrement des paquets dans le système de fichiers.';

  @override
  String get repeater_cliHelpLogStop =>
      'Arrêter de journaliser les paquets vers le système de fichiers.';

  @override
  String get repeater_cliHelpLogErase =>
      'Supprime les journaux de paquets du système de fichiers.';

  @override
  String get repeater_cliHelpNeighbors =>
      'Affiche une liste d\'autres nœuds répéteurs entendus via des annonces sans relais. Chaque ligne est id-préfixe-hexadécimal:timestamp:snr-fois-4';

  @override
  String get repeater_cliHelpNeighborRemove =>
      'Supprime la première entrée correspondante (par préfixe de clé publique (hexadécimal)) de la liste des voisins.';

  @override
  String get repeater_cliHelpRegion =>
      '(série uniquement) Liste toutes les régions définies et les autorisations actuelles d\'annonces sur tout le réseau (flood).';

  @override
  String get repeater_cliHelpRegionLoad =>
      'REMARQUE : il s\'agit d\'une invocation multi-commande spéciale. Chaque commande subséquente est un nom de région (indenté avec des espaces pour indiquer la hiérarchie parent, avec un minimum d\'un espace). Terminé par l\'envoi d\'une ligne vide/commande.';

  @override
  String get repeater_cliHelpRegionGet =>
      'Recherche la région avec le préfixe de nom donné (ou \"\" pour l\'étendue globale). Répond avec \"-> nom-de-région (nom-parent) \'F\'\"';

  @override
  String get repeater_cliHelpRegionPut =>
      'Ajoute ou met à jour une définition de région avec le nom donné.';

  @override
  String get repeater_cliHelpRegionRemove =>
      'Supprime une définition de région avec le nom donné.';

  @override
  String get repeater_cliHelpRegionAllowf =>
      'Définit les autorisations de \"Flot\" pour la région donnée. (\'\' pour la portée globale/héritée)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      'Supprime l\'autorisation \'F\'lood\' pour la région donnée. (NOTE : à ce stade, il n\'est pas conseillé de l\'utiliser sur l\'étendue globale/héritée !! )';

  @override
  String get repeater_cliHelpRegionHome =>
      'Répond avec la région \'maison\' actuelle. (Note appliquée nulle part pour l\'instant, réservée à une utilisation future)';

  @override
  String get repeater_cliHelpRegionHomeSet => 'Définit la région \'maison\'.';

  @override
  String get repeater_cliHelpRegionSave =>
      'Conserve la liste/la carte des régions dans le stockage.';

  @override
  String get repeater_cliHelpGps =>
      'Affiche l’état du GPS. Lorsque le GPS est éteint, il répond uniquement « éteint », si allumé, il répond avec « allumé », l’état, la correction, le nombre de satellites.';

  @override
  String get repeater_cliHelpGpsOnOff => 'Activer/désactiver le GPS.';

  @override
  String get repeater_cliHelpGpsSync =>
      'Synchronise l\'heure du nœud avec l\'horloge GPS.';

  @override
  String get repeater_cliHelpGpsSetLoc =>
      'Définit la position du nœud aux coordonnées GPS et enregistre les préférences.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'Donne la configuration de l\'annonce de la localisation du nœud :\n- none : ne pas inclure la localisation dans les annonces\n- share : partager la localisation GPS (du SensorManager)\n- prefs : annoncer la localisation stockée dans les préférences';

  @override
  String get repeater_cliHelpGpsAdvertSet =>
      'Définit la configuration de l\'annonce de localisation.';

  @override
  String get repeater_commandsListTitle => 'Liste des commandes';

  @override
  String get repeater_commandsListNote =>
      'NOTE : pour les diverses commandes « set »..., il existe également une commande « get »...';

  @override
  String get repeater_general => 'Général';

  @override
  String get repeater_settingsCategory => 'Paramètres';

  @override
  String get repeater_bridge => 'Pont';

  @override
  String get repeater_logging => 'Journalisation';

  @override
  String get repeater_neighborsRepeaterOnly => 'Voisins (Uniquement répéteur)';

  @override
  String get repeater_regionManagementRepeaterOnly =>
      'Gestion des régions (uniquement pour le répéteur)';

  @override
  String get repeater_regionNote =>
      'Les commandes de région ont été introduites pour gérer les définitions et les autorisations des régions.';

  @override
  String get repeater_gpsManagement => 'Gestion GPS';

  @override
  String get repeater_gpsNote =>
      'La commande GPS a été introduite pour gérer les sujets liés à la localisation.';

  @override
  String get repeater_getCategory => 'Obtenir des valeurs';

  @override
  String get repeater_powerMgmt => 'Gestion de l\'énergie';

  @override
  String get repeater_sensors => 'Capteurs';

  @override
  String get repeater_cliHelpPowerOff =>
      'Éteint l\'appareil. (aucune réponse n\'est attendue)';

  @override
  String get repeater_cliHelpClkReboot =>
      'Réinitialise l\'horloge à une époque connue et redémarre l\'appareil.';

  @override
  String get repeater_cliHelpAdvertZeroHop =>
      'Envoie une publicité sans intermédiaire (uniquement aux voisins immédiats).';

  @override
  String get repeater_cliHelpStartOta =>
      'Démarre une mise à jour du firmware par voie radio sur les cartes prises en charge.';

  @override
  String get repeater_cliHelpTime =>
      'Définit l\'heure de l\'appareil sur les secondes de l\'époque Unix spécifiée. L\'heure ne peut pas reculer.';

  @override
  String get repeater_cliHelpBoard =>
      'Indique le fabricant du panneau / l\'identifiant du matériel.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      'Envoie une requête de découverte de nœuds aux voisins proches. (Uniquement pour les répéteurs)';

  @override
  String get repeater_cliHelpPowersaving =>
      'Indique si le mode d\'économie d\'énergie est activé ou désactivé.';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      'Active ou désactive le mode d\'économie d\'énergie (si pris en charge).';

  @override
  String get repeater_cliHelpErase =>
      '(Uniquement pour les appareils) Formate le système de fichiers de l\'appareil. Efface tous les paramètres et les contacts.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      'Définit le cycle de transmission maximal autorisé en pourcentage (de 1 à 100). Ajuste automatiquement le facteur de temps d\'émission.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '(Uniquement pour les séries) Remplace la clé privée d\'identification de l\'appareil. Un redémarrage est nécessaire pour appliquer. Génère une nouvelle clé publique.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(Uniquement pour les SX126x) Active le gain RX amplifié pour une meilleure sensibilité à des courants plus élevés.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      'Définit la chaîne d\'informations de contact du propriétaire, qui figure dans les annonces. Utilisez \'|\' pour les sauts de ligne.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'Définit le mode de hachage de chemin. 0 = mode ancien, 1 = mode standard, 2 = mode strict. Influence la façon dont les chemins de routage sont correspondus.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'Définit la sensibilité de la détection des boucles de routage : désactivée, minimale, modérée ou stricte.';

  @override
  String get repeater_cliHelpSetFreq =>
      '(Uniquement pour les modèles série) Permet de régler rapidement la fréquence. Redémarrage nécessaire. Il est préférable d\'utiliser l\'option \"réglage radio\" pour configurer tous les paramètres radio.';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(Uniquement pour le pont ESPNow) Définit le canal WiFi (de 1 à 14) utilisé par le pont.';

  @override
  String get repeater_cliHelpGetName => 'Affiche le nom du nœud configuré.';

  @override
  String get repeater_cliHelpGetRole =>
      'Indique le rôle du firmware (répéteur, serveur de pièce, etc.).';

  @override
  String get repeater_cliHelpGetPublicKey =>
      'Affiche la clé publique du dispositif.';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '(Uniquement pour les séries) Affiche la clé privée de l\'appareil. Traitez-la comme une information confidentielle.';

  @override
  String get repeater_cliHelpGetRepeat =>
      'Indique si le transfert de paquets (en tant que routeur) est activé ou désactivé.';

  @override
  String get repeater_cliHelpGetTx => 'Indique la puissance actuelle en dBm.';

  @override
  String get repeater_cliHelpGetFreq =>
      'Affiche la fréquence radio configurée en MHz.';

  @override
  String get repeater_cliHelpGetRadio =>
      'Affiche tous les paramètres radio : fréquence, largeur de bande, facteur de dispersion, taux de codage.';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(Uniquement pour les SX126x) Affiche l\'état du gain amplifié de la réception.';

  @override
  String get repeater_cliHelpGetAf =>
      'Indique le facteur de temps d\'antenne actuel.';

  @override
  String get repeater_cliHelpGetDutyCycle =>
      'Affiche le cycle de fonctionnement actuel autorisé en pourcentage.';

  @override
  String get repeater_cliHelpGetIntThresh =>
      'Indique le seuil d\'interférence du canal en dB.';

  @override
  String get repeater_cliHelpGetAgcResetInterval =>
      'Indique l\'intervalle de réinitialisation de l\'AGC en secondes.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      'Indique si le mode \"double ACK\" est activé (1) ou désactivé (0).';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'Indique si l\'accès en lecture seule pour les invités est autorisé.';

  @override
  String get repeater_cliHelpGetAdvertInterval =>
      'Indique l\'intervalle publicitaire local en minutes.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'Indique l\'intervalle publicitaire pour la diffusion de l\'annonce en heures.';

  @override
  String get repeater_cliHelpGetGuestPassword =>
      'Affiche le mot de passe invité configuré.';

  @override
  String get repeater_cliHelpGetLat => 'Affiche la latitude configurée.';

  @override
  String get repeater_cliHelpGetLon => 'Affiche la longitude configurée.';

  @override
  String get repeater_cliHelpGetRxDelay =>
      'Affiche la valeur de base de rxdelay.';

  @override
  String get repeater_cliHelpGetTxDelay =>
      'Indique le facteur de délai de transmission en mode flood.';

  @override
  String get repeater_cliHelpGetDirectTxDelay =>
      'Indique le facteur de délai direct.';

  @override
  String get repeater_cliHelpGetFloodMax =>
      'Indique le nombre maximal de fois où le niveau de l\'eau a atteint son point culminant.';

  @override
  String get repeater_cliHelpGetOwnerInfo =>
      'Affiche la chaîne d\'informations de contact du propriétaire.';

  @override
  String get repeater_cliHelpGetPathHashMode =>
      'Affiche le mode \"hash de chemin\" (0/1/2).';

  @override
  String get repeater_cliHelpGetLoopDetect =>
      'Illustre la sensibilité à la détection des boucles.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(Uniquement pour les séries) Liste les entrées de contrôle d\'accès sur un répéteur.';

  @override
  String get repeater_cliHelpGetBridgeEnabled =>
      'Indique si le pont est activé.';

  @override
  String get repeater_cliHelpGetBridgeDelay =>
      'Indique le délai du pont en millisecondes.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'Indique si le pont transmet des paquets RX ou TX.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(Uniquement pour le pont RS232) Affiche la vitesse de communication du pont.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(Uniquement pour le pont ESPNow) Affiche le canal WiFi du pont.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(Uniquement pour le pont ESPNow) Affiche la clé partagée du pont.';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '(Uniquement pour le NRF52) Affiche la version du chargeur initial.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'Affiche le multiplicateur de l\'ADC (mise à l\'échelle de la tension de la batterie).';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      'Indique si le système dispose de fonctionnalités de gestion de l\'alimentation.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      'Indique la source d\'alimentation actuelle : externe ou batterie.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      'Indique les raisons les plus récentes de réinitialisation et d\'arrêt.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv =>
      'Affiche la tension de la batterie au démarrage, en millivolts (mV).';

  @override
  String get repeater_cliHelpSensorGet =>
      'Lit une valeur de configuration personnalisée pour un capteur en utilisant une touche.';

  @override
  String get repeater_cliHelpSensorSet =>
      'Crée une configuration personnalisée pour un capteur.';

  @override
  String get repeater_cliHelpSensorList =>
      'Affiche toutes les configurations de capteurs personnalisées, avec une pagination à partir d\'un index de départ optionnel.';

  @override
  String get repeater_cliHelpRegionDefault =>
      'Affiche la portée régionale par défaut actuelle.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'Définit la portée régionale par défaut. Utilisez \"<null>\" pour la réinitialiser.';

  @override
  String get repeater_cliHelpRegionListAllowed =>
      'Énumère les régions autorisant la circulation des véhicules en cas de flood.';

  @override
  String get repeater_cliHelpRegionListDenied =>
      'Liste les régions qui interdisent la circulation en cas de flood.';

  @override
  String get repeater_cliHelpStatsPackets =>
      '(Uniquement pour les séries) Affiche des statistiques au niveau des paquets.';

  @override
  String get repeater_cliHelpStatsRadio =>
      '(Uniquement pour les séries) Affiche les statistiques de la radio.';

  @override
  String get repeater_cliHelpStatsCore =>
      '(Uniquement pour les séries) Affiche les statistiques du micrologicem intégré.';

  @override
  String get telemetry_receivedData => 'Données de télémétrie reçues';

  @override
  String get telemetry_requestTimeout => 'Demande de télémétrie expirée.';

  @override
  String telemetry_errorLoading(String error) {
    return 'Erreur lors du chargement de la télémétrie : $error';
  }

  @override
  String get telemetry_noData => 'Aucune donnée de télémétrie disponible.';

  @override
  String telemetry_channelTitle(int channel) {
    return 'Canal $channel';
  }

  @override
  String get telemetry_batteryLabel => 'Batterie';

  @override
  String get telemetry_voltageLabel => 'Tension';

  @override
  String get telemetry_mcuTemperatureLabel => 'Température du MCU';

  @override
  String get telemetry_temperatureLabel => 'Température';

  @override
  String get telemetry_currentLabel => 'Actuellement';

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
  String get telemetry_digitalInputLabel => 'Entrée numérique';

  @override
  String get telemetry_digitalOutputLabel => 'Sortie numérique';

  @override
  String get telemetry_analogInputLabel => 'Entrée analogique';

  @override
  String get telemetry_analogOutputLabel => 'Sortie analogique';

  @override
  String get telemetry_genericLabel => 'Capteur générique';

  @override
  String get telemetry_luminosityLabel => 'Luminosité';

  @override
  String get telemetry_presenceLabel => 'Présence';

  @override
  String get telemetry_humidityLabel => 'Humidité';

  @override
  String get telemetry_accelerometerLabel => 'Accéléromètre';

  @override
  String get telemetry_pressureLabel => 'Pression';

  @override
  String get telemetry_altitudeLabel => 'Altitude';

  @override
  String get telemetry_frequencyLabel => 'Fréquence';

  @override
  String get telemetry_percentageLabel => 'Pourcentage';

  @override
  String get telemetry_concentrationLabel => 'Concentration';

  @override
  String get telemetry_powerLabel => 'Puissance';

  @override
  String get telemetry_distanceLabel => 'Distance';

  @override
  String get telemetry_energyLabel => 'Énergie';

  @override
  String get telemetry_directionLabel => 'Direction';

  @override
  String get telemetry_timeLabel => 'Heure';

  @override
  String get telemetry_gyrometerLabel => 'Gyromètre';

  @override
  String get telemetry_colourLabel => 'Couleur';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'Interrupteur';

  @override
  String get telemetry_polylineLabel => 'Polyligne';

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
  String get telemetry_autoFetchQuantity => 'Nombre de requêtes';

  @override
  String get telemetry_error => 'Impossible de récupérer les données';

  @override
  String get neighbors_receivedData => 'Données des voisins reçues';

  @override
  String get neighbors_requestTimedOut => 'Les voisins demandent un délai.';

  @override
  String neighbors_errorLoading(String error) {
    return 'Erreur lors du chargement des voisins : $error';
  }

  @override
  String get neighbors_repeatersNeighbors => 'Répéteurs Voisins';

  @override
  String get neighbors_noData =>
      'Aucune donnée concernant les voisins disponible.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return 'Clé publique inconnue $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return 'Écouté : $time auparavant';
  }

  @override
  String get channelPath_title => 'Chemin de paquet';

  @override
  String get channelPath_viewMap => 'Afficher la carte';

  @override
  String get channelPath_otherObservedPaths => 'Autres chemins observés';

  @override
  String get channelPath_repeaterHops => 'Sauts du répéteur';

  @override
  String get channelPath_noHopDetails =>
      'Les détails de l\'envoi ne sont pas fournis pour ce paquet.';

  @override
  String get channelPath_sourceLabel => 'Source';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'Ce message est arrivé par MQTT. Votre radio ne l\'a pas entendu, il n\'y a donc pas de chemin radio depuis votre radio.';

  @override
  String get channelPath_messageDetails => 'Détails du message';

  @override
  String get channelPath_senderLabel => 'Expéditeur';

  @override
  String get channelPath_timeLabel => 'Temps';

  @override
  String get channelPath_repeatsLabel => 'Répétitions';

  @override
  String channelPath_pathLabel(int index) {
    return 'Chemin $index';
  }

  @override
  String get channelPath_observedLabel => 'Observé';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return 'Chemin observé $index • $hops';
  }

  @override
  String get channelPath_noLocationData => 'Aucune donnée de localisation';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => 'Inconnu';

  @override
  String get channelPath_floodPath => 'Tout le réseau';

  @override
  String get channelPath_directPath => 'Afficher';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 de $total sauts';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed sur $total sauts';
  }

  @override
  String get channelPath_mapTitle => 'Carte du chemin';

  @override
  String get channelPath_noRepeaterLocations =>
      'Aucune position de répéteur disponible pour ce chemin.';

  @override
  String channelPath_primaryPath(int index) {
    return 'Chemin $index (Principal)';
  }

  @override
  String get channelPath_pathLabelTitle => 'Chemin';

  @override
  String get channelPath_observedPathHeader => 'Chemin observé';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable =>
      'Aucun détail de saut disponible pour ce paquet.';

  @override
  String get channelPath_unknownRepeater => 'Répéteur Inconnu';

  @override
  String get community_title => 'Communauté';

  @override
  String get community_create => 'Créer une Communauté';

  @override
  String get community_createDesc =>
      'Créer une nouvelle communauté et la partager via QR code.';

  @override
  String get community_join => 'Rejoindre';

  @override
  String get community_joinTitle => 'Rejoindre la communauté';

  @override
  String community_joinConfirmation(String name) {
    return 'Souhaitez-vous rejoindre la communauté \"$name\" ?';
  }

  @override
  String get community_scanQr => 'Scanner un QR code de communauté';

  @override
  String get community_scanInstructions =>
      'Pointez l\'appareil photo vers un QR code de communauté.';

  @override
  String get community_showQr => 'Afficher le QR Code';

  @override
  String get community_publicChannel => 'Communauté Publique';

  @override
  String get community_hashtagChannel => 'Hashtag Communauté';

  @override
  String get community_name => 'Nom de la communauté';

  @override
  String get community_enterName => 'Entrez le nom de la communauté';

  @override
  String community_created(String name) {
    return 'Communauté \"$name\" créée';
  }

  @override
  String community_joined(String name) {
    return 'Rejoint la communauté \"$name\"';
  }

  @override
  String get community_qrTitle => 'Partager Communauté';

  @override
  String community_qrInstructions(String name) {
    return 'Scanner ce QR code pour rejoindre $name';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'Les canaux hashtag de la communauté ne sont accessibles qu\'aux membres de la communauté';

  @override
  String get community_invalidQrCode => 'QR code de communauté non valide';

  @override
  String get community_alreadyMember => 'Déjà membre';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'Vous êtes déjà membre de \"$name\".';
  }

  @override
  String get community_addPublicChannel =>
      'Ajouter un Canal Public de la Communauté';

  @override
  String get community_addPublicChannelHint =>
      'Ajouter automatiquement le canal public pour cette communauté';

  @override
  String get community_noCommunities =>
      'Aucun groupe n\'a été rejoint pour le moment.';

  @override
  String get community_scanOrCreate =>
      'Scanner un QR code ou créer une communauté pour commencer';

  @override
  String get community_manageCommunities => 'Gérer les Communautés';

  @override
  String get community_delete => 'Quitter la communauté';

  @override
  String community_deleteConfirm(String name) {
    return 'Quitter \"$name\" ?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return 'Cela supprimera également $count canal/canaux et leurs messages.';
  }

  @override
  String community_deleted(String name) {
    return 'Communauté \"$name\" quittée';
  }

  @override
  String get community_regenerateSecret => 'Régénérer le secret';

  @override
  String community_regenerateSecretConfirm(String name) {
    return 'Régénérer la clé secrète pour \"$name\" ? Tous les membres devront scanner le nouveau QR code pour continuer à communiquer.';
  }

  @override
  String get community_regenerate => 'Régénérer';

  @override
  String community_secretRegenerated(String name) {
    return 'Mot de passe secret régénéré pour \"$name\"';
  }

  @override
  String get community_updateSecret => 'Mettre à jour le secret';

  @override
  String community_secretUpdated(String name) {
    return 'Modification secrète mise à jour pour \"$name\"';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return 'Scanner le nouveau QR code pour mettre à jour le mot de passe pour \"$name\"';
  }

  @override
  String get community_addHashtagChannel => 'Ajouter un Hashtag Communauté';

  @override
  String get community_addHashtagChannelDesc =>
      'Ajouter un canal hashtag pour cette communauté';

  @override
  String get community_selectCommunity => 'Sélectionner Communauté';

  @override
  String get community_regularHashtag => 'Hashtag régulier';

  @override
  String get community_regularHashtagDesc =>
      'Hashtag public (tout le monde peut rejoindre)';

  @override
  String get community_communityHashtag => 'Hashtag de la communauté';

  @override
  String get community_communityHashtagDesc =>
      'Exclusif aux membres de la communauté';

  @override
  String community_forCommunity(String name) {
    return 'Pour $name';
  }

  @override
  String get listFilter_tooltip => 'Filtrer et trier';

  @override
  String get listFilter_sortBy => 'Trier par';

  @override
  String get listFilter_latestMessages => 'Derniers messages';

  @override
  String get listFilter_heardRecently => 'Écoute récemment';

  @override
  String get listFilter_az => 'A à Z';

  @override
  String get listFilter_filters => 'Filtres';

  @override
  String get listFilter_all => 'Tout';

  @override
  String get listFilter_favorites => 'Préférences';

  @override
  String get listFilter_addToFavorites => 'Ajouter à mes favoris';

  @override
  String get listFilter_removeFromFavorites => 'Supprimer des favoris';

  @override
  String get listFilter_users => 'Utilisateurs';

  @override
  String get listFilter_repeaters => 'Répéteurs';

  @override
  String get listFilter_roomServers => 'Serveurs de salle';

  @override
  String get listFilter_unreadOnly => 'Messages non lus seulement';

  @override
  String get listFilter_newGroup => 'Nouveau groupe';

  @override
  String get pathTrace_you => 'Vous';

  @override
  String get pathTrace_failed => 'Échec du traçage du chemin.';

  @override
  String get pathTrace_notAvailable => 'Le traçage du chemin est indisponible.';

  @override
  String get pathTrace_refreshTooltip => 'Actualiser le traçage du chemin';

  @override
  String get pathTrace_someHopsNoLocation =>
      'Un ou plusieurs des sauts manquent d\'une localisation !';

  @override
  String get pathTrace_clearTooltip => 'Effacer le chemin';

  @override
  String get losSelectStartEnd =>
      'Sélectionnez les nœuds de début et de fin pour LOS.';

  @override
  String losRunFailed(String error) {
    return 'Échec de la vérification de la ligne de vue : $error';
  }

  @override
  String get losClearAllPoints => 'Effacer tous les points';

  @override
  String get losRunToViewElevationProfile =>
      'Exécutez LOS pour afficher le profil d\'altitude';

  @override
  String get losMenuTitle => 'Menu LOS';

  @override
  String get losMenuSubtitle =>
      'Appuyez sur les nœuds ou appuyez longuement sur la carte pour des points personnalisés';

  @override
  String get losShowDisplayNodes => 'Afficher les nœuds d\'affichage';

  @override
  String get losCustomPoints => 'Points personnalisés';

  @override
  String losCustomPointLabel(int index) {
    return 'Personnalisé $index';
  }

  @override
  String get losPointA => 'Point A';

  @override
  String get losPointB => 'Point B';

  @override
  String losAntennaA(String value, String unit) {
    return 'Antenne A : $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return 'Antenne B : $value $unit';
  }

  @override
  String get losRun => 'Exécuter la LOS';

  @override
  String get losNoElevationData => 'Aucune donnée d\'altitude';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, LOS clair, clairance minimale $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, bloqué par $obstruction $heightUnit';
  }

  @override
  String get losStatusChecking => 'LOS : vérification...';

  @override
  String get losStatusNoData => 'LOS : aucune donnée';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS : $clear/$total clair, $blocked bloqué, $unknown inconnu';
  }

  @override
  String get losErrorElevationUnavailable =>
      'Données d\'altitude indisponibles pour un ou plusieurs échantillons.';

  @override
  String get losErrorInvalidInput =>
      'Données de points/d\'altitude non valides pour le calcul de la LOS.';

  @override
  String get losRenameCustomPoint => 'Renommer le point personnalisé';

  @override
  String get losPointName => 'Nom du point';

  @override
  String get losShowPanelTooltip => 'Afficher le panneau LOS';

  @override
  String get losHidePanelTooltip => 'Masquer le panneau LOS';

  @override
  String get losElevationAttribution =>
      'Données d’altitude : Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'Horizon radio';

  @override
  String get losLegendLosBeam => 'Ligne de visée';

  @override
  String get losLegendTerrain => 'Terrain';

  @override
  String get losBlockedSpotsTitle => 'Places occupés';

  @override
  String get losBlockedSpotsHint =>
      'Sélectionnez un emplacement bloqué pour le mettre en évidence sur la carte.';

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
  String get losSelectedObstructionTitle => 'Obstruction sélectionnée';

  @override
  String losSelectedObstructionDetails(
    String obstruction,
    String heightUnit,
    String distanceFromA,
    String distanceUnit,
    String distanceFromB,
  ) {
    return 'Bloqué par $obstruction, à une hauteur de $heightUnit, à une distance de $distanceFromA par rapport à A et à une distance de $distanceFromB par rapport à B ($distanceUnit).';
  }

  @override
  String get losFrequencyLabel => 'Fréquence';

  @override
  String get losFrequencyInfoTooltip => 'Voir les détails du calcul';

  @override
  String get losFrequencyDialogTitle => 'Calcul de l’horizon radio';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'À partir de k=$baselineK à $baselineFreq MHz, le calcul ajuste le facteur k pour la bande actuelle de $frequencyMHz MHz, ce qui définit la limite incurvée de l\'horizon radio.';
  }

  @override
  String get contacts_pathTrace => 'Traçage de chemin';

  @override
  String get contacts_ping => 'Ping';

  @override
  String get contacts_repeaterPathTrace => 'Tracer le chemin vers le répéteur';

  @override
  String get contacts_repeaterPing => 'Pinguer le répéteur';

  @override
  String get contacts_roomPathTrace => 'Traçage du chemin vers le room server';

  @override
  String get contacts_roomPing => 'Pinguer le room server';

  @override
  String get contacts_chatTraceRoute => 'Tracer le chemin';

  @override
  String contacts_pathTraceTo(String name) {
    return 'Tracer l\'itinéraire vers $name';
  }

  @override
  String get contacts_clipboardEmpty => 'Le presse-papiers est vide.';

  @override
  String get contacts_pasteNotContact =>
      'Ce n’est pas un contact MeshCore. Copiez un lien ou une annonce meshcore://, puis réessayez.';

  @override
  String get contacts_invalidAdvertFormat => 'Données de contact non valides';

  @override
  String get contacts_contactImported => 'Le contact a été importé.';

  @override
  String get contacts_contactImportFailed =>
      'Échec de l\'importation du contact.';

  @override
  String get contacts_zeroHopAdvert => 'Annonce Zero saut';

  @override
  String get contacts_floodAdvert => 'Annonce à tout le réseau';

  @override
  String get contacts_copyAdvertToClipboard =>
      'Copier l\'annonce dans le presse-papiers';

  @override
  String get contacts_addContactFromClipboard =>
      'Ajouter un contact depuis le presse-papiers';

  @override
  String get contacts_ShareContact =>
      'Copier le contact dans le presse-papiers';

  @override
  String get contacts_ShareContactZeroHop => 'Partager un contact par annonce';

  @override
  String get contacts_zeroHopContactAdvertSent =>
      'Envoyer un contact par annonce.';

  @override
  String get contacts_zeroHopContactAdvertFailed =>
      'Échec de l\'envoi du contact.';

  @override
  String get contacts_contactAdvertCopied =>
      'Annonce copiée dans le presse-papiers.';

  @override
  String get contacts_contactAdvertCopyFailed =>
      'La copie de l\'annonce vers le presse-papiers a échoué.';

  @override
  String get notification_activityTitle => 'Activité MeshCore';

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
      other: 'messages de canal',
      one: 'message de canal',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'nouveaux nœuds',
      one: 'nouveau nœud',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return 'Nouveau $contactType découvert';
  }

  @override
  String get notification_receivedNewMessage => 'Nouveau message reçu';

  @override
  String get settings_gpxExportRepeaters =>
      'Exporter les répéteurs / room servers au format GPX';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'Exporte les répéteurs / roomserver avec une localisation vers un fichier GPX.';

  @override
  String get settings_gpxExportContacts =>
      'Exporter les compagnons au format GPX';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'Exporte les compagnons avec un emplacement vers un fichier GPX.';

  @override
  String get settings_gpxExportAll =>
      'Exporter tous les contacts au format GPX';

  @override
  String get settings_gpxExportAllSubtitle =>
      'Exporte tous les contacts avec une localisation vers un fichier GPX.';

  @override
  String get settings_gpxExportSuccess => 'Fichier GPX exporté avec succès.';

  @override
  String get settings_gpxExportNoContacts => 'Aucun contact à exporter.';

  @override
  String get settings_gpxExportNotAvailable =>
      'Non pris en charge sur votre appareil/Système d\'exploitation';

  @override
  String get settings_gpxExportError =>
      'Une erreur s\'est produite lors de l\'exportation.';

  @override
  String get settings_gpxExportRepeatersRoom =>
      'Emplacements des répéteurs et room servers';

  @override
  String get settings_gpxExportChat => 'Emplacements des compagnons';

  @override
  String get settings_gpxExportAllContacts =>
      'Tous les emplacements des contacts';

  @override
  String get settings_gpxExportShareText =>
      'Données de carte exportées à partir de NOTORYX Core';

  @override
  String get settings_gpxExportShareSubject =>
      'NOTORYX Core exporter les données de carte GPX';

  @override
  String get snrIndicator_nearByRepeaters => 'Répéteurs à proximité';

  @override
  String get snrIndicator_lastSeen => 'Vu pour la dernière fois';

  @override
  String get contactsSettings_title => 'Paramètres des contacts';

  @override
  String get contactsSettings_autoAddTitle => 'Découverte automatique';

  @override
  String get contactsSettings_otherTitle =>
      'Autres paramètres liés aux contacts';

  @override
  String get contactsSettings_autoAddUsersTitle =>
      'Ajouter automatiquement les utilisateurs';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      'Autoriser le compagnon à ajouter automatiquement les utilisateurs découverts';

  @override
  String get contactsSettings_autoAddRepeatersTitle =>
      'Ajouter automatiquement les répéteurs';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      'Autoriser le compagnon à ajouter automatiquement les répéteurs découverts';

  @override
  String get contactsSettings_autoAddRoomServersTitle =>
      'Ajouter automatiquement les room servers';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      'Autoriser le compagnon à ajouter automatiquement les room servers découverts';

  @override
  String get contactsSettings_autoAddSensorsTitle =>
      'Ajouter automatiquement les capteurs';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      'Autoriser le compagnon à ajouter automatiquement les capteurs découverts.';

  @override
  String get contactsSettings_overwriteOldestTitle => 'Écraser le plus ancien';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      'Lorsque la liste de contacts est pleine, le contact le plus ancien non favori sera remplacé.';

  @override
  String get discoveredContacts_Title => 'Contacts découverts';

  @override
  String get discoveredContacts_noMatching => 'Aucun contact correspondant';

  @override
  String get discoveredContacts_searchHint =>
      'Rechercher des contacts découverts';

  @override
  String get discoveredContacts_contactAdded => 'Contact ajouté';

  @override
  String get discoveredContacts_addContact => 'Ajouter un contact';

  @override
  String get discoveredContacts_copyContact =>
      'Copier le contact dans le presse-papiers';

  @override
  String get discoveredContacts_deleteContact => 'Supprimer le contact';

  @override
  String get discoveredContacts_deleteContactAll =>
      'Supprimer tous les contacts découverts';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      'Êtes-vous sûr de vouloir supprimer tous les contacts découverts ?';

  @override
  String get chat_sendCooldown =>
      'Veuillez patienter un instant avant de réessayer.';

  @override
  String get appSettings_jumpToOldestUnread =>
      'Accéder au message le plus ancien non lu';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      'Lorsque vous ouvrez une conversation contenant des messages non lus, faites défiler la page jusqu\'au premier message non lu, plutôt que jusqu\'au dernier.';

  @override
  String get appSettings_languageHu => 'Hongrois';

  @override
  String get appSettings_languageJa => 'Japonais';

  @override
  String get appSettings_languageKo => 'Coréen';

  @override
  String get radioStats_tooltip =>
      'Statistiques des radios et des réseaux sans fil';

  @override
  String get radioStats_screenTitle => 'Statistiques de radio';

  @override
  String get radioStats_notConnected =>
      'Connectez-vous à un appareil pour visualiser les statistiques de la radio.';

  @override
  String get radioStats_firmwareTooOld =>
      'Les statistiques radio nécessitent un firmware compatible v8 ou une version ultérieure.';

  @override
  String get radioStats_waiting => 'En attente des données…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'Niveau de bruit : $noiseDbm dBm';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return 'Dernier RSSI : $rssiDbm dBm';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return 'Dernier SNR : $snr dB';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'Temps d\'antenne TX (total) : $seconds s';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'Temps d\'antenne RX (total) : $seconds s';
  }

  @override
  String get radioStats_chartCaption =>
      'Niveau de bruit (dBm) sur les échantillons récents.';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'Niveau de bruit : $noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting =>
      'Récupération des statistiques de la radio…';

  @override
  String get radioStats_settingsTile => 'Statistiques de radio';

  @override
  String get radioStats_settingsSubtitle =>
      'Niveau de bruit, RSSI, rapport signal/bruit (SNR) et temps d\'antenne';

  @override
  String get translation_title => 'Traduction';

  @override
  String get imageMessages_enableTitle => 'Messages avec images';

  @override
  String get imageMessages_enableSubtitle =>
      'Envoyer des images via le maillage. Nécessite un téléchargement unique du modèle d\'image.';

  @override
  String get imageMessages_modelSectionTitle => 'Modèle d\'image';

  @override
  String get imageMessages_downloadModel => 'Télécharger';

  @override
  String get imageMessages_cancelDownload => 'Annuler';

  @override
  String get imageMessages_removeModel => 'Supprimer le modèle';

  @override
  String get imageMessages_modelReady => 'Prêt';

  @override
  String get imageMessages_modelNotPublished =>
      'Non publié — cette version ne peut pas le télécharger.';

  @override
  String get imageMessages_downloadFailed =>
      'Le modèle d\'image ne pouvait pas être téléchargé.';

  @override
  String get imageMessages_autoProcessTitle =>
      'Traiter automatiquement les images';

  @override
  String get imageMessages_autoProcessSubtitle =>
      'Reconstruisez chaque image dès son arrivée. Cela utilise environ 2 Go de mémoire pendant une seconde à chaque fois ; désactivez la reconstruction au toucher pour éviter cela.';

  @override
  String get translation_enableTitle => 'Activer la traduction';

  @override
  String get translation_enableSubtitle =>
      'Traduire les messages entrants et permettre la traduction avant l\'envoi.';

  @override
  String get translation_composerTitle => 'Traduire avant d\'envoyer';

  @override
  String get translation_composerSubtitle =>
      'Contrôle l\'état par défaut de l\'icône de traduction du composant.';

  @override
  String get translation_autoIncomingTitle =>
      'Traduire automatiquement les messages';

  @override
  String get translation_autoIncomingSubtitle =>
      'Traduit automatiquement les messages pour les notifications et pour les discussions ou les canaux.';

  @override
  String get translation_translateMessage => 'Traduire le message';

  @override
  String get translation_targetLanguage => 'Langue cible';

  @override
  String get translation_useAppLanguage =>
      'Utiliser la langue de l\'application';

  @override
  String get translation_downloadedModelLabel => 'Modèle téléchargé';

  @override
  String get translation_presetModelLabel => 'Modèle Hugging Face préconfiguré';

  @override
  String get translation_manualUrlLabel => 'URL du modèle manuel';

  @override
  String get translation_downloadModel => 'Télécharger le modèle';

  @override
  String get translation_downloading => 'Téléchargement...';

  @override
  String get translation_working => 'Au travail...';

  @override
  String get translation_stop => 'Arrêtez';

  @override
  String get translation_mergingChunks =>
      'Fusion des fragments téléchargés dans le fichier final...';

  @override
  String get translation_downloadedModels => 'Modèles téléchargés';

  @override
  String get translation_deleteModel => 'Supprimer le modèle';

  @override
  String get translation_modelDownloaded => 'Modèle de traduction téléchargé.';

  @override
  String get translation_downloadStopped =>
      'Le téléchargement a été interrompu.';

  @override
  String translation_downloadFailed(String error) {
    return 'Échec du téléchargement : $error';
  }

  @override
  String get translation_enterUrlFirst => 'Entrez d\'abord l\'URL du modèle.';

  @override
  String get scanner_linuxPairingShowPin => 'Afficher le code PIN';

  @override
  String get scanner_linuxPairingHidePin => 'Masquer le code PIN';

  @override
  String get scanner_linuxPairingPinTitle =>
      'Code PIN pour la connexion Bluetooth';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return 'Entrez le code PIN pour $deviceName (laissez vide si nécessaire).';
  }

  @override
  String get translation_messageTranslation => 'Traduction du message';

  @override
  String get translation_translateBeforeSending => 'Traduire avant d\'envoyer';

  @override
  String get translation_composerEnabledHint =>
      'Les messages seront traduits avant d\'être envoyés.';

  @override
  String get translation_composerDisabledHint =>
      'Envoyez des messages dans la langue originale, telle que vous l\'avez tapée.';

  @override
  String translation_translateTo(String language) {
    return 'Traduire en $language';
  }

  @override
  String get translation_translationOptions => 'Options de traduction';

  @override
  String get translation_systemLanguage => 'Langue du système';

  @override
  String get background_serviceTitle => 'MeshCore en cours d\'exécution';

  @override
  String get background_serviceText => 'Maintien de la connexion BLE';

  @override
  String appSettings_translationModelDeleted(String name) {
    return 'Supprimé $name';
  }

  @override
  String appSettings_translationModelDeleteFailed(String error) {
    return 'Échec de la suppression : $error';
  }

  @override
  String channels_channelUpdateFailed(String error) {
    return 'Échec de la mise à jour du canal : $error';
  }

  @override
  String get contact_typeChat => 'Chat';

  @override
  String get contact_typeRepeater => 'Répéteur';

  @override
  String get contact_typeRoom => 'Room';

  @override
  String get contact_typeSensor => 'Capteur';

  @override
  String get contact_typeUnknown => 'Inconnu';

  @override
  String get map_zoomIn => 'Zoom avant';

  @override
  String get map_zoomOut => 'Zoom arrière';

  @override
  String get map_centerMap => 'Centrer la carte';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'Web Bluetooth nécessite un navigateur Chromium.';

  @override
  String channels_communityShortId(String id) {
    return 'ID : $id…';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'GPS confirmé';

  @override
  String get pathTrace_legendInferred => 'Position déduite';

  @override
  String get pathMap_viewSingle => 'Simple';

  @override
  String get pathMap_viewCombined => 'Combiné';

  @override
  String get pathMap_play => 'Lecture';

  @override
  String get pathMap_pause => 'Pause';

  @override
  String get pathMap_replay => 'Rejouer';

  @override
  String get pathMap_stepBack => 'Saut précédent';

  @override
  String get pathMap_stepForward => 'Saut suivant';

  @override
  String get pathMap_animationOn => 'Afficher l\'animation des paquets';

  @override
  String get pathMap_animationOff => 'Masquer l\'animation des paquets';

  @override
  String pathMap_hopOf(int current, int total) {
    return 'Saut $current sur $total';
  }

  @override
  String pathMap_observedPaths(int count) {
    return 'Chemins observés : $count';
  }

  @override
  String get pathMap_primary => 'Principal';

  @override
  String pathMap_alternate(int index) {
    return 'Alternative $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sauts',
      one: '1 saut',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => 'Segment partagé';

  @override
  String get pathMap_legendEstimated => 'Segment estimé';

  @override
  String pathMap_sharedNodeCount(int count) {
    return 'Utilisé par $count chemins';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count sauts n\'ont pas de localisation — le chemin indiqué est partiel',
      one: 'Un saut n\'a pas de localisation — le chemin indiqué est partiel',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'Afficher tout';

  @override
  String get pathMap_hidePath => 'Masquer le chemin';

  @override
  String get pathMap_showPath => 'Afficher le chemin';

  @override
  String get pathMap_collapsePanel => 'Réduire le panneau';

  @override
  String get pathMap_expandPanel => 'Développer le panneau';

  @override
  String get pathMap_noLocation => 'Aucune localisation';

  @override
  String get pathMap_followPacket => 'Verrouiller la vue sur le paquet';

  @override
  String get pathMap_unfollowPacket => 'Déverrouiller la vue du paquet';

  @override
  String get imageSend_title => 'Envoyer l\'image';

  @override
  String get imageSend_cropNote =>
      'Redimensionné à 512 × 512 · le rapport d’aspect n’a pas été conservé';

  @override
  String get imageSend_originalSize =>
      'Texte original\n\nVeuillez traduire le texte suivant en français :';

  @override
  String get imageSend_onAirSize => 'En direct';

  @override
  String get imageSend_quality => 'Qualité';

  @override
  String get imageSend_qualityStandard => 'Standard';

  @override
  String get imageSend_qualityHigh => 'Haut';

  @override
  String get imageSend_packetsLabel => 'Paquets';

  @override
  String get imageSend_airtimeLabel => 'Durée de diffusion';

  @override
  String get imageSend_sizeLabel => 'Charge utile';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'paquets',
      one: 'paquet',
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
  String get imageSend_radioUnknownTitle => 'Réglages de la radio inconnus';

  @override
  String get imageSend_radioUnknownBody =>
      'Connectez-vous à un appareil afin que l\'heure de diffusion puisse être calculée.';

  @override
  String get imageSend_longSendTitle => 'Longue transmission';

  @override
  String imageSend_longSendBody(String duration) {
    return 'Cela maintiendra la chaîne pendant environ $duration.';
  }

  @override
  String get imageSend_floodNote =>
      'Routage des inondations : chaque répéteur dans la zone retransmet chaque paquet, de sorte que le canal reste occupé plus longtemps que cela.';

  @override
  String get imageSend_parityTitle => 'Paquet de récupération';

  @override
  String get imageSend_paritySubtitle =>
      'Un paquet supplémentaire. Les messages de groupe ne sont pas reconnus, ce qui permet au destinataire de reconstruire l\'image si un seul paquet est perdu.';

  @override
  String get imageSend_send => 'Envoyer';

  @override
  String get imageSend_cancel => 'Annuler';

  @override
  String get imageSend_encodeFailed => 'Cette image ne peut pas être encodée.';

  @override
  String get imageSend_codecDownloading =>
      'Le modèle d\'image est toujours en téléchargement.';

  @override
  String get imageSend_codecUnavailable =>
      'L\'envoi d\'images n\'est pas disponible sur cet appareil.';

  @override
  String get imageSend_codecDisabled =>
      'Les messages d\'images sont désactivés dans les paramètres.';

  @override
  String get imageSend_deviceUnsupported =>
      'Cette radio ne peut pas envoyer de paquets d\'images. Connectez un appareil exécutant le firmware compagnon version 13 ou ultérieure.';

  @override
  String get imageSend_directMessagesUnsupported =>
      'Les images se déplacent en tant que données de groupe, elles ne peuvent donc être envoyées que sur un canal — et non par message direct.';

  @override
  String get imageSend_tooLarge =>
      'Cette image a été encodée en plus de paquets que le format de maillage ne permet.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'paquets',
      one: 'paquet',
    );
    return 'Image envoyée en $count $_temp0.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return 'L\'image n\'a pas pu être envoyée : $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return 'Envoi de l\'image — paquet $sent sur $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'Nœud $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return '$received sur $total paquets';
  }

  @override
  String get receivedImage_queued => 'En attendant de décoder';

  @override
  String get receivedImage_tapToDecode => 'Tapez pour décoder';

  @override
  String get receivedImage_decoding => 'Reconstitution… d’environ 1 s';

  @override
  String receivedImage_incomplete(int received, int total) {
    return 'Image incomplète — $received sur $total paquets reçus';
  }

  @override
  String get receivedImage_corrupt =>
      'L\'image ne pouvait pas être reconstruite';

  @override
  String get receivedImage_decoderMissing =>
      'Image reçue — le décodage de l\'image est interrompu';

  @override
  String get receivedImage_evicted => 'Image non stockée';

  @override
  String get receivedImage_retry => 'Réessayez';

  @override
  String get receivedImage_decodeAgain => 'Décoder à nouveau';

  @override
  String get receivedImage_openSettings => 'Mettre en place';

  @override
  String get receivedImage_tapToProcess => 'Tapez pour traiter';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'paquets',
      one: 'paquet',
    );
    return '$bytes octets · $packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds s';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes minutes $seconds secondes';
  }

  @override
  String get bastion_tagline => 'La communication sans infrastructure.';

  @override
  String get bastion_nodes => 'Nœuds';

  @override
  String get bastion_repeaters => 'Répéteurs';

  @override
  String get bastion_active1h => 'Actifs 1 h';

  @override
  String get bastion_mapCoverage => 'Carte + couverture';

  @override
  String get bastion_routeIntelligence => 'Analyse des routes';

  @override
  String get bastion_repeaterTools => 'Outils répéteur';

  @override
  String get bastion_fieldStats => 'Stats terrain';

  @override
  String get bastion_fieldOps => 'Sortie + opérations terrain';

  @override
  String get bastion_coverageCapture => 'Capture de couverture';

  @override
  String get bastion_mapAttribution =>
      'Données cartographiques © contributeurs OpenStreetMap ; tuiles du fournisseur choisi';

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
      other: '$count nœuds uniques',
      one: '1 nœud unique',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sauts',
      one: '1 saut',
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
      'Maintenez 2 secondes. Envoie votre position à vos contacts de sortie toutes les 5 minutes jusqu\'à ce que quelqu\'un réponde.';

  @override
  String sos_holdHintChannel(String channel) {
    return 'Maintenez 2 secondes. Envoie votre position à vos contacts de sortie et à $channel toutes les 5 minutes jusqu\'à ce que quelqu\'un réponde.';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS non envoyé : $error';
  }

  @override
  String sos_acknowledged(String name) {
    return 'Accusé de réception par $name. Répétitions arrêtées.';
  }

  @override
  String get sos_waitingForRadio => 'En attente de l\'envoi par la radio…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return 'Envoyé $sends fois sur $max. Répétitions terminées ; pas encore de réponse.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return 'Envoyé $sends fois sur $max. Prochain à $time.';
  }

  @override
  String get sos_active => 'SOS ACTIF';

  @override
  String get sos_stop => 'ARRÊTER';

  @override
  String get sos_imSafe => 'JE SUIS EN SÉCURITÉ';

  @override
  String get sos_holdSemantics => 'SOS. Maintenez pour envoyer.';

  @override
  String get sos_keepHolding => 'CONTINUEZ…';

  @override
  String get sos_holdForSos => 'MAINTENIR POUR SOS';

  @override
  String get sos_blockStorage =>
      'Résolvez d\'abord l\'erreur de stockage du journal de terrain.';

  @override
  String get sos_blockNotConnected =>
      'Connectez votre radio MeshCore pour envoyer un SOS.';

  @override
  String get sos_blockNoTarget =>
      'Choisissez des contacts de sortie ou un canal SOS dans Planifier la sortie.';

  @override
  String get checkIn_labelOk => 'Tout va bien';

  @override
  String get checkIn_labelAtCamp => 'Au camp';

  @override
  String get checkIn_labelDelayed => 'En retard';

  @override
  String get checkIn_labelHeadingBack => 'Sur le retour';

  @override
  String get checkIn_blockLoading => 'Chargement de votre sortie…';

  @override
  String get checkIn_blockStorage =>
      'Résolvez l\'erreur de stockage du journal de terrain avant d\'envoyer.';

  @override
  String get checkIn_blockBusy =>
      'Un pointage est en cours d\'envoi. Veuillez patienter.';

  @override
  String get checkIn_blockNoContacts =>
      'Choisissez des contacts de sortie dans Planifier la sortie.';

  @override
  String get checkIn_blockRosterIncomplete =>
      'Certains contacts de sortie ne sont pas disponibles. Vérifiez votre liste.';

  @override
  String get checkIn_blockNotConnected =>
      'Connectez votre radio MeshCore pour pointer.';

  @override
  String get checkIn_blockNotActive =>
      'Démarrez votre sortie pour activer les pointages.';

  @override
  String get checkIn_notSent => 'Non envoyé';

  @override
  String checkIn_deliveredToOne(String name) {
    return 'Remis à $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return 'Remis aux $count contacts';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return 'Remis à $delivered sur $total';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return 'Non remis : $names';
  }

  @override
  String get checkIn_waitingForRest => 'En attente des autres';

  @override
  String get checkIn_aContact => 'un contact';

  @override
  String get checkIn_statusPending => 'En attente';

  @override
  String get checkIn_statusSent => 'Envoyé';

  @override
  String get checkIn_statusDelivered => 'Remis';

  @override
  String get checkIn_statusFailed => 'Échec';

  @override
  String get checkIn_explainPending =>
      'En file d\'attente locale. Cela ne confirme ni la transmission radio ni la réception.';

  @override
  String get checkIn_explainSent =>
      'La radio a accepté l\'envoi. Aucun accusé de remise n\'a été enregistré.';

  @override
  String get checkIn_explainDelivered =>
      'L\'app a enregistré un accusé de remise. Cela ne prouve pas que la personne l\'a lu.';

  @override
  String get checkIn_explainFailed =>
      'Aucune remise confirmée. Vérifiez la connexion radio, la joignabilité du destinataire et l\'historique des tentatives.';

  @override
  String get checkIn_explainUnknown =>
      'L\'état de remise n\'est pas disponible. Ne supposez pas que ce message est arrivé.';

  @override
  String get tripBrief_heading => 'NOTORYX • Résumé de sortie MeshCore';

  @override
  String tripBrief_trip(String name) {
    return 'Sortie : $name';
  }

  @override
  String tripBrief_status(String status) {
    return 'Statut : $status';
  }

  @override
  String get tripBrief_active => 'Active';

  @override
  String get tripBrief_stopped => 'Arrêtée';

  @override
  String tripBrief_contacts(String names) {
    return 'Contacts : $names';
  }

  @override
  String get tripBrief_noneSelected => 'Aucun sélectionné';

  @override
  String get tripBrief_unavailableContact =>
      'Contact indisponible (vérifiez la liste)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return 'Activité en retard après : $minutes minutes (ce téléphone alerte quand un contact devient silencieux)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'Rappel de pointage : $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return 'toutes les $minutes minutes sans pointage';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'Choix de pointage : $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'Position radio dans les pointages : $value';
  }

  @override
  String get tripBrief_includedMayBeStale => 'Incluse ; peut être obsolète';

  @override
  String tripBrief_battery(String value) {
    return 'Batterie radio dans les pointages : $value';
  }

  @override
  String get tripBrief_included => 'Incluse';

  @override
  String get tripBrief_off => 'Désactivée';

  @override
  String get tripBrief_review =>
      'Vérifiez les destinataires et le message avant d\'envoyer un pointage.';

  @override
  String get tripBrief_noProof =>
      'En file d\'attente ou envoyé ne prouve pas la remise. Un accusé de réception ne prouve pas la lecture.';

  @override
  String get tripBrief_overdueMeaning =>
      'En retard signifie aucune activité récente du contact ; ce n\'est pas une urgence confirmée.';

  @override
  String get tripBrief_automations =>
      'Les automatisations de terrain ne fonctionnent que lorsque l\'app est active. Convenez d\'un plan distinct en cas de contact manqué.';

  @override
  String get tripBrief_sharesOnly =>
      'Ce résumé partage seulement des informations ; il n\'envoie pas de message radio et ne démarre pas de sortie.';

  @override
  String get fieldOps_title => 'Opérations terrain NOTORYX Core';

  @override
  String get fieldOps_tabTrip => 'Sortie';

  @override
  String get fieldOps_tabReady => 'Prêt';

  @override
  String get fieldOps_tabLog => 'Journal';

  @override
  String get fieldOps_tabAuto => 'Auto';

  @override
  String get fieldOps_tabCoverage => 'Couverture';

  @override
  String get fieldOps_tabConnection => 'Connexion';

  @override
  String get fieldOps_diagnostics => 'Diagnostic';

  @override
  String get fieldOps_storageLoadError =>
      'Impossible de charger les données de terrain. Les données enregistrées sont conservées ; les automatisations restent désactivées.';

  @override
  String get fieldOps_storageSaveError =>
      'Impossible d\'enregistrer les données de terrain. Automatisations arrêtées ; les données déjà enregistrées sont conservées.';

  @override
  String get fieldOps_regionHint =>
      'Sélectionnez une zone et des niveaux de zoom dans Cartes hors ligne.';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • zoom $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return 'Impossible de vérifier la zone de carte : $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sortie active • $count contacts',
      one: 'Sortie active • 1 contact',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped =>
      'Sortie arrêtée. Démarrez-la quand vous êtes prêt.';

  @override
  String fieldOps_reminderAt(String time) {
    return 'Rappel de pointage à $time';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return 'Silencieux trop longtemps : $names';
  }

  @override
  String get fieldOps_planTrip => 'Planifier la sortie';

  @override
  String get fieldOps_endTrip => 'Terminer la sortie';

  @override
  String get fieldOps_startTrip => 'Démarrer la sortie';

  @override
  String get fieldOps_tripBrief => 'Résumé de sortie';

  @override
  String get fieldOps_connectRadio => 'Connecter la radio';

  @override
  String get fieldOps_previewedCheckIns => 'Pointages avec aperçu';

  @override
  String get fieldOps_previewedCheckInsHint =>
      'Choisissez un statut, vérifiez les destinataires réels et le message, puis envoyez. En file d\'attente ne veut pas dire remis.';

  @override
  String get fieldOps_tripRoster => 'Liste de la sortie';

  @override
  String get fieldOps_rosterEmpty =>
      'Choisissez jusqu\'à six contacts de discussion connus dans Planifier la sortie.';

  @override
  String get fieldOps_rosterCaveat =>
      '« Entendu pour la dernière fois » prouve une activité passée. Cela n\'établit pas la joignabilité actuelle. Les badges de retard signifient aucune activité récente du contact, pas une urgence confirmée.';

  @override
  String get fieldOps_offlineMaps => 'Cartes hors ligne';

  @override
  String get fieldOps_checkingTiles => 'Vérification des tuiles enregistrées…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tuiles en cache.',
      one: '1 tuile en cache.',
    );
    return '$_temp0 Cela ne garantit pas que tout votre itinéraire est couvert.';
  }

  @override
  String get fieldOps_downloadAreas =>
      'Télécharger / inspecter les zones hors ligne';

  @override
  String fieldOps_lastCheckIn(String time) {
    return 'Dernier pointage, $time';
  }

  @override
  String fieldOps_deliveryChip(String name, String status) {
    return '$name : $status';
  }

  @override
  String get fieldOps_contactFallback => 'Contact';

  @override
  String fieldOps_resendFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Renvoyer aux $count non remis',
      one: 'Renvoyer à 1 non remis',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable => 'Contact sélectionné indisponible';

  @override
  String get fieldOps_memberUnavailableHint =>
      'Vérifiez cette sortie avant d\'envoyer.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return 'Dernière activité il y a $minutes min';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return 'Dernière activité il y a $minutes min • en retard';
  }

  @override
  String get fieldOps_noCheckInRecorded =>
      'Aucun pointage enregistré dans ce journal.';

  @override
  String get fieldOps_tripMap => 'Carte de la sortie';

  @override
  String get fieldOps_tripMapEmpty =>
      'Aucun contact sélectionné n\'a encore annoncé de coordonnées.';

  @override
  String get fieldOps_lastPositions => 'Dernières positions annoncées';

  @override
  String get fieldOps_positionsCaveat =>
      'Les positions peuvent être obsolètes. Cette carte ne suit pas le GPS du téléphone et ne prouve pas que les membres sont actuellement ici.';

  @override
  String get fieldOps_briefPreviewTitle => 'Aperçu du résumé de sortie';

  @override
  String get fieldOps_briefPreviewHint =>
      'Contient les noms de la sortie et des contacts. Vérifiez avant de partager. Les coordonnées, clés et historiques de messages sont omis.';

  @override
  String get fieldOps_shareBrief => 'Partager le résumé';

  @override
  String get fieldOps_briefSubject => 'Résumé de sortie NOTORYX Core';

  @override
  String get fieldOps_tripName => 'Nom de la sortie';

  @override
  String get fieldOps_defaultTripName => 'Ma sortie';

  @override
  String get fieldOps_includePosition => 'Inclure la position radio annoncée';

  @override
  String get fieldOps_includePositionHint =>
      'Peut être obsolète ; le partage est désactivé par défaut.';

  @override
  String get fieldOps_includeBattery => 'Inclure la batterie de la radio';

  @override
  String get fieldOps_overdueLabel =>
      'M\'alerter quand un contact est silencieux pendant';

  @override
  String get fieldOps_reminderLabel => 'Me rappeler de pointer';

  @override
  String get fieldOps_reminderHelper =>
      'Une notification du téléphone, même si NOTORYX Core est fermé.';

  @override
  String get fieldOps_reminderOff => 'Désactivé';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Après $count minutes sans pointage',
      one: 'Après 1 minute sans pointage',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'Le SOS est aussi envoyé au canal';

  @override
  String get fieldOps_sosChannelNone => 'Aucun';

  @override
  String get fieldOps_selectContacts =>
      'Sélectionnez jusqu\'à six contacts de discussion connus';

  @override
  String get fieldOps_sendCheckInTitle => 'Envoyer le pointage ?';

  @override
  String fieldOps_recipients(String names) {
    return 'À : $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      'Utilise des envois de messages directs normaux. La remise sera suivie dans le journal de terrain.';

  @override
  String get fieldOps_send => 'Envoyer';

  @override
  String get sosRelay_title => 'Relais SOS';

  @override
  String get sosRelay_enable =>
      'Relayer les SOS qu’aucun répéteur n’a transmis';

  @override
  String get sosRelay_needsFirmware =>
      'Nécessite le firmware radio v1.16 ou plus récent';

  @override
  String get sosRelay_noneYet => 'Aucun SOS relayé pour l’instant';

  @override
  String sosRelay_relayedCount(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count paquets SOS relayés, le dernier à $time',
      one: '1 paquet SOS relayé, le dernier à $time',
    );
    return '$_temp0';
  }

  @override
  String get sosRelay_explainer =>
      'Quand votre radio entend un SOS directement de l’expéditeur et qu’aucun répéteur ne le transmet dans les 15 secondes environ, NOTORYX le renvoie une fois, sans modification, pour qu’il atteigne un répéteur que vous entendez mais pas l’expéditeur. Seuls les SOS de vos canaux sont relayés. Consomme un peu de batterie et de temps d’antenne, donc désactivé par défaut.';

  @override
  String get fieldOps_beforeYouLeave => 'Avant de partir';

  @override
  String get fieldOps_radioConnected => 'Radio connectée';

  @override
  String get fieldOps_connectHint => 'Connectez-vous en Bluetooth, USB ou TCP.';

  @override
  String get fieldOps_radioBattery => 'Batterie de la radio';

  @override
  String get fieldOps_batteryUnknown => 'Inconnue ; inspectez la radio.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent % • chargez pour la sortie prévue.';
  }

  @override
  String get fieldOps_tripContacts => 'Contacts de la sortie';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return '$available/$selected disponibles. Vérifiez qu\'ils ont des radios et des canaux compatibles.';
  }

  @override
  String get fieldOps_offlineArea => 'Zone de carte hors ligne sélectionnée';

  @override
  String get fieldOps_checkingFiles => 'Vérification des fichiers locaux…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return '$available/$expected fichiers de tuiles disponibles ; $missing manquants. Ceci est un instantané ; ouvrez la zone hors ligne avant de partir.';
  }

  @override
  String get fieldOps_locationChoice => 'Partage de position';

  @override
  String get fieldOps_locationOptedIn =>
      'Activé : les coordonnées annoncées par la radio peuvent être obsolètes.';

  @override
  String get fieldOps_locationOff =>
      'Le partage est désactivé. Vos pointages omettent les coordonnées.';

  @override
  String get fieldOps_automationAvailability =>
      'Disponibilité des automatisations';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'Fonctionne uniquement quand cette app est active. La veille, la fermeture ou la perte de la radio peuvent empêcher les actions programmées.';

  @override
  String get fieldOps_readinessCaveat =>
      'Les vérifications sont indicatives ; elles ne prouvent pas la portée radio et ne garantissent pas la remise des messages.';

  @override
  String get fieldOps_radio => 'Radio';

  @override
  String get fieldOps_refreshChecks => 'Actualiser les vérifications';

  @override
  String get fieldOps_searchLog => 'Rechercher dans le journal de terrain';

  @override
  String get fieldOps_kindAll => 'Tout';

  @override
  String get fieldOps_kindCheckIn => 'Pointage';

  @override
  String get fieldOps_kindReceived => 'Reçu';

  @override
  String get fieldOps_kindNote => 'Note';

  @override
  String get fieldOps_kindDeadZone => 'Zone blanche';

  @override
  String get fieldOps_kindRadio => 'Radio';

  @override
  String get fieldOps_kindAutomation => 'Automatisation';

  @override
  String get fieldOps_kindMissed => 'Manqué';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => 'Sortie';

  @override
  String get fieldOps_kindOverdue => 'En retard';

  @override
  String get fieldOps_addNote => 'Ajouter une note';

  @override
  String get fieldOps_exportJson => 'Exporter en JSON';

  @override
  String get fieldOps_deleteLog => 'Supprimer le journal';

  @override
  String get fieldOps_logSubject => 'Journal de terrain NOTORYX Core';

  @override
  String get fieldOps_logCaveat =>
      'Stocké localement, jusqu\'à 1 000 entrées. Les exports peuvent contenir des clés de contacts, des messages et des positions ; vérifiez avant de partager.';

  @override
  String get fieldOps_noEntries => 'Aucune entrée correspondante.';

  @override
  String get fieldOps_tripUnspecified => 'Sortie non précisée';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status : $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return 'Position radio annoncée enregistrée $latitude, $longitude (peut être obsolète)';
  }

  @override
  String get fieldOps_noteTitle => 'Observation de terrain';

  @override
  String get fieldOps_noteLabel => 'Qu\'avez-vous observé ?';

  @override
  String get fieldOps_deadZone => 'Zone blanche signalée';

  @override
  String get fieldOps_deadZoneHint =>
      'Votre observation, pas une prévision de couverture vérifiée.';

  @override
  String get fieldOps_savePosition => 'Enregistrer la position radio annoncée';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • peut être obsolète ; pas le GPS du téléphone';
  }

  @override
  String get fieldOps_noPosition => 'Aucune coordonnée annoncée utilisable';

  @override
  String get fieldOps_deleteLogTitle => 'Supprimer le journal de terrain ?';

  @override
  String get fieldOps_deleteLogBody =>
      'Cela supprime toutes les entrées enregistrées sur ce téléphone. Les réglages de la sortie sont conservés.';

  @override
  String get fieldOps_localAutomations => 'Automatisations locales';

  @override
  String get fieldOps_enableForTrip => 'Activer pour cette sortie';

  @override
  String get fieldOps_automationsCaveat =>
      'Désactivées après chaque redémarrage de l\'app. Les règles ne fonctionnent que lorsque l\'app est active. Les actions programmées manquées apparaissent dans le journal de terrain et ne sont jamais rejouées en rafale. Les pointages automatiques sont limités à un lot toutes les 10 minutes.';

  @override
  String get fieldOps_openBotMode => 'Ouvrir le mode bot NOTORYX';

  @override
  String get fieldOps_ruleEnabled => 'Règle activée';

  @override
  String get fieldOps_dryRun => 'Simulation';

  @override
  String get fieldOps_dryRunHint =>
      'Enregistrer l\'action sans envoyer ni notifier.';

  @override
  String get fieldOps_then => 'Alors';

  @override
  String get fieldOps_actionLog => 'Écrire dans le journal de terrain';

  @override
  String get fieldOps_actionNotify => 'Afficher une notification locale';

  @override
  String get fieldOps_actionCheckIn =>
      'Envoyer « I\'m OK » aux contacts de la sortie';

  @override
  String get fieldOps_batteryThreshold => 'Batterie inférieure ou égale à';

  @override
  String fieldOps_nextDue(String time) {
    return 'Prochaine échéance : $time';
  }

  @override
  String get fieldOps_nextDueNone => 'Prochaine échéance : non programmée';

  @override
  String get fieldOps_previewInLog => 'Aperçu dans le journal';

  @override
  String get fieldOps_allowNotifications => 'Autoriser les notifications';

  @override
  String get fieldOps_triggerReconnect => 'QUAND la radio se reconnecte';

  @override
  String get fieldOps_triggerDisconnect => 'QUAND la radio se déconnecte';

  @override
  String get fieldOps_triggerLowBattery =>
      'QUAND la batterie de la radio franchit le seuil';

  @override
  String get fieldOps_triggerNewNode => 'QUAND un nouveau nœud est ajouté';

  @override
  String get fieldOps_triggerRepeater => 'QUAND un nouveau répéteur est ajouté';

  @override
  String get fieldOps_triggerScheduled => 'QUAND un pointage programmé est dû';

  @override
  String get fieldOps_explainConnection => 'Expliquer ma connexion';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return 'État : $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      'Le téléphone a une connexion radio. Cela seul n\'établit pas de route vers vos destinataires.';

  @override
  String get fieldOps_disconnectedHint =>
      'Aucune connexion radio active. Vérifiez les autorisations Bluetooth, l\'alimentation et la portée de la radio ; USB/TCP sont disponibles depuis Connecter la radio.';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return 'Pointages de sortie en attente de confirmation : $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'Les heures de dernière vue et les positions annoncées des nœuds peuvent être obsolètes. L\'analyse des routes montre les routes apprises lors des tentatives observées ; elle n\'invente pas de chemins.';

  @override
  String get fieldOps_routeIntelligence => 'Analyse des routes';

  @override
  String get fieldOps_coverageIntelligence => 'Analyse de couverture';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      'Comparez les observations enregistrées entre deux sessions de terrain. Les points marquent les positions radio annoncées de l\'enregistreur où des nœuds ont été entendus. Ils n\'impliquent pas une couverture continue. Les instantanés RSSI/SNR ne sont pas des mesures par nœud.';

  @override
  String get fieldOps_captureSession => 'Capturer une session';

  @override
  String get fieldOps_refreshHistory => 'Actualiser l\'historique';

  @override
  String get fieldOps_noCoverageSessions =>
      'Aucune session de couverture enregistrée pour l\'instant.';

  @override
  String get fieldOps_sessionA => 'Session A • sarcelle';

  @override
  String get fieldOps_sessionB => 'Session B • ambre';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A : $a nœuds uniques • B : $b nœuds uniques';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return 'Communs : $shared • Seulement A : $onlyA • Seulement B : $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'Ne pas entendre un nœud pendant une session n\'établit pas une zone blanche. Les conditions et la durée d\'observation diffèrent.';

  @override
  String get fieldOps_heardTooltip =>
      'Observation d\'un nœud entendu ; pas la preuve d\'une liaison réussie';

  @override
  String get fieldOps_noteTooltip =>
      'Note locale aux coordonnées radio annoncées ; peut être obsolète.';

  @override
  String get bastionHome_aboutTooltip => 'À propos de NOTORYX Core';

  @override
  String get bastionHome_getStarted => 'Commencer';

  @override
  String get bastionHome_getStartedHint =>
      'Connectez votre radio et vérifiez votre premier message';

  @override
  String get bastionHome_planYourTrip => 'Planifiez votre sortie';

  @override
  String get bastionHome_tripActive => 'Sortie active';

  @override
  String get bastionHome_tripStopped => 'Sortie arrêtée';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • $contacts contacts • $unread messages non lus';
  }

  @override
  String get bastionHome_checkInOk => 'Pointer : tout va bien';

  @override
  String get bastionHome_checkInHint =>
      'Vérifiez les contacts et le message avant d\'envoyer. Suivez les accusés de réception dans le journal de terrain.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return 'Dernier pointage : $summary';
  }

  @override
  String get bastionHome_connectRadio => 'Connecter la radio';

  @override
  String get bastionHome_connectRadioHint =>
      'Connexions MeshCore en Bluetooth, USB et TCP';

  @override
  String get bastionHome_liveDiagnostics => 'Diagnostic en direct';

  @override
  String get bastionHome_liveDiagnosticsHint =>
      'État de la radio, signal, appareil et outils de trames';

  @override
  String get bastionHome_meshDiscovery => 'Découverte du maillage';

  @override
  String get bastionHome_meshDiscoveryHint =>
      'Trouvez des nœuds et inspectez le maillage autour de vous';

  @override
  String get bastionHome_fieldOpsHint =>
      'Résumé de sortie, préparation, journal de terrain, automatisations et comparaison de couverture';

  @override
  String get bastionHome_fieldTools => 'Outils de terrain NOTORYX';

  @override
  String get bastionHome_statusActive => 'ACTIF';

  @override
  String get bastionHome_consoleOnline => 'Console de terrain en ligne';

  @override
  String get bastionHome_consoleReady => 'Console de terrain prête';

  @override
  String get bastionHome_consoleHint =>
      'Connectez une radio pour activer le tableau de bord en direct.';

  @override
  String bastionHome_battery(String value) {
    return 'Bat $value';
  }

  @override
  String get bastionTools_title => 'Outils de terrain';

  @override
  String get bastionTools_backup => 'Sauvegarde chiffrée';

  @override
  String get bastionTools_backupHint =>
      'Enregistrez réglages, contacts et clés, avec l\'historique des discussions en option';

  @override
  String get bastionTools_fieldOpsHint =>
      'Pointages, préparation, journal de terrain, automatisations et comparaisons';

  @override
  String get bastionTools_mapHint =>
      'Carte en direct, sessions de capture, outils de cartes hors ligne et régions';

  @override
  String get bastionTools_pathAnalysis => 'Analyse des chemins';

  @override
  String get bastionTools_pathHint =>
      'Routes, découverte et analyse des chemins';

  @override
  String get bastionTools_repeaterHint =>
      'État, connexion, télémétrie, voisins et administration';

  @override
  String get bastionTools_statsHint =>
      'Comptages du maillage en direct et activité des contacts';

  @override
  String get bastionTools_diagnostics => 'Diagnostic';

  @override
  String get bastionTools_diagnosticsHint =>
      'État de la radio, informations sur l\'appareil, trames brutes et export';

  @override
  String get bastionTools_about => 'À propos + crédits';

  @override
  String get bastionTools_aboutHint =>
      'Version de NOTORYX Core, déclaration d\'indépendance et licences open source';

  @override
  String get bastionAbout_title => 'À propos + Crédits';

  @override
  String get bastionAbout_intro =>
      'Une application compagnon communautaire indépendante pour les réseaux MeshCore. NOTORYX Core n\'est pas une app officielle MeshCore et l\'inclusion de ressources communautaires n\'implique ni partenariat ni approbation.';

  @override
  String get bastionAbout_version => 'Version';

  @override
  String get bastionAbout_openSource => 'Fondation open source';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core est construit à partir du code open source MeshCore Open sous licence MIT, qu\'il modifie. Le travail sur la couverture crédite aussi, le cas échéant, la MeshMapper Flutter App sous licence MIT.';

  @override
  String get bastionAbout_community => 'La communauté d\'abord';

  @override
  String get bastionAbout_communityBody =>
      'Les ressources de créateurs tiers restent la propriété de leurs créateurs respectifs. Aucune propriété ni aucun partenariat n\'est sous-entendu.';

  @override
  String get bastionAbout_legalese =>
      'NOTORYX Core • Compagnon MeshCore indépendant';

  @override
  String get bastionAbout_licenses => 'Licences open source';

  @override
  String get bastionSetup_title => 'Bien démarrer avec NOTORYX Core';

  @override
  String get bastionSetup_intro =>
      'Connectez-vous, choisissez un contact, puis vérifiez un message. Vous pouvez revenir à ce guide depuis le tableau de bord à tout moment.';

  @override
  String get bastionSetup_step1 => '1. Connectez votre radio MeshCore';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return 'Connecté à $device via $transport.';
  }

  @override
  String get bastionSetup_noRadio => 'Aucune radio connectée pour l\'instant.';

  @override
  String get bastionSetup_step1Power =>
      'Allumez une radio compagnon MeshCore. Ouvrez Connecter la radio et choisissez Bluetooth, USB ou TCP. Accordez les autorisations demandées pour la connexion choisie.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Si la recherche Bluetooth est vide, vérifiez que le Bluetooth est activé et que NOTORYX Core dispose de l\'autorisation Appareils à proximité dans les réglages des applications Android. Suivez toute autre demande d\'autorisation affichée par le scanner.';

  @override
  String get bastionSetup_connectionDiagnostics => 'Diagnostic de connexion';

  @override
  String get bastionSetup_step2 => '2. Choisissez un contact de discussion';

  @override
  String get bastionSetup_step2Body =>
      'Demandez à un partenaire proche ayant des réglages radio MeshCore compatibles d\'annoncer son nœud. Choisissez ci-dessous un contact de discussion connu ; les répéteurs sont gérés séparément.';

  @override
  String get bastionSetup_noContacts =>
      'Aucun contact de discussion disponible. Connectez votre radio et ouvrez Découverte du maillage.';

  @override
  String get bastionSetup_testRecipient => 'Destinataire de test';

  @override
  String get bastionSetup_meshDiscovery => 'Découverte du maillage';

  @override
  String get bastionSetup_step3 => '3. Envoyez et vérifiez un message';

  @override
  String get bastionSetup_step3Body =>
      'Ouvrez la discussion, écrivez un court message de test, vérifiez le destinataire et touchez Envoyer. Revenez ici pour voir le dernier message sortant enregistré depuis l\'ouverture de ce guide.';

  @override
  String get bastionSetup_openTestChat => 'Ouvrir la discussion de test';

  @override
  String get bastionSetup_connectFirst =>
      'Connectez votre radio pour ouvrir la discussion de test.';

  @override
  String get bastionSetup_chooseRecipient =>
      'Choisissez d\'abord un destinataire.';

  @override
  String get bastionSetup_noTestMessage =>
      'Aucun message de test sortant enregistré pendant cette session du guide.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return 'Dernier message : $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'Demandez à votre partenaire de confirmer la réception ou de répondre. Un accusé de réception enregistré ne prouve pas la lecture. Vérifiez la connexion et le destinataire si un message échoue.';

  @override
  String get bastionSetup_step4 => '4. Préparez-vous pour le terrain';

  @override
  String get bastionSetup_step4Body =>
      'Planifiez vos contacts de sortie et inspectez les zones de carte téléchargées. Le mode bot et les automatisations de terrain sont désactivés au départ ; les automatisations de terrain ne fonctionnent que lorsque l\'app est active.';

  @override
  String get bastionSetup_tripTools => 'Outils de sortie et de préparation';

  @override
  String get bastionDiag_title => 'Diagnostic';

  @override
  String get bastionDiag_export => 'Exporter le diagnostic';

  @override
  String get bastionDiag_channels => 'Canaux';

  @override
  String get bastionDiag_radio => 'Radio';

  @override
  String get bastionDiag_frequency => 'Fréquence';

  @override
  String get bastionDiag_bandwidth => 'Bande passante';

  @override
  String get bastionDiag_spreadingFactor => 'Facteur d\'étalement';

  @override
  String get bastionDiag_codingRate => 'Taux de codage';

  @override
  String get bastionDiag_txPower => 'Puissance d\'émission';

  @override
  String get bastionDiag_noiseFloor => 'Plancher de bruit';

  @override
  String get bastionDiag_device => 'Appareil';

  @override
  String get bastionDiag_name => 'Nom';

  @override
  String get bastionDiag_manufacturer => 'Fabricant';

  @override
  String get bastionDiag_firmware => 'Micrologiciel';

  @override
  String get bastionDiag_battery => 'Batterie';

  @override
  String get bastionDiag_transport => 'Transport';

  @override
  String get bastionDiag_deepTools => 'Outils avancés';

  @override
  String get bastionDiag_liveStats => 'Stats radio en direct';

  @override
  String get bastionDiag_liveStatsHint =>
      'Bruit, RSSI, SNR et temps d\'antenne';

  @override
  String get bastionDiag_frameDebug => 'Débogage trames / BLE';

  @override
  String get bastionDiag_frameDebugHint =>
      'Inspectez les trames reçues décodées et brutes';

  @override
  String get bastionDiag_appLog => 'Journal de débogage de l\'app';

  @override
  String get bastionDiag_appLogHint =>
      'Consultez les événements de diagnostic de l\'application';

  @override
  String get bastionDiag_online => 'Radio en ligne';

  @override
  String get bastionDiag_offline => 'Radio hors ligne';

  @override
  String get bastionDiag_offlineHint =>
      'Connectez un compagnon MeshCore pour alimenter le diagnostic en direct.';

  @override
  String get coverage_title => 'Capture de couverture';

  @override
  String get coverage_leaveBlocked =>
      'Arrêtez et enregistrez la session avant de partir.';

  @override
  String get coverage_savedSessions => 'Sessions enregistrées';

  @override
  String get coverage_caveat =>
      'RSSI/SNR sont des instantanés radio et peuvent appartenir à un autre paquet. Les positions sont des coordonnées annoncées par la radio, pas le GPS du téléphone ni une preuve de couverture. Cyan : enregistreur ; ambre : nœud annoncé. Aucune interpolation n\'est effectuée.';

  @override
  String get coverage_captureActive => 'Capture active';

  @override
  String get coverage_fieldSession => 'Session de couverture terrain';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core enregistre les nœuds nouvellement entendus pendant cette session, y compris les données de route, les métadonnées de nœud/position et l\'instantané RSSI/SNR radio disponible le plus proche.';

  @override
  String get coverage_disconnectedBody =>
      'Connectez une radio avant de commencer. La capture de couverture enregistre les observations du maillage en direct depuis la radio compagnon connectée.';

  @override
  String get coverage_observations => 'Observations';

  @override
  String get coverage_uniqueNodes => 'Nœuds uniques';

  @override
  String get coverage_elapsed => 'Écoulé';

  @override
  String get coverage_radioConnected => 'Radio connectée';

  @override
  String get coverage_noRadio => 'Aucune radio';

  @override
  String get coverage_gpsReady => 'GPS radio prêt';

  @override
  String get coverage_noGps => 'Pas de GPS radio';

  @override
  String get coverage_stopSave => 'Arrêter + enregistrer';

  @override
  String get coverage_start => 'Démarrer une session de couverture';

  @override
  String get coverage_exportJson => 'Exporter JSON';

  @override
  String get coverage_exportCsv => 'Exporter CSV';

  @override
  String get coverage_liveObservations => 'Observations en direct';

  @override
  String get coverage_waiting => 'En attente d\'activité du maillage';

  @override
  String get coverage_waitingBody =>
      'Démarrez une session et les nœuds actifs nouvellement entendus apparaîtront ici. Les valeurs RSSI/SNR sont des instantanés radio et ne peuvent pas toujours être attribuées à un paquet précis.';

  @override
  String get coverage_signalNa => 'signal n/d';

  @override
  String get coverage_snrNa => 'SNR n/d';

  @override
  String get coverage_gpsUnavailable => 'GPS radio indisponible';

  @override
  String coverage_pathLine(String path, String location) {
    return 'Chemin : $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'diffusion';

  @override
  String get coverage_pathDirect => 'direct';

  @override
  String get coverage_shareSubject => 'Session de couverture NOTORYX Core';

  @override
  String get coverage_shareText =>
      'Export de capture de couverture NOTORYX Core';

  @override
  String get coverage_historyTitle => 'Sessions de couverture enregistrées';

  @override
  String coverage_loadFailed(String error) {
    return 'Impossible de charger les sessions : $error';
  }

  @override
  String get coverage_deleteTitle => 'Supprimer la session enregistrée ?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count observations seront supprimées de cet appareil.',
      one: '1 observation sera supprimée de cet appareil.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'Impossible de supprimer la session : $error';
  }

  @override
  String get coverage_retention =>
      'Les 20 sessions terminées les plus récentes sont conservées. Partagez celles que vous voulez garder. Les captures interrompues peuvent être rouvertes ci-dessous.';

  @override
  String get coverage_noSessions =>
      'Aucune session enregistrée pour l\'instant. Arrêtez une capture pour l\'enregistrer.';

  @override
  String get coverage_interrupted => 'Capture interrompue';

  @override
  String get coverage_saved => 'Enregistrée';

  @override
  String get coverage_deleteTooltip => 'Supprimer la session';

  @override
  String coverage_exportFailed(String error) {
    return 'Échec de l\'export : $error';
  }

  @override
  String get coverage_sessionTitle => 'Session de couverture';

  @override
  String get coverage_shareJson => 'Partager JSON';

  @override
  String get coverage_shareCsv => 'Partager CSV';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • âge de l\'instantané $age ms';
  }

  @override
  String get coverage_unknown => 'inconnu';

  @override
  String coverage_pathValue(String path) {
    return 'chemin $path';
  }

  @override
  String get coverage_recorder => 'Enregistreur';

  @override
  String get coverage_noCoordinates =>
      'Aucune coordonnée utilisable dans cette session. Les observations restent disponibles ci-dessous.';

  @override
  String get coverage_osmAttribution =>
      '© contributeurs OpenStreetMap • fond de carte en ligne';

  @override
  String get fieldStats_title => 'Analyse de terrain';

  @override
  String get fieldStats_chatNodes => 'Nœuds de discussion';

  @override
  String get fieldStats_rooms => 'Salons';

  @override
  String get fieldStats_sensors => 'Capteurs';

  @override
  String get fieldStats_direct => 'Directs';

  @override
  String get mapHub_title => 'Carte de terrain NOTORYX';

  @override
  String get mapHub_intro =>
      'Cartes en direct, zones hors ligne, profils régionaux et sessions de couverture terrain NOTORYX Core.';

  @override
  String get mapHub_captureHint =>
      'Démarrez et arrêtez une session de couverture terrain';

  @override
  String get mapHub_badgeNew => 'NOUVEAU';

  @override
  String get mapHub_liveMap => 'Carte du maillage en direct';

  @override
  String get mapHub_liveMapHint =>
      'Nœuds, répéteurs, positions, routes et outils de carte';

  @override
  String get mapHub_badgeLive => 'DIRECT';

  @override
  String get mapHub_offlinePacks => 'Packs de cartes hors ligne';

  @override
  String get mapHub_offlinePacksHint =>
      'Mettez en cache les tuiles pour les sorties et les zones sans réseau';

  @override
  String get mapHub_badgeOffline => 'HORS LIGNE';

  @override
  String get mapHub_regions => 'Profils de région';

  @override
  String get mapHub_regionsHint =>
      'Gérez et récupérez les définitions régionales du maillage';

  @override
  String get mapHub_badgeRegions => 'RÉGIONS';

  @override
  String get routes_title => 'Analyse des routes';

  @override
  String get routes_headline =>
      'Voyez comment le trafic circule dans le maillage.';

  @override
  String get routes_body =>
      'NOTORYX Core classe les routes enregistrées à l\'aide de l\'historique de chemins déjà appris lors de vraies tentatives de messages et de découvertes.';

  @override
  String get routes_routes => 'Routes';

  @override
  String get routes_success => 'Succès';

  @override
  String get routes_failed => 'Échecs';

  @override
  String get routes_routeMap => 'Carte des routes';

  @override
  String get routes_routeMapHint => 'Inspectez nœuds et chemins';

  @override
  String get routes_discover => 'Découvrir';

  @override
  String get routes_discoverHint => 'Trouvez de nouvelles routes';

  @override
  String get routes_learned => 'Routes apprises';

  @override
  String get routes_none => 'Pas encore d\'historique de routes';

  @override
  String get routes_noneBody =>
      'Utilisez le maillage normalement ou lancez une découverte. NOTORYX Core affichera ici les routes apprises dès que l\'historique de chemins sera disponible.';

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
    return 'MEILLEURE  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  poids $weight  •  $success succès / $fail échecs';
  }

  @override
  String routes_fastest(String ms) {
    return 'Plus rapide connue : $ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'Diffusion : $success succès / $fail échecs';
  }

  @override
  String get repeaterTools_unnamed => 'Répéteur sans nom';

  @override
  String get repeaterTools_empty =>
      'Aucun répéteur découvert pour l\'instant. Connectez une radio et découvrez d\'abord le maillage.';

  @override
  String get notification_fieldAlertTitle => 'Alerte terrain NOTORYX';

  @override
  String get notification_checkInReminderTitle =>
      'Rappel de pointage NOTORYX Core';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return 'Aucun pointage depuis $minutes minutes sur $trip. Ouvrez NOTORYX Core pour pointer.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return 'Aucune nouvelle de $name depuis $minutes minutes. Ce n\'est pas une urgence confirmée.';
  }

  @override
  String get notification_aTripContact => 'Un contact de la sortie';

  @override
  String notification_checkInNotDelivered(String name) {
    return 'Pointage non remis à $name. Vous pouvez le renvoyer depuis Sortie.';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return 'SOS confirmé par $name';
  }

  @override
  String get settings_batterySaver => 'Économiseur de batterie';

  @override
  String get settings_batterySaverOn =>
      'Activé : batterie de la radio toutes les 10 min, GPS toutes les 5 min, statistiques au plus une fois par minute, vérifications de la sortie toutes les 1–2 min. Messages, alertes et SOS inchangés.';

  @override
  String get settings_batterySaverOff =>
      'Vérifier la radio et la sortie moins souvent pour économiser la batterie du téléphone et de la radio. Messages, alertes et SOS inchangés.';

  @override
  String get settings_readAloud => 'Lire à voix haute les nouveaux messages';

  @override
  String get settings_readAloudHelper =>
      'Tant que NOTORYX Core est ouvert. Les canaux en sourdine restent silencieux. Tout message peut aussi être lu depuis son menu.';

  @override
  String get settings_readAloudOff => 'Désactivé';

  @override
  String get settings_readAloudDirect => 'Messages directs';

  @override
  String get settings_readAloudAll => 'Messages directs et de canal';

  @override
  String get chat_readAloud => 'Lire à voix haute';

  @override
  String get messageSearch_title => 'Rechercher des messages';

  @override
  String get messageSearch_intro =>
      'Recherchez dans tous les messages directs et de canal enregistrés sur ce téléphone.';

  @override
  String messageSearch_noResults(String query) {
    return 'Aucun message ne contient « $query ».';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count résultats',
      one: '1 résultat',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return 'Affichage des $count résultats les plus récents';
  }

  @override
  String get shortcuts_checkIn => 'Pointer';

  @override
  String get shortcuts_trip => 'Sortie';

  @override
  String get shortcuts_chats => 'Discussions';

  @override
  String get shortcuts_map => 'Carte';

  @override
  String get sensor_liveUpdates => 'Mises à jour en direct';

  @override
  String get sensor_intro =>
      'Laissez le capteur envoyer ses relevés de lui-même quand ils changent, au lieu de les demander à chaque fois. Nécessite une connexion avec accès en lecture.';

  @override
  String get sensor_watch => 'Surveiller les changements';

  @override
  String get sensor_loadFirst =>
      'Chargez d\'abord la télémétrie pour choisir des relevés.';

  @override
  String sensor_watching(String readings, String time) {
    return 'Surveillance de $readings jusqu\'à $time.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return 'Surveillance de $readings jusqu\'à $time • région $region.';
  }

  @override
  String get sensor_noChanges => 'Aucun changement signalé pour l\'instant.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return 'Dernière mise à jour $time • $count reçues';
  }

  @override
  String get sensor_stop => 'Arrêter les mises à jour en direct';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'Arrêté ici ; le capteur n\'a pas confirmé et s\'arrêtera à la fin du délai. $error';
  }

  @override
  String get sensor_dialogBody =>
      'Le capteur vérifie environ une fois par minute et envoie une mise à jour quand un relevé choisi varie de plus que son seuil.';

  @override
  String sensor_readingTitle(String label, String channel) {
    return '$label (canal $channel)';
  }

  @override
  String sensor_readingValue(String label, String channel, String value) {
    return '$label (canal $channel) : $value';
  }

  @override
  String sensor_watchItem(String label, String channel, String delta) {
    return '$label (canal $channel) ±$delta';
  }

  @override
  String sensor_updateOn(String delta) {
    return 'Mise à jour pour une variation de $delta';
  }

  @override
  String get sensor_changeThreshold => 'Modifier le seuil';

  @override
  String sensor_capacity(int max, String used) {
    return 'Le capteur peut surveiller jusqu\'à $max octets de relevés ($used utilisés).';
  }

  @override
  String get sensor_for => 'Durée';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count heures',
      one: '1 heure',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => 'Démarrer';

  @override
  String sensor_thresholdTitle(String label) {
    return 'Seuil de $label';
  }

  @override
  String get sensor_typeTemperature => 'Température';

  @override
  String get sensor_typeHumidity => 'Humidité';

  @override
  String get sensor_typePressure => 'Pression';

  @override
  String get sensor_typeVoltage => 'Tension';

  @override
  String get sensor_typeCurrent => 'Courant';

  @override
  String get sensor_typeLight => 'Luminosité';

  @override
  String get sensor_typeConcentration => 'Concentration';

  @override
  String get sensor_typePercentage => 'Pourcentage';

  @override
  String get sensor_typeAnalogInput => 'Entrée analogique';

  @override
  String get sensor_typeAltitude => 'Altitude';

  @override
  String get setupWizard_title => 'Connecter votre radio';

  @override
  String get setupWizard_choose => '1. Choisir une connexion';

  @override
  String get setupWizard_prepare => '2. Préparer votre radio';

  @override
  String get setupWizard_intro =>
      'Choisissez comment ce téléphone ou cet ordinateur se connectera à votre radio. La radio transporte les messages sur le maillage.';

  @override
  String get setupWizard_bluetooth =>
      'Connexion sans fil à une radio compatible à proximité.';

  @override
  String get setupWizard_noBluetooth =>
      'Le Bluetooth n\'est pas disponible dans ce navigateur. Utilisez l\'appli native ou une connexion USB prise en charge.';

  @override
  String get setupWizard_usb =>
      'Connexion filaire avec un câble de données USB.';

  @override
  String get setupWizard_noUsb =>
      'L\'USB série n\'est pas disponible ici. Utilisez une appli de bureau ou Android prise en charge, ou Chrome avec Web Serial.';

  @override
  String get setupWizard_bluetoothSteps =>
      'Allumez votre radio et gardez-la à proximité. Activez le Bluetooth et autorisez l\'appli à l\'utiliser. Fermez les autres applis connectées à la radio, puis ouvrez la liste des appareils et lancez la recherche.';

  @override
  String get setupWizard_usbSteps =>
      'Branchez une radio allumée avec un câble de données USB ; un câble de charge seule ne fonctionne pas. Fermez les autres applis série. Ouvrez la liste des appareils USB, choisissez votre radio et autorisez l\'accès si demandé.';

  @override
  String get setupWizard_firmwareTitle =>
      'Vérifiez la compatibilité avant de changer de firmware';

  @override
  String get setupWizard_firmware =>
      'Votre radio a besoin d\'un firmware companion MeshCore compatible avec la connexion choisie. La prise en charge dépend de la carte et de la version du firmware ; une prise USB ne garantit pas la prise en charge de l\'USB série. Consultez les instructions de votre carte et de la version installée. Un firmware de répéteur ou de serveur de salon n\'est pas un companion. Un échec de connexion ne signifie pas à lui seul qu\'il faut reflasher.';

  @override
  String get setupWizard_settings =>
      'Ce guide ne flashe pas de firmware et ne modifie pas les paramètres radio. Une fois connecté, utilisez les Paramètres pour la région, la fréquence et les options avancées. Validez les paramètres avec votre maillage local avant de les changer.';

  @override
  String get setupWizard_openBluetooth => 'Ouvrir les appareils Bluetooth';

  @override
  String get setupWizard_openUsb => 'Ouvrir les appareils USB';

  @override
  String get setupWizard_change => 'Changer de type de connexion';

  @override
  String get setupWizard_later => 'Configurer plus tard';

  @override
  String get setupWizard_bluetoothError =>
      'Impossible de se connecter à la radio. Gardez-la allumée et à proximité, vérifiez les autorisations Bluetooth et fermez les autres applis connectées. Relancez ensuite la recherche.';

  @override
  String get setupWizard_scanError =>
      'Impossible de rechercher des radios. Activez le Bluetooth et autorisez l\'accès au Bluetooth ou aux appareils à proximité dans les paramètres du système, puis relancez la recherche.';

  @override
  String get setupWizard_usbError =>
      'Impossible de se connecter en USB. Vérifiez le câble de données et l\'appareil choisi, autorisez l\'accès USB et fermez les autres applis série. Rebranchez le câble et réessayez.';

  @override
  String get connections_title => 'Connexions';

  @override
  String get connections_radioTitle => 'Connexion radio';

  @override
  String get connections_bluetoothOffNotice =>
      'Le Bluetooth est désactivé. Activez-le pour vous reconnecter ; l\'appli réessaiera dès son retour.';

  @override
  String get connections_transport => 'Transport';

  @override
  String connections_lastError(String error) {
    return 'Dernière erreur : $error';
  }

  @override
  String get connections_disconnectRadio => 'Déconnecter la radio';

  @override
  String connections_reconnectTo(String name) {
    return 'Se reconnecter à $name';
  }

  @override
  String get connections_forgetRadio => 'Oublier la radio';

  @override
  String get connections_connectAnother => 'Connecter une autre radio';

  @override
  String get connections_usbSerial => 'USB série';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'Appareil';

  @override
  String get connections_publicKey => 'Clé publique';

  @override
  String get connections_firmware => 'Firmware';

  @override
  String connections_firmwareProtocol(String code) {
    return 'protocole v$code';
  }

  @override
  String get connections_battery => 'Batterie';

  @override
  String get connections_lastRx => 'Dernière réception';

  @override
  String get connections_reconnectFailed =>
      'Impossible de se reconnecter à la radio';

  @override
  String get connections_statusBluetoothOff => 'Le Bluetooth est désactivé';

  @override
  String get connections_statusConnected => 'Connectée';

  @override
  String get connections_statusConnecting => 'Connexion…';

  @override
  String get connections_statusDisconnecting => 'Déconnexion…';

  @override
  String get connections_statusScanning => 'Recherche de radios…';

  @override
  String get connections_statusReconnectingSoon => 'Reconnexion imminente…';

  @override
  String get connections_statusNotConnected => 'Non connectée';

  @override
  String get mqtt_cardTitle => 'Connexion MQTT';

  @override
  String get mqtt_statusNotConfigured => 'Non configuré';

  @override
  String get mqtt_statusDisconnected => 'Déconnecté';

  @override
  String get mqtt_statusConnecting => 'Connexion';

  @override
  String get mqtt_statusConnected => 'Connecté';

  @override
  String get mqtt_statusReconnecting => 'Reconnexion';

  @override
  String get mqtt_statusError => 'Erreur de connexion';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'Broker : $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn => 'Connexion avec un jeton signé par la radio';

  @override
  String mqtt_tokenSignInAs(String username) {
    return 'Connexion avec un jeton signé par la radio en tant que $username…';
  }

  @override
  String get mqtt_connectRadioToSignIn =>
      'Connectez votre radio pour vous identifier';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'Le jeton est renouvelé à $time';
  }

  @override
  String mqtt_signedInAs(String username) {
    return 'Identifié en tant que $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return 'Écoute sur $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'Paquets : $accepted nouveaux, $duplicate doublons, $invalid invalides';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return 'Tentative $attempt sur $max';
  }

  @override
  String get mqtt_sharingWaitsForRadio =>
      'Le partage attend une connexion radio';

  @override
  String mqtt_sharingOn(String topic) {
    return 'Partage sur $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return 'Partagera sur $topic';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'Statut en ligne sur $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return 'Partagés $shared, retenus $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'Ajoutez un broker pour relier le trafic MeshCore via Internet. La connexion radio fonctionne indépendamment.';

  @override
  String get mqtt_disconnect => 'Déconnecter MQTT';

  @override
  String get mqtt_connect => 'Connecter MQTT';

  @override
  String get mqtt_packetFeed => 'Flux de paquets';

  @override
  String get mqtt_setUpBroker => 'Configurer un broker';

  @override
  String get mqtt_brokerSettings => 'Paramètres du broker';

  @override
  String get mqtt_settingsTitle => 'Paramètres du broker MQTT';

  @override
  String get mqtt_presetLabel => 'Partir d\'un préréglage';

  @override
  String get mqtt_presetCustom => 'Broker personnalisé';

  @override
  String get mqtt_presetLocal => 'Broker local (indiquer l\'adresse)';

  @override
  String get mqtt_presetLetsMeshUs =>
      'Analyseur LetsMesh (États-Unis, communauté)';

  @override
  String get mqtt_presetLetsMeshEu => 'Analyseur LetsMesh (UE, communauté)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh est un analyseur de paquets MeshCore géré par la communauté ; il ne fait pas partie de NOTORYX et n\'est pas cautionné par NOTORYX. Le partage nécessite votre radio connectée et reste désactivé tant que vous ne l\'activez pas.';

  @override
  String get mqtt_hostname => 'Nom d\'hôte du broker';

  @override
  String get mqtt_port => 'Port';

  @override
  String get mqtt_useTls => 'Utiliser TLS';

  @override
  String get mqtt_allowCleartext =>
      'Autoriser le texte clair vers un broker local';

  @override
  String get mqtt_allowCleartextHint =>
      'Uniquement localhost, .local et les hôtes privés 10.x / 192.168.x.';

  @override
  String get mqtt_useWebSocket => 'Utiliser WebSocket';

  @override
  String get mqtt_webSocketPath => 'Chemin WebSocket';

  @override
  String get mqtt_topicPrefix => 'Préfixe de topic';

  @override
  String get mqtt_region => 'Région (facultatif)';

  @override
  String get mqtt_regionHelp =>
      'Code de région de l\'observateur, p. ex. PHL. Laissez vide pour toutes.';

  @override
  String get mqtt_deliverChannel =>
      'Ajouter les messages de canal reçus via MQTT';

  @override
  String get mqtt_deliverChannelHint =>
      'Les messages de vos canaux entendus par des observateurs apparaissent dans vos discussions. Ils ne sont pas envoyés par votre radio.';

  @override
  String get mqtt_sharingTitle => 'Partager en tant qu\'observateur';

  @override
  String get mqtt_share => 'Partager les paquets que ma radio entend';

  @override
  String get mqtt_shareHint =>
      'Publie les annonces et le trafic de canal que reçoit votre radio, avec sa clé publique, la force du signal et la région. Les messages de canal restent chiffrés. Nécessite une région.';

  @override
  String get mqtt_shareDirect => 'Inclure le trafic des messages directs';

  @override
  String get mqtt_shareDirectHint =>
      'Requêtes, réponses et messages directs. Le contenu reste chiffré, mais cela montre quels nœuds communiquent entre eux.';

  @override
  String get mqtt_shareOwn => 'Inclure mes propres messages et annonces';

  @override
  String get mqtt_signInTitle => 'Identification';

  @override
  String get mqtt_authPassword => 'Nom d\'utilisateur et mot de passe';

  @override
  String get mqtt_authToken => 'Jeton signé par la radio';

  @override
  String get mqtt_tokenExplain =>
      'Votre radio signe avec sa propre clé un jeton d\'identification valable une heure, et l\'appli le renouvelle avant son expiration. La clé ne quitte jamais la radio. Le nom d\'utilisateur est v1_ suivi de la clé publique de votre radio.';

  @override
  String get mqtt_radioReady =>
      'Radio connectée : prête pour l\'identification.';

  @override
  String get mqtt_radioNeeded =>
      'Connectez votre radio pour vous identifier. MQTT l\'attend.';

  @override
  String get mqtt_username => 'Nom d\'utilisateur (facultatif)';

  @override
  String get mqtt_password => 'Mot de passe';

  @override
  String get mqtt_keepPassword =>
      'Laissez vide pour garder le mot de passe enregistré.';

  @override
  String get mqtt_credentialsWeb =>
      'Dans le navigateur, les identifiants ne sont conservés que jusqu\'à la fermeture de la page.';

  @override
  String get mqtt_credentialsKeychain =>
      'Les identifiants sont stockés dans le trousseau du système, jamais dans les paramètres de l\'appli ni dans les journaux.';

  @override
  String get mqtt_saveSettings => 'Enregistrer les paramètres';

  @override
  String get mqtt_feedTitle => 'Flux de paquets MQTT';

  @override
  String get mqtt_feedConnect =>
      'Connectez-vous à un broker pour voir les paquets des observateurs.';

  @override
  String mqtt_feedWaiting(String topic) {
    return 'En attente de paquets sur $topic';
  }

  @override
  String get mqtt_feedUnknownObserver => 'Observateur inconnu';

  @override
  String mqtt_feedHeardBy(String observer) {
    return 'Entendu par $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return '$hops sauts · $bytes octets';
  }

  @override
  String get mqtt_packetRequest => 'Requête';

  @override
  String get mqtt_packetResponse => 'Réponse';

  @override
  String get mqtt_packetDirectMessage => 'Message direct';

  @override
  String get mqtt_packetAck => 'Accusé de réception';

  @override
  String get mqtt_packetAdvert => 'Annonce';

  @override
  String get mqtt_packetChannelMessage => 'Message de canal';

  @override
  String get mqtt_packetChannelData => 'Données de canal';

  @override
  String get mqtt_packetAnonymousRequest => 'Requête anonyme';

  @override
  String get mqtt_packetPath => 'Chemin';

  @override
  String get mqtt_packetTrace => 'Trace';

  @override
  String get mqtt_packetMultipart => 'Multipartie';

  @override
  String get mqtt_packetControl => 'Contrôle';

  @override
  String mqtt_packetType(int type) {
    return 'Type $type';
  }

  @override
  String get mqtt_routeTransportFlood => 'Diffusion avec transport';

  @override
  String get mqtt_routeFlood => 'Diffusion';

  @override
  String get mqtt_routeDirect => 'Directe';

  @override
  String get mqtt_routeTransportDirect => 'Directe avec transport';

  @override
  String get mqtt_noticeInvalidHost =>
      'Saisissez un nom d\'hôte ou une adresse IPv4 sans schéma ni port.';

  @override
  String get mqtt_noticeInvalidPort =>
      'Le port doit être compris entre 1 et 65535.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'Le chemin WebSocket doit commencer par / et ne contenir ni requête ni fragment.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'Le préfixe de topic doit être un chemin MQTT non vide sans caractères génériques.';

  @override
  String get mqtt_noticeInvalidRegion =>
      'La région doit comporter 2 à 8 lettres ou chiffres, comme PHL.';

  @override
  String get mqtt_noticeTlsRequired =>
      'TLS est obligatoire, sauf si l\'accès non sécurisé à un broker local est explicitement autorisé.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      'Le MQTT en clair est réservé aux hôtes locaux explicitement autorisés.';

  @override
  String get mqtt_noticeRegionNeededToShare =>
      'Définissez une région pour partager des paquets en tant qu\'observateur.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return 'Saisissez le mot de passe de $username.';
  }

  @override
  String get mqtt_noticeNoNetwork =>
      'Pas de connexion réseau. MQTT se reconnectera à son retour.';

  @override
  String get mqtt_noticeSubscriptionRefused =>
      'Le broker a refusé l\'abonnement aux paquets.';

  @override
  String get mqtt_noticeBadCredentials =>
      'Le broker a refusé le nom d\'utilisateur ou le mot de passe.';

  @override
  String get mqtt_noticeNotAuthorized =>
      'Ce compte n\'est pas autorisé sur le broker.';

  @override
  String get mqtt_noticeConnectionRefused => 'Le broker a refusé la connexion.';

  @override
  String get mqtt_noticeUnreachable => 'Le broker est injoignable.';

  @override
  String get mqtt_noticeTlsFailed =>
      'La connexion sécurisée (TLS) n\'a pas pu être établie.';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'Cette plateforme ne prend en charge MQTT que via WebSocket.';

  @override
  String get mqtt_noticeRadioNotConnected =>
      'Connectez votre radio pour vous identifier avec sa clé.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'Le firmware de cette radio ne permet pas de signer avec sa clé.';

  @override
  String get mqtt_noticeSigningTimeout =>
      'La radio n\'a pas répondu à la demande de signature. Son firmware ne prend peut-être pas en charge la signature.';

  @override
  String get mqtt_noticeSigningTooLong =>
      'Les données sont trop longues pour que la radio les signe.';

  @override
  String get mqtt_noticeSigningRejected =>
      'La radio a refusé de signer les données.';

  @override
  String get scanner_signalStrong => 'Fort';

  @override
  String get scanner_signalGood => 'Bon';

  @override
  String get scanner_signalFair => 'Moyen';

  @override
  String get scanner_signalWeak => 'Faible';

  @override
  String get scanner_nearbyRadios => 'Radios à proximité';

  @override
  String get scanner_lastRadio => 'Dernière radio';

  @override
  String get scanner_reconnect => 'Reconnecter';

  @override
  String get scanner_tcpHint =>
      'Une radio avec un firmware Wi‑Fi sur votre réseau.';

  @override
  String get scanner_otherWays => 'Autres moyens de connexion';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count radios à proximité',
      one: '1 radio à proximité',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => 'Recherche de radios…';

  @override
  String get scanner_findTitle => 'Trouvez votre radio';

  @override
  String get scanner_heroHint =>
      'Allumez votre radio et gardez-la à quelques mètres. Elle doit avoir le firmware MeshCore companion.';

  @override
  String get scanner_tipsTitle => 'Vous ne voyez pas votre radio ?';

  @override
  String get scanner_tipPower => 'Vérifiez qu’elle est allumée et active.';

  @override
  String get scanner_tipFirmware =>
      'Elle doit avoir le firmware MeshCore companion. Les répéteurs et serveurs de salon n’apparaissent pas ici.';

  @override
  String get scanner_tipOtherDevice =>
      'Une radio ne se connecte qu’à un appareil à la fois. Déconnectez-la des autres téléphones ou ordinateurs.';

  @override
  String get connections_internetBridge => 'Pont Internet';

  @override
  String get connections_noRadio => 'Aucune radio';

  @override
  String get connections_radioSettings => 'Réglages radio';

  @override
  String get connections_viewDashboard => 'Voir le tableau des connexions';

  @override
  String get channelDirectory_title => 'Annuaire des canaux';

  @override
  String get channelDirectory_subtitle =>
      'Trouvez des canaux hashtag publics près de vous';

  @override
  String get channelDirectory_search => 'Rechercher des canaux ou des lieux';

  @override
  String get channelDirectory_nearYou => 'Près de vous';

  @override
  String get channelDirectory_all => 'Tous les canaux';

  @override
  String get channelDirectory_catAll => 'Tous';

  @override
  String get channelDirectory_catEmergency => 'Urgence';

  @override
  String get channelDirectory_catLocal => 'Local';

  @override
  String get channelDirectory_catGeneral => 'Général';

  @override
  String get channelDirectory_catInterest => 'Centres d’intérêt';

  @override
  String get channelDirectory_catTest => 'Tests';

  @override
  String get channelDirectory_join => 'Rejoindre';

  @override
  String get channelDirectory_joined => 'Rejoint';

  @override
  String get channelDirectory_noMatches =>
      'Aucun canal ne correspond à votre recherche.';

  @override
  String get channelDirectory_connectFirst =>
      'Connectez votre radio pour rejoindre des canaux.';

  @override
  String get channelDirectory_slotsFull =>
      'Tous les emplacements de canaux de votre radio sont utilisés. Supprimez d’abord un canal.';

  @override
  String get channelDirectory_joinFailed =>
      'Impossible d’ajouter le canal. Réessayez.';

  @override
  String get channelDirectory_addHint =>
      'Un canal manque ? Tout le monde peut en proposer un en modifiant la liste partagée sur GitHub.';

  @override
  String get prefixTool_title => 'ID des répéteurs';

  @override
  String get prefixTool_subtitle =>
      'Qui utilise un ID, quels ID se chevauchent et des ID libres pour un nouveau répéteur';

  @override
  String get prefixTool_width => 'Taille de l’ID de chemin';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes octet(s)';
  }

  @override
  String get prefixTool_includeCompanions =>
      'Inclure les companions et capteurs';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return '$nodes nœuds connus · $used ID utilisés · $shared partagés';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return '$free ID libres sur $space';
  }

  @override
  String get prefixTool_lookupHint => 'Rechercher un ID, p. ex. 3D';

  @override
  String prefixTool_lookupFree(String id) {
    return 'Aucun nœud connu n’utilise $id.';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nœuds utilisent $id',
      one: '1 nœud utilise $id',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => 'ID partagés';

  @override
  String get prefixTool_sharedHint =>
      'Les chemins passant par ces ID se ressemblent, sauf si le maillage utilise des ID plus longs.';

  @override
  String get prefixTool_noShared => 'Aucun ID partagé parmi les nœuds connus.';

  @override
  String get prefixTool_free => 'ID libres';

  @override
  String get prefixTool_shuffle => 'Autres suggestions';

  @override
  String get prefixTool_makeKey => 'Créer une clé';

  @override
  String get prefixTool_onlyKnown =>
      'Basé uniquement sur les nœuds entendus par votre radio. Un ID libre ici peut appartenir à un répéteur que vous n’avez pas entendu.';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id est déjà utilisé par $name.';
  }

  @override
  String get prefixTool_pickFree => 'Choisir un ID libre';

  @override
  String keyGen_title(String id) {
    return 'Clé pour l’ID $id';
  }

  @override
  String keyGen_searching(int tries) {
    return 'Recherche… $tries clés essayées';
  }

  @override
  String get keyGen_publicKey => 'Clé publique';

  @override
  String get keyGen_privateKey => 'Clé privée';

  @override
  String get keyGen_copy => 'Copier';

  @override
  String get keyGen_copied => 'Copié';

  @override
  String get keyGen_secretWarning =>
      'Gardez la clé privée secrète. Quiconque la possède peut se faire passer pour ce nœud.';

  @override
  String get keyGen_howToUse =>
      'Pour un répéteur : ouvrez ses réglages, collez-la comme clé privée et enregistrez. Les radios companion nécessitent un firmware qui autorise l’import de clé.';

  @override
  String get keyGen_tryAgain => 'En créer une autre';

  @override
  String get regionSetup_title => 'Configurer les régions';

  @override
  String get regionSetup_hubSubtitle =>
      'Placer ce répéteur dans l’arbre de régions de votre secteur';

  @override
  String get regionSetup_intro =>
      'Les régions gardent un message dans une zone au lieu d’inonder tout le maillage. Un répéteur ne relaie les messages d’une région que s’il la porte : donnez-lui sa région et toutes celles au-dessus.';

  @override
  String get regionSetup_where => 'Où se trouve le répéteur ?';

  @override
  String get regionSetup_tree => 'Arbre de régions';

  @override
  String get regionSetup_custom => 'Personnalisé';

  @override
  String get regionSetup_region => 'Région la plus locale';

  @override
  String get regionSetup_customLabel =>
      'Régions, de la plus large à la plus locale';

  @override
  String regionSetup_invalidName(String name) {
    return '« $name » n’est pas un nom de région valide. Utilisez des minuscules, chiffres et tirets, 29 caractères maximum.';
  }

  @override
  String regionSetup_tooMany(int max) {
    return 'Un répéteur peut porter au plus $max régions.';
  }

  @override
  String get regionSetup_options => 'Options';

  @override
  String get regionSetup_setDefault =>
      'Définir la région la plus locale par défaut';

  @override
  String get regionSetup_setDefaultBody =>
      'Les annonces du répéteur restent dans cette région.';

  @override
  String get regionSetup_legacy => 'Firmware 1.14';

  @override
  String get regionSetup_legacyBody =>
      'Ajoute region allowf après chaque région. Inutile à partir de 1.15.';

  @override
  String get regionSetup_denyUnscoped =>
      'Ne plus relayer les messages sans région';

  @override
  String get regionSetup_denyUnscopedBody =>
      'À n’activer que lorsque tout votre secteur utilise les régions, sinon les messages des anciennes applis ne passeront pas.';

  @override
  String get regionSetup_commands => 'Commandes';

  @override
  String get regionSetup_copyAll => 'Tout copier';

  @override
  String get regionSetup_copied => 'Copié';

  @override
  String get regionSetup_pickFirst =>
      'Choisissez une région pour voir les commandes.';

  @override
  String regionSetup_sendTo(String name) {
    return 'Envoyer à $name';
  }

  @override
  String get regionSetup_howToSend =>
      'Pour les envoyer, connectez-vous au répéteur et ouvrez Configurer les régions depuis son menu, ou collez-les dans sa ligne de commande.';

  @override
  String get regionSetup_noReply => 'Pas de réponse. Arrêt ici.';

  @override
  String get regionSetup_addToMine => 'Ajouter ces régions à ma liste';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count régions ajoutées à votre liste',
      one: '1 région ajoutée à votre liste',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => 'Journal de trajet';

  @override
  String get trackLog_subtitle =>
      'Enregistrer une trace avec le GPS de votre radio';

  @override
  String get trackLog_recording => 'Enregistrement';

  @override
  String get trackLog_notRecording => 'Pas d’enregistrement';

  @override
  String get trackLog_noGps =>
      'Votre radio ne donne pas de position GPS. Le journal de trajet nécessite une radio avec le GPS activé.';

  @override
  String get trackLog_start => 'Démarrer l’enregistrement';

  @override
  String get trackLog_stop => 'Arrêter l’enregistrement';

  @override
  String get trackLog_howItWorks =>
      'Utilise la position fournie par votre radio, environ une fois par minute, tant que NOTORYX Core est ouverte. Un point est ajouté après 25 m de déplacement, ou toutes les 15 minutes à l’arrêt.';

  @override
  String get trackLog_snap => 'Arrondir les positions à environ 100 m';

  @override
  String get trackLog_snapBody =>
      'Pour la confidentialité quand vous partagez un trajet.';

  @override
  String get trackLog_saved => 'Trajets enregistrés';

  @override
  String get trackLog_none => 'Aucun trajet pour l’instant.';

  @override
  String get trackLog_export => 'Exporter en GPX';

  @override
  String get trackLog_exportFailed => 'Impossible d’exporter le trajet.';

  @override
  String get trackLog_deleteTitle => 'Supprimer ce trajet ?';

  @override
  String get trackLog_deleteBody =>
      'Il est retiré de cet appareil. Les fichiers GPX exportés ne sont pas concernés.';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km km · $duration · $points points';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'Trajet NOTORYX $when';
  }

  @override
  String get routes_nearbyTitle => 'Meilleurs répéteurs proches';

  @override
  String get routes_nearbyEmptyTitle => 'Aucun répéteur entendu pour l’instant';

  @override
  String get routes_nearbyEmpty =>
      'Les répéteurs que votre radio entend directement apparaissent ici, les plus forts d’abord, au fil du trafic reçu. La liste couvre la dernière heure.';

  @override
  String get routes_unknownRepeater => 'Répéteur inconnu';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'entendu $count fois',
      one: 'entendu une fois',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'il y a $minutes min',
      one: 'il y a 1 min',
      zero: 'à l’instant',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return 'via $names';
  }

  @override
  String get nav_home => 'Accueil';

  @override
  String get nav_chats => 'Discussions';

  @override
  String get nav_tools => 'Outils';

  @override
  String get nav_settings => 'Réglages';

  @override
  String get nav_more => 'Plus';

  @override
  String get tools_groupApp => 'App et réglages';

  @override
  String get tools_groupField => 'Sur le terrain';

  @override
  String get tools_groupMaps => 'Cartes et couverture';

  @override
  String get tools_groupRouting => 'Routes et répéteurs';

  @override
  String get tools_pathGraph => 'Graphe des chemins';

  @override
  String get tools_pathGraphHint =>
      'Comment les messages vous parviennent : chaque chemin entendu, avec les répéteurs les plus actifs';

  @override
  String get tools_antenna => 'Couverture d’antenne';

  @override
  String get tools_antennaHint =>
      'Estimez jusqu’où une antenne porte sur le terrain';

  @override
  String routes_repeaterWithId(String id) {
    return 'Répéteur $id';
  }

  @override
  String get coverageHex_title => 'Hexagones de couverture';

  @override
  String get coverageHex_toolSubtitle =>
      'Cartographiez où votre radio entend le maillage et partagez-le';

  @override
  String get coverageHex_mapCoverage => 'Cartographier la couverture';

  @override
  String get coverageHex_statusOff =>
      'Désactivé. Activez-le en conduisant ou en marchant pour cartographier où votre radio entend le maillage.';

  @override
  String get coverageHex_waitingGps => 'En attente du GPS…';

  @override
  String coverageHex_gpsTooRough(String meters) {
    return 'Précision GPS $meters m : trop imprécise, pas d’enregistrement.';
  }

  @override
  String coverageHex_recording(String meters) {
    return 'Enregistrement. Précision GPS $meters m.';
  }

  @override
  String get coverageHex_hexagons => 'Hexagones';

  @override
  String get coverageHex_samples => 'Échantillons';

  @override
  String get coverageHex_privacyNote =>
      'Utilise le GPS du téléphone tant que ce bouton est activé. Seuls les identifiants d’hexagones (environ 0,9 km) sont partagés, jamais votre position exacte.';

  @override
  String get coverageHex_uploadSection => 'Envoyer aux cartes de couverture';

  @override
  String get coverageHex_wifiOnly => 'Envoyer uniquement en Wi-Fi';

  @override
  String get coverageHex_wifiOnlyHint =>
      'Les échantillons attendent sur le téléphone (jusqu’à 7 jours) le Wi-Fi.';

  @override
  String coverageHex_waiting(String count) {
    return '$count en attente';
  }

  @override
  String get coverageHex_addMap => 'Ajouter une carte de couverture';

  @override
  String get coverageHex_addMapHint =>
      'Tout point d’accès HTTPS qui accepte des données de couverture.';

  @override
  String get coverageHex_uploadNow => 'Envoyer maintenant';

  @override
  String get coverageHex_mapDialogTitle => 'Carte de couverture';

  @override
  String get coverageHex_nameMissing => 'Donnez-lui un nom.';

  @override
  String get coverageHex_url => 'URL d’envoi';

  @override
  String get coverageHex_urlInvalid => 'Doit être une URL https://.';

  @override
  String get coverageHex_apiKey => 'Clé API (facultative)';

  @override
  String get coverageHex_apiKeyHint => 'Envoyée comme X-API-Key.';

  @override
  String get coverageHex_format => 'Format';

  @override
  String get coverageHex_formatHex => 'ID d’hexagones (NOTORYX)';

  @override
  String get coverageHex_formatMeshMapper => 'Compatible MeshMapper';

  @override
  String get coverageHex_privacy => 'Confidentialité';

  @override
  String get coverageHex_privacyLive => 'En direct';

  @override
  String get coverageHex_privacyDelayed => 'Différé de 3 h';

  @override
  String get coverageHex_privacyAnonymous => 'Anonyme, 24 h';

  @override
  String get coverageHex_privacyLiveHint => 'Envoyé sous 15 minutes environ.';

  @override
  String get coverageHex_privacyDelayedHint =>
      'Retenu 3 heures pour que la carte ne montre pas où vous êtes maintenant.';

  @override
  String get coverageHex_privacyAnonymousHint =>
      'Retenu 24 heures, daté au jour près et non signé pour que les envois ne puissent pas être reliés.';

  @override
  String get coverageHex_uploadsOn => 'Envois activés';

  @override
  String coverageHex_sent(String count, String time) {
    return '$count cellules envoyées à $time.';
  }

  @override
  String coverageHex_httpError(String code) {
    return 'La carte a répondu $code ; nouvel essai prévu.';
  }

  @override
  String get coverageHex_unreachable =>
      'Carte injoignable ; nouvel essai prévu.';

  @override
  String get coverageHex_noPermission =>
      'L’autorisation de localisation n’a pas été accordée.';

  @override
  String get coverageHex_noGps => 'Le GPS n’est pas disponible.';

  @override
  String get coverageHex_loadFailed =>
      'Couverture enregistrée illisible ; nouveau départ.';

  @override
  String get mqttExtra_wifiOnly => 'Se connecter uniquement en Wi-Fi';

  @override
  String mqttExtra_backlog(String count) {
    return '$count paquets en attente d’envoi (conservés jusqu’à 72 heures).';
  }

  @override
  String get mqttExtra_add => 'Ajouter un autre broker';

  @override
  String get mqttExtra_addBody =>
      'Partage ce qu’entend votre radio avec un autre broker MQTT, en plus du principal. Il envoie seulement ; il ne renvoie jamais de paquets dans l’app.';

  @override
  String get mqttExtra_separateKey => 'Utiliser une clé distincte';

  @override
  String get mqttExtra_separateKeyHint =>
      'Se connecte avec une clé créée sur ce téléphone plutôt que celle de la radio, pour que ce broker ne puisse pas relier les envois à votre radio.';

  @override
  String mqttExtra_removeTitle(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get mqttExtra_removeBody =>
      'Déconnecte et oublie ses réglages, son mot de passe, sa clé et les paquets en attente.';

  @override
  String mqttExtra_ownKey(String key) {
    return 'Se connecte avec sa propre clé : $key…';
  }

  @override
  String get botWx_title => 'Publier les alertes météo dans un canal';

  @override
  String get botWx_body =>
      'Consulte toutes les 10 minutes le National Weather Service américain pour les alertes graves et extrêmes à la position GPS de la radio (arrondie à 1 km environ) et publie chaque nouvelle une fois. Nécessite Internet sur le téléphone.';

  @override
  String get botWx_channel => 'Publier dans le canal';

  @override
  String get botWx_moderate => 'Inclure les alertes modérées';

  @override
  String get botWx_moderateHint =>
      'Avis en plus des alertes. Plus de messages.';

  @override
  String botWx_lastChecked(String time) {
    return 'Dernière vérification $time.';
  }

  @override
  String get botWx_noPosition =>
      'La radio n’a pas encore indiqué de position GPS.';

  @override
  String get botWx_noChannel => 'Choisissez un canal pour les alertes.';

  @override
  String get botWx_channelGone => 'Le canal choisi n’existe plus.';

  @override
  String botWx_httpError(String code) {
    return 'Le service météo a répondu $code.';
  }

  @override
  String get botWx_unreachable => 'Service météo injoignable.';

  @override
  String get botCmd_sun =>
      'Lever et coucher du soleil à la position GPS de la radio.';

  @override
  String get botCmd_moon => 'Phase de la Lune et part éclairée.';

  @override
  String get botCmd_weather =>
      'Météo actuelle à la radio (Open-Meteo). Envoie la position arrondie à 1 km environ.';

  @override
  String get botCmd_dice => 'Lance des dés : !dice, !dice 20 ou !dice 2d6.';

  @override
  String get botCmd_trace =>
      'Liste les répéteurs par lesquels le message est passé.';

  @override
  String get ping_title => 'Ping de répéteur';

  @override
  String get ping_toolSubtitle =>
      'Temps aller-retour et signal dans les deux sens vers un répéteur proche';

  @override
  String get ping_noRepeaters => 'Aucun répéteur connu pour l’instant';

  @override
  String get ping_choose => 'Choisir un répéteur';

  @override
  String get ping_avgMs => 'ms aller-retour';

  @override
  String get ping_snrThere => 'SNR là-bas';

  @override
  String get ping_snrBack => 'SNR retour';

  @override
  String get ping_loss => 'Perdus';

  @override
  String ping_running(int done, int total) {
    return 'Ping $done sur $total…';
  }

  @override
  String ping_start(int count) {
    return 'Pinguer $count fois';
  }

  @override
  String get ping_results => 'Sondes';

  @override
  String get ping_noReply => 'Pas de réponse';

  @override
  String ping_resultLine(String ms, String snr) {
    return '$ms ms · SNR là-bas $snr';
  }

  @override
  String get ping_explainer =>
      'Chaque sonde est un traçage à un saut : le répéteur note la qualité de réception et la renvoie. Fonctionne avec les répéteurs que votre radio entend directement.';

  @override
  String get hunt_title => 'Recherche d’antenne';

  @override
  String get hunt_toolSubtitle =>
      'Grand indicateur de signal en direct qui clique plus vite quand il se renforce';

  @override
  String get hunt_noSignal => 'Pas encore de signal';

  @override
  String get hunt_noReply => 'Pas de réponse : déplacez ou tournez l’antenne';

  @override
  String get hunt_heardHere => 'dB reçus ici';

  @override
  String get hunt_best => 'Meilleur';

  @override
  String get hunt_sound => 'Cliquer quand le signal se renforce';

  @override
  String get hunt_soundHint =>
      'Avec une vibration à chaque clic, pour viser sans regarder.';

  @override
  String get hunt_stop => 'Arrêter';

  @override
  String get hunt_start => 'Commencer la recherche';

  @override
  String get hunt_explainer =>
      'Sonde le répéteur environ une fois par seconde. Orientez une antenne directive ou déplacez-vous : le nombre indique la qualité de réception.';

  @override
  String get settings_refreshRate => 'Fréquence d’actualisation';

  @override
  String get settings_refreshFast => 'Rapide';

  @override
  String get settings_refreshNormal => 'Normale';

  @override
  String get settings_refreshSlow => 'Lente';

  @override
  String get settings_refreshFastHint =>
      'Batterie chaque minute, GPS toutes les 30 s. Valeurs plus fraîches, plus de consommation.';

  @override
  String get settings_refreshNormalHint =>
      'Batterie toutes les 2 minutes, GPS chaque minute.';

  @override
  String get settings_refreshSlowHint =>
      'Batterie toutes les 6 minutes, GPS toutes les 3. Économise la batterie.';

  @override
  String get settings_refreshSaverOn =>
      'L’économiseur de batterie est activé et fixe le rythme (batterie toutes les 10 minutes).';

  @override
  String get reach_check => 'Vérifier la portée chez les observateurs';

  @override
  String get reach_title => 'Portée chez les observateurs';

  @override
  String get reach_noHash =>
      'Ce message ne peut pas encore être recherché : aucun répéteur ne l’a renvoyé vers votre radio, son identifiant de paquet est donc inconnu.';

  @override
  String get reach_unreachable =>
      'Analyseur injoignable. Vérifiez la connexion Internet ou l’adresse de l’analyseur dans les réglages.';

  @override
  String get reach_none =>
      'Aucun observateur ne l’a encore entendu. Ils envoient leurs données peu après, revérifiez dans une minute.';

  @override
  String get reach_observers => 'observateurs';

  @override
  String get reach_maxHops => 'sauts max.';

  @override
  String get reach_bestSnr => 'meilleur SNR';

  @override
  String reach_hops(int count) {
    return 'à $count sauts';
  }

  @override
  String get reach_explainer =>
      'Depuis l’analyseur en ligne : observateurs ayant entendu et envoyé ce paquet.';

  @override
  String get reach_checkAgain => 'Revérifier';

  @override
  String get analyzer_title => 'Analyseur en ligne';

  @override
  String get analyzer_url => 'Adresse de l’analyseur';

  @override
  String get analyzer_urlHint =>
      'Un analyseur CoreScope (https://). Utilisez celui de votre région.';

  @override
  String get analyzer_reset => 'Par défaut';

  @override
  String get analyzer_hint =>
      'Sert à vérifier quels observateurs ont entendu vos messages. Une vérification n’envoie que l’identifiant du paquet.';

  @override
  String get analyzer_hopLookup => 'Nommer en ligne les répéteurs inconnus';

  @override
  String get analyzer_hopLookupHint =>
      'Si un identifiant de répéteur n’est pas dans vos contacts, l’analyseur fournit son nom. Seuls les identifiants courts sont envoyés. Un nom finissant par « ? » signifie que plusieurs répéteurs partagent cet identifiant.';

  @override
  String discovered_tray(int count) {
    return 'Canaux entendus à proximité : $count';
  }

  @override
  String get discovered_title => 'Entendus à proximité, non rejoints';

  @override
  String discovered_heard(int count, String time) {
    return 'Entendu $count× · dernier $time';
  }

  @override
  String get discovered_ignore => 'Ignorer';

  @override
  String get discovered_ignoreAll => 'Tout ignorer';

  @override
  String get discovered_joinAll => 'Tout rejoindre';

  @override
  String get discovered_explainer =>
      'Ce sont des canaux publics de l’annuaire sur lesquels votre radio a entendu du trafic. Chacun a été confirmé en déchiffrant un message avec sa clé. Les canaux ignorés restent masqués.';

  @override
  String get mqtt_presetMeshRank => 'MeshRank (communauté)';

  @override
  String get mqtt_presetMeshRankNote =>
      'MeshRank est un classement communautaire des réseaux MeshCore, qui ne fait pas partie de NOTORYX et n’est pas approuvé par lui. Sans connexion : les paquets sont partagés sous la clé et le code de région de votre radio, uniquement une fois le partage activé.';

  @override
  String get pathFilter_title => 'Filtre de largeur de chemin';

  @override
  String get pathFilter_firmwareNote =>
      'Nécessite un firmware de répéteur avec règles de relais (mikecarper/MeshCore). Le firmware officiel MeshCore refuse ces commandes.';

  @override
  String get pathFilter_width => 'Largeur de chemin';

  @override
  String get pathFilter_anyWidth => 'Toute largeur';

  @override
  String pathFilter_bytes(int n) {
    return 'Chemins de $n octets';
  }

  @override
  String get pathFilter_twoOrMore => '2 ou 3 octets (2+)';

  @override
  String get pathFilter_path => 'S’applique à';

  @override
  String get pathFilter_radio => 'Diffusions radio';

  @override
  String get pathFilter_bridge => 'Pont';

  @override
  String get pathFilter_cross => 'Croisement';

  @override
  String get pathFilter_bridgeCross => 'Pont et croisement';

  @override
  String get pathFilter_limit => 'Limiter au lieu de rejeter';

  @override
  String get pathFilter_limitOn => 'Relaie jusqu’à un nombre fixé par minute.';

  @override
  String get pathFilter_drop => 'Les diffusions correspondantes sont rejetées.';

  @override
  String get pathFilter_perMinute => 'Par minute';

  @override
  String get pathFilter_rateInvalid => 'Saisissez de 1 à 65534.';

  @override
  String get pathFilter_reviewNote =>
      'Ceci remplit seulement la ligne de commande. Vérifiez-la, puis appuyez sur Envoyer. Utilisez d’abord « get fr » pour voir les règles.';

  @override
  String get pathFilter_useCommand => 'Utiliser la commande';

  @override
  String get settings_linkPreviews => 'Aperçus de liens';

  @override
  String get settings_linkPreviewsHint =>
      'Affiche le titre d’un lien dans un message. Désactivé par défaut : charger la page révèle votre adresse IP au site.';

  @override
  String get guide_title => 'Guide de terrain';

  @override
  String get guide_subtitle =>
      'Bases, batteries par temps froid, solaire et antennes';

  @override
  String get guide_secMesh => 'Rejoindre le maillage';

  @override
  String get guide_mesh1 =>
      'Le téléphone parle à la radio en Bluetooth, USB ou Wi-Fi ; la radio parle au maillage en LoRa. Les messages passent même sans réseau mobile.';

  @override
  String get guide_mesh2 =>
      'Les répéteurs relaient les messages ; chaque relais est un saut. Moins de sauts, livraison plus rapide et fiable.';

  @override
  String get guide_mesh3 =>
      'Restez bref et n’inondez pas les canaux chargés : chaque message utilise du temps d’antenne partagé.';

  @override
  String get guide_secCold => 'Batteries par temps froid';

  @override
  String get guide_cold1 =>
      'Ne chargez pas de batterie lithium sous 0 °C : cela l’abîme définitivement.';

  @override
  String get guide_cold2 =>
      'Gardez la radio sous votre veste. Le froid réduit la capacité, qui revient quand la batterie se réchauffe.';

  @override
  String get guide_cold3 =>
      'Pour les sites fixes en climat froid, le LiFePO4 résiste mieux que le lithium-ion ; un boîtier isolé ou chauffé aide les deux.';

  @override
  String get guide_secSolar => 'Solaire pour répéteurs';

  @override
  String get guide_solar1 =>
      'Un répéteur consomme très peu, mais dimensionnez panneau et batterie pour votre semaine d’hiver la plus sombre, pas un jour d’été.';

  @override
  String get guide_solar2 =>
      'Orientez le panneau vers l’équateur, fortement incliné en hiver ; évitez neige et ombre.';

  @override
  String get guide_secAntenna => 'Antennes et emplacement';

  @override
  String get guide_ant1 =>
      'La hauteur prime sur la puissance : une radio à quelques mètres porte bien plus loin qu’une posée sur un bureau.';

  @override
  String get guide_ant2 =>
      'Gardez l’antenne verticale et loin du métal, et utilisez-en une faite pour votre bande (par exemple 868 MHz en Europe).';

  @override
  String get guide_secMore => 'En savoir plus';

  @override
  String get guide_moreMeshcore => 'Le projet officiel MeshCore';

  @override
  String get guide_moreCascadia =>
      'Guides communautaires : démarrer, wardriving, régions, solaire';

  @override
  String get post_signed => 'Signé';

  @override
  String get post_unverified => 'Non vérifié';

  @override
  String post_signedKnown(String name) {
    return 'Signé par $name, l’un de vos contacts.';
  }

  @override
  String get post_signedUnknownKey =>
      'Signé, mais par aucun de vos contacts. Ajoutez l’expéditeur en contact pour savoir qui c’est.';

  @override
  String get post_unverifiedHint =>
      'Une signature accompagnait ce message mais ne correspond pas. Il a peut-être été modifié en route, ou ne vient pas de la personne indiquée.';

  @override
  String get settings_signPosts => 'Signer tous mes messages de canal';

  @override
  String get settings_signPostsHint =>
      'Un SOS sur un canal est toujours signé. Ceci signe chaque message pour que les autres utilisateurs de NOTORYX sachent que c’est bien vous. Chaque signature ajoute un paquet sur les ondes.';

  @override
  String get tools_search => 'Rechercher outils et réglages';

  @override
  String get tools_noMatches => 'Aucun outil ne correspond à la recherche.';

  @override
  String get tools_bot => 'Mode bot';

  @override
  String get tools_botHint =>
      'Réponses automatiques, !commandes et alertes météo sur les canaux';

  @override
  String get botChannels_title => 'Canaux';

  @override
  String get botChannels_hint =>
      'Le bot répond aussi aux !commandes dans les canaux activés, dans ce canal. Il n’y envoie jamais de réponse d’absence.';

  @override
  String get botChannels_none => 'Aucun canal sur cette radio pour l’instant.';

  @override
  String get advert_zeroHopHint =>
      'Seulement les radios qui vous entendent directement. Les répéteurs ne le relaient pas.';

  @override
  String get advert_floodHint =>
      'Les répéteurs le propagent dans tout le maillage. Utilise plus de temps d’antenne.';

  @override
  String get radioPresets_custom => 'Personnalisé';

  @override
  String get radioPresets_search => 'Rechercher un préréglage';

  @override
  String get radioPresets_suggested => 'Suggéré pour votre région';

  @override
  String get radioPresets_community => 'Préréglages de la communauté';

  @override
  String get radioPresets_hint =>
      'Ce sont les préréglages suggérés par la communauté MeshCore. Choisissez celui de votre maillage local. Il règle fréquence, bande passante, facteur d’étalement et taux de codage ; votre puissance d’émission ne change pas.';

  @override
  String get mySensors_title => 'Capteurs';

  @override
  String get mySensors_refresh => 'Lire les capteurs';

  @override
  String get mySensors_reading => 'Lecture des capteurs de votre radio…';

  @override
  String get mySensors_failed =>
      'Votre radio n’a pas répondu. Touchez actualiser pour réessayer.';

  @override
  String get mySensors_none => 'Aucune mesure de capteur de votre radio.';

  @override
  String get activeChannels_title => 'Actifs en ligne';

  @override
  String activeChannels_messages(int count) {
    return '$count messages';
  }

  @override
  String activeChannels_source(String host) {
    return 'Canaux utilisés, selon les observateurs de $host. Changez d’analyseur dans les réglages pour voir votre région.';
  }

  @override
  String get fieldOps_checkInChannelLabel =>
      'Les check-ins vont aussi au canal';

  @override
  String get fieldOps_checkInChannelHint =>
      'Signé avec la clé de votre radio, pour que les autres du canal voient que c’est bien vous. Vos contacts de sortie le reçoivent toujours directement.';

  @override
  String get channels_regionUnknown => 'Régional';

  @override
  String channels_regionSemantics(String region) {
    return 'Envoyé à la région $region';
  }

  @override
  String get channels_regionUnknownSemantics =>
      'Envoyé à une région inconnue de l’app';

  @override
  String get wardrive_title => 'Wardrive';

  @override
  String get wardrive_hint =>
      'Pinguez d’où vous êtes et cartographiez les répéteurs qui vous entendent';

  @override
  String get wardrive_start => 'Démarrer';

  @override
  String get wardrive_stop => 'Arrêter';

  @override
  String get wardrive_pings => 'pings';

  @override
  String get wardrive_heard => 'entendus';

  @override
  String get wardrive_pinging => 'Ping en cours…';

  @override
  String get wardrive_waitPosition =>
      'En attente d’une position GPS de votre téléphone ou radio.';

  @override
  String get wardrive_waitRadio => 'Connectez une radio pour pinguer.';

  @override
  String get wardrive_history => 'Historique';

  @override
  String get wardrive_noSessions => 'Aucun trajet pour l’instant.';

  @override
  String wardrive_sessionSummary(int pings, int heard) {
    return '$pings pings · $heard entendus';
  }

  @override
  String get wardrive_delete => 'Supprimer';

  @override
  String get wardrive_recentre => 'Revenir à ma position';

  @override
  String get wardrive_youAreHere => 'Vous êtes ici';

  @override
  String get wardrive_backToLive => 'Revenir au trajet en cours';

  @override
  String get wardrive_noReplies => 'Aucun répéteur n’a entendu ce ping.';

  @override
  String wardrive_replyDetail(String there, String here) {
    return 'Vous a entendu à $there dB · vous l’avez entendu à $here dB';
  }

  @override
  String get wardrive_explainer =>
      'Chaque ping est une demande de découverte sans relais : seuls les répéteurs à portée directe répondent, rien n’est publié sur un canal. Les positions viennent du GPS de votre téléphone, ou de votre radio à défaut.';

  @override
  String get mapTelemetry_policy =>
      'Les mesures enregistrées sont atténuées après 1 heure et masquées après 24 heures. Actualiser envoie une demande ; le nœud doit autoriser la télémétrie et les capteurs peuvent nécessiter une connexion. La carte ne demande jamais de mises à jour automatiques.';

  @override
  String get autoConnect_title => 'Se connecter automatiquement à ma radio';

  @override
  String get autoConnect_hint =>
      'À l’ouverture de l’app, reconnexion à votre dernière radio sans toucher. Plusieurs essais si elle n’est pas encore à portée.';

  @override
  String get networks_title => 'Réseaux';

  @override
  String get networks_hint => 'Chercher les réseaux proches et les consigner';

  @override
  String get networks_yourNetwork => 'Votre réseau';

  @override
  String get networks_scanTitle => 'Chercher des réseaux';

  @override
  String get networks_scanExplainer =>
      'Votre radio n’entend que les réseaux réglés exactement comme elle : une recherche la règle tour à tour sur chacun, écoute, puis la remet en place. Pendant ce temps, vous êtes hors de votre maillage.';

  @override
  String get networks_listenFor => 'Écoute par réseau';

  @override
  String networks_choose(int count) {
    return 'Réseaux à chercher : $count';
  }

  @override
  String get networks_suggested => 'Suggérés';

  @override
  String get networks_start => 'Lancer la recherche';

  @override
  String get networks_cancel => 'Arrêter la recherche';

  @override
  String networks_listening(String name, int step, int steps) {
    return 'Écoute de $name ($step sur $steps)';
  }

  @override
  String get networks_blockNoRadio => 'Connectez une radio pour chercher.';

  @override
  String get networks_blockSettings => 'En attente des réglages de la radio.';

  @override
  String get networks_blockSos =>
      'Pas pendant un SOS : la recherche vous coupe de votre maillage.';

  @override
  String get networks_blockTrip =>
      'Pas pendant une sortie : la recherche vous coupe de votre maillage.';

  @override
  String get networks_nearby => 'Réseaux à proximité';

  @override
  String get networks_nothingYet =>
      'Aucun réseau entendu pour l’instant. Lancez une recherche.';

  @override
  String networks_heardSummary(int nodes, int packets, String snr) {
    return 'Nœuds $nodes · paquets $packets · SNR $snr dB';
  }

  @override
  String networks_lastHeard(String time) {
    return 'Entendu $time';
  }

  @override
  String networks_timesHeard(int count) {
    return 'Fois entendu : $count';
  }

  @override
  String get networks_saved => 'Réseaux enregistrés';

  @override
  String get networks_noSaved => 'Aucun réseau enregistré.';

  @override
  String get networks_add => 'Ajouter un réseau';

  @override
  String get networks_join => 'Rejoindre';

  @override
  String networks_joinConfirm(String name) {
    return 'Passer votre radio sur $name ? Vous quitterez votre réseau actuel. La puissance d’émission reste la même.';
  }

  @override
  String networks_joined(String name) {
    return 'Votre radio est maintenant sur $name.';
  }

  @override
  String get networks_log => 'Journal des réseaux';

  @override
  String get networks_logEmpty => 'Rien de consigné pour l’instant.';

  @override
  String get networks_showMap => 'Carte';

  @override
  String get networks_exportCsv => 'Exporter en CSV';

  @override
  String get networks_exportGpx => 'Exporter en GPX';

  @override
  String get networks_clearLog => 'Vider le journal';

  @override
  String get networks_clearLogConfirm =>
      'Supprimer tous les réseaux consignés ?';

  @override
  String get networks_name => 'Nom';

  @override
  String get networks_invalid =>
      'Vérifiez les réglages : ils sortent de ce qu’acceptent les radios MeshCore.';

  @override
  String get networks_nodesHeard => 'Nœuds entendus';

  @override
  String get chat_resendNeedsRadio =>
      'Non envoyé : connectez votre radio, puis réessayez. Le message est conservé.';

  @override
  String get quick_title => 'Messages rapides';

  @override
  String get quick_ok => 'OK';

  @override
  String get quick_onMyWay => 'J’arrive';

  @override
  String get quick_atCamp => 'Au camp';

  @override
  String get quick_runningLate => 'En retard';

  @override
  String get quick_needHelp => 'Besoin d’aide';

  @override
  String get quick_copyThat => 'Bien reçu';

  @override
  String get quick_empty =>
      'Aucun message rapide. Touchez Modifier pour en ajouter un.';

  @override
  String get quick_add => 'Nouveau message rapide';

  @override
  String get quick_reset => 'Rétablir les messages par défaut';

  @override
  String get chat_stopRetrying => 'Arrêter les nouvelles tentatives';

  @override
  String chat_addFirstBanner(String name) {
    return '$name ne peut lire vos messages directs et y répondre qu’après vous avoir ajouté comme contact. Sinon, envoyez votre annonce ou partagez votre contact.';
  }

  @override
  String get map_goToMyPosition => 'Aller à ma position';

  @override
  String get map_positionUnavailable =>
      'Votre position n’est pas disponible. Activez la localisation ou définissez la position de la radio.';

  @override
  String get contact_forgetAdvert => 'Oublier la dernière annonce';

  @override
  String get contact_forgetAdvertHint =>
      'Si les annonces de ce nœud ne se mettent plus à jour après une réinitialisation de son horloge, Oublier la dernière annonce laisse passer la suivante.';

  @override
  String get contact_forgetAdvertDone =>
      'C’est fait. La prochaine annonce de ce nœud sera acceptée.';

  @override
  String get networks_modeQuick => 'Rapide';

  @override
  String get networks_modeThorough => 'Approfondi';

  @override
  String get networks_modeQuickHint =>
      'Envoie un court ping sans relais sur chaque réseau et écoute quelques secondes. Trouve les réseaux avec un répéteur à portée.';

  @override
  String get networks_modeThoroughHint =>
      'Écoute seulement, plus longtemps sur chaque réseau. N’envoie rien et trouve aussi les réseaux sans répéteur à portée si quelqu’un émet.';

  @override
  String networks_estimate(String time) {
    return 'environ $time';
  }

  @override
  String discoveredContacts_selected(int count) {
    return '$count sélectionnés';
  }

  @override
  String get discoveredContacts_selectAll => 'Tout sélectionner';

  @override
  String get discoveredContacts_addSelected => 'Ajouter la sélection';

  @override
  String discoveredContacts_addAllShown(int count) {
    return 'Ajouter tous ceux affichés ($count)';
  }

  @override
  String discoveredContacts_addManyTitle(int count) {
    return 'Ajouter $count contacts ?';
  }

  @override
  String discoveredContacts_roomLeft(int room) {
    return 'Votre radio a de la place pour $room contacts de plus.';
  }

  @override
  String discoveredContacts_roomLimit(int room, int count) {
    return 'Votre radio a de la place pour $room contacts de plus : seuls les $room premiers sur $count seront ajoutés.';
  }

  @override
  String discoveredContacts_adding(int done, int total) {
    return 'Ajout de $done sur $total…';
  }

  @override
  String discoveredContacts_addedMany(int count) {
    return 'Contacts ajoutés : $count';
  }

  @override
  String discoveredContacts_addedSome(int added, int failed) {
    return 'Contacts ajoutés : $added. Non ajoutés : $failed.';
  }

  @override
  String get discoveredContacts_radioFull =>
      'La liste de contacts de votre radio est pleine. Supprimez d’abord quelques contacts.';

  @override
  String get fieldIntel_radioNow => 'Radio en ce moment';

  @override
  String get fieldIntel_noRadio =>
      'Connectez votre radio pour les mesures en direct.';

  @override
  String get fieldIntel_noise => 'bruit dBm';

  @override
  String get fieldIntel_lastSnr => 'dernier SNR';

  @override
  String get fieldIntel_lastRssi => 'dernier RSSI';

  @override
  String get fieldIntel_battery => 'batterie V';

  @override
  String fieldIntel_airtime(String sent, String received) {
    return 'Temps d’émission depuis le démarrage de la radio : envoyé $sent, reçu $received';
  }

  @override
  String get fieldIntel_whoAround => 'Qui est dans le coin';

  @override
  String get fieldIntel_m15 => '15 min';

  @override
  String get fieldIntel_h1 => '1 heure';

  @override
  String get fieldIntel_h24 => '24 heures';

  @override
  String get fieldIntel_older => 'Plus ancien';

  @override
  String get fieldIntel_lastHour => 'Dernière heure';

  @override
  String get fieldIntel_chartHint =>
      'Quand chaque nœud a été entendu pour la dernière fois, heure par heure, sur la dernière journée. Touchez une barre pour voir qui.';

  @override
  String get fieldIntel_mix => 'Types de nœuds';

  @override
  String get fieldIntel_reach => 'Portée';

  @override
  String get fieldIntel_hops1 => '1 saut';

  @override
  String get fieldIntel_hops2 => '2 sauts';

  @override
  String get fieldIntel_hops3 => '3+ sauts';

  @override
  String get fieldIntel_noRoute => 'Pas encore de route';

  @override
  String get fieldIntel_distance => 'Les plus proches et les plus loin';

  @override
  String get fieldIntel_noneLocated => 'Aucun de vos contacts n’a de position.';

  @override
  String get fieldIntel_noPosition =>
      'Votre radio n’a pas encore de position : impossible de calculer les distances.';

  @override
  String get fieldIntel_bestRepeaters =>
      'Meilleurs répéteurs entendus en direct';

  @override
  String get fieldIntel_noneDirect =>
      'Aucun répéteur entendu en direct ces 30 dernières minutes.';

  @override
  String get fieldIntel_attention => 'À surveiller';

  @override
  String get fieldIntel_allGood => 'Rien à surveiller.';

  @override
  String fieldIntel_lowBattery(String volts) {
    return 'Batterie faible : $volts V';
  }

  @override
  String fieldIntel_quietFavorite(String ago) {
    return 'Favori non entendu depuis $ago';
  }

  @override
  String get fieldIntel_moreTools => 'Autres outils';

  @override
  String fieldIntel_nodeCount(int count) {
    return 'Nœuds : $count';
  }

  @override
  String get fieldIntel_none => 'Aucun nœud.';

  @override
  String fieldIntel_lastHeard(String ago) {
    return 'Entendu $ago';
  }

  @override
  String get fieldIntel_showOnMap => 'Voir sur la carte';

  @override
  String get fieldIntel_openChat => 'Ouvrir la discussion';

  @override
  String get repeaterTools_login => 'Se connecter';

  @override
  String get repeaterTools_heardDirect => 'Entendu en direct';

  @override
  String get repeaterTools_filterAll => 'Tous';

  @override
  String get repeaterTools_filterLowBattery => 'Batterie faible';

  @override
  String get repeaterTools_hint =>
      'Touchez un répéteur pour ses détails, puis connectez-vous pour l’état, les voisins, la télémétrie et la ligne de commande.';

  @override
  String get repeaterTools_noneMatch => 'Aucun répéteur ici.';

  @override
  String get repeaterTools_toolsTitle => 'Outils';

  @override
  String get repeaterTools_regionSetupHint =>
      'Trouvez l’arbre de régions de votre secteur et copiez ses commandes';

  @override
  String get routes_failingOnly => 'Seulement les routes en échec';

  @override
  String get routes_contactDetails => 'Détails du contact';

  @override
  String get links_contactTitle => 'Ajouter un contact ?';

  @override
  String get links_importAdvert => 'Ajouter ce contact à votre radio ?';

  @override
  String get links_connectFirst =>
      'Connectez d’abord votre radio, puis rouvrez le lien.';

  @override
  String get links_added => 'Contact ajouté';

  @override
  String get links_notContact => 'Ce lien n’est pas un contact MeshCore.';

  @override
  String get radioBuzzer_title => 'Buzzer de la radio';

  @override
  String get radioBuzzer_hint =>
      'La radio bipe à chaque nouveau message. Visible seulement pour les radios avec buzzer.';

  @override
  String get radioBuzzer_failed =>
      'La radio n’a pas accepté le changement. Réessayez.';

  @override
  String get appSettings_floodAttempts => 'Tentatives en inondation';

  @override
  String get appSettings_floodAttemptsSubtitle =>
      'Essais supplémentaires envoyés en inondation après l’échec des essais directs, au cas où la route aurait changé. Chacun utilise plus de temps d’antenne. 0 les désactive.';

  @override
  String get pathGraph_you => 'Vous';

  @override
  String pathGraph_relayed(int count) {
    return '$count messages relayés';
  }

  @override
  String get pathGraph_ambiguousNote =>
      'Cet ID court correspond à plusieurs répéteurs, impossible de l’attribuer à un seul.';

  @override
  String get pathGraph_comesFrom => 'Vient de';

  @override
  String get pathGraph_goesTo => 'Va vers';

  @override
  String get pathGraph_repeaterDetails => 'Détails du répéteur';

  @override
  String get pathGraph_days7 => '7 jours';

  @override
  String get pathGraph_empty =>
      'Aucun chemin de message de canal sur cette période. Les chemins sont collectés à partir des messages de canal reçus quand le traçage est activé.';

  @override
  String pathGraph_summary(int paths, int repeaters) {
    return '$paths chemins entendus · $repeaters répéteurs';
  }

  @override
  String get pathGraph_hashOnly =>
      'Chaque saut est affiché par son préfixe de hachage, ou son nom si vous connaissez le répéteur.';

  @override
  String pathGraph_matched(int count) {
    return '$count sauts courts (1 octet) associés à un répéteur précis grâce à des chemins plus longs.';
  }

  @override
  String pathGraph_matchedAmbiguous(int matched, int ambiguous) {
    return '$matched sauts courts (1 octet) associés à un répéteur précis grâce à des chemins plus longs · $ambiguous encore ambigus (marqués ?).';
  }

  @override
  String get pathGraph_chartHint =>
      'À gauche : répéteurs plus éloignés. À droite : vous. L’épaisseur de la bande indique combien de messages ont pris ce saut. Touchez une case pour voir ce répéteur.';

  @override
  String get pathGraph_busiest => 'Répéteurs les plus actifs';

  @override
  String pathGraph_chartSemantics(String name, int count) {
    return 'Graphe des chemins. Répéteur le plus actif $name, $count messages relayés.';
  }

  @override
  String diag_copied(String label) {
    return 'Copié : $label';
  }

  @override
  String get diag_noChannels => 'Aucun canal sur cette radio.';

  @override
  String get diag_tapToCopy =>
      'Touchez une valeur pour la copier. Tirez vers le bas pour actualiser.';

  @override
  String get diag_storage => 'Stockage';

  @override
  String diag_storageValue(int used, int total) {
    return '$used sur $total Ko';
  }

  @override
  String get rxLog_title => 'Journal RX';

  @override
  String get rxLog_hint => 'Chaque paquet entendu par votre radio, en direct';

  @override
  String get rxLog_empty =>
      'Aucun paquet pour l\'instant. Les paquets entendus par votre radio apparaissent ici dès leur arrivée.';

  @override
  String get rxLog_note =>
      'Conservé en mémoire uniquement, les 2 000 derniers paquets. Rien n\'est enregistré ni envoyé.';

  @override
  String get rxLog_pause => 'Pause';

  @override
  String get rxLog_resume => 'Reprendre';

  @override
  String get rxLog_export => 'Exporter en CSV';

  @override
  String get rxLog_clearConfirm => 'Effacer le journal RX ?';

  @override
  String rxLog_count(int shown, int total) {
    return '$shown affichés · $total entendus';
  }

  @override
  String get rxLog_paused =>
      'En pause : les nouveaux paquets ne sont pas enregistrés';

  @override
  String get rxLog_kindAll => 'Tous';

  @override
  String get rxLog_kindAdvert => 'Annonces';

  @override
  String get rxLog_kindChannel => 'Canal';

  @override
  String get rxLog_kindDirect => 'Directs';

  @override
  String get rxLog_kindAck => 'ACK';

  @override
  String get rxLog_kindPath => 'Chemins';

  @override
  String get rxLog_kindTrace => 'Traces';

  @override
  String get rxLog_kindControl => 'Contrôle';

  @override
  String get rxLog_kindOther => 'Autres';

  @override
  String get rxLog_routeFlood => 'Inondation';

  @override
  String get rxLog_routeDirect => 'Route directe';

  @override
  String get rxLog_heardDirectly => 'Entendu directement';

  @override
  String rxLog_hops(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sauts',
      one: '1 saut',
    );
    return '$_temp0';
  }

  @override
  String rxLog_bytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count octets',
      one: '1 octet',
    );
    return '$_temp0';
  }

  @override
  String get rxLog_own => 'Votre radio';

  @override
  String rxLog_signal(String snr, int rssi) {
    return 'SNR $snr · $rssi dBm';
  }

  @override
  String get rxLog_signalTitle => 'Signal';

  @override
  String get rxLog_route => 'Route';

  @override
  String get rxLog_path => 'Chemin';

  @override
  String get rxLog_payloadType => 'Type de charge';

  @override
  String get rxLog_hash => 'Hash du paquet';

  @override
  String get rxLog_raw => 'Paquet brut';

  @override
  String get rxLog_copyHex => 'Copier l\'hex';

  @override
  String get deliv_title => 'Détails de remise';

  @override
  String get deliv_note => 'Déduit de ce qui est enregistré avec ce message.';

  @override
  String get deliv_queued => 'En file d\'attente';

  @override
  String get deliv_sent => 'Envoyé par votre radio';

  @override
  String get deliv_notSent => 'Non pris en charge par votre radio';

  @override
  String get deliv_attempts => 'Tentatives';

  @override
  String deliv_attemptsValue(int made, int total) {
    return '$made sur $total';
  }

  @override
  String deliv_plan(int direct, int flood) {
    return 'Plan : $direct en direct, puis $flood par inondation';
  }

  @override
  String get deliv_lastRoute => 'Dernière route';

  @override
  String get deliv_routeFlood => 'Inondation par tous les répéteurs';

  @override
  String get deliv_routeNeighbor => 'Direct, sans répéteur';

  @override
  String deliv_routeVia(String path) {
    return 'Direct via $path';
  }

  @override
  String get deliv_confirmed => 'Réception confirmée';

  @override
  String deliv_tripTime(String seconds) {
    return 'Aller-retour $seconds s';
  }

  @override
  String get deliv_waiting => 'En attente de confirmation';

  @override
  String get deliv_noConfirm => 'Aucune confirmation';

  @override
  String deliv_lastHeard(String name) {
    return '$name entendu pour la dernière fois';
  }

  @override
  String deliv_hoursAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'il y a $hours heures',
      one: 'il y a 1 heure',
    );
    return '$_temp0';
  }

  @override
  String deliv_vDelivered(String name) {
    return 'Remis. $name l\'a confirmé.';
  }

  @override
  String deliv_vDeliveredFlood(String name) {
    return 'Remis par inondation après l\'échec des tentatives directes. La route enregistrée vers $name n\'est peut-être plus à jour.';
  }

  @override
  String deliv_vPending(int attempt, int total) {
    return 'Toujours en cours : tentative $attempt sur $total.';
  }

  @override
  String get deliv_vNotSent =>
      'Votre radio n\'a jamais pris ce message. Vérifiez qu\'elle est connectée, puis réessayez.';

  @override
  String deliv_vQuiet(String name, int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours heures',
      one: '1 heure',
    );
    return 'Aucune confirmation. $name n\'a pas été entendu depuis $_temp0 : hors de portée ou éteint ?';
  }

  @override
  String get deliv_vNoFlood =>
      'Aucune confirmation par la route enregistrée, et les tentatives par inondation sont désactivées. Activez-les dans Réglages → Réglages de l\'app → Messagerie, ou réessayez.';

  @override
  String get deliv_vNoAck =>
      'Aucune confirmation par aucune route. Hors de portée, ou leur confirmation n\'a pas pu revenir jusqu\'à vous.';

  @override
  String get favReturn_setting => 'Favoris de retour à portée';

  @override
  String get favReturn_settingHint =>
      'Prévenir quand un favori se fait de nouveau entendre après un silence';

  @override
  String get favReturn_off => 'Désactivé';

  @override
  String favReturn_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Après $count heures',
      one: 'Après 1 heure',
    );
    return '$_temp0';
  }

  @override
  String get favReturn_title => 'De retour à portée';

  @override
  String favReturn_body(String name, int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours heures',
      one: '1 heure',
    );
    return '$name entendu de nouveau après $_temp0 de silence';
  }

  @override
  String block_sender(String name) {
    return 'Bloquer $name';
  }

  @override
  String get block_confirmBody =>
      'Ses messages de canal sont masqués sur cet appareil et ne vous notifient jamais. Cette personne voit toujours vos messages. Vous pouvez la débloquer dans les Réglages.';

  @override
  String get block_action => 'Bloquer';

  @override
  String block_done(String name) {
    return '$name bloqué';
  }

  @override
  String get mention_suggestions => 'Suggestions de noms';

  @override
  String get block_listTitle => 'Expéditeurs bloqués';

  @override
  String get block_listHint =>
      'Les messages de ces noms sont masqués dans les canaux et ne vous notifient jamais.';

  @override
  String get block_listEmpty => 'Personne n\'est bloqué.';

  @override
  String get block_unblock => 'Débloquer';

  @override
  String block_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bloqués',
      one: '1 bloqué',
      zero: 'Personne de bloqué',
    );
    return '$_temp0';
  }

  @override
  String contactTable_nearlyFull(int percent) {
    return 'Liste de contacts de la radio pleine à $percent%';
  }

  @override
  String get contactTable_full => 'La liste de contacts de la radio est pleine';

  @override
  String contactTable_count(int used, int max) {
    return '$used contacts sur $max';
  }

  @override
  String get contactTable_overwriteHint =>
      'Une fois pleine, la radio remplace le contact entendu le moins récemment. Les favoris sont conservés.';

  @override
  String get contactTable_stopHint =>
      'Une fois pleine, la radio n\'ajoute plus les nouveaux contacts qu\'elle entend.';

  @override
  String get contactTable_freeUp => 'Libérer de la place';

  @override
  String get contactTable_sheetBody =>
      'Les moins récemment entendus d\'abord. Les favoris ne sont pas listés.';

  @override
  String contactTable_lastHeard(String when) {
    return 'Entendu $when';
  }

  @override
  String contactTable_remove(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Retirer $count contacts',
      one: 'Retirer 1 contact',
    );
    return '$_temp0';
  }

  @override
  String get contactTable_confirmBody =>
      'Ils sont retirés de la radio et leurs messages sur cet appareil sont supprimés. Action irréversible.';

  @override
  String contactTable_removed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contacts retirés',
      one: '1 contact retiré',
    );
    return '$_temp0';
  }

  @override
  String get contactTable_noneToSuggest =>
      'Tous les contacts sont des favoris, il n\'y a donc rien à suggérer.';

  @override
  String get adminWait_waiting => 'En attente de réponse';

  @override
  String adminWait_retrying(int attempt, int total) {
    return 'Pas encore de réponse. Nouvel essai ($attempt sur $total)';
  }

  @override
  String adminWait_direct(int hops) {
    String _temp0 = intl.Intl.pluralLogic(
      hops,
      locale: localeName,
      other: 'Direct, $hops sauts',
      one: 'Direct, 1 saut',
      zero: 'Direct',
    );
    return '$_temp0';
  }

  @override
  String adminWait_upTo(int seconds) {
    return 'jusqu\'à $seconds s';
  }
}
