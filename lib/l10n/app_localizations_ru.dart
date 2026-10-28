// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core';

  @override
  String get nav_contacts => 'Контакты';

  @override
  String get nav_channels => 'Каналы';

  @override
  String get nav_map => 'Карта';

  @override
  String get nav_messages => 'Сообщения';

  @override
  String get nav_nodes => 'Узлы';

  @override
  String get nav_radio => 'Радио';

  @override
  String get messages_title => 'Сообщения';

  @override
  String get messages_filterAll => 'Все';

  @override
  String get messages_filterDirect => 'Личные';

  @override
  String get messages_filterChannels => 'Каналы';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'Поиск сообщений';

  @override
  String get messages_searchHint => 'Поиск бесед';

  @override
  String get messages_closeSearch => 'Закрыть поиск';

  @override
  String get messages_manageChannels => 'Управление каналами';

  @override
  String get messages_new => 'Новое';

  @override
  String get messages_newDirect => 'Написать узлу';

  @override
  String get messages_newChannel => 'Добавить канал или вступить';

  @override
  String get messages_empty => 'Пока нет бесед';

  @override
  String get messages_emptyHint =>
      'Здесь появляются сообщения от узлов и каналов.';

  @override
  String get messages_noMatches => 'Нет бесед по вашему запросу';

  @override
  String messages_you(String text) {
    return 'Вы: $text';
  }

  @override
  String get messages_yesterday => 'Вчера';

  @override
  String messages_unreadCount(int count) {
    return 'Непрочитанных: $count';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return 'Подключено через $transport';
  }

  @override
  String get radioStatus_bluetooth => 'Bluetooth';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'Wi‑Fi (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return 'Батарея $percent%';
  }

  @override
  String get radioStatus_openRadio => 'Открыть сведения о радио';

  @override
  String get radioOverview_battery => 'Батарея';

  @override
  String radioOverview_firmware(String version) {
    return 'Прошивка $version';
  }

  @override
  String get radioOverview_sendAdvert => 'Отправить объявление';

  @override
  String get radioOverview_stats => 'Статистика радио';

  @override
  String get accessControl_title => 'Управление доступом';

  @override
  String get accessControl_hubSubtitle => 'Кто может входить без пароля';

  @override
  String get accessControl_explainRepeater =>
      'Люди из этого списка входят без пароля. Администраторы могут менять настройки; «Только чтение» и «Чтение и запись» также получают полную телеметрию.';

  @override
  String get accessControl_explainRoom =>
      'Администраторы из этого списка входят без пароля и могут управлять комнатой. Участники комнаты входят по паролю комнаты.';

  @override
  String get accessControl_roleReadOnly => 'Только чтение';

  @override
  String get accessControl_roleReadWrite => 'Чтение и запись';

  @override
  String get accessControl_roleAdmin => 'Администратор';

  @override
  String get accessControl_you => 'Вы';

  @override
  String get accessControl_unknownNode => 'Неизвестный узел';

  @override
  String get accessControl_add => 'Добавить';

  @override
  String get accessControl_addTitle => 'Добавить в список доступа';

  @override
  String get accessControl_pickContact => 'Выберите контакт';

  @override
  String get accessControl_noContacts =>
      'Нет контактов для добавления. Узлы появляются здесь после того, как вы примете их объявление.';

  @override
  String get accessControl_changeRole => 'Изменить роль';

  @override
  String get accessControl_remove => 'Убрать доступ';

  @override
  String accessControl_removeConfirm(String name) {
    return 'Убрать $name из списка доступа? Для входа понадобится пароль.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'Это вы. Если вы уберёте себя, для управления узлом понадобится пароль администратора.';

  @override
  String get accessControl_unknownKeyNote =>
      'Нет в ваших контактах. Для смены роли нужна более новая прошивка узла; удаление работает всегда.';

  @override
  String get accessControl_prefixUnsupported =>
      'Прошивка этого узла не может изменить роль того, кого нет в ваших контактах. Удалить его всё равно можно.';

  @override
  String get accessControl_empty => 'Список доступа пуст';

  @override
  String get accessControl_emptyHint =>
      'Добавьте людей, чтобы они могли входить без пароля.';

  @override
  String get accessControl_loading => 'Запрашиваем список доступа у узла…';

  @override
  String get accessControl_timeout =>
      'Узел не ответил. Проверьте маршрут и попробуйте снова.';

  @override
  String get accessControl_maybeIncomplete =>
      'Узел прислал одну полную страницу, а его прошивка не может прислать больше, поэтому некоторые записи могут отсутствовать.';

  @override
  String get accessControl_saved => 'Список доступа обновлён';

  @override
  String accessControl_failed(String reply) {
    return 'Узел отклонил изменение: $reply';
  }

  @override
  String get companionCli_title => 'Командная строка';

  @override
  String get companionCli_tileSubtitle => 'Выполнять команды на радио';

  @override
  String get companionCli_warning =>
      'Команды выполняются на подключённом радио и могут изменить его настройки или перезагрузить его.';

  @override
  String get companionCli_hint => 'Введите команду, например ver';

  @override
  String get companionCli_send => 'Выполнить команду';

  @override
  String get companionCli_noReply =>
      'Нет ответа. Возможно, радио перезагружается.';

  @override
  String get companionCli_empty =>
      'Попробуйте одну из команд выше или введите свою.';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle => 'Подключить радио к сети Wi‑Fi';

  @override
  String get wifi_unsupported => 'Прошивка этого радио не поддерживает Wi‑Fi.';

  @override
  String get wifi_enabled => 'Использовать Wi‑Fi';

  @override
  String get wifi_status => 'Состояние';

  @override
  String get wifi_connected => 'Подключено';

  @override
  String wifi_connectedIp(String ip) {
    return 'Подключено · $ip';
  }

  @override
  String get wifi_disconnected => 'Не подключено';

  @override
  String get wifi_network => 'Имя сети (SSID)';

  @override
  String get wifi_password => 'Пароль';

  @override
  String get wifi_passwordKeep =>
      'Оставьте пустым, чтобы сохранить текущий пароль';

  @override
  String get wifi_save => 'Сохранить';

  @override
  String get wifi_forget => 'Забыть сеть';

  @override
  String get wifi_forgetConfirm =>
      'Удалить сохранённую сеть и пароль из радио?';

  @override
  String get wifi_rebootNeeded =>
      'Сохранено. Перезагрузите радио, чтобы применить изменения Wi‑Fi.';

  @override
  String get wifi_rebootNow => 'Перезагрузить радио';

  @override
  String get wifi_rebootConfirm =>
      'Перезагрузить радио сейчас? Приложение отключится, и нужно будет подключиться снова.';

  @override
  String get wifi_loadFailed =>
      'Не удалось прочитать настройки Wi‑Fi из радио.';

  @override
  String get wifi_retry => 'Повторить';

  @override
  String wifi_saveFailed(String reply) {
    return 'Радио не приняло изменение: $reply';
  }

  @override
  String get accessControl_refresh => 'Обновить';

  @override
  String get common_cancel => 'Отмена';

  @override
  String get common_ok => 'OK';

  @override
  String get common_connect => 'Коннект';

  @override
  String get common_unknownDevice => 'Неизвестное устройство';

  @override
  String get common_save => 'Сохранить';

  @override
  String get common_delete => 'Удалить';

  @override
  String get common_deleteAll => 'Удалить все';

  @override
  String get common_close => 'Закрыть';

  @override
  String get common_done => 'Готово';

  @override
  String get common_edit => 'Изменить';

  @override
  String get common_add => 'Добавить';

  @override
  String get common_settings => 'Настройки';

  @override
  String get common_disconnect => 'Отключить';

  @override
  String get common_connected => 'Подключено';

  @override
  String get common_disconnected => 'Отключено';

  @override
  String get common_create => 'Создать';

  @override
  String get common_continue => 'Продолжить';

  @override
  String get common_share => 'Поделиться';

  @override
  String get common_copy => 'Копировать';

  @override
  String get common_retry => 'Повторить';

  @override
  String get common_hide => 'Скрыть';

  @override
  String get common_remove => 'Убрать';

  @override
  String get common_enable => 'Включить';

  @override
  String get common_disable => 'Выключить';

  @override
  String get common_undo => 'Отменить';

  @override
  String get messageStatus_sent => 'Отправлено';

  @override
  String get messageStatus_delivered => 'Доставлено';

  @override
  String get messageStatus_pending => 'Отправка';

  @override
  String get messageStatus_failed => 'Не удалось отправить';

  @override
  String get messageStatus_repeated => 'Услышал несколько раз';

  @override
  String get urlImage_enable => 'Включить изображения по URL';

  @override
  String get urlImage_possible =>
      'Возможно, изображение по URL; включите это в Настройках.';

  @override
  String get common_reboot => 'Перезагрузить';

  @override
  String get common_loading => 'Загрузка...';

  @override
  String get common_notAvailable => '—';

  @override
  String common_voltageValue(String volts) {
    return '$volts В';
  }

  @override
  String common_percentValue(int percent) {
    return '$percent%';
  }

  @override
  String get common_autoRefresh => 'Автообновление';

  @override
  String get common_interval => 'Интервал';

  @override
  String get scanner_title => 'NOTORYX Core';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'Установить соединение по протоколу TCP';

  @override
  String get tcpHostLabel => 'IP-адрес';

  @override
  String get tcpHostHint => '192.168.40.10';

  @override
  String get tcpPortLabel => 'Порт';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => 'Введите адрес и подключитесь.';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return 'Подключение к $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => 'Необходимо указать IP-адрес.';

  @override
  String get tcpErrorPortInvalid =>
      'Порт должен находиться в диапазоне от 1 до 65535.';

  @override
  String get tcpErrorUnsupported =>
      'Протокол TCP не поддерживается на этой платформе.';

  @override
  String get tcpErrorTimedOut => 'Соединение TCP не удалось установить.';

  @override
  String tcpConnectionFailed(String error) {
    return 'Не удалось установить соединение TCP: $error';
  }

  @override
  String get usbScreenTitle => 'Подключение через USB';

  @override
  String get usbScreenSubtitle =>
      'Выберите обнаруженное устройство с последовательным интерфейсом и подключите его напрямую к вашему узлу MeshCore.';

  @override
  String get usbScreenStatus => 'Выберите USB-устройство';

  @override
  String get usbScreenNote =>
      'USB-серийный порт активен на поддерживаемых устройствах Android и на настольных платформах.';

  @override
  String get usbScreenEmptyState =>
      'Не обнаружено устройств USB. Подключите одно из них и обновите список.';

  @override
  String get usbErrorPermissionDenied =>
      'Запрос на доступ через USB был отклонен.';

  @override
  String get usbErrorDeviceMissing =>
      'Выбранное USB-устройство больше недоступно.';

  @override
  String get usbErrorInvalidPort => 'Выберите действительное USB-устройство.';

  @override
  String get usbErrorBusy =>
      'Еще одно запрошенное соединение через USB уже находится в процессе.';

  @override
  String get usbErrorNotConnected => 'Ни одно USB-устройство не подключено.';

  @override
  String get usbErrorOpenFailed =>
      'Не удалось открыть выбранное USB-устройство.';

  @override
  String get usbErrorConnectFailed =>
      'Не удалось установить соединение с выбранным USB-устройством.';

  @override
  String get usbErrorUnsupported =>
      'Поддержка последовательного USB отсутствует на данной платформе.';

  @override
  String get usbErrorAlreadyActive => 'USB-соединение уже установлено.';

  @override
  String get usbErrorNoDeviceSelected =>
      'Не было выбрано ни одно устройство USB.';

  @override
  String get usbErrorPortClosed => 'USB-соединение не установлено.';

  @override
  String get usbErrorConnectTimedOut =>
      'Соединение не установлено. Убедитесь, что устройство имеет установленное программное обеспечение USB Companion.';

  @override
  String get usbFallbackDeviceName =>
      'Устройство для последовательного подключения к сети';

  @override
  String get usbStatus_notConnected => 'Выберите USB-устройство';

  @override
  String get usbStatus_connecting => 'Подключение к USB-устройству...';

  @override
  String get usbStatus_searching => 'Поиск USB-устройств...';

  @override
  String usbConnectionFailed(String error) {
    return 'Не удалось установить соединение через USB: $error';
  }

  @override
  String get scanner_scanning => 'Поиск устройств...';

  @override
  String get scanner_connecting => 'Подключение...';

  @override
  String get scanner_disconnecting => 'Отключение...';

  @override
  String get scanner_notConnected => 'Не подключено';

  @override
  String scanner_connectedTo(String deviceName) {
    return 'Подключено к $deviceName';
  }

  @override
  String get scanner_searchingDevices => 'Поиск устройств MeshCore...';

  @override
  String get scanner_tapToScan => 'Нажмите для поиска MeshCore устройств';

  @override
  String scanner_connectionFailed(String error) {
    return 'Подключение не удалось: $error';
  }

  @override
  String get scanner_stop => 'Стоп';

  @override
  String get scanner_scan => 'Сканирование';

  @override
  String get scanner_bluetoothOff => 'Bluetooth выключен';

  @override
  String get scanner_bluetoothOffMessage =>
      'Пожалуйста, включите Bluetooth, чтобы найти устройства.';

  @override
  String get scanner_chromeRequired => 'Требуется браузер Chrome';

  @override
  String get scanner_chromeRequiredMessage =>
      'Для поддержки Bluetooth в этом веб-приложении требуется Google Chrome или браузер на базе Chromium.';

  @override
  String get scanner_enableBluetooth => 'Включите Bluetooth';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'Bluetooth недоступен в браузере. Подключитесь через USB.';

  @override
  String get device_quickSwitch => 'Быстрое переключение';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => 'Настройки';

  @override
  String get settings_deviceInfo => 'Информация об устройстве';

  @override
  String get settings_appSettings => 'Настройки приложения';

  @override
  String get settings_appSettingsSubtitle =>
      'Уведомления, сообщения и настройки карты';

  @override
  String get settings_nodeSettings => 'Настройки ноды';

  @override
  String get settings_nodeName => 'Имя ноды';

  @override
  String get settings_nodeNameNotSet => 'Не установлено';

  @override
  String get settings_nodeNameHint => 'Введите имя ноды';

  @override
  String get settings_nodeNameUpdated => 'Имя обновлено';

  @override
  String get settings_radioSettings => 'Настройки радио';

  @override
  String get settings_radioSettingsSubtitle =>
      'Частота, мощность и коэффициент распространения';

  @override
  String get settings_radioSettingsUpdated => 'Настройки радио обновлены';

  @override
  String get settings_regionSettings => 'Регионы';

  @override
  String get settings_regionSettingsSubtitle =>
      'Управление сохранёнными регионами';

  @override
  String get settings_corridorRegion => 'Регион коридора';

  @override
  String get settings_corridorRegionDefault => '#corridor (по умолчанию)';

  @override
  String get settings_corridorRegionHelp =>
      'Пакеты flood-коридора помечаются этим регионом. Репитеры без прошивки коридоров пересылают их, только если разрешают этот регион. Оставьте пустым для метки по умолчанию #corridor.';

  @override
  String get settings_corridorRegionHint => 'Название региона';

  @override
  String get settings_corridorRegionUseDefault => 'По умолчанию';

  @override
  String get settings_corridorRegionUpdated => 'Регион коридора обновлён';

  @override
  String get settings_corridorRegionFailed =>
      'Не удалось обновить регион коридора';

  @override
  String get settings_regionManagement_screenTitle => 'Управление регионами';

  @override
  String get settings_regionNameHint => 'Введите название региона';

  @override
  String get settings_regionAddRegion => 'Добавить регион';

  @override
  String get settings_regionFetchRegions =>
      'Извлекать регионы с ретрансляторов';

  @override
  String get settings_regionFetchRegionsFail =>
      'Не были найдены никакие регионы';

  @override
  String get settings_regionFetchRegionsAlreadyExists =>
      'Этот регион уже был добавлен';

  @override
  String get settings_regionName => 'Название региона';

  @override
  String get settings_regionDeleted => 'Регион удалён';

  @override
  String get settings_deleteRegion => 'Удалить регион';

  @override
  String settings_deleteRegionConfirm(String region) {
    return 'Удалить \"$region\" из списка регионов?';
  }

  @override
  String get settings_location => 'Позиция';

  @override
  String get settings_locationSubtitle => 'Координаты GPS';

  @override
  String get settings_locationUpdated => 'Позиция и настройки GPS обновлены';

  @override
  String get settings_locationBothRequired => 'Введите широту и долготу.';

  @override
  String get settings_locationInvalid => 'Неверная широта или долгота.';

  @override
  String get settings_locationGPSEnable => 'Включить GPS';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'Включение GPS для автоматического обновления позиции.';

  @override
  String get settings_locationIntervalSec =>
      'Интервал для позиционирования GPS (секунды)';

  @override
  String get settings_locationIntervalInvalid =>
      'Интервал должен составлять не менее 60 секунд и не более 86400 секунд.';

  @override
  String get settings_latitude => 'Широта';

  @override
  String get settings_longitude => 'Долгота';

  @override
  String get settings_contactSettings => 'Настройки контактов';

  @override
  String get settings_contactSettingsSubtitle =>
      'Настройки добавления контактов';

  @override
  String get settings_privacyMode => 'Режим конфиденциальности';

  @override
  String get settings_privacyModeSubtitle =>
      'Скрыть имя/позицию в анонсировании';

  @override
  String get settings_privacyModeToggle =>
      'Включите режим конфиденциальности, чтобы скрыть свое имя и местоположение в анонсировании.';

  @override
  String get settings_privacyModeEnabled => 'Режим конфиденциальности включен';

  @override
  String get settings_privacyModeDisabled =>
      'Режим конфиденциальности выключен';

  @override
  String get settings_privacy => 'Настройки конфиденциальности';

  @override
  String get settings_privacySubtitle =>
      'Контролируйте, какую информацию делиться.';

  @override
  String get settings_privacySettingsDescription =>
      'Выберите, какую информацию ваше устройство будет делиться с другими.';

  @override
  String get settings_denyAll => 'Отклонить все';

  @override
  String get settings_allowByContact => 'Разрешить по флагам контактов';

  @override
  String get settings_allowAll => 'Разрешить все';

  @override
  String get settings_telemetryBaseMode => 'Базовый режим телеметрии';

  @override
  String get settings_telemetryLocationMode =>
      'Режим местоположения телеметрии';

  @override
  String get settings_telemetryEnvironmentMode => 'Режим среды телеметрии';

  @override
  String get settings_advertLocation => 'Местоположение рекламы';

  @override
  String get settings_advertLocationSubtitle =>
      'Включить местоположение в объявление';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'Авто-объявление без хопов при обновлении GPS';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'Когда GPS-местоположение меняется, отправлять объявление без хопов (требуется геопозиция в объявлении).';

  @override
  String get settings_multiAck => 'Несколько подтверждений';

  @override
  String get settings_telemetryModeUpdated => 'Режим телеметрии обновлен';

  @override
  String get settings_actions => 'Действия';

  @override
  String get settings_deleteAllPaths => 'Delete All Paths';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Clear all path data from contacts.';

  @override
  String get settings_sendAdvertisement => 'Отправить анонсирование';

  @override
  String get settings_sendAdvertisementSubtitle =>
      'Отправить анонсирование о присутствии сейчас';

  @override
  String get settings_advertisementSent => 'Анонсирование отправлено';

  @override
  String get settings_syncTime => 'Синхронизация времени';

  @override
  String get settings_syncTimeSubtitle => 'Синхронизировать время с телефоном';

  @override
  String get settings_timeSynchronized => 'Время синхронизировано';

  @override
  String get settings_refreshContacts => 'Обновить контакты';

  @override
  String get settings_refreshContactsSubtitle =>
      'Перезагрузить список контактов с устройства';

  @override
  String get settings_rebootDevice => 'Перезагрузить устройство';

  @override
  String get settings_rebootDeviceSubtitle =>
      'Перезапустить устройство MeshCore';

  @override
  String get settings_rebootDeviceConfirm =>
      'Вы уверены, что хотите перезагрузить устройство? Вы будете отключены.';

  @override
  String get settings_debug => 'Отладка';

  @override
  String get settings_companionDebugLog =>
      'Журнал отладки (для сопутствующего приложения)';

  @override
  String get settings_companionDebugLogSubtitle =>
      'Команды, ответы и необработанные данные, используемые для протоколов BLE, TCP и USB.';

  @override
  String get settings_appDebugLog => 'Журнал отладки приложения';

  @override
  String get settings_appDebugLogSubtitle => 'Сообщения отладки приложения';

  @override
  String get settings_about => 'О программе';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core v$version';
  }

  @override
  String get settings_aboutLegalese => '2026 MeshCore Open Source Project';

  @override
  String get settings_aboutDescription =>
      'Открытое клиентское приложение на Flutter для устройств MeshCore с LoRa-сетями.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'Данные о высоте LOS: Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => 'Имя';

  @override
  String get settings_infoId => 'ID';

  @override
  String get settings_infoStatus => 'Статус';

  @override
  String get settings_infoBattery => 'Батарея';

  @override
  String get settings_infoPublicKey => 'Публичный ключ';

  @override
  String get settings_infoContactsCount => 'Количество контактов';

  @override
  String get settings_infoChannelCount => 'Количество каналов';

  @override
  String get settings_infoHardware => 'Оборудование';

  @override
  String get settings_infoFirmware =>
      'Производственное программное обеспечение';

  @override
  String get settings_presets => 'Пресеты';

  @override
  String get settings_frequency => 'Частота (МГц)';

  @override
  String get settings_frequencyHelper => '300.0 – 2500.0';

  @override
  String get settings_frequencyInvalid => 'Недопустимая частота (300–2500 МГц)';

  @override
  String get settings_bandwidth => 'Полоса пропускания';

  @override
  String get settings_spreadingFactor => 'Коэффициент расширения';

  @override
  String get settings_codingRate => 'Коэффициент кодирования';

  @override
  String get settings_txPower => 'Мощность передачи (дБм)';

  @override
  String get settings_txPowerHelper => '0 – 22';

  @override
  String get settings_txPowerInvalid =>
      'Недопустимая мощность передачи (0–22 дБм)';

  @override
  String get settings_clientRepeat => 'Повторение \"вне сети\"';

  @override
  String get settings_clientRepeatSubtitle =>
      'Позвольте этому устройству повторять пакеты данных для других устройств.';

  @override
  String get settings_clientRepeatFreqWarning =>
      'Для работы в режиме \"без подключения к сети\" требуется частота 433, 869 или 918 МГц.';

  @override
  String settings_error(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get appSettings_title => 'Настройки приложения';

  @override
  String get appSettings_appearance => 'Внешний вид';

  @override
  String get appSettings_theme => 'Тема';

  @override
  String get appSettings_themeSystem => 'Как в системе';

  @override
  String get appSettings_themeLight => 'Светлая';

  @override
  String get appSettings_themeDark => 'Тёмная';

  @override
  String get appSettings_language => 'Язык';

  @override
  String get appSettings_languageSystem => 'Как в системе';

  @override
  String get appSettings_languageEn => 'Английский';

  @override
  String get appSettings_languageFr => 'Французский';

  @override
  String get appSettings_languageEs => 'Испанский';

  @override
  String get appSettings_languageDe => 'Немецкий';

  @override
  String get appSettings_languagePl => 'Польский';

  @override
  String get appSettings_languageSl => 'Словенский';

  @override
  String get appSettings_languagePt => 'Португальский';

  @override
  String get appSettings_languageIt => 'Итальянский';

  @override
  String get appSettings_languageZh => 'Китайский';

  @override
  String get appSettings_languageSv => 'Шведский';

  @override
  String get appSettings_languageNl => 'Нидерландский';

  @override
  String get appSettings_languageSk => 'Словацкий';

  @override
  String get appSettings_languageBg => 'Болгарский';

  @override
  String get appSettings_languageRu => 'Русский';

  @override
  String get appSettings_languageUk => 'Українська';

  @override
  String get repeater_pathHashModeOption0 => '0 - 1 байт';

  @override
  String get repeater_pathHashModeOption1 => '1 - 2 байта';

  @override
  String get repeater_pathHashModeOption2 => '2 - 3 байта';

  @override
  String get repeater_pathHashModeOption3 => '3 - 4 байта';

  @override
  String get appSettings_enableMessageTracing =>
      'Включить трассировку сообщений';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'Показывать подробные метаданные о маршрутизации и времени для сообщений';

  @override
  String get appSettings_notifications => 'Уведомления';

  @override
  String get appSettings_enableNotifications => 'Включить уведомления';

  @override
  String get appSettings_enableNotificationsSubtitle =>
      'Получать уведомления о сообщениях и оповещениях';

  @override
  String get appSettings_notificationPermissionDenied =>
      'Разрешение на уведомления отклонено';

  @override
  String get appSettings_notificationsEnabled => 'Уведомления включены';

  @override
  String get appSettings_notificationsDisabled => 'Уведомления отключены';

  @override
  String get appSettings_messageNotifications => 'Уведомления о сообщениях';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      'Показывать уведомление при получении новых сообщений';

  @override
  String get appSettings_channelMessageNotifications =>
      'Уведомления о сообщениях в каналах';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'Показывать уведомление при получении сообщений в каналах';

  @override
  String get appSettings_advertisementNotifications =>
      'Уведомления об анонсированиях';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      'Показывать уведомление при обнаружении новых нод';

  @override
  String get appSettings_messaging => 'Обмен сообщениями';

  @override
  String get appSettings_clearPathOnMaxRetry =>
      'Сбросить маршрут после максимального числа попыток';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      'Сбросить маршрут контакта после 5 неудачных попыток отправки';

  @override
  String get appSettings_pathsWillBeCleared =>
      'Маршруты будут сброшены после 5 неудачных попыток';

  @override
  String get appSettings_pathsWillNotBeCleared =>
      'Маршруты не будут автоматически сбрасываться';

  @override
  String get appSettings_autoRouteRotation =>
      'Автоматическое переключение маршрутов';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      'Циклически переключаться между лучшими маршрутами и режимом рассылки';

  @override
  String get appSettings_autoRouteRotationEnabled =>
      'Автоматическое переключение маршрутов включено';

  @override
  String get appSettings_autoRouteRotationDisabled =>
      'Автоматическое переключение маршрутов отключено';

  @override
  String get appSettings_maxRouteWeight =>
      'Максимальный допустимый вес маршрута';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      'Максимальный вес, который может быть перевезён по определённому маршруту при успешных доставках.';

  @override
  String get appSettings_initialRouteWeight => 'Начальный вес маршрута';

  @override
  String get appSettings_initialRouteWeightSubtitle =>
      'Начальный вес для новых, только что открытых маршрутов';

  @override
  String get appSettings_routeWeightSuccessIncrement =>
      'Увеличение веса успеха';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      'Вес, добавленный к маршруту после успешной доставки.';

  @override
  String get appSettings_routeWeightFailureDecrement =>
      'Уменьшение веса неудачи';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      'Вес, который был удален с пути после неудачной доставки.';

  @override
  String get appSettings_maxMessageRetries =>
      'Максимальное количество повторных попыток отправки сообщения';

  @override
  String get appSettings_maxMessageRetriesSubtitle =>
      'Количество попыток повторной отправки сообщения перед тем, как пометить его как неудачное.';

  @override
  String get appSettings_battery => 'Батарея';

  @override
  String get appSettings_batteryChemistry => 'Химия батареи';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return 'Установить для устройства ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      'Подключитесь к устройству, чтобы выбрать';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3.0–4.2 В)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2.6–3.65 В)';

  @override
  String get appSettings_batteryLipo => 'LiPo (3.0–4.2 В)';

  @override
  String get appSettings_batteryLipoHv => 'LiPo HV (3,0–4,35 В)';

  @override
  String get appSettings_mapDisplay => 'Отображение карты';

  @override
  String get appSettings_showRepeaters => 'Показывать репитеры';

  @override
  String get appSettings_showRepeatersSubtitle =>
      'Отображать репитеры на карте';

  @override
  String get appSettings_showChatNodes => 'Показывать чат-ноды';

  @override
  String get appSettings_showChatNodesSubtitle =>
      'Отображать чат-ноды на карте';

  @override
  String get appSettings_showOtherNodes => 'Показывать другие ноды';

  @override
  String get appSettings_showOtherNodesSubtitle =>
      'Отображать другие типы нод на карте';

  @override
  String get appSettings_timeFilter => 'Фильтр по времени';

  @override
  String get appSettings_timeFilterShowAll => 'Показывать все ноды';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return 'Показывать ноды за последние $hours ч';
  }

  @override
  String get appSettings_mapTimeFilter => 'Временной фильтр карты';

  @override
  String get appSettings_showNodesDiscoveredWithin =>
      'Показывать ноды, обнаруженные за:';

  @override
  String get appSettings_allTime => 'Всё время';

  @override
  String get appSettings_lastHour => 'Последний час';

  @override
  String get appSettings_last6Hours => 'Последние 6 часов';

  @override
  String get appSettings_last24Hours => 'Последние 24 часа';

  @override
  String get appSettings_lastWeek => 'Последнюю неделю';

  @override
  String get appSettings_rasterTileSource => 'Источник растровых тайлов';

  @override
  String get appSettings_stadiaEndpoint => 'Конечная точка Stadia';

  @override
  String get appSettings_stadiaApiKey => 'Ключ API Stadia';

  @override
  String get appSettings_stadiaApiKeyRequired =>
      'Требуется для использования Stadia Maps';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return 'Настроено: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Введите свой ключ API Stadia Maps. Приложение использует его для запросов растровых тайлов.';

  @override
  String get appSettings_offlineMapCache => 'Кэш офлайн-карты';

  @override
  String get appSettings_unitsTitle => 'Единицы';

  @override
  String get appSettings_unitsMetric => 'Метрическая (м/км)';

  @override
  String get appSettings_unitsImperial => 'Имперская (ft / mi)';

  @override
  String get appSettings_noAreaSelected => 'Область не выбрана';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'Область выбрана (масштаб $minZoom–$maxZoom)';
  }

  @override
  String get appSettings_debugCard => 'Отладка';

  @override
  String get appSettings_appDebugLogging => 'Журнал отладки приложения';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'Записывать отладочные сообщения приложения для диагностики';

  @override
  String get appSettings_appDebugLoggingEnabled =>
      'Журнал отладки приложения включён';

  @override
  String get appSettings_appDebugLoggingDisabled =>
      'Журнал отладки приложения отключён';

  @override
  String get contacts_title => 'Контакты';

  @override
  String get contacts_noContacts => 'Контактов пока нет';

  @override
  String get contacts_contactsWillAppear =>
      'Контакты появятся, когда устройства начнут рассылать оповещения';

  @override
  String get contacts_unread => 'Непрочитанное';

  @override
  String get contacts_searchContactsNoNumber => 'Поиск контактов...';

  @override
  String contacts_searchContacts(int number, String str) {
    return 'Поиск контактов...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'Поиск $number$str избранного...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'Поиск $number$str пользователей...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'Поиск $number$str ретрансляторов...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'Поиск $number$str серверов комнат...';
  }

  @override
  String get contacts_noUnreadContacts => 'Нет непрочитанных контактов';

  @override
  String get contacts_noContactsFound => 'Контакты или группы не найдены';

  @override
  String get contacts_deleteContact => 'Удалить контакт';

  @override
  String contacts_removeConfirm(String contactName) {
    return 'Удалить $contactName из контактов?';
  }

  @override
  String get contacts_manageRepeater => 'Управление репитером';

  @override
  String get contacts_manageRoom => 'Управление сервером комнат';

  @override
  String get contacts_roomLogin => 'Вход на сервер комнат';

  @override
  String get contacts_openChat => 'Открыть чат';

  @override
  String get contacts_editGroup => 'Изменить группу';

  @override
  String get contacts_deleteGroup => 'Удалить группу';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return 'Удалить \"$groupName\"?';
  }

  @override
  String get contacts_newGroup => 'Новая группа';

  @override
  String get contacts_moreOptions => 'Больше вариантов';

  @override
  String get contacts_searchOpen => 'Найти контакты';

  @override
  String get contacts_searchClose => 'Закрыть поиск';

  @override
  String get contacts_groupName => 'Имя группы';

  @override
  String get contacts_groupNameRequired => 'Имя группы обязательно';

  @override
  String get contacts_groupNameReserved => 'Это имя группы зарезервировано';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'Группа \"$name\" уже существует';
  }

  @override
  String get contacts_filterContacts => 'Фильтр контактов...';

  @override
  String get contacts_noContactsMatchFilter =>
      'Нет контактов, соответствующих фильтру';

  @override
  String get contacts_noMembers => 'Нет участников';

  @override
  String get contacts_lastSeenNow => 'Видели только что';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return 'Видели $minutes мин назад';
  }

  @override
  String get contacts_lastSeenHourAgo => 'Видели 1 час назад';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return 'Видели $hours ч назад';
  }

  @override
  String get contacts_lastSeenDayAgo => 'Видели 1 день назад';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return 'Видели $days дн. назад';
  }

  @override
  String get contact_info => 'Контактная информация';

  @override
  String get contact_settings => 'Настройки контактов';

  @override
  String get contact_telemetry => 'Телеметрия';

  @override
  String get contact_lastSeen => 'Последний раз видели';

  @override
  String get contact_clearChat => 'Очистить чат';

  @override
  String get contact_teleBase => 'База телеметрии';

  @override
  String get contact_teleBaseSubtitle =>
      'Разрешить обмен уровнем заряда батареи и базовой телеметрией';

  @override
  String get contact_teleLoc => 'Местоположение телеметрии';

  @override
  String get contact_teleLocSubtitle =>
      'Разрешить обмен данными о местоположении';

  @override
  String get contact_teleEnv => 'Среда телеметрии';

  @override
  String get contact_teleEnvSubtitle =>
      'Разрешить обмен данными датчиков окружающей среды';

  @override
  String get channels_title => 'Каналы';

  @override
  String get channels_noChannelsConfigured => 'Каналы не настроены';

  @override
  String get channels_addPublicChannel => 'Добавить публичный канал';

  @override
  String get channels_searchChannels => 'Поиск каналов...';

  @override
  String get channels_noChannelsFound => 'Каналы не найдены';

  @override
  String channels_channelIndex(int index) {
    return 'Канал $index';
  }

  @override
  String get channels_public => 'Публичный';

  @override
  String channels_via(String path) {
    return 'через $path';
  }

  @override
  String get channels_viaMqtt => 'через MQTT';

  @override
  String get channels_viaMqttSemantics =>
      'Получено через MQTT, ваше радио его не слышало';

  @override
  String get channels_private => 'Приватный';

  @override
  String get channels_editChannel => 'Изменить канал';

  @override
  String get channels_muteChannel => 'Отключить уведомления канала';

  @override
  String get channels_unmuteChannel => 'Включить уведомления канала';

  @override
  String get channels_deleteChannel => 'Удалить канал';

  @override
  String channels_deleteChannelConfirm(String name) {
    return 'Удалить \"$name\"? Это действие нельзя отменить.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'Не удалось удалить канал $name.';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'Канал \"$name\" удалён';
  }

  @override
  String get channels_addChannel => 'Добавить канал';

  @override
  String get channels_channelIndexLabel => 'Индекс канала';

  @override
  String get channels_channelName => 'Имя канала';

  @override
  String get channels_usePublicChannel => 'Использовать публичный канал';

  @override
  String get channels_standardPublicPsk => 'Стандартный публичный PSK';

  @override
  String get channels_pskHex => 'PSK (Hex)';

  @override
  String get channels_generateRandomPsk => 'Сгенерировать случайный PSK';

  @override
  String get channels_enterChannelName => 'Введите имя канала';

  @override
  String get channels_pskMustBe32Hex =>
      'PSK должен содержать 32 шестнадцатеричных символа';

  @override
  String channels_channelAdded(String name) {
    return 'Канал \"$name\" добавлен';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'Изменить канал $index';
  }

  @override
  String get channels_smazCompression => 'Сжатие SMAZ';

  @override
  String get channels_cyr2latCompression => 'Сжатие Cyr2Lat';

  @override
  String get channels_cyr2latCompressionDscr =>
      'Заменяет некоторые кириллические символы на латиницу при отправке.';

  @override
  String get channels_cyr2latSettingsHeading => 'Настройка Cyr2Lat';

  @override
  String get channels_cyr2latSettingsSubheading => 'Список замен';

  @override
  String get channels_cyr2latSettingsDscr =>
      'Редактировать JSON-конфигурацию замены символов';

  @override
  String get channels_cyr2latSettingsDialogHint => 'JSON-карта замен';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'Некорректный JSON: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'Канал \"$name\" обновлён';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Добавить профиль Cyr2Lat';

  @override
  String get settings_cyr2latProfileName => 'Название профиля';

  @override
  String get settings_cyr2latProfileNameEmpty =>
      'Название профиля не может быть пустым';

  @override
  String get settings_cyr2latProfileAdded => 'Профиль добавлен';

  @override
  String get settings_cyr2latProfileUpdated => 'Профиль успешно обновлен';

  @override
  String get settings_cyr2latProfileEdit => 'Редактировать профиль Cyr2Lat';

  @override
  String get settings_cyr2latProfileDelete => 'Удалить профиль Cyr2Lat';

  @override
  String get settings_cyr2latProfileDeleted => 'Профиль успешно удален';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return 'Вы действительно хотите удалить профиль \"$name\"?';
  }

  @override
  String get channels_publicChannelAdded => 'Публичный канал добавлен';

  @override
  String get channels_sortBy => 'Сортировка';

  @override
  String get channels_sortManual => 'Вручную';

  @override
  String get channels_sortAZ => 'По алфавиту';

  @override
  String get channels_sortLatestMessages => 'По последним сообщениям';

  @override
  String get channels_sortUnread => 'По непрочитанным';

  @override
  String get channels_createPrivateChannel => 'Создать приватный канал';

  @override
  String get channels_createPrivateChannelDesc => 'Защищён секретным ключом.';

  @override
  String get channels_joinPrivateChannel =>
      'Присоединиться к приватному каналу';

  @override
  String get channels_joinPrivateChannelDesc =>
      'Введите секретный ключ вручную.';

  @override
  String get channels_joinPublicChannel => 'Присоединиться к публичному каналу';

  @override
  String get channels_joinPublicChannelDesc =>
      'К этому каналу может присоединиться любой.';

  @override
  String get channels_joinHashtagChannel => 'Присоединиться к хэштег-каналу';

  @override
  String get channels_joinHashtagChannelDesc =>
      'К хэштег-каналам может присоединиться любой.';

  @override
  String get channels_scanQrCode => 'Сканировать QR-код';

  @override
  String get channels_scanQrCodeComingSoon => 'Скоро будет';

  @override
  String get channels_enterHashtag => 'Введите хэштег';

  @override
  String get channels_hashtagHint => 'например, #команда';

  @override
  String channels_regionSetTo(String region) {
    return 'РЕГИОН: $region';
  }

  @override
  String get channels_regionNotSet => 'Регион: отсутствует';

  @override
  String get channels_regionSelect_Title => 'Выберите регион';

  @override
  String get channels_clearRegion => 'Чистый регион';

  @override
  String get chat_noMessages => 'Сообщений пока нет';

  @override
  String get chat_sendMessage => 'Отправить сообщение';

  @override
  String chat_sendMessageTo(String contactName) {
    return 'Отправить сообщение $contactName';
  }

  @override
  String get chat_sendMessageToStart => 'Отправьте сообщение, чтобы начать';

  @override
  String get chat_originalMessageNotFound => 'Исходное сообщение не найдено';

  @override
  String chat_replyingTo(String name) {
    return 'Ответ для $name';
  }

  @override
  String chat_replyTo(String name) {
    return 'Ответить $name';
  }

  @override
  String get chat_location => 'Местоположение';

  @override
  String get chat_typeMessage => 'Напишите сообщение...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'Сообщение слишком длинное (макс. $maxBytes байт).';
  }

  @override
  String get chat_messageCopied => 'Сообщение скопировано';

  @override
  String get chat_messageDeleted => 'Сообщение удалено';

  @override
  String get chat_retryingMessage => 'Повтор отправки сообщения';

  @override
  String chat_retryCount(int current, int max) {
    return 'Попытка $current/$max';
  }

  @override
  String get chat_selectSendAction => 'Выберите действие отправки';

  @override
  String get chat_sendGif => 'Отправить GIF';

  @override
  String get chat_limitToArea => 'Ограничить областью';

  @override
  String get chat_limitToAreaTitle => 'Отправлять только в пределах…';

  @override
  String get chat_limitToAreaHelp =>
      'Репитеры с прошивкой flood-коридоров передают сообщение только внутри этой области. Остальные репитеры отбрасывают его, если не разрешают ваш регион коридора.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '$km км от вас';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return 'Только в радиусе $km км от вас';
  }

  @override
  String get chat_limitToAreaOff => 'Без ограничения';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'Укажите координаты радио, чтобы ограничивать сообщения областью.';

  @override
  String get chat_sendImageLora => 'Отправить изображение через MeshCore';

  @override
  String get chat_imagePickFailed => 'Не удалось открыть это изображение';

  @override
  String get chat_receivedGif => 'Получен GIF';

  @override
  String get chat_reply => 'Ответить';

  @override
  String get chat_addReaction => 'Добавить реакцию';

  @override
  String get chat_me => 'Я';

  @override
  String get reaction_report => 'Реакции эмодзи';

  @override
  String get emojiCategorySmileys => 'Смайлы';

  @override
  String get emojiCategoryGestures => 'Жесты';

  @override
  String get emojiCategoryHearts => 'Сердечки';

  @override
  String get emojiCategoryObjects => 'Предметы';

  @override
  String get gifPicker_title => 'Выберите GIF';

  @override
  String get gifPicker_searchHint => 'Поиск GIF...';

  @override
  String get gifPicker_poweredBy => 'Работает на GIPHY';

  @override
  String get gifPicker_noGifsFound => 'GIF не найдены';

  @override
  String get gifPicker_failedLoad => 'Не удалось загрузить GIF';

  @override
  String get gifPicker_failedSearch => 'Не удалось выполнить поиск GIF';

  @override
  String get gifPicker_noInternet => 'Нет подключения к интернету';

  @override
  String get debugLog_appTitle => 'Журнал отладки приложения';

  @override
  String get debugLog_bleTitle => 'Журнал отладки BLE';

  @override
  String get debugLog_copyLog => 'Копировать журнал';

  @override
  String get debugLog_clearLog => 'Очистить журнал';

  @override
  String get debugLog_copied => 'Журнал отладки скопирован';

  @override
  String get debugLog_bleCopied => 'Журнал BLE скопирован';

  @override
  String get debugLog_noEntries => 'Журнал отладки пока пуст';

  @override
  String get debugLog_enableInSettings =>
      'Включите запись журнала отладки в настройках';

  @override
  String get debugLog_frames => 'Фреймы';

  @override
  String get debugLog_rawLogRx => 'Сырой журнал приёма';

  @override
  String get debugLog_noBleActivity => 'Активность BLE пока отсутствует';

  @override
  String debugFrame_length(int count) {
    return 'Длина фрейма: $count байт';
  }

  @override
  String debugFrame_command(String value) {
    return 'Команда: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'Фрейм текстового сообщения:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- Публичный ключ получателя: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- Временная метка: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- Флаги: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- Тип текста: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'CLI';

  @override
  String get debugFrame_textTypePlain => 'Обычный';

  @override
  String debugFrame_text(String text) {
    return '- Текст: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => 'Шестнадцатеричный дамп:';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'хопов',
      many: 'хопов',
      few: 'хопа',
      one: 'хоп',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => 'Удалить маршрут';

  @override
  String get chat_noPathHistoryYet =>
      'История маршрутов пока пуста.\nОтправьте сообщение, чтобы обнаружить маршруты.';

  @override
  String get chat_pathCleared =>
      'Маршрут очищен. Следующее сообщение обновит маршрут.';

  @override
  String get chat_fullPath => 'Полный маршрут';

  @override
  String get routing_title => 'Маршрутизация';

  @override
  String get routing_modeAuto => 'Авто';

  @override
  String get routing_modeFlood => 'Наводнение';

  @override
  String get routing_modeManual => 'Инструкция';

  @override
  String get routing_modeAutoHint =>
      'Автоматически выбирает наиболее известный путь, и если такой путь неизвестен, использует алгоритм поиска пути.';

  @override
  String get routing_modeFloodHint =>
      'Передача сигнала через все ретрансляторы. Самый надежный способ, но требует больше времени на передачу.';

  @override
  String get routing_modeManualHint =>
      'Всегда следует точно по указанному вами маршруту.';

  @override
  String get routing_currentRoute => 'Текущий маршрут';

  @override
  String get routing_directNoHops =>
      'Прямое соединение – без использования ретрансляторов';

  @override
  String get routing_noPathYet =>
      'Пока нет пути. Следующее сообщение будет отправлено до тех пор, пока не будет обнаружен маршрут.';

  @override
  String get routing_floodBroadcast => 'Транслируется через все ретрансляторы';

  @override
  String get routing_editPath => 'Изменить путь';

  @override
  String get routing_forgetPath => 'Забудьте о маршруте';

  @override
  String get routing_knownPaths => 'Известные маршруты';

  @override
  String get routing_knownPathsHint =>
      'Создайте маршрут для переключения на этот пункт.';

  @override
  String get routing_inUse => 'В эксплуатации';

  @override
  String get routing_qualityStrong => 'Сильный первый скачок';

  @override
  String get routing_qualityGood => 'Хорошее начало';

  @override
  String get routing_qualityFair => 'Первый хороший урожай';

  @override
  String get routing_qualityWorked => 'Осуществлено';

  @override
  String get routing_qualityFlood =>
      'Узнал из новостей, распространяющихся в интернете.';

  @override
  String get routing_qualityUntested => 'Непроверенный';

  @override
  String routing_lastWorked(String when) {
    return 'worked $when';
  }

  @override
  String get routing_neverWorked => 'никогда не было подтверждено';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes delivered, $failures failed';
  }

  @override
  String get routing_floodDelivery => 'Доставка при затоплении';

  @override
  String get pathEditor_title => 'Создать маршрут';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count из 64 хмеля';
  }

  @override
  String get pathEditor_noHops =>
      'На данный момент хмель еще не добавлен. Чтобы добавить его, нажмите на соответствующие кнопки ниже в нужном порядке, или сохраните рецепт без хмеля, чтобы отправить его напрямую.';

  @override
  String get pathEditor_addHops =>
      'Добавляйте хмель в соответствии с указанным порядком.';

  @override
  String get pathEditor_searchRepeaters => 'Поиск повторителей';

  @override
  String get pathEditor_advancedHex =>
      'Продвинутый уровень: прямой путь в шестнадцатеричном формате';

  @override
  String get pathEditor_hexLabel => 'Префиксы шестнадцатеричной системы';

  @override
  String get pathEditor_hexHelper =>
      'Два шестнадцатеричных символа на каждом шаге, разделенные запятыми.';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return 'Неверно: $tokens';
  }

  @override
  String get pathEditor_tooManyHops =>
      'Максимальное количество ингредиентов – 64';

  @override
  String get pathEditor_usePath => 'Используйте этот путь';

  @override
  String get pathEditor_removeHop => 'Удалить хмель';

  @override
  String get pathEditor_unknownHop => 'Неизвестный ретранслятор';

  @override
  String get chat_pathSavedLocally =>
      'Сохранено локально. Подключитесь для синхронизации.';

  @override
  String get chat_pathDeviceConfirmed => 'Подтверждено устройством.';

  @override
  String get chat_pathDeviceNotConfirmed => 'Ещё не подтверждено устройством.';

  @override
  String get chat_type => 'Тип';

  @override
  String get chat_path => 'Маршрут';

  @override
  String get chat_publicKey => 'Публичный ключ';

  @override
  String get chat_compressOutgoingMessages => 'Сжимать исходящие сообщения';

  @override
  String get chat_floodForced => 'Рассылка (принудительно)';

  @override
  String get chat_directForced => 'Прямой (принудительно)';

  @override
  String chat_hopsForced(int count) {
    return '$count хоп(ов) (принудительно)';
  }

  @override
  String get chat_floodAuto => 'Рассылка (авто)';

  @override
  String get chat_direct => 'Прямой';

  @override
  String get chat_poiShared => 'Точка интереса отправлена';

  @override
  String chat_unread(int count) {
    return 'Непрочитанных: $count';
  }

  @override
  String get chat_markAsUnread => 'Пометить как непрочитанные';

  @override
  String get chat_newMessages => 'Новые сообщения';

  @override
  String get chat_openLink => 'Открыть ссылку?';

  @override
  String get chat_openLinkConfirmation =>
      'Хотите открыть эту ссылку в вашем браузере?';

  @override
  String get chat_open => 'Открыть';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'Не удалось открыть ссылку: $url';
  }

  @override
  String get chat_invalidLink => 'Неправильный формат ссылки';

  @override
  String get map_title => 'Карта нод';

  @override
  String get map_searchHint => 'Поиск по имени или ID узла';

  @override
  String get map_activity => 'Активность';

  @override
  String get map_online => 'Онлайн';

  @override
  String get map_recent => 'Недавно';

  @override
  String get map_stale => 'Устаревший';

  @override
  String get map_visible => 'Видимый';

  @override
  String get map_hidden => 'Скрытый';

  @override
  String get map_centerOnNode => 'Центрировать на узле';

  @override
  String get map_details => 'Детали';

  @override
  String get map_noGps => 'Без GPS';

  @override
  String get map_noResults => 'Не найдено соответствующих узлов';

  @override
  String get map_lineOfSight => 'Линия видимости';

  @override
  String get map_losScreenTitle => 'Линия видимости';

  @override
  String get map_noNodesWithLocation => 'Нет нод с данными о местоположении';

  @override
  String get map_nodesNeedGps =>
      'Ноды должны передавать свои GPS-координаты, чтобы отображаться на карте';

  @override
  String map_nodesCount(int count) {
    return 'Нод: $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'Меток: $count';
  }

  @override
  String get map_chat => 'Чат';

  @override
  String get map_repeater => 'Репитер';

  @override
  String get map_room => 'Комната';

  @override
  String get map_sensor => 'Сенсор';

  @override
  String get map_pinDm => 'Метка (ЛС)';

  @override
  String get map_pinPrivate => 'Метка (Приватная)';

  @override
  String get map_pinPublic => 'Метка (Публичная)';

  @override
  String get map_lastSeen => 'Последнее появление';

  @override
  String get map_disconnectConfirm =>
      'Вы уверены, что хотите отключиться от этого устройства?';

  @override
  String get map_from => 'От';

  @override
  String get map_source => 'Источник';

  @override
  String get map_flags => 'Флаги';

  @override
  String get map_type => 'Тип';

  @override
  String get map_path => 'Путь';

  @override
  String get map_location => 'Местоположение';

  @override
  String get map_estLocation => 'Прибл. местоположение';

  @override
  String get map_publicKey => 'Публичный ключ';

  @override
  String get map_publicKeyPrefixHint => 'напр. ab12';

  @override
  String get map_shareMarkerHere => 'Поделиться меткой здесь';

  @override
  String get map_setAsMyLocation => 'Установить мое местоположение';

  @override
  String get floodCorridor_title => 'Flood-коридор';

  @override
  String get floodCorridor_previewToHere =>
      'Предпросмотр flood-коридора досюда';

  @override
  String get floodCorridor_requesting => 'Запрашиваем коридор у радио…';

  @override
  String get floodCorridor_unsupported =>
      'Прошивка вашего радио не поддерживает flood-коридоры.';

  @override
  String get floodCorridor_noProposal =>
      'Радио не смогло предложить коридор. Убедитесь, что у него заданы координаты.';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count круга',
      many: '$count кругов',
      few: '$count круга',
      one: '1 круг',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return 'Внутри $inside из $total известных репитеров';
  }

  @override
  String get floodCorridor_straightLine =>
      'Прямая линия: на пути нет известных репитеров';

  @override
  String get floodCorridor_followsRepeaters =>
      'Проходит по известным репитерам';

  @override
  String get floodCorridor_horizonLimited =>
      'Известные репитеры не достают до цели; остаток — прямая линия';

  @override
  String get floodCorridor_thinStretch =>
      'На части коридора мало известных репитеров';

  @override
  String get floodCorridor_moreCoverage =>
      'Требовать большего покрытия репитерами';

  @override
  String get floodCorridor_previewNote =>
      'Только предпросмотр. Репитеры без прошивки коридоров их не применяют.';

  @override
  String get map_pinLabel => 'Метка';

  @override
  String get map_label => 'Подпись';

  @override
  String get map_pointOfInterest => 'Точка интереса';

  @override
  String get map_sendToContact => 'Отправить контакту';

  @override
  String get map_sendToChannel => 'Отправить в канал';

  @override
  String get map_noChannelsAvailable => 'Нет доступных каналов';

  @override
  String get map_publicLocationShare => 'Публичная передача местоположения';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return 'Вы собираетесь поделиться местоположением в $channelLabel. Этот канал публичный, и любой, у кого есть PSK, сможет его увидеть.';
  }

  @override
  String get map_connectToShareMarkers =>
      'Подключитесь к устройству, чтобы делиться метками';

  @override
  String get map_filterNodes => 'Фильтр нод';

  @override
  String get map_nodeTypes => 'Типы нод';

  @override
  String get map_chatNodes => 'Чат-ноды';

  @override
  String get map_repeaters => 'Репитеры';

  @override
  String get map_otherNodes => 'Другие ноды';

  @override
  String get map_showOverlaps => 'Перекрытия ключа повтора';

  @override
  String get map_keyPrefix => 'Префикс ключа';

  @override
  String get map_filterByKeyPrefix => 'Фильтр по префиксу ключа';

  @override
  String get map_publicKeyPrefix => 'Префикс публичного ключа';

  @override
  String get map_markers => 'Метки';

  @override
  String get map_showSharedMarkers => 'Показывать общие метки';

  @override
  String get map_showGuessedLocations =>
      'Отобразить предполагаемые места расположения узлов';

  @override
  String get map_showDiscoveryContacts => 'Показать контакты Discovery';

  @override
  String get map_guessedLocation => 'Угаданное место';

  @override
  String get map_lastSeenTime => 'Время последнего появления';

  @override
  String get map_sharedPin => 'Общая метка';

  @override
  String get map_sharedAt => 'Поделено';

  @override
  String get map_joinRoom => 'Присоединиться к комнате';

  @override
  String get map_manageRepeater => 'Управление репитером';

  @override
  String get map_tapToAdd => 'Нажимайте на узлы, чтобы добавить их в путь.';

  @override
  String get map_runTrace => 'Запустить трассировку пути';

  @override
  String get map_runTraceWithReturnPath => 'Вернуться обратно по тому же пути';

  @override
  String get map_removeLast => 'Удалить последний';

  @override
  String get map_pathTraceCancelled => 'Отмена трассировки пути';

  @override
  String get mapCache_title => 'Кэш офлайн-карты';

  @override
  String get mapCache_selectAreaFirst =>
      'Сначала выберите область для кэширования';

  @override
  String get mapCache_noTilesToDownload =>
      'Нет плиток для загрузки в этой области';

  @override
  String get mapCache_downloadTilesTitle => 'Загрузить плитки';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return 'Загрузить $count плиток для офлайн-использования?';
  }

  @override
  String get mapCache_downloadAction => 'Загрузить';

  @override
  String mapCache_cachedTiles(int count) {
    return 'Закэшировано $count плиток';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return 'Закэшировано $downloaded плиток ($failed не загружено)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => 'Очистить офлайн-кэш';

  @override
  String get mapCache_clearOfflineCachePrompt =>
      'Удалить все закэшированные плитки карты?';

  @override
  String get mapCache_offlineCacheCleared => 'Офлайн-кэш очищен';

  @override
  String get mapCache_noAreaSelected => 'Область не выбрана';

  @override
  String get mapCache_cacheArea => 'Область кэширования';

  @override
  String get mapCache_useCurrentView => 'Использовать текущий вид';

  @override
  String get mapCache_zoomRange => 'Диапазон масштаба';

  @override
  String mapCache_estimatedTiles(int count) {
    return 'Оценочное количество плиток: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return 'Загружено $completed из $total';
  }

  @override
  String get mapCache_downloadTilesButton => 'Загрузить плитки';

  @override
  String get mapCache_clearCacheButton => 'Очистить кэш';

  @override
  String mapCache_failedDownloads(int count) {
    return 'Неудачных загрузок: $count';
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
    return 'С $north, Ю $south, В $east, З $west';
  }

  @override
  String get time_justNow => 'Только что';

  @override
  String time_minutesAgo(int minutes) {
    return '$minutes мин назад';
  }

  @override
  String time_hoursAgo(int hours) {
    return '$hours ч назад';
  }

  @override
  String time_daysAgo(int days) {
    return '$days дн. назад';
  }

  @override
  String get time_hour => 'час';

  @override
  String get time_hours => 'часов';

  @override
  String get time_day => 'день';

  @override
  String get time_days => 'дней';

  @override
  String get time_week => 'неделя';

  @override
  String get time_weeks => 'недель';

  @override
  String get time_month => 'месяц';

  @override
  String get time_months => 'месяцев';

  @override
  String get time_minutes => 'минут';

  @override
  String get time_allTime => 'Всё время';

  @override
  String get dialog_disconnect => 'Отключиться';

  @override
  String get dialog_disconnectConfirm =>
      'Вы уверены, что хотите отключиться от этого устройства?';

  @override
  String get login_repeaterLogin => 'Вход в репитер';

  @override
  String get login_roomLogin => 'Вход на сервер комнат';

  @override
  String get login_password => 'Пароль';

  @override
  String get login_enterPassword => 'Введите пароль';

  @override
  String get login_savePassword => 'Сохранить пароль';

  @override
  String get login_savePasswordSubtitle =>
      'Пароль будет надёжно сохранён на этом устройстве';

  @override
  String get login_repeaterDescription =>
      'Введите пароль репитера для доступа к настройкам и статусу.';

  @override
  String get login_roomDescription =>
      'Введите пароль комнаты для доступа к настройкам и статусу.';

  @override
  String get login_routing => 'Маршрутизация';

  @override
  String get login_routingMode => 'Режим маршрутизации';

  @override
  String get login_autoUseSavedPath =>
      'Авто (использовать сохранённый маршрут)';

  @override
  String get login_forceFloodMode => 'Принудительный режим рассылки';

  @override
  String get login_managePaths => 'Управление маршрутами';

  @override
  String get login_login => 'Войти';

  @override
  String login_attempt(int current, int max) {
    return 'Попытка $current/$max';
  }

  @override
  String login_failed(String error) {
    return 'Ошибка входа: $error';
  }

  @override
  String get login_failedMessage =>
      'Не удалось войти. Либо пароль неверен, либо репитер недоступен.';

  @override
  String get common_reload => 'Обновить';

  @override
  String get common_clear => 'Очистить';

  @override
  String get path_currentPathLabel => 'Текущий маршрут';

  @override
  String get path_noRepeatersFound => 'Репитеры или серверы комнат не найдены.';

  @override
  String get repeater_management => 'Управление репитером';

  @override
  String get room_management => 'Управление сервером комнат';

  @override
  String get repeater_guest => 'Информация о ретрансляторе';

  @override
  String get room_guest => 'Информация о сервере';

  @override
  String get repeater_managementTools => 'Инструменты управления';

  @override
  String get repeater_guestTools => 'Инструменты для гостей';

  @override
  String get repeater_status => 'Статус';

  @override
  String get repeater_statusSubtitle =>
      'Просмотр статуса, статистики и соседей репитера';

  @override
  String get repeater_telemetry => 'Телеметрия';

  @override
  String get repeater_telemetrySubtitle =>
      'Просмотр телеметрии датчиков и системной статистики';

  @override
  String get repeater_cli => 'CLI';

  @override
  String get repeater_cliSubtitle => 'Отправка команд репитеру';

  @override
  String get repeater_neighbors => 'Соседи';

  @override
  String get repeater_neighborsSubtitle => 'Просмотр соседей на нулевом хопе.';

  @override
  String get repeater_settings => 'Настройки';

  @override
  String get repeater_settingsSubtitle => 'Настройка параметров репитера';

  @override
  String get repeater_clockSyncAfterLogin =>
      'Синхронизация часов после входа в систему';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      'Автоматически отправлять сообщение \"синхронизация времени\" после успешной авторизации.';

  @override
  String get repeater_statusTitle => 'Статус репитера';

  @override
  String get repeater_routingMode => 'Режим маршрутизации';

  @override
  String get repeater_refresh => 'Обновить';

  @override
  String get repeater_statusRequestTimeout => 'Время ожидания статуса истекло.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'Ошибка загрузки статуса: $error';
  }

  @override
  String get repeater_systemInformation => 'Системная информация';

  @override
  String get repeater_battery => 'Батарея';

  @override
  String get repeater_clockAtLogin => 'Время (при входе)';

  @override
  String get repeater_uptime => 'Время работы';

  @override
  String get repeater_queueLength => 'Длина очереди';

  @override
  String get repeater_debugFlags => 'Флаги отладки';

  @override
  String get repeater_radioStatistics => 'Радиостатистика';

  @override
  String get repeater_lastRssi => 'Последний RSSI';

  @override
  String get repeater_lastSnr => 'Последний SNR';

  @override
  String get repeater_noiseFloor => 'Уровень шума';

  @override
  String get repeater_txAirtime => 'Время эфира (передача)';

  @override
  String get repeater_rxAirtime => 'Время эфира (приём)';

  @override
  String get repeater_chanUtil => 'Использование канала';

  @override
  String get repeater_packetStatistics => 'Статистика пакетов';

  @override
  String get repeater_sent => 'Отправлено';

  @override
  String get repeater_received => 'Получено';

  @override
  String get repeater_duplicates => 'Дубликаты';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days дн. $hoursч $minutesм $secondsс';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return 'Всего: $total, Рассылка: $flood, Прямые: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return 'Всего: $total, Рассылка: $flood, Прямые: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return 'Рассылка: $flood, Прямые: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return 'Всего: $total';
  }

  @override
  String get repeater_settingsTitle => 'Настройки репитера';

  @override
  String get repeater_basicSettings => 'Основные настройки';

  @override
  String get repeater_repeaterName => 'Имя репитера';

  @override
  String get repeater_repeaterNameHelper => 'Отображаемое имя этого репитера';

  @override
  String get repeater_adminPassword => 'Пароль администратора';

  @override
  String get repeater_adminPasswordHelper => 'Пароль с полным доступом';

  @override
  String get repeater_guestPassword => 'Гостевой пароль';

  @override
  String get repeater_guestPasswordHelper =>
      'Пароль для доступа только для чтения';

  @override
  String get repeater_radioSettings => 'Настройки радио';

  @override
  String get repeater_frequencyMhz => 'Частота (МГц)';

  @override
  String get repeater_frequencyHelper => '300–2500 МГц';

  @override
  String get repeater_txPower => 'Мощность передачи';

  @override
  String get repeater_txPowerHelper => '1–30 дБм';

  @override
  String get repeater_bandwidth => 'Полоса пропускания';

  @override
  String get repeater_spreadingFactor => 'Коэффициент расширения';

  @override
  String get repeater_codingRate => 'Коэффициент кодирования';

  @override
  String get repeater_locationSettings => 'Настройки местоположения';

  @override
  String get repeater_latitude => 'Широта';

  @override
  String get repeater_latitudeHelper =>
      'В десятичных градусах (напр., 37.7749)';

  @override
  String get repeater_longitude => 'Долгота';

  @override
  String get repeater_longitudeHelper =>
      'В десятичных градусах (напр., -122.4194)';

  @override
  String get repeater_features => 'Функции';

  @override
  String get repeater_packetForwarding => 'Пересылка пакетов';

  @override
  String get repeater_packetForwardingSubtitle =>
      'Разрешить репитеру пересылать пакеты';

  @override
  String get repeater_guestAccess => 'Гостевой доступ';

  @override
  String get repeater_guestAccessSubtitle =>
      'Разрешить гостевой доступ только для чтения';

  @override
  String get repeater_privacyMode => 'Режим конфиденциальности';

  @override
  String get repeater_privacyModeSubtitle =>
      'Скрывать имя/местоположение в оповещениях';

  @override
  String get repeater_advertisementSettings => 'Настройки анонсирования';

  @override
  String get repeater_localAdvertInterval => 'Интервал локальных анонсирований';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes минут';
  }

  @override
  String get repeater_floodAdvertInterval =>
      'Интервал анонсирований рассылкой (flood)';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours часов';
  }

  @override
  String get repeater_encryptedAdvertInterval =>
      'Интервал зашифрованных анонсирований';

  @override
  String get repeater_dangerZone => 'Опасная зона';

  @override
  String get repeater_rebootRepeater => 'Перезагрузить репитер';

  @override
  String get repeater_rebootRepeaterSubtitle =>
      'Перезапустить устройство репитера';

  @override
  String get repeater_rebootRepeaterConfirm =>
      'Вы уверены, что хотите перезагрузить этот репитер?';

  @override
  String get repeater_regenerateIdentityKey => 'Пересоздать ключ идентификации';

  @override
  String get repeater_regenerateIdentityKeySubtitle =>
      'Сгенерировать новую пару публичного/приватного ключей';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'Это создаст новую идентичность для репитера. Продолжить?';

  @override
  String get repeater_eraseFileSystem => 'Стереть файловую систему';

  @override
  String get repeater_eraseFileSystemSubtitle =>
      'Отформатировать файловую систему репитера';

  @override
  String get repeater_eraseFileSystemConfirm =>
      'ВНИМАНИЕ: это удалит все данные на репитере. Действие нельзя отменить!';

  @override
  String get repeater_eraseSerialOnly =>
      'Очистка доступна только через последовательную консоль.';

  @override
  String repeater_commandSent(String command) {
    return 'Команда отправлена: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'Ошибка отправки команды: $error';
  }

  @override
  String get repeater_confirm => 'Подтвердить';

  @override
  String get repeater_settingsSaved => 'Настройки успешно сохранены';

  @override
  String get repeater_rxGain => 'Увеличенная эффективность RX';

  @override
  String get repeater_rxGainHelper =>
      'Более высокая чувствительность, больший ток потребления (только для SX1262/SX1268)';

  @override
  String get repeater_refreshRxGain => 'Обновите усиление RX';

  @override
  String get repeater_multiAcks => 'Несколько подтверждений';

  @override
  String get repeater_multiAcksSubtitle =>
      'Обеспечьте доставку сообщений по нескольким каналам для повышения эффективности.';

  @override
  String get repeater_refreshMultiAcks => 'Обновление нескольких подтверждений';

  @override
  String get repeater_networkHealth => 'Состояние сети';

  @override
  String get repeater_loopDetect => 'Обнаружение циклов';

  @override
  String get repeater_loopDetectHelper =>
      'Создайте пакеты данных, которые выглядят как циклы маршрутизации.';

  @override
  String get repeater_loopDetectOff => 'Отключено';

  @override
  String get repeater_loopDetectMinimal => 'Минимальный';

  @override
  String get repeater_loopDetectModerate => 'Умеренный';

  @override
  String get repeater_loopDetectStrict => 'Строгий';

  @override
  String get repeater_dutyCycle => 'Цикл работы';

  @override
  String get repeater_dutyCycleHelper =>
      'Максимальный процент времени, выделенного на трансляцию.';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => 'Информация о операторе';

  @override
  String get repeater_ownerInfoHelper =>
      'Общая метаинформация для этого ретранслятора';

  @override
  String get repeater_refreshOwnerInfo => 'Обновить информацию о операторе';

  @override
  String get repeater_floodMax =>
      'Максимальное количество прыжков при наводнении';

  @override
  String get repeater_floodMaxHelper =>
      'Максимальное количество пакетов, которые могут быть отправлены в одном потоке (0-64)';

  @override
  String get repeater_advancedSettings => 'Продвинутый';

  @override
  String get repeater_advancedSettingsSubtitle =>
      'Регуляторы для опытных операторов';

  @override
  String get repeater_pathHashMode => 'Режим хеширования пути';

  @override
  String get repeater_pathHashModeHelper =>
      'Байты, используемые для кодирования идентификатора этого ретранслятора в тегах flood-маршрута/обнаружения циклов. 0 = 1 байт (256 идентификаторов, до 64 переходов), 1 = 2 байта (65 000 идентификаторов, до 32 переходов), 2 = 3 байта (16 миллионов идентификаторов, до 21 перехода). Прошивки до v1.14 всегда использовали 1-байтовые маршруты; v1.14 и новее можно настроить на 2- или 3-байтовые маршруты.';

  @override
  String get repeater_keySettings => 'Изменить ключи идентичности';

  @override
  String get repeater_keySettingsSubtitle =>
      'Измените пару публичных/частных ключей';

  @override
  String get repeater_prvKey => 'Личный ключ';

  @override
  String get repeater_prvKeyHelper =>
      'Для повторителя генерируется новый приватный ключ — шестнадцатеричная строка из 128 символов.';

  @override
  String get repeater_generatePrvKey => 'Сгенерируйте случайный ключ-пару';

  @override
  String get repeater_stopGeneratingPrvKey => 'Прервать поиск ключной пары';

  @override
  String get repeater_pubKey => 'Публичный ключ';

  @override
  String get repeater_pubKeyHelper =>
      'Это публичный ключ, который соответствует сгенерированному приватному ключу. Вы не можете установить его напрямую.';

  @override
  String get repeater_pubKeyPrefix => 'Желаемый префикс';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'Найдите публичный ключ, начинающийся этими шестнадцатеричными цифрами. Ожидаемое количество попыток: $tries.';
  }

  @override
  String get repeater_txDelay => 'Задержка в работе системы Flood TX';

  @override
  String get repeater_txDelayHelper =>
      'Передача с увеличенным интервалом для трафика во время наводнения, в качестве коэффициента, умножающего время передачи пакета (от 0 до 2, по умолчанию 0,5). Более высокое значение означает меньшее количество столкновений, но более медленную передачу.';

  @override
  String get repeater_directTxDelay => 'Прямая задержка сигнала TX';

  @override
  String get repeater_directTxDelayHelper =>
      'Передача промежуточных данных для прямого (немассового) трафика, в качестве коэффициента, равного времени передачи пакета (от 0 до 2, по умолчанию 0,3).';

  @override
  String get repeater_intThresh => 'Пороговое значение помех';

  @override
  String get repeater_intThreshHelper =>
      'Порог устанавливается для калибровки уровня шума радио, чтобы оно отсеивало помехи, превышающие этот уровень. Значение \"0\" означает отключение – используйте только в случае, если вы наблюдаете ошибки при приеме сигнала в шумном диапазоне.';

  @override
  String get repeater_agcResetInterval => 'Интервал сброса AGC';

  @override
  String get repeater_agcResetIntervalHelper =>
      'Как часто следует сбрасывать автоматическую регулировку усиления радио, чтобы вернуться к нормальному состоянию после заклинивания? Интервал сброса составляет несколько секунд, кратный 4. Отключение периодического сброса осуществляется с помощью параметра 0.';

  @override
  String get repeater_actionsTitle => 'Действия';

  @override
  String get repeater_sendAdvert => 'Отправить объявление о наводнении';

  @override
  String get repeater_sendAdvertSubtitle =>
      'Разместите рекламу о наводнении в эфире по всей сети.';

  @override
  String get repeater_sendAdvertZeroHop =>
      'Опубликуйте рекламу, не требующую промежуточного распространения.';

  @override
  String get repeater_sendAdvertZeroHopSubtitle =>
      'Разместите рекламу, распространяемую одним способом (без использования ретрансляторов).';

  @override
  String get repeater_clockSync => 'Синхронизировать время сейчас';

  @override
  String get repeater_clockSyncSubtitle =>
      'Установите время на вашем телефоне, чтобы оно совпадало со временем ретранслятора.';

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
      'Настройки сохранены — перезагрузите ретранслятор, чтобы применить их.';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return 'Некоторые настройки не удалось применить: $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return 'Ошибка сохранения настроек: $error';
  }

  @override
  String get repeater_refreshBasicSettings => 'Обновить основные настройки';

  @override
  String get repeater_refreshRadioSettings => 'Обновить настройки радио';

  @override
  String get repeater_refreshTxPower => 'Обновить мощность передачи';

  @override
  String get repeater_refreshPacketForwarding => 'Обновить пересылку пакетов';

  @override
  String get repeater_refreshGuestAccess => 'Обновить гостевой доступ';

  @override
  String get repeater_refreshPrivacyMode => 'Обновить режим конфиденциальности';

  @override
  String repeater_refreshed(String label) {
    return '$label обновлён';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return 'Ошибка обновления $label';
  }

  @override
  String get repeater_cliTitle => 'CLI репитера';

  @override
  String get repeater_debugNextCommand => 'Отладка следующей команды';

  @override
  String get repeater_commandHelp => 'Справка по командам';

  @override
  String get repeater_clearHistory => 'Очистить историю';

  @override
  String get repeater_noCommandsSent => 'Команды ещё не отправлялись';

  @override
  String get repeater_typeCommandOrUseQuick =>
      'Введите команду ниже или используйте быстрые команды';

  @override
  String get repeater_enterCommandHint => 'Введите команду...';

  @override
  String get repeater_previousCommand => 'Предыдущая команда';

  @override
  String get repeater_nextCommand => 'Следующая команда';

  @override
  String get repeater_enterCommandFirst => 'Сначала введите команду';

  @override
  String get repeater_cliCommandFrameTitle => 'Фрейм CLI-команды';

  @override
  String repeater_cliCommandError(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get repeater_cliQuickGetName => 'Получить имя';

  @override
  String get repeater_cliQuickGetRadio => 'Получить радио';

  @override
  String get repeater_cliQuickGetTx => 'Получить TX';

  @override
  String get repeater_cliQuickNeighbors => 'Соседи';

  @override
  String get repeater_cliQuickVersion => 'Версия';

  @override
  String get repeater_cliQuickAdvertise => 'Анонсировать';

  @override
  String get repeater_cliQuickClock => 'Время';

  @override
  String get repeater_cliQuickClockSync => 'Синхронизация часов';

  @override
  String get repeater_cliQuickDiscovery => 'Обнаружить Соседей';

  @override
  String get repeater_cliHelpAdvert => 'Отправляет пакет анонсирования';

  @override
  String get repeater_cliHelpReboot =>
      'Перезагружает устройство. (обычно вы получите «Тайм-аут» — это нормально)';

  @override
  String get repeater_cliHelpClock =>
      'Показывает текущее время по часам устройства.';

  @override
  String get repeater_cliHelpPassword =>
      'Устанавливает новый пароль администратора для устройства.';

  @override
  String get repeater_cliHelpVersion =>
      'Показывает версию устройства и дату сборки прошивки.';

  @override
  String get repeater_cliHelpClearStats =>
      'Сбрасывает различные счётчики статистики в ноль.';

  @override
  String get repeater_cliHelpSetAf =>
      'Устанавливает коэффициент времени в эфире.';

  @override
  String get repeater_cliHelpSetTx =>
      'Устанавливает мощность передачи LoRa в дБм. (требуется перезагрузка)';

  @override
  String get repeater_cliHelpSetRepeat =>
      'Включает или отключает роль репитера для этой ноды.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(Сервер комнат) Если «on», то вход без пароля разрешён, но публиковать в комнату нельзя (только чтение)';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'Устанавливает максимальное число хопов для входящих пакетов в режиме рассылки (если >= макс., пакет не пересылается)';

  @override
  String get repeater_cliHelpSetIntThresh =>
      'Устанавливает порог интерференции (в дБ). По умолчанию 14. Установите 0, чтобы отключить обнаружение помех.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'Устанавливает интервал сброса автоматической регулировки усиления. Установите 0, чтобы отключить.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      'Включает или отключает функцию «двойных ACK».';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'Устанавливает интервал (в минутах) отправки локального (нулевой хоп) анонсирования. Установите 0, чтобы отключить.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'Устанавливает интервал (в часах) отправки анонсирований рассылкой. Установите 0, чтобы отключить.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'Устанавливает/обновляет гостевой пароль. (для репитеров гости могут отправлять запрос «Get Stats»)';

  @override
  String get repeater_cliHelpSetName => 'Устанавливает имя в оповещениях.';

  @override
  String get repeater_cliHelpSetLat =>
      'Устанавливает широту для карты в оповещениях. (десятичные градусы)';

  @override
  String get repeater_cliHelpSetLon =>
      'Устанавливает долготу для карты в оповещениях. (десятичные градусы)';

  @override
  String get repeater_cliHelpSetRadio =>
      'Устанавливает полностью новые параметры радио и сохраняет их в настройки. Требуется команда «reboot» для применения.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      'Устанавливает (экспериментально) базовую задержку (>1 для эффекта) для принятых пакетов на основе качества сигнала. Установите 0, чтобы отключить.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      'Устанавливает множитель времени в эфире для пакета в режиме рассылки и применяет случайную задержку перед пересылкой (чтобы уменьшить коллизии).';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'То же, что txdelay, но для случайной задержки пересылки пакетов в прямом режиме.';

  @override
  String get repeater_cliHelpSetBridgeEnabled => 'Включить/выключить мост.';

  @override
  String get repeater_cliHelpSetBridgeDelay =>
      'Установить задержку перед ретрансляцией пакетов.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      'Выбрать, будет ли мост ретранслировать полученные или отправленные пакеты.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'Установить скорость последовательного соединения для мостов RS232.';

  @override
  String get repeater_cliHelpSetBridgeSecret =>
      'Установить секрет моста для мостов ESP-NOW.';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      'Устанавливает пользовательский коэффициент коррекции напряжения батареи (поддерживается только на некоторых платах).';

  @override
  String get repeater_cliHelpTempRadio =>
      'Устанавливает временные параметры радио на заданное число минут, затем возвращает исходные. (НЕ сохраняется в настройки).';

  @override
  String get repeater_cliHelpSetPerm =>
      'Изменяет ACL. Удаляет запись (по префиксу публичного ключа), если «permissions» равен нулю. Добавляет новую запись, если указан полный ключ и он отсутствует в ACL. Обновляет запись по совпадению префикса. Биты прав зависят от роли прошивки, но младшие 2 бита: 0 (Гость), 1 (Только чтение), 2 (Чтение/запись), 3 (Админ)';

  @override
  String get repeater_cliHelpGetBridgeType =>
      'Получает тип моста: none, rs232, espnow';

  @override
  String get repeater_cliHelpLogStart =>
      'Начинает запись пакетов в файловую систему.';

  @override
  String get repeater_cliHelpLogStop =>
      'Останавливает запись пакетов в файловую систему.';

  @override
  String get repeater_cliHelpLogErase =>
      'Удаляет журналы пакетов из файловой системы.';

  @override
  String get repeater_cliHelpNeighbors =>
      'Показывает список других репитеров, услышанных через оповещения нулевого хопа. Каждая строка: префикс-id-в-hex:временная-метка:snr×4';

  @override
  String get repeater_cliHelpNeighborRemove =>
      'Удаляет первую подходящую запись (по префиксу публичного ключа в hex) из списка соседей.';

  @override
  String get repeater_cliHelpRegion =>
      '(только через последовательный порт) Показывает все определённые регионы и текущие права на рассылку.';

  @override
  String get repeater_cliHelpRegionLoad =>
      'ПРИМЕЧАНИЕ: это специальная многострочная команда. Каждая следующая строка — имя региона (с отступом пробелами для указания иерархии, минимум один пробел). Завершается пустой строкой.';

  @override
  String get repeater_cliHelpRegionGet =>
      'Ищет регион по префиксу имени (или «*» для глобальной области). Отвечает: «-> имя-региона (родитель) \'F\'»';

  @override
  String get repeater_cliHelpRegionPut =>
      'Добавляет или обновляет определение региона с заданным именем.';

  @override
  String get repeater_cliHelpRegionRemove =>
      'Удаляет определение региона с заданным именем. (должно точно совпадать и не иметь дочерних регионов)';

  @override
  String get repeater_cliHelpRegionAllowf =>
      'Разрешает рассылку («F»lood) для заданного региона. («*» для глобальной/устаревшей области)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      'Запрещает рассылку («F»lood) для заданного региона. (НЕ рекомендуется для глобальной области!)';

  @override
  String get repeater_cliHelpRegionHome =>
      'Показывает текущий «домашний» регион. (Пока не используется, зарезервировано на будущее)';

  @override
  String get repeater_cliHelpRegionHomeSet =>
      'Устанавливает «домашний» регион.';

  @override
  String get repeater_cliHelpRegionSave =>
      'Сохраняет список/карту регионов в память.';

  @override
  String get repeater_cliHelpGps =>
      'Показывает статус GPS. Если GPS выключен — отвечает только «off». Если включён — показывает статус, фиксацию, количество спутников.';

  @override
  String get repeater_cliHelpGpsOnOff => 'Переключает состояние питания GPS.';

  @override
  String get repeater_cliHelpGpsSync =>
      'Синхронизирует время ноды с часами GPS.';

  @override
  String get repeater_cliHelpGpsSetLoc =>
      'Устанавливает позицию ноды по координатам GPS и сохраняет в настройки.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'Показывает конфигурацию передачи местоположения в анонсированиях:\n- none: не включать местоположение\n- share: передавать GPS-координаты (из SensorManager)\n- prefs: передавать координаты из настроек';

  @override
  String get repeater_cliHelpGpsAdvertSet =>
      'Устанавливает конфигурацию передачи местоположения.';

  @override
  String get repeater_commandsListTitle => 'Список команд';

  @override
  String get repeater_commandsListNote =>
      'ПРИМЕЧАНИЕ: для большинства команд «set ...» существуют соответствующие команды «get ...».';

  @override
  String get repeater_general => 'Общие';

  @override
  String get repeater_settingsCategory => 'Настройки';

  @override
  String get repeater_bridge => 'Мост';

  @override
  String get repeater_logging => 'Журналирование';

  @override
  String get repeater_neighborsRepeaterOnly => 'Соседи (только для репитеров)';

  @override
  String get repeater_regionManagementRepeaterOnly =>
      'Управление регионами (только для репитеров)';

  @override
  String get repeater_regionNote =>
      'Команды регионов введены для управления определениями регионов и правами доступа.';

  @override
  String get repeater_gpsManagement => 'Управление GPS';

  @override
  String get repeater_gpsNote =>
      'Команда gps введена для управления параметрами, связанными с местоположением.';

  @override
  String get repeater_getCategory => 'Получить значения';

  @override
  String get repeater_powerMgmt => 'Управление энергопотреблением';

  @override
  String get repeater_sensors => 'Датчики';

  @override
  String get repeater_cliHelpPowerOff =>
      'Отключает устройство. (ожидается отсутствие ответа).';

  @override
  String get repeater_cliHelpClkReboot =>
      'Сбрасывает часы до известной эпохи и перезапускает устройство.';

  @override
  String get repeater_cliHelpAdvertZeroHop =>
      'Отправляет рекламу, распространяемую только среди ближайших соседей (без промежуточных узлов).';

  @override
  String get repeater_cliHelpStartOta =>
      'Запускает обновление прошивки по воздуху на поддерживаемых устройствах.';

  @override
  String get repeater_cliHelpTime =>
      'Устанавливает время устройства в соответствии с заданными секундами от начала эпохи Unix. Время не может сброситься назад.';

  @override
  String get repeater_cliHelpBoard =>
      'Отображает информацию о производителе платы / идентификатор аппаратного обеспечения.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      'Отправляет запрос на обнаружение соседних узлов. (Только для ретранслятора)';

  @override
  String get repeater_cliHelpPowersaving =>
      'Показывает, включен ли режим экономии энергии.';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      'Включает или выключает режим экономии энергии (если он поддерживается).';

  @override
  String get repeater_cliHelpErase =>
      '(Только для серийного использования) Форматирует файловую систему устройства. Удаляет все настройки и контакты.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      'Устанавливает максимальный допустимый цикл передачи данных в процентах (от 1 до 100). Внутренне корректирует коэффициент времени передачи.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '(Только для серийного использования) Заменяет приватный ключ, идентифицирующий устройство. Требуется перезагрузка для применения. Генерирует новый публичный ключ.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(Только для SX126x) Переключает усиление RX для повышения чувствительности при больших токах потребления.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      'Указывает строку с контактной информацией владельца, которая должна быть включена в объявления. Используйте \'|\' для переносов строк.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'Устанавливает режим хеширования пути. 0 = устаревший, 1 = стандартный, 2 = строгий. Влияет на то, как определяются маршруты.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'Устанавливает чувствительность обнаружения циклов маршрутизации: \"выключено\", \"минимальная\", \"умеренная\" или \"строгая\".';

  @override
  String get repeater_cliHelpSetFreq =>
      '(Только для настройки) Быстро устанавливает только частоту. Требуется перезагрузка. Рекомендуется использовать функцию \"настройка радио\" для полного набора параметров.';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(Только для моста ESPNow) Устанавливает канал Wi-Fi (от 1 до 14), используемый мостом.';

  @override
  String get repeater_cliHelpGetName => 'Отображает имя настроенного узла.';

  @override
  String get repeater_cliHelpGetRole =>
      'Отображает роль прошивки (ретранслятор, сервер для комнаты и т.д.).';

  @override
  String get repeater_cliHelpGetPublicKey =>
      'Отображает открытый ключ устройства.';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '(Только для серийного использования) Отображает приватный ключ устройства. Рассматривайте его как секретную информацию.';

  @override
  String get repeater_cliHelpGetRepeat =>
      'Отображает, включена ли функция перенаправления пакетов (функция ретранслятора) или нет.';

  @override
  String get repeater_cliHelpGetTx =>
      'Отображает текущую мощность передатчика в дБм.';

  @override
  String get repeater_cliHelpGetFreq =>
      'Отображает настроенную частоту радиосигнала в мегагерцах.';

  @override
  String get repeater_cliHelpGetRadio =>
      'Отображает все параметры радиосигнала: частоту, полосу пропускания, коэффициент модуляции, скорость кодирования.';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(Только для SX126x) Отображает состояние усиления сигнала на входе RX.';

  @override
  String get repeater_cliHelpGetAf =>
      'Отображает текущий коэффициент времени эфира.';

  @override
  String get repeater_cliHelpGetDutyCycle =>
      'Отображает текущий допустимый цикл работы в процентах.';

  @override
  String get repeater_cliHelpGetIntThresh =>
      'Отображает порог помех в децибелах.';

  @override
  String get repeater_cliHelpGetAgcResetInterval =>
      'Отображает интервал сброса автоматической регулировки усиления в секундах.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      'Показывает, включен ли режим двойной подтверждения (1) или выключен (0).';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'Отображает, разрешен ли доступ для чтения только для гостей.';

  @override
  String get repeater_cliHelpGetAdvertInterval =>
      'Отображает продолжительность рекламного блока в минутах.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'Отображает интервал времени показа рекламного ролика в часах.';

  @override
  String get repeater_cliHelpGetGuestPassword =>
      'Отображает установленный пароль для гостя.';

  @override
  String get repeater_cliHelpGetLat => 'Отображает заданную широту.';

  @override
  String get repeater_cliHelpGetLon => 'Отображает заданную долготу.';

  @override
  String get repeater_cliHelpGetRxDelay =>
      'Отображает базовое значение задержки.';

  @override
  String get repeater_cliHelpGetTxDelay =>
      'Отображает коэффициент задержки при работе в режиме затопления.';

  @override
  String get repeater_cliHelpGetDirectTxDelay =>
      'Отображает коэффициент задержки в режиме прямого подключения.';

  @override
  String get repeater_cliHelpGetFloodMax =>
      'Отображает максимальное количество переходов при затоплении.';

  @override
  String get repeater_cliHelpGetOwnerInfo =>
      'Отображает строку с контактной информацией владельца.';

  @override
  String get repeater_cliHelpGetPathHashMode =>
      'Отображает режим работы с хэшем пути (0/1/2).';

  @override
  String get repeater_cliHelpGetLoopDetect =>
      'Отображает чувствительность к обнаружению циклов.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(Только для серий) Перечисляет записи управления доступом на ретрансляторе.';

  @override
  String get repeater_cliHelpGetBridgeEnabled =>
      'Показывает, включена ли функция моста.';

  @override
  String get repeater_cliHelpGetBridgeDelay =>
      'Отображает задержку в миллисекундах.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'Отображает, какие пакеты RX или TX передаются через мост.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(Только для интерфейса RS232) Отображает скорость передачи данных на интерфейсе RS232.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(Только для моста ESPNow) Отображает канал WiFi, используемый мостом.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(Только для моста ESPNow) Отображает общий секрет, используемый мостом.';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '(Только для NRF52) Отображает версию загрузчика.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'Отображает коэффициент умножения аналого-цифрового преобразователя (масштабирование напряжения от батареи).';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      'Сообщает, есть ли у совета поддержки функций управления питанием.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      'Отображает текущий источник питания: внешний или аккумулятор.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      'Отображает последние причины сброса и выключения.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv =>
      'Отображает напряжение батареи при запуске системы в милливольтах (мВ).';

  @override
  String get repeater_cliHelpSensorGet =>
      'Считывает пользовательское значение для датчика по указанному ключу.';

  @override
  String get repeater_cliHelpSensorSet =>
      'Создает пользовательские настройки для датчика.';

  @override
  String get repeater_cliHelpSensorList =>
      'Перечисляет все пользовательские настройки датчиков, разбитые на страницы с возможностью указания начального индекса.';

  @override
  String get repeater_cliHelpRegionDefault =>
      'Отображает текущий область действия по умолчанию.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'Устанавливает значение региона по умолчанию. Используйте \"<null>\", чтобы сбросить значение.';

  @override
  String get repeater_cliHelpRegionListAllowed =>
      'Перечисляет регионы, где разрешено движение транспорта во время наводнений.';

  @override
  String get repeater_cliHelpRegionListDenied =>
      'Перечисляет регионы, где запрещено движение транспорта во время наводнений.';

  @override
  String get repeater_cliHelpStatsPackets =>
      '(Только для серийной версии) Отображает статистику на уровне пакетов.';

  @override
  String get repeater_cliHelpStatsRadio =>
      '(Только для серий) Отображает статистику радио.';

  @override
  String get repeater_cliHelpStatsCore =>
      '(Только для серийного оборудования) Отображает основные статистические данные прошивки.';

  @override
  String get telemetry_receivedData => 'Полученные телеметрические данные';

  @override
  String get telemetry_requestTimeout => 'Время ожидания телеметрии истекло.';

  @override
  String telemetry_errorLoading(String error) {
    return 'Ошибка загрузки телеметрии: $error';
  }

  @override
  String get telemetry_noData => 'Данные телеметрии недоступны.';

  @override
  String telemetry_channelTitle(int channel) {
    return 'Канал $channel';
  }

  @override
  String get telemetry_batteryLabel => 'Батарея';

  @override
  String get telemetry_voltageLabel => 'Напряжение';

  @override
  String get telemetry_mcuTemperatureLabel => 'Температура МК';

  @override
  String get telemetry_temperatureLabel => 'Температура';

  @override
  String get telemetry_currentLabel => 'Ток';

  @override
  String telemetry_batteryValue(int percent, String volts) {
    return '$percent% / $voltsВ';
  }

  @override
  String telemetry_voltageValue(String volts) {
    return '$voltsВ';
  }

  @override
  String telemetry_currentValue(String amps) {
    return '$ampsА';
  }

  @override
  String telemetry_temperatureValue(String celsius, String fahrenheit) {
    return '$celsius°C / $fahrenheit°F';
  }

  @override
  String get telemetry_digitalInputLabel => 'Цифровой вход';

  @override
  String get telemetry_digitalOutputLabel => 'Цифровой выход';

  @override
  String get telemetry_analogInputLabel => 'Аналоговый вход';

  @override
  String get telemetry_analogOutputLabel => 'Аналоговый выход';

  @override
  String get telemetry_genericLabel => 'Общий датчик';

  @override
  String get telemetry_luminosityLabel => 'Освещённость';

  @override
  String get telemetry_presenceLabel => 'Присутствие';

  @override
  String get telemetry_humidityLabel => 'Влажность';

  @override
  String get telemetry_accelerometerLabel => 'Акселерометр';

  @override
  String get telemetry_pressureLabel => 'Давление';

  @override
  String get telemetry_altitudeLabel => 'Высота';

  @override
  String get telemetry_frequencyLabel => 'Частота';

  @override
  String get telemetry_percentageLabel => 'Процент';

  @override
  String get telemetry_concentrationLabel => 'Концентрация';

  @override
  String get telemetry_powerLabel => 'Мощность';

  @override
  String get telemetry_distanceLabel => 'Расстояние';

  @override
  String get telemetry_energyLabel => 'Энергия';

  @override
  String get telemetry_directionLabel => 'Направление';

  @override
  String get telemetry_timeLabel => 'Время';

  @override
  String get telemetry_gyrometerLabel => 'Гирометр';

  @override
  String get telemetry_colourLabel => 'Цвет';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'Переключатель';

  @override
  String get telemetry_polylineLabel => 'Полилиния';

  @override
  String telemetry_altitudeValue(String meters) {
    return '$meters м';
  }

  @override
  String telemetry_frequencyValue(String hertz) {
    return '$hertz Гц';
  }

  @override
  String telemetry_pressureValue(String hpa) {
    return '$hpa гПа';
  }

  @override
  String telemetry_luminosityValue(String lux) {
    return '$lux лк';
  }

  @override
  String telemetry_powerValue(String watts) {
    return '$watts Вт';
  }

  @override
  String telemetry_distanceValue(String meters) {
    return '$meters м';
  }

  @override
  String telemetry_energyValue(String kilowattHours) {
    return '$kilowattHours кВт⋅ч';
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
  String get telemetry_autoFetchQuantity => 'Количество запросов';

  @override
  String get telemetry_error => 'Не удалось получить данные';

  @override
  String get neighbors_receivedData => 'Полученные данные о соседях';

  @override
  String get neighbors_requestTimedOut =>
      'Время ожидания данных о соседях истекло.';

  @override
  String neighbors_errorLoading(String error) {
    return 'Ошибка загрузки соседей: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => 'Соседи репитеров';

  @override
  String get neighbors_noData => 'Данные о соседях недоступны.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return 'Неизвестный $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return 'Слушал(а): $time назад';
  }

  @override
  String get channelPath_title => 'Путь пакета';

  @override
  String get channelPath_viewMap => 'Посмотреть на карте';

  @override
  String get channelPath_otherObservedPaths => 'Другие наблюдаемые пути';

  @override
  String get channelPath_repeaterHops => 'Хопы через репитеры';

  @override
  String get channelPath_noHopDetails =>
      'Детали хопов для этого пакета не предоставлены.';

  @override
  String get channelPath_sourceLabel => 'Источник';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'Это сообщение пришло через MQTT. Ваше радио его не слышало, поэтому радиомаршрута от вашего радио нет.';

  @override
  String get channelPath_messageDetails => 'Детали сообщения';

  @override
  String get channelPath_senderLabel => 'Отправитель';

  @override
  String get channelPath_timeLabel => 'Время';

  @override
  String get channelPath_repeatsLabel => 'Повторы';

  @override
  String channelPath_pathLabel(int index) {
    return 'Путь $index';
  }

  @override
  String get channelPath_observedLabel => 'Наблюдаемый';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return 'Наблюдаемый путь $index • $hops';
  }

  @override
  String get channelPath_noLocationData => 'Нет данных о местоположении';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => 'Неизвестный';

  @override
  String get channelPath_floodPath => 'Рассылка';

  @override
  String get channelPath_directPath => 'Прямой';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 из $total хопов';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed из $total хопов';
  }

  @override
  String get channelPath_mapTitle => 'Карта пути';

  @override
  String get channelPath_noRepeaterLocations =>
      'Нет данных о местоположении репитеров для этого пути.';

  @override
  String channelPath_primaryPath(int index) {
    return 'Путь $index (Основной)';
  }

  @override
  String get channelPath_pathLabelTitle => 'Путь';

  @override
  String get channelPath_observedPathHeader => 'Наблюдаемый путь';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable =>
      'Детали хопов для этого пакета недоступны.';

  @override
  String get channelPath_unknownRepeater => 'Неизвестный репитер';

  @override
  String get community_title => 'Сообщество';

  @override
  String get community_create => 'Создать сообщество';

  @override
  String get community_createDesc =>
      'Создать новое сообщество и поделиться через QR-код.';

  @override
  String get community_join => 'Присоединиться';

  @override
  String get community_joinTitle => 'Присоединиться к сообществу';

  @override
  String community_joinConfirmation(String name) {
    return 'Вы хотите присоединиться к сообществу  \"$name\"?';
  }

  @override
  String get community_scanQr => 'Сканировать QR-код сообщества';

  @override
  String get community_scanInstructions =>
      'Наведите камеру на QR-код сообщества';

  @override
  String get community_showQr => 'Показать QR-код';

  @override
  String get community_publicChannel => 'Публичный канал сообщества';

  @override
  String get community_hashtagChannel => 'Хэштег-канал сообщества';

  @override
  String get community_name => 'Имя сообщества';

  @override
  String get community_enterName => 'Введите имя сообщества';

  @override
  String community_created(String name) {
    return 'Сообщество \"$name\" создано';
  }

  @override
  String community_joined(String name) {
    return 'Присоединились к сообществу \"$name\"';
  }

  @override
  String get community_qrTitle => 'Поделиться сообществом';

  @override
  String community_qrInstructions(String name) {
    return 'Отсканируйте этот QR-код, чтобы присоединиться к \"$name\"';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'Хэштег-каналы сообщества доступны только его участникам';

  @override
  String get community_invalidQrCode => 'Недопустимый QR-код сообщества';

  @override
  String get community_alreadyMember => 'Уже участник';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'Вы уже участник сообщества \"$name\".';
  }

  @override
  String get community_addPublicChannel =>
      'Добавить публичный канал сообщества';

  @override
  String get community_addPublicChannelHint =>
      'Автоматически добавить публичный канал для этого сообщества';

  @override
  String get community_noCommunities =>
      'Вы ещё не присоединились ни к одному сообществу';

  @override
  String get community_scanOrCreate =>
      'Отсканируйте QR-код или создайте сообщество, чтобы начать';

  @override
  String get community_manageCommunities => 'Управление сообществами';

  @override
  String get community_delete => 'Покинуть сообщество';

  @override
  String community_deleteConfirm(String name) {
    return 'Покинуть \"$name\"?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return 'Это также удалит $count канал(ов) и их сообщения.';
  }

  @override
  String community_deleted(String name) {
    return 'Покинули сообщество \"$name\"';
  }

  @override
  String get community_regenerateSecret => 'Пересоздать секрет';

  @override
  String community_regenerateSecretConfirm(String name) {
    return 'Пересоздать секретный ключ для \"$name\"? Все участники должны будут отсканировать новый QR-код для продолжения общения.';
  }

  @override
  String get community_regenerate => 'Пересоздать';

  @override
  String community_secretRegenerated(String name) {
    return 'Секрет пересоздан для \"$name\"';
  }

  @override
  String get community_updateSecret => 'Обновить секрет';

  @override
  String community_secretUpdated(String name) {
    return 'Секрет обновлён для \"$name\"';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return 'Отсканируйте новый QR-код, чтобы обновить секрет для \"$name\"';
  }

  @override
  String get community_addHashtagChannel => 'Добавить хэштег-канал сообщества';

  @override
  String get community_addHashtagChannelDesc =>
      'Добавить хэштег-канал для этого сообщества';

  @override
  String get community_selectCommunity => 'Выбрать сообщество';

  @override
  String get community_regularHashtag => 'Обычный хэштег';

  @override
  String get community_regularHashtagDesc =>
      'Публичный хэштег (любой может присоединиться)';

  @override
  String get community_communityHashtag => 'Хэштег сообщества';

  @override
  String get community_communityHashtagDesc =>
      'Доступен только участникам сообщества';

  @override
  String community_forCommunity(String name) {
    return 'Для $name';
  }

  @override
  String get listFilter_tooltip => 'Фильтр и сортировка';

  @override
  String get listFilter_sortBy => 'Сортировка по';

  @override
  String get listFilter_latestMessages => 'Последние сообщения';

  @override
  String get listFilter_heardRecently => 'Слышали недавно';

  @override
  String get listFilter_az => 'По алфавиту';

  @override
  String get listFilter_filters => 'Фильтры';

  @override
  String get listFilter_all => 'Все';

  @override
  String get listFilter_favorites => 'Избранное';

  @override
  String get listFilter_addToFavorites => 'Добавить в избранное';

  @override
  String get listFilter_removeFromFavorites => 'Удалить из избранного';

  @override
  String get listFilter_users => 'Пользователи';

  @override
  String get listFilter_repeaters => 'Репитеры';

  @override
  String get listFilter_roomServers => 'Серверы комнат';

  @override
  String get listFilter_unreadOnly => 'Только непрочитанные';

  @override
  String get listFilter_newGroup => 'Новая группа';

  @override
  String get pathTrace_you => 'Вы';

  @override
  String get pathTrace_failed => 'Путь трассировки не выполнен.';

  @override
  String get pathTrace_notAvailable => 'Трассировка пути недоступна.';

  @override
  String get pathTrace_refreshTooltip => 'Обновить Path Trace';

  @override
  String get pathTrace_someHopsNoLocation =>
      'Одному или нескольким хмелям не указано местоположение!';

  @override
  String get pathTrace_clearTooltip => 'Очистить путь';

  @override
  String get losSelectStartEnd => 'Выберите начальный и конечный узлы для LOS.';

  @override
  String losRunFailed(String error) {
    return 'Проверка прямой видимости не удалась: $error';
  }

  @override
  String get losClearAllPoints => 'Очистить все точки';

  @override
  String get losRunToViewElevationProfile =>
      'Запустите LOS, чтобы просмотреть профиль высот.';

  @override
  String get losMenuTitle => 'ЛОС Меню';

  @override
  String get losMenuSubtitle =>
      'Коснитесь узлов или нажмите и удерживайте карту для выбора пользовательских точек.';

  @override
  String get losShowDisplayNodes => 'Показать узлы отображения';

  @override
  String get losCustomPoints => 'Пользовательские точки';

  @override
  String losCustomPointLabel(int index) {
    return 'Пользовательский $index';
  }

  @override
  String get losPointA => 'Точка А';

  @override
  String get losPointB => 'Точка Б';

  @override
  String losAntennaA(String value, String unit) {
    return 'Антенна А: $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return 'Антенна Б: $value $unit';
  }

  @override
  String get losRun => 'Запустить ЛОС';

  @override
  String get losNoElevationData => 'Нет данных о высоте';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, свободная зона видимости, минимальный зазор $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, заблокирован $obstruction $heightUnit';
  }

  @override
  String get losStatusChecking => 'ЛОС: проверяю...';

  @override
  String get losStatusNoData => 'ЛОС: нет данных';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS: $clear/$total очищено, $blocked заблокировано, $unknown неизвестно.';
  }

  @override
  String get losErrorElevationUnavailable =>
      'Данные о высоте недоступны для одного или нескольких образцов.';

  @override
  String get losErrorInvalidInput =>
      'Неверные данные о точках/высоте для расчета LOS.';

  @override
  String get losRenameCustomPoint => 'Переименовать пользовательскую точку';

  @override
  String get losPointName => 'Имя точки';

  @override
  String get losShowPanelTooltip => 'Показать панель LOS';

  @override
  String get losHidePanelTooltip => 'Скрыть панель LOS';

  @override
  String get losElevationAttribution =>
      'Данные о высоте: Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'Радиогоризонт';

  @override
  String get losLegendLosBeam => 'Линия прямой видимости';

  @override
  String get losLegendTerrain => 'Рельеф';

  @override
  String get losBlockedSpotsTitle => 'Зарезервированные места';

  @override
  String get losBlockedSpotsHint =>
      'Щелкните по заблокированной области, чтобы выделить ее на карте.';

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
  String get losSelectedObstructionTitle =>
      'Выбранный объект, препятствующий движению';

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
  String get losFrequencyLabel => 'Частота';

  @override
  String get losFrequencyInfoTooltip => 'Просмотреть детали расчёта';

  @override
  String get losFrequencyDialogTitle => 'Расчёт радиогоризонта';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'Начиная с k=$baselineK на частоте $baselineFreq МГц, расчет корректирует коэффициент k для текущего диапазона $frequencyMHz МГц, который определяет изогнутую границу радиогоризонта.';
  }

  @override
  String get contacts_pathTrace => 'Трассировка пути';

  @override
  String get contacts_ping => 'Пинговать';

  @override
  String get contacts_repeaterPathTrace => 'Отследить путь к ретранслятору';

  @override
  String get contacts_repeaterPing => 'Пинговать повторитель';

  @override
  String get contacts_roomPathTrace => 'Трассировка пути к серверу комнаты';

  @override
  String get contacts_roomPing => 'Пинговать сервер комнаты';

  @override
  String get contacts_chatTraceRoute => 'Трассировка маршрута';

  @override
  String contacts_pathTraceTo(String name) {
    return 'Показать маршрут к $name';
  }

  @override
  String get contacts_clipboardEmpty => 'Буфер обмена пуст.';

  @override
  String get contacts_invalidAdvertFormat =>
      'Недействительные контактные данные';

  @override
  String get contacts_contactImported => 'Контакт был импортирован';

  @override
  String get contacts_contactImportFailed => 'Контакт не удалось импортировать';

  @override
  String get contacts_zeroHopAdvert => 'Реклама Zero Hop';

  @override
  String get contacts_floodAdvert => 'Рекламный поток';

  @override
  String get contacts_copyAdvertToClipboard =>
      'Копировать рекламу в буфер обмена';

  @override
  String get contacts_addContactFromClipboard =>
      'Добавить контакт из буфера обмена';

  @override
  String get contacts_ShareContact => 'Копировать контакт в буфер обмена';

  @override
  String get contacts_ShareContactZeroHop =>
      'Поделиться контактом по объявлению';

  @override
  String get contacts_zeroHopContactAdvertSent =>
      'Отправлено сообщение по объявлению.';

  @override
  String get contacts_zeroHopContactAdvertFailed =>
      'Не удалось отправить контакт.';

  @override
  String get contacts_contactAdvertCopied =>
      'Реклама скопирована в буфер обмена.';

  @override
  String get contacts_contactAdvertCopyFailed =>
      'Копирование рекламы в буфер обмена не удалось.';

  @override
  String get notification_activityTitle => 'Активность MeshCore';

  @override
  String notification_messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'сообщений',
      many: 'сообщений',
      few: 'сообщения',
      one: 'сообщение',
    );
    return '$count $_temp0';
  }

  @override
  String notification_channelMessagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'сообщений канала',
      many: 'сообщений канала',
      few: 'сообщения канала',
      one: 'сообщение канала',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'новых узлов',
      many: 'новых узлов',
      few: 'новых узла',
      one: 'новый узел',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return 'Обнаружен новый $contactType';
  }

  @override
  String get notification_receivedNewMessage => 'Получено новое сообщение';

  @override
  String get settings_gpxExportRepeaters =>
      'Экспортировать рипитеры / сервер комнаты в GPX';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'Экспортирует ретрансляторы / сервер комнат с местоположением в файл GPX.';

  @override
  String get settings_gpxExportContacts => 'Экспортировать спутников в GPX';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'Экспортирует спутников с местоположением в файл GPX.';

  @override
  String get settings_gpxExportAll => 'Экспортировать все контакты в GPX';

  @override
  String get settings_gpxExportAllSubtitle =>
      'Экспортирует все контакты с местоположением в файл GPX.';

  @override
  String get settings_gpxExportSuccess => 'Успешно экспортирован файл GPX.';

  @override
  String get settings_gpxExportNoContacts => 'Нет контактов для экспорта.';

  @override
  String get settings_gpxExportNotAvailable =>
      'Не поддерживается на вашем устройстве/ОС';

  @override
  String get settings_gpxExportError => 'Произошла ошибка при экспорте.';

  @override
  String get settings_gpxExportRepeatersRoom =>
      'Местоположения повторителей и серверов комнат';

  @override
  String get settings_gpxExportChat => 'Местоположения спутников';

  @override
  String get settings_gpxExportAllContacts => 'Все местоположения контактов';

  @override
  String get settings_gpxExportShareText =>
      'Данные карты экспортированы из NOTORYX Core';

  @override
  String get settings_gpxExportShareSubject =>
      'NOTORYX Core экспорт данных карты GPX';

  @override
  String get snrIndicator_nearByRepeaters => 'Ближайшие ретрансляторы';

  @override
  String get snrIndicator_lastSeen => 'Последний раз видели';

  @override
  String get contactsSettings_title => 'Настройки контактов';

  @override
  String get contactsSettings_autoAddTitle => 'Автоматическое обнаружение';

  @override
  String get contactsSettings_otherTitle =>
      'Другие настройки, связанные с контактами';

  @override
  String get contactsSettings_autoAddUsersTitle =>
      'Автоматически добавлять пользователей';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      'Разрешить компаньону автоматически добавлять обнаруженных пользователей';

  @override
  String get contactsSettings_autoAddRepeatersTitle =>
      'Автоматически добавлять ретрансляторы';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      'Разрешить спутнику автоматически добавлять обнаруженные ретрансляторы';

  @override
  String get contactsSettings_autoAddRoomServersTitle =>
      'Автоматически добавлять серверы комнат';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      'Разрешить компаньону автоматически добавлять обнаруженные сервера комнат.';

  @override
  String get contactsSettings_autoAddSensorsTitle =>
      'Автоматически добавлять датчики';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      'Разрешить компаньону автоматически добавлять обнаруженные датчики';

  @override
  String get contactsSettings_overwriteOldestTitle =>
      'Перезаписать самое старое';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      'Когда список контактов заполнен, будет заменен самый старый контакт, который не находится в избранном.';

  @override
  String get discoveredContacts_Title => 'Обнаруженные контакты';

  @override
  String get discoveredContacts_noMatching => 'Нет совпадающих контактов';

  @override
  String get discoveredContacts_searchHint => 'Найденные контакты поиска';

  @override
  String get discoveredContacts_contactAdded => 'Контакт добавлен';

  @override
  String get discoveredContacts_addContact => 'Добавить контакт';

  @override
  String get discoveredContacts_copyContact =>
      'Копировать контакт в буфер обмена';

  @override
  String get discoveredContacts_deleteContact => 'Удалить контакт';

  @override
  String get discoveredContacts_deleteContactAll =>
      'Удалить Все Обнаруженные Контакты';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      'Вы уверены, что хотите удалить все обнаруженные контакты?';

  @override
  String get chat_sendCooldown =>
      'Пожалуйста, подождите немного, прежде чем отправлять сообщение снова.';

  @override
  String get appSettings_jumpToOldestUnread =>
      'Перейти к самому старому непрочитанному сообщению';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      'При открытии чата с непрочитанными сообщениями, прокрутите страницу, чтобы увидеть первое непрочитанное сообщение, а не последнее.';

  @override
  String get appSettings_languageHu => 'Венгерский';

  @override
  String get appSettings_languageJa => 'Японский';

  @override
  String get appSettings_languageKo => 'Корейский';

  @override
  String get radioStats_tooltip => 'Статистика радио и беспроводной сети';

  @override
  String get radioStats_screenTitle => 'Статистика радиовещания';

  @override
  String get radioStats_notConnected =>
      'Подключитесь к устройству, чтобы просмотреть статистику радио.';

  @override
  String get radioStats_firmwareTooOld =>
      'Для работы радиостатистики требуется установленная версия прошивки v8 или более новая.';

  @override
  String get radioStats_waiting => 'Ожидаем данных…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'Уровень шума: $noiseDbm дБм';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return 'Последнее значение RSSI: $rssiDbm дБм';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return 'Последнее значение SNR: $snr дБ';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'Время эфира на телеканале TX (общее): $seconds секунд';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'Общее время использования RX (в секундах): $seconds с';
  }

  @override
  String get radioStats_chartCaption =>
      'Уровень шума (дБм) на основе последних измерений.';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'Уровень шума: $noiseDbm дБм';
  }

  @override
  String get radioStats_stripWaiting => 'Получение данных о радио…';

  @override
  String get radioStats_settingsTile => 'Статистика радиовещания';

  @override
  String get radioStats_settingsSubtitle =>
      'Уровень шума, RSSI, SNR и время передачи';

  @override
  String get translation_title => 'Перевод';

  @override
  String get imageMessages_enableTitle => 'Включить изображения в сообщения';

  @override
  String get imageMessages_enableSubtitle =>
      'Отправьте изображения через сеть. Требуется однократная загрузка шаблона изображения.';

  @override
  String get imageMessages_modelSectionTitle => 'Модель изображения';

  @override
  String get imageMessages_downloadModel => 'Скачать';

  @override
  String get imageMessages_cancelDownload => 'Отмена';

  @override
  String get imageMessages_removeModel => 'Удалить модель';

  @override
  String get imageMessages_modelReady => 'Готов';

  @override
  String get imageMessages_modelNotPublished =>
      'Пока не опубликовано — эта сборка не может скачать это.';

  @override
  String get imageMessages_downloadFailed =>
      'Модель изображения не удалось скачать.';

  @override
  String get imageMessages_autoProcessTitle =>
      'Автоматически обрабатывать изображения';

  @override
  String get imageMessages_autoProcessSubtitle =>
      'Примерно каждое изображение реконструируйте сразу после его поступления. Для этого на каждый раз используется около 2 ГБ памяти; отключите реконструкцию касанием.';

  @override
  String get translation_enableTitle => 'Включить перевод';

  @override
  String get translation_enableSubtitle =>
      'Переводить входящие сообщения и позволять предварительный перевод перед отправкой.';

  @override
  String get translation_composerTitle => 'Переводить перед отправкой';

  @override
  String get translation_composerSubtitle =>
      'Управляет исходным состоянием значка перевода, предоставляемого редактором.';

  @override
  String get translation_autoIncomingTitle =>
      'Автоматически переводить сообщения';

  @override
  String get translation_autoIncomingSubtitle =>
      'Автоматически переводит сообщения для уведомлений, а также для чатов и каналов.';

  @override
  String get translation_translateMessage => 'Перевести сообщение';

  @override
  String get translation_targetLanguage => 'Целевой язык';

  @override
  String get translation_useAppLanguage => 'Используйте язык приложения';

  @override
  String get translation_downloadedModelLabel => 'Загруженная модель';

  @override
  String get translation_presetModelLabel =>
      'Предопределенная модель от Hugging Face';

  @override
  String get translation_manualUrlLabel => 'Ссылка на руководство';

  @override
  String get translation_downloadModel => 'Скачать модель';

  @override
  String get translation_downloading => 'Загрузка...';

  @override
  String get translation_working => 'Работа...';

  @override
  String get translation_stop => 'Прекратите';

  @override
  String get translation_mergingChunks =>
      'Объединение скачанных фрагментов в один финальный файл...';

  @override
  String get translation_downloadedModels => 'Загруженные модели';

  @override
  String get translation_deleteModel => 'Удалить модель';

  @override
  String get translation_modelDownloaded => 'Модель перевода загружена.';

  @override
  String get translation_downloadStopped => 'Процесс загрузки был прерван.';

  @override
  String translation_downloadFailed(String error) {
    return 'Не удалось скачать: $error';
  }

  @override
  String get translation_enterUrlFirst => 'Сначала введите URL модели.';

  @override
  String get scanner_linuxPairingShowPin => 'Показать PIN';

  @override
  String get scanner_linuxPairingHidePin => 'Скрыть PIN';

  @override
  String get scanner_linuxPairingPinTitle => 'PIN‑код сопряжения Bluetooth';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return 'Введите PIN‑код для $deviceName (оставьте пустым, если нет).';
  }

  @override
  String get translation_messageTranslation => 'Перевод сообщения';

  @override
  String get translation_translateBeforeSending => 'Перевести перед отправкой';

  @override
  String get translation_composerEnabledHint =>
      'Сообщения будут переведены перед отправкой.';

  @override
  String get translation_composerDisabledHint =>
      'Отправляйте сообщения на языке, в котором они были изначально набраны.';

  @override
  String translation_translateTo(String language) {
    return 'Перевести на $language';
  }

  @override
  String get translation_translationOptions => 'Варианты перевода';

  @override
  String get translation_systemLanguage => 'Язык системы';

  @override
  String get background_serviceTitle => 'MeshCore работает';

  @override
  String get background_serviceText => 'Поддерживает BLE-соединение';

  @override
  String appSettings_translationModelDeleted(String name) {
    return 'Удалено $name';
  }

  @override
  String appSettings_translationModelDeleteFailed(String error) {
    return 'Не удалось удалить: $error';
  }

  @override
  String channels_channelUpdateFailed(String error) {
    return 'Не удалось обновить канал: $error';
  }

  @override
  String get contact_typeChat => 'Чат';

  @override
  String get contact_typeRepeater => 'Ретранслятор';

  @override
  String get contact_typeRoom => 'Комната';

  @override
  String get contact_typeSensor => 'Датчик';

  @override
  String get contact_typeUnknown => 'Неизвестно';

  @override
  String get map_zoomIn => 'Увеличить масштаб';

  @override
  String get map_zoomOut => 'Увеличить масштаб';

  @override
  String get map_centerMap => 'Карта центра';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'Для работы Web Bluetooth требуется браузер на основе Chromium.';

  @override
  String channels_communityShortId(String id) {
    return 'Идентификатор: $id...';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'GPS подтверждено';

  @override
  String get pathTrace_legendInferred => 'Выведенная позиция';

  @override
  String get pathMap_viewSingle => 'Одиночный';

  @override
  String get pathMap_viewCombined => 'Объединённые';

  @override
  String get pathMap_play => 'Воспроизвести';

  @override
  String get pathMap_pause => 'Пауза';

  @override
  String get pathMap_replay => 'Повтор';

  @override
  String get pathMap_stepBack => 'Предыдущий хоп';

  @override
  String get pathMap_stepForward => 'Следующий хоп';

  @override
  String get pathMap_animationOn => 'Показать анимацию пакета';

  @override
  String get pathMap_animationOff => 'Скрыть анимацию пакета';

  @override
  String pathMap_hopOf(int current, int total) {
    return 'Хоп $current из $total';
  }

  @override
  String pathMap_observedPaths(int count) {
    return 'Наблюдаемые маршруты: $count';
  }

  @override
  String get pathMap_primary => 'Основной';

  @override
  String pathMap_alternate(int index) {
    return 'Альт $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count хопов',
      many: '$count хопов',
      few: '$count хопа',
      one: '$count хоп',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => 'Общий сегмент';

  @override
  String get pathMap_legendEstimated => 'Расчётный сегмент';

  @override
  String pathMap_sharedNodeCount(int count) {
    return 'Используется в $count маршрутах';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count хопов не имеют координат — показанный путь неполный',
      many: '$count хопов не имеют координат — показанный путь неполный',
      few: '$count хопа не имеют координат — показанный путь неполный',
      one: '$count хоп не имеет координат — показанный путь неполный',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'Показать всё';

  @override
  String get pathMap_hidePath => 'Скрыть путь';

  @override
  String get pathMap_showPath => 'Показать маршрут';

  @override
  String get pathMap_collapsePanel => 'Скрыть панель';

  @override
  String get pathMap_expandPanel => 'Расширить панель';

  @override
  String get pathMap_noLocation => 'Нет координат';

  @override
  String get pathMap_followPacket => 'Следить за пакетом';

  @override
  String get pathMap_unfollowPacket => 'Не следить за пакетом';

  @override
  String get imageSend_title => 'Отправьте изображение';

  @override
  String get imageSend_cropNote =>
      'Меняется размер на 512 × 512 · соотношение сторон не сохраняется';

  @override
  String get imageSend_originalSize => 'Оригинал';

  @override
  String get imageSend_onAirSize => 'В эфире';

  @override
  String get imageSend_quality => 'Качество';

  @override
  String get imageSend_qualityStandard => 'Стандарт';

  @override
  String get imageSend_qualityHigh => 'Высота';

  @override
  String get imageSend_packetsLabel => 'Пакеты';

  @override
  String get imageSend_airtimeLabel => 'Время на эфире';

  @override
  String get imageSend_sizeLabel => 'Пакет';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'пакета',
      many: 'пакетов',
      few: 'пакета',
      one: 'пакет',
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
  String get imageSend_radioUnknownTitle => 'Настройки радио неизвестны';

  @override
  String get imageSend_radioUnknownBody =>
      'Подключитесь к устройству, чтобы можно было рассчитать время эфирного времени.';

  @override
  String get imageSend_longSendTitle => 'Долгая передача';

  @override
  String imageSend_longSendBody(String duration) {
    return 'Это будет поддерживать канал примерно $duration.';
  }

  @override
  String get imageSend_floodNote =>
      'Руководство по маршрутизации потоков: каждый ретрансатор в зоне перераспределяет каждый пакет, поэтому канал остаётся занятным дольше, чем это.';

  @override
  String get imageSend_parityTitle => 'Пакет восстановления';

  @override
  String get imageSend_paritySubtitle =>
      'Один дополнительный пакет. Групповые сообщения не подтверждаются, поэтому это позволяет получателю восстановить изображение, если один пакет потерян.';

  @override
  String get imageSend_send => 'Отправить';

  @override
  String get imageSend_cancel => 'Отмена';

  @override
  String get imageSend_encodeFailed =>
      'Это изображение не может быть закодировано.';

  @override
  String get imageSend_codecDownloading =>
      'Модель изображения всё ещё загружается.';

  @override
  String get imageSend_codecUnavailable =>
      'Отправка изображения на этом устройстве недоступна.';

  @override
  String get imageSend_codecDisabled =>
      'В настройках отключены сообщения с изображениями.';

  @override
  String get imageSend_deviceUnsupported =>
      'Это радио не может отправлять пакеты изображений. Подключите устройство, работающее на прошивке-компаньоне версии 13 или выше.';

  @override
  String get imageSend_directMessagesUnsupported =>
      'Изображения передаются как групповые данные, поэтому их можно отправлять только в канал, а не в личное сообщение.';

  @override
  String get imageSend_tooLarge =>
      'Изображение было закодировано в больше пакетов, чем позволяет формат сетки.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'пакетов',
      one: 'пакет',
    );
    return 'Изображение отправлено как $count $_temp0.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return 'Изображение не может быть отправлено: $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return 'Отправка изображения — пакет $sent из $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'Узел $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return '$received из $total пакетов';
  }

  @override
  String get receivedImage_queued => 'Ожидание расшифровки';

  @override
  String get receivedImage_tapToDecode => 'Нажмите для декодирования';

  @override
  String get receivedImage_decoding => 'Реконструкция… примерно за 1 секунду';

  @override
  String receivedImage_incomplete(int received, int total) {
    return 'Отсутствует изображение — $received из $total пакетов пришло';
  }

  @override
  String get receivedImage_corrupt => 'Изображение не может быть восстановлено';

  @override
  String get receivedImage_decoderMissing =>
      'Получен изображение — декодирование изображения неправильное';

  @override
  String get receivedImage_evicted => 'Изображение больше не сохраняется';

  @override
  String get receivedImage_retry => 'Попробуйте снова';

  @override
  String get receivedImage_decodeAgain => 'Декодируйте снова';

  @override
  String get receivedImage_openSettings => 'Настройте';

  @override
  String get receivedImage_tapToProcess => 'Нажмите для обработки';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'пакетов',
      one: 'пакет',
    );
    return '$bytes байт · $packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds секунд';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes м $seconds с';
  }

  @override
  String get bastion_tagline => 'Связь без инфраструктуры.';

  @override
  String get bastion_nodes => 'УЗЛЫ';

  @override
  String get bastion_repeaters => 'РЕТРАНСЛЯТОРЫ';

  @override
  String get bastion_active1h => 'АКТИВНЫ 1 Ч';

  @override
  String get bastion_mapCoverage => 'КАРТА + ПОКРЫТИЕ';

  @override
  String get bastion_routeIntelligence => 'АНАЛИЗ МАРШРУТОВ';

  @override
  String get bastion_repeaterTools => 'ИНСТРУМЕНТЫ РЕТРАНСЛЯТОРА';

  @override
  String get bastion_fieldStats => 'ПОЛЕВАЯ СТАТИСТИКА';

  @override
  String get bastion_fieldOps => 'ПОХОД + ПОЛЕВЫЕ ОПЕРАЦИИ';

  @override
  String get bastion_coverageCapture => 'ЗАПИСЬ ПОКРЫТИЯ';

  @override
  String get bastion_mapAttribution =>
      'Данные карты © участники OpenStreetMap; тайлы выбранного поставщика';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count наблюдения',
      many: '$count наблюдений',
      few: '$count наблюдения',
      one: '$count наблюдение',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count уникального узла',
      many: '$count уникальных узлов',
      few: '$count уникальных узла',
      one: '$count уникальный узел',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count перехода',
      many: '$count переходов',
      few: '$count перехода',
      one: '$count переход',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count минуты',
      many: '$count минут',
      few: '$count минуты',
      one: '$count минута',
    );
    return '$_temp0';
  }

  @override
  String get sos_holdHint =>
      'Удерживайте 2 секунды. Отправляет ваше местоположение контактам похода каждые 5 минут, пока кто-нибудь не ответит.';

  @override
  String sos_holdHintChannel(String channel) {
    return 'Удерживайте 2 секунды. Отправляет ваше местоположение контактам похода и в $channel каждые 5 минут, пока кто-нибудь не ответит.';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS не отправлен: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return 'Подтверждено: $name. Повторы остановлены.';
  }

  @override
  String get sos_waitingForRadio => 'Ожидание отправки радиостанцией…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return 'Отправлено $sends из $max раз. Повторы завершены; ответа пока нет.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return 'Отправлено $sends из $max раз. Следующий в $time.';
  }

  @override
  String get sos_active => 'SOS АКТИВЕН';

  @override
  String get sos_stop => 'СТОП';

  @override
  String get sos_imSafe => 'Я В БЕЗОПАСНОСТИ';

  @override
  String get sos_holdSemantics => 'SOS. Удерживайте, чтобы отправить.';

  @override
  String get sos_keepHolding => 'ПРОДОЛЖАЙТЕ УДЕРЖИВАТЬ…';

  @override
  String get sos_holdForSos => 'УДЕРЖИВАЙТЕ ДЛЯ SOS';

  @override
  String get sos_blockStorage =>
      'Сначала устраните ошибку хранения полевого журнала.';

  @override
  String get sos_blockNotConnected =>
      'Подключите радиостанцию MeshCore, чтобы отправить SOS.';

  @override
  String get sos_blockNoTarget =>
      'Выберите контакты похода или канал SOS в разделе «Спланировать поход».';

  @override
  String get checkIn_labelOk => 'Всё в порядке';

  @override
  String get checkIn_labelAtCamp => 'В лагере';

  @override
  String get checkIn_labelDelayed => 'Задерживаюсь';

  @override
  String get checkIn_labelHeadingBack => 'Возвращаюсь';

  @override
  String get checkIn_blockLoading => 'Загрузка похода…';

  @override
  String get checkIn_blockStorage =>
      'Перед отправкой устраните ошибку хранения полевого журнала.';

  @override
  String get checkIn_blockBusy => 'Отметка отправляется. Подождите.';

  @override
  String get checkIn_blockNoContacts =>
      'Выберите контакты похода в разделе «Спланировать поход».';

  @override
  String get checkIn_blockRosterIncomplete =>
      'Некоторые контакты похода недоступны. Проверьте список.';

  @override
  String get checkIn_blockNotConnected =>
      'Подключите радиостанцию MeshCore, чтобы отметиться.';

  @override
  String get checkIn_blockNotActive => 'Начните поход, чтобы включить отметки.';

  @override
  String get checkIn_notSent => 'Не отправлено';

  @override
  String checkIn_deliveredToOne(String name) {
    return 'Доставлено: $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return 'Доставлено всем контактам ($count)';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return 'Доставлено $delivered из $total';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return 'Не доставлено: $names';
  }

  @override
  String get checkIn_waitingForRest => 'Ожидание остальных';

  @override
  String get checkIn_aContact => 'контакт';

  @override
  String get checkIn_statusPending => 'Ожидает';

  @override
  String get checkIn_statusSent => 'Отправлено';

  @override
  String get checkIn_statusDelivered => 'Доставлено';

  @override
  String get checkIn_statusFailed => 'Ошибка';

  @override
  String get checkIn_explainPending =>
      'В локальной очереди. Это не подтверждает ни радиопередачу, ни получение.';

  @override
  String get checkIn_explainSent =>
      'Радиостанция приняла отправку. Подтверждение доставки не зарегистрировано.';

  @override
  String get checkIn_explainDelivered =>
      'Приложение зарегистрировало подтверждение доставки. Это не доказывает, что человек его прочитал.';

  @override
  String get checkIn_explainFailed =>
      'Доставка не подтверждена. Проверьте радиосвязь, доступность получателя и историю повторов.';

  @override
  String get checkIn_explainUnknown =>
      'Состояние доставки недоступно. Не считайте, что сообщение дошло.';

  @override
  String get tripBrief_heading => 'NOTORYX • Сводка похода MeshCore';

  @override
  String tripBrief_trip(String name) {
    return 'Поход: $name';
  }

  @override
  String tripBrief_status(String status) {
    return 'Состояние: $status';
  }

  @override
  String get tripBrief_active => 'Активен';

  @override
  String get tripBrief_stopped => 'Остановлен';

  @override
  String tripBrief_contacts(String names) {
    return 'Контакты: $names';
  }

  @override
  String get tripBrief_noneSelected => 'Не выбраны';

  @override
  String get tripBrief_unavailableContact =>
      'Недоступный контакт (проверьте список)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return 'Активность просрочена через: $minutes мин (этот телефон предупреждает, когда контакт замолкает)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'Напоминание об отметке: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return 'каждые $minutes мин без отметки';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'Варианты отметки: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'Местоположение радиостанции в отметках: $value';
  }

  @override
  String get tripBrief_includedMayBeStale => 'Включено; может быть устаревшим';

  @override
  String tripBrief_battery(String value) {
    return 'Заряд радиостанции в отметках: $value';
  }

  @override
  String get tripBrief_included => 'Включено';

  @override
  String get tripBrief_off => 'Выкл.';

  @override
  String get tripBrief_review =>
      'Проверьте получателей и сообщение перед отправкой отметки.';

  @override
  String get tripBrief_noProof =>
      '«В очереди» или «отправлено» не доказывает доставку. Подтверждение не доказывает прочтение.';

  @override
  String get tripBrief_overdueMeaning =>
      'Просрочено означает отсутствие недавней активности контакта; это не подтверждённая чрезвычайная ситуация.';

  @override
  String get tripBrief_automations =>
      'Полевые автоматизации работают только при активном приложении. Договоритесь об отдельном плане на случай потери связи.';

  @override
  String get tripBrief_sharesOnly =>
      'Эта сводка только передаёт информацию; она не отправляет радиосообщение и не начинает поход.';

  @override
  String get fieldOps_title => 'Полевые операции NOTORYX Core';

  @override
  String get fieldOps_tabTrip => 'ПОХОД';

  @override
  String get fieldOps_tabReady => 'ГОТОВНОСТЬ';

  @override
  String get fieldOps_tabLog => 'ЖУРНАЛ';

  @override
  String get fieldOps_tabAuto => 'АВТО';

  @override
  String get fieldOps_tabCoverage => 'ПОКРЫТИЕ';

  @override
  String get fieldOps_tabConnection => 'СВЯЗЬ';

  @override
  String get fieldOps_diagnostics => 'Диагностика';

  @override
  String get fieldOps_storageLoadError =>
      'Не удалось загрузить полевые данные. Сохранённые данные сохранены; автоматизации остаются выключенными.';

  @override
  String get fieldOps_storageSaveError =>
      'Не удалось сохранить полевые данные. Автоматизации остановлены; ранее сохранённые данные сохранены.';

  @override
  String get fieldOps_regionHint =>
      'Выберите область и уровни масштаба в разделе «Офлайн-карты».';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • масштаб $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return 'Не удалось проверить область карты: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Поход активен • $count контакта',
      many: 'Поход активен • $count контактов',
      few: 'Поход активен • $count контакта',
      one: 'Поход активен • $count контакт',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped =>
      'Поход остановлен. Начните его, когда будете готовы.';

  @override
  String fieldOps_reminderAt(String time) {
    return 'Напоминание об отметке в $time';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return 'Слишком долго молчат: $names';
  }

  @override
  String get fieldOps_planTrip => 'Спланировать поход';

  @override
  String get fieldOps_endTrip => 'Завершить поход';

  @override
  String get fieldOps_startTrip => 'Начать поход';

  @override
  String get fieldOps_tripBrief => 'Сводка похода';

  @override
  String get fieldOps_connectRadio => 'Подключить радиостанцию';

  @override
  String get fieldOps_previewedCheckIns => 'Отметки с предпросмотром';

  @override
  String get fieldOps_previewedCheckInsHint =>
      'Выберите статус, проверьте фактических получателей и сообщение, затем отправьте. «В очереди» не значит «доставлено».';

  @override
  String get fieldOps_tripRoster => 'Состав похода';

  @override
  String get fieldOps_rosterEmpty =>
      'Выберите до шести известных контактов чата в разделе «Спланировать поход».';

  @override
  String get fieldOps_rosterCaveat =>
      '«Последний раз слышен» — свидетельство прошлой активности. Это не подтверждает текущую доступность. Отметки о просрочке означают отсутствие недавней активности контакта, а не подтверждённую чрезвычайную ситуацию.';

  @override
  String get fieldOps_offlineMaps => 'Офлайн-карты';

  @override
  String get fieldOps_checkingTiles => 'Проверка сохранённых тайлов…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count тайла в кэше.',
      many: '$count тайлов в кэше.',
      few: '$count тайла в кэше.',
      one: '$count тайл в кэше.',
    );
    return '$_temp0 Это не гарантирует покрытие всего маршрута.';
  }

  @override
  String get fieldOps_downloadAreas => 'Скачать / проверить офлайн-области';

  @override
  String fieldOps_lastCheckIn(String time) {
    return 'Последняя отметка, $time';
  }

  @override
  String fieldOps_deliveryChip(String name, String status) {
    return '$name: $status';
  }

  @override
  String get fieldOps_contactFallback => 'Контакт';

  @override
  String fieldOps_resendFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Отправить повторно $count недоставленным',
      many: 'Отправить повторно $count недоставленным',
      few: 'Отправить повторно $count недоставленным',
      one: 'Отправить повторно $count недоставленному',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable => 'Выбранный контакт недоступен';

  @override
  String get fieldOps_memberUnavailableHint =>
      'Проверьте поход перед отправкой.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return 'Последняя активность $minutes мин назад';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return 'Последняя активность $minutes мин назад • просрочено';
  }

  @override
  String get fieldOps_noCheckInRecorded => 'В этом журнале нет отметок.';

  @override
  String get fieldOps_tripMap => 'Карта похода';

  @override
  String get fieldOps_tripMapEmpty =>
      'Выбранные контакты ещё не передали координаты.';

  @override
  String get fieldOps_lastPositions => 'Последние переданные местоположения';

  @override
  String get fieldOps_positionsCaveat =>
      'Местоположения могут быть устаревшими. Эта карта не отслеживает GPS телефона и не доказывает, что участники сейчас здесь.';

  @override
  String get fieldOps_briefPreviewTitle => 'Предпросмотр сводки похода';

  @override
  String get fieldOps_briefPreviewHint =>
      'Содержит названия похода и имена контактов. Проверьте перед отправкой. Координаты, ключи и история сообщений не включены.';

  @override
  String get fieldOps_shareBrief => 'Поделиться сводкой';

  @override
  String get fieldOps_briefSubject => 'Сводка похода NOTORYX Core';

  @override
  String get fieldOps_tripName => 'Название похода';

  @override
  String get fieldOps_defaultTripName => 'Мой поход';

  @override
  String get fieldOps_includePosition =>
      'Включать переданное местоположение радиостанции';

  @override
  String get fieldOps_includePositionHint =>
      'Может быть устаревшим; по умолчанию отправка выключена.';

  @override
  String get fieldOps_includeBattery => 'Включать заряд радиостанции';

  @override
  String get fieldOps_overdueLabel =>
      'Предупреждать, если контакт молчит дольше';

  @override
  String get fieldOps_reminderLabel => 'Напоминать об отметке';

  @override
  String get fieldOps_reminderHelper =>
      'Уведомление на телефоне, даже если NOTORYX Core закрыт.';

  @override
  String get fieldOps_reminderOff => 'Выкл.';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Через $count минуты без отметки',
      many: 'Через $count минут без отметки',
      few: 'Через $count минуты без отметки',
      one: 'Через $count минуту без отметки',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'SOS также отправляется в канал';

  @override
  String get fieldOps_sosChannelNone => 'Нет';

  @override
  String get fieldOps_selectContacts =>
      'Выберите до шести известных контактов чата';

  @override
  String get fieldOps_sendCheckInTitle => 'Отправить отметку?';

  @override
  String fieldOps_recipients(String names) {
    return 'Кому: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      'Используются обычные личные сообщения. Доставка будет отслеживаться в полевом журнале.';

  @override
  String get fieldOps_send => 'Отправить';

  @override
  String get fieldOps_beforeYouLeave => 'Перед выходом';

  @override
  String get fieldOps_radioConnected => 'Радиостанция подключена';

  @override
  String get fieldOps_connectHint =>
      'Подключитесь через Bluetooth, USB или TCP.';

  @override
  String get fieldOps_radioBattery => 'Заряд радиостанции';

  @override
  String get fieldOps_batteryUnknown => 'Неизвестно; проверьте радиостанцию.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent% • зарядите для запланированного похода.';
  }

  @override
  String get fieldOps_tripContacts => 'Контакты похода';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return 'Доступно $available/$selected. Убедитесь, что у них совместимые радиостанции и каналы.';
  }

  @override
  String get fieldOps_offlineArea => 'Выбранная офлайн-область карты';

  @override
  String get fieldOps_checkingFiles => 'Проверка локальных файлов…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return 'Доступно файлов тайлов: $available/$expected; не хватает: $missing. Это снимок; откройте область офлайн перед выходом.';
  }

  @override
  String get fieldOps_locationChoice => 'Передача местоположения';

  @override
  String get fieldOps_locationOptedIn =>
      'Включено: переданные радиостанцией координаты могут быть устаревшими.';

  @override
  String get fieldOps_locationOff =>
      'Передача выключена. Ваши отметки не содержат координат.';

  @override
  String get fieldOps_automationAvailability => 'Доступность автоматизаций';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'Работает только при активном приложении. Сон, закрытие или потеря радиостанции могут помешать запланированным действиям.';

  @override
  String get fieldOps_readinessCaveat =>
      'Проверки готовности носят рекомендательный характер; они не доказывают дальность связи и не гарантируют доставку.';

  @override
  String get fieldOps_radio => 'Радио';

  @override
  String get fieldOps_refreshChecks => 'Обновить проверки';

  @override
  String get fieldOps_searchLog => 'Поиск в полевом журнале';

  @override
  String get fieldOps_kindAll => 'Все';

  @override
  String get fieldOps_kindCheckIn => 'Отметка';

  @override
  String get fieldOps_kindReceived => 'Получено';

  @override
  String get fieldOps_kindNote => 'Заметка';

  @override
  String get fieldOps_kindDeadZone => 'Мёртвая зона';

  @override
  String get fieldOps_kindRadio => 'Радио';

  @override
  String get fieldOps_kindAutomation => 'Автоматизация';

  @override
  String get fieldOps_kindMissed => 'Пропущено';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => 'Поход';

  @override
  String get fieldOps_kindOverdue => 'Просрочено';

  @override
  String get fieldOps_addNote => 'Добавить заметку';

  @override
  String get fieldOps_exportJson => 'Экспорт JSON';

  @override
  String get fieldOps_deleteLog => 'Удалить журнал';

  @override
  String get fieldOps_logSubject => 'Полевой журнал NOTORYX Core';

  @override
  String get fieldOps_logCaveat =>
      'Хранится локально, до 1000 записей. Экспорт может содержать ключи контактов, сообщения и местоположения; проверьте перед отправкой.';

  @override
  String get fieldOps_noEntries => 'Нет подходящих записей.';

  @override
  String get fieldOps_tripUnspecified => 'Поход не указан';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return 'Записанное переданное местоположение радиостанции $latitude, $longitude (может быть устаревшим)';
  }

  @override
  String get fieldOps_noteTitle => 'Полевое наблюдение';

  @override
  String get fieldOps_noteLabel => 'Что вы наблюдали?';

  @override
  String get fieldOps_deadZone => 'Отмеченная мёртвая зона';

  @override
  String get fieldOps_deadZoneHint =>
      'Ваше наблюдение, а не проверенный прогноз покрытия.';

  @override
  String get fieldOps_savePosition =>
      'Сохранить переданное местоположение радиостанции';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • может быть устаревшим; не GPS телефона';
  }

  @override
  String get fieldOps_noPosition => 'Нет пригодных переданных координат';

  @override
  String get fieldOps_deleteLogTitle => 'Удалить полевой журнал?';

  @override
  String get fieldOps_deleteLogBody =>
      'Будут удалены все сохранённые записи на этом телефоне. Настройки похода сохранятся.';

  @override
  String get fieldOps_localAutomations => 'Локальные автоматизации';

  @override
  String get fieldOps_enableForTrip => 'Включить для этого похода';

  @override
  String get fieldOps_automationsCaveat =>
      'Выключаются после каждого перезапуска приложения. Правила работают только при активном приложении. Пропущенные запланированные действия появляются в полевом журнале и никогда не выполняются пачкой задним числом. Автоматические отметки ограничены одной партией за 10 минут.';

  @override
  String get fieldOps_openBotMode => 'Открыть режим бота NOTORYX';

  @override
  String get fieldOps_ruleEnabled => 'Правило включено';

  @override
  String get fieldOps_dryRun => 'Пробный запуск';

  @override
  String get fieldOps_dryRunHint =>
      'Записать действие без отправки и уведомлений.';

  @override
  String get fieldOps_then => 'ТОГДА';

  @override
  String get fieldOps_actionLog => 'Записать в полевой журнал';

  @override
  String get fieldOps_actionNotify => 'Показать локальное уведомление';

  @override
  String get fieldOps_actionCheckIn => 'Отправить «I\'m OK» контактам похода';

  @override
  String get fieldOps_batteryThreshold => 'Заряд не выше';

  @override
  String fieldOps_nextDue(String time) {
    return 'Следующее: $time';
  }

  @override
  String get fieldOps_nextDueNone => 'Следующее: не запланировано';

  @override
  String get fieldOps_previewInLog => 'Предпросмотр в журнале';

  @override
  String get fieldOps_allowNotifications => 'Разрешить уведомления';

  @override
  String get fieldOps_triggerReconnect => 'КОГДА радиостанция переподключается';

  @override
  String get fieldOps_triggerDisconnect => 'КОГДА радиостанция отключается';

  @override
  String get fieldOps_triggerLowBattery =>
      'КОГДА заряд радиостанции пересекает порог';

  @override
  String get fieldOps_triggerNewNode => 'КОГДА добавлен новый узел';

  @override
  String get fieldOps_triggerRepeater => 'КОГДА добавлен новый ретранслятор';

  @override
  String get fieldOps_triggerScheduled =>
      'КОГДА наступает время запланированной отметки';

  @override
  String get fieldOps_explainConnection => 'Объяснить моё подключение';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return 'Состояние: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      'Телефон подключён к радиостанции. Само по себе это не обеспечивает маршрут к вашим получателям.';

  @override
  String get fieldOps_disconnectedHint =>
      'Нет активного радиоподключения. Проверьте разрешения Bluetooth, питание и дальность радиостанции; USB/TCP доступны в разделе «Подключить радиостанцию».';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return 'Отметки похода, ожидающие подтверждения: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'Время последнего появления и переданные местоположения узлов могут быть устаревшими. Анализ маршрутов показывает маршруты, выученные из наблюдаемых попыток; он не придумывает пути.';

  @override
  String get fieldOps_routeIntelligence => 'Анализ маршрутов';

  @override
  String get fieldOps_coverageIntelligence => 'Анализ покрытия';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      'Сравнивайте записанные наблюдения двух полевых сессий. Точки отмечают переданные местоположения записывающей радиостанции, где были слышны узлы. Они не означают непрерывного покрытия. Снимки RSSI/SNR — это не измерения по каждому узлу.';

  @override
  String get fieldOps_captureSession => 'Записать сессию';

  @override
  String get fieldOps_refreshHistory => 'Обновить историю';

  @override
  String get fieldOps_noCoverageSessions =>
      'Сохранённых сессий покрытия пока нет.';

  @override
  String get fieldOps_sessionA => 'Сессия A • бирюзовый';

  @override
  String get fieldOps_sessionB => 'Сессия B • янтарный';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: уникальных узлов $a • B: уникальных узлов $b';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return 'Общие: $shared • Только A: $onlyA • Только B: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'Если узел не слышен в одной сессии, это не доказывает мёртвую зону. Условия и длительность наблюдения различаются.';

  @override
  String get fieldOps_heardTooltip =>
      'Наблюдение услышанного узла; не доказательство успешной связи';

  @override
  String get fieldOps_noteTooltip =>
      'Локальная заметка в переданных координатах радиостанции; может быть устаревшей.';

  @override
  String get bastionHome_aboutTooltip => 'О NOTORYX Core';

  @override
  String get bastionHome_getStarted => 'НАЧАТЬ';

  @override
  String get bastionHome_getStartedHint =>
      'Подключите радиостанцию и проверьте первое сообщение';

  @override
  String get bastionHome_planYourTrip => 'СПЛАНИРУЙТЕ ПОХОД';

  @override
  String get bastionHome_tripActive => 'Поход активен';

  @override
  String get bastionHome_tripStopped => 'Поход остановлен';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • контактов: $contacts • непрочитанных: $unread';
  }

  @override
  String get bastionHome_checkInOk => 'ОТМЕТИТЬСЯ: ВСЁ В ПОРЯДКЕ';

  @override
  String get bastionHome_checkInHint =>
      'Проверьте контакты и сообщение перед отправкой. Следите за подтверждениями в полевом журнале.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return 'Последняя отметка: $summary';
  }

  @override
  String get bastionHome_connectRadio => 'ПОДКЛЮЧИТЬ РАДИОСТАНЦИЮ';

  @override
  String get bastionHome_connectRadioHint =>
      'Подключения MeshCore через Bluetooth, USB и TCP';

  @override
  String get bastionHome_liveDiagnostics => 'ДИАГНОСТИКА В РЕАЛЬНОМ ВРЕМЕНИ';

  @override
  String get bastionHome_liveDiagnosticsHint =>
      'Состояние радиостанции, сигнал, устройство и инструменты кадров';

  @override
  String get bastionHome_meshDiscovery => 'ОБНАРУЖЕНИЕ СЕТИ';

  @override
  String get bastionHome_meshDiscoveryHint =>
      'Находите узлы и изучайте сеть вокруг себя';

  @override
  String get bastionHome_fieldOpsHint =>
      'Сводка похода, готовность, полевой журнал, автоматизации и сравнение покрытия';

  @override
  String get bastionHome_fieldTools => 'ПОЛЕВЫЕ ИНСТРУМЕНТЫ NOTORYX';

  @override
  String get bastionHome_statusActive => 'АКТИВНО';

  @override
  String get bastionHome_consoleOnline => 'ПОЛЕВАЯ КОНСОЛЬ В СЕТИ';

  @override
  String get bastionHome_consoleReady => 'ПОЛЕВАЯ КОНСОЛЬ ГОТОВА';

  @override
  String get bastionHome_consoleHint =>
      'Подключите радиостанцию, чтобы включить панель в реальном времени.';

  @override
  String bastionHome_battery(String value) {
    return 'БАТ $value';
  }

  @override
  String get bastionTools_title => 'Полевые инструменты';

  @override
  String get bastionTools_backup => 'ЗАШИФРОВАННАЯ РЕЗЕРВНАЯ КОПИЯ';

  @override
  String get bastionTools_backupHint =>
      'Сохраните настройки, контакты и ключи, при желании с историей чатов';

  @override
  String get bastionTools_fieldOpsHint =>
      'Отметки, готовность, полевой журнал, автоматизации и сравнения';

  @override
  String get bastionTools_mapHint =>
      'Карта в реальном времени, сессии записи, инструменты офлайн-карт и регионы';

  @override
  String get bastionTools_pathAnalysis => 'АНАЛИЗ ПУТЕЙ';

  @override
  String get bastionTools_pathHint => 'Маршруты, обнаружение и анализ путей';

  @override
  String get bastionTools_repeaterHint =>
      'Состояние, вход, телеметрия, соседи и администрирование';

  @override
  String get bastionTools_statsHint =>
      'Счётчики сети в реальном времени и активность контактов';

  @override
  String get bastionTools_diagnostics => 'ДИАГНОСТИКА';

  @override
  String get bastionTools_diagnosticsHint =>
      'Состояние радиостанции, сведения об устройстве, сырые кадры и экспорт';

  @override
  String get bastionTools_about => 'О ПРИЛОЖЕНИИ + БЛАГОДАРНОСТИ';

  @override
  String get bastionTools_aboutHint =>
      'Версия NOTORYX Core, заявление о независимости и лицензии открытого ПО';

  @override
  String get bastionAbout_title => 'О приложении + Благодарности';

  @override
  String get bastionAbout_intro =>
      'Независимое общественное приложение-компаньон для сетей MeshCore. NOTORYX Core не является официальным приложением MeshCore, а включение ресурсов сообщества не означает партнёрства или одобрения.';

  @override
  String get bastionAbout_version => 'ВЕРСИЯ';

  @override
  String get bastionAbout_openSource => 'ОСНОВА С ОТКРЫТЫМ КОДОМ';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core создан на основе открытого кода MeshCore Open по лицензии MIT и изменяет его. Работа над сценарием покрытия также отмечает, где это применимо, приложение MeshMapper Flutter App по лицензии MIT.';

  @override
  String get bastionAbout_community => 'СООБЩЕСТВО ПРЕЖДЕ ВСЕГО';

  @override
  String get bastionAbout_communityBody =>
      'Ресурсы сторонних авторов остаются собственностью их авторов. Право собственности или партнёрство не подразумеваются.';

  @override
  String get bastionAbout_legalese =>
      'NOTORYX Core • Независимый компаньон MeshCore';

  @override
  String get bastionAbout_licenses => 'ЛИЦЕНЗИИ ОТКРЫТОГО ПО';

  @override
  String get bastionSetup_title => 'Начало работы с NOTORYX Core';

  @override
  String get bastionSetup_intro =>
      'Подключитесь, выберите контакт, затем проверьте сообщение. Вернуться к этому руководству можно с панели в любой момент.';

  @override
  String get bastionSetup_step1 => '1. Подключите радиостанцию MeshCore';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return 'Подключено к $device через $transport.';
  }

  @override
  String get bastionSetup_noRadio => 'Радиостанция ещё не подключена.';

  @override
  String get bastionSetup_step1Power =>
      'Включите радиостанцию-компаньон MeshCore. Откройте «Подключить радиостанцию» и выберите Bluetooth, USB или TCP. Предоставьте разрешения, запрошенные для выбранного подключения.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Если поиск Bluetooth ничего не находит, убедитесь, что Bluetooth включён и у NOTORYX Core есть разрешение «Устройства поблизости» в настройках приложений Android. Выполните все дополнительные запросы разрешений, которые показывает сканер.';

  @override
  String get bastionSetup_connectionDiagnostics => 'Диагностика подключения';

  @override
  String get bastionSetup_step2 => '2. Выберите контакт чата';

  @override
  String get bastionSetup_step2Body =>
      'Попросите партнёра поблизости с совместимыми настройками радиостанции MeshCore объявить свой узел. Выберите ниже известный контакт чата; ретрансляторы настраиваются отдельно.';

  @override
  String get bastionSetup_noContacts =>
      'Нет доступных контактов чата. Подключите радиостанцию и откройте «Обнаружение сети».';

  @override
  String get bastionSetup_testRecipient => 'Тестовый получатель';

  @override
  String get bastionSetup_meshDiscovery => 'Обнаружение сети';

  @override
  String get bastionSetup_step3 => '3. Отправьте и проверьте сообщение';

  @override
  String get bastionSetup_step3Body =>
      'Откройте чат, напишите короткое тестовое сообщение, проверьте получателя и нажмите «Отправить». Вернитесь сюда, чтобы увидеть последнее исходящее сообщение, записанное с момента открытия руководства.';

  @override
  String get bastionSetup_openTestChat => 'Открыть тестовый чат';

  @override
  String get bastionSetup_connectFirst =>
      'Подключите радиостанцию, чтобы открыть тестовый чат.';

  @override
  String get bastionSetup_chooseRecipient => 'Сначала выберите получателя.';

  @override
  String get bastionSetup_noTestMessage =>
      'В этой сессии руководства исходящих тестовых сообщений не записано.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return 'Последнее сообщение: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'Попросите партнёра подтвердить получение или ответить. Записанное подтверждение не доказывает прочтение. Если сообщение не дошло, перепроверьте подключение и получателя.';

  @override
  String get bastionSetup_step4 => '4. Подготовьтесь к выходу';

  @override
  String get bastionSetup_step4Body =>
      'Спланируйте контакты похода и проверьте скачанные области карт. Режим бота и полевые автоматизации изначально выключены; полевые автоматизации работают только при активном приложении.';

  @override
  String get bastionSetup_tripTools => 'Инструменты похода и готовности';

  @override
  String get bastionDiag_title => 'Диагностика';

  @override
  String get bastionDiag_export => 'Экспортировать диагностику';

  @override
  String get bastionDiag_channels => 'КАНАЛЫ';

  @override
  String get bastionDiag_radio => 'РАДИО';

  @override
  String get bastionDiag_frequency => 'Частота';

  @override
  String get bastionDiag_bandwidth => 'Полоса';

  @override
  String get bastionDiag_spreadingFactor => 'Коэффициент расширения';

  @override
  String get bastionDiag_codingRate => 'Скорость кодирования';

  @override
  String get bastionDiag_txPower => 'Мощность передачи';

  @override
  String get bastionDiag_noiseFloor => 'Уровень шума';

  @override
  String get bastionDiag_device => 'УСТРОЙСТВО';

  @override
  String get bastionDiag_name => 'Имя';

  @override
  String get bastionDiag_manufacturer => 'Производитель';

  @override
  String get bastionDiag_firmware => 'Прошивка';

  @override
  String get bastionDiag_battery => 'Батарея';

  @override
  String get bastionDiag_transport => 'Подключение';

  @override
  String get bastionDiag_deepTools => 'РАСШИРЕННЫЕ ИНСТРУМЕНТЫ';

  @override
  String get bastionDiag_liveStats => 'СТАТИСТИКА РАДИО В РЕАЛЬНОМ ВРЕМЕНИ';

  @override
  String get bastionDiag_liveStatsHint => 'Шум, RSSI, SNR и эфирное время';

  @override
  String get bastionDiag_frameDebug => 'ОТЛАДКА КАДРОВ / BLE';

  @override
  String get bastionDiag_frameDebugHint =>
      'Изучайте декодированные и сырые полученные кадры';

  @override
  String get bastionDiag_appLog => 'ЖУРНАЛ ОТЛАДКИ ПРИЛОЖЕНИЯ';

  @override
  String get bastionDiag_appLogHint =>
      'Просматривайте диагностические события приложения';

  @override
  String get bastionDiag_online => 'РАДИО В СЕТИ';

  @override
  String get bastionDiag_offline => 'РАДИО НЕ В СЕТИ';

  @override
  String get bastionDiag_offlineHint =>
      'Подключите компаньон MeshCore, чтобы заполнить диагностику в реальном времени.';

  @override
  String get coverage_title => 'Запись покрытия';

  @override
  String get coverage_leaveBlocked =>
      'Остановите и сохраните сессию перед выходом.';

  @override
  String get coverage_savedSessions => 'СОХРАНЁННЫЕ СЕССИИ';

  @override
  String get coverage_caveat =>
      'RSSI/SNR — снимки радиостанции и могут относиться к другому пакету. Местоположения — это координаты, переданные радиостанцией, а не GPS телефона и не доказательство покрытия. Голубой: записывающий; янтарный: переданный узел. Интерполяция не выполняется.';

  @override
  String get coverage_captureActive => 'ЗАПИСЬ АКТИВНА';

  @override
  String get coverage_fieldSession => 'ПОЛЕВАЯ СЕССИЯ ПОКРЫТИЯ';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core записывает впервые услышанные в этой сессии узлы, включая данные маршрута, метаданные узла/местоположения и ближайший доступный снимок RSSI/SNR радиостанции.';

  @override
  String get coverage_disconnectedBody =>
      'Перед началом подключите радиостанцию. Запись покрытия сохраняет наблюдения сети в реальном времени с подключённой радиостанции-компаньона.';

  @override
  String get coverage_observations => 'НАБЛЮДЕНИЯ';

  @override
  String get coverage_uniqueNodes => 'УНИКАЛЬНЫЕ УЗЛЫ';

  @override
  String get coverage_elapsed => 'ПРОШЛО';

  @override
  String get coverage_radioConnected => 'РАДИО ПОДКЛЮЧЕНО';

  @override
  String get coverage_noRadio => 'НЕТ РАДИО';

  @override
  String get coverage_gpsReady => 'GPS РАДИО ГОТОВ';

  @override
  String get coverage_noGps => 'НЕТ GPS РАДИО';

  @override
  String get coverage_stopSave => 'СТОП + СОХРАНИТЬ СЕССИЮ';

  @override
  String get coverage_start => 'НАЧАТЬ СЕССИЮ ПОКРЫТИЯ';

  @override
  String get coverage_exportJson => 'ЭКСПОРТ JSON';

  @override
  String get coverage_exportCsv => 'ЭКСПОРТ CSV';

  @override
  String get coverage_liveObservations => 'НАБЛЮДЕНИЯ В РЕАЛЬНОМ ВРЕМЕНИ';

  @override
  String get coverage_waiting => 'ОЖИДАНИЕ АКТИВНОСТИ СЕТИ';

  @override
  String get coverage_waitingBody =>
      'Начните сессию, и здесь появятся впервые услышанные активные узлы. Значения RSSI/SNR — снимки радиостанции, и их не всегда можно однозначно отнести к конкретному пакету.';

  @override
  String get coverage_signalNa => 'сигнал н/д';

  @override
  String get coverage_snrNa => 'SNR н/д';

  @override
  String get coverage_gpsUnavailable => 'GPS радиостанции недоступен';

  @override
  String coverage_pathLine(String path, String location) {
    return 'Путь: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'flood';

  @override
  String get coverage_pathDirect => 'напрямую';

  @override
  String get coverage_shareSubject => 'Сессия покрытия NOTORYX Core';

  @override
  String get coverage_shareText => 'Экспорт записи покрытия NOTORYX Core';

  @override
  String get coverage_historyTitle => 'Сохранённые сессии покрытия';

  @override
  String coverage_loadFailed(String error) {
    return 'Не удалось загрузить сессии: $error';
  }

  @override
  String get coverage_deleteTitle => 'Удалить сохранённую сессию?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count наблюдения будут удалены с этого устройства.',
      many: '$count наблюдений будут удалены с этого устройства.',
      few: '$count наблюдения будут удалены с этого устройства.',
      one: '$count наблюдение будет удалено с этого устройства.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'Не удалось удалить сессию: $error';
  }

  @override
  String get coverage_retention =>
      'Хранятся 20 последних завершённых сессий. Поделитесь сессиями, которые хотите сохранить. Прерванные записи можно открыть заново ниже.';

  @override
  String get coverage_noSessions =>
      'Сохранённых сессий пока нет. Остановите запись, чтобы сохранить её.';

  @override
  String get coverage_interrupted => 'Прерванная запись';

  @override
  String get coverage_saved => 'Сохранено';

  @override
  String get coverage_deleteTooltip => 'Удалить сессию';

  @override
  String coverage_exportFailed(String error) {
    return 'Ошибка экспорта: $error';
  }

  @override
  String get coverage_sessionTitle => 'Сессия покрытия';

  @override
  String get coverage_shareJson => 'Поделиться JSON';

  @override
  String get coverage_shareCsv => 'Поделиться CSV';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi дБм • SNR $snr дБ • возраст снимка $age мс';
  }

  @override
  String get coverage_unknown => 'неизвестно';

  @override
  String coverage_pathValue(String path) {
    return 'путь $path';
  }

  @override
  String get coverage_recorder => 'Записывающий';

  @override
  String get coverage_noCoordinates =>
      'В этой сессии нет пригодных координат. Наблюдения по-прежнему доступны ниже.';

  @override
  String get coverage_osmAttribution =>
      '© участники OpenStreetMap • онлайн-подложка';

  @override
  String get fieldStats_title => 'ПОЛЕВАЯ АНАЛИТИКА';

  @override
  String get fieldStats_snapshot => 'СНИМОК СЕТИ В РЕАЛЬНОМ ВРЕМЕНИ';

  @override
  String get fieldStats_headline => 'Что NOTORYX Core знает прямо сейчас.';

  @override
  String get fieldStats_body =>
      'Эти счётчики рассчитываются по таблице контактов подключённого MeshCore, местоположениям, путям и времени последнего появления.';

  @override
  String get fieldStats_total => 'ВСЕГО';

  @override
  String get fieldStats_chatNodes => 'УЗЛЫ ЧАТА';

  @override
  String get fieldStats_rooms => 'КОМНАТЫ';

  @override
  String get fieldStats_sensors => 'ДАТЧИКИ';

  @override
  String get fieldStats_located => 'С МЕСТОПОЛОЖЕНИЕМ';

  @override
  String get fieldStats_favorites => 'ИЗБРАННОЕ';

  @override
  String get fieldStats_routeSnapshot => 'СНИМОК МАРШРУТОВ';

  @override
  String get fieldStats_routed => 'С МАРШРУТОМ';

  @override
  String get fieldStats_direct => 'НАПРЯМУЮ';

  @override
  String get fieldStats_flood => 'FLOOD';

  @override
  String get fieldStats_pathIntel => 'АНАЛИЗ ПУТЕЙ';

  @override
  String get fieldStats_pathIntelBody =>
      'Анализ маршрутов NOTORYX Core использует сохранённые попытки путей, число переходов, успехи/неудачи, время прохождения и веса маршрутов, чтобы показывать выученные маршруты.';

  @override
  String get fieldStats_coverageSessions => 'СЕССИИ ПОКРЫТИЯ';

  @override
  String get fieldStats_coverageSessionsBody =>
      'Запись покрытия теперь сохраняет полевые сессии, восстанавливает прерванную работу, экспортирует наблюдения и наносит записанные точки покрытия на карту. RSSI/SNR остаются ближайшим доступным снимком радиостанции.';

  @override
  String get mapHub_title => 'ПОЛЕВАЯ КАРТА NOTORYX';

  @override
  String get mapHub_intro =>
      'Карты в реальном времени, офлайн-области, региональные профили и полевые сессии покрытия NOTORYX Core.';

  @override
  String get mapHub_captureHint =>
      'Начать и остановить полевую сессию покрытия';

  @override
  String get mapHub_badgeNew => 'НОВОЕ';

  @override
  String get mapHub_liveMap => 'КАРТА СЕТИ В РЕАЛЬНОМ ВРЕМЕНИ';

  @override
  String get mapHub_liveMapHint =>
      'Узлы, ретрансляторы, местоположения, маршруты и инструменты карты';

  @override
  String get mapHub_badgeLive => 'LIVE';

  @override
  String get mapHub_offlinePacks => 'ПАКЕТЫ ОФЛАЙН-КАРТ';

  @override
  String get mapHub_offlinePacksHint =>
      'Кэшируйте тайлы карт для походов и мест без связи';

  @override
  String get mapHub_badgeOffline => 'ОФЛАЙН';

  @override
  String get mapHub_regions => 'ПРОФИЛИ РЕГИОНОВ';

  @override
  String get mapHub_regionsHint =>
      'Управляйте региональными определениями сети и загружайте их';

  @override
  String get mapHub_badgeRegions => 'РЕГИОНЫ';

  @override
  String get routes_title => 'Анализ маршрутов';

  @override
  String get routes_headline => 'Посмотрите, как трафик проходит через сеть.';

  @override
  String get routes_body =>
      'NOTORYX Core ранжирует сохранённые маршруты по истории путей, уже выученной из реальных попыток отправки сообщений и обнаружения.';

  @override
  String get routes_routes => 'МАРШРУТЫ';

  @override
  String get routes_success => 'УСПЕХИ';

  @override
  String get routes_failed => 'НЕУДАЧИ';

  @override
  String get routes_routeMap => 'КАРТА МАРШРУТОВ';

  @override
  String get routes_routeMapHint => 'Изучайте узлы и пути';

  @override
  String get routes_discover => 'ОБНАРУЖИТЬ';

  @override
  String get routes_discoverHint => 'Найти новые маршруты';

  @override
  String get routes_learned => 'ВЫУЧЕННЫЕ МАРШРУТЫ';

  @override
  String get routes_none => 'ИСТОРИИ МАРШРУТОВ ПОКА НЕТ';

  @override
  String get routes_noneBody =>
      'Пользуйтесь сетью как обычно или запустите обнаружение. NOTORYX Core покажет здесь выученные маршруты, когда появится история путей.';

  @override
  String get routes_direct => 'НАПРЯМУЮ';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count маршрута',
      many: '$count маршрутов',
      few: '$count маршрута',
      one: '$count маршрут',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return 'ЛУЧШИЙ  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  вес $weight  •  успехов: $success / неудач: $fail';
  }

  @override
  String routes_fastest(String ms) {
    return 'Самый быстрый известный: $ms мс';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'Flood: успехов: $success / неудач: $fail';
  }

  @override
  String get repeaterTools_heroLabel => 'УПРАВЛЕНИЕ РЕТРАНСЛЯТОРАМИ';

  @override
  String get repeaterTools_headline => 'Управляйте инфраструктурой своей сети.';

  @override
  String get repeaterTools_body =>
      'Выберите обнаруженный ретранслятор, чтобы войти и открыть его существующие инструменты MeshCore: состояние, телеметрию, соседей, настройки и CLI.';

  @override
  String get repeaterTools_discovered => 'ОБНАРУЖЕНО';

  @override
  String get repeaterTools_tools => 'ИНСТРУМЕНТЫ';

  @override
  String get repeaterTools_available => 'ДОСТУПНЫЕ РЕТРАНСЛЯТОРЫ';

  @override
  String get repeaterTools_unnamed => 'Безымянный ретранслятор';

  @override
  String get repeaterTools_statusTelemetry => 'СОСТОЯНИЕ + ТЕЛЕМЕТРИЯ';

  @override
  String get repeaterTools_statusTelemetryBody =>
      'Проверяйте состояние и телеметрию ретранслятора с помощью существующих инструментов управления.';

  @override
  String get repeaterTools_neighbors => 'СОСЕДИ';

  @override
  String get repeaterTools_neighborsBody =>
      'Изучайте соседнюю инфраструктуру и связи в сети.';

  @override
  String get repeaterTools_cli => 'CLI + НАСТРОЙКИ';

  @override
  String get repeaterTools_cliBody =>
      'Вошедшие администраторы получают доступ к существующему CLI ретранслятора и инструментам настройки.';

  @override
  String get repeaterTools_empty =>
      'Ретрансляторы ещё не обнаружены. Подключите радиостанцию и сначала изучите сеть.';

  @override
  String get notification_fieldAlertTitle => 'Полевое оповещение NOTORYX';

  @override
  String get notification_checkInReminderTitle =>
      'Напоминание NOTORYX Core об отметке';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return 'Нет отметки уже $minutes мин в походе «$trip». Откройте NOTORYX Core, чтобы отметиться.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return '$name не выходит на связь $minutes мин. Это не подтверждённая чрезвычайная ситуация.';
  }

  @override
  String get notification_aTripContact => 'Контакт похода';

  @override
  String notification_checkInNotDelivered(String name) {
    return 'Отметка не доставлена: $name. Её можно отправить повторно на вкладке «Поход».';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return 'SOS подтверждён: $name';
  }

  @override
  String get settings_batterySaver => 'Экономия заряда';

  @override
  String get settings_batterySaverOn =>
      'Вкл.: заряд радиостанции каждые 10 мин, GPS каждые 5 мин, статистика не чаще раза в минуту, проверки похода каждые 1–2 мин. Сообщения, оповещения и SOS не меняются.';

  @override
  String get settings_batterySaverOff =>
      'Реже проверять радиостанцию и поход, чтобы экономить заряд телефона и радиостанции. Сообщения, оповещения и SOS не меняются.';

  @override
  String get settings_readAloud => 'Читать новые сообщения вслух';

  @override
  String get settings_readAloudHelper =>
      'Пока NOTORYX Core открыт. Каналы без звука не озвучиваются. Любое сообщение можно прочитать вслух из его меню.';

  @override
  String get settings_readAloudOff => 'Выкл.';

  @override
  String get settings_readAloudDirect => 'Личные сообщения';

  @override
  String get settings_readAloudAll => 'Личные сообщения и сообщения каналов';

  @override
  String get chat_readAloud => 'Прочитать вслух';

  @override
  String get messageSearch_title => 'Поиск сообщений';

  @override
  String get messageSearch_intro =>
      'Ищите во всех личных сообщениях и сообщениях каналов, сохранённых на этом телефоне.';

  @override
  String messageSearch_noResults(String query) {
    return 'Ни одно сообщение не содержит «$query».';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count совпадения',
      many: '$count совпадений',
      few: '$count совпадения',
      one: '$count совпадение',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return 'Показаны последние совпадения ($count)';
  }

  @override
  String get shortcuts_checkIn => 'Отметиться';

  @override
  String get shortcuts_trip => 'Поход';

  @override
  String get shortcuts_chats => 'Чаты';

  @override
  String get shortcuts_map => 'Карта';

  @override
  String get sensor_liveUpdates => 'Обновления в реальном времени';

  @override
  String get sensor_intro =>
      'Пусть датчик сам отправляет показания при их изменении, а не по запросу каждый раз. Нужен вход с правом чтения.';

  @override
  String get sensor_watch => 'Следить за изменениями';

  @override
  String get sensor_loadFirst =>
      'Сначала загрузите телеметрию, чтобы выбрать показания.';

  @override
  String sensor_watching(String readings, String time) {
    return 'Отслеживается: $readings до $time.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return 'Отслеживается: $readings до $time • регион $region.';
  }

  @override
  String get sensor_noChanges => 'Изменений пока не поступало.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return 'Последнее обновление $time • получено: $count';
  }

  @override
  String get sensor_stop => 'Остановить обновления';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'Остановлено здесь; датчик не подтвердил и прекратит отправку по истечении времени. $error';
  }

  @override
  String get sensor_dialogBody =>
      'Датчик проверяет показания примерно раз в минуту и отправляет обновление, когда выбранное показание меняется больше порога.';

  @override
  String sensor_readingTitle(String label, String channel) {
    return '$label (канал $channel)';
  }

  @override
  String sensor_readingValue(String label, String channel, String value) {
    return '$label (канал $channel): $value';
  }

  @override
  String sensor_watchItem(String label, String channel, String delta) {
    return '$label (канал $channel) ±$delta';
  }

  @override
  String sensor_updateOn(String delta) {
    return 'Обновлять при изменении на $delta';
  }

  @override
  String get sensor_changeThreshold => 'Изменить порог';

  @override
  String sensor_capacity(int max, String used) {
    return 'Датчик может отслеживать до $max байт показаний (занято: $used).';
  }

  @override
  String get sensor_for => 'Длительность';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count часа',
      many: '$count часов',
      few: '$count часа',
      one: '$count час',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => 'Начать';

  @override
  String sensor_thresholdTitle(String label) {
    return 'Порог: $label';
  }

  @override
  String get sensor_typeTemperature => 'Температура';

  @override
  String get sensor_typeHumidity => 'Влажность';

  @override
  String get sensor_typePressure => 'Давление';

  @override
  String get sensor_typeVoltage => 'Напряжение';

  @override
  String get sensor_typeCurrent => 'Ток';

  @override
  String get sensor_typeLight => 'Освещённость';

  @override
  String get sensor_typeConcentration => 'Концентрация';

  @override
  String get sensor_typePercentage => 'Процент';

  @override
  String get sensor_typeAnalogInput => 'Аналоговый вход';

  @override
  String get sensor_typeAltitude => 'Высота';

  @override
  String get setupWizard_title => 'Подключите радио';

  @override
  String get setupWizard_choose => '1. Выберите подключение';

  @override
  String get setupWizard_prepare => '2. Подготовьте радио';

  @override
  String get setupWizard_intro =>
      'Выберите, как этот телефон или компьютер подключится к радио. Радио передаёт сообщения по mesh-сети.';

  @override
  String get setupWizard_bluetooth =>
      'Беспроводное подключение к совместимому радио поблизости.';

  @override
  String get setupWizard_noBluetooth =>
      'Bluetooth недоступен в этом браузере. Используйте нативное приложение или поддерживаемое USB-подключение.';

  @override
  String get setupWizard_usb =>
      'Проводное подключение кабелем USB для передачи данных.';

  @override
  String get setupWizard_noUsb =>
      'USB-serial здесь недоступен. Используйте поддерживаемое приложение для компьютера или Android либо Chrome с Web Serial.';

  @override
  String get setupWizard_bluetoothSteps =>
      'Включите радио и держите его рядом. Включите Bluetooth и разрешите приложению его использовать. Закройте другие приложения, подключённые к радио, откройте список устройств и начните поиск.';

  @override
  String get setupWizard_usbSteps =>
      'Подключите включённое радио кабелем USB для передачи данных; кабель только для зарядки не подойдёт. Закройте другие приложения для последовательного порта. Откройте список USB-устройств, выберите радио и разрешите доступ, если появится запрос.';

  @override
  String get setupWizard_firmwareTitle =>
      'Проверьте совместимость перед сменой прошивки';

  @override
  String get setupWizard_firmware =>
      'Радио нужна прошивка MeshCore companion с поддержкой выбранного подключения. Поддержка зависит от платы и сборки прошивки; наличие USB-разъёма ещё не означает поддержку USB-serial. Проверьте инструкции для вашей платы и установленной сборки. Прошивка репитера или комнатного сервера не является companion. Неудачное подключение само по себе не значит, что нужно перепрошивать.';

  @override
  String get setupWizard_settings =>
      'Этот мастер не прошивает радио и не меняет его настройки. После подключения используйте Настройки для региона, частоты и дополнительных параметров. Согласуйте настройки с вашей локальной mesh-сетью, прежде чем их менять.';

  @override
  String get setupWizard_openBluetooth => 'Открыть устройства Bluetooth';

  @override
  String get setupWizard_openUsb => 'Открыть устройства USB';

  @override
  String get setupWizard_change => 'Сменить тип подключения';

  @override
  String get setupWizard_later => 'Настроить позже';

  @override
  String get setupWizard_bluetoothError =>
      'Не удалось подключиться к радио. Держите его включённым и рядом, проверьте разрешения Bluetooth и закройте другие подключённые приложения. Затем выполните поиск снова.';

  @override
  String get setupWizard_scanError =>
      'Не удалось найти радио. Включите Bluetooth и разрешите доступ к Bluetooth или устройствам поблизости в настройках системы, затем повторите поиск.';

  @override
  String get setupWizard_usbError =>
      'Не удалось подключиться по USB. Проверьте кабель для передачи данных и выбранное устройство, разрешите доступ к USB и закройте другие приложения для последовательного порта. Переподключите кабель и попробуйте снова.';

  @override
  String get connections_title => 'Подключения';

  @override
  String get connections_radioTitle => 'Подключение радио';

  @override
  String get connections_bluetoothOffNotice =>
      'Bluetooth выключен. Включите его, чтобы переподключиться; приложение повторит попытку, когда он снова заработает.';

  @override
  String get connections_transport => 'Способ подключения';

  @override
  String connections_lastError(String error) {
    return 'Последняя ошибка: $error';
  }

  @override
  String get connections_disconnectRadio => 'Отключить радио';

  @override
  String connections_reconnectTo(String name) {
    return 'Переподключиться к $name';
  }

  @override
  String get connections_forgetRadio => 'Забыть радио';

  @override
  String get connections_connectAnother => 'Подключить другое радио';

  @override
  String get connections_usbSerial => 'USB-serial';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'Устройство';

  @override
  String get connections_publicKey => 'Открытый ключ';

  @override
  String get connections_firmware => 'Прошивка';

  @override
  String connections_firmwareProtocol(String code) {
    return 'протокол v$code';
  }

  @override
  String get connections_battery => 'Батарея';

  @override
  String get connections_lastRx => 'Последний приём';

  @override
  String get connections_reconnectFailed =>
      'Не удалось переподключиться к радио';

  @override
  String get connections_statusBluetoothOff => 'Bluetooth выключен';

  @override
  String get connections_statusConnected => 'Подключено';

  @override
  String get connections_statusConnecting => 'Подключение…';

  @override
  String get connections_statusDisconnecting => 'Отключение…';

  @override
  String get connections_statusScanning => 'Поиск радио…';

  @override
  String get connections_statusReconnectingSoon => 'Скоро переподключение…';

  @override
  String get connections_statusNotConnected => 'Не подключено';

  @override
  String get mqtt_cardTitle => 'Подключение MQTT';

  @override
  String get mqtt_statusNotConfigured => 'Не настроено';

  @override
  String get mqtt_statusDisconnected => 'Отключено';

  @override
  String get mqtt_statusConnecting => 'Подключение';

  @override
  String get mqtt_statusConnected => 'Подключено';

  @override
  String get mqtt_statusReconnecting => 'Переподключение';

  @override
  String get mqtt_statusError => 'Ошибка подключения';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'Брокер: $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn => 'Вход по токену, подписанному радио';

  @override
  String mqtt_tokenSignInAs(String username) {
    return 'Вход по токену, подписанному радио, как $username…';
  }

  @override
  String get mqtt_connectRadioToSignIn => 'Подключите радио, чтобы войти';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'Токен обновится в $time';
  }

  @override
  String mqtt_signedInAs(String username) {
    return 'Вход выполнен как $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return 'Прослушивание $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'Пакеты: новых $accepted, повторов $duplicate, ошибочных $invalid';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return 'Попытка $attempt из $max';
  }

  @override
  String get mqtt_sharingWaitsForRadio => 'Публикация ждёт подключения радио';

  @override
  String mqtt_sharingOn(String topic) {
    return 'Публикация в $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return 'Будет публиковать в $topic';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'Статус онлайн в $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return 'Опубликовано $shared, задержано $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'Добавьте брокер, чтобы передавать трафик MeshCore через интернет. Подключение радио работает независимо.';

  @override
  String get mqtt_disconnect => 'Отключить MQTT';

  @override
  String get mqtt_connect => 'Подключить MQTT';

  @override
  String get mqtt_packetFeed => 'Лента пакетов';

  @override
  String get mqtt_setUpBroker => 'Настроить брокер';

  @override
  String get mqtt_brokerSettings => 'Настройки брокера';

  @override
  String get mqtt_settingsTitle => 'Настройки брокера MQTT';

  @override
  String get mqtt_presetLabel => 'Начать с шаблона';

  @override
  String get mqtt_presetCustom => 'Свой брокер';

  @override
  String get mqtt_presetLocal => 'Локальный брокер (укажите адрес)';

  @override
  String get mqtt_presetLetsMeshUs => 'Анализатор LetsMesh (США, сообщество)';

  @override
  String get mqtt_presetLetsMeshEu => 'Анализатор LetsMesh (ЕС, сообщество)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh — анализатор пакетов MeshCore, который ведёт сообщество; он не входит в NOTORYX и не одобрен NOTORYX. Для публикации нужно подключённое радио, и она выключена, пока вы её не включите.';

  @override
  String get mqtt_hostname => 'Имя хоста брокера';

  @override
  String get mqtt_port => 'Порт';

  @override
  String get mqtt_useTls => 'Использовать TLS';

  @override
  String get mqtt_allowCleartext =>
      'Разрешить нешифрованное подключение к локальному брокеру';

  @override
  String get mqtt_allowCleartextHint =>
      'Только localhost, .local и частные хосты 10.x / 192.168.x.';

  @override
  String get mqtt_useWebSocket => 'Использовать WebSocket';

  @override
  String get mqtt_webSocketPath => 'Путь WebSocket';

  @override
  String get mqtt_topicPrefix => 'Префикс топика';

  @override
  String get mqtt_region => 'Регион (необязательно)';

  @override
  String get mqtt_regionHelp =>
      'Код региона наблюдателя, например PHL. Оставьте пустым для всех.';

  @override
  String get mqtt_deliverChannel =>
      'Добавлять сообщения каналов, полученные через MQTT';

  @override
  String get mqtt_deliverChannelHint =>
      'Сообщения в ваших каналах, услышанные наблюдателями, появятся в чатах. Они не отправляются через ваше радио.';

  @override
  String get mqtt_sharingTitle => 'Публикация как наблюдатель';

  @override
  String get mqtt_share => 'Публиковать пакеты, которые слышит моё радио';

  @override
  String get mqtt_shareHint =>
      'Публикует объявления и трафик каналов, которые принимает ваше радио, с его открытым ключом, уровнем сигнала и регионом. Сообщения каналов остаются зашифрованными. Нужен регион.';

  @override
  String get mqtt_shareDirect => 'Включать трафик личных сообщений';

  @override
  String get mqtt_shareDirectHint =>
      'Запросы, ответы и личные сообщения. Содержимое остаётся зашифрованным, но видно, какие узлы общаются друг с другом.';

  @override
  String get mqtt_shareOwn => 'Включать мои собственные сообщения и объявления';

  @override
  String get mqtt_signInTitle => 'Вход';

  @override
  String get mqtt_authPassword => 'Имя пользователя и пароль';

  @override
  String get mqtt_authToken => 'Токен, подписанный радио';

  @override
  String get mqtt_tokenExplain =>
      'Радио подписывает своим ключом токен входа на один час, а приложение обновляет его до истечения. Ключ никогда не покидает радио. Имя пользователя — v1_ и открытый ключ вашего радио.';

  @override
  String get mqtt_radioReady => 'Радио подключено: можно входить.';

  @override
  String get mqtt_radioNeeded =>
      'Подключите радио, чтобы войти. MQTT ждёт его.';

  @override
  String get mqtt_username => 'Имя пользователя (необязательно)';

  @override
  String get mqtt_password => 'Пароль';

  @override
  String get mqtt_keepPassword =>
      'Оставьте пустым, чтобы сохранить текущий пароль.';

  @override
  String get mqtt_credentialsWeb =>
      'В браузере учётные данные хранятся только до закрытия страницы.';

  @override
  String get mqtt_credentialsKeychain =>
      'Учётные данные хранятся в системной связке ключей, а не в настройках приложения или журналах.';

  @override
  String get mqtt_saveSettings => 'Сохранить настройки';

  @override
  String get mqtt_feedTitle => 'Лента пакетов MQTT';

  @override
  String get mqtt_feedConnect =>
      'Подключитесь к брокеру, чтобы видеть пакеты от наблюдателей.';

  @override
  String mqtt_feedWaiting(String topic) {
    return 'Ожидание пакетов в $topic';
  }

  @override
  String get mqtt_feedUnknownObserver => 'Неизвестный наблюдатель';

  @override
  String mqtt_feedHeardBy(String observer) {
    return 'Услышал $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return 'Переходов: $hops · байт: $bytes';
  }

  @override
  String get mqtt_packetRequest => 'Запрос';

  @override
  String get mqtt_packetResponse => 'Ответ';

  @override
  String get mqtt_packetDirectMessage => 'Личное сообщение';

  @override
  String get mqtt_packetAck => 'Подтверждение';

  @override
  String get mqtt_packetAdvert => 'Объявление';

  @override
  String get mqtt_packetChannelMessage => 'Сообщение канала';

  @override
  String get mqtt_packetChannelData => 'Данные канала';

  @override
  String get mqtt_packetAnonymousRequest => 'Анонимный запрос';

  @override
  String get mqtt_packetPath => 'Маршрут';

  @override
  String get mqtt_packetTrace => 'Трассировка';

  @override
  String get mqtt_packetMultipart => 'Составной';

  @override
  String get mqtt_packetControl => 'Управление';

  @override
  String mqtt_packetType(int type) {
    return 'Тип $type';
  }

  @override
  String get mqtt_routeTransportFlood => 'Flood с транспортом';

  @override
  String get mqtt_routeFlood => 'Flood';

  @override
  String get mqtt_routeDirect => 'Прямой';

  @override
  String get mqtt_routeTransportDirect => 'Прямой с транспортом';

  @override
  String get mqtt_noticeInvalidHost =>
      'Введите имя хоста или адрес IPv4 без схемы и порта.';

  @override
  String get mqtt_noticeInvalidPort => 'Порт должен быть от 1 до 65535.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'Путь WebSocket должен начинаться с / и не содержать запроса или фрагмента.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'Префикс топика должен быть непустым путём MQTT без подстановочных знаков.';

  @override
  String get mqtt_noticeInvalidRegion =>
      'Регион — от 2 до 8 букв или цифр, например PHL.';

  @override
  String get mqtt_noticeTlsRequired =>
      'TLS обязателен, если явно не разрешён небезопасный доступ к локальному брокеру.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      'Нешифрованный MQTT разрешён только для явно одобренных локальных хостов.';

  @override
  String get mqtt_noticeRegionNeededToShare =>
      'Укажите регион, чтобы публиковать пакеты как наблюдатель.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return 'Введите пароль для $username.';
  }

  @override
  String get mqtt_noticeNoNetwork =>
      'Нет сети. MQTT переподключится, когда она появится.';

  @override
  String get mqtt_noticeSubscriptionRefused =>
      'Брокер отклонил подписку на пакеты.';

  @override
  String get mqtt_noticeBadCredentials =>
      'Брокер отклонил имя пользователя или пароль.';

  @override
  String get mqtt_noticeNotAuthorized =>
      'У этой учётной записи нет прав на брокере.';

  @override
  String get mqtt_noticeConnectionRefused => 'Брокер отклонил подключение.';

  @override
  String get mqtt_noticeUnreachable => 'Брокер недоступен.';

  @override
  String get mqtt_noticeTlsFailed =>
      'Не удалось установить защищённое (TLS) соединение.';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'Эта платформа поддерживает MQTT только через WebSocket.';

  @override
  String get mqtt_noticeRadioNotConnected =>
      'Подключите радио, чтобы войти с его ключом.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'Прошивка этого радио не умеет подписывать его ключом.';

  @override
  String get mqtt_noticeSigningTimeout =>
      'Радио не ответило на запрос подписи. Возможно, его прошивка не поддерживает подпись.';

  @override
  String get mqtt_noticeSigningTooLong =>
      'Данные слишком длинные, чтобы радио могло их подписать.';

  @override
  String get mqtt_noticeSigningRejected =>
      'Радио отказалось подписывать данные.';

  @override
  String get scanner_signalStrong => 'Сильный';

  @override
  String get scanner_signalGood => 'Хороший';

  @override
  String get scanner_signalFair => 'Средний';

  @override
  String get scanner_signalWeak => 'Слабый';

  @override
  String get scanner_nearbyRadios => 'Радио поблизости';

  @override
  String get scanner_lastRadio => 'Последнее радио';

  @override
  String get scanner_reconnect => 'Переподключить';

  @override
  String get scanner_tcpHint => 'Радио с прошивкой Wi‑Fi в вашей сети.';

  @override
  String get scanner_otherWays => 'Другие способы подключения';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count радио поблизости',
      one: '1 радио поблизости',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => 'Поиск радио…';

  @override
  String get scanner_findTitle => 'Найдите своё радио';

  @override
  String get scanner_heroHint =>
      'Включите радио и держите его в нескольких метрах. Нужна прошивка MeshCore companion.';

  @override
  String get scanner_tipsTitle => 'Не видно вашего радио?';

  @override
  String get scanner_tipPower => 'Проверьте, что оно включено и активно.';

  @override
  String get scanner_tipFirmware =>
      'Нужна прошивка MeshCore companion. Ретрансляторы и комнатные серверы здесь не отображаются.';

  @override
  String get scanner_tipOtherDevice =>
      'Радио подключается только к одному устройству за раз. Отключите его от других телефонов или компьютеров.';

  @override
  String get connections_internetBridge => 'Интернет-мост';

  @override
  String get connections_noRadio => 'Нет радио';

  @override
  String get connections_radioSettings => 'Настройки радио';

  @override
  String get connections_viewDashboard => 'Открыть панель подключений';

  @override
  String get regionSetup_title => 'Настройка регионов';

  @override
  String get regionSetup_hubSubtitle =>
      'Поместить ретранслятор в дерево регионов вашей местности';

  @override
  String get regionSetup_intro =>
      'Регионы удерживают сообщение в пределах области, а не рассылают его по всей сети. Ретранслятор передаёт сообщения региона, только если этот регион у него задан, поэтому задайте ему его регион и все регионы выше.';

  @override
  String get regionSetup_where => 'Где находится ретранслятор?';

  @override
  String get regionSetup_tree => 'Дерево регионов';

  @override
  String get regionSetup_custom => 'Своё';

  @override
  String get regionSetup_region => 'Самый местный регион';

  @override
  String regionSetup_source(String source) {
    return 'Источник: $source';
  }

  @override
  String get regionSetup_customLabel => 'Регионы, от самого широкого';

  @override
  String regionSetup_invalidName(String name) {
    return '«$name» — недопустимое имя региона. Используйте строчные латинские буквы, цифры и дефисы, до 29 символов.';
  }

  @override
  String regionSetup_tooMany(int max) {
    return 'Ретранслятору можно задать не более $max регионов.';
  }

  @override
  String get regionSetup_options => 'Параметры';

  @override
  String get regionSetup_setDefault => 'Сделать самый местный регион основным';

  @override
  String get regionSetup_setDefaultBody =>
      'Собственные объявления ретранслятора останутся в этом регионе.';

  @override
  String get regionSetup_legacy => 'Прошивка 1.14';

  @override
  String get regionSetup_legacyBody =>
      'Добавляет region allowf после каждого региона. Не нужно начиная с 1.15.';

  @override
  String get regionSetup_denyUnscoped => 'Не передавать сообщения без региона';

  @override
  String get regionSetup_denyUnscopedBody =>
      'Включайте, только когда вся местность использует регионы, иначе сообщения из старых приложений не пройдут.';

  @override
  String get regionSetup_commands => 'Команды';

  @override
  String get regionSetup_copyAll => 'Копировать всё';

  @override
  String get regionSetup_copied => 'Скопировано';

  @override
  String get regionSetup_pickFirst => 'Выберите регион, чтобы увидеть команды.';

  @override
  String regionSetup_sendTo(String name) {
    return 'Отправить на $name';
  }

  @override
  String get regionSetup_howToSend =>
      'Чтобы отправить их, войдите в ретранслятор и откройте «Настройка регионов» в его меню или вставьте их в его командную строку.';

  @override
  String get regionSetup_noReply => 'Нет ответа. Остановлено здесь.';

  @override
  String get regionSetup_addToMine => 'Добавить эти регионы в мой список';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'В список добавлено регионов: $count',
      one: 'В список добавлен 1 регион',
    );
    return '$_temp0';
  }
}
