// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core';

  @override
  String get nav_contacts => '联系人';

  @override
  String get nav_channels => '频道';

  @override
  String get nav_map => '地图';

  @override
  String get nav_messages => '消息';

  @override
  String get nav_nodes => '节点';

  @override
  String get nav_radio => '电台';

  @override
  String get messages_title => '消息';

  @override
  String get messages_filterAll => '全部';

  @override
  String get messages_filterDirect => '私信';

  @override
  String get messages_filterChannels => '频道';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => '搜索消息';

  @override
  String get messages_searchHint => '搜索对话';

  @override
  String get messages_closeSearch => '关闭搜索';

  @override
  String get messages_manageChannels => '管理频道';

  @override
  String get messages_new => '新建';

  @override
  String get messages_newDirect => '给节点发消息';

  @override
  String get messages_newChannel => '添加或加入频道';

  @override
  String get messages_empty => '还没有对话';

  @override
  String get messages_emptyHint => '来自节点和频道的消息会显示在这里。';

  @override
  String get messages_noMatches => '没有与搜索匹配的对话';

  @override
  String messages_you(String text) {
    return '你：$text';
  }

  @override
  String get messages_yesterday => '昨天';

  @override
  String messages_unreadCount(int count) {
    return '$count 条未读';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return '通过 $transport 连接';
  }

  @override
  String get radioStatus_bluetooth => '蓝牙';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'Wi‑Fi (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return '电池 $percent%';
  }

  @override
  String get radioStatus_openRadio => '打开电台详情';

  @override
  String get radioOverview_battery => '电池';

  @override
  String radioOverview_firmware(String version) {
    return '固件 $version';
  }

  @override
  String get radioOverview_sendAdvert => '发送广播';

  @override
  String get radioOverview_stats => '电台统计';

  @override
  String get accessControl_title => '访问控制';

  @override
  String get accessControl_hubSubtitle => '谁可以免密码登录';

  @override
  String get accessControl_explainRepeater =>
      '列表中的成员无需密码即可登录。管理员可以更改设置；“只读”和“读写”还会获得完整遥测数据。';

  @override
  String get accessControl_explainRoom => '列表中的管理员无需密码即可登录并管理房间。房间成员则使用房间密码加入。';

  @override
  String get accessControl_roleReadOnly => '只读';

  @override
  String get accessControl_roleReadWrite => '读写';

  @override
  String get accessControl_roleAdmin => '管理员';

  @override
  String get accessControl_you => '你';

  @override
  String get accessControl_unknownNode => '未知节点';

  @override
  String get accessControl_add => '添加';

  @override
  String get accessControl_addTitle => '添加到访问列表';

  @override
  String get accessControl_pickContact => '选择联系人';

  @override
  String get accessControl_noContacts => '没有可添加的联系人。收到节点的广播后，它们会显示在这里。';

  @override
  String get accessControl_changeRole => '更改角色';

  @override
  String get accessControl_remove => '移除访问权限';

  @override
  String accessControl_removeConfirm(String name) {
    return '要将 $name 从访问列表中移除吗？之后登录需要密码。';
  }

  @override
  String get accessControl_removeSelfWarning => '这是你自己。移除自己后，需要管理员密码才能再次管理此节点。';

  @override
  String get accessControl_unknownKeyNote => '不在你的联系人中。更改其角色需要更新的节点固件；移除始终可用。';

  @override
  String get accessControl_prefixUnsupported =>
      '该节点的固件无法更改不在你联系人中的成员角色。你仍可以将其移除。';

  @override
  String get accessControl_empty => '访问列表为空';

  @override
  String get accessControl_emptyHint => '添加成员后，他们无需密码即可登录。';

  @override
  String get accessControl_loading => '正在向节点获取访问列表…';

  @override
  String get accessControl_timeout => '节点没有响应。请检查路径后重试。';

  @override
  String get accessControl_maybeIncomplete =>
      '该节点发送了一整页，但其固件无法发送更多，因此可能缺少部分条目。';

  @override
  String get accessControl_saved => '访问列表已更新';

  @override
  String accessControl_failed(String reply) {
    return '节点拒绝了此更改：$reply';
  }

  @override
  String get companionCli_title => '命令行';

  @override
  String get companionCli_tileSubtitle => '在电台上运行命令';

  @override
  String get companionCli_warning => '命令会在已连接的电台上运行，可能更改其设置或使其重启。';

  @override
  String get companionCli_hint => '输入命令，例如 ver';

  @override
  String get companionCli_send => '运行命令';

  @override
  String get companionCli_noReply => '无响应。电台可能正在重启。';

  @override
  String get companionCli_empty => '试试上面的命令，或输入你自己的命令。';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle => '将电台连接到 Wi‑Fi 网络';

  @override
  String get wifi_unsupported => '此电台的固件不支持 Wi‑Fi。';

  @override
  String get wifi_enabled => '使用 Wi‑Fi';

  @override
  String get wifi_status => '状态';

  @override
  String get wifi_connected => '已连接';

  @override
  String wifi_connectedIp(String ip) {
    return '已连接 · $ip';
  }

  @override
  String get wifi_disconnected => '未连接';

  @override
  String get wifi_network => '网络名称 (SSID)';

  @override
  String get wifi_password => '密码';

  @override
  String get wifi_passwordKeep => '留空以保留当前密码';

  @override
  String get wifi_save => '保存';

  @override
  String get wifi_forget => '忘记网络';

  @override
  String get wifi_forgetConfirm => '要从电台中删除已保存的网络和密码吗？';

  @override
  String get wifi_rebootNeeded => '已保存。重启电台以应用 Wi‑Fi 更改。';

  @override
  String get wifi_rebootNow => '重启电台';

  @override
  String get wifi_rebootConfirm => '现在重启电台吗？应用会断开连接，你需要重新连接。';

  @override
  String get wifi_loadFailed => '无法从电台读取 Wi‑Fi 设置。';

  @override
  String get wifi_retry => '重试';

  @override
  String wifi_saveFailed(String reply) {
    return '电台未接受此更改：$reply';
  }

  @override
  String get accessControl_refresh => '刷新';

  @override
  String get common_cancel => '取消';

  @override
  String get common_ok => '确定';

  @override
  String get common_connect => '连接';

  @override
  String get common_unknownDevice => '未知设备';

  @override
  String get common_save => '保存';

  @override
  String get common_delete => '删除';

  @override
  String get common_deleteAll => '删除全部';

  @override
  String get common_close => '关闭';

  @override
  String get common_done => 'Done';

  @override
  String get common_edit => '编辑';

  @override
  String get common_add => '添加';

  @override
  String get common_settings => '设置';

  @override
  String get common_disconnect => '断开';

  @override
  String get common_connected => '已连接';

  @override
  String get common_disconnected => '已断开';

  @override
  String get common_create => '创建';

  @override
  String get common_continue => '继续';

  @override
  String get common_share => '分享';

  @override
  String get common_copy => '复制';

  @override
  String get common_retry => '重试';

  @override
  String get common_hide => '隐藏';

  @override
  String get common_remove => '移除';

  @override
  String get common_enable => '启用';

  @override
  String get common_disable => '禁用';

  @override
  String get common_undo => '撤销';

  @override
  String get messageStatus_sent => '发送';

  @override
  String get messageStatus_delivered => '已送达';

  @override
  String get messageStatus_pending => '发送';

  @override
  String get messageStatus_failed => '发送失败';

  @override
  String get messageStatus_repeated => '多次听到';

  @override
  String get urlImage_enable => '启用 URL 图片';

  @override
  String get urlImage_possible => '可能是 URL 图片；请在设置中启用。';

  @override
  String get common_reboot => '重启';

  @override
  String get common_loading => '正在加载...';

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
  String get common_autoRefresh => '自动刷新';

  @override
  String get common_interval => '间隔';

  @override
  String get scanner_title => '连接设备';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => '蓝牙';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => '通过 TCP 连接';

  @override
  String get tcpHostLabel => 'IP地址';

  @override
  String get tcpHostHint => '192.168.40.10';

  @override
  String get tcpPortLabel => '端口';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => '输入目标地址，然后连接';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return '连接到 $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => '需要提供IP地址。';

  @override
  String get tcpErrorPortInvalid => '端口号必须在 1 到 65535 之间。';

  @override
  String get tcpErrorUnsupported => '此平台不支持 TCP 传输。';

  @override
  String get tcpErrorTimedOut => 'TCP 连接超时。';

  @override
  String tcpConnectionFailed(String error) {
    return 'TCP 连接失败：$error';
  }

  @override
  String get usbScreenTitle => '通过USB连接';

  @override
  String get usbScreenSubtitle => '选择已检测到的串行设备，并直接连接到您的 MeshCore 节点。';

  @override
  String get usbScreenStatus => '选择一个 USB 设备';

  @override
  String get usbScreenNote => 'USB 串行接口在支持的 Android 设备和桌面平台上处于活动状态。';

  @override
  String get usbScreenEmptyState => '未找到任何 USB 设备。请插入一个，然后刷新。';

  @override
  String get usbErrorPermissionDenied => '拒绝了USB权限。';

  @override
  String get usbErrorDeviceMissing => '所选的USB设备已不再可用。';

  @override
  String get usbErrorInvalidPort => '选择一个有效的USB设备。';

  @override
  String get usbErrorBusy => '还有一个 USB 连接请求正在进行中。';

  @override
  String get usbErrorNotConnected => '没有连接任何USB设备。';

  @override
  String get usbErrorOpenFailed => '未能打开所选的USB设备。';

  @override
  String get usbErrorConnectFailed => '未能连接到所选的USB设备。';

  @override
  String get usbErrorUnsupported => '此平台不支持USB串行通信。';

  @override
  String get usbErrorAlreadyActive => 'USB 连接已建立。';

  @override
  String get usbErrorNoDeviceSelected => '未选择任何 USB 设备。';

  @override
  String get usbErrorPortClosed => 'USB 连接未建立。';

  @override
  String get usbErrorConnectTimedOut => '连接超时。请确保设备已安装 USB 伴侣固件。';

  @override
  String get usbFallbackDeviceName => 'Web 串流设备';

  @override
  String get usbStatus_notConnected => '选择一个 USB 设备';

  @override
  String get usbStatus_connecting => '连接USB设备...';

  @override
  String get usbStatus_searching => '正在搜索 USB 设备...';

  @override
  String usbConnectionFailed(String error) {
    return 'USB 连接失败：$error';
  }

  @override
  String get scanner_scanning => '正在搜索设备...';

  @override
  String get scanner_connecting => '正在连接...';

  @override
  String get scanner_disconnecting => '断开连接...';

  @override
  String get scanner_notConnected => '未连接';

  @override
  String scanner_connectedTo(String deviceName) {
    return '已连接到 $deviceName';
  }

  @override
  String get scanner_searchingDevices => '正在搜索 MeshCore 设备...';

  @override
  String get scanner_tapToScan => '点击“扫描”按钮以查找 MeshCore 设备。';

  @override
  String scanner_connectionFailed(String error) {
    return '连接失败：$error';
  }

  @override
  String get scanner_stop => '停止';

  @override
  String get scanner_scan => '扫描';

  @override
  String get scanner_bluetoothOff => '蓝牙已关闭';

  @override
  String get scanner_bluetoothOffMessage => '请开启蓝牙以搜索设备';

  @override
  String get scanner_chromeRequired => '需要 Chrome 浏览器';

  @override
  String get scanner_chromeRequiredMessage =>
      '此 Web 应用程序需要 Google Chrome 或基于 Chromium 的浏览器以支持蓝牙。';

  @override
  String get scanner_enableBluetooth => '启用蓝牙';

  @override
  String get scanner_bluetoothWebUnsupported => '浏览器不支持蓝牙，请改用 USB 连接。';

  @override
  String get device_quickSwitch => '快速切换';

  @override
  String get device_meshcore => '网格核心';

  @override
  String get settings_title => '设置';

  @override
  String get settings_deviceInfo => '设备信息';

  @override
  String get settings_appSettings => '应用设置';

  @override
  String get settings_appSettingsSubtitle => '通知、消息和地图偏好';

  @override
  String get settings_nodeSettings => '节点设置';

  @override
  String get settings_nodeName => '节点名称';

  @override
  String get settings_nodeNameNotSet => '未设置';

  @override
  String get settings_nodeNameHint => '请输入节点名称';

  @override
  String get settings_nodeNameUpdated => '节点名称已更新';

  @override
  String get settings_radioSettings => '无线电设置';

  @override
  String get settings_radioSettingsSubtitle => '频率、功率、扩频因子';

  @override
  String get settings_radioSettingsUpdated => '无线电设置已更新';

  @override
  String get settings_regionSettings => '地区';

  @override
  String get settings_regionSettingsSubtitle => '管理已存储的区域';

  @override
  String get settings_corridorRegion => '走廊区域';

  @override
  String get settings_corridorRegionDefault => '#corridor（默认）';

  @override
  String get settings_corridorRegionHelp =>
      '泛洪走廊数据包会标记此区域。没有走廊固件的转发节点只有在允许此区域时才会转发它们。留空则使用默认标签 #corridor。';

  @override
  String get settings_corridorRegionHint => '区域名称';

  @override
  String get settings_corridorRegionUseDefault => '使用默认值';

  @override
  String get settings_corridorRegionUpdated => '走廊区域已更新';

  @override
  String get settings_corridorRegionFailed => '无法更新走廊区域';

  @override
  String get settings_regionManagement_screenTitle => '区域管理';

  @override
  String get settings_regionNameHint => '区域名称';

  @override
  String get settings_regionAddRegion => '增加地区';

  @override
  String get settings_regionFetchRegions => '从中继器获取区域';

  @override
  String get settings_regionFetchRegionsFail => '未发现任何地区';

  @override
  String get settings_regionFetchRegionsAlreadyExists => '该地区已被添加';

  @override
  String get settings_regionName => '地区名称';

  @override
  String get settings_regionDeleted => '区域已删除';

  @override
  String get settings_deleteRegion => '删除区域';

  @override
  String settings_deleteRegionConfirm(String region) {
    return '从 $region 列表中删除？';
  }

  @override
  String get settings_location => '位置';

  @override
  String get settings_locationSubtitle => 'GPS 坐标';

  @override
  String get settings_locationUpdated => '位置和 GPS 设置已更新';

  @override
  String get settings_locationBothRequired => '请输入经度和纬度';

  @override
  String get settings_locationInvalid => '无效的经度和纬度';

  @override
  String get settings_locationGPSEnable => '启用 GPS';

  @override
  String get settings_locationGPSEnableSubtitle => '启用 GPS 以自动更新位置。';

  @override
  String get settings_locationIntervalSec => 'GPS 间隔（秒）';

  @override
  String get settings_locationIntervalInvalid => '间隔时间必须至少为 60 秒，但不超过 86400 秒。';

  @override
  String get settings_latitude => '纬度';

  @override
  String get settings_longitude => '经度';

  @override
  String get settings_contactSettings => '联系人设置';

  @override
  String get settings_contactSettingsSubtitle => '添加联系人的设置';

  @override
  String get settings_privacyMode => '隐私模式';

  @override
  String get settings_privacyModeSubtitle => '在广告中隐藏姓名/位置';

  @override
  String get settings_privacyModeToggle => '切换隐私模式以在广告中隐藏姓名和位置，保护个人信息。';

  @override
  String get settings_privacyModeEnabled => '隐私模式已启用';

  @override
  String get settings_privacyModeDisabled => '隐私模式已关闭';

  @override
  String get settings_privacy => '隐私设置';

  @override
  String get settings_privacySubtitle => '控制要共享的信息。';

  @override
  String get settings_privacySettingsDescription => '选择您的设备与他人共享的信息。';

  @override
  String get settings_denyAll => '拒绝所有';

  @override
  String get settings_allowByContact => '按联系人标志允许';

  @override
  String get settings_allowAll => '允许全部';

  @override
  String get settings_telemetryBaseMode => '遥测基础模式';

  @override
  String get settings_telemetryLocationMode => '遥测位置模式';

  @override
  String get settings_telemetryEnvironmentMode => '遥测环境模式';

  @override
  String get settings_advertLocation => '广告位置';

  @override
  String get settings_advertLocationSubtitle => '在广告中包含位置';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate => 'GPS 更新时自动发送零跳广告';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      '当 GPS 位置变化时，发送零跳广告（需要在广告中包含位置）。';

  @override
  String get settings_multiAck => '多重ACK';

  @override
  String get settings_telemetryModeUpdated => '遥测模式已更新';

  @override
  String get settings_actions => '操作';

  @override
  String get settings_deleteAllPaths => 'Delete All Paths';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Clear all path data from contacts.';

  @override
  String get settings_sendAdvertisement => '发送广播';

  @override
  String get settings_sendAdvertisementSubtitle => '立即发送广播';

  @override
  String get settings_advertisementSent => '已发送广播';

  @override
  String get settings_syncTime => '同步时间';

  @override
  String get settings_syncTimeSubtitle => '将设备时钟设置为与手机时间一致';

  @override
  String get settings_timeSynchronized => '时间已同步';

  @override
  String get settings_refreshContacts => '刷新联系人';

  @override
  String get settings_refreshContactsSubtitle => '从设备重新加载联系人列表';

  @override
  String get settings_rebootDevice => '重启设备';

  @override
  String get settings_rebootDeviceSubtitle => '重启 MeshCore 设备';

  @override
  String get settings_rebootDeviceConfirm => '确定要重启设备吗？这将断开与设备的连接。';

  @override
  String get settings_debug => '调试';

  @override
  String get settings_companionDebugLog => '调试日志';

  @override
  String get settings_companionDebugLogSubtitle => 'BLE/TCP/USB 协议、响应和原始数据';

  @override
  String get settings_appDebugLog => '应用调试日志';

  @override
  String get settings_appDebugLogSubtitle => '应用调试消息';

  @override
  String get settings_about => '关于';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core v$version';
  }

  @override
  String get settings_aboutLegalese => '2026 MeshCore 开源项目';

  @override
  String get settings_aboutDescription =>
      '一个开源的 Flutter 客户端，用于 MeshCore LoRa 无线网络设备。';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'LOS 高程数据:Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => '名称';

  @override
  String get settings_infoId => 'MAC ID';

  @override
  String get settings_infoStatus => '状态';

  @override
  String get settings_infoBattery => '电池';

  @override
  String get settings_infoPublicKey => '公钥';

  @override
  String get settings_infoContactsCount => '联系人数量';

  @override
  String get settings_infoChannelCount => '频道数量';

  @override
  String get settings_infoHardware => '硬件';

  @override
  String get settings_infoFirmware => '固件';

  @override
  String get settings_presets => '预设';

  @override
  String get settings_frequency => '频率 (MHz)';

  @override
  String get settings_frequencyHelper => '300.0 - 2500.0';

  @override
  String get settings_frequencyInvalid => '无效频率范围（300-2500 MHz）';

  @override
  String get settings_bandwidth => '带宽';

  @override
  String get settings_spreadingFactor => '扩频因子';

  @override
  String get settings_codingRate => '编码速率';

  @override
  String get settings_txPower => 'TX 功率 (dBm)';

  @override
  String get settings_txPowerHelper => '0 - 22';

  @override
  String get settings_txPowerInvalid => '无效的发射功率（0-22 dBm）';

  @override
  String get settings_clientRepeat => '离网重复';

  @override
  String get settings_clientRepeatSubtitle => '允许此设备重复发送网状数据包给其他设备';

  @override
  String get settings_clientRepeatFreqWarning =>
      '离网重复通信需要使用 433、869 或 918 兆赫兹的频率。';

  @override
  String settings_error(String message) {
    return '错误：$message';
  }

  @override
  String get appSettings_title => '应用设置';

  @override
  String get appSettings_appearance => '外观';

  @override
  String get appSettings_theme => '主题';

  @override
  String get appSettings_themeSystem => '跟随系统';

  @override
  String get appSettings_themeLight => '浅色';

  @override
  String get appSettings_themeDark => '深色';

  @override
  String get appSettings_language => '语言';

  @override
  String get appSettings_languageSystem => '跟随系统';

  @override
  String get appSettings_languageEn => '英语';

  @override
  String get appSettings_languageFr => '法语';

  @override
  String get appSettings_languageEs => '西班牙语';

  @override
  String get appSettings_languageDe => '德语';

  @override
  String get appSettings_languagePl => '波兰语';

  @override
  String get appSettings_languageSl => '斯洛文尼亚语';

  @override
  String get appSettings_languagePt => '葡萄牙语';

  @override
  String get appSettings_languageIt => '意大利语';

  @override
  String get appSettings_languageZh => '中文';

  @override
  String get appSettings_languageSv => '瑞典语';

  @override
  String get appSettings_languageNl => '荷兰语';

  @override
  String get appSettings_languageSk => '斯洛伐克语';

  @override
  String get appSettings_languageBg => '保加利亚语';

  @override
  String get appSettings_languageRu => '俄语';

  @override
  String get appSettings_languageUk => '乌克兰语';

  @override
  String get repeater_pathHashModeOption0 => '0 - 1 字节';

  @override
  String get repeater_pathHashModeOption1 => '1 - 2 字节';

  @override
  String get repeater_pathHashModeOption2 => '2 - 3 字节';

  @override
  String get repeater_pathHashModeOption3 => '3 - 4 字节';

  @override
  String get appSettings_enableMessageTracing => '启用消息追踪';

  @override
  String get appSettings_enableMessageTracingSubtitle => '显示消息的详细路由和时间元数据';

  @override
  String get appSettings_notifications => '通知';

  @override
  String get appSettings_enableNotifications => '启用通知';

  @override
  String get appSettings_enableNotificationsSubtitle => '接收消息和广播的通知';

  @override
  String get appSettings_notificationPermissionDenied => '权限被拒绝';

  @override
  String get appSettings_notificationsEnabled => '通知已启用';

  @override
  String get appSettings_notificationsDisabled => '通知已关闭';

  @override
  String get appSettings_messageNotifications => '消息通知';

  @override
  String get appSettings_messageNotificationsSubtitle => '收到新消息时显示通知';

  @override
  String get appSettings_channelMessageNotifications => '频道消息通知';

  @override
  String get appSettings_channelMessageNotificationsSubtitle => '收到频道消息时显示通知';

  @override
  String get appSettings_advertisementNotifications => '广播通知';

  @override
  String get appSettings_advertisementNotificationsSubtitle => '发现新节点时显示通知';

  @override
  String get appSettings_messaging => '消息';

  @override
  String get appSettings_clearPathOnMaxRetry => '达到最大重试次数时清除路径';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle => '在5次发送失败后重置联系路径。';

  @override
  String get appSettings_pathsWillBeCleared => '5次失败后将重新路由';

  @override
  String get appSettings_pathsWillNotBeCleared => '路径不会自动清除';

  @override
  String get appSettings_autoRouteRotation => '自动路径轮换';

  @override
  String get appSettings_autoRouteRotationSubtitle => '在最佳路径和泛洪模式之间切换';

  @override
  String get appSettings_autoRouteRotationEnabled => '自动路径轮换已启用';

  @override
  String get appSettings_autoRouteRotationDisabled => '自动路径轮换已禁用';

  @override
  String get appSettings_maxRouteWeight => '最大路径重量';

  @override
  String get appSettings_maxRouteWeightSubtitle => '一条路径可以累积的最大重量，取决于成功交付的数量。';

  @override
  String get appSettings_initialRouteWeight => '初始路线权重';

  @override
  String get appSettings_initialRouteWeightSubtitle => '新发现路径的初始重量';

  @override
  String get appSettings_routeWeightSuccessIncrement => '成功权重增加';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      '在成功交付后，将重量添加到路径中';

  @override
  String get appSettings_routeWeightFailureDecrement => '失败权重降低';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      '从一条路径上移除的货物，由于无法成功交付而移除。';

  @override
  String get appSettings_maxMessageRetries => '最大消息重试次数';

  @override
  String get appSettings_maxMessageRetriesSubtitle => '在将消息标记为失败之前，允许尝试的次数';

  @override
  String get appSettings_battery => '电池';

  @override
  String get appSettings_batteryChemistry => '电池类型';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return '为每个设备设置 ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst => '请先连接设备';

  @override
  String get appSettings_batteryNmc => '18650 NMC 电池 (3.0-4.2V)';

  @override
  String get appSettings_batteryLifepo4 => '磷酸铁锂 (2.6-3.65V)';

  @override
  String get appSettings_batteryLipo => '锂聚合物电池 (3.0-4.2V)';

  @override
  String get appSettings_batteryLipoHv => '锂多压电源（3.0-4.35伏）';

  @override
  String get appSettings_mapDisplay => '地图显示';

  @override
  String get appSettings_showRepeaters => '显示转发节点';

  @override
  String get appSettings_showRepeatersSubtitle => '在地图上显示转发节点';

  @override
  String get appSettings_showChatNodes => '显示聊天节点';

  @override
  String get appSettings_showChatNodesSubtitle => '在地图上显示聊天节点';

  @override
  String get appSettings_showOtherNodes => '显示其他节点';

  @override
  String get appSettings_showOtherNodesSubtitle => '在地图上显示其他节点类型';

  @override
  String get appSettings_timeFilter => '时间过滤器';

  @override
  String get appSettings_timeFilterShowAll => '显示所有节点';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return '显示过去 $hours 小时内的节点';
  }

  @override
  String get appSettings_mapTimeFilter => '地图时间筛选';

  @override
  String get appSettings_showNodesDiscoveredWithin => '显示在此时间段内发现的节点：';

  @override
  String get appSettings_allTime => '所有时间';

  @override
  String get appSettings_lastHour => '过去一小时';

  @override
  String get appSettings_last6Hours => '过去6小时';

  @override
  String get appSettings_last24Hours => '过去24小时';

  @override
  String get appSettings_lastWeek => '上周';

  @override
  String get appSettings_rasterTileSource => '栅格瓦片源';

  @override
  String get appSettings_stadiaEndpoint => 'Stadia 端点';

  @override
  String get appSettings_stadiaApiKey => 'Stadia API 密钥';

  @override
  String get appSettings_stadiaApiKeyRequired => '使用 Stadia Maps 时必需';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return '已配置：$maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      '请输入你的 Stadia Maps API 密钥。该应用会使用它来请求栅格瓦片。';

  @override
  String get appSettings_offlineMapCache => '离线地图缓存';

  @override
  String get appSettings_unitsTitle => '单位';

  @override
  String get appSettings_unitsMetric => '公制（米/公里） (°C)';

  @override
  String get appSettings_unitsImperial => '英制 (ft / mi / °F)';

  @override
  String get appSettings_noAreaSelected => '未选择任何区域';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return '已选择区域（缩放 $minZoom - $maxZoom）';
  }

  @override
  String get appSettings_debugCard => '调试';

  @override
  String get appSettings_appDebugLogging => '应用调试日志';

  @override
  String get appSettings_appDebugLoggingSubtitle => '记录应用调试消息以进行故障排除。';

  @override
  String get appSettings_appDebugLoggingEnabled => '调试日志已启用';

  @override
  String get appSettings_appDebugLoggingDisabled => '应用调试日志已禁用';

  @override
  String get contacts_title => '联系人';

  @override
  String get contacts_noContacts => '暂无联系人';

  @override
  String get contacts_contactsWillAppear => '当设备发送广播时，联系人将显示。';

  @override
  String get contacts_unread => '未读';

  @override
  String get contacts_searchContactsNoNumber => '搜索联系人...';

  @override
  String contacts_searchContacts(int number, String str) {
    return '搜索联系人...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return '搜索 $number$str 收藏...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return '搜索 $number$str 位用户...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return '搜索 $number$str 重复器...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return '搜索 $number$str 房间服务器...';
  }

  @override
  String get contacts_noUnreadContacts => '没有未读内容';

  @override
  String get contacts_noContactsFound => '未找到任何联系人或群聊';

  @override
  String get contacts_deleteContact => '删除联系人';

  @override
  String contacts_removeConfirm(String contactName) {
    return '从联系人中移除 $contactName？';
  }

  @override
  String get contacts_manageRepeater => '管理转发节点';

  @override
  String get contacts_manageRoom => '管理房间服务器';

  @override
  String get contacts_roomLogin => '服务器登录';

  @override
  String get contacts_openChat => '打开聊天';

  @override
  String get contacts_editGroup => '编辑群聊';

  @override
  String get contacts_deleteGroup => '删除群聊';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return '删除群聊 \"$groupName\"？';
  }

  @override
  String get contacts_newGroup => '新建群聊';

  @override
  String get contacts_moreOptions => '更多选择';

  @override
  String get contacts_searchOpen => '搜索联系人';

  @override
  String get contacts_searchClose => '高级搜索';

  @override
  String get contacts_groupName => '群聊名称';

  @override
  String get contacts_groupNameRequired => '请输入群聊名称';

  @override
  String get contacts_groupNameReserved => '该群组名称已被保留';

  @override
  String contacts_groupAlreadyExists(String name) {
    return '名为 \"$name\" 的群聊已存在';
  }

  @override
  String get contacts_filterContacts => '筛选联系人...';

  @override
  String get contacts_noContactsMatchFilter => '没有符合条件的联系人';

  @override
  String get contacts_noMembers => '暂无成员';

  @override
  String get contacts_lastSeenNow => '刚刚';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return '最后在线 $minutes 分钟前';
  }

  @override
  String get contacts_lastSeenHourAgo => '最后在线 1小时前';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return '最后在线 $hours 小时前';
  }

  @override
  String get contacts_lastSeenDayAgo => '最后在线 1天前';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return '最后在线 $days 天前';
  }

  @override
  String get contact_info => '联系信息';

  @override
  String get contact_settings => '联系人设置';

  @override
  String get contact_telemetry => '遥测数据';

  @override
  String get contact_lastSeen => '最近出现';

  @override
  String get contact_clearChat => '清除聊天记录';

  @override
  String get contact_teleBase => '遥测基站';

  @override
  String get contact_teleBaseSubtitle => '允许共享电池电量和基本遥测数据';

  @override
  String get contact_teleLoc => '遥测位置';

  @override
  String get contact_teleLocSubtitle => '允许共享位置数据';

  @override
  String get contact_teleEnv => '遥测环境';

  @override
  String get contact_teleEnvSubtitle => '允许共享环境传感器数据';

  @override
  String get channels_title => '频道';

  @override
  String get channels_noChannelsConfigured => '未配置任何频道';

  @override
  String get channels_addPublicChannel => '添加公共频道';

  @override
  String get channels_searchChannels => '搜索频道...';

  @override
  String get channels_noChannelsFound => '未找到任何频道';

  @override
  String channels_channelIndex(int index) {
    return '频道 $index';
  }

  @override
  String get channels_public => '公共';

  @override
  String channels_via(String path) {
    return 'via $path';
  }

  @override
  String get channels_viaMqtt => '来自 MQTT';

  @override
  String get channels_viaMqttSemantics => '通过 MQTT 收到，你的电台未接收到';

  @override
  String get channels_private => '私有';

  @override
  String get channels_editChannel => '编辑频道';

  @override
  String get channels_muteChannel => '静音频道';

  @override
  String get channels_unmuteChannel => '取消静音频道';

  @override
  String get channels_deleteChannel => '删除频道';

  @override
  String channels_deleteChannelConfirm(String name) {
    return '删除频道 \"$name\"？此操作不可撤销。';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return '无法删除频道 \"$name\"';
  }

  @override
  String channels_channelDeleted(String name) {
    return '已删除频道 \"$name\"';
  }

  @override
  String get channels_addChannel => '添加频道';

  @override
  String get channels_channelIndexLabel => '频道索引';

  @override
  String get channels_channelName => '频道名称';

  @override
  String get channels_usePublicChannel => '使用公共频道';

  @override
  String get channels_standardPublicPsk => '标准公共 PSK';

  @override
  String get channels_pskHex => 'PSK (十六进制)';

  @override
  String get channels_generateRandomPsk => '生成随机 PSK';

  @override
  String get channels_enterChannelName => '请输入频道名称';

  @override
  String get channels_pskMustBe32Hex => 'PSK 必须为 32 个十六进制字符';

  @override
  String channels_channelAdded(String name) {
    return '已添加频道 \"$name\"';
  }

  @override
  String channels_editChannelTitle(int index) {
    return '编辑频道 $index';
  }

  @override
  String get channels_smazCompression => 'SMAZ 压缩';

  @override
  String get channels_cyr2latCompression => 'Cyr2Lat 压缩';

  @override
  String get channels_cyr2latCompressionDscr => '发送时将一些西里尔字符替换为拉丁字符。';

  @override
  String get channels_cyr2latSettingsHeading => 'Cyr2Lat 設定';

  @override
  String get channels_cyr2latSettingsSubheading => '替換清單';

  @override
  String get channels_cyr2latSettingsDscr => '編輯 JSON 字元替換設定檔';

  @override
  String get channels_cyr2latSettingsDialogHint => 'JSON 替換映射表';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'JSON 格式錯誤：$error';
  }

  @override
  String channels_channelUpdated(String name) {
    return '频道 \"$name\" 已更新';
  }

  @override
  String get settings_cyr2latProfileAdd => '新增 Cyr2Lat 設定檔';

  @override
  String get settings_cyr2latProfileName => '設定檔名稱';

  @override
  String get settings_cyr2latProfileNameEmpty => '設定檔名稱不能為空';

  @override
  String get settings_cyr2latProfileAdded => '設定檔已成功新增';

  @override
  String get settings_cyr2latProfileUpdated => '設定檔已成功更新';

  @override
  String get settings_cyr2latProfileEdit => '編輯 Cyr2Lat 設定檔';

  @override
  String get settings_cyr2latProfileDelete => '刪除 Cyr2Lat 設定檔';

  @override
  String get settings_cyr2latProfileDeleted => '設定檔已成功刪除';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return '您確定要刪除設定檔 \"$name\" 嗎？';
  }

  @override
  String get channels_publicChannelAdded => '已添加公共频道';

  @override
  String get channels_sortBy => '排序方式';

  @override
  String get channels_sortManual => '手动';

  @override
  String get channels_sortAZ => 'A到Z';

  @override
  String get channels_sortLatestMessages => '最新消息';

  @override
  String get channels_sortUnread => '未读';

  @override
  String get channels_createPrivateChannel => '创建私有频道';

  @override
  String get channels_createPrivateChannelDesc => '使用密钥保护。';

  @override
  String get channels_joinPrivateChannel => '加入私有频道';

  @override
  String get channels_joinPrivateChannelDesc => '手动输入密钥。';

  @override
  String get channels_joinPublicChannel => '加入公共频道';

  @override
  String get channels_joinPublicChannelDesc => '任何人都可以加入。';

  @override
  String get channels_joinHashtagChannel => '加入标签频道';

  @override
  String get channels_joinHashtagChannelDesc => '任何人都可以加入标签频道。';

  @override
  String get channels_scanQrCode => '扫描二维码';

  @override
  String get channels_scanQrCodeComingSoon => '即将推出';

  @override
  String get channels_enterHashtag => '输入标签';

  @override
  String get channels_hashtagHint => '例如：#团队';

  @override
  String channels_regionSetTo(String region) {
    return '地区：$region';
  }

  @override
  String get channels_regionNotSet => '地区：无';

  @override
  String get channels_regionSelect_Title => '选择一个地区';

  @override
  String get channels_clearRegion => '无碍区域';

  @override
  String get chat_noMessages => '暂无消息';

  @override
  String get chat_sendMessage => '发送消息';

  @override
  String chat_sendMessageTo(String contactName) {
    return '发送消息给 $contactName';
  }

  @override
  String get chat_sendMessageToStart => '发送消息开始对话';

  @override
  String get chat_originalMessageNotFound => '找不到原始消息';

  @override
  String chat_replyingTo(String name) {
    return '正在回复 $name';
  }

  @override
  String chat_replyTo(String name) {
    return '回复 $name';
  }

  @override
  String get chat_location => '位置';

  @override
  String get chat_typeMessage => '输入消息...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return '消息过长（最多 $maxBytes 字节）';
  }

  @override
  String get chat_messageCopied => '消息已复制';

  @override
  String get chat_messageDeleted => '消息已删除';

  @override
  String get chat_retryingMessage => '正在重试消息';

  @override
  String chat_retryCount(int current, int max) {
    return '重试 $current/$max';
  }

  @override
  String get chat_selectSendAction => '选择发送操作';

  @override
  String get chat_sendGif => '发送 GIF';

  @override
  String get chat_limitToArea => '限制在一个区域内';

  @override
  String get chat_limitToAreaTitle => '仅在以下范围内发送…';

  @override
  String get chat_limitToAreaHelp =>
      '带有泛洪走廊固件的转发节点只在此区域内转发消息。其他转发节点会丢弃它，除非它们允许你的走廊区域。';

  @override
  String chat_limitToAreaRadius(int km) {
    return '你周围 $km 公里';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return '仅限你周围 $km 公里内';
  }

  @override
  String get chat_limitToAreaOff => '不限制';

  @override
  String get chat_limitToAreaNeedsPosition => '设置电台位置后才能将消息限制在某个区域。';

  @override
  String get chat_sendImageLora => '通过 MeshCore 发送图片';

  @override
  String get chat_imagePickFailed => '无法打开该图片';

  @override
  String get chat_receivedGif => '收到一个GIF';

  @override
  String get chat_reply => '回复';

  @override
  String get chat_addReaction => '添加表情';

  @override
  String get chat_me => '我';

  @override
  String get reaction_report => '表情回应';

  @override
  String get emojiCategorySmileys => '表情';

  @override
  String get emojiCategoryGestures => '手势';

  @override
  String get emojiCategoryHearts => '爱心';

  @override
  String get emojiCategoryObjects => '物品';

  @override
  String get gifPicker_title => '选择 GIF';

  @override
  String get gifPicker_searchHint => '搜索 GIF...';

  @override
  String get gifPicker_poweredBy => '由 GIPHY 提供';

  @override
  String get gifPicker_noGifsFound => '未找到 GIF';

  @override
  String get gifPicker_failedLoad => '加载 GIF 失败';

  @override
  String get gifPicker_failedSearch => '搜索 GIF 失败';

  @override
  String get gifPicker_noInternet => '无网络连接';

  @override
  String get debugLog_appTitle => '应用调试日志';

  @override
  String get debugLog_bleTitle => 'BLE 调试日志';

  @override
  String get debugLog_copyLog => '复制日志';

  @override
  String get debugLog_clearLog => '清除日志';

  @override
  String get debugLog_copied => '调试日志已复制';

  @override
  String get debugLog_bleCopied => 'BLE 日志已复制';

  @override
  String get debugLog_noEntries => '暂无调试日志';

  @override
  String get debugLog_enableInSettings => '请在设置中启用应用调试日志。';

  @override
  String get debugLog_frames => '帧';

  @override
  String get debugLog_rawLogRx => '原始日志 RX';

  @override
  String get debugLog_noBleActivity => '暂无 BLE 活动';

  @override
  String debugFrame_length(int count) {
    return '帧长度：$count 字节';
  }

  @override
  String debugFrame_command(String value) {
    return '命令：0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => '文本消息：';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- 目标公钥：$pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- 时间戳：$timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- 标志：0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- 文本类型：$type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => '命令行';

  @override
  String get debugFrame_textTypePlain => '纯文本';

  @override
  String debugFrame_text(String text) {
    return '- 文本：“$text”';
  }

  @override
  String get debugFrame_hexDump => '十六进制数据：';

  @override
  String chat_hopsCount(int count) {
    return '$count 跳';
  }

  @override
  String get chat_removePath => '移除路径';

  @override
  String get chat_noPathHistoryYet => '暂无路径历史。\n发送消息以探索路径。';

  @override
  String get chat_pathCleared => '路径已清除。下一条消息将重新路由。';

  @override
  String get chat_fullPath => '完整路径';

  @override
  String get routing_title => '路由';

  @override
  String get routing_modeAuto => '汽车';

  @override
  String get routing_modeFlood => '洪水';

  @override
  String get routing_modeManual => '手册';

  @override
  String get routing_modeAutoHint => '自动选择已知最佳路径，当没有已知路径时，则进行“洪水”搜索。';

  @override
  String get routing_modeFloodHint => '通过所有中继站进行广播。 这种方式最可靠，但占用更多的时间。';

  @override
  String get routing_modeManualHint => '总是按照您设置的路径进行导航。';

  @override
  String get routing_currentRoute => '当前路线';

  @override
  String get routing_directNoHops => '直接连接— 无中继跳';

  @override
  String get routing_noPathYet => '目前还没有找到路径。直到找到路径，才会收到后续消息。';

  @override
  String get routing_floodBroadcast => '通过所有中继器进行广播';

  @override
  String get routing_editPath => '编辑路径';

  @override
  String get routing_forgetPath => '忘记原路';

  @override
  String get routing_knownPaths => '已知的路径';

  @override
  String get routing_knownPathsHint => '点击该路径以切换到它。';

  @override
  String get routing_inUse => '使用中';

  @override
  String get routing_qualityStrong => '强劲的初始阶段';

  @override
  String get routing_qualityGood => '不错的开端';

  @override
  String get routing_qualityFair => '第一次尝试，结果良好';

  @override
  String get routing_qualityWorked => '已完成';

  @override
  String get routing_qualityFlood => '通过新闻报道';

  @override
  String get routing_qualityUntested => '未经测试';

  @override
  String routing_lastWorked(String when) {
    return '工作于 $when';
  }

  @override
  String get routing_neverWorked => '从未得到证实';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes delivered, $failures failed';
  }

  @override
  String get routing_floodDelivery => '洪水配送';

  @override
  String get pathEditor_title => '构建路径';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count of 64 hops';
  }

  @override
  String get pathEditor_noHops =>
      '目前还没有添加任何啤酒花。点击下面的“添加”按钮，按顺序添加，或者直接保存，不添加任何啤酒花。';

  @override
  String get pathEditor_addHops => '按照顺序添加啤酒花';

  @override
  String get pathEditor_searchRepeaters => '重复搜索';

  @override
  String get pathEditor_advancedHex => '高级：原始十六进制路径';

  @override
  String get pathEditor_hexLabel => '十六进制前缀';

  @override
  String get pathEditor_hexHelper => '每次跳跃，使用两个十六进制字符，用逗号分隔。';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return '无效：$tokens';
  }

  @override
  String get pathEditor_tooManyHops => '最多 64 个跳跃';

  @override
  String get pathEditor_usePath => '请使用此路径';

  @override
  String get pathEditor_removeHop => '去除啤酒花';

  @override
  String get pathEditor_unknownHop => '未知的重复器';

  @override
  String get chat_pathSavedLocally => '已本地保存，连接设备后可同步。';

  @override
  String get chat_pathDeviceConfirmed => '设备已确认。';

  @override
  String get chat_pathDeviceNotConfirmed => '设备尚未确认。';

  @override
  String get chat_type => '类型';

  @override
  String get chat_path => '路径';

  @override
  String get chat_publicKey => '公钥';

  @override
  String get chat_compressOutgoingMessages => '压缩发送的消息';

  @override
  String get chat_floodForced => '泛洪（强制）';

  @override
  String get chat_directForced => '直连（强制）';

  @override
  String chat_hopsForced(int count) {
    return '$count 跳（强制）';
  }

  @override
  String get chat_floodAuto => '自动泛洪';

  @override
  String get chat_direct => '直连';

  @override
  String get chat_poiShared => '共享位置';

  @override
  String chat_unread(int count) {
    return '未读：$count';
  }

  @override
  String get chat_markAsUnread => '标记为未读';

  @override
  String get chat_newMessages => '新的消息';

  @override
  String get chat_openLink => '打开链接？';

  @override
  String get chat_openLinkConfirmation => '是否使用浏览器打开此链接？';

  @override
  String get chat_open => '打开';

  @override
  String chat_couldNotOpenLink(String url) {
    return '无法打开链接：$url';
  }

  @override
  String get chat_invalidLink => '无效的链接格式';

  @override
  String get map_title => '节点地图';

  @override
  String get map_searchHint => '搜索节点名称或ID';

  @override
  String get map_activity => '活动';

  @override
  String get map_online => '在线';

  @override
  String get map_recent => '最近';

  @override
  String get map_stale => '过时';

  @override
  String get map_visible => '可见';

  @override
  String get map_hidden => '已隐藏';

  @override
  String get map_centerOnNode => '以节点为中心';

  @override
  String get map_details => '详细信息';

  @override
  String get map_noGps => '无 GPS';

  @override
  String get map_noResults => '未找到匹配的节点';

  @override
  String get map_lineOfSight => '视线';

  @override
  String get map_losScreenTitle => '视线';

  @override
  String get map_noNodesWithLocation => '没有包含位置信息的节点';

  @override
  String get map_nodesNeedGps => '节点需要共享 GPS 坐标才能在地图上显示';

  @override
  String map_nodesCount(int count) {
    return '节点：$count';
  }

  @override
  String map_pinsCount(int count) {
    return '标记：$count';
  }

  @override
  String get map_chat => '聊天';

  @override
  String get map_repeater => '转发节点';

  @override
  String get map_room => '房间';

  @override
  String get map_sensor => '传感器';

  @override
  String get map_pinDm => '标记（私信）';

  @override
  String get map_pinPrivate => '私有';

  @override
  String get map_pinPublic => '公共';

  @override
  String get map_lastSeen => '最后在线';

  @override
  String get map_disconnectConfirm => '确定要断开与此设备的连接吗？';

  @override
  String get map_from => '来自';

  @override
  String get map_source => '来源';

  @override
  String get map_flags => '标志';

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
  String get map_shareMarkerHere => '在此分享标记';

  @override
  String get map_setAsMyLocation => '设置为我的位置';

  @override
  String get floodCorridor_title => '泛洪走廊';

  @override
  String get floodCorridor_previewToHere => '预览到此处的泛洪走廊';

  @override
  String get floodCorridor_requesting => '正在向电台请求走廊…';

  @override
  String get floodCorridor_unsupported => '你的电台固件不支持泛洪走廊。';

  @override
  String get floodCorridor_noProposal => '电台无法提出走廊。请确认已设置位置。';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个圆',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return '$total 个已知转发节点中有 $inside 个在内';
  }

  @override
  String get floodCorridor_straightLine => '直线：沿途没有已知的转发节点';

  @override
  String get floodCorridor_followsRepeaters => '沿着已知的转发节点';

  @override
  String get floodCorridor_horizonLimited => '已知转发节点无法到达目标；其余部分为直线';

  @override
  String get floodCorridor_thinStretch => '走廊的一部分已知转发节点很少';

  @override
  String get floodCorridor_moreCoverage => '要求更多转发节点覆盖';

  @override
  String get floodCorridor_previewNote => '仅为预览。没有走廊固件的转发节点不会应用走廊。';

  @override
  String get map_pinLabel => '标签';

  @override
  String get map_label => '标签';

  @override
  String get map_pointOfInterest => '兴趣点';

  @override
  String get map_sendToContact => '发送给联系人';

  @override
  String get map_sendToChannel => '发送到频道';

  @override
  String get map_noChannelsAvailable => '没有可用的频道';

  @override
  String get map_publicLocationShare => '公共位置共享';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return '您即将在 $channelLabel 上分享一个位置。此频道是公开的，任何拥有 PSK 的人都可以看到。';
  }

  @override
  String get map_connectToShareMarkers => '连接设备以共享标记';

  @override
  String get map_filterNodes => '过滤节点';

  @override
  String get map_nodeTypes => '节点类型';

  @override
  String get map_chatNodes => '聊天节点';

  @override
  String get map_repeaters => '转发节点';

  @override
  String get map_otherNodes => '其他节点';

  @override
  String get map_showOverlaps => '重复键重叠';

  @override
  String get map_keyPrefix => '关键字前缀';

  @override
  String get map_filterByKeyPrefix => '按关键字前缀筛选';

  @override
  String get map_publicKeyPrefix => '关键字前缀';

  @override
  String get map_markers => '标记';

  @override
  String get map_showSharedMarkers => '显示共享标记';

  @override
  String get map_showGuessedLocations => '显示猜测的节点位置';

  @override
  String get map_showDiscoveryContacts => '显示发现联系人';

  @override
  String get map_guessedLocation => '猜测的位置';

  @override
  String get map_lastSeenTime => '最后在线时间';

  @override
  String get map_sharedPin => '共享标记';

  @override
  String get map_sharedAt => '已分享';

  @override
  String get map_joinRoom => '加入房间';

  @override
  String get map_manageRepeater => '管理转发节点';

  @override
  String get map_tapToAdd => '点击节点以添加到路径';

  @override
  String get map_runTrace => '运行路径追踪';

  @override
  String get map_runTraceWithReturnPath => '沿着相同的路径返回';

  @override
  String get map_removeLast => '移除最后一个';

  @override
  String get map_pathTraceCancelled => '路径追踪已取消';

  @override
  String get mapCache_title => '离线地图缓存';

  @override
  String get mapCache_selectAreaFirst => '请先选择要缓存的区域';

  @override
  String get mapCache_noTilesToDownload => '此区域没有可下载的瓦片';

  @override
  String get mapCache_downloadTilesTitle => '下载瓦片';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return '这需要下载 $count 个瓦片';
  }

  @override
  String get mapCache_downloadAction => '下载';

  @override
  String mapCache_cachedTiles(int count) {
    return '已缓存 $count 个瓦片';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return '已缓存 $downloaded 个瓦片（$failed 个失败）';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => '清除离线缓存';

  @override
  String get mapCache_clearOfflineCachePrompt => '清除所有缓存的地图瓦片';

  @override
  String get mapCache_offlineCacheCleared => '离线缓存已清除';

  @override
  String get mapCache_noAreaSelected => '未选择区域';

  @override
  String get mapCache_cacheArea => '缓存区域';

  @override
  String get mapCache_useCurrentView => '使用当前视图';

  @override
  String get mapCache_zoomRange => '缩放范围';

  @override
  String mapCache_estimatedTiles(int count) {
    return '估计瓦片数：$count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return '已下载 $completed/$total';
  }

  @override
  String get mapCache_downloadTilesButton => '下载瓦片';

  @override
  String get mapCache_clearCacheButton => '清除缓存';

  @override
  String mapCache_failedDownloads(int count) {
    return '下载失败：$count';
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
    return '北 $north, 南 $south, 东 $east, 西 $west';
  }

  @override
  String get time_justNow => '刚才';

  @override
  String time_minutesAgo(int minutes) {
    return '$minutes分钟前';
  }

  @override
  String time_hoursAgo(int hours) {
    return '$hours小时前';
  }

  @override
  String time_daysAgo(int days) {
    return '$days天前';
  }

  @override
  String get time_hour => '小时';

  @override
  String get time_hours => '小时';

  @override
  String get time_day => '天';

  @override
  String get time_days => '天';

  @override
  String get time_week => '周';

  @override
  String get time_weeks => '周';

  @override
  String get time_month => '月';

  @override
  String get time_months => '月';

  @override
  String get time_minutes => '分钟';

  @override
  String get time_allTime => '所有时间';

  @override
  String get dialog_disconnect => '断开';

  @override
  String get dialog_disconnectConfirm => '确定要断开与此设备的连接吗？';

  @override
  String get login_repeaterLogin => '转发节点登录';

  @override
  String get login_roomLogin => '房间服务器登录';

  @override
  String get login_password => '密码';

  @override
  String get login_enterPassword => '请输入密码';

  @override
  String get login_savePassword => '保存密码';

  @override
  String get login_savePasswordSubtitle => '密码将安全地存储在此设备上';

  @override
  String get login_repeaterDescription => '输入转发节点密码以访问设置和状态。';

  @override
  String get login_roomDescription => '输入房间服务器密码以访问设置和状态。';

  @override
  String get login_routing => '路由';

  @override
  String get login_routingMode => '路由模式';

  @override
  String get login_autoUseSavedPath => '自动（使用保存的路径）';

  @override
  String get login_forceFloodMode => '强制泛洪模式';

  @override
  String get login_managePaths => '管理路径';

  @override
  String get login_login => '登录';

  @override
  String login_attempt(int current, int max) {
    return '尝试 $current/$max';
  }

  @override
  String login_failed(String error) {
    return '登录失败：$error';
  }

  @override
  String get login_failedMessage => '登录失败。可能是密码错误或无法连接到服务器。';

  @override
  String get common_reload => '重新加载';

  @override
  String get common_clear => '清除';

  @override
  String get path_currentPathLabel => '当前路径';

  @override
  String get path_noRepeatersFound => '未找到任何转发节点或房间服务器。';

  @override
  String get repeater_management => '转发节点管理';

  @override
  String get room_management => '房间服务器管理';

  @override
  String get repeater_guest => '重复器信息';

  @override
  String get room_guest => '服务器信息';

  @override
  String get repeater_managementTools => '管理工具';

  @override
  String get repeater_guestTools => '访客工具';

  @override
  String get repeater_status => '状态';

  @override
  String get repeater_statusSubtitle => '查看转发节点状态、统计和邻居';

  @override
  String get repeater_telemetry => '遥测';

  @override
  String get repeater_telemetrySubtitle => '查看传感器和系统状态数据';

  @override
  String get repeater_cli => '命令行';

  @override
  String get repeater_cliSubtitle => '向转发节点发送命令';

  @override
  String get repeater_neighbors => '邻居';

  @override
  String get repeater_neighborsSubtitle => '查看邻居节点（零跳）';

  @override
  String get repeater_settings => '设置';

  @override
  String get repeater_settingsSubtitle => '配置转发节点参数';

  @override
  String get repeater_clockSyncAfterLogin => '登录后，自动同步时钟';

  @override
  String get repeater_clockSyncAfterLoginSubtitle => '在成功登录后，自动发送“时钟同步”指令。';

  @override
  String get repeater_statusTitle => '转发节点状态';

  @override
  String get repeater_routingMode => '路由模式';

  @override
  String get repeater_refresh => '刷新';

  @override
  String get repeater_statusRequestTimeout => '状态请求超时';

  @override
  String repeater_errorLoadingStatus(String error) {
    return '加载状态时出错：$error';
  }

  @override
  String get repeater_systemInformation => '系统信息';

  @override
  String get repeater_battery => '电池';

  @override
  String get repeater_clockAtLogin => '登录时的时钟';

  @override
  String get repeater_uptime => '运行时间';

  @override
  String get repeater_queueLength => '队列长度';

  @override
  String get repeater_debugFlags => '调试标志';

  @override
  String get repeater_radioStatistics => '无线电统计';

  @override
  String get repeater_lastRssi => '上次 RSSI';

  @override
  String get repeater_lastSnr => '上次 SNR';

  @override
  String get repeater_noiseFloor => '底噪';

  @override
  String get repeater_txAirtime => '发送空中时间';

  @override
  String get repeater_rxAirtime => '接收空中时间';

  @override
  String get repeater_chanUtil => '频道利用率';

  @override
  String get repeater_packetStatistics => '数据包统计';

  @override
  String get repeater_sent => '发送';

  @override
  String get repeater_received => '接收';

  @override
  String get repeater_duplicates => '重复';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days天 $hours小时 $minutes分 $seconds秒';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return '总计：$total，泛洪：$flood，直连：$direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return '总计：$total，泛洪：$flood，直连：$direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return '泛洪：$flood，直连：$direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return '总计：$total';
  }

  @override
  String get repeater_settingsTitle => '转发节点设置';

  @override
  String get repeater_basicSettings => '基本设置';

  @override
  String get repeater_repeaterName => '转发节点名称';

  @override
  String get repeater_repeaterNameHelper => '此转发节点的显示名称';

  @override
  String get repeater_adminPassword => '管理员密码';

  @override
  String get repeater_adminPasswordHelper => '完整访问密码';

  @override
  String get repeater_guestPassword => '访客密码';

  @override
  String get repeater_guestPasswordHelper => '只读访问密码';

  @override
  String get repeater_radioSettings => '无线电设置';

  @override
  String get repeater_frequencyMhz => '频率 (MHz)';

  @override
  String get repeater_frequencyHelper => '300-2500 兆赫';

  @override
  String get repeater_txPower => 'TX 功率';

  @override
  String get repeater_txPowerHelper => '1-30 dBm';

  @override
  String get repeater_bandwidth => '带宽';

  @override
  String get repeater_spreadingFactor => '扩频因子';

  @override
  String get repeater_codingRate => '编码速率';

  @override
  String get repeater_locationSettings => '位置设置';

  @override
  String get repeater_latitude => '纬度';

  @override
  String get repeater_latitudeHelper => '十进制，例如 37.7749';

  @override
  String get repeater_longitude => '经度';

  @override
  String get repeater_longitudeHelper => '十进制，例如 -122.4194';

  @override
  String get repeater_features => '功能';

  @override
  String get repeater_packetForwarding => '数据包转发';

  @override
  String get repeater_packetForwardingSubtitle => '启用转发节点转发数据包';

  @override
  String get repeater_guestAccess => '访客访问';

  @override
  String get repeater_guestAccessSubtitle => '允许访客只读权限';

  @override
  String get repeater_privacyMode => '隐私模式';

  @override
  String get repeater_privacyModeSubtitle => '在广播中隐藏姓名/位置';

  @override
  String get repeater_advertisementSettings => '广播设置';

  @override
  String get repeater_localAdvertInterval => '本地广播间隔';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes 分钟';
  }

  @override
  String get repeater_floodAdvertInterval => '泛洪广播间隔';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours 小时';
  }

  @override
  String get repeater_encryptedAdvertInterval => '加密广播间隔';

  @override
  String get repeater_dangerZone => '危险设置';

  @override
  String get repeater_rebootRepeater => '重启转发节点';

  @override
  String get repeater_rebootRepeaterSubtitle => '重启转发节点设备';

  @override
  String get repeater_rebootRepeaterConfirm => '确定要重启此转发节点吗？';

  @override
  String get repeater_regenerateIdentityKey => '重新生成身份密钥';

  @override
  String get repeater_regenerateIdentityKeySubtitle => '生成新的公钥/私钥对';

  @override
  String get repeater_regenerateIdentityKeyConfirm => '这将为转发节点生成新身份，继续吗？';

  @override
  String get repeater_eraseFileSystem => '擦除文件系统';

  @override
  String get repeater_eraseFileSystemSubtitle => '格式化转发节点文件系统';

  @override
  String get repeater_eraseFileSystemConfirm => '警告：此操作将清除转发节点上的所有数据，且无法恢复！';

  @override
  String get repeater_eraseSerialOnly => '擦除功能仅可通过串行控制台使用。';

  @override
  String repeater_commandSent(String command) {
    return '命令已发送：$command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return '发送命令时出错：$error';
  }

  @override
  String get repeater_confirm => '确认';

  @override
  String get repeater_settingsSaved => '设置保存成功';

  @override
  String get repeater_rxGain => '增强的 RX 增益';

  @override
  String get repeater_rxGainHelper => '更高的灵敏度，更大的电流消耗（仅适用于 SX1262/SX1268）';

  @override
  String get repeater_refreshRxGain => '重新启动增强型 RX 功能';

  @override
  String get repeater_multiAcks => '多重确认';

  @override
  String get repeater_multiAcksSubtitle => '通过多个路径确认消息，以提高传递效率。';

  @override
  String get repeater_refreshMultiAcks => '刷新多个确认';

  @override
  String get repeater_networkHealth => '网络健康';

  @override
  String get repeater_loopDetect => '循环检测';

  @override
  String get repeater_loopDetectHelper => '创建看起来像路由环的“洪水包”';

  @override
  String get repeater_loopDetectOff => '离开';

  @override
  String get repeater_loopDetectMinimal => '最少';

  @override
  String get repeater_loopDetectModerate => '适度的';

  @override
  String get repeater_loopDetectStrict => '严格';

  @override
  String get repeater_dutyCycle => '工作周期';

  @override
  String get repeater_dutyCycleHelper => '最大可使用的空闲时间百分比';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => '运营商信息';

  @override
  String get repeater_ownerInfoHelper => '此复播器的公共元数据';

  @override
  String get repeater_refreshOwnerInfo => '刷新操作员信息';

  @override
  String get repeater_floodMax => '最大跳跃次数';

  @override
  String get repeater_floodMaxHelper => '一个洪水包中，最大可以传输的跳数 (0-64)';

  @override
  String get repeater_advancedSettings => '高级';

  @override
  String get repeater_advancedSettingsSubtitle => '高级操作员使用的调节旋钮';

  @override
  String get repeater_pathHashMode => '路径哈希模式';

  @override
  String get repeater_pathHashModeHelper =>
      '用于在洪泛路径/环路检测标签中编码此中继器 ID 的字节数。0=1 字节（256 个 ID，最多 64 跳），1=2 字节（65K 个 ID，最多 32 跳），2=3 字节（16M 个 ID，最多 21 跳）。v1.14 之前的固件始终使用 1 字节路径；v1.14 及更新版本可配置为 2 或 3 字节路径。';

  @override
  String get repeater_keySettings => '更改身份密钥';

  @override
  String get repeater_keySettingsSubtitle => '更换公钥/私钥对';

  @override
  String get repeater_prvKey => '私钥';

  @override
  String get repeater_prvKeyHelper => '中继器的新私钥，为一个128位的十六进制字符串。';

  @override
  String get repeater_generatePrvKey => '生成一个随机的密钥对';

  @override
  String get repeater_stopGeneratingPrvKey => '中断密钥对搜索';

  @override
  String get repeater_pubKey => '公钥';

  @override
  String get repeater_pubKeyHelper => '这是与生成的私钥配对的公钥。您不能直接设置此内容。';

  @override
  String get repeater_pubKeyPrefix => '期望的前缀';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return '找到一组以这些十六进制数字开头的公钥。预计尝试次数：$tries';
  }

  @override
  String get repeater_txDelay => '洪水（德克萨斯州）延误';

  @override
  String get repeater_txDelayHelper =>
      '对于洪水流量，重新传输间隔应设置为包的传输时间（0-2，默认值为0.5）的倍数。 较高的值意味着更少的冲突，但传输速度会变慢。';

  @override
  String get repeater_directTxDelay => '直接的 TX 延迟';

  @override
  String get repeater_directTxDelayHelper =>
      '对于直接（非广播）流量，重新传输间隔应设置为包的传输时间（0-2，默认值为0.3）的倍数。';

  @override
  String get repeater_intThresh => '干扰阈值';

  @override
  String get repeater_intThreshHelper =>
      '将阈值传递给射频信号的噪声水平校准，使其能够拒绝高于该水平的干扰。 0 表示禁用——只有在您在嘈杂频段中看到 RX 错误时才启用。';

  @override
  String get repeater_agcResetInterval => 'AGC 恢复间隔';

  @override
  String get repeater_agcResetIntervalHelper =>
      '为了从失控的增益状态中恢复，应该多久重置收音机的自动增益控制？设置为“秒”，每次重置间隔为4秒。将此选项设置为“0”将禁用周期性重置。';

  @override
  String get repeater_actionsTitle => '行动';

  @override
  String get repeater_sendAdvert => '发布防洪广告';

  @override
  String get repeater_sendAdvertSubtitle => '通过网络播放防洪广告';

  @override
  String get repeater_sendAdvertZeroHop => '发送零跳广告';

  @override
  String get repeater_sendAdvertZeroHopSubtitle => '进行单跳广告广播（不使用中继）';

  @override
  String get repeater_clockSync => '现在同步时钟';

  @override
  String get repeater_clockSyncSubtitle => '将手机的时间设置为与中继器同步';

  @override
  String repeater_actionSucceeded(String action) {
    return '$action 成功';
  }

  @override
  String repeater_actionFailed(String action, String error) {
    return '$action 失败：$error';
  }

  @override
  String get repeater_settingsSavedRebootNeeded => '设置已保存 — 重启发射器以应用';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return '部分设置失败：$failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return '保存设置时出错：$error';
  }

  @override
  String get repeater_refreshBasicSettings => '刷新基本设置';

  @override
  String get repeater_refreshRadioSettings => '刷新无线电设置';

  @override
  String get repeater_refreshTxPower => '刷新 TX 功率';

  @override
  String get repeater_refreshPacketForwarding => '刷新包转发';

  @override
  String get repeater_refreshGuestAccess => '刷新访客权限';

  @override
  String get repeater_refreshPrivacyMode => '刷新隐私模式';

  @override
  String repeater_refreshed(String label) {
    return '$label 已刷新';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return '刷新 $label 时出错';
  }

  @override
  String get repeater_cliTitle => '转发节点命令行';

  @override
  String get repeater_debugNextCommand => '调试下一条命令';

  @override
  String get repeater_commandHelp => '帮助';

  @override
  String get repeater_clearHistory => '清除历史';

  @override
  String get repeater_noCommandsSent => '尚未发送命令';

  @override
  String get repeater_typeCommandOrUseQuick => '输入命令或使用快捷命令';

  @override
  String get repeater_enterCommandHint => '输入命令...';

  @override
  String get repeater_previousCommand => '上一条命令';

  @override
  String get repeater_nextCommand => '下一条命令';

  @override
  String get repeater_enterCommandFirst => '请先输入命令';

  @override
  String get repeater_cliCommandFrameTitle => 'CLI 命令帧';

  @override
  String repeater_cliCommandError(String error) {
    return '错误：$error';
  }

  @override
  String get repeater_cliQuickGetName => '获取名称';

  @override
  String get repeater_cliQuickGetRadio => '获取无线电设置';

  @override
  String get repeater_cliQuickGetTx => '获取 TX';

  @override
  String get repeater_cliQuickNeighbors => '邻居';

  @override
  String get repeater_cliQuickVersion => '版本';

  @override
  String get repeater_cliQuickAdvertise => '发送广播';

  @override
  String get repeater_cliQuickClock => '时钟';

  @override
  String get repeater_cliQuickClockSync => '同步时钟';

  @override
  String get repeater_cliQuickDiscovery => '发现邻居';

  @override
  String get repeater_cliHelpAdvert => '发送广播包';

  @override
  String get repeater_cliHelpReboot => '重启设备。（注意：可能会收到超时错误，属于正常现象）';

  @override
  String get repeater_cliHelpClock => '显示设备当前时间';

  @override
  String get repeater_cliHelpPassword => '设置新的管理员密码';

  @override
  String get repeater_cliHelpVersion => '显示设备版本和固件构建日期';

  @override
  String get repeater_cliHelpClearStats => '重置各种统计数据';

  @override
  String get repeater_cliHelpSetAf => '设置时间因子';

  @override
  String get repeater_cliHelpSetTx => '设置 LoRa 发射功率 (dBm)（重启生效）';

  @override
  String get repeater_cliHelpSetRepeat => '启用或禁用此节点的转发功能';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '（房间服务器）设为“开”则允许空密码登录，但只能读（不能发送）';

  @override
  String get repeater_cliHelpSetFloodMax => '设置最大传入数据包跳数（≥该值则不转发）';

  @override
  String get repeater_cliHelpSetIntThresh => '设置干扰阈值 (dB)，默认14，设为0禁用';

  @override
  String get repeater_cliHelpSetAgcResetInterval => '设置 AGC 重置间隔（秒），设为0禁用';

  @override
  String get repeater_cliHelpSetMultiAcks => '启用或禁用“多重确认”功能';

  @override
  String get repeater_cliHelpSetAdvertInterval => '设置本地广播间隔（分钟），设为0禁用';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval => '设置泛洪广播间隔（小时），设为0禁用';

  @override
  String get repeater_cliHelpSetGuestPassword => '设置/更新访客密码';

  @override
  String get repeater_cliHelpSetName => '设置广播名称';

  @override
  String get repeater_cliHelpSetLat => '设置广播纬度（十进制）';

  @override
  String get repeater_cliHelpSetLon => '设置广播经度（十进制）';

  @override
  String get repeater_cliHelpSetRadio => '完全重设无线电参数并保存，需重启生效';

  @override
  String get repeater_cliHelpSetRxDelay => '（实验性）设置接收延迟基数，设为0禁用';

  @override
  String get repeater_cliHelpSetTxDelay => '通过因子和随机时隙延迟泛洪数据包转发，降低冲突';

  @override
  String get repeater_cliHelpSetDirectTxDelay => '同 txdelay，用于直连模式数据包';

  @override
  String get repeater_cliHelpSetBridgeEnabled => '启用/禁用桥接';

  @override
  String get repeater_cliHelpSetBridgeDelay => '设置桥接转发延迟';

  @override
  String get repeater_cliHelpSetBridgeSource => '选择桥接器转发接收或发送的数据包';

  @override
  String get repeater_cliHelpSetBridgeBaud => '设置 RS232 桥接串口波特率';

  @override
  String get repeater_cliHelpSetBridgeSecret => '设置 ESPNOW 桥接密钥';

  @override
  String get repeater_cliHelpSetAdcMultiplier => '设置电池电压校正系数（特定板支持）';

  @override
  String get repeater_cliHelpTempRadio => '临时设置无线电参数指定分钟，之后恢复（不保存）';

  @override
  String get repeater_cliHelpSetPerm => '修改 ACL，权限位：0访客、1只读、2读写、3管理员';

  @override
  String get repeater_cliHelpGetBridgeType => '支持桥接模式：RS232、ESPNOW';

  @override
  String get repeater_cliHelpLogStart => '开始记录数据包到文件系统';

  @override
  String get repeater_cliHelpLogStop => '停止记录数据包';

  @override
  String get repeater_cliHelpLogErase => '删除所有记录的数据包';

  @override
  String get repeater_cliHelpNeighbors => '显示零跳广播收到的其他转发节点列表';

  @override
  String get repeater_cliHelpNeighborRemove => '从邻居列表删除第一个匹配项（通过公钥前缀）';

  @override
  String get repeater_cliHelpRegion => '（仅串口）列出所有定义区域及当前泛洪权限';

  @override
  String get repeater_cliHelpRegionLoad => '特殊多命令调用，以空行结束';

  @override
  String get repeater_cliHelpRegionGet => '搜索指定前缀的区域';

  @override
  String get repeater_cliHelpRegionPut => '添加或更新区域定义';

  @override
  String get repeater_cliHelpRegionRemove => '删除指定区域定义';

  @override
  String get repeater_cliHelpRegionAllowf => '为区域设置“泛洪”权限';

  @override
  String get repeater_cliHelpRegionDenyf => '移除区域的“泛洪”权限';

  @override
  String get repeater_cliHelpRegionHome => '返回当前“主区域”（预留）';

  @override
  String get repeater_cliHelpRegionHomeSet => '设置“主”区域';

  @override
  String get repeater_cliHelpRegionSave => '保存区域列表到存储';

  @override
  String get repeater_cliHelpGps => '显示 GPS 状态';

  @override
  String get repeater_cliHelpGpsOnOff => '切换 GPS 电源';

  @override
  String get repeater_cliHelpGpsSync => '将节点时间与 GPS 同步';

  @override
  String get repeater_cliHelpGpsSetLoc => '将节点坐标设为 GPS 坐标并保存';

  @override
  String get repeater_cliHelpGpsAdvert => '设置位置广播配置：none/share/prefs';

  @override
  String get repeater_cliHelpGpsAdvertSet => '设置广播位置配置';

  @override
  String get repeater_commandsListTitle => '命令列表';

  @override
  String get repeater_commandsListNote => '注意：多数 set 命令也有对应的 get 命令';

  @override
  String get repeater_general => '通用';

  @override
  String get repeater_settingsCategory => '设置';

  @override
  String get repeater_bridge => '桥接';

  @override
  String get repeater_logging => '日志';

  @override
  String get repeater_neighborsRepeaterOnly => '邻居（仅转发节点）';

  @override
  String get repeater_regionManagementRepeaterOnly => '区域管理（仅转发节点）';

  @override
  String get repeater_regionNote => '区域命令用于管理区域定义和权限';

  @override
  String get repeater_gpsManagement => 'GPS 管理';

  @override
  String get repeater_gpsNote => 'GPS 命令用于位置相关任务';

  @override
  String get repeater_getCategory => '获取值';

  @override
  String get repeater_powerMgmt => '电源管理';

  @override
  String get repeater_sensors => '传感器';

  @override
  String get repeater_cliHelpPowerOff => '关闭设备。（不应有任何响应）';

  @override
  String get repeater_cliHelpClkReboot => '将时钟重置为已知的时间点，并重启设备。';

  @override
  String get repeater_cliHelpAdvertZeroHop => '发送无中继广告（仅限于邻居）。';

  @override
  String get repeater_cliHelpStartOta => '在支持的板上启动通过空中进行固件更新。';

  @override
  String get repeater_cliHelpTime => '将设备时钟设置为给定的 Unix 纪元秒。时钟不能倒退。';

  @override
  String get repeater_cliHelpBoard => '显示制造商/硬件标识。';

  @override
  String get repeater_cliHelpDiscoverNeighbors => '向附近的邻居发送节点发现请求。（仅限中继器）';

  @override
  String get repeater_cliHelpPowersaving => '显示节能模式是否已开启或已关闭。';

  @override
  String get repeater_cliHelpPowersavingOnOff => '启用或禁用节能模式（如果支持）。';

  @override
  String get repeater_cliHelpErase => '（仅适用于序列模式）格式化设备的文件系统。清除所有设置和联系人。';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      '设定允许的最大传输时段百分比（1-100）。内部调整空闲时间因子。';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '（仅适用于序列号）替换设备身份私钥。需要重启才能应用。生成一个新的公钥。';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '（仅适用于 SX126x 芯片） 启用增强型 RX 增益，以在较高电流下提高灵敏度。';

  @override
  String get repeater_cliHelpSetOwnerInfo => '设置广告中包含的联系人信息字符串。使用 \'|\' 作为换行符。';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      '设置路径哈希模式。 0 = 传统模式，1 = 标准模式，2 = 严格模式。 影响路由路径的匹配方式。';

  @override
  String get repeater_cliHelpSetLoopDetect => '设置路由环检测的灵敏度：关闭、低、中、或高。';

  @override
  String get repeater_cliHelpSetFreq =>
      '（仅限串行模式）快速设置频率。需要重启。 建议使用“设置收音机参数”功能，以便设置完整的收音机参数。';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '（仅适用于 ESPNow 桥）设置桥使用的 WiFi 频道（1-14）。';

  @override
  String get repeater_cliHelpGetName => '显示配置的节点名称。';

  @override
  String get repeater_cliHelpGetRole => '显示固件的功能（如：中继器、房间服务器等）。';

  @override
  String get repeater_cliHelpGetPublicKey => '显示设备的公钥。';

  @override
  String get repeater_cliHelpGetPrvKey => '（仅适用于序列号）显示设备的私钥。请将其视为机密信息。';

  @override
  String get repeater_cliHelpGetRepeat => '显示数据包转发（作为中继器）是否已启用或已禁用。';

  @override
  String get repeater_cliHelpGetTx => '显示当前的发射功率（以dBm为单位）。';

  @override
  String get repeater_cliHelpGetFreq => '显示配置的射频频率（以兆赫兹为单位）。';

  @override
  String get repeater_cliHelpGetRadio => '显示完整的无线电参数：频率、带宽、扩频因子、编码速率。';

  @override
  String get repeater_cliHelpGetRadioRxGain => '（仅适用于 SX126x 模块）显示 RX 放大器的状态。';

  @override
  String get repeater_cliHelpGetAf => '显示当前的空闲时间系数。';

  @override
  String get repeater_cliHelpGetDutyCycle => '显示当前允许的占空比（以百分比表示）。';

  @override
  String get repeater_cliHelpGetIntThresh => '显示信道干扰阈值（以dB为单位）。';

  @override
  String get repeater_cliHelpGetAgcResetInterval => '显示 AGC 重置的间隔时间（以秒为单位）。';

  @override
  String get repeater_cliHelpGetMultiAcks => '显示双重确认模式是否已启用（1）或已禁用（0）。';

  @override
  String get repeater_cliHelpGetAllowReadOnly => '显示是否允许访客仅限查看权限。';

  @override
  String get repeater_cliHelpGetAdvertInterval => '显示本地广告的时间间隔，单位为分钟。';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval => '显示洪水广告的播放时间间隔，以小时为单位。';

  @override
  String get repeater_cliHelpGetGuestPassword => '显示已配置的访客密码。';

  @override
  String get repeater_cliHelpGetLat => '显示已配置的纬度。';

  @override
  String get repeater_cliHelpGetLon => '显示已配置的经度。';

  @override
  String get repeater_cliHelpGetRxDelay => '显示 rxdelay 的基本值。';

  @override
  String get repeater_cliHelpGetTxDelay => '显示洪水模式下的传输延迟系数。';

  @override
  String get repeater_cliHelpGetDirectTxDelay => '显示直接模式下的时延系数。';

  @override
  String get repeater_cliHelpGetFloodMax => '显示最大洪水传播次数。';

  @override
  String get repeater_cliHelpGetOwnerInfo => '显示所有者的联系信息。';

  @override
  String get repeater_cliHelpGetPathHashMode => '显示哈希模式（0/1/2）。';

  @override
  String get repeater_cliHelpGetLoopDetect => '显示循环检测的灵敏度。';

  @override
  String get repeater_cliHelpGetAcl => '（仅适用于序列号）列出复用器上的访问控制条目。';

  @override
  String get repeater_cliHelpGetBridgeEnabled => '显示桥是否已启用。';

  @override
  String get repeater_cliHelpGetBridgeDelay => '显示桥梁延迟的时间，单位为毫秒。';

  @override
  String get repeater_cliHelpGetBridgeSource => '显示桥接设备是否接收或发送 RX 或 TX 类型的数据包。';

  @override
  String get repeater_cliHelpGetBridgeBaud => '（仅限 RS232 桥）显示桥的波特率。';

  @override
  String get repeater_cliHelpGetBridgeChannel => '（仅适用于 ESPNow 桥）显示桥的 WiFi 通道。';

  @override
  String get repeater_cliHelpGetBridgeSecret => '（仅适用于 ESPNow 桥）显示桥的共享密钥。';

  @override
  String get repeater_cliHelpGetBootloaderVer => '（仅适用于NRF52）显示引导程序版本。';

  @override
  String get repeater_cliHelpGetAdcMultiplier => '显示 ADC 乘数（电池电压缩放）。';

  @override
  String get repeater_cliHelpGetPwrMgtSupport => '报告董事会是否支持电源管理功能。';

  @override
  String get repeater_cliHelpGetPwrMgtSource => '显示当前的电源：外部电源或电池。';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason => '显示最近的重置和关闭原因。';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv => '显示启动时的电池电压，单位为毫伏 (mV)。';

  @override
  String get repeater_cliHelpSensorGet => '通过按键读取自定义传感器设置。';

  @override
  String get repeater_cliHelpSensorSet => '编写自定义传感器设置。';

  @override
  String get repeater_cliHelpSensorList => '列出所有自定义传感器设置，并按可选的起始索引进行分页显示。';

  @override
  String get repeater_cliHelpRegionDefault => '显示当前默认的区域范围。';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      '设置默认的区域范围。使用 \"<null>\" 可以清除。';

  @override
  String get repeater_cliHelpRegionListAllowed => '列出允许洪水交通的区域。';

  @override
  String get repeater_cliHelpRegionListDenied => '列出禁止洪水交通的区域。';

  @override
  String get repeater_cliHelpStatsPackets => '（仅显示序列信息）显示数据包级别的统计信息。';

  @override
  String get repeater_cliHelpStatsRadio => '（仅显示序列信息）显示收音机相关统计数据。';

  @override
  String get repeater_cliHelpStatsCore => '（仅显示序列号）显示核心固件统计信息。';

  @override
  String get telemetry_receivedData => '接收到的遥测数据';

  @override
  String get telemetry_requestTimeout => '遥测请求超时';

  @override
  String telemetry_errorLoading(String error) {
    return '加载遥测数据时出错：$error';
  }

  @override
  String get telemetry_noData => '暂无遥测数据';

  @override
  String telemetry_channelTitle(int channel) {
    return '频道 $channel';
  }

  @override
  String get telemetry_batteryLabel => '电池';

  @override
  String get telemetry_voltageLabel => '电压';

  @override
  String get telemetry_mcuTemperatureLabel => 'MCU 温度';

  @override
  String get telemetry_temperatureLabel => '温度';

  @override
  String get telemetry_currentLabel => '电流';

  @override
  String telemetry_batteryValue(int percent, String volts) {
    return '$percent% / ${volts}V';
  }

  @override
  String telemetry_voltageValue(String volts) {
    return '$volts伏';
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
  String get telemetry_digitalInputLabel => '数字输入';

  @override
  String get telemetry_digitalOutputLabel => '数字输出';

  @override
  String get telemetry_analogInputLabel => '模拟输入';

  @override
  String get telemetry_analogOutputLabel => '模拟输出';

  @override
  String get telemetry_genericLabel => '通用传感器';

  @override
  String get telemetry_luminosityLabel => '照度';

  @override
  String get telemetry_presenceLabel => '存在检测';

  @override
  String get telemetry_humidityLabel => '湿度';

  @override
  String get telemetry_accelerometerLabel => '加速度计';

  @override
  String get telemetry_pressureLabel => '气压';

  @override
  String get telemetry_altitudeLabel => '高度';

  @override
  String get telemetry_frequencyLabel => '频率';

  @override
  String get telemetry_percentageLabel => '百分比';

  @override
  String get telemetry_concentrationLabel => '浓度';

  @override
  String get telemetry_powerLabel => '功率';

  @override
  String get telemetry_distanceLabel => '距离';

  @override
  String get telemetry_energyLabel => '能量';

  @override
  String get telemetry_directionLabel => '方向';

  @override
  String get telemetry_timeLabel => '时间';

  @override
  String get telemetry_gyrometerLabel => '陀螺仪';

  @override
  String get telemetry_colourLabel => '颜色';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => '开关';

  @override
  String get telemetry_polylineLabel => '折线';

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
  String get telemetry_autoFetchQuantity => '请求次数';

  @override
  String get telemetry_error => '无法获取数据';

  @override
  String get neighbors_receivedData => '已接收邻居信息';

  @override
  String get neighbors_requestTimedOut => '邻居请求超时';

  @override
  String neighbors_errorLoading(String error) {
    return '加载邻居时出错：$error';
  }

  @override
  String get neighbors_repeatersNeighbors => '转发节点的邻居';

  @override
  String get neighbors_noData => '暂无邻居信息';

  @override
  String neighbors_unknownContact(String pubkey) {
    return '未知 $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return '听到：$time前';
  }

  @override
  String get channelPath_title => '数据包路径';

  @override
  String get channelPath_viewMap => '查看地图';

  @override
  String get channelPath_otherObservedPaths => '其他观察到的路径';

  @override
  String get channelPath_repeaterHops => '转发节点跳数';

  @override
  String get channelPath_noHopDetails => '此数据包未提供详细信息';

  @override
  String get channelPath_sourceLabel => '来源';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      '此消息通过 MQTT 到达。你的电台没有收到它，因此没有来自你电台的无线路径。';

  @override
  String get channelPath_messageDetails => '消息详情';

  @override
  String get channelPath_senderLabel => '发送者';

  @override
  String get channelPath_timeLabel => '时间';

  @override
  String get channelPath_repeatsLabel => '重复';

  @override
  String channelPath_pathLabel(int index) {
    return '路径 $index';
  }

  @override
  String get channelPath_observedLabel => '观察到的';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return '观察到的路径 $index • $hops';
  }

  @override
  String get channelPath_noLocationData => '无位置信息';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => '未知';

  @override
  String get channelPath_floodPath => '泛洪';

  @override
  String get channelPath_directPath => '直连';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 / $total 跳';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed / $total 跳';
  }

  @override
  String get channelPath_mapTitle => '路径地图';

  @override
  String get channelPath_noRepeaterLocations => '此路径上没有可用的转发节点位置信息';

  @override
  String channelPath_primaryPath(int index) {
    return '路径 $index（主要）';
  }

  @override
  String get channelPath_pathLabelTitle => '路径';

  @override
  String get channelPath_observedPathHeader => '观察到的路径';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable => '此数据包暂无详细信息';

  @override
  String get channelPath_unknownRepeater => '未知转发节点';

  @override
  String get community_title => '社区';

  @override
  String get community_create => '创建社区';

  @override
  String get community_createDesc => '创建新社区并通过二维码分享。';

  @override
  String get community_join => '加入';

  @override
  String get community_joinTitle => '加入社区';

  @override
  String community_joinConfirmation(String name) {
    return '是否加入社区 \"$name\"？';
  }

  @override
  String get community_scanQr => '扫描社区二维码';

  @override
  String get community_scanInstructions => '将摄像头对准社区的二维码';

  @override
  String get community_showQr => '显示二维码';

  @override
  String get community_publicChannel => '社区公共频道';

  @override
  String get community_hashtagChannel => '社区标签频道';

  @override
  String get community_name => '社区名称';

  @override
  String get community_enterName => '请输入社区名称';

  @override
  String community_created(String name) {
    return '社区 \"$name\" 已创建';
  }

  @override
  String community_joined(String name) {
    return '已加入社区 \"$name\"';
  }

  @override
  String get community_qrTitle => '分享社区';

  @override
  String community_qrInstructions(String name) {
    return '扫描此二维码加入 \"$name\"';
  }

  @override
  String get community_hashtagPrivacyHint => '仅社区成员可加入社区标签频道。';

  @override
  String get community_invalidQrCode => '无效的社区二维码';

  @override
  String get community_alreadyMember => '已是成员';

  @override
  String community_alreadyMemberMessage(String name) {
    return '您已是 \"$name\" 的成员。';
  }

  @override
  String get community_addPublicChannel => '添加公共频道';

  @override
  String get community_addPublicChannelHint => '自动添加此社区的公共频道';

  @override
  String get community_noCommunities => '尚未加入任何社区。';

  @override
  String get community_scanOrCreate => '扫描二维码或创建社区以开始。';

  @override
  String get community_manageCommunities => '管理社区';

  @override
  String get community_delete => '退出社区';

  @override
  String community_deleteConfirm(String name) {
    return '是否退出 \"$name\"？';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return '这将同时删除 $count 个频道及其所有消息。';
  }

  @override
  String community_deleted(String name) {
    return '已退出社区 \"$name\"';
  }

  @override
  String get community_regenerateSecret => '重新生成密钥';

  @override
  String community_regenerateSecretConfirm(String name) {
    return '是否为 \"$name\" 重新生成密钥？所有成员需扫描新的二维码才能继续通信。';
  }

  @override
  String get community_regenerate => '重新生成';

  @override
  String community_secretRegenerated(String name) {
    return '已为 \"$name\" 重新生成密钥';
  }

  @override
  String get community_updateSecret => '更新密钥';

  @override
  String community_secretUpdated(String name) {
    return '“$name”的密钥已更新';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return '扫描新二维码以更新 \"$name\" 的密钥';
  }

  @override
  String get community_addHashtagChannel => '添加标签频道';

  @override
  String get community_addHashtagChannelDesc => '为此社区创建标签频道';

  @override
  String get community_selectCommunity => '选择社区';

  @override
  String get community_regularHashtag => '普通标签';

  @override
  String get community_regularHashtagDesc => '公共标签频道（任何人都可参与）';

  @override
  String get community_communityHashtag => '社区标签';

  @override
  String get community_communityHashtagDesc => '仅限社区成员';

  @override
  String community_forCommunity(String name) {
    return '为 $name';
  }

  @override
  String get listFilter_tooltip => '筛选与排序';

  @override
  String get listFilter_sortBy => '排序方式';

  @override
  String get listFilter_latestMessages => '最新消息';

  @override
  String get listFilter_heardRecently => '最近听到';

  @override
  String get listFilter_az => 'A到Z';

  @override
  String get listFilter_filters => '筛选';

  @override
  String get listFilter_all => '全部';

  @override
  String get listFilter_favorites => '收藏';

  @override
  String get listFilter_addToFavorites => '添加到收藏';

  @override
  String get listFilter_removeFromFavorites => '从收藏中移除';

  @override
  String get listFilter_users => '用户';

  @override
  String get listFilter_repeaters => '转发节点';

  @override
  String get listFilter_roomServers => '房间服务器';

  @override
  String get listFilter_unreadOnly => '仅显示未读';

  @override
  String get listFilter_newGroup => '新建群聊';

  @override
  String get pathTrace_you => '我自己';

  @override
  String get pathTrace_failed => '路径追踪失败。';

  @override
  String get pathTrace_notAvailable => '无法获取路径信息。';

  @override
  String get pathTrace_refreshTooltip => '刷新路径追踪';

  @override
  String get pathTrace_someHopsNoLocation => '某些跳缺少位置信息！';

  @override
  String get pathTrace_clearTooltip => '清除路径';

  @override
  String get losSelectStartEnd => '选择 LOS 的起始节点和结束节点。';

  @override
  String losRunFailed(String error) {
    return '视线检查失败：$error';
  }

  @override
  String get losClearAllPoints => '清除所有点';

  @override
  String get losRunToViewElevationProfile => '运行 LOS 查看高程剖面';

  @override
  String get losMenuTitle => '服务水平菜单';

  @override
  String get losMenuSubtitle => '点击节点或长按地图以获取自定义点';

  @override
  String get losShowDisplayNodes => '显示显示节点';

  @override
  String get losCustomPoints => '自定义积分';

  @override
  String losCustomPointLabel(int index) {
    return '自定义 $index';
  }

  @override
  String get losPointA => 'A点';

  @override
  String get losPointB => 'B点';

  @override
  String losAntennaA(String value, String unit) {
    return '天线 A： $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return '天线 B：$value $unit';
  }

  @override
  String get losRun => '运行视距';

  @override
  String get losNoElevationData => '无海拔数据';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit，清除 LOS，最小间隙 $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit，被 $obstruction $heightUnit 阻止';
  }

  @override
  String get losStatusChecking => '洛斯：正在检查...';

  @override
  String get losStatusNoData => 'LOS：无数据';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS：$clear/$total 清除，$blocked 阻塞，$unknown 未知';
  }

  @override
  String get losErrorElevationUnavailable => '一个或多个样本的海拔数据不可用。';

  @override
  String get losErrorInvalidInput => '用于 LOS 计算的点/高程数据无效。';

  @override
  String get losRenameCustomPoint => '重命名自定义点';

  @override
  String get losPointName => '点名称';

  @override
  String get losShowPanelTooltip => '显示 LOS 面板';

  @override
  String get losHidePanelTooltip => '隐藏 LOS 面板';

  @override
  String get losElevationAttribution => '高程数据：Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => '无线电地平线';

  @override
  String get losLegendLosBeam => '视距波束';

  @override
  String get losLegendTerrain => '地形';

  @override
  String get losBlockedSpotsTitle => '被占用区域';

  @override
  String get losBlockedSpotsHint => '点击地图上的某个被遮盖的区域，以突出显示该区域。';

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
  String get losSelectedObstructionTitle => '选择性阻碍';

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
  String get losFrequencyLabel => '频率';

  @override
  String get losFrequencyInfoTooltip => '查看计算详情';

  @override
  String get losFrequencyDialogTitle => '无线电地平线计算';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return '从 $baselineFreq MHz 处的 k=$baselineK 开始，计算调整当前 $frequencyMHz MHz 频段的 k 因子，该因子定义了弯曲的无线电范围上限。';
  }

  @override
  String get contacts_pathTrace => '路径追踪';

  @override
  String get contacts_ping => '乒';

  @override
  String get contacts_repeaterPathTrace => 'Trace 转发节点';

  @override
  String get contacts_repeaterPing => 'Ping 转发节点';

  @override
  String get contacts_roomPathTrace => 'Trace 房间服务器';

  @override
  String get contacts_roomPing => 'Ping 房间服务器';

  @override
  String get contacts_chatTraceRoute => '路由追踪';

  @override
  String contacts_pathTraceTo(String name) {
    return '追踪至 $name 的路径';
  }

  @override
  String get contacts_clipboardEmpty => '剪贴板为空';

  @override
  String get contacts_pasteNotContact =>
      '这不是 MeshCore 联系人。请复制 meshcore:// 联系人链接或广播后重试。';

  @override
  String get contacts_invalidAdvertFormat => '无效的联系人信息格式';

  @override
  String get contacts_contactImported => '联系人已导入';

  @override
  String get contacts_contactImportFailed => '导入联系人失败。';

  @override
  String get contacts_zeroHopAdvert => '发送零跳广播';

  @override
  String get contacts_floodAdvert => '发送泛洪广播';

  @override
  String get contacts_copyAdvertToClipboard => '复制广播到剪贴板';

  @override
  String get contacts_addContactFromClipboard => '从剪贴板添加联系人';

  @override
  String get contacts_ShareContact => '复制联系人信息到剪贴板';

  @override
  String get contacts_ShareContactZeroHop => '通过广播分享联系人';

  @override
  String get contacts_zeroHopContactAdvertSent => '零跳广播已发送';

  @override
  String get contacts_zeroHopContactAdvertFailed => '发送联系人广播失败。';

  @override
  String get contacts_contactAdvertCopied => '广播已复制到剪贴板。';

  @override
  String get contacts_contactAdvertCopyFailed => '复制广播到剪贴板失败。';

  @override
  String get notification_activityTitle => 'MeshCore 活动';

  @override
  String notification_messagesCount(int count) {
    return '$count 条消息';
  }

  @override
  String notification_channelMessagesCount(int count) {
    return '$count 条频道消息';
  }

  @override
  String notification_newNodesCount(int count) {
    return '$count 个新节点';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return '发现新 $contactType';
  }

  @override
  String get notification_receivedNewMessage => '收到新消息';

  @override
  String get settings_gpxExportRepeaters => '导出转发节点/房间服务器到 GPX';

  @override
  String get settings_gpxExportRepeatersSubtitle => '导出带位置的转发节点/房间服务器到 GPX 文件';

  @override
  String get settings_gpxExportContacts => '导出伙伴到 GPX';

  @override
  String get settings_gpxExportContactsSubtitle => '导出带位置的伙伴到 GPX 文件';

  @override
  String get settings_gpxExportAll => '导出所有联系人到 GPX';

  @override
  String get settings_gpxExportAllSubtitle => '导出所有带位置的联系人到 GPX 文件';

  @override
  String get settings_gpxExportSuccess => 'GPX 文件导出成功';

  @override
  String get settings_gpxExportNoContacts => '没有可导出的联系人';

  @override
  String get settings_gpxExportNotAvailable => '您的设备/操作系统不支持';

  @override
  String get settings_gpxExportError => '导出时出错';

  @override
  String get settings_gpxExportRepeatersRoom => '转发节点与房间服务器位置';

  @override
  String get settings_gpxExportChat => '伙伴位置';

  @override
  String get settings_gpxExportAllContacts => '所有联系人位置';

  @override
  String get settings_gpxExportShareText => '来自 NOTORYX Core 的地图数据导出';

  @override
  String get settings_gpxExportShareSubject => 'NOTORYX Core GPX 地图数据导出';

  @override
  String get snrIndicator_nearByRepeaters => '附近的重复器';

  @override
  String get snrIndicator_lastSeen => '最近访问';

  @override
  String get contactsSettings_title => '联系人设置';

  @override
  String get contactsSettings_autoAddTitle => '自动发现';

  @override
  String get contactsSettings_otherTitle => '其他联系人相关设置';

  @override
  String get contactsSettings_autoAddUsersTitle => '自动添加用户';

  @override
  String get contactsSettings_autoAddUsersSubtitle => '允许伴侣自动添加发现的用户';

  @override
  String get contactsSettings_autoAddRepeatersTitle => '自动添加重复器';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle => '允许伴侣自动添加发现的重复器';

  @override
  String get contactsSettings_autoAddRoomServersTitle => '自动添加房间服务器';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle => '允许伴侣自动添加发现的房间服务器';

  @override
  String get contactsSettings_autoAddSensorsTitle => '自动添加传感器';

  @override
  String get contactsSettings_autoAddSensorsSubtitle => '允许伴侣自动添加发现的传感器';

  @override
  String get contactsSettings_overwriteOldestTitle => '覆盖最旧的';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      '当联系人列表已满时，将替换最老的非收藏联系人。';

  @override
  String get discoveredContacts_Title => '已发现的联系人';

  @override
  String get discoveredContacts_noMatching => '没有匹配的联系人';

  @override
  String get discoveredContacts_searchHint => '搜索已发现的联系人';

  @override
  String get discoveredContacts_contactAdded => '联系人已添加';

  @override
  String get discoveredContacts_addContact => '添加联系人';

  @override
  String get discoveredContacts_copyContact => '复制联系人到剪贴板';

  @override
  String get discoveredContacts_deleteContact => '删除联系人';

  @override
  String get discoveredContacts_deleteContactAll => '删除所有发现的联系人';

  @override
  String get discoveredContacts_deleteContactAllContent => '您确定要删除所有发现的联系人吗？';

  @override
  String get chat_sendCooldown => '请稍等片刻后再尝试发送。';

  @override
  String get appSettings_jumpToOldestUnread => '跳转到最旧、未读的文章';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      '在打开包含未读消息的聊天时，请滚动到第一个未读消息，而不是最新的消息。';

  @override
  String get appSettings_languageHu => '匈牙利';

  @override
  String get appSettings_languageJa => '日语';

  @override
  String get appSettings_languageKo => '韩语';

  @override
  String get radioStats_tooltip => '无线电和网状结构统计数据';

  @override
  String get radioStats_screenTitle => '广播统计数据';

  @override
  String get radioStats_notConnected => '连接到设备以查看收音机统计信息。';

  @override
  String get radioStats_firmwareTooOld => '使用无线电统计功能需要配合使用 v8 或更高版本的固件。';

  @override
  String get radioStats_waiting => '正在等待数据…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return '噪声水平：$noiseDbm dBm';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return '上次 RSSI 值：$rssiDbm dBm';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return '上次 SNR：$snr dB';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'TX 频道播出时间（总时长）：$seconds 秒';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'RX 使用时长（总时长）：$seconds 秒';
  }

  @override
  String get radioStats_chartCaption => '近期的噪声水平（dBm）。';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return '噪声水平：$noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting => '正在获取收音机数据…';

  @override
  String get radioStats_settingsTile => '广播统计数据';

  @override
  String get radioStats_settingsSubtitle => '噪声水平、RSSI、信噪比和空中时间';

  @override
  String get translation_title => '翻译';

  @override
  String get imageMessages_enableTitle => '启用图片消息';

  @override
  String get imageMessages_enableSubtitle => '通过网格发送图像。需要一次性下载图像模型。';

  @override
  String get imageMessages_modelSectionTitle => '图像模型';

  @override
  String get imageMessages_downloadModel => '下载';

  @override
  String get imageMessages_cancelDownload => '取消';

  @override
  String get imageMessages_removeModel => '移除模型';

  @override
  String get imageMessages_modelReady => '准备就绪';

  @override
  String get imageMessages_modelNotPublished => '尚未发布——此版本无法下载该内容。';

  @override
  String get imageMessages_downloadFailed => '图像模型无法下载。';

  @override
  String get imageMessages_autoProcessTitle => '自动处理图像';

  @override
  String get imageMessages_autoProcessSubtitle =>
      '每次图像到达后立即重建，每次需要约2GB的内存；若想关闭重建功能，可通过点击取消开启。';

  @override
  String get translation_enableTitle => '启用翻译功能';

  @override
  String get translation_enableSubtitle => '翻译收到的消息，并允许在发送前进行翻译。';

  @override
  String get translation_composerTitle => '在发送之前进行翻译';

  @override
  String get translation_composerSubtitle => '控制作曲家翻译图标的默认状态。';

  @override
  String get translation_autoIncomingTitle => '自动翻译消息';

  @override
  String get translation_autoIncomingSubtitle => '自动为通知以及聊天或频道翻译消息。';

  @override
  String get translation_translateMessage => '翻译消息';

  @override
  String get translation_targetLanguage => '目标语言';

  @override
  String get translation_useAppLanguage => '使用应用程序语言';

  @override
  String get translation_downloadedModelLabel => '下载的模型';

  @override
  String get translation_presetModelLabel => '预设的 Hugging Face 模型';

  @override
  String get translation_manualUrlLabel => '手动模型网址';

  @override
  String get translation_downloadModel => '下载模型';

  @override
  String get translation_downloading => '正在下载...';

  @override
  String get translation_working => '工作中...';

  @override
  String get translation_stop => '停止';

  @override
  String get translation_mergingChunks => '将下载的片段合并成最终文件...';

  @override
  String get translation_downloadedModels => '下载的模型';

  @override
  String get translation_deleteModel => '删除模型';

  @override
  String get translation_modelDownloaded => '翻译模型已下载。';

  @override
  String get translation_downloadStopped => '下载已停止。';

  @override
  String translation_downloadFailed(String error) {
    return '下载失败：$error';
  }

  @override
  String get translation_enterUrlFirst => '首先，请输入模型的 URL。';

  @override
  String get scanner_linuxPairingShowPin => '显示PIN码';

  @override
  String get scanner_linuxPairingHidePin => '隐藏 PIN';

  @override
  String get scanner_linuxPairingPinTitle => '蓝牙配对 PIN';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return '输入 $deviceName 的 PIN 码（如果为空，则留空）。';
  }

  @override
  String get translation_messageTranslation => '消息翻译';

  @override
  String get translation_translateBeforeSending => '在发送前进行翻译';

  @override
  String get translation_composerEnabledHint => '消息将在发送前进行翻译。';

  @override
  String get translation_composerDisabledHint => '使用原始的打字方式发送消息。';

  @override
  String translation_translateTo(String language) {
    return '翻译成 $language';
  }

  @override
  String get translation_translationOptions => '翻译选项';

  @override
  String get translation_systemLanguage => '系统语言';

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
  String get map_zoomIn => '放大';

  @override
  String get map_zoomOut => '放大';

  @override
  String get map_centerMap => '中心地图';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'Web Bluetooth 需要 Chromium 浏览器';

  @override
  String channels_communityShortId(String id) {
    return 'ID：$id...';
  }

  @override
  String get pathTrace_legendGpsConfirmed => '通过GPS确认';

  @override
  String get pathTrace_legendInferred => '推测的位置';

  @override
  String get pathMap_viewSingle => '单条';

  @override
  String get pathMap_viewCombined => '综合';

  @override
  String get pathMap_play => '播放';

  @override
  String get pathMap_pause => '暂停';

  @override
  String get pathMap_replay => '重播';

  @override
  String get pathMap_stepBack => '上一跳';

  @override
  String get pathMap_stepForward => '下一跳';

  @override
  String get pathMap_animationOn => '显示数据包动画';

  @override
  String get pathMap_animationOff => '隐藏数据包动画';

  @override
  String pathMap_hopOf(int current, int total) {
    return '第 $current 跳，共 $total 跳';
  }

  @override
  String pathMap_observedPaths(int count) {
    return '观测到的路径：$count';
  }

  @override
  String get pathMap_primary => '主路径';

  @override
  String pathMap_alternate(int index) {
    return '备用 $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 跳',
      one: '1 跳',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => '共享路段';

  @override
  String get pathMap_legendEstimated => '估算路段';

  @override
  String pathMap_sharedNodeCount(int count) {
    return '已被 $count 条路径使用';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 跳无位置信息 — 显示的路径不完整',
      one: '1 跳无位置信息 — 显示的路径不完整',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => '显示全部';

  @override
  String get pathMap_hidePath => '隐藏路径';

  @override
  String get pathMap_showPath => '显示路径';

  @override
  String get pathMap_collapsePanel => '收起面板';

  @override
  String get pathMap_expandPanel => '展开面板';

  @override
  String get pathMap_noLocation => '无位置';

  @override
  String get pathMap_followPacket => '锁定视图跟随数据包';

  @override
  String get pathMap_unfollowPacket => '解锁视图跟随';

  @override
  String get imageSend_title => '发送图片';

  @override
  String get imageSend_cropNote => '调整大小至512 × 512 · 宽高比未保留';

  @override
  String get imageSend_originalSize => '原文';

  @override
  String get imageSend_onAirSize => '直播中';

  @override
  String get imageSend_quality => '质量';

  @override
  String get imageSend_qualityStandard => '标准';

  @override
  String get imageSend_qualityHigh => '高';

  @override
  String get imageSend_packetsLabel => '数据包';

  @override
  String get imageSend_airtimeLabel => '播出时间';

  @override
  String get imageSend_sizeLabel => '有效载荷';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '个数据包',
      one: '个数据包',
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
  String get imageSend_radioUnknownTitle => '无线电设置未知';

  @override
  String get imageSend_radioUnknownBody => '连接设备以计算播出时间。';

  @override
  String get imageSend_longSendTitle => '长距离传输';

  @override
  String imageSend_longSendBody(String duration) {
    return '这将维持频道大约 $duration 时间。';
  }

  @override
  String get imageSend_floodNote => '洪水路由：每个中继站都会转发每个数据包，因此信道比这段时间更长地处于繁忙状态。';

  @override
  String get imageSend_parityTitle => '恢复包';

  @override
  String get imageSend_paritySubtitle =>
      '多一个数据包。群发消息不被确认，因此如果某个数据包丢失，接收方可以重新构建图像。';

  @override
  String get imageSend_send => '发送';

  @override
  String get imageSend_cancel => '取消';

  @override
  String get imageSend_encodeFailed => '此图像无法编码。';

  @override
  String get imageSend_codecDownloading => '图像模型仍在下载中。';

  @override
  String get imageSend_codecUnavailable => '此设备无法发送图片。';

  @override
  String get imageSend_codecDisabled => '图片消息在设置中已关闭。';

  @override
  String get imageSend_deviceUnsupported =>
      '此无线电无法发送图像数据包。请连接运行伴侣固件13或更高版本的设备。';

  @override
  String get imageSend_directMessagesUnsupported =>
      '图片作为群组数据传输，因此只能发送到频道，而不能直接发送给个人。';

  @override
  String get imageSend_tooLarge => '该图像编码的数据包数量超过了网格格式所允许的范围。';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '个数据包',
      one: '个数据包',
    );
    return '图像已作为 $count $_temp0 发送。';
  }

  @override
  String imageSend_sendFailed(String error) {
    return '无法发送图片：$error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return '发送图像 — 已发送 $sent 包含 $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return '节点 $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return '已收到的 $received 个包含在 $total 个包裹中';
  }

  @override
  String get receivedImage_queued => '等待解码';

  @override
  String get receivedImage_tapToDecode => '点击解锁';

  @override
  String get receivedImage_decoding => '重建……大约1秒';

  @override
  String receivedImage_incomplete(int received, int total) {
    return '图片不完整 — $received 已收到 $total 个数据包';
  }

  @override
  String get receivedImage_corrupt => '图像无法重建';

  @override
  String get receivedImage_decoderMissing => '收到图片 — 图像解码失败';

  @override
  String get receivedImage_evicted => '图片已不再存储';

  @override
  String get receivedImage_retry => '再试一次';

  @override
  String get receivedImage_decodeAgain => '重新解码';

  @override
  String get receivedImage_openSettings => '建立';

  @override
  String get receivedImage_tapToProcess => '点击处理';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: '个数据包',
      one: '个数据包',
    );
    return '$bytes 字节 · $packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds 秒';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes 分 $seconds 秒';
  }

  @override
  String get bastion_tagline => '无需基础设施的通信。';

  @override
  String get bastion_nodes => '节点';

  @override
  String get bastion_repeaters => '中继器';

  @override
  String get bastion_active1h => '1 小时内活跃';

  @override
  String get bastion_mapCoverage => '地图 + 覆盖';

  @override
  String get bastion_routeIntelligence => '路由分析';

  @override
  String get bastion_repeaterTools => '中继器工具';

  @override
  String get bastion_fieldStats => '野外统计';

  @override
  String get bastion_fieldOps => '行程 + 野外行动';

  @override
  String get bastion_coverageCapture => '覆盖记录';

  @override
  String get bastion_mapAttribution => '地图数据 © OpenStreetMap 贡献者；图块来自所选提供商';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 条观测',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个唯一节点',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 跳',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 分钟',
    );
    return '$_temp0';
  }

  @override
  String get sos_holdHint => '按住 2 秒。每 5 分钟向你的行程联系人发送你的位置，直到有人回复。';

  @override
  String sos_holdHintChannel(String channel) {
    return '按住 2 秒。每 5 分钟向你的行程联系人和 $channel 发送你的位置，直到有人回复。';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS 未发送：$error';
  }

  @override
  String sos_acknowledged(String name) {
    return '$name 已确认。已停止重复发送。';
  }

  @override
  String get sos_waitingForRadio => '正在等待电台发送…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return '已发送 $sends/$max 次。重复发送已结束；尚无回复。';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return '已发送 $sends/$max 次。下次发送：$time。';
  }

  @override
  String get sos_active => 'SOS 进行中';

  @override
  String get sos_stop => '停止';

  @override
  String get sos_imSafe => '我已安全';

  @override
  String get sos_holdSemantics => 'SOS。按住发送。';

  @override
  String get sos_keepHolding => '继续按住…';

  @override
  String get sos_holdForSos => '按住发送 SOS';

  @override
  String get sos_blockStorage => '请先解决野外日志的存储错误。';

  @override
  String get sos_blockNotConnected => '请连接 MeshCore 电台以发送 SOS。';

  @override
  String get sos_blockNoTarget => '请在“规划行程”中选择行程联系人或 SOS 频道。';

  @override
  String get checkIn_labelOk => '我很好';

  @override
  String get checkIn_labelAtCamp => '已到营地';

  @override
  String get checkIn_labelDelayed => '有延误';

  @override
  String get checkIn_labelHeadingBack => '正在返回';

  @override
  String get checkIn_blockLoading => '正在加载行程…';

  @override
  String get checkIn_blockStorage => '发送前请先解决野外日志的存储错误。';

  @override
  String get checkIn_blockBusy => '正在发送报到。请稍候。';

  @override
  String get checkIn_blockNoContacts => '请在“规划行程”中选择行程联系人。';

  @override
  String get checkIn_blockRosterIncomplete => '部分行程联系人不可用。请检查名单。';

  @override
  String get checkIn_blockNotConnected => '请连接 MeshCore 电台以报到。';

  @override
  String get checkIn_blockNotActive => '开始行程后才能报到。';

  @override
  String get checkIn_notSent => '未发送';

  @override
  String checkIn_deliveredToOne(String name) {
    return '已送达 $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return '已送达全部 $count 位联系人';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return '已送达 $delivered/$total';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return '未送达：$names';
  }

  @override
  String get checkIn_waitingForRest => '正在等待其余联系人';

  @override
  String get checkIn_aContact => '一位联系人';

  @override
  String get checkIn_statusPending => '待处理';

  @override
  String get checkIn_statusSent => '已发送';

  @override
  String get checkIn_statusDelivered => '已送达';

  @override
  String get checkIn_statusFailed => '失败';

  @override
  String get checkIn_explainPending => '已在本地排队。这并不确认电台已发射或对方已接收。';

  @override
  String get checkIn_explainSent => '电台已接受发送。尚未记录送达确认。';

  @override
  String get checkIn_explainDelivered => '应用已记录送达确认。这并不能证明对方已阅读。';

  @override
  String get checkIn_explainFailed => '未确认送达。请检查电台连接、收件人可达性和重试记录。';

  @override
  String get checkIn_explainUnknown => '送达状态不可用。不要认为这条消息已经送达。';

  @override
  String get tripBrief_heading => 'NOTORYX • MeshCore 行程简报';

  @override
  String tripBrief_trip(String name) {
    return '行程：$name';
  }

  @override
  String tripBrief_status(String status) {
    return '状态：$status';
  }

  @override
  String get tripBrief_active => '进行中';

  @override
  String get tripBrief_stopped => '已停止';

  @override
  String tripBrief_contacts(String names) {
    return '联系人：$names';
  }

  @override
  String get tripBrief_noneSelected => '未选择';

  @override
  String get tripBrief_unavailableContact => '联系人不可用（请检查名单）';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return '活动超时判定：$minutes 分钟（联系人沉默时本手机会提醒）';
  }

  @override
  String tripBrief_reminder(String value) {
    return '报到提醒：$value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return '每 $minutes 分钟未报到时提醒';
  }

  @override
  String tripBrief_choices(String choices) {
    return '报到选项：$choices';
  }

  @override
  String tripBrief_position(String value) {
    return '报到中的电台位置：$value';
  }

  @override
  String get tripBrief_includedMayBeStale => '包含；可能已过时';

  @override
  String tripBrief_battery(String value) {
    return '报到中的电台电量：$value';
  }

  @override
  String get tripBrief_included => '包含';

  @override
  String get tripBrief_off => '关闭';

  @override
  String get tripBrief_review => '发送报到前，请检查收件人和消息内容。';

  @override
  String get tripBrief_noProof => '已排队或已发送不代表已送达。确认回执不代表已阅读。';

  @override
  String get tripBrief_overdueMeaning => '超时表示联系人近期没有活动；这不是已确认的紧急情况。';

  @override
  String get tripBrief_automations => '野外自动化仅在应用处于活动状态时运行。请另外约定失联时的应对计划。';

  @override
  String get tripBrief_sharesOnly => '本简报仅用于分享信息；它不会发送电台消息，也不会开始行程。';

  @override
  String get fieldOps_title => 'NOTORYX Core 野外行动';

  @override
  String get fieldOps_tabTrip => '行程';

  @override
  String get fieldOps_tabReady => '准备';

  @override
  String get fieldOps_tabLog => '日志';

  @override
  String get fieldOps_tabAuto => '自动';

  @override
  String get fieldOps_tabCoverage => '覆盖';

  @override
  String get fieldOps_tabConnection => '连接';

  @override
  String get fieldOps_diagnostics => '诊断';

  @override
  String get fieldOps_storageLoadError => '无法加载野外数据。已保存的数据仍保留；自动化保持关闭。';

  @override
  String get fieldOps_storageSaveError => '无法保存野外数据。自动化已停止；已有的保存数据仍保留。';

  @override
  String get fieldOps_regionHint => '请在“离线地图”中选择区域和缩放级别。';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • 缩放 $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return '无法验证地图区域：$error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '行程进行中 • $count 位联系人',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped => '行程已停止。准备好后再开始。';

  @override
  String fieldOps_reminderAt(String time) {
    return '$time 报到提醒';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return '沉默过久：$names';
  }

  @override
  String get fieldOps_planTrip => '规划行程';

  @override
  String get fieldOps_endTrip => '结束行程';

  @override
  String get fieldOps_startTrip => '开始行程';

  @override
  String get fieldOps_tripBrief => '行程简报';

  @override
  String get fieldOps_connectRadio => '连接电台';

  @override
  String get fieldOps_previewedCheckIns => '可预览的报到';

  @override
  String get fieldOps_previewedCheckInsHint =>
      '选择一个状态，检查实际收件人和消息，然后发送。已排队不代表已送达。';

  @override
  String get fieldOps_tripRoster => '行程名单';

  @override
  String get fieldOps_rosterEmpty => '请在“规划行程”中选择最多六位已知聊天联系人。';

  @override
  String get fieldOps_rosterCaveat =>
      '“上次收到”只是过去活动的证据，不能确定当前可达。超时标记表示联系人近期没有活动，并非已确认的紧急情况。';

  @override
  String get fieldOps_offlineMaps => '离线地图';

  @override
  String get fieldOps_checkingTiles => '正在检查已保存的图块…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已缓存 $count 个图块。',
    );
    return '$_temp0这并不保证你的整条路线都已覆盖。';
  }

  @override
  String get fieldOps_downloadAreas => '下载/检查离线区域';

  @override
  String fieldOps_lastCheckIn(String time) {
    return '上次报到，$time';
  }

  @override
  String fieldOps_deliveryChip(String name, String status) {
    return '$name：$status';
  }

  @override
  String get fieldOps_contactFallback => '联系人';

  @override
  String fieldOps_resendFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '重新发送给 $count 位未送达的联系人',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable => '所选联系人不可用';

  @override
  String get fieldOps_memberUnavailableHint => '发送前请检查此行程。';

  @override
  String fieldOps_lastActivity(int minutes) {
    return '上次活动于 $minutes 分钟前';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return '上次活动于 $minutes 分钟前 • 超时';
  }

  @override
  String get fieldOps_noCheckInRecorded => '此日志中没有报到记录。';

  @override
  String get fieldOps_tripMap => '行程地图';

  @override
  String get fieldOps_tripMapEmpty => '所选联系人尚未广播坐标。';

  @override
  String get fieldOps_lastPositions => '最近广播的位置';

  @override
  String get fieldOps_positionsCaveat => '位置可能已过时。此地图不追踪手机 GPS，也不能证明成员此刻在此处。';

  @override
  String get fieldOps_briefPreviewTitle => '预览行程简报';

  @override
  String get fieldOps_briefPreviewHint => '包含行程和联系人名称。分享前请检查。坐标、密钥和消息记录均已省略。';

  @override
  String get fieldOps_shareBrief => '分享简报';

  @override
  String get fieldOps_briefSubject => 'NOTORYX Core 行程简报';

  @override
  String get fieldOps_tripName => '行程名称';

  @override
  String get fieldOps_defaultTripName => '我的行程';

  @override
  String get fieldOps_includePosition => '包含电台广播的位置';

  @override
  String get fieldOps_includePositionHint => '可能已过时；默认不分享。';

  @override
  String get fieldOps_includeBattery => '包含电台电量';

  @override
  String get fieldOps_overdueLabel => '联系人沉默超过此时长时提醒我';

  @override
  String get fieldOps_reminderLabel => '提醒我报到';

  @override
  String get fieldOps_reminderHelper => '即使 NOTORYX Core 已关闭，也会发送手机通知。';

  @override
  String get fieldOps_reminderOff => '关闭';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 分钟未报到后',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'SOS 同时发送到频道';

  @override
  String get fieldOps_sosChannelNone => '无';

  @override
  String get fieldOps_selectContacts => '选择最多六位已知聊天联系人';

  @override
  String get fieldOps_sendCheckInTitle => '发送报到？';

  @override
  String fieldOps_recipients(String names) {
    return '收件人：$names';
  }

  @override
  String get fieldOps_sendCheckInHint => '使用普通私信发送。送达情况将记录在野外日志中。';

  @override
  String get fieldOps_send => '发送';

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
  String get fieldOps_beforeYouLeave => '出发前';

  @override
  String get fieldOps_radioConnected => '电台已连接';

  @override
  String get fieldOps_connectHint => '通过蓝牙、USB 或 TCP 连接。';

  @override
  String get fieldOps_radioBattery => '电台电量';

  @override
  String get fieldOps_batteryUnknown => '未知；请检查电台。';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent% • 请为计划的行程充电。';
  }

  @override
  String get fieldOps_tripContacts => '行程联系人';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return '$available/$selected 可用。请确认他们有兼容的电台和频道。';
  }

  @override
  String get fieldOps_offlineArea => '所选离线地图区域';

  @override
  String get fieldOps_checkingFiles => '正在检查本地文件…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return '$available/$expected 个图块文件可用；缺少 $missing 个。这只是快照；出发前请离线打开该区域。';
  }

  @override
  String get fieldOps_locationChoice => '位置分享';

  @override
  String get fieldOps_locationOptedIn => '已开启：电台广播的坐标可能已过时。';

  @override
  String get fieldOps_locationOff => '分享已关闭。你的报到不含坐标。';

  @override
  String get fieldOps_automationAvailability => '自动化可用性';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      '仅在本应用处于活动状态时运行。休眠、关闭应用或电台断开可能导致计划操作无法执行。';

  @override
  String get fieldOps_readinessCaveat => '准备检查仅供参考；不能证明电台覆盖范围，也不保证消息送达。';

  @override
  String get fieldOps_radio => '电台';

  @override
  String get fieldOps_refreshChecks => '刷新检查';

  @override
  String get fieldOps_searchLog => '搜索野外日志';

  @override
  String get fieldOps_kindAll => '全部';

  @override
  String get fieldOps_kindCheckIn => '报到';

  @override
  String get fieldOps_kindReceived => '已接收';

  @override
  String get fieldOps_kindNote => '备注';

  @override
  String get fieldOps_kindDeadZone => '盲区';

  @override
  String get fieldOps_kindRadio => '电台';

  @override
  String get fieldOps_kindAutomation => '自动化';

  @override
  String get fieldOps_kindMissed => '已错过';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => '行程';

  @override
  String get fieldOps_kindOverdue => '超时';

  @override
  String get fieldOps_addNote => '添加备注';

  @override
  String get fieldOps_exportJson => '导出 JSON';

  @override
  String get fieldOps_deleteLog => '删除日志';

  @override
  String get fieldOps_logSubject => 'NOTORYX Core 野外日志';

  @override
  String get fieldOps_logCaveat =>
      '本地存储，最多 1,000 条。导出内容可能包含联系人密钥、消息和位置；分享前请检查。';

  @override
  String get fieldOps_noEntries => '没有匹配的条目。';

  @override
  String get fieldOps_tripUnspecified => '未指定行程';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status：$explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return '已记录电台广播位置 $latitude, $longitude（可能已过时）';
  }

  @override
  String get fieldOps_noteTitle => '野外观察';

  @override
  String get fieldOps_noteLabel => '你观察到了什么？';

  @override
  String get fieldOps_deadZone => '报告盲区';

  @override
  String get fieldOps_deadZoneHint => '这是你的观察，不是经过验证的覆盖预测。';

  @override
  String get fieldOps_savePosition => '保存电台广播的位置';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • 可能已过时；不是手机 GPS';
  }

  @override
  String get fieldOps_noPosition => '没有可用的广播坐标';

  @override
  String get fieldOps_deleteLogTitle => '删除野外日志？';

  @override
  String get fieldOps_deleteLogBody => '这将删除此手机上保存的所有条目。行程设置会保留。';

  @override
  String get fieldOps_localAutomations => '本地自动化';

  @override
  String get fieldOps_enableForTrip => '为此行程启用';

  @override
  String get fieldOps_automationsCaveat =>
      '每次重启应用后都会关闭。规则仅在应用处于活动状态时运行。错过的计划操作会出现在野外日志中，绝不会集中补发。自动报到限制为每 10 分钟一批。';

  @override
  String get fieldOps_openBotMode => '打开 NOTORYX 机器人模式';

  @override
  String get fieldOps_ruleEnabled => '规则已启用';

  @override
  String get fieldOps_dryRun => '试运行';

  @override
  String get fieldOps_dryRunHint => '只记录操作，不发送也不通知。';

  @override
  String get fieldOps_then => '则';

  @override
  String get fieldOps_actionLog => '写入野外日志';

  @override
  String get fieldOps_actionNotify => '显示本地通知';

  @override
  String get fieldOps_actionCheckIn => '向行程联系人发送“I\'m OK”';

  @override
  String get fieldOps_batteryThreshold => '电量不高于';

  @override
  String fieldOps_nextDue(String time) {
    return '下次：$time';
  }

  @override
  String get fieldOps_nextDueNone => '下次：未安排';

  @override
  String get fieldOps_previewInLog => '在日志中预览';

  @override
  String get fieldOps_allowNotifications => '允许通知';

  @override
  String get fieldOps_triggerReconnect => '当电台重新连接时';

  @override
  String get fieldOps_triggerDisconnect => '当电台断开时';

  @override
  String get fieldOps_triggerLowBattery => '当电台电量越过阈值时';

  @override
  String get fieldOps_triggerNewNode => '当添加新节点时';

  @override
  String get fieldOps_triggerRepeater => '当添加新中继器时';

  @override
  String get fieldOps_triggerScheduled => '当计划的报到到期时';

  @override
  String get fieldOps_explainConnection => '解释我的连接';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return '状态：$state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat => '手机已与电台连接。仅凭这一点并不能建立通往收件人的路由。';

  @override
  String get fieldOps_disconnectedHint =>
      '没有活动的电台连接。请检查蓝牙权限、电台电源和覆盖范围；也可在“连接电台”中使用 USB/TCP。';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return '等待确认的行程报到：$count';
  }

  @override
  String get fieldOps_staleCaveat =>
      '节点的最后可见时间和广播位置可能已过时。路由分析显示从观察到的尝试中学到的路由；它不会凭空编造路径。';

  @override
  String get fieldOps_routeIntelligence => '路由分析';

  @override
  String get fieldOps_coverageIntelligence => '覆盖分析';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      '比较两次野外会话记录的观测。圆点标记记录者在收到节点时电台广播的位置。它们并不代表连续覆盖。RSSI/SNR 快照不是逐节点测量值。';

  @override
  String get fieldOps_captureSession => '记录会话';

  @override
  String get fieldOps_refreshHistory => '刷新历史';

  @override
  String get fieldOps_noCoverageSessions => '尚无保存的覆盖会话。';

  @override
  String get fieldOps_sessionA => '会话 A • 青绿色';

  @override
  String get fieldOps_sessionB => '会话 B • 琥珀色';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A：$a 个唯一节点 • B：$b 个唯一节点';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return '共有：$shared • 仅 A：$onlyA • 仅 B：$onlyB';
  }

  @override
  String get fieldOps_compareCaveat => '某次会话中没收到某个节点，不能断定是盲区。条件和观测时长各不相同。';

  @override
  String get fieldOps_heardTooltip => '收到的节点观测；不能证明链路成功';

  @override
  String get fieldOps_noteTooltip => '位于电台广播坐标处的本地备注；可能已过时。';

  @override
  String get bastionHome_aboutTooltip => '关于 NOTORYX Core';

  @override
  String get bastionHome_getStarted => '开始使用';

  @override
  String get bastionHome_getStartedHint => '连接你的电台并验证第一条消息';

  @override
  String get bastionHome_planYourTrip => '规划你的行程';

  @override
  String get bastionHome_tripActive => '行程进行中';

  @override
  String get bastionHome_tripStopped => '行程已停止';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • $contacts 位联系人 • $unread 条未读消息';
  }

  @override
  String get bastionHome_checkInOk => '报到：我很好';

  @override
  String get bastionHome_checkInHint => '发送前请检查联系人和消息。可在野外日志中跟踪确认回执。';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return '上次报到：$summary';
  }

  @override
  String get bastionHome_connectRadio => '连接电台';

  @override
  String get bastionHome_connectRadioHint => '通过蓝牙、USB 和 TCP 连接 MeshCore';

  @override
  String get bastionHome_liveDiagnostics => '实时诊断';

  @override
  String get bastionHome_liveDiagnosticsHint => '电台状态、信号、设备和帧工具';

  @override
  String get bastionHome_meshDiscovery => '网状网络发现';

  @override
  String get bastionHome_meshDiscoveryHint => '查找节点并查看你周围的网状网络';

  @override
  String get bastionHome_fieldOpsHint => '行程简报、准备、野外日志、自动化和覆盖对比';

  @override
  String get bastionHome_fieldTools => 'NOTORYX 野外工具';

  @override
  String get bastionHome_statusActive => '可用';

  @override
  String get bastionHome_consoleOnline => '野外控制台在线';

  @override
  String get bastionHome_consoleReady => '野外控制台就绪';

  @override
  String get bastionHome_consoleHint => '连接电台即可启用实时面板。';

  @override
  String bastionHome_battery(String value) {
    return '电量 $value';
  }

  @override
  String get bastionTools_title => '野外工具';

  @override
  String get bastionTools_backup => '加密备份';

  @override
  String get bastionTools_backupHint => '保存设置、联系人和密钥，可选包含聊天记录';

  @override
  String get bastionTools_fieldOpsHint => '报到、准备、野外日志、自动化和对比';

  @override
  String get bastionTools_mapHint => '实时地图、记录会话、离线地图工具和区域';

  @override
  String get bastionTools_pathAnalysis => '路径分析';

  @override
  String get bastionTools_pathHint => '路由、发现和路径分析';

  @override
  String get bastionTools_repeaterHint => '状态、登录、遥测、邻居和管理';

  @override
  String get bastionTools_statsHint => '实时网络计数和联系人活动';

  @override
  String get bastionTools_diagnostics => '诊断';

  @override
  String get bastionTools_diagnosticsHint => '电台状态、设备信息、原始帧和导出';

  @override
  String get bastionTools_about => '关于 + 致谢';

  @override
  String get bastionTools_aboutHint => 'NOTORYX Core 版本、独立性声明和开源许可证';

  @override
  String get bastionAbout_title => '关于 + 致谢';

  @override
  String get bastionAbout_intro =>
      '一款面向 MeshCore 网络的独立社区配套应用。NOTORYX Core 不是 MeshCore 官方应用，收录社区资源也不代表合作或认可。';

  @override
  String get bastionAbout_version => '版本';

  @override
  String get bastionAbout_openSource => '开源基础';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core 基于 MIT 许可证下的 MeshCore Open 开源代码构建并对其进行了修改。覆盖功能相关工作也在适用时致谢采用 MIT 许可证的 MeshMapper Flutter App。';

  @override
  String get bastionAbout_community => '社区优先';

  @override
  String get bastionAbout_communityBody => '第三方创作者的资源仍归各自创作者所有。不代表任何所有权或合作关系。';

  @override
  String get bastionAbout_legalese => 'NOTORYX Core • 独立的 MeshCore 配套应用';

  @override
  String get bastionAbout_licenses => '开源许可证';

  @override
  String get bastionSetup_title => 'NOTORYX Core 入门';

  @override
  String get bastionSetup_intro => '连接、选择联系人，然后验证一条消息。你可以随时从仪表板返回本指南。';

  @override
  String get bastionSetup_step1 => '1. 连接你的 MeshCore 电台';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return '已通过 $transport 连接到 $device。';
  }

  @override
  String get bastionSetup_noRadio => '尚未连接电台。';

  @override
  String get bastionSetup_step1Power =>
      '打开 MeshCore 配套电台。打开“连接电台”，选择蓝牙、USB 或 TCP。授予所选连接方式需要的权限。';

  @override
  String get bastionSetup_step1Bluetooth =>
      '如果蓝牙搜索为空，请检查蓝牙是否已开启，以及 NOTORYX Core 是否在 Android 应用设置中拥有“附近的设备”权限。并按扫描器显示的其他权限提示操作。';

  @override
  String get bastionSetup_connectionDiagnostics => '连接诊断';

  @override
  String get bastionSetup_step2 => '2. 选择聊天联系人';

  @override
  String get bastionSetup_step2Body =>
      '请附近使用兼容 MeshCore 电台设置的同伴广播其节点。在下方选择一位已知聊天联系人；中继器需单独管理。';

  @override
  String get bastionSetup_noContacts => '没有可用的聊天联系人。请连接电台并打开“网状网络发现”。';

  @override
  String get bastionSetup_testRecipient => '测试收件人';

  @override
  String get bastionSetup_meshDiscovery => '网状网络发现';

  @override
  String get bastionSetup_step3 => '3. 发送并验证消息';

  @override
  String get bastionSetup_step3Body =>
      '打开聊天，写一条简短的测试消息，检查收件人后点按“发送”。返回此处可查看自打开本指南以来记录的最新发出消息。';

  @override
  String get bastionSetup_openTestChat => '打开测试聊天';

  @override
  String get bastionSetup_connectFirst => '连接电台后才能打开测试聊天。';

  @override
  String get bastionSetup_chooseRecipient => '请先选择收件人。';

  @override
  String get bastionSetup_noTestMessage => '本次指南会话中没有记录发出的测试消息。';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return '最新消息：$status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      '请同伴确认收到或回复。记录的确认回执并不能证明对方已阅读。如果消息失败，请重新检查连接和收件人。';

  @override
  String get bastionSetup_step4 => '4. 为野外做好准备';

  @override
  String get bastionSetup_step4Body =>
      '规划行程联系人并检查已下载的地图区域。机器人模式和野外自动化默认关闭；野外自动化仅在应用处于活动状态时运行。';

  @override
  String get bastionSetup_tripTools => '行程与准备工具';

  @override
  String get bastionDiag_title => '诊断';

  @override
  String get bastionDiag_export => '导出诊断';

  @override
  String get bastionDiag_channels => '频道';

  @override
  String get bastionDiag_radio => '电台';

  @override
  String get bastionDiag_frequency => '频率';

  @override
  String get bastionDiag_bandwidth => '带宽';

  @override
  String get bastionDiag_spreadingFactor => '扩频因子';

  @override
  String get bastionDiag_codingRate => '编码率';

  @override
  String get bastionDiag_txPower => '发射功率';

  @override
  String get bastionDiag_noiseFloor => '底噪';

  @override
  String get bastionDiag_device => '设备';

  @override
  String get bastionDiag_name => '名称';

  @override
  String get bastionDiag_manufacturer => '制造商';

  @override
  String get bastionDiag_firmware => '固件';

  @override
  String get bastionDiag_battery => '电量';

  @override
  String get bastionDiag_transport => '连接方式';

  @override
  String get bastionDiag_deepTools => '高级工具';

  @override
  String get bastionDiag_liveStats => '实时电台统计';

  @override
  String get bastionDiag_liveStatsHint => '噪声、RSSI、SNR 和空中时间';

  @override
  String get bastionDiag_frameDebug => '帧 / BLE 调试';

  @override
  String get bastionDiag_frameDebugHint => '查看已解码和原始的接收帧';

  @override
  String get bastionDiag_appLog => '应用调试日志';

  @override
  String get bastionDiag_appLogHint => '查看应用诊断事件';

  @override
  String get bastionDiag_online => '电台在线';

  @override
  String get bastionDiag_offline => '电台离线';

  @override
  String get bastionDiag_offlineHint => '连接 MeshCore 配套设备以显示实时诊断。';

  @override
  String get coverage_title => '覆盖记录';

  @override
  String get coverage_leaveBlocked => '离开前请停止并保存会话。';

  @override
  String get coverage_savedSessions => '已保存的会话';

  @override
  String get coverage_caveat =>
      'RSSI/SNR 是电台快照，可能属于另一个数据包。位置是电台广播的坐标，不是手机 GPS，也不能证明覆盖。青色：记录者；琥珀色：广播的节点。不进行插值。';

  @override
  String get coverage_captureActive => '正在记录';

  @override
  String get coverage_fieldSession => '野外覆盖会话';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core 会记录本次会话中新收到的节点，包括路由数据、节点/位置元数据，以及最接近的电台 RSSI/SNR 快照。';

  @override
  String get coverage_disconnectedBody => '开始前请连接电台。覆盖记录会从已连接的配套电台记录实时网状网络观测。';

  @override
  String get coverage_observations => '观测';

  @override
  String get coverage_uniqueNodes => '唯一节点';

  @override
  String get coverage_elapsed => '已用时间';

  @override
  String get coverage_radioConnected => '电台已连接';

  @override
  String get coverage_noRadio => '无电台';

  @override
  String get coverage_gpsReady => '电台 GPS 就绪';

  @override
  String get coverage_noGps => '无电台 GPS';

  @override
  String get coverage_stopSave => '停止 + 保存会话';

  @override
  String get coverage_start => '开始覆盖会话';

  @override
  String get coverage_exportJson => '导出 JSON';

  @override
  String get coverage_exportCsv => '导出 CSV';

  @override
  String get coverage_liveObservations => '实时观测';

  @override
  String get coverage_waiting => '等待网络活动';

  @override
  String get coverage_waitingBody =>
      '开始会话后，新收到的活跃节点会显示在这里。RSSI/SNR 值是电台快照，不一定能唯一对应到某个数据包。';

  @override
  String get coverage_signalNa => '信号 不可用';

  @override
  String get coverage_snrNa => 'SNR 不可用';

  @override
  String get coverage_gpsUnavailable => '电台 GPS 不可用';

  @override
  String coverage_pathLine(String path, String location) {
    return '路径：$path  •  $location';
  }

  @override
  String get coverage_pathFlood => '泛洪';

  @override
  String get coverage_pathDirect => '直连';

  @override
  String get coverage_shareSubject => 'NOTORYX Core 覆盖会话';

  @override
  String get coverage_shareText => 'NOTORYX Core 覆盖记录导出';

  @override
  String get coverage_historyTitle => '已保存的覆盖会话';

  @override
  String coverage_loadFailed(String error) {
    return '无法加载会话：$error';
  }

  @override
  String get coverage_deleteTitle => '删除已保存的会话？';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '将从此设备删除 $count 条观测。',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return '无法删除会话：$error';
  }

  @override
  String get coverage_retention => '保留最近完成的 20 个会话。请分享你想保留的会话。中断的记录可在下方重新打开。';

  @override
  String get coverage_noSessions => '尚无保存的会话。停止记录即可保存。';

  @override
  String get coverage_interrupted => '中断的记录';

  @override
  String get coverage_saved => '已保存';

  @override
  String get coverage_deleteTooltip => '删除会话';

  @override
  String coverage_exportFailed(String error) {
    return '导出失败：$error';
  }

  @override
  String get coverage_sessionTitle => '覆盖会话';

  @override
  String get coverage_shareJson => '分享 JSON';

  @override
  String get coverage_shareCsv => '分享 CSV';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • 快照时长 $age ms';
  }

  @override
  String get coverage_unknown => '未知';

  @override
  String coverage_pathValue(String path) {
    return '路径 $path';
  }

  @override
  String get coverage_recorder => '记录者';

  @override
  String get coverage_noCoordinates => '此会话中没有可用坐标。观测仍可在下方查看。';

  @override
  String get coverage_osmAttribution => '© OpenStreetMap 贡献者 • 在线底图';

  @override
  String get fieldStats_title => '野外情报';

  @override
  String get fieldStats_chatNodes => '聊天节点';

  @override
  String get fieldStats_rooms => '房间';

  @override
  String get fieldStats_sensors => '传感器';

  @override
  String get fieldStats_direct => '直连';

  @override
  String get mapHub_title => 'NOTORYX 野外地图';

  @override
  String get mapHub_intro => '实时地图、离线区域、区域配置和 NOTORYX Core 野外覆盖会话。';

  @override
  String get mapHub_captureHint => '开始和停止野外覆盖会话';

  @override
  String get mapHub_badgeNew => '新';

  @override
  String get mapHub_liveMap => '实时网络地图';

  @override
  String get mapHub_liveMapHint => '节点、中继器、位置、路由和地图工具';

  @override
  String get mapHub_badgeLive => '实时';

  @override
  String get mapHub_offlinePacks => '离线地图包';

  @override
  String get mapHub_offlinePacksHint => '为行程和无信号区域缓存地图图块';

  @override
  String get mapHub_badgeOffline => '离线';

  @override
  String get mapHub_regions => '区域配置';

  @override
  String get mapHub_regionsHint => '管理和获取区域网络定义';

  @override
  String get mapHub_badgeRegions => '区域';

  @override
  String get routes_title => '路由分析';

  @override
  String get routes_headline => '了解流量如何在网状网络中传递。';

  @override
  String get routes_body => 'NOTORYX Core 根据从真实消息尝试和发现中学到的路径历史，对已保存的路由进行排序。';

  @override
  String get routes_routes => '路由';

  @override
  String get routes_success => '成功';

  @override
  String get routes_failed => '失败';

  @override
  String get routes_routeMap => '路由地图';

  @override
  String get routes_routeMapHint => '查看节点和路径';

  @override
  String get routes_discover => '发现';

  @override
  String get routes_discoverHint => '寻找新路由';

  @override
  String get routes_learned => '已学到的路由';

  @override
  String get routes_none => '尚无路由历史';

  @override
  String get routes_noneBody =>
      '照常使用网状网络或运行发现。一旦有了路径历史，NOTORYX Core 会在此显示学到的路由。';

  @override
  String get routes_direct => '直连';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 条路由',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return '最佳  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  权重 $weight  •  成功 $success / 失败 $fail';
  }

  @override
  String routes_fastest(String ms) {
    return '已知最快：$ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return '泛洪：成功 $success / 失败 $fail';
  }

  @override
  String get repeaterTools_unnamed => '未命名中继器';

  @override
  String get repeaterTools_empty => '尚未发现中继器。请先连接电台并探索网状网络。';

  @override
  String get notification_fieldAlertTitle => 'NOTORYX 野外警报';

  @override
  String get notification_checkInReminderTitle => 'NOTORYX Core 报到提醒';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return '$trip 已有 $minutes 分钟未报到。打开 NOTORYX Core 进行报到。';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return '已有 $minutes 分钟没有收到 $name 的消息。这不是已确认的紧急情况。';
  }

  @override
  String get notification_aTripContact => '一位行程联系人';

  @override
  String notification_checkInNotDelivered(String name) {
    return '报到未送达 $name。你可以在“行程”中重新发送。';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return '$name 已确认 SOS';
  }

  @override
  String get settings_batterySaver => '省电模式';

  @override
  String get settings_batterySaverOn =>
      '已开启：每 10 分钟读取电台电量，每 5 分钟读取 GPS，统计最多每分钟一次，行程检查每 1–2 分钟一次。消息、警报和 SOS 不受影响。';

  @override
  String get settings_batterySaverOff =>
      '降低电台和行程的检查频率，节省手机和电台电量。消息、警报和 SOS 不受影响。';

  @override
  String get settings_readAloud => '朗读新消息';

  @override
  String get settings_readAloudHelper =>
      '仅在 NOTORYX Core 打开时。已静音的频道不会朗读。任何消息也可以从其菜单中朗读。';

  @override
  String get settings_readAloudOff => '关闭';

  @override
  String get settings_readAloudDirect => '私信';

  @override
  String get settings_readAloudAll => '私信和频道消息';

  @override
  String get chat_readAloud => '朗读';

  @override
  String get messageSearch_title => '搜索消息';

  @override
  String get messageSearch_intro => '搜索此手机上保存的所有私信和频道消息。';

  @override
  String messageSearch_noResults(String query) {
    return '没有包含“$query”的消息。';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 条匹配',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return '显示最新的 $count 条匹配';
  }

  @override
  String get shortcuts_checkIn => '报到';

  @override
  String get shortcuts_trip => '行程';

  @override
  String get shortcuts_chats => '聊天';

  @override
  String get shortcuts_map => '地图';

  @override
  String get sensor_liveUpdates => '实时更新';

  @override
  String get sensor_intro => '让传感器在读数变化时自动发送，而不必每次询问。需要以读取权限登录。';

  @override
  String get sensor_watch => '监视变化';

  @override
  String get sensor_loadFirst => '请先加载遥测数据，再选择读数。';

  @override
  String sensor_watching(String readings, String time) {
    return '正在监视 $readings，直到 $time。';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return '正在监视 $readings，直到 $time • 区域 $region。';
  }

  @override
  String get sensor_noChanges => '尚未报告任何变化。';

  @override
  String sensor_lastUpdate(String time, int count) {
    return '上次更新 $time • 已收到 $count 条';
  }

  @override
  String get sensor_stop => '停止实时更新';

  @override
  String sensor_stopUnconfirmed(String error) {
    return '已在此处停止；传感器未确认，将在时间到期后停止。$error';
  }

  @override
  String get sensor_dialogBody => '传感器大约每分钟检查一次，当所选读数的变化超过阈值时发送更新。';

  @override
  String sensor_readingTitle(String label, String channel) {
    return '$label（通道 $channel）';
  }

  @override
  String sensor_readingValue(String label, String channel, String value) {
    return '$label（通道 $channel）：$value';
  }

  @override
  String sensor_watchItem(String label, String channel, String delta) {
    return '$label（通道 $channel）±$delta';
  }

  @override
  String sensor_updateOn(String delta) {
    return '变化 $delta 时更新';
  }

  @override
  String get sensor_changeThreshold => '更改阈值';

  @override
  String sensor_capacity(int max, String used) {
    return '传感器最多可监视 $max 字节的读数（已用 $used）。';
  }

  @override
  String get sensor_for => '时长';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 小时',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => '开始';

  @override
  String sensor_thresholdTitle(String label) {
    return '$label阈值';
  }

  @override
  String get sensor_typeTemperature => '温度';

  @override
  String get sensor_typeHumidity => '湿度';

  @override
  String get sensor_typePressure => '气压';

  @override
  String get sensor_typeVoltage => '电压';

  @override
  String get sensor_typeCurrent => '电流';

  @override
  String get sensor_typeLight => '光照';

  @override
  String get sensor_typeConcentration => '浓度';

  @override
  String get sensor_typePercentage => '百分比';

  @override
  String get sensor_typeAnalogInput => '模拟输入';

  @override
  String get sensor_typeAltitude => '海拔';

  @override
  String get setupWizard_title => '连接你的电台';

  @override
  String get setupWizard_choose => '1. 选择连接方式';

  @override
  String get setupWizard_prepare => '2. 准备电台';

  @override
  String get setupWizard_intro => '选择这部手机或电脑如何连接你的电台。电台通过网状网络传递消息。';

  @override
  String get setupWizard_bluetooth => '无线连接附近的兼容电台。';

  @override
  String get setupWizard_noBluetooth => '此浏览器不支持蓝牙。请使用原生应用或受支持的 USB 连接。';

  @override
  String get setupWizard_usb => '使用 USB 数据线的有线连接。';

  @override
  String get setupWizard_noUsb =>
      '此处无法使用 USB 串口。请使用受支持的桌面或 Android 应用，或支持 Web Serial 的 Chrome。';

  @override
  String get setupWizard_bluetoothSteps =>
      '打开电台并放在附近。开启蓝牙并允许应用使用。关闭其他连接到电台的应用，然后打开设备列表并扫描。';

  @override
  String get setupWizard_usbSteps =>
      '用 USB 数据线连接已开机的电台；仅充电线无法使用。关闭其他串口应用。打开 USB 设备列表，选择你的电台，如有提示请允许访问。';

  @override
  String get setupWizard_firmwareTitle => '更换固件前请先确认兼容性';

  @override
  String get setupWizard_firmware =>
      '你的电台需要支持所选连接方式的 MeshCore companion 固件。支持情况因板卡和固件版本而异；有 USB 接口并不代表支持 USB 串口。请查看你的板卡和已安装版本的说明。转发节点或房间服务器固件不是 companion。连接失败本身并不意味着需要重新刷写固件。';

  @override
  String get setupWizard_settings =>
      '本向导不会刷写固件，也不会更改电台设置。连接后，请在设置中配置区域、频率和高级选项。更改设置前请先与本地网状网络确认。';

  @override
  String get setupWizard_openBluetooth => '打开蓝牙设备';

  @override
  String get setupWizard_openUsb => '打开 USB 设备';

  @override
  String get setupWizard_change => '更改连接方式';

  @override
  String get setupWizard_later => '稍后设置';

  @override
  String get setupWizard_bluetoothError =>
      '无法连接电台。请保持电台开机并靠近，检查蓝牙权限并关闭其他已连接的应用，然后重新扫描。';

  @override
  String get setupWizard_scanError => '无法扫描电台。请开启蓝牙，并在系统设置中允许蓝牙或附近设备权限，然后重新扫描。';

  @override
  String get setupWizard_usbError =>
      '无法通过 USB 连接。请检查数据线和所选设备，允许 USB 访问，并关闭其他串口应用。重新插入数据线后重试。';

  @override
  String get connections_title => '连接';

  @override
  String get connections_radioTitle => '电台连接';

  @override
  String get connections_bluetoothOffNotice => '蓝牙已关闭。打开蓝牙以重新连接；蓝牙恢复后应用会自动重试。';

  @override
  String get connections_transport => '连接方式';

  @override
  String connections_lastError(String error) {
    return '上次错误：$error';
  }

  @override
  String get connections_disconnectRadio => '断开电台';

  @override
  String connections_reconnectTo(String name) {
    return '重新连接到 $name';
  }

  @override
  String get connections_forgetRadio => '忘记电台';

  @override
  String get connections_connectAnother => '连接其他电台';

  @override
  String get connections_usbSerial => 'USB 串口';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => '设备';

  @override
  String get connections_publicKey => '公钥';

  @override
  String get connections_firmware => '固件';

  @override
  String connections_firmwareProtocol(String code) {
    return '协议 v$code';
  }

  @override
  String get connections_battery => '电池';

  @override
  String get connections_lastRx => '最近接收';

  @override
  String get connections_reconnectFailed => '无法重新连接电台';

  @override
  String get connections_statusBluetoothOff => '蓝牙已关闭';

  @override
  String get connections_statusConnected => '已连接';

  @override
  String get connections_statusConnecting => '正在连接…';

  @override
  String get connections_statusDisconnecting => '正在断开…';

  @override
  String get connections_statusScanning => '正在搜索电台…';

  @override
  String get connections_statusReconnectingSoon => '即将重新连接…';

  @override
  String get connections_statusNotConnected => '未连接';

  @override
  String get mqtt_cardTitle => 'MQTT 连接';

  @override
  String get mqtt_statusNotConfigured => '未配置';

  @override
  String get mqtt_statusDisconnected => '已断开';

  @override
  String get mqtt_statusConnecting => '正在连接';

  @override
  String get mqtt_statusConnected => '已连接';

  @override
  String get mqtt_statusReconnecting => '正在重新连接';

  @override
  String get mqtt_statusError => '连接错误';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return '代理服务器：$host:$port（$transport）';
  }

  @override
  String get mqtt_tokenSignIn => '使用电台签名的令牌登录';

  @override
  String mqtt_tokenSignInAs(String username) {
    return '使用电台签名的令牌以 $username… 登录';
  }

  @override
  String get mqtt_connectRadioToSignIn => '连接电台后才能登录';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return '令牌将于 $time 续期';
  }

  @override
  String mqtt_signedInAs(String username) {
    return '已登录为 $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return '正在监听 $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return '数据包：新 $accepted，重复 $duplicate，无效 $invalid';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return '第 $attempt 次重试，共 $max 次';
  }

  @override
  String get mqtt_sharingWaitsForRadio => '共享正在等待电台连接';

  @override
  String mqtt_sharingOn(String topic) {
    return '正在共享到 $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return '将共享到 $topic';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return '在线状态发布到 $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return '已共享 $shared，已保留 $held';
  }

  @override
  String get mqtt_addBrokerHint => '添加代理服务器，通过互联网桥接 MeshCore 流量。电台连接独立工作。';

  @override
  String get mqtt_disconnect => '断开 MQTT';

  @override
  String get mqtt_connect => '连接 MQTT';

  @override
  String get mqtt_packetFeed => '数据包流';

  @override
  String get mqtt_setUpBroker => '设置代理服务器';

  @override
  String get mqtt_brokerSettings => '代理服务器设置';

  @override
  String get mqtt_settingsTitle => 'MQTT 代理服务器设置';

  @override
  String get mqtt_presetLabel => '从预设开始';

  @override
  String get mqtt_presetCustom => '自定义代理服务器';

  @override
  String get mqtt_presetLocal => '本地代理服务器（填写地址）';

  @override
  String get mqtt_presetLetsMeshUs => 'LetsMesh 分析器（美国，社区）';

  @override
  String get mqtt_presetLetsMeshEu => 'LetsMesh 分析器（欧盟，社区）';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh 是由社区运营的 MeshCore 数据包分析器，不属于 NOTORYX，也未获 NOTORYX 认可。共享需要连接电台，并在你开启前一直保持关闭。';

  @override
  String get mqtt_hostname => '代理服务器主机名';

  @override
  String get mqtt_port => '端口';

  @override
  String get mqtt_useTls => '使用 TLS';

  @override
  String get mqtt_allowCleartext => '允许以明文连接本地代理服务器';

  @override
  String get mqtt_allowCleartextHint =>
      '仅限 localhost、.local 以及私有 10.x / 192.168.x 主机。';

  @override
  String get mqtt_useWebSocket => '使用 WebSocket';

  @override
  String get mqtt_webSocketPath => 'WebSocket 路径';

  @override
  String get mqtt_topicPrefix => '主题前缀';

  @override
  String get mqtt_region => '区域（可选）';

  @override
  String get mqtt_regionHelp => '观察者的区域代码，例如 PHL。留空表示全部。';

  @override
  String get mqtt_deliverChannel => '添加通过 MQTT 收到的频道消息';

  @override
  String get mqtt_deliverChannelHint => '观察者听到的你所在频道的消息会显示在聊天中。这些消息不会通过你的电台发送。';

  @override
  String get mqtt_sharingTitle => '作为观察者共享';

  @override
  String get mqtt_share => '共享我的电台收到的数据包';

  @override
  String get mqtt_shareHint =>
      '发布你的电台接收到的广播和频道流量，附带其公钥、信号强度和区域。频道消息仍保持加密。需要设置区域。';

  @override
  String get mqtt_shareDirect => '包含私信流量';

  @override
  String get mqtt_shareDirectHint => '请求、回复和私信。内容仍保持加密，但会显示哪些节点在相互通信。';

  @override
  String get mqtt_shareOwn => '包含我自己的消息和广播';

  @override
  String get mqtt_signInTitle => '登录';

  @override
  String get mqtt_authPassword => '用户名和密码';

  @override
  String get mqtt_authToken => '电台签名的令牌';

  @override
  String get mqtt_tokenExplain =>
      '你的电台会用自己的密钥签署一个有效期一小时的登录令牌，应用会在过期前续期。密钥永远不会离开电台。用户名为 v1_ 加上电台的公钥。';

  @override
  String get mqtt_radioReady => '电台已连接：可以登录。';

  @override
  String get mqtt_radioNeeded => '连接电台后才能登录。MQTT 正在等待。';

  @override
  String get mqtt_username => '用户名（可选）';

  @override
  String get mqtt_password => '密码';

  @override
  String get mqtt_keepPassword => '留空以保留已保存的密码。';

  @override
  String get mqtt_credentialsWeb => '在浏览器中，凭据只保留到页面关闭为止。';

  @override
  String get mqtt_credentialsKeychain => '凭据存储在系统钥匙串中，绝不会存入应用设置或日志。';

  @override
  String get mqtt_saveSettings => '保存设置';

  @override
  String get mqtt_feedTitle => 'MQTT 数据包流';

  @override
  String get mqtt_feedConnect => '连接到代理服务器以查看观察者的数据包。';

  @override
  String mqtt_feedWaiting(String topic) {
    return '正在等待 $topic 上的数据包';
  }

  @override
  String get mqtt_feedUnknownObserver => '未知观察者';

  @override
  String mqtt_feedHeardBy(String observer) {
    return '由 $observer 接收';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return '$hops 跳 · $bytes 字节';
  }

  @override
  String get mqtt_packetRequest => '请求';

  @override
  String get mqtt_packetResponse => '响应';

  @override
  String get mqtt_packetDirectMessage => '私信';

  @override
  String get mqtt_packetAck => '确认';

  @override
  String get mqtt_packetAdvert => '广播';

  @override
  String get mqtt_packetChannelMessage => '频道消息';

  @override
  String get mqtt_packetChannelData => '频道数据';

  @override
  String get mqtt_packetAnonymousRequest => '匿名请求';

  @override
  String get mqtt_packetPath => '路径';

  @override
  String get mqtt_packetTrace => '追踪';

  @override
  String get mqtt_packetMultipart => '多部分';

  @override
  String get mqtt_packetControl => '控制';

  @override
  String mqtt_packetType(int type) {
    return '类型 $type';
  }

  @override
  String get mqtt_routeTransportFlood => '传输泛洪';

  @override
  String get mqtt_routeFlood => '泛洪';

  @override
  String get mqtt_routeDirect => '直达';

  @override
  String get mqtt_routeTransportDirect => '传输直达';

  @override
  String get mqtt_noticeInvalidHost => '请输入不含协议和端口的主机名或 IPv4 地址。';

  @override
  String get mqtt_noticeInvalidPort => '端口必须在 1 到 65535 之间。';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'WebSocket 路径必须以 / 开头，且不能包含查询或片段。';

  @override
  String get mqtt_noticeInvalidTopicPrefix => '主题前缀必须是不含通配符的非空 MQTT 路径。';

  @override
  String get mqtt_noticeInvalidRegion => '区域必须为 2 到 8 个字母或数字，例如 PHL。';

  @override
  String get mqtt_noticeTlsRequired => '除非明确允许不安全地访问本地代理服务器，否则必须使用 TLS。';

  @override
  String get mqtt_noticeCleartextLocalOnly => '明文 MQTT 仅限明确批准的本地主机。';

  @override
  String get mqtt_noticeRegionNeededToShare => '请设置区域，才能作为观察者共享数据包。';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return '请输入 $username 的密码。';
  }

  @override
  String get mqtt_noticeNoNetwork => '没有网络连接。网络恢复后 MQTT 会重新连接。';

  @override
  String get mqtt_noticeSubscriptionRefused => '代理服务器拒绝了数据包订阅。';

  @override
  String get mqtt_noticeBadCredentials => '代理服务器拒绝了用户名或密码。';

  @override
  String get mqtt_noticeNotAuthorized => '此账户在代理服务器上没有授权。';

  @override
  String get mqtt_noticeConnectionRefused => '代理服务器拒绝了连接。';

  @override
  String get mqtt_noticeUnreachable => '无法连接到代理服务器。';

  @override
  String get mqtt_noticeTlsFailed => '无法建立安全 (TLS) 连接。';

  @override
  String get mqtt_noticeWebSocketOnly => '此平台仅支持通过 WebSocket 使用 MQTT。';

  @override
  String get mqtt_noticeRadioNotConnected => '连接电台后才能用其密钥登录。';

  @override
  String get mqtt_noticeSigningUnsupported => '此电台的固件不支持用其密钥签名。';

  @override
  String get mqtt_noticeSigningTimeout => '电台没有响应签名请求。其固件可能不支持签名。';

  @override
  String get mqtt_noticeSigningTooLong => '数据太长，电台无法签名。';

  @override
  String get mqtt_noticeSigningRejected => '电台拒绝签署数据。';

  @override
  String get scanner_signalStrong => '强';

  @override
  String get scanner_signalGood => '良好';

  @override
  String get scanner_signalFair => '一般';

  @override
  String get scanner_signalWeak => '弱';

  @override
  String get scanner_nearbyRadios => '附近的电台';

  @override
  String get scanner_lastRadio => '上次使用的电台';

  @override
  String get scanner_reconnect => '重新连接';

  @override
  String get scanner_tcpHint => '你网络中带 Wi‑Fi 固件的电台。';

  @override
  String get scanner_otherWays => '其他连接方式';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '附近有 $count 台电台',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => '正在查找电台…';

  @override
  String get scanner_findTitle => '找到你的电台';

  @override
  String get scanner_heroHint => '打开电台并放在几米范围内。需要 MeshCore companion 固件。';

  @override
  String get scanner_tipsTitle => '看不到你的电台？';

  @override
  String get scanner_tipPower => '确认电台已开机并处于唤醒状态。';

  @override
  String get scanner_tipFirmware =>
      '需要 MeshCore companion 固件。中继器和房间服务器不会显示在这里。';

  @override
  String get scanner_tipOtherDevice => '电台一次只能连接一台设备。请先断开它与其他手机或电脑的连接。';

  @override
  String get connections_internetBridge => '互联网桥接';

  @override
  String get connections_noRadio => '没有电台';

  @override
  String get connections_radioSettings => '电台设置';

  @override
  String get connections_viewDashboard => '查看连接面板';

  @override
  String get channelDirectory_title => '频道目录';

  @override
  String get channelDirectory_subtitle => '查找附近的公开话题频道';

  @override
  String get channelDirectory_search => '搜索频道或地点';

  @override
  String get channelDirectory_nearYou => '你附近';

  @override
  String get channelDirectory_all => '所有频道';

  @override
  String get channelDirectory_catAll => '全部';

  @override
  String get channelDirectory_catEmergency => '紧急';

  @override
  String get channelDirectory_catLocal => '本地';

  @override
  String get channelDirectory_catGeneral => '综合';

  @override
  String get channelDirectory_catInterest => '兴趣';

  @override
  String get channelDirectory_catTest => '测试';

  @override
  String get channelDirectory_join => '加入';

  @override
  String get channelDirectory_joined => '已加入';

  @override
  String get channelDirectory_noMatches => '没有符合搜索的频道。';

  @override
  String get channelDirectory_connectFirst => '连接电台后才能加入频道。';

  @override
  String get channelDirectory_slotsFull => '电台的频道位已全部占用。请先删除一个频道。';

  @override
  String get channelDirectory_joinFailed => '无法添加频道，请重试。';

  @override
  String get channelDirectory_addHint => '缺少频道？任何人都可以在 GitHub 上编辑共享列表来推荐。';

  @override
  String get prefixTool_title => '中继器 ID';

  @override
  String get prefixTool_subtitle => '查看谁在用某个 ID、哪些 ID 重复，以及新中继器可用的空闲 ID';

  @override
  String get prefixTool_width => '路径 ID 长度';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes 字节';
  }

  @override
  String get prefixTool_includeCompanions => '包括伴侣设备和传感器';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return '已知节点 $nodes · 已用 ID $used · 重复 $shared';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return '空闲 ID $free / $space';
  }

  @override
  String get prefixTool_lookupHint => '查找 ID，例如 3D';

  @override
  String prefixTool_lookupFree(String id) {
    return '没有已知节点使用 $id。';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个节点使用 $id',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => '重复的 ID';

  @override
  String get prefixTool_sharedHint => '除非网络使用更长的 ID，否则经过这些 ID 的路径无法区分。';

  @override
  String get prefixTool_noShared => '已知节点中没有重复的 ID。';

  @override
  String get prefixTool_free => '空闲 ID';

  @override
  String get prefixTool_shuffle => '更多建议';

  @override
  String get prefixTool_makeKey => '生成密钥';

  @override
  String get prefixTool_onlyKnown => '仅基于你的电台听到过的节点。这里显示空闲的 ID 仍可能被你没听到的中继器使用。';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id 已被 $name 使用。';
  }

  @override
  String get prefixTool_pickFree => '选择空闲 ID';

  @override
  String keyGen_title(String id) {
    return 'ID $id 的密钥';
  }

  @override
  String keyGen_searching(int tries) {
    return '正在搜索…已尝试 $tries 个密钥';
  }

  @override
  String get keyGen_publicKey => '公钥';

  @override
  String get keyGen_privateKey => '私钥';

  @override
  String get keyGen_copy => '复制';

  @override
  String get keyGen_copied => '已复制';

  @override
  String get keyGen_secretWarning => '请妥善保管私钥。拥有私钥的人可以冒充此节点。';

  @override
  String get keyGen_howToUse => '用于中继器时，打开中继器设置，将其粘贴为私钥并保存。伴侣电台需要允许导入密钥的固件。';

  @override
  String get keyGen_tryAgain => '再生成一个';

  @override
  String get regionSetup_title => '区域设置';

  @override
  String get regionSetup_hubSubtitle => '把这台中继器放进本地区的区域树';

  @override
  String get regionSetup_intro =>
      '区域能让消息留在某个范围内，而不是泛洪整个网络。中继器只有带有某个区域时才会转发该区域的消息，所以要给它设置自身区域及其上所有区域。';

  @override
  String get regionSetup_where => '中继器在哪里？';

  @override
  String get regionSetup_tree => '区域树';

  @override
  String get regionSetup_custom => '自定义';

  @override
  String get regionSetup_region => '最小的区域';

  @override
  String get regionSetup_customLabel => '区域（从大到小）';

  @override
  String regionSetup_invalidName(String name) {
    return '“$name”不是有效的区域名。请使用小写字母、数字和连字符，最多 29 个字符。';
  }

  @override
  String regionSetup_tooMany(int max) {
    return '一台中继器最多可设置 $max 个区域。';
  }

  @override
  String get regionSetup_options => '选项';

  @override
  String get regionSetup_setDefault => '把最小的区域设为默认';

  @override
  String get regionSetup_setDefaultBody => '中继器自己的广播会留在该区域内。';

  @override
  String get regionSetup_legacy => '固件 1.14';

  @override
  String get regionSetup_legacyBody => '在每个区域后添加 region allowf。1.15 及以上不需要。';

  @override
  String get regionSetup_denyUnscoped => '停止转发没有区域的消息';

  @override
  String get regionSetup_denyUnscopedBody => '只有在整个地区都使用区域后才开启，否则旧版应用的消息将无法通过。';

  @override
  String get regionSetup_commands => '命令';

  @override
  String get regionSetup_copyAll => '全部复制';

  @override
  String get regionSetup_copied => '已复制';

  @override
  String get regionSetup_pickFirst => '选择一个区域即可查看命令。';

  @override
  String regionSetup_sendTo(String name) {
    return '发送到 $name';
  }

  @override
  String get regionSetup_howToSend => '要发送这些命令，请登录中继器并从其菜单打开区域设置，或把命令粘贴到它的命令行。';

  @override
  String get regionSetup_noReply => '没有回复，已在此停止。';

  @override
  String get regionSetup_addToMine => '把这些区域加入我的列表';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已将 $count 个区域加入你的列表',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => '轨迹记录';

  @override
  String get trackLog_subtitle => '用电台的 GPS 记录行进轨迹';

  @override
  String get trackLog_recording => '正在记录';

  @override
  String get trackLog_notRecording => '未在记录';

  @override
  String get trackLog_noGps => '你的电台没有报告 GPS 位置。轨迹记录需要开启 GPS 的电台。';

  @override
  String get trackLog_start => '开始记录';

  @override
  String get trackLog_stop => '停止记录';

  @override
  String get trackLog_howItWorks =>
      '在 NOTORYX Core 打开期间，使用电台大约每分钟报告一次的位置。移动 25 米后添加一个点，静止时每 15 分钟添加一个点。';

  @override
  String get trackLog_snap => '将位置取整到约 100 米';

  @override
  String get trackLog_snapBody => '分享轨迹时保护隐私。';

  @override
  String get trackLog_saved => '已保存的轨迹';

  @override
  String get trackLog_none => '还没有轨迹。';

  @override
  String get trackLog_export => '导出为 GPX';

  @override
  String get trackLog_exportFailed => '无法导出轨迹。';

  @override
  String get trackLog_deleteTitle => '删除此轨迹？';

  @override
  String get trackLog_deleteBody => '它将从此设备上删除。已导出的 GPX 文件不受影响。';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km 公里 · $duration · $points 个点';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'NOTORYX 轨迹 $when';
  }

  @override
  String get routes_nearbyTitle => '附近最佳中继器';

  @override
  String get routes_nearbyEmptyTitle => '尚未听到中继器';

  @override
  String get routes_nearbyEmpty => '电台直接听到的中继器会随着收到流量按信号从强到弱显示在这里。列表涵盖最近一小时。';

  @override
  String get routes_unknownRepeater => '未知中继器';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已听到 $count 次',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes 分钟前',
      zero: '刚刚',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return '经由 $names';
  }

  @override
  String get nav_home => '首页';

  @override
  String get nav_chats => '聊天';

  @override
  String get nav_tools => '工具';

  @override
  String get nav_settings => '设置';

  @override
  String get nav_more => '更多';

  @override
  String get tools_groupApp => '应用与设置';

  @override
  String get tools_groupField => '野外';

  @override
  String get tools_groupMaps => '地图与覆盖';

  @override
  String get tools_groupRouting => '路由与中继器';

  @override
  String get tools_pathGraph => '路径图';

  @override
  String get tools_pathGraphHint => '消息如何到达你：所有收到的路径，以及最繁忙的中继器';

  @override
  String get tools_antenna => '天线覆盖';

  @override
  String get tools_antennaHint => '估算天线在地形上能覆盖多远';

  @override
  String routes_repeaterWithId(String id) {
    return '中继器 $id';
  }

  @override
  String get coverageHex_title => '覆盖六边形';

  @override
  String get coverageHex_toolSubtitle => '绘制电台能收到网状网络的位置并分享';

  @override
  String get coverageHex_mapCoverage => '记录覆盖';

  @override
  String get coverageHex_statusOff => '已关闭。驾车或步行时打开，记录电台能收到网状网络的位置。';

  @override
  String get coverageHex_waitingGps => '正在等待 GPS…';

  @override
  String coverageHex_gpsTooRough(String meters) {
    return 'GPS 精度 $meters 米：太粗略，不记录。';
  }

  @override
  String coverageHex_recording(String meters) {
    return '正在记录。GPS 精度 $meters 米。';
  }

  @override
  String get coverageHex_hexagons => '六边形';

  @override
  String get coverageHex_samples => '样本';

  @override
  String get coverageHex_privacyNote =>
      '开关打开时使用手机 GPS。只共享六边形 ID（约 0.9 公里），绝不共享你的确切位置。';

  @override
  String get coverageHex_uploadSection => '上传到覆盖地图';

  @override
  String get coverageHex_wifiOnly => '仅在 Wi-Fi 下上传';

  @override
  String get coverageHex_wifiOnlyHint => '样本在手机上等待 Wi-Fi（最多 7 天）。';

  @override
  String coverageHex_waiting(String count) {
    return '$count 个等待中';
  }

  @override
  String get coverageHex_addMap => '添加覆盖地图';

  @override
  String get coverageHex_addMapHint => '任何接受覆盖数据上传的 HTTPS 地址。';

  @override
  String get coverageHex_uploadNow => '立即上传';

  @override
  String get coverageHex_mapDialogTitle => '覆盖地图';

  @override
  String get coverageHex_nameMissing => '请命名。';

  @override
  String get coverageHex_url => '上传 URL';

  @override
  String get coverageHex_urlInvalid => '必须是 https:// 网址。';

  @override
  String get coverageHex_apiKey => 'API 密钥（可选）';

  @override
  String get coverageHex_apiKeyHint => '作为 X-API-Key 发送。';

  @override
  String get coverageHex_format => '格式';

  @override
  String get coverageHex_formatHex => '六边形 ID（NOTORYX）';

  @override
  String get coverageHex_formatMeshMapper => '兼容 MeshMapper';

  @override
  String get coverageHex_privacy => '隐私';

  @override
  String get coverageHex_privacyLive => '实时';

  @override
  String get coverageHex_privacyDelayed => '延迟 3 小时';

  @override
  String get coverageHex_privacyAnonymous => '匿名，24 小时';

  @override
  String get coverageHex_privacyLiveHint => '约 15 分钟内发送。';

  @override
  String get coverageHex_privacyDelayedHint => '保留 3 小时，地图不会显示你的当前位置。';

  @override
  String get coverageHex_privacyAnonymousHint => '保留 24 小时，仅标注日期且不签名，上传之间无法关联。';

  @override
  String get coverageHex_uploadsOn => '开启上传';

  @override
  String coverageHex_sent(String count, String time) {
    return '已于 $time 发送 $count 个单元。';
  }

  @override
  String coverageHex_httpError(String code) {
    return '地图返回 $code；将重试。';
  }

  @override
  String get coverageHex_unreachable => '无法连接地图；将重试。';

  @override
  String get coverageHex_noPermission => '未授予位置权限。';

  @override
  String get coverageHex_noGps => 'GPS 不可用。';

  @override
  String get coverageHex_loadFailed => '无法读取已保存的覆盖数据；重新开始。';

  @override
  String get mqttExtra_wifiOnly => '仅在 Wi-Fi 下连接';

  @override
  String mqttExtra_backlog(String count) {
    return '$count 个数据包等待上传（最多保留 72 小时）。';
  }

  @override
  String get mqttExtra_add => '添加另一个代理';

  @override
  String get mqttExtra_addBody =>
      '将电台收到的内容再分享给一个 MQTT 代理（主代理之外）。它只上传，不会把数据包传回应用。';

  @override
  String get mqttExtra_separateKey => '使用单独的密钥';

  @override
  String get mqttExtra_separateKeyHint =>
      '使用在本手机上生成的密钥登录，而不是电台的密钥，这样该代理无法将上传与你的电台关联。';

  @override
  String mqttExtra_removeTitle(String name) {
    return '移除 $name？';
  }

  @override
  String get mqttExtra_removeBody => '断开连接并清除其设置、密码、密钥及等待上传的数据包。';

  @override
  String mqttExtra_ownKey(String key) {
    return '使用自己的密钥登录：$key…';
  }

  @override
  String get botWx_title => '将天气预警发布到频道';

  @override
  String get botWx_body =>
      '每 10 分钟查询美国国家气象局在电台 GPS 位置（约取整到 1 公里）的严重和极端预警，每条新预警发布一次。需要手机联网。';

  @override
  String get botWx_channel => '发布到频道';

  @override
  String get botWx_moderate => '包括中等预警';

  @override
  String get botWx_moderateHint => '包括提示和预警。消息更多。';

  @override
  String botWx_lastChecked(String time) {
    return '上次检查 $time。';
  }

  @override
  String get botWx_noPosition => '电台尚未报告 GPS 位置。';

  @override
  String get botWx_noChannel => '请选择发布预警的频道。';

  @override
  String get botWx_channelGone => '所选频道已不存在。';

  @override
  String botWx_httpError(String code) {
    return '气象服务返回 $code。';
  }

  @override
  String get botWx_unreachable => '无法连接气象服务。';

  @override
  String get botCmd_sun => '电台 GPS 位置的日出和日落。';

  @override
  String get botCmd_moon => '月相和照亮比例。';

  @override
  String get botCmd_weather => '电台处的当前天气（Open-Meteo）。发送约取整到 1 公里的位置。';

  @override
  String get botCmd_dice => '掷骰子：!dice、!dice 20 或 !dice 2d6。';

  @override
  String get botCmd_trace => '列出发送者消息经过的中继器。';

  @override
  String get ping_title => '中继器 Ping';

  @override
  String get ping_toolSubtitle => '到附近中继器的往返时间和双向信号';

  @override
  String get ping_noRepeaters => '尚无已知中继器';

  @override
  String get ping_choose => '选择中继器';

  @override
  String get ping_avgMs => '毫秒往返';

  @override
  String get ping_snrThere => 'SNR 对方';

  @override
  String get ping_snrBack => 'SNR 回传';

  @override
  String get ping_loss => '丢失';

  @override
  String ping_running(int done, int total) {
    return '正在 Ping $done/$total…';
  }

  @override
  String ping_start(int count) {
    return 'Ping $count 次';
  }

  @override
  String get ping_results => '探测';

  @override
  String get ping_noReply => '无响应';

  @override
  String ping_resultLine(String ms, String snr) {
    return '$ms 毫秒 · 对方 SNR $snr';
  }

  @override
  String get ping_explainer => '每次探测都是一跳路径追踪：中继器记录收到你的信号质量并回传。适用于电台能直接收到的中继器。';

  @override
  String get hunt_title => '天线寻向';

  @override
  String get hunt_toolSubtitle => '信号越强点击越快的大型实时信号表';

  @override
  String get hunt_noSignal => '尚无信号';

  @override
  String get hunt_noReply => '无响应 — 移动或转动天线';

  @override
  String get hunt_heardHere => 'dB（本机收到）';

  @override
  String get hunt_best => '最佳';

  @override
  String get hunt_sound => '信号增强时点击';

  @override
  String get hunt_soundHint => '每次点击都会振动，不看屏幕也能对准。';

  @override
  String get hunt_stop => '停止';

  @override
  String get hunt_start => '开始寻向';

  @override
  String get hunt_explainer => '约每秒探测一次中继器。转动定向天线或四处走动：数值表示电台收到它的好坏。';

  @override
  String get settings_refreshRate => '电台刷新频率';

  @override
  String get settings_refreshFast => '快';

  @override
  String get settings_refreshNormal => '正常';

  @override
  String get settings_refreshSlow => '慢';

  @override
  String get settings_refreshFastHint => '电量每分钟、GPS 每 30 秒。数值更新更快，更耗电。';

  @override
  String get settings_refreshNormalHint => '电量每 2 分钟、GPS 每分钟。';

  @override
  String get settings_refreshSlowHint => '电量每 6 分钟、GPS 每 3 分钟。省电。';

  @override
  String get settings_refreshSaverOn => '省电模式已开启，由它决定频率（电量每 10 分钟）。';

  @override
  String get reach_check => '检查观测站覆盖';

  @override
  String get reach_title => '观测站覆盖';

  @override
  String get reach_noHash => '暂时无法查询此消息：还没有中继器将它回传到你的电台，因此不知道数据包 ID。';

  @override
  String get reach_unreachable => '无法连接分析器。请检查网络连接或设置中的分析器地址。';

  @override
  String get reach_none => '还没有观测站收到。观测站收到后稍后才上传，请一分钟后再查。';

  @override
  String get reach_observers => '观测站';

  @override
  String get reach_maxHops => '最多跳数';

  @override
  String get reach_bestSnr => '最佳 SNR';

  @override
  String reach_hops(int count) {
    return '$count 跳之外';
  }

  @override
  String get reach_explainer => '来自在线分析器：收到并上传此数据包的观测站。';

  @override
  String get reach_checkAgain => '再次检查';

  @override
  String get analyzer_title => '在线分析器';

  @override
  String get analyzer_url => '分析器地址';

  @override
  String get analyzer_urlHint => 'CoreScope 分析器（https://）。请使用覆盖你所在地区的那个。';

  @override
  String get analyzer_reset => '默认';

  @override
  String get analyzer_hint => '用于查看哪些观测站收到了你的消息。只发送数据包 ID。';

  @override
  String get analyzer_hopLookup => '在线识别未知中继器';

  @override
  String get analyzer_hopLookupHint =>
      '中继器 ID 不在联系人中时，向分析器查询其名称。只发送短 ID。名称以“?”结尾表示多个中继器共用该 ID。';

  @override
  String discovered_tray(int count) {
    return '附近收到的频道：$count';
  }

  @override
  String get discovered_title => '附近收到，未加入';

  @override
  String discovered_heard(int count, String time) {
    return '收到 $count 次 · 最近 $time';
  }

  @override
  String get discovered_ignore => '忽略';

  @override
  String get discovered_ignoreAll => '全部忽略';

  @override
  String get discovered_joinAll => '全部加入';

  @override
  String get discovered_explainer =>
      '这些是频道目录中电台收到过流量的公开频道。每个都已用其密钥解密消息确认。已忽略的频道保持隐藏。';

  @override
  String get mqtt_presetMeshRank => 'MeshRank（社区）';

  @override
  String get mqtt_presetMeshRankNote =>
      'MeshRank 是社区运营的 MeshCore 网络排名，不属于 NOTORYX，也未获其认可。无需登录：只有在你开启共享后，数据包才会以电台的密钥和地区代码共享。';

  @override
  String get pathFilter_title => '路径宽度过滤器';

  @override
  String get pathFilter_firmwareNote =>
      '需要支持转发规则的中继器固件（mikecarper/MeshCore）。官方 MeshCore 固件会拒绝这些命令。';

  @override
  String get pathFilter_width => '路径宽度';

  @override
  String get pathFilter_anyWidth => '任意宽度';

  @override
  String pathFilter_bytes(int n) {
    return '$n 字节路径';
  }

  @override
  String get pathFilter_twoOrMore => '2 或 3 字节（2+）';

  @override
  String get pathFilter_path => '适用于';

  @override
  String get pathFilter_radio => '无线泛洪';

  @override
  String get pathFilter_bridge => '网桥';

  @override
  String get pathFilter_cross => '交叉';

  @override
  String get pathFilter_bridgeCross => '网桥和交叉';

  @override
  String get pathFilter_limit => '限速而非丢弃';

  @override
  String get pathFilter_limitOn => '每分钟最多转发设定数量。';

  @override
  String get pathFilter_drop => '匹配的泛洪将被丢弃。';

  @override
  String get pathFilter_perMinute => '每分钟';

  @override
  String get pathFilter_rateInvalid => '请输入 1 到 65534。';

  @override
  String get pathFilter_reviewNote => '这只会填入命令行。请检查后再点发送。可先用“get fr”查看现有规则。';

  @override
  String get pathFilter_useCommand => '使用命令';

  @override
  String get settings_linkPreviews => '链接预览';

  @override
  String get settings_linkPreviewsHint =>
      '显示消息中链接的标题。默认关闭：获取页面会让该网站得知你的 IP 地址。';

  @override
  String get guide_title => '野外指南';

  @override
  String get guide_subtitle => '基础、寒冷天气电池、太阳能和天线';

  @override
  String get guide_secMesh => '加入网状网络';

  @override
  String get guide_mesh1 =>
      '手机通过蓝牙、USB 或 Wi-Fi 连接电台；电台通过 LoRa 连接网状网络。没有手机信号也能收发消息。';

  @override
  String get guide_mesh2 => '中继器转发消息，每次中继为一跳。跳数越少，送达越快越可靠。';

  @override
  String get guide_mesh3 => '消息尽量简短，避免刷屏繁忙频道：每条消息都占用共享的发射时间。';

  @override
  String get guide_secCold => '寒冷天气的电池';

  @override
  String get guide_cold1 => '不要在冰点以下（0 °C）给锂电池充电，会造成永久损坏。';

  @override
  String get guide_cold2 => '把电台放在外套内。寒冷会降低容量，电池回暖后会恢复。';

  @override
  String get guide_cold3 => '寒冷地区的固定站点，磷酸铁锂比锂离子更耐寒；加热或保温箱对两者都有帮助。';

  @override
  String get guide_secSolar => '中继器太阳能';

  @override
  String get guide_solar1 => '中继器功耗很低，但电池板和电池要按冬季最暗的一周配置，而不是夏天。';

  @override
  String get guide_solar2 => '电池板朝向赤道，冬季倾角要大；避免积雪和遮挡。';

  @override
  String get guide_secAntenna => '天线与摆放';

  @override
  String get guide_ant1 => '高度胜过功率：架高几米的电台比放在桌上的覆盖远得多。';

  @override
  String get guide_ant2 => '天线保持垂直、远离金属，并使用适合你频段的天线（例如欧洲 868 MHz）。';

  @override
  String get guide_secMore => '了解更多';

  @override
  String get guide_moreMeshcore => '官方 MeshCore 项目';

  @override
  String get guide_moreCascadia => '社区指南：入门、驾车测绘、区域、太阳能';

  @override
  String get post_signed => '已签名';

  @override
  String get post_unverified => '未验证';

  @override
  String post_signedKnown(String name) {
    return '由你的联系人 $name 签名。';
  }

  @override
  String get post_signedUnknownKey => '已签名，但不是你的联系人签的。把发送者添加为联系人即可看到是谁。';

  @override
  String get post_unverifiedHint => '此消息附带的签名与内容不符。它可能在途中被改动，或并非来自所称的发送者。';

  @override
  String get settings_signPosts => '为我的所有频道消息签名';

  @override
  String get settings_signPostsHint =>
      '频道中的 SOS 始终会签名。开启后每条消息都会签名，让其他 NOTORYX 用户确认确实是你发的。每个签名会多发送一个数据包。';

  @override
  String get tools_search => '搜索工具和设置';

  @override
  String get tools_noMatches => '没有与搜索匹配的工具。';

  @override
  String get tools_bot => '机器人模式';

  @override
  String get tools_botHint => '频道自动回复、!命令和天气警报';

  @override
  String get botChannels_title => '频道';

  @override
  String get botChannels_hint => '机器人也会在你开启的频道中回复!命令，回复发在该频道。它不会在频道中发送离开回复。';

  @override
  String get botChannels_none => '此电台还没有频道。';

  @override
  String get advert_zeroHopHint => '只有直接收到你的电台会收到，中继器不会转发。';

  @override
  String get advert_floodHint => '中继器会将其传遍整个网络，占用更多空中时间。';

  @override
  String get radioPresets_custom => '自定义';

  @override
  String get radioPresets_search => '搜索预设';

  @override
  String get radioPresets_suggested => '你所在地区的推荐';

  @override
  String get radioPresets_community => '社区预设';

  @override
  String get radioPresets_hint =>
      '这些是 MeshCore 社区推荐的预设。请选择你本地网络使用的那个。预设会设置频率、带宽、扩频因子和编码率，发射功率保持不变。';

  @override
  String get mySensors_title => '传感器';

  @override
  String get mySensors_refresh => '读取传感器';

  @override
  String get mySensors_reading => '正在读取电台传感器…';

  @override
  String get mySensors_failed => '电台没有响应。点按刷新重试。';

  @override
  String get mySensors_none => '电台没有传感器读数。';

  @override
  String get activeChannels_title => '在线活跃';

  @override
  String activeChannels_messages(int count) {
    return '$count 条消息';
  }

  @override
  String activeChannels_source(String host) {
    return '$host 的观测站收到的正在使用的频道。在设置中更换分析器可查看你所在地区。';
  }

  @override
  String get fieldOps_checkInChannelLabel => '签到也发到频道';

  @override
  String get fieldOps_checkInChannelHint =>
      '使用电台的密钥签名，频道中的其他人能确认确实是你。行程联系人仍会直接收到。';

  @override
  String get channels_regionUnknown => '区域';

  @override
  String channels_regionSemantics(String region) {
    return '发送到区域 $region';
  }

  @override
  String get channels_regionUnknownSemantics => '发送到应用未知的区域';

  @override
  String get wardrive_title => '覆盖测绘';

  @override
  String get wardrive_hint => '在所在位置 ping，绘制哪些中继器能听到你';

  @override
  String get wardrive_start => '开始';

  @override
  String get wardrive_stop => '停止';

  @override
  String get wardrive_pings => '次 ping';

  @override
  String get wardrive_heard => '被听到';

  @override
  String get wardrive_pinging => '正在 ping…';

  @override
  String get wardrive_waitPosition => '正在等待手机或电台的 GPS 定位。';

  @override
  String get wardrive_waitRadio => '请连接电台后再 ping。';

  @override
  String get wardrive_history => '历史';

  @override
  String get wardrive_noSessions => '还没有记录。';

  @override
  String wardrive_sessionSummary(int pings, int heard) {
    return '$pings 次 ping · $heard 次被听到';
  }

  @override
  String get wardrive_delete => '删除';

  @override
  String get wardrive_recentre => '回到我的位置';

  @override
  String get wardrive_youAreHere => '你在这里';

  @override
  String get wardrive_backToLive => '返回当前记录';

  @override
  String get wardrive_noReplies => '没有中继器听到这次 ping。';

  @override
  String wardrive_replyDetail(String there, String here) {
    return '以 $there dB 听到你 · 你以 $here dB 听到它';
  }

  @override
  String get wardrive_explainer =>
      '每次 ping 都是零跳发现请求：只有直接覆盖范围内的中继器会回应，不会向频道发布任何内容。位置来自手机的 GPS，没有时使用电台的 GPS。';

  @override
  String get mapTelemetry_policy =>
      '缓存读数在1小时后变暗，24小时后隐藏。刷新会发送一次请求；节点必须允许遥测，传感器可能需要登录。地图不会自动请求更新。';

  @override
  String get autoConnect_title => '自动连接我的电台';

  @override
  String get autoConnect_hint => '打开应用时无需点按即可重新连接上次的电台。如果电台还不在范围内，会尝试几次。';

  @override
  String get networks_title => '网络';

  @override
  String get networks_hint => '搜索附近网络并记录';

  @override
  String get networks_yourNetwork => '你的网络';

  @override
  String get networks_scanTitle => '搜索网络';

  @override
  String get networks_scanExplainer =>
      '电台只能听到设置完全相同的网络，所以搜索会依次切换到每个网络收听，最后再切回来。搜索期间你会离开自己的网状网络。';

  @override
  String get networks_listenFor => '每个网络收听时长';

  @override
  String networks_choose(int count) {
    return '要搜索的网络：$count';
  }

  @override
  String get networks_suggested => '推荐';

  @override
  String get networks_start => '开始搜索';

  @override
  String get networks_cancel => '停止搜索';

  @override
  String networks_listening(String name, int step, int steps) {
    return '正在收听 $name（$step/$steps）';
  }

  @override
  String get networks_blockNoRadio => '请连接电台后再搜索。';

  @override
  String get networks_blockSettings => '正在等待电台设置。';

  @override
  String get networks_blockSos => 'SOS 进行中不能搜索：搜索会让你离开网状网络。';

  @override
  String get networks_blockTrip => '行程中不能搜索：搜索会让你离开网状网络。';

  @override
  String get networks_nearby => '附近的网络';

  @override
  String get networks_nothingYet => '还没有听到任何网络。请开始搜索。';

  @override
  String networks_heardSummary(int nodes, int packets, String snr) {
    return '节点 $nodes · 数据包 $packets · SNR $snr dB';
  }

  @override
  String networks_lastHeard(String time) {
    return '最后听到 $time';
  }

  @override
  String networks_timesHeard(int count) {
    return '听到次数：$count';
  }

  @override
  String get networks_saved => '已保存的网络';

  @override
  String get networks_noSaved => '还没有保存的网络。';

  @override
  String get networks_add => '添加网络';

  @override
  String get networks_join => '加入';

  @override
  String networks_joinConfirm(String name) {
    return '将电台切换到 $name？你将离开当前网络。发射功率保持不变。';
  }

  @override
  String networks_joined(String name) {
    return '电台现在使用 $name。';
  }

  @override
  String get networks_log => '网络记录';

  @override
  String get networks_logEmpty => '还没有记录。';

  @override
  String get networks_showMap => '地图';

  @override
  String get networks_exportCsv => '导出 CSV';

  @override
  String get networks_exportGpx => '导出 GPX';

  @override
  String get networks_clearLog => '清空记录';

  @override
  String get networks_clearLogConfirm => '删除所有已记录的网络？';

  @override
  String get networks_name => '名称';

  @override
  String get networks_invalid => '请检查设置：超出了 MeshCore 电台可接受的范围。';

  @override
  String get networks_nodesHeard => '听到的节点';

  @override
  String get chat_resendNeedsRadio => '未发送：请连接电台后重试。消息已保留。';

  @override
  String get quick_title => '快捷消息';

  @override
  String get quick_ok => '好的';

  @override
  String get quick_onMyWay => '在路上';

  @override
  String get quick_atCamp => '在营地';

  @override
  String get quick_runningLate => '会晚到';

  @override
  String get quick_needHelp => '需要帮助';

  @override
  String get quick_copyThat => '收到';

  @override
  String get quick_empty => '没有快捷消息。点按“编辑”添加。';

  @override
  String get quick_add => '新的快捷消息';

  @override
  String get quick_reset => '恢复默认';

  @override
  String get chat_stopRetrying => '停止重试';

  @override
  String chat_addFirstBanner(String name) {
    return '$name 需要先把你加为联系人，才能阅读并回复你的私信。如果对方还没有添加，请发送你的广播或分享你的联系人。';
  }

  @override
  String get map_goToMyPosition => '前往我的位置';

  @override
  String get map_positionUnavailable => '无法获取你的位置。请打开定位，或设置电台的位置。';

  @override
  String get contact_forgetAdvert => '忘记上次广播';

  @override
  String get contact_forgetAdvertHint => '如果此节点的时钟重置后广播不再更新，“忘记上次广播”可让下一条广播通过。';

  @override
  String get contact_forgetAdvertDone => '完成。此节点的下一条广播将被接受。';

  @override
  String get networks_modeQuick => '快速';

  @override
  String get networks_modeThorough => '全面';

  @override
  String get networks_modeQuickHint => '在每个网络发送一次零跳短 ping 并收听几秒，可找到范围内有中继器的网络。';

  @override
  String get networks_modeThoroughHint =>
      '只收听，每个网络听更久。不发送任何内容；只要有人发射，也能找到范围内没有中继器的网络。';

  @override
  String networks_estimate(String time) {
    return '约 $time';
  }

  @override
  String discoveredContacts_selected(int count) {
    return '已选择 $count 个';
  }

  @override
  String get discoveredContacts_selectAll => '全选';

  @override
  String get discoveredContacts_addSelected => '添加所选';

  @override
  String discoveredContacts_addAllShown(int count) {
    return '添加全部显示项（$count）';
  }

  @override
  String discoveredContacts_addManyTitle(int count) {
    return '添加 $count 个联系人？';
  }

  @override
  String discoveredContacts_roomLeft(int room) {
    return '电台还能再添加 $room 个联系人。';
  }

  @override
  String discoveredContacts_roomLimit(int room, int count) {
    return '电台只能再添加 $room 个联系人，因此 $count 个中只会添加前 $room 个。';
  }

  @override
  String discoveredContacts_adding(int done, int total) {
    return '正在添加 $done/$total…';
  }

  @override
  String discoveredContacts_addedMany(int count) {
    return '已添加联系人：$count';
  }

  @override
  String discoveredContacts_addedSome(int added, int failed) {
    return '已添加联系人：$added。未能添加：$failed。';
  }

  @override
  String get discoveredContacts_radioFull => '电台的联系人列表已满。请先删除一些联系人。';

  @override
  String get fieldIntel_radioNow => '电台现状';

  @override
  String get fieldIntel_noRadio => '连接电台以查看实时数据。';

  @override
  String get fieldIntel_noise => '噪声 dBm';

  @override
  String get fieldIntel_lastSnr => '最近 SNR';

  @override
  String get fieldIntel_lastRssi => '最近 RSSI';

  @override
  String get fieldIntel_battery => '电池 V';

  @override
  String fieldIntel_airtime(String sent, String received) {
    return '电台启动以来的发射时间：发送 $sent，接收 $received';
  }

  @override
  String get fieldIntel_whoAround => '附近有谁';

  @override
  String get fieldIntel_m15 => '15 分钟';

  @override
  String get fieldIntel_h1 => '1 小时';

  @override
  String get fieldIntel_h24 => '24 小时';

  @override
  String get fieldIntel_older => '更早';

  @override
  String get fieldIntel_lastHour => '最近一小时';

  @override
  String get fieldIntel_chartHint => '过去一天内每个节点最后被听到的时间，按小时显示。点按柱形查看是谁。';

  @override
  String get fieldIntel_mix => '节点类型';

  @override
  String get fieldIntel_reach => '覆盖范围';

  @override
  String get fieldIntel_hops1 => '1 跳';

  @override
  String get fieldIntel_hops2 => '2 跳';

  @override
  String get fieldIntel_hops3 => '3 跳以上';

  @override
  String get fieldIntel_noRoute => '暂无路由';

  @override
  String get fieldIntel_distance => '最近和最远';

  @override
  String get fieldIntel_noneLocated => '你的联系人都没有位置。';

  @override
  String get fieldIntel_noPosition => '电台还没有位置，无法计算距离。';

  @override
  String get fieldIntel_bestRepeaters => '直接听到的最佳中继器';

  @override
  String get fieldIntel_noneDirect => '过去 30 分钟内没有直接听到中继器。';

  @override
  String get fieldIntel_attention => '需要注意';

  @override
  String get fieldIntel_allGood => '没有需要注意的事项。';

  @override
  String fieldIntel_lowBattery(String volts) {
    return '电池电量低：$volts V';
  }

  @override
  String fieldIntel_quietFavorite(String ago) {
    return '收藏节点，$ago以来未听到';
  }

  @override
  String get fieldIntel_moreTools => '更多工具';

  @override
  String fieldIntel_nodeCount(int count) {
    return '节点：$count';
  }

  @override
  String get fieldIntel_none => '没有节点。';

  @override
  String fieldIntel_lastHeard(String ago) {
    return '最后听到 $ago';
  }

  @override
  String get fieldIntel_showOnMap => '在地图上显示';

  @override
  String get fieldIntel_openChat => '打开聊天';

  @override
  String get repeaterTools_login => '登录';

  @override
  String get repeaterTools_heardDirect => '直接听到';

  @override
  String get repeaterTools_filterAll => '全部';

  @override
  String get repeaterTools_filterLowBattery => '电量低';

  @override
  String get repeaterTools_hint => '点按中继器查看详情，并在那里登录以查看状态、邻居、遥测和命令行。';

  @override
  String get repeaterTools_noneMatch => '这里没有中继器。';

  @override
  String get repeaterTools_toolsTitle => '工具';

  @override
  String get repeaterTools_regionSetupHint => '查找你所在地区的区域树并复制其命令';

  @override
  String get routes_failingOnly => '仅失败的路由';

  @override
  String get routes_contactDetails => '联系人详情';
}
