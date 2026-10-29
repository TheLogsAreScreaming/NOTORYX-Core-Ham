// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core';

  @override
  String get nav_contacts => 'Contactos';

  @override
  String get nav_channels => 'Canales';

  @override
  String get nav_map => 'Mapa';

  @override
  String get nav_messages => 'Mensajes';

  @override
  String get nav_nodes => 'Nodos';

  @override
  String get nav_radio => 'Radio';

  @override
  String get messages_title => 'Mensajes';

  @override
  String get messages_filterAll => 'Todos';

  @override
  String get messages_filterDirect => 'Directos';

  @override
  String get messages_filterChannels => 'Canales';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'Buscar mensajes';

  @override
  String get messages_searchHint => 'Buscar conversaciones';

  @override
  String get messages_closeSearch => 'Cerrar búsqueda';

  @override
  String get messages_manageChannels => 'Gestionar canales';

  @override
  String get messages_new => 'Nuevo';

  @override
  String get messages_newDirect => 'Escribir a un nodo';

  @override
  String get messages_newChannel => 'Añadir o unirse a un canal';

  @override
  String get messages_empty => 'Aún no hay conversaciones';

  @override
  String get messages_emptyHint =>
      'Los mensajes de nodos y canales aparecen aquí.';

  @override
  String get messages_noMatches =>
      'Ninguna conversación coincide con tu búsqueda';

  @override
  String messages_you(String text) {
    return 'Tú: $text';
  }

  @override
  String get messages_yesterday => 'Ayer';

  @override
  String messages_unreadCount(int count) {
    return '$count sin leer';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return 'Conectado por $transport';
  }

  @override
  String get radioStatus_bluetooth => 'Bluetooth';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'Wi‑Fi (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return 'Batería $percent %';
  }

  @override
  String get radioStatus_openRadio => 'Abrir detalles de la radio';

  @override
  String get radioOverview_battery => 'Batería';

  @override
  String radioOverview_firmware(String version) {
    return 'Firmware $version';
  }

  @override
  String get radioOverview_sendAdvert => 'Enviar anuncio';

  @override
  String get radioOverview_stats => 'Estadísticas de radio';

  @override
  String get accessControl_title => 'Control de acceso';

  @override
  String get accessControl_hubSubtitle =>
      'Quién puede iniciar sesión sin la contraseña';

  @override
  String get accessControl_explainRepeater =>
      'Las personas de esta lista inician sesión sin contraseña. Los administradores pueden cambiar configuración; Solo lectura y Lectura y escritura también reciben la telemetría completa.';

  @override
  String get accessControl_explainRoom =>
      'Los administradores de esta lista inician sesión sin contraseña y pueden gestionar la sala. Los miembros de la sala entran con la contraseña de la sala.';

  @override
  String get accessControl_roleReadOnly => 'Solo lectura';

  @override
  String get accessControl_roleReadWrite => 'Lectura y escritura';

  @override
  String get accessControl_roleAdmin => 'Administrador';

  @override
  String get accessControl_you => 'Tú';

  @override
  String get accessControl_unknownNode => 'Nodo desconocido';

  @override
  String get accessControl_add => 'Añadir';

  @override
  String get accessControl_addTitle => 'Añadir a la lista de acceso';

  @override
  String get accessControl_pickContact => 'Elige un contacto';

  @override
  String get accessControl_noContacts =>
      'No hay contactos para añadir. Los nodos aparecen aquí cuando has recibido su anuncio.';

  @override
  String get accessControl_changeRole => 'Cambiar rol';

  @override
  String get accessControl_remove => 'Quitar acceso';

  @override
  String accessControl_removeConfirm(String name) {
    return '¿Quitar a $name de la lista de acceso? Necesitará la contraseña para iniciar sesión.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'Eres tú. Si te quitas, necesitarás la contraseña de administrador para volver a gestionar este nodo.';

  @override
  String get accessControl_unknownKeyNote =>
      'No está en tus contactos. Cambiar su rol requiere un firmware de nodo más reciente; quitarlo siempre funciona.';

  @override
  String get accessControl_prefixUnsupported =>
      'El firmware de este nodo no puede cambiar el rol de alguien que no está en tus contactos. Aún puedes quitarlo.';

  @override
  String get accessControl_empty => 'No hay nadie en la lista de acceso';

  @override
  String get accessControl_emptyHint =>
      'Añade personas para que puedan iniciar sesión sin la contraseña.';

  @override
  String get accessControl_loading => 'Pidiendo al nodo su lista de acceso…';

  @override
  String get accessControl_timeout =>
      'El nodo no respondió. Revisa la ruta e inténtalo de nuevo.';

  @override
  String get accessControl_maybeIncomplete =>
      'Este nodo envió una página completa y su firmware no puede enviar más, así que pueden faltar entradas.';

  @override
  String get accessControl_saved => 'Lista de acceso actualizada';

  @override
  String accessControl_failed(String reply) {
    return 'El nodo rechazó el cambio: $reply';
  }

  @override
  String get companionCli_title => 'Línea de comandos';

  @override
  String get companionCli_tileSubtitle => 'Ejecuta comandos en tu radio';

  @override
  String get companionCli_warning =>
      'Los comandos se ejecutan en tu radio conectada y pueden cambiar sus configuración o reiniciarla.';

  @override
  String get companionCli_hint => 'Escribe un comando, p. ej. ver';

  @override
  String get companionCli_send => 'Ejecutar comando';

  @override
  String get companionCli_noReply =>
      'Sin respuesta. Puede que la radio se esté reiniciando.';

  @override
  String get companionCli_empty =>
      'Prueba uno de los comandos de arriba o escribe el tuyo.';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle => 'Conecta tu radio a una red Wi‑Fi';

  @override
  String get wifi_unsupported => 'El firmware de esta radio no incluye Wi‑Fi.';

  @override
  String get wifi_enabled => 'Usar Wi‑Fi';

  @override
  String get wifi_status => 'Estado';

  @override
  String get wifi_connected => 'Conectado';

  @override
  String wifi_connectedIp(String ip) {
    return 'Conectado · $ip';
  }

  @override
  String get wifi_disconnected => 'No conectado';

  @override
  String get wifi_network => 'Nombre de red (SSID)';

  @override
  String get wifi_password => 'Contraseña';

  @override
  String get wifi_passwordKeep =>
      'Déjalo vacío para mantener la contraseña actual';

  @override
  String get wifi_save => 'Guardar';

  @override
  String get wifi_forget => 'Olvidar red';

  @override
  String get wifi_forgetConfirm =>
      '¿Quitar de la radio la red y la contraseña guardadas?';

  @override
  String get wifi_rebootNeeded =>
      'Guardado. Reinicia la radio para aplicar los cambios de Wi‑Fi.';

  @override
  String get wifi_rebootNow => 'Reiniciar radio';

  @override
  String get wifi_rebootConfirm =>
      '¿Reiniciar la radio ahora? La app se desconectará y tendrás que volver a conectar.';

  @override
  String get wifi_loadFailed =>
      'No se pudieron leer los configuración Wi‑Fi de la radio.';

  @override
  String get wifi_retry => 'Reintentar';

  @override
  String wifi_saveFailed(String reply) {
    return 'La radio no aceptó el cambio: $reply';
  }

  @override
  String get accessControl_refresh => 'Actualizar';

  @override
  String get common_cancel => 'Cancelar';

  @override
  String get common_ok => 'Aceptar';

  @override
  String get common_connect => 'Conectar';

  @override
  String get common_unknownDevice => 'Dispositivo Desconocido';

  @override
  String get common_save => 'Guardar';

  @override
  String get common_delete => 'Eliminar';

  @override
  String get common_deleteAll => 'Eliminar todo';

  @override
  String get common_close => 'Cerrar';

  @override
  String get common_done => 'Hecho';

  @override
  String get common_edit => 'Editar';

  @override
  String get common_add => 'Añadir';

  @override
  String get common_settings => 'Configuración';

  @override
  String get common_disconnect => 'Desconectar';

  @override
  String get common_connected => 'Conectado';

  @override
  String get common_disconnected => 'Desconectado';

  @override
  String get common_create => 'Crear';

  @override
  String get common_continue => 'Continuar';

  @override
  String get common_share => 'Compartir';

  @override
  String get common_copy => 'Copiar';

  @override
  String get common_retry => 'Reintentar';

  @override
  String get common_hide => 'Ocultar';

  @override
  String get common_remove => 'Eliminar';

  @override
  String get common_enable => 'Activar';

  @override
  String get common_disable => 'Desactivar';

  @override
  String get common_undo => 'Deshacer';

  @override
  String get messageStatus_sent => 'Enviado';

  @override
  String get messageStatus_delivered => 'Entregado';

  @override
  String get messageStatus_pending => 'Enviando';

  @override
  String get messageStatus_failed => 'No se pudo enviar';

  @override
  String get messageStatus_repeated => 'Escuchado repetidamente';

  @override
  String get urlImage_enable => 'Activar imágenes por URL';

  @override
  String get urlImage_possible =>
      'Posible imagen por URL; actívala en Configuración.';

  @override
  String get common_reboot => 'Reiniciar';

  @override
  String get common_loading => 'Cargando...';

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
  String get common_autoRefresh => 'Actualización automática';

  @override
  String get common_interval => 'Intervalo';

  @override
  String get scanner_title => 'NOTORYX Core';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'Establecer conexión a través de TCP';

  @override
  String get tcpHostLabel => 'Dirección IP';

  @override
  String get tcpHostHint => '192.168.40.10';

  @override
  String get tcpPortLabel => 'Puerto';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => 'Ingrese la dirección final y conecte.';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return 'Conectándose a $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => 'Se requiere la dirección IP.';

  @override
  String get tcpErrorPortInvalid => 'El puerto debe estar entre 1 y 65535.';

  @override
  String get tcpErrorUnsupported =>
      'El protocolo de transporte TCP no está soportado en esta plataforma.';

  @override
  String get tcpErrorTimedOut => 'La conexión TCP ha caducado.';

  @override
  String tcpConnectionFailed(String error) {
    return 'Error en la conexión TCP: $error';
  }

  @override
  String get usbScreenTitle => 'Conecte mediante USB';

  @override
  String get usbScreenSubtitle =>
      'Seleccione el dispositivo de serie detectado y conéctelo directamente a su nodo MeshCore.';

  @override
  String get usbScreenStatus => 'Seleccione un dispositivo USB';

  @override
  String get usbScreenNote =>
      'La comunicación serial a través de USB está activa en dispositivos Android compatibles y en plataformas de escritorio.';

  @override
  String get usbScreenEmptyState =>
      'No se encontraron dispositivos USB. Conecte uno y vuelva a intentar.';

  @override
  String get usbErrorPermissionDenied =>
      'Se denegó el permiso de acceso a través de USB.';

  @override
  String get usbErrorDeviceMissing =>
      'El dispositivo USB seleccionado ya no está disponible.';

  @override
  String get usbErrorInvalidPort => 'Seleccione un dispositivo USB válido.';

  @override
  String get usbErrorBusy =>
      'Ya se ha iniciado una solicitud de conexión USB adicional.';

  @override
  String get usbErrorNotConnected => 'No hay ningún dispositivo USB conectado.';

  @override
  String get usbErrorOpenFailed =>
      'No se pudo abrir el dispositivo USB seleccionado.';

  @override
  String get usbErrorConnectFailed =>
      'No se pudo conectar con el dispositivo USB seleccionado.';

  @override
  String get usbErrorUnsupported =>
      'La comunicación serial a través de USB no está soportada en esta plataforma.';

  @override
  String get usbErrorAlreadyActive => 'La conexión USB ya está activa.';

  @override
  String get usbErrorNoDeviceSelected =>
      'No se ha seleccionado ningún dispositivo USB.';

  @override
  String get usbErrorPortClosed => 'La conexión USB no está activa.';

  @override
  String get usbErrorConnectTimedOut =>
      'La conexión ha caducado. Asegúrese de que el dispositivo tenga el firmware USB Companion.';

  @override
  String get usbFallbackDeviceName => 'Dispositivo de serie web';

  @override
  String get usbStatus_notConnected => 'Seleccione un dispositivo USB';

  @override
  String get usbStatus_connecting => 'Conectándose al dispositivo USB...';

  @override
  String get usbStatus_searching => 'Buscando dispositivos USB...';

  @override
  String usbConnectionFailed(String error) {
    return 'Error al conectar mediante USB: $error';
  }

  @override
  String get scanner_scanning => 'Escaneando dispositivos...';

  @override
  String get scanner_connecting => 'Conectando...';

  @override
  String get scanner_disconnecting => 'Desconectando...';

  @override
  String get scanner_notConnected => 'No conectado';

  @override
  String scanner_connectedTo(String deviceName) {
    return 'Conectado a $deviceName';
  }

  @override
  String get scanner_searchingDevices => 'Buscando dispositivos MeshCore...';

  @override
  String get scanner_tapToScan =>
      'Pulsa Escanear para encontrar dispositivos MeshCore';

  @override
  String scanner_connectionFailed(String error) {
    return 'Error de conexión: $error';
  }

  @override
  String get scanner_stop => 'Detener';

  @override
  String get scanner_scan => 'Escanear';

  @override
  String get scanner_bluetoothOff => 'Bluetooth está desactivado.';

  @override
  String get scanner_bluetoothOffMessage =>
      'Por favor, active el Bluetooth para escanear dispositivos.';

  @override
  String get scanner_chromeRequired => 'Navegador Chrome requerido';

  @override
  String get scanner_chromeRequiredMessage =>
      'Esta aplicación web requiere Google Chrome o un navegador basado en Chromium para el soporte de Bluetooth.';

  @override
  String get scanner_enableBluetooth => 'Habilitar Bluetooth';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'La funcionalidad Bluetooth no está disponible en el navegador. Conéctese mediante USB en su lugar.';

  @override
  String get device_quickSwitch => 'Cambiar rápidamente';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => 'Configuración';

  @override
  String get settings_deviceInfo => 'Información del dispositivo';

  @override
  String get settings_appSettings => 'Configuración de la App';

  @override
  String get settings_appSettingsSubtitle =>
      'Notificaciones, mensajes y preferencias de mapa';

  @override
  String get settings_nodeSettings => 'Configuración del Nodo';

  @override
  String get settings_nodeName => 'Nombre del nodo';

  @override
  String get settings_nodeNameNotSet => 'No está configurado';

  @override
  String get settings_nodeNameHint => 'Introducir nombre de nodo';

  @override
  String get settings_nodeNameUpdated => 'Nombre actualizado';

  @override
  String get settings_radioSettings => 'Configuración de Radio';

  @override
  String get settings_radioSettingsSubtitle =>
      'Frecuencia, potencia, factor de dispersión';

  @override
  String get settings_radioSettingsUpdated => 'Ajustes de radio actualizados';

  @override
  String get settings_regionSettings => 'Regiones';

  @override
  String get settings_regionSettingsSubtitle =>
      'Gestionar regiones almacenadas';

  @override
  String get settings_corridorRegion => 'Región del corredor';

  @override
  String get settings_corridorRegionDefault => '#corridor (predeterminada)';

  @override
  String get settings_corridorRegionHelp =>
      'Los paquetes de corredor de inundación se etiquetan con esta región. Los repetidores sin firmware de corredor solo los reenvían si permiten esta región. Déjalo vacío para la etiqueta predeterminada #corridor.';

  @override
  String get settings_corridorRegionHint => 'Nombre de la región';

  @override
  String get settings_corridorRegionUseDefault => 'Usar predeterminada';

  @override
  String get settings_corridorRegionUpdated =>
      'Región del corredor actualizada';

  @override
  String get settings_corridorRegionFailed =>
      'No se pudo actualizar la región del corredor';

  @override
  String get settings_regionManagement_screenTitle => 'Gestión de Regiones';

  @override
  String get settings_regionNameHint => 'Nombre de la región';

  @override
  String get settings_regionAddRegion => 'Añadir región';

  @override
  String get settings_regionFetchRegions => 'Obtener regiones de repetidores';

  @override
  String get settings_regionFetchRegionsFail => 'No se encontraron regiones';

  @override
  String get settings_regionFetchRegionsAlreadyExists =>
      'Esta región ya ha sido agregada';

  @override
  String get settings_regionName => 'Nombre de la Región';

  @override
  String get settings_regionDeleted => 'Región eliminada';

  @override
  String get settings_deleteRegion => 'Eliminar Región';

  @override
  String settings_deleteRegionConfirm(String region) {
    return '¿Eliminar \"$region\" de la lista de regiones?';
  }

  @override
  String get settings_location => 'Ubicación';

  @override
  String get settings_locationSubtitle => 'Coordenadas GPS';

  @override
  String get settings_locationUpdated => 'Ubicación actualizada';

  @override
  String get settings_locationBothRequired =>
      'Introduzca tanto la latitud como la longitud.';

  @override
  String get settings_locationInvalid => 'Latitud o longitud inválidos.';

  @override
  String get settings_locationGPSEnable => 'Habilitar GPS';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'Habilita la actualización automática de la ubicación mediante GPS.';

  @override
  String get settings_locationIntervalSec => 'Intervalo para GPS (Segundos)';

  @override
  String get settings_locationIntervalInvalid =>
      'El intervalo debe ser de al menos 60 segundos y menor que 86400 segundos.';

  @override
  String get settings_latitude => 'Latitud';

  @override
  String get settings_longitude => 'Longitud';

  @override
  String get settings_contactSettings => 'Configuración de contacto';

  @override
  String get settings_contactSettingsSubtitle =>
      'Configuración de cómo se agregan los contactos.';

  @override
  String get settings_privacyMode => 'Modo de privacidad';

  @override
  String get settings_privacyModeSubtitle =>
      'Ocultar nombre/ubicación en anuncios';

  @override
  String get settings_privacyModeToggle =>
      'Activar el modo de privacidad para ocultar tu nombre y ubicación en los anuncios.';

  @override
  String get settings_privacyModeEnabled => 'Modo de privacidad activado';

  @override
  String get settings_privacyModeDisabled => 'Modo de privacidad desactivado';

  @override
  String get settings_privacy => 'Configuración de privacidad';

  @override
  String get settings_privacySubtitle =>
      'Controlar qué información se comparte.';

  @override
  String get settings_privacySettingsDescription =>
      'Elige qué información comparte tu dispositivo con otros.';

  @override
  String get settings_denyAll => 'Denegar todo';

  @override
  String get settings_allowByContact => 'Permitir por banderas de contacto';

  @override
  String get settings_allowAll => 'Permitir todo';

  @override
  String get settings_telemetryBaseMode => 'Modo base de telemetría';

  @override
  String get settings_telemetryLocationMode =>
      'Modo de ubicación de telemetría';

  @override
  String get settings_telemetryEnvironmentMode =>
      'Modo de entorno de telemetría';

  @override
  String get settings_advertLocation => 'Ubicación de anuncio';

  @override
  String get settings_advertLocationSubtitle => 'Incluir ubicación en anuncio';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'Anuncio de cero saltos automático al actualizar GPS';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'Cuando cambie la ubicación GPS, enviar un anuncio de cero saltos (requiere ubicación en anuncio).';

  @override
  String get settings_multiAck => 'Múltiples respuestas de confirmación';

  @override
  String get settings_telemetryModeUpdated => 'Modo de telemetría actualizado';

  @override
  String get settings_actions => 'Acciones';

  @override
  String get settings_deleteAllPaths => 'Eliminar todas las rutas';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Borrar todos los datos de ruta de los contactos.';

  @override
  String get settings_sendAdvertisement => 'Enviar anuncio';

  @override
  String get settings_sendAdvertisementSubtitle =>
      'Difundir la presencia ahora';

  @override
  String get settings_advertisementSent => 'Anuncio enviado';

  @override
  String get settings_syncTime => 'Sincronizar hora';

  @override
  String get settings_syncTimeSubtitle =>
      'Establecer la hora del dispositivo con la del teléfono';

  @override
  String get settings_timeSynchronized => 'Hora sincronizada';

  @override
  String get settings_refreshContacts => 'Actualizar contactos';

  @override
  String get settings_refreshContactsSubtitle =>
      'Recargar lista de contactos del dispositivo';

  @override
  String get settings_rebootDevice => 'Reiniciar dispositivo';

  @override
  String get settings_rebootDeviceSubtitle =>
      'Reiniciar el dispositivo MeshCore';

  @override
  String get settings_rebootDeviceConfirm =>
      '¿Está seguro de que desea reiniciar el dispositivo? Se desconectará.';

  @override
  String get settings_debug => 'Depurar';

  @override
  String get settings_companionDebugLog => 'Registro de depuración asociado';

  @override
  String get settings_companionDebugLogSubtitle =>
      'Comandos, respuestas y datos brutos para protocolos BLE/TCP/USB';

  @override
  String get settings_appDebugLog => 'Registro de Depuración de la App';

  @override
  String get settings_appDebugLogSubtitle =>
      'Mensajes de depuración de la aplicación';

  @override
  String get settings_about => 'Acerca de';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core v$version';
  }

  @override
  String get settings_aboutLegalese => 'Proyecto MeshCore Open Source 2026';

  @override
  String get settings_aboutDescription =>
      'Un cliente Flutter de código abierto para dispositivos MeshCore de malla LoRa.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'Datos de elevación LOS: Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => 'Nombre';

  @override
  String get settings_infoId => 'ID';

  @override
  String get settings_infoStatus => 'Estado';

  @override
  String get settings_infoBattery => 'Batería';

  @override
  String get settings_infoPublicKey => 'Clave pública';

  @override
  String get settings_infoContactsCount => 'Número de contactos';

  @override
  String get settings_infoChannelCount => 'Número de canales';

  @override
  String get settings_infoHardware => 'Hardware';

  @override
  String get settings_infoFirmware => 'Firmware';

  @override
  String get settings_presets => 'Preajustes';

  @override
  String get settings_frequency => 'Frecuencia (MHz)';

  @override
  String get settings_frequencyHelper => '300,0 - 2500,0';

  @override
  String get settings_frequencyInvalid => 'Frecuencia inválida (300-2500 MHz)';

  @override
  String get settings_bandwidth => 'Ancho de banda';

  @override
  String get settings_spreadingFactor => 'Factor de propagación';

  @override
  String get settings_codingRate => 'Tasa de codificación';

  @override
  String get settings_txPower => 'Potencia TX (dBm)';

  @override
  String get settings_txPowerHelper => '0 - 22';

  @override
  String get settings_txPowerInvalid => 'Potencia de TX inválida (0-22 dBm)';

  @override
  String get settings_clientRepeat => 'Repetir sin conexión';

  @override
  String get settings_clientRepeatSubtitle =>
      'Permita que este dispositivo repita los paquetes de red para otros usuarios.';

  @override
  String get settings_clientRepeatFreqWarning =>
      'Para la comunicación fuera de la red, se requiere una frecuencia de 433, 869 o 918 MHz.';

  @override
  String settings_error(String message) {
    return 'Error: $message';
  }

  @override
  String get appSettings_title => 'Configuración de la App';

  @override
  String get appSettings_appearance => 'Apariencia';

  @override
  String get appSettings_theme => 'Tema';

  @override
  String get appSettings_themeSystem => 'Valor predeterminado del sistema';

  @override
  String get appSettings_themeLight => 'Claro';

  @override
  String get appSettings_themeDark => 'Oscuro';

  @override
  String get appSettings_language => 'Idioma';

  @override
  String get appSettings_languageSystem => 'Predeterminado del sistema';

  @override
  String get appSettings_languageEn => 'Inglés';

  @override
  String get appSettings_languageFr => 'Francés';

  @override
  String get appSettings_languageEs => 'Español';

  @override
  String get appSettings_languageDe => 'Alemán';

  @override
  String get appSettings_languagePl => 'Polaco';

  @override
  String get appSettings_languageSl => 'Esloveno';

  @override
  String get appSettings_languagePt => 'Portugués';

  @override
  String get appSettings_languageIt => 'Italiano';

  @override
  String get appSettings_languageZh => 'Chino';

  @override
  String get appSettings_languageSv => 'Sueco';

  @override
  String get appSettings_languageNl => 'Neerlandés';

  @override
  String get appSettings_languageSk => 'Eslovaco';

  @override
  String get appSettings_languageBg => 'Búlgaro';

  @override
  String get appSettings_languageRu => 'Ruso';

  @override
  String get appSettings_languageUk => 'Ucraniano';

  @override
  String get repeater_pathHashModeOption0 => '0 - 1 byte';

  @override
  String get repeater_pathHashModeOption1 => '1 - 2 bytes';

  @override
  String get repeater_pathHashModeOption2 => '2 - 3 bytes';

  @override
  String get repeater_pathHashModeOption3 => '3 - 4 bytes';

  @override
  String get appSettings_enableMessageTracing =>
      'Habilitar seguimiento de mensajes';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'Mostrar metadatos detallados de enrutamiento y tiempo para los mensajes';

  @override
  String get appSettings_notifications => 'Notificaciones';

  @override
  String get appSettings_enableNotifications => 'Habilitar notificaciones';

  @override
  String get appSettings_enableNotificationsSubtitle =>
      'Recibir notificaciones para mensajes y anuncios';

  @override
  String get appSettings_notificationPermissionDenied =>
      'Permiso de notificación denegado';

  @override
  String get appSettings_notificationsEnabled => 'Notificaciones activadas';

  @override
  String get appSettings_notificationsDisabled => 'Notificaciones desactivadas';

  @override
  String get appSettings_messageNotifications => 'Notificaciones de mensajes';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      'Mostrar notificación al recibir nuevos mensajes';

  @override
  String get appSettings_channelMessageNotifications =>
      'Notificaciones de mensajes del canal';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'Mostrar notificación al recibir mensajes del canal';

  @override
  String get appSettings_advertisementNotifications =>
      'Notificaciones de anuncios';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      'Mostrar notificación cuando se descubren nuevos nodos';

  @override
  String get appSettings_messaging => 'Mensajería';

  @override
  String get appSettings_clearPathOnMaxRetry =>
      'Borrar ruta al máximo de reintentos';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      'Restablecer la ruta de contacto después de 5 intentos de envío fallidos';

  @override
  String get appSettings_pathsWillBeCleared =>
      'Las rutas se borrarán después de 5 intentos fallidos.';

  @override
  String get appSettings_pathsWillNotBeCleared =>
      'Las rutas no se eliminarán automáticamente.';

  @override
  String get appSettings_autoRouteRotation => 'Rotación automática de rutas';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      'Alternar entre las mejores rutas y el modo inundación';

  @override
  String get appSettings_autoRouteRotationEnabled =>
      'Rotación de ruta automática habilitada';

  @override
  String get appSettings_autoRouteRotationDisabled =>
      'Rotación de ruta automática desactivada';

  @override
  String get appSettings_maxRouteWeight => 'Peso máximo permitido para la ruta';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      'Peso máximo que una ruta puede acumular gracias a entregas exitosas.';

  @override
  String get appSettings_initialRouteWeight => 'Peso inicial de la ruta';

  @override
  String get appSettings_initialRouteWeightSubtitle =>
      'Peso inicial para rutas recién descubiertas';

  @override
  String get appSettings_routeWeightSuccessIncrement =>
      'Incremento de peso para el éxito';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      'Peso añadido a una ruta después de una entrega exitosa.';

  @override
  String get appSettings_routeWeightFailureDecrement =>
      'Reducción del peso asociado al fallo';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      'Peso retirado de una ruta después de un intento de entrega fallido.';

  @override
  String get appSettings_maxMessageRetries =>
      'Número máximo de reintentos de envío de mensajes';

  @override
  String get appSettings_maxMessageRetriesSubtitle =>
      'Número de intentos de reintento antes de marcar un mensaje como fallido.';

  @override
  String get appSettings_battery => 'Batería';

  @override
  String get appSettings_batteryChemistry => 'Química de la batería';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return 'Configurar por dispositivo ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      'Conéctate a un dispositivo para elegirlo';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3,0-4,2 V)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2,6-3,65 V)';

  @override
  String get appSettings_batteryLipo => 'LiPo (3,0-4,2 V)';

  @override
  String get appSettings_batteryLipoHv => 'LiPo HV (3.0-4.35V)';

  @override
  String get appSettings_mapDisplay => 'Visualización del mapa';

  @override
  String get appSettings_showRepeaters => 'Mostrar repetidores';

  @override
  String get appSettings_showRepeatersSubtitle =>
      'Mostrar nodos de repetidor en el mapa';

  @override
  String get appSettings_showChatNodes => 'Mostrar nodos de chat';

  @override
  String get appSettings_showChatNodesSubtitle =>
      'Mostrar nodos de chat en el mapa';

  @override
  String get appSettings_showOtherNodes => 'Mostrar otros nodos';

  @override
  String get appSettings_showOtherNodesSubtitle =>
      'Mostrar otros tipos de nodo en el mapa';

  @override
  String get appSettings_timeFilter => 'Filtro de tiempo';

  @override
  String get appSettings_timeFilterShowAll => 'Mostrar todos los nodos';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return 'Mostrar nodos de las últimas $hours horas';
  }

  @override
  String get appSettings_mapTimeFilter => 'Filtro de tiempo del mapa';

  @override
  String get appSettings_showNodesDiscoveredWithin =>
      'Mostrar nodos descubiertos dentro de:';

  @override
  String get appSettings_allTime => 'Todo el tiempo';

  @override
  String get appSettings_lastHour => 'Última hora';

  @override
  String get appSettings_last6Hours => 'Últimas 6 horas';

  @override
  String get appSettings_last24Hours => 'Últimas 24 horas';

  @override
  String get appSettings_lastWeek => 'La semana pasada';

  @override
  String get appSettings_rasterTileSource => 'Fuente de teselas ráster';

  @override
  String get appSettings_stadiaEndpoint => 'Punto de acceso de Stadia';

  @override
  String get appSettings_stadiaApiKey => 'Clave API de Stadia';

  @override
  String get appSettings_stadiaApiKeyRequired =>
      'Obligatorio para usar Stadia Maps';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return 'Configurado: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Introduce tu clave API de Stadia Maps. La aplicación la usa para solicitar teselas ráster.';

  @override
  String get appSettings_offlineMapCache => 'Caché de mapa sin conexión';

  @override
  String get appSettings_unitsTitle => 'Unidades';

  @override
  String get appSettings_unitsMetric => 'Métrico (m/km)';

  @override
  String get appSettings_unitsImperial => 'Imperial (pies/millas)';

  @override
  String get appSettings_noAreaSelected => 'No se ha seleccionado ningún área';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'Área seleccionada (zoom $minZoom-$maxZoom)';
  }

  @override
  String get appSettings_debugCard => 'Depurar';

  @override
  String get appSettings_appDebugLogging => 'Registro de Depuración de la App';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'Registrar mensajes de depuración de la app para solucionar problemas';

  @override
  String get appSettings_appDebugLoggingEnabled =>
      'Registro de depuración de la aplicación habilitado';

  @override
  String get appSettings_appDebugLoggingDisabled =>
      'El registro de depuración de la aplicación está desactivado';

  @override
  String get contacts_title => 'Contactos';

  @override
  String get contacts_noContacts => 'Aún no hay contactos.';

  @override
  String get contacts_contactsWillAppear =>
      'Los contactos aparecerán cuando los dispositivos anuncien.';

  @override
  String get contacts_unread => 'No leído';

  @override
  String get contacts_searchContactsNoNumber => 'Buscar contactos...';

  @override
  String contacts_searchContacts(int number, String str) {
    return 'Buscar $number$str contactos...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'Buscar $number$str favoritos...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'Buscar $number$str usuarios...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'Buscar $number$str repetidores...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'Buscar $number$str servidores de sala...';
  }

  @override
  String get contacts_noUnreadContacts => 'No hay contactos sin leer';

  @override
  String get contacts_noContactsFound =>
      'No se encontraron contactos ni grupos.';

  @override
  String get contacts_deleteContact => 'Eliminar contacto';

  @override
  String contacts_removeConfirm(String contactName) {
    return '¿Eliminar $contactName de los contactos?';
  }

  @override
  String get contacts_manageRepeater => 'Gestionar repetidor';

  @override
  String get contacts_manageRoom => 'Gestionar servidor de sala';

  @override
  String get contacts_roomLogin => 'Inicio de sesión en sala';

  @override
  String get contacts_openChat => 'Abrir chat';

  @override
  String get contacts_editGroup => 'Editar grupo';

  @override
  String get contacts_deleteGroup => 'Eliminar grupo';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return 'Eliminar $groupName?';
  }

  @override
  String get contacts_newGroup => 'Nuevo Grupo';

  @override
  String get contacts_moreOptions => 'Más opciones';

  @override
  String get contacts_searchOpen => 'Buscar contactos';

  @override
  String get contacts_searchClose => 'Cerrar búsqueda';

  @override
  String get contacts_groupName => 'Nombre del grupo';

  @override
  String get contacts_groupNameRequired => 'El nombre del grupo es obligatorio';

  @override
  String get contacts_groupNameReserved =>
      'Este nombre de grupo está reservado';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'El grupo \"$name\" ya existe';
  }

  @override
  String get contacts_filterContacts => 'Filtrar contactos...';

  @override
  String get contacts_noContactsMatchFilter =>
      'No hay contactos que coincidan con tu filtro';

  @override
  String get contacts_noMembers => 'No miembros';

  @override
  String get contacts_lastSeenNow => 'Última vez que se vio ahora';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return '~ $minutes minutos';
  }

  @override
  String get contacts_lastSeenHourAgo => '~ 1 hora';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return '~ $hours horas';
  }

  @override
  String get contacts_lastSeenDayAgo => '~ 1 día';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return '~ $days días';
  }

  @override
  String get contact_info => 'Información de contacto';

  @override
  String get contact_settings => 'Configuración de contacto';

  @override
  String get contact_telemetry => 'Telemetría';

  @override
  String get contact_lastSeen => 'Visto por última vez';

  @override
  String get contact_clearChat => 'Borrar chat';

  @override
  String get contact_teleBase => 'Base de Telemetría';

  @override
  String get contact_teleBaseSubtitle =>
      'Permitir el intercambio de nivel de batería y telemetría básica';

  @override
  String get contact_teleLoc => 'Ubicación de telemetría';

  @override
  String get contact_teleLocSubtitle =>
      'Permitir el intercambio de datos de ubicación';

  @override
  String get contact_teleEnv => 'Entorno de Telemetría';

  @override
  String get contact_teleEnvSubtitle =>
      'Permitir el intercambio de datos de sensores de entorno';

  @override
  String get channels_title => 'Canales';

  @override
  String get channels_noChannelsConfigured => 'No se han configurado canales';

  @override
  String get channels_addPublicChannel => 'Añadir Canal Público';

  @override
  String get channels_searchChannels => 'Buscar canales...';

  @override
  String get channels_noChannelsFound => 'No se encontraron canales';

  @override
  String channels_channelIndex(int index) {
    return 'Canal $index';
  }

  @override
  String get channels_public => 'Público';

  @override
  String channels_via(String path) {
    return 'vía $path';
  }

  @override
  String get channels_viaMqtt => 'por MQTT';

  @override
  String get channels_viaMqttSemantics =>
      'Recibido por MQTT, no oído por tu radio';

  @override
  String get channels_private => 'Privado';

  @override
  String get channels_editChannel => 'Editar canal';

  @override
  String get channels_muteChannel => 'Silenciar canal';

  @override
  String get channels_unmuteChannel => 'Activar canal';

  @override
  String get channels_deleteChannel => 'Eliminar canal';

  @override
  String channels_deleteChannelConfirm(String name) {
    return 'Eliminar \"$name\"? Esto no se puede deshacer.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'No se pudo eliminar el canal \"$name\"';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'Canal \"$name\" eliminado';
  }

  @override
  String get channels_addChannel => 'Añadir Canal';

  @override
  String get channels_channelIndexLabel => 'Índice de Canal';

  @override
  String get channels_channelName => 'Nombre del canal';

  @override
  String get channels_usePublicChannel => 'Usar Canal Público';

  @override
  String get channels_standardPublicPsk => 'PSK estándar público';

  @override
  String get channels_pskHex => 'PSK (Hex)';

  @override
  String get channels_generateRandomPsk => 'Generar PSK aleatorio';

  @override
  String get channels_enterChannelName =>
      'Por favor, introduce un nombre de canal';

  @override
  String get channels_pskMustBe32Hex =>
      'PSK debe ser de 32 caracteres hexadecimales.';

  @override
  String channels_channelAdded(String name) {
    return 'Canal \"$name\" añadido';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'Editar Canal $index';
  }

  @override
  String get channels_smazCompression => 'Compresión SMAZ';

  @override
  String get channels_cyr2latCompression => 'Compresión Cyr2Lat';

  @override
  String get channels_cyr2latCompressionDscr =>
      'Reemplaza algunos caracteres cirílicos con caracteres latinos al enviar.';

  @override
  String get channels_cyr2latSettingsHeading => 'Configuración de Cyr2Lat';

  @override
  String get channels_cyr2latSettingsSubheading => 'Lista de sustituciones';

  @override
  String get channels_cyr2latSettingsDscr =>
      'Editar la configuración JSON de sustitución de caracteres';

  @override
  String get channels_cyr2latSettingsDialogHint => 'Mapa JSON de sustituciones';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'JSON incorrecto: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'Canal \"$name\" actualizado';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Añadir perfil Cyr2Lat';

  @override
  String get settings_cyr2latProfileName => 'Nombre del perfil';

  @override
  String get settings_cyr2latProfileNameEmpty =>
      'El nombre del perfil no puede estar vacío';

  @override
  String get settings_cyr2latProfileAdded => 'Perfil añadido correctamente';

  @override
  String get settings_cyr2latProfileUpdated =>
      'Perfil actualizado correctamente';

  @override
  String get settings_cyr2latProfileEdit => 'Editar perfil Cyr2Lat';

  @override
  String get settings_cyr2latProfileDelete => 'Eliminar perfil Cyr2Lat';

  @override
  String get settings_cyr2latProfileDeleted => 'Perfil eliminado correctamente';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return '¿Está seguro de que desea eliminar el perfil \"$name\"?';
  }

  @override
  String get channels_publicChannelAdded => 'Canal público añadido';

  @override
  String get channels_sortBy => 'Ordenar por';

  @override
  String get channels_sortManual => 'Manual';

  @override
  String get channels_sortAZ => 'De la A a la Z';

  @override
  String get channels_sortLatestMessages => 'Últimos mensajes';

  @override
  String get channels_sortUnread => 'Sin leer';

  @override
  String get channels_createPrivateChannel => 'Crear un Canal Privado';

  @override
  String get channels_createPrivateChannelDesc =>
      'Cifrado con una clave secreta.';

  @override
  String get channels_joinPrivateChannel => 'Únete a un Canal Privado';

  @override
  String get channels_joinPrivateChannelDesc =>
      'Introducir manualmente una clave secreta.';

  @override
  String get channels_joinPublicChannel => 'Únete al Canal Público';

  @override
  String get channels_joinPublicChannelDesc =>
      'Cualquiera puede unirse a este canal.';

  @override
  String get channels_joinHashtagChannel => 'Únete a un Canal con Hashtag';

  @override
  String get channels_joinHashtagChannelDesc =>
      'Cualquiera puede unirse a los canales de hashtag.';

  @override
  String get channels_scanQrCode => 'Escanear un Código QR';

  @override
  String get channels_scanQrCodeComingSoon => 'Próximamente';

  @override
  String get channels_enterHashtag => 'Introducir hashtag';

  @override
  String get channels_hashtagHint => 'ej. #equipo';

  @override
  String channels_regionSetTo(String region) {
    return 'Región: $region';
  }

  @override
  String get channels_regionNotSet => 'Región: ninguna';

  @override
  String get channels_regionSelect_Title => 'Seleccione una región';

  @override
  String get channels_clearRegion => 'Zona despejada';

  @override
  String get chat_noMessages => 'Aún no hay mensajes';

  @override
  String get chat_sendMessage => 'Enviar mensaje';

  @override
  String chat_sendMessageTo(String contactName) {
    return 'Enviar un mensaje a $contactName';
  }

  @override
  String get chat_sendMessageToStart => 'Enviar un mensaje para comenzar';

  @override
  String get chat_originalMessageNotFound => 'Mensaje original no encontrado';

  @override
  String chat_replyingTo(String name) {
    return 'Responder a $name';
  }

  @override
  String chat_replyTo(String name) {
    return 'Responder a $name';
  }

  @override
  String get chat_location => 'Ubicación';

  @override
  String get chat_typeMessage => 'Escribe un mensaje...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'Mensaje demasiado largo (máximo $maxBytes bytes).';
  }

  @override
  String get chat_messageCopied => 'Mensaje copiado';

  @override
  String get chat_messageDeleted => 'Mensaje borrado';

  @override
  String get chat_retryingMessage => 'Reintentando…';

  @override
  String chat_retryCount(int current, int max) {
    return 'Reintentar $current/$max';
  }

  @override
  String get chat_selectSendAction => 'Seleccionar acción de envío';

  @override
  String get chat_sendGif => 'Enviar GIF';

  @override
  String get chat_limitToArea => 'Limitar a una zona';

  @override
  String get chat_limitToAreaTitle => 'Enviar solo dentro de…';

  @override
  String get chat_limitToAreaHelp =>
      'Los repetidores con firmware de corredor de inundación solo retransmiten el mensaje dentro de esta zona. Otros repetidores lo descartan salvo que permitan tu región de corredor.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '$km km a tu alrededor';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return 'Solo a menos de $km km de ti';
  }

  @override
  String get chat_limitToAreaOff => 'Sin límite';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'Establece la posición de tu radio para limitar los mensajes a una zona.';

  @override
  String get chat_sendImageLora => 'Enviar imagen mediante MeshCore';

  @override
  String get chat_imagePickFailed => 'No pude abrir esa imagen';

  @override
  String get chat_receivedGif => 'Recibido un GIF';

  @override
  String get chat_reply => 'Responder';

  @override
  String get chat_addReaction => 'Añadir Reacción';

  @override
  String get chat_me => 'Yo';

  @override
  String get reaction_report => 'Reacciones con emoji';

  @override
  String get emojiCategorySmileys => 'Emoticones';

  @override
  String get emojiCategoryGestures => 'Gestos';

  @override
  String get emojiCategoryHearts => 'Corazones';

  @override
  String get emojiCategoryObjects => 'Objetos';

  @override
  String get gifPicker_title => 'Elegir un GIF';

  @override
  String get gifPicker_searchHint => 'Buscar GIFs...';

  @override
  String get gifPicker_poweredBy => 'Con tecnología de GIPHY';

  @override
  String get gifPicker_noGifsFound => 'No se encontraron GIFs';

  @override
  String get gifPicker_failedLoad => 'No se pudo cargar los GIFs';

  @override
  String get gifPicker_failedSearch => 'No se encontraron GIFs';

  @override
  String get gifPicker_noInternet => 'No hay conexión a internet';

  @override
  String get debugLog_appTitle => 'Registro de Depuración de la App';

  @override
  String get debugLog_bleTitle => 'Registro de Depuración BLE';

  @override
  String get debugLog_copyLog => 'Copiar registro';

  @override
  String get debugLog_clearLog => 'Borrar registro';

  @override
  String get debugLog_copied => 'Registro de depuración copiado';

  @override
  String get debugLog_bleCopied => 'Registro BLE copiado';

  @override
  String get debugLog_noEntries => 'Aún no hay registros de depuración.';

  @override
  String get debugLog_enableInSettings =>
      'Habilitar el registro de depuración de la aplicación en la configuración';

  @override
  String get debugLog_frames => 'Marcos';

  @override
  String get debugLog_rawLogRx => 'Registro bruto RX';

  @override
  String get debugLog_noBleActivity => 'Aún no hay actividad BLE';

  @override
  String debugFrame_length(int count) {
    return 'Longitud del Marco: $count bytes';
  }

  @override
  String debugFrame_command(String value) {
    return 'Comando: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'Mensaje de Texto:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- Destino PubKey: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- Marca de tiempo: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- Banderas: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- Tipo de texto: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'CLI';

  @override
  String get debugFrame_textTypePlain => 'Plano';

  @override
  String debugFrame_text(String text) {
    return '- Texto: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => 'Volcado hexadecimal:';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'saltos',
      one: 'salto',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => 'Eliminar ruta';

  @override
  String get chat_noPathHistoryYet =>
      'Aún no hay historial de rutas.\nEnvía un mensaje para descubrir rutas.';

  @override
  String get chat_pathCleared =>
      'Ruta borrada. El siguiente mensaje redescubrirá la ruta.';

  @override
  String get chat_fullPath => 'Ruta completa';

  @override
  String get routing_title => 'Enrutamiento';

  @override
  String get routing_modeAuto => 'Automático';

  @override
  String get routing_modeFlood => 'Inundación';

  @override
  String get routing_modeManual => 'Manual';

  @override
  String get routing_modeAutoHint =>
      'Selecciona automáticamente la mejor ruta conocida y, si no hay ninguna, usa el modo de inundación.';

  @override
  String get routing_modeFloodHint =>
      'Transmite por todos los repetidores. Es la opción más fiable, pero usa más tiempo de aire.';

  @override
  String get routing_modeManualHint =>
      'Siempre sigue exactamente la ruta que has definido.';

  @override
  String get routing_currentRoute => 'Ruta actual';

  @override
  String get routing_directNoHops => 'Directo — sin saltos de repetidor';

  @override
  String get routing_noPathYet =>
      'Aún no hay una ruta. El siguiente mensaje se enviará por inundación hasta que se descubra una ruta.';

  @override
  String get routing_floodBroadcast => 'Transmisión por todos los repetidores';

  @override
  String get routing_editPath => 'Editar ruta';

  @override
  String get routing_forgetPath => 'Olvidar ruta';

  @override
  String get routing_knownPaths => 'Rutas conocidas';

  @override
  String get routing_knownPathsHint => 'Toca una ruta para cambiar a ella.';

  @override
  String get routing_inUse => 'En uso';

  @override
  String get routing_qualityStrong => 'Primer salto fuerte';

  @override
  String get routing_qualityGood => 'Primer salto bueno';

  @override
  String get routing_qualityFair => 'Primer salto aceptable';

  @override
  String get routing_qualityWorked => 'Ha entregado';

  @override
  String get routing_qualityFlood => 'Escuchado por inundación';

  @override
  String get routing_qualityUntested => 'Sin probar';

  @override
  String routing_lastWorked(String when) {
    return 'funcionó $when';
  }

  @override
  String get routing_neverWorked => 'nunca confirmado';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes entregados, $failures fallidos';
  }

  @override
  String get routing_floodDelivery => 'Entrega por inundación';

  @override
  String get pathEditor_title => 'Crear ruta';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count de 64 saltos';
  }

  @override
  String get pathEditor_noHops =>
      'Aún no se han añadido saltos. Toca los repetidores de abajo para añadirlos en orden, o guarda la ruta sin saltos para enviarla directamente.';

  @override
  String get pathEditor_addHops => 'Añadir los saltos en orden';

  @override
  String get pathEditor_searchRepeaters => 'Buscar repetidores';

  @override
  String get pathEditor_advancedHex =>
      'Avanzado: ruta hexadecimal sin procesar';

  @override
  String get pathEditor_hexLabel => 'Prefijos hexadecimales';

  @override
  String get pathEditor_hexHelper =>
      'Dos caracteres hexadecimales por salto, separados por comas.';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return 'Inválido: $tokens';
  }

  @override
  String get pathEditor_tooManyHops => 'Máximo 64 saltos';

  @override
  String get pathEditor_usePath => 'Usar esta ruta';

  @override
  String get pathEditor_removeHop => 'Eliminar salto';

  @override
  String get pathEditor_unknownHop => 'Repetidor desconocido';

  @override
  String get chat_pathSavedLocally =>
      'Guardado localmente. Conéctate para sincronizar.';

  @override
  String get chat_pathDeviceConfirmed => 'Dispositivo confirmado.';

  @override
  String get chat_pathDeviceNotConfirmed => 'Dispositivo aún no confirmado.';

  @override
  String get chat_type => 'Tipo';

  @override
  String get chat_path => 'Ruta';

  @override
  String get chat_publicKey => 'Clave pública';

  @override
  String get chat_compressOutgoingMessages => 'Comprimir mensajes salientes';

  @override
  String get chat_floodForced => 'Inundación (forzada)';

  @override
  String get chat_directForced => 'Directo (forzado)';

  @override
  String chat_hopsForced(int count) {
    return '$count saltos (forzados)';
  }

  @override
  String get chat_floodAuto => 'Inundación (automática)';

  @override
  String get chat_direct => 'Directo';

  @override
  String get chat_poiShared => 'Punto de interés compartido';

  @override
  String chat_unread(int count) {
    return 'Sin leer: $count';
  }

  @override
  String get chat_markAsUnread => 'Marcar como no leído';

  @override
  String get chat_newMessages => 'Nuevos mensajes';

  @override
  String get chat_openLink => '¿Abrir enlace?';

  @override
  String get chat_openLinkConfirmation =>
      '¿Quieres abrir este enlace en tu navegador?';

  @override
  String get chat_open => 'Abrir';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'No se pudo abrir el enlace: $url';
  }

  @override
  String get chat_invalidLink => 'Formato de enlace no válido';

  @override
  String get map_title => 'Mapa de nodos';

  @override
  String get map_searchHint => 'Buscar por nombre o ID del nodo';

  @override
  String get map_activity => 'Actividad';

  @override
  String get map_online => 'En línea';

  @override
  String get map_recent => 'Reciente';

  @override
  String get map_stale => 'Antiguo; pasado de fecha';

  @override
  String get map_visible => 'Visible';

  @override
  String get map_hidden => 'Oculto';

  @override
  String get map_centerOnNode => 'Enfocar en el nodo';

  @override
  String get map_details => 'Detalles';

  @override
  String get map_noGps => 'Sin GPS';

  @override
  String get map_noResults => 'No se encontraron nodos coincidentes.';

  @override
  String get map_lineOfSight => 'Línea de visión';

  @override
  String get map_losScreenTitle => 'Línea de visión';

  @override
  String get map_noNodesWithLocation => 'No hay nodos con datos de ubicación';

  @override
  String get map_nodesNeedGps =>
      'Los nodos necesitan compartir sus coordenadas GPS\npara aparecer en el mapa';

  @override
  String map_nodesCount(int count) {
    return 'Nodos: $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'Pines: $count';
  }

  @override
  String get map_chat => 'Chat';

  @override
  String get map_repeater => 'Repetidor';

  @override
  String get map_room => 'Sala';

  @override
  String get map_sensor => 'Sensor';

  @override
  String get map_pinDm => 'Pin (DM)';

  @override
  String get map_pinPrivate => 'Pin (privado)';

  @override
  String get map_pinPublic => 'Pin (público)';

  @override
  String get map_lastSeen => 'Última vez visto';

  @override
  String get map_disconnectConfirm =>
      '¿Está seguro de que desea desconectarse de este dispositivo?';

  @override
  String get map_from => 'De';

  @override
  String get map_source => 'Fuente';

  @override
  String get map_flags => 'Banderas';

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
  String get map_shareMarkerHere => 'Compartir marcador aquí';

  @override
  String get map_setAsMyLocation => 'Establecer mi ubicación';

  @override
  String get floodCorridor_title => 'Corredor de inundación';

  @override
  String get floodCorridor_previewToHere =>
      'Previsualizar corredor de inundación hasta aquí';

  @override
  String get floodCorridor_requesting => 'Pidiendo un corredor a tu radio…';

  @override
  String get floodCorridor_unsupported =>
      'El firmware de tu radio no admite corredores de inundación.';

  @override
  String get floodCorridor_noProposal =>
      'Tu radio no pudo proponer un corredor. Asegúrate de que tenga una posición configurada.';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count círculos',
      one: '1 círculo',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return '$inside de $total repetidores conocidos dentro';
  }

  @override
  String get floodCorridor_straightLine =>
      'Línea recta: no hay repetidores conocidos en el camino';

  @override
  String get floodCorridor_followsRepeaters =>
      'Sigue tus repetidores conocidos';

  @override
  String get floodCorridor_horizonLimited =>
      'Los repetidores conocidos no llegan al destino; el resto es una línea recta';

  @override
  String get floodCorridor_thinStretch =>
      'Parte del corredor tiene pocos repetidores conocidos';

  @override
  String get floodCorridor_moreCoverage =>
      'Exigir más cobertura de repetidores';

  @override
  String get floodCorridor_previewNote =>
      'Solo vista previa. Los repetidores sin firmware de corredor no aplican corredores.';

  @override
  String get map_pinLabel => 'Etiqueta del pin';

  @override
  String get map_label => 'Etiqueta';

  @override
  String get map_pointOfInterest => 'Punto de interés';

  @override
  String get map_sendToContact => 'Enviar a contacto';

  @override
  String get map_sendToChannel => 'Enviar a canal';

  @override
  String get map_noChannelsAvailable => 'No hay canales disponibles';

  @override
  String get map_publicLocationShare => 'Compartir ubicación pública';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return 'Estás a punto de compartir una ubicación en $channelLabel. Este canal es público y cualquiera con la PSK puede verla.';
  }

  @override
  String get map_connectToShareMarkers =>
      'Conéctate a un dispositivo para compartir marcadores';

  @override
  String get map_filterNodes => 'Filtrar nodos';

  @override
  String get map_nodeTypes => 'Tipos de nodo';

  @override
  String get map_chatNodes => 'Nodos de chat';

  @override
  String get map_repeaters => 'Repetidores';

  @override
  String get map_otherNodes => 'Otros nodos';

  @override
  String get map_showOverlaps => 'Superposiciones de tecla repetidora';

  @override
  String get map_keyPrefix => 'Prefijo de clave';

  @override
  String get map_filterByKeyPrefix => 'Filtrar por prefijo clave';

  @override
  String get map_publicKeyPrefix => 'Prefijo de clave pública';

  @override
  String get map_markers => 'Marcadores';

  @override
  String get map_showSharedMarkers => 'Mostrar marcadores compartidos';

  @override
  String get map_showGuessedLocations =>
      'Mostrar las ubicaciones estimadas de los nodos.';

  @override
  String get map_showDiscoveryContacts => 'Mostrar contactos de descubrimiento';

  @override
  String get map_guessedLocation => 'Ubicación estimada';

  @override
  String get map_lastSeenTime => 'Hora de última vez visto';

  @override
  String get map_sharedPin => 'Pin compartido';

  @override
  String get map_sharedAt => 'Compartido';

  @override
  String get map_joinRoom => 'Unirse a la sala';

  @override
  String get map_manageRepeater => 'Gestionar repetidor';

  @override
  String get map_tapToAdd => 'Toque los nodos para añadirlos a la ruta.';

  @override
  String get map_runTrace => 'Ejecutar traza de ruta';

  @override
  String get map_runTraceWithReturnPath => 'Volver por la misma ruta.';

  @override
  String get map_removeLast => 'Eliminar último';

  @override
  String get map_pathTraceCancelled => 'Traza de ruta cancelada.';

  @override
  String get mapCache_title => 'Caché de mapa sin conexión';

  @override
  String get mapCache_selectAreaFirst =>
      'Selecciona primero un área para almacenar en caché';

  @override
  String get mapCache_noTilesToDownload =>
      'No hay teselas para descargar para esta área.';

  @override
  String get mapCache_downloadTilesTitle => 'Descargar teselas';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return '¿Descargar $count teselas para uso sin conexión?';
  }

  @override
  String get mapCache_downloadAction => 'Descargar';

  @override
  String mapCache_cachedTiles(int count) {
    return 'Teselas almacenadas: $count';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return 'Teselas almacenadas: $downloaded ($failed fallidas)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => 'Borrar caché sin conexión';

  @override
  String get mapCache_clearOfflineCachePrompt =>
      '¿Eliminar todas las teselas del mapa almacenadas en caché?';

  @override
  String get mapCache_offlineCacheCleared => 'Caché sin conexión borrada';

  @override
  String get mapCache_noAreaSelected => 'No se ha seleccionado ningún área';

  @override
  String get mapCache_cacheArea => 'Área de caché';

  @override
  String get mapCache_useCurrentView => 'Usar vista actual';

  @override
  String get mapCache_zoomRange => 'Rango de zoom';

  @override
  String mapCache_estimatedTiles(int count) {
    return 'Teselas estimadas: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return 'Descargados $completed / $total';
  }

  @override
  String get mapCache_downloadTilesButton => 'Descargar teselas';

  @override
  String get mapCache_clearCacheButton => 'Borrar caché';

  @override
  String mapCache_failedDownloads(int count) {
    return 'Descargas fallidas: $count';
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
  String get time_justNow => 'Justo ahora';

  @override
  String time_minutesAgo(int minutes) {
    return 'hace $minutes min.';
  }

  @override
  String time_hoursAgo(int hours) {
    return 'hace $hours h';
  }

  @override
  String time_daysAgo(int days) {
    return 'hace $days días';
  }

  @override
  String get time_hour => 'hora';

  @override
  String get time_hours => 'horas';

  @override
  String get time_day => 'día';

  @override
  String get time_days => 'días';

  @override
  String get time_week => 'semana';

  @override
  String get time_weeks => 'semanas';

  @override
  String get time_month => 'mes';

  @override
  String get time_months => 'meses';

  @override
  String get time_minutes => 'minutos';

  @override
  String get time_allTime => 'Todo el tiempo';

  @override
  String get dialog_disconnect => 'Desconectar';

  @override
  String get dialog_disconnectConfirm =>
      '¿Está seguro de que desea desconectarse de este dispositivo?';

  @override
  String get login_repeaterLogin => 'Inicio de sesión del repetidor';

  @override
  String get login_roomLogin => 'Inicio de sesión en la sala';

  @override
  String get login_password => 'Contraseña';

  @override
  String get login_enterPassword => 'Introduce la contraseña';

  @override
  String get login_savePassword => 'Guardar contraseña';

  @override
  String get login_savePasswordSubtitle =>
      'La contraseña se almacenará de forma segura en este dispositivo.';

  @override
  String get login_repeaterDescription =>
      'Introduce la contraseña del repetidor para acceder como invitado o administrador.';

  @override
  String get login_roomDescription =>
      'Introduce la contraseña de la sala para acceder como invitado o administrador.';

  @override
  String get login_routing => 'Enrutamiento';

  @override
  String get login_routingMode => 'Modo de enrutamiento';

  @override
  String get login_autoUseSavedPath => 'Auto (usar la ruta guardada)';

  @override
  String get login_forceFloodMode => 'Forzar modo inundación';

  @override
  String get login_managePaths => 'Gestionar rutas';

  @override
  String get login_login => 'Iniciar sesión';

  @override
  String login_attempt(int current, int max) {
    return 'Intento $current/$max';
  }

  @override
  String login_failed(String error) {
    return 'Error de inicio de sesión: $error';
  }

  @override
  String get login_failedMessage =>
      'El inicio de sesión ha fallado. La contraseña es incorrecta o el repetidor no está disponible.';

  @override
  String get common_reload => 'Recargar';

  @override
  String get common_clear => 'Borrar';

  @override
  String get path_currentPathLabel => 'Ruta actual';

  @override
  String get path_noRepeatersFound =>
      'No se encontraron repetidores ni servidores de sala.';

  @override
  String get repeater_management => 'Gestión de repetidores';

  @override
  String get room_management => 'Administración del servidor de sala';

  @override
  String get repeater_guest => 'Información sobre repetidores';

  @override
  String get room_guest => 'Información del servidor';

  @override
  String get repeater_managementTools => 'Herramientas de gestión';

  @override
  String get repeater_guestTools => 'Herramientas para invitados';

  @override
  String get repeater_status => 'Estado';

  @override
  String get repeater_statusSubtitle =>
      'Ver el estado, las estadísticas y los vecinos del repetidor';

  @override
  String get repeater_telemetry => 'Telemetría';

  @override
  String get repeater_telemetrySubtitle =>
      'Ver la telemetría de los sensores y las estadísticas del sistema';

  @override
  String get repeater_cli => 'CLI';

  @override
  String get repeater_cliSubtitle => 'Enviar comandos al repetidor';

  @override
  String get repeater_neighbors => 'Vecinos';

  @override
  String get repeater_neighborsSubtitle => 'Ver vecinos de salto cero.';

  @override
  String get repeater_settings => 'Configuración';

  @override
  String get repeater_settingsSubtitle => 'Configurar parámetros del repetidor';

  @override
  String get repeater_clockSyncAfterLogin =>
      'Sincronización del reloj después de iniciar sesión';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      'Enviar automáticamente la función de \"sincronización de reloj\" después de un inicio de sesión exitoso.';

  @override
  String get repeater_statusTitle => 'Estado del Repetidor';

  @override
  String get repeater_routingMode => 'Modo de enrutamiento';

  @override
  String get repeater_refresh => 'Actualizar';

  @override
  String get repeater_statusRequestTimeout =>
      'Se agotó el tiempo de espera de la solicitud de estado.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'Error al cargar el estado: $error';
  }

  @override
  String get repeater_systemInformation => 'Información del sistema';

  @override
  String get repeater_battery => 'Batería';

  @override
  String get repeater_clockAtLogin => 'Reloj (al inicio de sesión)';

  @override
  String get repeater_uptime => 'Tiempo de actividad';

  @override
  String get repeater_queueLength => 'Longitud de la cola';

  @override
  String get repeater_debugFlags => 'Banderas de depuración';

  @override
  String get repeater_radioStatistics => 'Estadísticas de radio';

  @override
  String get repeater_lastRssi => 'Último RSSI';

  @override
  String get repeater_lastSnr => 'Último SNR';

  @override
  String get repeater_noiseFloor => 'Nivel de ruido';

  @override
  String get repeater_txAirtime => 'Tiempo de aire TX';

  @override
  String get repeater_rxAirtime => 'Tiempo de aire RX';

  @override
  String get repeater_chanUtil => 'Utilización del canal';

  @override
  String get repeater_packetStatistics => 'Estadísticas de paquetes';

  @override
  String get repeater_sent => 'Enviados';

  @override
  String get repeater_received => 'Recibidos';

  @override
  String get repeater_duplicates => 'Duplicados';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days días ${hours}h $minutes min $seconds s';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return 'Total: $total, Inundación: $flood, Directo: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return 'Total: $total, Inundación: $flood, Directo: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return 'Inundación: $flood, Directo: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return 'Total: $total';
  }

  @override
  String get repeater_settingsTitle => 'Ajustes del repetidor';

  @override
  String get repeater_basicSettings => 'Ajustes básicos';

  @override
  String get repeater_repeaterName => 'Nombre del repetidor';

  @override
  String get repeater_repeaterNameHelper =>
      'Nombre visible para este repetidor';

  @override
  String get repeater_adminPassword => 'Contraseña de administrador';

  @override
  String get repeater_adminPasswordHelper => 'Contraseña de acceso completo';

  @override
  String get repeater_guestPassword => 'Contraseña de invitado';

  @override
  String get repeater_guestPasswordHelper =>
      'Contraseña de acceso de solo lectura';

  @override
  String get repeater_radioSettings => 'Ajustes de radio';

  @override
  String get repeater_frequencyMhz => 'Frecuencia (MHz)';

  @override
  String get repeater_frequencyHelper => '300-2500 MHz';

  @override
  String get repeater_txPower => 'Potencia TX';

  @override
  String get repeater_txPowerHelper => '1-30 dBm';

  @override
  String get repeater_bandwidth => 'Ancho de banda';

  @override
  String get repeater_spreadingFactor => 'Factor de propagación';

  @override
  String get repeater_codingRate => 'Tasa de codificación';

  @override
  String get repeater_locationSettings => 'Ajustes de ubicación';

  @override
  String get repeater_latitude => 'Latitud';

  @override
  String get repeater_latitudeHelper =>
      'Grados decimales (por ejemplo, 37.7749)';

  @override
  String get repeater_longitude => 'Longitud';

  @override
  String get repeater_longitudeHelper =>
      'Grados decimales (por ejemplo, -122.4194)';

  @override
  String get repeater_features => 'Funciones';

  @override
  String get repeater_packetForwarding => 'Reenvío de paquetes';

  @override
  String get repeater_packetForwardingSubtitle =>
      'Permitir que el repetidor reenvíe paquetes';

  @override
  String get repeater_guestAccess => 'Acceso de invitado';

  @override
  String get repeater_guestAccessSubtitle =>
      'Permitir acceso de invitado de solo lectura';

  @override
  String get repeater_privacyMode => 'Modo de privacidad';

  @override
  String get repeater_privacyModeSubtitle =>
      'Ocultar nombre/ubicación en anuncios';

  @override
  String get repeater_advertisementSettings => 'Ajustes de anuncios';

  @override
  String get repeater_localAdvertInterval => 'Intervalo de anuncio local';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes minutos';
  }

  @override
  String get repeater_floodAdvertInterval =>
      'Intervalo de anuncio por inundación';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours horas';
  }

  @override
  String get repeater_encryptedAdvertInterval => 'Intervalo de anuncio cifrado';

  @override
  String get repeater_dangerZone => 'Zona de peligro';

  @override
  String get repeater_rebootRepeater => 'Reiniciar repetidor';

  @override
  String get repeater_rebootRepeaterSubtitle =>
      'Reiniciar el dispositivo repetidor';

  @override
  String get repeater_rebootRepeaterConfirm =>
      '¿Está seguro de que desea reiniciar este repetidor?';

  @override
  String get repeater_regenerateIdentityKey => 'Regenerar clave de identidad';

  @override
  String get repeater_regenerateIdentityKeySubtitle =>
      'Generar una nueva pareja de claves pública/privada';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'Esto generará una nueva identidad para el repetidor. ¿Continuar?';

  @override
  String get repeater_eraseFileSystem => 'Borrar sistema de archivos';

  @override
  String get repeater_eraseFileSystemSubtitle =>
      'Formatear el sistema de archivos del repetidor';

  @override
  String get repeater_eraseFileSystemConfirm =>
      'ADVERTENCIA: Esto borrará todos los datos del repetidor. ¡Esto no se puede deshacer!';

  @override
  String get repeater_eraseSerialOnly =>
      'Borrar solo está disponible a través de la consola serie.';

  @override
  String repeater_commandSent(String command) {
    return 'Comando enviado: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'Error al enviar el comando: $error';
  }

  @override
  String get repeater_confirm => 'Confirmar';

  @override
  String get repeater_settingsSaved => 'Ajustes guardados correctamente';

  @override
  String get repeater_rxGain => 'Ganancia RX';

  @override
  String get repeater_rxGainHelper =>
      'Mayor sensibilidad, mayor consumo de corriente (solo para SX1262/SX1268)';

  @override
  String get repeater_refreshRxGain =>
      'Mejora el rendimiento de RX con la nueva versión.';

  @override
  String get repeater_multiAcks => 'ACK múltiples';

  @override
  String get repeater_multiAcksSubtitle =>
      'Reconocer mensajes a través de múltiples rutas para una mejor entrega.';

  @override
  String get repeater_refreshMultiAcks => 'Actualizar ACK múltiples';

  @override
  String get repeater_networkHealth => 'Salud de la red';

  @override
  String get repeater_loopDetect => 'Detección de bucles';

  @override
  String get repeater_loopDetectHelper =>
      'Crea paquetes de \"flujo\" que parezcan bucles de enrutamiento.';

  @override
  String get repeater_loopDetectOff => 'Desactivado';

  @override
  String get repeater_loopDetectMinimal => 'Mínimo';

  @override
  String get repeater_loopDetectModerate => 'Moderado';

  @override
  String get repeater_loopDetectStrict => 'Estricto';

  @override
  String get repeater_dutyCycle => 'Ciclo de trabajo';

  @override
  String get repeater_dutyCycleHelper => 'Porcentaje máximo de tiempo de aire';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => 'Información del propietario';

  @override
  String get repeater_ownerInfoHelper =>
      'Metadatos públicos para este repetidor';

  @override
  String get repeater_refreshOwnerInfo =>
      'Actualizar información del propietario';

  @override
  String get repeater_floodMax => 'Máximo de saltos por inundación';

  @override
  String get repeater_floodMaxHelper =>
      'Número máximo de paquetes de inundación que un nodo puede enviar (0-64)';

  @override
  String get repeater_advancedSettings => 'Ajustes avanzados';

  @override
  String get repeater_advancedSettingsSubtitle =>
      'Controles de ajuste para operadores experimentados';

  @override
  String get repeater_pathHashMode => 'Modo de hash de ruta';

  @override
  String get repeater_pathHashModeHelper =>
      'Bytes utilizados para codificar el ID de este repetidor en las etiquetas de ruta/detección de bucles. 0=1 byte (256 IDs, hasta 64 saltos), 1=2 bytes (65.000 IDs, hasta 32 saltos), 2=3 bytes (16 millones de IDs, hasta 21 saltos). Las versiones 1.13 y anteriores de firmware eliminan rutas de múltiples bytes; solo se detectan una vez que la red está activa en la versión 1.14 o posterior.';

  @override
  String get repeater_keySettings => 'Cambiar Claves de Identidad';

  @override
  String get repeater_keySettingsSubtitle =>
      'Cambiar la pareja de claves pública/privada';

  @override
  String get repeater_prvKey => 'Clave privada';

  @override
  String get repeater_prvKeyHelper =>
      'Una nueva clave privada para el repetidor, una cadena hexadecimal de 128 caracteres.';

  @override
  String get repeater_generatePrvKey => 'Genera un par de claves aleatorias';

  @override
  String get repeater_stopGeneratingPrvKey =>
      'Interrumpir la búsqueda de par de claves';

  @override
  String get repeater_pubKey => 'Clave pública';

  @override
  String get repeater_pubKeyHelper =>
      'Esta es la clave pública que corresponde a la clave privada generada. No se puede establecer directamente.';

  @override
  String get repeater_pubKeyPrefix => 'Prefijo deseado';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'Encuentre una clave pública que comience con estos dígitos hexadecimales. Se esperan $tries intentos.';
  }

  @override
  String get repeater_txDelay => 'Retraso TX por inundación';

  @override
  String get repeater_txDelayHelper =>
      'Ajuste de retransmisión para el tráfico de inundación, como un multiplicador del tiempo de transmisión del paquete (0-2, valor predeterminado 0.5). Un valor más alto significa menos colisiones, pero una entrega más lenta.';

  @override
  String get repeater_directTxDelay => 'Retraso TX directo';

  @override
  String get repeater_directTxDelayHelper =>
      'Reenvío de espacios para el tráfico directo (no masivo), como un multiplicador del tiempo de transmisión del paquete (0-2, valor predeterminado 0.3).';

  @override
  String get repeater_intThresh => 'Límite de interferencia';

  @override
  String get repeater_intThreshHelper =>
      'Se establece un umbral para la calibración del nivel de ruido de la radio, de modo que rechaza las interferencias que superen este nivel. 0 deshabilita: solo aumente este valor si observa errores en una banda de frecuencia con mucho ruido.';

  @override
  String get repeater_agcResetInterval => 'Intervalo de reinicio de AGC';

  @override
  String get repeater_agcResetIntervalHelper =>
      '¿Con qué frecuencia se debe restablecer el control automático de ganancia del radio para recuperarse de un estado de ganancia bloqueada? Se puede restablecer cada pocos segundos o cada 4 segundos. Desactiva la función de restablecimiento periódico.';

  @override
  String get repeater_actionsTitle => 'Acciones';

  @override
  String get repeater_sendAdvert => 'Enviar anuncio por inundación';

  @override
  String get repeater_sendAdvertSubtitle =>
      'Transmitir un anuncio por inundación a través de la red.';

  @override
  String get repeater_sendAdvertZeroHop => 'Enviar anuncio sin saltos';

  @override
  String get repeater_sendAdvertZeroHopSubtitle =>
      'Transmite un anuncio de un solo salto (sin retransmisiones).';

  @override
  String get repeater_clockSync => 'Sincronizar reloj ahora';

  @override
  String get repeater_clockSyncSubtitle =>
      'Envía la hora de tu teléfono al repetidor.';

  @override
  String repeater_actionSucceeded(String action) {
    return '$action completado correctamente';
  }

  @override
  String repeater_actionFailed(String action, String error) {
    return 'Error en $action: $error';
  }

  @override
  String get repeater_settingsSavedRebootNeeded =>
      'Configuración guardada — reinicie el repetidor para aplicar los cambios.';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return 'Algunas configuraciones no se pudieron aplicar: $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return 'Error al guardar la configuración: $error';
  }

  @override
  String get repeater_refreshBasicSettings => 'Actualizar Configuración Básica';

  @override
  String get repeater_refreshRadioSettings => 'Actualizar Ajustes de Radio';

  @override
  String get repeater_refreshTxPower => 'Actualizar TX de energía';

  @override
  String get repeater_refreshPacketForwarding =>
      'Actualizar Enrutamiento de Paquetes';

  @override
  String get repeater_refreshGuestAccess => 'Actualizar Acceso Invitados';

  @override
  String get repeater_refreshPrivacyMode => 'Actualizar Modo Privacidad';

  @override
  String repeater_refreshed(String label) {
    return '$label actualizado';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return 'Error al refrescar $label';
  }

  @override
  String get repeater_cliTitle => 'Repetidor CLI';

  @override
  String get repeater_debugNextCommand => 'Siguiente Comando de Depuración';

  @override
  String get repeater_commandHelp => 'Ayuda';

  @override
  String get repeater_clearHistory => 'Borrar historial';

  @override
  String get repeater_noCommandsSent => 'Aún no se han enviado comandos.';

  @override
  String get repeater_typeCommandOrUseQuick =>
      'Escriba un comando a continuación o use comandos rápidos';

  @override
  String get repeater_enterCommandHint => 'Escribir comando...';

  @override
  String get repeater_previousCommand => 'Comando anterior';

  @override
  String get repeater_nextCommand => 'Siguiente comando';

  @override
  String get repeater_enterCommandFirst => 'Escriba un comando primero';

  @override
  String get repeater_cliCommandFrameTitle => 'Marco de Comando CLI';

  @override
  String repeater_cliCommandError(String error) {
    return 'Error: $error';
  }

  @override
  String get repeater_cliQuickGetName => 'Obtener Nombre';

  @override
  String get repeater_cliQuickGetRadio => 'Obtener Radio';

  @override
  String get repeater_cliQuickGetTx => 'Obtener TX';

  @override
  String get repeater_cliQuickNeighbors => 'Vecinos';

  @override
  String get repeater_cliQuickVersion => 'Versión';

  @override
  String get repeater_cliQuickAdvertise => 'Anunciar';

  @override
  String get repeater_cliQuickClock => 'Reloj';

  @override
  String get repeater_cliQuickClockSync => 'Sincronización del reloj';

  @override
  String get repeater_cliQuickDiscovery => 'Descubrir Vecinos';

  @override
  String get repeater_cliHelpAdvert => 'Envía un paquete de publicidad';

  @override
  String get repeater_cliHelpReboot =>
      'Reinicia el dispositivo. (ten en cuenta, es normal que aparezca \'Timeout\')';

  @override
  String get repeater_cliHelpClock =>
      'Muestra la hora actual según el reloj del dispositivo.';

  @override
  String get repeater_cliHelpPassword =>
      'Establece una nueva contraseña de administrador para el dispositivo.';

  @override
  String get repeater_cliHelpVersion =>
      'Muestra la versión del dispositivo y la fecha de compilación del firmware.';

  @override
  String get repeater_cliHelpClearStats =>
      'Reinicia varios contadores de estadísticas a cero.';

  @override
  String get repeater_cliHelpSetAf => 'Establece el factor de tiempo de aire.';

  @override
  String get repeater_cliHelpSetTx =>
      'Establece la potencia de transmisión LoRa en dBm (reboot para aplicar).';

  @override
  String get repeater_cliHelpSetRepeat =>
      'Habilita o deshabilita el rol del repetidor para este nodo.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(Servidor de la sala) Si está \"activado\", entonces el inicio de sesión con una contraseña en blanco estará permitido, pero no se podrá publicar en la sala. (solo lectura).';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'Establece el número máximo de saltos de paquetes de inundación entrantes (si es >= máximo, el paquete no se enruta).';

  @override
  String get repeater_cliHelpSetIntThresh =>
      'Establece el Umbral de Interferencia (en dB). El valor predeterminado es 14. Establecerlo en 0 desactiva la detección de interferencias del canal.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'Establece el intervalo para restablecer el Control Automático de Ganancia. Establecer en 0 para desactivarlo.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      'Habilita o deshabilita la función de \'ACKs dobles\'.';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'Establece el intervalo del temporizador en minutos para enviar un paquete de anuncio local (sin salto). Establecer en 0 para desactivarlo.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'Establece el intervalo del temporizador en horas para enviar un paquete de anuncio masivo. Establecer en 0 para desactivarlo.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'Establece/actualiza la contraseña del invitado. (para repetidores, los inicios de sesión de invitado pueden enviar la solicitud \"Obtener Estadísticas\")';

  @override
  String get repeater_cliHelpSetName => 'Establece el nombre del anuncio.';

  @override
  String get repeater_cliHelpSetLat =>
      'Establece la latitud del mapa de publicidad. (grados decimales)';

  @override
  String get repeater_cliHelpSetLon =>
      'Establece la longitud del mapa de la publicidad. (grados decimales)';

  @override
  String get repeater_cliHelpSetRadio =>
      'Establece parámetros de radio completamente nuevos y los guarda en las preferencias. Requiere un comando \"reboot\" para aplicarlos.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      'Configura (experimental) la base para aplicar un ligero retraso a los paquetes recibidos, según la fuerza de la señal/puntuación. Establece en 0 para desactivar.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      'Establece un factor multiplicado con el tiempo de aire para un paquete de modo de inundación y con un sistema de ranura aleatorio, para retrasar su reenvío (para disminuir la probabilidad de colisiones).';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'Igual que txdelay, pero para aplicar un retraso aleatorio a la transferencia de paquetes en modo directo.';

  @override
  String get repeater_cliHelpSetBridgeEnabled =>
      'Habilitar/Deshabilitar puente.';

  @override
  String get repeater_cliHelpSetBridgeDelay =>
      'Establecer retraso antes de retransmitir paquetes.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      'Elige si el puente retransmitirá paquetes recibidos o paquetes transmitidos.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'Establecer la velocidad de baudios del enlace serial para los puentes rs232.';

  @override
  String get repeater_cliHelpSetBridgeSecret =>
      'Establecer secreto de puente para puentes espnow.';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      'Establece un factor personalizado para ajustar el voltaje de la batería reportado (solo soportado en selectas placas).';

  @override
  String get repeater_cliHelpTempRadio =>
      'Establece parámetros de radio temporales para el número dado de minutos, volviendo a los parámetros de radio originales posteriormente. (no guarda en preferencias).';

  @override
  String get repeater_cliHelpSetPerm =>
      'Modifica el ACL. Elimina la entrada coincidente (por prefijo de pubkey) si \"permissions\" es cero. Añade una nueva entrada si el pubkey-hex tiene longitud completa y no está actualmente en el ACL. Actualiza la entrada mediante el prefijo de pubkey coincidente. Los bits de permiso varían según el rol del firmware, pero los dos bits inferiores son: 0 (Invitado), 1 (Solo lectura), 2 (Lectura/escritura), 3 (Administrador).';

  @override
  String get repeater_cliHelpGetBridgeType =>
      'Obtiene tipo de puente ninguno, rs232, espnow';

  @override
  String get repeater_cliHelpLogStart =>
      'Inicia el registro de paquetes en el sistema de archivos.';

  @override
  String get repeater_cliHelpLogStop =>
      'Detener el registro de paquetes al sistema de archivos.';

  @override
  String get repeater_cliHelpLogErase =>
      'Elimina los registros del paquete del sistema de archivos.';

  @override
  String get repeater_cliHelpNeighbors =>
      'Muestra una lista de otros nodos repetidores escuchados a través de anuncios de un solo salto. Cada línea es id-prefijo-hex:marca de tiempo:times-snr-4';

  @override
  String get repeater_cliHelpNeighborRemove =>
      'Elimina la primera entrada coincidente (por prefijo de pubkey (hex)) de la lista de vecinos.';

  @override
  String get repeater_cliHelpRegion =>
      '(solo serie) Lista todas las regiones definidas y los permisos de inundación actuales.';

  @override
  String get repeater_cliHelpRegionLoad =>
      'NOTA: este es un invocación multi-comando especial. Cada comando subsiguiente es un nombre de región (indentado con espacios para indicar la jerarquía padre, con un espacio mínimo). Terminado enviando una línea en blanco/comando.';

  @override
  String get repeater_cliHelpRegionGet =>
      'Busca la región con el prefijo de nombre dado (o \"\" para el ámbito global). Responde con \"-> nombre-región (nombre-padre) \'F\'\"';

  @override
  String get repeater_cliHelpRegionPut =>
      'Agrega o actualiza una definición de región con el nombre dado.';

  @override
  String get repeater_cliHelpRegionRemove =>
      'Elimina una definición de región con el nombre dado. (debe coincidir exactamente y no tener regiones hijas)';

  @override
  String get repeater_cliHelpRegionAllowf =>
      'Establece el permiso de \'F\'lujo para la región dada. (\'\' para el ámbito global/legado)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      'Elimina el permiso de \'F\'lood para la región especificada. (NOTA: en esta etapa NO se recomienda utilizarlo en el ámbito global/legado!!)';

  @override
  String get repeater_cliHelpRegionHome =>
      'Responde con la región \'home\' actual. (Aún no se ha aplicado en ninguna parte, reservado para el futuro).';

  @override
  String get repeater_cliHelpRegionHomeSet => 'Establece la región \'hogar\'.';

  @override
  String get repeater_cliHelpRegionSave =>
      'Persiste la lista/mapa de regiones al almacenamiento.';

  @override
  String get repeater_cliHelpGps =>
      'Muestra el estado del GPS. Cuando el GPS está apagado, responde solo con \"apagado\", si está encendido, responde con \"encendido\", estado, fijación, número de satélites.';

  @override
  String get repeater_cliHelpGpsOnOff => 'Activa o desactiva el modo GPS.';

  @override
  String get repeater_cliHelpGpsSync =>
      'Sincroniza la hora del nodo con el reloj GPS.';

  @override
  String get repeater_cliHelpGpsSetLoc =>
      'Establece la posición del nodo a las coordenadas GPS y guarda las preferencias.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'Da la configuración de la publicidad del nodo de ubicación:\n- ninguno: no incluir la ubicación en las publicidad\n- compartir: compartir la ubicación GPS (del SensorManager)\n- preferencias: publicidad la ubicación almacenada en preferencias';

  @override
  String get repeater_cliHelpGpsAdvertSet =>
      'Configura la configuración de la publicidad de la ubicación.';

  @override
  String get repeater_commandsListTitle => 'Lista de comandos';

  @override
  String get repeater_commandsListNote =>
      'NOTA: para los diversos comandos \"set...\", también existe un comando \"get...\".';

  @override
  String get repeater_general => 'General';

  @override
  String get repeater_settingsCategory => 'Configuración';

  @override
  String get repeater_bridge => 'Puente';

  @override
  String get repeater_logging => 'Registrando';

  @override
  String get repeater_neighborsRepeaterOnly => 'Vecinos (solo repetidor)';

  @override
  String get repeater_regionManagementRepeaterOnly =>
      'Gestión de Regiones (solo Repetidor)';

  @override
  String get repeater_regionNote =>
      'Se han introducido los comandos de región para gestionar las definiciones y permisos de la región.';

  @override
  String get repeater_gpsManagement => 'Gestión de GPS';

  @override
  String get repeater_gpsNote =>
      'Se ha introducido un comando GPS para gestionar temas relacionados con la ubicación.';

  @override
  String get repeater_getCategory => 'Obtener valores';

  @override
  String get repeater_powerMgmt => 'Gestión de la energía';

  @override
  String get repeater_sensors => 'Sensores';

  @override
  String get repeater_cliHelpPowerOff =>
      'Apaga el dispositivo. (no se espera respuesta)';

  @override
  String get repeater_cliHelpClkReboot =>
      'Restablece el reloj a una fecha conocida y reinicia el dispositivo.';

  @override
  String get repeater_cliHelpAdvertZeroHop =>
      'Envía un anuncio que no requiere saltos (solo para los vecinos inmediatos).';

  @override
  String get repeater_cliHelpStartOta =>
      'Inicia una actualización de firmware por aire en las placas compatibles.';

  @override
  String get repeater_cliHelpTime =>
      'Establece la hora del dispositivo en los segundos correspondientes a la época Unix. La hora no puede retroceder.';

  @override
  String get repeater_cliHelpBoard =>
      'Muestra el fabricante de la placa base / identificador de hardware.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      'Envía una solicitud de descubrimiento de nodos a los vecinos cercanos. (Solo para repetidores)';

  @override
  String get repeater_cliHelpPowersaving =>
      'Indica si el modo de ahorro de energía está activado o desactivado.';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      'Activa o desactiva el modo de ahorro de energía (si está disponible).';

  @override
  String get repeater_cliHelpErase =>
      '(Solo para dispositivos) Formatea el sistema de archivos del dispositivo. Elimina todas las configuraciones y contactos.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      'Establece el ciclo de transmisión máximo permitido como un porcentaje (1-100). Ajusta internamente el factor de tiempo de aire.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '(Solo para series) Reemplaza la clave privada de identificación del dispositivo. Se requiere reiniciar para aplicar. Genera una nueva clave pública.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(Solo para SX126x) Activa/desactiva el amplificador de la RX para mejorar la sensibilidad a corrientes más altas.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      'Define la cadena de información de contacto del propietario que se incluye en los anuncios. Utilice \'|\' para indicar nuevas líneas.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'Establece el modo de hash de la ruta. 0 = antiguo, 1 = estándar, 2 = estricto. Afecta la forma en que se comparan las rutas.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'Establece la sensibilidad para la detección de bucles de enrutamiento: apagado, mínimo, moderado o estricto.';

  @override
  String get repeater_cliHelpSetFreq =>
      '(Solo para la configuración de frecuencia) Establece rápidamente la frecuencia deseada. Se requiere reiniciar. Se recomienda utilizar la opción \"configurar radio\" para obtener todos los parámetros de la radio.';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(Solo para el puente ESPNow) Establece el canal de WiFi (1-14) que utiliza el puente.';

  @override
  String get repeater_cliHelpGetName =>
      'Muestra el nombre del nodo configurado.';

  @override
  String get repeater_cliHelpGetRole =>
      'Muestra el rol del firmware (Repetidor, Servidor de habitación, etc.).';

  @override
  String get repeater_cliHelpGetPublicKey =>
      'Muestra la clave pública del dispositivo.';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '(Solo para uso en serie) Muestra la clave privada del dispositivo. Trátala como una información confidencial.';

  @override
  String get repeater_cliHelpGetRepeat =>
      'Indica si el enrutamiento de paquetes (función de repetidor) está activado o desactivado.';

  @override
  String get repeater_cliHelpGetTx => 'Muestra la potencia actual en dBm.';

  @override
  String get repeater_cliHelpGetFreq =>
      'Muestra la frecuencia de radio configurada en MHz.';

  @override
  String get repeater_cliHelpGetRadio =>
      'Muestra todos los parámetros de radio: frecuencia, ancho de banda, factor de dispersión, tasa de codificación.';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(Solo para SX126x) Muestra el estado de ganancia amplificada del receptor.';

  @override
  String get repeater_cliHelpGetAf => 'Muestra el factor de tiempo actual.';

  @override
  String get repeater_cliHelpGetDutyCycle =>
      'Muestra el ciclo de trabajo actual permitido como un porcentaje.';

  @override
  String get repeater_cliHelpGetIntThresh =>
      'Muestra el umbral de interferencia del canal en dB.';

  @override
  String get repeater_cliHelpGetAgcResetInterval =>
      'Muestra el intervalo de reinicio del AGC en segundos.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      'Indica si el modo de confirmación doble está activado (1) o desactivado (0).';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'Indica si se permite el acceso de solo lectura para los usuarios invitados.';

  @override
  String get repeater_cliHelpGetAdvertInterval =>
      'Muestra el intervalo de publicidad local en minutos.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'Muestra el intervalo de publicidad para la emisión de la señal de inundación, expresado en horas.';

  @override
  String get repeater_cliHelpGetGuestPassword =>
      'Muestra la contraseña de invitado configurada.';

  @override
  String get repeater_cliHelpGetLat => 'Muestra la latitud configurada.';

  @override
  String get repeater_cliHelpGetLon => 'Muestra la longitud configurada.';

  @override
  String get repeater_cliHelpGetRxDelay => 'Muestra el valor base de rxdelay.';

  @override
  String get repeater_cliHelpGetTxDelay =>
      'Muestra el factor de retardo en modo de inundación.';

  @override
  String get repeater_cliHelpGetDirectTxDelay =>
      'Muestra el factor de retardo en modo directo.';

  @override
  String get repeater_cliHelpGetFloodMax =>
      'Muestra el número máximo de saltos por inundación.';

  @override
  String get repeater_cliHelpGetOwnerInfo =>
      'Muestra la cadena de información de contacto del propietario.';

  @override
  String get repeater_cliHelpGetPathHashMode =>
      'Muestra el modo de hash de ruta (0/1/2).';

  @override
  String get repeater_cliHelpGetLoopDetect =>
      'Muestra la sensibilidad en la detección de bucles.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(Solo para series) Enumera las entradas de control de acceso en un repetidor.';

  @override
  String get repeater_cliHelpGetBridgeEnabled =>
      'Indica si el puente está habilitado.';

  @override
  String get repeater_cliHelpGetBridgeDelay =>
      'Muestra el retardo del puente en milisegundos.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'Indica si el puente está enviando o recibiendo paquetes RX o TX.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(Solo puente RS232) Muestra la velocidad de transmisión del puente.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(Solo para el puente ESPNow) Muestra el canal WiFi del puente.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(Solo para el puente ESPNow) Muestra el secreto compartido por el puente.';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '(Solo NRF52) Muestra la versión del cargador.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'Muestra el multiplicador del ADC (escalado de voltaje de la batería).';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      'Indica si el sistema cuenta con funciones de gestión de energía.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      'Indica la fuente de energía actual: externa o batería.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      'Muestra las razones más recientes de reinicio y apagado.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv =>
      'Muestra el voltaje de la batería al encender el sistema en milivoltios (mV).';

  @override
  String get repeater_cliHelpSensorGet =>
      'Lee una configuración de sensor personalizada mediante una tecla.';

  @override
  String get repeater_cliHelpSensorSet =>
      'Crea una configuración personalizada para un sensor.';

  @override
  String get repeater_cliHelpSensorList =>
      'Muestra todas las configuraciones de sensores personalizadas, paginadas a partir de un índice de inicio opcional.';

  @override
  String get repeater_cliHelpRegionDefault =>
      'Muestra el ámbito predeterminado actual.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'Establece el ámbito regional predeterminado. Utilice \"<null>\" para restablecer a la configuración predeterminada.';

  @override
  String get repeater_cliHelpRegionListAllowed =>
      'Enumera las regiones que permiten el paso de vehículos debido a inundaciones.';

  @override
  String get repeater_cliHelpRegionListDenied =>
      'Enumera las regiones que prohíben el tráfico debido a las inundaciones.';

  @override
  String get repeater_cliHelpStatsPackets =>
      '(Solo para series) Muestra estadísticas a nivel de paquetes.';

  @override
  String get repeater_cliHelpStatsRadio =>
      '(Solo para transmisiones en serie) Muestra estadísticas de radio.';

  @override
  String get repeater_cliHelpStatsCore =>
      '(Solo para series) Muestra estadísticas clave del firmware.';

  @override
  String get telemetry_receivedData => 'Datos de Telemetría Recibidos';

  @override
  String get telemetry_requestTimeout => 'Solicitud de telemetría ha expirado.';

  @override
  String telemetry_errorLoading(String error) {
    return 'Error al cargar la telemetría: $error';
  }

  @override
  String get telemetry_noData => 'No hay datos de telemetría disponibles.';

  @override
  String telemetry_channelTitle(int channel) {
    return 'Canal $channel';
  }

  @override
  String get telemetry_batteryLabel => 'Batería';

  @override
  String get telemetry_voltageLabel => 'Voltaje';

  @override
  String get telemetry_mcuTemperatureLabel => 'Temperatura del MCU';

  @override
  String get telemetry_temperatureLabel => 'Temperatura';

  @override
  String get telemetry_currentLabel => 'Corriente';

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
  String get telemetry_digitalInputLabel => 'Entrada digital';

  @override
  String get telemetry_digitalOutputLabel => 'Salida digital';

  @override
  String get telemetry_analogInputLabel => 'Entrada analógica';

  @override
  String get telemetry_analogOutputLabel => 'Salida analógica';

  @override
  String get telemetry_genericLabel => 'Sensor genérico';

  @override
  String get telemetry_luminosityLabel => 'Luminosidad';

  @override
  String get telemetry_presenceLabel => 'Presencia';

  @override
  String get telemetry_humidityLabel => 'Humedad';

  @override
  String get telemetry_accelerometerLabel => 'Acelerómetro';

  @override
  String get telemetry_pressureLabel => 'Presión';

  @override
  String get telemetry_altitudeLabel => 'Altitud';

  @override
  String get telemetry_frequencyLabel => 'Frecuencia';

  @override
  String get telemetry_percentageLabel => 'Porcentaje';

  @override
  String get telemetry_concentrationLabel => 'Concentración';

  @override
  String get telemetry_powerLabel => 'Potencia';

  @override
  String get telemetry_distanceLabel => 'Distancia';

  @override
  String get telemetry_energyLabel => 'Energía';

  @override
  String get telemetry_directionLabel => 'Dirección';

  @override
  String get telemetry_timeLabel => 'Hora';

  @override
  String get telemetry_gyrometerLabel => 'Giroscopio';

  @override
  String get telemetry_colourLabel => 'Color';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'Interruptor';

  @override
  String get telemetry_polylineLabel => 'Polilínea';

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
  String get telemetry_autoFetchQuantity => 'Número de solicitudes';

  @override
  String get telemetry_error => 'No se pudieron obtener los datos';

  @override
  String get neighbors_receivedData => 'Recibidas Datos de Vecinos';

  @override
  String get neighbors_requestTimedOut =>
      'Los vecinos solicitan que se desconecte.';

  @override
  String neighbors_errorLoading(String error) {
    return 'Error al cargar vecinos: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => 'Repetidores Vecinos';

  @override
  String get neighbors_noData => 'No hay datos de vecinos disponibles.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return 'Clave pública desconocida $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return 'Escuchado hace $time';
  }

  @override
  String get channelPath_title => 'Ruta del paquete';

  @override
  String get channelPath_viewMap => 'Ver mapa';

  @override
  String get channelPath_otherObservedPaths => 'Otras rutas observadas';

  @override
  String get channelPath_repeaterHops => 'Saltos del repetidor';

  @override
  String get channelPath_noHopDetails =>
      'Los detalles del paquete no están disponibles.';

  @override
  String get channelPath_sourceLabel => 'Origen';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'Este mensaje llegó por MQTT. Tu radio no lo ha oído, así que no hay ruta de radio desde tu radio.';

  @override
  String get channelPath_messageDetails => 'Detalles del mensaje';

  @override
  String get channelPath_senderLabel => 'Remitente';

  @override
  String get channelPath_timeLabel => 'Hora';

  @override
  String get channelPath_repeatsLabel => 'Repetir';

  @override
  String channelPath_pathLabel(int index) {
    return 'Ruta $index';
  }

  @override
  String get channelPath_observedLabel => 'Observado';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return 'Ruta observada $index • $hops';
  }

  @override
  String get channelPath_noLocationData => 'No datos de ubicación';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month a las $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => 'Desconocido';

  @override
  String get channelPath_floodPath => 'Inundación';

  @override
  String get channelPath_directPath => 'Guardar';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 de $total saltos';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed de $total saltos';
  }

  @override
  String get channelPath_mapTitle => 'Mapa de Rutas';

  @override
  String get channelPath_noRepeaterLocations =>
      'No hay ubicaciones disponibles para el repetidor en esta ruta.';

  @override
  String channelPath_primaryPath(int index) {
    return 'Ruta $index (Principal)';
  }

  @override
  String get channelPath_pathLabelTitle => 'Ruta';

  @override
  String get channelPath_observedPathHeader => 'Ruta Observada';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable =>
      'No hay detalles de salto disponibles para este paquete.';

  @override
  String get channelPath_unknownRepeater => 'Repetidor Desconocido';

  @override
  String get community_title => 'Comunidad';

  @override
  String get community_create => 'Crear Comunidad';

  @override
  String get community_createDesc =>
      'Crear una nueva comunidad y compartir a través de código QR.';

  @override
  String get community_join => 'Únete';

  @override
  String get community_joinTitle => 'Únete a la comunidad';

  @override
  String community_joinConfirmation(String name) {
    return '¿Quieres unirte a la comunidad \"$name\"?';
  }

  @override
  String get community_scanQr => 'Escanear Código QR de la Comunidad';

  @override
  String get community_scanInstructions =>
      'Apunte la cámara a un código QR de la comunidad';

  @override
  String get community_showQr => 'Mostrar Código QR';

  @override
  String get community_publicChannel => 'Comunidad Pública';

  @override
  String get community_hashtagChannel => 'Hashtag de la Comunidad';

  @override
  String get community_name => 'Nombre de la comunidad';

  @override
  String get community_enterName => 'Introducir nombre de comunidad';

  @override
  String community_created(String name) {
    return 'Comunidad \"$name\" creada';
  }

  @override
  String community_joined(String name) {
    return 'Se unió a la comunidad \"$name\"';
  }

  @override
  String get community_qrTitle => 'Compartir Comunidad';

  @override
  String community_qrInstructions(String name) {
    return 'Escanear este código QR para unirte a $name';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'Los canales de hashtag de la comunidad solo son accesibles para los miembros de la comunidad';

  @override
  String get community_invalidQrCode => 'Código QR de comunidad no válido';

  @override
  String get community_alreadyMember => 'Ya eres Miembro';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'Ya eres miembro de \"$name\".';
  }

  @override
  String get community_addPublicChannel =>
      'Añadir Canal Público de la Comunidad';

  @override
  String get community_addPublicChannelHint =>
      'Añade automáticamente el canal público para esta comunidad.';

  @override
  String get community_noCommunities => 'Aún no se han unido comunidades.';

  @override
  String get community_scanOrCreate =>
      'Escanear un código QR o crear una comunidad para comenzar';

  @override
  String get community_manageCommunities => 'Gestionar Comunidades';

  @override
  String get community_delete => 'Salir de la Comunidad';

  @override
  String community_deleteConfirm(String name) {
    return '¿Salir de \"$name\"?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return 'Esto también eliminará $count canal(es) y sus mensajes.';
  }

  @override
  String community_deleted(String name) {
    return 'Has salido de la comunidad \"$name\"';
  }

  @override
  String get community_regenerateSecret => 'Regenerar Contraseña Secreta';

  @override
  String community_regenerateSecretConfirm(String name) {
    return 'Regenerar la clave secreta para \"$name\"? Todos los miembros deberán escanear el nuevo código QR para seguir comunicándose.';
  }

  @override
  String get community_regenerate => 'Regenerar';

  @override
  String community_secretRegenerated(String name) {
    return 'Código secreto regenerado para \"$name\"';
  }

  @override
  String get community_updateSecret => 'Actualizar Contraseña';

  @override
  String community_secretUpdated(String name) {
    return 'Confidencialidad actualizada para \"$name\"';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return 'Escanear el nuevo código QR para actualizar el secreto de \"$name\"';
  }

  @override
  String get community_addHashtagChannel => 'Añadir Hashtag de la Comunidad';

  @override
  String get community_addHashtagChannelDesc =>
      'Añadir un canal con hashtag para esta comunidad';

  @override
  String get community_selectCommunity => 'Seleccionar Comunidad';

  @override
  String get community_regularHashtag => 'Etiqueta de Hashtag Regular';

  @override
  String get community_regularHashtagDesc =>
      'Hashtag público (cualquiera puede unirse)';

  @override
  String get community_communityHashtag => 'Hashtag de la Comunidad';

  @override
  String get community_communityHashtagDesc =>
      'Exclusivo para miembros de la comunidad';

  @override
  String community_forCommunity(String name) {
    return 'Para $name';
  }

  @override
  String get listFilter_tooltip => 'Filtrar y ordenar';

  @override
  String get listFilter_sortBy => 'Ordenar por';

  @override
  String get listFilter_latestMessages => 'Últimos mensajes';

  @override
  String get listFilter_heardRecently => 'Escuchado recientemente';

  @override
  String get listFilter_az => 'De la A a la Z';

  @override
  String get listFilter_filters => 'Filtros';

  @override
  String get listFilter_all => 'Todas';

  @override
  String get listFilter_favorites => 'Favoritos';

  @override
  String get listFilter_addToFavorites => 'Añadir a favoritos';

  @override
  String get listFilter_removeFromFavorites => 'Eliminar de las favoritas';

  @override
  String get listFilter_users => 'Usuarios';

  @override
  String get listFilter_repeaters => 'Repetidores';

  @override
  String get listFilter_roomServers => 'Servidores de la sala';

  @override
  String get listFilter_unreadOnly => 'Solo sin leer';

  @override
  String get listFilter_newGroup => 'Nuevo grupo';

  @override
  String get pathTrace_you => 'Tú';

  @override
  String get pathTrace_failed => 'El trazado de ruta falló.';

  @override
  String get pathTrace_notAvailable => 'El trazado de ruta no está disponible.';

  @override
  String get pathTrace_refreshTooltip => 'Actualizar trazado de ruta';

  @override
  String get pathTrace_someHopsNoLocation =>
      'Uno o más de los saltos carecen de una ubicación';

  @override
  String get pathTrace_clearTooltip => 'Borrar ruta';

  @override
  String get losSelectStartEnd =>
      'Seleccione los nodos de inicio y fin para LOS.';

  @override
  String losRunFailed(String error) {
    return 'Error en la comprobación de la línea de visión: $error';
  }

  @override
  String get losClearAllPoints => 'Borrar todos los puntos';

  @override
  String get losRunToViewElevationProfile =>
      'Ejecute LOS para ver el perfil de elevación';

  @override
  String get losMenuTitle => 'Menú LOS';

  @override
  String get losMenuSubtitle =>
      'Toque nodos o mantenga presionado el mapa para puntos personalizados';

  @override
  String get losShowDisplayNodes => 'Mostrar nodos de visualización';

  @override
  String get losCustomPoints => 'Puntos personalizados';

  @override
  String losCustomPointLabel(int index) {
    return 'Personalizado $index';
  }

  @override
  String get losPointA => 'Punto A';

  @override
  String get losPointB => 'Punto B';

  @override
  String losAntennaA(String value, String unit) {
    return 'Antena A: $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return 'Antena B: $value $unit';
  }

  @override
  String get losRun => 'Ejecutar LOS';

  @override
  String get losNoElevationData => 'Sin datos de elevación';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, despejar LOS, autorización mínima $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, bloqueado por $obstruction $heightUnit';
  }

  @override
  String get losStatusChecking => 'LOS: comprobando...';

  @override
  String get losStatusNoData => 'LOS: sin datos';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS: $clear/$total claro, $blocked bloqueado, $unknown desconocido';
  }

  @override
  String get losErrorElevationUnavailable =>
      'Datos de elevación no disponibles para una o más muestras.';

  @override
  String get losErrorInvalidInput =>
      'Datos de puntos/elevación no válidos para el cálculo de LOS.';

  @override
  String get losRenameCustomPoint =>
      'Cambiar el nombre del punto personalizado';

  @override
  String get losPointName => 'Nombre del punto';

  @override
  String get losShowPanelTooltip => 'Mostrar panel LOS';

  @override
  String get losHidePanelTooltip => 'Ocultar panel LOS';

  @override
  String get losElevationAttribution =>
      'Datos de elevación: Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'Horizonte radioeléctrico';

  @override
  String get losLegendLosBeam => 'Línea de visión';

  @override
  String get losLegendTerrain => 'Terreno';

  @override
  String get losBlockedSpotsTitle => 'Espacios ocupados';

  @override
  String get losBlockedSpotsHint =>
      'Seleccione un punto bloqueado para resaltarlo en el mapa.';

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
  String get losSelectedObstructionTitle => 'Obstrucción seleccionada';

  @override
  String losSelectedObstructionDetails(
    String obstruction,
    String heightUnit,
    String distanceFromA,
    String distanceUnit,
    String distanceFromB,
  ) {
    return 'Bloqueado por $obstruction a una altura de $heightUnit, a $distanceFromA metros de A y a $distanceFromB metros de B ($distanceUnit).';
  }

  @override
  String get losFrequencyLabel => 'Frecuencia';

  @override
  String get losFrequencyInfoTooltip => 'Ver detalles del cálculo';

  @override
  String get losFrequencyDialogTitle => 'Cálculo del horizonte radioeléctrico';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'A partir de k=$baselineK en $baselineFreq MHz, el cálculo ajusta el factor k para la banda actual de $frequencyMHz MHz, que define el límite curvo del horizonte de radio.';
  }

  @override
  String get contacts_pathTrace => 'Traza de ruta';

  @override
  String get contacts_ping => 'Ping';

  @override
  String get contacts_repeaterPathTrace => 'Traza de ruta al repetidor';

  @override
  String get contacts_repeaterPing => 'Hacer ping al repetidor';

  @override
  String get contacts_roomPathTrace => 'Traza de ruta al servidor de sala';

  @override
  String get contacts_roomPing => 'Hacer ping al servidor de sala';

  @override
  String get contacts_chatTraceRoute => 'Ruta de trazado';

  @override
  String contacts_pathTraceTo(String name) {
    return 'Traza de ruta a $name';
  }

  @override
  String get contacts_clipboardEmpty => 'El portapapeles está vacío.';

  @override
  String get contacts_invalidAdvertFormat => 'Formato de anuncio no válido';

  @override
  String get contacts_contactImported => 'El contacto ha sido importado.';

  @override
  String get contacts_contactImportFailed =>
      'Contacto no se importó correctamente.';

  @override
  String get contacts_zeroHopAdvert => 'Anuncio de un solo salto';

  @override
  String get contacts_floodAdvert => 'Anuncio de inundación';

  @override
  String get contacts_copyAdvertToClipboard => 'Copiar anuncio al portapapeles';

  @override
  String get contacts_addContactFromClipboard =>
      'Agregar contacto desde el portapapeles';

  @override
  String get contacts_ShareContact => 'Copiar contacto al portapapeles';

  @override
  String get contacts_ShareContactZeroHop =>
      'Compartir contacto por anuncio de un solo salto';

  @override
  String get contacts_zeroHopContactAdvertSent =>
      'Contacto enviado por anuncio.';

  @override
  String get contacts_zeroHopContactAdvertFailed =>
      'No se pudo enviar el contacto.';

  @override
  String get contacts_contactAdvertCopied => 'Anuncio copiado al portapapeles.';

  @override
  String get contacts_contactAdvertCopyFailed =>
      'No se pudo copiar el anuncio al portapapeles.';

  @override
  String get notification_activityTitle => 'Actividad de MeshCore';

  @override
  String notification_messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'mensajes',
      one: 'mensaje',
    );
    return '$count $_temp0';
  }

  @override
  String notification_channelMessagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'mensajes de canal',
      one: 'mensaje de canal',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'nuevos nodos',
      one: 'nuevo nodo',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return 'Nuevo $contactType descubierto';
  }

  @override
  String get notification_receivedNewMessage => 'Nuevo mensaje recibido';

  @override
  String get settings_gpxExportRepeaters =>
      'Exportar repetidores / servidores de sala a GPX';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'Exporta repetidores o servidores de sala con una ubicación a un archivo GPX.';

  @override
  String get settings_gpxExportContacts => 'Exportar compañeros a GPX';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'Exporta compañeros con una ubicación a un archivo GPX.';

  @override
  String get settings_gpxExportAll => 'Exportar todos los contactos a GPX';

  @override
  String get settings_gpxExportAllSubtitle =>
      'Exporta todos los contactos con una ubicación a un archivo GPX.';

  @override
  String get settings_gpxExportSuccess => 'Archivo GPX exportado con éxito.';

  @override
  String get settings_gpxExportNoContacts => 'No hay contactos para exportar.';

  @override
  String get settings_gpxExportNotAvailable =>
      'No compatible con tu dispositivo o sistema operativo';

  @override
  String get settings_gpxExportError => 'Hubo un error al exportar.';

  @override
  String get settings_gpxExportRepeatersRoom =>
      'Ubicaciones de repetidores y servidores de sala';

  @override
  String get settings_gpxExportChat => 'Ubicaciones de compañeros';

  @override
  String get settings_gpxExportAllContacts =>
      'Todas las ubicaciones de contactos';

  @override
  String get settings_gpxExportShareText =>
      'Datos del mapa exportados desde NOTORYX Core';

  @override
  String get settings_gpxExportShareSubject =>
      'Exportación GPX de datos de mapa de NOTORYX Core';

  @override
  String get snrIndicator_nearByRepeaters => 'Repetidores cercanos';

  @override
  String get snrIndicator_lastSeen => 'Visto por última vez';

  @override
  String get contactsSettings_title => 'Configuración de contactos';

  @override
  String get contactsSettings_autoAddTitle => 'Detección automática';

  @override
  String get contactsSettings_otherTitle =>
      'Otras configuraciones relacionadas con el contacto';

  @override
  String get contactsSettings_autoAddUsersTitle =>
      'Agregar usuarios automáticamente';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      'Permitir que el compañero agregue automáticamente a los usuarios descubiertos.';

  @override
  String get contactsSettings_autoAddRepeatersTitle =>
      'Agregar repetidores automáticamente';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      'Permitir que el compañero agregue automáticamente los repetidores descubiertos.';

  @override
  String get contactsSettings_autoAddRoomServersTitle =>
      'Agregar automáticamente servidores de sala';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      'Permitir que el compañero agregue automáticamente los servidores de salas descubiertos.';

  @override
  String get contactsSettings_autoAddSensorsTitle =>
      'Agregar sensores automáticamente';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      'Permitir que el compañero agregue automáticamente los sensores descubiertos.';

  @override
  String get contactsSettings_overwriteOldestTitle =>
      'Sobreescribir el más antiguo';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      'Cuando la lista de contactos esté llena, se reemplazará el contacto no favorito más antiguo.';

  @override
  String get discoveredContacts_Title => 'Contactos descubiertos';

  @override
  String get discoveredContacts_noMatching =>
      'No se encontraron contactos coincidentes';

  @override
  String get discoveredContacts_searchHint => 'Buscar contactos descubiertos';

  @override
  String get discoveredContacts_contactAdded => 'Contacto agregado';

  @override
  String get discoveredContacts_addContact => 'Agregar contacto';

  @override
  String get discoveredContacts_copyContact =>
      'Copiar contacto al portapapeles';

  @override
  String get discoveredContacts_deleteContact => 'Eliminar contacto';

  @override
  String get discoveredContacts_deleteContactAll =>
      'Eliminar Todos los Contactos Descubiertos';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      '¿Está seguro de que desea eliminar todos los contactos descubiertos!';

  @override
  String get chat_sendCooldown =>
      'Por favor, espere un momento antes de reenviar.';

  @override
  String get appSettings_jumpToOldestUnread =>
      'Salta a los mensajes más antiguos sin leer';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      'Cuando abras una conversación con mensajes sin leer, desplázate hacia el primer mensaje sin leer en lugar del más reciente.';

  @override
  String get appSettings_languageHu => 'Húngaro';

  @override
  String get appSettings_languageJa => 'Japonés';

  @override
  String get appSettings_languageKo => 'Coreano';

  @override
  String get radioStats_tooltip => 'Estadísticas de radio y malla';

  @override
  String get radioStats_screenTitle => 'Estadísticas de radio';

  @override
  String get radioStats_notConnected =>
      'Conéctese a un dispositivo para visualizar estadísticas de radio.';

  @override
  String get radioStats_firmwareTooOld =>
      'Las estadísticas de radio requieren un firmware compatible v8 o posterior.';

  @override
  String get radioStats_waiting => 'Esperando datos…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'Nivel de ruido: $noiseDbm dBm';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return 'Último RSSI: $rssiDbm dBm';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return 'Último SNR: $snr dB';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'Tiempo de emisión en Texas (total): $seconds s';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'Tiempo de transmisión de RX (total): $seconds s';
  }

  @override
  String get radioStats_chartCaption =>
      'Nivel de ruido (dBm) en muestras recientes.';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'Nivel de ruido: $noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting => 'Obteniendo estadísticas de la radio…';

  @override
  String get radioStats_settingsTile => 'Estadísticas de radio';

  @override
  String get radioStats_settingsSubtitle =>
      'Nivel de ruido, RSSI, SNR y tiempo de transmisión';

  @override
  String get translation_title => 'Traducción';

  @override
  String get imageMessages_enableTitle => 'Mensajes de imagen';

  @override
  String get imageMessages_enableSubtitle =>
      'Enviar imágenes a través de la malla. Requiere la descarga de un modelo de imagen único.';

  @override
  String get imageMessages_modelSectionTitle => 'Modelo de imagen';

  @override
  String get imageMessages_downloadModel => 'Descargar';

  @override
  String get imageMessages_cancelDownload => 'Cancelar';

  @override
  String get imageMessages_removeModel => 'Eliminar modelo';

  @override
  String get imageMessages_modelReady => 'Listo';

  @override
  String get imageMessages_modelNotPublished =>
      'Aún no publicado — esta versión no puede descargarlo.';

  @override
  String get imageMessages_downloadFailed =>
      'El modelo de imagen no pudo ser descargado.';

  @override
  String get imageMessages_autoProcessTitle =>
      'Procesar imágenes automáticamente';

  @override
  String get imageMessages_autoProcessSubtitle =>
      'Reconstruya cada imagen tan pronto como llegue. Utiliza aproximadamente 2 GB de memoria durante un segundo cada vez; desactívelo para reconstruir con un toque.';

  @override
  String get translation_enableTitle => 'Habilitar la traducción';

  @override
  String get translation_enableSubtitle =>
      'Traducir los mensajes entrantes y permitir la traducción previa al envío.';

  @override
  String get translation_composerTitle => 'Traducir antes de enviar';

  @override
  String get translation_composerSubtitle =>
      'Controla el estado predeterminado del icono de traducción del compositor.';

  @override
  String get translation_autoIncomingTitle =>
      'Traducir mensajes automáticamente';

  @override
  String get translation_autoIncomingSubtitle =>
      'Traduce mensajes para notificaciones y para chats o canales automáticamente.';

  @override
  String get translation_translateMessage => 'Traducir mensaje';

  @override
  String get translation_targetLanguage => 'Idioma de destino';

  @override
  String get translation_useAppLanguage =>
      'Utilizar el idioma de la aplicación';

  @override
  String get translation_downloadedModelLabel => 'Modelo descargado';

  @override
  String get translation_presetModelLabel =>
      'Modelo predefinido de Hugging Face';

  @override
  String get translation_manualUrlLabel => 'URL del modelo manual';

  @override
  String get translation_downloadModel => 'Descargar el modelo';

  @override
  String get translation_downloading => 'Descargando...';

  @override
  String get translation_working => 'Trabajando...';

  @override
  String get translation_stop => '¡Detente!';

  @override
  String get translation_mergingChunks =>
      'Combinando los fragmentos descargados en el archivo final...';

  @override
  String get translation_downloadedModels => 'Modelos descargados';

  @override
  String get translation_deleteModel => 'Eliminar modelo';

  @override
  String get translation_modelDownloaded => 'Modelo de traducción descargado.';

  @override
  String get translation_downloadStopped => 'La descarga se ha detenido.';

  @override
  String translation_downloadFailed(String error) {
    return 'No se pudo descargar: $error';
  }

  @override
  String get translation_enterUrlFirst =>
      'Primero, introduzca la URL del modelo.';

  @override
  String get scanner_linuxPairingShowPin => 'Mostrar código PIN';

  @override
  String get scanner_linuxPairingHidePin => 'Ocultar PIN';

  @override
  String get scanner_linuxPairingPinTitle =>
      'PIN para emparejar dispositivos Bluetooth';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return 'Introduzca el código PIN para $deviceName (deje en blanco si no hay ninguno).';
  }

  @override
  String get translation_messageTranslation => 'Traducción del mensaje';

  @override
  String get translation_translateBeforeSending => 'Traducir antes de enviar';

  @override
  String get translation_composerEnabledHint =>
      'Los mensajes serán traducidos antes de ser enviados.';

  @override
  String get translation_composerDisabledHint =>
      'Envía mensajes utilizando el lenguaje escrito original.';

  @override
  String translation_translateTo(String language) {
    return 'Traducir a $language';
  }

  @override
  String get translation_translationOptions => 'Opciones de traducción';

  @override
  String get translation_systemLanguage => 'Idioma del sistema';

  @override
  String get background_serviceTitle => 'MeshCore en ejecución';

  @override
  String get background_serviceText => 'Manteniendo BLE conectado';

  @override
  String appSettings_translationModelDeleted(String name) {
    return 'Eliminado $name';
  }

  @override
  String appSettings_translationModelDeleteFailed(String error) {
    return 'No se pudo eliminar: $error';
  }

  @override
  String channels_channelUpdateFailed(String error) {
    return 'No se pudo actualizar el canal: $error';
  }

  @override
  String get contact_typeChat => 'Chat';

  @override
  String get contact_typeRepeater => 'Repetidor';

  @override
  String get contact_typeRoom => 'Sala';

  @override
  String get contact_typeSensor => 'Sensor';

  @override
  String get contact_typeUnknown => 'Desconocido';

  @override
  String get map_zoomIn => 'Acercar';

  @override
  String get map_zoomOut => 'Alejar';

  @override
  String get map_centerMap => 'Centrar mapa';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'Web Bluetooth requiere un navegador Chromium.';

  @override
  String channels_communityShortId(String id) {
    return 'ID: $id...';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'Confirmado mediante GPS';

  @override
  String get pathTrace_legendInferred => 'Posición estimada';

  @override
  String get pathMap_viewSingle => 'Individual';

  @override
  String get pathMap_viewCombined => 'Combinado';

  @override
  String get pathMap_play => 'Reproducir';

  @override
  String get pathMap_pause => 'Pausa';

  @override
  String get pathMap_replay => 'Repetir';

  @override
  String get pathMap_stepBack => 'Salto anterior';

  @override
  String get pathMap_stepForward => 'Siguiente salto';

  @override
  String get pathMap_animationOn => 'Mostrar animación del paquete';

  @override
  String get pathMap_animationOff => 'Ocultar la animación del paquete';

  @override
  String pathMap_hopOf(int current, int total) {
    return 'Saltar $current de $total';
  }

  @override
  String pathMap_observedPaths(int count) {
    return 'Rutas observadas: $count';
  }

  @override
  String get pathMap_primary => 'Principal';

  @override
  String pathMap_alternate(int index) {
    return 'Alternativo $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saltos',
      one: '1 salto',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => 'Segmento compartido';

  @override
  String get pathMap_legendEstimated => 'Segmento estimado';

  @override
  String pathMap_sharedNodeCount(int count) {
    return 'Utilizado en $count rutas.';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saltos no tienen ubicación — la ruta mostrada es parcial',
      one: '1 salto no tiene ubicación — la ruta mostrada es parcial',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'Mostrar todas';

  @override
  String get pathMap_hidePath => 'Ocultar ruta';

  @override
  String get pathMap_showPath => 'Mostrar ruta';

  @override
  String get pathMap_collapsePanel => 'Cerrar panel';

  @override
  String get pathMap_expandPanel => 'Ampliar panel';

  @override
  String get pathMap_noLocation => 'Sin ubicación';

  @override
  String get pathMap_followPacket => 'Seguir paquete';

  @override
  String get pathMap_unfollowPacket => 'Dejar de seguir el paquete';

  @override
  String get imageSend_title => 'Enviar imagen';

  @override
  String get imageSend_cropNote =>
      'Redimensionado a 512 × 512 · la relación de aspecto no se conservó';

  @override
  String get imageSend_originalSize => 'Texto original';

  @override
  String get imageSend_onAirSize => 'En emisión';

  @override
  String get imageSend_quality => 'Calidad';

  @override
  String get imageSend_qualityStandard => 'Estándar';

  @override
  String get imageSend_qualityHigh => 'Alto';

  @override
  String get imageSend_packetsLabel => 'Paquetes';

  @override
  String get imageSend_airtimeLabel => 'Tiempo en pantalla';

  @override
  String get imageSend_sizeLabel => 'Carga útil';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'paquetes',
      one: 'paquete',
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
  String get imageSend_radioUnknownTitle =>
      'Configuración de radio desconocida';

  @override
  String get imageSend_radioUnknownBody =>
      'Conéctese a un dispositivo para que se pueda calcular la hora de transmisión.';

  @override
  String get imageSend_longSendTitle => 'Larga transmisión';

  @override
  String imageSend_longSendBody(String duration) {
    return 'Esto mantendrá el canal durante aproximadamente $duration.';
  }

  @override
  String get imageSend_floodNote =>
      'Enrutamiento de inundación: cada repetidor dentro del rango retransmite cada paquete, por lo que el canal permanece ocupado durante más tiempo que esto.';

  @override
  String get imageSend_parityTitle => 'Paquete de recuperación';

  @override
  String get imageSend_paritySubtitle =>
      'Un paquete adicional. Los mensajes grupales no son reconocidos, por lo que esto permite al receptor reconstruir la imagen si se pierde un solo paquete.';

  @override
  String get imageSend_send => 'Enviar';

  @override
  String get imageSend_cancel => 'Cancelar';

  @override
  String get imageSend_encodeFailed => 'Esta imagen no pudo ser codificada.';

  @override
  String get imageSend_codecDownloading =>
      'El modelo de imagen todavía se está descargando.';

  @override
  String get imageSend_codecUnavailable =>
      'El envío de imágenes no está disponible en este dispositivo.';

  @override
  String get imageSend_codecDisabled =>
      'Los mensajes de imagen están desactivados en la configuración.';

  @override
  String get imageSend_deviceUnsupported =>
      'Esta radio no puede enviar paquetes de imagen. Conecte un dispositivo con el firmware Companion versión 13 o superior.';

  @override
  String get imageSend_directMessagesUnsupported =>
      'Las imágenes se transmiten como datos grupales, por lo que solo se pueden enviar a un canal, no mediante mensajes directos.';

  @override
  String get imageSend_tooLarge =>
      'Esa imagen se codificó en más paquetes de los que permite el formato de malla.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'paquetes',
      one: 'paquete',
    );
    return 'Imagen enviada como $count $_temp0.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return 'La imagen no pudo ser enviada: $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return 'Envío de imagen — paquete $sent de $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'Nodo $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return '$received de $total paquetes';
  }

  @override
  String get receivedImage_queued => 'Esperando descifrar';

  @override
  String get receivedImage_tapToDecode => 'Toque para decodificar';

  @override
  String get receivedImage_decoding =>
      'Reconstruyendo… aproximadamente 1 segundo';

  @override
  String receivedImage_incomplete(int received, int total) {
    return 'Imagen incompleta — $received de $total paquetes llegados';
  }

  @override
  String get receivedImage_corrupt => 'La imagen no pudo ser reconstruida';

  @override
  String get receivedImage_decoderMissing =>
      'Imagen recibida — la decodificación de la imagen no funciona';

  @override
  String get receivedImage_evicted => 'Imagen ya no almacenada';

  @override
  String get receivedImage_retry => 'Inténtalo de nuevo';

  @override
  String get receivedImage_decodeAgain => 'Decodificar de nuevo';

  @override
  String get receivedImage_openSettings => 'Configurar';

  @override
  String get receivedImage_tapToProcess => 'Toque para procesar';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'paquetes',
      one: 'paquete',
    );
    return '$bytes bytes · $packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds segundos';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes min $seconds s';
  }

  @override
  String get bastion_tagline => 'Comunicación sin infraestructura.';

  @override
  String get bastion_nodes => 'Nodos';

  @override
  String get bastion_repeaters => 'Repetidores';

  @override
  String get bastion_active1h => 'Activos 1 h';

  @override
  String get bastion_mapCoverage => 'Mapa + cobertura';

  @override
  String get bastion_routeIntelligence => 'Inteligencia de rutas';

  @override
  String get bastion_repeaterTools => 'Herramientas de repetidor';

  @override
  String get bastion_fieldStats => 'Estadísticas de campo';

  @override
  String get bastion_fieldOps => 'Salida + operaciones de campo';

  @override
  String get bastion_coverageCapture => 'Captura de cobertura';

  @override
  String get bastion_mapAttribution =>
      'Datos del mapa © colaboradores de OpenStreetMap; teselas del proveedor seleccionado';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count observaciones',
      one: '1 observación',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nodos únicos',
      one: '1 nodo único',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saltos',
      one: '1 salto',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutos',
      one: '1 minuto',
    );
    return '$_temp0';
  }

  @override
  String get sos_holdHint =>
      'Mantén pulsado 2 segundos. Envía tu posición a tus contactos de la salida cada 5 minutos hasta que alguien responda.';

  @override
  String sos_holdHintChannel(String channel) {
    return 'Mantén pulsado 2 segundos. Envía tu posición a tus contactos de la salida y a $channel cada 5 minutos hasta que alguien responda.';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS no enviado: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return 'Confirmado por $name. Repeticiones detenidas.';
  }

  @override
  String get sos_waitingForRadio => 'Esperando a que la radio envíe…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return 'Enviado $sends de $max veces. Repeticiones terminadas; aún sin respuesta.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return 'Enviado $sends de $max veces. Siguiente a las $time.';
  }

  @override
  String get sos_active => 'SOS ACTIVO';

  @override
  String get sos_stop => 'DETENER';

  @override
  String get sos_imSafe => 'ESTOY A SALVO';

  @override
  String get sos_holdSemantics => 'SOS. Mantén pulsado para enviar.';

  @override
  String get sos_keepHolding => 'SIGUE PULSANDO…';

  @override
  String get sos_holdForSos => 'MANTÉN PARA SOS';

  @override
  String get sos_blockStorage =>
      'Primero resuelve el error de almacenamiento del registro de campo.';

  @override
  String get sos_blockNotConnected =>
      'Conecta tu radio MeshCore para enviar un SOS.';

  @override
  String get sos_blockNoTarget =>
      'Elige contactos de la salida o un canal SOS en Planificar salida.';

  @override
  String get checkIn_labelOk => 'Estoy bien';

  @override
  String get checkIn_labelAtCamp => 'En el campamento';

  @override
  String get checkIn_labelDelayed => 'Con retraso';

  @override
  String get checkIn_labelHeadingBack => 'De regreso';

  @override
  String get checkIn_blockLoading => 'Cargando tu salida…';

  @override
  String get checkIn_blockStorage =>
      'Resuelve el error de almacenamiento del registro de campo antes de enviar.';

  @override
  String get checkIn_blockBusy =>
      'Se está enviando un aviso. Espera, por favor.';

  @override
  String get checkIn_blockNoContacts =>
      'Elige contactos de la salida en Planificar salida.';

  @override
  String get checkIn_blockRosterIncomplete =>
      'Algunos contactos de la salida no están disponibles. Revisa tu lista.';

  @override
  String get checkIn_blockNotConnected =>
      'Conecta tu radio MeshCore para enviar un aviso.';

  @override
  String get checkIn_blockNotActive =>
      'Inicia tu salida para activar los avisos.';

  @override
  String get checkIn_notSent => 'No enviado';

  @override
  String checkIn_deliveredToOne(String name) {
    return 'Entregado a $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return 'Entregado a los $count contactos';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return 'Entregado a $delivered de $total';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return 'No entregado: $names';
  }

  @override
  String get checkIn_waitingForRest => 'Esperando al resto';

  @override
  String get checkIn_aContact => 'un contacto';

  @override
  String get checkIn_statusPending => 'Pendiente';

  @override
  String get checkIn_statusSent => 'Enviado';

  @override
  String get checkIn_statusDelivered => 'Entregado';

  @override
  String get checkIn_statusFailed => 'Fallido';

  @override
  String get checkIn_explainPending =>
      'En cola localmente. Esto no confirma la transmisión por radio ni la recepción.';

  @override
  String get checkIn_explainSent =>
      'La radio aceptó el envío. No se ha registrado ninguna confirmación de entrega.';

  @override
  String get checkIn_explainDelivered =>
      'La app registró una confirmación de entrega. No prueba que la persona lo haya leído.';

  @override
  String get checkIn_explainFailed =>
      'Sin entrega confirmada. Revisa la conexión de radio, la accesibilidad del destinatario y el historial de reintentos.';

  @override
  String get checkIn_explainUnknown =>
      'El estado de entrega no está disponible. No des por hecho que este mensaje llegó.';

  @override
  String get tripBrief_heading => 'NOTORYX • Resumen de salida MeshCore';

  @override
  String tripBrief_trip(String name) {
    return 'Salida: $name';
  }

  @override
  String tripBrief_status(String status) {
    return 'Estado: $status';
  }

  @override
  String get tripBrief_active => 'Activa';

  @override
  String get tripBrief_stopped => 'Detenida';

  @override
  String tripBrief_contacts(String names) {
    return 'Contactos: $names';
  }

  @override
  String get tripBrief_noneSelected => 'Ninguno seleccionado';

  @override
  String get tripBrief_unavailableContact =>
      'Contacto no disponible (revisa la lista)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return 'Actividad atrasada tras: $minutes minutos (este teléfono avisa cuando un contacto queda en silencio)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'Recordatorio de aviso: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return 'cada $minutes minutos sin aviso';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'Opciones de aviso: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'Posición de radio en los avisos: $value';
  }

  @override
  String get tripBrief_includedMayBeStale =>
      'Incluida; puede estar desactualizada';

  @override
  String tripBrief_battery(String value) {
    return 'Batería de la radio en los avisos: $value';
  }

  @override
  String get tripBrief_included => 'Incluida';

  @override
  String get tripBrief_off => 'Desactivada';

  @override
  String get tripBrief_review =>
      'Revisa los destinatarios y el mensaje antes de enviar un aviso.';

  @override
  String get tripBrief_noProof =>
      'En cola o enviado no prueba la entrega. Una confirmación no prueba que se haya leído.';

  @override
  String get tripBrief_overdueMeaning =>
      'Atrasado significa sin actividad reciente del contacto; no es una emergencia confirmada.';

  @override
  String get tripBrief_automations =>
      'Las automatizaciones de campo solo funcionan mientras la app está activa. Acordad un plan aparte por si se pierde el contacto.';

  @override
  String get tripBrief_sharesOnly =>
      'Este resumen solo comparte información; no envía un mensaje de radio ni inicia una salida.';

  @override
  String get fieldOps_title => 'Operaciones de campo de NOTORYX Core';

  @override
  String get fieldOps_tabTrip => 'Salida';

  @override
  String get fieldOps_tabReady => 'Listo';

  @override
  String get fieldOps_tabLog => 'Registro';

  @override
  String get fieldOps_tabAuto => 'Auto';

  @override
  String get fieldOps_tabCoverage => 'Cobertura';

  @override
  String get fieldOps_tabConnection => 'Conexión';

  @override
  String get fieldOps_diagnostics => 'Diagnóstico';

  @override
  String get fieldOps_storageLoadError =>
      'No se pudieron cargar los datos de campo. Los datos guardados se conservaron; las automatizaciones siguen desactivadas.';

  @override
  String get fieldOps_storageSaveError =>
      'No se pudieron guardar los datos de campo. Automatizaciones detenidas; los datos ya guardados se conservan.';

  @override
  String get fieldOps_regionHint =>
      'Selecciona un área y niveles de zoom en Mapas sin conexión.';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • zoom $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return 'No se pudo verificar el área del mapa: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Salida activa • $count contactos',
      one: 'Salida activa • 1 contacto',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped =>
      'Salida detenida. Iníciala cuando estés listo.';

  @override
  String fieldOps_reminderAt(String time) {
    return 'Recordatorio de aviso a las $time';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return 'En silencio demasiado tiempo: $names';
  }

  @override
  String get fieldOps_planTrip => 'Planificar salida';

  @override
  String get fieldOps_endTrip => 'Terminar salida';

  @override
  String get fieldOps_startTrip => 'Iniciar salida';

  @override
  String get fieldOps_tripBrief => 'Resumen de salida';

  @override
  String get fieldOps_connectRadio => 'Conectar radio';

  @override
  String get fieldOps_previewedCheckIns => 'Avisos con vista previa';

  @override
  String get fieldOps_previewedCheckInsHint =>
      'Elige un estado, revisa los destinatarios reales y el mensaje y luego envía. En cola no significa entregado.';

  @override
  String get fieldOps_tripRoster => 'Lista de la salida';

  @override
  String get fieldOps_rosterEmpty =>
      'Elige hasta seis contactos de chat conocidos en Planificar salida.';

  @override
  String get fieldOps_rosterCaveat =>
      '«Oído por última vez» es prueba de actividad pasada. No establece la accesibilidad actual. Las marcas de atraso significan sin actividad reciente del contacto, no una emergencia confirmada.';

  @override
  String get fieldOps_offlineMaps => 'Mapas sin conexión';

  @override
  String get fieldOps_checkingTiles => 'Comprobando teselas guardadas…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count teselas guardadas.',
      one: '1 tesela guardada.',
    );
    return '$_temp0 Esto no garantiza que toda tu ruta esté cubierta.';
  }

  @override
  String get fieldOps_downloadAreas => 'Descargar / revisar áreas sin conexión';

  @override
  String fieldOps_lastCheckIn(String time) {
    return 'Último aviso, $time';
  }

  @override
  String fieldOps_deliveryChip(String name, String status) {
    return '$name: $status';
  }

  @override
  String get fieldOps_contactFallback => 'Contacto';

  @override
  String fieldOps_resendFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Reenviar a $count no entregados',
      one: 'Reenviar a 1 no entregado',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable =>
      'Contacto seleccionado no disponible';

  @override
  String get fieldOps_memberUnavailableHint =>
      'Revisa esta salida antes de enviar.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return 'Última actividad hace $minutes min';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return 'Última actividad hace $minutes min • atrasado';
  }

  @override
  String get fieldOps_noCheckInRecorded =>
      'No hay ningún aviso registrado en este registro.';

  @override
  String get fieldOps_tripMap => 'Mapa de la salida';

  @override
  String get fieldOps_tripMapEmpty =>
      'Ningún contacto seleccionado ha anunciado coordenadas todavía.';

  @override
  String get fieldOps_lastPositions => 'Últimas posiciones anunciadas';

  @override
  String get fieldOps_positionsCaveat =>
      'Las posiciones pueden estar desactualizadas. Este mapa no sigue el GPS del teléfono ni prueba que los miembros estén aquí ahora.';

  @override
  String get fieldOps_briefPreviewTitle => 'Vista previa del resumen de salida';

  @override
  String get fieldOps_briefPreviewHint =>
      'Incluye nombres de la salida y de los contactos. Revísalo antes de compartirlo. Se omiten coordenadas, claves e historial de mensajes.';

  @override
  String get fieldOps_shareBrief => 'Compartir resumen';

  @override
  String get fieldOps_briefSubject => 'Resumen de salida de NOTORYX Core';

  @override
  String get fieldOps_tripName => 'Nombre de la salida';

  @override
  String get fieldOps_defaultTripName => 'Mi salida';

  @override
  String get fieldOps_includePosition =>
      'Incluir la posición anunciada por la radio';

  @override
  String get fieldOps_includePositionHint =>
      'Puede estar desactualizada; compartir está desactivado por defecto.';

  @override
  String get fieldOps_includeBattery => 'Incluir batería de la radio';

  @override
  String get fieldOps_overdueLabel =>
      'Avisarme cuando un contacto esté en silencio durante';

  @override
  String get fieldOps_reminderLabel => 'Recordarme enviar un aviso';

  @override
  String get fieldOps_reminderHelper =>
      'Una notificación del teléfono, aunque NOTORYX Core esté cerrado.';

  @override
  String get fieldOps_reminderOff => 'Desactivado';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tras $count minutos sin aviso',
      one: 'Tras 1 minuto sin aviso',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'El SOS también va al canal';

  @override
  String get fieldOps_sosChannelNone => 'Ninguno';

  @override
  String get fieldOps_selectContacts =>
      'Selecciona hasta seis contactos de chat conocidos';

  @override
  String get fieldOps_sendCheckInTitle => '¿Enviar aviso?';

  @override
  String fieldOps_recipients(String names) {
    return 'Para: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      'Usa envíos normales de mensajes directos. La entrega se seguirá en el registro de campo.';

  @override
  String get fieldOps_send => 'Enviar';

  @override
  String get fieldOps_beforeYouLeave => 'Antes de salir';

  @override
  String get fieldOps_radioConnected => 'Radio conectada';

  @override
  String get fieldOps_connectHint => 'Conecta por Bluetooth, USB o TCP.';

  @override
  String get fieldOps_radioBattery => 'Batería de la radio';

  @override
  String get fieldOps_batteryUnknown => 'Desconocida; revisa la radio.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent % • cárgala para la salida prevista.';
  }

  @override
  String get fieldOps_tripContacts => 'Contactos de la salida';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return '$available/$selected disponibles. Comprueba que tengan radios y canales compatibles.';
  }

  @override
  String get fieldOps_offlineArea => 'Área de mapa sin conexión seleccionada';

  @override
  String get fieldOps_checkingFiles => 'Comprobando archivos locales…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return '$available/$expected archivos de teselas disponibles; faltan $missing. Es una instantánea; abre el área sin conexión antes de salir.';
  }

  @override
  String get fieldOps_locationChoice => 'Compartir ubicación';

  @override
  String get fieldOps_locationOptedIn =>
      'Activado: las coordenadas anunciadas por la radio pueden estar desactualizadas.';

  @override
  String get fieldOps_locationOff =>
      'Compartir está desactivado. Tus avisos omiten las coordenadas.';

  @override
  String get fieldOps_automationAvailability =>
      'Disponibilidad de automatizaciones';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'Solo funciona mientras esta app está activa. La suspensión, el cierre o la pérdida de la radio pueden impedir las acciones programadas.';

  @override
  String get fieldOps_readinessCaveat =>
      'Las comprobaciones son orientativas; no prueban el alcance de radio ni garantizan la entrega de mensajes.';

  @override
  String get fieldOps_radio => 'Radio';

  @override
  String get fieldOps_refreshChecks => 'Actualizar comprobaciones';

  @override
  String get fieldOps_searchLog => 'Buscar en el registro de campo';

  @override
  String get fieldOps_kindAll => 'Todo';

  @override
  String get fieldOps_kindCheckIn => 'Aviso';

  @override
  String get fieldOps_kindReceived => 'Recibido';

  @override
  String get fieldOps_kindNote => 'Nota';

  @override
  String get fieldOps_kindDeadZone => 'Zona sin cobertura';

  @override
  String get fieldOps_kindRadio => 'Radio';

  @override
  String get fieldOps_kindAutomation => 'Automatización';

  @override
  String get fieldOps_kindMissed => 'Perdido';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => 'Salida';

  @override
  String get fieldOps_kindOverdue => 'Atrasado';

  @override
  String get fieldOps_addNote => 'Añadir nota';

  @override
  String get fieldOps_exportJson => 'Exportar JSON';

  @override
  String get fieldOps_deleteLog => 'Eliminar registro';

  @override
  String get fieldOps_logSubject => 'Registro de campo de NOTORYX Core';

  @override
  String get fieldOps_logCaveat =>
      'Guardado localmente, hasta 1000 entradas. Las exportaciones pueden contener claves de contactos, mensajes y ubicaciones; revísalas antes de compartir.';

  @override
  String get fieldOps_noEntries => 'No hay entradas que coincidan.';

  @override
  String get fieldOps_tripUnspecified => 'Salida no especificada';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return 'Posición anunciada por la radio registrada $latitude, $longitude (puede estar desactualizada)';
  }

  @override
  String get fieldOps_noteTitle => 'Observación de campo';

  @override
  String get fieldOps_noteLabel => '¿Qué observaste?';

  @override
  String get fieldOps_deadZone => 'Zona sin cobertura reportada';

  @override
  String get fieldOps_deadZoneHint =>
      'Tu observación, no una predicción de cobertura verificada.';

  @override
  String get fieldOps_savePosition =>
      'Guardar la posición anunciada por la radio';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • puede estar desactualizada; no es GPS del teléfono';
  }

  @override
  String get fieldOps_noPosition => 'No hay coordenadas anunciadas utilizables';

  @override
  String get fieldOps_deleteLogTitle => '¿Eliminar el registro de campo?';

  @override
  String get fieldOps_deleteLogBody =>
      'Esto elimina todas las entradas guardadas en este teléfono. Se conservan los ajustes de la salida.';

  @override
  String get fieldOps_localAutomations => 'Automatizaciones locales';

  @override
  String get fieldOps_enableForTrip => 'Activar para esta salida';

  @override
  String get fieldOps_automationsCaveat =>
      'Se desactivan tras cada reinicio de la app. Las reglas solo funcionan mientras la app está activa. Las acciones programadas perdidas aparecen en el registro de campo y nunca se repiten en ráfaga. Los avisos automáticos se limitan a un lote cada 10 minutos.';

  @override
  String get fieldOps_openBotMode => 'Abrir el modo bot de NOTORYX';

  @override
  String get fieldOps_ruleEnabled => 'Regla activada';

  @override
  String get fieldOps_dryRun => 'Simulación';

  @override
  String get fieldOps_dryRunHint =>
      'Registrar la acción sin enviar ni notificar.';

  @override
  String get fieldOps_then => 'Entonces';

  @override
  String get fieldOps_actionLog => 'Escribir en el registro de campo';

  @override
  String get fieldOps_actionNotify => 'Mostrar notificación local';

  @override
  String get fieldOps_actionCheckIn =>
      'Enviar «I\'m OK» a los contactos de la salida';

  @override
  String get fieldOps_batteryThreshold => 'Batería igual o inferior a';

  @override
  String fieldOps_nextDue(String time) {
    return 'Próximo: $time';
  }

  @override
  String get fieldOps_nextDueNone => 'Próximo: no programado';

  @override
  String get fieldOps_previewInLog => 'Vista previa en el registro';

  @override
  String get fieldOps_allowNotifications => 'Permitir notificaciones';

  @override
  String get fieldOps_triggerReconnect => 'CUANDO la radio se reconecte';

  @override
  String get fieldOps_triggerDisconnect => 'CUANDO la radio se desconecte';

  @override
  String get fieldOps_triggerLowBattery =>
      'CUANDO la batería de la radio cruce el umbral';

  @override
  String get fieldOps_triggerNewNode => 'CUANDO se añada un nodo nuevo';

  @override
  String get fieldOps_triggerRepeater => 'CUANDO se añada un repetidor nuevo';

  @override
  String get fieldOps_triggerScheduled => 'CUANDO toque un aviso programado';

  @override
  String get fieldOps_explainConnection => 'Explicar mi conexión';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return 'Estado: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      'El teléfono tiene conexión con la radio. Eso por sí solo no establece una ruta hacia tus destinatarios.';

  @override
  String get fieldOps_disconnectedHint =>
      'No hay conexión de radio activa. Revisa los permisos de Bluetooth, la alimentación y el alcance de la radio; USB/TCP están disponibles en Conectar radio.';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return 'Avisos de la salida pendientes de confirmación: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'Las horas de última vista y las posiciones anunciadas de los nodos pueden estar desactualizadas. La inteligencia de rutas muestra rutas aprendidas de intentos observados; no inventa caminos.';

  @override
  String get fieldOps_routeIntelligence => 'Inteligencia de rutas';

  @override
  String get fieldOps_coverageIntelligence => 'Inteligencia de cobertura';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      'Compara las observaciones registradas entre dos sesiones de campo. Los puntos marcan las posiciones anunciadas por la radio del registrador donde se oyeron nodos. No implican cobertura continua. Las instantáneas RSSI/SNR no son mediciones por nodo.';

  @override
  String get fieldOps_captureSession => 'Capturar una sesión';

  @override
  String get fieldOps_refreshHistory => 'Actualizar historial';

  @override
  String get fieldOps_noCoverageSessions =>
      'Aún no hay sesiones de cobertura guardadas.';

  @override
  String get fieldOps_sessionA => 'Sesión A • verde azulado';

  @override
  String get fieldOps_sessionB => 'Sesión B • ámbar';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: $a nodos únicos • B: $b nodos únicos';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return 'Compartidos: $shared • Solo A: $onlyA • Solo B: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'No oír un nodo durante una sesión no establece una zona sin cobertura. Las condiciones y la duración de la observación varían.';

  @override
  String get fieldOps_heardTooltip =>
      'Observación de nodo oído; no prueba un enlace correcto';

  @override
  String get fieldOps_noteTooltip =>
      'Nota local en coordenadas anunciadas por la radio; puede estar desactualizada.';

  @override
  String get bastionHome_aboutTooltip => 'Acerca de NOTORYX Core';

  @override
  String get bastionHome_getStarted => 'Empezar';

  @override
  String get bastionHome_getStartedHint =>
      'Conecta tu radio y verifica tu primer mensaje';

  @override
  String get bastionHome_planYourTrip => 'Planifica tu salida';

  @override
  String get bastionHome_tripActive => 'Salida activa';

  @override
  String get bastionHome_tripStopped => 'Salida detenida';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • $contacts contactos • $unread mensajes sin leer';
  }

  @override
  String get bastionHome_checkInOk => 'Aviso: estoy bien';

  @override
  String get bastionHome_checkInHint =>
      'Revisa los contactos y el mensaje antes de enviar. Sigue las confirmaciones en el registro de campo.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return 'Último aviso: $summary';
  }

  @override
  String get bastionHome_connectRadio => 'Conectar radio';

  @override
  String get bastionHome_connectRadioHint =>
      'Conexiones MeshCore por Bluetooth, USB y TCP';

  @override
  String get bastionHome_liveDiagnostics => 'Diagnóstico en vivo';

  @override
  String get bastionHome_liveDiagnosticsHint =>
      'Estado de la radio, señal, dispositivo y herramientas de tramas';

  @override
  String get bastionHome_meshDiscovery => 'Descubrimiento de malla';

  @override
  String get bastionHome_meshDiscoveryHint =>
      'Encuentra nodos e inspecciona la malla a tu alrededor';

  @override
  String get bastionHome_fieldOpsHint =>
      'Resumen de salida, preparación, registro de campo, automatizaciones y comparación de cobertura';

  @override
  String get bastionHome_fieldTools => 'Herramientas de campo NOTORYX';

  @override
  String get bastionHome_statusActive => 'ACTIVO';

  @override
  String get bastionHome_consoleOnline => 'Consola de campo en línea';

  @override
  String get bastionHome_consoleReady => 'Consola de campo lista';

  @override
  String get bastionHome_consoleHint =>
      'Conecta una radio para activar el panel en vivo.';

  @override
  String bastionHome_battery(String value) {
    return 'Bat $value';
  }

  @override
  String get bastionTools_title => 'Herramientas de campo';

  @override
  String get bastionTools_backup => 'Copia cifrada';

  @override
  String get bastionTools_backupHint =>
      'Guarda ajustes, contactos y claves, con historial de chat opcional';

  @override
  String get bastionTools_fieldOpsHint =>
      'Avisos, preparación, registro de campo, automatizaciones y comparaciones';

  @override
  String get bastionTools_mapHint =>
      'Mapa en vivo, sesiones de captura, herramientas de mapas sin conexión y regiones';

  @override
  String get bastionTools_pathAnalysis => 'Análisis de rutas';

  @override
  String get bastionTools_pathHint =>
      'Rutas, descubrimiento e inteligencia de caminos';

  @override
  String get bastionTools_repeaterHint =>
      'Estado, inicio de sesión, telemetría, vecinos y administración';

  @override
  String get bastionTools_statsHint =>
      'Recuentos de la malla en vivo y actividad de contactos';

  @override
  String get bastionTools_diagnostics => 'Diagnóstico';

  @override
  String get bastionTools_diagnosticsHint =>
      'Estado de la radio, información del dispositivo, tramas en bruto y exportación';

  @override
  String get bastionTools_about => 'Acerca de + créditos';

  @override
  String get bastionTools_aboutHint =>
      'Versión de NOTORYX Core, declaración de independencia y licencias de código abierto';

  @override
  String get bastionAbout_title => 'Acerca de + Créditos';

  @override
  String get bastionAbout_intro =>
      'Una app comunitaria independiente para redes MeshCore. NOTORYX Core no es una app oficial de MeshCore y la inclusión de recursos de la comunidad no implica asociación ni respaldo.';

  @override
  String get bastionAbout_version => 'Versión';

  @override
  String get bastionAbout_openSource => 'Base de código abierto';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core se basa en el código abierto de MeshCore Open bajo la licencia MIT y lo modifica. El trabajo del flujo de cobertura también da crédito a la MeshMapper Flutter App con licencia MIT cuando corresponde.';

  @override
  String get bastionAbout_community => 'La comunidad primero';

  @override
  String get bastionAbout_communityBody =>
      'Los recursos de creadores externos siguen siendo propiedad de sus respectivos creadores. No se implica propiedad ni asociación.';

  @override
  String get bastionAbout_legalese =>
      'NOTORYX Core • Compañero independiente de MeshCore';

  @override
  String get bastionAbout_licenses => 'Licencias de código abierto';

  @override
  String get bastionSetup_title => 'Primeros pasos con NOTORYX Core';

  @override
  String get bastionSetup_intro =>
      'Conecta, elige un contacto y luego verifica un mensaje. Puedes volver a esta guía desde el panel en cualquier momento.';

  @override
  String get bastionSetup_step1 => '1. Conecta tu radio MeshCore';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return 'Conectado a $device mediante $transport.';
  }

  @override
  String get bastionSetup_noRadio => 'Aún no hay ninguna radio conectada.';

  @override
  String get bastionSetup_step1Power =>
      'Enciende una radio compañera MeshCore. Abre Conectar radio y elige Bluetooth, USB o TCP. Concede los permisos solicitados para la conexión elegida.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Si la búsqueda Bluetooth está vacía, comprueba que Bluetooth está activado y que NOTORYX Core tiene el permiso de Dispositivos cercanos en los ajustes de apps de Android. Sigue cualquier otra solicitud de permisos que muestre el escáner.';

  @override
  String get bastionSetup_connectionDiagnostics => 'Diagnóstico de conexión';

  @override
  String get bastionSetup_step2 => '2. Elige un contacto de chat';

  @override
  String get bastionSetup_step2Body =>
      'Pide a un compañero cercano con ajustes de radio MeshCore compatibles que anuncie su nodo. Elige abajo un contacto de chat conocido; los repetidores se gestionan aparte.';

  @override
  String get bastionSetup_noContacts =>
      'No hay contactos de chat disponibles. Conecta tu radio y abre Descubrimiento de malla.';

  @override
  String get bastionSetup_testRecipient => 'Destinatario de prueba';

  @override
  String get bastionSetup_meshDiscovery => 'Descubrimiento de malla';

  @override
  String get bastionSetup_step3 => '3. Envía y verifica un mensaje';

  @override
  String get bastionSetup_step3Body =>
      'Abre el chat, escribe un mensaje de prueba corto, revisa el destinatario y toca Enviar. Vuelve aquí para ver el último mensaje saliente registrado desde que abriste esta guía.';

  @override
  String get bastionSetup_openTestChat => 'Abrir chat de prueba';

  @override
  String get bastionSetup_connectFirst =>
      'Conecta tu radio para abrir el chat de prueba.';

  @override
  String get bastionSetup_chooseRecipient => 'Primero elige un destinatario.';

  @override
  String get bastionSetup_noTestMessage =>
      'No se ha registrado ningún mensaje de prueba saliente en esta sesión de la guía.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return 'Último mensaje: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'Pide a tu compañero que confirme la recepción o responda. Una confirmación registrada no prueba que lo haya leído. Revisa la conexión y el destinatario si un mensaje falla.';

  @override
  String get bastionSetup_step4 => '4. Prepárate para el campo';

  @override
  String get bastionSetup_step4Body =>
      'Planifica los contactos de tu salida y revisa las áreas de mapa descargadas. El modo bot y las automatizaciones de campo empiezan desactivados; las automatizaciones de campo solo funcionan mientras la app está activa.';

  @override
  String get bastionSetup_tripTools => 'Herramientas de salida y preparación';

  @override
  String get bastionDiag_title => 'Diagnóstico';

  @override
  String get bastionDiag_export => 'Exportar diagnóstico';

  @override
  String get bastionDiag_channels => 'Canales';

  @override
  String get bastionDiag_radio => 'Radio';

  @override
  String get bastionDiag_frequency => 'Frecuencia';

  @override
  String get bastionDiag_bandwidth => 'Ancho de banda';

  @override
  String get bastionDiag_spreadingFactor => 'Factor de dispersión';

  @override
  String get bastionDiag_codingRate => 'Tasa de codificación';

  @override
  String get bastionDiag_txPower => 'Potencia de TX';

  @override
  String get bastionDiag_noiseFloor => 'Nivel de ruido';

  @override
  String get bastionDiag_device => 'Dispositivo';

  @override
  String get bastionDiag_name => 'Nombre';

  @override
  String get bastionDiag_manufacturer => 'Fabricante';

  @override
  String get bastionDiag_firmware => 'Firmware';

  @override
  String get bastionDiag_battery => 'Batería';

  @override
  String get bastionDiag_transport => 'Transporte';

  @override
  String get bastionDiag_deepTools => 'Herramientas avanzadas';

  @override
  String get bastionDiag_liveStats => 'Estadísticas de radio en vivo';

  @override
  String get bastionDiag_liveStatsHint =>
      'Ruido, RSSI, SNR y tiempo en el aire';

  @override
  String get bastionDiag_frameDebug => 'Depuración de tramas / BLE';

  @override
  String get bastionDiag_frameDebugHint =>
      'Inspecciona tramas recibidas decodificadas y en bruto';

  @override
  String get bastionDiag_appLog => 'Registro de depuración de la app';

  @override
  String get bastionDiag_appLogHint =>
      'Revisa los eventos de diagnóstico de la aplicación';

  @override
  String get bastionDiag_online => 'Radio en línea';

  @override
  String get bastionDiag_offline => 'Radio desconectada';

  @override
  String get bastionDiag_offlineHint =>
      'Conecta un compañero MeshCore para rellenar el diagnóstico en vivo.';

  @override
  String get coverage_title => 'Captura de cobertura';

  @override
  String get coverage_leaveBlocked =>
      'Detén y guarda la sesión antes de salir.';

  @override
  String get coverage_savedSessions => 'Sesiones guardadas';

  @override
  String get coverage_caveat =>
      'RSSI/SNR son instantáneas de la radio y pueden pertenecer a otro paquete. Las posiciones son coordenadas anunciadas por la radio, no GPS del teléfono ni prueba de cobertura. Cian: registrador; ámbar: nodo anunciado. No se realiza interpolación.';

  @override
  String get coverage_captureActive => 'Captura activa';

  @override
  String get coverage_fieldSession => 'Sesión de cobertura de campo';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core registra los nodos recién oídos durante esta sesión, incluidos datos de ruta, metadatos de nodo/ubicación y la instantánea RSSI/SNR de la radio más cercana disponible.';

  @override
  String get coverage_disconnectedBody =>
      'Conecta una radio antes de empezar. La captura de cobertura registra observaciones de la malla en vivo desde la radio compañera conectada.';

  @override
  String get coverage_observations => 'Observaciones';

  @override
  String get coverage_uniqueNodes => 'Nodos únicos';

  @override
  String get coverage_elapsed => 'Transcurrido';

  @override
  String get coverage_radioConnected => 'Radio conectada';

  @override
  String get coverage_noRadio => 'Sin radio';

  @override
  String get coverage_gpsReady => 'GPS de radio listo';

  @override
  String get coverage_noGps => 'Sin GPS de radio';

  @override
  String get coverage_stopSave => 'Detener + guardar sesión';

  @override
  String get coverage_start => 'Iniciar sesión de cobertura';

  @override
  String get coverage_exportJson => 'Exportar JSON';

  @override
  String get coverage_exportCsv => 'Exportar CSV';

  @override
  String get coverage_liveObservations => 'Observaciones en vivo';

  @override
  String get coverage_waiting => 'Esperando actividad de la malla';

  @override
  String get coverage_waitingBody =>
      'Inicia una sesión y los nodos activos recién oídos aparecerán aquí. Los valores RSSI/SNR son instantáneas de la radio y no siempre pueden atribuirse a un paquete concreto.';

  @override
  String get coverage_signalNa => 'señal n/d';

  @override
  String get coverage_snrNa => 'SNR n/d';

  @override
  String get coverage_gpsUnavailable => 'GPS de radio no disponible';

  @override
  String coverage_pathLine(String path, String location) {
    return 'Ruta: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'inundación';

  @override
  String get coverage_pathDirect => 'directa';

  @override
  String get coverage_shareSubject => 'Sesión de cobertura de NOTORYX Core';

  @override
  String get coverage_shareText =>
      'Exportación de captura de cobertura de NOTORYX Core';

  @override
  String get coverage_historyTitle => 'Sesiones de cobertura guardadas';

  @override
  String coverage_loadFailed(String error) {
    return 'No se pudieron cargar las sesiones: $error';
  }

  @override
  String get coverage_deleteTitle => '¿Eliminar la sesión guardada?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se eliminarán $count observaciones de este dispositivo.',
      one: 'Se eliminará 1 observación de este dispositivo.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'No se pudo eliminar la sesión: $error';
  }

  @override
  String get coverage_retention =>
      'Se conservan las 20 sesiones completadas más recientes. Comparte las sesiones que quieras conservar. Las capturas interrumpidas pueden reabrirse abajo.';

  @override
  String get coverage_noSessions =>
      'Aún no hay sesiones guardadas. Detén una captura para guardarla.';

  @override
  String get coverage_interrupted => 'Captura interrumpida';

  @override
  String get coverage_saved => 'Guardada';

  @override
  String get coverage_deleteTooltip => 'Eliminar sesión';

  @override
  String coverage_exportFailed(String error) {
    return 'Error al exportar: $error';
  }

  @override
  String get coverage_sessionTitle => 'Sesión de cobertura';

  @override
  String get coverage_shareJson => 'Compartir JSON';

  @override
  String get coverage_shareCsv => 'Compartir CSV';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • antigüedad de la instantánea $age ms';
  }

  @override
  String get coverage_unknown => 'desconocida';

  @override
  String coverage_pathValue(String path) {
    return 'ruta $path';
  }

  @override
  String get coverage_recorder => 'Registrador';

  @override
  String get coverage_noCoordinates =>
      'No hay coordenadas utilizables en esta sesión. Las observaciones siguen disponibles abajo.';

  @override
  String get coverage_osmAttribution =>
      '© colaboradores de OpenStreetMap • mapa base en línea';

  @override
  String get fieldStats_title => 'Inteligencia de campo';

  @override
  String get fieldStats_snapshot => 'Instantánea de la malla en vivo';

  @override
  String get fieldStats_headline => 'Lo que NOTORYX Core sabe ahora mismo.';

  @override
  String get fieldStats_body =>
      'Estos contadores se calculan a partir de la tabla de contactos de MeshCore conectada, ubicaciones, rutas y marcas de tiempo de última vista.';

  @override
  String get fieldStats_total => 'Total';

  @override
  String get fieldStats_chatNodes => 'Nodos de chat';

  @override
  String get fieldStats_rooms => 'Salas';

  @override
  String get fieldStats_sensors => 'Sensores';

  @override
  String get fieldStats_located => 'Ubicados';

  @override
  String get fieldStats_favorites => 'Favoritos';

  @override
  String get fieldStats_routeSnapshot => 'Instantánea de rutas';

  @override
  String get fieldStats_routed => 'Enrutados';

  @override
  String get fieldStats_direct => 'Directos';

  @override
  String get fieldStats_flood => 'Inundación';

  @override
  String get fieldStats_pathIntel => 'Inteligencia de caminos';

  @override
  String get fieldStats_pathIntelBody =>
      'La inteligencia de rutas de NOTORYX Core usa intentos de ruta guardados, número de saltos, éxitos/fallos, tiempo de viaje y ponderación de rutas para mostrar rutas aprendidas.';

  @override
  String get fieldStats_coverageSessions => 'Sesiones de cobertura';

  @override
  String get fieldStats_coverageSessionsBody =>
      'La captura de cobertura ahora guarda sesiones de campo, restaura el trabajo interrumpido, exporta observaciones y mapea los puntos de cobertura registrados. RSSI/SNR siguen siendo la instantánea de radio más cercana disponible.';

  @override
  String get mapHub_title => 'Mapa de campo NOTORYX';

  @override
  String get mapHub_intro =>
      'Mapas en vivo, áreas sin conexión, perfiles regionales y sesiones de cobertura de campo de NOTORYX Core.';

  @override
  String get mapHub_captureHint =>
      'Inicia y detén una sesión de cobertura de campo';

  @override
  String get mapHub_badgeNew => 'NUEVO';

  @override
  String get mapHub_liveMap => 'Mapa de malla en vivo';

  @override
  String get mapHub_liveMapHint =>
      'Nodos, repetidores, posiciones, rutas y herramientas de mapa';

  @override
  String get mapHub_badgeLive => 'EN VIVO';

  @override
  String get mapHub_offlinePacks => 'Paquetes de mapas sin conexión';

  @override
  String get mapHub_offlinePacksHint =>
      'Guarda teselas de mapa para salidas y zonas sin servicio';

  @override
  String get mapHub_badgeOffline => 'SIN CONEXIÓN';

  @override
  String get mapHub_regions => 'Perfiles de región';

  @override
  String get mapHub_regionsHint =>
      'Gestiona y obtén definiciones regionales de malla';

  @override
  String get mapHub_badgeRegions => 'REGIONES';

  @override
  String get routes_title => 'Inteligencia de rutas';

  @override
  String get routes_headline => 'Mira cómo se mueve el tráfico por la malla.';

  @override
  String get routes_body =>
      'NOTORYX Core clasifica las rutas guardadas usando el historial de caminos ya aprendido de intentos reales de mensajes y descubrimientos.';

  @override
  String get routes_routes => 'Rutas';

  @override
  String get routes_success => 'Éxito';

  @override
  String get routes_failed => 'Fallidas';

  @override
  String get routes_routeMap => 'Mapa de rutas';

  @override
  String get routes_routeMapHint => 'Inspecciona nodos y caminos';

  @override
  String get routes_discover => 'Descubrir';

  @override
  String get routes_discoverHint => 'Encuentra rutas nuevas';

  @override
  String get routes_learned => 'Rutas aprendidas';

  @override
  String get routes_none => 'Aún no hay historial de rutas';

  @override
  String get routes_noneBody =>
      'Usa la malla con normalidad o ejecuta un descubrimiento. NOTORYX Core mostrará aquí las rutas aprendidas a medida que haya historial de caminos.';

  @override
  String get routes_direct => 'DIRECTA';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rutas',
      one: '1 ruta',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return 'MEJOR  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  peso $weight  •  $success éxitos / $fail fallos';
  }

  @override
  String routes_fastest(String ms) {
    return 'Más rápida conocida: $ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'Inundación: $success éxitos / $fail fallos';
  }

  @override
  String get repeaterTools_heroLabel => 'Control de repetidores';

  @override
  String get repeaterTools_headline =>
      'Gestiona la infraestructura detrás de tu malla.';

  @override
  String get repeaterTools_body =>
      'Selecciona un repetidor descubierto para autenticarte y abrir sus herramientas MeshCore de estado, telemetría, vecinos, ajustes y CLI.';

  @override
  String get repeaterTools_discovered => 'Descubiertos';

  @override
  String get repeaterTools_tools => 'Herramientas';

  @override
  String get repeaterTools_available => 'Repetidores disponibles';

  @override
  String get repeaterTools_unnamed => 'Repetidor sin nombre';

  @override
  String get repeaterTools_statusTelemetry => 'Estado + telemetría';

  @override
  String get repeaterTools_statusTelemetryBody =>
      'Inspecciona el estado y la telemetría del repetidor con las herramientas de gestión existentes.';

  @override
  String get repeaterTools_neighbors => 'Vecinos';

  @override
  String get repeaterTools_neighborsBody =>
      'Inspecciona la infraestructura vecina y las relaciones de la malla.';

  @override
  String get repeaterTools_cli => 'CLI + ajustes';

  @override
  String get repeaterTools_cliBody =>
      'Los administradores autenticados pueden acceder a la CLI del repetidor y a las herramientas de configuración existentes.';

  @override
  String get repeaterTools_empty =>
      'Aún no se han descubierto repetidores. Conecta una radio y descubre la malla primero.';

  @override
  String get notification_fieldAlertTitle => 'Alerta de campo de NOTORYX';

  @override
  String get notification_checkInReminderTitle =>
      'Recordatorio de aviso de NOTORYX Core';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return 'Sin aviso desde hace $minutes minutos en $trip. Abre NOTORYX Core para enviar un aviso.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return 'No se sabe nada de $name desde hace $minutes minutos. No es una emergencia confirmada.';
  }

  @override
  String get notification_aTripContact => 'Un contacto de la salida';

  @override
  String notification_checkInNotDelivered(String name) {
    return 'Aviso no entregado a $name. Puedes reenviarlo desde Salida.';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return 'SOS confirmado por $name';
  }

  @override
  String get settings_batterySaver => 'Ahorro de batería';

  @override
  String get settings_batterySaverOn =>
      'Activado: batería de la radio cada 10 min, GPS cada 5 min, estadísticas como máximo una vez por minuto, comprobaciones de la salida cada 1–2 min. Mensajes, alertas y SOS no cambian.';

  @override
  String get settings_batterySaverOff =>
      'Comprueba la radio y la salida con menos frecuencia para ahorrar batería del teléfono y de la radio. Mensajes, alertas y SOS no cambian.';

  @override
  String get settings_readAloud => 'Leer en voz alta los mensajes nuevos';

  @override
  String get settings_readAloudHelper =>
      'Mientras NOTORYX Core esté abierto. Los canales silenciados no se leen. Cualquier mensaje también puede leerse desde su menú.';

  @override
  String get settings_readAloudOff => 'Desactivado';

  @override
  String get settings_readAloudDirect => 'Mensajes directos';

  @override
  String get settings_readAloudAll => 'Mensajes directos y de canal';

  @override
  String get chat_readAloud => 'Leer en voz alta';

  @override
  String get messageSearch_title => 'Buscar mensajes';

  @override
  String get messageSearch_intro =>
      'Busca en todos los mensajes directos y de canal guardados en este teléfono.';

  @override
  String messageSearch_noResults(String query) {
    return 'Ningún mensaje contiene «$query».';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count coincidencias',
      one: '1 coincidencia',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return 'Se muestran las $count coincidencias más recientes';
  }

  @override
  String get shortcuts_checkIn => 'Enviar aviso';

  @override
  String get shortcuts_trip => 'Salida';

  @override
  String get shortcuts_chats => 'Chats';

  @override
  String get shortcuts_map => 'Mapa';

  @override
  String get sensor_liveUpdates => 'Actualizaciones en vivo';

  @override
  String get sensor_intro =>
      'Haz que el sensor envíe las lecturas por sí mismo cuando cambien, en lugar de preguntar cada vez. Requiere iniciar sesión con acceso de lectura.';

  @override
  String get sensor_watch => 'Vigilar cambios';

  @override
  String get sensor_loadFirst =>
      'Carga primero la telemetría para elegir lecturas.';

  @override
  String sensor_watching(String readings, String time) {
    return 'Vigilando $readings hasta las $time.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return 'Vigilando $readings hasta las $time • región $region.';
  }

  @override
  String get sensor_noChanges => 'Aún no se han notificado cambios.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return 'Última actualización $time • $count recibidas';
  }

  @override
  String get sensor_stop => 'Detener actualizaciones en vivo';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'Detenido aquí; el sensor no lo confirmó y se detendrá cuando acabe el tiempo. $error';
  }

  @override
  String get sensor_dialogBody =>
      'El sensor comprueba aproximadamente una vez por minuto y envía una actualización cuando una lectura elegida cambia más que su umbral.';

  @override
  String sensor_readingTitle(String label, String channel) {
    return '$label (canal $channel)';
  }

  @override
  String sensor_readingValue(String label, String channel, String value) {
    return '$label (canal $channel): $value';
  }

  @override
  String sensor_watchItem(String label, String channel, String delta) {
    return '$label (canal $channel) ±$delta';
  }

  @override
  String sensor_updateOn(String delta) {
    return 'Actualizar con un cambio de $delta';
  }

  @override
  String get sensor_changeThreshold => 'Cambiar umbral';

  @override
  String sensor_capacity(int max, String used) {
    return 'El sensor puede vigilar hasta $max bytes de lecturas ($used usados).';
  }

  @override
  String get sensor_for => 'Durante';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count horas',
      one: '1 hora',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => 'Iniciar';

  @override
  String sensor_thresholdTitle(String label) {
    return 'Umbral de $label';
  }

  @override
  String get sensor_typeTemperature => 'Temperatura';

  @override
  String get sensor_typeHumidity => 'Humedad';

  @override
  String get sensor_typePressure => 'Presión';

  @override
  String get sensor_typeVoltage => 'Tensión';

  @override
  String get sensor_typeCurrent => 'Corriente';

  @override
  String get sensor_typeLight => 'Luz';

  @override
  String get sensor_typeConcentration => 'Concentración';

  @override
  String get sensor_typePercentage => 'Porcentaje';

  @override
  String get sensor_typeAnalogInput => 'Entrada analógica';

  @override
  String get sensor_typeAltitude => 'Altitud';

  @override
  String get setupWizard_title => 'Conecta tu radio';

  @override
  String get setupWizard_choose => '1. Elige una conexión';

  @override
  String get setupWizard_prepare => '2. Prepara tu radio';

  @override
  String get setupWizard_intro =>
      'Elige cómo se conectará este teléfono u ordenador a tu radio. La radio transporta los mensajes por la malla.';

  @override
  String get setupWizard_bluetooth =>
      'Conexión inalámbrica a una radio compatible cercana.';

  @override
  String get setupWizard_noBluetooth =>
      'Bluetooth no está disponible en este navegador. Usa la app nativa o una conexión USB compatible.';

  @override
  String get setupWizard_usb => 'Conexión por cable con un cable de datos USB.';

  @override
  String get setupWizard_noUsb =>
      'USB serie no está disponible aquí. Usa una app de escritorio o Android compatible, o Chrome con Web Serial.';

  @override
  String get setupWizard_bluetoothSteps =>
      'Enciende tu radio y mantenla cerca. Activa Bluetooth y permite que la app lo use. Cierra otras apps conectadas a la radio, abre la lista de dispositivos y busca.';

  @override
  String get setupWizard_usbSteps =>
      'Conecta una radio encendida con un cable de datos USB; un cable solo de carga no sirve. Cierra otras apps serie. Abre la lista de dispositivos USB, elige tu radio y permite el acceso si se solicita.';

  @override
  String get setupWizard_firmwareTitle =>
      'Comprueba la compatibilidad antes de cambiar el firmware';

  @override
  String get setupWizard_firmware =>
      'Tu radio necesita firmware companion de MeshCore compatible con la conexión elegida. La compatibilidad depende de la placa y la compilación del firmware; tener un puerto USB no garantiza que admita USB serie. Consulta las instrucciones de tu placa y compilación instalada. El firmware de repetidor o de servidor de sala no es companion. Que falle la conexión no significa por sí solo que debas volver a flashear.';

  @override
  String get setupWizard_settings =>
      'Esta guía no flashea firmware ni cambia configuración de la radio. Tras conectar, usa Configuración para la región, la frecuencia y las opciones avanzadas. Confirma los configuración con tu malla local antes de cambiarlos.';

  @override
  String get setupWizard_openBluetooth => 'Abrir dispositivos Bluetooth';

  @override
  String get setupWizard_openUsb => 'Abrir dispositivos USB';

  @override
  String get setupWizard_change => 'Cambiar tipo de conexión';

  @override
  String get setupWizard_later => 'Configurar más tarde';

  @override
  String get setupWizard_bluetoothError =>
      'No se pudo conectar con la radio. Mantenla encendida y cerca, revisa los permisos de Bluetooth y cierra otras apps conectadas. Luego busca de nuevo.';

  @override
  String get setupWizard_scanError =>
      'No se pudieron buscar radios. Activa Bluetooth y permite el acceso a Bluetooth o Dispositivos cercanos en los configuración del sistema, y vuelve a buscar.';

  @override
  String get setupWizard_usbError =>
      'No se pudo conectar por USB. Revisa el cable de datos y el dispositivo elegido, permite el acceso USB y cierra otras apps serie. Vuelve a conectar el cable e inténtalo de nuevo.';

  @override
  String get connections_title => 'Conexiones';

  @override
  String get connections_radioTitle => 'Conexión de la radio';

  @override
  String get connections_bluetoothOffNotice =>
      'Bluetooth está desactivado. Actívalo para volver a conectar; la app lo reintentará cuando vuelva.';

  @override
  String get connections_transport => 'Transporte';

  @override
  String connections_lastError(String error) {
    return 'Último error: $error';
  }

  @override
  String get connections_disconnectRadio => 'Desconectar radio';

  @override
  String connections_reconnectTo(String name) {
    return 'Reconectar a $name';
  }

  @override
  String get connections_forgetRadio => 'Olvidar radio';

  @override
  String get connections_connectAnother => 'Conectar otra radio';

  @override
  String get connections_usbSerial => 'USB serie';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'Dispositivo';

  @override
  String get connections_publicKey => 'Clave pública';

  @override
  String get connections_firmware => 'Firmware';

  @override
  String connections_firmwareProtocol(String code) {
    return 'protocolo v$code';
  }

  @override
  String get connections_battery => 'Batería';

  @override
  String get connections_lastRx => 'Última recepción';

  @override
  String get connections_reconnectFailed =>
      'No se pudo reconectar con la radio';

  @override
  String get connections_statusBluetoothOff => 'Bluetooth está desactivado';

  @override
  String get connections_statusConnected => 'Conectada';

  @override
  String get connections_statusConnecting => 'Conectando…';

  @override
  String get connections_statusDisconnecting => 'Desconectando…';

  @override
  String get connections_statusScanning => 'Buscando radios…';

  @override
  String get connections_statusReconnectingSoon => 'Reconectando en breve…';

  @override
  String get connections_statusNotConnected => 'No conectada';

  @override
  String get mqtt_cardTitle => 'Conexión MQTT';

  @override
  String get mqtt_statusNotConfigured => 'Sin configurar';

  @override
  String get mqtt_statusDisconnected => 'Desconectado';

  @override
  String get mqtt_statusConnecting => 'Conectando';

  @override
  String get mqtt_statusConnected => 'Conectado';

  @override
  String get mqtt_statusReconnecting => 'Reconectando';

  @override
  String get mqtt_statusError => 'Error de conexión';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'Bróker: $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn =>
      'Inicia sesión con un token firmado por la radio';

  @override
  String mqtt_tokenSignInAs(String username) {
    return 'Inicia sesión con un token firmado por la radio como $username…';
  }

  @override
  String get mqtt_connectRadioToSignIn =>
      'Conecta tu radio para iniciar sesión';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'El token se renueva a las $time';
  }

  @override
  String mqtt_signedInAs(String username) {
    return 'Sesión iniciada como $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return 'Escuchando en $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'Paquetes: $accepted nuevos, $duplicate duplicados, $invalid no válidos';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return 'Reintento $attempt de $max';
  }

  @override
  String get mqtt_sharingWaitsForRadio =>
      'Compartir espera una conexión de radio';

  @override
  String mqtt_sharingOn(String topic) {
    return 'Compartiendo en $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return 'Compartirá en $topic';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'Estado en línea en $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return 'Compartidos $shared, retenidos $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'Añade un bróker para enlazar el tráfico MeshCore por internet. La conexión de radio funciona de forma independiente.';

  @override
  String get mqtt_disconnect => 'Desconectar MQTT';

  @override
  String get mqtt_connect => 'Conectar MQTT';

  @override
  String get mqtt_packetFeed => 'Feed de paquetes';

  @override
  String get mqtt_setUpBroker => 'Configurar bróker';

  @override
  String get mqtt_brokerSettings => 'Configuración del bróker';

  @override
  String get mqtt_settingsTitle => 'Configuración del bróker MQTT';

  @override
  String get mqtt_presetLabel => 'Empezar desde un preajuste';

  @override
  String get mqtt_presetCustom => 'Bróker personalizado';

  @override
  String get mqtt_presetLocal => 'Bróker local (indica la dirección)';

  @override
  String get mqtt_presetLetsMeshUs =>
      'Analizador LetsMesh (EE. UU., comunidad)';

  @override
  String get mqtt_presetLetsMeshEu => 'Analizador LetsMesh (UE, comunidad)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh es un analizador de paquetes MeshCore gestionado por la comunidad; no forma parte de NOTORYX ni cuenta con su respaldo. Compartir requiere la radio conectada y permanece desactivado hasta que lo actives.';

  @override
  String get mqtt_hostname => 'Nombre de host del bróker';

  @override
  String get mqtt_port => 'Puerto';

  @override
  String get mqtt_useTls => 'Usar TLS';

  @override
  String get mqtt_allowCleartext =>
      'Permitir texto sin cifrar a un bróker local';

  @override
  String get mqtt_allowCleartextHint =>
      'Solo localhost, .local y hosts privados 10.x / 192.168.x.';

  @override
  String get mqtt_useWebSocket => 'Usar WebSocket';

  @override
  String get mqtt_webSocketPath => 'Ruta WebSocket';

  @override
  String get mqtt_topicPrefix => 'Prefijo de topic';

  @override
  String get mqtt_region => 'Región (opcional)';

  @override
  String get mqtt_regionHelp =>
      'Código de región del observador, p. ej. PHL. Déjalo vacío para todas.';

  @override
  String get mqtt_deliverChannel =>
      'Añadir mensajes de canal recibidos por MQTT';

  @override
  String get mqtt_deliverChannelHint =>
      'Los mensajes de tus canales que oyeron los observadores aparecen en tus chats. No se envían por tu radio.';

  @override
  String get mqtt_sharingTitle => 'Compartir como observador';

  @override
  String get mqtt_share => 'Compartir los paquetes que oye mi radio';

  @override
  String get mqtt_shareHint =>
      'Publica los anuncios y el tráfico de canal que recibe tu radio, con su clave pública, la intensidad de señal y la región. Los mensajes de canal siguen cifrados. Requiere una región.';

  @override
  String get mqtt_shareDirect => 'Incluir tráfico de mensajes directos';

  @override
  String get mqtt_shareDirectHint =>
      'Solicitudes, respuestas y mensajes directos. El contenido sigue cifrado, pero muestra qué nodos hablan entre sí.';

  @override
  String get mqtt_shareOwn => 'Incluir mis propios mensajes y anuncios';

  @override
  String get mqtt_signInTitle => 'Inicio de sesión';

  @override
  String get mqtt_authPassword => 'Usuario y contraseña';

  @override
  String get mqtt_authToken => 'Token firmado por la radio';

  @override
  String get mqtt_tokenExplain =>
      'Tu radio firma con su propia clave un token de inicio de sesión de una hora, y la app lo renueva antes de que caduque. La clave nunca sale de la radio. El usuario es v1_ seguido de la clave pública de tu radio.';

  @override
  String get mqtt_radioReady => 'Radio conectada: lista para iniciar sesión.';

  @override
  String get mqtt_radioNeeded =>
      'Conecta tu radio para iniciar sesión. MQTT la espera.';

  @override
  String get mqtt_username => 'Usuario (opcional)';

  @override
  String get mqtt_password => 'Contraseña';

  @override
  String get mqtt_keepPassword =>
      'Déjalo vacío para mantener la contraseña guardada.';

  @override
  String get mqtt_credentialsWeb =>
      'En el navegador, las credenciales solo se guardan hasta que se cierra la página.';

  @override
  String get mqtt_credentialsKeychain =>
      'Las credenciales se guardan en el llavero del sistema, nunca en la configuración de la app ni en registros.';

  @override
  String get mqtt_saveSettings => 'Guardar configuración';

  @override
  String get mqtt_feedTitle => 'Feed de paquetes MQTT';

  @override
  String get mqtt_feedConnect =>
      'Conéctate a un bróker para ver paquetes de los observadores.';

  @override
  String mqtt_feedWaiting(String topic) {
    return 'Esperando paquetes en $topic';
  }

  @override
  String get mqtt_feedUnknownObserver => 'Observador desconocido';

  @override
  String mqtt_feedHeardBy(String observer) {
    return 'Oído por $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return '$hops saltos · $bytes bytes';
  }

  @override
  String get mqtt_packetRequest => 'Solicitud';

  @override
  String get mqtt_packetResponse => 'Respuesta';

  @override
  String get mqtt_packetDirectMessage => 'Mensaje directo';

  @override
  String get mqtt_packetAck => 'Confirmación';

  @override
  String get mqtt_packetAdvert => 'Anuncio';

  @override
  String get mqtt_packetChannelMessage => 'Mensaje de canal';

  @override
  String get mqtt_packetChannelData => 'Datos de canal';

  @override
  String get mqtt_packetAnonymousRequest => 'Solicitud anónima';

  @override
  String get mqtt_packetPath => 'Ruta';

  @override
  String get mqtt_packetTrace => 'Traza';

  @override
  String get mqtt_packetMultipart => 'Multiparte';

  @override
  String get mqtt_packetControl => 'Control';

  @override
  String mqtt_packetType(int type) {
    return 'Tipo $type';
  }

  @override
  String get mqtt_routeTransportFlood => 'Inundación con transporte';

  @override
  String get mqtt_routeFlood => 'Inundación';

  @override
  String get mqtt_routeDirect => 'Directa';

  @override
  String get mqtt_routeTransportDirect => 'Directa con transporte';

  @override
  String get mqtt_noticeInvalidHost =>
      'Introduce un nombre de host o una dirección IPv4 sin esquema ni puerto.';

  @override
  String get mqtt_noticeInvalidPort => 'El puerto debe estar entre 1 y 65535.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'La ruta WebSocket debe empezar por / y no contener consulta ni fragmento.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'El prefijo de topic debe ser una ruta MQTT no vacía y sin comodines.';

  @override
  String get mqtt_noticeInvalidRegion =>
      'La región debe tener de 2 a 8 letras o dígitos, como PHL.';

  @override
  String get mqtt_noticeTlsRequired =>
      'TLS es obligatorio salvo que se permita expresamente el acceso no seguro a un bróker local.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      'MQTT sin cifrar solo se permite con hosts locales aprobados expresamente.';

  @override
  String get mqtt_noticeRegionNeededToShare =>
      'Establece una región para compartir paquetes como observador.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return 'Introduce la contraseña de $username.';
  }

  @override
  String get mqtt_noticeNoNetwork =>
      'Sin conexión de red. MQTT se reconectará cuando vuelva.';

  @override
  String get mqtt_noticeSubscriptionRefused =>
      'El bróker rechazó la suscripción a paquetes.';

  @override
  String get mqtt_noticeBadCredentials =>
      'El bróker rechazó el usuario o la contraseña.';

  @override
  String get mqtt_noticeNotAuthorized =>
      'Esta cuenta no está autorizada en el bróker.';

  @override
  String get mqtt_noticeConnectionRefused => 'El bróker rechazó la conexión.';

  @override
  String get mqtt_noticeUnreachable => 'No se pudo contactar con el bróker.';

  @override
  String get mqtt_noticeTlsFailed =>
      'No se pudo establecer la conexión segura (TLS).';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'Esta plataforma solo admite MQTT sobre WebSocket.';

  @override
  String get mqtt_noticeRadioNotConnected =>
      'Conecta tu radio para iniciar sesión con su clave.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'El firmware de esta radio no permite firmar con su clave.';

  @override
  String get mqtt_noticeSigningTimeout =>
      'La radio no respondió a la solicitud de firma. Puede que su firmware no admita firmar.';

  @override
  String get mqtt_noticeSigningTooLong =>
      'Los datos son demasiado largos para que la radio los firme.';

  @override
  String get mqtt_noticeSigningRejected =>
      'La radio se negó a firmar los datos.';

  @override
  String get scanner_signalStrong => 'Fuerte';

  @override
  String get scanner_signalGood => 'Buena';

  @override
  String get scanner_signalFair => 'Regular';

  @override
  String get scanner_signalWeak => 'Débil';

  @override
  String get scanner_nearbyRadios => 'Radios cercanas';

  @override
  String get scanner_lastRadio => 'Última radio';

  @override
  String get scanner_reconnect => 'Reconectar';

  @override
  String get scanner_tcpHint => 'Una radio con firmware Wi‑Fi en tu red.';

  @override
  String get scanner_otherWays => 'Otras formas de conectar';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count radios cerca',
      one: '1 radio cerca',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => 'Buscando radios…';

  @override
  String get scanner_findTitle => 'Encuentra tu radio';

  @override
  String get scanner_heroHint =>
      'Enciende tu radio y mantenla a pocos metros. Necesita firmware MeshCore companion.';

  @override
  String get scanner_tipsTitle => '¿No ves tu radio?';

  @override
  String get scanner_tipPower => 'Comprueba que esté encendida y activa.';

  @override
  String get scanner_tipFirmware =>
      'Necesita firmware MeshCore companion. Los repetidores y servidores de sala no aparecen aquí.';

  @override
  String get scanner_tipOtherDevice =>
      'Una radio se conecta a un solo dispositivo a la vez. Desconéctala de otros teléfonos u ordenadores.';

  @override
  String get connections_internetBridge => 'Puente a internet';

  @override
  String get connections_noRadio => 'Sin radio';

  @override
  String get connections_radioSettings => 'Ajustes de radio';

  @override
  String get connections_viewDashboard => 'Ver panel de conexiones';

  @override
  String get channelDirectory_title => 'Directorio de canales';

  @override
  String get channelDirectory_subtitle =>
      'Encuentra canales públicos con hashtag cerca de ti';

  @override
  String get channelDirectory_search => 'Buscar canales o lugares';

  @override
  String get channelDirectory_nearYou => 'Cerca de ti';

  @override
  String get channelDirectory_all => 'Todos los canales';

  @override
  String get channelDirectory_catAll => 'Todos';

  @override
  String get channelDirectory_catEmergency => 'Emergencia';

  @override
  String get channelDirectory_catLocal => 'Local';

  @override
  String get channelDirectory_catGeneral => 'General';

  @override
  String get channelDirectory_catInterest => 'Intereses';

  @override
  String get channelDirectory_catTest => 'Pruebas';

  @override
  String get channelDirectory_join => 'Unirse';

  @override
  String get channelDirectory_joined => 'Unido';

  @override
  String get channelDirectory_noMatches =>
      'Ningún canal coincide con tu búsqueda.';

  @override
  String get channelDirectory_connectFirst =>
      'Conecta tu radio para unirte a canales.';

  @override
  String get channelDirectory_slotsFull =>
      'Todas las ranuras de canal de tu radio están en uso. Elimina un canal primero.';

  @override
  String get channelDirectory_joinFailed =>
      'No se pudo añadir el canal. Inténtalo de nuevo.';

  @override
  String get channelDirectory_addHint =>
      '¿Falta un canal? Cualquiera puede sugerirlo editando la lista compartida en GitHub.';

  @override
  String get prefixTool_title => 'IDs de repetidores';

  @override
  String get prefixTool_subtitle =>
      'Quién usa una ID, qué IDs coinciden e IDs libres para un repetidor nuevo';

  @override
  String get prefixTool_width => 'Tamaño de la ID de ruta';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes byte(s)';
  }

  @override
  String get prefixTool_includeCompanions => 'Incluir companions y sensores';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return '$nodes nodos conocidos · $used IDs en uso · $shared compartidas';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return '$free de $space IDs libres';
  }

  @override
  String get prefixTool_lookupHint => 'Busca una ID, p. ej. 3D';

  @override
  String prefixTool_lookupFree(String id) {
    return 'Ningún nodo conocido usa $id.';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nodos usan $id',
      one: '1 nodo usa $id',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => 'IDs compartidas';

  @override
  String get prefixTool_sharedHint =>
      'Las rutas por estas IDs se ven iguales salvo que la red use IDs más largas.';

  @override
  String get prefixTool_noShared =>
      'No hay IDs compartidas entre los nodos que conoces.';

  @override
  String get prefixTool_free => 'IDs libres';

  @override
  String get prefixTool_shuffle => 'Más sugerencias';

  @override
  String get prefixTool_makeKey => 'Crear una clave';

  @override
  String get prefixTool_onlyKnown =>
      'Solo según los nodos que ha oído tu radio. Una ID libre aquí aún puede pertenecer a un repetidor que no has oído.';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id ya lo usa $name.';
  }

  @override
  String get prefixTool_pickFree => 'Elegir una ID libre';

  @override
  String keyGen_title(String id) {
    return 'Clave para la ID $id';
  }

  @override
  String keyGen_searching(int tries) {
    return 'Buscando… $tries claves probadas';
  }

  @override
  String get keyGen_publicKey => 'Clave pública';

  @override
  String get keyGen_privateKey => 'Clave privada';

  @override
  String get keyGen_copy => 'Copiar';

  @override
  String get keyGen_copied => 'Copiado';

  @override
  String get keyGen_secretWarning =>
      'Mantén la clave privada en secreto. Quien la tenga puede hacerse pasar por este nodo.';

  @override
  String get keyGen_howToUse =>
      'Para usarla en un repetidor, abre sus ajustes, pégala como clave privada y guarda. Las radios companion necesitan firmware que permita importar claves.';

  @override
  String get keyGen_tryAgain => 'Crear otra';

  @override
  String get regionSetup_title => 'Configurar regiones';

  @override
  String get regionSetup_hubSubtitle =>
      'Coloca este repetidor en el árbol de regiones de tu zona';

  @override
  String get regionSetup_intro =>
      'Las regiones mantienen un mensaje dentro de una zona en lugar de inundar toda la red. Un repetidor solo reenvía mensajes de una región si la tiene asignada, así que dale su región y todas las superiores.';

  @override
  String get regionSetup_where => '¿Dónde está el repetidor?';

  @override
  String get regionSetup_tree => 'Árbol de regiones';

  @override
  String get regionSetup_custom => 'Personalizado';

  @override
  String get regionSetup_region => 'Región más local';

  @override
  String regionSetup_source(String source) {
    return 'Fuente: $source';
  }

  @override
  String get regionSetup_customLabel =>
      'Regiones, de la más amplia a la más local';

  @override
  String regionSetup_invalidName(String name) {
    return '«$name» no es un nombre de región válido. Usa minúsculas, números y guiones, hasta 29 caracteres.';
  }

  @override
  String regionSetup_tooMany(int max) {
    return 'Un repetidor puede tener como máximo $max regiones.';
  }

  @override
  String get regionSetup_options => 'Opciones';

  @override
  String get regionSetup_setDefault =>
      'Usar la región más local como predeterminada';

  @override
  String get regionSetup_setDefaultBody =>
      'Los anuncios del propio repetidor se quedan en esa región.';

  @override
  String get regionSetup_legacy => 'Firmware 1.14';

  @override
  String get regionSetup_legacyBody =>
      'Añade region allowf tras cada región. No hace falta en 1.15 o posterior.';

  @override
  String get regionSetup_denyUnscoped => 'No reenviar mensajes sin región';

  @override
  String get regionSetup_denyUnscopedBody =>
      'Actívalo solo cuando toda tu zona use regiones, o los mensajes de apps antiguas no llegarán.';

  @override
  String get regionSetup_commands => 'Comandos';

  @override
  String get regionSetup_copyAll => 'Copiar todo';

  @override
  String get regionSetup_copied => 'Copiado';

  @override
  String get regionSetup_pickFirst => 'Elige una región para ver los comandos.';

  @override
  String regionSetup_sendTo(String name) {
    return 'Enviar a $name';
  }

  @override
  String get regionSetup_howToSend =>
      'Para enviarlos, inicia sesión en el repetidor y abre Configurar regiones desde su menú, o pégalos en su línea de comandos.';

  @override
  String get regionSetup_noReply => 'Sin respuesta. Se detuvo aquí.';

  @override
  String get regionSetup_addToMine => 'Añadir estas regiones a mi lista';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count regiones añadidas a tu lista',
      one: '1 región añadida a tu lista',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => 'Registro de ruta';

  @override
  String get trackLog_subtitle => 'Graba un rastro con el GPS de tu radio';

  @override
  String get trackLog_recording => 'Grabando';

  @override
  String get trackLog_notRecording => 'Sin grabar';

  @override
  String get trackLog_noGps =>
      'Tu radio no informa una posición GPS. El registro de ruta necesita una radio con el GPS activado.';

  @override
  String get trackLog_start => 'Empezar a grabar';

  @override
  String get trackLog_stop => 'Detener grabación';

  @override
  String get trackLog_howItWorks =>
      'Usa la posición que informa tu radio, aproximadamente una vez por minuto, mientras NOTORYX Core está abierta. Se añade un punto al moverte 25 m, o cada 15 minutos si no te mueves.';

  @override
  String get trackLog_snap => 'Redondear posiciones a unos 100 m';

  @override
  String get trackLog_snapBody => 'Por privacidad al compartir una ruta.';

  @override
  String get trackLog_saved => 'Rutas guardadas';

  @override
  String get trackLog_none => 'Aún no hay rutas.';

  @override
  String get trackLog_export => 'Exportar como GPX';

  @override
  String get trackLog_exportFailed => 'No se pudo exportar la ruta.';

  @override
  String get trackLog_deleteTitle => '¿Eliminar esta ruta?';

  @override
  String get trackLog_deleteBody =>
      'Se quita de este dispositivo. Los archivos GPX exportados no se ven afectados.';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km km · $duration · $points puntos';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'Ruta NOTORYX $when';
  }

  @override
  String get routes_nearbyTitle => 'Mejores repetidores cerca';

  @override
  String get routes_nearbyEmptyTitle => 'Aún no se ha oído ningún repetidor';

  @override
  String get routes_nearbyEmpty =>
      'Los repetidores que tu radio oye directamente aparecen aquí, los más fuertes primero, a medida que recibe tráfico. La lista cubre la última hora.';

  @override
  String get routes_unknownRepeater => 'Repetidor desconocido';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'oído $count veces',
      one: 'oído una vez',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'hace $minutes min',
      one: 'hace 1 min',
      zero: 'ahora mismo',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return 'vía $names';
  }

  @override
  String get nav_home => 'Inicio';

  @override
  String get nav_chats => 'Chats';

  @override
  String get nav_tools => 'Herramientas';

  @override
  String get nav_settings => 'Ajustes';

  @override
  String get nav_more => 'Más';

  @override
  String get tools_groupApp => 'App y ajustes';

  @override
  String get tools_groupField => 'En el campo';

  @override
  String get tools_groupMaps => 'Mapas y cobertura';

  @override
  String get tools_groupRouting => 'Rutas y repetidores';

  @override
  String get tools_pathGraph => 'Grafo de rutas';

  @override
  String get tools_pathGraphHint =>
      'Cómo te llegan los mensajes: cada ruta oída, con los repetidores más activos';

  @override
  String get tools_antenna => 'Cobertura de antena';

  @override
  String get tools_antennaHint =>
      'Calcula hasta dónde llega una antena sobre el terreno';

  @override
  String routes_repeaterWithId(String id) {
    return 'Repetidor $id';
  }

  @override
  String get ping_title => 'Ping a repetidor';

  @override
  String get ping_toolSubtitle =>
      'Tiempo de ida y vuelta y señal en ambos sentidos con un repetidor cercano';

  @override
  String get ping_noRepeaters => 'Aún no hay repetidores conocidos';

  @override
  String get ping_choose => 'Elige un repetidor';

  @override
  String get ping_avgMs => 'ms ida y vuelta';

  @override
  String get ping_snrThere => 'SNR allí';

  @override
  String get ping_snrBack => 'SNR de vuelta';

  @override
  String get ping_loss => 'Perdidos';

  @override
  String ping_running(int done, int total) {
    return 'Ping $done de $total…';
  }

  @override
  String ping_start(int count) {
    return 'Hacer ping $count veces';
  }

  @override
  String get ping_results => 'Sondeos';

  @override
  String get ping_noReply => 'Sin respuesta';

  @override
  String ping_resultLine(String ms, String snr) {
    return '$ms ms · SNR allí $snr';
  }

  @override
  String get ping_explainer =>
      'Cada sondeo es un trazado de un salto: el repetidor anota lo bien que te oyó y lo devuelve. Funciona con repetidores que tu radio oye directamente.';

  @override
  String get hunt_title => 'Búsqueda con antena';

  @override
  String get hunt_toolSubtitle =>
      'Medidor de señal grande que hace clic más rápido cuanto más fuerte';

  @override
  String get hunt_noSignal => 'Aún sin señal';

  @override
  String get hunt_noReply => 'Sin respuesta: mueve o gira la antena';

  @override
  String get hunt_heardHere => 'dB oídos aquí';

  @override
  String get hunt_best => 'Mejor';

  @override
  String get hunt_sound => 'Clic según se hace más fuerte';

  @override
  String get hunt_soundHint =>
      'Con vibración en cada clic, para orientar sin mirar.';

  @override
  String get hunt_stop => 'Detener';

  @override
  String get hunt_start => 'Empezar a buscar';

  @override
  String get hunt_explainer =>
      'Sondea el repetidor una vez por segundo. Orienta una antena direccional o camina: el número indica lo bien que lo oye tu radio.';

  @override
  String get settings_refreshRate => 'Frecuencia de actualización';

  @override
  String get settings_refreshFast => 'Rápida';

  @override
  String get settings_refreshNormal => 'Normal';

  @override
  String get settings_refreshSlow => 'Lenta';

  @override
  String get settings_refreshFastHint =>
      'Batería cada minuto, GPS cada 30 s. Datos más recientes, más consumo.';

  @override
  String get settings_refreshNormalHint =>
      'Batería cada 2 minutos, GPS cada minuto.';

  @override
  String get settings_refreshSlowHint =>
      'Batería cada 6 minutos, GPS cada 3. Ahorra batería.';

  @override
  String get settings_refreshSaverOn =>
      'El ahorro de batería está activado y marca el ritmo (batería cada 10 minutos).';
}
