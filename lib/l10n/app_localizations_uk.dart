// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core';

  @override
  String get nav_contacts => 'Контакти';

  @override
  String get nav_channels => 'Канали';

  @override
  String get nav_map => 'Карта';

  @override
  String get nav_messages => 'Повідомлення';

  @override
  String get nav_nodes => 'Вузли';

  @override
  String get nav_radio => 'Радіо';

  @override
  String get messages_title => 'Повідомлення';

  @override
  String get messages_filterAll => 'Усі';

  @override
  String get messages_filterDirect => 'Особисті';

  @override
  String get messages_filterChannels => 'Канали';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'Пошук повідомлень';

  @override
  String get messages_searchHint => 'Пошук розмов';

  @override
  String get messages_closeSearch => 'Закрити пошук';

  @override
  String get messages_manageChannels => 'Керувати каналами';

  @override
  String get messages_new => 'Нове';

  @override
  String get messages_newDirect => 'Написати вузлу';

  @override
  String get messages_newChannel => 'Додати канал або приєднатися';

  @override
  String get messages_empty => 'Поки що немає розмов';

  @override
  String get messages_emptyHint =>
      'Тут з\'являються повідомлення від вузлів і каналів.';

  @override
  String get messages_noMatches => 'Немає розмов за вашим запитом';

  @override
  String messages_you(String text) {
    return 'Ви: $text';
  }

  @override
  String get messages_yesterday => 'Учора';

  @override
  String messages_unreadCount(int count) {
    return 'Непрочитаних: $count';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return 'Підключено через $transport';
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
  String get radioStatus_openRadio => 'Відкрити відомості про радіо';

  @override
  String get radioOverview_battery => 'Батарея';

  @override
  String radioOverview_firmware(String version) {
    return 'Прошивка $version';
  }

  @override
  String get radioOverview_sendAdvert => 'Надіслати оголошення';

  @override
  String get radioOverview_stats => 'Статистика радіо';

  @override
  String get accessControl_title => 'Керування доступом';

  @override
  String get accessControl_hubSubtitle => 'Хто може входити без пароля';

  @override
  String get accessControl_explainRepeater =>
      'Люди з цього списку входять без пароля. Адміністратори можуть змінювати налаштування; «Лише читання» та «Читання й запис» також отримують повну телеметрію.';

  @override
  String get accessControl_explainRoom =>
      'Адміністратори з цього списку входять без пароля й можуть керувати кімнатою. Учасники кімнати входять за паролем кімнати.';

  @override
  String get accessControl_roleReadOnly => 'Лише читання';

  @override
  String get accessControl_roleReadWrite => 'Читання й запис';

  @override
  String get accessControl_roleAdmin => 'Адміністратор';

  @override
  String get accessControl_you => 'Ви';

  @override
  String get accessControl_unknownNode => 'Невідомий вузол';

  @override
  String get accessControl_add => 'Додати';

  @override
  String get accessControl_addTitle => 'Додати до списку доступу';

  @override
  String get accessControl_pickContact => 'Виберіть контакт';

  @override
  String get accessControl_noContacts =>
      'Немає контактів для додавання. Вузли з\'являються тут після того, як ви отримаєте їхнє оголошення.';

  @override
  String get accessControl_changeRole => 'Змінити роль';

  @override
  String get accessControl_remove => 'Прибрати доступ';

  @override
  String accessControl_removeConfirm(String name) {
    return 'Прибрати $name зі списку доступу? Для входу знадобиться пароль.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'Це ви. Якщо ви приберете себе, для керування вузлом знадобиться пароль адміністратора.';

  @override
  String get accessControl_unknownKeyNote =>
      'Немає у ваших контактах. Для зміни ролі потрібна новіша прошивка вузла; видалення працює завжди.';

  @override
  String get accessControl_prefixUnsupported =>
      'Прошивка цього вузла не може змінити роль того, кого немає у ваших контактах. Видалити його все одно можна.';

  @override
  String get accessControl_empty => 'Список доступу порожній';

  @override
  String get accessControl_emptyHint =>
      'Додайте людей, щоб вони могли входити без пароля.';

  @override
  String get accessControl_loading => 'Запитуємо список доступу у вузла…';

  @override
  String get accessControl_timeout =>
      'Вузол не відповів. Перевірте маршрут і спробуйте ще раз.';

  @override
  String get accessControl_maybeIncomplete =>
      'Вузол надіслав одну повну сторінку, а його прошивка не може надіслати більше, тож деяких записів може бракувати.';

  @override
  String get accessControl_saved => 'Список доступу оновлено';

  @override
  String accessControl_failed(String reply) {
    return 'Вузол відхилив зміну: $reply';
  }

  @override
  String get companionCli_title => 'Командний рядок';

  @override
  String get companionCli_tileSubtitle => 'Виконувати команди на радіо';

  @override
  String get companionCli_warning =>
      'Команди виконуються на підключеному радіо й можуть змінити його налаштування або перезавантажити його.';

  @override
  String get companionCli_hint => 'Введіть команду, наприклад ver';

  @override
  String get companionCli_send => 'Виконати команду';

  @override
  String get companionCli_noReply =>
      'Немає відповіді. Можливо, радіо перезавантажується.';

  @override
  String get companionCli_empty =>
      'Спробуйте одну з команд вище або введіть власну.';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle => 'Підключити радіо до мережі Wi‑Fi';

  @override
  String get wifi_unsupported => 'Прошивка цього радіо не підтримує Wi‑Fi.';

  @override
  String get wifi_enabled => 'Використовувати Wi‑Fi';

  @override
  String get wifi_status => 'Стан';

  @override
  String get wifi_connected => 'Підключено';

  @override
  String wifi_connectedIp(String ip) {
    return 'Підключено · $ip';
  }

  @override
  String get wifi_disconnected => 'Не підключено';

  @override
  String get wifi_network => 'Назва мережі (SSID)';

  @override
  String get wifi_password => 'Пароль';

  @override
  String get wifi_passwordKeep =>
      'Залиште порожнім, щоб зберегти поточний пароль';

  @override
  String get wifi_save => 'Зберегти';

  @override
  String get wifi_forget => 'Забути мережу';

  @override
  String get wifi_forgetConfirm =>
      'Видалити збережену мережу й пароль із радіо?';

  @override
  String get wifi_rebootNeeded =>
      'Збережено. Перезавантажте радіо, щоб застосувати зміни Wi‑Fi.';

  @override
  String get wifi_rebootNow => 'Перезавантажити радіо';

  @override
  String get wifi_rebootConfirm =>
      'Перезавантажити радіо зараз? Застосунок від\'єднається, і потрібно буде підключитися знову.';

  @override
  String get wifi_loadFailed =>
      'Не вдалося прочитати налаштування Wi‑Fi з радіо.';

  @override
  String get wifi_retry => 'Повторити';

  @override
  String wifi_saveFailed(String reply) {
    return 'Радіо не прийняло зміну: $reply';
  }

  @override
  String get accessControl_refresh => 'Оновити';

  @override
  String get common_cancel => 'Скасувати';

  @override
  String get common_ok => 'ОК';

  @override
  String get common_connect => 'Підключити';

  @override
  String get common_unknownDevice => 'Невідомий пристрій';

  @override
  String get common_save => 'Зберегти';

  @override
  String get common_delete => 'Видалити';

  @override
  String get common_deleteAll => 'Видалити все';

  @override
  String get common_close => 'Закрити';

  @override
  String get common_done => 'Готово';

  @override
  String get common_edit => 'Редагувати';

  @override
  String get common_add => 'Додати';

  @override
  String get common_settings => 'Налаштування';

  @override
  String get common_disconnect => 'Відключити';

  @override
  String get common_connected => 'Підключено';

  @override
  String get common_disconnected => 'Відключено';

  @override
  String get common_create => 'Створити';

  @override
  String get common_continue => 'Продовжити';

  @override
  String get common_share => 'Поділитись';

  @override
  String get common_copy => 'Копіювати';

  @override
  String get common_retry => 'Повторити';

  @override
  String get common_hide => 'Приховати';

  @override
  String get common_remove => 'Прибрати';

  @override
  String get common_enable => 'Увімкнути';

  @override
  String get common_disable => 'Вимкнути';

  @override
  String get common_undo => 'Скасувати';

  @override
  String get messageStatus_sent => 'Надіслано';

  @override
  String get messageStatus_delivered => 'Доставлено';

  @override
  String get messageStatus_pending => 'Надсилання';

  @override
  String get messageStatus_failed => 'Не вдалося надіслати';

  @override
  String get messageStatus_repeated => 'Почув неодноразово';

  @override
  String get urlImage_enable => 'Увімкнути зображення за URL';

  @override
  String get urlImage_possible =>
      'Можливо, зображення за URL; увімкніть це в Налаштуваннях.';

  @override
  String get common_reboot => 'Перезавантажити';

  @override
  String get common_loading => 'Завантаження...';

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
  String get common_autoRefresh => 'Автооновлення';

  @override
  String get common_interval => 'Інтервал';

  @override
  String get scanner_title => 'MeshCore: Відкритий доступ';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'Підключитись через TCP';

  @override
  String get tcpHostLabel => 'IP-адреса';

  @override
  String get tcpHostHint => '192.168.40.10';

  @override
  String get tcpPortLabel => 'Порт';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => 'Введіть кінцеву точку та підключіться';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return 'Підключення до $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => 'Необхідно вказати IP-адресу.';

  @override
  String get tcpErrorPortInvalid => 'Порт має бути в межах від 1 до 65535.';

  @override
  String get tcpErrorUnsupported =>
      'Транспорт TCP не підтримується на цій платформі.';

  @override
  String get tcpErrorTimedOut =>
      'З\'єднання TCP завершилось через закінчення часу очікування.';

  @override
  String tcpConnectionFailed(String error) {
    return 'Не вдалось встановити з\'єднання TCP: $error';
  }

  @override
  String get usbScreenTitle => 'Підключити через USB';

  @override
  String get usbScreenSubtitle =>
      'Виберіть виявлений USB-пристрій і підключіть його безпосередньо до вашого вузла MeshCore.';

  @override
  String get usbScreenStatus => 'Виберіть пристрій USB';

  @override
  String get usbScreenNote =>
      'USB-серіальний інтерфейс активний на підтримуваних пристроях на базі Android та на десктопних платформах.';

  @override
  String get usbScreenEmptyState =>
      'Не знайдено жодних пристроїв USB. Підключіть один і перезавантажте.';

  @override
  String get usbErrorPermissionDenied =>
      'Було відмовлено у наданні дозволу на використання USB.';

  @override
  String get usbErrorDeviceMissing => 'Вибране USB-пристрій більше недоступне.';

  @override
  String get usbErrorInvalidPort => 'Виберіть дійсний USB-пристрій.';

  @override
  String get usbErrorBusy =>
      'Ще один запит на підключення через USB вже обробляється.';

  @override
  String get usbErrorNotConnected => 'Немає підключених пристроїв USB.';

  @override
  String get usbErrorOpenFailed => 'Не вдалось відкрити вибране USB-пристрій.';

  @override
  String get usbErrorConnectFailed =>
      'Не вдалось підключитись до вибраного USB-пристрою.';

  @override
  String get usbErrorUnsupported =>
      'Підтримка USB-серіального інтерфейсу не реалізована на цій платформі.';

  @override
  String get usbErrorAlreadyActive => 'USB-з\'єднання вже встановлено.';

  @override
  String get usbErrorNoDeviceSelected =>
      'Не було вибрано жодного пристрою USB.';

  @override
  String get usbErrorPortClosed => 'З\'єднання USB не встановлено.';

  @override
  String get usbErrorConnectTimedOut =>
      'З\'єднання не вдалось встановити. Переконайтесь, що пристрій має встановлене програмне забезпечення USB Companion.';

  @override
  String get usbFallbackDeviceName =>
      'Пристрій для передачі даних по веб-серіалах';

  @override
  String get usbStatus_notConnected => 'Виберіть пристрій USB';

  @override
  String get usbStatus_connecting => 'Підключення до USB-пристрою...';

  @override
  String get usbStatus_searching => 'Пошук пристроїв USB...';

  @override
  String usbConnectionFailed(String error) {
    return 'Не вдалось встановити з\'єднання через USB: $error';
  }

  @override
  String get scanner_scanning => 'Пошук пристроїв...';

  @override
  String get scanner_connecting => 'Підключення...';

  @override
  String get scanner_disconnecting => 'Відключення...';

  @override
  String get scanner_notConnected => 'Не підключено';

  @override
  String scanner_connectedTo(String deviceName) {
    return 'Підключено до $deviceName';
  }

  @override
  String get scanner_searchingDevices => 'Пошук пристроїв MeshCore...';

  @override
  String get scanner_tapToScan =>
      'Натисніть «Сканувати», щоб знайти пристрої MeshCore';

  @override
  String scanner_connectionFailed(String error) {
    return 'Помилка підключення: $error';
  }

  @override
  String get scanner_stop => 'Стоп';

  @override
  String get scanner_scan => 'Сканувати';

  @override
  String get scanner_bluetoothOff => 'Bluetooth вимкнено';

  @override
  String get scanner_bluetoothOffMessage =>
      'Будь ласка, увімкніть Bluetooth, щоб сканувати пристрої.';

  @override
  String get scanner_chromeRequired => 'Потрібен браузер Chrome';

  @override
  String get scanner_chromeRequiredMessage =>
      'Для підтримки Bluetooth у цьому вебзастосунку потрібен Google Chrome або браузер на базі Chromium.';

  @override
  String get scanner_enableBluetooth => 'Увімкніть Bluetooth';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'Bluetooth недоступний у браузері. Підключіться через USB.';

  @override
  String get device_quickSwitch => 'Швидке перемикання';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => 'Налаштування';

  @override
  String get settings_deviceInfo => 'Інформація про пристрій';

  @override
  String get settings_appSettings => 'Налаштування застосунку';

  @override
  String get settings_appSettingsSubtitle =>
      'Сповіщення, повідомлення та налаштування карти';

  @override
  String get settings_nodeSettings => 'Налаштування вузла';

  @override
  String get settings_nodeName => 'Ім\'я вузла';

  @override
  String get settings_nodeNameNotSet => 'Не встановлено';

  @override
  String get settings_nodeNameHint => 'Введіть ім\'я вузла';

  @override
  String get settings_nodeNameUpdated => 'Ім\'я оновлено';

  @override
  String get settings_radioSettings => 'Налаштування радіо';

  @override
  String get settings_radioSettingsSubtitle =>
      'Частота, потужність, коефіцієнт розширення';

  @override
  String get settings_radioSettingsUpdated => 'Налаштування радіо оновлено';

  @override
  String get settings_regionSettings => 'Ріси';

  @override
  String get settings_regionSettingsSubtitle => 'Управляти збережених регіонів';

  @override
  String get settings_corridorRegion => 'Регіон коридору';

  @override
  String get settings_corridorRegionDefault => '#corridor (типово)';

  @override
  String get settings_corridorRegionHelp =>
      'Пакети flood-коридору позначаються цим регіоном. Ретранслятори без прошивки коридорів пересилають їх, лише якщо дозволяють цей регіон. Залиште порожнім для типової мітки #corridor.';

  @override
  String get settings_corridorRegionHint => 'Назва регіону';

  @override
  String get settings_corridorRegionUseDefault => 'Типовий';

  @override
  String get settings_corridorRegionUpdated => 'Регіон коридору оновлено';

  @override
  String get settings_corridorRegionFailed =>
      'Не вдалося оновити регіон коридору';

  @override
  String get settings_regionManagement_screenTitle => 'Рégіональний управління';

  @override
  String get settings_regionNameHint => 'Назва регіону';

  @override
  String get settings_regionAddRegion => 'Добачить регіон';

  @override
  String get settings_regionFetchRegions => 'Збираємо регіони з репітерів';

  @override
  String get settings_regionFetchRegionsFail => 'Ні відкриті регіони';

  @override
  String get settings_regionFetchRegionsAlreadyExists =>
      'Цей регіон вже було доданий';

  @override
  String get settings_regionName => 'Ріонна назва';

  @override
  String get settings_regionDeleted => 'Ріон витертений';

  @override
  String get settings_deleteRegion => 'Видалення регіону';

  @override
  String settings_deleteRegionConfirm(String region) {
    return 'Вирішіть \"$region\" з списку регіонів?';
  }

  @override
  String get settings_location => 'Геопозиція';

  @override
  String get settings_locationSubtitle => 'GPS-координати';

  @override
  String get settings_locationUpdated => 'Геопозицію оновлено';

  @override
  String get settings_locationBothRequired => 'Введіть широту та довготу.';

  @override
  String get settings_locationInvalid => 'Некоректна широта або довгота.';

  @override
  String get settings_locationGPSEnable => 'Увімкнути GPS';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'Вмикає автоматичне оновлення геопозиції через GPS.';

  @override
  String get settings_locationIntervalSec => 'Інтервал для GPS (Секунди)';

  @override
  String get settings_locationIntervalInvalid =>
      'Інтервал має бути не менше 60 секунд і менше 86400 секунд.';

  @override
  String get settings_latitude => 'Широта';

  @override
  String get settings_longitude => 'Довгота';

  @override
  String get settings_contactSettings => 'Налаштування контактів';

  @override
  String get settings_contactSettingsSubtitle =>
      'Налаштування для додавання контактів';

  @override
  String get settings_privacyMode => 'Режим приватності';

  @override
  String get settings_privacyModeSubtitle =>
      'Приховати ім\'я/геопозицію в оголошеннях';

  @override
  String get settings_privacyModeToggle =>
      'Увімкніть режим приватності, щоб приховати своє ім\'я та геопозицію в оголошеннях.';

  @override
  String get settings_privacyModeEnabled => 'Режим приватності увімкнено';

  @override
  String get settings_privacyModeDisabled => 'Режим приватності вимкнено';

  @override
  String get settings_privacy => 'Налаштування приватності';

  @override
  String get settings_privacySubtitle =>
      'Керуйте інформацією, яка буде спільно використовуватись';

  @override
  String get settings_privacySettingsDescription =>
      'Виберіть, яку інформацію ваш пристрій буде передавати іншим.';

  @override
  String get settings_denyAll => 'Відхилити все';

  @override
  String get settings_allowByContact => 'Дозволити за контактними прапорцями';

  @override
  String get settings_allowAll => 'Дозволити все';

  @override
  String get settings_telemetryBaseMode => 'Режим базової телеметрії';

  @override
  String get settings_telemetryLocationMode => 'Режим місця телеметрії';

  @override
  String get settings_telemetryEnvironmentMode => 'Режим середовища телеметрії';

  @override
  String get settings_advertLocation => 'Геопозиція в оголошенні';

  @override
  String get settings_advertLocationSubtitle =>
      'Включити геопозицію в оголошення';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'Автооголошення без хопів при оновленні GPS';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'Коли GPS-локація змінюється, надсилати оголошення без хопів (потрібна геопозиція в оголошенні).';

  @override
  String get settings_multiAck => 'Багато підтверджень';

  @override
  String get settings_telemetryModeUpdated => 'Режим телеметрії оновлено';

  @override
  String get settings_actions => 'Дії';

  @override
  String get settings_deleteAllPaths => 'Видалити всі шляхи';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Очистити всі дані шляхів у контактах.';

  @override
  String get settings_sendAdvertisement => 'Оголосити себе';

  @override
  String get settings_sendAdvertisementSubtitle =>
      'Транслювати присутність зараз';

  @override
  String get settings_advertisementSent => 'Оголошення надіслано';

  @override
  String get settings_syncTime => 'Синхронізація часу';

  @override
  String get settings_syncTimeSubtitle =>
      'Встановити час пристрою відповідно до часу телефону.';

  @override
  String get settings_timeSynchronized => 'Час синхронізовано';

  @override
  String get settings_refreshContacts => 'Оновити контакти';

  @override
  String get settings_refreshContactsSubtitle =>
      'Перезавантажити список контактів з пристрою';

  @override
  String get settings_rebootDevice => 'Перезавантажити пристрій';

  @override
  String get settings_rebootDeviceSubtitle =>
      'Перезавантажити пристрій MeshCore';

  @override
  String get settings_rebootDeviceConfirm =>
      'Ви впевнені, що хочете перезавантажити пристрій? Вас буде відключено.';

  @override
  String get settings_debug => 'Налагодження';

  @override
  String get settings_companionDebugLog =>
      'Журнал відлачування (для супутника)';

  @override
  String get settings_companionDebugLogSubtitle =>
      'Команди, відповіді та необроблена інформація для протоколів BLE/TCP/USB';

  @override
  String get settings_appDebugLog => 'Журнал налагодження застосунку';

  @override
  String get settings_appDebugLogSubtitle =>
      'Повідомлення налагодження застосунку';

  @override
  String get settings_about => 'Про застосунок';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core v$version';
  }

  @override
  String get settings_aboutLegalese => 'Проєкт MeshCore Open Source 2026';

  @override
  String get settings_aboutDescription =>
      'Клієнт Flutter з відкритим вихідним кодом для пристроїв мережі MeshCore LoRa.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'Дані про висоту LOS: Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => 'Ім\'я';

  @override
  String get settings_infoId => 'Ідентифікатор';

  @override
  String get settings_infoStatus => 'Статус';

  @override
  String get settings_infoBattery => 'Батарея';

  @override
  String get settings_infoPublicKey => 'Відкритий ключ';

  @override
  String get settings_infoContactsCount => 'Кількість контактів';

  @override
  String get settings_infoChannelCount => 'Кількість каналів';

  @override
  String get settings_infoHardware => 'Оборудовання';

  @override
  String get settings_infoFirmware => 'Програмне вміст (фirmware)';

  @override
  String get settings_presets => 'Попередні налаштування';

  @override
  String get settings_frequency => 'Частота (МГц)';

  @override
  String get settings_frequencyHelper => '300,0 – 2500,0';

  @override
  String get settings_frequencyInvalid => 'Некоректна частота (300-2500 МГц)';

  @override
  String get settings_bandwidth => 'Смуга пропускання';

  @override
  String get settings_spreadingFactor => 'Коефіцієнт розширення';

  @override
  String get settings_codingRate => 'Швидкість кодування';

  @override
  String get settings_txPower => 'Потужність TX (дБм)';

  @override
  String get settings_txPowerHelper => '0 - 22';

  @override
  String get settings_txPowerInvalid => 'Некоректна потужність TX (0-22 дБм)';

  @override
  String get settings_clientRepeat => 'Автономна система';

  @override
  String get settings_clientRepeatSubtitle =>
      'Дозвольте цьому пристрою повторювати пакети даних для інших пристроїв.';

  @override
  String get settings_clientRepeatFreqWarning =>
      'Повтор без підключення до мережі вимагає частоти 433, 869 або 918 МГц.';

  @override
  String settings_error(String message) {
    return 'Помилка: $message';
  }

  @override
  String get appSettings_title => 'Налаштування застосунку';

  @override
  String get appSettings_appearance => 'Вигляд';

  @override
  String get appSettings_theme => 'Тема';

  @override
  String get appSettings_themeSystem => 'Системна';

  @override
  String get appSettings_themeLight => 'Світла';

  @override
  String get appSettings_themeDark => 'Темна';

  @override
  String get appSettings_language => 'Мова';

  @override
  String get appSettings_languageSystem => 'Як у системі';

  @override
  String get appSettings_languageEn => 'Англійська';

  @override
  String get appSettings_languageFr => 'Французька';

  @override
  String get appSettings_languageEs => 'Іспанська';

  @override
  String get appSettings_languageDe => 'Німецькою';

  @override
  String get appSettings_languagePl => 'Польська';

  @override
  String get appSettings_languageSl => 'Словенська мова';

  @override
  String get appSettings_languagePt => 'Португальська';

  @override
  String get appSettings_languageIt => 'Італійська';

  @override
  String get appSettings_languageZh => 'Китайська';

  @override
  String get appSettings_languageSv => 'Шведська';

  @override
  String get appSettings_languageNl => 'Нідерландська';

  @override
  String get appSettings_languageSk => 'Словенська';

  @override
  String get appSettings_languageBg => 'Болгарська';

  @override
  String get appSettings_languageRu => 'Російська';

  @override
  String get appSettings_languageUk => 'Українська';

  @override
  String get repeater_pathHashModeOption0 => '0 - 1 байт';

  @override
  String get repeater_pathHashModeOption1 => '1 - 2 байти';

  @override
  String get repeater_pathHashModeOption2 => '2 - 3 байти';

  @override
  String get repeater_pathHashModeOption3 => '3 - 4 байта';

  @override
  String get appSettings_enableMessageTracing =>
      'Увімкнути відстеження повідомлень';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'Показувати детальні метадані про маршрутизацію та час для повідомлень';

  @override
  String get appSettings_notifications => 'Сповіщення';

  @override
  String get appSettings_enableNotifications => 'Увімкнути сповіщення';

  @override
  String get appSettings_enableNotificationsSubtitle =>
      'Отримувати сповіщення про повідомлення та оголошення';

  @override
  String get appSettings_notificationPermissionDenied =>
      'У доступі до сповіщень відмовлено';

  @override
  String get appSettings_notificationsEnabled => 'Сповіщення увімкнено';

  @override
  String get appSettings_notificationsDisabled => 'Сповіщення вимкнено';

  @override
  String get appSettings_messageNotifications => 'Сповіщення про повідомлення';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      'Показувати сповіщення при отриманні нових повідомлень';

  @override
  String get appSettings_channelMessageNotifications => 'Сповіщення каналів';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'Показувати сповіщення при отриманні повідомлень каналу';

  @override
  String get appSettings_advertisementNotifications =>
      'Сповіщення про оголошення';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      'Показувати сповіщення при виявленні нових вузлів';

  @override
  String get appSettings_messaging => 'Обмін повідомленнями';

  @override
  String get appSettings_clearPathOnMaxRetry =>
      'Очищати шлях після макс. спроб';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      'Скидати шлях до контакту після 5 невдалих спроб надсилання';

  @override
  String get appSettings_pathsWillBeCleared =>
      'Шляхи будуть очищені після 5 невдалих спроб.';

  @override
  String get appSettings_pathsWillNotBeCleared =>
      'Шляхи не будуть очищатись автоматично.';

  @override
  String get appSettings_autoRouteRotation => 'Авторотація маршруту';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      'Чергувати найкращі шляхи та режим «через всю мережу» (flood)';

  @override
  String get appSettings_autoRouteRotationEnabled =>
      'Авторотація маршрутизації увімкнена';

  @override
  String get appSettings_autoRouteRotationDisabled =>
      'Авторотація маршрутизації вимкнена';

  @override
  String get appSettings_maxRouteWeight => 'Максимальна вага маршруту';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      'Максимальна вага, яку може накопичити маршрут завдяки успішним доставкам.';

  @override
  String get appSettings_initialRouteWeight => 'Початкова вартість маршруту';

  @override
  String get appSettings_initialRouteWeightSubtitle =>
      'Початкова вага для нових відкритих шляхів';

  @override
  String get appSettings_routeWeightSuccessIncrement =>
      'Збільшення ваги успіху';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      'Вага, додана до маршруту після успішної доставки';

  @override
  String get appSettings_routeWeightFailureDecrement =>
      'Зменшення ваги помилки';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      'Вага, яка була знята з маршруту після невдалої доставки';

  @override
  String get appSettings_maxMessageRetries =>
      'Максимальна кількість повторних спроб надсилання повідомлення';

  @override
  String get appSettings_maxMessageRetriesSubtitle =>
      'Кількість спроб повторного відправлення повідомлення перед тим, як позначити його як невдале';

  @override
  String get appSettings_battery => 'Батарея';

  @override
  String get appSettings_batteryChemistry => 'Хімія батареї';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return 'Встановити для пристрою ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      'Підключіть пристрій, щоб вибрати';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3.0-4.2В)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2.6-3.65В)';

  @override
  String get appSettings_batteryLipo => 'LiPo (3.0-4.2В)';

  @override
  String get appSettings_batteryLipoHv => 'ЛиPo HV (3,0-4,35 В)';

  @override
  String get appSettings_mapDisplay => 'Відображення карти';

  @override
  String get appSettings_showRepeaters => 'Показувати ретранслятори';

  @override
  String get appSettings_showRepeatersSubtitle =>
      'Відображати вузли-ретранслятори на карті';

  @override
  String get appSettings_showChatNodes => 'Показувати вузли чату';

  @override
  String get appSettings_showChatNodesSubtitle =>
      'Відображати вузли чату на карті';

  @override
  String get appSettings_showOtherNodes => 'Показувати інші вузли';

  @override
  String get appSettings_showOtherNodesSubtitle =>
      'Відображати інші типи вузлів на карті';

  @override
  String get appSettings_timeFilter => 'Фільтр часу';

  @override
  String get appSettings_timeFilterShowAll => 'Показати всі вузли';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return 'Показати вузли за останні $hours год';
  }

  @override
  String get appSettings_mapTimeFilter => 'Фільтр часу карти';

  @override
  String get appSettings_showNodesDiscoveredWithin =>
      'Показувати вузли, виявлені за:';

  @override
  String get appSettings_allTime => 'Весь час';

  @override
  String get appSettings_lastHour => 'Останню годину';

  @override
  String get appSettings_last6Hours => 'Останні 6 годин';

  @override
  String get appSettings_last24Hours => 'Останні 24 години';

  @override
  String get appSettings_lastWeek => 'Минулий тиждень';

  @override
  String get appSettings_rasterTileSource => 'Джерело растрових тайлів';

  @override
  String get appSettings_stadiaEndpoint => 'Кінцева точка Stadia';

  @override
  String get appSettings_stadiaApiKey => 'Ключ API Stadia';

  @override
  String get appSettings_stadiaApiKeyRequired =>
      'Потрібно для використання Stadia Maps';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return 'Налаштовано: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Введіть свій ключ API Stadia Maps. Програма використовує його для запитів растрових тайлів.';

  @override
  String get appSettings_offlineMapCache => 'Офлайн-кеш карти';

  @override
  String get appSettings_unitsTitle => 'Одиниці';

  @override
  String get appSettings_unitsMetric => 'Метричні (м / км)';

  @override
  String get appSettings_unitsImperial => 'Імперські (ft / mi)';

  @override
  String get appSettings_noAreaSelected => 'Область не вибрано';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'Вибрана область (зум $minZoom-$maxZoom)';
  }

  @override
  String get appSettings_debugCard => 'Налагодження';

  @override
  String get appSettings_appDebugLogging =>
      'Журналювання налагодження застосунку';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'Записувати повідомлення налагодження застосунку в журнал для усунення несправностей.';

  @override
  String get appSettings_appDebugLoggingEnabled =>
      'Журналювання налагодження застосунку увімкнено';

  @override
  String get appSettings_appDebugLoggingDisabled =>
      'Журналювання налагодження застосунку вимкнено.';

  @override
  String get contacts_title => 'Контакти';

  @override
  String get contacts_noContacts => 'Контактів не знайдено.';

  @override
  String get contacts_contactsWillAppear =>
      'Контакти з\'являться, коли пристрої надішлють оголошення.';

  @override
  String get contacts_unread => 'Непрочитане';

  @override
  String get contacts_searchContactsNoNumber => 'Пошук контактів...';

  @override
  String contacts_searchContacts(int number, String str) {
    return 'Пошук контактів...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'Пошук $number$str улюблених...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'Пошук $number$str користувачів...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'Пошук $number$str ретрансляторів...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'Пошук $number$str серверів кімнат...';
  }

  @override
  String get contacts_noUnreadContacts => 'Немає непрочитаних контактів';

  @override
  String get contacts_noContactsFound => 'Контактів або груп не знайдено.';

  @override
  String get contacts_deleteContact => 'Видалити контакт';

  @override
  String contacts_removeConfirm(String contactName) {
    return 'Видалити $contactName з контактів?';
  }

  @override
  String get contacts_manageRepeater => 'Керувати ретранслятором';

  @override
  String get contacts_manageRoom => 'Керувати сервером кімнати';

  @override
  String get contacts_roomLogin => 'Вхід у кімнату';

  @override
  String get contacts_openChat => 'Відкрити чат';

  @override
  String get contacts_editGroup => 'Редагувати групу';

  @override
  String get contacts_deleteGroup => 'Видалити групу';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return 'Видалити $groupName?';
  }

  @override
  String get contacts_newGroup => 'Нова група';

  @override
  String get contacts_moreOptions => 'Більше можливостей';

  @override
  String get contacts_searchOpen => 'Пошук контактів';

  @override
  String get contacts_searchClose => 'Закрити пошук';

  @override
  String get contacts_groupName => 'Назва групи';

  @override
  String get contacts_groupNameRequired => 'Назва групи обов\'язкова.';

  @override
  String get contacts_groupNameReserved => 'Ця назва групи зарезервована';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'Група «$name» вже існує.';
  }

  @override
  String get contacts_filterContacts => 'Фільтрувати контакти...';

  @override
  String get contacts_noContactsMatchFilter =>
      'Жоден контакт не відповідає фільтру.';

  @override
  String get contacts_noMembers => 'Немає учасників';

  @override
  String get contacts_lastSeenNow => 'В мережі';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return 'В мережі $minutes хв. тому';
  }

  @override
  String get contacts_lastSeenHourAgo => 'В мережі 1 годину тому';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return 'В мережі $hours год. тому';
  }

  @override
  String get contacts_lastSeenDayAgo => 'В мережі 1 день тому';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return 'В мережі $days дн. тому';
  }

  @override
  String get contact_info => 'Контактна інформація';

  @override
  String get contact_settings => 'Налаштування контактів';

  @override
  String get contact_telemetry => 'Телеметрія';

  @override
  String get contact_lastSeen => 'Останній раз бачили';

  @override
  String get contact_clearChat => 'Очистити чат';

  @override
  String get contact_teleBase => 'Базова телеметрія';

  @override
  String get contact_teleBaseSubtitle =>
      'Дозволити спільний доступ до рівня заряду батареї та базової телеметрії';

  @override
  String get contact_teleLoc => 'Геопозиція телеметрії';

  @override
  String get contact_teleLocSubtitle =>
      'Дозволити спільне використання даних про місцеположення';

  @override
  String get contact_teleEnv => 'Середовище телеметрії';

  @override
  String get contact_teleEnvSubtitle =>
      'Дозволити спільний доступ до даних датчиків середовища';

  @override
  String get channels_title => 'Канали';

  @override
  String get channels_noChannelsConfigured => 'Канали не налаштовані';

  @override
  String get channels_addPublicChannel => 'Додати публічний канал';

  @override
  String get channels_searchChannels => 'Пошук каналів...';

  @override
  String get channels_noChannelsFound => 'Каналів не знайдено';

  @override
  String channels_channelIndex(int index) {
    return 'Канал $index';
  }

  @override
  String get channels_public => 'Публічний';

  @override
  String channels_via(String path) {
    return 'через $path';
  }

  @override
  String get channels_viaMqtt => 'через MQTT';

  @override
  String get channels_viaMqttSemantics =>
      'Отримано через MQTT, ваше радіо його не чуло';

  @override
  String get channels_private => 'Приватний';

  @override
  String get channels_editChannel => 'Редагувати канал';

  @override
  String get channels_muteChannel => 'Вимкнути сповіщення каналу';

  @override
  String get channels_unmuteChannel => 'Увімкнути сповіщення каналу';

  @override
  String get channels_deleteChannel => 'Видалити канал';

  @override
  String channels_deleteChannelConfirm(String name) {
    return 'Видалити $name? Це не можна скасувати.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'Не вдалось видалити канал \"$name\"';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'Канал «$name» видалено';
  }

  @override
  String get channels_addChannel => 'Додати канал';

  @override
  String get channels_channelIndexLabel => 'Індекс каналу';

  @override
  String get channels_channelName => 'Назва каналу';

  @override
  String get channels_usePublicChannel => 'Використовувати публічний канал';

  @override
  String get channels_standardPublicPsk => 'Стандартний публічний PSK';

  @override
  String get channels_pskHex => 'PSK (шестнадцяткова система)';

  @override
  String get channels_generateRandomPsk => 'Згенерувати випадковий ключ PSK';

  @override
  String get channels_enterChannelName => 'Будь ласка, введіть назву каналу';

  @override
  String get channels_pskMustBe32Hex =>
      'PSK має складатись з 32 шістнадцяткових символів.';

  @override
  String channels_channelAdded(String name) {
    return 'Канал «$name» додано';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'Редагувати канал $index';
  }

  @override
  String get channels_smazCompression => 'Стиснення SMAZ';

  @override
  String get channels_cyr2latCompression => 'Стиснення Cyr2Lat';

  @override
  String get channels_cyr2latCompressionDscr =>
      'Замінює деякі кириличні символи на латиницю при відправці.';

  @override
  String get channels_cyr2latSettingsHeading => 'Налаштування Cyr2Lat';

  @override
  String get channels_cyr2latSettingsSubheading => 'Список замін';

  @override
  String get channels_cyr2latSettingsDscr =>
      'Редагувати JSON-конфігурацію заміни символів';

  @override
  String get channels_cyr2latSettingsDialogHint => 'JSON-карта замін';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'Некоректний JSON: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'Канал «$name» оновлено';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Додати профіль Cyr2Lat';

  @override
  String get settings_cyr2latProfileName => 'Назва профілю';

  @override
  String get settings_cyr2latProfileNameEmpty =>
      'Назва профілю не може бути порожньою';

  @override
  String get settings_cyr2latProfileAdded => 'Профіль успішно додано';

  @override
  String get settings_cyr2latProfileUpdated => 'Профіль успішно оновлено';

  @override
  String get settings_cyr2latProfileEdit => 'Редагувати профіль Cyr2Lat';

  @override
  String get settings_cyr2latProfileDelete => 'Видалити профіль Cyr2Lat';

  @override
  String get settings_cyr2latProfileDeleted => 'Профіль успішно видалено';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return 'Ви впевнені, що хочете видалити профіль \"$name\"?';
  }

  @override
  String get channels_publicChannelAdded => 'Публічний канал додано';

  @override
  String get channels_sortBy => 'Сортувати за';

  @override
  String get channels_sortManual => 'Вручну';

  @override
  String get channels_sortAZ => 'А-Я';

  @override
  String get channels_sortLatestMessages => 'Останні повідомлення';

  @override
  String get channels_sortUnread => 'Непрочитані';

  @override
  String get channels_createPrivateChannel => 'Створити приватний канал';

  @override
  String get channels_createPrivateChannelDesc => 'Захищено секретним ключем.';

  @override
  String get channels_joinPrivateChannel => 'Приєднатись до приватного каналу';

  @override
  String get channels_joinPrivateChannelDesc => 'Ввести секретний ключ вручну.';

  @override
  String get channels_joinPublicChannel => 'Приєднатись до публічного каналу';

  @override
  String get channels_joinPublicChannelDesc =>
      'Будь-хто може приєднатись до цього каналу.';

  @override
  String get channels_joinHashtagChannel => 'Приєднатись до хештег-каналу';

  @override
  String get channels_joinHashtagChannelDesc =>
      'Будь-хто може приєднатись до хештег-каналів.';

  @override
  String get channels_scanQrCode => 'Сканувати QR-код';

  @override
  String get channels_scanQrCodeComingSoon => 'Скоро буде';

  @override
  String get channels_enterHashtag => 'Введіть хештег';

  @override
  String get channels_hashtagHint => 'напр. #команда';

  @override
  String channels_regionSetTo(String region) {
    return 'Ріон: $region';
  }

  @override
  String get channels_regionNotSet => 'Ріон: нема';

  @override
  String get channels_regionSelect_Title => 'Вybірте регіон';

  @override
  String get channels_clearRegion => 'Чистя зона';

  @override
  String get chat_noMessages => 'Поки немає повідомлень.';

  @override
  String get chat_sendMessage => 'Надіслати повідомлення';

  @override
  String chat_sendMessageTo(String contactName) {
    return 'Надіслати повідомлення $contactName';
  }

  @override
  String get chat_sendMessageToStart => 'Надішліть повідомлення, щоб почати';

  @override
  String get chat_originalMessageNotFound =>
      'Оригінальне повідомлення не знайдено';

  @override
  String chat_replyingTo(String name) {
    return 'Відповідь $name';
  }

  @override
  String chat_replyTo(String name) {
    return 'Відповісти $name';
  }

  @override
  String get chat_location => 'Геопозиція';

  @override
  String get chat_typeMessage => 'Введіть повідомлення...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'Повідомлення занадто довге (макс. $maxBytes байт).';
  }

  @override
  String get chat_messageCopied => 'Повідомлення скопійовано';

  @override
  String get chat_messageDeleted => 'Повідомлення видалено';

  @override
  String get chat_retryingMessage => 'Спроба відновлення.';

  @override
  String chat_retryCount(int current, int max) {
    return 'Повторна спроба $current/$max';
  }

  @override
  String get chat_selectSendAction => 'Виберіть дію надсилання';

  @override
  String get chat_sendGif => 'Надіслати GIF';

  @override
  String get chat_limitToArea => 'Обмежити областю';

  @override
  String get chat_limitToAreaTitle => 'Надсилати лише в межах…';

  @override
  String get chat_limitToAreaHelp =>
      'Ретранслятори з прошивкою flood-коридорів передають повідомлення лише в цій області. Інші ретранслятори відкидають його, якщо не дозволяють ваш регіон коридору.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '$km км від вас';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return 'Лише в радіусі $km км від вас';
  }

  @override
  String get chat_limitToAreaOff => 'Без обмеження';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'Задайте координати радіо, щоб обмежувати повідомлення областю.';

  @override
  String get chat_sendImageLora => 'Надіслати зображення через MeshCore';

  @override
  String get chat_imagePickFailed => 'Неможливо відкрити це изображення';

  @override
  String get chat_receivedGif => 'Підймовано GIF';

  @override
  String get chat_reply => 'Відповісти';

  @override
  String get chat_addReaction => 'Додати реакцію';

  @override
  String get chat_me => 'Я';

  @override
  String get reaction_report => 'Реакції емодзі';

  @override
  String get emojiCategorySmileys => 'Емодзі';

  @override
  String get emojiCategoryGestures => 'Жести';

  @override
  String get emojiCategoryHearts => 'Серця';

  @override
  String get emojiCategoryObjects => 'Об\'єкти';

  @override
  String get gifPicker_title => 'Вибрати GIF';

  @override
  String get gifPicker_searchHint => 'Пошук GIF...';

  @override
  String get gifPicker_poweredBy => 'На базі GIPHY';

  @override
  String get gifPicker_noGifsFound => 'GIF не знайдено';

  @override
  String get gifPicker_failedLoad => 'Не вдалось завантажити GIF-файли';

  @override
  String get gifPicker_failedSearch => 'Пошук GIF не вдався';

  @override
  String get gifPicker_noInternet => 'Немає інтернет-з\'єднання';

  @override
  String get debugLog_appTitle => 'Журнал налагодження застосунку';

  @override
  String get debugLog_bleTitle => 'Журнал налагодження BLE';

  @override
  String get debugLog_copyLog => 'Копіювати журнал';

  @override
  String get debugLog_clearLog => 'Очистити журнал';

  @override
  String get debugLog_copied => 'Журнал налагодження скопійовано';

  @override
  String get debugLog_bleCopied => 'Журнал BLE скопійовано';

  @override
  String get debugLog_noEntries =>
      'Поки що немає записів журналу налагодження.';

  @override
  String get debugLog_enableInSettings =>
      'Увімкніть налагодження застосунку в налаштуваннях';

  @override
  String get debugLog_frames => 'Кадри';

  @override
  String get debugLog_rawLogRx => 'Необроблений лог - RX';

  @override
  String get debugLog_noBleActivity => 'Поки що немає активності BLE.';

  @override
  String debugFrame_length(int count) {
    return 'Довжина кадру: $count байт';
  }

  @override
  String debugFrame_command(String value) {
    return 'Команда: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'Повідомлення:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- PubKey призначення: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- Мітка часу: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- Прапорці: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- Тип тексту: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'CLI (Command Line Interface)';

  @override
  String get debugFrame_textTypePlain => 'Звичайний';

  @override
  String debugFrame_text(String text) {
    return '- Текст: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => 'Дамп Hex:';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'переходів',
      many: 'переходів',
      few: 'переходи',
      one: 'перехід',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => 'Видалити шлях';

  @override
  String get chat_noPathHistoryYet =>
      'Історія шляхів недоступна.\nНадішліть повідомлення, щоб виявити шляхи.';

  @override
  String get chat_pathCleared =>
      'Шлях очищено. Наступне повідомлення оновить маршрут.';

  @override
  String get chat_fullPath => 'Повний шлях';

  @override
  String get routing_title => 'Маршрутизація';

  @override
  String get routing_modeAuto => 'Автомобіль';

  @override
  String get routing_modeFlood => 'Повені';

  @override
  String get routing_modeManual => 'Інструкція';

  @override
  String get routing_modeAutoHint =>
      'Автоматично обирає найкращий відомий шлях, та у разі відсутності відомого шляху, використовує алгоритм \"занурення\".';

  @override
  String get routing_modeFloodHint =>
      'Передавання через усі ретранслятори. Найбільш надійний спосіб, але потребує більше часу.';

  @override
  String get routing_modeManualHint =>
      'Завжди доставляє точно за вказаним вами маршрутом.';

  @override
  String get routing_currentRoute => 'Поточний маршрут';

  @override
  String get routing_directNoHops =>
      'Пряме з\'єднання – без проміжних ретрансляторів';

  @override
  String get routing_noPathYet =>
      'Поки що немає жодного шляху. Повідомлення продовжуються надходити, поки не буде знайдено маршрут.';

  @override
  String get routing_floodBroadcast => 'Поширення через усі ретранслятори';

  @override
  String get routing_editPath => 'Редагувати шлях';

  @override
  String get routing_forgetPath => 'Забудь про шлях';

  @override
  String get routing_knownPaths => 'Відомі маршрути';

  @override
  String get routing_knownPathsHint =>
      'Виберіть опцію, щоб переключитися на неї.';

  @override
  String get routing_inUse => 'У робочому стані';

  @override
  String get routing_qualityStrong => 'Сильний перший стрибок';

  @override
  String get routing_qualityGood => 'Чудова перша спроба';

  @override
  String get routing_qualityFair => 'Перший, але вдалий, крок';

  @override
  String get routing_qualityWorked => 'Доставлено';

  @override
  String get routing_qualityFlood => 'Дізнався через новини';

  @override
  String get routing_qualityUntested => 'Не протестовано';

  @override
  String routing_lastWorked(String when) {
    return 'worked $when';
  }

  @override
  String get routing_neverWorked => 'ніколи не підтверджено';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes delivered, $failures failed';
  }

  @override
  String get routing_floodDelivery => 'Доставка під час повені';

  @override
  String get pathEditor_title => 'Створити маршрут';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count з 64 штук хмелю';
  }

  @override
  String get pathEditor_noHops =>
      'Ще не додано хміль. Натисніть на відповідні кнопки, щоб додати його в потрібному порядку, або збережіть рецепт без хмілю, щоб відправити його безпосередньо.';

  @override
  String get pathEditor_addHops => 'Додавайте хміль у наступній послідовності.';

  @override
  String get pathEditor_searchRepeaters => 'Пошук повторювачів';

  @override
  String get pathEditor_advancedHex =>
      'Просунутий рівень: пряма шлях у форматі шестнадцяткової системи.';

  @override
  String get pathEditor_hexLabel =>
      'Префікси для шестнадцяткової системи числення';

  @override
  String get pathEditor_hexHelper =>
      'Два шестизначні символи на кожний крок, розділені комами';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return 'Неправильно: $tokens';
  }

  @override
  String get pathEditor_tooManyHops => 'Максимум 64 хмелеві колоди';

  @override
  String get pathEditor_usePath => 'Використовуйте цей шлях';

  @override
  String get pathEditor_removeHop => 'Видалити хміль';

  @override
  String get pathEditor_unknownHop => 'Невідомий ретранслятор';

  @override
  String get chat_pathSavedLocally =>
      'Збережено локально. Підключіться для синхронізації.';

  @override
  String get chat_pathDeviceConfirmed => 'Пристрій підтверджено.';

  @override
  String get chat_pathDeviceNotConfirmed => 'Пристрій ще не підтверджено.';

  @override
  String get chat_type => 'Ввід';

  @override
  String get chat_path => 'Шлях';

  @override
  String get chat_publicKey => 'Відкритий ключ';

  @override
  String get chat_compressOutgoingMessages => 'Стискати вихідні повідомлення';

  @override
  String get chat_floodForced => 'Через всю мережу (примусово)';

  @override
  String get chat_directForced => 'Напряму (примусово)';

  @override
  String chat_hopsForced(int count) {
    return '$count переходів (примусово)';
  }

  @override
  String get chat_floodAuto => 'Через всю мережу (авто)';

  @override
  String get chat_direct => 'Напряму';

  @override
  String get chat_poiShared => 'Поділилися точкою інтересу';

  @override
  String chat_unread(int count) {
    return 'Непрочитано: $count';
  }

  @override
  String get chat_markAsUnread => 'Позначити як непрочитане';

  @override
  String get chat_newMessages => 'Нові повідомлення';

  @override
  String get chat_openLink => 'Відкрити посилання?';

  @override
  String get chat_openLinkConfirmation =>
      'Ви хочете відкрити це посилання у браузері?';

  @override
  String get chat_open => 'Відкрити';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'Не вдалось відкрити посилання: $url';
  }

  @override
  String get chat_invalidLink => 'Невірний формат посилання';

  @override
  String get map_title => 'Карта вузлів';

  @override
  String get map_searchHint => 'Назва або ID вузла';

  @override
  String get map_activity => 'Активність';

  @override
  String get map_online => 'Онлайн';

  @override
  String get map_recent => 'Нещодавні';

  @override
  String get map_stale => 'Застаріло';

  @override
  String get map_visible => 'Видимий';

  @override
  String get map_hidden => 'Прихований';

  @override
  String get map_centerOnNode => 'Центрувати на вузлі';

  @override
  String get map_details => 'Деталі';

  @override
  String get map_noGps => 'Без GPS';

  @override
  String get map_noResults => 'Не знайдено відповідних вузлів';

  @override
  String get map_lineOfSight => 'Пряма видимість';

  @override
  String get map_losScreenTitle => 'Пряма видимість';

  @override
  String get map_noNodesWithLocation => 'Немає вузлів з даними про геопозицію';

  @override
  String get map_nodesNeedGps =>
      'Вузли мають надавати свої GPS координати,\nщоб з\'явитись на карті.';

  @override
  String map_nodesCount(int count) {
    return 'Вузли: $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'Мітки: $count';
  }

  @override
  String get map_chat => 'Чат';

  @override
  String get map_repeater => 'Ретранслятор';

  @override
  String get map_room => 'Кімната';

  @override
  String get map_sensor => 'Сенсор';

  @override
  String get map_pinDm => 'Ключ (DM)';

  @override
  String get map_pinPrivate => 'Замок (Приватний)';

  @override
  String get map_pinPublic => 'Ключ (Публічний)';

  @override
  String get map_lastSeen => 'Останній раз бачили';

  @override
  String get map_disconnectConfirm =>
      'Ви впевнені, що хочете відключитись від цього пристрою?';

  @override
  String get map_from => 'Від';

  @override
  String get map_source => 'Джерело';

  @override
  String get map_flags => 'Прапорці';

  @override
  String get map_type => 'Тип';

  @override
  String get map_path => 'Шлях';

  @override
  String get map_location => 'Геопозиція';

  @override
  String get map_estLocation => 'Орієнтовна геопозиція';

  @override
  String get map_publicKey => 'Публічний ключ';

  @override
  String get map_publicKeyPrefixHint => 'напр. ab12';

  @override
  String get map_shareMarkerHere => 'Поділитись маркером тут';

  @override
  String get map_setAsMyLocation => 'Встановити мою геопозицію';

  @override
  String get floodCorridor_title => 'Flood-коридор';

  @override
  String get floodCorridor_previewToHere => 'Переглянути flood-коридор досюди';

  @override
  String get floodCorridor_requesting => 'Запитуємо коридор у радіо…';

  @override
  String get floodCorridor_unsupported =>
      'Прошивка вашого радіо не підтримує flood-коридори.';

  @override
  String get floodCorridor_noProposal =>
      'Радіо не змогло запропонувати коридор. Переконайтеся, що в нього задано координати.';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count кола',
      many: '$count кіл',
      few: '$count кола',
      one: '1 коло',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return 'Усередині $inside з $total відомих ретрансляторів';
  }

  @override
  String get floodCorridor_straightLine =>
      'Пряма лінія: на шляху немає відомих ретрансляторів';

  @override
  String get floodCorridor_followsRepeaters =>
      'Проходить відомими ретрансляторами';

  @override
  String get floodCorridor_horizonLimited =>
      'Відомі ретранслятори не сягають цілі; решта — пряма лінія';

  @override
  String get floodCorridor_thinStretch =>
      'На частині коридору мало відомих ретрансляторів';

  @override
  String get floodCorridor_moreCoverage =>
      'Вимагати більшого покриття ретрансляторами';

  @override
  String get floodCorridor_previewNote =>
      'Лише попередній перегляд. Ретранслятори без прошивки коридорів їх не застосовують.';

  @override
  String get map_pinLabel => 'Мітка піна';

  @override
  String get map_label => 'Мітка';

  @override
  String get map_pointOfInterest => 'Точка інтересу';

  @override
  String get map_sendToContact => 'Надіслати контакту';

  @override
  String get map_sendToChannel => 'Надіслати в канал';

  @override
  String get map_noChannelsAvailable => 'Немає доступних каналів';

  @override
  String get map_publicLocationShare => 'Поділитись в публічному місці';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return 'Ви збираєтесь поділитись геопозицією у $channelLabel. Цей канал публічний, і кожен, хто має ключ PSK, може це побачити.';
  }

  @override
  String get map_connectToShareMarkers =>
      'Підключіться до пристрою, щоб поділитись маркерами';

  @override
  String get map_filterNodes => 'Фільтрувати вузли';

  @override
  String get map_nodeTypes => 'Типи вузлів';

  @override
  String get map_chatNodes => 'Вузли чату';

  @override
  String get map_repeaters => 'Ретранслятори';

  @override
  String get map_otherNodes => 'Інші вузли';

  @override
  String get map_showOverlaps => 'Перекриття ключів ретрансляторів';

  @override
  String get map_keyPrefix => 'Префікс ключа';

  @override
  String get map_filterByKeyPrefix => 'Фільтрувати за префіксом ключа';

  @override
  String get map_publicKeyPrefix => 'Префікс відкритого ключа';

  @override
  String get map_markers => 'Маркери';

  @override
  String get map_showSharedMarkers => 'Показувати спільні маркери';

  @override
  String get map_showGuessedLocations =>
      'Показати геопозиції передбачених вузлів';

  @override
  String get map_showDiscoveryContacts => 'Показати виявлені контакти';

  @override
  String get map_guessedLocation => 'Передбачена геопозиція';

  @override
  String get map_lastSeenTime => 'Час останньої активності';

  @override
  String get map_sharedPin => 'Спільний пін';

  @override
  String get map_sharedAt => 'Поділено';

  @override
  String get map_joinRoom => 'Приєднатись до кімнати';

  @override
  String get map_manageRepeater => 'Керувати ретранслятором';

  @override
  String get map_tapToAdd => 'Натисніть на вузли, щоб додати їх до шляху';

  @override
  String get map_runTrace => 'Виконати трасування шляху';

  @override
  String get map_runTraceWithReturnPath => 'Повернутись назад тим же шляхом';

  @override
  String get map_removeLast => 'Видалити останній';

  @override
  String get map_pathTraceCancelled => 'Трасування шляху скасовано.';

  @override
  String get mapCache_title => 'Офлайн-кеш карти';

  @override
  String get mapCache_selectAreaFirst =>
      'Спершу виберіть область для кешування';

  @override
  String get mapCache_noTilesToDownload =>
      'Немає плиток для завантаження в цій області.';

  @override
  String get mapCache_downloadTilesTitle => 'Завантажити плитки';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return 'Завантажити $count плиток для використання офлайн?';
  }

  @override
  String get mapCache_downloadAction => 'Завантажити';

  @override
  String mapCache_cachedTiles(int count) {
    return 'Закешовано $count плиток';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return 'Плитки в кеші ($downloaded) ($failed помилок)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => 'Очистити офлайн-кеш';

  @override
  String get mapCache_clearOfflineCachePrompt =>
      'Видалити всі закешовані плитки карти?';

  @override
  String get mapCache_offlineCacheCleared => 'Офлайн-кеш очищено.';

  @override
  String get mapCache_noAreaSelected => 'Область не вибрано';

  @override
  String get mapCache_cacheArea => 'Область кешування';

  @override
  String get mapCache_useCurrentView => 'Використати поточний вигляд';

  @override
  String get mapCache_zoomRange => 'Діапазон масштабування';

  @override
  String mapCache_estimatedTiles(int count) {
    return 'Оцінка плиток: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return 'Завантажено $completed / $total';
  }

  @override
  String get mapCache_downloadTilesButton => 'Завантажити плитки';

  @override
  String get mapCache_clearCacheButton => 'Очистити кеш';

  @override
  String mapCache_failedDownloads(int count) {
    return 'Невдалі завантаження: $count';
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
    return 'Пн $north, Пд $south, Сх $east, Зх $west';
  }

  @override
  String get time_justNow => 'Тільки що';

  @override
  String time_minutesAgo(int minutes) {
    return '$minutes хв. тому';
  }

  @override
  String time_hoursAgo(int hours) {
    return '$hours год. тому';
  }

  @override
  String time_daysAgo(int days) {
    return '$days дн. тому';
  }

  @override
  String get time_hour => 'година';

  @override
  String get time_hours => 'годин';

  @override
  String get time_day => 'день';

  @override
  String get time_days => 'днів';

  @override
  String get time_week => 'тиждень';

  @override
  String get time_weeks => 'тижнів';

  @override
  String get time_month => 'місяць';

  @override
  String get time_months => 'місяців';

  @override
  String get time_minutes => 'хвилин';

  @override
  String get time_allTime => 'Весь час';

  @override
  String get dialog_disconnect => 'Відключити';

  @override
  String get dialog_disconnectConfirm =>
      'Ви впевнені, що хочете відключитись від цього пристрою?';

  @override
  String get login_repeaterLogin => 'Вхід у ретранслятор';

  @override
  String get login_roomLogin => 'Вхід у кімнату';

  @override
  String get login_password => 'Пароль';

  @override
  String get login_enterPassword => 'Введіть пароль';

  @override
  String get login_savePassword => 'Зберегти пароль';

  @override
  String get login_savePasswordSubtitle =>
      'Пароль буде надійно збережено на цьому пристрої.';

  @override
  String get login_repeaterDescription =>
      'Введіть пароль ретранслятора для доступу до налаштувань та статусу.';

  @override
  String get login_roomDescription =>
      'Введіть пароль кімнати для доступу до налаштувань та статусу.';

  @override
  String get login_routing => 'Маршрутизація';

  @override
  String get login_routingMode => 'Режим маршрутизації';

  @override
  String get login_autoUseSavedPath => 'Авто (збережений шлях)';

  @override
  String get login_forceFloodMode => 'Примусово через всю мережу';

  @override
  String get login_managePaths => 'Керувати шляхами';

  @override
  String get login_login => 'Вхід';

  @override
  String login_attempt(int current, int max) {
    return 'Спроба $current/$max';
  }

  @override
  String login_failed(String error) {
    return 'Вхід не вдався: $error';
  }

  @override
  String get login_failedMessage =>
      'Вхід не вдався. Або пароль неправильний, або ретранслятор недосяжний.';

  @override
  String get common_reload => 'Перезавантажити';

  @override
  String get common_clear => 'Очистити';

  @override
  String get path_currentPathLabel => 'Поточний шлях';

  @override
  String get path_noRepeatersFound =>
      'Ретрансляторів або серверів кімнат не знайдено.';

  @override
  String get repeater_management => 'Керування ретранслятором';

  @override
  String get room_management => 'Адміністрування сервера кімнати';

  @override
  String get repeater_guest => 'Інформація про ретранслятор';

  @override
  String get room_guest => 'Інформація про сервер кімнати';

  @override
  String get repeater_managementTools => 'Інструменти керування';

  @override
  String get repeater_guestTools => 'Гостьові інструменти';

  @override
  String get repeater_status => 'Статус';

  @override
  String get repeater_statusSubtitle =>
      'Показати статус, статистику та сусідів ретранслятора';

  @override
  String get repeater_telemetry => 'Телеметрія';

  @override
  String get repeater_telemetrySubtitle =>
      'Показати телеметрію сенсорів та статистику системи';

  @override
  String get repeater_cli => 'CLI (Command Line Interface)';

  @override
  String get repeater_cliSubtitle => 'Надіслати команди ретранслятору';

  @override
  String get repeater_neighbors => 'Сусіди';

  @override
  String get repeater_neighborsSubtitle =>
      'Показати сусідів, доступних без ретрансляції.';

  @override
  String get repeater_settings => 'Налаштування';

  @override
  String get repeater_settingsSubtitle => 'Налаштувати параметри ретранслятора';

  @override
  String get repeater_clockSyncAfterLogin => 'Синхронізація годин після входу';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      'Автоматично надсилати повідомлення \"синхронізація годин\" після успішного входу.';

  @override
  String get repeater_statusTitle => 'Статус ретранслятора';

  @override
  String get repeater_routingMode => 'Режим маршрутизації';

  @override
  String get repeater_refresh => 'Оновити';

  @override
  String get repeater_statusRequestTimeout =>
      'Час очікування запиту статусу вичерпано.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'Помилка завантаження статусу: $error';
  }

  @override
  String get repeater_systemInformation => 'Системна інформація';

  @override
  String get repeater_battery => 'Батарея';

  @override
  String get repeater_clockAtLogin => 'Годинник (при вході)';

  @override
  String get repeater_uptime => 'Час роботи';

  @override
  String get repeater_queueLength => 'Довжина черги';

  @override
  String get repeater_debugFlags => 'Прапорці налагодження';

  @override
  String get repeater_radioStatistics => 'Статистика радіо';

  @override
  String get repeater_lastRssi => 'Останній RSSI';

  @override
  String get repeater_lastSnr => 'Останній SNR';

  @override
  String get repeater_noiseFloor => 'Рівень шуму';

  @override
  String get repeater_txAirtime => 'Ефірний час TX';

  @override
  String get repeater_rxAirtime => 'Ефірний час RX';

  @override
  String get repeater_chanUtil => 'Використання каналу';

  @override
  String get repeater_packetStatistics => 'Статистика пакетів';

  @override
  String get repeater_sent => 'Надіслано';

  @override
  String get repeater_received => 'Отримано';

  @override
  String get repeater_duplicates => 'Дублікати';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days дн. $hours год $minutes хв $seconds с';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return 'Всього: $total, Через всю мережу: $flood, Прямі: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return 'Всього: $total, Через всю мережу: $flood, Прямі: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return 'Через всю мережу: $flood, Прямі: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return 'Всього: $total';
  }

  @override
  String get repeater_settingsTitle => 'Налаштування ретранслятора';

  @override
  String get repeater_basicSettings => 'Основні налаштування';

  @override
  String get repeater_repeaterName => 'Ім\'я ретранслятора';

  @override
  String get repeater_repeaterNameHelper =>
      'Показати ім\'я цього ретранслятора';

  @override
  String get repeater_adminPassword => 'Пароль адміністратора';

  @override
  String get repeater_adminPasswordHelper => 'Пароль повного доступу';

  @override
  String get repeater_guestPassword => 'Гостьовий пароль';

  @override
  String get repeater_guestPasswordHelper =>
      'Доступ лише для читання з паролем';

  @override
  String get repeater_radioSettings => 'Налаштування радіо';

  @override
  String get repeater_frequencyMhz => 'Частота (МГц)';

  @override
  String get repeater_frequencyHelper => '300-2500 МГц';

  @override
  String get repeater_txPower => 'Потужність TX';

  @override
  String get repeater_txPowerHelper => '1-30 дБм';

  @override
  String get repeater_bandwidth => 'Смуга пропускання';

  @override
  String get repeater_spreadingFactor => 'Коефіцієнт розширення';

  @override
  String get repeater_codingRate => 'Швидкість кодування';

  @override
  String get repeater_locationSettings => 'Налаштування геопозиції';

  @override
  String get repeater_latitude => 'Широта';

  @override
  String get repeater_latitudeHelper =>
      'Десяткові градуси (наприклад, 37.7749)';

  @override
  String get repeater_longitude => 'Довгота';

  @override
  String get repeater_longitudeHelper =>
      'Десяткові градуси (наприклад, -122.4194)';

  @override
  String get repeater_features => 'Функції';

  @override
  String get repeater_packetForwarding => 'Пересилання пакетів';

  @override
  String get repeater_packetForwardingSubtitle =>
      'Дозволити ретранслятору пересилати пакети';

  @override
  String get repeater_guestAccess => 'Гостьовий доступ';

  @override
  String get repeater_guestAccessSubtitle =>
      'Дозволити гостьовий доступ лише для читання';

  @override
  String get repeater_privacyMode => 'Режим приватності';

  @override
  String get repeater_privacyModeSubtitle =>
      'Приховати ім\'я/геопозицію в оголошеннях';

  @override
  String get repeater_advertisementSettings => 'Налаштування оголошень';

  @override
  String get repeater_localAdvertInterval =>
      'Інтервал локальних оголошень (без ретрансляції)';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes хвилин';
  }

  @override
  String get repeater_floodAdvertInterval =>
      'Інтервал оголошень через всю мережу (flood)';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours годин';
  }

  @override
  String get repeater_encryptedAdvertInterval =>
      'Інтервал зашифрованих оголошень';

  @override
  String get repeater_dangerZone => 'Небезпечна зона';

  @override
  String get repeater_rebootRepeater => 'Перезавантажити ретранслятор';

  @override
  String get repeater_rebootRepeaterSubtitle =>
      'Скинути пристрій ретранслятора';

  @override
  String get repeater_rebootRepeaterConfirm =>
      'Ви впевнені, що хочете перезавантажити цей ретранслятор?';

  @override
  String get repeater_regenerateIdentityKey =>
      'Перегенерувати ключ ідентифікації';

  @override
  String get repeater_regenerateIdentityKeySubtitle =>
      'Згенерувати нову пару ключів (публічний/приватний)';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'Це створить нову ідентифікацію для ретранслятора. Продовжити?';

  @override
  String get repeater_eraseFileSystem => 'Очистити файлову систему';

  @override
  String get repeater_eraseFileSystemSubtitle =>
      'Відформатувати файлову систему ретранслятора';

  @override
  String get repeater_eraseFileSystemConfirm =>
      'УВАГА: Це видалить всі дані з ретранслятора. Це не можна скасувати!';

  @override
  String get repeater_eraseSerialOnly =>
      'Очищення доступне лише через послідовну консоль.';

  @override
  String repeater_commandSent(String command) {
    return 'Команда надіслана: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'Помилка надсилання команди: $error';
  }

  @override
  String get repeater_confirm => 'Підтвердити';

  @override
  String get repeater_settingsSaved => 'Налаштування успішно збережено.';

  @override
  String get repeater_rxGain => 'Підвищена ефективність RX';

  @override
  String get repeater_rxGainHelper =>
      'Вища чутливість, більший струм споживання (тільки для SX1262/SX1268)';

  @override
  String get repeater_refreshRxGain => 'Оновіть підвищений прибуток від RX';

  @override
  String get repeater_multiAcks => 'Багато підтверджень';

  @override
  String get repeater_multiAcksSubtitle =>
      'Розпізнавайте повідомлення через різні канали для кращої доставки.';

  @override
  String get repeater_refreshMultiAcks => 'Оновити кілька підтверджень';

  @override
  String get repeater_networkHealth => 'Стан мережі';

  @override
  String get repeater_loopDetect => 'Виявлення циклів';

  @override
  String get repeater_loopDetectHelper =>
      'Створіть пакети, які імітують цикли маршрутизації.';

  @override
  String get repeater_loopDetectOff => 'Відключення';

  @override
  String get repeater_loopDetectMinimal => 'Мінімальний';

  @override
  String get repeater_loopDetectModerate => 'Помірний';

  @override
  String get repeater_loopDetectStrict => 'Суворий';

  @override
  String get repeater_dutyCycle => 'Цикл роботи';

  @override
  String get repeater_dutyCycleHelper =>
      'Максимальний відсоток часу, який може бути виділено для трансляції.';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => 'Інформація про оператора';

  @override
  String get repeater_ownerInfoHelper =>
      'Публічні метадані для цього ретранслятора';

  @override
  String get repeater_refreshOwnerInfo => 'Оновити інформацію про оператора';

  @override
  String get repeater_floodMax =>
      'Максимальна кількість стрибків під час повені';

  @override
  String get repeater_floodMaxHelper =>
      'Максимальна кількість хмелю, яку може містити один пакет (0-64)';

  @override
  String get repeater_advancedSettings => 'Просунутий';

  @override
  String get repeater_advancedSettingsSubtitle =>
      'Регулювальні ручки для досвідчених операторів';

  @override
  String get repeater_pathHashMode => 'Режим хешування шляху';

  @override
  String get repeater_pathHashModeHelper =>
      'Байти, що використовуються для кодування ідентифікатора цього ретранслятора в тегах flood-шляху/виявлення петель. 0=1 байт (256 ідентифікаторів, до 64 переходів), 1=2 байти (65 000 ідентифікаторів, до 32 переходів), 2=3 байти (16 мільйонів ідентифікаторів, до 21 переходу). Прошивки до v1.14 завжди використовували 1-байтові шляхи; v1.14 і новіші можна налаштувати на 2- або 3-байтові шляхи.';

  @override
  String get repeater_keySettings => 'Зміна ключів ідентифікації';

  @override
  String get repeater_keySettingsSubtitle =>
      'Замініть публічний/приватний ключ';

  @override
  String get repeater_prvKey => 'Приватний ключ';

  @override
  String get repeater_prvKeyHelper =>
      'Нова приватна ключ для репітера, 128-символова штучна штука в шестнадцатеричному форматі.';

  @override
  String get repeater_generatePrvKey => 'Синхронізujте ключовий пару';

  @override
  String get repeater_stopGeneratingPrvKey => 'Прервити шук ключового пару';

  @override
  String get repeater_pubKey => 'Публічна ключ';

  @override
  String get repeater_pubKeyHelper =>
      'Це публична ключ, який пов\'язано з створеною приватною ключом. Ви не можете встановлювати його напрямую.';

  @override
  String get repeater_pubKeyPrefix => 'Високорейтингове прикінання';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'Найдіть відповідний открытий ключ, який починається ціми шестнадцатыми цифрами. Ожидається кількість потрібних попыток: $tries.';
  }

  @override
  String get repeater_txDelay => 'Затримка у Flood, штат Техас';

  @override
  String get repeater_txDelayHelper =>
      'Повторне надсилання з урахуванням навантаження від потоків транспорту, як множник від часу передачі пакета (0-2, за замовчуванням 0,5). Чим вище значення, тим менше конфліктів, але повільніше передавання.';

  @override
  String get repeater_directTxDelay => 'Пряме затримка TX';

  @override
  String get repeater_directTxDelayHelper =>
      'Відновлення інтервалів для прямого (немасового) трафіку, як множник часу передачі пакета (від 0 до 2, за замовчуванням 0,3).';

  @override
  String get repeater_intThresh => 'Порогове значення перешкод';

  @override
  String get repeater_intThreshHelper =>
      'Порогове значення встановлено для калібрування шумового рівня радіо, щоб відхиляти сигнали, що перевищують цей рівень. 0 – вимкнено; активуйте лише у разі виявлення помилок RX у шумному діапазоні.';

  @override
  String get repeater_agcResetInterval => 'Інтервал перезавантаження AGC';

  @override
  String get repeater_agcResetIntervalHelper =>
      'Як часто потрібно скидати автоматичне регулювання гучності радіо, щоб відновити нормальну роботу після ситуації, коли гучність була заблокована. Кожні кілька секунд, зменшуючи значення до кратного 4. Вимкнення періодичного скидання.';

  @override
  String get repeater_actionsTitle => 'Дії';

  @override
  String get repeater_sendAdvert => 'Надіслати рекламу щодо повені';

  @override
  String get repeater_sendAdvertSubtitle =>
      'Розповсюдити рекламу про надзвичайну ситуацію (повен) через мережу.';

  @override
  String get repeater_sendAdvertZeroHop => 'Надіслати рекламу без посередників';

  @override
  String get repeater_sendAdvertZeroHopSubtitle =>
      'Розповсюдити рекламу з однією переадресацією (без повторного розповсюдження)';

  @override
  String get repeater_clockSync => 'Синхронізувати годинник зараз';

  @override
  String get repeater_clockSyncSubtitle =>
      'Передайте час вашого телефону на ретранслятор.';

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
      'Налаштування збережено — перезавантажте ретранслятор для застосування.';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return 'Деякі налаштування не вдалося застосувати: $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return 'Помилка збереження налаштувань: $error';
  }

  @override
  String get repeater_refreshBasicSettings => 'Оновити основні налаштування';

  @override
  String get repeater_refreshRadioSettings => 'Оновити налаштування радіо';

  @override
  String get repeater_refreshTxPower => 'Оновити потужність TX';

  @override
  String get repeater_refreshPacketForwarding => 'Оновити пересилання пакетів';

  @override
  String get repeater_refreshGuestAccess => 'Оновити гостьовий доступ';

  @override
  String get repeater_refreshPrivacyMode => 'Оновити режим приватності';

  @override
  String repeater_refreshed(String label) {
    return '$label оновлено';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return 'Помилка оновлення $label';
  }

  @override
  String get repeater_cliTitle => 'Ретранслятор CLI';

  @override
  String get repeater_debugNextCommand => 'Налагодити наступну команду';

  @override
  String get repeater_commandHelp => 'Довідка';

  @override
  String get repeater_clearHistory => 'Очистити історію';

  @override
  String get repeater_noCommandsSent => 'Команди ще не надсилалися.';

  @override
  String get repeater_typeCommandOrUseQuick =>
      'Введіть команду нижче або використовуйте швидкі команди';

  @override
  String get repeater_enterCommandHint => 'Введіть команду...';

  @override
  String get repeater_previousCommand => 'Попередня команда';

  @override
  String get repeater_nextCommand => 'Наступна команда';

  @override
  String get repeater_enterCommandFirst => 'Спершу введіть команду';

  @override
  String get repeater_cliCommandFrameTitle => 'Фрейм команди CLI';

  @override
  String repeater_cliCommandError(String error) {
    return 'Помилка: $error';
  }

  @override
  String get repeater_cliQuickGetName => 'Отримати ім\'я';

  @override
  String get repeater_cliQuickGetRadio => 'Отримати Радіо';

  @override
  String get repeater_cliQuickGetTx => 'Отримати TX';

  @override
  String get repeater_cliQuickNeighbors => 'Сусіди';

  @override
  String get repeater_cliQuickVersion => 'Версія';

  @override
  String get repeater_cliQuickAdvertise => 'Оголосити';

  @override
  String get repeater_cliQuickClock => 'Годинник';

  @override
  String get repeater_cliQuickClockSync => 'Синхронізація годинника';

  @override
  String get repeater_cliQuickDiscovery => 'Виявити сусідів';

  @override
  String get repeater_cliHelpAdvert => 'Надсилає пакет оголошення';

  @override
  String get repeater_cliHelpReboot =>
      'Перезавантажує пристрій. (Зверніть увагу, ви можете отримати «Тайм-аут», що є нормальним)';

  @override
  String get repeater_cliHelpClock =>
      'Відображає поточний час за годинником кожного пристрою.';

  @override
  String get repeater_cliHelpPassword =>
      'Встановлює новий пароль адміністратора для пристрою.';

  @override
  String get repeater_cliHelpVersion =>
      'Відображає версію пристрою та дату збірки прошивки.';

  @override
  String get repeater_cliHelpClearStats =>
      'Скидає різні лічильники статистики до нуля.';

  @override
  String get repeater_cliHelpSetAf => 'Встановлює коефіцієнт ефірного часу.';

  @override
  String get repeater_cliHelpSetTx =>
      'Встановлює потужність передачі LoRa в дБм (для застосування потрібне перезавантаження).';

  @override
  String get repeater_cliHelpSetRepeat =>
      'Вмикає або вимикає роль ретранслятора для цього вузла.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(Сервер кімнати) Якщо «увімкнено», порожній пароль дозволить вхід, але не дозволить публікувати в кімнаті. (тільки читання)';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'Встановлює максимальну кількість переходів для вхідних пакетів flood (якщо >= max, пакет не пересилається).';

  @override
  String get repeater_cliHelpSetIntThresh =>
      'Встановлює поріг інтерференції (в дБ). Значення за замовчуванням — 14. Встановлення на 0 вимикає виявлення інтерференції каналу.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'Встановлює інтервал скидання автоматичного контролера посилення (AGC). Встановіть 0 для вимкнення.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      'Вмикає або вимикає функціональність подвійних ACK.';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'Встановлює інтервал таймера для надсилання локального пакету оголошення (без ретрансляції). Встановіть 0 для вимкнення.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'Встановлює інтервал таймера в годинах для надсилання пакету оголошення через всю мережу. Встановіть 0 для вимкнення.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'Встановлює/оновлює гостьовий пароль. (для ретрансляторів гостьові підключення можуть надсилати запит «Get Stats»)';

  @override
  String get repeater_cliHelpSetName => 'Встановлює ім\'я для оголошення.';

  @override
  String get repeater_cliHelpSetLat =>
      'Встановлює широту для карти оголошень. (десяткові градуси)';

  @override
  String get repeater_cliHelpSetLon =>
      'Встановлює довготу для карти оголошень. (десяткові градуси)';

  @override
  String get repeater_cliHelpSetRadio =>
      'Повністю встановлює нові параметри радіо та зберігає їх у налаштуваннях. Потребує команди «перезавантаження» для застосування.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      'Базові (експериментальні) параметри для застосування невеликої затримки до отриманих пакетів залежно від сили сигналу/оцінки. Встановіть 0 для вимкнення.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      'Встановлює множник для часу роботи в режимі «через всю мережу» (flood) для пакету та системи випадкових слотів, щоб затримати його відправку (для зменшення ймовірності колізій).';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'Те саме, що й txdelay, але для застосування випадкової затримки при пересиланні пакетів у прямому режимі.';

  @override
  String get repeater_cliHelpSetBridgeEnabled => 'Увімкнути/Вимкнути міст.';

  @override
  String get repeater_cliHelpSetBridgeDelay =>
      'Встановити затримку перед пересиланням пакетів.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      'Виберіть, чи буде міст ретранслювати отримані пакети або передані пакети.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'Встановити швидкість послідовного зв\'язку для мостів Rs232.';

  @override
  String get repeater_cliHelpSetBridgeSecret =>
      'Встановити секрет мосту для мостів espnow.';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      'Встановлює власний множник для коригування повідомлюваної напруги батареї (підтримується лише на деяких платах).';

  @override
  String get repeater_cliHelpTempRadio =>
      'Встановлює тимчасові параметри радіо на задану кількість хвилин, потім повертається до початкових налаштувань. (не зберігає в налаштуваннях).';

  @override
  String get repeater_cliHelpSetPerm =>
      'Змінює ACL (список контролю доступу). Видаляє відповідний запис (за префіксом публічного ключа), якщо «permissions» дорівнює нулю. Додає новий запис, якщо hex публічного ключа повний і його немає в ACL. Оновлює запис на основі префікса публічного ключа. Біти дозволів залежать від ролі прошивки, але нижні 2 біти: 0 (Гість), 1 (Тільки читання), 2 (Читання/Запис), 3 (Адміністратор).';

  @override
  String get repeater_cliHelpGetBridgeType =>
      'Отримати тип мосту: немає, rs232, espnow';

  @override
  String get repeater_cliHelpLogStart =>
      'Починає запис пакетів у файлову систему.';

  @override
  String get repeater_cliHelpLogStop =>
      'Зупиняє запис пакетів у файлову систему.';

  @override
  String get repeater_cliHelpLogErase =>
      'Видаляє журнали пакетів з файлової системи.';

  @override
  String get repeater_cliHelpNeighbors =>
      'Показує список інших вузлів-ретрансляторів, почутих через оголошення без ретрансляції. Кожен рядок — id-hex-префікс:timestamp:snr-помножено-на-4';

  @override
  String get repeater_cliHelpNeighborRemove =>
      'Видаляє перший відповідний запис (за префіксом публічного ключа (hex)) зі списку сусідів.';

  @override
  String get repeater_cliHelpRegion =>
      '(тільки серійний) Перелічує всі визначені регіони та поточні дозволи на оголошення «через всю мережу» (flood).';

  @override
  String get repeater_cliHelpRegionLoad =>
      'ПРИМІТКА: це спеціальний виклик кількох команд. Кожна наступна команда — це назва регіону (з відступом пробілами для позначення ієрархії батьків, мінімум один пробіл). Завершується надсиланням порожнього рядка/команди.';

  @override
  String get repeater_cliHelpRegionGet =>
      'Шукає регіон із заданим префіксом назви (або «» для глобальної області). Відповідає: «-> ім\'я-регіону (ім\'я-батька) \'F\'»';

  @override
  String get repeater_cliHelpRegionPut =>
      'Додає або оновлює визначення регіону з заданою назвою.';

  @override
  String get repeater_cliHelpRegionRemove =>
      'Видаляє визначення регіону з заданою назвою.';

  @override
  String get repeater_cliHelpRegionAllowf =>
      'Встановлює дозвіл «Flood» для заданого регіону. (\'\' для глобальної/успадкованої області)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      'Видаляє дозвіл «Flood» для заданого регіону. (ПРИМІТКА: на даному етапі не рекомендується використовувати для глобальної/успадкованої області!! )';

  @override
  String get repeater_cliHelpRegionHome =>
      'Відповідає поточним «домашнім» регіоном. (Примітка: поки ніде не застосовується, зарезервовано для майбутнього використання)';

  @override
  String get repeater_cliHelpRegionHomeSet => 'Встановлює «домашній» регіон.';

  @override
  String get repeater_cliHelpRegionSave =>
      'Зберігає список/карту регіонів у сховищі.';

  @override
  String get repeater_cliHelpGps =>
      'Показує статус GPS. Коли GPS вимкнено, відповідає лише «вимкнено», якщо увімкнено — відповідає «увімкнено», статус, корекція, кількість супутників.';

  @override
  String get repeater_cliHelpGpsOnOff => 'Увімкнути/вимкнути GPS.';

  @override
  String get repeater_cliHelpGpsSync =>
      'Синхронізує час вузла з годинником GPS.';

  @override
  String get repeater_cliHelpGpsSetLoc =>
      'Встановлює позицію вузла за координатами GPS і зберігає в налаштуваннях.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'Надає конфігурацію оголошення геопозиції вузла:\n- none : не включати геопозицію в оголошення\n- share : ділитись геопозицією GPS (з SensorManager)\n- prefs : оголошувати геопозицію, збережену в налаштуваннях';

  @override
  String get repeater_cliHelpGpsAdvertSet =>
      'Встановлює конфігурацію оголошення геопозиції.';

  @override
  String get repeater_commandsListTitle => 'Список команд';

  @override
  String get repeater_commandsListNote =>
      'ПРИМІТКА: для різних команд «set»... також існує команда «get»...';

  @override
  String get repeater_general => 'Загальні';

  @override
  String get repeater_settingsCategory => 'Налаштування';

  @override
  String get repeater_bridge => 'Міст';

  @override
  String get repeater_logging => 'Журналювання';

  @override
  String get repeater_neighborsRepeaterOnly => 'Сусіди (Тільки ретранслятор)';

  @override
  String get repeater_regionManagementRepeaterOnly =>
      'Керування регіонами (Тільки ретранслятор)';

  @override
  String get repeater_regionNote =>
      'Команди регіонів були введені для керування визначеннями та дозволами регіонів.';

  @override
  String get repeater_gpsManagement => 'Керування GPS';

  @override
  String get repeater_gpsNote =>
      'Команда GPS була введена для керування питаннями, пов\'язаними з локацією.';

  @override
  String get repeater_getCategory => 'Отримати цінності';

  @override
  String get repeater_powerMgmt => 'Управління енергоспоживанням';

  @override
  String get repeater_sensors => 'Датчики';

  @override
  String get repeater_cliHelpPowerOff =>
      'Вмикає живлення пристрою. (очікується відсутність відповіді)';

  @override
  String get repeater_cliHelpClkReboot =>
      'Скидає годинник до відомої епохи та перезавантажує пристрій.';

  @override
  String get repeater_cliHelpAdvertZeroHop =>
      'Надсилає рекламу, яка не проходить через інші мережі (лише до безпосередніх сусідів).';

  @override
  String get repeater_cliHelpStartOta =>
      'Запускає оновлення прошивки безпосередньо через повітря на сумісних платах.';

  @override
  String get repeater_cliHelpTime =>
      'Встановлює час пристрою відповідно до заданих секунд від початку епохи Unix. Час не може відкачуватися назад.';

  @override
  String get repeater_cliHelpBoard =>
      'Показує виробника/ідентифікатор обладнання.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      'Відправляє запит на виявлення сусідніх вузлів. (Тільки для повторювачів)';

  @override
  String get repeater_cliHelpPowersaving =>
      'Показує, чи увімкнено режим енергозбереження, чи ні.';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      'Увімкне або вимкне режим енергозбереження (якщо підтримується).';

  @override
  String get repeater_cliHelpErase =>
      '(Тільки для серійного використання) Форматує файлову систему пристрою. Видаляє всі налаштування та контакти.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      'Встановлює максимальний допустимий цикл передавання як відсоток (від 1 до 100). Автоматично коригує коефіцієнт використання часу.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '(Тільки для серійного використання) Замінює приватний ключ ідентифікації пристрою. Необхідне перезавантаження для застосування. Генерує новий публічний ключ.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(Тільки для SX126x) Увімкнення посиленого рівня RX для покращення чутливості при високому споживанні струму.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      'Вказує рядок з контактною інформацією власника, який вказано в оголошеннях. Використовуйте \'|\' для переходу на новий рядок.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'Встановлює режим хешування шляху. 0 = для старих систем, 1 = для стандартних, 2 = для суворих. Впливає на те, як маршрути порівнюються.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'Встановлює чутливість виявлення циклів маршрутизації: вимкнено, мінімальну, помірну або жорстку.';

  @override
  String get repeater_cliHelpSetFreq =>
      '(Тільки для серійного пристрою) Швидко встановлює лише частоту. Потрібно перезавантажити. Рекомендується використовувати функцію \"налаштування радіо\", щоб задати всі параметри радіо.';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(Тільки для мосту ESPNow) Встановлює канал Wi-Fi (від 1 до 14), який використовується мостом.';

  @override
  String get repeater_cliHelpGetName =>
      'Показує назву узла, яка була налаштована.';

  @override
  String get repeater_cliHelpGetRole =>
      'Показує роль прошивки (ретранслятор, сервер кімнати тощо).';

  @override
  String get repeater_cliHelpGetPublicKey =>
      'Відображає публічний ключ пристрою.';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '(Тільки для серійного використання) Показує приватний ключ пристрою. Розглядайте його як секретну інформацію.';

  @override
  String get repeater_cliHelpGetRepeat =>
      'Показує, чи активна функція перенаправлення пакетів (роль повторювача).';

  @override
  String get repeater_cliHelpGetTx =>
      'Показує потожну потужність передавача в децибелах (dBm).';

  @override
  String get repeater_cliHelpGetFreq =>
      'Показує налаштовану радіочастоту в мегагерцах (MHz).';

  @override
  String get repeater_cliHelpGetRadio =>
      'Показує повні параметри радіосигналу: частоту, смугу пропускання, коефіцієнт модуляції, швидкість кодування.';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(Тільки для SX126x) Показує стан посилення сигналу RX.';

  @override
  String get repeater_cliHelpGetAf =>
      'Показує поточний коефіцієнт часу трансляції.';

  @override
  String get repeater_cliHelpGetDutyCycle =>
      'Показує поточний допустимий цикл роботи як відсоток.';

  @override
  String get repeater_cliHelpGetIntThresh =>
      'Показує поріг перешкод каналу в децибелах.';

  @override
  String get repeater_cliHelpGetAgcResetInterval =>
      'Показує інтервал перезавантаження AGC у секундах.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      'Показує, чи увімкнено режим подвійного підтвердження (1) або вимкнено (0).';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'Показує, чи дозволено лише читання для гостей.';

  @override
  String get repeater_cliHelpGetAdvertInterval =>
      'Показує тривалість місцевої рекламної паузи в хвилинах.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'Показує інтервал часу між рекламними роликами про повені, виражений у годинах.';

  @override
  String get repeater_cliHelpGetGuestPassword =>
      'Відображає налаштований пароль для гостей.';

  @override
  String get repeater_cliHelpGetLat => 'Відображає задану широту.';

  @override
  String get repeater_cliHelpGetLon => 'Відображає задану довготу.';

  @override
  String get repeater_cliHelpGetRxDelay =>
      'Відображає базове значення rxdelay.';

  @override
  String get repeater_cliHelpGetTxDelay =>
      'Показує коефіцієнт затримки сигналу у режимі затоплення.';

  @override
  String get repeater_cliHelpGetDirectTxDelay =>
      'Показує коефіцієнт затримки сигналу в режимі прямого зв\'язку.';

  @override
  String get repeater_cliHelpGetFloodMax =>
      'Показує максимальну кількість підйомів, спричинених повенем.';

  @override
  String get repeater_cliHelpGetOwnerInfo =>
      'Відображає рядок з контактною інформацією власника.';

  @override
  String get repeater_cliHelpGetPathHashMode =>
      'Відображає режим хешування шляху (0/1/2).';

  @override
  String get repeater_cliHelpGetLoopDetect =>
      'Демонструє чутливість до виявлення циклів.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(Тільки для серій) Перераховує записи контролю доступу на репітері.';

  @override
  String get repeater_cliHelpGetBridgeEnabled =>
      'Показує, чи увімкнено цей міст.';

  @override
  String get repeater_cliHelpGetBridgeDelay =>
      'Показує затримку мосту в мілісекундах.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'Показує, чи маршрутизує міст пакети RX або TX.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(Тільки для мосту RS232) Показує швидкість передачі даних на мосту.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(Тільки для мосту ESPNow) Показує канал WiFi мосту.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(Тільки для мосту ESPNow) Показує секрет, який використовується для зв\'язку.';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '(Тільки для NRF52) Показує версію завантажувача.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'Відображає коефіцієнт множення аналого-цифрового перетворювача (масштабування напруги від батареї).';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      'Показує, чи має рада директорів підтримку в управлінні енергоспоживанням.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      'Показує поточне джерело живлення: зовнішнє або акумуляторне.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      'Показує останні причини перезавантаження та вимкнення.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv =>
      'Показує напругу акумулятора під час запуску системи в мілівольтах (мВ).';

  @override
  String get repeater_cliHelpSensorGet =>
      'Читає налаштування датчика, вказане за допомогою ключа.';

  @override
  String get repeater_cliHelpSensorSet =>
      'Створює налаштування для спеціального датчика.';

  @override
  String get repeater_cliHelpSensorList =>
      'Перераховує всі налаштування користувацьких датчиків, розділені на сторінки, починаючи з опціонального індексу початку.';

  @override
  String get repeater_cliHelpRegionDefault =>
      'Показує поточний область дії за замовчуванням.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'Встановлює значення регіону за замовчуванням. Використовуйте \"<null>\", щоб очистити.';

  @override
  String get repeater_cliHelpRegionListAllowed =>
      'Перелік регіонів, де дозволено рух транспорту під час повені.';

  @override
  String get repeater_cliHelpRegionListDenied =>
      'Перелік регіонів, які забороняють рух транспорту під час повені.';

  @override
  String get repeater_cliHelpStatsPackets =>
      '(Тільки для серійного використання) Відображає статистику на рівні пакетів.';

  @override
  String get repeater_cliHelpStatsRadio =>
      '(Тільки для серій) Відображає радіостатистику.';

  @override
  String get repeater_cliHelpStatsCore =>
      '(Тільки для серійного використання) Відображає основні статистичні дані про програмне забезпечення.';

  @override
  String get telemetry_receivedData => 'Дані телеметрії отримано';

  @override
  String get telemetry_requestTimeout => 'Час запиту телеметрії вичерпано.';

  @override
  String telemetry_errorLoading(String error) {
    return 'Помилка завантаження телеметрії: $error';
  }

  @override
  String get telemetry_noData => 'Дані телеметрії недоступні.';

  @override
  String telemetry_channelTitle(int channel) {
    return 'Канал $channel';
  }

  @override
  String get telemetry_batteryLabel => 'Батарея';

  @override
  String get telemetry_voltageLabel => 'Напруга';

  @override
  String get telemetry_mcuTemperatureLabel => 'Температура MCU';

  @override
  String get telemetry_temperatureLabel => 'Температура';

  @override
  String get telemetry_currentLabel => 'Поточний струм';

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
  String get telemetry_digitalInputLabel => 'Цифровий вхід';

  @override
  String get telemetry_digitalOutputLabel => 'Цифровий вихід';

  @override
  String get telemetry_analogInputLabel => 'Аналоговий вхід';

  @override
  String get telemetry_analogOutputLabel => 'Аналоговий вихід';

  @override
  String get telemetry_genericLabel => 'Загальний датчик';

  @override
  String get telemetry_luminosityLabel => 'Освітленість';

  @override
  String get telemetry_presenceLabel => 'Присутність';

  @override
  String get telemetry_humidityLabel => 'Вологість';

  @override
  String get telemetry_accelerometerLabel => 'Акселерометр';

  @override
  String get telemetry_pressureLabel => 'Тиск';

  @override
  String get telemetry_altitudeLabel => 'Висота';

  @override
  String get telemetry_frequencyLabel => 'Частота';

  @override
  String get telemetry_percentageLabel => 'Відсоток';

  @override
  String get telemetry_concentrationLabel => 'Концентрація';

  @override
  String get telemetry_powerLabel => 'Потужність';

  @override
  String get telemetry_distanceLabel => 'Відстань';

  @override
  String get telemetry_energyLabel => 'Енергія';

  @override
  String get telemetry_directionLabel => 'Напрямок';

  @override
  String get telemetry_timeLabel => 'Час';

  @override
  String get telemetry_gyrometerLabel => 'Гірометр';

  @override
  String get telemetry_colourLabel => 'Колір';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'Перемикач';

  @override
  String get telemetry_polylineLabel => 'Полілінія';

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
    return '$kilowattHours кВт⋅год';
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
  String get telemetry_autoFetchQuantity => 'Кількість запитів';

  @override
  String get telemetry_error => 'Не вдалося отримати дані';

  @override
  String get neighbors_receivedData => 'Дані сусідів отримано';

  @override
  String get neighbors_requestTimedOut => 'Час запиту сусідів вичерпано.';

  @override
  String neighbors_errorLoading(String error) {
    return 'Помилка завантаження сусідів: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => 'Ретранслятори-сусіди';

  @override
  String get neighbors_noData => 'Дані про сусідів недоступні.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return 'Невідомий відкритий ключ $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return 'Почуто: $time тому';
  }

  @override
  String get channelPath_title => 'Шлях пакету';

  @override
  String get channelPath_viewMap => 'Показати карту';

  @override
  String get channelPath_otherObservedPaths => 'Інші спостережувані шляхи';

  @override
  String get channelPath_repeaterHops => 'Переходи через ретранслятори';

  @override
  String get channelPath_noHopDetails =>
      'Деталі відправки не надані для цього пакету.';

  @override
  String get channelPath_sourceLabel => 'Джерело';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'Це повідомлення надійшло через MQTT. Ваше радіо його не чуло, тому радіомаршруту від вашого радіо немає.';

  @override
  String get channelPath_messageDetails => 'Деталі повідомлення';

  @override
  String get channelPath_senderLabel => 'Відправник';

  @override
  String get channelPath_timeLabel => 'Час';

  @override
  String get channelPath_repeatsLabel => 'Повторення';

  @override
  String channelPath_pathLabel(int index) {
    return 'Шлях $index';
  }

  @override
  String get channelPath_observedLabel => 'Спостережено';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return 'Спостережуваний шлях $index • $hops';
  }

  @override
  String get channelPath_noLocationData => 'Немає даних про геопозицію';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => 'Невідомий';

  @override
  String get channelPath_floodPath => 'Через всю мережу';

  @override
  String get channelPath_directPath => 'Напряму';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 з $total переходів';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed з $total переходів';
  }

  @override
  String get channelPath_mapTitle => 'Карта шляху';

  @override
  String get channelPath_noRepeaterLocations =>
      'Позиції ретрансляторів недоступні для цього шляху.';

  @override
  String channelPath_primaryPath(int index) {
    return 'Шлях $index (Основний)';
  }

  @override
  String get channelPath_pathLabelTitle => 'Шлях';

  @override
  String get channelPath_observedPathHeader => 'Спостережуваний шлях';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable =>
      'Деталі переходів недоступні для цього пакету.';

  @override
  String get channelPath_unknownRepeater => 'Невідомий ретранслятор';

  @override
  String get community_title => 'Спільнота';

  @override
  String get community_create => 'Створити спільноту';

  @override
  String get community_createDesc =>
      'Створити нову спільноту та поділитись через QR-код.';

  @override
  String get community_join => 'Приєднатись';

  @override
  String get community_joinTitle => 'Приєднатись до спільноти';

  @override
  String community_joinConfirmation(String name) {
    return 'Ви бажаєте приєднатись до спільноти «$name»?';
  }

  @override
  String get community_scanQr => 'Сканувати QR спільноти';

  @override
  String get community_scanInstructions =>
      'Наведіть камеру на QR-код спільноти.';

  @override
  String get community_showQr => 'Показати QR-код';

  @override
  String get community_publicChannel => 'Публічна спільнота';

  @override
  String get community_hashtagChannel => 'Хештег спільноти';

  @override
  String get community_name => 'Назва спільноти';

  @override
  String get community_enterName => 'Введіть назву спільноти';

  @override
  String community_created(String name) {
    return 'Спільноту «$name» створено';
  }

  @override
  String community_joined(String name) {
    return 'Приєднався до спільноти «$name»';
  }

  @override
  String get community_qrTitle => 'Поділитись спільнотою';

  @override
  String community_qrInstructions(String name) {
    return 'Відскануйте цей QR-код, щоб приєднатись до $name';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'Хештег-канали спільноти доступні лише членам спільноти';

  @override
  String get community_invalidQrCode => 'Недійсний QR-код спільноти';

  @override
  String get community_alreadyMember => 'Вже учасник';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'Ви вже є учасником «$name».';
  }

  @override
  String get community_addPublicChannel => 'Додати публічний канал спільноти';

  @override
  String get community_addPublicChannelHint =>
      'Автоматично додати публічний канал для цієї спільноти';

  @override
  String get community_noCommunities => 'Поки не приєднано до жодної групи.';

  @override
  String get community_scanOrCreate =>
      'Відскануйте QR-код або створіть спільноту, щоб почати';

  @override
  String get community_manageCommunities => 'Керувати спільнотами';

  @override
  String get community_delete => 'Покинути спільноту';

  @override
  String community_deleteConfirm(String name) {
    return 'Покинути «$name»?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'каналів',
      many: 'каналів',
      few: 'канали',
      one: 'канал',
    );
    return 'Це також видалить $count $_temp0 та їх повідомлення.';
  }

  @override
  String community_deleted(String name) {
    return 'Спільноту «$name» покинуто';
  }

  @override
  String get community_regenerateSecret => 'Перегенерувати секретний ключ';

  @override
  String community_regenerateSecretConfirm(String name) {
    return 'Перегенерувати секретний ключ для «$name»? Усі учасники матимуть відсканувати новий QR-код, щоб продовжити спілкування.';
  }

  @override
  String get community_regenerate => 'Перегенерувати';

  @override
  String community_secretRegenerated(String name) {
    return 'Секретний ключ для «$name» перегенеровано';
  }

  @override
  String get community_updateSecret => 'Оновити секретний ключ';

  @override
  String community_secretUpdated(String name) {
    return 'Секретний ключ для «$name» оновлено';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return 'Відскануйте новий QR-код, щоб оновити секретний ключ для «$name»';
  }

  @override
  String get community_addHashtagChannel => 'Додати хештег спільноти';

  @override
  String get community_addHashtagChannelDesc =>
      'Додати хештег-канал для цієї спільноти';

  @override
  String get community_selectCommunity => 'Вибрати спільноту';

  @override
  String get community_regularHashtag => 'Звичайний хештег';

  @override
  String get community_regularHashtagDesc =>
      'Публічний хештег (будь-хто може приєднатись)';

  @override
  String get community_communityHashtag => 'Хештег спільноти';

  @override
  String get community_communityHashtagDesc =>
      'Ексклюзивно для членів спільноти';

  @override
  String community_forCommunity(String name) {
    return 'Для $name';
  }

  @override
  String get listFilter_tooltip => 'Фільтр та сортування';

  @override
  String get listFilter_sortBy => 'Сортувати за';

  @override
  String get listFilter_latestMessages => 'Останні повідомлення';

  @override
  String get listFilter_heardRecently => 'Нещодавно почуті';

  @override
  String get listFilter_az => 'А-Я';

  @override
  String get listFilter_filters => 'Фільтри';

  @override
  String get listFilter_all => 'Все';

  @override
  String get listFilter_favorites => 'Улюблені';

  @override
  String get listFilter_addToFavorites => 'Додати до улюблених';

  @override
  String get listFilter_removeFromFavorites => 'Видалити зі списку улюблених';

  @override
  String get listFilter_users => 'Користувачі';

  @override
  String get listFilter_repeaters => 'Ретранслятори';

  @override
  String get listFilter_roomServers => 'Сервери кімнат';

  @override
  String get listFilter_unreadOnly => 'Тільки непрочитані повідомлення';

  @override
  String get listFilter_newGroup => 'Нова група';

  @override
  String get pathTrace_you => 'Ви';

  @override
  String get pathTrace_failed => 'Відстеження шляху не вдалось.';

  @override
  String get pathTrace_notAvailable => 'Трасування шляху недоступне.';

  @override
  String get pathTrace_refreshTooltip => 'Оновити трасування шляху';

  @override
  String get pathTrace_someHopsNoLocation =>
      'Один або декілька переходів не мають даних про геопозицію!';

  @override
  String get pathTrace_clearTooltip => 'Очистити шлях';

  @override
  String get losSelectStartEnd =>
      'Виберіть початковий і кінцевий вузли для LOS.';

  @override
  String losRunFailed(String error) {
    return 'Помилка перевірки прямої видимості: $error';
  }

  @override
  String get losClearAllPoints => 'Очистити всі пункти';

  @override
  String get losRunToViewElevationProfile =>
      'Запустіть LOS, щоб переглянути профіль висоти';

  @override
  String get losMenuTitle => 'Меню LOS';

  @override
  String get losMenuSubtitle =>
      'Торкніться вузлів або утримуйте карту, щоб отримати власні точки';

  @override
  String get losShowDisplayNodes => 'Показати вузли відображення';

  @override
  String get losCustomPoints => 'Користувальницькі точки';

  @override
  String losCustomPointLabel(int index) {
    return 'Власна точка $index';
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
  String get losRun => 'Запустіть LOS';

  @override
  String get losNoElevationData => 'Немає даних про висоту';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, чистий LOS, мінімальний зазор $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, заблоковано $obstruction $heightUnit';
  }

  @override
  String get losStatusChecking => 'LOS: перевірка...';

  @override
  String get losStatusNoData => 'LOS: немає даних';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS: $clear/$total очищено, $blocked заблоковано, $unknown невідомо';
  }

  @override
  String get losErrorElevationUnavailable =>
      'Дані про висоту недоступні для одного чи кількох зразків.';

  @override
  String get losErrorInvalidInput =>
      'Недійсні дані про точки/висоту для розрахунку LOS.';

  @override
  String get losRenameCustomPoint => 'Перейменувати власну точку';

  @override
  String get losPointName => 'Назва точки';

  @override
  String get losShowPanelTooltip => 'Показати панель LOS';

  @override
  String get losHidePanelTooltip => 'Приховати панель LOS';

  @override
  String get losElevationAttribution =>
      'Дані про висоту: Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'Радіогоризонт';

  @override
  String get losLegendLosBeam => 'Лінія прямої видимості';

  @override
  String get losLegendTerrain => 'Рельєф';

  @override
  String get losBlockedSpotsTitle => 'Заблоковані місця';

  @override
  String get losBlockedSpotsHint =>
      'Натисніть на заблоковане місце, щоб виділити його на карті.';

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
  String get losSelectedObstructionTitle => 'Вибраний об\'єкт перешкоди';

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
  String get losFrequencyInfoTooltip => 'Переглянути деталі розрахунку';

  @override
  String get losFrequencyDialogTitle => 'Розрахунок радіогоризонту';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'Починаючи з k=$baselineK на $baselineFreq МГц, обчислення коригує k-фактор для поточного діапазону $frequencyMHz МГц, який визначає викривлену межу радіогоризонту.';
  }

  @override
  String get contacts_pathTrace => 'Трасування шляхів';

  @override
  String get contacts_ping => 'Пінгувати';

  @override
  String get contacts_repeaterPathTrace => 'Трасування шляху до ретранслятора';

  @override
  String get contacts_repeaterPing => 'Пінгувати ретранслятор';

  @override
  String get contacts_roomPathTrace => 'Трасування шляху до серверу кімнати';

  @override
  String get contacts_roomPing => 'Пінг сервера кімнати';

  @override
  String get contacts_chatTraceRoute => 'Трасування шляху';

  @override
  String contacts_pathTraceTo(String name) {
    return 'Відстежити маршрут до $name';
  }

  @override
  String get contacts_clipboardEmpty => 'Буфер обміну порожній';

  @override
  String get contacts_invalidAdvertFormat => 'Недійсні контактні дані';

  @override
  String get contacts_contactImported => 'Контакт було імпортовано.';

  @override
  String get contacts_contactImportFailed => 'Контакт не вдалось імпортувати';

  @override
  String get contacts_zeroHopAdvert => 'Оголошення без ретрансляції';

  @override
  String get contacts_floodAdvert => 'Оголошення з ретрансляцією';

  @override
  String get contacts_copyAdvertToClipboard => 'Копіювати оголошення';

  @override
  String get contacts_addContactFromClipboard => 'Додати контакт з буфера';

  @override
  String get contacts_ShareContact => 'Копіювати контакт у буфер обміну';

  @override
  String get contacts_ShareContactZeroHop =>
      'Поділитись контактом за оголошенням';

  @override
  String get contacts_zeroHopContactAdvertSent =>
      'Відправлено контакт за оголошенням';

  @override
  String get contacts_zeroHopContactAdvertFailed =>
      'Не вдалось надіслати контакт.';

  @override
  String get contacts_contactAdvertCopied =>
      'Оголошення скопійовано до буфера обміну.';

  @override
  String get contacts_contactAdvertCopyFailed =>
      'Копіювання оголошення в буфер обміну завершилось невдало';

  @override
  String get notification_activityTitle => 'Активність MeshCore';

  @override
  String notification_messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'повідомлень',
      many: 'повідомлень',
      few: 'повідомлення',
      one: 'повідомлення',
    );
    return '$count $_temp0';
  }

  @override
  String notification_channelMessagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'повідомлень каналу',
      many: 'повідомлень каналу',
      few: 'повідомлення каналу',
      one: 'повідомлення каналу',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'нових вузлів',
      many: 'нових вузлів',
      few: 'нові вузли',
      one: 'новий вузол',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return 'Виявлено новий $contactType';
  }

  @override
  String get notification_receivedNewMessage => 'Отримано нове повідомлення';

  @override
  String get settings_gpxExportRepeaters =>
      'Експорт ретрансляторів і серверів кімнат у GPX';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'Експортує ретранслятори та сервери кімнат з геопозицією у файл GPX.';

  @override
  String get settings_gpxExportContacts => 'Експорт контактів у GPX';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'Експортує контакти з геопозицією у файл GPX.';

  @override
  String get settings_gpxExportAll => 'Експорт усіх контактів у GPX';

  @override
  String get settings_gpxExportAllSubtitle =>
      'Експортує всі контакти з геопозицією у файл GPX.';

  @override
  String get settings_gpxExportSuccess => 'Успішно експортовано файл GPX.';

  @override
  String get settings_gpxExportNoContacts => 'Немає контактів для експорту.';

  @override
  String get settings_gpxExportNotAvailable =>
      'Не підтримується на вашому пристрої/операційній системі';

  @override
  String get settings_gpxExportError => 'Сталась помилка під час експорту.';

  @override
  String get settings_gpxExportRepeatersRoom =>
      'Геопозиції ретрансляторів та серверів кімнат';

  @override
  String get settings_gpxExportChat => 'Геопозиції контактів';

  @override
  String get settings_gpxExportAllContacts => 'Усі місця контактів';

  @override
  String get settings_gpxExportShareText =>
      'Дані карти експортовані з NOTORYX Core';

  @override
  String get settings_gpxExportShareSubject =>
      'експорт даних карти NOTORYX Core у форматі GPX';

  @override
  String get snrIndicator_nearByRepeaters => 'Найближчі ретранслятори';

  @override
  String get snrIndicator_lastSeen => 'Останній раз бачили';

  @override
  String get contactsSettings_title => 'Налаштування контактів';

  @override
  String get contactsSettings_autoAddTitle => 'Автоматичне виявлення';

  @override
  String get contactsSettings_otherTitle =>
      'Інші налаштування, пов\'язані з контактами';

  @override
  String get contactsSettings_autoAddUsersTitle =>
      'Автоматично додавати користувачів';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      'Дозволити пристрою-компаньйону автоматично додавати виявлених користувачів';

  @override
  String get contactsSettings_autoAddRepeatersTitle =>
      'Автоматично додавати ретранслятори';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      'Дозволити пристрою-компаньйону автоматично додавати виявлені ретранслятори';

  @override
  String get contactsSettings_autoAddRoomServersTitle =>
      'Автоматично додавати сервери кімнат';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      'Дозволити пристрою-компаньйону автоматично додавати виявлені сервери кімнат.';

  @override
  String get contactsSettings_autoAddSensorsTitle =>
      'Автоматично додавати сенсори';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      'Дозволити пристрою-компаньйону автоматично додавати виявлені сенсори';

  @override
  String get contactsSettings_overwriteOldestTitle => 'Перезаписати найстаріше';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      'Коли список контактів заповнений, найстарший контакт без позначки улюбленого буде замінений.';

  @override
  String get discoveredContacts_Title => 'Виявлені контакти';

  @override
  String get discoveredContacts_noMatching =>
      'Відповідних контактів не знайдено';

  @override
  String get discoveredContacts_searchHint => 'Знайти виявлені контакти';

  @override
  String get discoveredContacts_contactAdded => 'Контакт додано';

  @override
  String get discoveredContacts_addContact => 'Додати контакт';

  @override
  String get discoveredContacts_copyContact =>
      'Копіювати контакт у буфер обміну';

  @override
  String get discoveredContacts_deleteContact => 'Видалити контакт';

  @override
  String get discoveredContacts_deleteContactAll =>
      'Видалити всі виявлені контакти';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      'Ви впевнені, що хочете видалити всі виявлені контакти?';

  @override
  String get chat_sendCooldown =>
      'Будь ласка, зачекайте трохи, перш ніж відправляти знову.';

  @override
  String get appSettings_jumpToOldestUnread =>
      'Перейти до найстарішого непрочитаного повідомлення';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      'При відкритті чату з непрочитаними повідомленнями, прокрутіть до першого непрочитаного повідомлення, а не до останнього.';

  @override
  String get appSettings_languageHu => 'Угорська';

  @override
  String get appSettings_languageJa => 'Японська';

  @override
  String get appSettings_languageKo => 'Корейська';

  @override
  String get radioStats_tooltip => 'Статистика радіо та мережі';

  @override
  String get radioStats_screenTitle => 'Статистика радіо';

  @override
  String get radioStats_notConnected =>
      'Підключіться до пристрою, щоб переглядати статистику радіо.';

  @override
  String get radioStats_firmwareTooOld =>
      'Статистика радіо вимагає прошивки пристрою-компаньйона версії 8 або новішої.';

  @override
  String get radioStats_waiting => 'Очікування даних…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'Рівень шуму: $noiseDbm дБм';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return 'Останній показник RSSI: $rssiDbm дБм';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return 'Останній показник SNR: $snr дБ';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'Час в ефірі TX (загальний): $seconds секунд';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'Час в ефірі RX (загальний): $seconds секунд';
  }

  @override
  String get radioStats_chartCaption =>
      'Рівень шуму (дБм) на основі останніх вимірювань.';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'Рівень шуму: $noiseDbm дБм';
  }

  @override
  String get radioStats_stripWaiting => 'Отримано статистику радіо…';

  @override
  String get radioStats_settingsTile => 'Статистика радіо';

  @override
  String get radioStats_settingsSubtitle =>
      'Рівень шуму, RSSI, SNR та час в ефірі.';

  @override
  String get translation_title => 'Переклад';

  @override
  String get imageMessages_enableTitle => 'Підтримка зображень для посилання';

  @override
  String get imageMessages_enableSubtitle =>
      'Пошукуєте изображення через сеть. Вимagaєте однократне скачання моделю изображення.';

  @override
  String get imageMessages_modelSectionTitle => 'Модель для зображень';

  @override
  String get imageMessages_downloadModel => 'Скачання';

  @override
  String get imageMessages_cancelDownload => 'Завершити';

  @override
  String get imageMessages_removeModel => 'Видалим модель';

  @override
  String get imageMessages_modelReady => 'Готово';

  @override
  String get imageMessages_modelNotPublished =>
      'Щоб не було опубліковано — це версія не дозволяє зробити скачання.';

  @override
  String get imageMessages_downloadFailed =>
      'Модель для зображень не можна сказати.';

  @override
  String get imageMessages_autoProcessTitle => 'Автоматично оброблювати obraзи';

  @override
  String get imageMessages_autoProcessSubtitle =>
      'Кожна картинка повинні бути відтворена на мій момент прибуття. Використовує приблизно 2 ГБ пам\'яті на кожен раз; відключіть від відтворення за допомогою кlikу.';

  @override
  String get translation_enableTitle => 'Увімкнути переклад';

  @override
  String get translation_enableSubtitle =>
      'Перекладати отримані повідомлення та дозволяти попередній переклад перед відправкою.';

  @override
  String get translation_composerTitle => 'Перекладіть перед відправкою';

  @override
  String get translation_composerSubtitle =>
      'Контролює стан ікон перекладу, який використовується за замовчуванням.';

  @override
  String get translation_autoIncomingTitle =>
      'Автоматично перекладати повідомлення';

  @override
  String get translation_autoIncomingSubtitle =>
      'Автоматично перекладає повідомлення для сповіщень, а також для чатів і каналів.';

  @override
  String get translation_translateMessage => 'Перекласти повідомлення';

  @override
  String get translation_targetLanguage => 'Цільова мова';

  @override
  String get translation_useAppLanguage => 'Використовувати мову застосунку';

  @override
  String get translation_downloadedModelLabel => 'Завантажений шаблон';

  @override
  String get translation_presetModelLabel =>
      'Попередньо налаштована модель з Hugging Face';

  @override
  String get translation_manualUrlLabel =>
      'Посилання на веб-сторінку з інструкцією';

  @override
  String get translation_downloadModel => 'Завантажити модель';

  @override
  String get translation_downloading => 'Завантаження...';

  @override
  String get translation_working => 'Працюю...';

  @override
  String get translation_stop => 'Припинити';

  @override
  String get translation_mergingChunks =>
      'Об\'єднання завантажених фрагментів у кінцевий файл...';

  @override
  String get translation_downloadedModels => 'Завантажені моделі';

  @override
  String get translation_deleteModel => 'Видалити модель';

  @override
  String get translation_modelDownloaded => 'Модель перекладу завантажена.';

  @override
  String get translation_downloadStopped => 'Завантаження призупинено.';

  @override
  String translation_downloadFailed(String error) {
    return 'Не вдалось завантажити: $error';
  }

  @override
  String get translation_enterUrlFirst => 'Спочатку введіть URL моделі.';

  @override
  String get scanner_linuxPairingShowPin => 'Показати PIN';

  @override
  String get scanner_linuxPairingHidePin => 'Приховати PIN';

  @override
  String get scanner_linuxPairingPinTitle => 'PIN‑код спарювання Bluetooth';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return 'Введіть PIN для $deviceName (залиште порожнім, якщо його немає).';
  }

  @override
  String get translation_messageTranslation => 'Переклад повідомлення';

  @override
  String get translation_translateBeforeSending =>
      'Перекладіть перед відправкою';

  @override
  String get translation_composerEnabledHint =>
      'Повідомлення будуть перекладені перед відправленням.';

  @override
  String get translation_composerDisabledHint =>
      'Надсилайте повідомлення, використовуючи оригінальний текстовий формат.';

  @override
  String translation_translateTo(String language) {
    return 'Перекласти на $language';
  }

  @override
  String get translation_translationOptions => 'Варіанти перекладу';

  @override
  String get translation_systemLanguage => 'Мова системи';

  @override
  String get background_serviceTitle => 'MeshCore працює';

  @override
  String get background_serviceText => 'Підтримує з\'єднання BLE';

  @override
  String appSettings_translationModelDeleted(String name) {
    return 'Видалено $name';
  }

  @override
  String appSettings_translationModelDeleteFailed(String error) {
    return 'Не вдалось видалити: $error';
  }

  @override
  String channels_channelUpdateFailed(String error) {
    return 'Не вдалось оновити канал: $error';
  }

  @override
  String get contact_typeChat => 'Чат';

  @override
  String get contact_typeRepeater => 'Ретранслятор';

  @override
  String get contact_typeRoom => 'Кімната';

  @override
  String get contact_typeSensor => 'Сенсор';

  @override
  String get contact_typeUnknown => 'Невідомо';

  @override
  String get map_zoomIn => 'Увійти в режим збільшення';

  @override
  String get map_zoomOut => 'Видалити зум';

  @override
  String get map_centerMap => 'Карта центру';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'Web Bluetooth вимагає браузера на основі Chromium';

  @override
  String channels_communityShortId(String id) {
    return 'ID: $id...';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'GPS підтверджено';

  @override
  String get pathTrace_legendInferred => 'Висновок щодо положення';

  @override
  String get pathMap_viewSingle => 'Один';

  @override
  String get pathMap_viewCombined => 'Об\'єднаний';

  @override
  String get pathMap_play => 'Відтворити';

  @override
  String get pathMap_pause => 'Призупинити';

  @override
  String get pathMap_replay => 'Повтор';

  @override
  String get pathMap_stepBack => 'Попередній перехід';

  @override
  String get pathMap_stepForward => 'Наступний перехід';

  @override
  String get pathMap_animationOn => 'Відобразити анімацію пакета';

  @override
  String get pathMap_animationOff => 'Приховати анімацію пакета';

  @override
  String pathMap_hopOf(int current, int total) {
    return 'Перехід $current з $total';
  }

  @override
  String pathMap_observedPaths(int count) {
    return 'Зафіксовані маршрути: $count';
  }

  @override
  String get pathMap_primary => 'Основний';

  @override
  String pathMap_alternate(int index) {
    return 'Альт. $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count переходів',
      many: '$count переходів',
      few: '$count переходи',
      one: '1 перехід',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => 'Об\'єднаний сегмент';

  @override
  String get pathMap_legendEstimated => 'Орієнтовний сегмент';

  @override
  String pathMap_sharedNodeCount(int count) {
    return 'Використовується $count шляхами';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count переходів не мають геопозиції — показаний шлях є частковим',
      many: '$count переходів не мають геопозиції — показаний шлях є частковим',
      few: '$count переходи не мають геопозиції — показаний шлях є частковим',
      one: '1 перехід не має геопозиції — показаний шлях є частковим',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'Показати все';

  @override
  String get pathMap_hidePath => 'Приховати шлях';

  @override
  String get pathMap_showPath => 'Показати шлях';

  @override
  String get pathMap_collapsePanel => 'Згорнути панель';

  @override
  String get pathMap_expandPanel => 'Розгорнути панель';

  @override
  String get pathMap_noLocation => 'Без геопозиції';

  @override
  String get pathMap_followPacket => 'Прив\'язати вигляд до пакету';

  @override
  String get pathMap_unfollowPacket => 'Відв\'язати вигляд від пакету';

  @override
  String get imageSend_title =>
      'Нашкоду зовні\n\n(or more naturally, depending on context)\n\nПошукуєте изображення';

  @override
  String get imageSend_cropNote =>
      'Манітовано до 512 × 512 · соотношення варість не зберігається';

  @override
  String get imageSend_originalSize => 'Оригінал';

  @override
  String get imageSend_onAirSize => 'На ері';

  @override
  String get imageSend_quality => 'Качество';

  @override
  String get imageSend_qualityStandard => 'Стандарт';

  @override
  String get imageSend_qualityHigh => 'Висок';

  @override
  String get imageSend_packetsLabel => 'Пакети';

  @override
  String get imageSend_airtimeLabel => 'Час на ері';

  @override
  String get imageSend_sizeLabel => 'Підлог';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'пакета',
      many: 'пакетів',
      few: 'пакети',
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
  String get imageSend_radioUnknownTitle => 'Настройки радио неизвестні';

  @override
  String get imageSend_radioUnknownBody =>
      'Залучіться до пристрою, щоб можна було розрахунювати час в етері.';

  @override
  String get imageSend_longSendTitle => 'Длуга передача';

  @override
  String imageSend_longSendBody(String duration) {
    return 'Це забезпечить канал на approximativno $duration хвилин.';
  }

  @override
  String get imageSend_floodNote =>
      'Рухування потоків: кожен ретрансатор у діапазоні відправлює кожен пакет, тому канал залишається занятшим довше, ніж це.';

  @override
  String get imageSend_parityTitle => 'Пакет відновлення';

  @override
  String get imageSend_paritySubtitle =>
      'Один дополний пакет. Групові посилання не відповідають, тому це дозволяє відвідувачу відтворити зображення, якщо один пакет втрачений.';

  @override
  String get imageSend_send => 'Пошутить';

  @override
  String get imageSend_cancel => 'Завершити';

  @override
  String get imageSend_encodeFailed =>
      'Це изображення не може бути кодировано.';

  @override
  String get imageSend_codecDownloading =>
      'Модель для відтворення изображень ще збирається.';

  @override
  String get imageSend_codecUnavailable =>
      'Постій для відправлення изображень на цьому пристрої не доступний.';

  @override
  String get imageSend_codecDisabled =>
      'Пictesovani posyly wyключені в настройках.';

  @override
  String get imageSend_deviceUnsupported =>
      'Цей радіопередач не може отправляти пакети зображень. Зконнете пристрої, що працює з обладнанням керемонітом компаньєр 13 або новшим.';

  @override
  String get imageSend_directMessagesUnsupported =>
      'Фотографії передаються як дані групою, тому їх можна відправляти лише на канал — не в прямому посилання.';

  @override
  String get imageSend_tooLarge =>
      'Це изображення кодує більше пакітів, ніж дозволяє формат сети.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'пакетів',
      one: 'пакет',
    );
    return 'Зображення надіслано як $count $_temp0.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return 'Изображення не можна відправити: $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return 'Пошускаємо изображення — пакет $sent з $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'Нод $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return 'Підходяче: $received з $total пакітів';
  }

  @override
  String get receivedImage_queued => 'Очікування розслівання коду';

  @override
  String get receivedImage_tapToDecode => 'Кliknite для декодування';

  @override
  String get receivedImage_decoding => 'Повноювання… за прибуття 1 с.';

  @override
  String receivedImage_incomplete(int received, int total) {
    return 'Образок не повний — $received з $total пакітів прибавлено';
  }

  @override
  String get receivedImage_corrupt => 'Obraz не можна відтворити';

  @override
  String get receivedImage_decoderMissing =>
      'Під час приємки — розшифровка зображення не вдалося.';

  @override
  String get receivedImage_evicted => 'Изображення не зберігається';

  @override
  String get receivedImage_retry => 'Попробуй ще раз';

  @override
  String get receivedImage_decodeAgain => 'Декодуй ще раз';

  @override
  String get receivedImage_openSettings => 'Заведіть';

  @override
  String get receivedImage_tapToProcess => 'Кликніть для обробки';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'пакетів',
      one: 'пакет',
    );
    return '$bytes байтів · $packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds секунди';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes хв $seconds с';
  }

  @override
  String get bastion_tagline => 'Зв\'язок без інфраструктури.';

  @override
  String get bastion_nodes => 'ВУЗЛИ';

  @override
  String get bastion_repeaters => 'РЕТРАНСЛЯТОРИ';

  @override
  String get bastion_active1h => 'АКТИВНІ 1 ГОД';

  @override
  String get bastion_mapCoverage => 'МАПА + ПОКРИТТЯ';

  @override
  String get bastion_routeIntelligence => 'АНАЛІЗ МАРШРУТІВ';

  @override
  String get bastion_repeaterTools => 'ІНСТРУМЕНТИ РЕТРАНСЛЯТОРА';

  @override
  String get bastion_fieldStats => 'ПОЛЬОВА СТАТИСТИКА';

  @override
  String get bastion_fieldOps => 'ПОХІД + ПОЛЬОВІ ОПЕРАЦІЇ';

  @override
  String get bastion_coverageCapture => 'ЗАПИС ПОКРИТТЯ';

  @override
  String get bastion_mapAttribution =>
      'Дані мапи © учасники OpenStreetMap; тайли вибраного постачальника';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count спостереження',
      many: '$count спостережень',
      few: '$count спостереження',
      one: '$count спостереження',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count унікального вузла',
      many: '$count унікальних вузлів',
      few: '$count унікальні вузли',
      one: '$count унікальний вузол',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count переходу',
      many: '$count переходів',
      few: '$count переходи',
      one: '$count перехід',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count хвилини',
      many: '$count хвилин',
      few: '$count хвилини',
      one: '$count хвилина',
    );
    return '$_temp0';
  }

  @override
  String get sos_holdHint =>
      'Утримуйте 2 секунди. Надсилає ваше місцезнаходження контактам походу кожні 5 хвилин, доки хтось не відповість.';

  @override
  String sos_holdHintChannel(String channel) {
    return 'Утримуйте 2 секунди. Надсилає ваше місцезнаходження контактам походу та в $channel кожні 5 хвилин, доки хтось не відповість.';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS не надіслано: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return 'Підтверджено: $name. Повтори зупинено.';
  }

  @override
  String get sos_waitingForRadio => 'Очікування надсилання радіостанцією…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return 'Надіслано $sends з $max разів. Повтори завершено; відповіді ще немає.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return 'Надіслано $sends з $max разів. Наступне о $time.';
  }

  @override
  String get sos_active => 'SOS АКТИВНИЙ';

  @override
  String get sos_stop => 'СТОП';

  @override
  String get sos_imSafe => 'Я В БЕЗПЕЦІ';

  @override
  String get sos_holdSemantics => 'SOS. Утримуйте, щоб надіслати.';

  @override
  String get sos_keepHolding => 'ПРОДОВЖУЙТЕ УТРИМУВАТИ…';

  @override
  String get sos_holdForSos => 'УТРИМУЙТЕ ДЛЯ SOS';

  @override
  String get sos_blockStorage =>
      'Спершу усуньте помилку зберігання польового журналу.';

  @override
  String get sos_blockNotConnected =>
      'Під\'єднайте радіостанцію MeshCore, щоб надіслати SOS.';

  @override
  String get sos_blockNoTarget =>
      'Виберіть контакти походу або канал SOS у розділі «Спланувати похід».';

  @override
  String get checkIn_labelOk => 'Усе гаразд';

  @override
  String get checkIn_labelAtCamp => 'У таборі';

  @override
  String get checkIn_labelDelayed => 'Затримуюсь';

  @override
  String get checkIn_labelHeadingBack => 'Повертаюсь';

  @override
  String get checkIn_blockLoading => 'Завантаження походу…';

  @override
  String get checkIn_blockStorage =>
      'Перед надсиланням усуньте помилку зберігання польового журналу.';

  @override
  String get checkIn_blockBusy => 'Позначка надсилається. Зачекайте.';

  @override
  String get checkIn_blockNoContacts =>
      'Виберіть контакти походу в розділі «Спланувати похід».';

  @override
  String get checkIn_blockRosterIncomplete =>
      'Деякі контакти походу недоступні. Перевірте список.';

  @override
  String get checkIn_blockNotConnected =>
      'Під\'єднайте радіостанцію MeshCore, щоб позначитися.';

  @override
  String get checkIn_blockNotActive => 'Почніть похід, щоб увімкнути позначки.';

  @override
  String get checkIn_notSent => 'Не надіслано';

  @override
  String checkIn_deliveredToOne(String name) {
    return 'Доставлено: $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return 'Доставлено всім контактам ($count)';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return 'Доставлено $delivered з $total';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return 'Не доставлено: $names';
  }

  @override
  String get checkIn_waitingForRest => 'Очікування решти';

  @override
  String get checkIn_aContact => 'контакт';

  @override
  String get checkIn_statusPending => 'Очікує';

  @override
  String get checkIn_statusSent => 'Надіслано';

  @override
  String get checkIn_statusDelivered => 'Доставлено';

  @override
  String get checkIn_statusFailed => 'Помилка';

  @override
  String get checkIn_explainPending =>
      'У локальній черзі. Це не підтверджує ні радіопередачу, ні отримання.';

  @override
  String get checkIn_explainSent =>
      'Радіостанція прийняла надсилання. Підтвердження доставки не зареєстровано.';

  @override
  String get checkIn_explainDelivered =>
      'Застосунок зареєстрував підтвердження доставки. Це не доводить, що людина його прочитала.';

  @override
  String get checkIn_explainFailed =>
      'Доставку не підтверджено. Перевірте радіозв\'язок, досяжність отримувача та історію повторів.';

  @override
  String get checkIn_explainUnknown =>
      'Стан доставки недоступний. Не вважайте, що повідомлення дійшло.';

  @override
  String get tripBrief_heading => 'NOTORYX • Зведення походу MeshCore';

  @override
  String tripBrief_trip(String name) {
    return 'Похід: $name';
  }

  @override
  String tripBrief_status(String status) {
    return 'Стан: $status';
  }

  @override
  String get tripBrief_active => 'Активний';

  @override
  String get tripBrief_stopped => 'Зупинений';

  @override
  String tripBrief_contacts(String names) {
    return 'Контакти: $names';
  }

  @override
  String get tripBrief_noneSelected => 'Не вибрано';

  @override
  String get tripBrief_unavailableContact =>
      'Недоступний контакт (перевірте список)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return 'Активність прострочена через: $minutes хв (цей телефон попереджає, коли контакт замовкає)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'Нагадування про позначку: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return 'кожні $minutes хв без позначки';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'Варіанти позначки: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'Місцезнаходження радіостанції в позначках: $value';
  }

  @override
  String get tripBrief_includedMayBeStale => 'Додано; може бути застарілим';

  @override
  String tripBrief_battery(String value) {
    return 'Заряд радіостанції в позначках: $value';
  }

  @override
  String get tripBrief_included => 'Додано';

  @override
  String get tripBrief_off => 'Вимк.';

  @override
  String get tripBrief_review =>
      'Перевірте отримувачів і повідомлення перед надсиланням позначки.';

  @override
  String get tripBrief_noProof =>
      '«У черзі» чи «надіслано» не доводить доставку. Підтвердження не доводить прочитання.';

  @override
  String get tripBrief_overdueMeaning =>
      'Прострочено означає відсутність нещодавньої активності контакту; це не підтверджена надзвичайна ситуація.';

  @override
  String get tripBrief_automations =>
      'Польові автоматизації працюють лише тоді, коли застосунок активний. Домовтеся про окремий план на випадок втрати зв\'язку.';

  @override
  String get tripBrief_sharesOnly =>
      'Це зведення лише передає інформацію; воно не надсилає радіоповідомлення й не починає похід.';

  @override
  String get fieldOps_title => 'Польові операції NOTORYX Core';

  @override
  String get fieldOps_tabTrip => 'ПОХІД';

  @override
  String get fieldOps_tabReady => 'ГОТОВНІСТЬ';

  @override
  String get fieldOps_tabLog => 'ЖУРНАЛ';

  @override
  String get fieldOps_tabAuto => 'АВТО';

  @override
  String get fieldOps_tabCoverage => 'ПОКРИТТЯ';

  @override
  String get fieldOps_tabConnection => 'ЗВ\'ЯЗОК';

  @override
  String get fieldOps_diagnostics => 'Діагностика';

  @override
  String get fieldOps_storageLoadError =>
      'Не вдалося завантажити польові дані. Збережені дані залишено; автоматизації лишаються вимкненими.';

  @override
  String get fieldOps_storageSaveError =>
      'Не вдалося зберегти польові дані. Автоматизації зупинено; раніше збережені дані залишено.';

  @override
  String get fieldOps_regionHint =>
      'Виберіть область і рівні масштабу в розділі «Офлайн-мапи».';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • масштаб $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return 'Не вдалося перевірити область мапи: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Похід активний • $count контакту',
      many: 'Похід активний • $count контактів',
      few: 'Похід активний • $count контакти',
      one: 'Похід активний • $count контакт',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped =>
      'Похід зупинено. Почніть його, коли будете готові.';

  @override
  String fieldOps_reminderAt(String time) {
    return 'Нагадування про позначку о $time';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return 'Надто довго мовчать: $names';
  }

  @override
  String get fieldOps_planTrip => 'Спланувати похід';

  @override
  String get fieldOps_endTrip => 'Завершити похід';

  @override
  String get fieldOps_startTrip => 'Почати похід';

  @override
  String get fieldOps_tripBrief => 'Зведення походу';

  @override
  String get fieldOps_connectRadio => 'Під\'єднати радіостанцію';

  @override
  String get fieldOps_previewedCheckIns => 'Позначки з попереднім переглядом';

  @override
  String get fieldOps_previewedCheckInsHint =>
      'Виберіть статус, перевірте фактичних отримувачів і повідомлення, потім надішліть. «У черзі» не означає «доставлено».';

  @override
  String get fieldOps_tripRoster => 'Склад походу';

  @override
  String get fieldOps_rosterEmpty =>
      'Виберіть до шести відомих контактів чату в розділі «Спланувати похід».';

  @override
  String get fieldOps_rosterCaveat =>
      '«Востаннє чути» — свідчення минулої активності. Це не підтверджує поточну досяжність. Позначки прострочення означають відсутність нещодавньої активності контакту, а не підтверджену надзвичайну ситуацію.';

  @override
  String get fieldOps_offlineMaps => 'Офлайн-мапи';

  @override
  String get fieldOps_checkingTiles => 'Перевірка збережених тайлів…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count тайла в кеші.',
      many: '$count тайлів у кеші.',
      few: '$count тайли в кеші.',
      one: '$count тайл у кеші.',
    );
    return '$_temp0 Це не гарантує покриття всього маршруту.';
  }

  @override
  String get fieldOps_downloadAreas =>
      'Завантажити / перевірити офлайн-області';

  @override
  String fieldOps_lastCheckIn(String time) {
    return 'Остання позначка, $time';
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
      other: 'Надіслати повторно $count недоставленим',
      many: 'Надіслати повторно $count недоставленим',
      few: 'Надіслати повторно $count недоставленим',
      one: 'Надіслати повторно $count недоставленому',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable => 'Вибраний контакт недоступний';

  @override
  String get fieldOps_memberUnavailableHint =>
      'Перевірте похід перед надсиланням.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return 'Остання активність $minutes хв тому';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return 'Остання активність $minutes хв тому • прострочено';
  }

  @override
  String get fieldOps_noCheckInRecorded => 'У цьому журналі немає позначок.';

  @override
  String get fieldOps_tripMap => 'Мапа походу';

  @override
  String get fieldOps_tripMapEmpty =>
      'Вибрані контакти ще не передали координати.';

  @override
  String get fieldOps_lastPositions => 'Останні передані місцезнаходження';

  @override
  String get fieldOps_positionsCaveat =>
      'Місцезнаходження можуть бути застарілими. Ця мапа не відстежує GPS телефона й не доводить, що учасники зараз тут.';

  @override
  String get fieldOps_briefPreviewTitle =>
      'Попередній перегляд зведення походу';

  @override
  String get fieldOps_briefPreviewHint =>
      'Містить назви походу й імена контактів. Перевірте перед поширенням. Координати, ключі та історію повідомлень вилучено.';

  @override
  String get fieldOps_shareBrief => 'Поділитися зведенням';

  @override
  String get fieldOps_briefSubject => 'Зведення походу NOTORYX Core';

  @override
  String get fieldOps_tripName => 'Назва походу';

  @override
  String get fieldOps_defaultTripName => 'Мій похід';

  @override
  String get fieldOps_includePosition =>
      'Додавати передане місцезнаходження радіостанції';

  @override
  String get fieldOps_includePositionHint =>
      'Може бути застарілим; за замовчуванням передавання вимкнено.';

  @override
  String get fieldOps_includeBattery => 'Додавати заряд радіостанції';

  @override
  String get fieldOps_overdueLabel =>
      'Попереджати, якщо контакт мовчить довше ніж';

  @override
  String get fieldOps_reminderLabel => 'Нагадувати про позначку';

  @override
  String get fieldOps_reminderHelper =>
      'Сповіщення на телефоні, навіть якщо NOTORYX Core закрито.';

  @override
  String get fieldOps_reminderOff => 'Вимк.';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Через $count хвилини без позначки',
      many: 'Через $count хвилин без позначки',
      few: 'Через $count хвилини без позначки',
      one: 'Через $count хвилину без позначки',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'SOS також надсилається в канал';

  @override
  String get fieldOps_sosChannelNone => 'Немає';

  @override
  String get fieldOps_selectContacts =>
      'Виберіть до шести відомих контактів чату';

  @override
  String get fieldOps_sendCheckInTitle => 'Надіслати позначку?';

  @override
  String fieldOps_recipients(String names) {
    return 'Кому: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      'Використовуються звичайні особисті повідомлення. Доставку відстежуватиме польовий журнал.';

  @override
  String get fieldOps_send => 'Надіслати';

  @override
  String get fieldOps_beforeYouLeave => 'Перед виходом';

  @override
  String get fieldOps_radioConnected => 'Радіостанцію під\'єднано';

  @override
  String get fieldOps_connectHint =>
      'Під\'єднайтеся через Bluetooth, USB або TCP.';

  @override
  String get fieldOps_radioBattery => 'Заряд радіостанції';

  @override
  String get fieldOps_batteryUnknown => 'Невідомо; перевірте радіостанцію.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent% • зарядіть для запланованого походу.';
  }

  @override
  String get fieldOps_tripContacts => 'Контакти походу';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return 'Доступно $available/$selected. Переконайтеся, що вони мають сумісні радіостанції та канали.';
  }

  @override
  String get fieldOps_offlineArea => 'Вибрана офлайн-область мапи';

  @override
  String get fieldOps_checkingFiles => 'Перевірка локальних файлів…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return 'Доступно файлів тайлів: $available/$expected; бракує: $missing. Це знімок; відкрийте область офлайн перед виходом.';
  }

  @override
  String get fieldOps_locationChoice => 'Передавання місцезнаходження';

  @override
  String get fieldOps_locationOptedIn =>
      'Увімкнено: передані радіостанцією координати можуть бути застарілими.';

  @override
  String get fieldOps_locationOff =>
      'Передавання вимкнено. Ваші позначки не містять координат.';

  @override
  String get fieldOps_automationAvailability => 'Доступність автоматизацій';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'Працює лише тоді, коли застосунок активний. Сон, закриття або втрата радіостанції можуть завадити запланованим діям.';

  @override
  String get fieldOps_readinessCaveat =>
      'Перевірки готовності мають рекомендаційний характер; вони не доводять дальність зв\'язку й не гарантують доставку.';

  @override
  String get fieldOps_radio => 'Радіо';

  @override
  String get fieldOps_refreshChecks => 'Оновити перевірки';

  @override
  String get fieldOps_searchLog => 'Пошук у польовому журналі';

  @override
  String get fieldOps_kindAll => 'Усі';

  @override
  String get fieldOps_kindCheckIn => 'Позначка';

  @override
  String get fieldOps_kindReceived => 'Отримано';

  @override
  String get fieldOps_kindNote => 'Нотатка';

  @override
  String get fieldOps_kindDeadZone => 'Мертва зона';

  @override
  String get fieldOps_kindRadio => 'Радіо';

  @override
  String get fieldOps_kindAutomation => 'Автоматизація';

  @override
  String get fieldOps_kindMissed => 'Пропущено';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => 'Похід';

  @override
  String get fieldOps_kindOverdue => 'Прострочено';

  @override
  String get fieldOps_addNote => 'Додати нотатку';

  @override
  String get fieldOps_exportJson => 'Експорт JSON';

  @override
  String get fieldOps_deleteLog => 'Видалити журнал';

  @override
  String get fieldOps_logSubject => 'Польовий журнал NOTORYX Core';

  @override
  String get fieldOps_logCaveat =>
      'Зберігається локально, до 1000 записів. Експорт може містити ключі контактів, повідомлення та місцезнаходження; перевірте перед поширенням.';

  @override
  String get fieldOps_noEntries => 'Немає відповідних записів.';

  @override
  String get fieldOps_tripUnspecified => 'Похід не вказано';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return 'Записане передане місцезнаходження радіостанції $latitude, $longitude (може бути застарілим)';
  }

  @override
  String get fieldOps_noteTitle => 'Польове спостереження';

  @override
  String get fieldOps_noteLabel => 'Що ви спостерігали?';

  @override
  String get fieldOps_deadZone => 'Позначена мертва зона';

  @override
  String get fieldOps_deadZoneHint =>
      'Ваше спостереження, а не перевірений прогноз покриття.';

  @override
  String get fieldOps_savePosition =>
      'Зберегти передане місцезнаходження радіостанції';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • може бути застарілим; не GPS телефона';
  }

  @override
  String get fieldOps_noPosition => 'Немає придатних переданих координат';

  @override
  String get fieldOps_deleteLogTitle => 'Видалити польовий журнал?';

  @override
  String get fieldOps_deleteLogBody =>
      'Буде видалено всі збережені записи на цьому телефоні. Налаштування походу збережуться.';

  @override
  String get fieldOps_localAutomations => 'Локальні автоматизації';

  @override
  String get fieldOps_enableForTrip => 'Увімкнути для цього походу';

  @override
  String get fieldOps_automationsCaveat =>
      'Вимикаються після кожного перезапуску застосунку. Правила працюють лише тоді, коли застосунок активний. Пропущені заплановані дії з\'являються в польовому журналі й ніколи не виконуються пакетом заднім числом. Автоматичні позначки обмежено однією партією на 10 хвилин.';

  @override
  String get fieldOps_openBotMode => 'Відкрити режим бота NOTORYX';

  @override
  String get fieldOps_ruleEnabled => 'Правило ввімкнено';

  @override
  String get fieldOps_dryRun => 'Пробний запуск';

  @override
  String get fieldOps_dryRunHint => 'Записати дію без надсилання й сповіщень.';

  @override
  String get fieldOps_then => 'ТОДІ';

  @override
  String get fieldOps_actionLog => 'Записати в польовий журнал';

  @override
  String get fieldOps_actionNotify => 'Показати локальне сповіщення';

  @override
  String get fieldOps_actionCheckIn => 'Надіслати «I\'m OK» контактам походу';

  @override
  String get fieldOps_batteryThreshold => 'Заряд не вище';

  @override
  String fieldOps_nextDue(String time) {
    return 'Наступне: $time';
  }

  @override
  String get fieldOps_nextDueNone => 'Наступне: не заплановано';

  @override
  String get fieldOps_previewInLog => 'Попередній перегляд у журналі';

  @override
  String get fieldOps_allowNotifications => 'Дозволити сповіщення';

  @override
  String get fieldOps_triggerReconnect => 'КОЛИ радіостанція перепідключається';

  @override
  String get fieldOps_triggerDisconnect => 'КОЛИ радіостанція від\'єднується';

  @override
  String get fieldOps_triggerLowBattery =>
      'КОЛИ заряд радіостанції перетинає поріг';

  @override
  String get fieldOps_triggerNewNode => 'КОЛИ додано новий вузол';

  @override
  String get fieldOps_triggerRepeater => 'КОЛИ додано новий ретранслятор';

  @override
  String get fieldOps_triggerScheduled =>
      'КОЛИ настає час запланованої позначки';

  @override
  String get fieldOps_explainConnection => 'Пояснити моє підключення';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return 'Стан: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      'Телефон під\'єднано до радіостанції. Само по собі це не забезпечує маршрут до ваших отримувачів.';

  @override
  String get fieldOps_disconnectedHint =>
      'Немає активного радіопідключення. Перевірте дозволи Bluetooth, живлення й дальність радіостанції; USB/TCP доступні в розділі «Під\'єднати радіостанцію».';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return 'Позначки походу, що очікують підтвердження: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'Час останньої появи й передані місцезнаходження вузлів можуть бути застарілими. Аналіз маршрутів показує маршрути, вивчені з помічених спроб; він не вигадує шляхи.';

  @override
  String get fieldOps_routeIntelligence => 'Аналіз маршрутів';

  @override
  String get fieldOps_coverageIntelligence => 'Аналіз покриття';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      'Порівнюйте записані спостереження двох польових сесій. Точки позначають передані місцезнаходження радіостанції, що записувала, де було чути вузли. Вони не означають безперервного покриття. Знімки RSSI/SNR — це не вимірювання для кожного вузла.';

  @override
  String get fieldOps_captureSession => 'Записати сесію';

  @override
  String get fieldOps_refreshHistory => 'Оновити історію';

  @override
  String get fieldOps_noCoverageSessions =>
      'Збережених сесій покриття ще немає.';

  @override
  String get fieldOps_sessionA => 'Сесія A • бірюзовий';

  @override
  String get fieldOps_sessionB => 'Сесія B • бурштиновий';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: унікальних вузлів $a • B: унікальних вузлів $b';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return 'Спільні: $shared • Лише A: $onlyA • Лише B: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'Якщо вузол не чути в одній сесії, це не доводить мертву зону. Умови й тривалість спостереження відрізняються.';

  @override
  String get fieldOps_heardTooltip =>
      'Спостереження почутого вузла; не доказ успішного зв\'язку';

  @override
  String get fieldOps_noteTooltip =>
      'Локальна нотатка в переданих координатах радіостанції; може бути застарілою.';

  @override
  String get bastionHome_aboutTooltip => 'Про NOTORYX Core';

  @override
  String get bastionHome_getStarted => 'ПОЧАТИ';

  @override
  String get bastionHome_getStartedHint =>
      'Під\'єднайте радіостанцію й перевірте перше повідомлення';

  @override
  String get bastionHome_planYourTrip => 'СПЛАНУЙТЕ ПОХІД';

  @override
  String get bastionHome_tripActive => 'Похід активний';

  @override
  String get bastionHome_tripStopped => 'Похід зупинено';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • контактів: $contacts • непрочитаних: $unread';
  }

  @override
  String get bastionHome_checkInOk => 'ПОЗНАЧИТИСЯ: УСЕ ГАРАЗД';

  @override
  String get bastionHome_checkInHint =>
      'Перевірте контакти й повідомлення перед надсиланням. Стежте за підтвердженнями в польовому журналі.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return 'Остання позначка: $summary';
  }

  @override
  String get bastionHome_connectRadio => 'ПІД\'ЄДНАТИ РАДІОСТАНЦІЮ';

  @override
  String get bastionHome_connectRadioHint =>
      'Підключення MeshCore через Bluetooth, USB і TCP';

  @override
  String get bastionHome_liveDiagnostics => 'ДІАГНОСТИКА НАЖИВО';

  @override
  String get bastionHome_liveDiagnosticsHint =>
      'Стан радіостанції, сигнал, пристрій та інструменти кадрів';

  @override
  String get bastionHome_meshDiscovery => 'ВИЯВЛЕННЯ МЕРЕЖІ';

  @override
  String get bastionHome_meshDiscoveryHint =>
      'Знаходьте вузли й досліджуйте мережу навколо себе';

  @override
  String get bastionHome_fieldOpsHint =>
      'Зведення походу, готовність, польовий журнал, автоматизації та порівняння покриття';

  @override
  String get bastionHome_fieldTools => 'ПОЛЬОВІ ІНСТРУМЕНТИ NOTORYX';

  @override
  String get bastionHome_statusActive => 'АКТИВНО';

  @override
  String get bastionHome_consoleOnline => 'ПОЛЬОВА КОНСОЛЬ У МЕРЕЖІ';

  @override
  String get bastionHome_consoleReady => 'ПОЛЬОВА КОНСОЛЬ ГОТОВА';

  @override
  String get bastionHome_consoleHint =>
      'Під\'єднайте радіостанцію, щоб увімкнути панель наживо.';

  @override
  String bastionHome_battery(String value) {
    return 'БАТ $value';
  }

  @override
  String get bastionTools_title => 'Польові інструменти';

  @override
  String get bastionTools_backup => 'ЗАШИФРОВАНА РЕЗЕРВНА КОПІЯ';

  @override
  String get bastionTools_backupHint =>
      'Збережіть налаштування, контакти й ключі, за бажанням з історією чатів';

  @override
  String get bastionTools_fieldOpsHint =>
      'Позначки, готовність, польовий журнал, автоматизації та порівняння';

  @override
  String get bastionTools_mapHint =>
      'Мапа наживо, сесії запису, інструменти офлайн-мап і регіони';

  @override
  String get bastionTools_pathAnalysis => 'АНАЛІЗ ШЛЯХІВ';

  @override
  String get bastionTools_pathHint => 'Маршрути, виявлення та аналіз шляхів';

  @override
  String get bastionTools_repeaterHint =>
      'Стан, вхід, телеметрія, сусіди й адміністрування';

  @override
  String get bastionTools_statsHint =>
      'Лічильники мережі наживо й активність контактів';

  @override
  String get bastionTools_diagnostics => 'ДІАГНОСТИКА';

  @override
  String get bastionTools_diagnosticsHint =>
      'Стан радіостанції, відомості про пристрій, сирі кадри й експорт';

  @override
  String get bastionTools_about => 'ПРО ЗАСТОСУНОК + ПОДЯКИ';

  @override
  String get bastionTools_aboutHint =>
      'Версія NOTORYX Core, заява про незалежність і ліцензії відкритого ПЗ';

  @override
  String get bastionAbout_title => 'Про застосунок + Подяки';

  @override
  String get bastionAbout_intro =>
      'Незалежний громадський застосунок-компаньйон для мереж MeshCore. NOTORYX Core не є офіційним застосунком MeshCore, а додавання ресурсів спільноти не означає партнерства чи схвалення.';

  @override
  String get bastionAbout_version => 'ВЕРСІЯ';

  @override
  String get bastionAbout_openSource => 'ОСНОВА З ВІДКРИТИМ КОДОМ';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core створено на основі відкритого коду MeshCore Open за ліцензією MIT, який він змінює. Робота над сценарієм покриття також відзначає, де це доречно, застосунок MeshMapper Flutter App за ліцензією MIT.';

  @override
  String get bastionAbout_community => 'СПІЛЬНОТА ПОНАД УСЕ';

  @override
  String get bastionAbout_communityBody =>
      'Ресурси сторонніх авторів залишаються власністю їхніх авторів. Право власності чи партнерство не маються на увазі.';

  @override
  String get bastionAbout_legalese =>
      'NOTORYX Core • Незалежний компаньйон MeshCore';

  @override
  String get bastionAbout_licenses => 'ЛІЦЕНЗІЇ ВІДКРИТОГО ПЗ';

  @override
  String get bastionSetup_title => 'Початок роботи з NOTORYX Core';

  @override
  String get bastionSetup_intro =>
      'Під\'єднайтеся, виберіть контакт, потім перевірте повідомлення. Повернутися до цього посібника можна з панелі будь-коли.';

  @override
  String get bastionSetup_step1 => '1. Під\'єднайте радіостанцію MeshCore';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return 'Під\'єднано до $device через $transport.';
  }

  @override
  String get bastionSetup_noRadio => 'Радіостанцію ще не під\'єднано.';

  @override
  String get bastionSetup_step1Power =>
      'Увімкніть радіостанцію-компаньйон MeshCore. Відкрийте «Під\'єднати радіостанцію» й виберіть Bluetooth, USB або TCP. Надайте дозволи, запитані для вибраного підключення.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Якщо пошук Bluetooth нічого не знаходить, переконайтеся, що Bluetooth увімкнено і NOTORYX Core має дозвіл «Пристрої поблизу» в налаштуваннях застосунків Android. Виконайте всі додаткові запити дозволів, які показує сканер.';

  @override
  String get bastionSetup_connectionDiagnostics => 'Діагностика підключення';

  @override
  String get bastionSetup_step2 => '2. Виберіть контакт чату';

  @override
  String get bastionSetup_step2Body =>
      'Попросіть партнера поблизу із сумісними налаштуваннями радіостанції MeshCore оголосити свій вузол. Виберіть нижче відомий контакт чату; ретранслятори налаштовуються окремо.';

  @override
  String get bastionSetup_noContacts =>
      'Немає доступних контактів чату. Під\'єднайте радіостанцію й відкрийте «Виявлення мережі».';

  @override
  String get bastionSetup_testRecipient => 'Тестовий отримувач';

  @override
  String get bastionSetup_meshDiscovery => 'Виявлення мережі';

  @override
  String get bastionSetup_step3 => '3. Надішліть і перевірте повідомлення';

  @override
  String get bastionSetup_step3Body =>
      'Відкрийте чат, напишіть коротке тестове повідомлення, перевірте отримувача й натисніть «Надіслати». Поверніться сюди, щоб побачити останнє вихідне повідомлення, записане з моменту відкриття посібника.';

  @override
  String get bastionSetup_openTestChat => 'Відкрити тестовий чат';

  @override
  String get bastionSetup_connectFirst =>
      'Під\'єднайте радіостанцію, щоб відкрити тестовий чат.';

  @override
  String get bastionSetup_chooseRecipient => 'Спершу виберіть отримувача.';

  @override
  String get bastionSetup_noTestMessage =>
      'У цій сесії посібника вихідних тестових повідомлень не записано.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return 'Останнє повідомлення: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'Попросіть партнера підтвердити отримання або відповісти. Записане підтвердження не доводить прочитання. Якщо повідомлення не дійшло, перевірте підключення й отримувача ще раз.';

  @override
  String get bastionSetup_step4 => '4. Підготуйтеся до виходу';

  @override
  String get bastionSetup_step4Body =>
      'Сплануйте контакти походу й перевірте завантажені області мап. Режим бота й польові автоматизації спочатку вимкнені; польові автоматизації працюють лише тоді, коли застосунок активний.';

  @override
  String get bastionSetup_tripTools => 'Інструменти походу й готовності';

  @override
  String get bastionDiag_title => 'Діагностика';

  @override
  String get bastionDiag_export => 'Експортувати діагностику';

  @override
  String get bastionDiag_channels => 'КАНАЛИ';

  @override
  String get bastionDiag_radio => 'РАДІО';

  @override
  String get bastionDiag_frequency => 'Частота';

  @override
  String get bastionDiag_bandwidth => 'Смуга';

  @override
  String get bastionDiag_spreadingFactor => 'Коефіцієнт розширення';

  @override
  String get bastionDiag_codingRate => 'Швидкість кодування';

  @override
  String get bastionDiag_txPower => 'Потужність передавання';

  @override
  String get bastionDiag_noiseFloor => 'Рівень шуму';

  @override
  String get bastionDiag_device => 'ПРИСТРІЙ';

  @override
  String get bastionDiag_name => 'Ім\'я';

  @override
  String get bastionDiag_manufacturer => 'Виробник';

  @override
  String get bastionDiag_firmware => 'Прошивка';

  @override
  String get bastionDiag_battery => 'Батарея';

  @override
  String get bastionDiag_transport => 'Підключення';

  @override
  String get bastionDiag_deepTools => 'РОЗШИРЕНІ ІНСТРУМЕНТИ';

  @override
  String get bastionDiag_liveStats => 'СТАТИСТИКА РАДІО НАЖИВО';

  @override
  String get bastionDiag_liveStatsHint => 'Шум, RSSI, SNR та ефірний час';

  @override
  String get bastionDiag_frameDebug => 'НАЛАГОДЖЕННЯ КАДРІВ / BLE';

  @override
  String get bastionDiag_frameDebugHint =>
      'Досліджуйте декодовані та сирі отримані кадри';

  @override
  String get bastionDiag_appLog => 'ЖУРНАЛ НАЛАГОДЖЕННЯ ЗАСТОСУНКУ';

  @override
  String get bastionDiag_appLogHint =>
      'Переглядайте діагностичні події застосунку';

  @override
  String get bastionDiag_online => 'РАДІО В МЕРЕЖІ';

  @override
  String get bastionDiag_offline => 'РАДІО НЕ В МЕРЕЖІ';

  @override
  String get bastionDiag_offlineHint =>
      'Під\'єднайте компаньйон MeshCore, щоб заповнити діагностику наживо.';

  @override
  String get coverage_title => 'Запис покриття';

  @override
  String get coverage_leaveBlocked =>
      'Зупиніть і збережіть сесію перед виходом.';

  @override
  String get coverage_savedSessions => 'ЗБЕРЕЖЕНІ СЕСІЇ';

  @override
  String get coverage_caveat =>
      'RSSI/SNR — знімки радіостанції й можуть стосуватися іншого пакета. Місцезнаходження — це координати, передані радіостанцією, а не GPS телефона й не доказ покриття. Блакитний: записувач; бурштиновий: переданий вузол. Інтерполяція не виконується.';

  @override
  String get coverage_captureActive => 'ЗАПИС АКТИВНИЙ';

  @override
  String get coverage_fieldSession => 'ПОЛЬОВА СЕСІЯ ПОКРИТТЯ';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core записує вперше почуті в цій сесії вузли, зокрема дані маршруту, метадані вузла/місцезнаходження й найближчий доступний знімок RSSI/SNR радіостанції.';

  @override
  String get coverage_disconnectedBody =>
      'Перед початком під\'єднайте радіостанцію. Запис покриття зберігає спостереження мережі наживо з під\'єднаної радіостанції-компаньйона.';

  @override
  String get coverage_observations => 'СПОСТЕРЕЖЕННЯ';

  @override
  String get coverage_uniqueNodes => 'УНІКАЛЬНІ ВУЗЛИ';

  @override
  String get coverage_elapsed => 'МИНУЛО';

  @override
  String get coverage_radioConnected => 'РАДІО ПІД\'ЄДНАНО';

  @override
  String get coverage_noRadio => 'НЕМАЄ РАДІО';

  @override
  String get coverage_gpsReady => 'GPS РАДІО ГОТОВИЙ';

  @override
  String get coverage_noGps => 'НЕМАЄ GPS РАДІО';

  @override
  String get coverage_stopSave => 'СТОП + ЗБЕРЕГТИ СЕСІЮ';

  @override
  String get coverage_start => 'ПОЧАТИ СЕСІЮ ПОКРИТТЯ';

  @override
  String get coverage_exportJson => 'ЕКСПОРТ JSON';

  @override
  String get coverage_exportCsv => 'ЕКСПОРТ CSV';

  @override
  String get coverage_liveObservations => 'СПОСТЕРЕЖЕННЯ НАЖИВО';

  @override
  String get coverage_waiting => 'ОЧІКУВАННЯ АКТИВНОСТІ МЕРЕЖІ';

  @override
  String get coverage_waitingBody =>
      'Почніть сесію, і тут з\'являться вперше почуті активні вузли. Значення RSSI/SNR — знімки радіостанції, і їх не завжди можна однозначно віднести до конкретного пакета.';

  @override
  String get coverage_signalNa => 'сигнал н/д';

  @override
  String get coverage_snrNa => 'SNR н/д';

  @override
  String get coverage_gpsUnavailable => 'GPS радіостанції недоступний';

  @override
  String coverage_pathLine(String path, String location) {
    return 'Шлях: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'flood';

  @override
  String get coverage_pathDirect => 'напряму';

  @override
  String get coverage_shareSubject => 'Сесія покриття NOTORYX Core';

  @override
  String get coverage_shareText => 'Експорт запису покриття NOTORYX Core';

  @override
  String get coverage_historyTitle => 'Збережені сесії покриття';

  @override
  String coverage_loadFailed(String error) {
    return 'Не вдалося завантажити сесії: $error';
  }

  @override
  String get coverage_deleteTitle => 'Видалити збережену сесію?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count спостереження буде видалено з цього пристрою.',
      many: '$count спостережень буде видалено з цього пристрою.',
      few: '$count спостереження буде видалено з цього пристрою.',
      one: '$count спостереження буде видалено з цього пристрою.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'Не вдалося видалити сесію: $error';
  }

  @override
  String get coverage_retention =>
      'Зберігаються 20 останніх завершених сесій. Поділіться сесіями, які хочете зберегти. Перервані записи можна відкрити знову нижче.';

  @override
  String get coverage_noSessions =>
      'Збережених сесій ще немає. Зупиніть запис, щоб зберегти його.';

  @override
  String get coverage_interrupted => 'Перерваний запис';

  @override
  String get coverage_saved => 'Збережено';

  @override
  String get coverage_deleteTooltip => 'Видалити сесію';

  @override
  String coverage_exportFailed(String error) {
    return 'Помилка експорту: $error';
  }

  @override
  String get coverage_sessionTitle => 'Сесія покриття';

  @override
  String get coverage_shareJson => 'Поділитися JSON';

  @override
  String get coverage_shareCsv => 'Поділитися CSV';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi дБм • SNR $snr дБ • вік знімка $age мс';
  }

  @override
  String get coverage_unknown => 'невідомо';

  @override
  String coverage_pathValue(String path) {
    return 'шлях $path';
  }

  @override
  String get coverage_recorder => 'Записувач';

  @override
  String get coverage_noCoordinates =>
      'У цій сесії немає придатних координат. Спостереження й надалі доступні нижче.';

  @override
  String get coverage_osmAttribution =>
      '© учасники OpenStreetMap • онлайн-підкладка';

  @override
  String get fieldStats_title => 'ПОЛЬОВА АНАЛІТИКА';

  @override
  String get fieldStats_snapshot => 'ЗНІМОК МЕРЕЖІ НАЖИВО';

  @override
  String get fieldStats_headline => 'Що NOTORYX Core знає просто зараз.';

  @override
  String get fieldStats_body =>
      'Ці лічильники обчислюються за таблицею контактів під\'єднаного MeshCore, місцезнаходженнями, шляхами й часом останньої появи.';

  @override
  String get fieldStats_total => 'УСЬОГО';

  @override
  String get fieldStats_chatNodes => 'ВУЗЛИ ЧАТУ';

  @override
  String get fieldStats_rooms => 'КІМНАТИ';

  @override
  String get fieldStats_sensors => 'ДАТЧИКИ';

  @override
  String get fieldStats_located => 'З МІСЦЕЗНАХОДЖЕННЯМ';

  @override
  String get fieldStats_favorites => 'ОБРАНЕ';

  @override
  String get fieldStats_routeSnapshot => 'ЗНІМОК МАРШРУТІВ';

  @override
  String get fieldStats_routed => 'З МАРШРУТОМ';

  @override
  String get fieldStats_direct => 'НАПРЯМУ';

  @override
  String get fieldStats_flood => 'FLOOD';

  @override
  String get fieldStats_pathIntel => 'АНАЛІЗ ШЛЯХІВ';

  @override
  String get fieldStats_pathIntelBody =>
      'Аналіз маршрутів NOTORYX Core використовує збережені спроби шляхів, кількість переходів, успіхи/невдачі, час проходження й ваги маршрутів, щоб показувати вивчені маршрути.';

  @override
  String get fieldStats_coverageSessions => 'СЕСІЇ ПОКРИТТЯ';

  @override
  String get fieldStats_coverageSessionsBody =>
      'Запис покриття тепер зберігає польові сесії, відновлює перервану роботу, експортує спостереження й наносить записані точки покриття на мапу. RSSI/SNR залишаються найближчим доступним знімком радіостанції.';

  @override
  String get mapHub_title => 'ПОЛЬОВА МАПА NOTORYX';

  @override
  String get mapHub_intro =>
      'Мапи наживо, офлайн-області, регіональні профілі та польові сесії покриття NOTORYX Core.';

  @override
  String get mapHub_captureHint => 'Почати й зупинити польову сесію покриття';

  @override
  String get mapHub_badgeNew => 'НОВЕ';

  @override
  String get mapHub_liveMap => 'МАПА МЕРЕЖІ НАЖИВО';

  @override
  String get mapHub_liveMapHint =>
      'Вузли, ретранслятори, місцезнаходження, маршрути й інструменти мапи';

  @override
  String get mapHub_badgeLive => 'НАЖИВО';

  @override
  String get mapHub_offlinePacks => 'ПАКЕТИ ОФЛАЙН-МАП';

  @override
  String get mapHub_offlinePacksHint =>
      'Кешуйте тайли мап для походів і місць без зв\'язку';

  @override
  String get mapHub_badgeOffline => 'ОФЛАЙН';

  @override
  String get mapHub_regions => 'ПРОФІЛІ РЕГІОНІВ';

  @override
  String get mapHub_regionsHint =>
      'Керуйте регіональними визначеннями мережі й завантажуйте їх';

  @override
  String get mapHub_badgeRegions => 'РЕГІОНИ';

  @override
  String get routes_title => 'Аналіз маршрутів';

  @override
  String get routes_headline => 'Подивіться, як трафік рухається мережею.';

  @override
  String get routes_body =>
      'NOTORYX Core ранжує збережені маршрути за історією шляхів, уже вивченою з реальних спроб надсилання повідомлень і виявлення.';

  @override
  String get routes_routes => 'МАРШРУТИ';

  @override
  String get routes_success => 'УСПІХИ';

  @override
  String get routes_failed => 'НЕВДАЧІ';

  @override
  String get routes_routeMap => 'МАПА МАРШРУТІВ';

  @override
  String get routes_routeMapHint => 'Досліджуйте вузли й шляхи';

  @override
  String get routes_discover => 'ВИЯВИТИ';

  @override
  String get routes_discoverHint => 'Знайти нові маршрути';

  @override
  String get routes_learned => 'ВИВЧЕНІ МАРШРУТИ';

  @override
  String get routes_none => 'ІСТОРІЇ МАРШРУТІВ ЩЕ НЕМАЄ';

  @override
  String get routes_noneBody =>
      'Користуйтеся мережею як зазвичай або запустіть виявлення. NOTORYX Core покаже тут вивчені маршрути, коли з\'явиться історія шляхів.';

  @override
  String get routes_direct => 'НАПРЯМУ';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count маршруту',
      many: '$count маршрутів',
      few: '$count маршрути',
      one: '$count маршрут',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return 'НАЙКРАЩИЙ  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  вага $weight  •  успіхів: $success / невдач: $fail';
  }

  @override
  String routes_fastest(String ms) {
    return 'Найшвидший відомий: $ms мс';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'Flood: успіхів: $success / невдач: $fail';
  }

  @override
  String get repeaterTools_heroLabel => 'КЕРУВАННЯ РЕТРАНСЛЯТОРАМИ';

  @override
  String get repeaterTools_headline => 'Керуйте інфраструктурою своєї мережі.';

  @override
  String get repeaterTools_body =>
      'Виберіть виявлений ретранслятор, щоб увійти й відкрити його наявні інструменти MeshCore: стан, телеметрію, сусідів, налаштування й CLI.';

  @override
  String get repeaterTools_discovered => 'ВИЯВЛЕНО';

  @override
  String get repeaterTools_tools => 'ІНСТРУМЕНТИ';

  @override
  String get repeaterTools_available => 'ДОСТУПНІ РЕТРАНСЛЯТОРИ';

  @override
  String get repeaterTools_unnamed => 'Ретранслятор без назви';

  @override
  String get repeaterTools_statusTelemetry => 'СТАН + ТЕЛЕМЕТРІЯ';

  @override
  String get repeaterTools_statusTelemetryBody =>
      'Перевіряйте стан і телеметрію ретранслятора наявними інструментами керування.';

  @override
  String get repeaterTools_neighbors => 'СУСІДИ';

  @override
  String get repeaterTools_neighborsBody =>
      'Досліджуйте сусідню інфраструктуру й зв\'язки в мережі.';

  @override
  String get repeaterTools_cli => 'CLI + НАЛАШТУВАННЯ';

  @override
  String get repeaterTools_cliBody =>
      'Адміністратори, що увійшли, мають доступ до наявного CLI ретранслятора й інструментів налаштування.';

  @override
  String get repeaterTools_empty =>
      'Ретранслятори ще не виявлено. Під\'єднайте радіостанцію й спершу дослідіть мережу.';

  @override
  String get notification_fieldAlertTitle => 'Польове сповіщення NOTORYX';

  @override
  String get notification_checkInReminderTitle =>
      'Нагадування NOTORYX Core про позначку';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return 'Немає позначки вже $minutes хв у поході «$trip». Відкрийте NOTORYX Core, щоб позначитися.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return '$name не виходить на зв\'язок $minutes хв. Це не підтверджена надзвичайна ситуація.';
  }

  @override
  String get notification_aTripContact => 'Контакт походу';

  @override
  String notification_checkInNotDelivered(String name) {
    return 'Позначку не доставлено: $name. Її можна надіслати повторно на вкладці «Похід».';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return 'SOS підтверджено: $name';
  }

  @override
  String get settings_batterySaver => 'Економія заряду';

  @override
  String get settings_batterySaverOn =>
      'Увімк.: заряд радіостанції кожні 10 хв, GPS кожні 5 хв, статистика не частіше разу на хвилину, перевірки походу кожні 1–2 хв. Повідомлення, сповіщення й SOS не змінюються.';

  @override
  String get settings_batterySaverOff =>
      'Рідше перевіряти радіостанцію й похід, щоб заощадити заряд телефона й радіостанції. Повідомлення, сповіщення й SOS не змінюються.';

  @override
  String get settings_readAloud => 'Читати нові повідомлення вголос';

  @override
  String get settings_readAloudHelper =>
      'Поки NOTORYX Core відкрито. Канали без звуку не озвучуються. Будь-яке повідомлення можна прочитати вголос з його меню.';

  @override
  String get settings_readAloudOff => 'Вимк.';

  @override
  String get settings_readAloudDirect => 'Особисті повідомлення';

  @override
  String get settings_readAloudAll =>
      'Особисті повідомлення й повідомлення каналів';

  @override
  String get chat_readAloud => 'Прочитати вголос';

  @override
  String get messageSearch_title => 'Пошук повідомлень';

  @override
  String get messageSearch_intro =>
      'Шукайте в усіх особистих повідомленнях і повідомленнях каналів, збережених на цьому телефоні.';

  @override
  String messageSearch_noResults(String query) {
    return 'Жодне повідомлення не містить «$query».';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count збігу',
      many: '$count збігів',
      few: '$count збіги',
      one: '$count збіг',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return 'Показано останні збіги ($count)';
  }

  @override
  String get shortcuts_checkIn => 'Позначитися';

  @override
  String get shortcuts_trip => 'Похід';

  @override
  String get shortcuts_chats => 'Чати';

  @override
  String get shortcuts_map => 'Мапа';

  @override
  String get sensor_liveUpdates => 'Оновлення наживо';

  @override
  String get sensor_intro =>
      'Нехай датчик сам надсилає показники, коли вони змінюються, а не на запит щоразу. Потрібен вхід із правом читання.';

  @override
  String get sensor_watch => 'Стежити за змінами';

  @override
  String get sensor_loadFirst =>
      'Спершу завантажте телеметрію, щоб вибрати показники.';

  @override
  String sensor_watching(String readings, String time) {
    return 'Відстежується: $readings до $time.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return 'Відстежується: $readings до $time • регіон $region.';
  }

  @override
  String get sensor_noChanges => 'Змін поки не надходило.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return 'Останнє оновлення $time • отримано: $count';
  }

  @override
  String get sensor_stop => 'Зупинити оновлення наживо';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'Зупинено тут; датчик не підтвердив і припинить надсилання, коли мине час. $error';
  }

  @override
  String get sensor_dialogBody =>
      'Датчик перевіряє показники приблизно раз на хвилину й надсилає оновлення, коли вибраний показник змінюється більше за поріг.';

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
    return 'Оновлювати при зміні на $delta';
  }

  @override
  String get sensor_changeThreshold => 'Змінити поріг';

  @override
  String sensor_capacity(int max, String used) {
    return 'Датчик може відстежувати до $max байт показників (зайнято: $used).';
  }

  @override
  String get sensor_for => 'Тривалість';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count години',
      many: '$count годин',
      few: '$count години',
      one: '$count година',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => 'Почати';

  @override
  String sensor_thresholdTitle(String label) {
    return 'Поріг: $label';
  }

  @override
  String get sensor_typeTemperature => 'Температура';

  @override
  String get sensor_typeHumidity => 'Вологість';

  @override
  String get sensor_typePressure => 'Тиск';

  @override
  String get sensor_typeVoltage => 'Напруга';

  @override
  String get sensor_typeCurrent => 'Струм';

  @override
  String get sensor_typeLight => 'Освітленість';

  @override
  String get sensor_typeConcentration => 'Концентрація';

  @override
  String get sensor_typePercentage => 'Відсоток';

  @override
  String get sensor_typeAnalogInput => 'Аналоговий вхід';

  @override
  String get sensor_typeAltitude => 'Висота';

  @override
  String get setupWizard_title => 'Підключіть радіо';

  @override
  String get setupWizard_choose => '1. Виберіть підключення';

  @override
  String get setupWizard_prepare => '2. Підготуйте радіо';

  @override
  String get setupWizard_intro =>
      'Виберіть, як цей телефон або комп\'ютер підключатиметься до радіо. Радіо передає повідомлення mesh-мережею.';

  @override
  String get setupWizard_bluetooth =>
      'Бездротове підключення до сумісного радіо поблизу.';

  @override
  String get setupWizard_noBluetooth =>
      'Bluetooth недоступний у цьому браузері. Використайте нативний застосунок або підтримуване USB-підключення.';

  @override
  String get setupWizard_usb =>
      'Дротове підключення USB-кабелем для передавання даних.';

  @override
  String get setupWizard_noUsb =>
      'USB-serial тут недоступний. Використайте підтримуваний застосунок для комп\'ютера чи Android або Chrome з Web Serial.';

  @override
  String get setupWizard_bluetoothSteps =>
      'Увімкніть радіо й тримайте його поруч. Увімкніть Bluetooth і дозвольте застосунку його використовувати. Закрийте інші застосунки, підключені до радіо, відкрийте список пристроїв і почніть пошук.';

  @override
  String get setupWizard_usbSteps =>
      'Підключіть увімкнене радіо USB-кабелем для передавання даних; кабель лише для заряджання не підійде. Закрийте інші застосунки для послідовного порту. Відкрийте список USB-пристроїв, виберіть радіо й дозвольте доступ, якщо з\'явиться запит.';

  @override
  String get setupWizard_firmwareTitle =>
      'Перевірте сумісність перед зміною прошивки';

  @override
  String get setupWizard_firmware =>
      'Радіо потрібна прошивка MeshCore companion із підтримкою вибраного підключення. Підтримка залежить від плати й збірки прошивки; наявність USB-роз\'єму ще не означає підтримки USB-serial. Перевірте інструкції для вашої плати та встановленої збірки. Прошивка ретранслятора чи кімнатного сервера не є companion. Невдале підключення саме по собі не означає, що потрібно перепрошивати.';

  @override
  String get setupWizard_settings =>
      'Цей майстер не прошиває радіо й не змінює його налаштування. Після підключення використовуйте Налаштування для регіону, частоти й додаткових параметрів. Узгодьте налаштування з вашою локальною mesh-мережею, перш ніж їх змінювати.';

  @override
  String get setupWizard_openBluetooth => 'Відкрити пристрої Bluetooth';

  @override
  String get setupWizard_openUsb => 'Відкрити пристрої USB';

  @override
  String get setupWizard_change => 'Змінити тип підключення';

  @override
  String get setupWizard_later => 'Налаштувати пізніше';

  @override
  String get setupWizard_bluetoothError =>
      'Не вдалося підключитися до радіо. Тримайте його ввімкненим і поруч, перевірте дозволи Bluetooth і закрийте інші підключені застосунки. Потім повторіть пошук.';

  @override
  String get setupWizard_scanError =>
      'Не вдалося знайти радіо. Увімкніть Bluetooth і дозвольте доступ до Bluetooth або пристроїв поблизу в налаштуваннях системи, потім повторіть пошук.';

  @override
  String get setupWizard_usbError =>
      'Не вдалося підключитися через USB. Перевірте кабель для передавання даних і вибраний пристрій, дозвольте доступ до USB і закрийте інші застосунки для послідовного порту. Перепідключіть кабель і спробуйте ще раз.';

  @override
  String get connections_title => 'Підключення';

  @override
  String get connections_radioTitle => 'Підключення радіо';

  @override
  String get connections_bluetoothOffNotice =>
      'Bluetooth вимкнено. Увімкніть його, щоб перепідключитися; застосунок повторить спробу, щойно він запрацює.';

  @override
  String get connections_transport => 'Спосіб підключення';

  @override
  String connections_lastError(String error) {
    return 'Остання помилка: $error';
  }

  @override
  String get connections_disconnectRadio => 'Від\'єднати радіо';

  @override
  String connections_reconnectTo(String name) {
    return 'Перепідключитися до $name';
  }

  @override
  String get connections_forgetRadio => 'Забути радіо';

  @override
  String get connections_connectAnother => 'Підключити інше радіо';

  @override
  String get connections_usbSerial => 'USB-serial';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'Пристрій';

  @override
  String get connections_publicKey => 'Відкритий ключ';

  @override
  String get connections_firmware => 'Прошивка';

  @override
  String connections_firmwareProtocol(String code) {
    return 'протокол v$code';
  }

  @override
  String get connections_battery => 'Батарея';

  @override
  String get connections_lastRx => 'Останній прийом';

  @override
  String get connections_reconnectFailed =>
      'Не вдалося перепідключитися до радіо';

  @override
  String get connections_statusBluetoothOff => 'Bluetooth вимкнено';

  @override
  String get connections_statusConnected => 'Підключено';

  @override
  String get connections_statusConnecting => 'Підключення…';

  @override
  String get connections_statusDisconnecting => 'Від\'єднання…';

  @override
  String get connections_statusScanning => 'Пошук радіо…';

  @override
  String get connections_statusReconnectingSoon => 'Незабаром перепідключення…';

  @override
  String get connections_statusNotConnected => 'Не підключено';

  @override
  String get mqtt_cardTitle => 'Підключення MQTT';

  @override
  String get mqtt_statusNotConfigured => 'Не налаштовано';

  @override
  String get mqtt_statusDisconnected => 'Від\'єднано';

  @override
  String get mqtt_statusConnecting => 'Підключення';

  @override
  String get mqtt_statusConnected => 'Підключено';

  @override
  String get mqtt_statusReconnecting => 'Перепідключення';

  @override
  String get mqtt_statusError => 'Помилка підключення';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'Брокер: $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn => 'Вхід за токеном, підписаним радіо';

  @override
  String mqtt_tokenSignInAs(String username) {
    return 'Вхід за токеном, підписаним радіо, як $username…';
  }

  @override
  String get mqtt_connectRadioToSignIn => 'Підключіть радіо, щоб увійти';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'Токен оновиться о $time';
  }

  @override
  String mqtt_signedInAs(String username) {
    return 'Вхід виконано як $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return 'Прослуховування $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'Пакети: нових $accepted, повторів $duplicate, хибних $invalid';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return 'Спроба $attempt з $max';
  }

  @override
  String get mqtt_sharingWaitsForRadio =>
      'Публікація чекає на підключення радіо';

  @override
  String mqtt_sharingOn(String topic) {
    return 'Публікація в $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return 'Публікуватиме в $topic';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'Статус онлайн у $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return 'Опубліковано $shared, затримано $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'Додайте брокер, щоб передавати трафік MeshCore через інтернет. Підключення радіо працює незалежно.';

  @override
  String get mqtt_disconnect => 'Від\'єднати MQTT';

  @override
  String get mqtt_connect => 'Підключити MQTT';

  @override
  String get mqtt_packetFeed => 'Стрічка пакетів';

  @override
  String get mqtt_setUpBroker => 'Налаштувати брокер';

  @override
  String get mqtt_brokerSettings => 'Налаштування брокера';

  @override
  String get mqtt_settingsTitle => 'Налаштування брокера MQTT';

  @override
  String get mqtt_presetLabel => 'Почати з шаблону';

  @override
  String get mqtt_presetCustom => 'Власний брокер';

  @override
  String get mqtt_presetLocal => 'Локальний брокер (вкажіть адресу)';

  @override
  String get mqtt_presetLetsMeshUs => 'Аналізатор LetsMesh (США, спільнота)';

  @override
  String get mqtt_presetLetsMeshEu => 'Аналізатор LetsMesh (ЄС, спільнота)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh — аналізатор пакетів MeshCore, який веде спільнота; він не входить до NOTORYX і не схвалений NOTORYX. Для публікації потрібне підключене радіо, і вона вимкнена, доки ви її не ввімкнете.';

  @override
  String get mqtt_hostname => 'Ім\'я хоста брокера';

  @override
  String get mqtt_port => 'Порт';

  @override
  String get mqtt_useTls => 'Використовувати TLS';

  @override
  String get mqtt_allowCleartext =>
      'Дозволити нешифроване підключення до локального брокера';

  @override
  String get mqtt_allowCleartextHint =>
      'Лише localhost, .local і приватні хости 10.x / 192.168.x.';

  @override
  String get mqtt_useWebSocket => 'Використовувати WebSocket';

  @override
  String get mqtt_webSocketPath => 'Шлях WebSocket';

  @override
  String get mqtt_topicPrefix => 'Префікс топіка';

  @override
  String get mqtt_region => 'Регіон (необов\'язково)';

  @override
  String get mqtt_regionHelp =>
      'Код регіону спостерігача, наприклад PHL. Залиште порожнім для всіх.';

  @override
  String get mqtt_deliverChannel =>
      'Додавати повідомлення каналів, отримані через MQTT';

  @override
  String get mqtt_deliverChannelHint =>
      'Повідомлення у ваших каналах, які почули спостерігачі, з\'являться в чатах. Вони не надсилаються через ваше радіо.';

  @override
  String get mqtt_sharingTitle => 'Публікація як спостерігач';

  @override
  String get mqtt_share => 'Публікувати пакети, які чує моє радіо';

  @override
  String get mqtt_shareHint =>
      'Публікує оголошення й трафік каналів, які приймає ваше радіо, з його відкритим ключем, рівнем сигналу й регіоном. Повідомлення каналів лишаються зашифрованими. Потрібен регіон.';

  @override
  String get mqtt_shareDirect => 'Включати трафік особистих повідомлень';

  @override
  String get mqtt_shareDirectHint =>
      'Запити, відповіді й особисті повідомлення. Вміст лишається зашифрованим, але видно, які вузли спілкуються між собою.';

  @override
  String get mqtt_shareOwn => 'Включати мої власні повідомлення й оголошення';

  @override
  String get mqtt_signInTitle => 'Вхід';

  @override
  String get mqtt_authPassword => 'Ім\'я користувача й пароль';

  @override
  String get mqtt_authToken => 'Токен, підписаний радіо';

  @override
  String get mqtt_tokenExplain =>
      'Радіо підписує власним ключем токен входу на одну годину, а застосунок оновлює його до завершення. Ключ ніколи не залишає радіо. Ім\'я користувача — v1_ і відкритий ключ вашого радіо.';

  @override
  String get mqtt_radioReady => 'Радіо підключено: можна входити.';

  @override
  String get mqtt_radioNeeded =>
      'Підключіть радіо, щоб увійти. MQTT чекає на нього.';

  @override
  String get mqtt_username => 'Ім\'я користувача (необов\'язково)';

  @override
  String get mqtt_password => 'Пароль';

  @override
  String get mqtt_keepPassword =>
      'Залиште порожнім, щоб зберегти поточний пароль.';

  @override
  String get mqtt_credentialsWeb =>
      'У браузері облікові дані зберігаються лише до закриття сторінки.';

  @override
  String get mqtt_credentialsKeychain =>
      'Облікові дані зберігаються в системній в\'язці ключів, ніколи в налаштуваннях застосунку чи журналах.';

  @override
  String get mqtt_saveSettings => 'Зберегти налаштування';

  @override
  String get mqtt_feedTitle => 'Стрічка пакетів MQTT';

  @override
  String get mqtt_feedConnect =>
      'Підключіться до брокера, щоб бачити пакети від спостерігачів.';

  @override
  String mqtt_feedWaiting(String topic) {
    return 'Очікування пакетів у $topic';
  }

  @override
  String get mqtt_feedUnknownObserver => 'Невідомий спостерігач';

  @override
  String mqtt_feedHeardBy(String observer) {
    return 'Почув $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return 'Переходів: $hops · байтів: $bytes';
  }

  @override
  String get mqtt_packetRequest => 'Запит';

  @override
  String get mqtt_packetResponse => 'Відповідь';

  @override
  String get mqtt_packetDirectMessage => 'Особисте повідомлення';

  @override
  String get mqtt_packetAck => 'Підтвердження';

  @override
  String get mqtt_packetAdvert => 'Оголошення';

  @override
  String get mqtt_packetChannelMessage => 'Повідомлення каналу';

  @override
  String get mqtt_packetChannelData => 'Дані каналу';

  @override
  String get mqtt_packetAnonymousRequest => 'Анонімний запит';

  @override
  String get mqtt_packetPath => 'Маршрут';

  @override
  String get mqtt_packetTrace => 'Трасування';

  @override
  String get mqtt_packetMultipart => 'Складений';

  @override
  String get mqtt_packetControl => 'Керування';

  @override
  String mqtt_packetType(int type) {
    return 'Тип $type';
  }

  @override
  String get mqtt_routeTransportFlood => 'Flood із транспортом';

  @override
  String get mqtt_routeFlood => 'Flood';

  @override
  String get mqtt_routeDirect => 'Прямий';

  @override
  String get mqtt_routeTransportDirect => 'Прямий із транспортом';

  @override
  String get mqtt_noticeInvalidHost =>
      'Введіть ім\'я хоста або адресу IPv4 без схеми й порту.';

  @override
  String get mqtt_noticeInvalidPort => 'Порт має бути від 1 до 65535.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'Шлях WebSocket має починатися з / і не містити запиту чи фрагмента.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'Префікс топіка має бути непорожнім шляхом MQTT без символів підстановки.';

  @override
  String get mqtt_noticeInvalidRegion =>
      'Регіон — від 2 до 8 літер або цифр, наприклад PHL.';

  @override
  String get mqtt_noticeTlsRequired =>
      'TLS обов\'язковий, якщо явно не дозволено небезпечний доступ до локального брокера.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      'Нешифрований MQTT дозволено лише для явно схвалених локальних хостів.';

  @override
  String get mqtt_noticeRegionNeededToShare =>
      'Задайте регіон, щоб публікувати пакети як спостерігач.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return 'Введіть пароль для $username.';
  }

  @override
  String get mqtt_noticeNoNetwork =>
      'Немає мережі. MQTT перепідключиться, коли вона з\'явиться.';

  @override
  String get mqtt_noticeSubscriptionRefused =>
      'Брокер відхилив підписку на пакети.';

  @override
  String get mqtt_noticeBadCredentials =>
      'Брокер відхилив ім\'я користувача або пароль.';

  @override
  String get mqtt_noticeNotAuthorized =>
      'Цей обліковий запис не має прав на брокері.';

  @override
  String get mqtt_noticeConnectionRefused => 'Брокер відхилив підключення.';

  @override
  String get mqtt_noticeUnreachable => 'Брокер недоступний.';

  @override
  String get mqtt_noticeTlsFailed =>
      'Не вдалося встановити захищене (TLS) з\'єднання.';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'Ця платформа підтримує MQTT лише через WebSocket.';

  @override
  String get mqtt_noticeRadioNotConnected =>
      'Підключіть радіо, щоб увійти з його ключем.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'Прошивка цього радіо не вміє підписувати його ключем.';

  @override
  String get mqtt_noticeSigningTimeout =>
      'Радіо не відповіло на запит підпису. Можливо, його прошивка не підтримує підпис.';

  @override
  String get mqtt_noticeSigningTooLong =>
      'Дані задовгі, щоб радіо могло їх підписати.';

  @override
  String get mqtt_noticeSigningRejected =>
      'Радіо відмовилося підписувати дані.';

  @override
  String get scanner_signalStrong => 'Сильний';

  @override
  String get scanner_signalGood => 'Добрий';

  @override
  String get scanner_signalFair => 'Середній';

  @override
  String get scanner_signalWeak => 'Слабкий';

  @override
  String get scanner_nearbyRadios => 'Радіо поблизу';

  @override
  String get scanner_lastRadio => 'Останнє радіо';

  @override
  String get scanner_reconnect => 'Перепідключити';

  @override
  String get scanner_tcpHint => 'Радіо з прошивкою Wi‑Fi у вашій мережі.';

  @override
  String get scanner_otherWays => 'Інші способи підключення';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count радіо поблизу',
      one: '1 радіо поблизу',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => 'Пошук радіо…';

  @override
  String get scanner_findTitle => 'Знайдіть своє радіо';

  @override
  String get scanner_heroHint =>
      'Увімкніть радіо й тримайте його за кілька метрів. Потрібна прошивка MeshCore companion.';

  @override
  String get scanner_tipsTitle => 'Не бачите свого радіо?';

  @override
  String get scanner_tipPower => 'Перевірте, що воно увімкнене й активне.';

  @override
  String get scanner_tipFirmware =>
      'Потрібна прошивка MeshCore companion. Ретранслятори й кімнатні сервери тут не показуються.';

  @override
  String get scanner_tipOtherDevice =>
      'Радіо підключається лише до одного пристрою одночасно. Від’єднайте його від інших телефонів чи комп’ютерів.';

  @override
  String get connections_internetBridge => 'Інтернет-міст';

  @override
  String get connections_noRadio => 'Немає радіо';

  @override
  String get connections_radioSettings => 'Налаштування радіо';

  @override
  String get connections_viewDashboard => 'Відкрити панель підключень';

  @override
  String get channelDirectory_title => 'Каталог каналів';

  @override
  String get channelDirectory_subtitle =>
      'Знайдіть публічні хештег-канали поруч';

  @override
  String get channelDirectory_search => 'Пошук каналів або місць';

  @override
  String get channelDirectory_nearYou => 'Поруч із вами';

  @override
  String get channelDirectory_all => 'Усі канали';

  @override
  String get channelDirectory_catAll => 'Усі';

  @override
  String get channelDirectory_catEmergency => 'Екстрені';

  @override
  String get channelDirectory_catLocal => 'Місцеві';

  @override
  String get channelDirectory_catGeneral => 'Загальні';

  @override
  String get channelDirectory_catInterest => 'Інтереси';

  @override
  String get channelDirectory_catTest => 'Тестові';

  @override
  String get channelDirectory_join => 'Приєднатися';

  @override
  String get channelDirectory_joined => 'Приєднано';

  @override
  String get channelDirectory_noMatches => 'Немає каналів за вашим запитом.';

  @override
  String get channelDirectory_connectFirst =>
      'Підключіть радіо, щоб приєднуватися до каналів.';

  @override
  String get channelDirectory_slotsFull =>
      'Усі слоти каналів на радіо зайняті. Спочатку видаліть канал.';

  @override
  String get channelDirectory_joinFailed =>
      'Не вдалося додати канал. Спробуйте ще раз.';

  @override
  String get channelDirectory_addHint =>
      'Бракує каналу? Будь-хто може запропонувати його, відредагувавши спільний список на GitHub.';

  @override
  String get prefixTool_title => 'ID ретрансляторів';

  @override
  String get prefixTool_subtitle =>
      'Хто використовує ID, які ID збігаються і вільні ID для нового ретранслятора';

  @override
  String get prefixTool_width => 'Розмір ID маршруту';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes байт';
  }

  @override
  String get prefixTool_includeCompanions =>
      'Враховувати компаньйони й датчики';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return 'Відомо вузлів: $nodes · зайнято ID: $used · спільних: $shared';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return 'Вільно ID: $free із $space';
  }

  @override
  String get prefixTool_lookupHint => 'Знайти ID, наприклад 3D';

  @override
  String prefixTool_lookupFree(String id) {
    return 'Жоден відомий вузол не використовує $id.';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$id використовують вузлів: $count',
      one: '$id використовує 1 вузол',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => 'Спільні ID';

  @override
  String get prefixTool_sharedHint =>
      'Маршрути через ці ID виглядають однаково, якщо мережа не використовує довші ID.';

  @override
  String get prefixTool_noShared => 'Серед відомих вузлів немає спільних ID.';

  @override
  String get prefixTool_free => 'Вільні ID';

  @override
  String get prefixTool_shuffle => 'Ще варіанти';

  @override
  String get prefixTool_makeKey => 'Створити ключ';

  @override
  String get prefixTool_onlyKnown =>
      'Лише за вузлами, які чуло ваше радіо. Вільний тут ID може належати ретранслятору, якого ви не чули.';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id вже використовує $name.';
  }

  @override
  String get prefixTool_pickFree => 'Вибрати вільний ID';

  @override
  String keyGen_title(String id) {
    return 'Ключ для ID $id';
  }

  @override
  String keyGen_searching(int tries) {
    return 'Пошук… перевірено ключів: $tries';
  }

  @override
  String get keyGen_publicKey => 'Відкритий ключ';

  @override
  String get keyGen_privateKey => 'Закритий ключ';

  @override
  String get keyGen_copy => 'Копіювати';

  @override
  String get keyGen_copied => 'Скопійовано';

  @override
  String get keyGen_secretWarning =>
      'Зберігайте закритий ключ у таємниці. Хто його має, може видавати себе за цей вузол.';

  @override
  String get keyGen_howToUse =>
      'Для ретранслятора: відкрийте його налаштування, вставте як закритий ключ і збережіть. Радіо-компаньйонам потрібна прошивка з дозволеним імпортом ключа.';

  @override
  String get keyGen_tryAgain => 'Створити ще';

  @override
  String get regionSetup_title => 'Налаштування регіонів';

  @override
  String get regionSetup_hubSubtitle =>
      'Помістити ретранслятор у дерево регіонів вашої місцевості';

  @override
  String get regionSetup_intro =>
      'Регіони утримують повідомлення в межах області, а не розсилають його всією мережею. Ретранслятор передає повідомлення регіону, лише якщо цей регіон у нього задано, тож задайте йому його регіон і всі регіони вище.';

  @override
  String get regionSetup_where => 'Де стоїть ретранслятор?';

  @override
  String get regionSetup_tree => 'Дерево регіонів';

  @override
  String get regionSetup_custom => 'Власне';

  @override
  String get regionSetup_region => 'Найлокальніший регіон';

  @override
  String regionSetup_source(String source) {
    return 'Джерело: $source';
  }

  @override
  String get regionSetup_customLabel => 'Регіони, від найширшого';

  @override
  String regionSetup_invalidName(String name) {
    return '«$name» — неприпустима назва регіону. Використовуйте малі латинські літери, цифри й дефіси, до 29 символів.';
  }

  @override
  String regionSetup_tooMany(int max) {
    return 'Ретранслятору можна задати щонайбільше $max регіонів.';
  }

  @override
  String get regionSetup_options => 'Параметри';

  @override
  String get regionSetup_setDefault => 'Зробити найлокальніший регіон основним';

  @override
  String get regionSetup_setDefaultBody =>
      'Власні оголошення ретранслятора залишаться в цьому регіоні.';

  @override
  String get regionSetup_legacy => 'Прошивка 1.14';

  @override
  String get regionSetup_legacyBody =>
      'Додає region allowf після кожного регіону. Не потрібно з 1.15.';

  @override
  String get regionSetup_denyUnscoped =>
      'Не передавати повідомлення без регіону';

  @override
  String get regionSetup_denyUnscopedBody =>
      'Вмикайте лише тоді, коли вся місцевість використовує регіони, інакше повідомлення зі старих застосунків не пройдуть.';

  @override
  String get regionSetup_commands => 'Команди';

  @override
  String get regionSetup_copyAll => 'Копіювати все';

  @override
  String get regionSetup_copied => 'Скопійовано';

  @override
  String get regionSetup_pickFirst => 'Виберіть регіон, щоб побачити команди.';

  @override
  String regionSetup_sendTo(String name) {
    return 'Надіслати на $name';
  }

  @override
  String get regionSetup_howToSend =>
      'Щоб надіслати їх, увійдіть у ретранслятор і відкрийте «Налаштування регіонів» у його меню або вставте їх у його командний рядок.';

  @override
  String get regionSetup_noReply => 'Немає відповіді. Зупинено тут.';

  @override
  String get regionSetup_addToMine => 'Додати ці регіони до мого списку';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'До списку додано регіонів: $count',
      one: 'До списку додано 1 регіон',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => 'Журнал маршруту';

  @override
  String get trackLog_subtitle => 'Записуйте трек за GPS радіо';

  @override
  String get trackLog_recording => 'Іде запис';

  @override
  String get trackLog_notRecording => 'Запис не ведеться';

  @override
  String get trackLog_noGps =>
      'Радіо не повідомляє GPS-позицію. Для журналу маршруту потрібне радіо з увімкненим GPS.';

  @override
  String get trackLog_start => 'Почати запис';

  @override
  String get trackLog_stop => 'Зупинити запис';

  @override
  String get trackLog_howItWorks =>
      'Використовує позицію, яку радіо повідомляє приблизно раз на хвилину, поки NOTORYX Core відкритий. Точка додається після переміщення на 25 м або кожні 15 хвилин на місці.';

  @override
  String get trackLog_snap => 'Округлювати позиції приблизно до 100 м';

  @override
  String get trackLog_snapBody => 'Для конфіденційності, коли ділитеся треком.';

  @override
  String get trackLog_saved => 'Збережені треки';

  @override
  String get trackLog_none => 'Треків поки немає.';

  @override
  String get trackLog_export => 'Експорт у GPX';

  @override
  String get trackLog_exportFailed => 'Не вдалося експортувати трек.';

  @override
  String get trackLog_deleteTitle => 'Видалити цей трек?';

  @override
  String get trackLog_deleteBody =>
      'Його буде видалено з цього пристрою. Експортовані GPX-файли не змінюються.';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km км · $duration · точок: $points';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'Трек NOTORYX $when';
  }

  @override
  String get routes_nearbyTitle => 'НАЙКРАЩІ РЕТРАНСЛЯТОРИ ПОРУЧ';

  @override
  String get routes_nearbyEmptyTitle => 'Ретранслятори ще не чути';

  @override
  String get routes_nearbyEmpty =>
      'Ретранслятори, які радіо чує напряму, з’являються тут, починаючи з найсильніших, у міру приймання трафіку. Список охоплює останню годину.';

  @override
  String get routes_unknownRepeater => 'Невідомий ретранслятор';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'чути разів: $count',
      one: 'чути 1 раз',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes хв тому',
      one: '1 хв тому',
      zero: 'щойно',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return 'через $names';
  }
}
