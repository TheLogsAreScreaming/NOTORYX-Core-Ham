// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core Ham';

  @override
  String get nav_contacts => '連絡先';

  @override
  String get nav_channels => 'チャンネル';

  @override
  String get nav_map => '地図';

  @override
  String get nav_messages => 'メッセージ';

  @override
  String get nav_nodes => 'ノード';

  @override
  String get nav_radio => '無線機';

  @override
  String get messages_title => 'メッセージ';

  @override
  String get messages_filterAll => 'すべて';

  @override
  String get messages_filterDirect => 'ダイレクト';

  @override
  String get messages_filterChannels => 'チャンネル';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'メッセージを検索';

  @override
  String get messages_searchHint => '会話を検索';

  @override
  String get messages_closeSearch => '検索を閉じる';

  @override
  String get messages_manageChannels => 'チャンネルを管理';

  @override
  String get messages_new => '新規';

  @override
  String get messages_newDirect => 'ノードにメッセージ';

  @override
  String get messages_newChannel => 'チャンネルを追加または参加';

  @override
  String get messages_empty => 'まだ会話はありません';

  @override
  String get messages_emptyHint => 'ノードやチャンネルからのメッセージがここに表示されます。';

  @override
  String get messages_noMatches => '検索に一致する会話はありません';

  @override
  String messages_you(String text) {
    return 'あなた: $text';
  }

  @override
  String get messages_yesterday => '昨日';

  @override
  String messages_unreadCount(int count) {
    return '未読 $count 件';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return '$transport で接続中';
  }

  @override
  String get radioStatus_bluetooth => 'Bluetooth';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'Wi‑Fi (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return 'バッテリー $percent%';
  }

  @override
  String get radioStatus_openRadio => '無線機の詳細を開く';

  @override
  String get radioOverview_battery => 'バッテリー';

  @override
  String radioOverview_firmware(String version) {
    return 'ファームウェア $version';
  }

  @override
  String get radioOverview_sendAdvert => 'アドバートを送信';

  @override
  String get radioOverview_stats => '無線機の統計';

  @override
  String get accessControl_title => 'アクセス制御';

  @override
  String get accessControl_hubSubtitle => 'パスワードなしでログインできる人';

  @override
  String get accessControl_explainRepeater =>
      'このリストの人はパスワードなしでログインします。管理者は設定を変更でき、「読み取り専用」と「読み書き」は完全なテレメトリーも受け取ります。';

  @override
  String get accessControl_explainRoom =>
      'このリストの管理者はパスワードなしでログインし、ルームを管理できます。ルームのメンバーはルームのパスワードで参加します。';

  @override
  String get accessControl_roleReadOnly => '読み取り専用';

  @override
  String get accessControl_roleReadWrite => '読み書き';

  @override
  String get accessControl_roleAdmin => '管理者';

  @override
  String get accessControl_you => 'あなた';

  @override
  String get accessControl_unknownNode => '不明なノード';

  @override
  String get accessControl_add => '追加';

  @override
  String get accessControl_addTitle => 'アクセスリストに追加';

  @override
  String get accessControl_pickContact => '連絡先を選択';

  @override
  String get accessControl_noContacts =>
      '追加できる連絡先がありません。ノードはアドバートを受信するとここに表示されます。';

  @override
  String get accessControl_changeRole => 'ロールを変更';

  @override
  String get accessControl_remove => 'アクセスを削除';

  @override
  String accessControl_removeConfirm(String name) {
    return '$name をアクセスリストから削除しますか？ログインにパスワードが必要になります。';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'これはあなた自身です。自分を削除すると、このノードを再び管理するには管理者パスワードが必要になります。';

  @override
  String get accessControl_unknownKeyNote =>
      '連絡先にありません。ロールの変更には新しいノードファームウェアが必要です。削除はいつでもできます。';

  @override
  String get accessControl_prefixUnsupported =>
      'このノードのファームウェアでは、連絡先にない人のロールを変更できません。削除は可能です。';

  @override
  String get accessControl_empty => 'アクセスリストは空です';

  @override
  String get accessControl_emptyHint => '追加した人はパスワードなしでログインできます。';

  @override
  String get accessControl_loading => 'ノードにアクセスリストを問い合わせています…';

  @override
  String get accessControl_timeout => 'ノードが応答しませんでした。経路を確認して再試行してください。';

  @override
  String get accessControl_maybeIncomplete =>
      'このノードは1ページ分を送信しましたが、ファームウェアがそれ以上送れないため、一部の項目が欠けている可能性があります。';

  @override
  String get accessControl_saved => 'アクセスリストを更新しました';

  @override
  String accessControl_failed(String reply) {
    return 'ノードが変更を拒否しました: $reply';
  }

  @override
  String get companionCli_title => 'コマンドライン';

  @override
  String get companionCli_tileSubtitle => '無線機でコマンドを実行';

  @override
  String get companionCli_warning =>
      'コマンドは接続中の無線機で実行され、設定を変更したり再起動したりすることがあります。';

  @override
  String get companionCli_hint => 'コマンドを入力（例: ver）';

  @override
  String get companionCli_send => 'コマンドを実行';

  @override
  String get companionCli_noReply => '応答がありません。無線機が再起動中かもしれません。';

  @override
  String get companionCli_empty => '上のコマンドを試すか、自分で入力してください。';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle => '無線機をWi‑Fiネットワークに接続';

  @override
  String get wifi_unsupported => 'この無線機のファームウェアにはWi‑Fi機能がありません。';

  @override
  String get wifi_enabled => 'Wi‑Fiを使用';

  @override
  String get wifi_status => '状態';

  @override
  String get wifi_connected => '接続済み';

  @override
  String wifi_connectedIp(String ip) {
    return '接続済み · $ip';
  }

  @override
  String get wifi_disconnected => '未接続';

  @override
  String get wifi_network => 'ネットワーク名 (SSID)';

  @override
  String get wifi_password => 'パスワード';

  @override
  String get wifi_passwordKeep => '現在のパスワードを使う場合は空欄のままにしてください';

  @override
  String get wifi_save => '保存';

  @override
  String get wifi_forget => 'ネットワークを削除';

  @override
  String get wifi_forgetConfirm => '保存したネットワークとパスワードを無線機から削除しますか？';

  @override
  String get wifi_rebootNeeded => '保存しました。Wi‑Fiの変更を反映するには無線機を再起動してください。';

  @override
  String get wifi_rebootNow => '無線機を再起動';

  @override
  String get wifi_rebootConfirm => '今すぐ無線機を再起動しますか？アプリの接続が切れ、再接続が必要になります。';

  @override
  String get wifi_loadFailed => '無線機からWi‑Fi設定を読み取れませんでした。';

  @override
  String get wifi_retry => '再試行';

  @override
  String wifi_saveFailed(String reply) {
    return '無線機が変更を受け付けませんでした: $reply';
  }

  @override
  String get accessControl_refresh => '更新';

  @override
  String get common_cancel => 'キャンセル';

  @override
  String get common_ok => 'OK';

  @override
  String get common_connect => '接続';

  @override
  String get common_unknownDevice => '不明なデバイス';

  @override
  String get common_save => '保存';

  @override
  String get common_delete => '削除';

  @override
  String get common_deleteAll => 'すべて削除';

  @override
  String get common_close => '閉じる';

  @override
  String get common_done => '完了';

  @override
  String get common_edit => '編集';

  @override
  String get common_add => '追加';

  @override
  String get common_settings => '設定';

  @override
  String get common_disconnect => '切断';

  @override
  String get common_connected => '接続済み';

  @override
  String get common_disconnected => '切断済み';

  @override
  String get common_create => '作成';

  @override
  String get common_continue => '続行';

  @override
  String get common_share => '共有';

  @override
  String get common_copy => 'コピー';

  @override
  String get common_retry => '再試行';

  @override
  String get common_hide => '隠す';

  @override
  String get common_remove => '削除';

  @override
  String get common_enable => '有効にする';

  @override
  String get common_disable => '無効にする';

  @override
  String get common_undo => '元に戻す';

  @override
  String get messageStatus_sent => '送信';

  @override
  String get messageStatus_delivered => '配達';

  @override
  String get messageStatus_pending => '送信';

  @override
  String get messageStatus_failed => '送信できませんでした';

  @override
  String get messageStatus_repeated => '何度も聞いた';

  @override
  String get urlImage_enable => 'URL画像を有効にする';

  @override
  String get urlImage_possible => 'URL画像の可能性があります。設定で有効にしてください。';

  @override
  String get common_reboot => '再起動';

  @override
  String get common_loading => '読み込み中...';

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
  String get common_autoRefresh => '自動更新';

  @override
  String get common_interval => '間隔';

  @override
  String get scanner_title => 'NOTORYX Core Ham';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'TCP で接続';

  @override
  String get tcpHostLabel => '接続先';

  @override
  String get tcpHostHint => '192.168.40.10 / example.com';

  @override
  String get tcpPortLabel => 'ポート';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => '接続先を入力して接続してください';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return '$endpoint への接続中...';
  }

  @override
  String get tcpErrorHostRequired => '接続先は必須です。';

  @override
  String get tcpErrorPortInvalid => 'ポート番号は1から65535の範囲で指定してください。';

  @override
  String get tcpErrorUnsupported => 'このプラットフォームでは、TCP 転送はサポートされていません。';

  @override
  String get tcpErrorTimedOut => 'TCP 接続がタイムアウトしました。';

  @override
  String tcpConnectionFailed(String error) {
    return 'TCP接続に失敗しました：$error';
  }

  @override
  String get usbScreenTitle => 'USB経由で接続';

  @override
  String get usbScreenSubtitle => '検出されたシリアルデバイスを選択して、MeshCore ノードに直接接続します。';

  @override
  String get usbScreenStatus => 'USB デバイスを選択してください';

  @override
  String get usbScreenNote =>
      'USB シリアルは、対応する Android デバイスとデスクトップ プラットフォームで利用できます。';

  @override
  String get usbScreenEmptyState => 'USB デバイスが見つかりません。接続してから再度更新してください。';

  @override
  String get usbErrorPermissionDenied => 'USBへのアクセス許可が拒否されました。';

  @override
  String get usbErrorDeviceMissing => '選択されたUSBデバイスは、もう利用できません。';

  @override
  String get usbErrorInvalidPort => '有効なUSBデバイスを選択してください。';

  @override
  String get usbErrorBusy => '別の USB 接続要求がすでに進行中です。';

  @override
  String get usbErrorNotConnected => 'USBデバイスは接続されていません。';

  @override
  String get usbErrorOpenFailed => '選択したUSBデバイスを開くことができません。';

  @override
  String get usbErrorConnectFailed => '選択したUSBデバイスへの接続に失敗しました。';

  @override
  String get usbErrorUnsupported => 'このプラットフォームでは、USBシリアル通信はサポートされていません。';

  @override
  String get usbErrorAlreadyActive => 'USB 接続はすでにアクティブです。';

  @override
  String get usbErrorNoDeviceSelected => 'USBデバイスは選択されていません。';

  @override
  String get usbErrorPortClosed => 'USB 接続は開かれていません。';

  @override
  String get usbErrorConnectTimedOut =>
      '接続がタイムアウトしました。デバイスにUSBコンパニオンファームウェアがインストールされていることを確認してください。';

  @override
  String get usbFallbackDeviceName => 'ウェブシリアルデバイス';

  @override
  String get usbStatus_notConnected => 'USB デバイスを選択してください';

  @override
  String get usbStatus_connecting => 'USBデバイスへの接続中...';

  @override
  String get usbStatus_searching => 'USBデバイスを検索中...';

  @override
  String usbConnectionFailed(String error) {
    return 'USB接続に失敗しました：$error';
  }

  @override
  String get scanner_scanning => 'デバイスをスキャン中...';

  @override
  String get scanner_connecting => '接続中...';

  @override
  String get scanner_disconnecting => '切断...';

  @override
  String get scanner_notConnected => '接続されていない';

  @override
  String scanner_connectedTo(String deviceName) {
    return '$deviceName に接続済み';
  }

  @override
  String get scanner_searchingDevices => 'MeshCore デバイスを検索中...';

  @override
  String get scanner_tapToScan => 'MeshCore デバイスを見つけるには、「スキャン」をタップしてください。';

  @override
  String scanner_connectionFailed(String error) {
    return '接続に失敗しました：$error';
  }

  @override
  String get scanner_stop => '停止';

  @override
  String get scanner_scan => 'スキャン';

  @override
  String get scanner_bluetoothOff => 'Bluetooth はオフです';

  @override
  String get scanner_bluetoothOffMessage => 'Bluetooth を有効にしてデバイスを検索してください。';

  @override
  String get scanner_chromeRequired => 'Chrome ブラウザが必須です';

  @override
  String get scanner_chromeRequiredMessage =>
      'このWebアプリケーションは、Bluetooth機能を利用するために、Google ChromeまたはChromiumベースのブラウザが必要です。';

  @override
  String get scanner_enableBluetooth => 'Bluetooth を有効にする';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'ブラウザでは Bluetooth は利用できません。代わりに USB で接続してください。';

  @override
  String get device_quickSwitch => 'クイックスイッチ';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => '設定';

  @override
  String get settings_deviceInfo => 'デバイス情報';

  @override
  String get settings_appSettings => 'アプリ設定';

  @override
  String get settings_appSettingsSubtitle => '通知、メッセージング、および地図の表示設定';

  @override
  String get settings_nodeSettings => 'ノード設定';

  @override
  String get settings_nodeName => 'ノード名';

  @override
  String get settings_nodeNameNotSet => '設定されていない';

  @override
  String get settings_nodeNameHint => 'ノード名を入力してください';

  @override
  String get settings_nodeNameUpdated => '名前を更新しました';

  @override
  String get settings_radioSettings => 'ラジオ設定';

  @override
  String get settings_radioSettingsSubtitle => '周波数、電力、スプレッドファクター';

  @override
  String get settings_radioSettingsUpdated => 'ラジオの設定が更新されました';

  @override
  String get settings_regionSettings => '地域';

  @override
  String get settings_regionSettingsSubtitle => '保存された領域の管理';

  @override
  String get settings_corridorRegion => 'コリドー地域';

  @override
  String get settings_corridorRegionDefault => '#corridor（デフォルト）';

  @override
  String get settings_corridorRegionHelp =>
      'フラッドコリドーのパケットにはこの地域がタグ付けされます。コリドー対応ファームウェアのないリピーターは、この地域を許可している場合にのみ転送します。空欄にするとデフォルトのタグ #corridor を使います。';

  @override
  String get settings_corridorRegionHint => '地域名';

  @override
  String get settings_corridorRegionUseDefault => 'デフォルトを使用';

  @override
  String get settings_corridorRegionUpdated => 'コリドー地域を更新しました';

  @override
  String get settings_corridorRegionFailed => 'コリドー地域を更新できませんでした';

  @override
  String get settings_regionManagement_screenTitle => '地域管理';

  @override
  String get settings_regionNameHint => '地域名を入力してください';

  @override
  String get settings_regionAddRegion => '地域を追加';

  @override
  String get settings_regionFetchRegions => 'リピーターからのフェッチ地域';

  @override
  String get settings_regionFetchRegionsFail => '地域は見つかりませんでした';

  @override
  String get settings_regionFetchRegionsAlreadyExists => 'この地域はすでに追加されています。';

  @override
  String get settings_regionName => '地域名';

  @override
  String get settings_regionDeleted => '地域が削除されました';

  @override
  String get settings_deleteRegion => '地域を削除';

  @override
  String settings_deleteRegionConfirm(String region) {
    return '$region を地域リストから削除しますか？';
  }

  @override
  String get settings_location => '場所';

  @override
  String get settings_locationSubtitle => 'GPS 座標';

  @override
  String get settings_locationUpdated => '場所とGPS設定が更新されました';

  @override
  String get settings_locationBothRequired => '緯度と経度をそれぞれ入力してください。';

  @override
  String get settings_locationInvalid => '無効な緯度または経度。';

  @override
  String get settings_locationGPSEnable => 'GPS を有効にする';

  @override
  String get settings_locationGPSEnableSubtitle => 'GPS が自動的に位置情報を更新できるようにします。';

  @override
  String get settings_locationIntervalSec => 'GPS 更新間隔（秒）';

  @override
  String get settings_locationIntervalInvalid =>
      '間隔は少なくとも60秒で、86400秒未満でなければなりません。';

  @override
  String get settings_latitude => '緯度';

  @override
  String get settings_longitude => '経度';

  @override
  String get settings_contactSettings => '連絡先設定';

  @override
  String get settings_contactSettingsSubtitle => '連絡先の追加方法に関する設定';

  @override
  String get settings_privacyMode => 'プライバシーモード';

  @override
  String get settings_privacyModeSubtitle => '広告に名前や位置を表示しない';

  @override
  String get settings_privacyModeToggle =>
      'プライバシーモードを有効にすると、広告に表示される名前と位置を非表示にします。';

  @override
  String get settings_privacyModeEnabled => 'プライバシーモードが有効になっています';

  @override
  String get settings_privacyModeDisabled => 'プライバシーモードは無効です';

  @override
  String get settings_privacy => 'プライバシー設定';

  @override
  String get settings_privacySubtitle => '共有する情報の内容を管理する。';

  @override
  String get settings_privacySettingsDescription =>
      '自分のデバイスが他の人に共有する情報を選択してください。';

  @override
  String get settings_denyAll => 'すべてを否定';

  @override
  String get settings_allowByContact => '連絡先を明示するオプション';

  @override
  String get settings_allowAll => 'すべて許可';

  @override
  String get settings_telemetryBaseMode => 'テレメトリ基本モード';

  @override
  String get settings_telemetryLocationMode => 'テレメトリ位置特定モード';

  @override
  String get settings_telemetryEnvironmentMode => 'テレメトリ環境モード';

  @override
  String get settings_advertLocation => '広告掲載場所';

  @override
  String get settings_advertLocationSubtitle => '広告に場所を記載してください。';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate => 'GPS更新時にゼロホップ広告を自動送信';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'GPS位置が変化したときにゼロホップ広告を送信します（広告への位置情報の含有が必要）。';

  @override
  String get settings_multiAck => 'マルチ ACK';

  @override
  String get settings_telemetryModeUpdated => 'テレメトリモードが更新されました';

  @override
  String get settings_actions => '操作';

  @override
  String get settings_deleteAllPaths => 'すべての経路を削除';

  @override
  String get settings_deleteAllPathsSubtitle => '連絡先からすべての経路データを消去します。';

  @override
  String get settings_sendAdvertisement => '広告を送信';

  @override
  String get settings_sendAdvertisementSubtitle => '現在の存在を送信します';

  @override
  String get settings_advertisementSent => '広告を送信しました';

  @override
  String get settings_syncTime => '時刻を同期';

  @override
  String get settings_syncTimeSubtitle => 'デバイスの時刻をスマートフォンに合わせます';

  @override
  String get settings_timeSynchronized => '時刻を同期しました';

  @override
  String get settings_refreshContacts => '連絡先を更新';

  @override
  String get settings_refreshContactsSubtitle => 'デバイスから連絡先リストを再読み込みします';

  @override
  String get settings_rebootDevice => 'デバイスを再起動';

  @override
  String get settings_rebootDeviceSubtitle => 'MeshCore デバイスを再起動します';

  @override
  String get settings_rebootDeviceConfirm =>
      '本当にデバイスを再起動したいですか？ その場合、接続が切断されます。';

  @override
  String get settings_debug => 'デバッグ';

  @override
  String get settings_companionDebugLog => '同伴デバッグログ';

  @override
  String get settings_companionDebugLogSubtitle =>
      'BLE/TCP/USB 関連のコマンド、応答、および生のデータ';

  @override
  String get settings_appDebugLog => 'アプリのデバッグログ';

  @override
  String get settings_appDebugLogSubtitle => 'アプリケーションのデバッグメッセージ';

  @override
  String get settings_about => '概要';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core Ham v$version';
  }

  @override
  String get settings_aboutLegalese => '2026 MeshCore オープンソースプロジェクト';

  @override
  String get settings_aboutDescription =>
      'MeshCore LoRa メッシュネットワークデバイス向けのオープンソース Flutter クライアント。';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'LOS 標高データ：Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => '名前';

  @override
  String get settings_infoId => 'ID';

  @override
  String get settings_infoStatus => 'ステータス';

  @override
  String get settings_infoBattery => 'バッテリー';

  @override
  String get settings_infoPublicKey => '公開鍵';

  @override
  String get settings_infoContactsCount => '連絡先数';

  @override
  String get settings_infoChannelCount => 'チャンネル数';

  @override
  String get settings_infoHardware => 'ハードウェア';

  @override
  String get settings_infoFirmware => 'ファームウェア';

  @override
  String get settings_presets => 'プリセット';

  @override
  String get settings_frequency => '周波数 (MHz)';

  @override
  String get settings_frequencyHelper => '420–450 / 902–928';

  @override
  String get settings_frequencyInvalid => '無効な周波数 (420–450 / 902–928 MHz)';

  @override
  String get settings_bandwidth => '帯域幅';

  @override
  String get settings_spreadingFactor => '伝播係数';

  @override
  String get settings_codingRate => 'コーディング速度';

  @override
  String get settings_txPower => 'TX 信号電力 (dBm)';

  @override
  String get settings_txPowerHelper => '0 - 22';

  @override
  String get settings_txPowerInvalid => '無効な送信電力 (0-22 dBm)';

  @override
  String get settings_clientRepeat => 'オフグリッド中継';

  @override
  String get settings_clientRepeatSubtitle =>
      'このデバイスが他のデバイス向けにメッシュパケットを中継できるようにします。';

  @override
  String get settings_clientRepeatFreqWarning =>
      'オフグリッド中継には 433、869、または 918 MHz の周波数が必要です。';

  @override
  String settings_error(String message) {
    return 'エラー: $message';
  }

  @override
  String get appSettings_title => 'アプリ設定';

  @override
  String get appSettings_appearance => '外観';

  @override
  String get appSettings_theme => 'テーマ';

  @override
  String get appSettings_themeSystem => 'システム設定';

  @override
  String get appSettings_themeLight => 'ライト';

  @override
  String get appSettings_themeDark => 'ダーク';

  @override
  String get appSettings_language => '言語';

  @override
  String get appSettings_languageSystem => 'システム設定';

  @override
  String get appSettings_languageEn => '英語';

  @override
  String get appSettings_languageFr => 'フランス語';

  @override
  String get appSettings_languageEs => 'スペイン語';

  @override
  String get appSettings_languageDe => 'ドイツ語';

  @override
  String get appSettings_languagePl => 'ポーランド語';

  @override
  String get appSettings_languageSl => 'スロベニア語';

  @override
  String get appSettings_languagePt => 'ポルトガル語';

  @override
  String get appSettings_languageIt => 'イタリア語';

  @override
  String get appSettings_languageZh => '中国語';

  @override
  String get appSettings_languageSv => 'スウェーデン語';

  @override
  String get appSettings_languageNl => 'オランダ語';

  @override
  String get appSettings_languageSk => 'スロベニア語';

  @override
  String get appSettings_languageBg => 'ブルガリア語';

  @override
  String get appSettings_languageRu => 'ロシア語';

  @override
  String get appSettings_languageUk => 'ウクライナ語';

  @override
  String get repeater_pathHashModeOption0 => '0 - 1バイト';

  @override
  String get repeater_pathHashModeOption1 => '1〜2バイト';

  @override
  String get repeater_pathHashModeOption2 => '2〜3バイト';

  @override
  String get repeater_pathHashModeOption3 => '3〜4バイト';

  @override
  String get appSettings_enableMessageTracing => 'メッセージ追跡を有効にする';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'メッセージの詳細な経路とタイミングのメタデータを表示します';

  @override
  String get appSettings_notifications => '通知';

  @override
  String get appSettings_enableNotifications => '通知を有効にする';

  @override
  String get appSettings_enableNotificationsSubtitle => 'メッセージや広告の通知を受け取ります';

  @override
  String get appSettings_notificationPermissionDenied => '通知の許可が拒否されました';

  @override
  String get appSettings_notificationsEnabled => '通知機能が有効になっています';

  @override
  String get appSettings_notificationsDisabled => '通知が無効化されています';

  @override
  String get appSettings_messageNotifications => 'メッセージ通知';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      '新しいメッセージを受信した際に、通知を表示する';

  @override
  String get appSettings_channelMessageNotifications => 'チャネルメッセージの通知';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'チャンネルからのメッセージを受信した際に、通知を表示する';

  @override
  String get appSettings_advertisementNotifications => '広告通知';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      '新しいノードが発見された場合に通知を表示する';

  @override
  String get appSettings_messaging => 'メッセージング';

  @override
  String get appSettings_clearPathOnMaxRetry => '最大再試行時に経路を消去';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      '5 回送信に失敗したら連絡先の経路をリセットします';

  @override
  String get appSettings_pathsWillBeCleared => '5 回失敗すると経路を消去します';

  @override
  String get appSettings_pathsWillNotBeCleared => '経路は自動では消去されません';

  @override
  String get appSettings_autoRouteRotation => '自動経路切り替え';

  @override
  String get appSettings_autoRouteRotationSubtitle => '最適な経路とフラッドモードを切り替えます';

  @override
  String get appSettings_autoRouteRotationEnabled => '自動経路切り替えが有効です';

  @override
  String get appSettings_autoRouteRotationDisabled => '自動経路切り替えは無効です';

  @override
  String get appSettings_maxRouteWeight => '最大経路重み';

  @override
  String get appSettings_maxRouteWeightSubtitle => '成功配送によって経路に蓄積できる最大重み';

  @override
  String get appSettings_initialRouteWeight => '初期経路重み';

  @override
  String get appSettings_initialRouteWeightSubtitle => '新しく発見された経路の初期重み';

  @override
  String get appSettings_routeWeightSuccessIncrement => '成功時の重み増加';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      '成功配送後に経路へ加算する重み';

  @override
  String get appSettings_routeWeightFailureDecrement => '失敗時の重み減少';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      '失敗配送後に経路から差し引く重み';

  @override
  String get appSettings_maxMessageRetries => '最大メッセージ再試行回数';

  @override
  String get appSettings_maxMessageRetriesSubtitle => 'メッセージを失敗として扱うまでの再試行回数';

  @override
  String get appSettings_battery => 'バッテリー';

  @override
  String get appSettings_batteryChemistry => 'バッテリー種別';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return '$deviceName ごとに設定';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst => '選択するにはデバイスに接続してください';

  @override
  String get appSettings_batteryNmc => '18650型 NMC (3.0-4.2V)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2.6-3.65V)';

  @override
  String get appSettings_batteryLipo => 'LiPo (3.0-4.2V)';

  @override
  String get appSettings_batteryLipoHv => 'リポバッテリー HV（3.0〜4.35V）';

  @override
  String get appSettings_mapDisplay => '地図表示';

  @override
  String get appSettings_showRepeaters => 'リピータを表示';

  @override
  String get appSettings_showRepeatersSubtitle => '地図上にリピータノードを表示する';

  @override
  String get appSettings_showChatNodes => 'チャットノードを表示';

  @override
  String get appSettings_showChatNodesSubtitle => '地図上にチャットノードを表示する';

  @override
  String get appSettings_showOtherNodes => 'その他のノードを表示';

  @override
  String get appSettings_showOtherNodesSubtitle => '地図上に、他のノードの種類を表示する';

  @override
  String get appSettings_timeFilter => '時間フィルター';

  @override
  String get appSettings_timeFilterShowAll => 'すべてのノードを表示';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return '過去 $hours 時間以内に発見されたノードを表示';
  }

  @override
  String get appSettings_mapTimeFilter => '地図の時間フィルター';

  @override
  String get appSettings_showNodesDiscoveredWithin => '次の期間内に発見されたノードを表示:';

  @override
  String get appSettings_allTime => '全期間';

  @override
  String get appSettings_lastHour => '過去1時間';

  @override
  String get appSettings_last6Hours => '過去6時間';

  @override
  String get appSettings_last24Hours => '過去24時間';

  @override
  String get appSettings_lastWeek => '過去1週間';

  @override
  String get appSettings_rasterTileSource => 'ラスタタイルのソース';

  @override
  String get appSettings_stadiaEndpoint => 'Stadia エンドポイント';

  @override
  String get appSettings_stadiaApiKey => 'Stadia API キー';

  @override
  String get appSettings_stadiaApiKeyRequired => 'Stadia Maps の利用に必要です';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return '設定済み: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Stadia Maps の API キーを入力してください。このアプリはラスタタイルの取得に使用します。';

  @override
  String get appSettings_offlineMapCache => 'オフライン地図キャッシュ';

  @override
  String get appSettings_unitsTitle => '単位';

  @override
  String get appSettings_unitsMetric => 'メートル法 (m / km / °C)';

  @override
  String get appSettings_unitsImperial => 'ヤード・ポンド法 (ft / mi / °F)';

  @override
  String get appSettings_noAreaSelected => 'エリアが選択されていません';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'エリア選択中（ズーム $minZoom-$maxZoom）';
  }

  @override
  String get appSettings_debugCard => 'デバッグ';

  @override
  String get appSettings_appDebugLogging => 'アプリのデバッグログ';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'トラブルシューティング用にアプリのデバッグメッセージを記録します';

  @override
  String get appSettings_appDebugLoggingEnabled => 'アプリのデバッグログは有効です';

  @override
  String get appSettings_appDebugLoggingDisabled => 'アプリのデバッグログは無効です';

  @override
  String get contacts_title => '連絡先';

  @override
  String get contacts_noContacts => 'まだ連絡先はありません';

  @override
  String get contacts_contactsWillAppear => 'デバイスが広告を送信すると連絡先が表示されます';

  @override
  String get contacts_unread => '未読';

  @override
  String get contacts_searchContactsNoNumber => '連絡先を検索...';

  @override
  String contacts_searchContacts(int number, String str) {
    return '連絡先を検索... $number 件の $str';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'お気に入りを検索... $number 件の $str';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'ユーザーを検索... $number 件の $str';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'リピータを検索... $number 件の $str';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'ルームサーバーを検索... $number 件の $str';
  }

  @override
  String get contacts_noUnreadContacts => '未読の連絡先はありません';

  @override
  String get contacts_noContactsFound => '連絡先またはグループは見つかりませんでした。';

  @override
  String get contacts_deleteContact => '連絡先を削除';

  @override
  String contacts_removeConfirm(String contactName) {
    return '$contactName を連絡先から削除しますか？';
  }

  @override
  String get contacts_manageRepeater => 'リピータの管理';

  @override
  String get contacts_manageRoom => 'ルームサーバーを管理';

  @override
  String get contacts_roomLogin => 'ルームサーバーログイン';

  @override
  String get contacts_openChat => 'チャットを開く';

  @override
  String get contacts_editGroup => 'グループを編集';

  @override
  String get contacts_deleteGroup => 'グループを削除';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return '$groupName を削除しますか？';
  }

  @override
  String get contacts_newGroup => '新しいグループ';

  @override
  String get contacts_moreOptions => 'さらに多くの選択肢';

  @override
  String get contacts_searchOpen => '連絡先を検索する';

  @override
  String get contacts_searchClose => '検索を終了';

  @override
  String get contacts_groupName => 'グループ名';

  @override
  String get contacts_groupNameRequired => 'グループ名が必須です';

  @override
  String get contacts_groupNameReserved => 'このグループ名は予約済みです';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'グループ「$name」はすでに存在します';
  }

  @override
  String get contacts_filterContacts => '連絡先をフィルタ...';

  @override
  String get contacts_noContactsMatchFilter => '条件に一致する連絡先はありません';

  @override
  String get contacts_noMembers => 'メンバーなし';

  @override
  String get contacts_lastSeenNow => '最近';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return '約 $minutes 分前';
  }

  @override
  String get contacts_lastSeenHourAgo => '約 1 時間前';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return '約 $hours 時間前';
  }

  @override
  String get contacts_lastSeenDayAgo => '約 1 日前';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return '約 $days 日前';
  }

  @override
  String get contact_info => '連絡先';

  @override
  String get contact_settings => '連絡設定';

  @override
  String get contact_telemetry => 'テレメトリー';

  @override
  String get contact_lastSeen => '最後に確認された場所';

  @override
  String get contact_clearChat => 'チャットのクリア';

  @override
  String get contact_teleBase => 'テレメトリ基地';

  @override
  String get contact_teleBaseSubtitle => 'バッテリー残量と基本的なテレメトリーの共有を許可する';

  @override
  String get contact_teleLoc => 'テレメトリの場所';

  @override
  String get contact_teleLocSubtitle => '位置情報共有を許可する';

  @override
  String get contact_teleEnv => 'テレメトリ環境';

  @override
  String get contact_teleEnvSubtitle => '環境センサーのデータを共有することを許可する';

  @override
  String get channels_title => 'チャンネル';

  @override
  String get channels_noChannelsConfigured => '設定されたチャンネルがありません';

  @override
  String get channels_addPublicChannel => '公開チャンネルを追加';

  @override
  String get channels_searchChannels => 'チャンネルを検索...';

  @override
  String get channels_noChannelsFound => 'チャンネルが見つかりませんでした';

  @override
  String channels_channelIndex(int index) {
    return 'チャンネル $index';
  }

  @override
  String get channels_public => '公開';

  @override
  String channels_via(String path) {
    return '経由: $path';
  }

  @override
  String get channels_viaMqtt => 'MQTT経由';

  @override
  String get channels_viaMqttSemantics => 'MQTT経由で受信、無線機では受信していません';

  @override
  String get channels_private => 'キー付き';

  @override
  String get channels_editChannel => 'チャンネルを編集';

  @override
  String get channels_muteChannel => 'チャンネルをミュート';

  @override
  String get channels_unmuteChannel => 'チャンネルのミュートを解除';

  @override
  String get channels_deleteChannel => 'チャンネルを削除';

  @override
  String channels_deleteChannelConfirm(String name) {
    return '$name を削除しますか？ これは取り消すことができません。';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'チャンネル「$name」の削除に失敗しました。';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'チャンネル「$name」が削除されました';
  }

  @override
  String get channels_addChannel => 'チャンネルを追加';

  @override
  String get channels_channelIndexLabel => 'チャンネルインデックス';

  @override
  String get channels_channelName => 'チャンネル名';

  @override
  String get channels_usePublicChannel => 'パブリックチャンネルを使用する';

  @override
  String get channels_standardPublicPsk => '公開用の標準 PSK';

  @override
  String get channels_pskHex => 'PSK（16 進数）';

  @override
  String get channels_generateRandomPsk => 'ランダムな PSK を生成';

  @override
  String get channels_enterChannelName => 'チャンネル名を入力してください';

  @override
  String get channels_pskMustBe32Hex => 'PSKは32桁の16進数で構成されている必要があります。';

  @override
  String channels_channelAdded(String name) {
    return 'チャンネル「$name」を追加しました';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'チャンネル $index の編集';
  }

  @override
  String get channels_smazCompression => 'SMAZ 圧縮';

  @override
  String get channels_cyr2latCompression => 'Cyr2Lat 圧縮';

  @override
  String get channels_cyr2latCompressionDscr => '送信時に一部のキリル文字をラテン文字に置き換えます。';

  @override
  String get channels_cyr2latSettingsHeading => 'Cyr2Lat 設定';

  @override
  String get channels_cyr2latSettingsSubheading => '置換リスト';

  @override
  String get channels_cyr2latSettingsDscr => '文字置換の JSON 設定を編集します';

  @override
  String get channels_cyr2latSettingsDialogHint => 'JSON 置換マップ';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return '無効な JSON: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'チャンネル「$name」が更新されました';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Cyr2Lat プロファイルを追加';

  @override
  String get settings_cyr2latProfileName => 'プロファイル名';

  @override
  String get settings_cyr2latProfileNameEmpty => 'プロファイル名は空にできません';

  @override
  String get settings_cyr2latProfileAdded => 'プロファイルを追加しました';

  @override
  String get settings_cyr2latProfileUpdated => 'プロファイルを更新しました';

  @override
  String get settings_cyr2latProfileEdit => 'Cyr2Lat プロファイルを編集';

  @override
  String get settings_cyr2latProfileDelete => 'Cyr2Lat プロファイルを削除';

  @override
  String get settings_cyr2latProfileDeleted => 'プロファイルを削除しました';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return 'プロファイル「$name」を削除しますか？';
  }

  @override
  String get channels_publicChannelAdded => '公開チャンネルを追加しました';

  @override
  String get channels_sortBy => '並び替え';

  @override
  String get channels_sortManual => '手動';

  @override
  String get channels_sortAZ => 'AからZ';

  @override
  String get channels_sortLatestMessages => '最新のメッセージ';

  @override
  String get channels_sortUnread => '未読';

  @override
  String get channels_createPrivateChannel => 'キー付きチャンネルを作成';

  @override
  String get channels_createPrivateChannelDesc =>
      '共有キーでチャンネルを選びます。メッセージは引き続き誰でも読めます。';

  @override
  String get channels_joinPrivateChannel => 'キー付きチャンネルに参加';

  @override
  String get channels_joinPrivateChannelDesc => 'チャンネルの共有キーを入力してください。';

  @override
  String get channels_joinPublicChannel => '公開チャンネルに参加する';

  @override
  String get channels_joinPublicChannelDesc => '誰でもこのチャンネルに参加できます。';

  @override
  String get channels_joinHashtagChannel => 'ハッシュタグチャンネルに参加する';

  @override
  String get channels_joinHashtagChannelDesc => '誰でもハッシュタグチャンネルに参加できます。';

  @override
  String get channels_scanQrCode => 'QRコードをスキャンする';

  @override
  String get channels_scanQrCodeComingSoon => '近日公開';

  @override
  String get channels_enterHashtag => 'ハッシュタグを入力してください';

  @override
  String get channels_hashtagHint => '例：#チーム';

  @override
  String channels_regionSetTo(String region) {
    return '地域：$region';
  }

  @override
  String get channels_regionNotSet => '地域：なし';

  @override
  String get channels_regionSelect_Title => '地域を選択する';

  @override
  String get channels_clearRegion => 'クリアな地域';

  @override
  String get chat_noMessages => 'まだメッセージは届いていません';

  @override
  String get chat_sendMessage => 'メッセージを送信する';

  @override
  String chat_sendMessageTo(String contactName) {
    return '$contactName へのメッセージを送信する';
  }

  @override
  String get chat_sendMessageToStart => '開始するためにメッセージを送信してください';

  @override
  String get chat_originalMessageNotFound => '元のメッセージが見つかりませんでした';

  @override
  String chat_replyingTo(String name) {
    return '$name への返信';
  }

  @override
  String chat_replyTo(String name) {
    return '$nameへの返信';
  }

  @override
  String get chat_location => '場所';

  @override
  String get chat_typeMessage => 'メッセージを入力してください…';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'メッセージが長すぎます（$maxBytes バイトを超えています）';
  }

  @override
  String get chat_messageCopied => 'メッセージがコピーされました';

  @override
  String get chat_messageDeleted => 'メッセージは削除されました';

  @override
  String get chat_retryingMessage => 'メッセージを再試行中';

  @override
  String chat_retryCount(int current, int max) {
    return '$current/$max 回目';
  }

  @override
  String get chat_selectSendAction => '送信アクションを選択';

  @override
  String get chat_jumpToLatest => '最新のメッセージへ移動';

  @override
  String get chat_sendGif => 'GIF を送信';

  @override
  String get chat_limitToArea => 'エリアを限定';

  @override
  String get chat_limitToAreaTitle => '送信範囲を限定…';

  @override
  String get chat_limitToAreaHelp =>
      'フラッドコリドー対応ファームウェアのリピーターは、このエリア内でのみメッセージを中継します。他のリピーターは、あなたのコリドー地域を許可していない限り破棄します。';

  @override
  String chat_limitToAreaRadius(int km) {
    return '半径${km}km';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return '半径${km}km以内のみ';
  }

  @override
  String get chat_limitToAreaOff => '制限なし';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'メッセージをエリアに限定するには、無線機の位置を設定してください。';

  @override
  String get chat_sendImageLora => 'MeshCore経由で画像を送信';

  @override
  String get chat_imagePickFailed => 'その画像を開けませんでした';

  @override
  String get chat_receivedGif => 'GIFを受け取りました';

  @override
  String get chat_reply => '返信';

  @override
  String get chat_addReaction => 'リアクションを追加';

  @override
  String get chat_me => '私';

  @override
  String get reaction_report => '絵文字リアクション';

  @override
  String get emojiCategorySmileys => '顔文字';

  @override
  String get emojiCategoryGestures => 'ジェスチャー';

  @override
  String get emojiCategoryHearts => 'ハート';

  @override
  String get emojiCategoryObjects => '物';

  @override
  String get gifPicker_title => 'GIF を選択';

  @override
  String get gifPicker_searchHint => 'GIF を検索...';

  @override
  String get gifPicker_poweredBy => 'GIPHY 提供';

  @override
  String get gifPicker_noGifsFound => 'GIF が見つかりませんでした';

  @override
  String get gifPicker_failedLoad => 'GIF の読み込みに失敗しました';

  @override
  String get gifPicker_failedSearch => 'GIF の検索に失敗しました';

  @override
  String get gifPicker_noInternet => 'インターネット接続がありません';

  @override
  String get debugLog_appTitle => 'アプリのデバッグログ';

  @override
  String get debugLog_bleTitle => 'BLE デバッグログ';

  @override
  String get debugLog_copyLog => 'ログをコピー';

  @override
  String get debugLog_clearLog => 'ログをクリア';

  @override
  String get debugLog_copied => 'デバッグログをコピーしました';

  @override
  String get debugLog_bleCopied => 'BLE ログをコピーしました';

  @override
  String get debugLog_noEntries => 'まだデバッグログはありません';

  @override
  String get debugLog_enableInSettings => '設定でアプリのデバッグログを有効にしてください';

  @override
  String get debugLog_frames => 'フレーム';

  @override
  String get debugLog_rawLogRx => '生の Log-RX';

  @override
  String get debugLog_noBleActivity => 'まだ BLE アクティビティはありません';

  @override
  String debugFrame_length(int count) {
    return 'フレーム長: $count バイト';
  }

  @override
  String debugFrame_command(String value) {
    return 'コマンド: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'テキストメッセージフレーム:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- 宛先公開鍵: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- タイムスタンプ: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- フラグ: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- テキストの種類: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'CLI';

  @override
  String get debugFrame_textTypePlain => 'プレーン';

  @override
  String debugFrame_text(String text) {
    return '- テキスト: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => '16 進ダンプ:';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ホップ',
      one: 'ホップ',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => '経路を削除';

  @override
  String get chat_noPathHistoryYet => 'まだ経路履歴はありません。\n経路を見つけるにはメッセージを送信してください。';

  @override
  String get chat_pathCleared => '経路をクリアしました。次のメッセージで再探索します。';

  @override
  String get chat_fullPath => '完全な経路';

  @override
  String get routing_title => '経路設定';

  @override
  String get routing_modeAuto => '自動';

  @override
  String get routing_modeFlood => 'フラッド';

  @override
  String get routing_modeManual => '手動';

  @override
  String get routing_modeAutoHint => '既知の最良経路を自動で選び、経路がないときはフラッドします。';

  @override
  String get routing_modeFloodHint =>
      'すべてのリピータを通じてブロードキャストします。最も信頼性は高いですが、空中時間を多く使います。';

  @override
  String get routing_modeManualHint => '常に、設定した正確な経路を使います。';

  @override
  String get routing_currentRoute => '現在の経路';

  @override
  String get routing_directNoHops => '直接 - 中継ホップなし';

  @override
  String get routing_noPathYet => 'まだ経路はありません。次のメッセージは経路が見つかるまでフラッドされます。';

  @override
  String get routePick_open => '経路ビューと選択';

  @override
  String get routePick_openHint => '各ホップのリンク品質を表示し、より確実な経路を選択';

  @override
  String routePick_title(String name) {
    return '$name への経路';
  }

  @override
  String get routePick_current => '現在の経路';

  @override
  String get routePick_flooding => '固定経路なし: 経路を学習するまでメッセージはメッシュ全体にフラッドされます。';

  @override
  String get routePick_direct => '直接';

  @override
  String routePick_hopUnknown(String id) {
    return 'リピーター $id';
  }

  @override
  String get routePick_notMeasured => '未測定';

  @override
  String get routePick_measure => 'この経路を測定';

  @override
  String get routePick_measuring => 'トレース中…';

  @override
  String get routePick_measured => '測定しました。';

  @override
  String get routePick_noAnswer => 'トレースに応答がありません。経路上のリピーターが圏外かもしれません。';

  @override
  String get routePick_floodDone => '経路を消去しました。次のメッセージはフラッドして新しい経路を探します。';

  @override
  String get routePick_suggested => 'おすすめ';

  @override
  String routePick_suggestBody(String route, int score) {
    return 'より確実な経路: $route（スコア $score）';
  }

  @override
  String get routePick_use => '使用';

  @override
  String routePick_useLabel(String route) {
    return '経路 $route を使用';
  }

  @override
  String get routePick_options => '選べる経路';

  @override
  String get routePick_optionsHint =>
      'この連絡先で聞こえたすべての経路を、リンク信号・配信実績・長さ・新しさから0〜100で採点。';

  @override
  String get routePick_none => 'まだ経路がありません。メッセージを送って探してください。';

  @override
  String get routePick_other => 'その他';

  @override
  String get routePick_build => '経路を作成';

  @override
  String get routePick_flood => 'メッシュに経路を探させる';

  @override
  String get routePick_explainer =>
      '測定では経路に沿って往復のトレースを送り、リピーター間の各リンクを双方向で測ります。連絡先までの最後のリンクはトレースできません。結果は30日間保存され、同じリンクを使うすべての経路に反映されます。';

  @override
  String routePick_score(int score) {
    return 'スコア $score/100';
  }

  @override
  String routePick_hopLabel(
    int number,
    String name,
    String quality,
    String out,
    String back,
  ) {
    return 'ホップ $number: $name。リンク $quality、往路 $out デシベル、復路 $back デシベル。';
  }

  @override
  String get routePick_lastLink => '連絡先への最後のリンク: トレースでは測定不可';

  @override
  String routePick_linkLine(String out, String back) {
    return '往路 $out dB · 復路 $back dB';
  }

  @override
  String routePick_optionLine(int score, int hops) {
    return 'スコア $score · ホップ数: $hops';
  }

  @override
  String routePick_record(int ok, int tries) {
    return '$tries 件中 $ok 件配信';
  }

  @override
  String routePick_weakest(String snr) {
    return '最弱リンク $snr dB';
  }

  @override
  String get routePick_inUse => '使用中';

  @override
  String get routing_floodBroadcast => 'すべてのリピータにブロードキャスト';

  @override
  String get routing_editPath => '経路を編集';

  @override
  String get routing_forgetPath => '経路を忘れる';

  @override
  String get routing_knownPaths => '既知の経路';

  @override
  String get routing_knownPathsHint => '経路をタップして切り替えます。';

  @override
  String get routing_inUse => '使用中';

  @override
  String get routing_qualityStrong => '強い最初のホップ';

  @override
  String get routing_qualityGood => '良好な最初のホップ';

  @override
  String get routing_qualityFair => 'まずまずの最初のホップ';

  @override
  String get routing_qualityWorked => '配信済み';

  @override
  String get routing_qualityFlood => 'フラッドで受信';

  @override
  String get routing_qualityUntested => '未検証';

  @override
  String routing_lastWorked(String when) {
    return '$when に確認';
  }

  @override
  String get routing_neverWorked => '未確認';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes 件配信済み、$failures 件失敗';
  }

  @override
  String get routing_floodDelivery => 'フラッド配送';

  @override
  String get pathEditor_title => '経路を作成';

  @override
  String pathEditor_hopCounter(int count) {
    return '64 ホップ中 $count';
  }

  @override
  String get pathEditor_noHops =>
      'まだホップはありません。下のリピータをタップして順番に追加するか、ホップなしで保存して直接送信します。';

  @override
  String get pathEditor_addHops => '順番にホップを追加';

  @override
  String get pathEditor_searchRepeaters => 'リピータを検索';

  @override
  String get pathEditor_advancedHex => '詳細: 生の 16 進経路';

  @override
  String get pathEditor_hexLabel => '16 進接頭辞';

  @override
  String get pathEditor_hexHelper => 'ホップごとに 16 進数 2 文字をカンマ区切りで入力します';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return '無効: $tokens';
  }

  @override
  String get pathEditor_tooManyHops => '最大 64 ホップ';

  @override
  String get pathEditor_usePath => 'この経路を使用';

  @override
  String get pathEditor_removeHop => 'ホップを削除';

  @override
  String get pathEditor_unknownHop => '不明なリピータ';

  @override
  String get chat_pathSavedLocally => 'ローカルに保存しました。同期するには接続してください。';

  @override
  String get chat_pathDeviceConfirmed => 'デバイスで確認済み';

  @override
  String get chat_pathDeviceNotConfirmed => 'デバイスではまだ確認されていません';

  @override
  String get chat_type => '種類';

  @override
  String get chat_path => '道';

  @override
  String get chat_publicKey => '公開鍵';

  @override
  String get chat_compressOutgoingMessages => '送信メッセージを圧縮する';

  @override
  String get chat_floodForced => 'フラッド（強制）';

  @override
  String get chat_directForced => 'ダイレクト（強制）';

  @override
  String chat_hopsForced(int count) {
    return '$count ホップ（強制）';
  }

  @override
  String get chat_floodAuto => 'フラッド (自動)';

  @override
  String get chat_direct => '直接';

  @override
  String get chat_poiShared => '共有された POI';

  @override
  String chat_unread(int count) {
    return '未読: $count';
  }

  @override
  String get chat_markAsUnread => '未読としてマークする';

  @override
  String get chat_newMessages => '新しいメッセージ';

  @override
  String get chat_openLink => 'リンクを開きますか？';

  @override
  String get chat_openLinkConfirmation => 'このリンクをブラウザで開きますか？';

  @override
  String get chat_open => '開く';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'リンクを開けませんでした: $url';
  }

  @override
  String get chat_invalidLink => '無効なリンク形式';

  @override
  String get map_title => 'ノードマップ';

  @override
  String get map_searchHint => 'ノード名またはIDで検索';

  @override
  String get map_activity => 'アクティビティ';

  @override
  String get map_online => 'オンライン';

  @override
  String get map_recent => '最近';

  @override
  String get map_stale => '古い';

  @override
  String get map_visible => '表示中';

  @override
  String get map_hidden => '非表示';

  @override
  String get map_centerOnNode => 'ノードを中央に表示';

  @override
  String get map_details => '詳細';

  @override
  String get map_noGps => 'GPS なし';

  @override
  String get map_noResults => '一致するノードなし';

  @override
  String get map_lineOfSight => '見通し';

  @override
  String get map_losScreenTitle => '見通し';

  @override
  String get map_noNodesWithLocation => '位置情報を持つノードはありません';

  @override
  String get map_nodesNeedGps => 'ノードを地図に表示するには GPS 座標の共有が必要です';

  @override
  String map_nodesCount(int count) {
    return 'ノード: $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'ピン: $count';
  }

  @override
  String get map_chat => 'チャット';

  @override
  String get map_repeater => 'リピータ';

  @override
  String get map_room => '部屋';

  @override
  String get map_sensor => 'センサー';

  @override
  String get map_pinDm => 'ピン（DM）';

  @override
  String get map_pinPrivate => 'ピン（非公開）';

  @override
  String get map_pinPublic => 'ピン（公開）';

  @override
  String get map_lastSeen => '最後に確認';

  @override
  String get map_disconnectConfirm => '本当にこのデバイスとの接続を解除したいですか？';

  @override
  String get map_from => '送信元';

  @override
  String get map_source => '出典';

  @override
  String get map_flags => 'フラグ';

  @override
  String get map_type => '種類';

  @override
  String get map_path => '経路';

  @override
  String get map_location => '位置';

  @override
  String get map_estLocation => '推定位置';

  @override
  String get map_publicKey => '公開鍵';

  @override
  String get map_publicKeyPrefixHint => 'e.g. ab12';

  @override
  String get map_shareMarkerHere => 'ここにマーカーを共有';

  @override
  String get map_setAsMyLocation => '現在地として設定';

  @override
  String get floodCorridor_title => 'フラッドコリドー';

  @override
  String get floodCorridor_previewToHere => 'ここまでのフラッドコリドーをプレビュー';

  @override
  String get floodCorridor_requesting => '無線機にコリドーを問い合わせています…';

  @override
  String get floodCorridor_unsupported => '無線機のファームウェアはフラッドコリドーに対応していません。';

  @override
  String get floodCorridor_noProposal =>
      '無線機がコリドーを提案できませんでした。位置が設定されているか確認してください。';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count個の円',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return '既知のリピーター$total台中$inside台が範囲内';
  }

  @override
  String get floodCorridor_straightLine => '直線: 途中に既知のリピーターがありません';

  @override
  String get floodCorridor_followsRepeaters => '既知のリピーターに沿っています';

  @override
  String get floodCorridor_horizonLimited => '既知のリピーターは目的地まで届きません。残りは直線です';

  @override
  String get floodCorridor_thinStretch => 'コリドーの一部に既知のリピーターが少ない区間があります';

  @override
  String get floodCorridor_moreCoverage => 'より多くのリピーターカバーを必須にする';

  @override
  String get floodCorridor_previewNote =>
      'プレビューのみ。コリドー対応ファームウェアのないリピーターはコリドーを適用しません。';

  @override
  String get map_pinLabel => 'ピンラベル';

  @override
  String get map_label => 'ラベル';

  @override
  String get map_pointOfInterest => '興味地点';

  @override
  String get map_sendToContact => '連絡先へ送信';

  @override
  String get map_sendToChannel => 'チャンネルへ送信';

  @override
  String get map_noChannelsAvailable => '利用可能なチャンネルはありません';

  @override
  String get map_publicLocationShare => '公開位置情報の共有';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return '$channelLabel で位置情報を共有しようとしています。このチャンネルは公開されており、PSK を持つ誰でも閲覧できます。';
  }

  @override
  String get map_connectToShareMarkers => 'マーカーを共有するにはデバイスに接続してください';

  @override
  String get map_filterNodes => 'ノードを絞り込む';

  @override
  String get map_nodeTypes => 'ノードの種類';

  @override
  String get map_chatNodes => 'チャットノード';

  @override
  String get map_repeaters => 'リピータ';

  @override
  String get map_otherNodes => 'その他のノード';

  @override
  String get map_showOverlaps => 'リピータキーの重複';

  @override
  String get map_keyPrefix => 'キー接頭辞';

  @override
  String get map_filterByKeyPrefix => 'キー接頭辞で絞り込む';

  @override
  String get map_publicKeyPrefix => '公開鍵のプレフィックス';

  @override
  String get map_markers => 'マーカー';

  @override
  String get map_showSharedMarkers => '共有のマーカーを表示する';

  @override
  String get map_showGuessedLocations => '推測されたノードの位置を表示する';

  @override
  String get map_showDiscoveryContacts => 'Discovery 連絡先を表示';

  @override
  String get map_guessedLocation => '推測された場所';

  @override
  String get map_lastSeenTime => '最後に確認された時間';

  @override
  String get map_sharedPin => '共有ピン';

  @override
  String get map_sharedAt => '共有済み';

  @override
  String get map_joinRoom => '部屋に参加する';

  @override
  String get map_manageRepeater => 'リピータの管理';

  @override
  String get map_tapToAdd => 'ノードをタップして経路に追加します。';

  @override
  String get map_runTrace => '経路トレースを実行';

  @override
  String get map_runTraceWithReturnPath => '元の経路に戻る。';

  @override
  String get map_removeLast => '最後を削除';

  @override
  String get map_pathTraceCancelled => '経路トレースはキャンセルされました';

  @override
  String get mapCache_title => 'オフライン用地図キャッシュ';

  @override
  String get mapCache_selectAreaFirst => '最初にキャッシュする領域を選択してください';

  @override
  String get mapCache_noTilesToDownload => 'この地域にはダウンロードできるタイルは存在しません。';

  @override
  String get mapCache_downloadTilesTitle => 'タイルをダウンロードする';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return 'オフラインでの使用のために、$count個のタイルをダウンロードしますか？';
  }

  @override
  String get mapCache_downloadAction => 'ダウンロード';

  @override
  String mapCache_cachedTiles(int count) {
    return '$count 枚のタイルをキャッシュしました';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return '$downloaded 枚をキャッシュ済み（$failed 件失敗）';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => 'オフラインキャッシュをクリアする';

  @override
  String get mapCache_clearOfflineCachePrompt => 'キャッシュされた地図のタイルをすべて削除しますか？';

  @override
  String get mapCache_offlineCacheCleared => 'オフラインキャッシュをクリア';

  @override
  String get mapCache_noAreaSelected => '選択されたエリアはありません';

  @override
  String get mapCache_cacheArea => 'キャッシュエリア';

  @override
  String get mapCache_useCurrentView => '現在表示されている内容を保持する';

  @override
  String get mapCache_zoomRange => 'ズーム範囲';

  @override
  String mapCache_estimatedTiles(int count) {
    return '推定されるタイル数: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return 'ダウンロード済み $completed / $total';
  }

  @override
  String get mapCache_downloadTilesButton => 'タイルをダウンロードする';

  @override
  String get mapCache_clearCacheButton => 'キャッシュをクリアする';

  @override
  String mapCache_failedDownloads(int count) {
    return '失敗したダウンロード: $count';
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
  String get time_justNow => 'まさに今';

  @override
  String time_minutesAgo(int minutes) {
    return '$minutes分前';
  }

  @override
  String time_hoursAgo(int hours) {
    return '$hours時間前';
  }

  @override
  String time_daysAgo(int days) {
    return '$days日前';
  }

  @override
  String get time_hour => '1時間';

  @override
  String get time_hours => '時間';

  @override
  String get time_day => '一日';

  @override
  String get time_days => '日';

  @override
  String get time_week => '1週間';

  @override
  String get time_weeks => '週';

  @override
  String get time_month => '月';

  @override
  String get time_months => '月';

  @override
  String get time_minutes => '分';

  @override
  String get time_allTime => '全期間';

  @override
  String get dialog_disconnect => '切断する';

  @override
  String get dialog_disconnectConfirm => '本当にこのデバイスとの接続を解除したいですか？';

  @override
  String get login_repeaterLogin => '再ログイン';

  @override
  String get login_roomLogin => 'ルームサーバーへのログイン';

  @override
  String get login_password => 'パスワード';

  @override
  String get login_enterPassword => 'パスワードを入力してください';

  @override
  String get login_savePassword => 'パスワードを保存する';

  @override
  String get login_savePasswordSubtitle => 'パスワードは、このデバイスに安全に保存されます。';

  @override
  String get login_repeaterDescription =>
      '設定やステータスにアクセスするために、リピータのパスワードを入力してください。';

  @override
  String get login_roomDescription => '設定やステータスへのアクセスには、部屋のパスワードを入力してください。';

  @override
  String get login_routing => '経路設定';

  @override
  String get login_routingMode => 'ルーティングモード';

  @override
  String get login_autoUseSavedPath => '自動 (保存されたパスを使用)';

  @override
  String get login_forceFloodMode => '強制的にフラッドモードを起動';

  @override
  String get login_managePaths => 'パスの管理';

  @override
  String get login_login => 'ログイン';

  @override
  String login_attempt(int current, int max) {
    return '試行回数：$current/$max';
  }

  @override
  String login_failed(String error) {
    return 'ログインに失敗しました：$error';
  }

  @override
  String get login_failedMessage =>
      'ログインに失敗しました。パスワードが間違っているか、または接続が確立されていません。';

  @override
  String get common_reload => '再読み込み';

  @override
  String get common_clear => 'クリア';

  @override
  String get path_currentPathLabel => '現在の経路';

  @override
  String get path_noRepeatersFound => '繰り返し機能やルームサーバーは見つかりませんでした。';

  @override
  String get repeater_management => 'リピータ管理';

  @override
  String get room_management => 'ルームサーバーの管理';

  @override
  String get repeater_guest => 'リピータに関する情報';

  @override
  String get room_guest => 'ルームサーバーに関する情報';

  @override
  String get repeater_managementTools => '管理ツール';

  @override
  String get repeater_guestTools => 'ゲスト向けツール';

  @override
  String get repeater_status => 'ステータス';

  @override
  String get repeater_statusSubtitle => 'リピータの状態、統計情報、および隣接するネットワークの情報を表示する';

  @override
  String get repeater_telemetry => 'テレメトリー';

  @override
  String get repeater_telemetrySubtitle => 'センサーおよびシステムの状態に関するテレメトリの表示';

  @override
  String get repeater_cli => 'CLI（コマンドラインインターフェース）';

  @override
  String get repeater_cliSubtitle => 'リピータへのコマンドを送信する';

  @override
  String get repeater_neighbors => '近隣住民';

  @override
  String get repeater_neighborsSubtitle => 'ゼロホップの隣接ノードを表示する。';

  @override
  String get repeater_settings => '設定';

  @override
  String get repeater_settingsSubtitle => 'リピータのパラメータを設定する';

  @override
  String get repeater_clockSyncAfterLogin => 'ログイン後に時刻を同期';

  @override
  String get repeater_clockSyncAfterLoginSubtitle => 'ログイン成功時に自動で時刻同期を送信します';

  @override
  String get repeater_statusTitle => '再送ステータス';

  @override
  String get repeater_routingMode => 'ルーティングモード';

  @override
  String get repeater_refresh => 'リフレッシュ';

  @override
  String get repeater_statusRequestTimeout => 'ステータス情報の取得に失敗しました。';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'ステータス読み込みエラー: $error';
  }

  @override
  String get repeater_systemInformation => 'システム情報';

  @override
  String get repeater_battery => 'バッテリー';

  @override
  String get repeater_clockAtLogin => 'ログイン時の時刻表示';

  @override
  String get repeater_uptime => '稼働時間';

  @override
  String get repeater_queueLength => '待ち行列の長さ';

  @override
  String get repeater_debugFlags => 'デバッグフラグ';

  @override
  String get repeater_radioStatistics => 'ラジオに関する統計';

  @override
  String get repeater_lastRssi => '最後のRSSI';

  @override
  String get repeater_lastSnr => '最後のSNR';

  @override
  String get repeater_noiseFloor => 'ノイズレベル';

  @override
  String get repeater_txAirtime => 'TX 送信時間';

  @override
  String get repeater_rxAirtime => 'RX 受信時間';

  @override
  String get repeater_chanUtil => 'チャンネルの利用状況';

  @override
  String get repeater_packetStatistics => 'パケット統計';

  @override
  String get repeater_sent => '送信済み';

  @override
  String get repeater_received => '受信済み';

  @override
  String get repeater_duplicates => '重複';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days日 $hours時間 $minutes分 $seconds秒';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return '合計: $total, フラッド: $flood, 直接: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return '合計: $total, フラッド: $flood, 直接: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return '$flood: $flood, 直接: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return '合計: $total';
  }

  @override
  String get repeater_settingsTitle => 'リピータ設定';

  @override
  String get repeater_basicSettings => '基本設定';

  @override
  String get repeater_repeaterName => 'リピータ名';

  @override
  String get repeater_repeaterNameHelper => 'このリピータの名前';

  @override
  String get repeater_adminPassword => '管理者パスワード';

  @override
  String get repeater_adminPasswordHelper => '完全アクセス権のパスワード';

  @override
  String get repeater_guestPassword => 'ゲスト用のパスワード';

  @override
  String get repeater_guestPasswordHelper => '読み取り専用アクセス用のパスワード';

  @override
  String get repeater_radioSettings => 'ラジオ設定';

  @override
  String get repeater_frequencyMhz => '周波数 (MHz)';

  @override
  String get repeater_frequencyHelper => '420–450 / 902–928 MHz';

  @override
  String get repeater_txPower => 'TXパワー';

  @override
  String get repeater_txPowerHelper => '-30～-10 dBm';

  @override
  String get repeater_bandwidth => '帯域幅';

  @override
  String get repeater_spreadingFactor => '伝播係数';

  @override
  String get repeater_codingRate => 'コーディング速度';

  @override
  String get repeater_locationSettings => '場所設定';

  @override
  String get repeater_latitude => '緯度';

  @override
  String get repeater_latitudeHelper => '度分表記（例：37.7749）';

  @override
  String get repeater_longitude => '経度';

  @override
  String get repeater_longitudeHelper => '度分表記（例：-122.4194）';

  @override
  String get repeater_features => '特徴';

  @override
  String get repeater_packetForwarding => 'パケット転送';

  @override
  String get repeater_packetForwardingSubtitle => 'リピータがパケットを転送できるように設定する';

  @override
  String get repeater_guestAccess => 'ゲストへのアクセス';

  @override
  String get repeater_guestAccessSubtitle => 'ゲストへの読み取り専用アクセスを許可する';

  @override
  String get repeater_privacyMode => 'プライバシーモード';

  @override
  String get repeater_privacyModeSubtitle => '広告に名前/場所を記載しない';

  @override
  String get repeater_advertisementSettings => '広告設定';

  @override
  String get repeater_localAdvertInterval => '地域広告掲載期間';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes 分';
  }

  @override
  String get repeater_floodAdvertInterval => 'フラッドに関する広告の表示間隔';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours 時間';
  }

  @override
  String get repeater_encryptedAdvertInterval => '暗号化された広告表示間';

  @override
  String get repeater_dangerZone => '危険区域';

  @override
  String get repeater_rebootRepeater => 'リピータを再起動する';

  @override
  String get repeater_rebootRepeaterSubtitle => 'リピータデバイスを再起動する';

  @override
  String get repeater_rebootRepeaterConfirm => '本当にこのリピータを再起動したいですか？';

  @override
  String get repeater_regenerateIdentityKey => 'IDキーの再生成';

  @override
  String get repeater_regenerateIdentityKeySubtitle => '新しい公開鍵/秘密鍵のペアを生成する';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'これにより、リピータには新しい識別情報が割り当てられます。続行しますか？';

  @override
  String get repeater_eraseFileSystem => 'ファイルシステムを削除する';

  @override
  String get repeater_eraseFileSystemSubtitle => 'リピータファイルシステムをフォーマットする';

  @override
  String get repeater_eraseFileSystemConfirm =>
      '警告：この操作により、リピータ内のすべてのデータが消去されます。この操作は元に戻すことができません！';

  @override
  String get repeater_eraseSerialOnly => 'Erase機能は、シリアルコンソール経由でのみ利用可能です。';

  @override
  String repeater_commandSent(String command) {
    return '送信されたコマンド: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'コマンド送信エラー：$error';
  }

  @override
  String get repeater_confirm => '確認';

  @override
  String get repeater_settingsSaved => '設定が正常に保存されました';

  @override
  String get repeater_rxGain => 'RX ゲインの向上';

  @override
  String get repeater_rxGainHelper => 'より高い感度、より大きな電流（SX1262/SX1268のみ）';

  @override
  String get repeater_refreshRxGain => '強化されたRX効果を再確認';

  @override
  String get repeater_multiAcks => '複数のACK（応答）';

  @override
  String get repeater_multiAcksSubtitle => '複数の経路でメッセージを送信することで、より確実な配信を実現する。';

  @override
  String get repeater_refreshMultiAcks => '複数のACKをリフレッシュする';

  @override
  String get repeater_networkHealth => 'ネットワークの状態';

  @override
  String get repeater_loopDetect => 'ループ検出';

  @override
  String get repeater_loopDetectHelper => 'ルーティングループを検知する';

  @override
  String get repeater_loopDetectOff => 'オフ';

  @override
  String get repeater_loopDetectMinimal => '最小限の';

  @override
  String get repeater_loopDetectModerate => '適度な';

  @override
  String get repeater_loopDetectStrict => '厳格な';

  @override
  String get repeater_dutyCycle => '動作サイクル';

  @override
  String get repeater_dutyCycleHelper => '最大の使用時間割合';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => '事業者の情報';

  @override
  String get repeater_ownerInfoHelper => 'このリピータに関する公開メタデータ';

  @override
  String get repeater_refreshOwnerInfo => 'オペレーター情報の更新';

  @override
  String get repeater_floodMax => '最大ホップ数';

  @override
  String get repeater_floodMaxHelper => 'フラッドパケットが移動できる最大ホップ数 (0-64)';

  @override
  String get repeater_advancedSettings => '高度な';

  @override
  String get repeater_advancedSettingsSubtitle => '経験豊富なオペレーター向けの調整ノブ';

  @override
  String get repeater_pathHashMode => 'パスハッシュモード';

  @override
  String get repeater_pathHashModeHelper =>
      'このリピータのIDをフローパス/ループ検出タグにエンコードするために使用されるバイト数。 0=1バイト (256個のID、最大64ホップ)、1=2バイト (65,000個のID、最大32ホップ)、2=3バイト (160万個のID、最大21ホップ)。 v1.13およびそれ以前のファームウェアでは、マルチバイトパスがサポートされていません。 v1.14以降のバージョンでは、一度ネットワークが起動されると、パスが一度だけ検出されます。';

  @override
  String get repeater_keySettings => 'アイデンティティキーの変更';

  @override
  String get repeater_keySettingsSubtitle => '公開鍵/秘密鍵を変更する';

  @override
  String get repeater_prvKey => 'プライベートキー';

  @override
  String get repeater_prvKeyHelper => 'リピーター用の新しいプライベートキー。128文字の16進文字列です。';

  @override
  String get repeater_generatePrvKey => 'ランダムな鍵ペアを生成する';

  @override
  String get repeater_stopGeneratingPrvKey => 'キーペアの検索を中断';

  @override
  String get repeater_pubKey => '公開鍵';

  @override
  String get repeater_pubKeyHelper => 'これは生成された秘密鍵に対応する公開鍵です。直接設定することはできません。';

  @override
  String get repeater_pubKeyPrefix => '希望する接頭辞';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'これらの16進数で始まる公開鍵を見つけてください。予想される試行回数: $tries。';
  }

  @override
  String get repeater_txDelay => 'フロイド・TXでの遅延';

  @override
  String get repeater_txDelayHelper =>
      'フラッド時の交通量に対応するための再送信間隔を、パケットの通信時間を掛けた値（0～2、デフォルト0.5）で設定します。値を大きくすると衝突が減りますが、通信速度が遅くなります。';

  @override
  String get repeater_directTxDelay => '直接的なTX遅延';

  @override
  String get repeater_directTxDelayHelper =>
      '直接（フラッドではない）トラフィックに対する再送信間隔を、パケットの空中時間（0～2、デフォルト0.3）の倍数として設定する。';

  @override
  String get repeater_intThresh => '干渉閾値';

  @override
  String get repeater_intThreshHelper =>
      'ラジオのノイズレベルを基準とする閾値を設定し、このレベルを超えるノイズを抑制します。 0 を設定すると、ノイズの多い帯域で RX エラーが発生した場合のみ、この値を上げることができます。';

  @override
  String get repeater_agcResetInterval => 'AGCのリセット間隔';

  @override
  String get repeater_agcResetIntervalHelper =>
      'ラジオの自動ゲイン制御をリセットする頻度について：ゲインが固定状態になった場合に、回復するために、何度リセットするかを設定します。4の倍数でリセットする場合、0を設定すると、定期的なリセットは停止します。';

  @override
  String get repeater_actionsTitle => '操作';

  @override
  String get repeater_sendAdvert => 'フラッド広告を送信';

  @override
  String get repeater_sendAdvertSubtitle => 'ネットワーク全体にフラッド広告をブロードキャストします';

  @override
  String get repeater_sendAdvertZeroHop => 'ゼロホップ広告を送信';

  @override
  String get repeater_sendAdvertZeroHopSubtitle => '1 ホップ広告を送信します（リピータなし）';

  @override
  String get repeater_clockSync => '時刻を同期';

  @override
  String get repeater_clockSyncSubtitle => 'スマートフォンの時刻をデバイスに設定します';

  @override
  String repeater_actionSucceeded(String action) {
    return '$action が成功しました';
  }

  @override
  String repeater_actionFailed(String action, String error) {
    return '$action の実行に失敗しました: $error';
  }

  @override
  String get repeater_settingsSavedRebootNeeded =>
      '設定を保存しました — リピータを再起動して適用してください';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return '設定の一部でエラーが発生しました：$failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return '設定の保存に失敗しました：$error';
  }

  @override
  String get repeater_refreshBasicSettings => '基本設定をリセットする';

  @override
  String get repeater_refreshRadioSettings => 'ラジオ設定をリセットする';

  @override
  String get repeater_refreshTxPower => 'TX の電力レベルをリセットする';

  @override
  String get repeater_refreshPacketForwarding => 'パケット転送の刷新';

  @override
  String get repeater_refreshGuestAccess => 'ゲストへのアクセスをリフレッシュする';

  @override
  String get repeater_refreshPrivacyMode => 'プライバシーモードをリセットする';

  @override
  String repeater_refreshed(String label) {
    return '$label が更新されました';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return '$label の更新に失敗しました';
  }

  @override
  String get repeater_cliTitle => 'リピータ CLI';

  @override
  String get repeater_debugNextCommand => '次のコマンドのデバッグ';

  @override
  String get repeater_commandHelp => 'コマンドヘルプ';

  @override
  String get repeater_clearHistory => '履歴をクリア';

  @override
  String get repeater_noCommandsSent => 'まだコマンドは送信されていません';

  @override
  String get repeater_typeCommandOrUseQuick =>
      '以下のコマンドを入力するか、クイックコマンドを使用してください。';

  @override
  String get repeater_enterCommandHint => 'コマンドを入力してください...';

  @override
  String get repeater_previousCommand => '直前の指示';

  @override
  String get repeater_nextCommand => '次の指示';

  @override
  String get repeater_enterCommandFirst => 'まず、コマンドを入力してください。';

  @override
  String get repeater_cliCommandFrameTitle => 'CLI コマンドフレーム';

  @override
  String repeater_cliCommandError(String error) {
    return 'エラー：$error';
  }

  @override
  String get repeater_cliQuickGetName => '名前を取得する';

  @override
  String get repeater_cliQuickGetRadio => 'ラジオを聴く';

  @override
  String get repeater_cliQuickGetTx => 'TX を取得';

  @override
  String get repeater_cliQuickNeighbors => '近隣';

  @override
  String get repeater_cliQuickVersion => 'バージョン';

  @override
  String get repeater_cliQuickAdvertise => '広告送信';

  @override
  String get repeater_cliQuickClock => '時刻';

  @override
  String get repeater_cliQuickClockSync => '時刻同期';

  @override
  String get repeater_cliQuickDiscovery => '近隣を発見する';

  @override
  String get repeater_cliHelpAdvert => '広告用資料を送る';

  @override
  String get repeater_cliHelpReboot =>
      'デバイスを再起動します。(注：通常は「タイムアウト」が表示されますが、これは正常です)';

  @override
  String get repeater_cliHelpClock => '各デバイスの時計で現在の時刻を表示します。';

  @override
  String get repeater_cliHelpPassword => 'デバイス用の新しい管理者パスワードを設定します。';

  @override
  String get repeater_cliHelpVersion => 'デバイスのバージョンとファームウェアのビルド日を表示します。';

  @override
  String get repeater_cliHelpClearStats => 'さまざまな統計カウンターをゼロにリセットする。';

  @override
  String get repeater_cliHelpSetAf => '空き時間係数を設定します。';

  @override
  String get repeater_cliHelpSetTx => 'LoRaの送信電力をdBmで設定します。（設定変更後、再起動が必要です）';

  @override
  String get repeater_cliHelpSetRepeat => 'このノードに対するリピータの役割を有効化または無効化します。';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '（ルームサーバー設定）「オン」に設定した場合、空白のパスワードでのログインは可能ですが、ルームへの投稿はできません。（閲覧のみ）';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'インバウンドフラッドパケットの最大ホップ数を設定します（最大値を超えた場合、パケットは転送されません）。';

  @override
  String get repeater_cliHelpSetIntThresh =>
      '干渉閾値を設定します（dB単位）。デフォルト値は14です。0に設定すると、チャンネル間の干渉を検出する機能を無効にします。';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'オートゲインコントローラーのリセット間隔を設定します。 0 に設定すると無効化されます。';

  @override
  String get repeater_cliHelpSetMultiAcks => '「ダブルACK」機能の有効化または無効化を可能にします。';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'ローカル（ホップなし）の広告パケットを送信する間隔を分単位で設定します。 0 に設定すると、機能を無効にします。';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'フラッド広告の送信間隔を時間単位で設定します。0に設定すると、送信を停止します。';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'ゲストのパスワードを設定/更新します。（繰り返し利用の場合、ゲストのログインは「統計情報を取得」のリクエストを送信できます）';

  @override
  String get repeater_cliHelpSetName => '広告の名前を設定します。';

  @override
  String get repeater_cliHelpSetLat => '広告表示の地図の緯度を設定します。（度分秒表記）';

  @override
  String get repeater_cliHelpSetLon => '広告表示の地図の経度を設定します。（度数、分）';

  @override
  String get repeater_cliHelpSetRadio =>
      '完全に新しいラジオパラメータを設定し、設定として保存します。適用するには、「再起動」コマンドが必要です。';

  @override
  String get repeater_cliHelpSetRxDelay =>
      '（実験用）遅延時間を設定するためのベース（1以上の値に設定する必要）\n受信パケットに対して、信号強度/スコアに基づいてわずかな遅延を適用します。 0に設定すると無効化されます。';

  @override
  String get repeater_cliHelpSetTxDelay =>
      '時間経過に応じた「フラッシュモード」パケットの送信遅延を設定します。この遅延は、ランダムなスロットシステムと組み合わせて使用され、パケットの衝突を減らすことを目的としています。';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'txdelayと同様ですが、ダイレクトモードのパケット転送にランダムな遅延を適用する場合に使用します。';

  @override
  String get repeater_cliHelpSetBridgeEnabled => 'ブリッジを有効化/無効化';

  @override
  String get repeater_cliHelpSetBridgeDelay => 'パケットを再送信する前に、遅延を設定する。';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      '橋が受信したパケットを再送信するか、送信したパケットを再送信するかどうかを選択してください。';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'RS232 橋渡しに使用するシリアルリンクのボーレートを設定する。';

  @override
  String get repeater_cliHelpSetBridgeSecret => 'ESPNow 橋の秘密設定';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      '特定のボードでのみサポートされている、報告されるバッテリー電圧を調整するためのカスタムファクタを設定できます。';

  @override
  String get repeater_cliHelpTempRadio =>
      '指定された時間（分単位）に対して、一時的にラジオパラメータを設定し、その後元のラジオパラメータに戻します。（設定を保存しません）。';

  @override
  String get repeater_cliHelpSetPerm =>
      'ACL を変更します。「permissions」が 0 の場合、対応するエントリ（pubkey のプレフィックスで識別）を削除します。pubkey-hex が有効な長さで、かつ ACL に現在存在しない場合に、新しいエントリを追加します。pubkey のプレフィックスと一致するエントリを更新します。権限ビットはファームウェアの役割によって異なり、下位 2 ビットは以下のとおりです：0 (ゲスト)、1 (読み取り専用)、2 (読み書き)、3 (管理者)';

  @override
  String get repeater_cliHelpGetBridgeType => 'ブリッジ機能なし、RS232、ESPNow';

  @override
  String get repeater_cliHelpLogStart => 'パケットのログ記録を開始し、ファイルシステムに保存する。';

  @override
  String get repeater_cliHelpLogStop => 'ファイルシステムへのパケットログの記録を停止する。';

  @override
  String get repeater_cliHelpLogErase => 'ファイルシステムからパケットログを削除する。';

  @override
  String get repeater_cliHelpNeighbors =>
      'ゼロホップ広告を通じて受信した他のリピータノードの一覧を表示します。各行は、IDプレフィックス（16進数）、タイムスタンプ、SNR（シグナル強度）の情報を4つ含みます。';

  @override
  String get repeater_cliHelpNeighborRemove =>
      '隣接リストから、最初に一致するエントリ（pubkeyプレフィックス（16進数）で特定）を削除します。';

  @override
  String get repeater_cliHelpRegion =>
      '（特定のシリーズのみ）定義されたすべての地域と、現在のフラッド許可状況を一覧表示します。';

  @override
  String get repeater_cliHelpRegionLoad =>
      '注：これは特殊な複数コマンドの呼び出しです。その後の各コマンドは、地域名であり（スペースを使用して親階層を示し、少なくとも1つのスペースが必要です）、空行/コマンドで終了します。';

  @override
  String get repeater_cliHelpRegionGet =>
      '指定された名前のプレフィックスを持つ地域を検索します（または、グローバルな範囲の場合は「*」）。結果として、「region-name (parent-name) \'F\'」と返答します。';

  @override
  String get repeater_cliHelpRegionPut => '指定された名前で、領域の定義を追加または更新します。';

  @override
  String get repeater_cliHelpRegionRemove =>
      '指定された名前を持つ領域の定義を削除します。(正確に一致している必要があり、子領域は存在してはなりません)';

  @override
  String get repeater_cliHelpRegionAllowf =>
      '指定された領域に対して、「フラッド」アクセス許可を設定します。 (グローバル/従来のスコープには「*」を使用)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      '指定された領域における「FLOOD」権限を削除します。（注：現時点では、グローバル/従来の範囲での使用は推奨されません！）';

  @override
  String get repeater_cliHelpRegionHome =>
      '現在の「ホーム」地域に返信します。（まだ適用されていない、将来利用を予定）';

  @override
  String get repeater_cliHelpRegionHomeSet => '「ホーム」地域を設定します。';

  @override
  String get repeater_cliHelpRegionSave => '領域リスト/マップをストレージに保存する。';

  @override
  String get repeater_cliHelpGps =>
      'GPSの状態を表示します。GPSがオフの場合、「オフ」と表示します。オンの場合、「オン」、「ステータス」、「位置情報」、「衛星数」と表示します。';

  @override
  String get repeater_cliHelpGpsOnOff => 'GPS の電源状態を切り替えます。';

  @override
  String get repeater_cliHelpGpsSync => 'ノードの時刻をGPSクロックと同期する。';

  @override
  String get repeater_cliHelpGpsSetLoc => 'ノードの位置をGPS座標に設定し、設定を保存する。';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'ノードの広告設定における場所情報の指定:\n- none: 広告に場所情報を含まない\n- share: GPS位置情報を共有 (SensorManagerから取得)\n- prefs: プリファレンスに保存された場所情報を広告';

  @override
  String get repeater_cliHelpGpsAdvertSet => '場所に関する広告設定を行います。';

  @override
  String get repeater_commandsListTitle => 'コマンド一覧';

  @override
  String get repeater_commandsListNote =>
      '注：さまざまな「set ...」コマンドには、「get ...」コマンドも存在します。';

  @override
  String get repeater_general => '一般的な';

  @override
  String get repeater_settingsCategory => '設定';

  @override
  String get repeater_bridge => '橋';

  @override
  String get repeater_logging => 'ログ記録';

  @override
  String get repeater_neighborsRepeaterOnly => '近隣住民（リピータのみ）';

  @override
  String get repeater_regionManagementRepeaterOnly => '地域管理（ブロードキャスト用のみ）';

  @override
  String get repeater_regionNote => '地域レベルでの管理のため、地域定義と権限の管理を行うための機能が導入されました。';

  @override
  String get repeater_gpsManagement => 'GPS管理';

  @override
  String get repeater_gpsNote => 'GPSコマンドは、位置情報に関連するタスクを管理するために導入されました。';

  @override
  String get repeater_getCategory => '価値を取得する';

  @override
  String get repeater_powerMgmt => '電力管理';

  @override
  String get repeater_sensors => 'センサー';

  @override
  String get repeater_cliHelpPowerOff => 'デバイスをシャットダウンします。（応答は期待されていません）';

  @override
  String get repeater_cliHelpClkReboot => '時計を既知の基準時点にリセットし、デバイスを再起動します。';

  @override
  String get repeater_cliHelpAdvertZeroHop => '近隣のデバイスのみに、ゼロホップの広告を送信します。';

  @override
  String get repeater_cliHelpStartOta =>
      'サポートされているボードに対して、無線でファームウェアのアップデートを開始します。';

  @override
  String get repeater_cliHelpTime =>
      'デバイスのクロックを、指定されたUnixエポックの秒数に設定します。クロックは逆方向に進むことはできません。';

  @override
  String get repeater_cliHelpBoard => '製造元の名前/ハードウェア識別子を表示します。';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      '近隣のノードに対して、ノードの探索リクエストを送信します。（リピータ機能のみ）';

  @override
  String get repeater_cliHelpPowersaving => '省電力モードがオンになっているかどうかを表示します。';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      '省電力モード（対応している場合）を有効または無効にします。';

  @override
  String get repeater_cliHelpErase =>
      '（シリアルモードのみ）デバイスのファイルシステムをフォーマットします。すべての設定と連絡先を消去します。';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      '送信可能な最大デューティサイクルをパーセントで設定します（1〜100）。内部で、空き時間の要素を調整します。';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '（シリアル番号のみ）デバイスのプライベートキーを置き換えます。適用には再起動が必要です。新しいパブリックキーを生成します。';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '（SX126xのみ）高電流での使用時に、感度を向上させるために、増幅されたRXのゲインを切り替えることができます。';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      '広告に記載されている所有者連絡先情報を設定します。改行には\'|\'を使用してください。';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'パスハッシュモードを設定します。 0 = 従来のモード、1 = 標準モード、2 = 厳格モード。ルーティングパスのマッチング方法に影響します。';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'ルーティングループ検出の感度を設定します：オフ、最小、中程度、または厳格。';

  @override
  String get repeater_cliHelpSetFreq =>
      '（シリアル設定のみ）特定の周波数のみを素早く設定できます。再起動が必要です。「ラジオ設定」を使用すると、ラジオのすべてのパラメータを設定できます。';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '（ESPNowブリッジのみ）ブリッジで使用するWi-Fiチャンネル（1～14）を設定します。';

  @override
  String get repeater_cliHelpGetName => '設定されたノードの名前を表示します。';

  @override
  String get repeater_cliHelpGetRole => 'ファームウェアの役割（リピータ、ルームサーバーなど）を表示します。';

  @override
  String get repeater_cliHelpGetPublicKey => 'デバイスの公開鍵を表示します。';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '（シリアル番号のみ）デバイスのプライベートキーを表示します。機密情報として扱ってください。';

  @override
  String get repeater_cliHelpGetRepeat => 'パケット転送（リピータ機能）が有効になっているかどうかを表示します。';

  @override
  String get repeater_cliHelpGetTx => '現在のTX（送信）電力のdBm値を表示します。';

  @override
  String get repeater_cliHelpGetFreq => '設定された無線周波数をMHzで表示します。';

  @override
  String get repeater_cliHelpGetRadio =>
      '以下のすべての無線パラメータを表示: 周波数、帯域幅、スプレッドファクター、符号化レート。';

  @override
  String get repeater_cliHelpGetRadioRxGain => '(SX126xのみ) RX の増幅ゲインの状態を表示します。';

  @override
  String get repeater_cliHelpGetAf => '現在の空き時間係数を表示します。';

  @override
  String get repeater_cliHelpGetDutyCycle => '現在の許可されたデューティサイクルをパーセントで表示します。';

  @override
  String get repeater_cliHelpGetIntThresh => 'チャンネル干渉の閾値をdBで表示します。';

  @override
  String get repeater_cliHelpGetAgcResetInterval => 'AGCのリセット間隔を秒単位で表示します。';

  @override
  String get repeater_cliHelpGetMultiAcks => 'ダブルACKモードが有効 (1) か無効 (0) かを示す。';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'ゲストによる読み取り専用アクセスが許可されているかどうかを示す。';

  @override
  String get repeater_cliHelpGetAdvertInterval => 'ローカル広告の時間を分単位で表示します。';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'フラッドに関する広告の放送時間を時間単位で表示します。';

  @override
  String get repeater_cliHelpGetGuestPassword => '設定されたゲストパスワードを表示します。';

  @override
  String get repeater_cliHelpGetLat => '設定された緯度を表示します。';

  @override
  String get repeater_cliHelpGetLon => '設定された経度を表示します。';

  @override
  String get repeater_cliHelpGetRxDelay => 'rxdelay の基本値を表示します。';

  @override
  String get repeater_cliHelpGetTxDelay => 'フラッドモードにおける送信遅延の要因を示します。';

  @override
  String get repeater_cliHelpGetDirectTxDelay => 'ダイレクトモードの遅延要素を示します。';

  @override
  String get repeater_cliHelpGetFloodMax => 'フラッドパケットの最大ホップ数を表示します。';

  @override
  String get repeater_cliHelpGetOwnerInfo => '所有者の連絡先情報を表示します。';

  @override
  String get repeater_cliHelpGetPathHashMode => 'パスハッシュモード（0/1/2）を表示します。';

  @override
  String get repeater_cliHelpGetLoopDetect => 'ループ検出の感度を示す。';

  @override
  String get repeater_cliHelpGetAcl => '（シリアルのみ）リピータ上のアクセス制御設定を一覧表示します。';

  @override
  String get repeater_cliHelpGetBridgeEnabled => '橋が有効になっているかどうかを表示します。';

  @override
  String get repeater_cliHelpGetBridgeDelay => '橋の遅延時間をミリ秒（ms）で表示します。';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'RX または TX パケットを橋渡ししているかどうかを示す。';

  @override
  String get repeater_cliHelpGetBridgeBaud => '（RS232 橋渡し機能のみ）橋渡しのボーレートを表示します。';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '（ESPNowブリッジのみ）ブリッジで使用しているWi-Fiチャンネルを表示します。';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '（ESPNowブリッジのみ）ブリッジで共有されている秘密鍵を表示します。';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '（NRF52のみ）ブートローダーのバージョンを表示します。';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'ADC（アナログ-デジタル変換）のマルチプライヤー（バッテリー電圧のスケーリング）を表示します。';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      '取締役会が電力管理機能をサポートしているかどうかを報告します。';

  @override
  String get repeater_cliHelpGetPwrMgtSource => '現在の電源（外部電源またはバッテリー）を表示します。';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      '最新のリセットおよびシャットダウンの理由を表示します。';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv => '起動時のバッテリー電圧をmVで表示します。';

  @override
  String get repeater_cliHelpSensorGet => 'キーを使用して、カスタムセンサーの設定を読み取る。';

  @override
  String get repeater_cliHelpSensorSet => 'カスタムセンサーの設定を作成する。';

  @override
  String get repeater_cliHelpSensorList =>
      'カスタムセンサーの設定をすべてリスト表示し、オプションで指定できる開始インデックスからページ分割して表示します。';

  @override
  String get repeater_cliHelpRegionDefault => '現在のデフォルトの地域範囲を表示します。';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'デフォルトの地域範囲を設定します。「<null>」を使用すると、設定をリセットできます。';

  @override
  String get repeater_cliHelpRegionListAllowed => 'フラッド時の通行が許可されている地域の一覧';

  @override
  String get repeater_cliHelpRegionListDenied => 'フラッドによる交通を遮断している地域の一覧';

  @override
  String get repeater_cliHelpStatsPackets => '（シリアルのみ）パケットレベルの統計情報を表示します。';

  @override
  String get repeater_cliHelpStatsRadio => '（シリーズのみ）ラジオの統計情報を表示します。';

  @override
  String get repeater_cliHelpStatsCore => '（シリアルのみ）主要なファームウェアの統計情報を表示します。';

  @override
  String get telemetry_receivedData => '受信したテレメトリーデータ';

  @override
  String get telemetry_requestTimeout => 'テレメトリの要求タイムアウトしました。';

  @override
  String telemetry_errorLoading(String error) {
    return 'テレメトリの読み込みに失敗しました: $error';
  }

  @override
  String get telemetry_noData => 'テレメトリデータは利用できません。';

  @override
  String telemetry_channelTitle(int channel) {
    return 'チャンネル $channel';
  }

  @override
  String get telemetry_batteryLabel => 'バッテリー';

  @override
  String get telemetry_voltageLabel => '電圧';

  @override
  String get telemetry_mcuTemperatureLabel => 'MCU の温度';

  @override
  String get telemetry_temperatureLabel => '温度';

  @override
  String get telemetry_currentLabel => '現在';

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
    return '$celsius℃ / $fahrenheit°F';
  }

  @override
  String get telemetry_digitalInputLabel => 'デジタル入力';

  @override
  String get telemetry_digitalOutputLabel => 'デジタル出力';

  @override
  String get telemetry_analogInputLabel => 'アナログ入力';

  @override
  String get telemetry_analogOutputLabel => 'アナログ出力';

  @override
  String get telemetry_genericLabel => '汎用センサー';

  @override
  String get telemetry_luminosityLabel => '照度';

  @override
  String get telemetry_presenceLabel => '在室';

  @override
  String get telemetry_humidityLabel => '湿度';

  @override
  String get telemetry_accelerometerLabel => '加速度計';

  @override
  String get telemetry_pressureLabel => '気圧';

  @override
  String get telemetry_altitudeLabel => '高度';

  @override
  String get telemetry_frequencyLabel => '周波数';

  @override
  String get telemetry_percentageLabel => 'パーセント';

  @override
  String get telemetry_concentrationLabel => '濃度';

  @override
  String get telemetry_powerLabel => '電力';

  @override
  String get telemetry_distanceLabel => '距離';

  @override
  String get telemetry_energyLabel => 'エネルギー';

  @override
  String get telemetry_directionLabel => '方向';

  @override
  String get telemetry_timeLabel => '時刻';

  @override
  String get telemetry_gyrometerLabel => 'ジャイロメーター';

  @override
  String get telemetry_colourLabel => '色';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'スイッチ';

  @override
  String get telemetry_polylineLabel => 'ポリライン';

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
  String get telemetry_autoFetchQuantity => 'リクエスト数';

  @override
  String get telemetry_error => 'データを取得できません';

  @override
  String get neighbors_receivedData => '近隣住民のデータを受信';

  @override
  String get neighbors_requestTimedOut => '近隣住民からの要望：時間制限を設けてください。';

  @override
  String neighbors_errorLoading(String error) {
    return '近隣情報の読み込みに失敗: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => '近隣のリピータ';

  @override
  String get neighbors_noData => '近隣のデータは利用できません。';

  @override
  String neighbors_unknownContact(String pubkey) {
    return '不明な $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return '聞いたのは、$time くらい前です';
  }

  @override
  String get channelPath_title => 'パケットパス';

  @override
  String get channelPath_viewMap => '地図を表示する';

  @override
  String get channelPath_otherObservedPaths => '観察されたその他の経路';

  @override
  String get channelPath_repeaterHops => 'リピータホップ';

  @override
  String get channelPath_noHopDetails => 'このパッケージに関する詳細な情報は提供されていません。';

  @override
  String get channelPath_sourceLabel => '受信元';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'このメッセージはMQTT経由で届きました。あなたの無線機は受信していないため、無線機からの電波経路はありません。';

  @override
  String get channelPath_messageDetails => 'メッセージの詳細';

  @override
  String get channelPath_senderLabel => '送信者';

  @override
  String get channelPath_timeLabel => '時間';

  @override
  String get channelPath_repeatsLabel => 'リピータ';

  @override
  String channelPath_pathLabel(int index) {
    return '$index 番目の経路';
  }

  @override
  String get channelPath_observedLabel => '観察';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return '観察された経路 $index • $hops';
  }

  @override
  String get channelPath_noLocationData => '場所に関するデータはありません';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => '不明';

  @override
  String get channelPath_floodPath => 'フラッド';

  @override
  String get channelPath_directPath => '直接';

  @override
  String channelPath_observedZeroOf(int total) {
    return '$total個のホップ';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed/$total ホップ';
  }

  @override
  String get channelPath_mapTitle => '経路図';

  @override
  String get channelPath_noRepeaterLocations => 'この経路にリピータの位置情報はありません。';

  @override
  String channelPath_primaryPath(int index) {
    return '$index番目の経路（主要経路）';
  }

  @override
  String get channelPath_pathLabelTitle => '道';

  @override
  String get channelPath_observedPathHeader => '観察された経路';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable => 'このパッケージに関する詳細な配送情報は利用できません。';

  @override
  String get channelPath_unknownRepeater => '不明な増幅機';

  @override
  String get community_title => 'コミュニティ';

  @override
  String get community_create => 'コミュニティを作成';

  @override
  String get community_createDesc => '新しいコミュニティを作成して QR コードで共有します。';

  @override
  String get community_join => '参加';

  @override
  String get community_joinTitle => 'コミュニティに参加';

  @override
  String community_joinConfirmation(String name) {
    return '$name のコミュニティに参加しますか？';
  }

  @override
  String get community_scanQr => 'コミュニティの QR コードをスキャン';

  @override
  String get community_scanInstructions => 'カメラをコミュニティの QR コードに向けてください';

  @override
  String get community_showQr => 'QR コードを表示';

  @override
  String get community_publicChannel => '公開チャンネル';

  @override
  String get community_hashtagChannel => 'コミュニティ用ハッシュタグ';

  @override
  String get community_name => 'コミュニティ名';

  @override
  String get community_enterName => 'コミュニティ名を入力してください';

  @override
  String community_created(String name) {
    return 'コミュニティ「$name」を作成しました';
  }

  @override
  String community_joined(String name) {
    return '$name のコミュニティに参加しました';
  }

  @override
  String get community_qrTitle => 'コミュニティ共有';

  @override
  String community_qrInstructions(String name) {
    return 'この QR コードをスキャンして $name に参加してください。';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'コミュニティのハッシュタグチャンネルには、コミュニティのメンバーだけが参加できます。';

  @override
  String get community_invalidQrCode => '無効なコミュニティQRコード';

  @override
  String get community_alreadyMember => 'すでにメンバーです';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'あなたはすでに $name のメンバーです。';
  }

  @override
  String get community_addPublicChannel => '公開チャンネルを追加';

  @override
  String get community_addPublicChannelHint => 'このコミュニティの公開チャンネルを自動で追加します';

  @override
  String get community_noCommunities => 'まだコミュニティはありません';

  @override
  String get community_scanOrCreate => 'QR コードをスキャンするか、コミュニティを作成して始めてください。';

  @override
  String get community_manageCommunities => 'コミュニティを管理';

  @override
  String get community_delete => 'コミュニティを離脱';

  @override
  String community_deleteConfirm(String name) {
    return '$name から離脱しますか？';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return 'これにより、$count のチャンネルとそのメッセージも削除されます。';
  }

  @override
  String community_deleted(String name) {
    return 'コミュニティ「$name」から離脱しました';
  }

  @override
  String get community_regenerateSecret => '秘密鍵を再生成';

  @override
  String community_regenerateSecretConfirm(String name) {
    return '$name の秘密鍵を再生成しますか？ 継続して通信するには、すべてのメンバーが新しい QR コードをスキャンする必要があります。';
  }

  @override
  String get community_regenerate => '再生成';

  @override
  String community_secretRegenerated(String name) {
    return '$name の秘密鍵を再生成しました';
  }

  @override
  String get community_updateSecret => '秘密鍵を更新';

  @override
  String community_secretUpdated(String name) {
    return '$name の秘密設定を更新しました';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return '新しい QR コードをスキャンして $name の秘密設定を更新してください。';
  }

  @override
  String get community_addHashtagChannel => 'ハッシュタグチャンネルを追加';

  @override
  String get community_addHashtagChannelDesc => 'このコミュニティ用のハッシュタグチャンネルを追加します';

  @override
  String get community_selectCommunity => 'コミュニティを選択';

  @override
  String get community_regularHashtag => '通常のハッシュタグ';

  @override
  String get community_regularHashtagDesc => '公開ハッシュタグ（誰でも参加可能）';

  @override
  String get community_communityHashtag => 'コミュニティ用ハッシュタグ';

  @override
  String get community_communityHashtagDesc => 'コミュニティメンバーのみ利用できます';

  @override
  String community_forCommunity(String name) {
    return '$name 向け';
  }

  @override
  String get listFilter_tooltip => 'フィルタリングと並べ替え';

  @override
  String get listFilter_sortBy => '並び替え';

  @override
  String get listFilter_latestMessages => '最新のメッセージ';

  @override
  String get listFilter_heardRecently => '最近、聞いた';

  @override
  String get listFilter_az => 'AからZ';

  @override
  String get listFilter_filters => 'フィルター';

  @override
  String get listFilter_all => 'すべて';

  @override
  String get listFilter_favorites => 'お気に入り';

  @override
  String get listFilter_addToFavorites => 'お気に入りに追加';

  @override
  String get listFilter_removeFromFavorites => 'お気に入りから削除';

  @override
  String get listFilter_users => '利用者';

  @override
  String get listFilter_repeaters => 'リピータ';

  @override
  String get listFilter_roomServers => 'ルーム用サーバー';

  @override
  String get listFilter_unreadOnly => '未読のみ';

  @override
  String get listFilter_newGroup => '新しいグループ';

  @override
  String get traceCard_title => 'トレースカード';

  @override
  String get traceCard_open => 'トレースカードを共有';

  @override
  String traceCard_from(String name) {
    return '送信元: $name';
  }

  @override
  String traceCard_to(String name) {
    return '宛先: $name';
  }

  @override
  String traceCard_sentAt(String time) {
    return '送信日時 $time';
  }

  @override
  String traceCard_roundTrip(String seconds) {
    return '往復 $seconds 秒';
  }

  @override
  String traceCard_hops(int count) {
    return 'ホップ数: $count';
  }

  @override
  String get traceCard_backToYou => 'あなたに戻る';

  @override
  String traceCard_distance(String distance) {
    return '経路 $distance';
  }

  @override
  String traceCard_weakest(String snr) {
    return '最も弱いリンク $snr';
  }

  @override
  String get traceCard_noMap => 'この経路の位置情報がないため、地図はありません。';

  @override
  String get traceCard_guessed => '推定位置';

  @override
  String get traceCard_mapLabel => '往復経路の地図';

  @override
  String get traceCard_shareImage => '画像を共有';

  @override
  String get traceCard_shareText => 'テキストを共有';

  @override
  String get traceCard_shareFailed => 'トレースカードを共有できませんでした。';

  @override
  String get traceCard_snrUnknown => 'SNRなし';

  @override
  String get pathTrace_you => 'あなた';

  @override
  String get pathTrace_failed => 'パスの追跡に失敗しました。';

  @override
  String get pathTrace_notAvailable => 'パスの追跡機能は利用できません。';

  @override
  String get pathTrace_refreshTooltip => 'パスの追跡をリフレッシュする。';

  @override
  String get pathTrace_someHopsNoLocation => 'ホップの1つまたは複数について、場所が特定されていません。';

  @override
  String get pathTrace_clearTooltip => '明確な道筋。';

  @override
  String get losSelectStartEnd => 'LOS の開始ノードと終了ノードを選択してください。';

  @override
  String losRunFailed(String error) {
    return '視界確認に失敗: $error';
  }

  @override
  String get losClearAllPoints => 'すべての項目をクリア';

  @override
  String get losRunToViewElevationProfile => 'LOS（レーザー測距）を使用して、標高プロファイルを表示する';

  @override
  String get losMenuTitle => 'LOS メニュー';

  @override
  String get losMenuSubtitle => '特定の場所をタップするか、地図を長押ししてカスタムポイントを作成する。';

  @override
  String get losShowDisplayNodes => '表示ノードを表示する';

  @override
  String get losCustomPoints => 'カスタマイズ可能なポイント';

  @override
  String losCustomPointLabel(int index) {
    return 'カスタマイズ $index';
  }

  @override
  String get losPointA => 'ポイントA';

  @override
  String get losPointB => 'ポイントB';

  @override
  String losAntennaA(String value, String unit) {
    return 'アンテナ A: $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return 'アンテナ B: $value $unit';
  }

  @override
  String get losRun => 'LOS（レーティングシステム）を使用する';

  @override
  String get losNoElevationData => '標高データは含まれていません';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, clear LOS, min clearance $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, blocked by $obstruction $heightUnit';
  }

  @override
  String get losStatusChecking => 'LOS：確認中…';

  @override
  String get losStatusNoData => 'LOS: データの欠如';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS: $clear/$total clear, $blocked blocked, $unknown unknown';
  }

  @override
  String get losErrorElevationUnavailable =>
      'あるサンプルまたは複数のサンプルについて、標高データが利用できません。';

  @override
  String get losErrorInvalidInput => 'LOS（レーダー）計算に必要な、無効な点/標高データ。';

  @override
  String get losRenameCustomPoint => 'カスタムポイントの名前を変更する';

  @override
  String get losPointName => '項目名';

  @override
  String get losShowPanelTooltip => 'LOSパネルを表示する';

  @override
  String get losHidePanelTooltip => 'LOSパネルを隠す';

  @override
  String get losElevationAttribution => '標高データ：Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'ラジオ・ホライゾン';

  @override
  String get losLegendLosBeam => 'LOS ビーミング';

  @override
  String get losLegendTerrain => '地形';

  @override
  String get losBlockedSpotsTitle => '利用できない場所';

  @override
  String get losBlockedSpotsHint => '地図上で、特定された場所を強調するために、該当する場所をタップしてください。';

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
  String get losSelectedObstructionTitle => '選択された障害';

  @override
  String losSelectedObstructionDetails(
    String obstruction,
    String heightUnit,
    String distanceFromA,
    String distanceUnit,
    String distanceFromB,
  ) {
    return '$obstruction によって $heightUnit の高さで、A地点から $distanceFromA、B地点から $distanceFromB ($distanceUnit) の距離で塞がれています。';
  }

  @override
  String get losFrequencyLabel => '周波数';

  @override
  String get losFrequencyInfoTooltip => '計算の詳細を見る';

  @override
  String get losFrequencyDialogTitle => 'ラジオによる水平線計算';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'k=$baselineK ( $baselineFreq MHz) から開始し、現在の $frequencyMHz MHz の帯域に対して k の値を調整します。これにより、曲面状の無線通信範囲の限界が定義されます。';
  }

  @override
  String get contacts_pathTrace => '経路追跡';

  @override
  String get contacts_ping => 'パング';

  @override
  String get contacts_repeaterPathTrace => 'リピータまでの経路を追跡する';

  @override
  String get contacts_repeaterPing => 'リピータにPING';

  @override
  String get contacts_roomPathTrace => '部屋のサーバーへの経路を追跡する';

  @override
  String get contacts_roomPing => 'ピンルーム用サーバー';

  @override
  String get contacts_chatTraceRoute => '経路の追跡ルート';

  @override
  String contacts_pathTraceTo(String name) {
    return '$name への経路を追跡する';
  }

  @override
  String get contacts_clipboardEmpty => 'クリップボードは空です。';

  @override
  String get contacts_pasteNotContact =>
      'MeshCore の連絡先ではありません。meshcore:// の連絡先リンクまたはアドバートをコピーして、もう一度お試しください。';

  @override
  String get contacts_invalidAdvertFormat => '無効な連絡先情報';

  @override
  String get contacts_contactImported => '連絡先が登録されました。';

  @override
  String get contacts_contactImportFailed => '連絡先のインポートに失敗しました。';

  @override
  String get contacts_zeroHopAdvert => 'ゼロホップ広告';

  @override
  String get contacts_floodAdvert => 'フラッドに関する広告';

  @override
  String get contacts_copyAdvertToClipboard => '広告をクリップボードにコピー';

  @override
  String get contacts_addContactFromClipboard => 'クリップボードから連絡先を追加する';

  @override
  String get contacts_ShareContact => '連絡先をクリップボードにコピー';

  @override
  String get contacts_ShareContactZeroHop => '広告を通じて連絡先を共有する';

  @override
  String get contacts_zeroHopContactAdvertSent => '広告を通じて連絡先を得た。';

  @override
  String get contacts_zeroHopContactAdvertFailed => '連絡を送信できませんでした。';

  @override
  String get contacts_contactAdvertCopied => '広告がクリップボードにコピーされました。';

  @override
  String get contacts_contactAdvertCopyFailed => '広告のコピーがクリップボードにコピーできませんでした。';

  @override
  String get notification_activityTitle => 'メッシュコアの活動';

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
      other: 'チャンネルメッセージ',
      one: 'チャンネルメッセージ',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '新しいノード',
      one: '新しいノード',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return '新たに $contactType が発見されました';
  }

  @override
  String get notification_receivedNewMessage => '新しいメッセージを受信';

  @override
  String get settings_gpxExportRepeaters => 'GPX へのエクスポート用リピータ/ルームサーバー';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'GPXファイルに場所情報を付加した、レピーター/ルームサーバーのエクスポート';

  @override
  String get settings_gpxExportContacts => 'GPX 形式へのエクスポート';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'GPXファイルに位置情報を保存して、他の人と共有する。';

  @override
  String get settings_gpxExportAll => 'すべての連絡先をGPX形式でエクスポートする';

  @override
  String get settings_gpxExportAllSubtitle =>
      'すべての連絡先を、場所情報付きのGPXファイルにエクスポートする。';

  @override
  String get settings_gpxExportSuccess => 'GPXファイルの正常なエクスポートが完了しました。';

  @override
  String get settings_gpxExportNoContacts => 'エクスポートする連絡先は存在しません。';

  @override
  String get settings_gpxExportNotAvailable => 'このデバイス/OSではサポートされていません';

  @override
  String get settings_gpxExportError => 'エクスポート時にエラーが発生しました。';

  @override
  String get settings_gpxExportRepeatersRoom => 'リピータ/ルームサーバーの位置情報';

  @override
  String get settings_gpxExportChat => '関連施設';

  @override
  String get settings_gpxExportAllContacts => 'すべての連絡先場所';

  @override
  String get settings_gpxExportShareText => 'NOTORYX Core Hamからエクスポートされた地図データ';

  @override
  String get settings_gpxExportShareSubject =>
      'NOTORYX Core Ham GPX形式の地図データのエクスポート';

  @override
  String get snrIndicator_nearByRepeaters => '近くのリピータ';

  @override
  String get snrIndicator_lastSeen => '最後に確認された場所';

  @override
  String get contactsSettings_title => '連絡先設定';

  @override
  String get contactsSettings_autoAddTitle => '自動検出';

  @override
  String get contactsSettings_otherTitle => 'その他の連絡に関する設定';

  @override
  String get contactsSettings_autoAddUsersTitle => '自動でユーザーを追加する';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      '利用者が自動的に発見したユーザーを追加できるようにする。';

  @override
  String get contactsSettings_autoAddRepeatersTitle => 'リピータを自動追加';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      '発見したリピータを、自動的に追加できるようにする。';

  @override
  String get contactsSettings_autoAddRoomServersTitle => '自動でルームサーバーを追加';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      '利用者が、発見した部屋のサーバーを自動的に追加できるようにする。';

  @override
  String get contactsSettings_autoAddSensorsTitle => '自動でセンサーを追加';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      '利用者が、発見したセンサーを自動的に追加できるようにする。';

  @override
  String get contactsSettings_overwriteOldestTitle => '最も古いものを上書きする';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      '連絡先リストが満杯になった場合、最も古いかつ「お気に入り」ではない連絡先が削除されます。';

  @override
  String get discoveredContacts_Title => '連絡先が見つかった';

  @override
  String get discoveredContacts_noMatching => '一致する連絡先が見つかりませんでした';

  @override
  String get discoveredContacts_searchHint => '発見された連絡先を検索する';

  @override
  String get discoveredContacts_contactAdded => '連絡先を追加';

  @override
  String get discoveredContacts_addContact => '連絡先を追加';

  @override
  String get discoveredContacts_copyContact => '連絡先をクリップボードにコピー';

  @override
  String get discoveredContacts_deleteContact => '発見された連絡先を削除';

  @override
  String get discoveredContacts_deleteContactAll => '発見されたすべての連絡先を削除';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      '本当に、見つけたすべての連絡先を削除してもよろしいですか？';

  @override
  String get chat_sendCooldown => '再度送信する前に、しばらくお待ちください。';

  @override
  String get appSettings_jumpToOldestUnread => '最も古い未読のメッセージへ移動';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      '未読メッセージがあるチャットを開く際、「最新のメッセージ」ではなく、最初に未読のメッセージまでスクロールしてください。';

  @override
  String get appSettings_languageHu => 'ハンガリー語';

  @override
  String get appSettings_languageJa => '日本語';

  @override
  String get appSettings_languageKo => '韓国語';

  @override
  String get radioStats_tooltip => 'ラジオおよびメッシュに関する統計';

  @override
  String get radioStats_screenTitle => 'ラジオの統計';

  @override
  String get radioStats_notConnected => 'ラジオの統計情報を表示するために、デバイスに接続してください。';

  @override
  String get radioStats_firmwareTooOld =>
      'ラジオの統計機能を使用するには、v8またはそれ以降のファームウェアが必要です。';

  @override
  String get radioStats_waiting => 'データ待ち…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'ノイズレベル: $noiseDbm dBm';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return '最後のRSSI: $rssiDbm dBm';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return '最終SNR: $snr dB';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'TX 放送時間（合計）：$seconds 秒';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'RX 放送時間（合計）：$seconds 秒';
  }

  @override
  String get radioStats_chartCaption => '最近のサンプルのノイズレベル（dBm）。';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'ノイズレベル: $noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting => 'ラジオの統計情報を取得中…';

  @override
  String get radioStats_settingsTile => 'ラジオの統計';

  @override
  String get radioStats_settingsSubtitle => 'ノイズレベル、RSSI、SNR、および通信時間';

  @override
  String get translation_title => '翻訳';

  @override
  String get imageMessages_enableTitle => '画像メッセージを有効にする';

  @override
  String get imageMessages_enableSubtitle =>
      'メッシュ経由で画像を送信してください。画像モデルを一度限りのダウンロードが必要です。';

  @override
  String get imageMessages_modelSectionTitle => '画像モデル';

  @override
  String get imageMessages_downloadModel => 'ダウンロード';

  @override
  String get imageMessages_cancelDownload => 'キャンセル';

  @override
  String get imageMessages_removeModel => 'モデルを削除';

  @override
  String get imageMessages_modelReady => '準備完了';

  @override
  String get imageMessages_modelNotPublished =>
      'まだ公開されていません — このビルドではダウンロードできません。';

  @override
  String get imageMessages_downloadFailed => '画像モデルがダウンロードできませんでした。';

  @override
  String get imageMessages_autoProcessTitle => '画像を自動的に処理する';

  @override
  String get imageMessages_autoProcessSubtitle =>
      '画像が届き次第、すぐに再構築してください。1回あたり約2GBのメモリを使用します。タップで再構築を解除できます。';

  @override
  String get translation_enableTitle => '翻訳機能を有効にする';

  @override
  String get translation_enableSubtitle => '受信メッセージを翻訳し、送信前に翻訳を適用できるようにする。';

  @override
  String get translation_composerTitle => '送信する前に翻訳する';

  @override
  String get translation_composerSubtitle => '作曲家翻訳アイコンのデフォルト状態を制御する。';

  @override
  String get translation_autoIncomingTitle => 'メッセージを自動翻訳';

  @override
  String get translation_autoIncomingSubtitle =>
      '通知やチャット、チャンネルのメッセージを自動的に翻訳します。';

  @override
  String get translation_translateMessage => 'メッセージを翻訳';

  @override
  String get translation_targetLanguage => '翻訳対象言語';

  @override
  String get translation_useAppLanguage => 'アプリの言語設定';

  @override
  String get translation_downloadedModelLabel => 'ダウンロードしたモデル';

  @override
  String get translation_presetModelLabel => 'あらかじめ設定されたHugging Faceモデル';

  @override
  String get translation_manualUrlLabel => 'マニュアルモデルのURL';

  @override
  String get translation_downloadModel => 'モデルのダウンロード';

  @override
  String get translation_downloading => 'ダウンロード中...';

  @override
  String get translation_working => '業務中…';

  @override
  String get translation_stop => '停止';

  @override
  String get translation_mergingChunks => 'ダウンロードしたファイルを最終ファイルに結合中...';

  @override
  String get translation_downloadedModels => 'ダウンロードされたモデル';

  @override
  String get translation_deleteModel => 'モデルを削除';

  @override
  String get translation_modelDownloaded => '翻訳モデルのダウンロードが完了しました。';

  @override
  String get translation_downloadStopped => 'ダウンロードが中断されました。';

  @override
  String translation_downloadFailed(String error) {
    return 'ダウンロードに失敗しました：$error';
  }

  @override
  String get translation_enterUrlFirst => 'まず、モデルのURLを入力してください。';

  @override
  String get scanner_linuxPairingShowPin => 'PINを表示';

  @override
  String get scanner_linuxPairingHidePin => 'PINを非表示';

  @override
  String get scanner_linuxPairingPinTitle => 'Bluetooth ペアリング PIN';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return '$deviceNameのPINを入力してください（なしの場合は空欄のまま）。';
  }

  @override
  String get translation_messageTranslation => 'メッセージの翻訳';

  @override
  String get translation_translateBeforeSending => '送信する前に翻訳する';

  @override
  String get translation_composerEnabledHint => 'メッセージは送信前に翻訳されます。';

  @override
  String get translation_composerDisabledHint => '元のタイプされた言語でメッセージを送信してください。';

  @override
  String translation_translateTo(String language) {
    return '$language への翻訳';
  }

  @override
  String get translation_translationOptions => '翻訳の選択肢';

  @override
  String get translation_systemLanguage => 'システム言語';

  @override
  String get background_serviceTitle => 'MeshCore 実行中';

  @override
  String get background_serviceText => 'BLE 接続を維持しています';

  @override
  String appSettings_translationModelDeleted(String name) {
    return '$name を削除しました';
  }

  @override
  String appSettings_translationModelDeleteFailed(String error) {
    return '削除に失敗しました: $error';
  }

  @override
  String channels_channelUpdateFailed(String error) {
    return 'チャンネルの更新に失敗しました: $error';
  }

  @override
  String get contact_typeChat => 'チャット';

  @override
  String get contact_typeRepeater => 'リピータ';

  @override
  String get contact_typeRoom => 'ルーム';

  @override
  String get contact_typeSensor => 'センサー';

  @override
  String get contact_typeUnknown => '不明';

  @override
  String get map_zoomIn => 'ズームイン';

  @override
  String get map_zoomOut => 'ズームアウト';

  @override
  String get map_centerMap => '地図を中央に移動';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'Web Bluetooth には Chromium ベースのブラウザが必要です。';

  @override
  String channels_communityShortId(String id) {
    return 'ID: $id…';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'GPSによる確認';

  @override
  String get pathTrace_legendInferred => '推測される位置';

  @override
  String get pathMap_viewSingle => '単独表示';

  @override
  String get pathMap_viewCombined => '統合表示';

  @override
  String get pathMap_play => '再生';

  @override
  String get pathMap_pause => '一時停止';

  @override
  String get pathMap_replay => 'リプレイ';

  @override
  String get pathMap_stepBack => '前のホップ';

  @override
  String get pathMap_stepForward => '次のホップ';

  @override
  String get pathMap_animationOn => 'パケットアニメーションを表示';

  @override
  String get pathMap_animationOff => 'パケットアニメーションを非表示';

  @override
  String pathMap_hopOf(int current, int total) {
    return '$current/$total ホップ目';
  }

  @override
  String pathMap_observedPaths(int count) {
    return '観測された経路: $count';
  }

  @override
  String get pathMap_primary => '主要';

  @override
  String pathMap_alternate(int index) {
    return '代替 $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ホップ',
      one: '1 ホップ',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => '共有セグメント';

  @override
  String get pathMap_legendEstimated => '概算のセグメント';

  @override
  String pathMap_sharedNodeCount(int count) {
    return '$count 経路で使用されています';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count つのホップに位置情報がありません - 表示中の経路は一部です',
      one: '1 つのホップに位置情報がありません - 表示中の経路は一部です',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'すべて表示';

  @override
  String get pathMap_hidePath => '経路を非表示';

  @override
  String get pathMap_showPath => '経路を表示';

  @override
  String get pathMap_collapsePanel => 'パネルを折りたたむ';

  @override
  String get pathMap_expandPanel => 'パネルを展開';

  @override
  String get pathMap_noLocation => '位置情報なし';

  @override
  String get pathMap_followPacket => 'パケットを追跡';

  @override
  String get pathMap_unfollowPacket => 'パケットの追跡を解除';

  @override
  String get imageSend_title => '画像を送信';

  @override
  String get imageSend_cropNote => '512 × 512にリサイズされました。アスペクト比は保持されませんでした。';

  @override
  String get imageSend_originalSize =>
      '原文：\nThe early morning light filtered through the curtains, casting a soft glow on the room.\n\n翻訳：\n早朝の光がカーテンをすり抜け、部屋に柔らかな光を投げかけていた。';

  @override
  String get imageSend_onAirSize => '放送中';

  @override
  String get imageSend_quality => '品質';

  @override
  String get imageSend_qualityStandard => '標準';

  @override
  String get imageSend_qualityHigh => 'ハイ';

  @override
  String get imageSend_packetsLabel => 'パケット';

  @override
  String get imageSend_airtimeLabel => '放送時間';

  @override
  String get imageSend_sizeLabel => 'ペイロード';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'パケット',
      one: 'パケット',
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
  String get imageSend_radioUnknownTitle => 'ラジオの設定が不明です';

  @override
  String get imageSend_radioUnknownBody => '放送時間の計算ができるように、デバイスに接続してください。';

  @override
  String get imageSend_longSendTitle => '長距離伝送';

  @override
  String imageSend_longSendBody(String duration) {
    return 'このチャンネルは約 $duration 間保持されます。';
  }

  @override
  String get imageSend_floodNote =>
      '洪水ルーティング：範囲内の各リピーターが各パケットを再送信するため、チャネルはこれよりも長く占有されたままになります。';

  @override
  String get imageSend_parityTitle => '回復パケット';

  @override
  String get imageSend_paritySubtitle =>
      '追加のパケットが1つあります。グループメッセージは確認されないため、1つのパケットが失われても受信者が画像を再構築できます。';

  @override
  String get imageSend_send => '送る';

  @override
  String get imageSend_cancel => 'キャンセル';

  @override
  String get imageSend_encodeFailed => 'この画像はエンコードできませんでした。';

  @override
  String get imageSend_codecDownloading => '画像モデルはまだダウンロード中です。';

  @override
  String get imageSend_codecUnavailable => 'このデバイスでは画像送信が利用できません。';

  @override
  String get imageSend_codecDisabled => '設定で画像メッセージはオフになっています。';

  @override
  String get imageSend_deviceUnsupported =>
      'このラジオは画像パケットを送信できません。コンパニオン ファームウェア 13 以降を実行しているデバイスを接続してください。';

  @override
  String get imageSend_directMessagesUnsupported =>
      '画像はグループデータとして送信されるため、ダイレクトメッセージではなくチャンネルに送ることができます。';

  @override
  String get imageSend_tooLarge => 'その画像は、メッシュ形式が許容するよりも多くのパケットにエンコードされています。';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'パケット',
      one: 'パケット',
    );
    return '$count $_temp0として画像を送信しました。';
  }

  @override
  String imageSend_sendFailed(String error) {
    return '画像を送信できませんでした：$error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return '画像送信 — パケット $sent 件、合計 $total 件';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'ノード $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return '$total パケット中 $received パケット';
  }

  @override
  String get receivedImage_queued => '復号を待っている';

  @override
  String get receivedImage_tapToDecode => 'デコードするにはタップしてください。';

  @override
  String get receivedImage_decoding => '再構築… 約1秒';

  @override
  String receivedImage_incomplete(int received, int total) {
    return '画像が不完全です — $total パケット中 $received パケットが到着しました';
  }

  @override
  String get receivedImage_corrupt => '画像を再構成することはできませんでした';

  @override
  String get receivedImage_decoderMissing => '画像を受信しました — 画像のデコードが失敗しました';

  @override
  String get receivedImage_evicted => '画像はもう保存されていません';

  @override
  String get receivedImage_retry => 'もう一度試してください';

  @override
  String get receivedImage_decodeAgain => 'もう一度デコードしてください';

  @override
  String get receivedImage_openSettings => '設定する';

  @override
  String get receivedImage_tapToProcess => '処理するにはタップしてください';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'パケット',
      one: 'パケット',
    );
    return '$bytes バイト・$packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds秒';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes分 $seconds秒';
  }

  @override
  String get bastion_tagline => 'インフラに頼らない通信。';

  @override
  String get bastion_nodes => 'ノード';

  @override
  String get bastion_repeaters => 'リピーター';

  @override
  String get bastion_active1h => '1時間以内に活動';

  @override
  String get bastion_mapCoverage => 'マップ + カバレッジ';

  @override
  String get bastion_routeIntelligence => 'ルート分析';

  @override
  String get bastion_repeaterTools => 'リピーターツール';

  @override
  String get bastion_fieldStats => 'フィールド統計';

  @override
  String get bastion_fieldOps => '行程 + フィールド運用';

  @override
  String get bastion_coverageCapture => 'カバレッジ記録';

  @override
  String get bastion_mapAttribution =>
      '地図データ © OpenStreetMap 貢献者、タイルは選択したプロバイダー';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の観測',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '固有ノード$count個',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countホップ',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count分',
    );
    return '$_temp0';
  }

  @override
  String get sos_notEmergencyService =>
      '選択した連絡先と範囲内の無線機にのみ届きます。911 や緊急サービスには連絡しません。';

  @override
  String get sos_holdHint => '2秒間長押しします。誰かが応答するまで、5分ごとに行程の連絡先へ位置を送信します。';

  @override
  String sos_holdHintChannel(String channel) {
    return '2秒間長押しします。誰かが応答するまで、5分ごとに行程の連絡先と$channelへ位置を送信します。';
  }

  @override
  String sos_notSent(String error) {
    return 'SOSを送信できませんでした: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return '$nameが確認しました。再送を停止しました。';
  }

  @override
  String get sos_waitingForRadio => '無線機の送信を待っています…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return '$max回中$sends回送信しました。再送は終了しましたが、まだ応答はありません。';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return '$max回中$sends回送信しました。次回は$timeです。';
  }

  @override
  String get sos_active => 'SOS発信中';

  @override
  String get sos_stop => '停止';

  @override
  String get sos_imSafe => '無事です';

  @override
  String get sos_holdSemantics => 'SOS。長押しで送信します。';

  @override
  String get sos_keepHolding => 'そのまま押し続けて…';

  @override
  String get sos_holdForSos => '長押しでSOS';

  @override
  String get sos_blockStorage => '先にフィールドログの保存エラーを解決してください。';

  @override
  String get sos_blockNotConnected => 'SOSを送信するには MeshCore 無線機を接続してください。';

  @override
  String get sos_blockNoTarget => '「行程を計画」で行程の連絡先またはSOSチャンネルを選んでください。';

  @override
  String get checkIn_labelOk => '無事です';

  @override
  String get checkIn_labelAtCamp => 'キャンプ地にいます';

  @override
  String get checkIn_labelDelayed => '遅れています';

  @override
  String get checkIn_labelHeadingBack => '帰路についています';

  @override
  String get checkIn_blockLoading => '行程を読み込み中…';

  @override
  String get checkIn_blockStorage => '送信する前にフィールドログの保存エラーを解決してください。';

  @override
  String get checkIn_blockBusy => 'チェックインを送信中です。お待ちください。';

  @override
  String get checkIn_blockNoContacts => '「行程を計画」で行程の連絡先を選んでください。';

  @override
  String get checkIn_blockRosterIncomplete =>
      '一部の行程の連絡先が利用できません。メンバーを確認してください。';

  @override
  String get checkIn_blockNotConnected => 'チェックインするには MeshCore 無線機を接続してください。';

  @override
  String get checkIn_blockNotActive => 'チェックインを有効にするには行程を開始してください。';

  @override
  String get checkIn_notSent => '未送信';

  @override
  String checkIn_deliveredToOne(String name) {
    return '$nameに配信済み';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return '$count件すべての連絡先に配信済み';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return '$total件中$delivered件に配信済み';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return '未配信: $names';
  }

  @override
  String get checkIn_waitingForRest => '残りを待っています';

  @override
  String get checkIn_aContact => '連絡先';

  @override
  String get checkIn_statusPending => '保留中';

  @override
  String get checkIn_statusSent => '送信済み';

  @override
  String get checkIn_statusDelivered => '配信済み';

  @override
  String get checkIn_statusFailed => '失敗';

  @override
  String get checkIn_explainPending => '端末内でキューに入っています。無線送信や受信を確認したものではありません。';

  @override
  String get checkIn_explainSent => '無線機が送信を受け付けました。配信確認はまだ記録されていません。';

  @override
  String get checkIn_explainDelivered => 'アプリが配信確認を記録しました。相手が読んだことの証明ではありません。';

  @override
  String get checkIn_explainFailed =>
      '配信は確認されていません。無線接続、受信者への到達性、再送履歴を確認してください。';

  @override
  String get checkIn_explainUnknown => '配信状態が不明です。このメッセージが届いたとは考えないでください。';

  @override
  String get tripBrief_heading => 'NOTORYX • MeshCore 行程概要';

  @override
  String tripBrief_trip(String name) {
    return '行程: $name';
  }

  @override
  String tripBrief_status(String status) {
    return '状態: $status';
  }

  @override
  String get tripBrief_active => '進行中';

  @override
  String get tripBrief_stopped => '停止中';

  @override
  String tripBrief_contacts(String names) {
    return '連絡先: $names';
  }

  @override
  String get tripBrief_noneSelected => '未選択';

  @override
  String get tripBrief_unavailableContact => '利用できない連絡先(メンバーを確認)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return '活動の遅延とみなすまで: $minutes分(連絡先が静かになるとこの端末が通知します)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'チェックインのリマインダー: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return 'チェックインがないまま$minutes分ごと';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'チェックインの選択肢: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'チェックインに含める無線機の位置: $value';
  }

  @override
  String get tripBrief_includedMayBeStale => '含める(古い可能性あり)';

  @override
  String tripBrief_battery(String value) {
    return 'チェックインに含める無線機のバッテリー: $value';
  }

  @override
  String get tripBrief_included => '含める';

  @override
  String get tripBrief_off => 'オフ';

  @override
  String get tripBrief_review => 'チェックインを送信する前に受信者とメッセージを確認してください。';

  @override
  String get tripBrief_noProof => 'キュー登録や送信済みは配信の証明ではありません。確認応答は既読の証明ではありません。';

  @override
  String get tripBrief_overdueMeaning =>
      '遅延とは最近の連絡先の活動がないことを意味し、緊急事態が確認されたわけではありません。';

  @override
  String get tripBrief_automations =>
      'フィールド自動化はアプリが動作している間だけ実行されます。連絡が取れない場合の別の計画を決めておいてください。';

  @override
  String get tripBrief_sharesOnly => 'この概要は情報を共有するだけで、無線メッセージの送信や行程の開始は行いません。';

  @override
  String get fieldOps_title => 'NOTORYX Core Ham フィールド運用';

  @override
  String get fieldOps_tabTrip => '行程';

  @override
  String get fieldOps_tabReady => '準備';

  @override
  String get fieldOps_tabLog => 'ログ';

  @override
  String get fieldOps_tabAuto => '自動';

  @override
  String get fieldOps_tabCoverage => 'カバレッジ';

  @override
  String get fieldOps_tabConnection => '接続';

  @override
  String get fieldOps_diagnostics => '診断';

  @override
  String get fieldOps_storageLoadError =>
      'フィールドデータを読み込めませんでした。保存済みデータは保持され、自動化はオフのままです。';

  @override
  String get fieldOps_storageSaveError =>
      'フィールドデータを保存できませんでした。自動化を停止しました。既存の保存データは保持されます。';

  @override
  String get fieldOps_regionHint => '「オフライン地図」でエリアとズームレベルを選んでください。';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • ズーム $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return '地図エリアを確認できませんでした: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '行程進行中 • 連絡先$count件',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped => '行程は停止中です。準備ができたら開始してください。';

  @override
  String fieldOps_reminderAt(String time) {
    return '$timeにチェックインのリマインダー';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return '長時間応答なし: $names';
  }

  @override
  String get fieldOps_planTrip => '行程を計画';

  @override
  String get fieldOps_endTrip => '行程を終了';

  @override
  String get fieldOps_startTrip => '行程を開始';

  @override
  String get fieldOps_tripBrief => '行程概要';

  @override
  String get fieldOps_connectRadio => '無線機を接続';

  @override
  String get fieldOps_previewedCheckIns => 'プレビュー付きチェックイン';

  @override
  String get fieldOps_previewedCheckInsHint =>
      '状態を選び、実際の受信者とメッセージを確認してから送信します。キュー登録は配信済みを意味しません。';

  @override
  String get fieldOps_tripRoster => '行程メンバー';

  @override
  String get fieldOps_rosterEmpty => '「行程を計画」で既知のチャット連絡先を最大6件選んでください。';

  @override
  String get fieldOps_rosterCaveat =>
      '最終受信は過去の活動の証拠です。現在の到達性を示すものではありません。遅延バッジは最近の連絡先の活動がないことを示し、緊急事態が確認されたわけではありません。';

  @override
  String get fieldOps_offlineMaps => 'オフライン地図';

  @override
  String get fieldOps_checkingTiles => '保存済みタイルを確認中…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'キャッシュ済みタイル$count枚。',
    );
    return '$_temp0ルート全体がカバーされている保証はありません。';
  }

  @override
  String get fieldOps_downloadAreas => 'オフラインエリアをダウンロード/確認';

  @override
  String fieldOps_lastCheckIn(String time) {
    return '最後のチェックイン、$time';
  }

  @override
  String fieldOps_deliveryChip(String name, String status) {
    return '$name: $status';
  }

  @override
  String get fieldOps_contactFallback => '連絡先';

  @override
  String fieldOps_resendFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '未配信の$count件に再送',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable => '選択した連絡先は利用できません';

  @override
  String get fieldOps_memberUnavailableHint => '送信する前にこの行程を確認してください。';

  @override
  String fieldOps_lastActivity(int minutes) {
    return '最終活動 $minutes分前';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return '最終活動 $minutes分前 • 遅延';
  }

  @override
  String get fieldOps_noCheckInRecorded => 'このログにチェックインの記録はありません。';

  @override
  String get fieldOps_tripMap => '行程マップ';

  @override
  String get fieldOps_tripMapEmpty => '選択した連絡先はまだ座標を発信していません。';

  @override
  String get fieldOps_lastPositions => '最後に発信された位置';

  @override
  String get fieldOps_positionsCaveat =>
      '位置は古い可能性があります。この地図は端末のGPSを追跡せず、メンバーが今ここにいることを証明しません。';

  @override
  String get fieldOps_briefPreviewTitle => '行程概要のプレビュー';

  @override
  String get fieldOps_briefPreviewHint =>
      '行程名と連絡先名が含まれます。共有する前に確認してください。座標、鍵、メッセージ履歴は含まれません。';

  @override
  String get fieldOps_shareBrief => '概要を共有';

  @override
  String get fieldOps_briefSubject => 'NOTORYX Core Ham 行程概要';

  @override
  String get fieldOps_tripName => '行程名';

  @override
  String get fieldOps_defaultTripName => '私の行程';

  @override
  String get fieldOps_includePosition => '無線機が発信した位置を含める';

  @override
  String get fieldOps_includePositionHint => '古い可能性があります。共有は既定でオフです。';

  @override
  String get fieldOps_includeBattery => '無線機のバッテリーを含める';

  @override
  String get fieldOps_overdueLabel => '連絡先が応答しない時間がこれを超えたら通知';

  @override
  String get fieldOps_reminderLabel => 'チェックインを通知';

  @override
  String get fieldOps_reminderHelper => 'NOTORYX Core Ham を閉じていても端末に通知します。';

  @override
  String get fieldOps_reminderOff => 'オフ';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'チェックインがないまま$count分後',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'SOSの送信先チャンネル';

  @override
  String get fieldOps_sosChannelNone => 'なし';

  @override
  String get fieldOps_selectContacts => '既知のチャット連絡先を最大6件選択';

  @override
  String get fieldOps_sendCheckInTitle => 'チェックインを送信しますか?';

  @override
  String fieldOps_recipients(String names) {
    return '宛先: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      '通常のダイレクトメッセージで送信します。配信状況はフィールドログで追跡されます。';

  @override
  String get fieldOps_send => '送信';

  @override
  String get sosRelay_title => 'SOS 中継';

  @override
  String get sosRelay_enable => 'リピーターが中継しなかった SOS を中継する';

  @override
  String get sosRelay_needsFirmware => '無線機ファームウェア v1.16 以降が必要です';

  @override
  String get sosRelay_noneYet => 'まだ SOS を中継していません';

  @override
  String sosRelay_relayedCount(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'SOS パケットを $count 件中継、最終 $time',
    );
    return '$_temp0';
  }

  @override
  String get sosRelay_explainer =>
      '送信者から直接 SOS を受信し、約 15 秒以内にどのリピーターも中継しなかった場合、NOTORYX がそれをそのまま 1 回だけ再送信し、送信者には届かないがあなたには届くリピーターへ届けます。中継するのは、あなたが持っているチャンネルの SOS だけです。バッテリーと送信時間を使うため、既定ではオフです。';

  @override
  String get fieldOps_beforeYouLeave => '出発前に';

  @override
  String get fieldOps_radioConnected => '無線機接続済み';

  @override
  String get fieldOps_connectHint => 'Bluetooth、USB、TCPで接続します。';

  @override
  String get fieldOps_radioBattery => '無線機のバッテリー';

  @override
  String get fieldOps_batteryUnknown => '不明。無線機を確認してください。';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent% • 予定の行程に向けて充電してください。';
  }

  @override
  String get fieldOps_tripContacts => '行程の連絡先';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return '$available/$selected件が利用可能。互換性のある無線機とチャンネルがあるか確認してください。';
  }

  @override
  String get fieldOps_offlineArea => '選択したオフライン地図エリア';

  @override
  String get fieldOps_checkingFiles => 'ローカルファイルを確認中…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return 'タイルファイル$available/$expected件が利用可能、$missing件が不足。これはスナップショットです。出発前にオフラインでエリアを開いてください。';
  }

  @override
  String get fieldOps_locationChoice => '位置情報の共有';

  @override
  String get fieldOps_locationOptedIn => 'オン: 無線機が発信した座標は古い可能性があります。';

  @override
  String get fieldOps_locationOff => '共有はオフです。チェックインに座標は含まれません。';

  @override
  String get fieldOps_automationAvailability => '自動化の可用性';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'このアプリが動作している間だけ実行されます。スリープ、終了、無線機の切断によって予定の操作が実行されないことがあります。';

  @override
  String get fieldOps_readinessCaveat =>
      '準備チェックは参考情報です。無線の到達範囲を証明したり、メッセージの配信を保証したりするものではありません。';

  @override
  String get fieldOps_radio => '無線機';

  @override
  String get fieldOps_refreshChecks => 'チェックを更新';

  @override
  String get fieldOps_searchLog => 'フィールドログを検索';

  @override
  String get fieldOps_kindAll => 'すべて';

  @override
  String get fieldOps_kindCheckIn => 'チェックイン';

  @override
  String get fieldOps_kindReceived => '受信';

  @override
  String get fieldOps_kindNote => 'メモ';

  @override
  String get fieldOps_kindDeadZone => '圏外エリア';

  @override
  String get fieldOps_kindRadio => '無線';

  @override
  String get fieldOps_kindAutomation => '自動化';

  @override
  String get fieldOps_kindMissed => '未実行';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => '行程';

  @override
  String get fieldOps_kindOverdue => '遅延';

  @override
  String get fieldOps_addNote => 'メモを追加';

  @override
  String get fieldOps_exportJson => 'JSONをエクスポート';

  @override
  String get fieldOps_deleteLog => 'ログを削除';

  @override
  String get fieldOps_logSubject => 'NOTORYX Core Ham フィールドログ';

  @override
  String get fieldOps_logCaveat =>
      '端末内に最大1,000件保存されます。エクスポートには連絡先の鍵、メッセージ、位置が含まれる場合があります。共有前に確認してください。';

  @override
  String get fieldOps_noEntries => '一致する項目はありません。';

  @override
  String get fieldOps_tripUnspecified => '行程未指定';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return '記録された無線機の発信位置 $latitude, $longitude(古い可能性あり)';
  }

  @override
  String get fieldOps_noteTitle => 'フィールド観察';

  @override
  String get fieldOps_noteLabel => '何を観察しましたか?';

  @override
  String get fieldOps_deadZone => '圏外エリアを報告';

  @override
  String get fieldOps_deadZoneHint => 'あなたの観察であり、検証済みのカバレッジ予測ではありません。';

  @override
  String get fieldOps_savePosition => '無線機が発信した位置を保存';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • 古い可能性あり、端末のGPSではありません';
  }

  @override
  String get fieldOps_noPosition => '使用できる発信座標がありません';

  @override
  String get fieldOps_deleteLogTitle => 'フィールドログを削除しますか?';

  @override
  String get fieldOps_deleteLogBody => 'この端末に保存されたすべての項目が削除されます。行程の設定は保持されます。';

  @override
  String get fieldOps_localAutomations => 'ローカル自動化';

  @override
  String get fieldOps_enableForTrip => 'この行程で有効にする';

  @override
  String get fieldOps_automationsCaveat =>
      'アプリを再起動するたびにオフになります。ルールはアプリが動作している間だけ実行されます。実行されなかった予定の操作はフィールドログに表示され、まとめて再実行されることはありません。自動チェックインは10分ごとに1回までに制限されます。';

  @override
  String get fieldOps_openBotMode => 'NOTORYX ボットモードを開く';

  @override
  String get fieldOps_ruleEnabled => 'ルール有効';

  @override
  String get fieldOps_dryRun => 'テスト実行';

  @override
  String get fieldOps_dryRunHint => '送信や通知をせずに操作を記録します。';

  @override
  String get fieldOps_then => '実行内容';

  @override
  String get fieldOps_actionLog => 'フィールドログに記録';

  @override
  String get fieldOps_actionNotify => 'ローカル通知を表示';

  @override
  String get fieldOps_actionCheckIn => '行程の連絡先に「I\'m OK」を送信';

  @override
  String get fieldOps_batteryThreshold => 'バッテリーがこの値以下';

  @override
  String fieldOps_nextDue(String time) {
    return '次回: $time';
  }

  @override
  String get fieldOps_nextDueNone => '次回: 予定なし';

  @override
  String get fieldOps_previewInLog => 'ログでプレビュー';

  @override
  String get fieldOps_allowNotifications => '通知を許可';

  @override
  String get fieldOps_triggerReconnect => '無線機が再接続したとき';

  @override
  String get fieldOps_triggerDisconnect => '無線機が切断したとき';

  @override
  String get fieldOps_triggerLowBattery => '無線機のバッテリーがしきい値を超えたとき';

  @override
  String get fieldOps_triggerNewNode => '新しいノードが追加されたとき';

  @override
  String get fieldOps_triggerRepeater => '新しいリピーターが追加されたとき';

  @override
  String get fieldOps_triggerScheduled => '予定のチェックイン時刻になったとき';

  @override
  String get fieldOps_explainConnection => '接続について説明';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return '状態: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      '端末は無線機に接続しています。それだけで受信者へのルートが確立されているわけではありません。';

  @override
  String get fieldOps_disconnectedHint =>
      '有効な無線接続がありません。Bluetoothの権限、無線機の電源と到達範囲を確認してください。USB/TCPは「無線機を接続」から利用できます。';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return '確認待ちの行程チェックイン: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'ノードの最終確認時刻や発信位置は古い可能性があります。ルート分析は観測された試行から学習したルートを表示し、経路を推測で作ることはありません。';

  @override
  String get fieldOps_routeIntelligence => 'ルート分析';

  @override
  String get fieldOps_coverageIntelligence => 'カバレッジ分析';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      '2つのフィールドセッションの観測記録を比較します。点はノードが受信された時点の記録者の無線機発信位置を示します。連続したカバレッジを意味するものではありません。RSSI/SNRのスナップショットはノードごとの測定値ではありません。';

  @override
  String get fieldOps_captureSession => 'セッションを記録';

  @override
  String get fieldOps_refreshHistory => '履歴を更新';

  @override
  String get fieldOps_noCoverageSessions => '保存されたカバレッジセッションはまだありません。';

  @override
  String get fieldOps_sessionA => 'セッションA • ティール';

  @override
  String get fieldOps_sessionB => 'セッションB • アンバー';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: 固有ノード$a個 • B: 固有ノード$b個';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return '共通: $shared • Aのみ: $onlyA • Bのみ: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'あるセッションでノードを受信できなくても、圏外エリアとは断定できません。条件や観測時間は異なります。';

  @override
  String get fieldOps_heardTooltip => '受信したノードの観測。リンク成功の証明ではありません';

  @override
  String get fieldOps_noteTooltip => '無線機が発信した座標でのローカルメモ。古い可能性があります。';

  @override
  String get bastionHome_aboutTooltip => 'NOTORYX Core Ham について';

  @override
  String get bastionHome_getStarted => 'はじめに';

  @override
  String get bastionHome_getStartedHint => '無線機を接続して最初のメッセージを確認します';

  @override
  String get bastionHome_planYourTrip => '行程を計画';

  @override
  String get bastionHome_tripActive => '行程進行中';

  @override
  String get bastionHome_tripStopped => '行程停止中';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • 連絡先$contacts件 • 未読メッセージ$unread件';
  }

  @override
  String get bastionHome_checkInOk => 'チェックイン: 無事です';

  @override
  String get bastionHome_checkInHint =>
      '送信前に連絡先とメッセージを確認してください。確認応答はフィールドログで追跡できます。';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return '最後のチェックイン: $summary';
  }

  @override
  String get bastionHome_connectRadio => '無線機を接続';

  @override
  String get bastionHome_connectRadioHint => 'Bluetooth、USB、TCPによる MeshCore 接続';

  @override
  String get bastionHome_liveDiagnostics => 'ライブ診断';

  @override
  String get bastionHome_liveDiagnosticsHint => '無線機の状態、信号、デバイス、フレームツール';

  @override
  String get bastionHome_meshDiscovery => 'メッシュ探索';

  @override
  String get bastionHome_meshDiscoveryHint => '周囲のノードを見つけてメッシュを調べます';

  @override
  String get bastionHome_fieldOpsHint => '行程概要、準備、フィールドログ、自動化、カバレッジ比較';

  @override
  String get bastionHome_fieldTools => 'NOTORYX フィールドツール';

  @override
  String get bastionHome_statusActive => '有効';

  @override
  String get bastionHome_consoleOnline => 'フィールドコンソール オンライン';

  @override
  String get bastionHome_consoleReady => 'フィールドコンソール 準備完了';

  @override
  String get bastionHome_consoleHint => '無線機を接続するとライブダッシュボードが表示されます。';

  @override
  String bastionHome_battery(String value) {
    return '電池 $value';
  }

  @override
  String get bastionTools_title => 'フィールドツール';

  @override
  String get bastionTools_backup => '暗号化バックアップ';

  @override
  String get bastionTools_backupHint => '設定、連絡先、鍵を保存。チャット履歴も任意で保存できます';

  @override
  String get bastionTools_fieldOpsHint => 'チェックイン、準備、フィールドログ、自動化、比較';

  @override
  String get bastionTools_mapHint => 'ライブマップ、記録セッション、オフライン地図ツール、地域';

  @override
  String get bastionTools_pathAnalysis => '経路分析';

  @override
  String get bastionTools_pathHint => 'ルート、探索、経路分析';

  @override
  String get bastionTools_repeaterHint => '状態、ログイン、テレメトリー、近隣、管理';

  @override
  String get bastionTools_statsHint => 'メッシュのライブ集計と連絡先の活動';

  @override
  String get bastionTools_diagnostics => '診断';

  @override
  String get bastionTools_diagnosticsHint => '無線機の状態、デバイス情報、生フレーム、エクスポート';

  @override
  String get bastionTools_about => '情報 + クレジット';

  @override
  String get bastionTools_aboutHint =>
      'NOTORYX Core Ham のバージョン、独立性に関する声明、オープンソースライセンス';

  @override
  String get bastionAbout_title => '情報 + クレジット';

  @override
  String get bastionAbout_intro =>
      'MeshCore ネットワーク向けの独立したコミュニティ製コンパニオンアプリです。NOTORYX Core Ham は MeshCore の公式アプリではなく、コミュニティのリソースを掲載していても提携や推奨を意味するものではありません。';

  @override
  String get bastionAbout_version => 'バージョン';

  @override
  String get bastionAbout_openSource => 'オープンソースの基盤';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core Ham は MIT ライセンスの MeshCore Open のオープンソースコードをもとに作られ、それを改変しています。カバレッジ機能の作業では、該当する場合に MIT ライセンスの MeshMapper Flutter App のクレジットも記載しています。';

  @override
  String get bastionAbout_community => 'コミュニティ第一';

  @override
  String get bastionAbout_communityBody =>
      '第三者のクリエイターのリソースは、それぞれのクリエイターに帰属します。所有権や提携を意味するものではありません。';

  @override
  String get bastionAbout_legalese => 'NOTORYX Core Ham • 独立した MeshCore コンパニオン';

  @override
  String get bastionAbout_licenses => 'オープンソースライセンス';

  @override
  String get bastionSetup_title => 'NOTORYX Core Ham をはじめる';

  @override
  String get bastionSetup_intro =>
      '接続し、連絡先を選び、メッセージを確認します。このガイドにはダッシュボードからいつでも戻れます。';

  @override
  String get bastionSetup_step1 => '1. MeshCore 無線機を接続';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return '$transportで$deviceに接続しました。';
  }

  @override
  String get bastionSetup_noRadio => 'まだ無線機が接続されていません。';

  @override
  String get bastionSetup_step1Power =>
      'MeshCore コンパニオン無線機の電源を入れます。「無線機を接続」を開き、Bluetooth、USB、TCPのいずれかを選びます。選んだ接続に必要な権限を許可してください。';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Bluetoothの検索結果が空の場合は、Bluetoothがオンになっていること、Android のアプリ設定で NOTORYX Core Ham に「付近のデバイス」の権限があることを確認してください。スキャナーが表示する追加の権限リクエストにも従ってください。';

  @override
  String get bastionSetup_connectionDiagnostics => '接続の診断';

  @override
  String get bastionSetup_step2 => '2. チャット連絡先を選ぶ';

  @override
  String get bastionSetup_step2Body =>
      '互換性のある MeshCore 無線設定を持つ近くのパートナーに、ノードをアドバタイズしてもらいます。下から既知のチャット連絡先を選んでください。リピーターは別に管理します。';

  @override
  String get bastionSetup_noContacts =>
      '利用できるチャット連絡先がありません。無線機を接続して「メッシュ探索」を開いてください。';

  @override
  String get bastionSetup_testRecipient => 'テストの受信者';

  @override
  String get bastionSetup_meshDiscovery => 'メッシュ探索';

  @override
  String get bastionSetup_step3 => '3. メッセージを送信して確認';

  @override
  String get bastionSetup_step3Body =>
      'チャットを開き、短いテストメッセージを書き、受信者を確認して「送信」をタップします。ここに戻ると、このガイドを開いてから記録された最新の送信メッセージを確認できます。';

  @override
  String get bastionSetup_openTestChat => 'テストチャットを開く';

  @override
  String get bastionSetup_connectFirst => 'テストチャットを開くには無線機を接続してください。';

  @override
  String get bastionSetup_chooseRecipient => 'まず受信者を選んでください。';

  @override
  String get bastionSetup_noTestMessage =>
      'このガイドのセッションでは送信したテストメッセージの記録がありません。';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return '最新のメッセージ: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'パートナーに受信の確認か返信を頼んでください。確認応答の記録は既読の証明ではありません。メッセージが失敗した場合は、接続と受信者を確認し直してください。';

  @override
  String get bastionSetup_step4 => '4. フィールドに備える';

  @override
  String get bastionSetup_step4Body =>
      '行程の連絡先を計画し、ダウンロードした地図エリアを確認します。ボットモードとフィールド自動化は最初はオフで、フィールド自動化はアプリが動作している間だけ実行されます。';

  @override
  String get bastionSetup_tripTools => '行程と準備のツール';

  @override
  String get bastionDiag_title => '診断';

  @override
  String get bastionDiag_export => '診断をエクスポート';

  @override
  String get bastionDiag_channels => 'チャンネル';

  @override
  String get bastionDiag_radio => '無線';

  @override
  String get bastionDiag_frequency => '周波数';

  @override
  String get bastionDiag_bandwidth => '帯域幅';

  @override
  String get bastionDiag_spreadingFactor => '拡散率';

  @override
  String get bastionDiag_codingRate => '符号化率';

  @override
  String get bastionDiag_txPower => '送信出力';

  @override
  String get bastionDiag_noiseFloor => 'ノイズフロア';

  @override
  String get bastionDiag_device => 'デバイス';

  @override
  String get bastionDiag_name => '名前';

  @override
  String get bastionDiag_manufacturer => 'メーカー';

  @override
  String get bastionDiag_firmware => 'ファームウェア';

  @override
  String get bastionDiag_battery => 'バッテリー';

  @override
  String get bastionDiag_transport => '接続方式';

  @override
  String get bastionDiag_deepTools => '詳細ツール';

  @override
  String get bastionDiag_liveStats => 'ライブ無線統計';

  @override
  String get bastionDiag_liveStatsHint => 'ノイズ、RSSI、SNR、送信時間';

  @override
  String get bastionDiag_frameDebug => 'フレーム / BLE デバッグ';

  @override
  String get bastionDiag_frameDebugHint => 'デコード済みおよび生の受信フレームを調べます';

  @override
  String get bastionDiag_appLog => 'アプリのデバッグログ';

  @override
  String get bastionDiag_appLogHint => 'アプリの診断イベントを確認します';

  @override
  String get bastionDiag_online => '無線機オンライン';

  @override
  String get bastionDiag_offline => '無線機オフライン';

  @override
  String get bastionDiag_offlineHint => 'MeshCore コンパニオンを接続するとライブ診断が表示されます。';

  @override
  String get coverage_title => 'カバレッジ記録';

  @override
  String get coverage_leaveBlocked => '離れる前にセッションを停止して保存してください。';

  @override
  String get coverage_savedSessions => '保存済みセッション';

  @override
  String get coverage_caveat =>
      'RSSI/SNRは無線機のスナップショットで、別のパケットのものかもしれません。位置は無線機が発信した座標で、端末のGPSでもカバレッジの証明でもありません。シアン: 記録者、アンバー: 発信ノード。補間は行いません。';

  @override
  String get coverage_captureActive => '記録中';

  @override
  String get coverage_fieldSession => 'フィールドカバレッジセッション';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core Ham はこのセッション中に新たに受信したノードを記録します。ルートデータ、ノード/位置のメタデータ、最も近い無線機のRSSI/SNRスナップショットを含みます。';

  @override
  String get coverage_disconnectedBody =>
      '開始する前に無線機を接続してください。カバレッジ記録は接続中のコンパニオン無線機からメッシュの観測をリアルタイムで記録します。';

  @override
  String get coverage_observations => '観測';

  @override
  String get coverage_uniqueNodes => '固有ノード';

  @override
  String get coverage_elapsed => '経過時間';

  @override
  String get coverage_radioConnected => '無線機接続済み';

  @override
  String get coverage_noRadio => '無線機なし';

  @override
  String get coverage_gpsReady => '無線機gps準備完了';

  @override
  String get coverage_noGps => '無線機gpsなし';

  @override
  String get coverage_stopSave => '停止 + セッションを保存';

  @override
  String get coverage_start => 'カバレッジセッションを開始';

  @override
  String get coverage_exportJson => 'Jsonをエクスポート';

  @override
  String get coverage_exportCsv => 'Csvをエクスポート';

  @override
  String get coverage_liveObservations => 'ライブ観測';

  @override
  String get coverage_waiting => 'メッシュの活動を待機中';

  @override
  String get coverage_waitingBody =>
      'セッションを開始すると、新たに受信したアクティブなノードがここに表示されます。RSSI/SNRの値は無線機のスナップショットで、特定のパケットに一意に結び付けられるとは限りません。';

  @override
  String get coverage_signalNa => '信号 なし';

  @override
  String get coverage_snrNa => 'SNR なし';

  @override
  String get coverage_gpsUnavailable => '無線機GPSが利用できません';

  @override
  String coverage_pathLine(String path, String location) {
    return '経路: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'フラッド';

  @override
  String get coverage_pathDirect => '直接';

  @override
  String get coverage_shareSubject => 'NOTORYX Core Ham カバレッジセッション';

  @override
  String get coverage_shareText => 'NOTORYX Core Ham カバレッジ記録のエクスポート';

  @override
  String get coverage_historyTitle => '保存済みカバレッジセッション';

  @override
  String coverage_loadFailed(String error) {
    return 'セッションを読み込めませんでした: $error';
  }

  @override
  String get coverage_deleteTitle => '保存済みセッションを削除しますか?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の観測がこの端末から削除されます。',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'セッションを削除できませんでした: $error';
  }

  @override
  String get coverage_retention =>
      '完了した最新20件のセッションが保持されます。残したいセッションは共有してください。中断された記録は下から再度開けます。';

  @override
  String get coverage_noSessions => '保存済みセッションはまだありません。記録を停止すると保存されます。';

  @override
  String get coverage_interrupted => '中断された記録';

  @override
  String get coverage_saved => '保存済み';

  @override
  String get coverage_deleteTooltip => 'セッションを削除';

  @override
  String coverage_exportFailed(String error) {
    return 'エクスポートに失敗しました: $error';
  }

  @override
  String get coverage_sessionTitle => 'カバレッジセッション';

  @override
  String get coverage_shareJson => 'JSONを共有';

  @override
  String get coverage_shareCsv => 'CSVを共有';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • スナップショット経過 $age ms';
  }

  @override
  String get coverage_unknown => '不明';

  @override
  String coverage_pathValue(String path) {
    return '経路 $path';
  }

  @override
  String get coverage_recorder => '記録者';

  @override
  String get coverage_noCoordinates =>
      'このセッションには使用できる座標がありません。観測は下に引き続き表示されます。';

  @override
  String get coverage_osmAttribution => '© OpenStreetMap 貢献者 • オンライン背景地図';

  @override
  String get fieldStats_title => 'フィールド分析';

  @override
  String get fieldStats_snapshot => 'メッシュのライブスナップショット';

  @override
  String get fieldStats_headline => '今 NOTORYX Core Ham が把握していること。';

  @override
  String get fieldStats_body =>
      'これらの集計は、接続中の MeshCore の連絡先テーブル、位置、経路、最終確認時刻から計算されます。';

  @override
  String get fieldStats_total => '合計';

  @override
  String get fieldStats_chatNodes => 'チャットノード';

  @override
  String get fieldStats_rooms => 'ルーム';

  @override
  String get fieldStats_sensors => 'センサー';

  @override
  String get fieldStats_located => '位置あり';

  @override
  String get fieldStats_favorites => 'お気に入り';

  @override
  String get fieldStats_routeSnapshot => 'ルートのスナップショット';

  @override
  String get fieldStats_routed => 'ルートあり';

  @override
  String get fieldStats_direct => '直接';

  @override
  String get fieldStats_flood => 'フラッド';

  @override
  String get fieldStats_pathIntel => '経路分析';

  @override
  String get fieldStats_pathIntelBody =>
      'NOTORYX Core Ham のルート分析は、保存された経路の試行、ホップ数、成功/失敗、所要時間、ルートの重み付けを使って学習済みルートを表示します。';

  @override
  String get fieldStats_coverageSessions => 'カバレッジセッション';

  @override
  String get fieldStats_coverageSessionsBody =>
      'カバレッジ記録はフィールドセッションの保存、中断した作業の復元、観測のエクスポート、記録したカバレッジ地点の地図表示に対応しました。RSSI/SNRは引き続き最も近い無線機のスナップショットです。';

  @override
  String get mapHub_title => 'NOTORYX フィールドマップ';

  @override
  String get mapHub_intro =>
      'ライブマップ、オフラインエリア、地域プロファイル、NOTORYX Core Ham のフィールドカバレッジセッション。';

  @override
  String get mapHub_captureHint => 'フィールドカバレッジセッションを開始・停止';

  @override
  String get mapHub_badgeNew => '新機能';

  @override
  String get mapHub_liveMap => 'ライブメッシュマップ';

  @override
  String get mapHub_liveMapHint => 'ノード、リピーター、位置、ルート、地図ツール';

  @override
  String get mapHub_badgeLive => 'ライブ';

  @override
  String get mapHub_offlinePacks => 'オフライン地図パック';

  @override
  String get mapHub_offlinePacksHint => '行程や圏外エリア向けに地図タイルをキャッシュ';

  @override
  String get mapHub_badgeOffline => 'オフライン';

  @override
  String get mapHub_regions => '地域プロファイル';

  @override
  String get mapHub_regionsHint => '地域のメッシュ定義を管理・取得';

  @override
  String get replay_title => '1日を再生';

  @override
  String get replay_entryHint => '選んだ日にチームが移動した場所を再生';

  @override
  String get replay_badge => '履歴';

  @override
  String get replay_day => '日付';

  @override
  String get replay_team => 'チーム';

  @override
  String get replay_everyone => '全員';

  @override
  String get replay_emptyTeam =>
      'この日のチーム位置はありません。メンバーがチャンネルで追跡位置を共有すると表示されます。ノードのアドバートは「全員」で確認できます。';

  @override
  String get replay_emptyEveryone =>
      'この日の位置記録はありません。今後、アプリを開いている間にノードがアドバートする位置を記録します。';

  @override
  String replay_mapSummary(String time, int count) {
    return '$time の地図: $count 件表示';
  }

  @override
  String get replay_play => '再生';

  @override
  String get replay_pause => '一時停止';

  @override
  String get replay_speed => '速度';

  @override
  String replay_speedValue(int minutes) {
    return '1秒あたり$minutes分';
  }

  @override
  String replay_showNode(String name) {
    return '$name を表示/非表示';
  }

  @override
  String get replay_notYet => 'この時刻にはまだ未確認';

  @override
  String replay_lastSeen(String time, String lat, String lon) {
    return '最終確認 $time、$lat, $lon';
  }

  @override
  String get replay_explainer =>
      'チーム位置はメンバーがチャンネルで共有する追跡位置から取得します。「全員」ではノードがアドバートする位置も表示します。これはアプリを開いている間に記録され、30日間保存されます。何も送信しません。';

  @override
  String get mapHub_badgeRegions => '地域';

  @override
  String get routes_title => 'ルート分析';

  @override
  String get routes_headline => 'メッシュ内のトラフィックの流れを確認します。';

  @override
  String get routes_body =>
      'NOTORYX Core Ham は、実際のメッセージ送信や探索から学習済みの経路履歴を使って保存済みルートを順位付けします。';

  @override
  String get routes_routes => 'ルート';

  @override
  String get routes_success => '成功';

  @override
  String get routes_failed => '失敗';

  @override
  String get routes_routeMap => 'ルートマップ';

  @override
  String get routes_routeMapHint => 'ノードと経路を調べる';

  @override
  String get routes_discover => '探索';

  @override
  String get routes_discoverHint => '新しいルートを見つける';

  @override
  String get routes_learned => '学習済みルート';

  @override
  String get routes_none => 'ルート履歴はまだありません';

  @override
  String get routes_noneBody =>
      '通常どおりメッシュを使うか探索を実行してください。経路履歴が得られると、学習済みルートがここに表示されます。';

  @override
  String get routes_direct => '直接';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countルート',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return '最適  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  重み $weight  •  成功 $success / 失敗 $fail';
  }

  @override
  String routes_fastest(String ms) {
    return '既知の最速: $ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'フラッド: 成功 $success / 失敗 $fail';
  }

  @override
  String get repeaterTools_heroLabel => 'リピーター管理';

  @override
  String get repeaterTools_headline => 'メッシュを支えるインフラを管理します。';

  @override
  String get repeaterTools_body =>
      '検出したリピーターを選んで認証し、既存の MeshCore の状態、テレメトリー、近隣、設定、CLIツールを開きます。';

  @override
  String get repeaterTools_discovered => '検出済み';

  @override
  String get repeaterTools_tools => 'ツール';

  @override
  String get repeaterTools_available => '利用可能なリピーター';

  @override
  String get repeaterTools_unnamed => '名前のないリピーター';

  @override
  String get repeaterTools_statusTelemetry => '状態 + テレメトリー';

  @override
  String get repeaterTools_statusTelemetryBody =>
      '既存の管理機能でリピーターの状態とテレメトリーを確認します。';

  @override
  String get repeaterTools_neighbors => '近隣';

  @override
  String get repeaterTools_neighborsBody => '近隣のインフラとメッシュの関係を調べます。';

  @override
  String get repeaterTools_cli => 'CLI + 設定';

  @override
  String get repeaterTools_cliBody => '認証済みの管理者は既存のリピーターCLIと設定ツールを利用できます。';

  @override
  String get repeaterTools_empty =>
      'リピーターはまだ検出されていません。無線機を接続して、まずメッシュを探索してください。';

  @override
  String get rptTest_title => '近くのリピーターをテスト';

  @override
  String get rptTest_subtitle => 'ワンタップで直接届くリピーターを確認';

  @override
  String get rptTest_start => '今すぐテスト';

  @override
  String get rptTest_listening => '応答を待っています…';

  @override
  String rptTest_wait(int seconds) {
    return '次のテストまで $seconds 秒';
  }

  @override
  String rptTest_found(int count) {
    return '応答したリピーター: $count';
  }

  @override
  String get rptTest_none =>
      '直接届く範囲のリピーターから応答がありません。高い場所から、または1分後に再試行してください。古いファームウェアのリピーターはこのテストに応答しません。';

  @override
  String get rptTest_strong => '強い';

  @override
  String get rptTest_usable => '使用可';

  @override
  String get rptTest_weak => '弱い';

  @override
  String rptTest_unknown(String prefix) {
    return 'リピーター $prefix';
  }

  @override
  String rptTest_line(String there, String here, String rssi) {
    return '相手の受信 $there dB · 自分の受信 $here dB, $rssi dBm';
  }

  @override
  String rptTest_rowLabel(
    String name,
    String quality,
    String there,
    String here,
    String rssi,
  ) {
    return '$name、$quality。相手の受信 $there デシベル。自分の受信 $here デシベル、$rssi dBm。';
  }

  @override
  String get rptTest_notConnected => 'テストするには無線機を接続してください。';

  @override
  String get rptTest_explainer =>
      'ホップなしの探索要求を1回送るため、あなたの無線機を直接受信できるリピーターだけが応答します。最初の数値はリピーターがあなたを受信した強さ、2番目はあなたが受信した強さです。リピーターは応答回数を制限するため、テストは30秒間隔です。';

  @override
  String get notification_fieldAlertTitle => 'NOTORYX フィールドアラート';

  @override
  String get notification_checkInReminderTitle =>
      'NOTORYX Core Ham チェックインのリマインダー';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return '$tripで$minutes分間チェックインがありません。NOTORYX Core Ham を開いてチェックインしてください。';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return '$nameから$minutes分間応答がありません。緊急事態が確認されたわけではありません。';
  }

  @override
  String get notification_aTripContact => '行程の連絡先';

  @override
  String notification_checkInNotDelivered(String name) {
    return '$nameへのチェックインが配信されませんでした。「行程」から再送できます。';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return '$nameがSOSを確認しました';
  }

  @override
  String get settings_batterySaver => 'バッテリーセーバー';

  @override
  String get settings_batterySaverOn =>
      'オン: 無線機のバッテリーは10分ごと、GPSは5分ごと、統計は最大1分に1回、行程のチェックは1〜2分ごと。メッセージ、アラート、SOSは変わりません。';

  @override
  String get settings_batterySaverOff =>
      '無線機と行程の確認頻度を下げて、端末と無線機のバッテリーを節約します。メッセージ、アラート、SOSは変わりません。';

  @override
  String get settings_readAloud => '新着メッセージを読み上げ';

  @override
  String get settings_readAloudHelper =>
      'NOTORYX Core Ham を開いている間だけ。ミュートしたチャンネルは読み上げません。各メッセージのメニューからも読み上げできます。';

  @override
  String get settings_readAloudOff => 'オフ';

  @override
  String get settings_readAloudDirect => 'ダイレクトメッセージ';

  @override
  String get settings_readAloudAll => 'ダイレクトとチャンネルのメッセージ';

  @override
  String get chat_readAloud => '読み上げ';

  @override
  String get messageSearch_title => 'メッセージを検索';

  @override
  String get messageSearch_intro =>
      'この端末に保存されたすべてのダイレクトメッセージとチャンネルメッセージを検索します。';

  @override
  String messageSearch_noResults(String query) {
    return '「$query」を含むメッセージはありません。';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件一致',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return '最新の一致$count件を表示しています';
  }

  @override
  String get shortcuts_checkIn => 'チェックイン';

  @override
  String get shortcuts_trip => '行程';

  @override
  String get shortcuts_chats => 'チャット';

  @override
  String get shortcuts_map => 'マップ';

  @override
  String get sensor_liveUpdates => 'ライブ更新';

  @override
  String get sensor_intro =>
      '毎回問い合わせる代わりに、値が変化したときにセンサーから送信させます。読み取り権限でのログインが必要です。';

  @override
  String get sensor_watch => '変化を監視';

  @override
  String get sensor_loadFirst => '監視する値を選ぶには、先にテレメトリーを読み込んでください。';

  @override
  String sensor_watching(String readings, String time) {
    return '$timeまで$readingsを監視中。';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return '$timeまで$readingsを監視中 • 地域 $region。';
  }

  @override
  String get sensor_noChanges => 'まだ変化は報告されていません。';

  @override
  String sensor_lastUpdate(String time, int count) {
    return '最終更新 $time • $count件受信';
  }

  @override
  String get sensor_stop => 'ライブ更新を停止';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'ここで停止しました。センサーからの確認がないため、時間が切れると停止します。$error';
  }

  @override
  String get sensor_dialogBody => 'センサーは約1分ごとに確認し、選んだ値がしきい値を超えて変化すると更新を送信します。';

  @override
  String sensor_readingTitle(String label, String channel) {
    return '$label(ch $channel)';
  }

  @override
  String sensor_readingValue(String label, String channel, String value) {
    return '$label(ch $channel): $value';
  }

  @override
  String sensor_watchItem(String label, String channel, String delta) {
    return '$label(ch $channel)±$delta';
  }

  @override
  String sensor_updateOn(String delta) {
    return '$deltaの変化で更新';
  }

  @override
  String get sensor_changeThreshold => 'しきい値を変更';

  @override
  String sensor_capacity(int max, String used) {
    return 'センサーが監視できるのは最大$maxバイトの値です(使用中 $used)。';
  }

  @override
  String get sensor_for => '期間';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count時間',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => '開始';

  @override
  String sensor_thresholdTitle(String label) {
    return '$labelのしきい値';
  }

  @override
  String get sensor_typeTemperature => '温度';

  @override
  String get sensor_typeHumidity => '湿度';

  @override
  String get sensor_typePressure => '気圧';

  @override
  String get sensor_typeVoltage => '電圧';

  @override
  String get sensor_typeCurrent => '電流';

  @override
  String get sensor_typeLight => '照度';

  @override
  String get sensor_typeConcentration => '濃度';

  @override
  String get sensor_typePercentage => 'パーセント';

  @override
  String get sensor_typeAnalogInput => 'アナログ入力';

  @override
  String get sensor_typeAltitude => '高度';

  @override
  String get setupWizard_title => '無線機を接続';

  @override
  String get setupWizard_choose => '1. 接続方法を選ぶ';

  @override
  String get setupWizard_prepare => '2. 無線機を準備する';

  @override
  String get setupWizard_intro =>
      'このスマートフォンやパソコンを無線機にどう接続するか選んでください。無線機がメッシュでメッセージを運びます。';

  @override
  String get setupWizard_bluetooth => '近くの対応無線機にワイヤレスで接続します。';

  @override
  String get setupWizard_noBluetooth =>
      'このブラウザではBluetoothを使えません。ネイティブアプリか対応するUSB接続を使ってください。';

  @override
  String get setupWizard_usb => 'USBデータケーブルによる有線接続。';

  @override
  String get setupWizard_noUsb =>
      'ここではUSBシリアルを使えません。対応するデスクトップまたはAndroidアプリ、もしくはWeb Serial対応のChromeを使ってください。';

  @override
  String get setupWizard_bluetoothSteps =>
      '無線機の電源を入れて近くに置きます。Bluetoothをオンにしてアプリの使用を許可します。無線機に接続している他のアプリを閉じ、デバイス一覧を開いてスキャンします。';

  @override
  String get setupWizard_usbSteps =>
      '電源の入った無線機をUSBデータケーブルで接続します。充電専用ケーブルは使えません。他のシリアルアプリを閉じます。USBデバイス一覧を開いて無線機を選び、求められたらアクセスを許可します。';

  @override
  String get setupWizard_firmwareTitle => 'ファームウェアを変更する前に互換性を確認';

  @override
  String get setupWizard_firmware =>
      '無線機には、選んだ接続方法に対応したNOTORYX Hamコンパニオンファームウェアが必要です。対応状況はボードやファームウェアのビルドによって異なり、USBポートがあってもUSBシリアルに対応しているとは限りません。お使いのボードとインストール済みのビルドの説明を確認してください。リピーターやルームサーバーのファームウェアはコンパニオンではありません。接続に失敗しただけで書き直しが必要とは限りません。';

  @override
  String get setupWizard_settings =>
      'このガイドはファームウェアの書き込みや無線機の設定変更を行いません。接続後、地域・周波数・詳細オプションは設定から変更してください。変更前に地元のメッシュと設定を確認してください。';

  @override
  String get setupWizard_openBluetooth => 'Bluetoothデバイスを開く';

  @override
  String get setupWizard_openUsb => 'USBデバイスを開く';

  @override
  String get setupWizard_change => '接続方法を変更';

  @override
  String get setupWizard_later => 'あとで設定';

  @override
  String get setupWizard_bluetoothError =>
      '無線機に接続できませんでした。電源を入れたまま近くに置き、Bluetoothの権限を確認し、接続中の他のアプリを閉じてから、もう一度スキャンしてください。';

  @override
  String get setupWizard_scanError =>
      '無線機をスキャンできませんでした。Bluetoothをオンにし、システム設定でBluetoothまたは付近のデバイスへのアクセスを許可してから、もう一度スキャンしてください。';

  @override
  String get setupWizard_usbError =>
      'USBで接続できませんでした。データケーブルと選んだデバイスを確認し、USBアクセスを許可し、他のシリアルアプリを閉じてください。ケーブルを挿し直して再試行してください。';

  @override
  String get connections_title => '接続';

  @override
  String get connections_radioTitle => '無線機の接続';

  @override
  String get connections_bluetoothOffNotice =>
      'Bluetoothがオフです。再接続するにはオンにしてください。オンに戻るとアプリが再試行します。';

  @override
  String get connections_transport => '接続方法';

  @override
  String connections_lastError(String error) {
    return '前回のエラー: $error';
  }

  @override
  String get connections_disconnectRadio => '無線機を切断';

  @override
  String connections_reconnectTo(String name) {
    return '$name に再接続';
  }

  @override
  String get connections_forgetRadio => '無線機を削除';

  @override
  String get connections_connectAnother => '別の無線機を接続';

  @override
  String get connections_usbSerial => 'USBシリアル';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'デバイス';

  @override
  String get connections_publicKey => '公開鍵';

  @override
  String get connections_firmware => 'ファームウェア';

  @override
  String connections_firmwareProtocol(String code) {
    return 'プロトコル v$code';
  }

  @override
  String get connections_battery => 'バッテリー';

  @override
  String get connections_lastRx => '最終受信';

  @override
  String get connections_reconnectFailed => '無線機に再接続できませんでした';

  @override
  String get connections_statusBluetoothOff => 'Bluetoothがオフです';

  @override
  String get connections_statusConnected => '接続済み';

  @override
  String get connections_statusConnecting => '接続中…';

  @override
  String get connections_statusDisconnecting => '切断中…';

  @override
  String get connections_statusScanning => '無線機を検索中…';

  @override
  String get connections_statusReconnectingSoon => 'まもなく再接続…';

  @override
  String get connections_statusNotConnected => '未接続';

  @override
  String get mqtt_cardTitle => 'MQTT接続';

  @override
  String get mqtt_statusNotConfigured => '未設定';

  @override
  String get mqtt_statusDisconnected => '切断';

  @override
  String get mqtt_statusConnecting => '接続中';

  @override
  String get mqtt_statusConnected => '接続済み';

  @override
  String get mqtt_statusReconnecting => '再接続中';

  @override
  String get mqtt_statusError => '接続エラー';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'ブローカー: $host:$port（$transport）';
  }

  @override
  String get mqtt_tokenSignIn => '無線機が署名したトークンでサインイン';

  @override
  String mqtt_tokenSignInAs(String username) {
    return '無線機が署名したトークンで $username… としてサインイン';
  }

  @override
  String get mqtt_connectRadioToSignIn => 'サインインするには無線機を接続してください';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'トークンは $time に更新されます';
  }

  @override
  String mqtt_signedInAs(String username) {
    return '$username としてサインイン中';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return '$topic を受信中';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'パケット: 新規 $accepted、重複 $duplicate、無効 $invalid';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return '再試行 $attempt/$max';
  }

  @override
  String get mqtt_sharingWaitsForRadio => '共有は無線機の接続を待っています';

  @override
  String mqtt_sharingOn(String topic) {
    return '$topic に共有中';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return '$topic に共有予定';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'オンライン状態を $topic に送信';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return '共有 $shared、保留 $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'ブローカーを追加すると、MeshCoreのトラフィックをインターネット経由でつなげます。無線機の接続はそれとは別に動作します。';

  @override
  String get mqtt_disconnect => 'MQTTを切断';

  @override
  String get mqtt_connect => 'MQTTに接続';

  @override
  String get mqtt_packetFeed => 'パケットフィード';

  @override
  String get mqtt_setUpBroker => 'ブローカーを設定';

  @override
  String get mqtt_brokerSettings => 'ブローカー設定';

  @override
  String get mqtt_settingsTitle => 'MQTTブローカー設定';

  @override
  String get mqtt_presetLabel => 'プリセットから始める';

  @override
  String get mqtt_presetCustom => 'カスタムブローカー';

  @override
  String get mqtt_presetLocal => 'ローカルブローカー（アドレスを設定）';

  @override
  String get mqtt_presetLetsMeshUs => 'LetsMeshアナライザー（米国、コミュニティ）';

  @override
  String get mqtt_presetLetsMeshEu => 'LetsMeshアナライザー（EU、コミュニティ）';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMeshはコミュニティが運営するMeshCoreパケットアナライザーで、NOTORYXの一部ではなく、NOTORYXが推奨するものでもありません。共有には無線機の接続が必要で、オンにするまでオフのままです。';

  @override
  String get mqtt_hostname => 'ブローカーのホスト名';

  @override
  String get mqtt_port => 'ポート';

  @override
  String get mqtt_useTls => 'TLSを使用';

  @override
  String get mqtt_allowCleartext => 'ローカルブローカーへの平文通信を許可';

  @override
  String get mqtt_allowCleartextHint =>
      'localhost、.local、プライベートな 10.x / 192.168.x ホストのみ。';

  @override
  String get mqtt_useWebSocket => 'WebSocketを使用';

  @override
  String get mqtt_webSocketPath => 'WebSocketパス';

  @override
  String get mqtt_topicPrefix => 'トピックの接頭辞';

  @override
  String get mqtt_region => '地域（任意）';

  @override
  String get mqtt_regionHelp => '観測者の地域コード（例: PHL）。空欄ですべて。';

  @override
  String get mqtt_deliverChannel => 'MQTTで受信したチャンネルメッセージを追加';

  @override
  String get mqtt_deliverChannelHint =>
      '観測者が受信した、参加中チャンネルのメッセージがチャットに表示されます。無線機からは送信されません。';

  @override
  String get mqtt_sharingTitle => '観測者として共有';

  @override
  String get mqtt_share => '無線機が受信したパケットを共有';

  @override
  String get mqtt_shareHint =>
      '無線機が受信したアドバートとチャンネルのトラフィックを、公開鍵・信号強度・地域とともに公開します。チャンネルメッセージは暗号化されたままです。地域の設定が必要です。';

  @override
  String get mqtt_shareDirect => 'ダイレクトメッセージのトラフィックを含める';

  @override
  String get mqtt_shareDirectHint =>
      'リクエスト、応答、ダイレクトメッセージ。内容は暗号化されたままですが、どのノード同士が通信しているかがわかります。';

  @override
  String get mqtt_shareOwn => '自分のメッセージとアドバートを含める';

  @override
  String get mqtt_signInTitle => 'サインイン';

  @override
  String get mqtt_authPassword => 'ユーザー名とパスワード';

  @override
  String get mqtt_authToken => '無線機が署名したトークン';

  @override
  String get mqtt_tokenExplain =>
      '無線機が自身の鍵で1時間有効なサインイントークンに署名し、アプリが期限前に更新します。鍵が無線機の外に出ることはありません。ユーザー名は v1_ と無線機の公開鍵です。';

  @override
  String get mqtt_radioReady => '無線機接続済み: サインインできます。';

  @override
  String get mqtt_radioNeeded => 'サインインするには無線機を接続してください。MQTTは接続を待っています。';

  @override
  String get mqtt_username => 'ユーザー名（任意）';

  @override
  String get mqtt_password => 'パスワード';

  @override
  String get mqtt_keepPassword => '保存済みのパスワードを使う場合は空欄のままにしてください。';

  @override
  String get mqtt_credentialsWeb => 'ブラウザーでは、認証情報はページを閉じるまでしか保持されません。';

  @override
  String get mqtt_credentialsKeychain =>
      '認証情報はシステムのキーチェーンに保存され、アプリの設定やログには保存されません。';

  @override
  String get mqtt_saveSettings => '設定を保存';

  @override
  String get mqtt_feedTitle => 'MQTTパケットフィード';

  @override
  String get mqtt_feedConnect => 'ブローカーに接続すると観測者のパケットが表示されます。';

  @override
  String mqtt_feedWaiting(String topic) {
    return '$topic のパケットを待っています';
  }

  @override
  String get mqtt_feedUnknownObserver => '不明な観測者';

  @override
  String mqtt_feedHeardBy(String observer) {
    return '受信: $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return '$hopsホップ · $bytesバイト';
  }

  @override
  String get mqtt_packetRequest => 'リクエスト';

  @override
  String get mqtt_packetResponse => '応答';

  @override
  String get mqtt_packetDirectMessage => 'ダイレクトメッセージ';

  @override
  String get mqtt_packetAck => '確認応答';

  @override
  String get mqtt_packetAdvert => 'アドバート';

  @override
  String get mqtt_packetChannelMessage => 'チャンネルメッセージ';

  @override
  String get mqtt_packetChannelData => 'チャンネルデータ';

  @override
  String get mqtt_packetAnonymousRequest => '匿名リクエスト';

  @override
  String get mqtt_packetPath => '経路';

  @override
  String get mqtt_packetTrace => 'トレース';

  @override
  String get mqtt_packetMultipart => 'マルチパート';

  @override
  String get mqtt_packetControl => '制御';

  @override
  String mqtt_packetType(int type) {
    return 'タイプ $type';
  }

  @override
  String get mqtt_routeTransportFlood => 'トランスポート付きフラッド';

  @override
  String get mqtt_routeFlood => 'フラッド';

  @override
  String get mqtt_routeDirect => 'ダイレクト';

  @override
  String get mqtt_routeTransportDirect => 'トランスポート付きダイレクト';

  @override
  String get mqtt_noticeInvalidHost => 'スキームやポートを含まないホスト名またはIPv4アドレスを入力してください。';

  @override
  String get mqtt_noticeInvalidPort => 'ポートは1〜65535の範囲で指定してください。';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'WebSocketパスは / で始め、クエリやフラグメントを含めないでください。';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'トピックの接頭辞は、ワイルドカードを含まない空でないMQTTパスにしてください。';

  @override
  String get mqtt_noticeInvalidRegion => '地域は2〜8文字の英数字にしてください（例: PHL）。';

  @override
  String get mqtt_noticeTlsRequired =>
      'ローカルブローカーへの安全でないアクセスを明示的に許可しない限り、TLSが必要です。';

  @override
  String get mqtt_noticeCleartextLocalOnly => '平文のMQTTは、明示的に許可したローカルホストに限られます。';

  @override
  String get mqtt_noticeRegionNeededToShare => '観測者としてパケットを共有するには地域を設定してください。';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return '$username のパスワードを入力してください。';
  }

  @override
  String get mqtt_noticeNoNetwork => 'ネットワークに接続されていません。回復するとMQTTが再接続します。';

  @override
  String get mqtt_noticeSubscriptionRefused => 'ブローカーがパケットの購読を拒否しました。';

  @override
  String get mqtt_noticeBadCredentials => 'ブローカーがユーザー名またはパスワードを拒否しました。';

  @override
  String get mqtt_noticeNotAuthorized => 'このアカウントにはブローカーの権限がありません。';

  @override
  String get mqtt_noticeConnectionRefused => 'ブローカーが接続を拒否しました。';

  @override
  String get mqtt_noticeUnreachable => 'ブローカーに接続できませんでした。';

  @override
  String get mqtt_noticeTlsFailed => '安全な（TLS）接続を確立できませんでした。';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'このプラットフォームはWebSocket経由のMQTTのみ対応しています。';

  @override
  String get mqtt_noticeRadioNotConnected => '無線機の鍵でサインインするには無線機を接続してください。';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'この無線機のファームウェアは自身の鍵による署名に対応していません。';

  @override
  String get mqtt_noticeSigningTimeout =>
      '無線機が署名リクエストに応答しませんでした。ファームウェアが署名に対応していない可能性があります。';

  @override
  String get mqtt_noticeSigningTooLong => 'データが長すぎて無線機で署名できません。';

  @override
  String get mqtt_noticeSigningRejected => '無線機がデータへの署名を拒否しました。';

  @override
  String get scanner_signalStrong => '強い';

  @override
  String get scanner_signalGood => '良好';

  @override
  String get scanner_signalFair => '普通';

  @override
  String get scanner_signalWeak => '弱い';

  @override
  String get scanner_nearbyRadios => '近くの無線機';

  @override
  String get scanner_lastRadio => '前回の無線機';

  @override
  String get scanner_reconnect => '再接続';

  @override
  String get scanner_tcpHint => 'ネットワーク上の Wi‑Fi ファームウェア搭載無線機。';

  @override
  String get scanner_otherWays => 'その他の接続方法';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '近くの無線機 $count台',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => '無線機を探しています…';

  @override
  String get scanner_findTitle => '無線機を探す';

  @override
  String get scanner_heroHint =>
      '無線機の電源を入れ、数メートル以内に置いてください。NOTORYX Ham companion ファームウェアが必要です。';

  @override
  String get scanner_tipsTitle => '無線機が表示されませんか？';

  @override
  String get scanner_tipPower => '電源が入っていて起動しているか確認してください。';

  @override
  String get scanner_tipFirmware =>
      'NOTORYX Ham companion ファームウェアが必要です。リピーターとルームサーバーはここに表示されません。';

  @override
  String get scanner_tipOtherDevice =>
      '無線機は一度に1台の端末にしか接続できません。ほかのスマートフォンやパソコンから切断してください。';

  @override
  String get connections_internetBridge => 'インターネットブリッジ';

  @override
  String get connections_noRadio => '無線機なし';

  @override
  String get connections_radioSettings => '無線設定';

  @override
  String get connections_viewDashboard => '接続ダッシュボードを表示';

  @override
  String get channelDirectory_title => 'チャンネル一覧';

  @override
  String get channelDirectory_subtitle => '近くの公開ハッシュタグチャンネルを探す';

  @override
  String get channelDirectory_search => 'チャンネルや地名を検索';

  @override
  String get channelDirectory_nearYou => '近くのチャンネル';

  @override
  String get channelDirectory_all => 'すべてのチャンネル';

  @override
  String get channelDirectory_catAll => 'すべて';

  @override
  String get channelDirectory_catEmergency => '緊急';

  @override
  String get channelDirectory_catLocal => '地域';

  @override
  String get channelDirectory_catGeneral => '一般';

  @override
  String get channelDirectory_catInterest => '趣味';

  @override
  String get channelDirectory_catTest => 'テスト';

  @override
  String get channelDirectory_join => '参加';

  @override
  String get channelDirectory_joined => '参加済み';

  @override
  String get channelDirectory_noMatches => '検索に一致するチャンネルはありません。';

  @override
  String get channelDirectory_connectFirst => 'チャンネルに参加するには無線機を接続してください。';

  @override
  String get channelDirectory_slotsFull =>
      '無線機のチャンネル枠がすべて使用中です。先にチャンネルを削除してください。';

  @override
  String get channelDirectory_joinFailed => 'チャンネルを追加できませんでした。もう一度お試しください。';

  @override
  String get channelDirectory_addHint =>
      'チャンネルが見つかりませんか？GitHub の共有リストを編集すれば誰でも提案できます。';

  @override
  String get prefixTool_title => 'リピーターID';

  @override
  String get prefixTool_subtitle => 'IDの使用者、重複しているID、新しいリピーター用の空きIDを確認';

  @override
  String get prefixTool_width => 'パスIDのサイズ';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytesバイト';
  }

  @override
  String get prefixTool_includeCompanions => 'コンパニオンとセンサーも含める';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return '既知のノード $nodes · 使用中のID $used · 重複 $shared';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return '空きID $free / $space';
  }

  @override
  String get prefixTool_lookupHint => 'IDを検索（例: 3D）';

  @override
  String prefixTool_lookupFree(String id) {
    return '$id を使う既知のノードはありません。';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$id を使うノード: $count台',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => '重複しているID';

  @override
  String get prefixTool_sharedHint => 'メッシュがより長いIDを使わない限り、これらのIDを通る経路は区別できません。';

  @override
  String get prefixTool_noShared => '既知のノードに重複したIDはありません。';

  @override
  String get prefixTool_free => '空きID';

  @override
  String get prefixTool_shuffle => '別の候補';

  @override
  String get prefixTool_makeKey => 'キーを作成';

  @override
  String get prefixTool_onlyKnown =>
      '無線機が受信したノードだけに基づきます。ここで空いているIDも、受信していないリピーターが使っている可能性があります。';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id はすでに $name が使っています。';
  }

  @override
  String get prefixTool_pickFree => '空きIDを選ぶ';

  @override
  String keyGen_title(String id) {
    return 'ID $id のキー';
  }

  @override
  String keyGen_searching(int tries) {
    return '検索中… $tries個のキーを試行';
  }

  @override
  String get keyGen_publicKey => '公開鍵';

  @override
  String get keyGen_privateKey => '秘密鍵';

  @override
  String get keyGen_copy => 'コピー';

  @override
  String get keyGen_copied => 'コピーしました';

  @override
  String get keyGen_secretWarning => '秘密鍵は秘密にしてください。持っている人はこのノードになりすませます。';

  @override
  String get keyGen_howToUse =>
      'リピーターで使うには、リピーターの設定を開き、秘密鍵として貼り付けて保存します。コンパニオン無線機にはキーのインポートを許可するファームウェアが必要です。';

  @override
  String get keyGen_tryAgain => 'もう一つ作成';

  @override
  String get regionSetup_title => 'リージョン設定';

  @override
  String get regionSetup_hubSubtitle => 'このリピーターを地域のリージョンツリーに配置';

  @override
  String get regionSetup_intro =>
      'リージョンを使うと、メッシュ全体にフラッドせず、メッセージを一定の範囲内に留められます。リピーターはそのリージョンを持っている場合だけ転送するので、自分のリージョンとその上位すべてを設定してください。';

  @override
  String get regionSetup_where => 'リピーターの場所は？';

  @override
  String get regionSetup_tree => 'リージョンツリー';

  @override
  String get regionSetup_custom => 'カスタム';

  @override
  String get regionSetup_region => '最も狭いリージョン';

  @override
  String get regionSetup_customLabel => 'リージョン（広い順）';

  @override
  String regionSetup_invalidName(String name) {
    return '「$name」は有効なリージョン名ではありません。小文字、数字、ハイフンで29文字以内にしてください。';
  }

  @override
  String regionSetup_tooMany(int max) {
    return 'リピーターに設定できるリージョンは最大$max個です。';
  }

  @override
  String get regionSetup_options => 'オプション';

  @override
  String get regionSetup_setDefault => '最も狭いリージョンを既定にする';

  @override
  String get regionSetup_setDefaultBody => 'リピーター自身のアドバートはそのリージョン内に留まります。';

  @override
  String get regionSetup_legacy => 'ファームウェア 1.14';

  @override
  String get regionSetup_legacyBody =>
      '各リージョンの後に region allowf を追加します。1.15以降は不要です。';

  @override
  String get regionSetup_denyUnscoped => 'リージョンなしのメッセージを転送しない';

  @override
  String get regionSetup_denyUnscopedBody =>
      '地域全体がリージョンを使うようになってから有効にしてください。そうしないと古いアプリからのメッセージが届きません。';

  @override
  String get regionSetup_commands => 'コマンド';

  @override
  String get regionSetup_copyAll => 'すべてコピー';

  @override
  String get regionSetup_copied => 'コピーしました';

  @override
  String get regionSetup_pickFirst => 'リージョンを選ぶとコマンドが表示されます。';

  @override
  String regionSetup_sendTo(String name) {
    return '$name に送信';
  }

  @override
  String get regionSetup_howToSend =>
      '送信するには、リピーターにログインしてメニューからリージョン設定を開くか、コマンドラインに貼り付けてください。';

  @override
  String get regionSetup_noReply => '応答なし。ここで停止しました。';

  @override
  String get regionSetup_addToMine => 'これらのリージョンをリストに追加';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'リストに$count件のリージョンを追加しました',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => 'トラックログ';

  @override
  String get trackLog_subtitle => '無線機のGPSで移動の軌跡を記録';

  @override
  String get trackLog_recording => '記録中';

  @override
  String get trackLog_notRecording => '記録していません';

  @override
  String get trackLog_noGps => '無線機がGPS位置を送っていません。トラックログにはGPSをオンにした無線機が必要です。';

  @override
  String get trackLog_start => '記録を開始';

  @override
  String get trackLog_stop => '記録を停止';

  @override
  String get trackLog_howItWorks =>
      'NOTORYX Core Ham を開いている間、無線機が約1分ごとに送る位置を使います。25 m 移動するか、止まっている間は15分ごとに点が追加されます。';

  @override
  String get trackLog_snap => '位置を約100 mに丸める';

  @override
  String get trackLog_snapBody => 'トラックを共有するときのプライバシー保護のため。';

  @override
  String get trackLog_saved => '保存したトラック';

  @override
  String get trackLog_none => 'まだトラックはありません。';

  @override
  String get trackLog_export => 'GPXで書き出す';

  @override
  String get trackLog_exportFailed => 'トラックを書き出せませんでした。';

  @override
  String get trackLog_deleteTitle => 'このトラックを削除しますか？';

  @override
  String get trackLog_deleteBody => 'この端末から削除されます。書き出したGPXファイルには影響しません。';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km km · $duration · $points点';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'NOTORYX トラック $when';
  }

  @override
  String get routes_nearbyTitle => '近くの最適なリピーター';

  @override
  String get routes_nearbyEmptyTitle => 'まだリピーターを受信していません';

  @override
  String get routes_nearbyEmpty =>
      '無線機が直接受信したリピーターが、通信を受けるたびに強い順にここへ表示されます。直近1時間が対象です。';

  @override
  String get routes_unknownRepeater => '不明なリピーター';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count回受信',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes分前',
      zero: 'たった今',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return '経由: $names';
  }

  @override
  String get nav_home => 'ホーム';

  @override
  String get nav_chats => 'チャット';

  @override
  String get nav_tools => 'ツール';

  @override
  String get nav_settings => '設定';

  @override
  String get nav_more => 'その他';

  @override
  String get tools_groupApp => 'アプリと設定';

  @override
  String get tools_groupField => 'フィールド';

  @override
  String get tools_groupMaps => 'マップとカバレッジ';

  @override
  String get tools_groupRouting => 'ルートとリピーター';

  @override
  String get tools_pathGraph => '経路グラフ';

  @override
  String get tools_pathGraphHint => 'メッセージの届き方：受信したすべての経路と、最も混雑したリピーター';

  @override
  String get tools_antenna => 'アンテナカバレッジ';

  @override
  String get tools_antennaHint => '地形上でアンテナが届く範囲を推定';

  @override
  String routes_repeaterWithId(String id) {
    return 'リピーター $id';
  }

  @override
  String get signedCov_section => '署名付きレポート';

  @override
  String get signedCov_share => '署名付きレポートを共有';

  @override
  String get signedCov_shareHint =>
      '各六角形はこの電話のカバレッジ鍵で署名されるため、改ざんや捏造を見分けられます。共有しない限り電話の外には出ません。';

  @override
  String get signedCov_check => 'レポートを確認';

  @override
  String get signedCov_checkHint => '署名付きレポートを貼り付けて、本物の観測を確認';

  @override
  String get signedCov_paste => '署名付きレポート (JSON)';

  @override
  String get signedCov_verify => '確認';

  @override
  String signedCov_yourKey(String fingerprint) {
    return 'あなたのカバレッジ鍵: $fingerprint';
  }

  @override
  String signedCov_result(int accepted, int rejected) {
    return '$accepted 件の観測を確認、$rejected 件を拒否';
  }

  @override
  String signedCov_signer(String fingerprint) {
    return '署名鍵 $fingerprint';
  }

  @override
  String get signedCov_unreadable => 'これは署名付きカバレッジレポートではありません。';

  @override
  String signedCov_rBadSignature(int count) {
    return '署名なしまたは不正: $count 件';
  }

  @override
  String signedCov_rMalformed(int count) {
    return '破損: $count 件';
  }

  @override
  String signedCov_rImpossible(int count) {
    return 'ありえない信号値: $count 件';
  }

  @override
  String signedCov_rFuture(int count) {
    return '未来の日付: $count 件';
  }

  @override
  String get signedCov_empty => '共有できるカバレッジのサンプルはまだありません。';

  @override
  String get signedCov_shareFailed => 'レポートを共有できませんでした。';

  @override
  String get coverageHex_title => 'カバレッジ六角形';

  @override
  String get coverageHex_toolSubtitle => '無線機がメッシュを受信できる場所を地図にして共有';

  @override
  String get coverageHex_mapCoverage => 'カバレッジを記録';

  @override
  String get coverageHex_statusOff =>
      'オフ。運転中や歩行中にオンにすると、無線機がメッシュを受信できる場所を記録します。';

  @override
  String get coverageHex_waitingGps => 'GPS を待機中…';

  @override
  String coverageHex_gpsTooRough(String meters) {
    return 'GPS 精度 $meters m：粗すぎるため記録しません。';
  }

  @override
  String coverageHex_recording(String meters) {
    return '記録中。GPS 精度 $meters m。';
  }

  @override
  String get coverageHex_hexagons => '六角形';

  @override
  String get coverageHex_samples => 'サンプル';

  @override
  String get coverageHex_privacyNote =>
      'このスイッチがオンの間、スマートフォンの GPS を使います。共有されるのは六角形 ID（約 0.9 km）のみで、正確な位置は共有されません。';

  @override
  String get coverageHex_uploadSection => 'カバレッジマップへアップロード';

  @override
  String get coverageHex_wifiOnly => 'Wi-Fi 接続時のみアップロード';

  @override
  String get coverageHex_wifiOnlyHint =>
      'サンプルは Wi-Fi になるまでスマートフォンで待機します（最大 7 日）。';

  @override
  String coverageHex_waiting(String count) {
    return '$count 件待機中';
  }

  @override
  String get coverageHex_addMap => 'カバレッジマップを追加';

  @override
  String get coverageHex_addMapHint => 'カバレッジのアップロードを受け付ける HTTPS エンドポイント。';

  @override
  String get coverageHex_uploadNow => '今すぐアップロード';

  @override
  String get coverageHex_mapDialogTitle => 'カバレッジマップ';

  @override
  String get coverageHex_nameMissing => '名前を付けてください。';

  @override
  String get coverageHex_url => 'アップロード URL';

  @override
  String get coverageHex_urlInvalid => 'https:// の URL にしてください。';

  @override
  String get coverageHex_apiKey => 'API キー（任意）';

  @override
  String get coverageHex_apiKeyHint => 'X-API-Key として送信されます。';

  @override
  String get coverageHex_format => '形式';

  @override
  String get coverageHex_formatHex => '六角形 ID（NOTORYX）';

  @override
  String get coverageHex_formatMeshMapper => 'MeshMapper 互換';

  @override
  String get coverageHex_privacy => 'プライバシー';

  @override
  String get coverageHex_privacyLive => 'ライブ';

  @override
  String get coverageHex_privacyDelayed => '3 時間遅延';

  @override
  String get coverageHex_privacyAnonymous => '匿名、24 時間';

  @override
  String get coverageHex_privacyLiveHint => '約 15 分以内に送信。';

  @override
  String get coverageHex_privacyDelayedHint => '地図に現在地が表示されないよう 3 時間保留します。';

  @override
  String get coverageHex_privacyAnonymousHint =>
      '24 時間保留し、日付のみ・署名なしで送信するため、アップロード同士を結び付けられません。';

  @override
  String get coverageHex_uploadsOn => 'アップロードを有効化';

  @override
  String coverageHex_sent(String count, String time) {
    return '$time に $count セルを送信しました。';
  }

  @override
  String coverageHex_httpError(String code) {
    return '地図が $code を返しました。再試行します。';
  }

  @override
  String get coverageHex_unreachable => '地図に接続できません。再試行します。';

  @override
  String get coverageHex_noPermission => '位置情報の許可がありません。';

  @override
  String get coverageHex_noGps => 'GPS を利用できません。';

  @override
  String get coverageHex_loadFailed => '保存済みのカバレッジを読めません。最初からやり直します。';

  @override
  String get mqttExtra_wifiOnly => 'Wi-Fi 接続時のみ接続';

  @override
  String mqttExtra_backlog(String count) {
    return '$count 個のパケットがアップロード待ち（最大 72 時間保持）。';
  }

  @override
  String get mqttExtra_add => '別のブローカーを追加';

  @override
  String get mqttExtra_addBody =>
      '無線機が受信した内容を、メインとは別の MQTT ブローカーにも共有します。アップロード専用で、アプリにパケットを戻すことはありません。';

  @override
  String get mqttExtra_separateKey => '別のキーを使う';

  @override
  String get mqttExtra_separateKeyHint =>
      '無線機ではなくこのスマートフォンで作成したキーでサインインするため、このブローカーはアップロードを無線機に結び付けられません。';

  @override
  String mqttExtra_removeTitle(String name) {
    return '$name を削除しますか？';
  }

  @override
  String get mqttExtra_removeBody => '切断し、設定・パスワード・キー・送信待ちのパケットを削除します。';

  @override
  String mqttExtra_ownKey(String key) {
    return '独自のキーでサインイン：$key…';
  }

  @override
  String get botCmd_sun => '無線機の GPS 位置の日の出と日の入り。';

  @override
  String get botCmd_moon => '月相と照らされている割合。';

  @override
  String get botCmd_dice => 'サイコロを振ります：!dice、!dice 20、!dice 2d6。';

  @override
  String get botCmd_trace => '送信者のメッセージが経由したリピーターを一覧表示します。';

  @override
  String get ping_title => 'リピーター ping';

  @override
  String get ping_toolSubtitle => '近くのリピーターとの往復時間と双方向の信号';

  @override
  String get ping_noRepeaters => '既知のリピーターはまだありません';

  @override
  String get ping_choose => 'リピーターを選択';

  @override
  String get ping_avgMs => 'ms 往復';

  @override
  String get ping_snrThere => 'SNR 先方';

  @override
  String get ping_snrBack => 'SNR 受信';

  @override
  String get ping_loss => '損失';

  @override
  String ping_running(int done, int total) {
    return 'ping $done/$total…';
  }

  @override
  String ping_start(int count) {
    return '$count 回 ping';
  }

  @override
  String get ping_results => 'プローブ';

  @override
  String get ping_noReply => '応答なし';

  @override
  String ping_resultLine(String ms, String snr) {
    return '$ms ms · 先方 SNR $snr';
  }

  @override
  String get ping_explainer =>
      '各プローブは 1 ホップの経路トレースです。リピーターは受信品質を記録して送り返します。無線機が直接受信できるリピーターで使えます。';

  @override
  String get hunt_title => 'アンテナハント';

  @override
  String get hunt_toolSubtitle => '強くなるほど速くクリックする大きな信号メーター';

  @override
  String get hunt_noSignal => 'まだ信号なし';

  @override
  String get hunt_noReply => '応答なし — アンテナを動かすか向きを変えてください';

  @override
  String get hunt_heardHere => 'dB（こちらで受信）';

  @override
  String get hunt_best => '最高';

  @override
  String get hunt_sound => '強くなるほどクリック';

  @override
  String get hunt_soundHint => 'クリックごとに振動するので、画面を見ずに向きを合わせられます。';

  @override
  String get hunt_stop => '停止';

  @override
  String get hunt_start => 'ハント開始';

  @override
  String get hunt_explainer =>
      '約 1 秒ごとにリピーターを探査します。指向性アンテナを向けるか歩き回ってください。数値は無線機の受信の良さです。';

  @override
  String get settings_refreshRate => '無線機の更新頻度';

  @override
  String get settings_refreshFast => '速い';

  @override
  String get settings_refreshNormal => '標準';

  @override
  String get settings_refreshSlow => '遅い';

  @override
  String get settings_refreshFastHint => 'バッテリーは毎分、GPS は 30 秒ごと。新しい値、電池消費は多め。';

  @override
  String get settings_refreshNormalHint => 'バッテリーは 2 分ごと、GPS は毎分。';

  @override
  String get settings_refreshSlowHint => 'バッテリーは 6 分ごと、GPS は 3 分ごと。電池を節約。';

  @override
  String get settings_refreshSaverOn =>
      'バッテリーセーバーがオンのため、そちらの間隔になります（バッテリーは 10 分ごと）。';

  @override
  String get reach_check => 'オブザーバー到達を確認';

  @override
  String get reach_title => 'オブザーバー到達';

  @override
  String get reach_noHash =>
      'このメッセージはまだ調べられません。リピーターが無線機に中継し返していないため、パケット ID が不明です。';

  @override
  String get reach_unreachable =>
      'アナライザーに接続できません。インターネット接続か、設定のアナライザーのアドレスを確認してください。';

  @override
  String get reach_none =>
      'まだどのオブザーバーも受信していません。受信後少ししてからアップロードされるので、1 分後に再確認してください。';

  @override
  String get reach_observers => 'オブザーバー';

  @override
  String get reach_maxHops => '最大ホップ';

  @override
  String get reach_bestSnr => '最高 SNR';

  @override
  String reach_hops(int count) {
    return '$count ホップ先';
  }

  @override
  String get reach_explainer => 'オンラインアナライザーより：このパケットを受信してアップロードしたオブザーバー。';

  @override
  String get reach_checkAgain => '再確認';

  @override
  String get analyzer_title => 'オンラインアナライザー';

  @override
  String get analyzer_url => 'アナライザーのアドレス';

  @override
  String get analyzer_urlHint =>
      'CoreScope アナライザー（https://）。お住まいの地域をカバーするものを使います。';

  @override
  String get analyzer_reset => '既定値';

  @override
  String get analyzer_hint => 'どのオブザーバーがメッセージを受信したかの確認に使います。送るのはパケット ID だけです。';

  @override
  String get analyzer_hopLookup => '不明なリピーター名をオンラインで取得';

  @override
  String get analyzer_hopLookupHint =>
      'リピーター ID が連絡先にない場合、アナライザーに名前を問い合わせます。送るのは短い ID だけです。名前の末尾の「?」は、その ID を複数のリピーターが共有していることを示します。';

  @override
  String discovered_tray(int count) {
    return '近くで受信したチャンネル：$count';
  }

  @override
  String get discovered_title => '近くで受信、未参加';

  @override
  String discovered_heard(int count, String time) {
    return '$count 回受信・最終 $time';
  }

  @override
  String get discovered_ignore => '無視';

  @override
  String get discovered_ignoreAll => 'すべて無視';

  @override
  String get discovered_joinAll => 'すべて参加';

  @override
  String get discovered_explainer =>
      'チャンネルディレクトリにある公開チャンネルで、無線機が通信を受信したものです。いずれもキーでメッセージを復号して確認済みです。無視したチャンネルは表示されません。';

  @override
  String get mqtt_presetMeshRank => 'MeshRank（コミュニティ）';

  @override
  String get mqtt_presetMeshRankNote =>
      'MeshRank はコミュニティ運営の MeshCore ネットワークランキングで、NOTORYX の一部ではなく、推奨もしていません。サインイン不要：共有をオンにした後に限り、無線機のキーと地域コードでパケットが共有されます。';

  @override
  String get pathFilter_title => 'パス幅フィルター';

  @override
  String get pathFilter_firmwareNote =>
      '転送ルール対応のリピーターファームウェア（mikecarper/MeshCore）が必要です。公式 MeshCore ファームウェアはこのコマンドを拒否します。';

  @override
  String get pathFilter_width => 'パス幅';

  @override
  String get pathFilter_anyWidth => '任意の幅';

  @override
  String pathFilter_bytes(int n) {
    return '$n バイトのパス';
  }

  @override
  String get pathFilter_twoOrMore => '2 または 3 バイト（2+）';

  @override
  String get pathFilter_path => '適用対象';

  @override
  String get pathFilter_radio => '無線フラッド';

  @override
  String get pathFilter_bridge => 'ブリッジ';

  @override
  String get pathFilter_cross => 'クロスオーバー';

  @override
  String get pathFilter_bridgeCross => 'ブリッジとクロスオーバー';

  @override
  String get pathFilter_limit => '破棄ではなく制限';

  @override
  String get pathFilter_limitOn => '1 分あたり決まった数まで転送します。';

  @override
  String get pathFilter_drop => '一致するフラッドは転送されず破棄されます。';

  @override
  String get pathFilter_perMinute => '1 分あたり';

  @override
  String get pathFilter_rateInvalid => '1〜65534 を入力してください。';

  @override
  String get pathFilter_reviewNote =>
      'コマンド欄に入力するだけです。確認してから送信してください。先に「get fr」で既存のルールを確認できます。';

  @override
  String get pathFilter_useCommand => 'コマンドを使用';

  @override
  String get settings_linkPreviews => 'リンクプレビュー';

  @override
  String get settings_linkPreviewsHint =>
      'メッセージ内のリンクのタイトルを表示します。既定はオフ：ページを取得するとそのサイトに IP アドレスが伝わります。';

  @override
  String get guide_title => 'フィールドガイド';

  @override
  String get guide_subtitle => '基本、寒冷時のバッテリー、ソーラー、アンテナ';

  @override
  String get guide_secMesh => 'メッシュに参加する';

  @override
  String get guide_mesh1 =>
      'スマートフォンは Bluetooth・USB・Wi-Fi で無線機と、無線機は LoRa でメッシュと通信します。携帯の電波がなくてもメッセージは届きます。';

  @override
  String get guide_mesh2 =>
      'リピーターがメッセージを中継し、1 回の中継が 1 ホップです。ホップが少ないほど速く確実に届きます。';

  @override
  String get guide_mesh3 =>
      'メッセージは短く、混雑したチャンネルに送りすぎないでください。どのメッセージも共有の送信時間を使います。';

  @override
  String get guide_secCold => '寒冷時のバッテリー';

  @override
  String get guide_cold1 => '氷点下（0 °C）でリチウム電池を充電しないでください。永久に劣化します。';

  @override
  String get guide_cold2 => '無線機は上着の内側に。寒さで容量は減りますが、温まれば戻ります。';

  @override
  String get guide_cold3 =>
      '寒冷地の固定設置では、リチウムイオンより LiFePO4 が適しています。断熱・加温ボックスはどちらにも有効です。';

  @override
  String get guide_secSolar => 'リピーターのソーラー';

  @override
  String get guide_solar1 =>
      'リピーターの消費電力はごく小さいですが、パネルと電池は夏の日ではなく冬の最も暗い 1 週間に合わせて選びます。';

  @override
  String get guide_solar2 => 'パネルは赤道側に向け、冬は急角度に。雪や影がかからないようにします。';

  @override
  String get guide_secAntenna => 'アンテナと設置場所';

  @override
  String get guide_ant1 => '出力より高さ。数メートル高い無線機は机の上より遥かに遠くまで届きます。';

  @override
  String get guide_ant2 => 'アンテナは垂直に、金属から離し、使う周波数帯用のもの（例：日本は 920 MHz）を使います。';

  @override
  String get guide_secMore => '詳しく知る';

  @override
  String get guide_moreMeshcore => '公式 MeshCore プロジェクト';

  @override
  String get guide_moreCascadia => 'コミュニティガイド：入門、ウォードライビング、地域、ソーラー';

  @override
  String get post_signed => '署名済み';

  @override
  String get post_unverified => '未確認';

  @override
  String post_signedKnown(String name) {
    return '連絡先の $name が署名しました。';
  }

  @override
  String get post_signedUnknownKey =>
      '署名はありますが、連絡先の誰でもありません。送信者を連絡先に追加すると誰かが分かります。';

  @override
  String get post_unverifiedHint =>
      'この投稿には署名が付いていましたが一致しません。途中で変更されたか、名乗っている人からではない可能性があります。';

  @override
  String get settings_signPosts => 'すべてのチャンネル投稿に署名';

  @override
  String get settings_signPostsHint =>
      'チャンネルの SOS は常に署名されます。これをオンにするとすべての投稿に署名し、他の NOTORYX ユーザーが本当にあなたからだと分かります。署名ごとに 1 パケット送信が増えます。';

  @override
  String get tools_search => 'ツールと設定を検索';

  @override
  String get tools_noMatches => '検索に一致するツールはありません。';

  @override
  String get tools_bot => 'ボットモード';

  @override
  String get tools_botHint => 'チャンネルでの自動返信と!コマンド';

  @override
  String get botChannels_title => 'チャンネル';

  @override
  String get botChannels_hint =>
      'オンにしたチャンネルでも、ボットはそのチャンネル内で!コマンドに応答します。不在返信は送りません。';

  @override
  String get botChannels_none => 'この無線機にはまだチャンネルがありません。';

  @override
  String get advert_zeroHopHint => '直接受信できる無線機だけに届きます。リピーターは中継しません。';

  @override
  String get advert_floodHint => 'リピーターがメッシュ全体に中継します。通信時間が多くかかります。';

  @override
  String get radioPresets_custom => 'カスタム';

  @override
  String get radioPresets_search => 'プリセットを検索';

  @override
  String get radioPresets_suggested => 'お住まいの地域のおすすめ';

  @override
  String get radioPresets_community => 'コミュニティのプリセット';

  @override
  String get radioPresets_hint =>
      'MeshCore コミュニティが推奨するプリセットです。地元のメッシュで使われているものを選んでください。周波数・帯域幅・SF・CR を設定し、送信出力は変わりません。';

  @override
  String get mySensors_title => 'センサー';

  @override
  String get mySensors_refresh => 'センサーを読み取る';

  @override
  String get mySensors_reading => '無線機のセンサーを読み取り中…';

  @override
  String get mySensors_failed => '無線機が応答しませんでした。更新をタップして再試行してください。';

  @override
  String get mySensors_none => '無線機からのセンサー値はありません。';

  @override
  String get activeChannels_title => 'オンラインで活発';

  @override
  String activeChannels_messages(int count) {
    return '$count 件のメッセージ';
  }

  @override
  String activeChannels_source(String host) {
    return '$host のオブザーバーが受信した、使われているチャンネルです。地域を見るには設定でアナライザーを変更してください。';
  }

  @override
  String get fieldOps_checkInChannelLabel => 'チェックインの送信先チャンネル';

  @override
  String get fieldOps_checkInChannelHint =>
      '無線機の鍵で署名されるので、チャンネルの他の人に本当にあなたからだと分かります。旅行の連絡先には引き続き直接届きます。';

  @override
  String get channels_regionUnknown => '地域限定';

  @override
  String channels_regionSemantics(String region) {
    return '地域 $region 宛てに送信';
  }

  @override
  String get channels_regionUnknownSemantics => 'アプリが知らない地域宛てに送信';

  @override
  String get timeline_title => 'タイムライン';

  @override
  String get timeline_toolSubtitle => 'メッセージ、新しいノード、信号の変化、場所をひとつのフィードに';

  @override
  String get timeline_refresh => '再読み込み';

  @override
  String get timeline_search => 'タイムラインを検索';

  @override
  String get timeline_kindMessages => 'メッセージ';

  @override
  String get timeline_kindNodes => '新しいノード';

  @override
  String get timeline_kindSignal => '信号';

  @override
  String get timeline_kindPlaces => '場所';

  @override
  String timeline_messageFrom(String sender, String where) {
    return '$where の $sender';
  }

  @override
  String timeline_nodeJoined(String name) {
    return '初めて受信: $name';
  }

  @override
  String timeline_signalUp(String name, String from, String to) {
    return '$name: 信号が $from から $to dB に上昇';
  }

  @override
  String timeline_signalDown(String name, String from, String to) {
    return '$name: 信号が $from から $to dB に低下';
  }

  @override
  String timeline_placeSaved(String name) {
    return '場所を保存: $name';
  }

  @override
  String timeline_placeShared(String sender, String where) {
    return '$sender が $where で場所を共有';
  }

  @override
  String get timeline_empty => 'まだ何もありません。メッセージ、新しく受信したノード、信号の変化、場所がここに表示されます。';

  @override
  String get wardrive_title => 'ウォードライブ';

  @override
  String get wardrive_hint => '現在地から ping して、どのリピーターに届くかを地図化';

  @override
  String get wardrive_start => '開始';

  @override
  String get wardrive_stop => '停止';

  @override
  String get wardrive_pings => 'ping';

  @override
  String get wardrive_heard => '受信';

  @override
  String get wardrive_pinging => 'ping 中…';

  @override
  String get wardrive_waitPosition => 'スマートフォンまたは無線機の GPS 測位を待っています。';

  @override
  String get wardrive_waitRadio => 'ping するには無線機を接続してください。';

  @override
  String get wardrive_history => '履歴';

  @override
  String get wardrive_noSessions => 'まだ記録はありません。';

  @override
  String wardrive_sessionSummary(int pings, int heard) {
    return '$pings 回 ping · $heard 回受信';
  }

  @override
  String get wardrive_delete => '削除';

  @override
  String get wardrive_recentre => '現在地に戻る';

  @override
  String get wardrive_youAreHere => '現在地';

  @override
  String get wardrive_backToLive => '現在の記録に戻る';

  @override
  String get wardrive_noReplies => 'この ping を受信したリピーターはいません。';

  @override
  String wardrive_replyDetail(String there, String here) {
    return 'あなたを $there dB で受信 · あなたは $here dB で受信';
  }

  @override
  String get wardrive_explainer =>
      '各 ping はゼロホップの探索要求です。直接届くリピーターだけが応答し、チャンネルには何も投稿されません。位置はスマートフォンの GPS から取得し、ない場合は無線機の GPS を使います。';

  @override
  String get mapTelemetry_policy =>
      '保存された測定値は1時間後に薄く表示され、24時間後に非表示になります。更新すると1回の要求を送信します。ノードがテレメトリーを許可している必要があり、センサーにはログインが必要な場合があります。地図は自動で更新を要求しません。';

  @override
  String get autoConnect_title => '無線機に自動接続';

  @override
  String get autoConnect_hint => 'アプリを開くと、タップせずに前回の無線機へ再接続します。まだ圏外なら数回試します。';

  @override
  String get ham_licensedOperator => '免許を持つ運用者';

  @override
  String get ham_operatorIntro =>
      'NOTORYX Core Ham の無線機はアマチュア無線の免許（FCC Part 97）で送信します。送信内容は誰でも読むことができ、すべてのフレームに無線機名の先頭にあるコールサインが含まれます。';

  @override
  String get ham_yourStation => 'あなたの局';

  @override
  String get ham_callSign => 'コールサイン';

  @override
  String get ham_notUsCallsign => '米国のコールサインではありません';

  @override
  String get ham_licenceClass => '免許クラス';

  @override
  String get ham_licenceClassHelper => 'どのクラスも 33 cm と 70 cm を全面的に運用できます';

  @override
  String get ham_antennaSystem => 'アンテナ系';

  @override
  String get ham_antennaSystemHint => '下の出力の推定に使います。ないものは 0 のままにしてください。';

  @override
  String get ham_externalAmpGain => '外部アンプの利得';

  @override
  String get ham_feedlineLoss => '給電線の損失';

  @override
  String get ham_antennaGain => 'アンテナ利得';

  @override
  String get ham_coordination => '調整';

  @override
  String get ham_coordinationNotice =>
      'NOTORYX Core Ham は十分な調整を行ってから使ってください。無線機とレピーターは共用バンドで自動的に送信します。どの無線機も電波を出す前に、周波数調整担当者と相談し、地域のバンドプランに従い、地域のすべての運用者と 1 つのチャンネルを取り決めてください。';

  @override
  String get ham_readCoordinationGuide => '調整ガイドを読む';

  @override
  String get ham_acknowledgment => 'この免許を持っており、調整ガイドを読みました。送信する前に調整を行います。';

  @override
  String get ham_operatorSaved => '保存しました';

  @override
  String get ham_connectedRadio => '接続中の無線機';

  @override
  String get ham_nodeName => 'ノード名';

  @override
  String get ham_nodeNameOk => 'あなたのコールサインで始まっています';

  @override
  String get ham_nodeNameBad => 'コールサインで始まらないと無線機は送信しません';

  @override
  String ham_setNameTo(String callsign) {
    return '$callsign に設定';
  }

  @override
  String get ham_frequency => '周波数';

  @override
  String get ham_inHamBand => 'アマチュアバンド内';

  @override
  String get ham_outsideHamBands => '420–450 / 902–928 MHz の範囲外';

  @override
  String get ham_txPowerSetting => '送信出力の設定';

  @override
  String get ham_chipSetting => '無線チップの設定値';

  @override
  String get ham_firmware => 'ファームウェア';

  @override
  String get ham_estimatedOutput => '推定出力';

  @override
  String get ham_estimatedErp => '推定 ERP';

  @override
  String get ham_unknown => '不明';

  @override
  String get ham_unknownBoard => '不明なボード: アンプなしとして計算';

  @override
  String get ham_ampNone => 'アンプなし';

  @override
  String ham_ampGain(String db) {
    return 'アンプで約 +$db dB';
  }

  @override
  String get ham_ampVariable => 'アンプのレベル設定による';

  @override
  String ham_boardNote(String board, String note) {
    return '$board: $note';
  }

  @override
  String ham_measureFirst(String board) {
    return '$board。推定に頼る前に測定してください。';
  }

  @override
  String ham_outputNote(String board) {
    return '$board。推定値です。確実を期すため測定し、通信できる最小の出力を使ってください。';
  }

  @override
  String get ham_overSpreadSpectrum =>
      '10 W PEP を超えています。LoRa のようなスペクトラム拡散の上限です（§97.311）。下げてください。';

  @override
  String get ham_erpNote =>
      '給電線損失とアンテナ利得を考慮したダイポール比の値です。高出力では電波防護（§97.13）を確認してください。';

  @override
  String get ham_location => '場所';

  @override
  String get ham_noLocationLimits => '帯域の制限は見つかりません';

  @override
  String get ham_locationOkNote => '無線機の位置からの判断です。念のため §97.303 を確認してください。';

  @override
  String get ham_check => '要確認';

  @override
  String get ham_positionUnknown => '位置が不明です。運用場所の制限は §97.303 で確認してください。';

  @override
  String get ham_exclusion33cm =>
      'この地域は §97.303(g) の除外区域内とみられます。ここではアマチュア局は 33 cm で送信できません。';

  @override
  String get ham_lineA =>
      'ライン A の北側（カナダ国境付近）では 420–430 MHz は使えません。§97.303 を確認してください。';

  @override
  String get ham_statusOk => 'OK';

  @override
  String get ham_needsAttention => '要確認';

  @override
  String get ham_setupBanner => '送信する前に運用者の設定を完了してください';

  @override
  String get ham_setUp => '設定';

  @override
  String get ham_operatorCardIncomplete => 'コールサインを設定し、調整ガイドを読んでください';

  @override
  String get ham_nodeNameCallsignHelper =>
      'コールサインで始めてください（例:「W1AW」「W1AW Base」）';

  @override
  String get ham_repeaterNameNeedsCall =>
      '名前はレピーターのコールサインで始めてください（例:「N0RPT Hilltop」）。';

  @override
  String get ham_repeaterPasswordsSerial =>
      'パスワードはレピーターの USB シリアルコンソールで設定してください。電波で送ると誰でも読めてしまいます。';

  @override
  String get networks_title => 'ネットワーク';

  @override
  String get networks_hint => '近くのネットワークを探して記録';

  @override
  String get networks_yourNetwork => 'あなたのネットワーク';

  @override
  String get networks_scanTitle => 'ネットワークを探す';

  @override
  String get networks_scanExplainer =>
      '無線機はまったく同じ設定のネットワークしか受信できないため、スキャンでは設定を順に切り替えて受信し、最後に元に戻します。スキャン中は自分のメッシュから外れます。';

  @override
  String get networks_listenFor => '各ネットワークの受信時間';

  @override
  String networks_choose(int count) {
    return 'スキャンするネットワーク: $count';
  }

  @override
  String get networks_suggested => 'おすすめ';

  @override
  String get networks_start => 'スキャン開始';

  @override
  String get networks_cancel => 'スキャン停止';

  @override
  String networks_listening(String name, int step, int steps) {
    return '$name を受信中 ($step/$steps)';
  }

  @override
  String get networks_blockNoRadio => 'スキャンするには無線機を接続してください。';

  @override
  String get networks_blockSettings => '無線機の設定を待っています。';

  @override
  String get networks_blockSos => 'SOS 中はできません: スキャンするとメッシュから外れます。';

  @override
  String get networks_blockTrip => 'トリップ中はできません: スキャンするとメッシュから外れます。';

  @override
  String get networks_nearby => '近くのネットワーク';

  @override
  String get networks_nothingYet => 'まだネットワークは受信されていません。スキャンしてください。';

  @override
  String networks_heardSummary(int nodes, int packets, String snr) {
    return 'ノード $nodes · パケット $packets · SNR $snr dB';
  }

  @override
  String networks_lastHeard(String time) {
    return '最終受信 $time';
  }

  @override
  String networks_timesHeard(int count) {
    return '受信回数: $count';
  }

  @override
  String get networks_saved => '保存したネットワーク';

  @override
  String get networks_noSaved => '保存したネットワークはまだありません。';

  @override
  String get networks_add => 'ネットワークを追加';

  @override
  String get networks_join => '参加';

  @override
  String networks_joinConfirm(String name) {
    return '無線機を $name に切り替えますか? 現在のネットワークから離れます。送信出力は変わりません。';
  }

  @override
  String networks_joined(String name) {
    return '無線機は $name になりました。';
  }

  @override
  String get networks_log => 'ネットワークログ';

  @override
  String get networks_logEmpty => 'まだ記録はありません。';

  @override
  String get networks_showMap => '地図';

  @override
  String get networks_exportCsv => 'CSV を書き出す';

  @override
  String get networks_exportGpx => 'GPX を書き出す';

  @override
  String get networks_clearLog => 'ログを消去';

  @override
  String get networks_clearLogConfirm => '記録したネットワークをすべて削除しますか?';

  @override
  String get networks_name => '名前';

  @override
  String get networks_invalid => '設定を確認してください: MeshCore 無線機が受け付ける範囲外です。';

  @override
  String get networks_nodesHeard => '受信したノード';

  @override
  String get chat_resendNeedsRadio =>
      '送信されていません: 無線機を接続してからもう一度お試しください。メッセージは残っています。';

  @override
  String get quick_title => 'クイックメッセージ';

  @override
  String get quick_ok => 'OK';

  @override
  String get quick_onMyWay => '向かっています';

  @override
  String get quick_atCamp => 'キャンプにいます';

  @override
  String get quick_runningLate => '遅れます';

  @override
  String get quick_needHelp => '助けが必要です';

  @override
  String get quick_copyThat => '了解';

  @override
  String get quick_empty => 'クイックメッセージはありません。編集をタップして追加してください。';

  @override
  String get quick_add => '新しいクイックメッセージ';

  @override
  String get quick_reset => '既定に戻す';

  @override
  String get chat_stopRetrying => '再送を止める';

  @override
  String chat_addFirstBanner(String name) {
    return '$name があなたを連絡先に追加するまで、ダイレクトメッセージを読んだり返信したりできません。まだなら、アドバートを送るか連絡先を共有してください。';
  }

  @override
  String get map_goToMyPosition => '現在地に移動';

  @override
  String get map_positionUnavailable =>
      '位置情報を取得できません。位置情報をオンにするか、無線機の位置を設定してください。';

  @override
  String get contact_forgetAdvert => '最後のアドバートを忘れる';

  @override
  String get contact_forgetAdvertHint =>
      'このノードの時計がリセットされてからアドバートが更新されない場合、「最後のアドバートを忘れる」で次のアドバートを受け付けます。';

  @override
  String get contact_forgetAdvertDone => '完了しました。このノードの次のアドバートを受け付けます。';

  @override
  String get networks_modeQuick => 'クイック';

  @override
  String get networks_modeThorough => 'じっくり';

  @override
  String get networks_modeQuickHint =>
      '各ネットワークでゼロホップの短い ping を 1 回送り、数秒受信します。範囲内にリピーターがあるネットワークを見つけます。';

  @override
  String get networks_modeThoroughHint =>
      '受信のみで、各ネットワークで長めに聞きます。何も送信せず、誰かが送信すればリピーターのないネットワークも見つけます。';

  @override
  String networks_estimate(String time) {
    return '約 $time';
  }

  @override
  String discoveredContacts_selected(int count) {
    return '$count 件選択';
  }

  @override
  String get discoveredContacts_selectAll => 'すべて選択';

  @override
  String get discoveredContacts_addSelected => '選択項目を追加';

  @override
  String discoveredContacts_addAllShown(int count) {
    return '表示中をすべて追加 ($count)';
  }

  @override
  String discoveredContacts_addManyTitle(int count) {
    return '$count 件の連絡先を追加しますか?';
  }

  @override
  String discoveredContacts_roomLeft(int room) {
    return '無線機にはあと $room 件の連絡先を追加できます。';
  }

  @override
  String discoveredContacts_roomLimit(int room, int count) {
    return '無線機にはあと $room 件しか追加できないため、$count 件のうち最初の $room 件だけを追加します。';
  }

  @override
  String discoveredContacts_adding(int done, int total) {
    return '$done/$total を追加中…';
  }

  @override
  String discoveredContacts_addedMany(int count) {
    return '追加した連絡先: $count';
  }

  @override
  String discoveredContacts_addedSome(int added, int failed) {
    return '追加した連絡先: $added。追加できなかった連絡先: $failed。';
  }

  @override
  String get discoveredContacts_radioFull =>
      '無線機の連絡先リストがいっぱいです。先にいくつか削除してください。';

  @override
  String get fieldIntel_radioNow => '現在の無線機';

  @override
  String get fieldIntel_noRadio => 'ライブ値を表示するには無線機を接続してください。';

  @override
  String get fieldIntel_noise => 'ノイズ dBm';

  @override
  String get fieldIntel_lastSnr => '最新 SNR';

  @override
  String get fieldIntel_lastRssi => '最新 RSSI';

  @override
  String get fieldIntel_battery => 'バッテリー V';

  @override
  String fieldIntel_airtime(String sent, String received) {
    return '無線機起動後の送信時間: 送信 $sent、受信 $received';
  }

  @override
  String get fieldIntel_whoAround => '周りにいるノード';

  @override
  String get fieldIntel_m15 => '15 分';

  @override
  String get fieldIntel_h1 => '1 時間';

  @override
  String get fieldIntel_h24 => '24 時間';

  @override
  String get fieldIntel_older => 'それ以前';

  @override
  String get fieldIntel_lastHour => '直近 1 時間';

  @override
  String get fieldIntel_chartHint =>
      '各ノードを最後に受信した時刻を、過去 1 日分 1 時間ごとに表示します。バーをタップすると一覧が表示されます。';

  @override
  String get fieldIntel_mix => 'ノードの種類';

  @override
  String get fieldIntel_reach => '到達範囲';

  @override
  String get fieldIntel_hops1 => '1 ホップ';

  @override
  String get fieldIntel_hops2 => '2 ホップ';

  @override
  String get fieldIntel_hops3 => '3 ホップ以上';

  @override
  String get fieldIntel_noRoute => 'ルート未確定';

  @override
  String get fieldIntel_distance => '最も近い / 遠いノード';

  @override
  String get fieldIntel_noneLocated => '位置情報を持つ連絡先がありません。';

  @override
  String get fieldIntel_noPosition => '無線機に位置がないため、距離を計算できません。';

  @override
  String get fieldIntel_bestRepeaters => '直接受信できる最良のリピーター';

  @override
  String get fieldIntel_noneDirect => '過去 30 分間に直接受信したリピーターはありません。';

  @override
  String get fieldIntel_attention => '要確認';

  @override
  String get fieldIntel_allGood => '確認が必要なものはありません。';

  @override
  String fieldIntel_lowBattery(String volts) {
    return 'バッテリー低下: $volts V';
  }

  @override
  String fieldIntel_quietFavorite(String ago) {
    return 'お気に入り、$agoから受信なし';
  }

  @override
  String get fieldIntel_moreTools => 'その他のツール';

  @override
  String fieldIntel_nodeCount(int count) {
    return 'ノード: $count';
  }

  @override
  String get fieldIntel_none => 'ノードはありません。';

  @override
  String fieldIntel_lastHeard(String ago) {
    return '最終受信 $ago';
  }

  @override
  String get fieldIntel_showOnMap => '地図で表示';

  @override
  String get fieldIntel_openChat => 'チャットを開く';

  @override
  String get repeaterTools_login => 'ログイン';

  @override
  String get repeaterTools_heardDirect => '直接受信';

  @override
  String get repeaterTools_filterAll => 'すべて';

  @override
  String get repeaterTools_filterLowBattery => 'バッテリー低下';

  @override
  String get repeaterTools_hint =>
      'リピーターをタップすると詳細が表示され、そこからログインしてステータス、近隣、テレメトリー、コマンドラインを確認できます。';

  @override
  String get repeaterTools_noneMatch => '該当するリピーターはありません。';

  @override
  String get repeaterTools_toolsTitle => 'ツール';

  @override
  String get repeaterTools_regionSetupHint => '地域のリージョンツリーを調べてコマンドをコピーします';

  @override
  String get routes_failingOnly => '失敗したルートのみ';

  @override
  String get routes_contactDetails => '連絡先の詳細';

  @override
  String get links_contactTitle => '連絡先を追加しますか?';

  @override
  String get links_importAdvert => 'この連絡先を無線機に追加しますか?';

  @override
  String get links_connectFirst => '先に無線機を接続してから、もう一度リンクを開いてください。';

  @override
  String get links_added => '連絡先を追加しました';

  @override
  String get links_notContact => 'このリンクは MeshCore の連絡先ではありません。';

  @override
  String get radioBuzzer_title => '無線機のブザー';

  @override
  String get radioBuzzer_hint => '新着メッセージで無線機が鳴ります。ブザー付きの無線機でのみ表示されます。';

  @override
  String get radioBuzzer_failed => '無線機が変更を受け付けませんでした。もう一度お試しください。';

  @override
  String get appSettings_floodAttempts => 'フラッド送信の試行回数';

  @override
  String get appSettings_floodAttemptsSubtitle =>
      '直接送信が失敗した後、経路が変わった場合に備えてフラッドで再送する回数です。1 回ごとに送信時間が増えます。0 でオフ。';

  @override
  String get pathGraph_you => 'あなた';

  @override
  String pathGraph_relayed(int count) {
    return '$count 件のメッセージを中継';
  }

  @override
  String get pathGraph_ambiguousNote => 'この短い ID は複数のリピーターに一致するため、1 つに特定できません。';

  @override
  String get pathGraph_comesFrom => '受信元';

  @override
  String get pathGraph_goesTo => '送信先';

  @override
  String get pathGraph_repeaterDetails => 'リピーターの詳細';

  @override
  String get pathGraph_days7 => '7 日間';

  @override
  String get pathGraph_empty =>
      'この期間のチャンネルメッセージの経路はまだありません。経路は、メッセージ追跡がオンのときに受信したチャンネルメッセージから集められます。';

  @override
  String pathGraph_summary(int paths, int repeaters) {
    return '受信した経路 $paths · リピーター $repeaters';
  }

  @override
  String get pathGraph_hashOnly => '各ホップはハッシュ接頭辞、またはリピーターが分かる場合はその名前で表示されます。';

  @override
  String pathGraph_matched(int count) {
    return '$count 件の短い (1 バイト) ホップを、より長い経路から特定のリピーターに対応付けました。';
  }

  @override
  String pathGraph_matchedAmbiguous(int matched, int ambiguous) {
    return '$matched 件の短い (1 バイト) ホップを、より長い経路から特定のリピーターに対応付けました · $ambiguous 件はまだあいまいです (? 付き)。';
  }

  @override
  String get pathGraph_chartHint =>
      '左: 遠くのリピーター。右: あなた。帯の太さはそのホップを通ったメッセージ数です。ボックスをタップするとそのリピーターを表示します。';

  @override
  String get pathGraph_busiest => '最も使われているリピーター';

  @override
  String pathGraph_chartSemantics(String name, int count) {
    return '経路グラフ。最も使われているリピーターは $name、$count 件を中継。';
  }

  @override
  String diag_copied(String label) {
    return 'コピーしました: $label';
  }

  @override
  String get diag_noChannels => 'この無線機にはチャンネルがありません。';

  @override
  String get diag_tapToCopy => '値をタップするとコピーします。下に引くと更新します。';

  @override
  String get diag_storage => 'ストレージ';

  @override
  String diag_storageValue(int used, int total) {
    return '$used / $total KB';
  }

  @override
  String get favReturn_setting => 'お気に入りが圏内に復帰';

  @override
  String get favReturn_settingHint => 'しばらく受信がなかったお気に入りを再び受信したら通知';

  @override
  String get favReturn_off => 'オフ';

  @override
  String favReturn_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count時間後',
    );
    return '$_temp0';
  }

  @override
  String get favReturn_title => '圏内に復帰';

  @override
  String favReturn_body(String name, int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours時間',
    );
    return '$name を$_temp0ぶりに受信しました';
  }

  @override
  String get ham_heardFrom => '受信元';

  @override
  String get ham_lastHeard => '最後に受信した局';

  @override
  String get ham_nothingHeardYet => 'まだありません';

  @override
  String get ham_readyToTransmit => '送信の準備ができています';

  @override
  String get ham_notReadyToTransmit => '送信する前に、下で印の付いた項目を確認してください';

  @override
  String get ham_bannerNameMismatch => '送信する前に無線機の名前をコールサインにしてください';

  @override
  String get ham_bannerOutOfBand => '無線機がアマチュアバンドの外に設定されています';

  @override
  String get a11y_showPassword => 'パスワードを表示';

  @override
  String get a11y_hidePassword => 'パスワードを隠す';

  @override
  String get a11y_sendLocation => '現在地を送信';

  @override
  String get a11y_toggleFlash => 'ライト';

  @override
  String get a11y_switchCamera => 'カメラを切り替え';

  @override
  String get los_worst => '最悪';

  @override
  String get los_selectedObstruction => '選択した障害物';

  @override
  String get bastionHome_stationOk => 'ノード名とバンドは問題ありません';

  @override
  String get bastionHome_stationConnectToCheck => '無線機を接続して名前とバンドを確認してください';

  @override
  String get theme_selected => '選択中';

  @override
  String get theme_desc_blaze => 'チャコールスレートに高視認オレンジ。標準テーマ。';

  @override
  String get theme_desc_neon_anarchy => '黒地にトキシックグリーンとエレクトリックパープル';

  @override
  String get theme_desc_tactical => 'フィールド向けのオリーブ、ガンメタル、アースカラー';

  @override
  String get theme_desc_pink_overload => 'ホットピンク、バブルガム、ラベンダー';

  @override
  String get theme_desc_bare_beauty => '温かいヌード、ダスティローズ、ココア、セージ';

  @override
  String get theme_desc_okabe_ito => '色覚の多様性に配慮、青みがかったグレー地';

  @override
  String get theme_desc_night_ops => '暗所作業向けの落ち着いた赤';

  @override
  String get theme_desc_seasonal => '季節に合わせて変化、または季節を選択';

  @override
  String theme_seasonNow(String season) {
    return '現在: $season';
  }

  @override
  String get theme_season => '季節';

  @override
  String get theme_seasonAuto => '自動';

  @override
  String get season_spring => '春';

  @override
  String get season_summer => '夏';

  @override
  String get season_autumn => '秋';

  @override
  String get season_winter => '冬';

  @override
  String get season_halloween => 'ハロウィン';

  @override
  String get season_christmas => 'クリスマス';

  @override
  String get season_valentine => 'バレンタインデー';

  @override
  String get theme_holidays => '行事の配色';

  @override
  String get theme_holidaysHint => '季節が自動のとき、ハロウィン、クリスマス、バレンタインデーの配色を使用';

  @override
  String get rxLog_title => '受信ログ';

  @override
  String get rxLog_hint => '無線機が受信したすべてのパケットをリアルタイムで表示';

  @override
  String get rxLog_empty => 'まだパケットはありません。無線機が受信したパケットは届き次第ここに表示されます。';

  @override
  String get rxLog_note => 'メモリ内のみに直近2,000件を保持します。保存や送信は行いません。';

  @override
  String get rxLog_pause => '一時停止';

  @override
  String get rxLog_resume => '再開';

  @override
  String get rxLog_export => 'CSVを書き出す';

  @override
  String get rxLog_clearConfirm => '受信ログを消去しますか？';

  @override
  String rxLog_count(int shown, int total) {
    return '$shown件表示 · $total件受信';
  }

  @override
  String get rxLog_paused => '一時停止中：新しいパケットは記録されません';

  @override
  String get rxLog_kindAll => 'すべて';

  @override
  String get rxLog_kindAdvert => 'アドバート';

  @override
  String get rxLog_kindChannel => 'チャンネル';

  @override
  String get rxLog_kindDirect => 'ダイレクト';

  @override
  String get rxLog_kindAck => 'ACK';

  @override
  String get rxLog_kindPath => 'パス';

  @override
  String get rxLog_kindTrace => 'トレース';

  @override
  String get rxLog_kindControl => '制御';

  @override
  String get rxLog_kindOther => 'その他';

  @override
  String get rxLog_routeFlood => 'フラッド';

  @override
  String get rxLog_routeDirect => 'ダイレクト経路';

  @override
  String get rxLog_heardDirectly => '直接受信';

  @override
  String rxLog_hops(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countホップ',
    );
    return '$_temp0';
  }

  @override
  String rxLog_bytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countバイト',
    );
    return '$_temp0';
  }

  @override
  String get rxLog_own => '自分の無線機';

  @override
  String rxLog_signal(String snr, int rssi) {
    return 'SNR $snr · $rssi dBm';
  }

  @override
  String get rxLog_signalTitle => '信号';

  @override
  String get rxLog_route => '経路';

  @override
  String get rxLog_path => 'パス';

  @override
  String get rxLog_payloadType => 'ペイロード種別';

  @override
  String get rxLog_hash => 'パケットハッシュ';

  @override
  String get rxLog_raw => '生パケット';

  @override
  String get rxLog_copyHex => '16進をコピー';

  @override
  String get deliv_title => '配信の詳細';

  @override
  String get deliv_note => 'このメッセージに保存された情報から算出しています。';

  @override
  String get deliv_queued => 'キュー登録';

  @override
  String get deliv_sent => '無線機が送信';

  @override
  String get deliv_notSent => '無線機が受け付けませんでした';

  @override
  String get deliv_attempts => '試行';

  @override
  String deliv_attemptsValue(int made, int total) {
    return '$made / $total';
  }

  @override
  String deliv_plan(int direct, int flood) {
    return '予定：ダイレクト $direct 回、その後フラッド $flood 回';
  }

  @override
  String get deliv_lastRoute => '最後の経路';

  @override
  String get deliv_routeFlood => 'すべての中継器を通るフラッド';

  @override
  String get deliv_routeNeighbor => 'ダイレクト（中継なし）';

  @override
  String deliv_routeVia(String path) {
    return '$path 経由のダイレクト';
  }

  @override
  String get deliv_confirmed => '受信を確認';

  @override
  String deliv_tripTime(String seconds) {
    return '往復 $seconds 秒';
  }

  @override
  String get deliv_waiting => '確認待ち';

  @override
  String get deliv_noConfirm => '確認なし';

  @override
  String deliv_lastHeard(String name) {
    return '$name の最終受信';
  }

  @override
  String deliv_hoursAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours時間前',
    );
    return '$_temp0';
  }

  @override
  String deliv_vDelivered(String name) {
    return '配信済み。$name が確認しました。';
  }

  @override
  String deliv_vDeliveredFlood(String name) {
    return 'ダイレクト送信が失敗した後、フラッドで配信されました。$name への保存経路が古い可能性があります。';
  }

  @override
  String deliv_vPending(int attempt, int total) {
    return '送信中：$total 回中 $attempt 回目。';
  }

  @override
  String get deliv_vNotSent => '無線機がこのメッセージを受け付けませんでした。接続を確認してから再試行してください。';

  @override
  String deliv_vQuiet(String name, int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours時間',
    );
    return '確認なし。$name は$_temp0受信されていないため、圏外か電源が切れている可能性があります。';
  }

  @override
  String get deliv_vNoFlood =>
      '保存経路で確認がなく、フラッド試行がオフです。設定 → アプリ設定 → メッセージでオンにするか、再試行してください。';

  @override
  String get deliv_vNoAck => 'どの経路でも確認がありません。圏外か、確認があなたまで届かなかった可能性があります。';

  @override
  String get batteryOpt_title => 'バッテリーの最適化';

  @override
  String get batteryOpt_off => 'NOTORYX Core Ham ではオフのため、バックグラウンドでも通知が届きます。';

  @override
  String get batteryOpt_on =>
      'オン。Android がバックグラウンドでアプリを停止することがあり、SOS・チェックイン・メッセージの通知が遅れたり届かなかったりします。';

  @override
  String get batteryOpt_fix => 'オフにする';

  @override
  String block_sender(String name) {
    return '$name をブロック';
  }

  @override
  String get block_confirmBody =>
      'この相手のチャンネルメッセージはこの端末で非表示になり、通知もされません。相手からはあなたのメッセージが引き続き見えます。設定でブロックを解除できます。';

  @override
  String get block_action => 'ブロック';

  @override
  String block_done(String name) {
    return '$name をブロックしました';
  }

  @override
  String get mention_suggestions => '名前の候補';

  @override
  String get block_listTitle => 'ブロック中の送信者';

  @override
  String get block_listHint => 'これらの名前からのメッセージはチャンネルで非表示になり、通知もされません。';

  @override
  String get block_listEmpty => 'ブロック中の相手はいません。';

  @override
  String get block_unblock => 'ブロック解除';

  @override
  String block_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 件ブロック中',
      zero: 'ブロックなし',
    );
    return '$_temp0';
  }

  @override
  String contactTable_nearlyFull(int percent) {
    return '無線機の連絡先リストが $percent% 使用中';
  }

  @override
  String get contactTable_full => '無線機の連絡先リストがいっぱいです';

  @override
  String contactTable_count(int used, int max) {
    return '$used / $max 件の連絡先';
  }

  @override
  String get contactTable_overwriteHint =>
      'いっぱいになると、無線機は最も長く受信していない連絡先を置き換えます。お気に入りは残ります。';

  @override
  String get contactTable_stopHint => 'いっぱいになると、無線機は新しく受信した連絡先を追加しなくなります。';

  @override
  String get contactTable_freeUp => '空きを作る';

  @override
  String get contactTable_sheetBody => '受信が古い順に表示。お気に入りは表示されません。';

  @override
  String contactTable_lastHeard(String when) {
    return '最終受信 $when';
  }

  @override
  String contactTable_remove(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 件の連絡先を削除',
    );
    return '$_temp0';
  }

  @override
  String get contactTable_confirmBody =>
      '無線機から削除され、この端末上のメッセージも削除されます。元に戻せません。';

  @override
  String contactTable_removed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 件の連絡先を削除しました',
    );
    return '$_temp0';
  }

  @override
  String get contactTable_noneToSuggest => 'すべての連絡先がお気に入りのため、候補はありません。';

  @override
  String get adminWait_waiting => '応答を待っています';

  @override
  String adminWait_retrying(int attempt, int total) {
    return 'まだ応答がありません。再試行中 ($attempt/$total)';
  }

  @override
  String adminWait_direct(int hops) {
    String _temp0 = intl.Intl.pluralLogic(
      hops,
      locale: localeName,
      other: '直接、$hops ホップ',
      zero: '直接',
    );
    return '$_temp0';
  }

  @override
  String adminWait_upTo(int seconds) {
    return '最大 $seconds 秒';
  }

  @override
  String get seasonal_holidays => '行事の配色';

  @override
  String get coords_setting => '座標の形式';

  @override
  String get coords_decimal => '10進数の度';

  @override
  String get coords_dms => '度・分・秒';

  @override
  String get coords_utm => 'UTM';

  @override
  String get coords_mgrs => 'MGRS';

  @override
  String get coords_copyTitle => '位置をコピー';

  @override
  String coords_copied(String format) {
    return '$format でコピーしました';
  }

  @override
  String pathHash_badge(int width) {
    return '経路は $width バイトのパスハッシュを使用';
  }

  @override
  String pathHash_mismatch(int width) {
    return 'この無線機は $width バイトを使用';
  }

  @override
  String ham_idMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '名前と一致しない局識別が $count 件あります',
    );
    return '$_temp0';
  }

  @override
  String get ham_idMismatchBody =>
      '直接受信したこれらのアドバートには、名前の先頭のコールサインと異なる局識別が付いていました。無線機の設定ミスかもしれません。頼りにする前に運用者に確認してください。';

  @override
  String ham_idMismatchSentAs(String station) {
    return '局識別 $station で送信';
  }

  @override
  String get ham_idMismatchNoCall => 'この名前はコールサインで始まっていません';

  @override
  String get ham_composerPlainText => '平文です。受信している誰でも読めます';

  @override
  String get ham_bannerStockFirmware =>
      'この無線機は標準の MeshCore です。アマチュアバンドで送信しないでください';

  @override
  String get ham_firmwareOk => 'NOTORYX Ham ファームウェア: 局識別、平文、アマチュアバンドのみ';

  @override
  String get ham_firmwareStock =>
      '標準の MeshCore は暗号化し、局識別を送りません。送信前に NOTORYX Ham ファームウェアを書き込んでください';

  @override
  String get ham_stationLog => '局ログ';

  @override
  String get ham_stationLogExport => 'ログを書き出す';

  @override
  String get ham_exportAdif => 'ADIF で書き出す (.adi)';

  @override
  String get ham_exportCsv => 'CSV で書き出す';

  @override
  String get ham_stationLogClear => 'ログを消去';

  @override
  String get ham_stationLogClearConfirm => '局ログのすべての記録を削除しますか？元に戻せません。';

  @override
  String get ham_stationLogEmpty => 'まだ記録された局はありません';

  @override
  String get ham_stationLogHint => '名前がコールサインで始まる局とのダイレクトメッセージを、この端末にだけ記録します。';

  @override
  String ham_stationLogCounts(int sent, int received) {
    return '送信 $sent、受信 $received';
  }

  @override
  String ham_rxStationId(String call) {
    return 'ID $call';
  }

  @override
  String get ham_stationIdLabel => '局識別';

  @override
  String get ham_stationIdHint => 'このフレームを送信した局。送信者、または中継したリピーターです';

  @override
  String ham_stockTrafficTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'この 10 分間に標準 MeshCore のフレームを $count 件受信しました',
    );
    return '$_temp0';
  }

  @override
  String get security_title => 'セキュリティ';

  @override
  String get security_toolSubtitle => 'アプリのロックとメッセージ履歴の暗号化';

  @override
  String get appLock_title => 'アプリのロック';

  @override
  String get appLock_subtitle =>
      'アプリを開くときに指紋、顔、または画面ロックを求めます。通知は届き、SOSはロック画面からも送信できます。';

  @override
  String get appLock_reason => 'NOTORYX Core Hamのロックを解除';

  @override
  String get appLock_unlock => 'ロック解除';

  @override
  String get appLock_locked => 'NOTORYX Core Hamはロックされています';

  @override
  String get appLock_unavailable => 'この端末には画面ロックがないか、確認できませんでした。';

  @override
  String get dbEncrypt_title => 'メッセージ履歴を暗号化';

  @override
  String get dbEncrypt_subtitle =>
      'この端末のメッセージデータベースを、スマートフォンの安全な保管領域にある鍵で暗号化します。鍵を失うと履歴は復元できないため、バックアップを保管してください。';

  @override
  String get dbEncrypt_on => '状態: 暗号化済み';

  @override
  String get dbEncrypt_off => '状態: 暗号化なし';

  @override
  String get dbEncrypt_failed => '状態: 適用できませんでした。履歴は変更されていません。';

  @override
  String get dbEncrypt_restart => '次回アプリを起動したときに有効になります。';

  @override
  String get appLock_sosNoTarget => '先にロックを解除し、SOSの送信先を選んでください。';

  @override
  String get ham_stockTrafficBody =>
      '別のネットワーク (Part 15 の MeshCore メッシュなど) がこの周波数を使っています。そのフレームには局識別がなく、アマチュア無線用ファームウェアでは読めません。ここで送信する前に周波数調整担当者に確認してください。';

  @override
  String get forward_action => '転送';

  @override
  String get forward_title => 'メッセージを転送';

  @override
  String get forward_to => '送信先';

  @override
  String get forward_send => '送信';

  @override
  String get forward_hint => 'あなたのコールサインで送信され、作成者の名前も示されます。転送内容の責任はあなたにあります。';

  @override
  String get forward_needCallsign => '先に「免許を持つオペレーター」でコールサインを設定してください。';

  @override
  String forward_tooLong(int count) {
    return '$count バイト長すぎます。メッセージを短くしてください。';
  }

  @override
  String get forward_sent => '無線機に転送しました';

  @override
  String get ham_setupBeforeTitle => '送信する前に';

  @override
  String get team_title => 'チーム設定';

  @override
  String get team_toolSubtitle => '無線設定とチャンネルを QR またはファイルで共有';

  @override
  String get team_shareHint =>
      'この無線機の周波数、帯域幅、拡散率、符号化率、ハッシュタグチャンネルを共有します。鍵と送信出力は含まれません。';

  @override
  String get team_shareFile => 'ファイルで共有';

  @override
  String get team_scan => 'チームの QR コードをスキャン';

  @override
  String get team_openFile => 'チームファイルを開く';

  @override
  String get team_importTitle => 'チーム設定を適用しますか？';

  @override
  String get team_apply => '無線機に適用';

  @override
  String get team_invalid => '有効なチーム設定ではないか、周波数がアマチュアバンド外です。';

  @override
  String get team_applied => 'チーム設定を適用しました';

  @override
  String team_summary(String freq, String bandwidth, int sf, int cr) {
    return '$freq MHz, $bandwidth kHz, SF$sf, CR$cr';
  }

  @override
  String team_channels(String names) {
    return 'チャンネル: $names';
  }

  @override
  String get ham_setupBeforeBody =>
      '調整ガイドを読み、「免許を持つ運用者」でコールサインと免許を入力してください。周波数調整担当者とメッシュ内の他局がチャンネルに合意するまで送信しないでください。';

  @override
  String ham_setupBeforeDone(String call) {
    return '免許局として設定済み: $call';
  }

  @override
  String get fieldOps_kindReport => 'レポート';

  @override
  String get fieldReport_title => 'フィールドレポート';

  @override
  String get fieldReport_open => 'SALUTE または 9-Line レポートを作成';

  @override
  String get fieldReport_hint =>
      'コールサインを付けた平文で、トリップの連絡先と SOS チャンネルに送信します。送信を押すまで何も送られません。';

  @override
  String get fieldReport_usePosition => '無線機の位置を使う';

  @override
  String fieldReport_preview(int count) {
    return '送信するメッセージ: $count';
  }

  @override
  String get fieldReport_needCallsign => '先に「免許を持つオペレーター」でコールサインを設定してください。';

  @override
  String get fieldReport_tooLong => '1 行が長すぎて 1 通に収まりません。短くしてください。';

  @override
  String get fieldReport_sent => 'レポートを無線機に渡しました';

  @override
  String get coords_maidenhead => 'メイデンヘッド・ロケーター';

  @override
  String get reactions_radioTitle => 'リアクションを無線で送信';

  @override
  String get reactions_radioHint =>
      'リアクションは1件ごとに電波で送られます。自動では、送信時間が制限されるEUの868 MHz帯ではこの端末内だけに表示します。';

  @override
  String get reactions_radioAuto => '自動';

  @override
  String get reactions_radioOn => 'オン';

  @override
  String get reactions_radioOff => 'オフ（この端末）';

  @override
  String get notification_replyAction => '返信';

  @override
  String get notification_replyHint => '返信を入力';

  @override
  String get mesh_title => 'メッシュの状態';

  @override
  String get mesh_overallGood => 'メッシュは良好です';

  @override
  String get mesh_overallFair => 'メッシュは動いていますが問題があります';

  @override
  String get mesh_overallPoor => 'メッシュは不調です';

  @override
  String get mesh_overallUnknown => 'まだ判断できるデータがありません';

  @override
  String get mesh_gradeGood => '良好';

  @override
  String get mesh_gradeFair => '普通';

  @override
  String get mesh_gradePoor => '不良';

  @override
  String get mesh_gradeUnknown => 'データなし';

  @override
  String get mesh_noise => 'ノイズ';

  @override
  String mesh_noiseValue(String dbm) {
    return 'ノイズフロア $dbm dBm';
  }

  @override
  String get mesh_signal => '直近の信号';

  @override
  String mesh_signalValue(String db) {
    return 'SNR $db dB';
  }

  @override
  String get mesh_busy => 'チャンネル使用率';

  @override
  String mesh_busyValue(int percent) {
    return '直近15分のうち$percent%が送受信中';
  }

  @override
  String get mesh_neighbours => '直接受信';

  @override
  String mesh_neighboursValue(int count) {
    return '直近1時間で$countノード';
  }

  @override
  String get mesh_delivery => 'ダイレクトメッセージ';

  @override
  String mesh_deliveryValue(int delivered, int total) {
    return '直近1日で$total件中$delivered件配信';
  }

  @override
  String get mesh_tipNoise => '近くの何かがこの周波数でノイズを出しています。アンテナを電子機器や充電器から離してください。';

  @override
  String get mesh_tipSignal => '直近のパケットは弱い信号でした。アンテナを高くするか、高い場所へ移動してください。';

  @override
  String get mesh_tipBusy => 'チャンネルが混雑しています。メッセージは短くし、フラッド送信は避けてください。';

  @override
  String get mesh_tipNeighbours =>
      '直接受信できるノードが少ないです。アンテナを高くするか、リピーターに近づいてください。';

  @override
  String get mesh_tipDelivery =>
      '多くのメッセージが確認応答されていません。失敗したメッセージを開いて、どこで止まったか確認してください。';

  @override
  String routeHealth_staleTitle(String name) {
    return '$nameへのルートは古いかもしれません';
  }

  @override
  String routeHealth_weakTitle(String name) {
    return '$nameへのルートは不安定です';
  }

  @override
  String routeHealth_lastWorkedHours(int hours) {
    return '最後に成功したのは$hours時間前';
  }

  @override
  String routeHealth_lastWorkedDays(int days) {
    return '最後に成功したのは$days日前';
  }

  @override
  String routeHealth_notHeard(int days) {
    return '$days日間受信なし';
  }

  @override
  String routeHealth_failures(int failures, int attempts) {
    return '$attempts回中$failures回失敗';
  }

  @override
  String routeHealth_longPath(int hops) {
    return '$hopsホップ';
  }

  @override
  String get routeHealth_useFlood => '新しいルートを探す';

  @override
  String get routeHealth_keep => 'このルートを使う';

  @override
  String get netChange_title => 'ネットワークの変化';

  @override
  String get netChange_toolSubtitle => '近くに現れた、または沈黙したリピーター';

  @override
  String netChange_newDirect(String name) {
    return '直接受信した新しいリピーター: $name';
  }

  @override
  String netChange_newHops(String name, int hops) {
    return '$hopsホップ先の新しいリピーター: $name';
  }

  @override
  String netChange_wentQuiet(String name, int hours) {
    return '$nameが沈黙: $hours時間受信なし';
  }

  @override
  String get netChange_empty =>
      'まだ変化はありません。沈黙したお気に入りリピーターや近くの新しいリピーターがここに表示されます。';

  @override
  String get netChange_quietSetting => 'お気に入りリピーターの沈黙';

  @override
  String get netChange_quietHint => 'お気に入りリピーターがこの時間受信されないときに通知';

  @override
  String get netChange_newSetting => '近くの新しいリピーター';

  @override
  String get netChange_newHint => '未知のリピーターが1ホップ以内で受信されたら通知';

  @override
  String get netChange_clear => 'クリア';

  @override
  String get netChange_notifTitle => 'ネットワークの変化';

  @override
  String get journal_title => 'ノード日誌';

  @override
  String get journal_toolSubtitle => 'これまでに受信したすべてのノード。行動ラベル、タグ、メモ付き';

  @override
  String get journal_empty => 'まだノードはありません。無線機が受信したノードは自動でここに追加されます。';

  @override
  String get journal_search => '名前、ID、タグ、メモを検索';

  @override
  String get journal_filterAll => 'すべて';

  @override
  String get journal_bSteadyRelay => '常時稼働の中継';

  @override
  String get journal_bRegular => '常連';

  @override
  String get journal_bRoamer => '移動型';

  @override
  String get journal_bRarelyHeard => 'めったに受信しない';

  @override
  String get journal_bNewcomer => '新顔';

  @override
  String get journal_bGoneQuiet => '沈黙中';

  @override
  String journal_confidence(int percent) {
    return '確度 $percent%';
  }

  @override
  String journal_eDaysHeard(int heard, int days) {
    return '$days 日中 $heard 日受信';
  }

  @override
  String journal_eFirstHeard(int hours) {
    return '$hours 時間前に初受信';
  }

  @override
  String journal_eSilent(int days) {
    return '$days 日間受信なし';
  }

  @override
  String journal_ePlaces(int places, int km) {
    return '$places か所で確認、最大 $km km 離れている';
  }

  @override
  String journal_eSightings(int count) {
    return '新しいアドバート計 $count 件';
  }

  @override
  String get journal_noLabel => 'ラベルを付けるにはまだデータが足りません。';

  @override
  String journal_firstSeen(String time) {
    return '初受信: $time';
  }

  @override
  String journal_lastSeen(String time) {
    return '最終受信: $time';
  }

  @override
  String journal_hops(int min, int max) {
    return 'ホップ数: $min〜$max';
  }

  @override
  String get journal_tags => 'タグ';

  @override
  String get journal_addTag => 'タグを追加';

  @override
  String get journal_tagHint => '例: 登山口、クラブ、自分の';

  @override
  String journal_removeTag(String tag) {
    return 'タグ $tag を削除';
  }

  @override
  String get journal_note => 'メモ';

  @override
  String get journal_saveNote => 'メモを保存';

  @override
  String get journal_forget => 'このノードを削除';

  @override
  String journal_forgetConfirm(String name) {
    return '$name をタグとメモごと日誌から削除しますか？再び受信すると最初から記録されます。';
  }

  @override
  String get journal_forgotten => 'ノードを日誌から削除しました。';

  @override
  String journal_markLabel(String name) {
    return '$name の生成マーク';
  }

  @override
  String get trouble_title => 'トラブルシューティング';

  @override
  String get trouble_toolSubtitle => 'うまくいかないときの手順ごとのヘルプ';

  @override
  String get trouble_pick => '何が問題ですか？';

  @override
  String get trouble_noDelivery => 'メッセージが届かない';

  @override
  String get trouble_noConnect => '無線機に接続できない';

  @override
  String get trouble_hearNobody => '誰も受信できない';

  @override
  String get trouble_startHere => 'ここから';

  @override
  String get trouble_resultOk => 'OK';

  @override
  String get trouble_resultProblem => '問題あり';

  @override
  String get trouble_resultUnchecked => '確認できません';

  @override
  String get trouble_connectedNow => '現在は接続されています。接続が何度も切れる場合は、以下の手順も役立ちます。';

  @override
  String get trouble_allOk => 'すべてのチェックに合格しました。それでも動かない場合は、以下の手順を確認してください。';

  @override
  String get trouble_connected => '無線機が接続されている';

  @override
  String get trouble_connectedAdvice => 'まず無線機を接続してください: 設定 → 無線機を接続。';

  @override
  String get trouble_routes => 'メッセージ相手へのルートがわかっている';

  @override
  String get trouble_routesAdvice =>
      'ルートが不明な相手へのメッセージはメッシュ全体にフラッドされ、届かないことがよくあります。相手がアドバートするのを待つか依頼してから、もう一度送ってください。';

  @override
  String get trouble_heardRecently => 'メッセージ相手を直近1日で受信している';

  @override
  String get trouble_heardRecentlyAdvice =>
      'しばらく受信がない相手は圏外か電源オフかもしれません。戻るまでメッセージは確認応答されません。';

  @override
  String get trouble_neighbours => '無線機がほかのノードを受信している';

  @override
  String get trouble_neighboursAdvice =>
      '直接何も受信できない場合、ここからはメッシュに届きません。アンテナを高くする、高い場所へ行く、またはリピーターに近づいてください。';

  @override
  String get trouble_bluetooth => 'Bluetoothがオンで、アプリが使える';

  @override
  String get trouble_bluetoothAdvice =>
      'Bluetoothがオンで、端末の設定でNOTORYX Core HamにBluetooth（Androidでは付近のデバイス）の権限があるか確認してください。';

  @override
  String get trouble_otherApp => 'ほかの端末やアプリが無線機に接続していない';

  @override
  String get trouble_otherAppAdvice =>
      '無線機は一度に1つのアプリとだけ通信します。ほかのMeshCoreアプリを閉じるか、ペアリング済みのほかの端末でBluetoothをオフにしてください。';

  @override
  String get trouble_inRange => '無線機の電源が入っていて近くにある';

  @override
  String get trouble_inRangeAdvice =>
      '無線機が充電され、電源が入り、数メートル以内にあるか確認してください。無線機の再起動で固まった接続が直ることがよくあります。';

  @override
  String get trouble_otherTransport => '別の接続方法を試す';

  @override
  String get trouble_otherTransportAdvice =>
      'Bluetoothで失敗が続く場合は、USBケーブル、または対応していればWi-Fi（TCP）で接続してください。';

  @override
  String get trouble_noise => '無線機がノイズに埋もれていない';

  @override
  String get trouble_noiseAdvice =>
      'ノイズフロアが高いと弱い信号が隠れます。アンテナを電子機器、充電器、ソーラーコントローラーから離してください。';

  @override
  String get trouble_region => '無線機が地域の設定を使っている';

  @override
  String get trouble_regionAdvice =>
      '周波数、帯域幅、拡散率が地元のメッシュと違うと誰も受信できません。設定 → 無線機を地域の設定と比べてください。';

  @override
  String get trouble_antenna => 'アンテナが取り付けられている';

  @override
  String get trouble_antennaAdvice =>
      'アンテナがしっかり締まっているか確認してください。アンテナなしで送信しないでください。無線機が壊れることがあります。';

  @override
  String get readiness_sos => 'SOSの送信先';

  @override
  String get readiness_sosOk => 'SOSの送信先があります。';

  @override
  String get readiness_sosBlocked =>
      'SOSの送信先がありません。連絡先にいる同行者を追加するか、SOSチャンネルを設定してください。';

  @override
  String get readiness_routes => '同行者へのルート';

  @override
  String get readiness_routesOk => 'すべての同行者へのルートがわかっています。';

  @override
  String readiness_routesMissing(String names) {
    return '$namesへのルートが不明です。ルートを学習するまでメッセージはフラッドで送られます。出発前にメッセージを送ってください。';
  }

  @override
  String get readiness_notifications => '通知';

  @override
  String get readiness_notificationsOk => '許可されています。';

  @override
  String get readiness_notificationsOff => '通知がオフのため、返信・チェックイン・アラートが届きません。';

  @override
  String get readiness_batteryOpt => 'バッテリー最適化';

  @override
  String get readiness_batteryOptOk => 'NOTORYX Core Hamは対象外です。';

  @override
  String get readiness_batteryOptOn =>
      'Androidがバックグラウンドでアプリを停止する可能性があります。設定 → アプリ設定 → 通知でオフにしてください。';

  @override
  String get readiness_blockedTitle => 'まだ出発できません';

  @override
  String readiness_warnTitle(int count) {
    return '確認事項 $count 件';
  }

  @override
  String get readiness_startAnyway => 'このまま開始';

  @override
  String get readiness_review => '確認する';

  @override
  String get readiness_summaryReady => '準備完了';

  @override
  String readiness_summaryWarn(int count) {
    return '確認 $count 件';
  }

  @override
  String get readiness_summaryBlocked => 'SOSの送信先がありません';

  @override
  String get waypoints_title => 'ウェイポイント';

  @override
  String get waypoints_toolSubtitle => '保存した場所とルート。GPXの読み込み・書き出し';

  @override
  String get waypoints_importFile => 'GPXファイルを読み込む';

  @override
  String get waypoints_importPaste => 'GPXを貼り付け';

  @override
  String get waypoints_export => 'GPXを書き出す';

  @override
  String get waypoints_empty =>
      'ウェイポイントはまだありません。GPXファイルを読み込むか、チャットで共有された場所を保存してください。';

  @override
  String waypoints_waypoints(int count) {
    return 'ウェイポイント ($count)';
  }

  @override
  String waypoints_routes(int count) {
    return 'ルート ($count)';
  }

  @override
  String waypoints_routeSummary(int points, String km) {
    return '$points地点 · $km km';
  }

  @override
  String get waypoints_delete => '削除';

  @override
  String get waypoints_copy => '座標をコピー';

  @override
  String get waypoints_sendToChannel => 'チャンネルに送信';

  @override
  String get waypoints_pickChannel => 'どのチャンネルに送りますか？';

  @override
  String waypoints_sent(String channel) {
    return '$channelに送信しました';
  }

  @override
  String get waypoints_importFailed => 'アプリで読めるGPXファイルではありません。';

  @override
  String get waypoints_pasteHint => 'GPXのテキストをここに貼り付け';

  @override
  String get waypoints_import => '読み込む';

  @override
  String waypoints_imported(int waypoints, int routes) {
    return 'ウェイポイント$waypoints件とルート$routes件を追加しました';
  }

  @override
  String get waypoints_save => 'ウェイポイントとして保存';

  @override
  String get waypoints_unnamed => '共有された場所';

  @override
  String get waypoints_saved => 'ウェイポイントに保存しました';

  @override
  String get waypoints_alreadySaved => 'すでにウェイポイントにあります';

  @override
  String get map_showWaypoints => '保存したウェイポイントとルートを表示';

  @override
  String get dbEncrypt_covers =>
      '連絡先、チャンネルキー、ウェイポイント、保存したルート、下書き、送信待ちメッセージも対象です。';

  @override
  String get bk_intro =>
      'アプリ設定、連絡先、チャンネル鍵、ウェイポイント、下書きを暗号化して保存します。選択すればメッセージ履歴も含めます。オフライン地図、写真、無線機のファームウェアは含まれません。';

  @override
  String bk_confirmBody(Object count) {
    return 'この端末に保存されている$count件の設定（連絡先、チャンネル鍵、ウェイポイントを含む）をバックアップの内容で置き換えます。元に戻すことはできません。';
  }

  @override
  String get bk_history => 'メッセージ履歴を含める';

  @override
  String get bk_historyHint => 'すべての無線機のダイレクトメッセージとチャンネルメッセージ。ファイルが大きくなります。';

  @override
  String get bk_tooLarge => 'バックアップが大きすぎます。メッセージ履歴をオフにしてもう一度お試しください。';

  @override
  String bk_confirmHistory(int count) {
    return '最大$count件のメッセージも履歴に追加します。この端末にすでにあるメッセージは残ります。';
  }

  @override
  String bk_restoredHistory(int count) {
    return '$count件のメッセージを履歴に追加しました。';
  }

  @override
  String get bk_confirmTitle => 'このバックアップを復元しますか？';

  @override
  String bk_restored(int count) {
    return '$count件の設定を復元しました。アプリを完全に終了して開き直してください。';
  }

  @override
  String get automation_title => 'Automation';

  @override
  String get automation_toolHint =>
      'Rules that alert you or send a message when something happens';

  @override
  String get automation_newRule => 'New rule';

  @override
  String get automation_editRule => 'Edit rule';

  @override
  String get automation_hamNotice =>
      'Rules run while the app is open. Automated messages are plain text and start with [auto]. They are held unless your station is ready to transmit (ham firmware, call sign in the radio\'s name, in band), limited to 3 every 10 minutes, and written to the station log. You remain the control operator for every automated transmission.';

  @override
  String get automation_empty => 'No rules yet';

  @override
  String get automation_emptyHint =>
      'Add a rule to get an alert when your battery runs low, a station goes quiet or a message arrives.';

  @override
  String get automation_allowWebhooks => 'Allow webhooks';

  @override
  String get automation_allowWebhooksHint =>
      'Needs internet. Off by default; webhook actions do nothing while this is off.';

  @override
  String get automation_workingChannel => 'Working channel';

  @override
  String get automation_stationLogHint =>
      'Every automated transmission is listed there';

  @override
  String get automation_activity => 'Recent activity';

  @override
  String get automation_none => 'None';

  @override
  String get automation_unnamed => 'Unnamed rule';

  @override
  String get automation_transmits => 'Transmits on air';

  @override
  String get automation_incomplete => 'Unfinished';

  @override
  String automation_ruleSwitch(String name) {
    return 'Rule $name on';
  }

  @override
  String get automation_ruleName => 'Rule name';

  @override
  String get automation_when => 'When';

  @override
  String get automation_then => 'Then';

  @override
  String get automation_matchAll => 'All are true (AND)';

  @override
  String get automation_matchAny => 'Any is true (OR)';

  @override
  String automation_matchAllShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'All of $count conditions',
      one: '1 condition',
    );
    return '$_temp0';
  }

  @override
  String automation_matchAnyShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Any of $count conditions',
      one: '1 condition',
    );
    return '$_temp0';
  }

  @override
  String automation_actionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count actions',
      one: '1 action',
    );
    return '$_temp0';
  }

  @override
  String get automation_addCondition => 'Add condition';

  @override
  String get automation_addAction => 'Add action';

  @override
  String automation_remove(String item) {
    return 'Remove $item';
  }

  @override
  String get automation_savedOff =>
      'Saved switched off. Fill in every field to turn it on.';

  @override
  String get automation_deleteConfirm => 'Delete this rule?';

  @override
  String get automation_transmitNotice =>
      'This rule transmits. It only sends when your station is ready, at most 3 automated messages every 10 minutes and once every 15 minutes per rule, and each one is logged in the station log.';

  @override
  String get automation_condBattery => 'Battery low';

  @override
  String get automation_condTime => 'Time of day';

  @override
  String get automation_condEnter => 'Enter an area';

  @override
  String get automation_condLeave => 'Leave an area';

  @override
  String get automation_condMessage => 'Message received';

  @override
  String get automation_condOnline => 'Node online';

  @override
  String get automation_condOffline => 'Node offline';

  @override
  String automation_batteryBelow(int percent) {
    return 'Radio battery below $percent%';
  }

  @override
  String get automation_timeHint =>
      'Every day at this time, on this device\'s clock';

  @override
  String get automation_latitude => 'Latitude';

  @override
  String get automation_longitude => 'Longitude';

  @override
  String get automation_radiusMeters => 'Radius (meters)';

  @override
  String get automation_useRadioPosition => 'Use the radio\'s position';

  @override
  String get automation_areaHint => 'Uses the position the radio reports.';

  @override
  String get automation_sourceAny => 'Any';

  @override
  String get automation_sourceDirect => 'Direct';

  @override
  String get automation_sourceChannel => 'Channel';

  @override
  String get automation_onChannel => 'On channel';

  @override
  String get automation_anyChannel => 'Any channel';

  @override
  String get automation_from => 'From';

  @override
  String get automation_anyone => 'Anyone';

  @override
  String get automation_contains => 'Contains text (optional)';

  @override
  String get automation_node => 'Node';

  @override
  String get automation_heardWithinMinutes => 'Heard within (minutes)';

  @override
  String get automation_actionSend => 'Send a message';

  @override
  String get automation_actionAlert => 'Alert me';

  @override
  String get automation_actionChangeChannel => 'Change working channel';

  @override
  String get automation_actionSound => 'Play a sound';

  @override
  String get automation_actionWebhook => 'Call a webhook';

  @override
  String get automation_sendTo => 'Send to';

  @override
  String get automation_targetChannel => 'Channel';

  @override
  String get automation_targetContact => 'Contact';

  @override
  String get automation_message => 'Message';

  @override
  String get automation_messageTooLong =>
      'Too long: 140 bytes at most, [auto] included';

  @override
  String get automation_sendHint =>
      'Sent on air as plain text with [auto] in front, and logged in the station log.';

  @override
  String get automation_alertText => 'Alert text';

  @override
  String get automation_changeChannelHint =>
      'Rules that send to the working channel use this channel from now on.';

  @override
  String get automation_soundHint => 'Plays this device\'s alert sound.';

  @override
  String get automation_webhookUrl => 'Webhook address (https://)';

  @override
  String get automation_webhookHttps => 'Use an https:// address';

  @override
  String get automation_webhookNeedsInternet =>
      'Needs internet. Sends the rule\'s name and the time.';

  @override
  String get automation_webhookOffNotice =>
      'Needs internet. Webhooks are off: allow them on the Automation page.';

  @override
  String get automation_outDone => 'Done';

  @override
  String get automation_outNotConnected => 'Held: no radio connected';

  @override
  String get automation_outNotReady => 'Held: station not ready to transmit';

  @override
  String get automation_outRateLimited =>
      'Held: automated message limit reached';

  @override
  String get automation_outNoTarget =>
      'Held: contact or channel not on the radio';

  @override
  String get automation_outWebhooksOff => 'Skipped: webhooks are off';

  @override
  String get automation_outFailed => 'Failed';

  @override
  String get ham_automatedTx => 'Automated transmissions';

  @override
  String get ham_automatedTxHint =>
      'Messages your automation rules sent on air.';

  @override
  String get ham_exportAutomatedCsv => 'Export automated transmissions (CSV)';

  @override
  String get checklist_title => 'チェックリスト';

  @override
  String get checklist_toolSubtitle => '出発前・設置用の再利用できるチェックリスト（オフライン対応）';

  @override
  String get checklist_empty => 'チェックリストはありません。下のボタンで追加できます。';

  @override
  String get checklist_add => '新しいチェックリスト';

  @override
  String get checklist_edit => 'チェックリストを編集';

  @override
  String get checklist_name => '名前';

  @override
  String get checklist_items => '項目（1 行に 1 つ）';

  @override
  String checklist_itemCount(int count) {
    return '項目数: $count';
  }

  @override
  String get checklist_history => '完了した記録';

  @override
  String get checklist_noRuns => '完了した記録はまだありません。';

  @override
  String get checklist_inProgress => '進行中';

  @override
  String checklist_progress(int done, int total) {
    return '$total 件中 $done 件完了';
  }

  @override
  String checklist_startedAt(String time) {
    return '開始 $time';
  }

  @override
  String checklist_finishedAt(String time) {
    return '完了 $time';
  }

  @override
  String get checklist_note => 'メモ';

  @override
  String get checklist_finish => '完了して保存';

  @override
  String get checklist_unfinished => 'チェックされていない項目があります。それでも保存しますか？';

  @override
  String get checklist_saveAnyway => '保存する';

  @override
  String get checklist_export => '書き出しまたは削除';

  @override
  String get checklist_exportText => 'テキストで共有';

  @override
  String get checklist_exportJson => 'JSON で共有';

  @override
  String get checklist_exportFailed => '記録を共有できませんでした。';

  @override
  String get checklist_deleteRun => '記録を削除';

  @override
  String get checklist_deleteRunConfirm => 'この記録を削除しますか？元に戻せません。';

  @override
  String checklist_deleteConfirm(String name) {
    return '$name を削除しますか？完了した記録は残ります。';
  }

  @override
  String get checklist_preTrip => '出発前';

  @override
  String get checklist_preTrip1 => '無線機を充電し、予備バッテリーを持った';

  @override
  String get checklist_preTrip2 => '無線機を電話とペアリングし、テスト送信した';

  @override
  String get checklist_preTrip3 => 'エリアのオフライン地図を保存した';

  @override
  String get checklist_preTrip4 => 'ルートと帰着予定を誰かに伝えた';

  @override
  String get checklist_preTrip5 => 'グループのチャンネルとチームの連絡先を確認した';

  @override
  String get checklist_preTrip6 => 'SOS とチェックインを一度試した';

  @override
  String get checklist_deploy => 'ノードの設置';

  @override
  String get checklist_deploy1 => '場所と許可を確認した';

  @override
  String get checklist_deploy2 => 'アンテナを取り付け、コネクタを防水した';

  @override
  String get checklist_deploy3 => '電源とソーラーを確認した';

  @override
  String get checklist_deploy4 => '無線設定と地域を確認した';

  @override
  String get checklist_deploy5 => 'テスト送信がノード経由で届いた';

  @override
  String get checklist_deploy6 => '位置・写真・メモを記録した';

  @override
  String automation_placeholders(String list) {
    return '使用できる語: $list';
  }
}
