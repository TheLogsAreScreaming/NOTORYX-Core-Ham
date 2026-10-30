// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core';

  @override
  String get nav_contacts => 'Контакти';

  @override
  String get nav_channels => 'Канали';

  @override
  String get nav_map => 'Карта';

  @override
  String get nav_messages => 'Съобщения';

  @override
  String get nav_nodes => 'Възли';

  @override
  String get nav_radio => 'Радио';

  @override
  String get messages_title => 'Съобщения';

  @override
  String get messages_filterAll => 'Всички';

  @override
  String get messages_filterDirect => 'Лични';

  @override
  String get messages_filterChannels => 'Канали';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'Търсене в съобщенията';

  @override
  String get messages_searchHint => 'Търсене в разговорите';

  @override
  String get messages_closeSearch => 'Затвори търсенето';

  @override
  String get messages_manageChannels => 'Управление на канали';

  @override
  String get messages_new => 'Ново';

  @override
  String get messages_newDirect => 'Съобщение до възел';

  @override
  String get messages_newChannel => 'Добавяне или присъединяване към канал';

  @override
  String get messages_empty => 'Все още няма разговори';

  @override
  String get messages_emptyHint =>
      'Тук се показват съобщения от възли и канали.';

  @override
  String get messages_noMatches => 'Няма разговори, отговарящи на търсенето';

  @override
  String messages_you(String text) {
    return 'Вие: $text';
  }

  @override
  String get messages_yesterday => 'Вчера';

  @override
  String messages_unreadCount(int count) {
    return '$count непрочетени';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return 'Свързано чрез $transport';
  }

  @override
  String get radioStatus_bluetooth => 'Bluetooth';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'Wi‑Fi (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return 'Батерия $percent%';
  }

  @override
  String get radioStatus_openRadio => 'Отвори данните за радиото';

  @override
  String get radioOverview_battery => 'Батерия';

  @override
  String radioOverview_firmware(String version) {
    return 'Фърмуер $version';
  }

  @override
  String get radioOverview_sendAdvert => 'Изпрати обявяване';

  @override
  String get radioOverview_stats => 'Статистика на радиото';

  @override
  String get accessControl_title => 'Контрол на достъпа';

  @override
  String get accessControl_hubSubtitle => 'Кой може да влиза без парола';

  @override
  String get accessControl_explainRepeater =>
      'Хората в този списък влизат без парола. Администраторите могат да променят настройките; „Само четене“ и „Четене и запис“ получават и пълната телеметрия.';

  @override
  String get accessControl_explainRoom =>
      'Администраторите в този списък влизат без парола и могат да управляват стаята. Членовете на стаята влизат с паролата на стаята.';

  @override
  String get accessControl_roleReadOnly => 'Само четене';

  @override
  String get accessControl_roleReadWrite => 'Четене и запис';

  @override
  String get accessControl_roleAdmin => 'Администратор';

  @override
  String get accessControl_you => 'Вие';

  @override
  String get accessControl_unknownNode => 'Непознат възел';

  @override
  String get accessControl_add => 'Добави';

  @override
  String get accessControl_addTitle => 'Добавяне в списъка за достъп';

  @override
  String get accessControl_pickContact => 'Изберете контакт';

  @override
  String get accessControl_noContacts =>
      'Няма контакти за добавяне. Възлите се появяват тук, след като получите тяхното обявяване.';

  @override
  String get accessControl_changeRole => 'Промяна на ролята';

  @override
  String get accessControl_remove => 'Премахни достъпа';

  @override
  String accessControl_removeConfirm(String name) {
    return 'Да се премахне ли $name от списъка за достъп? За влизане ще е нужна паролата.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'Това сте вие. Ако се премахнете, ще ви трябва администраторската парола, за да управлявате този възел отново.';

  @override
  String get accessControl_unknownKeyNote =>
      'Не е в контактите ви. Промяната на ролята изисква по-нов фърмуер на възела; премахването винаги работи.';

  @override
  String get accessControl_prefixUnsupported =>
      'Фърмуерът на този възел не може да промени ролята на човек, който не е в контактите ви. Все пак можете да го премахнете.';

  @override
  String get accessControl_empty => 'Списъкът за достъп е празен';

  @override
  String get accessControl_emptyHint =>
      'Добавете хора, за да влизат без парола.';

  @override
  String get accessControl_loading =>
      'Изисква се списъкът за достъп от възела…';

  @override
  String get accessControl_timeout =>
      'Възелът не отговори. Проверете маршрута и опитайте отново.';

  @override
  String get accessControl_maybeIncomplete =>
      'Възелът изпрати една пълна страница, а фърмуерът му не може да изпрати повече, затова може да липсват записи.';

  @override
  String get accessControl_saved => 'Списъкът за достъп е обновен';

  @override
  String accessControl_failed(String reply) {
    return 'Възелът отказа промяната: $reply';
  }

  @override
  String get companionCli_title => 'Команден ред';

  @override
  String get companionCli_tileSubtitle => 'Изпълнявайте команди на радиото си';

  @override
  String get companionCli_warning =>
      'Командите се изпълняват на свързаното радио и могат да променят настройките му или да го рестартират.';

  @override
  String get companionCli_hint => 'Въведете команда, напр. ver';

  @override
  String get companionCli_send => 'Изпълни командата';

  @override
  String get companionCli_noReply =>
      'Няма отговор. Радиото може да се рестартира.';

  @override
  String get companionCli_empty =>
      'Опитайте някоя от командите по-горе или въведете своя.';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle => 'Свържете радиото си с Wi‑Fi мрежа';

  @override
  String get wifi_unsupported => 'Фърмуерът на това радио не поддържа Wi‑Fi.';

  @override
  String get wifi_enabled => 'Използвай Wi‑Fi';

  @override
  String get wifi_status => 'Състояние';

  @override
  String get wifi_connected => 'Свързано';

  @override
  String wifi_connectedIp(String ip) {
    return 'Свързано · $ip';
  }

  @override
  String get wifi_disconnected => 'Няма връзка';

  @override
  String get wifi_network => 'Име на мрежата (SSID)';

  @override
  String get wifi_password => 'Парола';

  @override
  String get wifi_passwordKeep =>
      'Оставете празно, за да запазите текущата парола';

  @override
  String get wifi_save => 'Запази';

  @override
  String get wifi_forget => 'Забрави мрежата';

  @override
  String get wifi_forgetConfirm =>
      'Да се премахнат ли запазената мрежа и парола от радиото?';

  @override
  String get wifi_rebootNeeded =>
      'Запазено. Рестартирайте радиото, за да приложите промените по Wi‑Fi.';

  @override
  String get wifi_rebootNow => 'Рестартирай радиото';

  @override
  String get wifi_rebootConfirm =>
      'Да се рестартира ли радиото сега? Приложението ще прекъсне връзката и ще трябва да се свържете отново.';

  @override
  String get wifi_loadFailed =>
      'Неуспешно четене на Wi‑Fi настройките от радиото.';

  @override
  String get wifi_retry => 'Опитай отново';

  @override
  String wifi_saveFailed(String reply) {
    return 'Радиото не прие промяната: $reply';
  }

  @override
  String get accessControl_refresh => 'Опресни';

  @override
  String get common_cancel => 'Отказ';

  @override
  String get common_ok => 'Добре';

  @override
  String get common_connect => 'Свържи се';

  @override
  String get common_unknownDevice => 'Неизвестно устройство';

  @override
  String get common_save => 'Запази';

  @override
  String get common_delete => 'Изтрий';

  @override
  String get common_deleteAll => 'Изтрий всичко';

  @override
  String get common_close => 'Затвори';

  @override
  String get common_done => 'Готово';

  @override
  String get common_edit => 'Редактирай';

  @override
  String get common_add => 'Добави';

  @override
  String get common_settings => 'Настройки';

  @override
  String get common_disconnect => 'Прекъсни';

  @override
  String get common_connected => 'Свързано';

  @override
  String get common_disconnected => 'Прекъснато';

  @override
  String get common_create => 'Създай';

  @override
  String get common_continue => 'Продължи';

  @override
  String get common_share => 'Сподели';

  @override
  String get common_copy => 'Копирай';

  @override
  String get common_retry => 'Опитай отново';

  @override
  String get common_hide => 'Скрий';

  @override
  String get common_remove => 'Изтрий';

  @override
  String get common_enable => 'Активирай';

  @override
  String get common_disable => 'Деактивирай';

  @override
  String get common_undo => 'Отмени';

  @override
  String get messageStatus_sent => 'Изпратено';

  @override
  String get messageStatus_delivered => 'Доставено';

  @override
  String get messageStatus_pending => 'Изпраща се';

  @override
  String get messageStatus_failed => 'Неуспешно изпращане';

  @override
  String get messageStatus_repeated => 'Повторно чуто';

  @override
  String get urlImage_enable => 'Включи изображения от URL';

  @override
  String get urlImage_possible =>
      'Възможно изображение от URL; включете го в Настройки.';

  @override
  String get common_reboot => 'Рестартирай';

  @override
  String get common_loading => 'Зареждане...';

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
  String get common_autoRefresh => 'Автоматично обновяване';

  @override
  String get common_interval => 'Интервал';

  @override
  String get scanner_title => 'MeshCore – Отворена версия';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'Свържете се чрез TCP';

  @override
  String get tcpHostLabel => 'IP адрес';

  @override
  String get tcpHostHint => '192.168.40.10';

  @override
  String get tcpPortLabel => 'Пристанище';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => 'Въведете крайната точка и свържете се.';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return 'Свързване към $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => 'Необходим е IP адрес.';

  @override
  String get tcpErrorPortInvalid => 'Портът трябва да бъде между 1 и 65535.';

  @override
  String get tcpErrorUnsupported =>
      'Транспортът чрез TCP не се поддържа на тази платформа.';

  @override
  String get tcpErrorTimedOut => 'Връзката TCP изтекла.';

  @override
  String tcpConnectionFailed(String error) {
    return 'Неуспешно е установено TCP връзката: $error';
  }

  @override
  String get usbScreenTitle => 'Свържете се чрез USB';

  @override
  String get usbScreenSubtitle =>
      'Изберете открития сериен уред и свържете директно към вашия MeshCore възел.';

  @override
  String get usbScreenStatus => 'Изберете USB устройство';

  @override
  String get usbScreenNote =>
      'USB серийната връзка е активна на поддържаните Android устройства и настолни платформи.';

  @override
  String get usbScreenEmptyState =>
      'Няма открити USB устройства. Включете едно и опитайте отново.';

  @override
  String get usbErrorPermissionDenied => 'Не беше разрешено достъпът през USB.';

  @override
  String get usbErrorDeviceMissing =>
      'Избраното USB устройство вече не е налично.';

  @override
  String get usbErrorInvalidPort => 'Изберете валитно USB устройство.';

  @override
  String get usbErrorBusy =>
      'Друг мол за свързване през USB вече е в процес на изпълнение.';

  @override
  String get usbErrorNotConnected => 'Няма свързано USB устройство.';

  @override
  String get usbErrorOpenFailed =>
      'Не успях да отворя избраното USB устройство.';

  @override
  String get usbErrorConnectFailed =>
      'Не успях да се свържа с избраното USB устройство.';

  @override
  String get usbErrorUnsupported =>
      'USB серийната комуникация не се поддържа на тази платформа.';

  @override
  String get usbErrorAlreadyActive => 'USB връзката вече е активирана.';

  @override
  String get usbErrorNoDeviceSelected => 'Няма избран USB устройство.';

  @override
  String get usbErrorPortClosed => 'USB връзката не е активна.';

  @override
  String get usbErrorConnectTimedOut =>
      'Връзката прекъсна. Уверете се, че устройството има софтуер за USB връзка.';

  @override
  String get usbFallbackDeviceName =>
      'Устройство за четене на уеб серийни данни';

  @override
  String get usbStatus_notConnected => 'Изберете USB устройство';

  @override
  String get usbStatus_connecting => 'Свързване към USB устройство...';

  @override
  String get usbStatus_searching => 'Търсене на USB устройства...';

  @override
  String usbConnectionFailed(String error) {
    return 'Неуспешно свързване през USB: $error';
  }

  @override
  String get scanner_scanning => 'Сканиране за устройства...';

  @override
  String get scanner_connecting => 'Свързвам се...';

  @override
  String get scanner_disconnecting => 'Изключване...';

  @override
  String get scanner_notConnected => 'Не е свързан';

  @override
  String scanner_connectedTo(String deviceName) {
    return 'Свързано с $deviceName';
  }

  @override
  String get scanner_searchingDevices => 'Търсене на устройства MeshCore...';

  @override
  String get scanner_tapToScan =>
      'Докоснете „Сканирай“, за да намерите устройства MeshCore.';

  @override
  String scanner_connectionFailed(String error) {
    return 'Връзката не успя: $error';
  }

  @override
  String get scanner_stop => 'Спрете';

  @override
  String get scanner_scan => 'Сканирай';

  @override
  String get scanner_bluetoothOff => 'Bluetooth е изключен.';

  @override
  String get scanner_bluetoothOffMessage =>
      'Моля, активирайте Bluetooth, за да сканирате за устройства.';

  @override
  String get scanner_chromeRequired => 'Изисква се браузър Chrome';

  @override
  String get scanner_chromeRequiredMessage =>
      'Това уеб приложение изисква Google Chrome или браузър, базиран на Chromium, за поддръжка на Bluetooth.';

  @override
  String get scanner_enableBluetooth => 'Активирайте Bluetooth';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'Функцията Bluetooth не е налична в браузъра. Моля, свържете се чрез USB вместо това.';

  @override
  String get device_quickSwitch => 'Бързо превключване';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => 'Настройки';

  @override
  String get settings_deviceInfo => 'Информация за устройството';

  @override
  String get settings_appSettings => 'Настройки на приложението';

  @override
  String get settings_appSettingsSubtitle =>
      'Уведомления, съобщения и предпочитания за карта';

  @override
  String get settings_nodeSettings => 'Настройки на възела';

  @override
  String get settings_nodeName => 'Име на възела';

  @override
  String get settings_nodeNameNotSet => 'Не е зададено';

  @override
  String get settings_nodeNameHint => 'Въведете име на възел';

  @override
  String get settings_nodeNameUpdated => 'Името е актуализирано';

  @override
  String get settings_radioSettings => 'Настройки на радиопредавателя';

  @override
  String get settings_radioSettingsSubtitle =>
      'Честота, мощност, разпространяващ фактор';

  @override
  String get settings_radioSettingsUpdated =>
      'Радио настройките са актуализирани';

  @override
  String get settings_regionSettings => 'Региони';

  @override
  String get settings_regionSettingsSubtitle =>
      'Управляне на хранилищни региони';

  @override
  String get settings_corridorRegion => 'Регион на коридора';

  @override
  String get settings_corridorRegionDefault => '#corridor (по подразбиране)';

  @override
  String get settings_corridorRegionHelp =>
      'Пакетите за flood коридор се маркират с този регион. Повторителите без фърмуер за коридори ги препращат само ако разрешават този регион. Оставете празно за етикета по подразбиране #corridor.';

  @override
  String get settings_corridorRegionHint => 'Име на региона';

  @override
  String get settings_corridorRegionUseDefault => 'По подразбиране';

  @override
  String get settings_corridorRegionUpdated => 'Регионът на коридора е обновен';

  @override
  String get settings_corridorRegionFailed =>
      'Неуспешно обновяване на региона на коридора';

  @override
  String get settings_regionManagement_screenTitle => 'Регионално управление';

  @override
  String get settings_regionNameHint => 'Възразна название на региона';

  @override
  String get settings_regionAddRegion => 'Добавете регион';

  @override
  String get settings_regionFetchRegions => 'Извън рептерите от региони';

  @override
  String get settings_regionFetchRegionsFail =>
      'Не бъде открити никако региони';

  @override
  String get settings_regionFetchRegionsAlreadyExists =>
      'Тата регион е уже добавена';

  @override
  String get settings_regionName => 'Регионноименоване';

  @override
  String get settings_regionDeleted => 'Регион отстранен';

  @override
  String get settings_deleteRegion => 'Удаляне на регион';

  @override
  String settings_deleteRegionConfirm(String region) {
    return 'Състрясна: отпиште \"$region\" от списка региони?';
  }

  @override
  String get settings_location => 'Местоположение';

  @override
  String get settings_locationSubtitle => 'GPS координати';

  @override
  String get settings_locationUpdated => 'Местоположението е актуализирано';

  @override
  String get settings_locationBothRequired =>
      'Въведете както географска ширина, така и географска дължина.';

  @override
  String get settings_locationInvalid => 'Невалидна ширина или дължина.';

  @override
  String get settings_locationGPSEnable => 'Активиране на GPS';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'Активирайте автоматичното актуализиране на местоположението чрез GPS.';

  @override
  String get settings_locationIntervalSec => 'Интервал за GPS (Секунди)';

  @override
  String get settings_locationIntervalInvalid =>
      'Интервалът трябва да бъде поне 60 секунди и по-малко от 86400 секунди.';

  @override
  String get settings_latitude => 'Широчина';

  @override
  String get settings_longitude => 'Дължина';

  @override
  String get settings_contactSettings => 'Настройки за контакти';

  @override
  String get settings_contactSettingsSubtitle =>
      'Настройки за добавяне на контакти.';

  @override
  String get settings_privacyMode => 'Режим на поверителност';

  @override
  String get settings_privacyModeSubtitle =>
      'Скриване на име/местоположение в рекламите';

  @override
  String get settings_privacyModeToggle =>
      'Активирайте режим на поверителност, за да скриете името и местоположението си в рекламите.';

  @override
  String get settings_privacyModeEnabled =>
      'Режим на поверителност е активиран';

  @override
  String get settings_privacyModeDisabled =>
      'Режим на поверителност е деактивиран';

  @override
  String get settings_privacy => 'Настройки на поверителността';

  @override
  String get settings_privacySubtitle =>
      'Контролирайте каква информация се споделя.';

  @override
  String get settings_privacySettingsDescription =>
      'Изберете каква информация устройството ви споделя с другите.';

  @override
  String get settings_denyAll => 'Откажи всичко';

  @override
  String get settings_allowByContact => 'Позволи по флагове за контакт';

  @override
  String get settings_allowAll => 'Позволи всичко';

  @override
  String get settings_telemetryBaseMode => 'Базов режим на телеметрия';

  @override
  String get settings_telemetryLocationMode =>
      'Режим на местоположение на телеметрията';

  @override
  String get settings_telemetryEnvironmentMode =>
      'Режим на средата на телеметрията';

  @override
  String get settings_advertLocation => 'Място на обявата';

  @override
  String get settings_advertLocationSubtitle =>
      'Включи местоположение в обявата';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'Автоматична zero-hop обява при GPS обновяване';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'Когато GPS местоположението се промени, изпрати zero-hop обява (изисква местоположение в обявата).';

  @override
  String get settings_multiAck => 'Множество ACK';

  @override
  String get settings_telemetryModeUpdated => 'Режим на телеметрията е обновен';

  @override
  String get settings_actions => 'Действия';

  @override
  String get settings_deleteAllPaths => 'Изтрий всички пътища';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Изчисти всички данни за пътищата от контактите.';

  @override
  String get settings_sendAdvertisement => 'Изпрати реклама';

  @override
  String get settings_sendAdvertisementSubtitle => 'Излъчи присъствието сега';

  @override
  String get settings_advertisementSent => 'Рекламата е изпратена';

  @override
  String get settings_syncTime => 'Време за синхронизация';

  @override
  String get settings_syncTimeSubtitle =>
      'Задайте часовника на устройството да отговаря на времето на телефона.';

  @override
  String get settings_timeSynchronized => 'Синхронизирано във времето';

  @override
  String get settings_refreshContacts => 'Презареди контакти';

  @override
  String get settings_refreshContactsSubtitle =>
      'Презареди списъка с контакти от устройството';

  @override
  String get settings_rebootDevice => 'Рестартирай устройството';

  @override
  String get settings_rebootDeviceSubtitle =>
      'Рестартирай устройството MeshCore';

  @override
  String get settings_rebootDeviceConfirm =>
      'Сигурни ли сте, че искате да рестартирате устройството? Ще бъдете прекъснати.';

  @override
  String get settings_debug => 'Отстрани';

  @override
  String get settings_companionDebugLog =>
      'Дневник за отстраняване на грешки на придружаващото приложение';

  @override
  String get settings_companionDebugLogSubtitle =>
      'Команди, отговори и сурови данни за протоколите BLE/TCP/USB';

  @override
  String get settings_appDebugLog =>
      'Лог на отстраняване на грешки на приложението';

  @override
  String get settings_appDebugLogSubtitle =>
      'Съобщения за отстраняване на грешки на приложението';

  @override
  String get settings_about => 'За нас';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core, версия $version';
  }

  @override
  String get settings_aboutLegalese => 'Проект MeshCore с отворен код 2024 г.';

  @override
  String get settings_aboutDescription =>
      'Отворен Flutter клиент за MeshCore LoRa мрежови устройства.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'Данни за надморска височина на LOS: Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => 'Име';

  @override
  String get settings_infoId => 'ИД';

  @override
  String get settings_infoStatus => 'Статус';

  @override
  String get settings_infoBattery => 'Батерия';

  @override
  String get settings_infoPublicKey => 'Публичен ключ';

  @override
  String get settings_infoContactsCount => 'Брой контакти';

  @override
  String get settings_infoChannelCount => 'Брой канали';

  @override
  String get settings_infoHardware => 'Оборудование';

  @override
  String get settings_infoFirmware =>
      'Програмно-оборонни системни программи (фirmware)';

  @override
  String get settings_presets => 'Предварителни настройки';

  @override
  String get settings_frequency => 'Честота (MHz)';

  @override
  String get settings_frequencyHelper => '300,0 – 2500,0';

  @override
  String get settings_frequencyInvalid => 'Невалидна честота (300-2500 MHz)';

  @override
  String get settings_bandwidth => 'Ширина на честотната лента';

  @override
  String get settings_spreadingFactor => 'Фактор на разпространение';

  @override
  String get settings_codingRate => 'Скорост на кодиране';

  @override
  String get settings_txPower => 'TX мощност (dBm)';

  @override
  String get settings_txPowerHelper => '0 - 22';

  @override
  String get settings_txPowerInvalid => 'Невалидна мощност на TX (0-22 dBm)';

  @override
  String get settings_clientRepeat => 'Клиентско повторение';

  @override
  String get settings_clientRepeatSubtitle =>
      'Позволете на това устройство да предава пакети към мрежата за други устройства.';

  @override
  String get settings_clientRepeatFreqWarning =>
      'За повторение извън мрежата са необходими честоти от 433, 869 или 918 MHz.';

  @override
  String settings_error(String message) {
    return 'Грешка: $message';
  }

  @override
  String get appSettings_title => 'Настройки на приложението';

  @override
  String get appSettings_appearance => 'Външен вид';

  @override
  String get appSettings_theme => 'Тема';

  @override
  String get appSettings_themeSystem => 'Система по подразбиране';

  @override
  String get appSettings_themeLight => 'Светла';

  @override
  String get appSettings_themeDark => 'Тъмна';

  @override
  String get appSettings_language => 'Език';

  @override
  String get appSettings_languageSystem => 'Система по подразбиране';

  @override
  String get appSettings_languageEn => 'Английски';

  @override
  String get appSettings_languageFr => 'Френски';

  @override
  String get appSettings_languageEs => 'Испански';

  @override
  String get appSettings_languageDe => 'Немски';

  @override
  String get appSettings_languagePl => 'Полски';

  @override
  String get appSettings_languageSl => 'Словенски';

  @override
  String get appSettings_languagePt => 'Португалски';

  @override
  String get appSettings_languageIt => 'Италиански';

  @override
  String get appSettings_languageZh => 'Китайски';

  @override
  String get appSettings_languageSv => 'Шведски';

  @override
  String get appSettings_languageNl => 'Нидерландски';

  @override
  String get appSettings_languageSk => 'Словашки';

  @override
  String get appSettings_languageBg => 'Български';

  @override
  String get appSettings_languageRu => 'Руски';

  @override
  String get appSettings_languageUk => 'Украински';

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
      'Разрешаване на проследяване на съобщения';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'Показване на подробни метаданни за маршрутизация и синхронизация за съобщения';

  @override
  String get appSettings_notifications => 'Уведомления';

  @override
  String get appSettings_enableNotifications => 'Включи известията';

  @override
  String get appSettings_enableNotificationsSubtitle =>
      'Получавайте известия за съобщения и реклами';

  @override
  String get appSettings_notificationPermissionDenied =>
      'Отказвано е разрешение за известия';

  @override
  String get appSettings_notificationsEnabled => 'Известията са включени';

  @override
  String get appSettings_notificationsDisabled => 'Известията са изключени';

  @override
  String get appSettings_messageNotifications => 'Известия за съобщения';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      'Показвай известие при получаване на нови съобщения';

  @override
  String get appSettings_channelMessageNotifications =>
      'Известия за канални съобщения';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'Показвай известие при получаване на съобщения от канали';

  @override
  String get appSettings_advertisementNotifications => 'Уведомления за реклами';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      'Покажи известие, когато бъдат открити нови възли.';

  @override
  String get appSettings_messaging => 'Съобщения';

  @override
  String get appSettings_clearPathOnMaxRetry =>
      'Изчисти пътя при максимален брой опити';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      'Възстанови пътя към контакта след 5 неуспешни опита за изпращане';

  @override
  String get appSettings_pathsWillBeCleared =>
      'Пътищата ще бъдат почистени след 5 неуспешни опита.';

  @override
  String get appSettings_pathsWillNotBeCleared =>
      'Пътищата няма да бъдат автоматично изчистени.';

  @override
  String get appSettings_autoRouteRotation =>
      'Автоматична ротация на маршрутите';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      'Превключвайте между най-добрите пътища и режим на наводняване';

  @override
  String get appSettings_autoRouteRotationEnabled =>
      'Автоматичната ротация на маршрутите е включена';

  @override
  String get appSettings_autoRouteRotationDisabled =>
      'Автоматичната ротация на маршрутите е изключена';

  @override
  String get appSettings_maxRouteWeight =>
      'Максимално допустимо тегло на маршрута';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      'Максималното тегло, което един маршрут може да събере от успешни доставки.';

  @override
  String get appSettings_initialRouteWeight =>
      'Първоначална тежест на маршрута';

  @override
  String get appSettings_initialRouteWeightSubtitle =>
      'Начално тегло за новооткрити маршрути';

  @override
  String get appSettings_routeWeightSuccessIncrement =>
      'Увеличение на теглото за успех';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      'Тегло, добавено към път след успешно доставяне.';

  @override
  String get appSettings_routeWeightFailureDecrement =>
      'Намаляване на теглото, свързано с неуспех';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      'Тегло, което е било премахнато от пътя след неуспешен опит за доставка.';

  @override
  String get appSettings_maxMessageRetries =>
      'Максимален брой опити за изпращане на съобщение';

  @override
  String get appSettings_maxMessageRetriesSubtitle =>
      'Брой опити за повторно изпращане, преди съобщението да бъде маркирано като неуспешно.';

  @override
  String get appSettings_battery => 'Батерия';

  @override
  String get appSettings_batteryChemistry => 'Химия на батерията';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return 'Зададено за устройство ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      'Свържете се с устройство, за да изберете.';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3.0-4.2V)';

  @override
  String get appSettings_batteryLifepo4 => 'Литиево желязо фосфат (2.6-3.65V)';

  @override
  String get appSettings_batteryLipo => 'Литиев полимер (3.0-4.2V)';

  @override
  String get appSettings_batteryLipoHv => 'LiPo ВЗГ (3,0-4,35 В)';

  @override
  String get appSettings_mapDisplay => 'Карта за показване';

  @override
  String get appSettings_showRepeaters => 'Показване на повторители';

  @override
  String get appSettings_showRepeatersSubtitle =>
      'Показване на възпроизвеждащи се възли на картата';

  @override
  String get appSettings_showChatNodes => 'Покажи Възли на Чат';

  @override
  String get appSettings_showChatNodesSubtitle =>
      'Показване на чат възли на картата';

  @override
  String get appSettings_showOtherNodes => 'Покажи други възли';

  @override
  String get appSettings_showOtherNodesSubtitle =>
      'Покажи други типове възли на картата';

  @override
  String get appSettings_timeFilter => 'Филтриране по време';

  @override
  String get appSettings_timeFilterShowAll => 'Покажи всички възли';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return 'Покажи възли от последните $hours часа';
  }

  @override
  String get appSettings_mapTimeFilter => 'Филтри за време на картата';

  @override
  String get appSettings_showNodesDiscoveredWithin =>
      'Покажи възлите, открити в:';

  @override
  String get appSettings_allTime => 'Всичко време';

  @override
  String get appSettings_lastHour => 'Последната минута';

  @override
  String get appSettings_last6Hours => 'Последни 6 часа';

  @override
  String get appSettings_last24Hours => 'Последно 24 часа';

  @override
  String get appSettings_lastWeek => 'Миналата седмица';

  @override
  String get appSettings_rasterTileSource => 'Източник на растерни плочки';

  @override
  String get appSettings_stadiaEndpoint => 'Крайна точка на Stadia';

  @override
  String get appSettings_stadiaApiKey => 'API ключ за Stadia';

  @override
  String get appSettings_stadiaApiKeyRequired =>
      'Задължително за използване на Stadia Maps';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return 'Конфигурирано: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Въведете своя API ключ за Stadia Maps. Приложението го използва за заявки за растерни плочки.';

  @override
  String get appSettings_offlineMapCache => 'Кеш на офлайн карти';

  @override
  String get appSettings_unitsTitle => 'единици';

  @override
  String get appSettings_unitsMetric => 'Метрика (m / km)';

  @override
  String get appSettings_unitsImperial => 'Имперска (ft / mi)';

  @override
  String get appSettings_noAreaSelected => 'Няма избрана област';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'Избрана е област (мащаб $minZoom-$maxZoom)';
  }

  @override
  String get appSettings_debugCard => 'Отстрани';

  @override
  String get appSettings_appDebugLogging =>
      'Дневник за отстраняване на грешки на приложението';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'Записвай съобщенията за отстраняване на грешки на приложението.';

  @override
  String get appSettings_appDebugLoggingEnabled =>
      'Дневникът за отстраняване на грешки на приложението е включен.';

  @override
  String get appSettings_appDebugLoggingDisabled =>
      'Дневникът за отстраняване на грешки на приложението е изключен.';

  @override
  String get contacts_title => 'Контакти';

  @override
  String get contacts_noContacts => 'Няма контакти към момента.';

  @override
  String get contacts_contactsWillAppear =>
      'Контактите ще се появят, когато устройствата рекламират.';

  @override
  String get contacts_unread => 'Непрочетено';

  @override
  String get contacts_searchContactsNoNumber => 'Търси контакти...';

  @override
  String contacts_searchContacts(int number, String str) {
    return 'Търсене на контакти...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'Търсене на $number$str любими...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'Търсене на $number$str потребители...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'Търсене на $number$str повтарящи се...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'Търсене на $number$str сървъри в стаята...';
  }

  @override
  String get contacts_noUnreadContacts => 'Няма непрочетени контакти';

  @override
  String get contacts_noContactsFound => 'Няма намерени контакти или групи.';

  @override
  String get contacts_deleteContact => 'Изтрий Контакт';

  @override
  String contacts_removeConfirm(String contactName) {
    return 'Изтрий $contactName от контактите?';
  }

  @override
  String get contacts_manageRepeater => 'Управление на повторителя';

  @override
  String get contacts_manageRoom => 'Управление на сървър за стая';

  @override
  String get contacts_roomLogin => 'Вход в стаята';

  @override
  String get contacts_openChat => 'Отвори чат';

  @override
  String get contacts_editGroup => 'Редактирай Група';

  @override
  String get contacts_deleteGroup => 'Изтрий група';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return 'Премахнете \"$groupName\"?';
  }

  @override
  String get contacts_newGroup => 'Нова група';

  @override
  String get contacts_moreOptions => 'Повече възможности';

  @override
  String get contacts_searchOpen => 'Търсене на контакти';

  @override
  String get contacts_searchClose => 'Затвори търсене';

  @override
  String get contacts_groupName => 'Име на групата';

  @override
  String get contacts_groupNameRequired => 'Името на групата е задължително.';

  @override
  String get contacts_groupNameReserved => 'Това име на група е запазено';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'Групата \"$name\" вече съществува.';
  }

  @override
  String get contacts_filterContacts => 'Филтрирай контактите...';

  @override
  String get contacts_noContactsMatchFilter =>
      'Няма съвпадения с вашия филтър.';

  @override
  String get contacts_noMembers => 'Няма членове';

  @override
  String get contacts_lastSeenNow => 'Видян току-що';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return 'Преди $minutes минути';
  }

  @override
  String get contacts_lastSeenHourAgo => 'Преди час';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return 'Преди $hours часа';
  }

  @override
  String get contacts_lastSeenDayAgo => 'Преди 1 ден';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return 'Преди $days дни';
  }

  @override
  String get contact_info => 'Контактна информация';

  @override
  String get contact_settings => 'Настройки за контакти';

  @override
  String get contact_telemetry => 'Телеметрия';

  @override
  String get contact_lastSeen => 'Последно видян';

  @override
  String get contact_clearChat => 'Изчисти чата';

  @override
  String get contact_teleBase => 'Базата данни за телеметрия';

  @override
  String get contact_teleBaseSubtitle =>
      'Позволи споделяне на ниво на батерията и основна телеметрия';

  @override
  String get contact_teleLoc => 'Местоположение на телеметрията';

  @override
  String get contact_teleLocSubtitle =>
      'Позволи споделяне на данни за местоположение';

  @override
  String get contact_teleEnv => 'Среда на телеметрия';

  @override
  String get contact_teleEnvSubtitle =>
      'Позволи споделяне на данни от средносферните датчици';

  @override
  String get channels_title => 'Канали';

  @override
  String get channels_noChannelsConfigured => 'Няма конфигурирани канали';

  @override
  String get channels_addPublicChannel => 'Добави публичен канал';

  @override
  String get channels_searchChannels => 'Търсене на канали...';

  @override
  String get channels_noChannelsFound => 'Няма намерени канали';

  @override
  String channels_channelIndex(int index) {
    return 'Канал $index';
  }

  @override
  String get channels_public => 'Публично';

  @override
  String channels_via(String path) {
    return 'чрез $path';
  }

  @override
  String get channels_viaMqtt => 'чрез MQTT';

  @override
  String get channels_viaMqttSemantics =>
      'Получено чрез MQTT, не е чуто от вашето радио';

  @override
  String get channels_private => 'Частен';

  @override
  String get channels_editChannel => 'Редактирай канал';

  @override
  String get channels_muteChannel => 'Заглуши канала';

  @override
  String get channels_unmuteChannel => 'Включи известията на канала';

  @override
  String get channels_deleteChannel => 'Изтрий канала';

  @override
  String channels_deleteChannelConfirm(String name) {
    return 'Изтрий \"$name\"? Това не може да бъде отменено.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'Неуспешно изтриване на канала \"$name\"';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'Каналът \"$name\" е изтрит';
  }

  @override
  String get channels_addChannel => 'Добави Канал';

  @override
  String get channels_channelIndexLabel => 'Индекс на канал';

  @override
  String get channels_channelName => 'Име на канала';

  @override
  String get channels_usePublicChannel => 'Използвай публичен канал';

  @override
  String get channels_standardPublicPsk => 'Стандартен публичен PSK';

  @override
  String get channels_pskHex => 'PSK (шестнадесетичен код)';

  @override
  String get channels_generateRandomPsk => 'Генерирай случайна PSK';

  @override
  String get channels_enterChannelName => 'Моля, въведете име на канал.';

  @override
  String get channels_pskMustBe32Hex =>
      'PSK трябва да бъде 32 шестнадесетични знака.';

  @override
  String channels_channelAdded(String name) {
    return 'Каналът \"$name\" е добавен';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'Редактирай Канал $index';
  }

  @override
  String get channels_smazCompression => 'Компресия SMAZ';

  @override
  String get channels_cyr2latCompression => 'Компресия Cyr2Lat';

  @override
  String get channels_cyr2latCompressionDscr =>
      'Заменя някои кирилични символи с латиница при изпращане.';

  @override
  String get channels_cyr2latSettingsHeading => 'Настройки на Cyr2Lat';

  @override
  String get channels_cyr2latSettingsSubheading => 'Списък със замествания';

  @override
  String get channels_cyr2latSettingsDscr =>
      'Редактиране на JSON конфигурацията за заместване на символи';

  @override
  String get channels_cyr2latSettingsDialogHint => 'JSON карта за замествания';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'Неправилен JSON: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'Каналът \"$name\" е актуализиран';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Добавяне на профил Cyr2Lat';

  @override
  String get settings_cyr2latProfileName => 'Име на профила';

  @override
  String get settings_cyr2latProfileNameEmpty =>
      'Името на профила не може да бъде празно';

  @override
  String get settings_cyr2latProfileAdded => 'Профилът е добавен успешно';

  @override
  String get settings_cyr2latProfileUpdated =>
      'Профилът е актуализиран успешно';

  @override
  String get settings_cyr2latProfileEdit => 'Редактиране на Cyr2Lat профил';

  @override
  String get settings_cyr2latProfileDelete => 'Изтриване на профил Cyr2Lat';

  @override
  String get settings_cyr2latProfileDeleted => 'Профилът беше изтрит успешно';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return 'Сигурен ли сте, че искате да изтриете профила \"$name\"?';
  }

  @override
  String get channels_publicChannelAdded => 'Публичен канал добавен';

  @override
  String get channels_sortBy => 'Сортирай по';

  @override
  String get channels_sortManual => 'Ръчно';

  @override
  String get channels_sortAZ => 'От А до Я';

  @override
  String get channels_sortLatestMessages => 'Последни съобщения';

  @override
  String get channels_sortUnread => 'Непрочетено';

  @override
  String get channels_createPrivateChannel => 'Създай Частен Канал';

  @override
  String get channels_createPrivateChannelDesc => 'Защитено с таен ключ.';

  @override
  String get channels_joinPrivateChannel => 'Присъедини се към Частен Канал';

  @override
  String get channels_joinPrivateChannelDesc => 'Ръчно въведете таен ключ.';

  @override
  String get channels_joinPublicChannel =>
      'Присъединете се към Публичния канал';

  @override
  String get channels_joinPublicChannelDesc =>
      'Всеки може да се присъедини към този канал.';

  @override
  String get channels_joinHashtagChannel => 'Присъедини се към Хаштаг Канал';

  @override
  String get channels_joinHashtagChannelDesc =>
      'Всеки може да се присъедини към хаштаговите канали.';

  @override
  String get channels_scanQrCode => 'Сканирайте QR код';

  @override
  String get channels_scanQrCodeComingSoon => 'Ще излезе скоро';

  @override
  String get channels_enterHashtag => 'Въведете хаштаг';

  @override
  String get channels_hashtagHint => 'напр. #отбор';

  @override
  String channels_regionSetTo(String region) {
    return 'Регион: $region';
  }

  @override
  String get channels_regionNotSet => 'Регион: ние';

  @override
  String get channels_regionSelect_Title => 'Выберете регион';

  @override
  String get channels_clearRegion => 'Чиста зона';

  @override
  String get chat_noMessages => 'Няма съобщения.';

  @override
  String get chat_sendMessage => 'Изпратете съобщение';

  @override
  String chat_sendMessageTo(String contactName) {
    return 'Изпрати съобщение на $contactName';
  }

  @override
  String get chat_sendMessageToStart => 'Изпрати съобщение, за да започнеш.';

  @override
  String get chat_originalMessageNotFound => 'Съобщението не е намерено';

  @override
  String chat_replyingTo(String name) {
    return 'Отговарям на $name';
  }

  @override
  String chat_replyTo(String name) {
    return 'Отговори на $name';
  }

  @override
  String get chat_location => 'Местоположение';

  @override
  String get chat_typeMessage => 'Въведете съобщение...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'Съобщението е твърде дълго (макс $maxBytes байта).';
  }

  @override
  String get chat_messageCopied => 'Съобщението е копирано';

  @override
  String get chat_messageDeleted => 'Съобщението е изтрито';

  @override
  String get chat_retryingMessage => 'Опитваме се отново.';

  @override
  String chat_retryCount(int current, int max) {
    return 'Опитай отново $current/$max';
  }

  @override
  String get chat_selectSendAction => 'Изберете действие за изпращане';

  @override
  String get chat_sendGif => 'Изпрати GIF';

  @override
  String get chat_limitToArea => 'Ограничаване до район';

  @override
  String get chat_limitToAreaTitle => 'Изпращане само в рамките на…';

  @override
  String get chat_limitToAreaHelp =>
      'Повторителите с фърмуер за flood коридори препредават съобщението само в този район. Другите повторители го отхвърлят, освен ако не разрешават вашия регион на коридора.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '$km км около вас';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return 'Само в радиус $km км от вас';
  }

  @override
  String get chat_limitToAreaOff => 'Без ограничение';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'Задайте позицията на радиото, за да ограничавате съобщенията до район.';

  @override
  String get chat_sendImageLora => 'Изпращане на изображение чрез MeshCore';

  @override
  String get chat_imagePickFailed => 'Не мог да откривам та изображин';

  @override
  String get chat_receivedGif => 'Получил GIF';

  @override
  String get chat_reply => 'Отговори';

  @override
  String get chat_addReaction => 'Добави Реакция';

  @override
  String get chat_me => 'Аз';

  @override
  String get reaction_report => 'Реакции с емоджи';

  @override
  String get emojiCategorySmileys => 'Емотикони';

  @override
  String get emojiCategoryGestures => 'Жестове';

  @override
  String get emojiCategoryHearts => 'Сърца';

  @override
  String get emojiCategoryObjects => 'Обекти';

  @override
  String get gifPicker_title => 'Изберете GIF';

  @override
  String get gifPicker_searchHint => 'Търсене на GIF-ове...';

  @override
  String get gifPicker_poweredBy => 'Задвижвано от GIPHY';

  @override
  String get gifPicker_noGifsFound => 'Няма намерени GIF файлове.';

  @override
  String get gifPicker_failedLoad => 'Не можа да се заредят GIF файловете';

  @override
  String get gifPicker_failedSearch => 'Неуспешно търсене на GIF-ове';

  @override
  String get gifPicker_noInternet => 'Няма интернет връзка';

  @override
  String get debugLog_appTitle =>
      'Лог на отстраняване на грешки на приложението';

  @override
  String get debugLog_bleTitle => 'Лог за отстраняване на грешки на BLE';

  @override
  String get debugLog_copyLog => 'Копирай лог';

  @override
  String get debugLog_clearLog => 'Изчисти логовете';

  @override
  String get debugLog_copied => 'Копирано лого за отстраняване на грешки';

  @override
  String get debugLog_bleCopied => 'Копиран лог от BLE';

  @override
  String get debugLog_noEntries => 'Все още няма дебъг логове.';

  @override
  String get debugLog_enableInSettings =>
      'Активирайте отстраняване на грешки в настройките на приложението';

  @override
  String get debugLog_frames => 'Рамки';

  @override
  String get debugLog_rawLogRx => 'Необработен лог-RX';

  @override
  String get debugLog_noBleActivity => 'Няма BLE активност към момента.';

  @override
  String debugFrame_length(int count) {
    return 'Дължина на кадъра: $count байта';
  }

  @override
  String debugFrame_command(String value) {
    return 'Команда: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'Съобщение:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- Дестинация Публичен Ключ: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- Време: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- Флагове: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- Тип текст: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'Команден ред (CLI)';

  @override
  String get debugFrame_textTypePlain => 'Просто';

  @override
  String debugFrame_text(String text) {
    return '- Текст: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => 'Хексадесетичен Dump:';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'скока',
      one: 'скок',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => 'Премахни пътя';

  @override
  String get chat_noPathHistoryYet =>
      'Няма история на пътищата още.\nИзпратете съобщение, за да откриете пътища.';

  @override
  String get chat_pathCleared =>
      'Пътят е почистен. Следващото съобщение ще открие маршрута отново.';

  @override
  String get chat_fullPath => 'Пълен път';

  @override
  String get routing_title => 'Маршрутизиране';

  @override
  String get routing_modeAuto => 'Автоматично';

  @override
  String get routing_modeFlood => 'Наводняване';

  @override
  String get routing_modeManual => 'Ръчно';

  @override
  String get routing_modeAutoHint =>
      'Автоматично избира най-добрия известен път, а при липса на информация използва стратегия за наводняване.';

  @override
  String get routing_modeFloodHint =>
      'Излъчва през всички повторители. Най-надеждният начин, но изисква повече време в ефира.';

  @override
  String get routing_modeManualHint =>
      'Винаги следва точно пътя, който сте определили.';

  @override
  String get routing_currentRoute => 'Текущ маршрут';

  @override
  String get routing_directNoHops => 'Директно - без скокове';

  @override
  String get routing_noPathYet =>
      'Все още няма път. Съобщението продължава да се изпраща, докато не бъде открит маршрут.';

  @override
  String get routing_floodBroadcast => 'Предаване през всички повторители';

  @override
  String get routing_editPath => 'Редактирай пътя';

  @override
  String get routing_forgetPath => 'Забрави пътя';

  @override
  String get routing_knownPaths => 'Известни пътища';

  @override
  String get routing_knownPathsHint =>
      'Докоснете бутона, за да превключите към него.';

  @override
  String get routing_inUse => 'В употреба';

  @override
  String get routing_qualityStrong => 'Силен първи скок';

  @override
  String get routing_qualityGood => 'Добър първи опит';

  @override
  String get routing_qualityFair => 'Приемлив първи скок';

  @override
  String get routing_qualityWorked => 'Работил';

  @override
  String get routing_qualityFlood => 'Получено чрез наводняване';

  @override
  String get routing_qualityUntested => 'Нетестирано';

  @override
  String routing_lastWorked(String when) {
    return 'последно работил $when';
  }

  @override
  String get routing_neverWorked => 'Никога не е потвърдено';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes доставени, $failures неуспешни';
  }

  @override
  String get routing_floodDelivery => 'Доставка при наводняване';

  @override
  String get pathEditor_title => 'Създаване на път';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count от 64 скока';
  }

  @override
  String get pathEditor_noHops =>
      'Все още няма добавени скокове. Можете да използвате бутоните по-долу, за да ги добавите по ред, или да запазите пътя без скокове, за да го изпратите директно.';

  @override
  String get pathEditor_addHops => 'Добавете скоковете в посочения ред.';

  @override
  String get pathEditor_searchRepeaters => 'Търсене на повторители';

  @override
  String get pathEditor_advancedHex => 'Разширено: суров шестнадесетичен път';

  @override
  String get pathEditor_hexLabel => 'Шестнадесетични префикси';

  @override
  String get pathEditor_hexHelper =>
      'Два шестнадесетични идентификатора на скок, разделени със запетаи';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return 'Невалидни: $tokens';
  }

  @override
  String get pathEditor_tooManyHops => 'Максимум 64 скока';

  @override
  String get pathEditor_usePath => 'Използвай този маршрут.';

  @override
  String get pathEditor_removeHop => 'Премахни скока';

  @override
  String get pathEditor_unknownHop => 'Неизвестен повторител';

  @override
  String get chat_pathSavedLocally =>
      'Запазено локално. Свържете се за синхронизиране.';

  @override
  String get chat_pathDeviceConfirmed => 'Устройство потвърдено.';

  @override
  String get chat_pathDeviceNotConfirmed =>
      'Устройството все още не е потвърдено.';

  @override
  String get chat_type => 'Въведете';

  @override
  String get chat_path => 'Път';

  @override
  String get chat_publicKey => 'Публичен ключ';

  @override
  String get chat_compressOutgoingMessages =>
      'Компресиране на изходящи съобщения';

  @override
  String get chat_floodForced => 'Наводняване (принудително)';

  @override
  String get chat_directForced => 'Директно (принудително)';

  @override
  String chat_hopsForced(int count) {
    return '$count скока (принудително)';
  }

  @override
  String get chat_floodAuto => 'Наводняване (автоматично)';

  @override
  String get chat_direct => 'Директно';

  @override
  String get chat_poiShared => 'Споделена точка на интерес';

  @override
  String chat_unread(int count) {
    return 'Непрочетени: $count';
  }

  @override
  String get chat_markAsUnread => 'Отбелязване като непрочетено';

  @override
  String get chat_newMessages => 'Нови съобщения';

  @override
  String get chat_openLink => 'Отворете връзката?';

  @override
  String get chat_openLinkConfirmation =>
      'Искате ли да отворите тази връзка в браузъра си?';

  @override
  String get chat_open => 'Отвори';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'Не можа да се отвори връзката: $url';
  }

  @override
  String get chat_invalidLink => 'Невалиден формат на връзката';

  @override
  String get map_title => 'Карта на възлите';

  @override
  String get map_searchHint => 'Търсене по име или идентификатор на възел';

  @override
  String get map_activity => 'Дейност';

  @override
  String get map_online => 'Онлайн';

  @override
  String get map_recent => 'Скорошни';

  @override
  String get map_stale => 'Остарял';

  @override
  String get map_visible => 'Видими';

  @override
  String get map_hidden => 'Скрит';

  @override
  String get map_centerOnNode => 'Центрирай върху възела';

  @override
  String get map_details => 'Подробности';

  @override
  String get map_noGps => 'Без GPS';

  @override
  String get map_noResults => 'Няма съвпадащи възли';

  @override
  String get map_lineOfSight => 'Линия на видимост';

  @override
  String get map_losScreenTitle => 'Линия на видимост';

  @override
  String get map_noNodesWithLocation => 'Няма възли с данни за местоположение.';

  @override
  String get map_nodesNeedGps =>
      'Възлите трябва да споделят GPS координатите си,\nза да се появят на картата.';

  @override
  String map_nodesCount(int count) {
    return 'Възли: $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'Пинове: $count';
  }

  @override
  String get map_chat => 'Чат';

  @override
  String get map_repeater => 'Повторител';

  @override
  String get map_room => 'Стая';

  @override
  String get map_sensor => 'Сензор';

  @override
  String get map_pinDm => 'Пин (DM)';

  @override
  String get map_pinPrivate => 'Пин (личен)';

  @override
  String get map_pinPublic => 'Публичен пин';

  @override
  String get map_lastSeen => 'Последно видян';

  @override
  String get map_disconnectConfirm =>
      'Сигурни ли сте, че искате да прекъснете връзката с това устройство?';

  @override
  String get map_from => 'От';

  @override
  String get map_source => 'Източник';

  @override
  String get map_flags => 'Флагове';

  @override
  String get map_type => 'Тип';

  @override
  String get map_path => 'Път';

  @override
  String get map_location => 'Местоположение';

  @override
  String get map_estLocation => 'Прибл. местоположение';

  @override
  String get map_publicKey => 'Публичен ключ';

  @override
  String get map_publicKeyPrefixHint => 'напр. ab12';

  @override
  String get map_shareMarkerHere => 'Споделете маркер тук';

  @override
  String get map_setAsMyLocation => 'Задайте като моя местоположение';

  @override
  String get floodCorridor_title => 'Flood коридор';

  @override
  String get floodCorridor_previewToHere => 'Преглед на flood коридор дотук';

  @override
  String get floodCorridor_requesting => 'Изисква се коридор от радиото…';

  @override
  String get floodCorridor_unsupported =>
      'Фърмуерът на радиото ви не поддържа flood коридори.';

  @override
  String get floodCorridor_noProposal =>
      'Радиото не успя да предложи коридор. Уверете се, че има зададена позиция.';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count кръга',
      one: '1 кръг',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return '$inside от $total познати повторители вътре';
  }

  @override
  String get floodCorridor_straightLine =>
      'Права линия: няма познати повторители по пътя';

  @override
  String get floodCorridor_followsRepeaters =>
      'Следва познатите ви повторители';

  @override
  String get floodCorridor_horizonLimited =>
      'Познатите повторители не достигат целта; останалото е права линия';

  @override
  String get floodCorridor_thinStretch =>
      'Част от коридора има малко познати повторители';

  @override
  String get floodCorridor_moreCoverage =>
      'Изисквай повече покритие с повторители';

  @override
  String get floodCorridor_previewNote =>
      'Само преглед. Повторителите без фърмуер за коридори не прилагат коридори.';

  @override
  String get map_pinLabel => 'Етикет на пина';

  @override
  String get map_label => 'Етикет';

  @override
  String get map_pointOfInterest => 'Точка на интерес';

  @override
  String get map_sendToContact => 'Изпрати на контакт';

  @override
  String get map_sendToChannel => 'Изпрати в канала';

  @override
  String get map_noChannelsAvailable => 'Няма налични канали';

  @override
  String get map_publicLocationShare => 'Споделяне на публично местоположение';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return 'Ще споделите местоположение в $channelLabel. Този канал е публичен и всеки с PSK може да го види.';
  }

  @override
  String get map_connectToShareMarkers =>
      'Свържете се с устройство, за да споделяте маркери.';

  @override
  String get map_filterNodes => 'Филтрирай възлите';

  @override
  String get map_nodeTypes => 'Типове възли';

  @override
  String get map_chatNodes => 'Възли на чата';

  @override
  String get map_repeaters => 'Повторители';

  @override
  String get map_otherNodes => 'Други възли';

  @override
  String get map_showOverlaps => 'Покриване на ключа на повтаряча';

  @override
  String get map_keyPrefix => 'Префикс на ключа';

  @override
  String get map_filterByKeyPrefix => 'Филтрирайте по префикс на ключ';

  @override
  String get map_publicKeyPrefix => 'Префикс на публичния ключ';

  @override
  String get map_markers => 'Маркери';

  @override
  String get map_showSharedMarkers => 'Показвай споделените маркери';

  @override
  String get map_showGuessedLocations =>
      'Покажете местоположенията на предположените възли.';

  @override
  String get map_showDiscoveryContacts => 'Покажи контакти за откриване';

  @override
  String get map_guessedLocation => 'Предполагано местоположение';

  @override
  String get map_lastSeenTime => 'Последно видян';

  @override
  String get map_sharedPin => 'Споделен пин';

  @override
  String get map_sharedAt => 'Споделено';

  @override
  String get map_joinRoom => 'Присъедини се към стаята';

  @override
  String get map_manageRepeater => 'Управление на повторителя';

  @override
  String get map_tapToAdd => 'Докоснете възлите, за да ги добавите към пътя.';

  @override
  String get map_runTrace => 'Стартирай проследяването на пътя';

  @override
  String get map_runTraceWithReturnPath => 'Върни се по същия път.';

  @override
  String get map_removeLast => 'Премахни последното';

  @override
  String get map_pathTraceCancelled => 'Отменен е следването на пътя.';

  @override
  String get mapCache_title => 'Кеш на офлайн карти';

  @override
  String get mapCache_selectAreaFirst => 'Изберете област за кеширане първа';

  @override
  String get mapCache_noTilesToDownload =>
      'Няма плочки за изтегляне за тази област.';

  @override
  String get mapCache_downloadTilesTitle => 'Изтегли плочки';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return 'Изтегли $count плочки за офлайн употреба?';
  }

  @override
  String get mapCache_downloadAction => 'Изтегли';

  @override
  String mapCache_cachedTiles(int count) {
    return 'Кеширани $count плочки';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return 'Запазени $downloaded плочки ($failed неуспешни)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => 'Изчисти офлайн кеша';

  @override
  String get mapCache_clearOfflineCachePrompt =>
      'Премахнете всички кеширани плочки на картата?';

  @override
  String get mapCache_offlineCacheCleared =>
      'Кешът на устройството е изчистен.';

  @override
  String get mapCache_noAreaSelected => 'Няма избрана област';

  @override
  String get mapCache_cacheArea => 'Област с кеш';

  @override
  String get mapCache_useCurrentView => 'Използвайте текущия изглед';

  @override
  String get mapCache_zoomRange => 'Обхват на увеличението';

  @override
  String mapCache_estimatedTiles(int count) {
    return 'Очаквани плочки: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return 'Изтеглено $completed / $total';
  }

  @override
  String get mapCache_downloadTilesButton => 'Изтегли плочките';

  @override
  String get mapCache_clearCacheButton => 'Изчисти кеша';

  @override
  String mapCache_failedDownloads(int count) {
    return 'Неуспешни изтегляния: $count';
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
    return 'Север $north, Юг $south, Изток $east, Запад $west';
  }

  @override
  String get time_justNow => 'Току-що';

  @override
  String time_minutesAgo(int minutes) {
    return 'Преди $minutes минути';
  }

  @override
  String time_hoursAgo(int hours) {
    return 'Преди $hours часа';
  }

  @override
  String time_daysAgo(int days) {
    return 'Преди $days дни';
  }

  @override
  String get time_hour => 'час';

  @override
  String get time_hours => 'часове';

  @override
  String get time_day => 'ден';

  @override
  String get time_days => 'дни';

  @override
  String get time_week => 'седмица';

  @override
  String get time_weeks => 'седмици';

  @override
  String get time_month => 'месец';

  @override
  String get time_months => 'месеци';

  @override
  String get time_minutes => 'минути';

  @override
  String get time_allTime => 'За цялото време';

  @override
  String get dialog_disconnect => 'Прекъсни';

  @override
  String get dialog_disconnectConfirm =>
      'Сигурни ли сте, че искате да прекъснете връзката с това устройство?';

  @override
  String get login_repeaterLogin => 'Вход за повторител';

  @override
  String get login_roomLogin => 'Вход в стаята';

  @override
  String get login_password => 'Парола';

  @override
  String get login_enterPassword => 'Въведете парола';

  @override
  String get login_savePassword => 'Запази паролата';

  @override
  String get login_savePasswordSubtitle =>
      'Паролата ще бъде съхранена сигурно на това устройство.';

  @override
  String get login_repeaterDescription =>
      'Въведете паролата на повторителя, за да получите достъп до настройките и статуса.';

  @override
  String get login_roomDescription =>
      'Въведете паролата на стаята, за да получите достъп до настройките и статуса.';

  @override
  String get login_routing => 'Маршрутизиране';

  @override
  String get login_routingMode => 'Режим на маршрутизиране';

  @override
  String get login_autoUseSavedPath => 'Автоматично (използвай запазения път)';

  @override
  String get login_forceFloodMode => 'Принуди режим на наводняване';

  @override
  String get login_managePaths => 'Управление на пътищата';

  @override
  String get login_login => 'Вход';

  @override
  String login_attempt(int current, int max) {
    return 'Опитвате $current/$max';
  }

  @override
  String login_failed(String error) {
    return 'Входът не беше успешен: $error';
  }

  @override
  String get login_failedMessage =>
      'Входът не беше успешен. Или паролата е грешна, или повторителят е недостъпен.';

  @override
  String get common_reload => 'Презареди';

  @override
  String get common_clear => 'Изчисти';

  @override
  String get path_currentPathLabel => 'Текущ път';

  @override
  String get path_noRepeatersFound =>
      'Няма намерени репетитори или сървъри на стаи.';

  @override
  String get repeater_management => 'Управление на повторители';

  @override
  String get room_management => 'Управление на сървъра за стая';

  @override
  String get repeater_guest => 'Информация за ретранслаторите';

  @override
  String get room_guest => 'Информация за сървъра на стаята';

  @override
  String get repeater_managementTools => 'Инструменти за управление';

  @override
  String get repeater_guestTools => 'Инструменти за гости';

  @override
  String get repeater_status => 'Статус';

  @override
  String get repeater_statusSubtitle =>
      'Прегледайте статуса, статистиката и съседните устройства.';

  @override
  String get repeater_telemetry => 'Телеметрия';

  @override
  String get repeater_telemetrySubtitle =>
      'Прегледайте телеметрията на сензорите и системните статистики';

  @override
  String get repeater_cli => 'Команден ред (CLI)';

  @override
  String get repeater_cliSubtitle => 'Изпрати команди към ретранслатора';

  @override
  String get repeater_neighbors => 'Съседи';

  @override
  String get repeater_neighborsSubtitle =>
      'Преглед на съседни възли с нулев скок.';

  @override
  String get repeater_settings => 'Настройки';

  @override
  String get repeater_settingsSubtitle =>
      'Конфигурирайте параметрите на повторителя';

  @override
  String get repeater_clockSyncAfterLogin =>
      'Синхронизиране на часовника след влизане';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      'Автоматично изпращайте съобщение \"синхронизиране на часовника\" след успешно влизане.';

  @override
  String get repeater_statusTitle => 'Статус на повтарянето';

  @override
  String get repeater_routingMode => 'Режим на маршрутизиране';

  @override
  String get repeater_refresh => 'Презареди';

  @override
  String get repeater_statusRequestTimeout =>
      'Заявката за статус премина прекалено дълго.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'Грешка при зареждане на статуса: $error';
  }

  @override
  String get repeater_systemInformation => 'Информация за системата';

  @override
  String get repeater_battery => 'Батерия';

  @override
  String get repeater_clockAtLogin => 'Часовник (при влизане)';

  @override
  String get repeater_uptime => 'Наличност';

  @override
  String get repeater_queueLength => 'Дължина на опашката';

  @override
  String get repeater_debugFlags => 'Контролни точки за отстраняване на грешки';

  @override
  String get repeater_radioStatistics => 'Статистика на радиостанциите';

  @override
  String get repeater_lastRssi => 'Последна RSSI';

  @override
  String get repeater_lastSnr => 'Последна SNR';

  @override
  String get repeater_noiseFloor => 'Ниво на шум';

  @override
  String get repeater_txAirtime => 'TX време в ефир';

  @override
  String get repeater_rxAirtime => 'RX време в ефир';

  @override
  String get repeater_chanUtil => 'Използване на канала';

  @override
  String get repeater_packetStatistics => 'Статистика на пакетите';

  @override
  String get repeater_sent => 'Изпратено';

  @override
  String get repeater_received => 'Получено';

  @override
  String get repeater_duplicates => 'Дубликати';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days дни $hoursч $minutesм $secondsс';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return 'Общо: $total, Наводнение: $flood, Директно: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return 'Общо: $total, Наводнение: $flood, Директно: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return 'Поливане: $flood, Директен: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return 'Общо: $total';
  }

  @override
  String get repeater_settingsTitle => 'Настройки на повтарящия се елемент';

  @override
  String get repeater_basicSettings => 'Основни настройки';

  @override
  String get repeater_repeaterName => 'Име на повтарящ се елемент';

  @override
  String get repeater_repeaterNameHelper =>
      'Показване на името на този повторител';

  @override
  String get repeater_adminPassword => 'Парола на администратора';

  @override
  String get repeater_adminPasswordHelper => 'Пълен достъпен парола';

  @override
  String get repeater_guestPassword => 'Парола на гост';

  @override
  String get repeater_guestPasswordHelper => 'Достъп с ограничен достъп';

  @override
  String get repeater_radioSettings => 'Настройки на радиостанцията';

  @override
  String get repeater_frequencyMhz => 'Честота (MHz)';

  @override
  String get repeater_frequencyHelper => '300-2500 MHz';

  @override
  String get repeater_txPower => 'TX мощност';

  @override
  String get repeater_txPowerHelper => '1-30 dBm';

  @override
  String get repeater_bandwidth => 'Ширина на честотния спектър';

  @override
  String get repeater_spreadingFactor => 'Фактор на разпространение';

  @override
  String get repeater_codingRate => 'Скорост на кодиране';

  @override
  String get repeater_locationSettings => 'Настройки на местоположението';

  @override
  String get repeater_latitude => 'Широчина';

  @override
  String get repeater_latitudeHelper => 'Десетични градуси (напр. 37.7749)';

  @override
  String get repeater_longitude => 'Дължина';

  @override
  String get repeater_longitudeHelper =>
      'Градуси с десетични знаци (напр. -122.4194)';

  @override
  String get repeater_features => 'Характеристики';

  @override
  String get repeater_packetForwarding => 'Пренасочване на пакети';

  @override
  String get repeater_packetForwardingSubtitle =>
      'Активирайте повторителя, за да препраща пакети.';

  @override
  String get repeater_guestAccess => 'Достъп за гости';

  @override
  String get repeater_guestAccessSubtitle => 'Разрешете само четене за гости';

  @override
  String get repeater_privacyMode => 'Режим на поверителност';

  @override
  String get repeater_privacyModeSubtitle =>
      'Скриване на име/местоположение в рекламите';

  @override
  String get repeater_advertisementSettings => 'Настройки на рекламите';

  @override
  String get repeater_localAdvertInterval => 'Интервал на местната реклама';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes минути';
  }

  @override
  String get repeater_floodAdvertInterval =>
      'Интервал на рекламата за наводняване';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours часа';
  }

  @override
  String get repeater_encryptedAdvertInterval =>
      'Криптиран интервал на рекламата';

  @override
  String get repeater_dangerZone => 'Опасна зона';

  @override
  String get repeater_rebootRepeater => 'Рестартирай повторителя';

  @override
  String get repeater_rebootRepeaterSubtitle => 'Рестартира повторителя.';

  @override
  String get repeater_rebootRepeaterConfirm =>
      'Сигурни ли сте, че искате да рестартирате този повторител?';

  @override
  String get repeater_regenerateIdentityKey =>
      'Генерирай нов идентификационен ключ';

  @override
  String get repeater_regenerateIdentityKeySubtitle =>
      'Генерирай нова двойка публичен/частен ключ';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'Това ще генерира нова идентичност за повторителя. Продължете?';

  @override
  String get repeater_eraseFileSystem => 'Изтрий файловата система';

  @override
  String get repeater_eraseFileSystemSubtitle =>
      'Форматирай файловата система на повторителя';

  @override
  String get repeater_eraseFileSystemConfirm =>
      'ВНИМАНИЕ: Това ще изтрие всички данни от повторителя. Това не може да бъде отменено!';

  @override
  String get repeater_eraseSerialOnly =>
      'Изтриването е достъпно само през серийния терминал.';

  @override
  String repeater_commandSent(String command) {
    return 'Командата е изпратена: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'Грешка при изпращане на командата: $error';
  }

  @override
  String get repeater_confirm => 'Потвърди';

  @override
  String get repeater_settingsSaved => 'Настройките са запазени успешно.';

  @override
  String get repeater_rxGain => 'RX усилване';

  @override
  String get repeater_rxGainHelper =>
      'По-висока чувствителност, по-голям ток (само за SX1262/SX1268)';

  @override
  String get repeater_refreshRxGain => 'Обнови RX усилването';

  @override
  String get repeater_multiAcks => 'Множество потвърждения';

  @override
  String get repeater_multiAcksSubtitle =>
      'Потвърждавай съобщенията по множество канали за по-добро доставяне.';

  @override
  String get repeater_refreshMultiAcks => 'Обнови множествените ACK';

  @override
  String get repeater_networkHealth => 'Състояние на мрежата';

  @override
  String get repeater_loopDetect => 'Откриване на цикли';

  @override
  String get repeater_loopDetectHelper =>
      'Изпратете пакети, които изглеждат като цикли в маршрутизацията.';

  @override
  String get repeater_loopDetectOff => 'Изключено';

  @override
  String get repeater_loopDetectMinimal => 'Минимален';

  @override
  String get repeater_loopDetectModerate => 'Умерен';

  @override
  String get repeater_loopDetectStrict => 'Строг';

  @override
  String get repeater_dutyCycle => 'Работен цикъл';

  @override
  String get repeater_dutyCycleHelper =>
      'Максимален процент на използване на времето в ефир';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => 'Информация за оператора';

  @override
  String get repeater_ownerInfoHelper =>
      'Публични метаданни за този повторител';

  @override
  String get repeater_refreshOwnerInfo => 'Обновете информацията за оператора';

  @override
  String get repeater_floodMax => 'Максимален брой хопове при наводняване';

  @override
  String get repeater_floodMaxHelper =>
      'Максималният брой хопове, които един пакет може да премине (0-64)';

  @override
  String get repeater_advancedSettings => 'Разширени настройки';

  @override
  String get repeater_advancedSettingsSubtitle =>
      'Експериментални настройки за опитни оператори';

  @override
  String get repeater_pathHashMode => 'Режим за хеширане на пътища';

  @override
  String get repeater_pathHashModeHelper =>
      'Байтовете, използвани за кодиране на идентификатора на този повторител в таговете за откриване на потоци/цикли, са: 0=1 байт (256 идентификатора, до 64 скока), 1=2 байта (65 000 идентификатора, до 32 скока), 2=3 байта (16 милиона идентификатора, до 21 скока). Версиите 1.13 и по-старите фърмуери използват многобайтови пътища - само след като мрежата е актуализирана до версия 1.14 или по-нова.';

  @override
  String get repeater_keySettings => 'Изменяне на идентичности ключа';

  @override
  String get repeater_keySettingsSubtitle =>
      'Замени ключовият пар от публични/частни';

  @override
  String get repeater_prvKey => 'Частни ключ';

  @override
  String get repeater_prvKeyHelper =>
      'Нова приватна ключ на повторчето, 128-символовна шестнадатерична строка.';

  @override
  String get repeater_generatePrvKey => 'Генериране на случайна ключи';

  @override
  String get repeater_stopGeneratingPrvKey =>
      'Прервана поискна на ключова парта';

  @override
  String get repeater_pubKey => 'Публична ключ';

  @override
  String get repeater_pubKeyHelper =>
      'Та е публичната ключ, която се свързува с генериранта приватна ключ. Трябва да не настройте тоа напрямо.';

  @override
  String get repeater_pubKeyPrefix => 'Желата префикс';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'Наискате публична ключ, който почева с този шестнадатницил. Ожидавани проби: $tries.';
  }

  @override
  String get repeater_txDelay => 'Забавяне на Flood TX';

  @override
  String get repeater_txDelayHelper =>
      'Разстоянието между пакетите при наводняване като множител на времето за пренос на пакета (0-2, по подразбиране 0.5). По-висока стойност означава по-малко сблъсъци, но по-бавно предаване.';

  @override
  String get repeater_directTxDelay => 'Забавяне на директното предаване';

  @override
  String get repeater_directTxDelayHelper =>
      'Интервал за директен (не-масов) трафик, като множител на времето за пренос на пакета (0-2, по подразбиране 0.3).';

  @override
  String get repeater_intThresh => 'Праг на смущенията';

  @override
  String get repeater_intThreshHelper =>
      'Прагът е зададен на нивото на шума на радиото, така че да отхвърля смущения, които са над този праг. 0 – изключва; активирайте само, ако забележите грешки в шумна честотна лента.';

  @override
  String get repeater_agcResetInterval => 'Интервал за нулиране на AGC';

  @override
  String get repeater_agcResetIntervalHelper =>
      'Колко често да се рестартира автоматичната настройка на усилването, за да се възстанови от състояние, в което усилването е блокирано. Времето за рестартиране е няколко секунди, като се определя като кратна на 4. 0 деактивира периодичното рестартиране.';

  @override
  String get repeater_actionsTitle => 'Действия';

  @override
  String get repeater_sendAdvert => 'Изпрати реклама за наводняване';

  @override
  String get repeater_sendAdvertSubtitle =>
      'Публикувай реклама за наводняване в мрежата.';

  @override
  String get repeater_sendAdvertZeroHop => 'Изпрати реклама без хопове';

  @override
  String get repeater_sendAdvertZeroHopSubtitle =>
      'Публикувай реклама, която достига до целевата аудитория само чрез директно разпространение.';

  @override
  String get repeater_clockSync => 'Синхронизирай часовника сега';

  @override
  String get repeater_clockSyncSubtitle =>
      'Настройте времето на телефона си да съвпада с времето на повторителя.';

  @override
  String repeater_actionSucceeded(String action) {
    return '$action успешно';
  }

  @override
  String repeater_actionFailed(String action, String error) {
    return '$action не успя: $error';
  }

  @override
  String get repeater_settingsSavedRebootNeeded =>
      'Настройките са запазени - рестартирайте повторителя, за да ги приложите.';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return 'Някои настройки не успяха: $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return 'Грешка при запазване на настройките: $error';
  }

  @override
  String get repeater_refreshBasicSettings => 'Обнови основните настройки';

  @override
  String get repeater_refreshRadioSettings => 'Обнови настройките на радиото';

  @override
  String get repeater_refreshTxPower => 'Обнови TX мощността';

  @override
  String get repeater_refreshPacketForwarding =>
      'Обнови препращането на пакети';

  @override
  String get repeater_refreshGuestAccess => 'Обнови достъпа за гости';

  @override
  String get repeater_refreshPrivacyMode => 'Обнови режима на поверителност';

  @override
  String repeater_refreshed(String label) {
    return '$label е обновено';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return 'Грешка при обновяване на $label';
  }

  @override
  String get repeater_cliTitle => 'CLI на повторителя';

  @override
  String get repeater_debugNextCommand => 'Отстрани следващата команда';

  @override
  String get repeater_commandHelp => 'Помощ';

  @override
  String get repeater_clearHistory => 'Изчисти историята';

  @override
  String get repeater_noCommandsSent => 'Няма изпратени команди засега.';

  @override
  String get repeater_typeCommandOrUseQuick =>
      'Въведете команда по-долу или използвайте бързи команди';

  @override
  String get repeater_enterCommandHint => 'Въведете команда...';

  @override
  String get repeater_previousCommand => 'Предишна команда';

  @override
  String get repeater_nextCommand => 'Следваща команда';

  @override
  String get repeater_enterCommandFirst => 'Въведете първо команда.';

  @override
  String get repeater_cliCommandFrameTitle => 'Рамка на CLI команда';

  @override
  String repeater_cliCommandError(String error) {
    return 'Грешка: $error';
  }

  @override
  String get repeater_cliQuickGetName => 'Вземи име';

  @override
  String get repeater_cliQuickGetRadio => 'Вземи радио';

  @override
  String get repeater_cliQuickGetTx => 'Вземи TX';

  @override
  String get repeater_cliQuickNeighbors => 'Съседи';

  @override
  String get repeater_cliQuickVersion => 'Версия';

  @override
  String get repeater_cliQuickAdvertise => 'Рекламирай';

  @override
  String get repeater_cliQuickClock => 'Часовник';

  @override
  String get repeater_cliQuickClockSync => 'Синхронизация на часовника';

  @override
  String get repeater_cliQuickDiscovery => 'Открий Съседи';

  @override
  String get repeater_cliHelpAdvert => 'Изпраща рекламен пакет';

  @override
  String get repeater_cliHelpReboot =>
      'Рестартира устройството. (Забележка, може да получите \'Timeout\', което е нормално)';

  @override
  String get repeater_cliHelpClock =>
      'Показва текущото време според часовника на всяко устройство.';

  @override
  String get repeater_cliHelpPassword =>
      'Задава се нова администраторска парола за устройството.';

  @override
  String get repeater_cliHelpVersion =>
      'Показва версията на устройството и датата на компилация на фърмуера.';

  @override
  String get repeater_cliHelpClearStats =>
      'Рестартира различни статистики броячи до нула.';

  @override
  String get repeater_cliHelpSetAf => 'Задава времето на фактора.';

  @override
  String get repeater_cliHelpSetTx =>
      'Задава се мощността на предаване на LoRa в dBm (отчитане спрямо референтно ниво).';

  @override
  String get repeater_cliHelpSetRepeat =>
      'Активира или деактивира ролята на репитера за този възел.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(Сървър на стаята) Ако е \"включено\", тогава влизането с празен парола ще бъде разрешено, но не може да публикува в стаята (само четене).';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'Задава максималния брой хопове на входящ пакет за заливване (ако >= max, пакетът не се предава).';

  @override
  String get repeater_cliHelpSetIntThresh =>
      'Задава праг на интерференцията (в dB). По подразбиране е 14. Задайте на 0, за да деактивирате откриването на интерференция на каналите.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'Задава интервала за рестартиране на Автоматичния контролер за усилване. Задайте на 0, за да го деактивирате.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      'Активира или деактивира функцията \'двойни ACKs\'.';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'Задава интервала на таймера в минути за изпращане на локален (безпроблемен) рекламен пакет. Задайте на 0, за да го деактивирате.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'Задава интервала на таймера в часове за изпращане на пакет с реклама за наводнение. Задайте на 0, за да го деактивирате.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'Задава/обновява паролата на гост. (за повторители, гостите могат да изпращат заявката \"Get Stats\")';

  @override
  String get repeater_cliHelpSetName => 'Задава име на обявата.';

  @override
  String get repeater_cliHelpSetLat =>
      'Задава географска ширина на картата с реклами (в десетими градуси).';

  @override
  String get repeater_cliHelpSetLon =>
      'Задава обхвата на дължина на картата на рекламата. (десетими градуса)';

  @override
  String get repeater_cliHelpSetRadio =>
      'Задава напълно нови радио параметри и ги запазва в предпочитанията. Изисква команда \"рестарт\", за да бъдат приложени.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      'Зададени (експериментални) основи (трябва да е > 1 за ефект) за прилагане на леко забавяне на получените пакети, базирано на силата на сигнала/резултата. Задайте на 0, за да го деактивирате.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      'Задава фактор, умножен по времето на въздух за пакет в режим на наводнение и с рандомизирана система за слотове, за да забави предаването му (за да намали вероятността от сблъсъци).';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'Същото като txdelay, но за прилагане на случайна забавяне при препращането на пакети в директен режим.';

  @override
  String get repeater_cliHelpSetBridgeEnabled =>
      'Активиране/Деактивиране на мост.';

  @override
  String get repeater_cliHelpSetBridgeDelay =>
      'Задайте забавяне преди преизпращане на пакети.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      'Изберете дали мостът ще предава препратени пакети или получени пакети.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'Задайте скоростта на предаване за RS232 мостовете.';

  @override
  String get repeater_cliHelpSetBridgeSecret =>
      'Задайте тайна за мостовете на EspNow.';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      'Задава персонализиран коефициент за коригиране на отчетеното напрежение на батерията (поддържа се само на избрани дъски).';

  @override
  String get repeater_cliHelpTempRadio =>
      'Задава временни радио параметри за посочения брой минути, връщайки се към оригиналните радио параметри след това. (не се запазва в предпочитанията).';

  @override
  String get repeater_cliHelpSetPerm =>
      'Променя ACL. Премахва съответстващия запис (по префикс на pubkey), ако \"permissions\" е нула. Добавя нов запис, ако pubkey-hex е с пълна дължина и не е в ACL. Актуализира запис, съответстващ на префикса на pubkey. Битовете за разрешения варират според ролята на firmware, но долните 2 бита са: 0 (Гост), 1 (Само четене), 2 (Четене и писане), 3 (Администратор).';

  @override
  String get repeater_cliHelpGetBridgeType =>
      'Получава типа на моста: none, rs232, espnow';

  @override
  String get repeater_cliHelpLogStart =>
      'Започва записване на пакети във файловата система.';

  @override
  String get repeater_cliHelpLogStop =>
      'Спира записването на пакети във файловата система.';

  @override
  String get repeater_cliHelpLogErase =>
      'Изтрива логовете от пакета от файловата система.';

  @override
  String get repeater_cliHelpNeighbors =>
      'Показва списък с други възли на репитер, чути чрез нулев хоп реклами. Всяка линия е id-prefix-hex:timestamp:snr-times-4';

  @override
  String get repeater_cliHelpNeighborRemove =>
      'Премахва първия съвпадащ запис (по префикси на pubkey (hex)) от списъка с съседи.';

  @override
  String get repeater_cliHelpRegion =>
      '(сериен режим) Изброява всички дефинирани региони и текущите разрешения за наводнения.';

  @override
  String get repeater_cliHelpRegionLoad =>
      'Забележка: това е специално многокомандно извикване. Всяка следваща команда е име на регион (отстъпен с интервали, за да се покаже йерархията, с минимум един интервал). Завършва се чрез изпращане на празен ред/команда.';

  @override
  String get repeater_cliHelpRegionGet =>
      'Търси регион с даден префикс на име (или \"\" за глобалния обхват). Отговаря с \"-> region-name (parent-name) \'F\'\"';

  @override
  String get repeater_cliHelpRegionPut =>
      'Добавя или актуализира дефиниция на регион с дадено име.';

  @override
  String get repeater_cliHelpRegionRemove =>
      'Премахва дефиниция на регион с дадено име. (трябва да съвпада точно и да няма подрегиони)';

  @override
  String get repeater_cliHelpRegionAllowf =>
      'Задава разрешение \'Flood\' за посочената област. (\'\' за глобалния/стария обхват)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      'Премахва разрешението \"F\" за посочената област. (ЗАБЕЛЕЖКА: в момента не се препоръчва да се използва на глобално/старо ниво!!)';

  @override
  String get repeater_cliHelpRegionHome =>
      'Отговаря с текущия \'home\' регион. (Забележка: не е приложена никъде, запазена за бъдещи нужди).';

  @override
  String get repeater_cliHelpRegionHomeSet => 'Задава \'домашно\' региона.';

  @override
  String get repeater_cliHelpRegionSave =>
      'Запазва списъка/картата с региони в съхранение.';

  @override
  String get repeater_cliHelpGps =>
      'Показва статуса на GPS. Когато GPS е изключен, отговаря само с \"off\", ако е включен отговаря с \"on\", статус, fix, брой на сателити.';

  @override
  String get repeater_cliHelpGpsOnOff => 'Включва/Изключва GPS захранването.';

  @override
  String get repeater_cliHelpGpsSync =>
      'Синхронизира времето на възела с GPS часовника.';

  @override
  String get repeater_cliHelpGpsSetLoc =>
      'Задава координатите на нодата по GPS и запазва предпочитанията.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'Предоставя конфигурацията на рекламата за местоположението на възела:\n- none: не включвайте местоположението в рекламите\n- share: споделяйте gps местоположението (от SensorManager)\n- prefs: рекламирайте местоположението, съхранено в предпочитанията';

  @override
  String get repeater_cliHelpGpsAdvertSet =>
      'Задава конфигурация на обявите за местоположение.';

  @override
  String get repeater_commandsListTitle => 'Списък с команди';

  @override
  String get repeater_commandsListNote =>
      'ЗАБЕЛЕЖКА: за различните команди \"set ...\", също така съществува команда \"get ...\".';

  @override
  String get repeater_general => 'Общо';

  @override
  String get repeater_settingsCategory => 'Настройки';

  @override
  String get repeater_bridge => 'Мост';

  @override
  String get repeater_logging => 'Логване';

  @override
  String get repeater_neighborsRepeaterOnly => 'Съседи (Само за повтаряне)';

  @override
  String get repeater_regionManagementRepeaterOnly =>
      'Управление на региони (Само за повтарящ се канал)';

  @override
  String get repeater_regionNote =>
      'Регионните команди са въведени, за да управляват дефинициите и разрешенията на регионите.';

  @override
  String get repeater_gpsManagement => 'Управление на GPS';

  @override
  String get repeater_gpsNote =>
      'GPS командата е въведена, за да управлява теми, свързани с местоположението.';

  @override
  String get repeater_getCategory => 'Получете стойности';

  @override
  String get repeater_powerMgmt => 'Управление на енергията';

  @override
  String get repeater_sensors => 'Датчици';

  @override
  String get repeater_cliHelpPowerOff =>
      'Изключва устройството. (не се очаква отговор)';

  @override
  String get repeater_cliHelpClkReboot =>
      'Възстановява часовника до известна историческа дата и рестартира устройството.';

  @override
  String get repeater_cliHelpAdvertZeroHop =>
      'Изпраща реклама, която достига само до съседни устройства (само до съседни мрежи).';

  @override
  String get repeater_cliHelpStartOta =>
      'Стартира актуализация на фърмуера чрез въздушното, на всички поддържани платки.';

  @override
  String get repeater_cliHelpTime =>
      'Задава времето на устройството към зададените секунди от началото на Unix ерата. Времето не може да се върне назад.';

  @override
  String get repeater_cliHelpBoard =>
      'Показва производителя на платката / идентификатора на хардуера.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      'Изпраща заявка за откриване на съседни възли. (Само за устройства тип репитер)';

  @override
  String get repeater_cliHelpPowersaving =>
      'Показва дали режимът за пестене на енергия е активиран или деактивиран.';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      'Активира или деактивира режима за пестене на енергия (ако е поддържан).';

  @override
  String get repeater_cliHelpErase =>
      '(Само за серийни устройства) Форматира файловата система на устройството. Изтрива всички настройки и контакти.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      'Задава максимално допустимия процент на използване на времето за предаване (от 1 до 100 процента). Вътрешно коригира фактора за времето на предаване.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '(Само за серийни номера) Заменя личната част от ключа за идентификация на устройството. Необходимо е да се рестартира устройството, за да се приложи. Генерира нов публичен ключ.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(Само за SX126x) Превключва усиления на приемния сигнал (RX gain) за подобрена чувствителност при по-високо потребление на ток.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      'Задава низовете с информация за контакт на собственика, които са включени в рекламите. Използвайте \'|\' за нови редове.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'Задава режима за хеширане на пътищата. 0 = за стари системи, 1 = за стандартни системи, 2 = за строги системи. Влияе върху начина, по който се съпоставят маршрутите.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'Задава чувствителността за откриване на цикли в маршрутизацията: изключена, минимална, умерена или строга.';

  @override
  String get repeater_cliHelpSetFreq =>
      '(Само за серийно управление) Бързо задава само честотата. Необходимо е рестартиране. Препоръчително е да се използват настройките за \"радио\", за да се зададат всички параметри.';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(Само за моста ESPNow) Определя WiFi канала (от 1 до 14), използван от моста.';

  @override
  String get repeater_cliHelpGetName => 'Показва зададеното име на възела.';

  @override
  String get repeater_cliHelpGetRole =>
      'Показва ролята на фърмуера (например повторител, сървър на стая и т.н.).';

  @override
  String get repeater_cliHelpGetPublicKey =>
      'Показва публичния ключ на устройството.';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '(Само за серийния номер) Показва личната ключа на устройството. Трябва да се третира като тайна.';

  @override
  String get repeater_cliHelpGetRepeat =>
      'Показва дали функцията за пренасочване на пакети (ролята на повторителя) е активирана или деактивирана.';

  @override
  String get repeater_cliHelpGetTx => 'Показва текущата мощност на TX в dBm.';

  @override
  String get repeater_cliHelpGetFreq => 'Показва зададената честота в MHz.';

  @override
  String get repeater_cliHelpGetRadio =>
      'Показва пълните радио параметри: честота, ширина на честотния обхват, фактор на разпространение, скорост на кодиране.';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(Само за SX126x) Показва състоянието на усиления сигнал на RX.';

  @override
  String get repeater_cliHelpGetAf =>
      'Показва текущия коефициент на въздействие върху въздуха.';

  @override
  String get repeater_cliHelpGetDutyCycle =>
      'Показва текущия допустим цикъл на работа като процент.';

  @override
  String get repeater_cliHelpGetIntThresh =>
      'Показва прага на интерференцията на канала в децибели (dB).';

  @override
  String get repeater_cliHelpGetAgcResetInterval =>
      'Показва интервала за рестартиране на AGC в секунди.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      'Показва дали режимът \"двоен ACK\" е активиран (1) или деактивиран (0).';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'Показва дали е разрешено само четене за гостите.';

  @override
  String get repeater_cliHelpGetAdvertInterval =>
      'Показва времето на рекламата в минути.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'Показва интервала на рекламата за навод в часове.';

  @override
  String get repeater_cliHelpGetGuestPassword =>
      'Показва зададения парол за гост.';

  @override
  String get repeater_cliHelpGetLat => 'Показва зададената географска ширина.';

  @override
  String get repeater_cliHelpGetLon => 'Показва зададената дължина.';

  @override
  String get repeater_cliHelpGetRxDelay =>
      'Показва основната стойност на забавянето на сигнала.';

  @override
  String get repeater_cliHelpGetTxDelay =>
      'Показва коефициента за забавяне при режим на наводняване.';

  @override
  String get repeater_cliHelpGetDirectTxDelay =>
      'Показва коефициента за забавяне при директен режим.';

  @override
  String get repeater_cliHelpGetFloodMax =>
      'Показва максималния брой на повторни наводнения.';

  @override
  String get repeater_cliHelpGetOwnerInfo =>
      'Показва информацията за контакт на собственика.';

  @override
  String get repeater_cliHelpGetPathHashMode =>
      'Показва режима на хеширане на пътя (0/1/2).';

  @override
  String get repeater_cliHelpGetLoopDetect =>
      'Показва чувствителността към откриване на цикли.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(Само за серийни устройства) Изброява настройките за контрол на достъпа в повторителя.';

  @override
  String get repeater_cliHelpGetBridgeEnabled =>
      'Показва дали мостът е активиран.';

  @override
  String get repeater_cliHelpGetBridgeDelay =>
      'Показва забавянето на моста в милисекунди.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'Показва дали мостът изпраща или получава пакети RX или TX.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(Само за мост RS232) Показва скоростта на предаване на данните на моста.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(Само за моста ESPNow) Показва канала на WiFi на моста.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(Само за моста ESPNow) Показва споделения секрет на моста.';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '(Само за NRF52) Показва версията на зареждащия софтуер.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'Показва множителя на аналоговия-цифров преобразувател (мащабиране на напрежението от батерията).';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      'Описва дали борда на директорите има поддръжка за управление на захранването.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      'Показва текущия източник на захранване: външен или батерия.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      'Показва най-скорошните причини за рестартиране и изключване.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv =>
      'Показва напрежението на батерията при стартиране, измерено в миливолта (mV).';

  @override
  String get repeater_cliHelpSensorGet =>
      'Чете персонализирана настройка на сензор чрез клавиш.';

  @override
  String get repeater_cliHelpSensorSet =>
      'Създава персонализирана настройка за сензор.';

  @override
  String get repeater_cliHelpSensorList =>
      'Показва всички настройки на потребителските сензори, разделени на страници, започвайки от опционален индекс.';

  @override
  String get repeater_cliHelpRegionDefault =>
      'Показва текущия обхват на региона по подразбиране.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'Задава обхвата на региона по подразбиране. Използвайте \"<null>\", за да го изчистите.';

  @override
  String get repeater_cliHelpRegionListAllowed =>
      'Списва регионите, които позволяват преминаване на превозни средства при наводнение.';

  @override
  String get repeater_cliHelpRegionListDenied =>
      'Списва региони, които забраняват движението по пътищата при наводнения.';

  @override
  String get repeater_cliHelpStatsPackets =>
      '(Само за серия) Показва статистически данни на ниво пакет.';

  @override
  String get repeater_cliHelpStatsRadio =>
      '(Само за конкретен сериал) Показва радиостатистика.';

  @override
  String get repeater_cliHelpStatsCore =>
      '(Само за серийния номер) Показва основните статистически данни за фърмуера.';

  @override
  String get telemetry_receivedData => 'Получени телеметрични данни';

  @override
  String get telemetry_requestTimeout => 'Заявката за телеметрия е прекъсната.';

  @override
  String telemetry_errorLoading(String error) {
    return 'Грешка при зареждане на телеметрията: $error';
  }

  @override
  String get telemetry_noData => 'Няма налични данни за телеметрията.';

  @override
  String telemetry_channelTitle(int channel) {
    return 'Канал $channel';
  }

  @override
  String get telemetry_batteryLabel => 'Батерия';

  @override
  String get telemetry_voltageLabel => 'Напрежение';

  @override
  String get telemetry_mcuTemperatureLabel => 'Температура на MCU';

  @override
  String get telemetry_temperatureLabel => 'Температура';

  @override
  String get telemetry_currentLabel => 'Текущо';

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
  String get telemetry_digitalInputLabel => 'Цифров вход';

  @override
  String get telemetry_digitalOutputLabel => 'Цифров изход';

  @override
  String get telemetry_analogInputLabel => 'Аналогов вход';

  @override
  String get telemetry_analogOutputLabel => 'Аналогов изход';

  @override
  String get telemetry_genericLabel => 'Общ сензор';

  @override
  String get telemetry_luminosityLabel => 'Осветеност';

  @override
  String get telemetry_presenceLabel => 'Присъствие';

  @override
  String get telemetry_humidityLabel => 'Влажност';

  @override
  String get telemetry_accelerometerLabel => 'Акселерометър';

  @override
  String get telemetry_pressureLabel => 'Налягане';

  @override
  String get telemetry_altitudeLabel => 'Надморска височина';

  @override
  String get telemetry_frequencyLabel => 'Честота';

  @override
  String get telemetry_percentageLabel => 'Процент';

  @override
  String get telemetry_concentrationLabel => 'Концентрация';

  @override
  String get telemetry_powerLabel => 'Мощност';

  @override
  String get telemetry_distanceLabel => 'Разстояние';

  @override
  String get telemetry_energyLabel => 'Енергия';

  @override
  String get telemetry_directionLabel => 'Посока';

  @override
  String get telemetry_timeLabel => 'Време';

  @override
  String get telemetry_gyrometerLabel => 'Жироскоп';

  @override
  String get telemetry_colourLabel => 'Цвят';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'Превключвател';

  @override
  String get telemetry_polylineLabel => 'Полилиния';

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
  String get telemetry_autoFetchQuantity => 'Брой заявки';

  @override
  String get telemetry_error => 'Неуспешно получаване на данни';

  @override
  String get neighbors_receivedData => 'Получени данни за съседи';

  @override
  String get neighbors_requestTimedOut => 'Съседите поискат изтичане на време.';

  @override
  String neighbors_errorLoading(String error) {
    return 'Грешка при зареждане на съседи: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => 'Повторители Съседи';

  @override
  String get neighbors_noData => 'Няма налични данни за съседи.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return 'Неизвестна $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return 'Слушано преди $time.';
  }

  @override
  String get channelPath_title => 'Пътеки пъзел';

  @override
  String get channelPath_viewMap => 'Преглед на картата';

  @override
  String get channelPath_otherObservedPaths => 'Други Наблюдавани Пътища';

  @override
  String get channelPath_repeaterHops => 'Повтарящи се скокове';

  @override
  String get channelPath_noHopDetails =>
      'Детайлите за пакета не са предоставени.';

  @override
  String get channelPath_sourceLabel => 'Източник';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'Това съобщение пристигна чрез MQTT. Вашето радио не го е чуло, затова няма радиомаршрут от вашето радио.';

  @override
  String get channelPath_messageDetails => 'Подробности на съобщението';

  @override
  String get channelPath_senderLabel => 'Изпращач';

  @override
  String get channelPath_timeLabel => 'Време';

  @override
  String get channelPath_repeatsLabel => 'Повтаря';

  @override
  String channelPath_pathLabel(int index) {
    return 'Път $index';
  }

  @override
  String get channelPath_observedLabel => 'Наблюдавано';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return 'Наблюдаван път $index • $hops';
  }

  @override
  String get channelPath_noLocationData => 'Няма данни за местоположение.';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => 'Неизвестно';

  @override
  String get channelPath_floodPath => 'Поливане';

  @override
  String get channelPath_directPath => 'Директно';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 от $total скокове';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed от $total скокове';
  }

  @override
  String get channelPath_mapTitle => 'Карта на пътя';

  @override
  String get channelPath_noRepeaterLocations =>
      'Няма налични местоположения на повторителите за този път.';

  @override
  String channelPath_primaryPath(int index) {
    return 'Път $index (Основен)';
  }

  @override
  String get channelPath_pathLabelTitle => 'Пътеки';

  @override
  String get channelPath_observedPathHeader => 'Наблюдаван път';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable =>
      'Няма налични детайли за този пакет.';

  @override
  String get channelPath_unknownRepeater => 'Неизвестен повторител';

  @override
  String get community_title => 'Общност';

  @override
  String get community_create => 'Създай общност';

  @override
  String get community_createDesc =>
      'Създайте нова общност и я споделете чрез QR код.';

  @override
  String get community_join => 'Присъедини се';

  @override
  String get community_joinTitle => 'Присъедини се към общността';

  @override
  String community_joinConfirmation(String name) {
    return 'Искате ли да се присъедините към общността \"$name\"?';
  }

  @override
  String get community_scanQr => 'Сканирайте QR кода на общността';

  @override
  String get community_scanInstructions =>
      'Насочете камерата към QR код на общността';

  @override
  String get community_showQr => 'Покажи QR код';

  @override
  String get community_publicChannel => 'Обществено общност';

  @override
  String get community_hashtagChannel => 'Хаштаг на общността';

  @override
  String get community_name => 'Име на общността';

  @override
  String get community_enterName => 'Въведете име на общността';

  @override
  String community_created(String name) {
    return 'Общността \"$name\" е създадена';
  }

  @override
  String community_joined(String name) {
    return 'Присъединено общност \"$name\"';
  }

  @override
  String get community_qrTitle => 'Споделяне в общността';

  @override
  String community_qrInstructions(String name) {
    return 'Сканирайте този QR код, за да се присъедините към $name.';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'Хаштаг каналите на общността са достъпни само за членове на общността';

  @override
  String get community_invalidQrCode => 'Невалиден QR код на общността';

  @override
  String get community_alreadyMember => 'Вече съм член';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'Вие вече сте член на \"$name\".';
  }

  @override
  String get community_addPublicChannel => 'Добави публичен общностен канал';

  @override
  String get community_addPublicChannelHint =>
      'Автоматично добавете публичния канал за тази общност.';

  @override
  String get community_noCommunities => 'Няма присъединени общности още.';

  @override
  String get community_scanOrCreate =>
      'Сканирайте QR код или създайте общност, за да започнете.';

  @override
  String get community_manageCommunities => 'Управление на общности';

  @override
  String get community_delete => 'Напусни общността';

  @override
  String community_deleteConfirm(String name) {
    return 'Напускате \"$name\"?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return 'Това ще изтрие също $count канал(а) и техните съобщения.';
  }

  @override
  String community_deleted(String name) {
    return 'Остави общността \"$name\"';
  }

  @override
  String get community_regenerateSecret => 'Регенерейрай секрет';

  @override
  String community_regenerateSecretConfirm(String name) {
    return 'Регенерация на секретния ключ за \"$name\"? Всички членове ще трябва да сканират новия QR код, за да продължат комуникацията.';
  }

  @override
  String get community_regenerate => 'Регенерация';

  @override
  String community_secretRegenerated(String name) {
    return 'Секретно презареждане за \"$name\"';
  }

  @override
  String get community_updateSecret => 'Актуализирай тайна';

  @override
  String community_secretUpdated(String name) {
    return 'Секретно обновено за \"$name\"';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return 'Сканьорвайте новия QR код, за да актуализирате секрета за \"$name\"';
  }

  @override
  String get community_addHashtagChannel => 'Добави общностен хаштаг';

  @override
  String get community_addHashtagChannelDesc =>
      'Добавете хаштаг канал за тази общност';

  @override
  String get community_selectCommunity => 'Изберете общност';

  @override
  String get community_regularHashtag => 'Обикновен хаштаг';

  @override
  String get community_regularHashtagDesc =>
      'Общ хаштаг (всеки може да се присъедини)';

  @override
  String get community_communityHashtag => 'Общностен хаштаг';

  @override
  String get community_communityHashtagDesc => 'Само за членове на общността';

  @override
  String community_forCommunity(String name) {
    return 'За $name';
  }

  @override
  String get listFilter_tooltip => 'Филтрирайте и сортирайте';

  @override
  String get listFilter_sortBy => 'Сортирай по';

  @override
  String get listFilter_latestMessages => 'Последни съобщения';

  @override
  String get listFilter_heardRecently => 'Слушано е наскоро';

  @override
  String get listFilter_az => 'А-Я';

  @override
  String get listFilter_filters => 'Филтри';

  @override
  String get listFilter_all => 'Всички';

  @override
  String get listFilter_favorites => 'Любими';

  @override
  String get listFilter_addToFavorites => 'Добави към любими';

  @override
  String get listFilter_removeFromFavorites => 'Премахване от списъка с любими';

  @override
  String get listFilter_users => 'Потребители';

  @override
  String get listFilter_repeaters => 'Повторители';

  @override
  String get listFilter_roomServers => 'Сървъри на стая';

  @override
  String get listFilter_unreadOnly => 'Само непрочетените';

  @override
  String get listFilter_newGroup => 'Нова група';

  @override
  String get pathTrace_you => 'Вие';

  @override
  String get pathTrace_failed => 'Пътят за проследяване не успя.';

  @override
  String get pathTrace_notAvailable => 'Пътека за проследяване не е достъпна.';

  @override
  String get pathTrace_refreshTooltip => 'Обнови проследяването на пътя.';

  @override
  String get pathTrace_someHopsNoLocation =>
      'Един или повече от хмелите липсва местоположение!';

  @override
  String get pathTrace_clearTooltip => 'Изчисти пътя';

  @override
  String get losSelectStartEnd => 'Изберете начални и крайни възли за LOS.';

  @override
  String losRunFailed(String error) {
    return 'Проверката на пряката видимост е неуспешна: $error';
  }

  @override
  String get losClearAllPoints => 'Изчистете всички точки';

  @override
  String get losRunToViewElevationProfile =>
      'Стартирайте LOS, за да видите профила на надморската височина';

  @override
  String get losMenuTitle => 'LOS меню';

  @override
  String get losMenuSubtitle =>
      'Докоснете възли или натиснете продължително карта за персонализирани точки';

  @override
  String get losShowDisplayNodes => 'Показване на възли на дисплея';

  @override
  String get losCustomPoints => 'Персонализирани точки';

  @override
  String losCustomPointLabel(int index) {
    return 'Персонализирано $index';
  }

  @override
  String get losPointA => 'Точка А';

  @override
  String get losPointB => 'Точка Б';

  @override
  String losAntennaA(String value, String unit) {
    return 'Антена A: $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return 'Антена B: $value $unit';
  }

  @override
  String get losRun => 'Стартирайте LOS';

  @override
  String get losNoElevationData => 'Няма данни за надморска височина';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, чист LOS, минимално разстояние $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, блокиран от $obstruction $heightUnit';
  }

  @override
  String get losStatusChecking => 'LOS: проверка...';

  @override
  String get losStatusNoData => 'LOS: няма данни';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS: $clear/$total ясно, $blocked блокирано, $unknown неизвестно';
  }

  @override
  String get losErrorElevationUnavailable =>
      'Няма налични данни за надморска височина за една или повече проби.';

  @override
  String get losErrorInvalidInput =>
      'Невалидни данни за точки/надморска височина за изчисляване на LOS.';

  @override
  String get losRenameCustomPoint => 'Преименувайте персонализирана точка';

  @override
  String get losPointName => 'Име на точката';

  @override
  String get losShowPanelTooltip => 'Показване на LOS панел';

  @override
  String get losHidePanelTooltip => 'Скриване на LOS панела';

  @override
  String get losElevationAttribution =>
      'Данни за надморска височина: Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'Радиохоризонт';

  @override
  String get losLegendLosBeam => 'Линия на видимост';

  @override
  String get losLegendTerrain => 'Терен';

  @override
  String get losBlockedSpotsTitle => 'Ограничени места';

  @override
  String get losBlockedSpotsHint =>
      'Кликнете върху блокираната точка, за да я отбележите на картата.';

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
  String get losSelectedObstructionTitle => 'Избрано препятствие';

  @override
  String losSelectedObstructionDetails(
    String obstruction,
    String heightUnit,
    String distanceFromA,
    String distanceUnit,
    String distanceFromB,
  ) {
    return 'Блокирано от $obstruction $heightUnit, $distanceFromA от A и $distanceFromB от B ($distanceUnit).';
  }

  @override
  String get losFrequencyLabel => 'Честота';

  @override
  String get losFrequencyInfoTooltip => 'Преглед на детайли за изчислението';

  @override
  String get losFrequencyDialogTitle => 'Изчисляване на радиохоризонта';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'Започвайки от k=$baselineK при $baselineFreq MHz, изчислението коригира k-фактора за текущата $frequencyMHz MHz лента, която определя границата на извития радиохоризонт.';
  }

  @override
  String get contacts_pathTrace => 'Пътен проследяване';

  @override
  String get contacts_ping => 'Пинг';

  @override
  String get contacts_repeaterPathTrace => 'Трасировка до повторител';

  @override
  String get contacts_repeaterPing => 'Пингване на повторителя';

  @override
  String get contacts_roomPathTrace => 'Трасиране на път до съ';

  @override
  String get contacts_roomPing => 'Ping на сървъра на стаята';

  @override
  String get contacts_chatTraceRoute => 'Трасиране на път';

  @override
  String contacts_pathTraceTo(String name) {
    return 'Проследи маршрут към $name';
  }

  @override
  String get contacts_clipboardEmpty => 'Клипборда е празна.';

  @override
  String get contacts_invalidAdvertFormat => 'Невалидни данни за контакт';

  @override
  String get contacts_contactImported => 'Контактът е импортиран.';

  @override
  String get contacts_contactImportFailed =>
      'Контактът не е успешно импортиран.';

  @override
  String get contacts_zeroHopAdvert => 'Реклама без скок';

  @override
  String get contacts_floodAdvert => 'Реклама за наводняване';

  @override
  String get contacts_copyAdvertToClipboard => 'Копирай обявата в клипборда';

  @override
  String get contacts_addContactFromClipboard => 'Добави контакт от клипборда';

  @override
  String get contacts_ShareContact => 'Копирай контакт в клипборда';

  @override
  String get contacts_ShareContactZeroHop => 'Сподели контакт чрез обява';

  @override
  String get contacts_zeroHopContactAdvertSent => 'Изпратен контакт по обява.';

  @override
  String get contacts_zeroHopContactAdvertFailed =>
      'Неуспешно изпращане на контакт.';

  @override
  String get contacts_contactAdvertCopied =>
      'Рекламата е копирана в клипборда.';

  @override
  String get contacts_contactAdvertCopyFailed =>
      'Копирането на обявата в клипборда не успя.';

  @override
  String get notification_activityTitle => 'Активност на MeshCore';

  @override
  String notification_messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'съобщения',
      one: 'съобщение',
    );
    return '$count $_temp0';
  }

  @override
  String notification_channelMessagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'съобщения в канали',
      one: 'съобщение в канал',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'нови възли',
      one: 'нов възел',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return 'Открит нов $contactType';
  }

  @override
  String get notification_receivedNewMessage => 'Получено ново съобщение';

  @override
  String get settings_gpxExportRepeaters =>
      'Експортиране на повтарящи се устройства / сървър на стаята до GPX';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'Изпраща повторители / roomserver с местоположение в GPX файл.';

  @override
  String get settings_gpxExportContacts => 'Експортирай спътници към GPX';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'Експортира спътници с местоположение в GPX файл.';

  @override
  String get settings_gpxExportAll => 'Експортирай всички контакти в GPX';

  @override
  String get settings_gpxExportAllSubtitle =>
      'Експортира всички контакти с местоположение в файл GPX.';

  @override
  String get settings_gpxExportSuccess => 'Успешно изlexport на файл GPX.';

  @override
  String get settings_gpxExportNoContacts => 'Няма контакти за изlexport.';

  @override
  String get settings_gpxExportNotAvailable =>
      'Не е поддържан на вашето устройство/ОС';

  @override
  String get settings_gpxExportError => 'Възникна грешка при изнасяне.';

  @override
  String get settings_gpxExportRepeatersRoom =>
      'Местоположения на повторител и сървър на стаята';

  @override
  String get settings_gpxExportChat => 'Местоположения на спътници';

  @override
  String get settings_gpxExportAllContacts =>
      'Местоположения на всички контакти';

  @override
  String get settings_gpxExportShareText =>
      'Картинни данни изнесени от NOTORYX Core';

  @override
  String get settings_gpxExportShareSubject =>
      'NOTORYX Core износ на данни за карта в формат GPX';

  @override
  String get snrIndicator_nearByRepeaters => 'Близки повторители';

  @override
  String get snrIndicator_lastSeen => 'Последно видян';

  @override
  String get contactsSettings_title => 'Настройки на контактите';

  @override
  String get contactsSettings_autoAddTitle => 'Автоматично откриване';

  @override
  String get contactsSettings_otherTitle =>
      'Други настройки свързани с контакти';

  @override
  String get contactsSettings_autoAddUsersTitle =>
      'Автоматично добавяне на потребители';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      'Позволи на спътника да добавя автоматично откритите потребители.';

  @override
  String get contactsSettings_autoAddRepeatersTitle =>
      'Автоматично добавяне на повтарящи се елементи';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      'Позволи на спътника да добавя автоматично откритите повтарящи се устройства.';

  @override
  String get contactsSettings_autoAddRoomServersTitle =>
      'Автоматично добавяне на сървъри на стаите';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      'Позволи на спътника да добавя автоматично откритите сървъри на стаите.';

  @override
  String get contactsSettings_autoAddSensorsTitle =>
      'Автоматично добавяне на датчици';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      'Позволи на спътника да добавя автоматично откритите датчици.';

  @override
  String get contactsSettings_overwriteOldestTitle => 'Премахни най-старото';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      'Когато списъкът с контакти е пълен, най-старият неключов контакт ще бъде заменен.';

  @override
  String get discoveredContacts_Title => 'Открити контакти';

  @override
  String get discoveredContacts_noMatching => 'Няма съвпадащи контакти';

  @override
  String get discoveredContacts_searchHint => 'Търсене на открити контакти';

  @override
  String get discoveredContacts_contactAdded => 'Контакт добавен';

  @override
  String get discoveredContacts_addContact => 'Добави контакт';

  @override
  String get discoveredContacts_copyContact => 'Копирай контакт в клипборда';

  @override
  String get discoveredContacts_deleteContact => 'Изтрий контакт';

  @override
  String get discoveredContacts_deleteContactAll =>
      'Изтриване на Всички Открити Контакти';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      'Сигурни ли сте, че искате да изтриете всички открити контакти?';

  @override
  String get chat_sendCooldown =>
      'Моля, изчакайте малко, преди да изпратите отново.';

  @override
  String get appSettings_jumpToOldestUnread =>
      'Преминете към най-старата непочетена статия';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      'Когато отворите чат с непрочетени съобщения, плъзнете надолу, за да видите първото непрочетено съобщение, вместо най-новото.';

  @override
  String get appSettings_languageHu => 'Унгарски';

  @override
  String get appSettings_languageJa => 'Японски';

  @override
  String get appSettings_languageKo => 'Корейски';

  @override
  String get radioStats_tooltip => 'Статистика за радио и мрежа';

  @override
  String get radioStats_screenTitle =>
      'Статистически данни за радиопредаванията';

  @override
  String get radioStats_notConnected =>
      'Свържете се с устройство, за да видите статистически данни за радиопредаване.';

  @override
  String get radioStats_firmwareTooOld =>
      'Статистиката на радиостанцията изисква съвместимо софтуерно решение версия 8 или по-нова.';

  @override
  String get radioStats_waiting => 'Изчакване на данни…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'Ниво на шума: $noiseDbm dBm';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return 'Последен RSSI: $rssiDbm dBm';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return 'Последна стойност на SNR: $snr dB';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'Време на въздух (общо): $seconds секунди';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'Общо време на използване на RX (в секунди): $seconds с';
  }

  @override
  String get radioStats_chartCaption =>
      'Ниво на шума (dBm) за последните измервания.';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'Ниво на шума: $noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting => 'Извличане на данни за радиото…';

  @override
  String get radioStats_settingsTile => 'Статистически данни за радиостанции';

  @override
  String get radioStats_settingsSubtitle =>
      'Ниво на шума, RSSI, SNR и време на пренос';

  @override
  String get translation_title => 'Превод';

  @override
  String get imageMessages_enableTitle => 'Абilitiraм изображените сообщения';

  @override
  String get imageMessages_enableSubtitle =>
      'Изправате изображения чрез сетката. Треба е одноразовна загрузка модел на изображение.';

  @override
  String get imageMessages_modelSectionTitle => 'Изображени модель';

  @override
  String get imageMessages_downloadModel => 'Скачане';

  @override
  String get imageMessages_cancelDownload => 'Отмена';

  @override
  String get imageMessages_removeModel => 'Удалете модель';

  @override
  String get imageMessages_modelReady => 'Готов';

  @override
  String get imageMessages_modelNotPublished =>
      'Еще не опубликовано — тази версия не може да скане.';

  @override
  String get imageMessages_downloadFailed =>
      'Модел за изображение не може да бъде скачан.';

  @override
  String get imageMessages_autoProcessTitle =>
      'Автоматически обрабатвате изображения';

  @override
  String get imageMessages_autoProcessSubtitle =>
      'Катализиране на всята изображение сразу по пришествие. Използване на около 2 ГБ на втора пъти; откажете от реконструкцията чаке при натискане.';

  @override
  String get translation_enableTitle => 'Активирайте превода';

  @override
  String get translation_enableSubtitle =>
      'Превеждайте входящите съобщения и позволявайте предварително превеждане преди изпращане.';

  @override
  String get translation_composerTitle => 'Преведете преди да изпратите';

  @override
  String get translation_composerSubtitle =>
      'Контролира началния статус на иконата за превод, създадена от композитора.';

  @override
  String get translation_autoIncomingTitle => 'Автоматичен превод на съобщения';

  @override
  String get translation_autoIncomingSubtitle =>
      'Превежда автоматично съобщенията за известия, както и за чатове или канали.';

  @override
  String get translation_translateMessage => 'Преведи съобщението';

  @override
  String get translation_targetLanguage => 'Целеви език';

  @override
  String get translation_useAppLanguage => 'Използвайте езика на приложението';

  @override
  String get translation_downloadedModelLabel => 'Изтегнат модел';

  @override
  String get translation_presetModelLabel =>
      'Предварително конфигуриран модел от Hugging Face';

  @override
  String get translation_manualUrlLabel => 'URL на ръководството';

  @override
  String get translation_downloadModel => 'Изтеглете модела';

  @override
  String get translation_downloading => 'Изтегляне...';

  @override
  String get translation_working => 'Работа...';

  @override
  String get translation_stop => 'Спрете';

  @override
  String get translation_mergingChunks =>
      'Съединяване на изтеглените части в един файл...';

  @override
  String get translation_downloadedModels => 'Изтеглени модели';

  @override
  String get translation_deleteModel => 'Изтриване на модела';

  @override
  String get translation_modelDownloaded => 'Моделът за превод е изтеглен.';

  @override
  String get translation_downloadStopped => 'Изтеглянето беше прекъснато.';

  @override
  String translation_downloadFailed(String error) {
    return 'Не успях да изтегля: $error';
  }

  @override
  String get translation_enterUrlFirst => 'Въведете първо URL адрес на модела.';

  @override
  String get scanner_linuxPairingShowPin => 'Покажи PIN';

  @override
  String get scanner_linuxPairingHidePin => 'Скриване на PIN кода';

  @override
  String get scanner_linuxPairingPinTitle => 'PIN за съвпадение чрез Bluetooth';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return 'Въведете PIN кода за $deviceName (оставете празно, ако няма такъв).';
  }

  @override
  String get translation_messageTranslation => 'Превод на съобщението';

  @override
  String get translation_translateBeforeSending =>
      'Преведете преди да изпратите';

  @override
  String get translation_composerEnabledHint =>
      'Съобщенията ще бъдат преведени, преди да бъдат изпратени.';

  @override
  String get translation_composerDisabledHint =>
      'Изпращайте съобщения на оригиналния въведен език.';

  @override
  String translation_translateTo(String language) {
    return 'Превеждане на $language';
  }

  @override
  String get translation_translationOptions => 'Опции за превод';

  @override
  String get translation_systemLanguage => 'Език на системата';

  @override
  String get background_serviceTitle => 'MeshCore работи';

  @override
  String get background_serviceText => 'Поддържа BLE връзката активна';

  @override
  String appSettings_translationModelDeleted(String name) {
    return 'Изтрит $name';
  }

  @override
  String appSettings_translationModelDeleteFailed(String error) {
    return 'Неуспешно изтриване: $error';
  }

  @override
  String channels_channelUpdateFailed(String error) {
    return 'Неуспешно обновяване на канала: $error';
  }

  @override
  String get contact_typeChat => 'Чат';

  @override
  String get contact_typeRepeater => 'Повторител';

  @override
  String get contact_typeRoom => 'Стая';

  @override
  String get contact_typeSensor => 'Сензор';

  @override
  String get contact_typeUnknown => 'Неизвестен';

  @override
  String get map_zoomIn => 'Увеличи';

  @override
  String get map_zoomOut => 'Намали мащаба';

  @override
  String get map_centerMap => 'Центрирай картата';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'Web Bluetooth изисква браузър, базиран на Chromium.';

  @override
  String channels_communityShortId(String id) {
    return 'Идентификационен номер: $id...';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'GPS потвърдено';

  @override
  String get pathTrace_legendInferred => 'Извлечена позиция';

  @override
  String get pathMap_viewSingle => 'Самостоятелен';

  @override
  String get pathMap_viewCombined => 'Комбиниран';

  @override
  String get pathMap_play => 'Пусни';

  @override
  String get pathMap_pause => 'Пауза';

  @override
  String get pathMap_replay => 'Повторение';

  @override
  String get pathMap_stepBack => 'Предишна стъпка';

  @override
  String get pathMap_stepForward => 'Следваща стъпка';

  @override
  String get pathMap_animationOn => 'Показвай анимацията на пакета';

  @override
  String get pathMap_animationOff => 'Скрий анимацията на пакета';

  @override
  String pathMap_hopOf(int current, int total) {
    return 'Стъпка $current от $total';
  }

  @override
  String pathMap_observedPaths(int count) {
    return 'Наблюдавани пътища: $count';
  }

  @override
  String get pathMap_primary => 'Основен';

  @override
  String pathMap_alternate(int index) {
    return 'Алтернативен $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count скока',
      one: '1 скок',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => 'Споделена секция';

  @override
  String get pathMap_legendEstimated => 'Очаквана стойност на сегмента';

  @override
  String pathMap_sharedNodeCount(int count) {
    return 'Използвани от $count пътища';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count скока нямат определено местоположение — показаният път е непълен',
      one: '1 скок няма определено местоположение — показаният път е непълен',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'Покажи всички пътища';

  @override
  String get pathMap_hidePath => 'Скрий пътя';

  @override
  String get pathMap_showPath => 'Покажи пътя';

  @override
  String get pathMap_collapsePanel => 'Сгъни панела';

  @override
  String get pathMap_expandPanel => 'Разгъни панела';

  @override
  String get pathMap_noLocation => 'Без посочено местоположение';

  @override
  String get pathMap_followPacket => 'Проследи пакета';

  @override
  String get pathMap_unfollowPacket => 'Спри проследяването на пакета';

  @override
  String get imageSend_title => 'Изпрати изображение';

  @override
  String get imageSend_cropNote =>
      'Масштабиран до 512 × 512 · соотношение сторон не съхранясе';

  @override
  String get imageSend_originalSize => 'Късно на използване на език:';

  @override
  String get imageSend_onAirSize => 'В ефир';

  @override
  String get imageSend_quality => 'Качество';

  @override
  String get imageSend_qualityStandard => 'Стандарт';

  @override
  String get imageSend_qualityHigh => 'Высок';

  @override
  String get imageSend_packetsLabel => 'Пакети';

  @override
  String get imageSend_airtimeLabel => 'Времето на изкъсване';

  @override
  String get imageSend_sizeLabel => 'Баланса';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'пакета',
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
  String get imageSend_radioUnknownTitle => 'Настройки на радио неизвестни';

  @override
  String get imageSend_radioUnknownBody =>
      'Усредете се с устройство, за да се отработа часът на изстъпане.';

  @override
  String get imageSend_longSendTitle => 'Долга пресилка';

  @override
  String imageSend_longSendBody(String duration) {
    return 'Тази буде поддержива открит отряд на около $duration.';
  }

  @override
  String get imageSend_floodNote =>
      'Руйжинг на превъште: всички ретранслятори в диапазонта превратят всички пакети, тъйа каналят оставря дълше, от този час.';

  @override
  String get imageSend_parityTitle => 'Возобновителен пакет';

  @override
  String get imageSend_paritySubtitle =>
      'Едно дополително пакет. Групни извещания не принимаются, след това разбирателят едно пакетто, какщо е пропущен един пакет.';

  @override
  String get imageSend_send => 'Отправляй';

  @override
  String get imageSend_cancel => 'Отмена';

  @override
  String get imageSend_encodeFailed =>
      'Тази изображение не може да бъде кодирано.';

  @override
  String get imageSend_codecDownloading =>
      'Модел на изображение еще разгрузира.';

  @override
  String get imageSend_codecUnavailable =>
      'Изглед отправа не е доступен на този устройство.';

  @override
  String get imageSend_codecDisabled =>
      'Изображенията на извещенията е отключена в настройките.';

  @override
  String get imageSend_deviceUnsupported =>
      'Та радиота не може да пресылава изображени пакети. Подключите устройство, който работи с компанионски прошивка 13 или новия.';

  @override
  String get imageSend_directMessagesUnsupported =>
      'Изображенията се превозводя се как групова информация, следато да се отправят единствено на канал — не в лична вестка.';

  @override
  String get imageSend_tooLarge =>
      'Таата изображение е кодирано в по-числа пакети, отгоре както формат на сетта разрешава.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'пакета',
      one: 'пакет',
    );
    return 'Изображението е изпратено като $count $_temp0.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return 'Изображение не може да бъде отправено: $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return 'Отправка наизображение — пакет $sent от $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'Узъдето $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return '$received от $total пакета';
  }

  @override
  String get receivedImage_queued => 'Ожидането за декодиране';

  @override
  String get receivedImage_tapToDecode => 'Натискнете за декодиране';

  @override
  String get receivedImage_decoding => 'Повторно… за приблизително 1 секунда';

  @override
  String receivedImage_incomplete(int received, int total) {
    return 'Изображение неполно — $received от $total пакети отправили';
  }

  @override
  String get receivedImage_corrupt => 'Изображение не може да бъде воссоздано';

  @override
  String get receivedImage_decoderMissing =>
      'Получена изображение — разгадка на изображение е вреjan';

  @override
  String get receivedImage_evicted => 'Изображение не е хранитено';

  @override
  String get receivedImage_retry => 'Повтори';

  @override
  String get receivedImage_decodeAgain => 'Правилейте заново';

  @override
  String get receivedImage_openSettings => 'Настройте';

  @override
  String get receivedImage_tapToProcess => 'Натискнете за обработка';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'пакета',
      one: 'пакет',
    );
    return '$bytes байта · $packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds секунди';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes мин $seconds сек';
  }

  @override
  String get bastion_tagline => 'Комуникация без инфраструктура.';

  @override
  String get bastion_nodes => 'Възли';

  @override
  String get bastion_repeaters => 'Ретранслатори';

  @override
  String get bastion_active1h => 'Активни 1 ч';

  @override
  String get bastion_mapCoverage => 'Карта + покритие';

  @override
  String get bastion_routeIntelligence => 'Анализ на маршрути';

  @override
  String get bastion_repeaterTools => 'Инструменти за ретранслатор';

  @override
  String get bastion_fieldStats => 'Теренна статистика';

  @override
  String get bastion_fieldOps => 'Поход + теренни операции';

  @override
  String get bastion_coverageCapture => 'Запис на покритие';

  @override
  String get bastion_mapAttribution =>
      'Картни данни © сътрудници на OpenStreetMap; плочки от избрания доставчик';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count наблюдения',
      one: '1 наблюдение',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count уникални възела',
      one: '1 уникален възел',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count скока',
      one: '1 скок',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count минути',
      one: '1 минута',
    );
    return '$_temp0';
  }

  @override
  String get sos_holdHint =>
      'Задръжте 2 секунди. Изпраща местоположението ви до контактите от похода на всеки 5 минути, докато някой отговори.';

  @override
  String sos_holdHintChannel(String channel) {
    return 'Задръжте 2 секунди. Изпраща местоположението ви до контактите от похода и до $channel на всеки 5 минути, докато някой отговори.';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS не е изпратен: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return 'Потвърдено от $name. Повторенията са спрени.';
  }

  @override
  String get sos_waitingForRadio => 'Изчакване радиостанцията да изпрати…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return 'Изпратено $sends от $max пъти. Повторенията приключиха; все още няма отговор.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return 'Изпратено $sends от $max пъти. Следващо в $time.';
  }

  @override
  String get sos_active => 'SOS АКТИВЕН';

  @override
  String get sos_stop => 'СПРИ';

  @override
  String get sos_imSafe => 'В БЕЗОПАСНОСТ СЪМ';

  @override
  String get sos_holdSemantics => 'SOS. Задръжте, за да изпратите.';

  @override
  String get sos_keepHolding => 'ПРОДЪЛЖЕТЕ ДА ДЪРЖИТЕ…';

  @override
  String get sos_holdForSos => 'ЗАДРЪЖТЕ ЗА SOS';

  @override
  String get sos_blockStorage =>
      'Първо отстранете грешката при съхранение на теренния дневник.';

  @override
  String get sos_blockNotConnected =>
      'Свържете радиостанцията си MeshCore, за да изпратите SOS.';

  @override
  String get sos_blockNoTarget =>
      'Изберете контакти от похода или SOS канал в „Планиране на поход“.';

  @override
  String get checkIn_labelOk => 'Добре съм';

  @override
  String get checkIn_labelAtCamp => 'В лагера';

  @override
  String get checkIn_labelDelayed => 'Забавям се';

  @override
  String get checkIn_labelHeadingBack => 'Връщам се';

  @override
  String get checkIn_blockLoading => 'Зареждане на похода…';

  @override
  String get checkIn_blockStorage =>
      'Отстранете грешката при съхранение на теренния дневник, преди да изпратите.';

  @override
  String get checkIn_blockBusy => 'Изпраща се отметка. Моля, изчакайте.';

  @override
  String get checkIn_blockNoContacts =>
      'Изберете контакти от похода в „Планиране на поход“.';

  @override
  String get checkIn_blockRosterIncomplete =>
      'Някои контакти от похода не са налични. Прегледайте списъка.';

  @override
  String get checkIn_blockNotConnected =>
      'Свържете радиостанцията си MeshCore, за да се отметнете.';

  @override
  String get checkIn_blockNotActive =>
      'Започнете похода, за да включите отметките.';

  @override
  String get checkIn_notSent => 'Не е изпратено';

  @override
  String checkIn_deliveredToOne(String name) {
    return 'Доставено до $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return 'Доставено до всички $count контакта';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return 'Доставено до $delivered от $total';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return 'Не е доставено: $names';
  }

  @override
  String get checkIn_waitingForRest => 'Изчакване на останалите';

  @override
  String get checkIn_aContact => 'контакт';

  @override
  String get checkIn_statusPending => 'Чакащо';

  @override
  String get checkIn_statusSent => 'Изпратено';

  @override
  String get checkIn_statusDelivered => 'Доставено';

  @override
  String get checkIn_statusFailed => 'Неуспешно';

  @override
  String get checkIn_explainPending =>
      'В локална опашка. Това не потвърждава радиопредаване или получаване.';

  @override
  String get checkIn_explainSent =>
      'Радиостанцията прие изпращането. Не е записано потвърждение за доставка.';

  @override
  String get checkIn_explainDelivered =>
      'Приложението записа потвърждение за доставка. Това не доказва, че човекът го е прочел.';

  @override
  String get checkIn_explainFailed =>
      'Няма потвърдена доставка. Проверете радиовръзката, достъпността на получателя и историята на повторните опити.';

  @override
  String get checkIn_explainUnknown =>
      'Състоянието на доставката не е налично. Не приемайте, че съобщението е пристигнало.';

  @override
  String get tripBrief_heading => 'NOTORYX • Обобщение на поход MeshCore';

  @override
  String tripBrief_trip(String name) {
    return 'Поход: $name';
  }

  @override
  String tripBrief_status(String status) {
    return 'Състояние: $status';
  }

  @override
  String get tripBrief_active => 'Активен';

  @override
  String get tripBrief_stopped => 'Спрян';

  @override
  String tripBrief_contacts(String names) {
    return 'Контакти: $names';
  }

  @override
  String get tripBrief_noneSelected => 'Няма избрани';

  @override
  String get tripBrief_unavailableContact =>
      'Недостъпен контакт (прегледайте списъка)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return 'Активността е просрочена след: $minutes минути (този телефон предупреждава, когато контакт замълчи)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'Напомняне за отметка: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return 'на всеки $minutes минути без отметка';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'Възможности за отметка: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'Позиция на радиостанцията в отметките: $value';
  }

  @override
  String get tripBrief_includedMayBeStale => 'Включена; може да е остаряла';

  @override
  String tripBrief_battery(String value) {
    return 'Батерия на радиостанцията в отметките: $value';
  }

  @override
  String get tripBrief_included => 'Включена';

  @override
  String get tripBrief_off => 'Изкл.';

  @override
  String get tripBrief_review =>
      'Прегледайте получателите и съобщението, преди да изпратите отметка.';

  @override
  String get tripBrief_noProof =>
      'В опашка или изпратено не доказва доставка. Потвърждението не доказва, че е прочетено.';

  @override
  String get tripBrief_overdueMeaning =>
      'Просрочено означава липса на скорошна активност на контакта; това не е потвърдена спешна ситуация.';

  @override
  String get tripBrief_automations =>
      'Теренните автоматизации работят само докато приложението е активно. Договорете отделен план при пропуснат контакт.';

  @override
  String get tripBrief_sharesOnly =>
      'Това обобщение само споделя информация; то не изпраща радиосъобщение и не започва поход.';

  @override
  String get fieldOps_title => 'Теренни операции NOTORYX Core';

  @override
  String get fieldOps_tabTrip => 'Поход';

  @override
  String get fieldOps_tabReady => 'Готовност';

  @override
  String get fieldOps_tabLog => 'Дневник';

  @override
  String get fieldOps_tabAuto => 'Авто';

  @override
  String get fieldOps_tabCoverage => 'Покритие';

  @override
  String get fieldOps_tabConnection => 'Връзка';

  @override
  String get fieldOps_diagnostics => 'Диагностика';

  @override
  String get fieldOps_storageLoadError =>
      'Теренните данни не можаха да се заредят. Запазените данни са съхранени; автоматизациите остават изключени.';

  @override
  String get fieldOps_storageSaveError =>
      'Теренните данни не можаха да се запишат. Автоматизациите са спрени; вече съхранените данни се запазват.';

  @override
  String get fieldOps_regionHint =>
      'Изберете област и нива на мащаб в „Офлайн карти“.';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • мащаб $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return 'Областта на картата не можа да се провери: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Походът е активен • $count контакта',
      one: 'Походът е активен • 1 контакт',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped =>
      'Походът е спрян. Започнете го, когато сте готови.';

  @override
  String fieldOps_reminderAt(String time) {
    return 'Напомняне за отметка в $time';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return 'Мълчат твърде дълго: $names';
  }

  @override
  String get fieldOps_planTrip => 'Планиране на поход';

  @override
  String get fieldOps_endTrip => 'Край на похода';

  @override
  String get fieldOps_startTrip => 'Начало на похода';

  @override
  String get fieldOps_tripBrief => 'Обобщение на похода';

  @override
  String get fieldOps_connectRadio => 'Свързване на радиостанция';

  @override
  String get fieldOps_previewedCheckIns => 'Отметки с преглед';

  @override
  String get fieldOps_previewedCheckInsHint =>
      'Изберете състояние, прегледайте действителните получатели и съобщението, после изпратете. В опашка не означава доставено.';

  @override
  String get fieldOps_tripRoster => 'Списък на похода';

  @override
  String get fieldOps_rosterEmpty =>
      'Изберете до шест известни контакта за чат в „Планиране на поход“.';

  @override
  String get fieldOps_rosterCaveat =>
      '„Последно чут“ е доказателство за минала активност. Това не потвърждава текущата достъпност. Знаците за просрочие означават липса на скорошна активност на контакта, а не потвърдена спешна ситуация.';

  @override
  String get fieldOps_offlineMaps => 'Офлайн карти';

  @override
  String get fieldOps_checkingTiles => 'Проверка на запазените плочки…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count кеширани плочки.',
      one: '1 кеширана плочка.',
    );
    return '$_temp0 Това не гарантира, че целият ви маршрут е покрит.';
  }

  @override
  String get fieldOps_downloadAreas => 'Изтегляне / преглед на офлайн области';

  @override
  String fieldOps_lastCheckIn(String time) {
    return 'Последна отметка, $time';
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
      other: 'Повторно изпращане до $count недоставени',
      one: 'Повторно изпращане до 1 недоставен',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable => 'Избраният контакт не е наличен';

  @override
  String get fieldOps_memberUnavailableHint =>
      'Прегледайте похода, преди да изпратите.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return 'Последна активност преди $minutes мин';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return 'Последна активност преди $minutes мин • просрочено';
  }

  @override
  String get fieldOps_noCheckInRecorded =>
      'В този дневник няма записана отметка.';

  @override
  String get fieldOps_tripMap => 'Карта на похода';

  @override
  String get fieldOps_tripMapEmpty =>
      'Все още никой от избраните контакти не е излъчил координати.';

  @override
  String get fieldOps_lastPositions => 'Последни излъчени позиции';

  @override
  String get fieldOps_positionsCaveat =>
      'Позициите може да са остарели. Тази карта не следи GPS на телефона и не доказва, че участниците са тук в момента.';

  @override
  String get fieldOps_briefPreviewTitle => 'Преглед на обобщението на похода';

  @override
  String get fieldOps_briefPreviewHint =>
      'Съдържа имената на похода и контактите. Прегледайте преди споделяне. Координатите, ключовете и историята на съобщенията са пропуснати.';

  @override
  String get fieldOps_shareBrief => 'Споделяне на обобщението';

  @override
  String get fieldOps_briefSubject => 'Обобщение на поход NOTORYX Core';

  @override
  String get fieldOps_tripName => 'Име на похода';

  @override
  String get fieldOps_defaultTripName => 'Моят поход';

  @override
  String get fieldOps_includePosition =>
      'Включване на излъчената позиция на радиостанцията';

  @override
  String get fieldOps_includePositionHint =>
      'Може да е остаряла; споделянето е изключено по подразбиране.';

  @override
  String get fieldOps_includeBattery =>
      'Включване на батерията на радиостанцията';

  @override
  String get fieldOps_overdueLabel => 'Предупреди ме, когато контакт мълчи';

  @override
  String get fieldOps_reminderLabel => 'Напомняй ми да се отмятам';

  @override
  String get fieldOps_reminderHelper =>
      'Известие на телефона, дори ако NOTORYX Core е затворен.';

  @override
  String get fieldOps_reminderOff => 'Изкл.';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'След $count минути без отметка',
      one: 'След 1 минута без отметка',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'SOS отива и до канал';

  @override
  String get fieldOps_sosChannelNone => 'Няма';

  @override
  String get fieldOps_selectContacts =>
      'Изберете до шест известни контакта за чат';

  @override
  String get fieldOps_sendCheckInTitle => 'Изпращане на отметка?';

  @override
  String fieldOps_recipients(String names) {
    return 'До: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      'Използват се обикновени директни съобщения. Доставката ще се следи в теренния дневник.';

  @override
  String get fieldOps_send => 'Изпрати';

  @override
  String get fieldOps_beforeYouLeave => 'Преди да тръгнете';

  @override
  String get fieldOps_radioConnected => 'Радиостанцията е свързана';

  @override
  String get fieldOps_connectHint => 'Свържете се чрез Bluetooth, USB или TCP.';

  @override
  String get fieldOps_radioBattery => 'Батерия на радиостанцията';

  @override
  String get fieldOps_batteryUnknown => 'Неизвестна; проверете радиостанцията.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent% • заредете за планирания поход.';
  }

  @override
  String get fieldOps_tripContacts => 'Контакти от похода';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return 'Налични $available/$selected. Проверете дали имат съвместими радиостанции и канали.';
  }

  @override
  String get fieldOps_offlineArea => 'Избрана офлайн област на картата';

  @override
  String get fieldOps_checkingFiles => 'Проверка на локалните файлове…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return 'Налични файлове с плочки: $available/$expected; липсват $missing. Това е моментна снимка; отворете областта офлайн, преди да тръгнете.';
  }

  @override
  String get fieldOps_locationChoice => 'Споделяне на местоположение';

  @override
  String get fieldOps_locationOptedIn =>
      'Включено: излъчените от радиостанцията координати може да са остарели.';

  @override
  String get fieldOps_locationOff =>
      'Споделянето е изключено. Отметките ви не съдържат координати.';

  @override
  String get fieldOps_automationAvailability => 'Наличност на автоматизациите';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'Работи само докато приложението е активно. Заспиване, затваряне или загуба на радиостанцията може да попречат на планираните действия.';

  @override
  String get fieldOps_readinessCaveat =>
      'Проверките за готовност са препоръчителни; те не доказват обхват и не гарантират доставка на съобщения.';

  @override
  String get fieldOps_radio => 'Радио';

  @override
  String get fieldOps_refreshChecks => 'Опресняване на проверките';

  @override
  String get fieldOps_searchLog => 'Търсене в теренния дневник';

  @override
  String get fieldOps_kindAll => 'Всички';

  @override
  String get fieldOps_kindCheckIn => 'Отметка';

  @override
  String get fieldOps_kindReceived => 'Получено';

  @override
  String get fieldOps_kindNote => 'Бележка';

  @override
  String get fieldOps_kindDeadZone => 'Мъртва зона';

  @override
  String get fieldOps_kindRadio => 'Радио';

  @override
  String get fieldOps_kindAutomation => 'Автоматизация';

  @override
  String get fieldOps_kindMissed => 'Пропуснато';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => 'Поход';

  @override
  String get fieldOps_kindOverdue => 'Просрочено';

  @override
  String get fieldOps_addNote => 'Добавяне на бележка';

  @override
  String get fieldOps_exportJson => 'Експорт на JSON';

  @override
  String get fieldOps_deleteLog => 'Изтриване на дневника';

  @override
  String get fieldOps_logSubject => 'Теренен дневник NOTORYX Core';

  @override
  String get fieldOps_logCaveat =>
      'Съхранява се локално, до 1000 записа. Експортите може да съдържат ключове на контакти, съобщения и местоположения; прегледайте преди споделяне.';

  @override
  String get fieldOps_noEntries => 'Няма съвпадащи записи.';

  @override
  String get fieldOps_tripUnspecified => 'Неуточнен поход';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return 'Записана излъчена позиция на радиостанцията $latitude, $longitude (може да е остаряла)';
  }

  @override
  String get fieldOps_noteTitle => 'Теренно наблюдение';

  @override
  String get fieldOps_noteLabel => 'Какво наблюдавахте?';

  @override
  String get fieldOps_deadZone => 'Докладвана мъртва зона';

  @override
  String get fieldOps_deadZoneHint =>
      'Вашето наблюдение, а не проверена прогноза за покритие.';

  @override
  String get fieldOps_savePosition =>
      'Запазване на излъчената позиция на радиостанцията';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • може да е остаряла; не е GPS на телефона';
  }

  @override
  String get fieldOps_noPosition => 'Няма използваеми излъчени координати';

  @override
  String get fieldOps_deleteLogTitle => 'Изтриване на теренния дневник?';

  @override
  String get fieldOps_deleteLogBody =>
      'Това премахва всички запазени записи на този телефон. Настройките на похода се запазват.';

  @override
  String get fieldOps_localAutomations => 'Локални автоматизации';

  @override
  String get fieldOps_enableForTrip => 'Включване за този поход';

  @override
  String get fieldOps_automationsCaveat =>
      'Изключени след всяко рестартиране на приложението. Правилата работят само докато приложението е активно. Пропуснатите планирани действия се показват в теренния дневник и никога не се наваксват наведнъж. Автоматичните отметки са ограничени до една партида на 10 минути.';

  @override
  String get fieldOps_openBotMode => 'Отваряне на режим бот на NOTORYX';

  @override
  String get fieldOps_ruleEnabled => 'Правилото е включено';

  @override
  String get fieldOps_dryRun => 'Пробно изпълнение';

  @override
  String get fieldOps_dryRunHint =>
      'Записване на действието без изпращане или известяване.';

  @override
  String get fieldOps_then => 'Тогава';

  @override
  String get fieldOps_actionLog => 'Запис в теренния дневник';

  @override
  String get fieldOps_actionNotify => 'Показване на локално известие';

  @override
  String get fieldOps_actionCheckIn =>
      'Изпращане на „I\'m OK“ до контактите от похода';

  @override
  String get fieldOps_batteryThreshold => 'Батерия на или под';

  @override
  String fieldOps_nextDue(String time) {
    return 'Следващо: $time';
  }

  @override
  String get fieldOps_nextDueNone => 'Следващо: не е планирано';

  @override
  String get fieldOps_previewInLog => 'Преглед в дневника';

  @override
  String get fieldOps_allowNotifications => 'Разрешаване на известия';

  @override
  String get fieldOps_triggerReconnect =>
      'КОГАТО радиостанцията се свърже отново';

  @override
  String get fieldOps_triggerDisconnect =>
      'КОГАТО радиостанцията прекъсне връзката';

  @override
  String get fieldOps_triggerLowBattery =>
      'КОГАТО батерията на радиостанцията премине прага';

  @override
  String get fieldOps_triggerNewNode => 'КОГАТО бъде добавен нов възел';

  @override
  String get fieldOps_triggerRepeater => 'КОГАТО бъде добавен нов ретранслатор';

  @override
  String get fieldOps_triggerScheduled =>
      'КОГАТО дойде време за планирана отметка';

  @override
  String get fieldOps_explainConnection => 'Обясни връзката ми';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return 'Състояние: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      'Телефонът има връзка с радиостанцията. Само по себе си това не осигурява маршрут до получателите ви.';

  @override
  String get fieldOps_disconnectedHint =>
      'Няма активна радиовръзка. Проверете разрешенията за Bluetooth, захранването и обхвата на радиостанцията; USB/TCP са налични от „Свързване на радиостанция“.';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return 'Отметки от похода, чакащи потвърждение: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'Времената на последно виждане и излъчените позиции на възлите може да са остарели. Анализът на маршрути показва маршрути, научени от наблюдавани опити; той не измисля пътища.';

  @override
  String get fieldOps_routeIntelligence => 'Анализ на маршрути';

  @override
  String get fieldOps_coverageIntelligence => 'Анализ на покритието';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      'Сравнете записаните наблюдения между две теренни сесии. Точките отбелязват излъчените позиции на записващата радиостанция, където са чути възли. Те не означават непрекъснато покритие. Моментните снимки RSSI/SNR не са измервания за отделни възли.';

  @override
  String get fieldOps_captureSession => 'Запис на сесия';

  @override
  String get fieldOps_refreshHistory => 'Опресняване на историята';

  @override
  String get fieldOps_noCoverageSessions =>
      'Все още няма запазени сесии за покритие.';

  @override
  String get fieldOps_sessionA => 'Сесия A • тюркоаз';

  @override
  String get fieldOps_sessionB => 'Сесия B • кехлибар';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: уникални възли $a • B: уникални възли $b';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return 'Общи: $shared • Само A: $onlyA • Само B: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'Ако възел не се чува в една сесия, това не доказва мъртва зона. Условията и продължителността на наблюдението се различават.';

  @override
  String get fieldOps_heardTooltip =>
      'Наблюдение на чут възел; не е доказателство за успешна връзка';

  @override
  String get fieldOps_noteTooltip =>
      'Локална бележка при излъчените координати на радиостанцията; може да е остаряла.';

  @override
  String get bastionHome_aboutTooltip => 'За NOTORYX Core';

  @override
  String get bastionHome_getStarted => 'Първи стъпки';

  @override
  String get bastionHome_getStartedHint =>
      'Свържете радиостанцията си и проверете първото си съобщение';

  @override
  String get bastionHome_planYourTrip => 'Планирайте похода си';

  @override
  String get bastionHome_tripActive => 'Походът е активен';

  @override
  String get bastionHome_tripStopped => 'Походът е спрян';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • контакти: $contacts • непрочетени: $unread';
  }

  @override
  String get bastionHome_checkInOk => 'Отметка: добре съм';

  @override
  String get bastionHome_checkInHint =>
      'Прегледайте контактите и съобщението, преди да изпратите. Следете потвържденията в теренния дневник.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return 'Последна отметка: $summary';
  }

  @override
  String get bastionHome_connectRadio => 'Свързване на радиостанция';

  @override
  String get bastionHome_connectRadioHint =>
      'Връзки MeshCore чрез Bluetooth, USB и TCP';

  @override
  String get bastionHome_liveDiagnostics => 'Диагностика на живо';

  @override
  String get bastionHome_liveDiagnosticsHint =>
      'Състояние на радиостанцията, сигнал, устройство и инструменти за кадри';

  @override
  String get bastionHome_meshDiscovery => 'Откриване на мрежата';

  @override
  String get bastionHome_meshDiscoveryHint =>
      'Намерете възли и разгледайте мрежата около вас';

  @override
  String get bastionHome_fieldOpsHint =>
      'Обобщение на похода, готовност, теренен дневник, автоматизации и сравнение на покритието';

  @override
  String get bastionHome_fieldTools => 'Теренни инструменти NOTORYX';

  @override
  String get bastionHome_statusActive => 'АКТИВНО';

  @override
  String get bastionHome_consoleOnline => 'Теренната конзола е онлайн';

  @override
  String get bastionHome_consoleReady => 'Теренната конзола е готова';

  @override
  String get bastionHome_consoleHint =>
      'Свържете радиостанция, за да активирате таблото на живо.';

  @override
  String bastionHome_battery(String value) {
    return 'Бат $value';
  }

  @override
  String get bastionTools_title => 'Теренни инструменти';

  @override
  String get bastionTools_backup => 'Шифровано резервно копие';

  @override
  String get bastionTools_backupHint =>
      'Запазете настройки, контакти и ключове, по избор с история на чата';

  @override
  String get bastionTools_fieldOpsHint =>
      'Отметки, готовност, теренен дневник, автоматизации и сравнения';

  @override
  String get bastionTools_mapHint =>
      'Карта на живо, сесии за запис, инструменти за офлайн карти и региони';

  @override
  String get bastionTools_pathAnalysis => 'Анализ на пътища';

  @override
  String get bastionTools_pathHint => 'Маршрути, откриване и анализ на пътища';

  @override
  String get bastionTools_repeaterHint =>
      'Състояние, вход, телеметрия, съседи и администрация';

  @override
  String get bastionTools_statsHint =>
      'Броячи на мрежата на живо и активност на контактите';

  @override
  String get bastionTools_diagnostics => 'Диагностика';

  @override
  String get bastionTools_diagnosticsHint =>
      'Състояние на радиостанцията, информация за устройството, сурови кадри и експорт';

  @override
  String get bastionTools_about => 'За приложението + благодарности';

  @override
  String get bastionTools_aboutHint =>
      'Версия на NOTORYX Core, декларация за независимост и лицензи с отворен код';

  @override
  String get bastionAbout_title => 'За приложението + Благодарности';

  @override
  String get bastionAbout_intro =>
      'Независимо общностно приложение-спътник за мрежи MeshCore. NOTORYX Core не е официално приложение на MeshCore и включването на ресурси от общността не означава партньорство или одобрение.';

  @override
  String get bastionAbout_version => 'Версия';

  @override
  String get bastionAbout_openSource => 'Основа с отворен код';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core е изграден върху и променя отворения код на MeshCore Open под лиценза MIT. Работата по процеса за покритие отдава признание и, където е приложимо, на лицензираното под MIT приложение MeshMapper Flutter App.';

  @override
  String get bastionAbout_community => 'Общността на първо място';

  @override
  String get bastionAbout_communityBody =>
      'Ресурсите на външни автори остават собственост на съответните им автори. Не се подразбира собственост или партньорство.';

  @override
  String get bastionAbout_legalese =>
      'NOTORYX Core • Независим спътник за MeshCore';

  @override
  String get bastionAbout_licenses => 'Лицензи с отворен код';

  @override
  String get bastionSetup_title => 'Първи стъпки с NOTORYX Core';

  @override
  String get bastionSetup_intro =>
      'Свържете се, изберете контакт и после проверете съобщение. Можете да се върнете към това ръководство от таблото по всяко време.';

  @override
  String get bastionSetup_step1 => '1. Свържете радиостанцията си MeshCore';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return 'Свързано с $device чрез $transport.';
  }

  @override
  String get bastionSetup_noRadio => 'Все още няма свързана радиостанция.';

  @override
  String get bastionSetup_step1Power =>
      'Включете радиостанция-спътник MeshCore. Отворете „Свързване на радиостанция“ и изберете Bluetooth, USB или TCP. Разрешете поисканите за избраната връзка разрешения.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Ако търсенето чрез Bluetooth е празно, проверете дали Bluetooth е включен и дали NOTORYX Core има разрешение „Устройства наблизо“ в настройките на приложенията на Android. Следвайте всички допълнителни заявки за разрешения от скенера.';

  @override
  String get bastionSetup_connectionDiagnostics => 'Диагностика на връзката';

  @override
  String get bastionSetup_step2 => '2. Изберете контакт за чат';

  @override
  String get bastionSetup_step2Body =>
      'Помолете партньор наблизо със съвместими настройки на радиостанция MeshCore да обяви своя възел. Изберете известен контакт за чат по-долу; ретранслаторите се управляват отделно.';

  @override
  String get bastionSetup_noContacts =>
      'Няма налични контакти за чат. Свържете радиостанцията си и отворете „Откриване на мрежата“.';

  @override
  String get bastionSetup_testRecipient => 'Тестов получател';

  @override
  String get bastionSetup_meshDiscovery => 'Откриване на мрежата';

  @override
  String get bastionSetup_step3 => '3. Изпратете и проверете съобщение';

  @override
  String get bastionSetup_step3Body =>
      'Отворете чата, напишете кратко тестово съобщение, прегледайте получателя и докоснете „Изпрати“. Върнете се тук, за да видите последното изходящо съобщение, записано след отварянето на ръководството.';

  @override
  String get bastionSetup_openTestChat => 'Отваряне на тестов чат';

  @override
  String get bastionSetup_connectFirst =>
      'Свържете радиостанцията си, за да отворите тестовия чат.';

  @override
  String get bastionSetup_chooseRecipient => 'Първо изберете получател.';

  @override
  String get bastionSetup_noTestMessage =>
      'В тази сесия на ръководството не е записано изходящо тестово съобщение.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return 'Последно съобщение: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'Помолете партньора си да потвърди получаването или да отговори. Записаното потвърждение не доказва, че е прочетено. Проверете отново връзката и получателя, ако съобщение не успее.';

  @override
  String get bastionSetup_step4 => '4. Подгответе се за терена';

  @override
  String get bastionSetup_step4Body =>
      'Планирайте контактите от похода и прегледайте изтеглените области на картата. Режимът бот и теренните автоматизации първоначално са изключени; теренните автоматизации работят само докато приложението е активно.';

  @override
  String get bastionSetup_tripTools => 'Инструменти за поход и готовност';

  @override
  String get bastionDiag_title => 'Диагностика';

  @override
  String get bastionDiag_export => 'Експорт на диагностика';

  @override
  String get bastionDiag_channels => 'Канали';

  @override
  String get bastionDiag_radio => 'Радио';

  @override
  String get bastionDiag_frequency => 'Честота';

  @override
  String get bastionDiag_bandwidth => 'Честотна лента';

  @override
  String get bastionDiag_spreadingFactor => 'Фактор на разширение';

  @override
  String get bastionDiag_codingRate => 'Скорост на кодиране';

  @override
  String get bastionDiag_txPower => 'Мощност на предаване';

  @override
  String get bastionDiag_noiseFloor => 'Ниво на шума';

  @override
  String get bastionDiag_device => 'Устройство';

  @override
  String get bastionDiag_name => 'Име';

  @override
  String get bastionDiag_manufacturer => 'Производител';

  @override
  String get bastionDiag_firmware => 'Фърмуер';

  @override
  String get bastionDiag_battery => 'Батерия';

  @override
  String get bastionDiag_transport => 'Връзка';

  @override
  String get bastionDiag_deepTools => 'Разширени инструменти';

  @override
  String get bastionDiag_liveStats => 'Радиостатистика на живо';

  @override
  String get bastionDiag_liveStatsHint => 'Шум, RSSI, SNR и ефирно време';

  @override
  String get bastionDiag_frameDebug => 'Отстраняване на грешки в кадри / BLE';

  @override
  String get bastionDiag_frameDebugHint =>
      'Разгледайте декодирани и сурови получени кадри';

  @override
  String get bastionDiag_appLog => 'Дневник за отстраняване на грешки';

  @override
  String get bastionDiag_appLogHint =>
      'Прегледайте диагностичните събития на приложението';

  @override
  String get bastionDiag_online => 'Радиостанцията е онлайн';

  @override
  String get bastionDiag_offline => 'Радиостанцията е офлайн';

  @override
  String get bastionDiag_offlineHint =>
      'Свържете спътник MeshCore, за да попълните диагностиката на живо.';

  @override
  String get coverage_title => 'Запис на покритие';

  @override
  String get coverage_leaveBlocked =>
      'Спрете и запазете сесията, преди да излезете.';

  @override
  String get coverage_savedSessions => 'Запазени сесии';

  @override
  String get coverage_caveat =>
      'RSSI/SNR са моментни снимки на радиостанцията и може да принадлежат на друг пакет. Позициите са излъчени от радиостанцията координати, а не GPS на телефона или доказателство за покритие. Синьо: записващ; кехлибарено: излъчен възел. Не се извършва интерполация.';

  @override
  String get coverage_captureActive => 'Записът е активен';

  @override
  String get coverage_fieldSession => 'Теренна сесия за покритие';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core записва новочути възли по време на тази сесия, включително данни за маршрута, метаданни за възел/местоположение и най-близката налична моментна снимка RSSI/SNR на радиостанцията.';

  @override
  String get coverage_disconnectedBody =>
      'Свържете радиостанция, преди да започнете. Записът на покритие запазва наблюдения на мрежата на живо от свързаната радиостанция-спътник.';

  @override
  String get coverage_observations => 'Наблюдения';

  @override
  String get coverage_uniqueNodes => 'Уникални възли';

  @override
  String get coverage_elapsed => 'Изминало';

  @override
  String get coverage_radioConnected => 'Радиостанцията е свързана';

  @override
  String get coverage_noRadio => 'Няма радиостанция';

  @override
  String get coverage_gpsReady => 'GPS на радиостанцията е готов';

  @override
  String get coverage_noGps => 'Няма GPS на радиостанцията';

  @override
  String get coverage_stopSave => 'Спри + запази сесията';

  @override
  String get coverage_start => 'Започни сесия за покритие';

  @override
  String get coverage_exportJson => 'Експорт на JSON';

  @override
  String get coverage_exportCsv => 'Експорт на CSV';

  @override
  String get coverage_liveObservations => 'Наблюдения на живо';

  @override
  String get coverage_waiting => 'Изчакване на активност в мрежата';

  @override
  String get coverage_waitingBody =>
      'Започнете сесия и новочутите активни възли ще се появят тук. Стойностите RSSI/SNR са моментни снимки на радиостанцията и не винаги могат еднозначно да се отнесат към конкретен пакет.';

  @override
  String get coverage_signalNa => 'сигнал н/д';

  @override
  String get coverage_snrNa => 'SNR н/д';

  @override
  String get coverage_gpsUnavailable => 'GPS на радиостанцията не е наличен';

  @override
  String coverage_pathLine(String path, String location) {
    return 'Път: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'flood';

  @override
  String get coverage_pathDirect => 'директен';

  @override
  String get coverage_shareSubject => 'Сесия за покритие NOTORYX Core';

  @override
  String get coverage_shareText => 'Експорт на запис на покритие NOTORYX Core';

  @override
  String get coverage_historyTitle => 'Запазени сесии за покритие';

  @override
  String coverage_loadFailed(String error) {
    return 'Сесиите не можаха да се заредят: $error';
  }

  @override
  String get coverage_deleteTitle => 'Изтриване на запазената сесия?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count наблюдения ще бъдат премахнати от това устройство.',
      one: '1 наблюдение ще бъде премахнато от това устройство.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'Сесията не можа да се изтрие: $error';
  }

  @override
  String get coverage_retention =>
      'Пазят се най-новите 20 завършени сесии. Споделете сесиите, които искате да запазите. Прекъснатите записи могат да се отворят отново по-долу.';

  @override
  String get coverage_noSessions =>
      'Все още няма запазени сесии. Спрете запис, за да го запазите.';

  @override
  String get coverage_interrupted => 'Прекъснат запис';

  @override
  String get coverage_saved => 'Запазена';

  @override
  String get coverage_deleteTooltip => 'Изтриване на сесията';

  @override
  String coverage_exportFailed(String error) {
    return 'Експортът е неуспешен: $error';
  }

  @override
  String get coverage_sessionTitle => 'Сесия за покритие';

  @override
  String get coverage_shareJson => 'Споделяне на JSON';

  @override
  String get coverage_shareCsv => 'Споделяне на CSV';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • възраст на снимката $age ms';
  }

  @override
  String get coverage_unknown => 'неизвестно';

  @override
  String coverage_pathValue(String path) {
    return 'път $path';
  }

  @override
  String get coverage_recorder => 'Записващ';

  @override
  String get coverage_noCoordinates =>
      'Няма използваеми координати в тази сесия. Наблюденията остават достъпни по-долу.';

  @override
  String get coverage_osmAttribution =>
      '© сътрудници на OpenStreetMap • онлайн основна карта';

  @override
  String get fieldStats_title => 'Теренен анализ';

  @override
  String get fieldStats_snapshot => 'Моментна снимка на мрежата';

  @override
  String get fieldStats_headline => 'Какво знае NOTORYX Core в момента.';

  @override
  String get fieldStats_body =>
      'Тези броячи се изчисляват от таблицата с контакти на свързания MeshCore, местоположенията, пътищата и времената на последно виждане.';

  @override
  String get fieldStats_total => 'Общо';

  @override
  String get fieldStats_chatNodes => 'Възли за чат';

  @override
  String get fieldStats_rooms => 'Стаи';

  @override
  String get fieldStats_sensors => 'Сензори';

  @override
  String get fieldStats_located => 'С местоположение';

  @override
  String get fieldStats_favorites => 'Любими';

  @override
  String get fieldStats_routeSnapshot => 'Моментна снимка на маршрутите';

  @override
  String get fieldStats_routed => 'С маршрут';

  @override
  String get fieldStats_direct => 'Директни';

  @override
  String get fieldStats_flood => 'Flood';

  @override
  String get fieldStats_pathIntel => 'Анализ на пътища';

  @override
  String get fieldStats_pathIntelBody =>
      'Анализът на маршрути на NOTORYX Core използва запазени опити за пътища, брой скокове, успехи/неуспехи, време за преминаване и тегла на маршрутите, за да покаже научени маршрути.';

  @override
  String get fieldStats_coverageSessions => 'Сесии за покритие';

  @override
  String get fieldStats_coverageSessionsBody =>
      'Записът на покритие вече запазва теренни сесии, възстановява прекъсната работа, експортира наблюдения и нанася записаните точки на покритие върху картата. RSSI/SNR остават най-близката налична моментна снимка на радиостанцията.';

  @override
  String get mapHub_title => 'Теренна карта NOTORYX';

  @override
  String get mapHub_intro =>
      'Карти на живо, офлайн области, регионални профили и теренни сесии за покритие на NOTORYX Core.';

  @override
  String get mapHub_captureHint =>
      'Започване и спиране на теренна сесия за покритие';

  @override
  String get mapHub_badgeNew => 'НОВО';

  @override
  String get mapHub_liveMap => 'Карта на мрежата на живо';

  @override
  String get mapHub_liveMapHint =>
      'Възли, ретранслатори, позиции, маршрути и инструменти за картата';

  @override
  String get mapHub_badgeLive => 'НА ЖИВО';

  @override
  String get mapHub_offlinePacks => 'Пакети офлайн карти';

  @override
  String get mapHub_offlinePacksHint =>
      'Кеширайте плочки за походи и места без покритие';

  @override
  String get mapHub_badgeOffline => 'ОФЛАЙН';

  @override
  String get mapHub_regions => 'Профили на региони';

  @override
  String get mapHub_regionsHint =>
      'Управление и изтегляне на регионални дефиниции на мрежата';

  @override
  String get mapHub_badgeRegions => 'РЕГИОНИ';

  @override
  String get routes_title => 'Анализ на маршрути';

  @override
  String get routes_headline => 'Вижте как трафикът се движи през мрежата.';

  @override
  String get routes_body =>
      'NOTORYX Core подрежда запазените маршрути по историята на пътищата, вече научена от реални опити за съобщения и откриване.';

  @override
  String get routes_routes => 'Маршрути';

  @override
  String get routes_success => 'Успехи';

  @override
  String get routes_failed => 'Неуспехи';

  @override
  String get routes_routeMap => 'Карта на маршрутите';

  @override
  String get routes_routeMapHint => 'Разгледайте възли и пътища';

  @override
  String get routes_discover => 'Откриване';

  @override
  String get routes_discoverHint => 'Намерете нови маршрути';

  @override
  String get routes_learned => 'Научени маршрути';

  @override
  String get routes_none => 'Все още няма история на маршрутите';

  @override
  String get routes_noneBody =>
      'Използвайте мрежата нормално или стартирайте откриване. NOTORYX Core ще показва тук научените маршрути, щом има история на пътищата.';

  @override
  String get routes_direct => 'ДИРЕКТЕН';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count маршрута',
      one: '1 маршрут',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return 'НАЙ-ДОБЪР  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  тегло $weight  •  успехи: $success / неуспехи: $fail';
  }

  @override
  String routes_fastest(String ms) {
    return 'Най-бърз известен: $ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'Flood: успехи: $success / неуспехи: $fail';
  }

  @override
  String get repeaterTools_heroLabel => 'Управление на ретранслатори';

  @override
  String get repeaterTools_headline =>
      'Управлявайте инфраструктурата зад мрежата си.';

  @override
  String get repeaterTools_body =>
      'Изберете открит ретранслатор, за да влезете и да отворите наличните му инструменти MeshCore за състояние, телеметрия, съседи, настройки и CLI.';

  @override
  String get repeaterTools_discovered => 'Открити';

  @override
  String get repeaterTools_tools => 'Инструменти';

  @override
  String get repeaterTools_available => 'Налични ретранслатори';

  @override
  String get repeaterTools_unnamed => 'Ретранслатор без име';

  @override
  String get repeaterTools_statusTelemetry => 'Състояние + телеметрия';

  @override
  String get repeaterTools_statusTelemetryBody =>
      'Проверявайте състоянието и телеметрията на ретранслатора с наличните инструменти за управление.';

  @override
  String get repeaterTools_neighbors => 'Съседи';

  @override
  String get repeaterTools_neighborsBody =>
      'Разгледайте съседната инфраструктура и връзките в мрежата.';

  @override
  String get repeaterTools_cli => 'CLI + настройки';

  @override
  String get repeaterTools_cliBody =>
      'Влезлите администратори имат достъп до наличния CLI на ретранслатора и инструментите за конфигуриране.';

  @override
  String get repeaterTools_empty =>
      'Все още няма открити ретранслатори. Свържете радиостанция и първо разгледайте мрежата.';

  @override
  String get notification_fieldAlertTitle => 'Теренно предупреждение NOTORYX';

  @override
  String get notification_checkInReminderTitle =>
      'Напомняне за отметка NOTORYX Core';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return 'Няма отметка от $minutes минути в похода „$trip“. Отворете NOTORYX Core, за да се отметнете.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return 'Няма вест от $name от $minutes минути. Това не е потвърдена спешна ситуация.';
  }

  @override
  String get notification_aTripContact => 'Контакт от похода';

  @override
  String notification_checkInNotDelivered(String name) {
    return 'Отметката не е доставена до $name. Можете да я изпратите отново от „Поход“.';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return 'SOS потвърден от $name';
  }

  @override
  String get settings_batterySaver => 'Пестене на батерията';

  @override
  String get settings_batterySaverOn =>
      'Вкл.: батерия на радиостанцията на всеки 10 мин, GPS на всеки 5 мин, статистика най-много веднъж в минута, проверки на похода на всеки 1–2 мин. Съобщенията, предупрежденията и SOS не се променят.';

  @override
  String get settings_batterySaverOff =>
      'Проверявайте радиостанцията и похода по-рядко, за да пестите батерията на телефона и радиостанцията. Съобщенията, предупрежденията и SOS не се променят.';

  @override
  String get settings_readAloud => 'Четене на нови съобщения на глас';

  @override
  String get settings_readAloudHelper =>
      'Докато NOTORYX Core е отворен. Заглушените канали остават тихи. Всяко съобщение може да се прочете и от менюто му.';

  @override
  String get settings_readAloudOff => 'Изкл.';

  @override
  String get settings_readAloudDirect => 'Директни съобщения';

  @override
  String get settings_readAloudAll => 'Директни съобщения и съобщения в канали';

  @override
  String get chat_readAloud => 'Прочети на глас';

  @override
  String get messageSearch_title => 'Търсене в съобщенията';

  @override
  String get messageSearch_intro =>
      'Търсете във всички директни съобщения и съобщения в канали, запазени на този телефон.';

  @override
  String messageSearch_noResults(String query) {
    return 'Няма съобщения, съдържащи „$query“.';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count съвпадения',
      one: '1 съвпадение',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return 'Показани са най-новите $count съвпадения';
  }

  @override
  String get shortcuts_checkIn => 'Отметка';

  @override
  String get shortcuts_trip => 'Поход';

  @override
  String get shortcuts_chats => 'Чатове';

  @override
  String get shortcuts_map => 'Карта';

  @override
  String get sensor_liveUpdates => 'Актуализации на живо';

  @override
  String get sensor_intro =>
      'Нека сензорът сам изпраща показания, когато се променят, вместо да питате всеки път. Изисква вход с право за четене.';

  @override
  String get sensor_watch => 'Следене за промени';

  @override
  String get sensor_loadFirst =>
      'Първо заредете телеметрията, за да изберете показания.';

  @override
  String sensor_watching(String readings, String time) {
    return 'Следят се $readings до $time.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return 'Следят се $readings до $time • регион $region.';
  }

  @override
  String get sensor_noChanges => 'Все още няма отчетени промени.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return 'Последна актуализация $time • получени: $count';
  }

  @override
  String get sensor_stop => 'Спиране на актуализациите на живо';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'Спряно тук; сензорът не потвърди и ще спре, когато времето изтече. $error';
  }

  @override
  String get sensor_dialogBody =>
      'Сензорът проверява около веднъж в минута и изпраща актуализация, когато избрано показание се промени повече от прага си.';

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
    return 'Актуализиране при промяна с $delta';
  }

  @override
  String get sensor_changeThreshold => 'Промяна на прага';

  @override
  String sensor_capacity(int max, String used) {
    return 'Сензорът може да следи до $max байта показания (използвани: $used).';
  }

  @override
  String get sensor_for => 'За';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count часа',
      one: '1 час',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => 'Старт';

  @override
  String sensor_thresholdTitle(String label) {
    return 'Праг за $label';
  }

  @override
  String get sensor_typeTemperature => 'Температура';

  @override
  String get sensor_typeHumidity => 'Влажност';

  @override
  String get sensor_typePressure => 'Налягане';

  @override
  String get sensor_typeVoltage => 'Напрежение';

  @override
  String get sensor_typeCurrent => 'Ток';

  @override
  String get sensor_typeLight => 'Осветеност';

  @override
  String get sensor_typeConcentration => 'Концентрация';

  @override
  String get sensor_typePercentage => 'Процент';

  @override
  String get sensor_typeAnalogInput => 'Аналогов вход';

  @override
  String get sensor_typeAltitude => 'Надморска височина';

  @override
  String get setupWizard_title => 'Свържете радиото';

  @override
  String get setupWizard_choose => '1. Изберете връзка';

  @override
  String get setupWizard_prepare => '2. Подгответе радиото';

  @override
  String get setupWizard_intro =>
      'Изберете как този телефон или компютър ще се свързва с радиото. Радиото пренася съобщенията през мрежата.';

  @override
  String get setupWizard_bluetooth =>
      'Безжична връзка със съвместимо радио наблизо.';

  @override
  String get setupWizard_noBluetooth =>
      'Bluetooth не е наличен в този браузър. Използвайте приложението или поддържана USB връзка.';

  @override
  String get setupWizard_usb => 'Кабелна връзка чрез USB кабел за данни.';

  @override
  String get setupWizard_noUsb =>
      'USB серийната връзка не е налична тук. Използвайте поддържано приложение за компютър или Android, или Chrome с Web Serial.';

  @override
  String get setupWizard_bluetoothSteps =>
      'Включете радиото и го дръжте наблизо. Включете Bluetooth и разрешете на приложението да го използва. Затворете другите приложения, свързани с радиото, отворете списъка с устройства и потърсете.';

  @override
  String get setupWizard_usbSteps =>
      'Свържете включено радио с USB кабел за данни; кабел само за зареждане няма да работи. Затворете другите серийни приложения. Отворете списъка с USB устройства, изберете радиото и разрешете достъп, ако бъдете попитани.';

  @override
  String get setupWizard_firmwareTitle =>
      'Проверете съвместимостта, преди да сменяте фърмуера';

  @override
  String get setupWizard_firmware =>
      'Радиото ви се нуждае от фърмуер MeshCore companion, който поддържа избраната връзка. Поддръжката зависи от платката и версията на фърмуера; наличието на USB порт само по себе си не гарантира поддръжка на USB сериен порт. Проверете инструкциите за вашата платка и инсталираната версия. Фърмуерът на повторител или сървър за стая не е companion. Неуспешната връзка сама по себе си не означава, че трябва да препрограмирате.';

  @override
  String get setupWizard_settings =>
      'Този помощник не препрограмира фърмуера и не променя настройките на радиото. След свързване използвайте Настройки за регион, честота и разширени опции. Съгласувайте настройките с местната мрежа, преди да ги променяте.';

  @override
  String get setupWizard_openBluetooth => 'Отвори Bluetooth устройствата';

  @override
  String get setupWizard_openUsb => 'Отвори USB устройствата';

  @override
  String get setupWizard_change => 'Промяна на типа връзка';

  @override
  String get setupWizard_later => 'Настройка по-късно';

  @override
  String get setupWizard_bluetoothError =>
      'Неуспешно свързване с радиото. Дръжте го включено и наблизо, проверете разрешенията за Bluetooth и затворете другите свързани приложения. След това потърсете отново.';

  @override
  String get setupWizard_scanError =>
      'Неуспешно търсене на радиа. Включете Bluetooth и разрешете достъп до Bluetooth или устройства наблизо в системните настройки, след което потърсете отново.';

  @override
  String get setupWizard_usbError =>
      'Неуспешно свързване чрез USB. Проверете кабела за данни и избраното устройство, разрешете USB достъп и затворете другите серийни приложения. Свържете кабела отново и опитайте пак.';

  @override
  String get connections_title => 'Връзки';

  @override
  String get connections_radioTitle => 'Връзка с радиото';

  @override
  String get connections_bluetoothOffNotice =>
      'Bluetooth е изключен. Включете го, за да се свържете отново; приложението ще опита пак, когато се върне.';

  @override
  String get connections_transport => 'Вид връзка';

  @override
  String connections_lastError(String error) {
    return 'Последна грешка: $error';
  }

  @override
  String get connections_disconnectRadio => 'Прекъсни радиото';

  @override
  String connections_reconnectTo(String name) {
    return 'Свържи отново с $name';
  }

  @override
  String get connections_forgetRadio => 'Забрави радиото';

  @override
  String get connections_connectAnother => 'Свържи друго радио';

  @override
  String get connections_usbSerial => 'USB сериен';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'Устройство';

  @override
  String get connections_publicKey => 'Публичен ключ';

  @override
  String get connections_firmware => 'Фърмуер';

  @override
  String connections_firmwareProtocol(String code) {
    return 'протокол v$code';
  }

  @override
  String get connections_battery => 'Батерия';

  @override
  String get connections_lastRx => 'Последно приемане';

  @override
  String get connections_reconnectFailed =>
      'Неуспешно повторно свързване с радиото';

  @override
  String get connections_statusBluetoothOff => 'Bluetooth е изключен';

  @override
  String get connections_statusConnected => 'Свързано';

  @override
  String get connections_statusConnecting => 'Свързване…';

  @override
  String get connections_statusDisconnecting => 'Прекъсване…';

  @override
  String get connections_statusScanning => 'Търсене на радиа…';

  @override
  String get connections_statusReconnectingSoon =>
      'Повторно свързване след малко…';

  @override
  String get connections_statusNotConnected => 'Няма връзка';

  @override
  String get mqtt_cardTitle => 'MQTT връзка';

  @override
  String get mqtt_statusNotConfigured => 'Не е настроено';

  @override
  String get mqtt_statusDisconnected => 'Прекъснато';

  @override
  String get mqtt_statusConnecting => 'Свързване';

  @override
  String get mqtt_statusConnected => 'Свързано';

  @override
  String get mqtt_statusReconnecting => 'Повторно свързване';

  @override
  String get mqtt_statusError => 'Грешка при свързване';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'Брокер: $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn => 'Влиза с токен, подписан от радиото';

  @override
  String mqtt_tokenSignInAs(String username) {
    return 'Влиза с токен, подписан от радиото, като $username…';
  }

  @override
  String get mqtt_connectRadioToSignIn => 'Свържете радиото, за да влезете';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'Токенът се подновява в $time';
  }

  @override
  String mqtt_signedInAs(String username) {
    return 'Влязъл като $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return 'Слуша на $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'Пакети: $accepted нови, $duplicate дублирани, $invalid невалидни';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return 'Опит $attempt от $max';
  }

  @override
  String get mqtt_sharingWaitsForRadio => 'Споделянето чака връзка с радиото';

  @override
  String mqtt_sharingOn(String topic) {
    return 'Споделя на $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return 'Ще споделя на $topic';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'Онлайн статус на $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return 'Споделени $shared, задържани $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'Добавете брокер, за да свързвате трафика на MeshCore през интернет. Връзката с радиото работи независимо.';

  @override
  String get mqtt_disconnect => 'Прекъсни MQTT';

  @override
  String get mqtt_connect => 'Свържи MQTT';

  @override
  String get mqtt_packetFeed => 'Поток пакети';

  @override
  String get mqtt_setUpBroker => 'Настрой брокер';

  @override
  String get mqtt_brokerSettings => 'Настройки на брокера';

  @override
  String get mqtt_settingsTitle => 'Настройки на MQTT брокера';

  @override
  String get mqtt_presetLabel => 'Започни от шаблон';

  @override
  String get mqtt_presetCustom => 'Собствен брокер';

  @override
  String get mqtt_presetLocal => 'Локален брокер (въведете адрес)';

  @override
  String get mqtt_presetLetsMeshUs => 'Анализатор LetsMesh (САЩ, общност)';

  @override
  String get mqtt_presetLetsMeshEu => 'Анализатор LetsMesh (ЕС, общност)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh е анализатор на пакети за MeshCore, поддържан от общността; не е част от NOTORYX и не е одобрен от NOTORYX. Споделянето изисква свързано радио и остава изключено, докато не го включите.';

  @override
  String get mqtt_hostname => 'Име на хоста на брокера';

  @override
  String get mqtt_port => 'Порт';

  @override
  String get mqtt_useTls => 'Използвай TLS';

  @override
  String get mqtt_allowCleartext =>
      'Разреши некриптирана връзка с локален брокер';

  @override
  String get mqtt_allowCleartextHint =>
      'Само localhost, .local и частни хостове 10.x / 192.168.x.';

  @override
  String get mqtt_useWebSocket => 'Използвай WebSocket';

  @override
  String get mqtt_webSocketPath => 'Път за WebSocket';

  @override
  String get mqtt_topicPrefix => 'Префикс на темата';

  @override
  String get mqtt_region => 'Регион (по избор)';

  @override
  String get mqtt_regionHelp =>
      'Код на региона на наблюдателя, напр. PHL. Оставете празно за всички.';

  @override
  String get mqtt_deliverChannel =>
      'Добавяй съобщения от канали, получени чрез MQTT';

  @override
  String get mqtt_deliverChannelHint =>
      'Съобщенията във вашите канали, чути от наблюдатели, се появяват в чатовете. Не се изпращат през радиото ви.';

  @override
  String get mqtt_sharingTitle => 'Споделяне като наблюдател';

  @override
  String get mqtt_share => 'Споделяй пакетите, които радиото ми чува';

  @override
  String get mqtt_shareHint =>
      'Публикува обявяванията и трафика на каналите, които радиото приема, с неговия публичен ключ, силата на сигнала и региона. Съобщенията в каналите остават криптирани. Нужен е регион.';

  @override
  String get mqtt_shareDirect => 'Включи трафика на лични съобщения';

  @override
  String get mqtt_shareDirectHint =>
      'Заявки, отговори и лични съобщения. Съдържанието остава криптирано, но се вижда кои възли общуват помежду си.';

  @override
  String get mqtt_shareOwn => 'Включи моите собствени съобщения и обявявания';

  @override
  String get mqtt_signInTitle => 'Вход';

  @override
  String get mqtt_authPassword => 'Потребителско име и парола';

  @override
  String get mqtt_authToken => 'Токен, подписан от радиото';

  @override
  String get mqtt_tokenExplain =>
      'Радиото подписва със собствения си ключ токен за вход, валиден един час, а приложението го подновява преди изтичане. Ключът никога не напуска радиото. Потребителското име е v1_ и публичният ключ на радиото.';

  @override
  String get mqtt_radioReady => 'Радиото е свързано: готово за вход.';

  @override
  String get mqtt_radioNeeded =>
      'Свържете радиото, за да влезете. MQTT го чака.';

  @override
  String get mqtt_username => 'Потребителско име (по избор)';

  @override
  String get mqtt_password => 'Парола';

  @override
  String get mqtt_keepPassword =>
      'Оставете празно, за да запазите текущата парола.';

  @override
  String get mqtt_credentialsWeb =>
      'В браузъра данните за вход се пазят само докато страницата е отворена.';

  @override
  String get mqtt_credentialsKeychain =>
      'Данните за вход се пазят в системния ключодържател, никога в настройките на приложението или в логовете.';

  @override
  String get mqtt_saveSettings => 'Запази настройките';

  @override
  String get mqtt_feedTitle => 'Поток пакети от MQTT';

  @override
  String get mqtt_feedConnect =>
      'Свържете се с брокер, за да виждате пакети от наблюдатели.';

  @override
  String mqtt_feedWaiting(String topic) {
    return 'Изчакване на пакети на $topic';
  }

  @override
  String get mqtt_feedUnknownObserver => 'Непознат наблюдател';

  @override
  String mqtt_feedHeardBy(String observer) {
    return 'Чуто от $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return 'Скокове: $hops · байта: $bytes';
  }

  @override
  String get mqtt_packetRequest => 'Заявка';

  @override
  String get mqtt_packetResponse => 'Отговор';

  @override
  String get mqtt_packetDirectMessage => 'Лично съобщение';

  @override
  String get mqtt_packetAck => 'Потвърждение';

  @override
  String get mqtt_packetAdvert => 'Обявяване';

  @override
  String get mqtt_packetChannelMessage => 'Съобщение в канал';

  @override
  String get mqtt_packetChannelData => 'Данни на канал';

  @override
  String get mqtt_packetAnonymousRequest => 'Анонимна заявка';

  @override
  String get mqtt_packetPath => 'Маршрут';

  @override
  String get mqtt_packetTrace => 'Проследяване';

  @override
  String get mqtt_packetMultipart => 'Многочастен';

  @override
  String get mqtt_packetControl => 'Управление';

  @override
  String mqtt_packetType(int type) {
    return 'Тип $type';
  }

  @override
  String get mqtt_routeTransportFlood => 'Flood с транспорт';

  @override
  String get mqtt_routeFlood => 'Flood';

  @override
  String get mqtt_routeDirect => 'Директен';

  @override
  String get mqtt_routeTransportDirect => 'Директен с транспорт';

  @override
  String get mqtt_noticeInvalidHost =>
      'Въведете име на хост или IPv4 адрес без схема и порт.';

  @override
  String get mqtt_noticeInvalidPort => 'Портът трябва да е между 1 и 65535.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'Пътят за WebSocket трябва да започва с / и да не съдържа заявка или фрагмент.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'Префиксът на темата трябва да е непразен MQTT път без заместващи символи.';

  @override
  String get mqtt_noticeInvalidRegion =>
      'Регионът трябва да е от 2 до 8 букви или цифри, напр. PHL.';

  @override
  String get mqtt_noticeTlsRequired =>
      'TLS е задължителен, освен ако несигурният достъп до локален брокер е изрично разрешен.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      'Некриптиран MQTT е позволен само за изрично одобрени локални хостове.';

  @override
  String get mqtt_noticeRegionNeededToShare =>
      'Задайте регион, за да споделяте пакети като наблюдател.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return 'Въведете паролата за $username.';
  }

  @override
  String get mqtt_noticeNoNetwork =>
      'Няма мрежа. MQTT ще се свърже отново, когато тя се върне.';

  @override
  String get mqtt_noticeSubscriptionRefused =>
      'Брокерът отказа абонамента за пакети.';

  @override
  String get mqtt_noticeBadCredentials =>
      'Брокерът отхвърли потребителското име или паролата.';

  @override
  String get mqtt_noticeNotAuthorized => 'Този акаунт няма права на брокера.';

  @override
  String get mqtt_noticeConnectionRefused => 'Брокерът отказа връзката.';

  @override
  String get mqtt_noticeUnreachable => 'Брокерът е недостъпен.';

  @override
  String get mqtt_noticeTlsFailed =>
      'Неуспешно установяване на защитена (TLS) връзка.';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'Тази платформа поддържа MQTT само през WebSocket.';

  @override
  String get mqtt_noticeRadioNotConnected =>
      'Свържете радиото, за да влезете с неговия ключ.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'Фърмуерът на това радио не поддържа подписване с неговия ключ.';

  @override
  String get mqtt_noticeSigningTimeout =>
      'Радиото не отговори на заявката за подпис. Възможно е фърмуерът му да не поддържа подписване.';

  @override
  String get mqtt_noticeSigningTooLong =>
      'Данните са твърде дълги, за да ги подпише радиото.';

  @override
  String get mqtt_noticeSigningRejected => 'Радиото отказа да подпише данните.';

  @override
  String get scanner_signalStrong => 'Силен';

  @override
  String get scanner_signalGood => 'Добър';

  @override
  String get scanner_signalFair => 'Среден';

  @override
  String get scanner_signalWeak => 'Слаб';

  @override
  String get scanner_nearbyRadios => 'Радиа наблизо';

  @override
  String get scanner_lastRadio => 'Последно радио';

  @override
  String get scanner_reconnect => 'Свържи отново';

  @override
  String get scanner_tcpHint => 'Радио с Wi‑Fi фърмуер във вашата мрежа.';

  @override
  String get scanner_otherWays => 'Други начини за свързване';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count радиа наблизо',
      one: '1 радио наблизо',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => 'Търсене на радиа…';

  @override
  String get scanner_findTitle => 'Намерете радиото си';

  @override
  String get scanner_heroHint =>
      'Включете радиото и го дръжте на няколко метра. Нужен е фърмуер MeshCore companion.';

  @override
  String get scanner_tipsTitle => 'Не виждате радиото си?';

  @override
  String get scanner_tipPower => 'Проверете дали е включено и активно.';

  @override
  String get scanner_tipFirmware =>
      'Нужен е фърмуер MeshCore companion. Ретранслаторите и стайните сървъри не се показват тук.';

  @override
  String get scanner_tipOtherDevice =>
      'Радиото се свързва само с едно устройство наведнъж. Изключете го от други телефони или компютри.';

  @override
  String get connections_internetBridge => 'Интернет мост';

  @override
  String get connections_noRadio => 'Няма радио';

  @override
  String get connections_radioSettings => 'Настройки на радиото';

  @override
  String get connections_viewDashboard => 'Преглед на връзките';

  @override
  String get channelDirectory_title => 'Каталог на канали';

  @override
  String get channelDirectory_subtitle =>
      'Намерете публични хаштаг канали наблизо';

  @override
  String get channelDirectory_search => 'Търсене на канали или места';

  @override
  String get channelDirectory_nearYou => 'Наблизо';

  @override
  String get channelDirectory_all => 'Всички канали';

  @override
  String get channelDirectory_catAll => 'Всички';

  @override
  String get channelDirectory_catEmergency => 'Спешни';

  @override
  String get channelDirectory_catLocal => 'Местни';

  @override
  String get channelDirectory_catGeneral => 'Общи';

  @override
  String get channelDirectory_catInterest => 'Интереси';

  @override
  String get channelDirectory_catTest => 'Тестови';

  @override
  String get channelDirectory_join => 'Присъедини се';

  @override
  String get channelDirectory_joined => 'Присъединен';

  @override
  String get channelDirectory_noMatches =>
      'Няма канали, отговарящи на търсенето.';

  @override
  String get channelDirectory_connectFirst =>
      'Свържете радиото си, за да се присъединявате към канали.';

  @override
  String get channelDirectory_slotsFull =>
      'Всички слотове за канали на радиото са заети. Първо премахнете канал.';

  @override
  String get channelDirectory_joinFailed =>
      'Каналът не можа да бъде добавен. Опитайте отново.';

  @override
  String get channelDirectory_addHint =>
      'Липсва канал? Всеки може да предложи такъв, като редактира общия списък в GitHub.';

  @override
  String get prefixTool_title => 'ID на ретранслатори';

  @override
  String get prefixTool_subtitle =>
      'Кой използва ID, кои ID съвпадат и свободни ID за нов ретранслатор';

  @override
  String get prefixTool_width => 'Размер на ID в маршрута';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes байт';
  }

  @override
  String get prefixTool_includeCompanions =>
      'Включи companion устройства и сензори';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return 'Известни възли: $nodes · заети ID: $used · общи: $shared';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return 'Свободни ID: $free от $space';
  }

  @override
  String get prefixTool_lookupHint => 'Търсене на ID, напр. 3D';

  @override
  String prefixTool_lookupFree(String id) {
    return 'Нито един известен възел не използва $id.';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count възела използват $id',
      one: '1 възел използва $id',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => 'Общи ID';

  @override
  String get prefixTool_sharedHint =>
      'Маршрутите през тези ID изглеждат еднакво, освен ако мрежата не използва по-дълги ID.';

  @override
  String get prefixTool_noShared => 'Няма общи ID сред известните възли.';

  @override
  String get prefixTool_free => 'Свободни ID';

  @override
  String get prefixTool_shuffle => 'Още предложения';

  @override
  String get prefixTool_makeKey => 'Създай ключ';

  @override
  String get prefixTool_onlyKnown =>
      'Само по възлите, чути от радиото. Свободен тук ID може да е на ретранслатор, който не сте чули.';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id вече се използва от $name.';
  }

  @override
  String get prefixTool_pickFree => 'Избери свободен ID';

  @override
  String keyGen_title(String id) {
    return 'Ключ за ID $id';
  }

  @override
  String keyGen_searching(int tries) {
    return 'Търсене… изпробвани ключове: $tries';
  }

  @override
  String get keyGen_publicKey => 'Публичен ключ';

  @override
  String get keyGen_privateKey => 'Частен ключ';

  @override
  String get keyGen_copy => 'Копирай';

  @override
  String get keyGen_copied => 'Копирано';

  @override
  String get keyGen_secretWarning =>
      'Пазете частния ключ в тайна. Който го има, може да се представя за този възел.';

  @override
  String get keyGen_howToUse =>
      'За ретранслатор: отворете настройките му, поставете го като частен ключ и запазете. Companion радиата изискват фърмуер, който позволява импорт на ключ.';

  @override
  String get keyGen_tryAgain => 'Създай друг';

  @override
  String get regionSetup_title => 'Настройка на региони';

  @override
  String get regionSetup_hubSubtitle =>
      'Поставете ретранслатора в дървото от региони на района';

  @override
  String get regionSetup_intro =>
      'Регионите задържат съобщение в даден район, вместо да заливат цялата мрежа. Ретранслаторът препраща съобщения на регион само ако носи този регион, затова му дайте собствения регион и всички над него.';

  @override
  String get regionSetup_where => 'Къде е ретранслаторът?';

  @override
  String get regionSetup_tree => 'Дърво от региони';

  @override
  String get regionSetup_custom => 'Собствено';

  @override
  String get regionSetup_region => 'Най-местен регион';

  @override
  String get regionSetup_customLabel => 'Региони, от най-широкия';

  @override
  String regionSetup_invalidName(String name) {
    return '„$name“ не е валидно име на регион. Използвайте малки латински букви, цифри и тирета, до 29 знака.';
  }

  @override
  String regionSetup_tooMany(int max) {
    return 'Ретранслаторът може да носи най-много $max региона.';
  }

  @override
  String get regionSetup_options => 'Опции';

  @override
  String get regionSetup_setDefault =>
      'Най-местният регион да е по подразбиране';

  @override
  String get regionSetup_setDefaultBody =>
      'Собствените обявления на ретранслатора остават в този регион.';

  @override
  String get regionSetup_legacy => 'Фърмуер 1.14';

  @override
  String get regionSetup_legacyBody =>
      'Добавя region allowf след всеки регион. Не е нужно от 1.15.';

  @override
  String get regionSetup_denyUnscoped =>
      'Без препращане на съобщения без регион';

  @override
  String get regionSetup_denyUnscopedBody =>
      'Включете само когато целият район използва региони, иначе съобщенията от по-стари приложения няма да минат.';

  @override
  String get regionSetup_commands => 'Команди';

  @override
  String get regionSetup_copyAll => 'Копирай всички';

  @override
  String get regionSetup_copied => 'Копирано';

  @override
  String get regionSetup_pickFirst =>
      'Изберете регион, за да видите командите.';

  @override
  String regionSetup_sendTo(String name) {
    return 'Изпрати до $name';
  }

  @override
  String get regionSetup_howToSend =>
      'За да ги изпратите, влезте в ретранслатора и отворете „Настройка на региони“ от менюто му, или ги поставете в командния му ред.';

  @override
  String get regionSetup_noReply => 'Няма отговор. Спряно тук.';

  @override
  String get regionSetup_addToMine => 'Добави тези региони към списъка ми';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count региона са добавени към списъка',
      one: '1 регион е добавен към списъка',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => 'Дневник на маршрута';

  @override
  String get trackLog_subtitle => 'Записвайте следа по GPS на радиото';

  @override
  String get trackLog_recording => 'Записва се';

  @override
  String get trackLog_notRecording => 'Не се записва';

  @override
  String get trackLog_noGps =>
      'Радиото не подава GPS позиция. Дневникът на маршрута изисква радио с включен GPS.';

  @override
  String get trackLog_start => 'Започни запис';

  @override
  String get trackLog_stop => 'Спри записа';

  @override
  String get trackLog_howItWorks =>
      'Използва позицията, която радиото подава приблизително веднъж в минута, докато NOTORYX Core е отворено. Точка се добавя след преместване с 25 м или на всеки 15 минути на място.';

  @override
  String get trackLog_snap => 'Закръгляй позициите до около 100 м';

  @override
  String get trackLog_snapBody => 'За поверителност, когато споделяте маршрут.';

  @override
  String get trackLog_saved => 'Запазени маршрути';

  @override
  String get trackLog_none => 'Още няма маршрути.';

  @override
  String get trackLog_export => 'Експорт като GPX';

  @override
  String get trackLog_exportFailed => 'Маршрутът не можа да бъде експортиран.';

  @override
  String get trackLog_deleteTitle => 'Да се изтрие ли маршрутът?';

  @override
  String get trackLog_deleteBody =>
      'Ще бъде премахнат от това устройство. Експортираните GPX файлове не се засягат.';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km км · $duration · $points точки';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'Маршрут NOTORYX $when';
  }

  @override
  String get routes_nearbyTitle => 'Най-добри ретранслатори наблизо';

  @override
  String get routes_nearbyEmptyTitle => 'Още не са чути ретранслатори';

  @override
  String get routes_nearbyEmpty =>
      'Ретранслаторите, които радиото чува директно, се появяват тук, най-силните първи, докато приема трафик. Списъкът обхваща последния час.';

  @override
  String get routes_unknownRepeater => 'Неизвестен ретранслатор';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'чут $count пъти',
      one: 'чут веднъж',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'преди $minutes мин',
      one: 'преди 1 мин',
      zero: 'току-що',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return 'през $names';
  }

  @override
  String get nav_home => 'Начало';

  @override
  String get nav_chats => 'Чатове';

  @override
  String get nav_tools => 'Инструменти';

  @override
  String get nav_settings => 'Настройки';

  @override
  String get nav_more => 'Още';

  @override
  String get tools_groupApp => 'Приложение и настройки';

  @override
  String get tools_groupField => 'На терен';

  @override
  String get tools_groupMaps => 'Карти и покритие';

  @override
  String get tools_groupRouting => 'Маршрути и ретранслатори';

  @override
  String get tools_pathGraph => 'Граф на пътищата';

  @override
  String get tools_pathGraphHint =>
      'Как стигат съобщенията до вас: всеки чут път и най-натоварените ретранслатори';

  @override
  String get tools_antenna => 'Покритие на антената';

  @override
  String get tools_antennaHint => 'Оценете докъде достига антена над терена';

  @override
  String routes_repeaterWithId(String id) {
    return 'Ретранслатор $id';
  }

  @override
  String get coverageHex_title => 'Шестоъгълници на покритието';

  @override
  String get coverageHex_toolSubtitle =>
      'Картографирайте къде радиото чува мрежата и го споделете';

  @override
  String get coverageHex_mapCoverage => 'Картографиране на покритието';

  @override
  String get coverageHex_statusOff =>
      'Изключено. Включете, докато карате или вървите, за да картографирате къде радиото чува мрежата.';

  @override
  String get coverageHex_waitingGps => 'Изчакване на GPS…';

  @override
  String coverageHex_gpsTooRough(String meters) {
    return 'Точност на GPS $meters м: твърде груба, не се записва.';
  }

  @override
  String coverageHex_recording(String meters) {
    return 'Записва се. Точност на GPS $meters м.';
  }

  @override
  String get coverageHex_hexagons => 'Шестоъгълници';

  @override
  String get coverageHex_samples => 'Проби';

  @override
  String get coverageHex_privacyNote =>
      'Използва GPS на телефона, докато този превключвател е включен. Споделят се само ID на шестоъгълници (около 0,9 км), никога точното ви местоположение.';

  @override
  String get coverageHex_uploadSection => 'Качване в карти на покритието';

  @override
  String get coverageHex_wifiOnly => 'Качване само през Wi-Fi';

  @override
  String get coverageHex_wifiOnlyHint =>
      'Пробите чакат на телефона (до 7 дни) до Wi-Fi.';

  @override
  String coverageHex_waiting(String count) {
    return '$count чакат';
  }

  @override
  String get coverageHex_addMap => 'Добавяне на карта на покритието';

  @override
  String get coverageHex_addMapHint =>
      'Всеки HTTPS адрес, който приема качване на покритие.';

  @override
  String get coverageHex_uploadNow => 'Качване сега';

  @override
  String get coverageHex_mapDialogTitle => 'Карта на покритието';

  @override
  String get coverageHex_nameMissing => 'Дайте ѝ име.';

  @override
  String get coverageHex_url => 'URL за качване';

  @override
  String get coverageHex_urlInvalid => 'Трябва да е https:// URL.';

  @override
  String get coverageHex_apiKey => 'API ключ (по избор)';

  @override
  String get coverageHex_apiKeyHint => 'Изпраща се като X-API-Key.';

  @override
  String get coverageHex_format => 'Формат';

  @override
  String get coverageHex_formatHex => 'ID на шестоъгълници (NOTORYX)';

  @override
  String get coverageHex_formatMeshMapper => 'Съвместим с MeshMapper';

  @override
  String get coverageHex_privacy => 'Поверителност';

  @override
  String get coverageHex_privacyLive => 'На живо';

  @override
  String get coverageHex_privacyDelayed => 'Със закъснение 3 ч';

  @override
  String get coverageHex_privacyAnonymous => 'Анонимно, 24 ч';

  @override
  String get coverageHex_privacyLiveHint => 'Изпраща се до около 15 минути.';

  @override
  String get coverageHex_privacyDelayedHint =>
      'Задържа се 3 часа, за да не показва картата къде сте сега.';

  @override
  String get coverageHex_privacyAnonymousHint =>
      'Задържа се 24 часа, само с дата и без подпис, за да не могат да се свържат качванията.';

  @override
  String get coverageHex_uploadsOn => 'Качването е включено';

  @override
  String coverageHex_sent(String count, String time) {
    return 'Изпратени $count клетки в $time.';
  }

  @override
  String coverageHex_httpError(String code) {
    return 'Картата отговори с $code; ще се опита отново.';
  }

  @override
  String get coverageHex_unreachable =>
      'Картата е недостъпна; ще се опита отново.';

  @override
  String get coverageHex_noPermission =>
      'Разрешението за местоположение не е дадено.';

  @override
  String get coverageHex_noGps => 'GPS не е наличен.';

  @override
  String get coverageHex_loadFailed =>
      'Запазеното покритие не може да се прочете; започва се отначало.';

  @override
  String get mqttExtra_wifiOnly => 'Свързване само през Wi-Fi';

  @override
  String mqttExtra_backlog(String count) {
    return '$count пакета чакат качване (пазят се до 72 часа).';
  }

  @override
  String get mqttExtra_add => 'Добавяне на друг брокер';

  @override
  String get mqttExtra_addBody =>
      'Споделя чутото от радиото с още един MQTT брокер освен основния. Само качва; никога не връща пакети в приложението.';

  @override
  String get mqttExtra_separateKey => 'Отделен ключ';

  @override
  String get mqttExtra_separateKeyHint =>
      'Влиза с ключ, създаден на този телефон вместо на радиото, така брокерът не може да свърже качванията с радиото ви.';

  @override
  String mqttExtra_removeTitle(String name) {
    return 'Премахване на $name?';
  }

  @override
  String get mqttExtra_removeBody =>
      'Прекъсва и забравя настройките, паролата, ключа и всички пакети, чакащи качване.';

  @override
  String mqttExtra_ownKey(String key) {
    return 'Влиза със собствен ключ: $key…';
  }

  @override
  String get botWx_title => 'Публикуване на метеопредупреждения в канал';

  @override
  String get botWx_body =>
      'Проверява Националната метеорологична служба на САЩ на всеки 10 минути за сериозни и екстремни предупреждения на GPS позицията на радиото (закръглена до около 1 км) и публикува всяко ново веднъж. Нужен е интернет на телефона.';

  @override
  String get botWx_channel => 'Публикуване в канал';

  @override
  String get botWx_moderate => 'Включване на умерени предупреждения';

  @override
  String get botWx_moderateHint =>
      'Съвети, както и предупреждения. По-натоварено.';

  @override
  String botWx_lastChecked(String time) {
    return 'Последна проверка $time.';
  }

  @override
  String get botWx_noPosition => 'Радиото още не е съобщило GPS позиция.';

  @override
  String get botWx_noChannel => 'Изберете канал за предупрежденията.';

  @override
  String get botWx_channelGone => 'Избраният канал вече не съществува.';

  @override
  String botWx_httpError(String code) {
    return 'Метеослужбата отговори с $code.';
  }

  @override
  String get botWx_unreachable => 'Метеослужбата е недостъпна.';

  @override
  String get botCmd_sun => 'Изгрев и залез на GPS позицията на радиото.';

  @override
  String get botCmd_moon => 'Фаза на Луната и колко е осветена.';

  @override
  String get botCmd_weather =>
      'Текущо време при радиото (Open-Meteo). Изпраща позицията, закръглена до около 1 км.';

  @override
  String get botCmd_dice => 'Хвърля зарове: !dice, !dice 20 или !dice 2d6.';

  @override
  String get botCmd_trace =>
      'Изброява ретранслаторите, през които е минало съобщението.';

  @override
  String get ping_title => 'Пинг на ретранслатор';

  @override
  String get ping_toolSubtitle =>
      'Време за отиване и връщане и сигнал в двете посоки до близък ретранслатор';

  @override
  String get ping_noRepeaters => 'Още няма известни ретранслатори';

  @override
  String get ping_choose => 'Изберете ретранслатор';

  @override
  String get ping_avgMs => 'мс отиване и връщане';

  @override
  String get ping_snrThere => 'SNR там';

  @override
  String get ping_snrBack => 'SNR обратно';

  @override
  String get ping_loss => 'Загубени';

  @override
  String ping_running(int done, int total) {
    return 'Пинг $done от $total…';
  }

  @override
  String ping_start(int count) {
    return 'Пинг $count пъти';
  }

  @override
  String get ping_results => 'Проби';

  @override
  String get ping_noReply => 'Няма отговор';

  @override
  String ping_resultLine(String ms, String snr) {
    return '$ms мс · SNR там $snr';
  }

  @override
  String get ping_explainer =>
      'Всяка проба е проследяване на път с един скок: ретранслаторът отбелязва колко добре ви е чул и го връща. Работи с ретранслатори, които радиото ви чува директно.';

  @override
  String get hunt_title => 'Търсене с антена';

  @override
  String get hunt_toolSubtitle =>
      'Голям жив измервател на сигнала, който щрака по-бързо при по-силен сигнал';

  @override
  String get hunt_noSignal => 'Още няма сигнал';

  @override
  String get hunt_noReply => 'Няма отговор — преместете или завъртете антената';

  @override
  String get hunt_heardHere => 'dB чути тук';

  @override
  String get hunt_best => 'Най-добър';

  @override
  String get hunt_sound => 'Щракане при по-силен сигнал';

  @override
  String get hunt_soundHint =>
      'С вибрация при всяко щракане, за да насочвате, без да гледате.';

  @override
  String get hunt_stop => 'Стоп';

  @override
  String get hunt_start => 'Начало на търсенето';

  @override
  String get hunt_explainer =>
      'Проверява ретранслатора около веднъж в секунда. Насочете насочена антена или се разходете: числото показва колко добре радиото го чува.';

  @override
  String get settings_refreshRate => 'Честота на опресняване';

  @override
  String get settings_refreshFast => 'Бързо';

  @override
  String get settings_refreshNormal => 'Нормално';

  @override
  String get settings_refreshSlow => 'Бавно';

  @override
  String get settings_refreshFastHint =>
      'Батерия всяка минута, GPS на 30 с. По-свежи данни, повече разход.';

  @override
  String get settings_refreshNormalHint =>
      'Батерия на 2 минути, GPS всяка минута.';

  @override
  String get settings_refreshSlowHint =>
      'Батерия на 6 минути, GPS на 3 минути. Пести батерия.';

  @override
  String get settings_refreshSaverOn =>
      'Пестенето на батерия е включено и то определя темпото (батерия на 10 минути).';

  @override
  String get reach_check => 'Проверка на обхвата при наблюдатели';

  @override
  String get reach_title => 'Обхват при наблюдатели';

  @override
  String get reach_noHash =>
      'Това съобщение още не може да се провери: никой ретранслатор не го е върнал към радиото ви, затова ID на пакета не е известен.';

  @override
  String get reach_unreachable =>
      'Анализаторът е недостъпен. Проверете интернет връзката или адреса на анализатора в Настройки.';

  @override
  String get reach_none =>
      'Още никой наблюдател не го е чул. Наблюдателите качват малко след като чуят пакет, проверете пак след минута.';

  @override
  String get reach_observers => 'наблюдатели';

  @override
  String get reach_maxHops => 'макс. скокове';

  @override
  String get reach_bestSnr => 'най-добър SNR';

  @override
  String reach_hops(int count) {
    return 'на $count скока';
  }

  @override
  String get reach_explainer =>
      'От онлайн анализатора: наблюдатели, чули и качили този пакет.';

  @override
  String get reach_checkAgain => 'Нова проверка';

  @override
  String get analyzer_title => 'Онлайн анализатор';

  @override
  String get analyzer_url => 'Адрес на анализатора';

  @override
  String get analyzer_urlHint =>
      'Анализатор CoreScope (https://). Използвайте този за вашия регион.';

  @override
  String get analyzer_reset => 'По подразбиране';

  @override
  String get analyzer_hint =>
      'Използва се за проверка кои наблюдатели са чули съобщенията ви. Проверката изпраща само ID на пакета.';

  @override
  String get analyzer_hopLookup => 'Имена на непознати ретранслатори онлайн';

  @override
  String get analyzer_hopLookupHint =>
      'Когато ID на ретранслатор не е в контактите ви, анализаторът се пита за името му. Изпраща само кратките ID. Име с „?“ означава, че няколко ретранслатора споделят ID.';

  @override
  String discovered_tray(int count) {
    return 'Канали, чути наблизо: $count';
  }

  @override
  String get discovered_title => 'Чути наблизо, неприсъединени';

  @override
  String discovered_heard(int count, String time) {
    return 'Чут $count× · последно $time';
  }

  @override
  String get discovered_ignore => 'Пренебрегване';

  @override
  String get discovered_ignoreAll => 'Пренебрегване на всички';

  @override
  String get discovered_joinAll => 'Присъединяване към всички';

  @override
  String get discovered_explainer =>
      'Това са публични канали от указателя, по които радиото ви е чуло трафик. Всеки е потвърден чрез дешифриране на съобщение с ключа му. Пренебрегнатите остават скрити.';

  @override
  String get mqtt_presetMeshRank => 'MeshRank (общност)';

  @override
  String get mqtt_presetMeshRankNote =>
      'MeshRank е класация на мрежи MeshCore от общността, не е част от NOTORYX и не е одобрена от него. Без вход: пакетите се споделят с ключа и регионалния код на радиото, само след като включите споделянето.';

  @override
  String get pathFilter_title => 'Филтър по ширина на пътя';

  @override
  String get pathFilter_firmwareNote =>
      'Изисква фърмуер на ретранслатора с правила за препращане (mikecarper/MeshCore). Официалният фърмуер MeshCore отхвърля тези команди.';

  @override
  String get pathFilter_width => 'Ширина на пътя';

  @override
  String get pathFilter_anyWidth => 'Всяка ширина';

  @override
  String pathFilter_bytes(int n) {
    return 'Пътища от $n байта';
  }

  @override
  String get pathFilter_twoOrMore => '2 или 3 байта (2+)';

  @override
  String get pathFilter_path => 'Прилага се за';

  @override
  String get pathFilter_radio => 'Радио заливания';

  @override
  String get pathFilter_bridge => 'Мост';

  @override
  String get pathFilter_cross => 'Кросоувър';

  @override
  String get pathFilter_bridgeCross => 'Мост и кросоувър';

  @override
  String get pathFilter_limit => 'Ограничаване вместо отхвърляне';

  @override
  String get pathFilter_limitOn => 'Препраща до зададен брой на минута.';

  @override
  String get pathFilter_drop =>
      'Съвпадащите заливания се отхвърлят, не се препращат.';

  @override
  String get pathFilter_perMinute => 'На минута';

  @override
  String get pathFilter_rateInvalid => 'Въведете от 1 до 65534.';

  @override
  String get pathFilter_reviewNote =>
      'Това само попълва командния ред. Проверете го и натиснете Изпращане. Първо използвайте „get fr“, за да видите правилата.';

  @override
  String get pathFilter_useCommand => 'Използване на командата';

  @override
  String get settings_linkPreviews => 'Визуализация на връзки';

  @override
  String get settings_linkPreviewsHint =>
      'Показва заглавието на връзка в съобщение. Изключено по подразбиране: зареждането на страницата разкрива IP адреса ви пред сайта.';

  @override
  String get guide_title => 'Полево ръководство';

  @override
  String get guide_subtitle =>
      'Основи, батерии в студ, слънчева енергия и антени';

  @override
  String get guide_secMesh => 'Влизане в мрежата';

  @override
  String get guide_mesh1 =>
      'Телефонът говори с радиото през Bluetooth, USB или Wi-Fi; радиото говори с мрежата през LoRa. Съобщенията работят и без мобилен сигнал.';

  @override
  String get guide_mesh2 =>
      'Ретранслаторите предават съобщенията; всяко препредаване е скок. По-малко скокове означава по-бърза и надеждна доставка.';

  @override
  String get guide_mesh3 =>
      'Пишете кратко и не заливайте натоварени канали: всяко съобщение използва общо ефирно време.';

  @override
  String get guide_secCold => 'Батерии в студа';

  @override
  String get guide_cold1 =>
      'Не зареждайте литиеви батерии под нулата (0 °C): това ги поврежда трайно.';

  @override
  String get guide_cold2 =>
      'Носете радиото под якето. Студът намалява капацитета, но той се връща, щом батерията се затопли.';

  @override
  String get guide_cold3 =>
      'За постоянни места в студен климат LiFePO4 се справя по-добре от литиево-йонните; отоплена или изолирана кутия помага и на двете.';

  @override
  String get guide_secSolar => 'Слънчева енергия за ретранслатори';

  @override
  String get guide_solar1 =>
      'Ретранслаторът ползва много малко енергия, но оразмерете панела и батерията за най-тъмната зимна седмица, а не за летен ден.';

  @override
  String get guide_solar2 =>
      'Насочете панела към екватора и го наклонете стръмно през зимата; пазете го от сняг и сянка.';

  @override
  String get guide_secAntenna => 'Антени и разположение';

  @override
  String get guide_ant1 =>
      'Височината е по-важна от мощността: радио на няколко метра височина стига много по-далеч от такова на бюро.';

  @override
  String get guide_ant2 =>
      'Дръжте антената вертикално и далеч от метал и използвайте антена за вашата честота (напр. 868 MHz в Европа).';

  @override
  String get guide_secMore => 'Научете повече';

  @override
  String get guide_moreMeshcore => 'Официалният проект MeshCore';

  @override
  String get guide_moreCascadia =>
      'Ръководства от общността: начало, картографиране, региони, слънце';

  @override
  String get post_signed => 'Подписано';

  @override
  String get post_unverified => 'Непотвърдено';

  @override
  String post_signedKnown(String name) {
    return 'Подписано от $name, един от контактите ви.';
  }

  @override
  String get post_signedUnknownKey =>
      'Подписано, но не от ваш контакт. Добавете подателя като контакт, за да видите кой е.';

  @override
  String get post_unverifiedHint =>
      'С публикацията дойде подпис, но той не съвпада. Тя може да е променена по пътя или да не е от посочения подател.';

  @override
  String get settings_signPosts =>
      'Подписване на всички мои публикации в канали';

  @override
  String get settings_signPostsHint =>
      'SOS в канал винаги се подписва. Това подписва всяка публикация, за да виждат другите потребители на NOTORYX, че наистина сте вие. Всеки подпис е един допълнителен пакет в ефира.';

  @override
  String get tools_search => 'Търсене на инструменти и настройки';

  @override
  String get tools_noMatches => 'Няма инструменти, отговарящи на търсенето.';

  @override
  String get tools_bot => 'Режим бот';

  @override
  String get tools_botHint =>
      'Автоматични отговори, !команди и метео предупреждения в каналите';

  @override
  String get botChannels_title => 'Канали';

  @override
  String get botChannels_hint =>
      'Ботът отговаря и на !команди във включените канали, в същия канал. Там никога не изпраща отговор „отсъствам“.';

  @override
  String get botChannels_none => 'Все още няма канали на това радио.';

  @override
  String get advert_zeroHopHint =>
      'Само радиата, които ви чуват директно. Ретранслаторите не го предават.';

  @override
  String get advert_floodHint =>
      'Ретранслаторите го разпространяват в цялата мрежа. Използва повече ефирно време.';

  @override
  String get mySensors_title => 'Сензори';

  @override
  String get mySensors_refresh => 'Прочети сензорите';

  @override
  String get mySensors_reading => 'Четене на сензорите на радиото…';

  @override
  String get mySensors_failed =>
      'Радиото не отговори. Докоснете обновяване, за да опитате отново.';

  @override
  String get mySensors_none => 'Няма данни от сензорите на радиото.';
}
