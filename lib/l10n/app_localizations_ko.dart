// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core Ham';

  @override
  String get nav_contacts => '연락처';

  @override
  String get nav_channels => '채널';

  @override
  String get nav_map => '지도';

  @override
  String get nav_messages => '메시지';

  @override
  String get nav_nodes => '노드';

  @override
  String get nav_radio => '무전기';

  @override
  String get messages_title => '메시지';

  @override
  String get messages_filterAll => '전체';

  @override
  String get messages_filterDirect => '개인';

  @override
  String get messages_filterChannels => '채널';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => '메시지 검색';

  @override
  String get messages_searchHint => '대화 검색';

  @override
  String get messages_closeSearch => '검색 닫기';

  @override
  String get messages_manageChannels => '채널 관리';

  @override
  String get messages_new => '새로 만들기';

  @override
  String get messages_newDirect => '노드에 메시지 보내기';

  @override
  String get messages_newChannel => '채널 추가 또는 참여';

  @override
  String get messages_empty => '아직 대화가 없습니다';

  @override
  String get messages_emptyHint => '노드와 채널의 메시지가 여기에 표시됩니다.';

  @override
  String get messages_noMatches => '검색과 일치하는 대화가 없습니다';

  @override
  String messages_you(String text) {
    return '나: $text';
  }

  @override
  String get messages_yesterday => '어제';

  @override
  String messages_unreadCount(int count) {
    return '읽지 않음 $count개';
  }

  @override
  String radioStatus_connectedVia(String transport) {
    return '$transport(으)로 연결됨';
  }

  @override
  String get radioStatus_bluetooth => '블루투스';

  @override
  String get radioStatus_usb => 'USB';

  @override
  String get radioStatus_tcp => 'Wi‑Fi (TCP)';

  @override
  String radioStatus_battery(int percent) {
    return '배터리 $percent%';
  }

  @override
  String get radioStatus_openRadio => '무전기 세부정보 열기';

  @override
  String get radioOverview_battery => '배터리';

  @override
  String radioOverview_firmware(String version) {
    return '펌웨어 $version';
  }

  @override
  String get radioOverview_sendAdvert => '광고 보내기';

  @override
  String get radioOverview_stats => '무전기 통계';

  @override
  String get accessControl_title => '접근 제어';

  @override
  String get accessControl_hubSubtitle => '비밀번호 없이 로그인할 수 있는 사람';

  @override
  String get accessControl_explainRepeater =>
      '이 목록의 사람은 비밀번호 없이 로그인합니다. 관리자는 설정을 변경할 수 있고, 읽기 전용과 읽기 및 쓰기는 전체 텔레메트리도 받습니다.';

  @override
  String get accessControl_explainRoom =>
      '이 목록의 관리자는 비밀번호 없이 로그인하고 방을 관리할 수 있습니다. 방 구성원은 방 비밀번호로 참여합니다.';

  @override
  String get accessControl_roleReadOnly => '읽기 전용';

  @override
  String get accessControl_roleReadWrite => '읽기 및 쓰기';

  @override
  String get accessControl_roleAdmin => '관리자';

  @override
  String get accessControl_you => '나';

  @override
  String get accessControl_unknownNode => '알 수 없는 노드';

  @override
  String get accessControl_add => '추가';

  @override
  String get accessControl_addTitle => '접근 목록에 추가';

  @override
  String get accessControl_pickContact => '연락처 선택';

  @override
  String get accessControl_noContacts =>
      '추가할 연락처가 없습니다. 노드의 광고를 수신하면 여기에 표시됩니다.';

  @override
  String get accessControl_changeRole => '역할 변경';

  @override
  String get accessControl_remove => '접근 권한 제거';

  @override
  String accessControl_removeConfirm(String name) {
    return '$name을(를) 접근 목록에서 제거할까요? 로그인하려면 비밀번호가 필요합니다.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      '본인입니다. 자신을 제거하면 이 노드를 다시 관리하려면 관리자 비밀번호가 필요합니다.';

  @override
  String get accessControl_unknownKeyNote =>
      '연락처에 없습니다. 역할을 바꾸려면 최신 노드 펌웨어가 필요하며, 제거는 항상 가능합니다.';

  @override
  String get accessControl_prefixUnsupported =>
      '이 노드의 펌웨어는 연락처에 없는 사람의 역할을 변경할 수 없습니다. 제거는 계속 가능합니다.';

  @override
  String get accessControl_empty => '접근 목록이 비어 있습니다';

  @override
  String get accessControl_emptyHint => '사람을 추가하면 비밀번호 없이 로그인할 수 있습니다.';

  @override
  String get accessControl_loading => '노드에 접근 목록을 요청하는 중…';

  @override
  String get accessControl_timeout => '노드가 응답하지 않았습니다. 경로를 확인하고 다시 시도하세요.';

  @override
  String get accessControl_maybeIncomplete =>
      '이 노드는 한 페이지를 모두 보냈지만 펌웨어가 더 보낼 수 없어 일부 항목이 빠졌을 수 있습니다.';

  @override
  String get accessControl_saved => '접근 목록을 업데이트했습니다';

  @override
  String accessControl_failed(String reply) {
    return '노드가 변경을 거부했습니다: $reply';
  }

  @override
  String get companionCli_title => '명령줄';

  @override
  String get companionCli_tileSubtitle => '무전기에서 명령 실행';

  @override
  String get companionCli_warning => '명령은 연결된 무전기에서 실행되며 설정을 바꾸거나 재시작할 수 있습니다.';

  @override
  String get companionCli_hint => '명령 입력 (예: ver)';

  @override
  String get companionCli_send => '명령 실행';

  @override
  String get companionCli_noReply => '응답이 없습니다. 무전기가 재시작 중일 수 있습니다.';

  @override
  String get companionCli_empty => '위의 명령을 사용하거나 직접 입력하세요.';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle => '무전기를 Wi‑Fi 네트워크에 연결';

  @override
  String get wifi_unsupported => '이 무전기의 펌웨어에는 Wi‑Fi가 없습니다.';

  @override
  String get wifi_enabled => 'Wi‑Fi 사용';

  @override
  String get wifi_status => '상태';

  @override
  String get wifi_connected => '연결됨';

  @override
  String wifi_connectedIp(String ip) {
    return '연결됨 · $ip';
  }

  @override
  String get wifi_disconnected => '연결되지 않음';

  @override
  String get wifi_network => '네트워크 이름 (SSID)';

  @override
  String get wifi_password => '비밀번호';

  @override
  String get wifi_passwordKeep => '현재 비밀번호를 유지하려면 비워 두세요';

  @override
  String get wifi_save => '저장';

  @override
  String get wifi_forget => '네트워크 삭제';

  @override
  String get wifi_forgetConfirm => '저장된 네트워크와 비밀번호를 무전기에서 삭제할까요?';

  @override
  String get wifi_rebootNeeded => '저장했습니다. Wi‑Fi 변경을 적용하려면 무전기를 재시작하세요.';

  @override
  String get wifi_rebootNow => '무전기 재시작';

  @override
  String get wifi_rebootConfirm => '지금 무전기를 재시작할까요? 앱 연결이 끊어지며 다시 연결해야 합니다.';

  @override
  String get wifi_loadFailed => '무전기에서 Wi‑Fi 설정을 읽지 못했습니다.';

  @override
  String get wifi_retry => '다시 시도';

  @override
  String wifi_saveFailed(String reply) {
    return '무전기가 변경을 받아들이지 않았습니다: $reply';
  }

  @override
  String get accessControl_refresh => '새로고침';

  @override
  String get common_cancel => '취소';

  @override
  String get common_ok => '확인';

  @override
  String get common_connect => '연결하기';

  @override
  String get common_unknownDevice => '알 수 없는 장치';

  @override
  String get common_save => '저장';

  @override
  String get common_delete => '삭제';

  @override
  String get common_deleteAll => '모두 삭제';

  @override
  String get common_close => '닫기';

  @override
  String get common_done => '완료';

  @override
  String get common_edit => '수정';

  @override
  String get common_add => '추가';

  @override
  String get common_settings => '설정';

  @override
  String get common_disconnect => '연결 해제';

  @override
  String get common_connected => '연결됨';

  @override
  String get common_disconnected => '연결 해제됨';

  @override
  String get common_create => '만들기';

  @override
  String get common_continue => '계속';

  @override
  String get common_share => '공유';

  @override
  String get common_copy => '복사';

  @override
  String get common_retry => '다시 시도';

  @override
  String get common_hide => '숨기기';

  @override
  String get common_remove => '제거';

  @override
  String get common_enable => '사용';

  @override
  String get common_disable => '사용 안 함';

  @override
  String get common_undo => '되돌리기';

  @override
  String get messageStatus_sent => '전송됨';

  @override
  String get messageStatus_delivered => '전달됨';

  @override
  String get messageStatus_pending => '전송 중';

  @override
  String get messageStatus_failed => '전송 실패';

  @override
  String get messageStatus_repeated => '반복 수신됨';

  @override
  String get urlImage_enable => 'URL 이미지 사용';

  @override
  String get urlImage_possible => 'URL 이미지일 수 있습니다. 설정에서 사용하도록 하세요.';

  @override
  String get common_reboot => '재부팅';

  @override
  String get common_loading => '불러오는 중...';

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
  String get common_autoRefresh => '자동 새로고침';

  @override
  String get common_interval => '간격';

  @override
  String get scanner_title => 'NOTORYX Core Ham';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => '블루투스';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'TCP를 통해 연결';

  @override
  String get tcpHostLabel => 'IP 주소';

  @override
  String get tcpHostHint => '192.168.40.10 / example.com';

  @override
  String get tcpPortLabel => '포트';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => '엔드포인트를 입력한 뒤 연결하세요.';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return '$endpoint에 연결 중...';
  }

  @override
  String get tcpErrorHostRequired => 'IP 주소가 필요합니다.';

  @override
  String get tcpErrorPortInvalid => '포트 번호는 1에서 65535 사이여야 합니다.';

  @override
  String get tcpErrorUnsupported => '이 플랫폼에서는 TCP 트랜스포트를 지원하지 않습니다.';

  @override
  String get tcpErrorTimedOut => 'TCP 연결이 시간 초과되었습니다.';

  @override
  String tcpConnectionFailed(String error) {
    return 'TCP 연결 실패: $error';
  }

  @override
  String get usbScreenTitle => 'USB를 통해 연결';

  @override
  String get usbScreenSubtitle => '감지된 시리얼 장치를 선택하고 MeshCore 노드에 직접 연결하십시오.';

  @override
  String get usbScreenStatus => 'USB 장치를 선택하세요.';

  @override
  String get usbScreenNote =>
      'USB 직렬 통신은 지원되는 Android 기기 및 데스크톱 플랫폼에서 사용할 수 있습니다.';

  @override
  String get usbScreenEmptyState => 'USB 장치가 없습니다. 하나 연결한 뒤 새로고침하세요.';

  @override
  String get usbErrorPermissionDenied => 'USB 접근 권한이 거부되었습니다.';

  @override
  String get usbErrorDeviceMissing => '선택한 USB 장치를 더 이상 사용할 수 없습니다.';

  @override
  String get usbErrorInvalidPort => '유효한 USB 장치를 선택하세요.';

  @override
  String get usbErrorBusy => '다른 USB 연결 요청이 이미 진행 중입니다.';

  @override
  String get usbErrorNotConnected => 'USB 장치가 연결되지 않았습니다.';

  @override
  String get usbErrorOpenFailed => '선택한 USB 장치를 열 수 없습니다.';

  @override
  String get usbErrorConnectFailed => '선택한 USB 장치에 연결하지 못했습니다.';

  @override
  String get usbErrorUnsupported => '이 플랫폼에서는 USB 직렬 통신을 지원하지 않습니다.';

  @override
  String get usbErrorAlreadyActive => 'USB 연결이 이미 활성 상태입니다.';

  @override
  String get usbErrorNoDeviceSelected => 'USB 장치가 선택되지 않았습니다.';

  @override
  String get usbErrorPortClosed => 'USB 연결이 열려 있지 않습니다.';

  @override
  String get usbErrorConnectTimedOut =>
      '연결 시간이 초과되었습니다. 장치에 USB Companion 펌웨어가 있는지 확인하세요.';

  @override
  String get usbFallbackDeviceName => '웹 시리얼 장치';

  @override
  String get usbStatus_notConnected => 'USB 장치를 선택합니다.';

  @override
  String get usbStatus_connecting => 'USB 장치에 연결 중...';

  @override
  String get usbStatus_searching => 'USB 장치 검색 중...';

  @override
  String usbConnectionFailed(String error) {
    return 'USB 연결 실패: $error';
  }

  @override
  String get scanner_scanning => '장치 검색 중...';

  @override
  String get scanner_connecting => '연결 중...';

  @override
  String get scanner_disconnecting => '연결 해제 중...';

  @override
  String get scanner_notConnected => '연결되지 않음';

  @override
  String scanner_connectedTo(String deviceName) {
    return '$deviceName에 연결됨';
  }

  @override
  String get scanner_searchingDevices => 'MeshCore 장치를 검색 중...';

  @override
  String get scanner_tapToScan => 'MeshCore 장치를 찾기 위해 스캔 버튼을 누르세요.';

  @override
  String scanner_connectionFailed(String error) {
    return '연결 실패: $error';
  }

  @override
  String get scanner_stop => '멈춰';

  @override
  String get scanner_scan => '스캔';

  @override
  String get scanner_bluetoothOff => '블루투스가 꺼져 있습니다.';

  @override
  String get scanner_bluetoothOffMessage => '기기를 검색하려면 블루투스를 켜세요.';

  @override
  String get scanner_chromeRequired => 'Chrome 브라우저 필요';

  @override
  String get scanner_chromeRequiredMessage =>
      '이 웹 앱은 블루투스 지원을 위해 Google Chrome 또는 Chromium 기반 브라우저가 필요합니다.';

  @override
  String get scanner_enableBluetooth => '블루투스 켜기';

  @override
  String get scanner_bluetoothWebUnsupported =>
      '브라우저에서는 블루투스를 사용할 수 없습니다. 대신 USB로 연결하세요.';

  @override
  String get device_quickSwitch => '빠른 전환';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => '설정';

  @override
  String get settings_deviceInfo => '장치 정보';

  @override
  String get settings_appSettings => '앱 설정';

  @override
  String get settings_appSettingsSubtitle => '알림, 메시징, 지도 설정';

  @override
  String get settings_nodeSettings => '노드 설정';

  @override
  String get settings_nodeName => '노드 이름';

  @override
  String get settings_nodeNameNotSet => '설정되지 않음';

  @override
  String get settings_nodeNameHint => '노드 이름을 입력하세요';

  @override
  String get settings_nodeNameUpdated => '이름 변경';

  @override
  String get settings_radioSettings => '라디오 설정';

  @override
  String get settings_radioSettingsSubtitle => '주파수, 전력, 확산 계수';

  @override
  String get settings_radioSettingsUpdated => '라디오 설정이 업데이트되었습니다.';

  @override
  String get settings_regionSettings => '지역';

  @override
  String get settings_regionSettingsSubtitle => '저장된 지역 관리';

  @override
  String get settings_corridorRegion => '코리도 지역';

  @override
  String get settings_corridorRegionDefault => '#corridor (기본값)';

  @override
  String get settings_corridorRegionHelp =>
      '플러드 코리도 패킷에는 이 지역이 태그됩니다. 코리도 펌웨어가 없는 리피터는 이 지역을 허용할 때만 전달합니다. 비워 두면 기본 태그 #corridor를 사용합니다.';

  @override
  String get settings_corridorRegionHint => '지역 이름';

  @override
  String get settings_corridorRegionUseDefault => '기본값 사용';

  @override
  String get settings_corridorRegionUpdated => '코리도 지역을 업데이트했습니다';

  @override
  String get settings_corridorRegionFailed => '코리도 지역을 업데이트하지 못했습니다';

  @override
  String get settings_regionManagement_screenTitle => '지역 관리';

  @override
  String get settings_regionNameHint => '지역 이름 입력';

  @override
  String get settings_regionAddRegion => '지역 추가';

  @override
  String get settings_regionFetchRegions => '리피터에서 지역을 가져옵니다.';

  @override
  String get settings_regionFetchRegionsFail => '어떤 지역도 발견되지 않았습니다.';

  @override
  String get settings_regionFetchRegionsAlreadyExists => '이 지역은 이미 추가되었습니다.';

  @override
  String get settings_regionName => '지역 이름';

  @override
  String get settings_regionDeleted => '지역 삭제';

  @override
  String get settings_deleteRegion => '지역 삭제';

  @override
  String settings_deleteRegionConfirm(String region) {
    return '\"$region\"을(를) 지역 목록에서 삭제하시겠습니까?';
  }

  @override
  String get settings_location => '위치';

  @override
  String get settings_locationSubtitle => 'GPS 좌표';

  @override
  String get settings_locationUpdated => '위치 및 GPS 설정이 업데이트되었습니다.';

  @override
  String get settings_locationBothRequired => '위도와 경도를 모두 입력하세요.';

  @override
  String get settings_locationInvalid => '유효하지 않은 위도 또는 경도.';

  @override
  String get settings_locationGPSEnable => 'GPS 활성화';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'GPS를 사용하여 위치 정보를 자동으로 업데이트할 수 있도록 합니다.';

  @override
  String get settings_locationIntervalSec => 'GPS 간격 (초)';

  @override
  String get settings_locationIntervalInvalid =>
      '간격은 최소 60초 이상, 86400초 미만이어야 합니다.';

  @override
  String get settings_latitude => '위도';

  @override
  String get settings_longitude => '경도';

  @override
  String get settings_contactSettings => '연락처 설정';

  @override
  String get settings_contactSettingsSubtitle => '연락처 추가 방식 설정';

  @override
  String get settings_privacyMode => '개인 정보 보호 모드';

  @override
  String get settings_privacyModeSubtitle => '광고에 이름/위치 정보 숨기기';

  @override
  String get settings_privacyModeToggle =>
      '광고에 자신의 이름과 위치를 숨기기 위해 개인 정보 보호 모드를 켜거나 끄십시오.';

  @override
  String get settings_privacyModeEnabled => '개인 정보 보호 모드 활성화';

  @override
  String get settings_privacyModeDisabled => '개인 정보 보호 모드 비활성화';

  @override
  String get settings_privacy => '개인 정보 설정';

  @override
  String get settings_privacySubtitle => '어떤 정보를 공유할지 통제하세요.';

  @override
  String get settings_privacySettingsDescription =>
      '어떤 정보를 기기가 다른 사람들과 공유할지 선택하세요.';

  @override
  String get settings_denyAll => '모든 것을 부정';

  @override
  String get settings_allowByContact => '연락처 표시 기능 활성화';

  @override
  String get settings_allowAll => '모든 것을 허용';

  @override
  String get settings_telemetryBaseMode => '원격 모니터링 기본 설정';

  @override
  String get settings_telemetryLocationMode => '텔레메트리 위치 모드';

  @override
  String get settings_telemetryEnvironmentMode => '텔레메트리 환경 모드';

  @override
  String get settings_advertLocation => '광고 위치';

  @override
  String get settings_advertLocationSubtitle => '광고에 위치 정보를 포함하세요.';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'GPS 업데이트 시 제로 홉 광고 자동 전송';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'GPS 위치가 변경되면 제로 홉 광고를 전송합니다(광고에 위치 포함 필요).';

  @override
  String get settings_multiAck => '다중 ACK';

  @override
  String get settings_telemetryModeUpdated => '텔레메트리 모드 업데이트 완료';

  @override
  String get settings_actions => '행동';

  @override
  String get settings_deleteAllPaths => '모든 경로 삭제';

  @override
  String get settings_deleteAllPathsSubtitle => '연락처의 모든 경로 데이터를 지웁니다.';

  @override
  String get settings_sendAdvertisement => '광고 전송';

  @override
  String get settings_sendAdvertisementSubtitle => '현재 존재를 방송합니다.';

  @override
  String get settings_advertisementSent => '광고가 전송되었습니다.';

  @override
  String get settings_syncTime => '시간 동기화';

  @override
  String get settings_syncTimeSubtitle => '장치 시계를 휴대폰 시간으로 설정';

  @override
  String get settings_timeSynchronized => '시간이 동기화되었습니다.';

  @override
  String get settings_refreshContacts => '연락처 새로고침';

  @override
  String get settings_refreshContactsSubtitle => '장치에서 연락처 목록을 다시 불러오기';

  @override
  String get settings_rebootDevice => '장치 재부팅';

  @override
  String get settings_rebootDeviceSubtitle => 'MeshCore 장치를 재부팅합니다.';

  @override
  String get settings_rebootDeviceConfirm => '정말 장치를 재부팅하시겠습니까? 연결이 끊어집니다.';

  @override
  String get settings_debug => '디버그';

  @override
  String get settings_companionDebugLog => '동반 디버깅 로그';

  @override
  String get settings_companionDebugLogSubtitle =>
      'BLE/TCP/USB 명령어, 응답 및 원시 데이터';

  @override
  String get settings_appDebugLog => '앱 디버그 로그';

  @override
  String get settings_appDebugLogSubtitle => '애플리케이션 디버그 메시지';

  @override
  String get settings_about => '정보';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core Ham v$version';
  }

  @override
  String get settings_aboutLegalese => '2026 MeshCore 오픈 소스 프로젝트';

  @override
  String get settings_aboutDescription =>
      'MeshCore LoRa 메시 네트워크 장치를 위한 오픈소스 Flutter 클라이언트.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'LOS 고도 데이터: Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => '이름';

  @override
  String get settings_infoId => 'ID';

  @override
  String get settings_infoStatus => '상태';

  @override
  String get settings_infoBattery => '배터리';

  @override
  String get settings_infoPublicKey => '공개 키';

  @override
  String get settings_infoContactsCount => '연락처 수';

  @override
  String get settings_infoChannelCount => '채널 수';

  @override
  String get settings_infoHardware => '하드웨어';

  @override
  String get settings_infoFirmware => '펌웨어';

  @override
  String get settings_presets => '프리셋';

  @override
  String get settings_frequency => '주파수 (MHz)';

  @override
  String get settings_frequencyHelper => '420–450 / 902–928';

  @override
  String get settings_frequencyInvalid => '유효하지 않은 주파수 (420–450 / 902–928 MHz)';

  @override
  String get settings_bandwidth => '대역폭';

  @override
  String get settings_spreadingFactor => '분산 계수';

  @override
  String get settings_codingRate => '코딩 속도';

  @override
  String get settings_txPower => '송신 전력 (dBm)';

  @override
  String get settings_txPowerHelper => '0 - 22';

  @override
  String get settings_txPowerInvalid => '유효하지 않은 송신 전력 (0-22 dBm)';

  @override
  String get settings_clientRepeat => '오프그리드 반복';

  @override
  String get settings_clientRepeatSubtitle =>
      '이 장치가 다른 장치의 메시 패킷을 반복하도록 허용합니다.';

  @override
  String get settings_clientRepeatFreqWarning =>
      '오프그리드 반복에는 433MHz, 869MHz 또는 918MHz 주파수가 필요합니다.';

  @override
  String settings_error(String message) {
    return '오류: $message';
  }

  @override
  String get appSettings_title => '앱 설정';

  @override
  String get appSettings_appearance => '모양';

  @override
  String get appSettings_theme => '테마';

  @override
  String get appSettings_themeSystem => '시스템 기본값';

  @override
  String get appSettings_themeLight => '밝음';

  @override
  String get appSettings_themeDark => '어두움';

  @override
  String get appSettings_language => '언어';

  @override
  String get appSettings_languageSystem => '기본 설정';

  @override
  String get appSettings_languageEn => '영어';

  @override
  String get appSettings_languageFr => '프랑스어';

  @override
  String get appSettings_languageEs => '스페인어';

  @override
  String get appSettings_languageDe => '독일어';

  @override
  String get appSettings_languagePl => '폴란드어';

  @override
  String get appSettings_languageSl => '슬로베니아어';

  @override
  String get appSettings_languagePt => '포르투갈어';

  @override
  String get appSettings_languageIt => '이탈리아어';

  @override
  String get appSettings_languageZh => '중국어';

  @override
  String get appSettings_languageSv => '스웨덴어';

  @override
  String get appSettings_languageNl => '네덜란드어';

  @override
  String get appSettings_languageSk => '슬로바키아어';

  @override
  String get appSettings_languageBg => '불가리아어';

  @override
  String get appSettings_languageRu => '러시아어';

  @override
  String get appSettings_languageUk => '우크라이나어';

  @override
  String get repeater_pathHashModeOption0 => '0 - 1 바이트';

  @override
  String get repeater_pathHashModeOption1 => '1~2 바이트';

  @override
  String get repeater_pathHashModeOption2 => '2 - 3 바이트';

  @override
  String get repeater_pathHashModeOption3 => '3 - 4 바이트';

  @override
  String get appSettings_enableMessageTracing => '메시지 추적 기능 활성화';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      '메시지에 대한 상세한 경로 및 시간 정보를 표시';

  @override
  String get appSettings_notifications => '알림';

  @override
  String get appSettings_enableNotifications => '알림 활성화';

  @override
  String get appSettings_enableNotificationsSubtitle => '메시지와 광고에 대한 알림을 받으세요.';

  @override
  String get appSettings_notificationPermissionDenied => '알림 권한 거부';

  @override
  String get appSettings_notificationsEnabled => '알림 사용';

  @override
  String get appSettings_notificationsDisabled => '알림 사용 안 함';

  @override
  String get appSettings_messageNotifications => '메시지 알림';

  @override
  String get appSettings_messageNotificationsSubtitle => '새로운 메시지를 받을 때 알림 표시';

  @override
  String get appSettings_channelMessageNotifications => '채널 메시지 알림';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      '채널 메시지를 수신할 때 알림 표시';

  @override
  String get appSettings_advertisementNotifications => '광고 알림';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      '새 노드가 발견되었을 때 알림 표시';

  @override
  String get appSettings_messaging => '메시징';

  @override
  String get appSettings_clearPathOnMaxRetry => '최대 재시도 시 경로 지우기';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      '전송 시도가 5번 실패하면 연락 경로를 재설정합니다.';

  @override
  String get appSettings_pathsWillBeCleared => '5번 실패하면 해당 경로를 지웁니다.';

  @override
  String get appSettings_pathsWillNotBeCleared => '경로를 자동으로 지우지 않습니다.';

  @override
  String get appSettings_autoRouteRotation => '자동 경로 순환';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      '최적 경로와 플러드 모드 사이를 전환합니다.';

  @override
  String get appSettings_autoRouteRotationEnabled => '자동 경로 순환 기능 활성화';

  @override
  String get appSettings_autoRouteRotationDisabled => '자동 경로 순환 기능 비활성화';

  @override
  String get appSettings_maxRouteWeight => '최대 경로 가중치';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      '한 경로가 성공적인 전송을 통해 누적할 수 있는 최대 가중치';

  @override
  String get appSettings_initialRouteWeight => '초기 경로 가중치';

  @override
  String get appSettings_initialRouteWeightSubtitle => '새로 발견된 경로의 초기 가중치';

  @override
  String get appSettings_routeWeightSuccessIncrement => '성공 시 증가';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      '성공적으로 전송된 경로에 추가되는 가중치';

  @override
  String get appSettings_routeWeightFailureDecrement => '실패 시 감소';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      '전송 실패 후 경로에서 제거되는 가중치';

  @override
  String get appSettings_maxMessageRetries => '최대 메시지 재시도 횟수';

  @override
  String get appSettings_maxMessageRetriesSubtitle => '메시지를 실패로 처리하기 전 시도 횟수';

  @override
  String get appSettings_battery => '배터리';

  @override
  String get appSettings_batteryChemistry => '배터리 종류';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return '$deviceName별';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      '배터리 종류를 선택하려면 먼저 장치를 연결하세요.';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3.0-4.2V)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2.6-3.65V)';

  @override
  String get appSettings_batteryLipo => '리튬 폴리머 (3.0-4.2V)';

  @override
  String get appSettings_batteryLipoHv => '리포 HV (3.0-4.35V)';

  @override
  String get appSettings_mapDisplay => '지도 표시';

  @override
  String get appSettings_showRepeaters => '리피터 표시';

  @override
  String get appSettings_showRepeatersSubtitle => '지도에 리피터 노드를 표시';

  @override
  String get appSettings_showChatNodes => '채팅 노드 표시';

  @override
  String get appSettings_showChatNodesSubtitle => '지도에 채팅 노드를 표시';

  @override
  String get appSettings_showOtherNodes => '다른 노드 표시';

  @override
  String get appSettings_showOtherNodesSubtitle => '지도에 다른 노드 유형을 표시';

  @override
  String get appSettings_timeFilter => '시간 필터';

  @override
  String get appSettings_timeFilterShowAll => '모든 노드 표시';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return '최근 $hours시간 동안의 노드 표시';
  }

  @override
  String get appSettings_mapTimeFilter => '지도 시간 필터';

  @override
  String get appSettings_showNodesDiscoveredWithin => '다음 기간 내에 발견된 노드 표시:';

  @override
  String get appSettings_allTime => '전체 기간';

  @override
  String get appSettings_lastHour => '지난 1시간';

  @override
  String get appSettings_last6Hours => '지난 6시간';

  @override
  String get appSettings_last24Hours => '지난 24시간';

  @override
  String get appSettings_lastWeek => '지난 주';

  @override
  String get appSettings_rasterTileSource => '래스터 타일 소스';

  @override
  String get appSettings_stadiaEndpoint => 'Stadia 엔드포인트';

  @override
  String get appSettings_stadiaApiKey => 'Stadia API 키';

  @override
  String get appSettings_stadiaApiKeyRequired => 'Stadia Maps를 사용하려면 필요합니다';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return '설정됨: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Stadia Maps API 키를 입력하세요. 이 앱은 래스터 타일 요청에 이 키를 사용합니다.';

  @override
  String get appSettings_offlineMapCache => '오프라인 지도 캐시';

  @override
  String get appSettings_unitsTitle => '단위';

  @override
  String get appSettings_unitsMetric => '미터법 (m / km / °C)';

  @override
  String get appSettings_unitsImperial => '영국식 (ft / mi / °F)';

  @override
  String get appSettings_noAreaSelected => '선택된 영역 없음';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return '선택된 영역 (줌 레벨: $minZoom - $maxZoom)';
  }

  @override
  String get appSettings_debugCard => '디버그';

  @override
  String get appSettings_appDebugLogging => '앱 디버그 로깅';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      '문제 해결을 위한 앱 디버그 메시지를 기록합니다.';

  @override
  String get appSettings_appDebugLoggingEnabled => '앱 디버깅 로깅 활성화';

  @override
  String get appSettings_appDebugLoggingDisabled => '앱 디버깅 로깅 비활성화';

  @override
  String get contacts_title => '연락처';

  @override
  String get contacts_noContacts => '아직 연락처는 없습니다.';

  @override
  String get contacts_contactsWillAppear => '장치가 광고를 할 때, 연락처 정보가 표시됩니다.';

  @override
  String get contacts_unread => '읽지 않음';

  @override
  String get contacts_searchContactsNoNumber => '연락처 검색...';

  @override
  String contacts_searchContacts(int number, String str) {
    return '$number $str 연락처 검색...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return '$number $str 검색 결과 보기...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return '$number $str 사용자 검색...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return '$number $str 검색 결과 반복기 검색';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return '$number $str 방 서버 검색';
  }

  @override
  String get contacts_noUnreadContacts => '읽지 않은 연락처가 없습니다.';

  @override
  String get contacts_noContactsFound => '연락처 또는 그룹이 검색되지 않았습니다.';

  @override
  String get contacts_deleteContact => '연락처 삭제';

  @override
  String contacts_removeConfirm(String contactName) {
    return '$contactName를 연락처 목록에서 제거하시겠습니까?';
  }

  @override
  String get contacts_manageRepeater => '리피터 관리';

  @override
  String get contacts_manageRoom => '방 서버 관리';

  @override
  String get contacts_roomLogin => '방 서버 로그인';

  @override
  String get contacts_openChat => '자유로운 대화';

  @override
  String get contacts_editGroup => '편집 그룹';

  @override
  String get contacts_deleteGroup => '그룹 삭제';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return '$groupName 삭제?';
  }

  @override
  String get contacts_newGroup => '새로운 그룹';

  @override
  String get contacts_moreOptions => '더 많은 옵션';

  @override
  String get contacts_searchOpen => '연락처 검색';

  @override
  String get contacts_searchClose => '검색 닫기';

  @override
  String get contacts_groupName => '그룹 이름';

  @override
  String get contacts_groupNameRequired => '그룹 이름이 필요합니다';

  @override
  String get contacts_groupNameReserved => '이 그룹 이름은 이미 사용 중입니다.';

  @override
  String contacts_groupAlreadyExists(String name) {
    return '그룹 \"$name\"은 이미 존재합니다.';
  }

  @override
  String get contacts_filterContacts => '연락처 필터링...';

  @override
  String get contacts_noContactsMatchFilter => '입력하신 검색 조건과 일치하는 연락처가 없습니다.';

  @override
  String get contacts_noMembers => '회원 없음';

  @override
  String get contacts_lastSeenNow => '최근';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return '~ $minutes분';
  }

  @override
  String get contacts_lastSeenHourAgo => '약 1시간';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return '~ $hours시간';
  }

  @override
  String get contacts_lastSeenDayAgo => '~ 1일';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return '~ $days일';
  }

  @override
  String get contact_info => '연락처';

  @override
  String get contact_settings => '연락처 설정';

  @override
  String get contact_telemetry => '텔레메트리';

  @override
  String get contact_lastSeen => '마지막으로 목격';

  @override
  String get contact_clearChat => '명확한 대화';

  @override
  String get contact_teleBase => '텔레메트리 기반';

  @override
  String get contact_teleBaseSubtitle => '배터리 잔량 및 기본적인 통신 데이터를 공유할 수 있도록 허용';

  @override
  String get contact_teleLoc => '텔레메트리 위치';

  @override
  String get contact_teleLocSubtitle => '위치 정보 공유 허용';

  @override
  String get contact_teleEnv => '텔레메트리 환경';

  @override
  String get contact_teleEnvSubtitle => '환경 센서 데이터를 공유하도록 허용';

  @override
  String get channels_title => '채널';

  @override
  String get channels_noChannelsConfigured => '구성된 채널이 없습니다.';

  @override
  String get channels_addPublicChannel => '공개 채널 추가';

  @override
  String get channels_searchChannels => '검색 채널...';

  @override
  String get channels_noChannelsFound => '채널을 찾을 수 없습니다.';

  @override
  String channels_channelIndex(int index) {
    return '채널 $index';
  }

  @override
  String get channels_public => '대중의';

  @override
  String channels_via(String path) {
    return '$path 경유';
  }

  @override
  String get channels_viaMqtt => 'MQTT 경유';

  @override
  String get channels_viaMqttSemantics => 'MQTT로 수신됨, 내 무전기는 듣지 못함';

  @override
  String get channels_private => '키 지정';

  @override
  String get channels_editChannel => '채널 편집';

  @override
  String get channels_muteChannel => '음소거 채널';

  @override
  String get channels_unmuteChannel => '채널 음소거 해제';

  @override
  String get channels_deleteChannel => '채널 삭제';

  @override
  String channels_deleteChannelConfirm(String name) {
    return '$name 삭제하시겠습니까? 이 작업은 취소할 수 없습니다.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return '채널 \"$name\" 삭제에 실패했습니다.';
  }

  @override
  String channels_channelDeleted(String name) {
    return '채널 \"$name\" 삭제';
  }

  @override
  String get channels_addChannel => '채널 추가';

  @override
  String get channels_channelIndexLabel => '채널 인덱스';

  @override
  String get channels_channelName => '채널 이름';

  @override
  String get channels_usePublicChannel => '공개 채널 사용';

  @override
  String get channels_standardPublicPsk => '표준 공공 PSK';

  @override
  String get channels_pskHex => 'PSK (헥스)';

  @override
  String get channels_generateRandomPsk => '임의의 PSK 생성';

  @override
  String get channels_enterChannelName => '채널 이름을 입력해 주세요.';

  @override
  String get channels_pskMustBe32Hex => 'PSK(개인식별키)는 32자리 16진수 문자여야 합니다.';

  @override
  String channels_channelAdded(String name) {
    return '채널 \"$name\" 추가';
  }

  @override
  String channels_editChannelTitle(int index) {
    return '채널 $index 편집';
  }

  @override
  String get channels_smazCompression => 'SMAZ 압축';

  @override
  String get channels_cyr2latCompression => 'Cyr2Lat 압축';

  @override
  String get channels_cyr2latCompressionDscr => '보낼 때 일부 키릴 문자를 라틴 문자로 바꿉니다.';

  @override
  String get channels_cyr2latSettingsHeading => 'Cyr2Lat 설정';

  @override
  String get channels_cyr2latSettingsSubheading => '변환 목록';

  @override
  String get channels_cyr2latSettingsDscr => '문자 변환 JSON 구성 편집';

  @override
  String get channels_cyr2latSettingsDialogHint => 'JSON 변환 맵';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return '잘못된 JSON: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return '채널 \"$name\"이 업데이트되었습니다.';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Cyr2Lat 프로필 추가';

  @override
  String get settings_cyr2latProfileName => '프로필 이름';

  @override
  String get settings_cyr2latProfileNameEmpty => '프로필 이름은 비워둘 수 없습니다';

  @override
  String get settings_cyr2latProfileAdded => '프로필이 성공적으로 추가되었습니다';

  @override
  String get settings_cyr2latProfileUpdated => '프로필이 성공적으로 업데이트되었습니다';

  @override
  String get settings_cyr2latProfileEdit => 'Cyr2Lat 프로필 편집';

  @override
  String get settings_cyr2latProfileDelete => 'Cyr2Lat 프로필 삭제';

  @override
  String get settings_cyr2latProfileDeleted => '프로필이 성공적으로 삭제되었습니다';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return '\"$name\" 프로필을 삭제하시겠습니까?';
  }

  @override
  String get channels_publicChannelAdded => '공개 채널 추가';

  @override
  String get channels_sortBy => '정렬 기준 선택';

  @override
  String get channels_sortManual => '사용 설명서';

  @override
  String get channels_sortAZ => 'A부터 Z까지';

  @override
  String get channels_sortLatestMessages => '최신 메시지';

  @override
  String get channels_sortUnread => '읽지 않음';

  @override
  String get channels_createPrivateChannel => '키 지정 채널 만들기';

  @override
  String get channels_createPrivateChannelDesc =>
      '공유 키로 채널을 고릅니다. 메시지는 여전히 누구나 읽을 수 있습니다.';

  @override
  String get channels_joinPrivateChannel => '키 지정 채널 참여';

  @override
  String get channels_joinPrivateChannelDesc => '채널의 공유 키를 입력하세요.';

  @override
  String get channels_joinPublicChannel => '공개 채널에 참여하세요';

  @override
  String get channels_joinPublicChannelDesc => '누구나 이 채널에 참여할 수 있습니다.';

  @override
  String get channels_joinHashtagChannel => '해시태그 채널에 참여하세요';

  @override
  String get channels_joinHashtagChannelDesc => '누구나 해시태그 채널에 참여할 수 있습니다.';

  @override
  String get channels_scanQrCode => 'QR 코드를 스캔';

  @override
  String get channels_scanQrCodeComingSoon => '곧 출시';

  @override
  String get channels_enterHashtag => '해시태그 입력';

  @override
  String get channels_hashtagHint => '예: #팀';

  @override
  String channels_regionSetTo(String region) {
    return '지역: $region';
  }

  @override
  String get channels_regionNotSet => '지역: 없음';

  @override
  String get channels_regionSelect_Title => '지역을 선택하세요';

  @override
  String get channels_clearRegion => '명확한 지역';

  @override
  String get chat_noMessages => '아직 메시지가 없습니다.';

  @override
  String get chat_sendMessage => '메시지를 보내기';

  @override
  String chat_sendMessageTo(String contactName) {
    return '$contactName에게 메시지를 보내';
  }

  @override
  String get chat_sendMessageToStart => '시작하려면 메시지를 보내세요.';

  @override
  String get chat_originalMessageNotFound => '원래 메시지를 찾을 수 없음';

  @override
  String chat_replyingTo(String name) {
    return '$name에게 답변';
  }

  @override
  String chat_replyTo(String name) {
    return '$name님께 회신';
  }

  @override
  String get chat_location => '위치';

  @override
  String get chat_typeMessage => '메시지를 입력하세요...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return '메시지가 너무 길어서 (최대 $maxBytes 바이트).';
  }

  @override
  String get chat_messageCopied => '메시지가 복사되었습니다';

  @override
  String get chat_messageDeleted => '메시지가 삭제되었습니다.';

  @override
  String get chat_retryingMessage => '재시도 메시지';

  @override
  String chat_retryCount(int current, int max) {
    return '$current/$max 시도';
  }

  @override
  String get chat_selectSendAction => '전송 작업 선택';

  @override
  String get chat_sendGif => 'GIF 보내기';

  @override
  String get chat_limitToArea => '지역으로 제한';

  @override
  String get chat_limitToAreaTitle => '다음 범위 안에서만 보내기…';

  @override
  String get chat_limitToAreaHelp =>
      '플러드 코리도 펌웨어가 있는 리피터는 이 지역 안에서만 메시지를 중계합니다. 다른 리피터는 내 코리도 지역을 허용하지 않으면 메시지를 버립니다.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '내 주변 ${km}km';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return '내 주변 ${km}km 이내만';
  }

  @override
  String get chat_limitToAreaOff => '제한 없음';

  @override
  String get chat_limitToAreaNeedsPosition => '메시지를 지역으로 제한하려면 무전기 위치를 설정하세요.';

  @override
  String get chat_sendImageLora => 'MeshCore를 통해 이미지 보내기';

  @override
  String get chat_imagePickFailed => '그 이미지를 열 수 없었어요.';

  @override
  String get chat_receivedGif => 'GIF를 받았습니다';

  @override
  String get chat_reply => '답변';

  @override
  String get chat_addReaction => '댓글 추가';

  @override
  String get chat_me => '나';

  @override
  String get reaction_report => '이모지 반응';

  @override
  String get emojiCategorySmileys => '이모티콘';

  @override
  String get emojiCategoryGestures => '제스처';

  @override
  String get emojiCategoryHearts => '심장';

  @override
  String get emojiCategoryObjects => '대상';

  @override
  String get gifPicker_title => 'GIF 선택';

  @override
  String get gifPicker_searchHint => 'GIF 검색...';

  @override
  String get gifPicker_poweredBy => 'GIPHY에서 제공';

  @override
  String get gifPicker_noGifsFound => 'GIF 파일이 없습니다.';

  @override
  String get gifPicker_failedLoad => 'GIF 파일 로딩 실패';

  @override
  String get gifPicker_failedSearch => 'GIF 검색에 실패했습니다.';

  @override
  String get gifPicker_noInternet => '인터넷 연결 없음';

  @override
  String get debugLog_appTitle => '앱 디버깅 로그';

  @override
  String get debugLog_bleTitle => 'BLE 디버그 로그';

  @override
  String get debugLog_copyLog => '로그 기록';

  @override
  String get debugLog_clearLog => '명확한 로그';

  @override
  String get debugLog_copied => '디버깅 로그 복사';

  @override
  String get debugLog_bleCopied => 'BLE 로그 복사';

  @override
  String get debugLog_noEntries => '현재 디버깅 로그는 생성되지 않았습니다.';

  @override
  String get debugLog_enableInSettings => '설정에서 앱 디버깅 로깅을 활성화합니다.';

  @override
  String get debugLog_frames => '프레임';

  @override
  String get debugLog_rawLogRx => '원시 로그-RX';

  @override
  String get debugLog_noBleActivity => '현재 BLE 관련 활동은 없습니다.';

  @override
  String debugFrame_length(int count) {
    return '프레임 길이: $count 바이트';
  }

  @override
  String debugFrame_command(String value) {
    return '명령: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => '텍스트 메시지 프레임:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- 목적지 공개 키: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- 시간: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- 플래그: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- 텍스트 유형: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => '명령줄 인터페이스 (CLI)';

  @override
  String get debugFrame_textTypePlain => '일반 텍스트';

  @override
  String debugFrame_text(String text) {
    return '- 텍스트: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => '헥스 덤프:';

  @override
  String chat_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '홉',
      one: '홉',
    );
    return '$count $_temp0';
  }

  @override
  String get chat_removePath => '경로 제거';

  @override
  String get chat_noPathHistoryYet => '아직 경로 기록이 없습니다.\n경로를 찾기 위해 메시지를 보내세요.';

  @override
  String get chat_pathCleared => '경로가 확보되었습니다. 다음 메시지는 경로를 다시 찾을 것입니다.';

  @override
  String get chat_fullPath => '전체 경로';

  @override
  String get routing_title => '라우팅';

  @override
  String get routing_modeAuto => '자동';

  @override
  String get routing_modeFlood => '플러드';

  @override
  String get routing_modeManual => '수동';

  @override
  String get routing_modeAutoHint =>
      '가장 잘 알려진 경로를 자동으로 선택하고, 경로가 없으면 플러드로 전환합니다.';

  @override
  String get routing_modeFloodHint =>
      '모든 중계기를 통해 방송합니다. 가장 안정적이지만 송신 시간을 더 많이 사용합니다.';

  @override
  String get routing_modeManualHint => '항상 지정한 정확한 경로를 따릅니다.';

  @override
  String get routing_currentRoute => '현재 경로';

  @override
  String get routing_directNoHops => '직접 연결 - 중계 없음';

  @override
  String get routing_noPathYet => '아직 경로가 없습니다. 다음 메시지가 도착할 때까지 계속 탐색합니다.';

  @override
  String get routing_floodBroadcast => '모든 중계기를 통해 방송';

  @override
  String get routing_editPath => '경로 편집';

  @override
  String get routing_forgetPath => '경로 지우기';

  @override
  String get routing_knownPaths => '알려진 경로';

  @override
  String get routing_knownPathsHint => '전환할 경로를 선택하세요.';

  @override
  String get routing_inUse => '사용 중';

  @override
  String get routing_qualityStrong => '매우 좋음';

  @override
  String get routing_qualityGood => '좋음';

  @override
  String get routing_qualityFair => '보통';

  @override
  String get routing_qualityWorked => '작동함';

  @override
  String get routing_qualityFlood => '플러드로 수신됨';

  @override
  String get routing_qualityUntested => '미검증';

  @override
  String routing_lastWorked(String when) {
    return '$when에 작동';
  }

  @override
  String get routing_neverWorked => '아직 작동한 적 없음';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes건 성공, $failures건 실패';
  }

  @override
  String get routing_floodDelivery => '플러드 전송';

  @override
  String get pathEditor_title => '경로 만들기';

  @override
  String pathEditor_hopCounter(int count) {
    return '64개 중 $count 홉';
  }

  @override
  String get pathEditor_noHops =>
      '아직 홉이 추가되지 않았습니다. 아래 탭을 사용해 순서대로 추가하거나, 홉 없이 바로 보내려면 \"홉 없음\"으로 저장하세요.';

  @override
  String get pathEditor_addHops => '홉을 순서대로 추가하세요.';

  @override
  String get pathEditor_searchRepeaters => '리피터 검색';

  @override
  String get pathEditor_advancedHex => '고급: 원시 HEX 경로';

  @override
  String get pathEditor_hexLabel => 'HEX 접두사';

  @override
  String get pathEditor_hexHelper => '각 홉마다 2개의 16진수 바이트, 쉼표로 구분';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return '유효하지 않음: $tokens';
  }

  @override
  String get pathEditor_tooManyHops => '최대 64개의 홉';

  @override
  String get pathEditor_usePath => '이 경로 사용';

  @override
  String get pathEditor_removeHop => '홉 제거';

  @override
  String get pathEditor_unknownHop => '알 수 없는 중계기';

  @override
  String get chat_pathSavedLocally => '로컬에 저장되었습니다. 동기화할 장치에 연결하세요.';

  @override
  String get chat_pathDeviceConfirmed => '장치가 확인되었습니다.';

  @override
  String get chat_pathDeviceNotConfirmed => '기기가 아직 확인되지 않았습니다.';

  @override
  String get chat_type => '유형';

  @override
  String get chat_path => '경로';

  @override
  String get chat_publicKey => '공개 키';

  @override
  String get chat_compressOutgoingMessages => '전송되는 메시지 압축';

  @override
  String get chat_floodForced => '플러드 (강제)';

  @override
  String get chat_directForced => '직접 (강제)';

  @override
  String chat_hopsForced(int count) {
    return '$count홉 (강제)';
  }

  @override
  String get chat_floodAuto => '플러드 (자동)';

  @override
  String get chat_direct => '직접';

  @override
  String get chat_poiShared => '공유된 POI';

  @override
  String chat_unread(int count) {
    return '읽지 않음: $count';
  }

  @override
  String get chat_markAsUnread => '미리 읽지 않음으로 표시';

  @override
  String get chat_newMessages => '새로운 메시지';

  @override
  String get chat_openLink => '링크를 열기?';

  @override
  String get chat_openLinkConfirmation => '이 링크를 브라우저에서 열고 싶으신가요?';

  @override
  String get chat_open => '열기';

  @override
  String chat_couldNotOpenLink(String url) {
    return '링크를 열 수 없습니다: $url';
  }

  @override
  String get chat_invalidLink => '유효하지 않은 링크 형식';

  @override
  String get map_title => '노드 매핑';

  @override
  String get map_searchHint => '노드 이름 또는 ID 검색';

  @override
  String get map_activity => '활동';

  @override
  String get map_online => '온라인';

  @override
  String get map_recent => '최근';

  @override
  String get map_stale => '오래됨';

  @override
  String get map_visible => '보임';

  @override
  String get map_hidden => '숨김';

  @override
  String get map_centerOnNode => '노드 중심으로 보기';

  @override
  String get map_details => '세부 정보';

  @override
  String get map_noGps => 'GPS 없음';

  @override
  String get map_noResults => '일치하는 노드가 없습니다.';

  @override
  String get map_lineOfSight => '시야';

  @override
  String get map_losScreenTitle => '시야';

  @override
  String get map_noNodesWithLocation => '위치 정보가 있는 노드가 없습니다.';

  @override
  String get map_nodesNeedGps => '노드는 지도에 표시되려면 GPS 좌표를 공유해야 합니다.';

  @override
  String map_nodesCount(int count) {
    return '노드: $count';
  }

  @override
  String map_pinsCount(int count) {
    return '핀: $count';
  }

  @override
  String get map_chat => '채팅';

  @override
  String get map_repeater => '반복기';

  @override
  String get map_room => '방';

  @override
  String get map_sensor => '센서';

  @override
  String get map_pinDm => '핀 (DM)';

  @override
  String get map_pinPrivate => '개인 계정';

  @override
  String get map_pinPublic => '공개 (일반 공개)';

  @override
  String get map_lastSeen => '마지막으로 목격';

  @override
  String get map_disconnectConfirm => '이 장치와의 연결을 해제하시겠습니까?';

  @override
  String get map_from => '~부터';

  @override
  String get map_source => '출처';

  @override
  String get map_flags => '깃발';

  @override
  String get map_type => '유형';

  @override
  String get map_path => '경로';

  @override
  String get map_location => '위치';

  @override
  String get map_estLocation => '추정 위치';

  @override
  String get map_publicKey => '공개 키';

  @override
  String get map_publicKeyPrefixHint => '예: ab12';

  @override
  String get map_shareMarkerHere => '여기에서 마커 공유';

  @override
  String get map_setAsMyLocation => '내 위치로 설정';

  @override
  String get floodCorridor_title => '플러드 코리도';

  @override
  String get floodCorridor_previewToHere => '여기까지 플러드 코리도 미리보기';

  @override
  String get floodCorridor_requesting => '무전기에 코리도를 요청하는 중…';

  @override
  String get floodCorridor_unsupported => '무전기 펌웨어가 플러드 코리도를 지원하지 않습니다.';

  @override
  String get floodCorridor_noProposal =>
      '무전기가 코리도를 제안하지 못했습니다. 위치가 설정되어 있는지 확인하세요.';

  @override
  String floodCorridor_circleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '원 $count개',
    );
    return '$_temp0';
  }

  @override
  String floodCorridor_repeatersInside(int inside, int total) {
    return '알려진 리피터 $total개 중 $inside개가 안쪽에 있음';
  }

  @override
  String get floodCorridor_straightLine => '직선: 경로상에 알려진 리피터가 없습니다';

  @override
  String get floodCorridor_followsRepeaters => '알려진 리피터를 따라갑니다';

  @override
  String get floodCorridor_horizonLimited =>
      '알려진 리피터가 목적지까지 닿지 않습니다. 나머지는 직선입니다';

  @override
  String get floodCorridor_thinStretch => '코리도 일부 구간에 알려진 리피터가 적습니다';

  @override
  String get floodCorridor_moreCoverage => '더 많은 리피터 커버리지 요구';

  @override
  String get floodCorridor_previewNote =>
      '미리보기 전용입니다. 코리도 펌웨어가 없는 리피터는 코리도를 적용하지 않습니다.';

  @override
  String get map_pinLabel => '핀 라벨';

  @override
  String get map_label => '레이블';

  @override
  String get map_pointOfInterest => '관심 지점';

  @override
  String get map_sendToContact => '연락처로 보내기';

  @override
  String get map_sendToChannel => '채널로 전송';

  @override
  String get map_noChannelsAvailable => '사용 가능한 채널이 없습니다.';

  @override
  String get map_publicLocationShare => '공개 장소 공유';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return '현재 $channelLabel 채널에서 위치 정보를 공유하려고 합니다. 이 채널은 공개되어 있으며, PSK를 가진 모든 사용자가 이 위치 정보를 볼 수 있습니다.';
  }

  @override
  String get map_connectToShareMarkers => '장치를 연결하여 마커를 공유';

  @override
  String get map_filterNodes => '필터 노드';

  @override
  String get map_nodeTypes => '노드 유형';

  @override
  String get map_chatNodes => '채팅 노드';

  @override
  String get map_repeaters => '다시 보내는 장치';

  @override
  String get map_otherNodes => '다른 노드';

  @override
  String get map_showOverlaps => '반복 키 중복';

  @override
  String get map_keyPrefix => '핵심 접두사';

  @override
  String get map_filterByKeyPrefix => '주요 접두사 기준으로 필터링';

  @override
  String get map_publicKeyPrefix => '공개 키 접두사';

  @override
  String get map_markers => '마커';

  @override
  String get map_showSharedMarkers => '공통 마커 표시';

  @override
  String get map_showGuessedLocations => '추정된 노드 위치 표시';

  @override
  String get map_showDiscoveryContacts => '디스커버리 담당자 연락처 보기';

  @override
  String get map_guessedLocation => '추측된 위치';

  @override
  String get map_lastSeenTime => '마지막으로 확인된 시간';

  @override
  String get map_sharedPin => '공유 비밀번호';

  @override
  String get map_sharedAt => '공유됨';

  @override
  String get map_joinRoom => '방에 참여';

  @override
  String get map_manageRepeater => '리피터 관리';

  @override
  String get map_tapToAdd => '노드에 클릭하여 경로에 추가합니다.';

  @override
  String get map_runTrace => '경로 추적';

  @override
  String get map_runTraceWithReturnPath => '원래 경로로 돌아가세요.';

  @override
  String get map_removeLast => '마지막 항목 삭제';

  @override
  String get map_pathTraceCancelled => '경로 추적 기능이 취소되었습니다.';

  @override
  String get mapCache_title => '오프라인 지도 캐시';

  @override
  String get mapCache_selectAreaFirst => '캐시할 영역을 먼저 선택하세요';

  @override
  String get mapCache_noTilesToDownload => '이 지역에 다운로드할 타일이 없습니다.';

  @override
  String get mapCache_downloadTilesTitle => '타일 다운로드';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return '$count개의 타일을 오프라인 사용을 위해 다운로드하시겠습니까?';
  }

  @override
  String get mapCache_downloadAction => '다운로드';

  @override
  String mapCache_cachedTiles(int count) {
    return '$count 개의 타일 캐시';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return '캐시된 타일 $downloaded개 ($failed개 실패)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => '오프라인 캐시 삭제';

  @override
  String get mapCache_clearOfflineCachePrompt => '모든 캐시된 지도 템플릿을 삭제하시겠습니까?';

  @override
  String get mapCache_offlineCacheCleared => '오프라인 캐시 삭제';

  @override
  String get mapCache_noAreaSelected => '선택된 영역 없음';

  @override
  String get mapCache_cacheArea => '캐시 영역';

  @override
  String get mapCache_useCurrentView => '현재 보기 유지';

  @override
  String get mapCache_zoomRange => '줌 기능 범위';

  @override
  String mapCache_estimatedTiles(int count) {
    return '예상되는 타일 개수: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return '다운로드됨 $completed / $total';
  }

  @override
  String get mapCache_downloadTilesButton => '타일 다운로드';

  @override
  String get mapCache_clearCacheButton => '캐시 삭제';

  @override
  String mapCache_failedDownloads(int count) {
    return '실패한 다운로드: $count';
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
  String get time_justNow => '방금';

  @override
  String time_minutesAgo(int minutes) {
    return '$minutes분 전';
  }

  @override
  String time_hoursAgo(int hours) {
    return '$hours시간 전';
  }

  @override
  String time_daysAgo(int days) {
    return '$days일 전';
  }

  @override
  String get time_hour => '시간';

  @override
  String get time_hours => '시간';

  @override
  String get time_day => '하루';

  @override
  String get time_days => '일';

  @override
  String get time_week => '주';

  @override
  String get time_weeks => '몇 주';

  @override
  String get time_month => '달';

  @override
  String get time_months => '개월';

  @override
  String get time_minutes => '분';

  @override
  String get time_allTime => '모든 시간';

  @override
  String get dialog_disconnect => '연결 해제';

  @override
  String get dialog_disconnectConfirm => '이 장치와의 연결을 해제하시겠습니까?';

  @override
  String get login_repeaterLogin => '다시 로그인';

  @override
  String get login_roomLogin => '방 서버 로그인';

  @override
  String get login_password => '비밀번호';

  @override
  String get login_enterPassword => '비밀번호를 입력하세요';

  @override
  String get login_savePassword => '비밀번호 저장';

  @override
  String get login_savePasswordSubtitle => '비밀번호는 이 장치에 안전하게 저장됩니다.';

  @override
  String get login_repeaterDescription => '반복기 비밀번호를 입력하여 설정 및 상태를 확인하십시오.';

  @override
  String get login_roomDescription => '설정 및 상태에 액세스하려면 방 비밀번호를 입력하세요.';

  @override
  String get login_routing => '라우팅';

  @override
  String get login_routingMode => '라우팅 모드';

  @override
  String get login_autoUseSavedPath => '자동 (저장된 경로 사용)';

  @override
  String get login_forceFloodMode => '강수 모드 활성화';

  @override
  String get login_managePaths => '경로 관리';

  @override
  String get login_login => '로그인';

  @override
  String login_attempt(int current, int max) {
    return '시도 $current/$max';
  }

  @override
  String login_failed(String error) {
    return '로그인 실패: $error';
  }

  @override
  String get login_failedMessage =>
      '로그인에 실패했습니다. 비밀번호가 잘못되었거나, 연결이 되지 않는 것 같습니다.';

  @override
  String get common_reload => '다시 불러오기';

  @override
  String get common_clear => '지우기';

  @override
  String get path_currentPathLabel => '현재 경로';

  @override
  String get path_noRepeatersFound => '반복 장치 또는 서버는 찾을 수 없습니다.';

  @override
  String get repeater_management => '리피터 관리';

  @override
  String get room_management => '방 서버 관리';

  @override
  String get repeater_guest => '반복 장비 정보';

  @override
  String get room_guest => '서버 정보';

  @override
  String get repeater_managementTools => '관리 도구';

  @override
  String get repeater_guestTools => '손님용 도구';

  @override
  String get repeater_status => '상태';

  @override
  String get repeater_statusSubtitle => '반복 장비의 상태, 통계, 및 이웃 장비 목록 보기';

  @override
  String get repeater_telemetry => '텔레메트리';

  @override
  String get repeater_telemetrySubtitle => '센서 및 시스템 상태에 대한 통신 데이터를 확인';

  @override
  String get repeater_cli => '명령줄 인터페이스 (CLI)';

  @override
  String get repeater_cliSubtitle => '리피터에 명령을 전송';

  @override
  String get repeater_neighbors => '이웃';

  @override
  String get repeater_neighborsSubtitle => '0홉 이웃 노드를 확인합니다.';

  @override
  String get repeater_settings => '설정';

  @override
  String get repeater_settingsSubtitle => '리피터 파라미터 설정';

  @override
  String get repeater_clockSyncAfterLogin => '로그인 후 시계 동기화';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      '성공적인 로그인 후, 자동으로 \"시간 동기화\"를 전송합니다.';

  @override
  String get repeater_statusTitle => '반복 장치 상태';

  @override
  String get repeater_routingMode => '라우팅 방식';

  @override
  String get repeater_refresh => '새롭게';

  @override
  String get repeater_statusRequestTimeout => '상태 확인 요청이 시간 초과되었습니다.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return '상태 로딩 오류: $error';
  }

  @override
  String get repeater_systemInformation => '시스템 정보';

  @override
  String get repeater_battery => '배터리';

  @override
  String get repeater_clockAtLogin => '로그인 시 시간 표시';

  @override
  String get repeater_uptime => '가동 시간';

  @override
  String get repeater_queueLength => '대기 줄의 길이';

  @override
  String get repeater_debugFlags => '디버깅 플래그';

  @override
  String get repeater_radioStatistics => '라디오 통계';

  @override
  String get repeater_lastRssi => '마지막 RSSI 값';

  @override
  String get repeater_lastSnr => '마지막 SNR';

  @override
  String get repeater_noiseFloor => '잡음 수준';

  @override
  String get repeater_txAirtime => 'TX 에어타임';

  @override
  String get repeater_rxAirtime => 'RX 에어타임';

  @override
  String get repeater_chanUtil => '채널 활용도';

  @override
  String get repeater_packetStatistics => '패킷 통계';

  @override
  String get repeater_sent => '발송';

  @override
  String get repeater_received => '수신';

  @override
  String get repeater_duplicates => '중복';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days일 $hours시간 $minutes분 $seconds초';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return '총: $total, 홍수: $flood, 직접: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return '총: $total, 홍수: $flood, 직접: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return '홍수: $flood, 직접: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return '총: $total';
  }

  @override
  String get repeater_settingsTitle => '리피터 설정';

  @override
  String get repeater_basicSettings => '기본 설정';

  @override
  String get repeater_repeaterName => '반복 장비 이름';

  @override
  String get repeater_repeaterNameHelper => '이 반복기용 표시 이름';

  @override
  String get repeater_adminPassword => '관리자 비밀번호';

  @override
  String get repeater_adminPasswordHelper => '전체 접근 권한 비밀번호';

  @override
  String get repeater_guestPassword => '게스트 비밀번호';

  @override
  String get repeater_guestPasswordHelper => '읽기 전용 접근 비밀번호';

  @override
  String get repeater_radioSettings => '라디오 설정';

  @override
  String get repeater_frequencyMhz => '주파수 (MHz)';

  @override
  String get repeater_frequencyHelper => '420–450 / 902–928 MHz';

  @override
  String get repeater_txPower => 'TX 파워';

  @override
  String get repeater_txPowerHelper => '1~30 dBm';

  @override
  String get repeater_bandwidth => '대역폭';

  @override
  String get repeater_spreadingFactor => '분산 계수';

  @override
  String get repeater_codingRate => '코딩 속도';

  @override
  String get repeater_locationSettings => '위치 설정';

  @override
  String get repeater_latitude => '위도';

  @override
  String get repeater_latitudeHelper => '십진법 위도 (예: 37.7749)';

  @override
  String get repeater_longitude => '경도';

  @override
  String get repeater_longitudeHelper => '십진법 위도 (예: -122.4194)';

  @override
  String get repeater_features => '특징';

  @override
  String get repeater_packetForwarding => '패킷 전송';

  @override
  String get repeater_packetForwardingSubtitle => '리피터가 패킷을 전달하도록 설정';

  @override
  String get repeater_guestAccess => '게스트 접근';

  @override
  String get repeater_guestAccessSubtitle => '게스트의 읽기 전용 접근 권한 허용';

  @override
  String get repeater_privacyMode => '개인 정보 보호 모드';

  @override
  String get repeater_privacyModeSubtitle => '광고에 이름/위치 정보 숨기기';

  @override
  String get repeater_advertisementSettings => '광고 설정';

  @override
  String get repeater_localAdvertInterval => '지역 광고 시간 간격';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes 분';
  }

  @override
  String get repeater_floodAdvertInterval => '홍수 광고 간격';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours 시간';
  }

  @override
  String get repeater_encryptedAdvertInterval => '암호화된 광고 간격';

  @override
  String get repeater_dangerZone => '위험 구역';

  @override
  String get repeater_rebootRepeater => '리부트 반복';

  @override
  String get repeater_rebootRepeaterSubtitle => '리피터 장치를 재시작하세요.';

  @override
  String get repeater_rebootRepeaterConfirm => '반복기를 재부팅하시려는 것이 맞으신가요?';

  @override
  String get repeater_regenerateIdentityKey => '아이디 키 재 생성';

  @override
  String get repeater_regenerateIdentityKeySubtitle => '새로운 공개/개인 키 쌍 생성';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      '이를 통해 리피터에 새로운 식별자를 할당합니다. 계속 진행하시겠습니까?';

  @override
  String get repeater_eraseFileSystem => '파일 시스템 삭제';

  @override
  String get repeater_eraseFileSystemSubtitle => '리피터 파일 시스템을 포맷합니다.';

  @override
  String get repeater_eraseFileSystemConfirm =>
      '경고: 이 작업은 리피터에 있는 모든 데이터를 삭제합니다. 이 작업을 되돌릴 수 없습니다!';

  @override
  String get repeater_eraseSerialOnly =>
      '\'Erase\' 기능은 시리얼 콘솔을 통해서만 사용할 수 있습니다.';

  @override
  String repeater_commandSent(String command) {
    return '명령 전송: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return '명령 전송 오류: $error';
  }

  @override
  String get repeater_confirm => '확인';

  @override
  String get repeater_settingsSaved => '설정이 성공적으로 저장되었습니다.';

  @override
  String get repeater_rxGain => '향상된 RX 성능';

  @override
  String get repeater_rxGainHelper =>
      '더 높은 감도, 더 많은 전류 소모 (SX1262/SX1268에만 해당)';

  @override
  String get repeater_refreshRxGain => 'RX 성능 향상 효과 재확인';

  @override
  String get repeater_multiAcks => '다중 ACK';

  @override
  String get repeater_multiAcksSubtitle => '다양한 경로를 통해 메시지를 확인하여 전달 효율성을 높입니다.';

  @override
  String get repeater_refreshMultiAcks => '다중 ACK 재확인';

  @override
  String get repeater_networkHealth => '네트워크 상태';

  @override
  String get repeater_loopDetect => '루프 감지';

  @override
  String get repeater_loopDetectHelper => '라우팅 루프처럼 보이는 과도한 데이터 패킷을 전송';

  @override
  String get repeater_loopDetectOff => '거기';

  @override
  String get repeater_loopDetectMinimal => '최소';

  @override
  String get repeater_loopDetectModerate => '적당한';

  @override
  String get repeater_loopDetectStrict => '엄격한';

  @override
  String get repeater_dutyCycle => '작동 주기';

  @override
  String get repeater_dutyCycleHelper => '허용되는 최대 방송 시간 비율';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => '운영자 정보';

  @override
  String get repeater_ownerInfoHelper => '이 리피터에 대한 공개 메타데이터';

  @override
  String get repeater_refreshOwnerInfo => '운영자 정보 업데이트';

  @override
  String get repeater_floodMax => '최대 홉 수';

  @override
  String get repeater_floodMaxHelper => '최대 패킷이 이동할 수 있는 홉 수 (0-64)';

  @override
  String get repeater_advancedSettings => '고급';

  @override
  String get repeater_advancedSettingsSubtitle => '숙련된 운영자를 위한 조절 노브';

  @override
  String get repeater_pathHashMode => '패스 해시 모드';

  @override
  String get repeater_pathHashModeHelper =>
      '이 리피터의 ID를 플러드 경로/루프 감지 태그에 인코딩하는 데 사용되는 바이트 수입니다. 0=1바이트(256개 ID, 최대 64홉), 1=2바이트(65,000개 ID, 최대 32홉), 2=3바이트(1,600만 개 ID, 최대 21홉). v1.14 이전 펌웨어는 항상 1바이트 경로를 사용했으며, v1.14 이상은 2바이트 또는 3바이트 경로로 설정할 수 있습니다.';

  @override
  String get repeater_keySettings => '신원 키 변경';

  @override
  String get repeater_keySettingsSubtitle => '공개/비공개 키 쌍을 변경하세요';

  @override
  String get repeater_prvKey => '개인 키';

  @override
  String get repeater_prvKeyHelper => '리피터의 새로운 개인 키로, 128자리의 16진수 문자열입니다.';

  @override
  String get repeater_generatePrvKey => '임의의 키 쌍을 생성하세요.';

  @override
  String get repeater_stopGeneratingPrvKey => '키페어 검색 중단';

  @override
  String get repeater_pubKey => '공개 키';

  @override
  String get repeater_pubKeyHelper =>
      '이것은 생성된 개인 키와 함께 사용되는 공개 키입니다. 직접 설정할 수 없습니다.';

  @override
  String get repeater_pubKeyPrefix => '원하는 접두사';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return '이러한 16진수로 시작하는 공개 키를 찾으세요. 필요한 시도 횟수: $tries.';
  }

  @override
  String get repeater_txDelay => '플러드 TX 지연';

  @override
  String get repeater_txDelayHelper =>
      '홍수 시 교통량에 맞춰 재전송 간격을 설정합니다. 이는 패킷의 전송 시간을 곱한 값 (0-2, 기본값 0.5)으로 설정합니다. 값이 클수록 충돌이 줄어들지만 전송 속도가 느려집니다.';

  @override
  String get repeater_directTxDelay => '직접적인 TX 지연';

  @override
  String get repeater_directTxDelayHelper =>
      '직접 (대량 전송이 아닌) 트래픽에 대한 재전송 간격을, 패킷의 전송 시간을 곱하여 설정 (0-2, 기본값 0.3).';

  @override
  String get repeater_intThresh => '간섭 허용치';

  @override
  String get repeater_intThreshHelper =>
      '신호의 잡음 수준을 기준으로 작동하며, 이 수준 이상의 간섭은 차단합니다. 0은 비활성화 상태를 의미하며, 잡음이 심한 대역에서 RX 오류가 발생할 경우에만 활성화해야 합니다.';

  @override
  String get repeater_agcResetInterval => 'AGC 재설정 간격';

  @override
  String get repeater_agcResetIntervalHelper =>
      '자동 게인 제어를 재설정하여 신호가 불안정해졌을 때 원래 상태로 복구하는 빈도를 설정하는 방법은 다음과 같습니다. 4의 배수 단위로 설정하면 주기적인 재설정이 수행됩니다. 0을 설정하면 주기적인 재설정이 수행되지 않습니다.';

  @override
  String get repeater_actionsTitle => '행동';

  @override
  String get repeater_sendAdvert => '홍수 관련 광고 전송';

  @override
  String get repeater_sendAdvertSubtitle => '네트워크를 통해 홍수 광고를 방송';

  @override
  String get repeater_sendAdvertZeroHop => '제로 홉 광고 전송';

  @override
  String get repeater_sendAdvertZeroHopSubtitle => '단일 중계 (중계 없이) 광고를 송출';

  @override
  String get repeater_clockSync => '현재 시계 동기화';

  @override
  String get repeater_clockSyncSubtitle => '스마트폰의 시간을 리피터로 설정';

  @override
  String repeater_actionSucceeded(String action) {
    return '$action이 성공적으로 완료되었습니다.';
  }

  @override
  String repeater_actionFailed(String action, String error) {
    return '$action 실패: $error';
  }

  @override
  String get repeater_settingsSavedRebootNeeded =>
      '설정이 저장되었습니다. 다시 시작하여 설정을 적용하세요.';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return '다음 설정에 실패했습니다: $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return '설정 저장 오류: $error';
  }

  @override
  String get repeater_refreshBasicSettings => '기본 설정 초기화';

  @override
  String get repeater_refreshRadioSettings => '라디오 설정 초기화';

  @override
  String get repeater_refreshTxPower => 'TX 전원 재설정';

  @override
  String get repeater_refreshPacketForwarding => '패킷 전송 재시작';

  @override
  String get repeater_refreshGuestAccess => '게스트 접근 권한 갱신';

  @override
  String get repeater_refreshPrivacyMode => '개인 정보 보호 모드 재설정';

  @override
  String repeater_refreshed(String label) {
    return '$label가 갱신됨';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return '$label를 새로 고침 중 오류 발생';
  }

  @override
  String get repeater_cliTitle => '리피터 CLI';

  @override
  String get repeater_debugNextCommand => '다음 명령 디버깅';

  @override
  String get repeater_commandHelp => '명령 도움';

  @override
  String get repeater_clearHistory => '명확한 역사';

  @override
  String get repeater_noCommandsSent => '아직 명령이 전송되지 않았습니다.';

  @override
  String get repeater_typeCommandOrUseQuick => '아래에 명령어를 입력하거나, 빠른 명령어를 사용하세요.';

  @override
  String get repeater_enterCommandHint => '명령어를 입력하세요...';

  @override
  String get repeater_previousCommand => '이전 명령어';

  @override
  String get repeater_nextCommand => '다음 명령어';

  @override
  String get repeater_enterCommandFirst => '먼저 명령어를 입력하세요';

  @override
  String get repeater_cliCommandFrameTitle => 'CLI 명령어 프레임';

  @override
  String repeater_cliCommandError(String error) {
    return '오류: $error';
  }

  @override
  String get repeater_cliQuickGetName => '이름을 알려주세요';

  @override
  String get repeater_cliQuickGetRadio => '라디오 듣기';

  @override
  String get repeater_cliQuickGetTx => 'TX 획득';

  @override
  String get repeater_cliQuickNeighbors => '이웃';

  @override
  String get repeater_cliQuickVersion => '버전';

  @override
  String get repeater_cliQuickAdvertise => '광고';

  @override
  String get repeater_cliQuickClock => '시계';

  @override
  String get repeater_cliQuickClockSync => '시계 동기화';

  @override
  String get repeater_cliQuickDiscovery => '이웃 발견하기';

  @override
  String get repeater_cliHelpAdvert => '광고 패킷을 발송';

  @override
  String get repeater_cliHelpReboot =>
      '장치를 재부팅합니다. (참고: \'시간 초과\' 오류가 발생할 수 있으며, 이는 정상적인 현상입니다)';

  @override
  String get repeater_cliHelpClock => '각 기기의 시계에 표시되는 현재 시간';

  @override
  String get repeater_cliHelpPassword => '장치에 새로운 관리자 비밀번호를 설정합니다.';

  @override
  String get repeater_cliHelpVersion => '장치 버전 및 펌웨어 빌드 날짜를 표시합니다.';

  @override
  String get repeater_cliHelpClearStats => '다양한 통계 지표를 0으로 초기화합니다.';

  @override
  String get repeater_cliHelpSetAf => '에어 타임 요소를 설정합니다.';

  @override
  String get repeater_cliHelpSetTx =>
      'LoRa 전송 전력을 dBm 단위로 설정합니다. (설정을 적용하려면 재부팅 필요)';

  @override
  String get repeater_cliHelpSetRepeat => '이 노드에 대한 리피터 역할을 활성화하거나 비활성화합니다.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(방 서버) \'켜짐\' 상태인 경우, 빈 비밀번호로 로그인할 수 있지만, 방에 게시할 수는 없습니다 (단, 읽기만 가능).';

  @override
  String get repeater_cliHelpSetFloodMax =>
      '들어오는 플러드 패킷의 최대 홉 수를 설정합니다 (최대 홉 수보다 크거나 같으면 패킷은 전달되지 않습니다).';

  @override
  String get repeater_cliHelpSetIntThresh =>
      '간섭 임계값을 설정합니다 (dB 단위). 기본값은 14입니다. 0으로 설정하면 채널 간섭 감지 기능을 비활성화합니다.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      '자동 게인 제어기를 재설정하는 간격을 설정합니다. 0으로 설정하면 비활성화됩니다.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      '\'더블 ACK\' 기능을 활성화하거나 비활성화할 수 있습니다.';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      '로컬 (제로 홉) 광고 패킷을 전송하는 간격 (분 단위)을 설정합니다. 0으로 설정하면 비활성화됩니다.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      '시간 단위로 광고 패킷을 전송하는 간격을 설정합니다. 0으로 설정하면 비활성화됩니다.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      '게스트 비밀번호를 설정하거나 업데이트합니다. (반복 사용자, 게스트 로그인 시 \"통계 가져오기\" 요청을 보낼 수 있음)';

  @override
  String get repeater_cliHelpSetName => '광고 이름을 설정합니다.';

  @override
  String get repeater_cliHelpSetLat => '광고 지도의 위도를 설정합니다. (십진법 단위)';

  @override
  String get repeater_cliHelpSetLon => '광고 지도의 경도를 설정합니다. (십진도)';

  @override
  String get repeater_cliHelpSetRadio =>
      '완전히 새로운 라디오 파라미터를 설정하고, 선호 사항에 저장합니다. 적용하려면 \"재부팅\" 명령이 필요합니다.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      '(실험용) 기본 설정 (최소 1이어야 함)으로, 수신된 패킷에 약간의 지연을 적용하며, 신호 강도/점수를 기준으로 설정합니다. 0으로 설정하면 비활성화됩니다.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      '공통 패킷의 전송 지연 시간을 설정하며, 시간-공기 시간과 무작위 슬롯 시스템을 곱하여 충돌 가능성을 줄입니다.';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'txdelay와 동일하게, 하지만 직접 모드 패킷 전송 시 무작위 지연을 적용하는 경우';

  @override
  String get repeater_cliHelpSetBridgeEnabled => '브리지 활성화/비활성화';

  @override
  String get repeater_cliHelpSetBridgeDelay => '패킷 재전송 전에 지연 시간을 설정합니다.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      '브리지가 수신된 패킷을 다시 전송할지, 아니면 전송된 패킷을 다시 전송할지 선택하십시오.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'rs232 브리지에 대한 직렬 통신 속도(baud rate)를 설정합니다.';

  @override
  String get repeater_cliHelpSetBridgeSecret => 'ESPNow 브리지에 대한 비밀 설정';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      '특정 보드에서만 지원되는 방식으로, 보고되는 배터리 전압을 조정하기 위한 사용자 정의 요소를 설정할 수 있습니다.';

  @override
  String get repeater_cliHelpTempRadio =>
      '주어진 시간(분) 동안 임시 라디오 파라미터를 설정하고, 이후 원래 라디오 파라미터로 되돌립니다. (설정을 저장하지 않습니다).';

  @override
  String get repeater_cliHelpSetPerm =>
      'ACL을 수정합니다. \"permissions\" 값이 0인 경우, 일치하는 항목(pubkey 접두사)을 제거합니다. pubkey-hex 길이가 완전하고 현재 ACL에 없는 경우 새로운 항목을 추가합니다. pubkey 접두사를 기준으로 항목을 업데이트합니다. 권한 비트는 펌웨어 역할에 따라 다르지만, 하위 2비트는 다음과 같습니다: 0 (게스트), 1 (읽기 전용), 2 (읽기/쓰기), 3 (관리자)';

  @override
  String get repeater_cliHelpGetBridgeType => '브리지형, RS232, ESPNOW 지원';

  @override
  String get repeater_cliHelpLogStart => '패킷 로깅을 파일 시스템으로 시작합니다.';

  @override
  String get repeater_cliHelpLogStop => '패킷 로깅을 파일 시스템으로 저장하는 것을 중단합니다.';

  @override
  String get repeater_cliHelpLogErase => '파일 시스템에서 패킷 로그를 삭제합니다.';

  @override
  String get repeater_cliHelpNeighbors =>
      '제로 홉 광고를 통해 수신된 다른 리피터 노드 목록을 보여줍니다. 각 줄은 ID-프리픽스-16진수:타임스탬프:SNR-횟수-4 형식입니다.';

  @override
  String get repeater_cliHelpNeighborRemove =>
      '이 함수는 지정된 pubkey 접두사(16진수)와 일치하는 첫 번째 항목을 이웃 목록에서 제거합니다.';

  @override
  String get repeater_cliHelpRegion =>
      '(단일 시리즈) 정의된 모든 지역과 현재 홍수 허가 정보를 나열합니다.';

  @override
  String get repeater_cliHelpRegionLoad =>
      '참고: 이는 여러 명령을 한 번에 실행하는 특별한 방식입니다. 각 후속 명령은 영역 이름이며 (부모 계층 구조를 나타내기 위해 공백으로 들여쓰기하며, 최소 1개의 공백을 사용) 공백으로 끝나는 줄 또는 명령을 보내어 종료합니다.';

  @override
  String get repeater_cliHelpRegionGet =>
      '주어진 이름 접두사(또는 전역 검색을 위한 \"\\*\" 사용)를 사용하여 특정 지역을 검색합니다. 결과를 \"-> 지역 이름 (상위 지역 이름) \'F\'\" 형태로 반환합니다.';

  @override
  String get repeater_cliHelpRegionPut => '주어진 이름으로 지역 정의를 추가하거나 업데이트합니다.';

  @override
  String get repeater_cliHelpRegionRemove =>
      '지정된 이름으로 특정 영역 정의를 제거합니다. (정확히 일치해야 하며, 하위 영역은 존재하지 않아야 합니다)';

  @override
  String get repeater_cliHelpRegionAllowf =>
      '지정된 영역에 대한 \'물\' 접근 권한을 설정합니다. (\'*\'는 전역/기존 범위에 해당)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      '지정된 영역에 대해 \'Flood\' 권한을 제거합니다. (참고: 현재 단계에서는 전역/기존 범위에서 이 기능을 사용하지 않는 것이 좋습니다!!)';

  @override
  String get repeater_cliHelpRegionHome =>
      '현재 \'홈\' 지역으로 응답합니다. (아직 적용되지 않았으며, 향후 사용을 위해 예약됨)';

  @override
  String get repeater_cliHelpRegionHomeSet => '\'홈\' 지역을 설정합니다.';

  @override
  String get repeater_cliHelpRegionSave => '지역 목록/지도를 저장에 유지합니다.';

  @override
  String get repeater_cliHelpGps =>
      'GPS 상태를 표시합니다. GPS가 꺼져 있으면 \"꺼짐\"이라고 표시하고, 켜져 있으면 \"켜짐\", 상태, 위치 정보, 위성 수 등을 표시합니다.';

  @override
  String get repeater_cliHelpGpsOnOff => 'GPS 전원 상태를 켜고 끄는 기능.';

  @override
  String get repeater_cliHelpGpsSync => '노드 시간을 GPS 시계와 동기화합니다.';

  @override
  String get repeater_cliHelpGpsSetLoc => '노드의 위치를 GPS 좌표로 설정하고, 설정을 저장합니다.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      '노드의 위치 광고 설정:\n- none: 광고에 위치 정보를 포함하지 않음\n- share: GPS 위치 정보를 공유 (SensorManager에서 가져옴)\n- prefs: 설정에 저장된 위치를 광고';

  @override
  String get repeater_cliHelpGpsAdvertSet => '위치 기반 광고 설정 구성';

  @override
  String get repeater_commandsListTitle => '명령 목록';

  @override
  String get repeater_commandsListNote =>
      '참고: 다양한 \"set...\" 명령과 함께 \"get...\" 명령도 존재합니다.';

  @override
  String get repeater_general => '일반';

  @override
  String get repeater_settingsCategory => '설정';

  @override
  String get repeater_bridge => '다리';

  @override
  String get repeater_logging => '로깅';

  @override
  String get repeater_neighborsRepeaterOnly => '이웃 (단방향 통신만 지원)';

  @override
  String get repeater_regionManagementRepeaterOnly => '지역 관리 (단, 중계 기능만 사용)';

  @override
  String get repeater_regionNote =>
      '지역별 관리 기능을 도입하여 지역 정의 및 권한 관리를 수행할 수 있습니다.';

  @override
  String get repeater_gpsManagement => 'GPS 관리';

  @override
  String get repeater_gpsNote => 'GPS 명령이 위치 관련 주제를 관리하기 위해 도입되었습니다.';

  @override
  String get repeater_getCategory => '가치 얻기';

  @override
  String get repeater_powerMgmt => '전력 관리';

  @override
  String get repeater_sensors => '센서';

  @override
  String get repeater_cliHelpPowerOff => '장치를 끄는 기능 (응답이 없을 것으로 예상)';

  @override
  String get repeater_cliHelpClkReboot => '시계를 알려진 시점으로 재설정하고 장치를 재부팅합니다.';

  @override
  String get repeater_cliHelpAdvertZeroHop => '직접적인 연결 없이 이웃에게만 광고를 전송합니다.';

  @override
  String get repeater_cliHelpStartOta => '지원되는 보드에서 무선으로 펌웨어 업데이트를 시작합니다.';

  @override
  String get repeater_cliHelpTime =>
      '장치를 주어진 유닉스 에포크 초부터 시간으로 설정합니다. 시간은 이전으로 이동할 수 없습니다.';

  @override
  String get repeater_cliHelpBoard => '제조사/하드웨어 식별 정보를 표시합니다.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      '인접한 노드에 대한 탐색 요청을 보냅니다. (리피터만 해당)';

  @override
  String get repeater_cliHelpPowersaving => '절전 모드가 켜져 있는지 확인하는 표시';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      '절전 모드를 활성화하거나 비활성화할 수 있습니다 (지원되는 경우).';

  @override
  String get repeater_cliHelpErase =>
      '(단일 사용) 장치 파일 시스템을 포맷합니다. 모든 설정 및 연락처를 삭제합니다.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      '최대 허용 전송 주기(백분율)를 설정합니다(1~100%). 내부적으로 통신 시간을 조정합니다.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '(시리얼 키만 해당) 장치 식별용 개인 키를 대체합니다. 적용하려면 재부팅이 필요합니다. 새로운 공개 키를 생성합니다.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(SX126x 전용) 더 높은 전류를 사용할 때 더 나은 감도를 위해 증폭된 RX 감쇠 기능을 전환합니다.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      '광고에 포함된 소유자 연락처 정보를 지정합니다. 줄 바꿈을 위해 \'|\' 문자를 사용합니다.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      '경로 해시 모드를 설정합니다. 0 = 고전 방식, 1 = 표준 방식, 2 = 엄격한 방식. 경로 매칭 방식에 영향을 미칩니다.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      '라우팅 루프 감지 감도 설정: 끄기, 최소, 중간, 또는 엄격';

  @override
  String get repeater_cliHelpSetFreq =>
      '(단일 기능) 특정 주파수만 빠르게 설정합니다. 재부팅이 필요합니다. 전체 라디오 파라미터 설정에는 \"라디오 설정\" 기능을 사용하는 것이 좋습니다.';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(ESPNow 브리지만 해당) 브리지에서 사용되는 WiFi 채널(1~14)을 설정합니다.';

  @override
  String get repeater_cliHelpGetName => '구성된 노드의 이름을 표시합니다.';

  @override
  String get repeater_cliHelpGetRole => '펌웨어 역할(리피터, 룸 서버 등)을 보여줍니다.';

  @override
  String get repeater_cliHelpGetPublicKey => '장치의 공개 키를 표시합니다.';

  @override
  String get repeater_cliHelpGetPrvKey => '(전용) 장치의 개인 키를 표시합니다. 비밀 정보로 취급합니다.';

  @override
  String get repeater_cliHelpGetRepeat => '패킷 전달(리피터 기능)이 활성화되어 있는지 여부를 표시합니다.';

  @override
  String get repeater_cliHelpGetTx => '현재 TX 전력(dBm)을 표시합니다.';

  @override
  String get repeater_cliHelpGetFreq => '구성된 무선 주파수를 MHz 단위로 표시합니다.';

  @override
  String get repeater_cliHelpGetRadio =>
      '전체 무선 파라미터 표시: 주파수, 대역폭, 스프레딩 계수, 인코딩 속도';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(SX126x 전용) RX의 증폭 이득 상태를 표시합니다.';

  @override
  String get repeater_cliHelpGetAf => '현재 공기 시간 요소를 보여줍니다.';

  @override
  String get repeater_cliHelpGetDutyCycle => '현재 허용되는 작업 주기를 백분율로 표시합니다.';

  @override
  String get repeater_cliHelpGetIntThresh => '채널 간섭 임계값을 dB 단위로 표시합니다.';

  @override
  String get repeater_cliHelpGetAgcResetInterval => 'AGC 재설정 간격을 초 단위로 표시합니다.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      '더블 ACK 모드가 활성화되어 있는지 (1) 또는 비활성화되어 있는지 (0)를 표시합니다.';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      '게스트의 읽기 전용 액세스가 허용되는지 여부를 표시합니다.';

  @override
  String get repeater_cliHelpGetAdvertInterval => '지역 광고 시간 간격을 분 단위로 표시합니다.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      '홍수 광고 시간 간격을 시간 단위로 표시합니다.';

  @override
  String get repeater_cliHelpGetGuestPassword => '구성된 게스트 비밀번호를 표시합니다.';

  @override
  String get repeater_cliHelpGetLat => '설정된 위도를 보여줍니다.';

  @override
  String get repeater_cliHelpGetLon => '설정된 경도를 보여줍니다.';

  @override
  String get repeater_cliHelpGetRxDelay => 'Rxdelay 기본 값을 표시합니다.';

  @override
  String get repeater_cliHelpGetTxDelay => '홍수 모드에서의 전송 지연 계수를 보여줍니다.';

  @override
  String get repeater_cliHelpGetDirectTxDelay => '직렬 모드에서의 딜레이 계수를 보여줍니다.';

  @override
  String get repeater_cliHelpGetFloodMax => '최대 홍수 발생 횟수를 보여줍니다.';

  @override
  String get repeater_cliHelpGetOwnerInfo => '소유주 연락처 정보를 표시합니다.';

  @override
  String get repeater_cliHelpGetPathHashMode => '경로 해시 모드 (0/1/2)를 표시합니다.';

  @override
  String get repeater_cliHelpGetLoopDetect => '루프 탐지 감도를 보여줍니다.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(단순히 목록만 표시) 리피터에 설정된 접근 제어 항목 목록을 보여줍니다.';

  @override
  String get repeater_cliHelpGetBridgeEnabled => '다리 기능이 활성화되어 있는지 여부를 표시합니다.';

  @override
  String get repeater_cliHelpGetBridgeDelay => '다리 통과 시간(밀리초)을 표시합니다.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      '브리지 로그가 RX 또는 TX 패킷을 기록하는지 여부를 보여줍니다.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(RS232 브리지 기능만) 브리지의 보드 속도를 표시합니다.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(ESPNow 브리지만 해당) 브리지의 Wi-Fi 채널을 표시합니다.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(ESPNow 브리지만 해당) 브리지에서 공유된 비밀을 표시합니다.';

  @override
  String get repeater_cliHelpGetBootloaderVer => '(NRF52만 해당) 부팅 로더 버전을 표시합니다.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      '배터리 전압을 스케일링하는 ADC 멀티플라이어를 보여줍니다.';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      '이 보드가 전력 관리 기능을 지원하는지 여부를 나타냅니다.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      '현재 전원 공급 장치 (외부 전원 또는 배터리)를 표시합니다.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason => '가장 최근 재설정 및 종료 이유를 보여줍니다.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv => '부팅 시 배터리 전압을 mV 단위로 표시합니다.';

  @override
  String get repeater_cliHelpSensorGet => '키를 사용하여 사용자 정의 센서 설정을 읽습니다.';

  @override
  String get repeater_cliHelpSensorSet => '사용자 정의 센서 설정을 작성합니다.';

  @override
  String get repeater_cliHelpSensorList =>
      '사용자 정의 센서 설정 목록을, 선택적으로 지정된 시작 인덱스부터 페이지 나누어 표시합니다.';

  @override
  String get repeater_cliHelpRegionDefault => '현재 기본 지역 범위를 보여줍니다.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      '기본 지역 범위를 설정합니다. \"<null>\"을 사용하여 초기화합니다.';

  @override
  String get repeater_cliHelpRegionListAllowed => '홍수 피해 차량 통행이 가능한 지역 목록';

  @override
  String get repeater_cliHelpRegionListDenied => '홍수 발생 시 통행 금지 지역 목록';

  @override
  String get repeater_cliHelpStatsPackets => '(전송 속도만 표시) 패킷 수준의 통계 정보를 보여줍니다.';

  @override
  String get repeater_cliHelpStatsRadio => '(특정 시리즈만 해당) 라디오 통계 정보를 표시합니다.';

  @override
  String get repeater_cliHelpStatsCore => '(시리얼 번호만 표시) 핵심 펌웨어 통계 정보를 보여줍니다.';

  @override
  String get telemetry_receivedData => '수신된 통신 데이터';

  @override
  String get telemetry_requestTimeout => '원격 모니터링 요청이 시간 초과되었습니다.';

  @override
  String telemetry_errorLoading(String error) {
    return '$error 오류로 인해 통신 데이터를 로드하지 못했습니다.';
  }

  @override
  String get telemetry_noData => '텔레메트리 데이터는 제공되지 않습니다.';

  @override
  String telemetry_channelTitle(int channel) {
    return '채널 $channel';
  }

  @override
  String get telemetry_batteryLabel => '배터리';

  @override
  String get telemetry_voltageLabel => '전압';

  @override
  String get telemetry_mcuTemperatureLabel => 'MCU의 온도';

  @override
  String get telemetry_temperatureLabel => '온도';

  @override
  String get telemetry_currentLabel => '현재';

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
  String get telemetry_digitalInputLabel => '디지털 입력';

  @override
  String get telemetry_digitalOutputLabel => '디지털 출력';

  @override
  String get telemetry_analogInputLabel => '아날로그 입력';

  @override
  String get telemetry_analogOutputLabel => '아날로그 출력';

  @override
  String get telemetry_genericLabel => '일반 센서';

  @override
  String get telemetry_luminosityLabel => '조도';

  @override
  String get telemetry_presenceLabel => '존재 감지';

  @override
  String get telemetry_humidityLabel => '습도';

  @override
  String get telemetry_accelerometerLabel => '가속도계';

  @override
  String get telemetry_pressureLabel => '압력';

  @override
  String get telemetry_altitudeLabel => '고도';

  @override
  String get telemetry_frequencyLabel => '주파수';

  @override
  String get telemetry_percentageLabel => '백분율';

  @override
  String get telemetry_concentrationLabel => '농도';

  @override
  String get telemetry_powerLabel => '전력';

  @override
  String get telemetry_distanceLabel => '거리';

  @override
  String get telemetry_energyLabel => '에너지';

  @override
  String get telemetry_directionLabel => '방향';

  @override
  String get telemetry_timeLabel => '시간';

  @override
  String get telemetry_gyrometerLabel => '자이로미터';

  @override
  String get telemetry_colourLabel => '색상';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => '스위치';

  @override
  String get telemetry_polylineLabel => '폴리라인';

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
  String get telemetry_autoFetchQuantity => '요청 수';

  @override
  String get telemetry_error => '데이터를 가져올 수 없습니다';

  @override
  String get neighbors_receivedData => '이웃 정보 수집';

  @override
  String get neighbors_requestTimedOut => '이웃들이 시간 제한을 요청하고 있습니다.';

  @override
  String neighbors_errorLoading(String error) {
    return '이웃 정보 로딩 중 오류: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => '반복기, 이웃';

  @override
  String get neighbors_noData => '이웃 정보는 없습니다.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return '알 수 없는 $pubkey';
  }

  @override
  String neighbors_heardAgo(String time) {
    return '수신: $time 전';
  }

  @override
  String get channelPath_title => '패킷 경로';

  @override
  String get channelPath_viewMap => '지도 보기';

  @override
  String get channelPath_otherObservedPaths => '관찰된 다른 경로';

  @override
  String get channelPath_repeaterHops => '반복 홉';

  @override
  String get channelPath_noHopDetails => '이 패키지에 대한 자세한 정보는 제공되지 않습니다.';

  @override
  String get channelPath_sourceLabel => '출처';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      '이 메시지는 MQTT로 도착했습니다. 내 무전기가 수신하지 않았으므로 내 무전기로부터의 무선 경로가 없습니다.';

  @override
  String get channelPath_messageDetails => '메시지 세부 정보';

  @override
  String get channelPath_senderLabel => '발신자';

  @override
  String get channelPath_timeLabel => '시간';

  @override
  String get channelPath_repeatsLabel => '반복';

  @override
  String channelPath_pathLabel(int index) {
    return '경로 $index';
  }

  @override
  String get channelPath_observedLabel => '관찰';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return '관찰된 경로 $index • $hops';
  }

  @override
  String get channelPath_noLocationData => '위치 정보 없음';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => '알 수 없음';

  @override
  String get channelPath_floodPath => '홍수';

  @override
  String get channelPath_directPath => '직접';

  @override
  String channelPath_observedZeroOf(int total) {
    return '$total 중 0개';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed/$total 홉 관찰됨';
  }

  @override
  String get channelPath_mapTitle => '경로 지도';

  @override
  String get channelPath_noRepeaterLocations => '이 경로에 대한 중계기 설치 위치는 없습니다.';

  @override
  String channelPath_primaryPath(int index) {
    return '경로 $index (주 경로)';
  }

  @override
  String get channelPath_pathLabelTitle => '경로';

  @override
  String get channelPath_observedPathHeader => '관찰된 경로';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable => '이 패킷에 대한 이동 정보는 제공되지 않습니다.';

  @override
  String get channelPath_unknownRepeater => '알 수 없는 중계기';

  @override
  String get community_title => '지역 사회';

  @override
  String get community_create => '커뮤니티 만들기';

  @override
  String get community_createDesc => '새로운 커뮤니티를 만들고 QR 코드를 통해 공유하세요.';

  @override
  String get community_join => '참여하기';

  @override
  String get community_joinTitle => '커뮤니티에 참여하기';

  @override
  String community_joinConfirmation(String name) {
    return '$name님, 커뮤니티에 참여하고 싶으신가요?';
  }

  @override
  String get community_scanQr => '커뮤니티 QR 스캔';

  @override
  String get community_scanInstructions => '카메라를 커뮤니티 QR 코드 방향으로 향하게 하세요.';

  @override
  String get community_showQr => 'QR 코드 표시';

  @override
  String get community_publicChannel => '지역 사회 대상';

  @override
  String get community_hashtagChannel => '커뮤니티 해시태그';

  @override
  String get community_name => '지역 이름';

  @override
  String get community_enterName => '커뮤니티 이름을 입력하세요';

  @override
  String community_created(String name) {
    return '커뮤니티 \"$name\"이 생성되었습니다.';
  }

  @override
  String community_joined(String name) {
    return '\"$name\" 커뮤니티에 가입';
  }

  @override
  String get community_qrTitle => '커뮤니티 공유';

  @override
  String community_qrInstructions(String name) {
    return '이 QR 코드를 스캔하여 \"$name\"에 가입하세요.';
  }

  @override
  String get community_hashtagPrivacyHint =>
      '커뮤니티 해시태그 채널은 커뮤니티 구성원만 가입할 수 있습니다.';

  @override
  String get community_invalidQrCode => '유효하지 않은 커뮤니티 QR 코드';

  @override
  String get community_alreadyMember => '이미 회원인 경우';

  @override
  String community_alreadyMemberMessage(String name) {
    return '이미 $name의 회원입니다.';
  }

  @override
  String get community_addPublicChannel => '커뮤니티 공개 채널 추가';

  @override
  String get community_addPublicChannelHint => '이 커뮤니티에 공개 채널을 자동으로 추가합니다.';

  @override
  String get community_noCommunities => '아직 어느 커뮤니티도 가입하지 않았습니다.';

  @override
  String get community_scanOrCreate => 'QR 코드를 스캔하거나 커뮤니티를 만들어 시작하세요.';

  @override
  String get community_manageCommunities => '커뮤니티 관리';

  @override
  String get community_delete => '커뮤니티 떠나기';

  @override
  String community_deleteConfirm(String name) {
    return '$name을 묻어두나요?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return '또한, 이 기능은 $count개의 채널과 그에 해당하는 메시지를 삭제합니다.';
  }

  @override
  String community_deleted(String name) {
    return '지역 커뮤니티 \"$name\"';
  }

  @override
  String get community_regenerateSecret => '비밀 복원';

  @override
  String community_regenerateSecretConfirm(String name) {
    return '$name의 비밀 키를 재생성하시겠습니까? 모든 회원은 계속 통신을 위해 새로운 QR 코드를 스캔해야 합니다.';
  }

  @override
  String get community_regenerate => '재생';

  @override
  String community_secretRegenerated(String name) {
    return '$name을 위한 비밀 정보가 복원되었습니다.';
  }

  @override
  String get community_updateSecret => '비밀 업데이트';

  @override
  String community_secretUpdated(String name) {
    return '$name을 위한 비밀 정보 업데이트';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return '새로운 QR 코드를 스캔하여 $name의 비밀번호를 업데이트하세요.';
  }

  @override
  String get community_addHashtagChannel => '커뮤니티 해시태그 추가';

  @override
  String get community_addHashtagChannelDesc => '이 커뮤니티를 위한 해시태그 채널을 추가하세요.';

  @override
  String get community_selectCommunity => '커뮤니티 선택';

  @override
  String get community_regularHashtag => '일반 해시태그';

  @override
  String get community_regularHashtagDesc => '공개 해시태그 (누구나 참여 가능)';

  @override
  String get community_communityHashtag => '커뮤니티 해시태그';

  @override
  String get community_communityHashtagDesc => '지역 주민을 위한';

  @override
  String community_forCommunity(String name) {
    return '$name 님께';
  }

  @override
  String get listFilter_tooltip => '필터링 및 정렬';

  @override
  String get listFilter_sortBy => '정렬 기준 선택';

  @override
  String get listFilter_latestMessages => '최신 메시지';

  @override
  String get listFilter_heardRecently => '최근에 들었습니다';

  @override
  String get listFilter_az => 'A부터 Z까지';

  @override
  String get listFilter_filters => '필터';

  @override
  String get listFilter_all => '모든';

  @override
  String get listFilter_favorites => '관심 목록';

  @override
  String get listFilter_addToFavorites => '즐겨찾으로 추가';

  @override
  String get listFilter_removeFromFavorites => '즐겨찾에서 제거';

  @override
  String get listFilter_users => '사용자';

  @override
  String get listFilter_repeaters => '다시 보내는 장치';

  @override
  String get listFilter_roomServers => '방 내 서버';

  @override
  String get listFilter_unreadOnly => '읽지 않은 항목만';

  @override
  String get listFilter_newGroup => '새로운 그룹';

  @override
  String get pathTrace_you => '당신';

  @override
  String get pathTrace_failed => '경로 추적 실패.';

  @override
  String get pathTrace_notAvailable => '경로 추적 기능은 제공되지 않습니다.';

  @override
  String get pathTrace_refreshTooltip => '경로 추적 재시작';

  @override
  String get pathTrace_someHopsNoLocation => '홉 중 하나 또는 여러 개에 위치 정보가 누락되었습니다!';

  @override
  String get pathTrace_clearTooltip => '명확한 경로.';

  @override
  String get losSelectStartEnd => 'LOS(최소 거리 경로)의 시작 및 종료 노드를 선택합니다.';

  @override
  String losRunFailed(String error) {
    return '시야 확인 실패: $error';
  }

  @override
  String get losClearAllPoints => '모든 사항을 명확히 합니다.';

  @override
  String get losRunToViewElevationProfile =>
      'LOS(Line of Sight)를 사용하여 고도 프로필을 확인합니다.';

  @override
  String get losMenuTitle => 'LOS 메뉴';

  @override
  String get losMenuSubtitle => '사용자 지정 지점을 추가하려면, 노드를 탭하거나 맵을 길게 눌러 주세요.';

  @override
  String get losShowDisplayNodes => '노드 표시';

  @override
  String get losCustomPoints => '사용자 지정 포인트';

  @override
  String losCustomPointLabel(int index) {
    return '맞춤형 $index';
  }

  @override
  String get losPointA => 'A 지점';

  @override
  String get losPointB => '점 B';

  @override
  String losAntennaA(String value, String unit) {
    return '안테나 A: $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return '안테나 B: $value $unit';
  }

  @override
  String get losRun => 'LOS (Loss of Signal) 상태로 전환';

  @override
  String get losNoElevationData => '고도 정보 없음';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, LOS 확보, 최소 여유 $clearance $heightUnit';
  }

  @override
  String losProfileBlocked(
    String distance,
    String distanceUnit,
    String obstruction,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, $obstruction $heightUnit에 의해 차단됨';
  }

  @override
  String get losStatusChecking => 'LOS: 확인 중...';

  @override
  String get losStatusNoData => 'LOS: 데이터 없음';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS: $clear/$total 개, $blocked 개, $unknown 개';
  }

  @override
  String get losErrorElevationUnavailable => '샘플 중 하나 이상에 대한 고도 데이터가 없습니다.';

  @override
  String get losErrorInvalidInput => 'LOS 계산에 사용되는 부정확한 지점/고도 데이터.';

  @override
  String get losRenameCustomPoint => '사용자 지정된 지점의 이름을 변경';

  @override
  String get losPointName => '항목 이름';

  @override
  String get losShowPanelTooltip => 'LOS 패널 표시';

  @override
  String get losHidePanelTooltip => 'LOS 패널 숨기기';

  @override
  String get losElevationAttribution => '고도 데이터: Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => '라디오 호라이즌';

  @override
  String get losLegendLosBeam => 'LOS 빔';

  @override
  String get losLegendTerrain => '지형';

  @override
  String get losBlockedSpotsTitle => '차단된 공간';

  @override
  String get losBlockedSpotsHint => '지도에서 특정 위치를 강조하려면 해당 위치를 클릭하세요.';

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
  String get losSelectedObstructionTitle => '선택된 장애물';

  @override
  String losSelectedObstructionDetails(
    String obstruction,
    String heightUnit,
    String distanceFromA,
    String distanceUnit,
    String distanceFromB,
  ) {
    return '$obstruction $heightUnit에 의해 차단됨, A에서 $distanceFromA, B에서 $distanceFromB ($distanceUnit)';
  }

  @override
  String get losFrequencyLabel => '빈도';

  @override
  String get losFrequencyInfoTooltip => '계산 내역 보기';

  @override
  String get losFrequencyDialogTitle => '라디오 수신 가능 범위 계산';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return '$baselineK에서 시작하여 $baselineFreq MHz의 주파수에서 계산을 시작하면, 현재 $frequencyMHz MHz 대역에 대한 k-값을 조정하여, 이는 곡선형 라디오 지평선 상한선을 정의합니다.';
  }

  @override
  String get contacts_pathTrace => '경로 추적';

  @override
  String get contacts_ping => '핑';

  @override
  String get contacts_repeaterPathTrace => '리피터로 가는 경로';

  @override
  String get contacts_repeaterPing => '핑 반복';

  @override
  String get contacts_roomPathTrace => '방 서버로의 경로 추적';

  @override
  String get contacts_roomPing => '피нг 룸 서버';

  @override
  String get contacts_chatTraceRoute => '경로 추적 경로';

  @override
  String contacts_pathTraceTo(String name) {
    return '$name까지의 경로 추적';
  }

  @override
  String get contacts_clipboardEmpty => '클립보드가 비어 있습니다.';

  @override
  String get contacts_pasteNotContact =>
      'MeshCore 연락처가 아닙니다. meshcore:// 연락처 링크나 광고를 복사한 뒤 다시 시도하세요.';

  @override
  String get contacts_invalidAdvertFormat => '유효하지 않은 연락 정보';

  @override
  String get contacts_contactImported => '연락이 수신되었습니다.';

  @override
  String get contacts_contactImportFailed => '연락처를 가져오지 못했습니다.';

  @override
  String get contacts_zeroHopAdvert => '제로 홉 광고';

  @override
  String get contacts_floodAdvert => '홍수 광고';

  @override
  String get contacts_copyAdvertToClipboard => '광고 텍스트를 클립보드에 복사';

  @override
  String get contacts_addContactFromClipboard => '복사본에서 연락처 추가';

  @override
  String get contacts_ShareContact => '연락처를 복사';

  @override
  String get contacts_ShareContactZeroHop => '광고를 통해 연락처 공유';

  @override
  String get contacts_zeroHopContactAdvertSent => '광고를 통해 연락처를 받았습니다.';

  @override
  String get contacts_zeroHopContactAdvertFailed => '연락처 전송에 실패했습니다.';

  @override
  String get contacts_contactAdvertCopied => '광고 내용이 복사되었습니다.';

  @override
  String get contacts_contactAdvertCopyFailed => '광고를 클립보드에 복사하는 데 실패했습니다.';

  @override
  String get notification_activityTitle => '메쉬코어 활동';

  @override
  String notification_messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '메시지들',
      one: '메시지',
    );
    return '$count $_temp0';
  }

  @override
  String notification_channelMessagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '채널 메시지',
      one: '채널 메시지',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '새 노드들',
      one: '새 노드',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return '새로운 $contactType 발견';
  }

  @override
  String get notification_receivedNewMessage => '새로운 메시지를 받았습니다';

  @override
  String get settings_gpxExportRepeaters => 'GPX로 전송/방 관리 서버';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'GPX 파일에 위치 정보를 포함하여 반복자/룸 서버를 내보냅니다.';

  @override
  String get settings_gpxExportContacts => 'GPX 형식으로 내보내기';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'GPX 파일에 위치 정보를 포함하여 동행하는 기능을 내보냅니다.';

  @override
  String get settings_gpxExportAll => '모든 연락처를 GPX 형식으로 내보내기';

  @override
  String get settings_gpxExportAllSubtitle =>
      '위치 정보가 있는 모든 연락처를 GPX 파일로 내보냅니다.';

  @override
  String get settings_gpxExportSuccess => 'GPX 파일이 성공적으로 내보내졌습니다.';

  @override
  String get settings_gpxExportNoContacts => '수출할 연락처가 없습니다.';

  @override
  String get settings_gpxExportNotAvailable => '귀하의 장치/운영체제에서는 지원되지 않습니다.';

  @override
  String get settings_gpxExportError => '데이터 내보내기 과정에서 오류가 발생했습니다.';

  @override
  String get settings_gpxExportRepeatersRoom => '중계 장치 및 서버 위치';

  @override
  String get settings_gpxExportChat => '함께 방문할 장소';

  @override
  String get settings_gpxExportAllContacts => '모든 연락처 위치';

  @override
  String get settings_gpxExportShareText => 'NOTORYX Core Ham에서 추출한 지도 데이터';

  @override
  String get settings_gpxExportShareSubject =>
      'NOTORYX Core Ham GPX 지도 데이터 내보내기';

  @override
  String get snrIndicator_nearByRepeaters => '주변의 중계기';

  @override
  String get snrIndicator_lastSeen => '마지막으로 목격';

  @override
  String get contactsSettings_title => '연락처 설정';

  @override
  String get contactsSettings_autoAddTitle => '자동 검색';

  @override
  String get contactsSettings_otherTitle => '다른 연락 관련 설정';

  @override
  String get contactsSettings_autoAddUsersTitle => '자동으로 사용자 추가';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      '동반자가 자동으로 발견한 사용자를 추가할 수 있도록 합니다.';

  @override
  String get contactsSettings_autoAddRepeatersTitle => '자동으로 중계기 추가';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      '애완동물이 발견한 무선 라디오를 자동으로 추가할 수 있도록 설정합니다.';

  @override
  String get contactsSettings_autoAddRoomServersTitle => '자동으로 방 서버 추가';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      '애완동물이 발견한 방 서버를 자동으로 추가할 수 있도록 설정합니다.';

  @override
  String get contactsSettings_autoAddSensorsTitle => '자동으로 센서 추가';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      '애완동물이 발견한 센서를 자동으로 추가할 수 있도록 설정합니다.';

  @override
  String get contactsSettings_overwriteOldestTitle => '가장 오래된 것을 덮어쓰기';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      '연락처 목록이 가득 차면, 가장 오래된 (선호하지 않은) 연락처가 대체됩니다.';

  @override
  String get discoveredContacts_Title => '연락처 찾기';

  @override
  String get discoveredContacts_noMatching => '일치하는 연락처가 없습니다.';

  @override
  String get discoveredContacts_searchHint => '발견된 연락처 검색';

  @override
  String get discoveredContacts_contactAdded => '연락처 추가';

  @override
  String get discoveredContacts_addContact => '연락처 추가';

  @override
  String get discoveredContacts_copyContact => '복사';

  @override
  String get discoveredContacts_deleteContact => '발견된 연락처 삭제';

  @override
  String get discoveredContacts_deleteContactAll => '발견된 모든 연락처 삭제';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      '정말로 모든 검색된 연락처를 삭제하시겠습니까?';

  @override
  String get chat_sendCooldown => '다시 보내기 전에 잠시 기다려 주시기 바랍니다.';

  @override
  String get appSettings_jumpToOldestUnread => '가장 오래된, 아직 읽지 않은 항목으로 이동';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      '새로운 메시지가 없는 채팅을 열 때, 최신 메시지가 아닌 첫 번째 읽지 않은 메시지로 스크롤하세요.';

  @override
  String get appSettings_languageHu => '헝가리';

  @override
  String get appSettings_languageJa => '일본어';

  @override
  String get appSettings_languageKo => '한국어';

  @override
  String get radioStats_tooltip => '라디오 및 메시 통계';

  @override
  String get radioStats_screenTitle => '라디오 통계';

  @override
  String get radioStats_notConnected => '라디오 통계를 확인하기 위해 장치에 연결합니다.';

  @override
  String get radioStats_firmwareTooOld =>
      '무선 통계 기능을 사용하려면 v8 또는 그 이상의 호환 펌웨어가 필요합니다.';

  @override
  String get radioStats_waiting => '데이터를 기다리는 중…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return '잡음 수준: $noiseDbm dBm';
  }

  @override
  String radioStats_lastRssi(int rssiDbm) {
    return '마지막 RSSI: $rssiDbm dBm';
  }

  @override
  String radioStats_lastSnr(String snr) {
    return '마지막 SNR: $snr dB';
  }

  @override
  String radioStats_txAir(int seconds) {
    return 'TX 방송 시간 (총): $seconds 초';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'RX 사용 시간 (총): $seconds 초';
  }

  @override
  String get radioStats_chartCaption => '최근 샘플의 잡음 수준 (dBm)';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return '잡음 수준: $noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting => '라디오 통계 가져오기…';

  @override
  String get radioStats_settingsTile => '라디오 통계';

  @override
  String get radioStats_settingsSubtitle => '잡음 수준, RSSI, 신호 대 잡음비, 통신 시간';

  @override
  String get translation_title => '번역';

  @override
  String get imageMessages_enableTitle => '이미지 메시지 활성화';

  @override
  String get imageMessages_enableSubtitle =>
      '메시를 통해 이미지를 전송하세요. 일회성 이미지 모델 다운로드가 필요합니다.';

  @override
  String get imageMessages_modelSectionTitle => '이미지 모델';

  @override
  String get imageMessages_downloadModel => '다운로드';

  @override
  String get imageMessages_cancelDownload => '취소';

  @override
  String get imageMessages_removeModel => '모델 제거';

  @override
  String get imageMessages_modelReady => '준비 완료';

  @override
  String get imageMessages_modelNotPublished =>
      '아직 출판되지 않았습니다 — 이 빌드로는 다운로드할 수 없습니다.';

  @override
  String get imageMessages_downloadFailed => '이미지 모델을 다운로드할 수 없었습니다.';

  @override
  String get imageMessages_autoProcessTitle => '자동으로 프로세스 이미지를 처리합니다.';

  @override
  String get imageMessages_autoProcessSubtitle =>
      '이미지가 도착하는 즉시 재구성하세요. 매번 2GB의 메모리를 사용하며, 탭으로 재구성을 원할 경우 해제하세요.';

  @override
  String get translation_enableTitle => '번역 기능 활성화';

  @override
  String get translation_enableSubtitle => '입력 메시지를 번역하고, 미리 번역 기능을 제공합니다.';

  @override
  String get translation_composerTitle => '보내기 전에 번역';

  @override
  String get translation_composerSubtitle => '컴포저 번역 아이콘의 기본 상태를 제어합니다.';

  @override
  String get translation_autoIncomingTitle => '메시지 자동 번역';

  @override
  String get translation_autoIncomingSubtitle =>
      '알림과 채팅 또는 채널의 메시지를 자동으로 번역합니다.';

  @override
  String get translation_translateMessage => '메시지 번역';

  @override
  String get translation_targetLanguage => '목표 언어';

  @override
  String get translation_useAppLanguage => '앱 언어 사용';

  @override
  String get translation_downloadedModelLabel => '다운로드한 모델';

  @override
  String get translation_presetModelLabel => '사전에 설정된 Hugging Face 모델';

  @override
  String get translation_manualUrlLabel => '수동 모델 URL';

  @override
  String get translation_downloadModel => '모델 다운로드';

  @override
  String get translation_downloading => '다운로드 중...';

  @override
  String get translation_working => '업무 중...';

  @override
  String get translation_stop => '멈춰';

  @override
  String get translation_mergingChunks => '다운로드한 파일 조각들을 최종 파일로 병합 중...';

  @override
  String get translation_downloadedModels => '다운로드한 모델';

  @override
  String get translation_deleteModel => '모델 삭제';

  @override
  String get translation_modelDownloaded => '번역 모델이 다운로드되었습니다.';

  @override
  String get translation_downloadStopped => '다운로드 중단됨.';

  @override
  String translation_downloadFailed(String error) {
    return '다운로드 실패: $error';
  }

  @override
  String get translation_enterUrlFirst => '먼저 모델 URL을 입력하세요.';

  @override
  String get scanner_linuxPairingShowPin => 'PIN 보기';

  @override
  String get scanner_linuxPairingHidePin => 'PIN 숨기기';

  @override
  String get scanner_linuxPairingPinTitle => '블루투스 페어링 PIN';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return '$deviceName의 PIN을 입력하세요 (해당하는 경우에만 입력).';
  }

  @override
  String get translation_messageTranslation => '메시지 번역';

  @override
  String get translation_translateBeforeSending => '보내기 전에 번역';

  @override
  String get translation_composerEnabledHint => '메시지는 전송하기 전에 번역될 것입니다.';

  @override
  String get translation_composerDisabledHint => '원래 작성된 언어로 메시지를 보내세요.';

  @override
  String translation_translateTo(String language) {
    return '$language 번역';
  }

  @override
  String get translation_translationOptions => '번역 옵션';

  @override
  String get translation_systemLanguage => '시스템 언어';

  @override
  String get background_serviceTitle => 'MeshCore 실행 중';

  @override
  String get background_serviceText => 'BLE 연결 유지 중';

  @override
  String appSettings_translationModelDeleted(String name) {
    return '$name 삭제됨';
  }

  @override
  String appSettings_translationModelDeleteFailed(String error) {
    return '삭제 실패: $error';
  }

  @override
  String channels_channelUpdateFailed(String error) {
    return '채널 업데이트 실패: $error';
  }

  @override
  String get contact_typeChat => '채팅';

  @override
  String get contact_typeRepeater => '리피터';

  @override
  String get contact_typeRoom => '룸';

  @override
  String get contact_typeSensor => '센서';

  @override
  String get contact_typeUnknown => '알 수 없음';

  @override
  String get map_zoomIn => '확대';

  @override
  String get map_zoomOut => '축소';

  @override
  String get map_centerMap => '지도 중앙 맞추기';

  @override
  String get chrome_bluetoothRequiresChromium =>
      '웹 블루투스는 Chromium 기반 브라우저가 필요합니다.';

  @override
  String channels_communityShortId(String id) {
    return 'ID: $id...';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'GPS로 확인됨';

  @override
  String get pathTrace_legendInferred => '추정된 위치';

  @override
  String get pathMap_viewSingle => '단일';

  @override
  String get pathMap_viewCombined => '결합';

  @override
  String get pathMap_play => '재생';

  @override
  String get pathMap_pause => '일시 정지';

  @override
  String get pathMap_replay => '다시 재생';

  @override
  String get pathMap_stepBack => '이전 홉';

  @override
  String get pathMap_stepForward => '다음 홉';

  @override
  String get pathMap_animationOn => '패킷 애니메이션 표시';

  @override
  String get pathMap_animationOff => '패킷 애니메이션 숨기기';

  @override
  String pathMap_hopOf(int current, int total) {
    return '$current/$total 홉';
  }

  @override
  String pathMap_observedPaths(int count) {
    return '관찰된 경로: $count';
  }

  @override
  String get pathMap_primary => '주 경로';

  @override
  String pathMap_alternate(int index) {
    return '대체 $index';
  }

  @override
  String pathMap_hopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 홉',
      one: '1 홉',
    );
    return '$_temp0';
  }

  @override
  String pathMap_gpsCount(int confirmed, int total) {
    return '$confirmed/$total GPS';
  }

  @override
  String get pathMap_legendShared => '공유 구간';

  @override
  String get pathMap_legendEstimated => '추정 구간';

  @override
  String pathMap_sharedNodeCount(int count) {
    return '$count개의 경로에서 사용됨';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 홉은 위치가 없어 표시된 경로가 일부입니다',
      one: '1 홉은 위치가 없어 표시된 경로가 일부입니다',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => '모두 보기';

  @override
  String get pathMap_hidePath => '경로 숨기기';

  @override
  String get pathMap_showPath => '경로 표시';

  @override
  String get pathMap_collapsePanel => '패널 접기';

  @override
  String get pathMap_expandPanel => '패널 펼치기';

  @override
  String get pathMap_noLocation => '위치 없음';

  @override
  String get pathMap_followPacket => '패킷 고정';

  @override
  String get pathMap_unfollowPacket => '패킷 고정 해제';

  @override
  String get imageSend_title => '이미지를 보내세요';

  @override
  String get imageSend_cropNote => '512 × 512로 크기가 조정되었으며, 종횡비는 유지되지 않았습니다.';

  @override
  String get imageSend_originalSize => '원문 없음';

  @override
  String get imageSend_onAirSize => '방송 중';

  @override
  String get imageSend_quality => '품질';

  @override
  String get imageSend_qualityStandard => '표준';

  @override
  String get imageSend_qualityHigh => '높다';

  @override
  String get imageSend_packetsLabel => '패킷';

  @override
  String get imageSend_airtimeLabel => '방송 시간';

  @override
  String get imageSend_sizeLabel => '페이로드';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '패킷',
      one: '패킷',
    );
    return '$count $_temp0';
  }

  @override
  String imageSend_range(String min, String max) {
    return '$min~$max';
  }

  @override
  String get imageSend_unknownValue => '—';

  @override
  String get imageSend_radioUnknownTitle => '라디오 설정 정보 없음';

  @override
  String get imageSend_radioUnknownBody => '방송 시간을 계산할 수 있도록 기기와 연결하세요.';

  @override
  String get imageSend_longSendTitle => '장거리 송신';

  @override
  String imageSend_longSendBody(String duration) {
    return '이것은 약 $duration 동안 채널을 유지할 것입니다.';
  }

  @override
  String get imageSend_floodNote =>
      '홍수 라우팅: 범위 내의 모든 리피터가 각 패킷을 재전송하므로, 채널이 이보다 더 오래 점유 상태를 유지합니다.';

  @override
  String get imageSend_parityTitle => '회복 패킷';

  @override
  String get imageSend_paritySubtitle =>
      '추가 한 개의 패킷입니다. 그룹 메시지는 확인되지 않으므로, 하나의 패킷이 손실되었을 경우 수신자가 이미지를 다시 구성할 수 있습니다.';

  @override
  String get imageSend_send => '보내다';

  @override
  String get imageSend_cancel => '취소';

  @override
  String get imageSend_encodeFailed => '이 이미지는 인코딩할 수 없습니다.';

  @override
  String get imageSend_codecDownloading => '이미지 모델이 아직 다운로드 중입니다.';

  @override
  String get imageSend_codecUnavailable => '이 기기에서는 이미지 전송이 불가능합니다.';

  @override
  String get imageSend_codecDisabled => '설정에서 이미지 메시지가 꺼져 있습니다.';

  @override
  String get imageSend_deviceUnsupported =>
      '이 라디오는 이미지 패킷을 전송할 수 없습니다. 컴패니언 펌웨어 13 이상을 실행하는 장치를 연결해 주세요.';

  @override
  String get imageSend_directMessagesUnsupported =>
      '이미지는 그룹 데이터로 전송되므로, 직접 메시지가 아닌 채널로만 보낼 수 있습니다.';

  @override
  String get imageSend_tooLarge => '그 이미지는 메시 형식이 허용하는 것보다 더 많은 패킷으로 인코딩되었습니다.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '패킷',
      one: '패킷',
    );
    return '이미지가 $count $_temp0로 전송되었습니다.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return '이미지를 보낼 수 없습니다: $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return '이미지 전송 — $sent개의 $total 패킷';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return '노드 $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return '$total개 패킷 중 $received개';
  }

  @override
  String get receivedImage_queued => '해독을 기다리는 중입니다.';

  @override
  String get receivedImage_tapToDecode => '해독하려면 탭을 누르세요.';

  @override
  String get receivedImage_decoding => '재구성하는… 약 1초 정도';

  @override
  String receivedImage_incomplete(int received, int total) {
    return '이미지 불완전 — $total개 중 $received개 패킷 수신됨';
  }

  @override
  String get receivedImage_corrupt => '이미지는 재구성될 수 없습니다.';

  @override
  String get receivedImage_decoderMissing => '수신된 이미지 — 이미지 해독이 되지 않았습니다';

  @override
  String get receivedImage_evicted => '이미지는 더 이상 저장되지 않았습니다.';

  @override
  String get receivedImage_retry => '다시 시도해 보세요';

  @override
  String get receivedImage_decodeAgain => '다시 해독하다';

  @override
  String get receivedImage_openSettings => '설정하다';

  @override
  String get receivedImage_tapToProcess => '처리하려면 탭을 누르세요.';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: '패킷',
      one: '패킷',
    );
    return '$bytes 바이트 · $packets $_temp0';
  }

  @override
  String imageSend_secondsValue(String seconds) {
    return '$seconds 초';
  }

  @override
  String imageSend_minutesSecondsValue(String minutes, String seconds) {
    return '$minutes분 $seconds초';
  }

  @override
  String get bastion_tagline => '인프라 없이도 통신을.';

  @override
  String get bastion_nodes => '노드';

  @override
  String get bastion_repeaters => '리피터';

  @override
  String get bastion_active1h => '1시간 내 활동';

  @override
  String get bastion_mapCoverage => '지도 + 커버리지';

  @override
  String get bastion_routeIntelligence => '경로 분석';

  @override
  String get bastion_repeaterTools => '리피터 도구';

  @override
  String get bastion_fieldStats => '현장 통계';

  @override
  String get bastion_fieldOps => '여정 + 현장 운영';

  @override
  String get bastion_coverageCapture => '커버리지 기록';

  @override
  String get bastion_mapAttribution =>
      '지도 데이터 © OpenStreetMap 기여자, 타일은 선택한 제공업체';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '관측 $count건',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '고유 노드 $count개',
    );
    return '$_temp0';
  }

  @override
  String bastion_hopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count홉',
    );
    return '$_temp0';
  }

  @override
  String bastion_minutesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count분',
    );
    return '$_temp0';
  }

  @override
  String get sos_holdHint => '2초간 길게 누르세요. 누군가 응답할 때까지 5분마다 여정 연락처에 위치를 보냅니다.';

  @override
  String sos_holdHintChannel(String channel) {
    return '2초간 길게 누르세요. 누군가 응답할 때까지 5분마다 여정 연락처와 $channel에 위치를 보냅니다.';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS를 보내지 못했습니다: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return '$name 님이 확인했습니다. 반복 전송을 중지했습니다.';
  }

  @override
  String get sos_waitingForRadio => '무전기가 전송하기를 기다리는 중…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return '$max회 중 $sends회 전송했습니다. 반복 전송이 끝났지만 아직 응답이 없습니다.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return '$max회 중 $sends회 전송했습니다. 다음 전송: $time.';
  }

  @override
  String get sos_active => 'SOS 발신 중';

  @override
  String get sos_stop => '중지';

  @override
  String get sos_imSafe => '안전합니다';

  @override
  String get sos_holdSemantics => 'SOS. 길게 눌러 보내기.';

  @override
  String get sos_keepHolding => '계속 누르세요…';

  @override
  String get sos_holdForSos => '길게 눌러 SOS';

  @override
  String get sos_blockStorage => '먼저 현장 로그 저장 오류를 해결하세요.';

  @override
  String get sos_blockNotConnected => 'SOS를 보내려면 MeshCore 무전기를 연결하세요.';

  @override
  String get sos_blockNoTarget => '여정 계획에서 여정 연락처나 SOS 채널을 선택하세요.';

  @override
  String get checkIn_labelOk => '괜찮아요';

  @override
  String get checkIn_labelAtCamp => '캠프에 있어요';

  @override
  String get checkIn_labelDelayed => '늦어지고 있어요';

  @override
  String get checkIn_labelHeadingBack => '돌아가는 중이에요';

  @override
  String get checkIn_blockLoading => '여정을 불러오는 중…';

  @override
  String get checkIn_blockStorage => '보내기 전에 현장 로그 저장 오류를 해결하세요.';

  @override
  String get checkIn_blockBusy => '체크인을 보내는 중입니다. 잠시 기다려 주세요.';

  @override
  String get checkIn_blockNoContacts => '여정 계획에서 여정 연락처를 선택하세요.';

  @override
  String get checkIn_blockRosterIncomplete =>
      '일부 여정 연락처를 사용할 수 없습니다. 명단을 확인하세요.';

  @override
  String get checkIn_blockNotConnected => '체크인하려면 MeshCore 무전기를 연결하세요.';

  @override
  String get checkIn_blockNotActive => '체크인을 사용하려면 여정을 시작하세요.';

  @override
  String get checkIn_notSent => '보내지 않음';

  @override
  String checkIn_deliveredToOne(String name) {
    return '$name 님에게 전달됨';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return '연락처 $count명 모두에게 전달됨';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return '$total명 중 $delivered명에게 전달됨';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return '전달 안 됨: $names';
  }

  @override
  String get checkIn_waitingForRest => '나머지를 기다리는 중';

  @override
  String get checkIn_aContact => '연락처';

  @override
  String get checkIn_statusPending => '대기 중';

  @override
  String get checkIn_statusSent => '보냄';

  @override
  String get checkIn_statusDelivered => '전달됨';

  @override
  String get checkIn_statusFailed => '실패';

  @override
  String get checkIn_explainPending =>
      '기기에서 대기열에 있습니다. 무선 전송이나 수신을 확인한 것이 아닙니다.';

  @override
  String get checkIn_explainSent => '무전기가 전송을 받아들였습니다. 전달 확인은 아직 기록되지 않았습니다.';

  @override
  String get checkIn_explainDelivered => '앱이 전달 확인을 기록했습니다. 상대가 읽었다는 증거는 아닙니다.';

  @override
  String get checkIn_explainFailed =>
      '전달이 확인되지 않았습니다. 무선 연결, 수신자 도달 가능성, 재시도 기록을 확인하세요.';

  @override
  String get checkIn_explainUnknown =>
      '전달 상태를 알 수 없습니다. 이 메시지가 도착했다고 가정하지 마세요.';

  @override
  String get tripBrief_heading => 'NOTORYX • MeshCore 여정 요약';

  @override
  String tripBrief_trip(String name) {
    return '여정: $name';
  }

  @override
  String tripBrief_status(String status) {
    return '상태: $status';
  }

  @override
  String get tripBrief_active => '진행 중';

  @override
  String get tripBrief_stopped => '중지됨';

  @override
  String tripBrief_contacts(String names) {
    return '연락처: $names';
  }

  @override
  String get tripBrief_noneSelected => '선택 안 함';

  @override
  String get tripBrief_unavailableContact => '사용할 수 없는 연락처(명단 확인)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return '활동 지연 기준: $minutes분(연락처가 조용해지면 이 휴대폰이 알립니다)';
  }

  @override
  String tripBrief_reminder(String value) {
    return '체크인 알림: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return '체크인 없이 $minutes분마다';
  }

  @override
  String tripBrief_choices(String choices) {
    return '체크인 선택지: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return '체크인에 포함할 무전기 위치: $value';
  }

  @override
  String get tripBrief_includedMayBeStale => '포함, 오래된 정보일 수 있음';

  @override
  String tripBrief_battery(String value) {
    return '체크인에 포함할 무전기 배터리: $value';
  }

  @override
  String get tripBrief_included => '포함';

  @override
  String get tripBrief_off => '끔';

  @override
  String get tripBrief_review => '체크인을 보내기 전에 수신자와 메시지를 확인하세요.';

  @override
  String get tripBrief_noProof =>
      '대기열 등록이나 전송은 전달의 증거가 아닙니다. 확인 응답은 읽었다는 증거가 아닙니다.';

  @override
  String get tripBrief_overdueMeaning =>
      '지연은 최근 연락처 활동이 없다는 뜻이며, 확인된 긴급 상황이 아닙니다.';

  @override
  String get tripBrief_automations =>
      '현장 자동화는 앱이 활성 상태일 때만 실행됩니다. 연락이 끊겼을 때를 대비한 별도 계획을 정해 두세요.';

  @override
  String get tripBrief_sharesOnly =>
      '이 요약은 정보만 공유하며, 무선 메시지를 보내거나 여정을 시작하지 않습니다.';

  @override
  String get fieldOps_title => 'NOTORYX Core Ham 현장 운영';

  @override
  String get fieldOps_tabTrip => '여정';

  @override
  String get fieldOps_tabReady => '준비';

  @override
  String get fieldOps_tabLog => '로그';

  @override
  String get fieldOps_tabAuto => '자동';

  @override
  String get fieldOps_tabCoverage => '커버리지';

  @override
  String get fieldOps_tabConnection => '연결';

  @override
  String get fieldOps_diagnostics => '진단';

  @override
  String get fieldOps_storageLoadError =>
      '현장 데이터를 불러올 수 없습니다. 저장된 데이터는 유지되었고 자동화는 꺼진 상태로 유지됩니다.';

  @override
  String get fieldOps_storageSaveError =>
      '현장 데이터를 저장할 수 없습니다. 자동화가 중지되었고 기존 저장 데이터는 유지됩니다.';

  @override
  String get fieldOps_regionHint => '오프라인 지도에서 지역과 확대 수준을 선택하세요.';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • 확대 $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return '지도 지역을 확인할 수 없습니다: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '여정 진행 중 • 연락처 $count명',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped => '여정이 중지되었습니다. 준비되면 시작하세요.';

  @override
  String fieldOps_reminderAt(String time) {
    return '$time에 체크인 알림';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return '너무 오래 조용함: $names';
  }

  @override
  String get fieldOps_planTrip => '여정 계획';

  @override
  String get fieldOps_endTrip => '여정 종료';

  @override
  String get fieldOps_startTrip => '여정 시작';

  @override
  String get fieldOps_tripBrief => '여정 요약';

  @override
  String get fieldOps_connectRadio => '무전기 연결';

  @override
  String get fieldOps_previewedCheckIns => '미리 보기 체크인';

  @override
  String get fieldOps_previewedCheckInsHint =>
      '상태를 고르고 실제 수신자와 메시지를 확인한 뒤 보내세요. 대기열 등록은 전달을 의미하지 않습니다.';

  @override
  String get fieldOps_tripRoster => '여정 명단';

  @override
  String get fieldOps_rosterEmpty => '여정 계획에서 알려진 채팅 연락처를 최대 6명까지 선택하세요.';

  @override
  String get fieldOps_rosterCaveat =>
      '마지막 수신은 과거 활동의 증거입니다. 현재 도달 가능성을 뜻하지 않습니다. 지연 배지는 최근 연락처 활동이 없다는 뜻이며 확인된 긴급 상황이 아닙니다.';

  @override
  String get fieldOps_offlineMaps => '오프라인 지도';

  @override
  String get fieldOps_checkingTiles => '저장된 타일 확인 중…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '캐시된 타일 $count개.',
    );
    return '$_temp0 전체 경로가 포함된다는 보장은 없습니다.';
  }

  @override
  String get fieldOps_downloadAreas => '오프라인 지역 다운로드/확인';

  @override
  String fieldOps_lastCheckIn(String time) {
    return '마지막 체크인, $time';
  }

  @override
  String fieldOps_deliveryChip(String name, String status) {
    return '$name: $status';
  }

  @override
  String get fieldOps_contactFallback => '연락처';

  @override
  String fieldOps_resendFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '전달되지 않은 $count명에게 다시 보내기',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable => '선택한 연락처를 사용할 수 없음';

  @override
  String get fieldOps_memberUnavailableHint => '보내기 전에 이 여정을 확인하세요.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return '마지막 활동 $minutes분 전';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return '마지막 활동 $minutes분 전 • 지연';
  }

  @override
  String get fieldOps_noCheckInRecorded => '이 로그에 기록된 체크인이 없습니다.';

  @override
  String get fieldOps_tripMap => '여정 지도';

  @override
  String get fieldOps_tripMapEmpty => '선택한 연락처가 아직 좌표를 알리지 않았습니다.';

  @override
  String get fieldOps_lastPositions => '마지막으로 알린 위치';

  @override
  String get fieldOps_positionsCaveat =>
      '위치는 오래된 정보일 수 있습니다. 이 지도는 휴대폰 GPS를 추적하지 않으며 구성원이 지금 이곳에 있음을 증명하지 않습니다.';

  @override
  String get fieldOps_briefPreviewTitle => '여정 요약 미리 보기';

  @override
  String get fieldOps_briefPreviewHint =>
      '여정 이름과 연락처 이름이 포함됩니다. 공유하기 전에 확인하세요. 좌표, 키, 메시지 기록은 제외됩니다.';

  @override
  String get fieldOps_shareBrief => '요약 공유';

  @override
  String get fieldOps_briefSubject => 'NOTORYX Core Ham 여정 요약';

  @override
  String get fieldOps_tripName => '여정 이름';

  @override
  String get fieldOps_defaultTripName => '내 여정';

  @override
  String get fieldOps_includePosition => '무전기가 알린 위치 포함';

  @override
  String get fieldOps_includePositionHint =>
      '오래된 정보일 수 있으며, 공유는 기본적으로 꺼져 있습니다.';

  @override
  String get fieldOps_includeBattery => '무전기 배터리 포함';

  @override
  String get fieldOps_overdueLabel => '연락처가 이 시간 동안 조용하면 알림';

  @override
  String get fieldOps_reminderLabel => '체크인 알림 받기';

  @override
  String get fieldOps_reminderHelper =>
      'NOTORYX Core Ham가 닫혀 있어도 휴대폰 알림을 보냅니다.';

  @override
  String get fieldOps_reminderOff => '끔';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '체크인 없이 $count분 후',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'SOS를 함께 보낼 채널';

  @override
  String get fieldOps_sosChannelNone => '없음';

  @override
  String get fieldOps_selectContacts => '알려진 채팅 연락처를 최대 6명까지 선택';

  @override
  String get fieldOps_sendCheckInTitle => '체크인을 보낼까요?';

  @override
  String fieldOps_recipients(String names) {
    return '받는 사람: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      '일반 다이렉트 메시지로 보냅니다. 전달 상태는 현장 로그에서 추적됩니다.';

  @override
  String get fieldOps_send => '보내기';

  @override
  String get sosRelay_title => 'SOS 중계';

  @override
  String get sosRelay_enable => '리피터가 전달하지 않은 SOS 중계';

  @override
  String get sosRelay_needsFirmware => '무전기 펌웨어 v1.16 이상이 필요합니다';

  @override
  String get sosRelay_noneYet => '아직 중계한 SOS가 없습니다';

  @override
  String sosRelay_relayedCount(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'SOS 패킷 $count개 중계, 마지막 $time',
    );
    return '$_temp0';
  }

  @override
  String get sosRelay_explainer =>
      '무전기가 보낸 사람에게서 직접 SOS를 듣고 약 15초 안에 어떤 리피터도 전달하지 않으면, NOTORYX가 그대로 한 번 더 보내 보낸 사람은 닿지 않지만 내가 들을 수 있는 리피터에 닿게 합니다. 내가 가진 채널의 SOS만 중계합니다. 배터리와 송신 시간을 쓰므로 기본적으로 꺼져 있습니다.';

  @override
  String get fieldOps_beforeYouLeave => '출발 전에';

  @override
  String get fieldOps_radioConnected => '무전기 연결됨';

  @override
  String get fieldOps_connectHint => 'Bluetooth, USB 또는 TCP로 연결하세요.';

  @override
  String get fieldOps_radioBattery => '무전기 배터리';

  @override
  String get fieldOps_batteryUnknown => '알 수 없음. 무전기를 확인하세요.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent% • 계획한 여정에 맞게 충전하세요.';
  }

  @override
  String get fieldOps_tripContacts => '여정 연락처';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return '$available/$selected명 사용 가능. 호환되는 무전기와 채널이 있는지 확인하세요.';
  }

  @override
  String get fieldOps_offlineArea => '선택한 오프라인 지도 지역';

  @override
  String get fieldOps_checkingFiles => '로컬 파일 확인 중…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return '타일 파일 $available/$expected개 사용 가능, $missing개 누락. 스냅샷일 뿐이니 출발 전에 오프라인으로 지역을 열어 보세요.';
  }

  @override
  String get fieldOps_locationChoice => '위치 공유';

  @override
  String get fieldOps_locationOptedIn => '켜짐: 무전기가 알린 좌표는 오래된 정보일 수 있습니다.';

  @override
  String get fieldOps_locationOff => '공유가 꺼져 있습니다. 체크인에 좌표가 포함되지 않습니다.';

  @override
  String get fieldOps_automationAvailability => '자동화 사용 가능 여부';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      '이 앱이 활성 상태일 때만 실행됩니다. 절전, 종료, 무전기 연결 끊김으로 예약된 작업이 실행되지 않을 수 있습니다.';

  @override
  String get fieldOps_readinessCaveat =>
      '준비 점검은 참고용입니다. 무선 범위를 증명하거나 메시지 전달을 보장하지 않습니다.';

  @override
  String get fieldOps_radio => '무전기';

  @override
  String get fieldOps_refreshChecks => '점검 새로고침';

  @override
  String get fieldOps_searchLog => '현장 로그 검색';

  @override
  String get fieldOps_kindAll => '전체';

  @override
  String get fieldOps_kindCheckIn => '체크인';

  @override
  String get fieldOps_kindReceived => '수신';

  @override
  String get fieldOps_kindNote => '메모';

  @override
  String get fieldOps_kindDeadZone => '음영 지역';

  @override
  String get fieldOps_kindRadio => '무전';

  @override
  String get fieldOps_kindAutomation => '자동화';

  @override
  String get fieldOps_kindMissed => '누락';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => '여정';

  @override
  String get fieldOps_kindOverdue => '지연';

  @override
  String get fieldOps_addNote => '메모 추가';

  @override
  String get fieldOps_exportJson => 'JSON 내보내기';

  @override
  String get fieldOps_deleteLog => '로그 삭제';

  @override
  String get fieldOps_logSubject => 'NOTORYX Core Ham 현장 로그';

  @override
  String get fieldOps_logCaveat =>
      '기기에 최대 1,000개 항목이 저장됩니다. 내보낸 파일에는 연락처 키, 메시지, 위치가 포함될 수 있으니 공유 전에 확인하세요.';

  @override
  String get fieldOps_noEntries => '일치하는 항목이 없습니다.';

  @override
  String get fieldOps_tripUnspecified => '여정 미지정';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return '기록된 무전기 알림 위치 $latitude, $longitude(오래된 정보일 수 있음)';
  }

  @override
  String get fieldOps_noteTitle => '현장 관찰';

  @override
  String get fieldOps_noteLabel => '무엇을 관찰했나요?';

  @override
  String get fieldOps_deadZone => '음영 지역 보고';

  @override
  String get fieldOps_deadZoneHint => '사용자의 관찰이며, 검증된 커버리지 예측이 아닙니다.';

  @override
  String get fieldOps_savePosition => '무전기가 알린 위치 저장';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • 오래된 정보일 수 있음, 휴대폰 GPS 아님';
  }

  @override
  String get fieldOps_noPosition => '사용할 수 있는 알림 좌표가 없습니다';

  @override
  String get fieldOps_deleteLogTitle => '현장 로그를 삭제할까요?';

  @override
  String get fieldOps_deleteLogBody => '이 휴대폰에 저장된 모든 항목이 삭제됩니다. 여정 설정은 유지됩니다.';

  @override
  String get fieldOps_localAutomations => '로컬 자동화';

  @override
  String get fieldOps_enableForTrip => '이 여정에서 사용';

  @override
  String get fieldOps_automationsCaveat =>
      '앱을 다시 시작할 때마다 꺼집니다. 규칙은 앱이 활성 상태일 때만 실행됩니다. 누락된 예약 작업은 현장 로그에 표시되며 한꺼번에 다시 실행되지 않습니다. 자동 체크인은 10분에 한 번으로 제한됩니다.';

  @override
  String get fieldOps_openBotMode => 'NOTORYX 봇 모드 열기';

  @override
  String get fieldOps_ruleEnabled => '규칙 사용';

  @override
  String get fieldOps_dryRun => '테스트 실행';

  @override
  String get fieldOps_dryRunHint => '전송이나 알림 없이 작업을 기록합니다.';

  @override
  String get fieldOps_then => '실행';

  @override
  String get fieldOps_actionLog => '현장 로그에 기록';

  @override
  String get fieldOps_actionNotify => '로컬 알림 표시';

  @override
  String get fieldOps_actionCheckIn => '여정 연락처에 \'I\'m OK\' 보내기';

  @override
  String get fieldOps_batteryThreshold => '배터리가 이 값 이하일 때';

  @override
  String fieldOps_nextDue(String time) {
    return '다음 예정: $time';
  }

  @override
  String get fieldOps_nextDueNone => '다음 예정: 예약 없음';

  @override
  String get fieldOps_previewInLog => '로그에서 미리 보기';

  @override
  String get fieldOps_allowNotifications => '알림 허용';

  @override
  String get fieldOps_triggerReconnect => '무전기가 다시 연결될 때';

  @override
  String get fieldOps_triggerDisconnect => '무전기 연결이 끊길 때';

  @override
  String get fieldOps_triggerLowBattery => '무전기 배터리가 기준을 넘을 때';

  @override
  String get fieldOps_triggerNewNode => '새 노드가 추가될 때';

  @override
  String get fieldOps_triggerRepeater => '새 리피터가 추가될 때';

  @override
  String get fieldOps_triggerScheduled => '예약된 체크인 시간이 될 때';

  @override
  String get fieldOps_explainConnection => '내 연결 설명';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return '상태: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      '휴대폰이 무전기에 연결되어 있습니다. 그것만으로 수신자까지의 경로가 확보되지는 않습니다.';

  @override
  String get fieldOps_disconnectedHint =>
      '활성 무선 연결이 없습니다. Bluetooth 권한, 무전기 전원과 범위를 확인하세요. USB/TCP는 무전기 연결에서 사용할 수 있습니다.';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return '확인을 기다리는 여정 체크인: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      '노드의 마지막 확인 시각과 알린 위치는 오래된 정보일 수 있습니다. 경로 분석은 관측된 시도에서 학습한 경로를 보여 주며, 경로를 만들어 내지 않습니다.';

  @override
  String get fieldOps_routeIntelligence => '경로 분석';

  @override
  String get fieldOps_coverageIntelligence => '커버리지 분석';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      '두 현장 세션의 관측 기록을 비교합니다. 점은 노드가 수신된 기록자의 무전기 알림 위치를 표시합니다. 연속적인 커버리지를 의미하지 않습니다. RSSI/SNR 스냅샷은 노드별 측정값이 아닙니다.';

  @override
  String get fieldOps_captureSession => '세션 기록';

  @override
  String get fieldOps_refreshHistory => '기록 새로고침';

  @override
  String get fieldOps_noCoverageSessions => '저장된 커버리지 세션이 아직 없습니다.';

  @override
  String get fieldOps_sessionA => '세션 A • 청록색';

  @override
  String get fieldOps_sessionB => '세션 B • 호박색';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: 고유 노드 $a개 • B: 고유 노드 $b개';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return '공통: $shared • A만: $onlyA • B만: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      '한 세션에서 노드가 수신되지 않았다고 음영 지역이라고 단정할 수 없습니다. 조건과 관측 시간이 다릅니다.';

  @override
  String get fieldOps_heardTooltip => '수신된 노드 관측. 연결 성공의 증거가 아닙니다';

  @override
  String get fieldOps_noteTooltip => '무전기가 알린 좌표의 로컬 메모. 오래된 정보일 수 있습니다.';

  @override
  String get bastionHome_aboutTooltip => 'NOTORYX Core Ham 정보';

  @override
  String get bastionHome_getStarted => '시작하기';

  @override
  String get bastionHome_getStartedHint => '무전기를 연결하고 첫 메시지를 확인하세요';

  @override
  String get bastionHome_planYourTrip => '여정 계획하기';

  @override
  String get bastionHome_tripActive => '여정 진행 중';

  @override
  String get bastionHome_tripStopped => '여정 중지됨';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • 연락처 $contacts명 • 읽지 않은 메시지 $unread개';
  }

  @override
  String get bastionHome_checkInOk => '체크인: 괜찮아요';

  @override
  String get bastionHome_checkInHint =>
      '보내기 전에 연락처와 메시지를 확인하세요. 확인 응답은 현장 로그에서 추적하세요.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return '마지막 체크인: $summary';
  }

  @override
  String get bastionHome_connectRadio => '무전기 연결';

  @override
  String get bastionHome_connectRadioHint => 'Bluetooth, USB, TCP MeshCore 연결';

  @override
  String get bastionHome_liveDiagnostics => '실시간 진단';

  @override
  String get bastionHome_liveDiagnosticsHint => '무전기 상태, 신호, 기기, 프레임 도구';

  @override
  String get bastionHome_meshDiscovery => '메시 탐색';

  @override
  String get bastionHome_meshDiscoveryHint => '주변 노드를 찾고 메시를 살펴보세요';

  @override
  String get bastionHome_fieldOpsHint => '여정 요약, 준비, 현장 로그, 자동화, 커버리지 비교';

  @override
  String get bastionHome_fieldTools => 'NOTORYX 현장 도구';

  @override
  String get bastionHome_statusActive => '사용 중';

  @override
  String get bastionHome_consoleOnline => '현장 콘솔 온라인';

  @override
  String get bastionHome_consoleReady => '현장 콘솔 준비됨';

  @override
  String get bastionHome_consoleHint => '무전기를 연결하면 실시간 대시보드가 표시됩니다.';

  @override
  String bastionHome_battery(String value) {
    return '배터리 $value';
  }

  @override
  String get bastionTools_title => '현장 도구';

  @override
  String get bastionTools_backup => '암호화 백업';

  @override
  String get bastionTools_backupHint => '설정, 연락처, 키를 저장하고 채팅 기록도 선택적으로 저장';

  @override
  String get bastionTools_fieldOpsHint => '체크인, 준비, 현장 로그, 자동화, 비교';

  @override
  String get bastionTools_mapHint => '실시간 지도, 기록 세션, 오프라인 지도 도구, 지역';

  @override
  String get bastionTools_pathAnalysis => '경로 분석';

  @override
  String get bastionTools_pathHint => '경로, 탐색, 경로 분석';

  @override
  String get bastionTools_repeaterHint => '상태, 로그인, 원격 측정, 이웃, 관리';

  @override
  String get bastionTools_statsHint => '실시간 메시 집계와 연락처 활동';

  @override
  String get bastionTools_diagnostics => '진단';

  @override
  String get bastionTools_diagnosticsHint => '무전기 상태, 기기 정보, 원시 프레임, 내보내기';

  @override
  String get bastionTools_about => '정보 + 크레딧';

  @override
  String get bastionTools_aboutHint =>
      'NOTORYX Core Ham 버전, 독립성 고지, 오픈 소스 라이선스';

  @override
  String get bastionAbout_title => '정보 + 크레딧';

  @override
  String get bastionAbout_intro =>
      'MeshCore 네트워크를 위한 독립 커뮤니티 동반 앱입니다. NOTORYX Core Ham는 MeshCore 공식 앱이 아니며, 커뮤니티 자료를 포함한다고 해서 제휴나 보증을 의미하지 않습니다.';

  @override
  String get bastionAbout_version => '버전';

  @override
  String get bastionAbout_openSource => '오픈 소스 기반';

  @override
  String get bastionAbout_openSourceBody =>
      'NOTORYX Core Ham는 MIT 라이선스의 MeshCore Open 오픈 소스 코드를 기반으로 만들어졌으며 이를 수정합니다. 커버리지 기능 작업은 해당되는 경우 MIT 라이선스의 MeshMapper Flutter App도 함께 밝힙니다.';

  @override
  String get bastionAbout_community => '커뮤니티 우선';

  @override
  String get bastionAbout_communityBody =>
      '제3자 제작자의 자료는 각 제작자의 소유로 남습니다. 소유권이나 제휴를 의미하지 않습니다.';

  @override
  String get bastionAbout_legalese => 'NOTORYX Core Ham • 독립 MeshCore 동반 앱';

  @override
  String get bastionAbout_licenses => '오픈 소스 라이선스';

  @override
  String get bastionSetup_title => 'NOTORYX Core Ham 시작하기';

  @override
  String get bastionSetup_intro =>
      '연결하고, 연락처를 고른 다음, 메시지를 확인하세요. 대시보드에서 언제든 이 안내로 돌아올 수 있습니다.';

  @override
  String get bastionSetup_step1 => '1. MeshCore 무전기 연결';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return '$transport(으)로 $device에 연결되었습니다.';
  }

  @override
  String get bastionSetup_noRadio => '아직 연결된 무전기가 없습니다.';

  @override
  String get bastionSetup_step1Power =>
      'MeshCore 동반 무전기를 켜세요. 무전기 연결을 열고 Bluetooth, USB 또는 TCP를 선택하세요. 선택한 연결에 필요한 권한을 허용하세요.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Bluetooth 검색 결과가 비어 있으면 Bluetooth가 켜져 있는지, Android 앱 설정에서 NOTORYX Core Ham에 근처 기기 권한이 있는지 확인하세요. 스캐너가 표시하는 추가 권한 요청도 따르세요.';

  @override
  String get bastionSetup_connectionDiagnostics => '연결 진단';

  @override
  String get bastionSetup_step2 => '2. 채팅 연락처 선택';

  @override
  String get bastionSetup_step2Body =>
      '호환되는 MeshCore 무선 설정을 가진 근처의 동료에게 노드를 알려 달라고 요청하세요. 아래에서 알려진 채팅 연락처를 고르세요. 리피터는 따로 관리합니다.';

  @override
  String get bastionSetup_noContacts =>
      '사용할 수 있는 채팅 연락처가 없습니다. 무전기를 연결하고 메시 탐색을 여세요.';

  @override
  String get bastionSetup_testRecipient => '테스트 수신자';

  @override
  String get bastionSetup_meshDiscovery => '메시 탐색';

  @override
  String get bastionSetup_step3 => '3. 메시지 보내고 확인하기';

  @override
  String get bastionSetup_step3Body =>
      '채팅을 열고 짧은 테스트 메시지를 쓴 뒤 수신자를 확인하고 보내기를 누르세요. 여기로 돌아오면 이 안내를 연 뒤 기록된 최신 발신 메시지를 볼 수 있습니다.';

  @override
  String get bastionSetup_openTestChat => '테스트 채팅 열기';

  @override
  String get bastionSetup_connectFirst => '테스트 채팅을 열려면 무전기를 연결하세요.';

  @override
  String get bastionSetup_chooseRecipient => '먼저 수신자를 선택하세요.';

  @override
  String get bastionSetup_noTestMessage => '이번 안내 세션에 기록된 발신 테스트 메시지가 없습니다.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return '최신 메시지: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      '동료에게 수신 확인이나 답장을 요청하세요. 기록된 확인 응답은 읽었다는 증거가 아닙니다. 메시지가 실패하면 연결과 수신자를 다시 확인하세요.';

  @override
  String get bastionSetup_step4 => '4. 현장 준비';

  @override
  String get bastionSetup_step4Body =>
      '여정 연락처를 계획하고 다운로드한 지도 지역을 확인하세요. 봇 모드와 현장 자동화는 처음에는 꺼져 있으며, 현장 자동화는 앱이 활성 상태일 때만 실행됩니다.';

  @override
  String get bastionSetup_tripTools => '여정 및 준비 도구';

  @override
  String get bastionDiag_title => '진단';

  @override
  String get bastionDiag_export => '진단 내보내기';

  @override
  String get bastionDiag_channels => '채널';

  @override
  String get bastionDiag_radio => '무선';

  @override
  String get bastionDiag_frequency => '주파수';

  @override
  String get bastionDiag_bandwidth => '대역폭';

  @override
  String get bastionDiag_spreadingFactor => '확산 계수';

  @override
  String get bastionDiag_codingRate => '부호율';

  @override
  String get bastionDiag_txPower => '송신 출력';

  @override
  String get bastionDiag_noiseFloor => '잡음 레벨';

  @override
  String get bastionDiag_device => '기기';

  @override
  String get bastionDiag_name => '이름';

  @override
  String get bastionDiag_manufacturer => '제조사';

  @override
  String get bastionDiag_firmware => '펌웨어';

  @override
  String get bastionDiag_battery => '배터리';

  @override
  String get bastionDiag_transport => '연결 방식';

  @override
  String get bastionDiag_deepTools => '고급 도구';

  @override
  String get bastionDiag_liveStats => '실시간 무선 통계';

  @override
  String get bastionDiag_liveStatsHint => '잡음, RSSI, SNR, 송출 시간';

  @override
  String get bastionDiag_frameDebug => '프레임 / BLE 디버그';

  @override
  String get bastionDiag_frameDebugHint => '디코딩된 수신 프레임과 원시 프레임 살펴보기';

  @override
  String get bastionDiag_appLog => '앱 디버그 로그';

  @override
  String get bastionDiag_appLogHint => '앱 진단 이벤트 검토';

  @override
  String get bastionDiag_online => '무전기 온라인';

  @override
  String get bastionDiag_offline => '무전기 오프라인';

  @override
  String get bastionDiag_offlineHint => 'MeshCore 동반 기기를 연결하면 실시간 진단이 표시됩니다.';

  @override
  String get coverage_title => '커버리지 기록';

  @override
  String get coverage_leaveBlocked => '나가기 전에 세션을 중지하고 저장하세요.';

  @override
  String get coverage_savedSessions => '저장된 세션';

  @override
  String get coverage_caveat =>
      'RSSI/SNR은 무전기 스냅샷이며 다른 패킷의 값일 수 있습니다. 위치는 무전기가 알린 좌표로, 휴대폰 GPS나 커버리지의 증거가 아닙니다. 청록: 기록자, 호박색: 알린 노드. 보간은 하지 않습니다.';

  @override
  String get coverage_captureActive => '기록 중';

  @override
  String get coverage_fieldSession => '현장 커버리지 세션';

  @override
  String get coverage_connectedBody =>
      'NOTORYX Core Ham는 이 세션 동안 새로 수신된 노드를 기록합니다. 경로 데이터, 노드/위치 메타데이터, 가장 가까운 무전기 RSSI/SNR 스냅샷을 포함합니다.';

  @override
  String get coverage_disconnectedBody =>
      '시작하기 전에 무전기를 연결하세요. 커버리지 기록은 연결된 동반 무전기에서 실시간 메시 관측을 기록합니다.';

  @override
  String get coverage_observations => '관측';

  @override
  String get coverage_uniqueNodes => '고유 노드';

  @override
  String get coverage_elapsed => '경과 시간';

  @override
  String get coverage_radioConnected => '무전기 연결됨';

  @override
  String get coverage_noRadio => '무전기 없음';

  @override
  String get coverage_gpsReady => '무전기 GPS 준비됨';

  @override
  String get coverage_noGps => '무전기 GPS 없음';

  @override
  String get coverage_stopSave => '중지 + 세션 저장';

  @override
  String get coverage_start => '커버리지 세션 시작';

  @override
  String get coverage_exportJson => 'JSON 내보내기';

  @override
  String get coverage_exportCsv => 'CSV 내보내기';

  @override
  String get coverage_liveObservations => '실시간 관측';

  @override
  String get coverage_waiting => '메시 활동 대기 중';

  @override
  String get coverage_waitingBody =>
      '세션을 시작하면 새로 수신된 활성 노드가 여기에 표시됩니다. RSSI/SNR 값은 무전기 스냅샷이며 항상 특정 패킷과 정확히 연결되지는 않습니다.';

  @override
  String get coverage_signalNa => '신호 없음';

  @override
  String get coverage_snrNa => 'SNR 없음';

  @override
  String get coverage_gpsUnavailable => '무전기 GPS 사용 불가';

  @override
  String coverage_pathLine(String path, String location) {
    return '경로: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => '플러드';

  @override
  String get coverage_pathDirect => '직접';

  @override
  String get coverage_shareSubject => 'NOTORYX Core Ham 커버리지 세션';

  @override
  String get coverage_shareText => 'NOTORYX Core Ham 커버리지 기록 내보내기';

  @override
  String get coverage_historyTitle => '저장된 커버리지 세션';

  @override
  String coverage_loadFailed(String error) {
    return '세션을 불러올 수 없습니다: $error';
  }

  @override
  String get coverage_deleteTitle => '저장된 세션을 삭제할까요?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '관측 $count건이 이 기기에서 삭제됩니다.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return '세션을 삭제할 수 없습니다: $error';
  }

  @override
  String get coverage_retention =>
      '완료된 최신 세션 20개가 보관됩니다. 보관하려는 세션은 공유하세요. 중단된 기록은 아래에서 다시 열 수 있습니다.';

  @override
  String get coverage_noSessions => '저장된 세션이 아직 없습니다. 기록을 중지하면 저장됩니다.';

  @override
  String get coverage_interrupted => '중단된 기록';

  @override
  String get coverage_saved => '저장됨';

  @override
  String get coverage_deleteTooltip => '세션 삭제';

  @override
  String coverage_exportFailed(String error) {
    return '내보내기 실패: $error';
  }

  @override
  String get coverage_sessionTitle => '커버리지 세션';

  @override
  String get coverage_shareJson => 'JSON 공유';

  @override
  String get coverage_shareCsv => 'CSV 공유';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • 스냅샷 경과 $age ms';
  }

  @override
  String get coverage_unknown => '알 수 없음';

  @override
  String coverage_pathValue(String path) {
    return '경로 $path';
  }

  @override
  String get coverage_recorder => '기록자';

  @override
  String get coverage_noCoordinates =>
      '이 세션에는 사용할 수 있는 좌표가 없습니다. 관측은 아래에서 계속 볼 수 있습니다.';

  @override
  String get coverage_osmAttribution => '© OpenStreetMap 기여자 • 온라인 기본 지도';

  @override
  String get fieldStats_title => '현장 분석';

  @override
  String get fieldStats_snapshot => '실시간 메시 스냅샷';

  @override
  String get fieldStats_headline => '지금 NOTORYX Core Ham가 알고 있는 것.';

  @override
  String get fieldStats_body =>
      '이 집계는 연결된 MeshCore 연락처 표, 위치, 경로, 마지막 확인 시각을 바탕으로 계산됩니다.';

  @override
  String get fieldStats_total => '전체';

  @override
  String get fieldStats_chatNodes => '채팅 노드';

  @override
  String get fieldStats_rooms => '룸';

  @override
  String get fieldStats_sensors => '센서';

  @override
  String get fieldStats_located => '위치 있음';

  @override
  String get fieldStats_favorites => '즐겨찾기';

  @override
  String get fieldStats_routeSnapshot => '경로 스냅샷';

  @override
  String get fieldStats_routed => '경로 있음';

  @override
  String get fieldStats_direct => '직접';

  @override
  String get fieldStats_flood => '플러드';

  @override
  String get fieldStats_pathIntel => '경로 분석';

  @override
  String get fieldStats_pathIntelBody =>
      'NOTORYX Core Ham의 경로 분석은 저장된 경로 시도, 홉 수, 성공/실패, 이동 시간, 경로 가중치를 사용해 학습된 경로를 보여 줍니다.';

  @override
  String get fieldStats_coverageSessions => '커버리지 세션';

  @override
  String get fieldStats_coverageSessionsBody =>
      '커버리지 기록은 이제 현장 세션을 저장하고, 중단된 작업을 복원하고, 관측을 내보내고, 기록된 커버리지 지점을 지도에 표시합니다. RSSI/SNR은 여전히 가장 가까운 무전기 스냅샷입니다.';

  @override
  String get mapHub_title => 'NOTORYX 현장 지도';

  @override
  String get mapHub_intro =>
      '실시간 지도, 오프라인 지역, 지역 프로필, NOTORYX Core Ham 현장 커버리지 세션.';

  @override
  String get mapHub_captureHint => '현장 커버리지 세션 시작 및 중지';

  @override
  String get mapHub_badgeNew => '새 기능';

  @override
  String get mapHub_liveMap => '실시간 메시 지도';

  @override
  String get mapHub_liveMapHint => '노드, 리피터, 위치, 경로, 지도 도구';

  @override
  String get mapHub_badgeLive => '실시간';

  @override
  String get mapHub_offlinePacks => '오프라인 지도 팩';

  @override
  String get mapHub_offlinePacksHint => '여정과 서비스 불가 지역을 위해 지도 타일 캐시';

  @override
  String get mapHub_badgeOffline => '오프라인';

  @override
  String get mapHub_regions => '지역 프로필';

  @override
  String get mapHub_regionsHint => '지역 메시 정의 관리 및 가져오기';

  @override
  String get mapHub_badgeRegions => '지역';

  @override
  String get routes_title => '경로 분석';

  @override
  String get routes_headline => '메시에서 트래픽이 어떻게 흐르는지 확인하세요.';

  @override
  String get routes_body =>
      'NOTORYX Core Ham는 실제 메시지 시도와 탐색에서 이미 학습한 경로 기록으로 저장된 경로의 순위를 매깁니다.';

  @override
  String get routes_routes => '경로';

  @override
  String get routes_success => '성공';

  @override
  String get routes_failed => '실패';

  @override
  String get routes_routeMap => '경로 지도';

  @override
  String get routes_routeMapHint => '노드와 경로 살펴보기';

  @override
  String get routes_discover => '탐색';

  @override
  String get routes_discoverHint => '새 경로 찾기';

  @override
  String get routes_learned => '학습된 경로';

  @override
  String get routes_none => '아직 경로 기록이 없습니다';

  @override
  String get routes_noneBody =>
      '평소처럼 메시를 사용하거나 탐색을 실행하세요. 경로 기록이 생기면 학습된 경로가 여기에 표시됩니다.';

  @override
  String get routes_direct => '직접';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '경로 $count개',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return '최적  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  가중치 $weight  •  성공 $success / 실패 $fail';
  }

  @override
  String routes_fastest(String ms) {
    return '알려진 최단 시간: $ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return '플러드: 성공 $success / 실패 $fail';
  }

  @override
  String get repeaterTools_heroLabel => '리피터 관리';

  @override
  String get repeaterTools_headline => '메시를 받치는 인프라를 관리하세요.';

  @override
  String get repeaterTools_body =>
      '발견된 리피터를 선택해 인증하고, 기존 MeshCore 상태, 원격 측정, 이웃, 설정, CLI 도구를 여세요.';

  @override
  String get repeaterTools_discovered => '발견됨';

  @override
  String get repeaterTools_tools => '도구';

  @override
  String get repeaterTools_available => '사용 가능한 리피터';

  @override
  String get repeaterTools_unnamed => '이름 없는 리피터';

  @override
  String get repeaterTools_statusTelemetry => '상태 + 원격 측정';

  @override
  String get repeaterTools_statusTelemetryBody =>
      '기존 관리 도구로 리피터 상태와 원격 측정을 확인합니다.';

  @override
  String get repeaterTools_neighbors => '이웃';

  @override
  String get repeaterTools_neighborsBody => '이웃 인프라와 메시 관계를 살펴봅니다.';

  @override
  String get repeaterTools_cli => 'CLI + 설정';

  @override
  String get repeaterTools_cliBody => '인증된 관리자는 기존 리피터 CLI와 구성 도구를 사용할 수 있습니다.';

  @override
  String get repeaterTools_empty => '아직 발견된 리피터가 없습니다. 무전기를 연결하고 먼저 메시를 탐색하세요.';

  @override
  String get notification_fieldAlertTitle => 'NOTORYX 현장 알림';

  @override
  String get notification_checkInReminderTitle => 'NOTORYX Core Ham 체크인 알림';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return '$trip에서 $minutes분 동안 체크인이 없습니다. NOTORYX Core Ham를 열어 체크인하세요.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return '$name 님이 $minutes분 동안 소식이 없습니다. 확인된 긴급 상황은 아닙니다.';
  }

  @override
  String get notification_aTripContact => '여정 연락처';

  @override
  String notification_checkInNotDelivered(String name) {
    return '$name 님에게 체크인이 전달되지 않았습니다. 여정에서 다시 보낼 수 있습니다.';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return '$name 님이 SOS를 확인했습니다';
  }

  @override
  String get settings_batterySaver => '배터리 절약';

  @override
  String get settings_batterySaverOn =>
      '켜짐: 무전기 배터리 10분마다, GPS 5분마다, 통계는 최대 1분에 한 번, 여정 점검은 1–2분마다. 메시지, 알림, SOS는 그대로입니다.';

  @override
  String get settings_batterySaverOff =>
      '무전기와 여정을 덜 자주 확인해 휴대폰과 무전기 배터리를 아낍니다. 메시지, 알림, SOS는 그대로입니다.';

  @override
  String get settings_readAloud => '새 메시지 소리 내어 읽기';

  @override
  String get settings_readAloudHelper =>
      'NOTORYX Core Ham가 열려 있는 동안만. 음소거한 채널은 읽지 않습니다. 각 메시지의 메뉴에서도 읽을 수 있습니다.';

  @override
  String get settings_readAloudOff => '끔';

  @override
  String get settings_readAloudDirect => '다이렉트 메시지';

  @override
  String get settings_readAloudAll => '다이렉트 및 채널 메시지';

  @override
  String get chat_readAloud => '소리 내어 읽기';

  @override
  String get messageSearch_title => '메시지 검색';

  @override
  String get messageSearch_intro => '이 휴대폰에 저장된 모든 다이렉트 및 채널 메시지를 검색합니다.';

  @override
  String messageSearch_noResults(String query) {
    return '\'$query\'이(가) 포함된 메시지가 없습니다.';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count건 일치',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return '최신 일치 항목 $count건 표시 중';
  }

  @override
  String get shortcuts_checkIn => '체크인';

  @override
  String get shortcuts_trip => '여정';

  @override
  String get shortcuts_chats => '채팅';

  @override
  String get shortcuts_map => '지도';

  @override
  String get sensor_liveUpdates => '실시간 업데이트';

  @override
  String get sensor_intro =>
      '매번 요청하는 대신 값이 바뀌면 센서가 직접 보내도록 합니다. 읽기 권한으로 로그인해야 합니다.';

  @override
  String get sensor_watch => '변화 감시';

  @override
  String get sensor_loadFirst => '감시할 값을 고르려면 먼저 원격 측정을 불러오세요.';

  @override
  String sensor_watching(String readings, String time) {
    return '$time까지 $readings 감시 중.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return '$time까지 $readings 감시 중 • 지역 $region.';
  }

  @override
  String get sensor_noChanges => '아직 보고된 변화가 없습니다.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return '마지막 업데이트 $time • $count건 수신';
  }

  @override
  String get sensor_stop => '실시간 업데이트 중지';

  @override
  String sensor_stopUnconfirmed(String error) {
    return '여기서 중지했습니다. 센서가 확인하지 않았으며 시간이 끝나면 멈춥니다. $error';
  }

  @override
  String get sensor_dialogBody =>
      '센서는 약 1분마다 확인하고, 선택한 값이 기준보다 크게 바뀌면 업데이트를 보냅니다.';

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
    return '$label(ch $channel) ±$delta';
  }

  @override
  String sensor_updateOn(String delta) {
    return '$delta 변하면 업데이트';
  }

  @override
  String get sensor_changeThreshold => '기준 변경';

  @override
  String sensor_capacity(int max, String used) {
    return '센서는 최대 $max바이트의 값을 감시할 수 있습니다($used 사용 중).';
  }

  @override
  String get sensor_for => '기간';

  @override
  String sensor_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count시간',
    );
    return '$_temp0';
  }

  @override
  String get sensor_start => '시작';

  @override
  String sensor_thresholdTitle(String label) {
    return '$label 기준';
  }

  @override
  String get sensor_typeTemperature => '온도';

  @override
  String get sensor_typeHumidity => '습도';

  @override
  String get sensor_typePressure => '기압';

  @override
  String get sensor_typeVoltage => '전압';

  @override
  String get sensor_typeCurrent => '전류';

  @override
  String get sensor_typeLight => '조도';

  @override
  String get sensor_typeConcentration => '농도';

  @override
  String get sensor_typePercentage => '백분율';

  @override
  String get sensor_typeAnalogInput => '아날로그 입력';

  @override
  String get sensor_typeAltitude => '고도';

  @override
  String get setupWizard_title => '무전기 연결';

  @override
  String get setupWizard_choose => '1. 연결 방식 선택';

  @override
  String get setupWizard_prepare => '2. 무전기 준비';

  @override
  String get setupWizard_intro =>
      '이 휴대폰이나 컴퓨터를 무전기에 연결할 방법을 선택하세요. 무전기가 메시 네트워크로 메시지를 전달합니다.';

  @override
  String get setupWizard_bluetooth => '근처의 호환 무전기에 무선으로 연결합니다.';

  @override
  String get setupWizard_noBluetooth =>
      '이 브라우저에서는 블루투스를 사용할 수 없습니다. 네이티브 앱이나 지원되는 USB 연결을 사용하세요.';

  @override
  String get setupWizard_usb => 'USB 데이터 케이블을 사용한 유선 연결입니다.';

  @override
  String get setupWizard_noUsb =>
      '여기서는 USB 시리얼을 사용할 수 없습니다. 지원되는 데스크톱 또는 Android 앱이나 Web Serial을 지원하는 Chrome을 사용하세요.';

  @override
  String get setupWizard_bluetoothSteps =>
      '무전기 전원을 켜고 가까이 두세요. 블루투스를 켜고 앱에 사용 권한을 허용하세요. 무전기에 연결된 다른 앱을 닫고 기기 목록을 열어 검색하세요.';

  @override
  String get setupWizard_usbSteps =>
      '전원이 켜진 무전기를 USB 데이터 케이블로 연결하세요. 충전 전용 케이블은 작동하지 않습니다. 다른 시리얼 앱을 닫으세요. USB 기기 목록을 열어 무전기를 선택하고, 요청되면 접근을 허용하세요.';

  @override
  String get setupWizard_firmwareTitle => '펌웨어를 바꾸기 전에 호환성 확인';

  @override
  String get setupWizard_firmware =>
      '무전기에는 선택한 연결 방식을 지원하는 NOTORYX Ham 컴패니언 펌웨어가 필요합니다. 지원 여부는 보드와 펌웨어 빌드에 따라 다르며, USB 포트가 있다고 해서 USB 시리얼이 지원되는 것은 아닙니다. 사용 중인 보드와 설치된 빌드의 안내를 확인하세요. 리피터나 룸 서버 펌웨어는 컴패니언이 아닙니다. 연결 실패만으로 펌웨어를 다시 써야 한다는 뜻은 아닙니다.';

  @override
  String get setupWizard_settings =>
      '이 안내는 펌웨어를 쓰거나 무전기 설정을 바꾸지 않습니다. 연결 후 설정에서 지역, 주파수, 고급 옵션을 지정하세요. 바꾸기 전에 지역 메시와 설정을 확인하세요.';

  @override
  String get setupWizard_openBluetooth => '블루투스 기기 열기';

  @override
  String get setupWizard_openUsb => 'USB 기기 열기';

  @override
  String get setupWizard_change => '연결 방식 변경';

  @override
  String get setupWizard_later => '나중에 설정';

  @override
  String get setupWizard_bluetoothError =>
      '무전기에 연결하지 못했습니다. 전원을 켠 채 가까이 두고, 블루투스 권한을 확인하고, 연결된 다른 앱을 닫은 다음 다시 검색하세요.';

  @override
  String get setupWizard_scanError =>
      '무전기를 검색하지 못했습니다. 블루투스를 켜고 시스템 설정에서 블루투스 또는 주변 기기 접근을 허용한 다음 다시 검색하세요.';

  @override
  String get setupWizard_usbError =>
      'USB로 연결하지 못했습니다. 데이터 케이블과 선택한 기기를 확인하고, USB 접근을 허용하고, 다른 시리얼 앱을 닫으세요. 케이블을 다시 연결하고 다시 시도하세요.';

  @override
  String get connections_title => '연결';

  @override
  String get connections_radioTitle => '무전기 연결';

  @override
  String get connections_bluetoothOffNotice =>
      '블루투스가 꺼져 있습니다. 다시 연결하려면 켜세요. 블루투스가 돌아오면 앱이 다시 시도합니다.';

  @override
  String get connections_transport => '연결 방식';

  @override
  String connections_lastError(String error) {
    return '마지막 오류: $error';
  }

  @override
  String get connections_disconnectRadio => '무전기 연결 끊기';

  @override
  String connections_reconnectTo(String name) {
    return '$name에 다시 연결';
  }

  @override
  String get connections_forgetRadio => '무전기 삭제';

  @override
  String get connections_connectAnother => '다른 무전기 연결';

  @override
  String get connections_usbSerial => 'USB 시리얼';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => '기기';

  @override
  String get connections_publicKey => '공개 키';

  @override
  String get connections_firmware => '펌웨어';

  @override
  String connections_firmwareProtocol(String code) {
    return '프로토콜 v$code';
  }

  @override
  String get connections_battery => '배터리';

  @override
  String get connections_lastRx => '마지막 수신';

  @override
  String get connections_reconnectFailed => '무전기에 다시 연결하지 못했습니다';

  @override
  String get connections_statusBluetoothOff => '블루투스가 꺼져 있음';

  @override
  String get connections_statusConnected => '연결됨';

  @override
  String get connections_statusConnecting => '연결 중…';

  @override
  String get connections_statusDisconnecting => '연결 끊는 중…';

  @override
  String get connections_statusScanning => '무전기 검색 중…';

  @override
  String get connections_statusReconnectingSoon => '곧 다시 연결…';

  @override
  String get connections_statusNotConnected => '연결되지 않음';

  @override
  String get mqtt_cardTitle => 'MQTT 연결';

  @override
  String get mqtt_statusNotConfigured => '설정되지 않음';

  @override
  String get mqtt_statusDisconnected => '연결 끊김';

  @override
  String get mqtt_statusConnecting => '연결 중';

  @override
  String get mqtt_statusConnected => '연결됨';

  @override
  String get mqtt_statusReconnecting => '다시 연결 중';

  @override
  String get mqtt_statusError => '연결 오류';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return '브로커: $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn => '무전기가 서명한 토큰으로 로그인';

  @override
  String mqtt_tokenSignInAs(String username) {
    return '무전기가 서명한 토큰으로 $username…(으)로 로그인';
  }

  @override
  String get mqtt_connectRadioToSignIn => '로그인하려면 무전기를 연결하세요';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return '토큰 갱신 시각: $time';
  }

  @override
  String mqtt_signedInAs(String username) {
    return '$username(으)로 로그인됨';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return '$topic 수신 중';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return '패킷: 새 패킷 $accepted, 중복 $duplicate, 잘못됨 $invalid';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return '재시도 $attempt/$max';
  }

  @override
  String get mqtt_sharingWaitsForRadio => '공유가 무전기 연결을 기다리는 중';

  @override
  String mqtt_sharingOn(String topic) {
    return '$topic에 공유 중';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return '$topic에 공유 예정';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return '$topic에 온라인 상태 게시';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return '공유 $shared, 보류 $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      '브로커를 추가하면 인터넷을 통해 MeshCore 트래픽을 연결할 수 있습니다. 무전기 연결은 별도로 동작합니다.';

  @override
  String get mqtt_disconnect => 'MQTT 연결 끊기';

  @override
  String get mqtt_connect => 'MQTT 연결';

  @override
  String get mqtt_packetFeed => '패킷 피드';

  @override
  String get mqtt_setUpBroker => '브로커 설정';

  @override
  String get mqtt_brokerSettings => '브로커 설정';

  @override
  String get mqtt_settingsTitle => 'MQTT 브로커 설정';

  @override
  String get mqtt_presetLabel => '프리셋으로 시작';

  @override
  String get mqtt_presetCustom => '사용자 지정 브로커';

  @override
  String get mqtt_presetLocal => '로컬 브로커 (주소 입력)';

  @override
  String get mqtt_presetLetsMeshUs => 'LetsMesh 분석기 (미국, 커뮤니티)';

  @override
  String get mqtt_presetLetsMeshEu => 'LetsMesh 분석기 (EU, 커뮤니티)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh는 커뮤니티가 운영하는 MeshCore 패킷 분석기로, NOTORYX의 일부가 아니며 NOTORYX가 보증하지 않습니다. 공유하려면 무전기가 연결되어 있어야 하며, 직접 켜기 전까지는 꺼져 있습니다.';

  @override
  String get mqtt_hostname => '브로커 호스트 이름';

  @override
  String get mqtt_port => '포트';

  @override
  String get mqtt_useTls => 'TLS 사용';

  @override
  String get mqtt_allowCleartext => '로컬 브로커에 암호화되지 않은 연결 허용';

  @override
  String get mqtt_allowCleartextHint =>
      'localhost, .local 및 사설 10.x / 192.168.x 호스트만 해당됩니다.';

  @override
  String get mqtt_useWebSocket => 'WebSocket 사용';

  @override
  String get mqtt_webSocketPath => 'WebSocket 경로';

  @override
  String get mqtt_topicPrefix => '토픽 접두사';

  @override
  String get mqtt_region => '지역 (선택)';

  @override
  String get mqtt_regionHelp => '관측자 지역 코드(예: PHL). 비워 두면 전체입니다.';

  @override
  String get mqtt_deliverChannel => 'MQTT로 수신한 채널 메시지 추가';

  @override
  String get mqtt_deliverChannelHint =>
      '관측자가 들은 내 채널의 메시지가 채팅에 표시됩니다. 내 무전기로 전송되지는 않습니다.';

  @override
  String get mqtt_sharingTitle => '관측자로 공유';

  @override
  String get mqtt_share => '내 무전기가 수신한 패킷 공유';

  @override
  String get mqtt_shareHint =>
      '무전기가 수신한 광고와 채널 트래픽을 공개 키, 신호 세기, 지역과 함께 게시합니다. 채널 메시지는 암호화된 상태로 유지됩니다. 지역이 필요합니다.';

  @override
  String get mqtt_shareDirect => '개인 메시지 트래픽 포함';

  @override
  String get mqtt_shareDirectHint =>
      '요청, 응답, 개인 메시지. 내용은 암호화된 상태로 유지되지만 어떤 노드끼리 통신하는지 드러납니다.';

  @override
  String get mqtt_shareOwn => '내 메시지와 광고 포함';

  @override
  String get mqtt_signInTitle => '로그인';

  @override
  String get mqtt_authPassword => '사용자 이름과 비밀번호';

  @override
  String get mqtt_authToken => '무전기가 서명한 토큰';

  @override
  String get mqtt_tokenExplain =>
      '무전기가 자체 키로 1시간짜리 로그인 토큰에 서명하고, 앱이 만료 전에 갱신합니다. 키는 무전기 밖으로 나가지 않습니다. 사용자 이름은 v1_ 뒤에 무전기 공개 키를 붙인 것입니다.';

  @override
  String get mqtt_radioReady => '무전기 연결됨: 로그인할 준비가 되었습니다.';

  @override
  String get mqtt_radioNeeded => '로그인하려면 무전기를 연결하세요. MQTT가 기다리고 있습니다.';

  @override
  String get mqtt_username => '사용자 이름 (선택)';

  @override
  String get mqtt_password => '비밀번호';

  @override
  String get mqtt_keepPassword => '저장된 비밀번호를 유지하려면 비워 두세요.';

  @override
  String get mqtt_credentialsWeb => '브라우저에서는 페이지를 닫을 때까지만 자격 증명이 유지됩니다.';

  @override
  String get mqtt_credentialsKeychain =>
      '자격 증명은 시스템 키체인에 저장되며 앱 설정이나 로그에는 저장되지 않습니다.';

  @override
  String get mqtt_saveSettings => '설정 저장';

  @override
  String get mqtt_feedTitle => 'MQTT 패킷 피드';

  @override
  String get mqtt_feedConnect => '관측자의 패킷을 보려면 브로커에 연결하세요.';

  @override
  String mqtt_feedWaiting(String topic) {
    return '$topic에서 패킷을 기다리는 중';
  }

  @override
  String get mqtt_feedUnknownObserver => '알 수 없는 관측자';

  @override
  String mqtt_feedHeardBy(String observer) {
    return '수신: $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return '$hops홉 · $bytes바이트';
  }

  @override
  String get mqtt_packetRequest => '요청';

  @override
  String get mqtt_packetResponse => '응답';

  @override
  String get mqtt_packetDirectMessage => '개인 메시지';

  @override
  String get mqtt_packetAck => '확인 응답';

  @override
  String get mqtt_packetAdvert => '광고';

  @override
  String get mqtt_packetChannelMessage => '채널 메시지';

  @override
  String get mqtt_packetChannelData => '채널 데이터';

  @override
  String get mqtt_packetAnonymousRequest => '익명 요청';

  @override
  String get mqtt_packetPath => '경로';

  @override
  String get mqtt_packetTrace => '추적';

  @override
  String get mqtt_packetMultipart => '멀티파트';

  @override
  String get mqtt_packetControl => '제어';

  @override
  String mqtt_packetType(int type) {
    return '유형 $type';
  }

  @override
  String get mqtt_routeTransportFlood => '전송 플러드';

  @override
  String get mqtt_routeFlood => '플러드';

  @override
  String get mqtt_routeDirect => '직접';

  @override
  String get mqtt_routeTransportDirect => '전송 직접';

  @override
  String get mqtt_noticeInvalidHost => '스킴이나 포트 없이 호스트 이름 또는 IPv4 주소를 입력하세요.';

  @override
  String get mqtt_noticeInvalidPort => '포트는 1에서 65535 사이여야 합니다.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'WebSocket 경로는 /로 시작해야 하며 쿼리나 프래그먼트를 포함할 수 없습니다.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      '토픽 접두사는 와일드카드가 없는 비어 있지 않은 MQTT 경로여야 합니다.';

  @override
  String get mqtt_noticeInvalidRegion => '지역은 2~8자의 영문자 또는 숫자여야 합니다(예: PHL).';

  @override
  String get mqtt_noticeTlsRequired =>
      '로컬 브로커에 대한 보안되지 않은 접근을 명시적으로 허용하지 않는 한 TLS가 필요합니다.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      '암호화되지 않은 MQTT는 명시적으로 승인한 로컬 호스트로만 제한됩니다.';

  @override
  String get mqtt_noticeRegionNeededToShare => '관측자로 패킷을 공유하려면 지역을 설정하세요.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return '$username의 비밀번호를 입력하세요.';
  }

  @override
  String get mqtt_noticeNoNetwork => '네트워크 연결이 없습니다. 연결이 돌아오면 MQTT가 다시 연결합니다.';

  @override
  String get mqtt_noticeSubscriptionRefused => '브로커가 패킷 구독을 거부했습니다.';

  @override
  String get mqtt_noticeBadCredentials => '브로커가 사용자 이름 또는 비밀번호를 거부했습니다.';

  @override
  String get mqtt_noticeNotAuthorized => '이 계정은 브로커에서 권한이 없습니다.';

  @override
  String get mqtt_noticeConnectionRefused => '브로커가 연결을 거부했습니다.';

  @override
  String get mqtt_noticeUnreachable => '브로커에 연결할 수 없습니다.';

  @override
  String get mqtt_noticeTlsFailed => '보안(TLS) 연결을 설정할 수 없습니다.';

  @override
  String get mqtt_noticeWebSocketOnly => '이 플랫폼은 WebSocket을 통한 MQTT만 지원합니다.';

  @override
  String get mqtt_noticeRadioNotConnected => '무전기 키로 로그인하려면 무전기를 연결하세요.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      '이 무전기의 펌웨어는 자체 키로 서명하는 기능을 지원하지 않습니다.';

  @override
  String get mqtt_noticeSigningTimeout =>
      '무전기가 서명 요청에 응답하지 않았습니다. 펌웨어가 서명을 지원하지 않을 수 있습니다.';

  @override
  String get mqtt_noticeSigningTooLong => '데이터가 너무 길어 무전기가 서명할 수 없습니다.';

  @override
  String get mqtt_noticeSigningRejected => '무전기가 데이터 서명을 거부했습니다.';

  @override
  String get scanner_signalStrong => '강함';

  @override
  String get scanner_signalGood => '좋음';

  @override
  String get scanner_signalFair => '보통';

  @override
  String get scanner_signalWeak => '약함';

  @override
  String get scanner_nearbyRadios => '주변 무전기';

  @override
  String get scanner_lastRadio => '최근 무전기';

  @override
  String get scanner_reconnect => '다시 연결';

  @override
  String get scanner_tcpHint => '네트워크에 있는 Wi‑Fi 펌웨어 무전기.';

  @override
  String get scanner_otherWays => '다른 연결 방법';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '주변 무전기 $count대',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => '무전기를 찾는 중…';

  @override
  String get scanner_findTitle => '무전기 찾기';

  @override
  String get scanner_heroHint =>
      '무전기를 켜고 몇 미터 안에 두세요. NOTORYX Ham companion 펌웨어가 필요합니다.';

  @override
  String get scanner_tipsTitle => '무전기가 보이지 않나요?';

  @override
  String get scanner_tipPower => '전원이 켜져 있고 깨어 있는지 확인하세요.';

  @override
  String get scanner_tipFirmware =>
      'NOTORYX Ham companion 펌웨어가 필요합니다. 리피터와 룸 서버는 여기에 표시되지 않습니다.';

  @override
  String get scanner_tipOtherDevice =>
      '무전기는 한 번에 한 기기에만 연결됩니다. 다른 휴대폰이나 컴퓨터에서 연결을 끊으세요.';

  @override
  String get connections_internetBridge => '인터넷 브리지';

  @override
  String get connections_noRadio => '무전기 없음';

  @override
  String get connections_radioSettings => '무전기 설정';

  @override
  String get connections_viewDashboard => '연결 대시보드 보기';

  @override
  String get channelDirectory_title => '채널 목록';

  @override
  String get channelDirectory_subtitle => '주변의 공개 해시태그 채널 찾기';

  @override
  String get channelDirectory_search => '채널 또는 장소 검색';

  @override
  String get channelDirectory_nearYou => '내 주변';

  @override
  String get channelDirectory_all => '모든 채널';

  @override
  String get channelDirectory_catAll => '전체';

  @override
  String get channelDirectory_catEmergency => '긴급';

  @override
  String get channelDirectory_catLocal => '지역';

  @override
  String get channelDirectory_catGeneral => '일반';

  @override
  String get channelDirectory_catInterest => '관심사';

  @override
  String get channelDirectory_catTest => '테스트';

  @override
  String get channelDirectory_join => '참여';

  @override
  String get channelDirectory_joined => '참여함';

  @override
  String get channelDirectory_noMatches => '검색과 일치하는 채널이 없습니다.';

  @override
  String get channelDirectory_connectFirst => '채널에 참여하려면 무전기를 연결하세요.';

  @override
  String get channelDirectory_slotsFull =>
      '무전기의 채널 슬롯이 모두 사용 중입니다. 먼저 채널을 삭제하세요.';

  @override
  String get channelDirectory_joinFailed => '채널을 추가하지 못했습니다. 다시 시도하세요.';

  @override
  String get channelDirectory_addHint =>
      '찾는 채널이 없나요? GitHub의 공유 목록을 수정해 누구나 제안할 수 있습니다.';

  @override
  String get prefixTool_title => '리피터 ID';

  @override
  String get prefixTool_subtitle => 'ID를 쓰는 노드, 겹치는 ID, 새 리피터용 빈 ID 확인';

  @override
  String get prefixTool_width => '경로 ID 크기';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes바이트';
  }

  @override
  String get prefixTool_includeCompanions => '컴패니언과 센서 포함';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return '알려진 노드 $nodes · 사용 중 ID $used · 겹침 $shared';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return '빈 ID $free / $space';
  }

  @override
  String get prefixTool_lookupHint => 'ID 검색 (예: 3D)';

  @override
  String prefixTool_lookupFree(String id) {
    return '$id를 쓰는 알려진 노드가 없습니다.';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$id를 쓰는 노드 $count개',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => '겹치는 ID';

  @override
  String get prefixTool_sharedHint =>
      '메시가 더 긴 ID를 쓰지 않으면 이 ID를 거치는 경로는 구분되지 않습니다.';

  @override
  String get prefixTool_noShared => '알려진 노드 중 겹치는 ID가 없습니다.';

  @override
  String get prefixTool_free => '빈 ID';

  @override
  String get prefixTool_shuffle => '다른 추천';

  @override
  String get prefixTool_makeKey => '키 만들기';

  @override
  String get prefixTool_onlyKnown =>
      '무전기가 들은 노드만 기준입니다. 여기서 빈 ID도 듣지 못한 리피터가 쓰고 있을 수 있습니다.';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id는 이미 $name이(가) 사용 중입니다.';
  }

  @override
  String get prefixTool_pickFree => '빈 ID 고르기';

  @override
  String keyGen_title(String id) {
    return 'ID $id용 키';
  }

  @override
  String keyGen_searching(int tries) {
    return '검색 중… 키 $tries개 시도';
  }

  @override
  String get keyGen_publicKey => '공개 키';

  @override
  String get keyGen_privateKey => '개인 키';

  @override
  String get keyGen_copy => '복사';

  @override
  String get keyGen_copied => '복사됨';

  @override
  String get keyGen_secretWarning =>
      '개인 키는 비밀로 유지하세요. 가진 사람은 이 노드로 위장할 수 있습니다.';

  @override
  String get keyGen_howToUse =>
      '리피터에 쓰려면 리피터 설정을 열고 개인 키로 붙여 넣은 뒤 저장하세요. 컴패니언 무전기는 키 가져오기를 허용하는 펌웨어가 필요합니다.';

  @override
  String get keyGen_tryAgain => '하나 더 만들기';

  @override
  String get regionSetup_title => '지역 설정';

  @override
  String get regionSetup_hubSubtitle => '이 리피터를 지역 트리에 배치';

  @override
  String get regionSetup_intro =>
      '지역을 쓰면 메시 전체에 플러딩하지 않고 메시지를 한 지역 안에 머물게 할 수 있습니다. 리피터는 해당 지역을 가지고 있을 때만 그 지역의 메시지를 전달하므로, 자신의 지역과 그 위의 모든 지역을 지정하세요.';

  @override
  String get regionSetup_where => '리피터 위치는?';

  @override
  String get regionSetup_tree => '지역 트리';

  @override
  String get regionSetup_custom => '직접 입력';

  @override
  String get regionSetup_region => '가장 좁은 지역';

  @override
  String get regionSetup_customLabel => '지역 (넓은 순서)';

  @override
  String regionSetup_invalidName(String name) {
    return '\"$name\"은(는) 올바른 지역 이름이 아닙니다. 소문자, 숫자, 하이픈으로 29자 이내여야 합니다.';
  }

  @override
  String regionSetup_tooMany(int max) {
    return '리피터는 최대 $max개의 지역을 가질 수 있습니다.';
  }

  @override
  String get regionSetup_options => '옵션';

  @override
  String get regionSetup_setDefault => '가장 좁은 지역을 기본값으로';

  @override
  String get regionSetup_setDefaultBody => '리피터의 자체 알림이 그 지역 안에 머뭅니다.';

  @override
  String get regionSetup_legacy => '펌웨어 1.14';

  @override
  String get regionSetup_legacyBody =>
      '각 지역 뒤에 region allowf를 추가합니다. 1.15 이상에서는 필요 없습니다.';

  @override
  String get regionSetup_denyUnscoped => '지역 없는 메시지 전달 중지';

  @override
  String get regionSetup_denyUnscopedBody =>
      '지역 전체가 지역 기능을 쓸 때만 켜세요. 그렇지 않으면 이전 앱의 메시지가 전달되지 않습니다.';

  @override
  String get regionSetup_commands => '명령';

  @override
  String get regionSetup_copyAll => '모두 복사';

  @override
  String get regionSetup_copied => '복사됨';

  @override
  String get regionSetup_pickFirst => '지역을 선택하면 명령이 표시됩니다.';

  @override
  String regionSetup_sendTo(String name) {
    return '$name에 보내기';
  }

  @override
  String get regionSetup_howToSend =>
      '보내려면 리피터에 로그인한 뒤 메뉴에서 지역 설정을 열거나, 명령줄에 붙여 넣으세요.';

  @override
  String get regionSetup_noReply => '응답 없음. 여기서 중단했습니다.';

  @override
  String get regionSetup_addToMine => '이 지역을 내 목록에 추가';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '내 목록에 지역 $count개 추가됨',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => '트랙 기록';

  @override
  String get trackLog_subtitle => '무전기 GPS로 이동 경로 기록';

  @override
  String get trackLog_recording => '기록 중';

  @override
  String get trackLog_notRecording => '기록 안 함';

  @override
  String get trackLog_noGps =>
      '무전기가 GPS 위치를 보내지 않습니다. 트랙 기록에는 GPS가 켜진 무전기가 필요합니다.';

  @override
  String get trackLog_start => '기록 시작';

  @override
  String get trackLog_stop => '기록 중지';

  @override
  String get trackLog_howItWorks =>
      'NOTORYX Core Ham가 열려 있는 동안 무전기가 약 1분마다 보내는 위치를 사용합니다. 25 m 이동하거나, 멈춰 있으면 15분마다 지점이 추가됩니다.';

  @override
  String get trackLog_snap => '위치를 약 100 m로 반올림';

  @override
  String get trackLog_snapBody => '트랙을 공유할 때 개인정보 보호용.';

  @override
  String get trackLog_saved => '저장된 트랙';

  @override
  String get trackLog_none => '아직 트랙이 없습니다.';

  @override
  String get trackLog_export => 'GPX로 내보내기';

  @override
  String get trackLog_exportFailed => '트랙을 내보내지 못했습니다.';

  @override
  String get trackLog_deleteTitle => '이 트랙을 삭제할까요?';

  @override
  String get trackLog_deleteBody => '이 기기에서 삭제됩니다. 내보낸 GPX 파일은 영향을 받지 않습니다.';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km km · $duration · 지점 $points개';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'NOTORYX 트랙 $when';
  }

  @override
  String get routes_nearbyTitle => '주변 최적 리피터';

  @override
  String get routes_nearbyEmptyTitle => '아직 들린 리피터가 없습니다';

  @override
  String get routes_nearbyEmpty =>
      '무전기가 직접 듣는 리피터가 트래픽을 받는 대로 강한 순서로 여기에 표시됩니다. 최근 1시간이 대상입니다.';

  @override
  String get routes_unknownRepeater => '알 수 없는 리피터';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count회 수신',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes분 전',
      zero: '방금',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return '경유: $names';
  }

  @override
  String get nav_home => '홈';

  @override
  String get nav_chats => '채팅';

  @override
  String get nav_tools => '도구';

  @override
  String get nav_settings => '설정';

  @override
  String get nav_more => '더보기';

  @override
  String get tools_groupApp => '앱 및 설정';

  @override
  String get tools_groupField => '현장';

  @override
  String get tools_groupMaps => '지도 및 커버리지';

  @override
  String get tools_groupRouting => '경로 및 리피터';

  @override
  String get tools_pathGraph => '경로 그래프';

  @override
  String get tools_pathGraphHint => '메시지가 도달하는 방식: 수신된 모든 경로와 가장 바쁜 리피터';

  @override
  String get tools_antenna => '안테나 커버리지';

  @override
  String get tools_antennaHint => '지형에서 안테나가 닿는 범위를 추정';

  @override
  String routes_repeaterWithId(String id) {
    return '리피터 $id';
  }

  @override
  String get coverageHex_title => '커버리지 육각형';

  @override
  String get coverageHex_toolSubtitle => '무전기가 메시를 수신하는 곳을 지도로 만들고 공유';

  @override
  String get coverageHex_mapCoverage => '커버리지 기록';

  @override
  String get coverageHex_statusOff =>
      '꺼짐. 운전하거나 걸을 때 켜면 무전기가 메시를 수신하는 곳을 기록합니다.';

  @override
  String get coverageHex_waitingGps => 'GPS 대기 중…';

  @override
  String coverageHex_gpsTooRough(String meters) {
    return 'GPS 정확도 ${meters}m: 너무 부정확하여 기록하지 않습니다.';
  }

  @override
  String coverageHex_recording(String meters) {
    return '기록 중. GPS 정확도 ${meters}m.';
  }

  @override
  String get coverageHex_hexagons => '육각형';

  @override
  String get coverageHex_samples => '샘플';

  @override
  String get coverageHex_privacyNote =>
      '이 스위치가 켜져 있는 동안 휴대폰 GPS를 사용합니다. 육각형 ID(약 0.9km)만 공유되며 정확한 위치는 공유되지 않습니다.';

  @override
  String get coverageHex_uploadSection => '커버리지 지도로 업로드';

  @override
  String get coverageHex_wifiOnly => 'Wi-Fi에서만 업로드';

  @override
  String get coverageHex_wifiOnlyHint => '샘플은 Wi-Fi가 될 때까지 휴대폰에서 대기합니다(최대 7일).';

  @override
  String coverageHex_waiting(String count) {
    return '$count개 대기 중';
  }

  @override
  String get coverageHex_addMap => '커버리지 지도 추가';

  @override
  String get coverageHex_addMapHint => '커버리지 업로드를 받는 HTTPS 엔드포인트.';

  @override
  String get coverageHex_uploadNow => '지금 업로드';

  @override
  String get coverageHex_mapDialogTitle => '커버리지 지도';

  @override
  String get coverageHex_nameMissing => '이름을 입력하세요.';

  @override
  String get coverageHex_url => '업로드 URL';

  @override
  String get coverageHex_urlInvalid => 'https:// URL이어야 합니다.';

  @override
  String get coverageHex_apiKey => 'API 키(선택)';

  @override
  String get coverageHex_apiKeyHint => 'X-API-Key로 전송됩니다.';

  @override
  String get coverageHex_format => '형식';

  @override
  String get coverageHex_formatHex => '육각형 ID(NOTORYX)';

  @override
  String get coverageHex_formatMeshMapper => 'MeshMapper 호환';

  @override
  String get coverageHex_privacy => '개인정보';

  @override
  String get coverageHex_privacyLive => '실시간';

  @override
  String get coverageHex_privacyDelayed => '3시간 지연';

  @override
  String get coverageHex_privacyAnonymous => '익명, 24시간';

  @override
  String get coverageHex_privacyLiveHint => '약 15분 이내에 전송됩니다.';

  @override
  String get coverageHex_privacyDelayedHint => '지도에 현재 위치가 표시되지 않도록 3시간 보류합니다.';

  @override
  String get coverageHex_privacyAnonymousHint =>
      '24시간 보류하고 날짜만 표시하며 서명하지 않아 업로드를 서로 연결할 수 없습니다.';

  @override
  String get coverageHex_uploadsOn => '업로드 켜기';

  @override
  String coverageHex_sent(String count, String time) {
    return '$time에 셀 $count개를 보냈습니다.';
  }

  @override
  String coverageHex_httpError(String code) {
    return '지도가 $code로 응답했습니다. 다시 시도합니다.';
  }

  @override
  String get coverageHex_unreachable => '지도에 연결할 수 없습니다. 다시 시도합니다.';

  @override
  String get coverageHex_noPermission => '위치 권한이 허용되지 않았습니다.';

  @override
  String get coverageHex_noGps => 'GPS를 사용할 수 없습니다.';

  @override
  String get coverageHex_loadFailed => '저장된 커버리지를 읽을 수 없어 새로 시작합니다.';

  @override
  String get mqttExtra_wifiOnly => 'Wi-Fi에서만 연결';

  @override
  String mqttExtra_backlog(String count) {
    return '업로드 대기 중인 패킷 $count개(최대 72시간 보관).';
  }

  @override
  String get mqttExtra_add => '다른 브로커 추가';

  @override
  String get mqttExtra_addBody =>
      '무전기가 수신한 내용을 기본 브로커 외에 MQTT 브로커 하나에 더 공유합니다. 업로드만 하며 앱으로 패킷을 되돌리지 않습니다.';

  @override
  String get mqttExtra_separateKey => '별도 키 사용';

  @override
  String get mqttExtra_separateKeyHint =>
      '무전기 키 대신 이 휴대폰에서 만든 키로 로그인하므로 이 브로커는 업로드를 무전기와 연결할 수 없습니다.';

  @override
  String mqttExtra_removeTitle(String name) {
    return '$name을(를) 삭제할까요?';
  }

  @override
  String get mqttExtra_removeBody => '연결을 끊고 설정, 비밀번호, 키, 대기 중인 패킷을 삭제합니다.';

  @override
  String mqttExtra_ownKey(String key) {
    return '자체 키로 로그인: $key…';
  }

  @override
  String get botWx_title => '기상 경보를 채널에 게시';

  @override
  String get botWx_body =>
      '10분마다 미국 국립기상청에서 무전기 GPS 위치(약 1km로 반올림)의 심각·극단 경보를 확인하고 새 경보를 한 번씩 게시합니다. 휴대폰 인터넷이 필요합니다.';

  @override
  String get botWx_channel => '게시할 채널';

  @override
  String get botWx_moderate => '중간 수준 경보 포함';

  @override
  String get botWx_moderateHint => '주의보와 경보 모두. 메시지가 늘어납니다.';

  @override
  String botWx_lastChecked(String time) {
    return '마지막 확인 $time.';
  }

  @override
  String get botWx_noPosition => '무전기가 아직 GPS 위치를 보고하지 않았습니다.';

  @override
  String get botWx_noChannel => '경보를 게시할 채널을 선택하세요.';

  @override
  String get botWx_channelGone => '선택한 채널이 더 이상 없습니다.';

  @override
  String botWx_httpError(String code) {
    return '기상 서비스가 $code로 응답했습니다.';
  }

  @override
  String get botWx_unreachable => '기상 서비스에 연결할 수 없습니다.';

  @override
  String get botCmd_sun => '무전기 GPS 위치의 일출과 일몰.';

  @override
  String get botCmd_moon => '달의 위상과 밝은 비율.';

  @override
  String get botCmd_weather =>
      '무전기 위치의 현재 날씨(Open-Meteo). 약 1km로 반올림한 위치를 보냅니다.';

  @override
  String get botCmd_dice => '주사위 굴리기: !dice, !dice 20, !dice 2d6.';

  @override
  String get botCmd_trace => '보낸 사람의 메시지가 거친 리피터를 보여 줍니다.';

  @override
  String get ping_title => '리피터 핑';

  @override
  String get ping_toolSubtitle => '근처 리피터와의 왕복 시간과 양방향 신호';

  @override
  String get ping_noRepeaters => '아직 알려진 리피터가 없습니다';

  @override
  String get ping_choose => '리피터 선택';

  @override
  String get ping_avgMs => 'ms 왕복';

  @override
  String get ping_snrThere => 'SNR 상대측';

  @override
  String get ping_snrBack => 'SNR 수신';

  @override
  String get ping_loss => '손실';

  @override
  String ping_running(int done, int total) {
    return '핑 $done/$total…';
  }

  @override
  String ping_start(int count) {
    return '$count회 핑';
  }

  @override
  String get ping_results => '프로브';

  @override
  String get ping_noReply => '응답 없음';

  @override
  String ping_resultLine(String ms, String snr) {
    return '$ms ms · 상대측 SNR $snr';
  }

  @override
  String get ping_explainer =>
      '각 프로브는 1홉 경로 추적입니다. 리피터가 수신 상태를 기록해 되돌려 보냅니다. 무전기가 직접 수신하는 리피터에서 작동합니다.';

  @override
  String get hunt_title => '안테나 헌트';

  @override
  String get hunt_toolSubtitle => '신호가 강할수록 빠르게 딸깍이는 큰 실시간 신호 계기';

  @override
  String get hunt_noSignal => '아직 신호 없음';

  @override
  String get hunt_noReply => '응답 없음 — 안테나를 옮기거나 돌려 보세요';

  @override
  String get hunt_heardHere => 'dB(이쪽 수신)';

  @override
  String get hunt_best => '최고';

  @override
  String get hunt_sound => '강해질수록 딸깍';

  @override
  String get hunt_soundHint => '딸깍할 때마다 진동하므로 화면을 보지 않고 방향을 맞출 수 있습니다.';

  @override
  String get hunt_stop => '중지';

  @override
  String get hunt_start => '헌트 시작';

  @override
  String get hunt_explainer =>
      '약 1초마다 리피터를 탐지합니다. 지향성 안테나를 돌리거나 걸어 다니세요. 숫자는 무전기가 얼마나 잘 수신하는지입니다.';

  @override
  String get settings_refreshRate => '무전기 새로고침 빈도';

  @override
  String get settings_refreshFast => '빠름';

  @override
  String get settings_refreshNormal => '보통';

  @override
  String get settings_refreshSlow => '느림';

  @override
  String get settings_refreshFastHint =>
      '배터리 1분마다, GPS 30초마다. 더 최신 값, 배터리 소모 증가.';

  @override
  String get settings_refreshNormalHint => '배터리 2분마다, GPS 1분마다.';

  @override
  String get settings_refreshSlowHint => '배터리 6분마다, GPS 3분마다. 배터리 절약.';

  @override
  String get settings_refreshSaverOn => '배터리 절약이 켜져 있어 그 주기를 따릅니다(배터리 10분마다).';

  @override
  String get reach_check => '관측자 도달 확인';

  @override
  String get reach_title => '관측자 도달';

  @override
  String get reach_noHash =>
      '아직 이 메시지를 조회할 수 없습니다. 어떤 리피터도 무전기로 되돌려 보내지 않아 패킷 ID를 모릅니다.';

  @override
  String get reach_unreachable =>
      '분석기에 연결할 수 없습니다. 인터넷 연결이나 설정의 분석기 주소를 확인하세요.';

  @override
  String get reach_none =>
      '아직 어떤 관측자도 듣지 못했습니다. 관측자는 수신 후 조금 뒤 업로드하므로 1분 뒤 다시 확인하세요.';

  @override
  String get reach_observers => '관측자';

  @override
  String get reach_maxHops => '최대 홉';

  @override
  String get reach_bestSnr => '최고 SNR';

  @override
  String reach_hops(int count) {
    return '$count홉 거리';
  }

  @override
  String get reach_explainer => '온라인 분석기 기준: 이 패킷을 듣고 업로드한 관측자.';

  @override
  String get reach_checkAgain => '다시 확인';

  @override
  String get analyzer_title => '온라인 분석기';

  @override
  String get analyzer_url => '분석기 주소';

  @override
  String get analyzer_urlHint => 'CoreScope 분석기(https://). 내 지역을 담당하는 것을 쓰세요.';

  @override
  String get analyzer_reset => '기본값';

  @override
  String get analyzer_hint => '어떤 관측자가 메시지를 들었는지 확인하는 데 씁니다. 패킷 ID만 보냅니다.';

  @override
  String get analyzer_hopLookup => '알 수 없는 리피터 이름 온라인 조회';

  @override
  String get analyzer_hopLookupHint =>
      '리피터 ID가 연락처에 없으면 분석기에 이름을 묻습니다. 짧은 ID만 보냅니다. 이름 끝의 “?”는 여러 리피터가 그 ID를 함께 쓴다는 뜻입니다.';

  @override
  String discovered_tray(int count) {
    return '근처에서 들린 채널: $count';
  }

  @override
  String get discovered_title => '근처에서 들림, 미참여';

  @override
  String discovered_heard(int count, String time) {
    return '$count회 들림 · 마지막 $time';
  }

  @override
  String get discovered_ignore => '무시';

  @override
  String get discovered_ignoreAll => '모두 무시';

  @override
  String get discovered_joinAll => '모두 참여';

  @override
  String get discovered_explainer =>
      '채널 디렉터리의 공개 채널 중 무전기가 트래픽을 들은 채널입니다. 각 채널은 키로 메시지를 복호화해 확인했습니다. 무시한 채널은 숨겨집니다.';

  @override
  String get mqtt_presetMeshRank => 'MeshRank(커뮤니티)';

  @override
  String get mqtt_presetMeshRankNote =>
      'MeshRank는 커뮤니티가 운영하는 MeshCore 네트워크 순위로, NOTORYX의 일부가 아니며 보증하지 않습니다. 로그인 없음: 공유를 켠 후에만 무전기 키와 지역 코드로 패킷이 공유됩니다.';

  @override
  String get pathFilter_title => '경로 폭 필터';

  @override
  String get pathFilter_firmwareNote =>
      '전달 규칙을 지원하는 리피터 펌웨어(mikecarper/MeshCore)가 필요합니다. 공식 MeshCore 펌웨어는 이 명령을 거부합니다.';

  @override
  String get pathFilter_width => '경로 폭';

  @override
  String get pathFilter_anyWidth => '모든 폭';

  @override
  String pathFilter_bytes(int n) {
    return '$n바이트 경로';
  }

  @override
  String get pathFilter_twoOrMore => '2 또는 3바이트(2+)';

  @override
  String get pathFilter_path => '적용 대상';

  @override
  String get pathFilter_radio => '무선 플러드';

  @override
  String get pathFilter_bridge => '브리지';

  @override
  String get pathFilter_cross => '크로스오버';

  @override
  String get pathFilter_bridgeCross => '브리지와 크로스오버';

  @override
  String get pathFilter_limit => '버리는 대신 제한';

  @override
  String get pathFilter_limitOn => '분당 정해진 수까지 전달합니다.';

  @override
  String get pathFilter_drop => '일치하는 플러드는 전달하지 않고 버립니다.';

  @override
  String get pathFilter_perMinute => '분당';

  @override
  String get pathFilter_rateInvalid => '1~65534를 입력하세요.';

  @override
  String get pathFilter_reviewNote =>
      '명령줄만 채웁니다. 확인한 뒤 보내기를 누르세요. 먼저 “get fr”로 기존 규칙을 확인하세요.';

  @override
  String get pathFilter_useCommand => '명령 사용';

  @override
  String get settings_linkPreviews => '링크 미리보기';

  @override
  String get settings_linkPreviewsHint =>
      '메시지 속 링크의 제목을 보여 줍니다. 기본값은 꺼짐: 페이지를 가져오면 그 사이트에 IP 주소가 알려집니다.';

  @override
  String get guide_title => '현장 가이드';

  @override
  String get guide_subtitle => '기본, 추운 날 배터리, 태양광, 안테나';

  @override
  String get guide_secMesh => '메시에 참여하기';

  @override
  String get guide_mesh1 =>
      '휴대폰은 블루투스·USB·Wi-Fi로 무전기와, 무전기는 LoRa로 메시와 통신합니다. 휴대폰 신호가 없어도 메시지가 됩니다.';

  @override
  String get guide_mesh2 => '리피터가 메시지를 전달하며, 한 번 중계가 1홉입니다. 홉이 적을수록 빠르고 확실합니다.';

  @override
  String get guide_mesh3 =>
      '메시지는 짧게, 붐비는 채널에 몰아 보내지 마세요. 모든 메시지가 공유 송신 시간을 씁니다.';

  @override
  String get guide_secCold => '추울 때 배터리';

  @override
  String get guide_cold1 => '영하(0 °C)에서 리튬 배터리를 충전하지 마세요. 영구 손상됩니다.';

  @override
  String get guide_cold2 => '무전기는 재킷 안에 넣으세요. 추위에 용량이 줄지만 배터리가 따뜻해지면 돌아옵니다.';

  @override
  String get guide_cold3 =>
      '추운 지역 고정 설치에는 리튬이온보다 LiFePO4가 낫습니다. 단열·가열 함은 둘 다에 도움이 됩니다.';

  @override
  String get guide_secSolar => '리피터용 태양광';

  @override
  String get guide_solar1 =>
      '리피터는 전력을 거의 쓰지 않지만, 패널과 배터리는 여름날이 아닌 가장 어두운 겨울 주에 맞추세요.';

  @override
  String get guide_solar2 => '패널은 적도 쪽을 향하게, 겨울에는 가파르게 기울이고 눈과 그늘을 피하세요.';

  @override
  String get guide_secAntenna => '안테나와 설치 위치';

  @override
  String get guide_ant1 => '출력보다 높이가 중요합니다. 몇 미터 높은 무전기가 책상 위보다 훨씬 멀리 닿습니다.';

  @override
  String get guide_ant2 => '안테나는 수직으로, 금속에서 떨어뜨리고 사용 대역용(예: 한국 920 MHz)을 쓰세요.';

  @override
  String get guide_secMore => '더 알아보기';

  @override
  String get guide_moreMeshcore => '공식 MeshCore 프로젝트';

  @override
  String get guide_moreCascadia => '커뮤니티 가이드: 시작하기, 워드라이빙, 지역, 태양광';

  @override
  String get post_signed => '서명됨';

  @override
  String get post_unverified => '미확인';

  @override
  String post_signedKnown(String name) {
    return '연락처의 $name 님이 서명했습니다.';
  }

  @override
  String get post_signedUnknownKey =>
      '서명은 있지만 연락처에 있는 사람이 아닙니다. 보낸 사람을 연락처에 추가하면 누구인지 알 수 있습니다.';

  @override
  String get post_unverifiedHint =>
      '이 게시물에 서명이 있었지만 일치하지 않습니다. 도중에 바뀌었거나 말한 사람이 보낸 것이 아닐 수 있습니다.';

  @override
  String get settings_signPosts => '모든 채널 게시물에 서명';

  @override
  String get settings_signPostsHint =>
      '채널의 SOS는 항상 서명됩니다. 이 설정은 모든 게시물에 서명해 다른 NOTORYX 사용자가 정말 본인임을 알 수 있게 합니다. 서명마다 패킷이 하나 더 전송됩니다.';

  @override
  String get tools_search => '도구 및 설정 검색';

  @override
  String get tools_noMatches => '검색과 일치하는 도구가 없습니다.';

  @override
  String get tools_bot => '봇 모드';

  @override
  String get tools_botHint => '채널 자동 응답, !명령, 기상 경보';

  @override
  String get botChannels_title => '채널';

  @override
  String get botChannels_hint =>
      '켠 채널에서도 봇이 해당 채널에서 !명령에 답합니다. 부재 응답은 보내지 않습니다.';

  @override
  String get botChannels_none => '이 무전기에 아직 채널이 없습니다.';

  @override
  String get advert_zeroHopHint => '직접 듣는 무전기에만 전달됩니다. 리피터는 전달하지 않습니다.';

  @override
  String get advert_floodHint => '리피터가 메시 전체로 전달합니다. 방송 시간을 더 씁니다.';

  @override
  String get radioPresets_custom => '사용자 지정';

  @override
  String get radioPresets_search => '프리셋 검색';

  @override
  String get radioPresets_suggested => '내 지역 추천';

  @override
  String get radioPresets_community => '커뮤니티 프리셋';

  @override
  String get radioPresets_hint =>
      'MeshCore 커뮤니티가 추천하는 프리셋입니다. 지역 메시에서 쓰는 것을 고르세요. 주파수·대역폭·SF·CR을 설정하며 송신 출력은 그대로입니다.';

  @override
  String get mySensors_title => '센서';

  @override
  String get mySensors_refresh => '센서 읽기';

  @override
  String get mySensors_reading => '무전기 센서를 읽는 중…';

  @override
  String get mySensors_failed => '무전기가 응답하지 않았습니다. 새로고침을 눌러 다시 시도하세요.';

  @override
  String get mySensors_none => '무전기의 센서 값이 없습니다.';

  @override
  String get activeChannels_title => '온라인 활성';

  @override
  String activeChannels_messages(int count) {
    return '메시지 $count개';
  }

  @override
  String activeChannels_source(String host) {
    return '$host 관측자가 들은, 사람들이 쓰는 채널입니다. 내 지역을 보려면 설정에서 분석기를 바꾸세요.';
  }

  @override
  String get fieldOps_checkInChannelLabel => '체크인도 보낼 채널';

  @override
  String get fieldOps_checkInChannelHint =>
      '무전기 키로 서명되어 채널의 다른 사람이 정말 당신임을 알 수 있습니다. 여행 연락처는 계속 직접 받습니다.';

  @override
  String get channels_regionUnknown => '지역 한정';

  @override
  String channels_regionSemantics(String region) {
    return '$region 지역으로 보냄';
  }

  @override
  String get channels_regionUnknownSemantics => '앱이 모르는 지역으로 보냄';

  @override
  String get wardrive_title => '워드라이브';

  @override
  String get wardrive_hint => '현재 위치에서 핑하고 어떤 리피터가 듣는지 지도에 표시';

  @override
  String get wardrive_start => '시작';

  @override
  String get wardrive_stop => '중지';

  @override
  String get wardrive_pings => '핑';

  @override
  String get wardrive_heard => '들림';

  @override
  String get wardrive_pinging => '핑 중…';

  @override
  String get wardrive_waitPosition => '휴대폰 또는 무전기의 GPS 위치를 기다리는 중입니다.';

  @override
  String get wardrive_waitRadio => '핑하려면 무전기를 연결하세요.';

  @override
  String get wardrive_history => '기록';

  @override
  String get wardrive_noSessions => '아직 기록이 없습니다.';

  @override
  String wardrive_sessionSummary(int pings, int heard) {
    return '핑 $pings회 · $heard회 들림';
  }

  @override
  String get wardrive_delete => '삭제';

  @override
  String get wardrive_recentre => '내 위치로 돌아가기';

  @override
  String get wardrive_youAreHere => '현재 위치';

  @override
  String get wardrive_backToLive => '현재 기록으로 돌아가기';

  @override
  String get wardrive_noReplies => '이 핑을 들은 리피터가 없습니다.';

  @override
  String wardrive_replyDetail(String there, String here) {
    return '당신을 $there dB로 들음 · 당신은 $here dB로 들음';
  }

  @override
  String get wardrive_explainer =>
      '각 핑은 제로홉 탐색 요청입니다. 직접 범위의 리피터만 응답하며 채널에는 아무것도 게시되지 않습니다. 위치는 휴대폰 GPS에서 가져오며, 없으면 무전기 GPS를 사용합니다.';

  @override
  String get mapTelemetry_policy =>
      '저장된 측정값은 1시간 후 흐리게 표시되고 24시간 후 사라집니다. 새로고침은 요청을 한 번 전송합니다. 노드에서 원격 측정을 허용해야 하며 센서는 로그인이 필요할 수 있습니다. 지도는 자동으로 업데이트를 요청하지 않습니다.';

  @override
  String get autoConnect_title => '내 무전기에 자동 연결';

  @override
  String get autoConnect_hint =>
      '앱을 열면 탭하지 않아도 마지막 무전기에 다시 연결합니다. 아직 범위 밖이면 몇 번 시도합니다.';

  @override
  String get ham_licensedOperator => '자격을 갖춘 운용자';

  @override
  String get ham_operatorIntro =>
      'NOTORYX Core Ham 무선기는 아마추어 무선 자격(FCC Part 97)으로 송신합니다. 보낸 내용은 누구나 읽을 수 있으며, 모든 프레임에는 무선기 이름 앞부분의 호출부호가 들어갑니다.';

  @override
  String get ham_yourStation => '내 무선국';

  @override
  String get ham_callSign => '호출부호';

  @override
  String get ham_notUsCallsign => '미국 호출부호가 아닙니다';

  @override
  String get ham_licenceClass => '자격 등급';

  @override
  String get ham_licenceClassHelper => '모든 등급이 33 cm와 70 cm를 모두 사용할 수 있습니다';

  @override
  String get ham_antennaSystem => '안테나 계통';

  @override
  String get ham_antennaSystemHint => '아래 출력 추정에 쓰입니다. 없는 항목은 0으로 두세요.';

  @override
  String get ham_externalAmpGain => '외부 증폭기 이득';

  @override
  String get ham_feedlineLoss => '급전선 손실';

  @override
  String get ham_antennaGain => '안테나 이득';

  @override
  String get ham_coordination => '조정';

  @override
  String get ham_coordinationNotice =>
      'NOTORYX Core Ham은 충분한 조정을 거친 뒤에만 사용하세요. 무선기와 중계기는 공유 대역에서 자동으로 송신합니다. 어떤 무선기든 전파를 내기 전에 주파수 조정 담당자와 상의하고, 지역 대역 계획을 따르며, 지역의 모든 운용자와 하나의 채널을 합의하세요.';

  @override
  String get ham_readCoordinationGuide => '조정 안내서 읽기';

  @override
  String get ham_acknowledgment => '이 자격을 갖고 있으며 조정 안내서를 읽었고, 송신하기 전에 조정하겠습니다.';

  @override
  String get ham_operatorSaved => '저장했습니다';

  @override
  String get ham_connectedRadio => '연결된 무선기';

  @override
  String get ham_nodeName => '노드 이름';

  @override
  String get ham_nodeNameOk => '내 호출부호로 시작합니다';

  @override
  String get ham_nodeNameBad => '호출부호로 시작해야 하며, 그렇지 않으면 무선기가 송신하지 않습니다';

  @override
  String ham_setNameTo(String callsign) {
    return '$callsign(으)로 설정';
  }

  @override
  String get ham_frequency => '주파수';

  @override
  String get ham_inHamBand => '아마추어 대역 안';

  @override
  String get ham_outsideHamBands => '420–450 / 902–928 MHz 범위 밖';

  @override
  String get ham_txPowerSetting => '송신 출력 설정';

  @override
  String get ham_chipSetting => '무선 칩의 설정값';

  @override
  String get ham_firmware => '펌웨어';

  @override
  String get ham_estimatedOutput => '추정 출력';

  @override
  String get ham_estimatedErp => '추정 ERP';

  @override
  String get ham_unknown => '알 수 없음';

  @override
  String get ham_unknownBoard => '알 수 없는 보드: 증폭기 없음으로 계산';

  @override
  String get ham_ampNone => '증폭기 없음';

  @override
  String ham_ampGain(String db) {
    return '증폭기로 약 +$db dB';
  }

  @override
  String get ham_ampVariable => '증폭기 레벨 설정에 따라 다름';

  @override
  String ham_boardNote(String board, String note) {
    return '$board: $note';
  }

  @override
  String ham_measureFirst(String board) {
    return '$board. 추정치에 의존하기 전에 측정하세요.';
  }

  @override
  String ham_outputNote(String board) {
    return '$board. 추정치입니다. 확실히 하려면 측정하고, 통신되는 최소 출력을 쓰세요.';
  }

  @override
  String get ham_overSpreadSpectrum =>
      '10 W PEP를 넘습니다. LoRa 같은 대역 확산의 한도입니다(§97.311). 낮추세요.';

  @override
  String get ham_erpNote =>
      '급전선 손실과 안테나 이득을 반영한 다이폴 기준 값입니다. 출력이 높으면 전자파 노출(§97.13)을 확인하세요.';

  @override
  String get ham_location => '위치';

  @override
  String get ham_noLocationLimits => '대역 제한 없음';

  @override
  String get ham_locationOkNote => '무선기 위치 기준입니다. 확실히 하려면 §97.303을 확인하세요.';

  @override
  String get ham_check => '확인 필요';

  @override
  String get ham_positionUnknown => '위치를 알 수 없습니다. 운용 장소의 제한은 §97.303을 확인하세요.';

  @override
  String get ham_exclusion33cm =>
      '이 지역은 §97.303(g) 제외 구역 안으로 보입니다. 여기서는 아마추어국이 33 cm로 송신할 수 없습니다.';

  @override
  String get ham_lineA =>
      '라인 A 북쪽(캐나다 국경 부근)이라면 420–430 MHz는 사용할 수 없습니다. §97.303을 확인하세요.';

  @override
  String get ham_statusOk => '정상';

  @override
  String get ham_needsAttention => '확인 필요';

  @override
  String get ham_setupBanner => '송신하기 전에 운용자 설정을 마치세요';

  @override
  String get ham_setUp => '설정';

  @override
  String get ham_operatorCardIncomplete => '호출부호를 설정하고 조정 안내서를 읽으세요';

  @override
  String get ham_nodeNameCallsignHelper =>
      '호출부호로 시작하세요(예: \"W1AW\", \"W1AW Base\")';

  @override
  String get ham_repeaterNameNeedsCall =>
      '이름은 중계기의 호출부호로 시작해야 합니다(예: \"N0RPT Hilltop\").';

  @override
  String get ham_repeaterPasswordsSerial =>
      '비밀번호는 중계기의 USB 시리얼 콘솔에서 설정하세요. 전파로 보내면 누구나 읽을 수 있습니다.';

  @override
  String get networks_title => '네트워크';

  @override
  String get networks_hint => '근처 네트워크를 찾아 기록';

  @override
  String get networks_yourNetwork => '내 네트워크';

  @override
  String get networks_scanTitle => '네트워크 찾기';

  @override
  String get networks_scanExplainer =>
      '무전기는 설정이 정확히 같은 네트워크만 들을 수 있어서, 스캔은 각 네트워크로 차례로 전환해 듣고 다시 원래대로 돌려놓습니다. 스캔 중에는 내 메시에서 벗어납니다.';

  @override
  String get networks_listenFor => '네트워크당 듣는 시간';

  @override
  String networks_choose(int count) {
    return '스캔할 네트워크: $count';
  }

  @override
  String get networks_suggested => '추천';

  @override
  String get networks_start => '스캔 시작';

  @override
  String get networks_cancel => '스캔 중지';

  @override
  String networks_listening(String name, int step, int steps) {
    return '$name 듣는 중 ($step/$steps)';
  }

  @override
  String get networks_blockNoRadio => '스캔하려면 무전기를 연결하세요.';

  @override
  String get networks_blockSettings => '무전기 설정을 기다리는 중입니다.';

  @override
  String get networks_blockSos => 'SOS 중에는 안 됩니다: 스캔하면 메시에서 벗어납니다.';

  @override
  String get networks_blockTrip => '여행 중에는 안 됩니다: 스캔하면 메시에서 벗어납니다.';

  @override
  String get networks_nearby => '근처 네트워크';

  @override
  String get networks_nothingYet => '아직 들린 네트워크가 없습니다. 스캔해 보세요.';

  @override
  String networks_heardSummary(int nodes, int packets, String snr) {
    return '노드 $nodes · 패킷 $packets · SNR $snr dB';
  }

  @override
  String networks_lastHeard(String time) {
    return '마지막 수신 $time';
  }

  @override
  String networks_timesHeard(int count) {
    return '수신 횟수: $count';
  }

  @override
  String get networks_saved => '저장한 네트워크';

  @override
  String get networks_noSaved => '저장한 네트워크가 없습니다.';

  @override
  String get networks_add => '네트워크 추가';

  @override
  String get networks_join => '참여';

  @override
  String networks_joinConfirm(String name) {
    return '무전기를 $name(으)로 바꿀까요? 현재 네트워크에서 나갑니다. 송신 출력은 그대로입니다.';
  }

  @override
  String networks_joined(String name) {
    return '무전기가 이제 $name에 있습니다.';
  }

  @override
  String get networks_log => '네트워크 기록';

  @override
  String get networks_logEmpty => '아직 기록이 없습니다.';

  @override
  String get networks_showMap => '지도';

  @override
  String get networks_exportCsv => 'CSV 내보내기';

  @override
  String get networks_exportGpx => 'GPX 내보내기';

  @override
  String get networks_clearLog => '기록 지우기';

  @override
  String get networks_clearLogConfirm => '기록된 네트워크를 모두 삭제할까요?';

  @override
  String get networks_name => '이름';

  @override
  String get networks_invalid => '설정을 확인하세요: MeshCore 무전기가 허용하는 범위를 벗어납니다.';

  @override
  String get networks_nodesHeard => '들린 노드';

  @override
  String get chat_resendNeedsRadio =>
      '보내지 않았습니다: 무전기를 연결한 뒤 다시 시도하세요. 메시지는 그대로 남아 있습니다.';

  @override
  String get quick_title => '빠른 메시지';

  @override
  String get quick_ok => '확인';

  @override
  String get quick_onMyWay => '가는 중';

  @override
  String get quick_atCamp => '캠프에 있음';

  @override
  String get quick_runningLate => '늦어요';

  @override
  String get quick_needHelp => '도움이 필요해요';

  @override
  String get quick_copyThat => '알겠습니다';

  @override
  String get quick_empty => '빠른 메시지가 없습니다. 편집을 눌러 추가하세요.';

  @override
  String get quick_add => '새 빠른 메시지';

  @override
  String get quick_reset => '기본값으로 재설정';

  @override
  String get chat_stopRetrying => '재시도 중지';

  @override
  String chat_addFirstBanner(String name) {
    return '$name님이 나를 연락처로 추가해야 내 다이렉트 메시지를 읽고 답할 수 있습니다. 아직이라면 내 광고를 보내거나 연락처를 공유하세요.';
  }

  @override
  String get map_goToMyPosition => '내 위치로 이동';

  @override
  String get map_positionUnavailable =>
      '위치를 사용할 수 없습니다. 위치 서비스를 켜거나 무전기 위치를 설정하세요.';

  @override
  String get contact_forgetAdvert => '마지막 광고 잊기';

  @override
  String get contact_forgetAdvertHint =>
      '이 노드의 시계가 초기화된 뒤 광고가 갱신되지 않으면, 마지막 광고 잊기로 다음 광고를 받아들입니다.';

  @override
  String get contact_forgetAdvertDone => '완료했습니다. 이 노드의 다음 광고를 받아들입니다.';

  @override
  String get networks_modeQuick => '빠르게';

  @override
  String get networks_modeThorough => '꼼꼼하게';

  @override
  String get networks_modeQuickHint =>
      '각 네트워크에 제로홉 핑을 한 번 보내고 몇 초간 듣습니다. 범위 안에 리피터가 있는 네트워크를 찾습니다.';

  @override
  String get networks_modeThoroughHint =>
      '듣기만 하며 네트워크마다 더 오래 듣습니다. 아무것도 보내지 않으며, 누군가 송신하면 리피터가 없는 네트워크도 찾습니다.';

  @override
  String networks_estimate(String time) {
    return '약 $time';
  }

  @override
  String discoveredContacts_selected(int count) {
    return '$count개 선택됨';
  }

  @override
  String get discoveredContacts_selectAll => '모두 선택';

  @override
  String get discoveredContacts_addSelected => '선택 항목 추가';

  @override
  String discoveredContacts_addAllShown(int count) {
    return '표시된 항목 모두 추가 ($count)';
  }

  @override
  String discoveredContacts_addManyTitle(int count) {
    return '연락처 $count개를 추가할까요?';
  }

  @override
  String discoveredContacts_roomLeft(int room) {
    return '무전기에 연락처를 $room개 더 추가할 수 있습니다.';
  }

  @override
  String discoveredContacts_roomLimit(int room, int count) {
    return '무전기에 $room개만 더 추가할 수 있어 $count개 중 처음 $room개만 추가됩니다.';
  }

  @override
  String discoveredContacts_adding(int done, int total) {
    return '$total개 중 $done개 추가 중…';
  }

  @override
  String discoveredContacts_addedMany(int count) {
    return '추가된 연락처: $count';
  }

  @override
  String discoveredContacts_addedSome(int added, int failed) {
    return '추가된 연락처: $added. 추가하지 못함: $failed.';
  }

  @override
  String get discoveredContacts_radioFull =>
      '무전기의 연락처 목록이 가득 찼습니다. 먼저 일부를 삭제하세요.';

  @override
  String get fieldIntel_radioNow => '지금 무전기';

  @override
  String get fieldIntel_noRadio => '실시간 값을 보려면 무전기를 연결하세요.';

  @override
  String get fieldIntel_noise => '노이즈 dBm';

  @override
  String get fieldIntel_lastSnr => '최근 SNR';

  @override
  String get fieldIntel_lastRssi => '최근 RSSI';

  @override
  String get fieldIntel_battery => '배터리 V';

  @override
  String fieldIntel_airtime(String sent, String received) {
    return '무전기 시작 후 송신 시간: 송신 $sent, 수신 $received';
  }

  @override
  String get fieldIntel_whoAround => '주변 노드';

  @override
  String get fieldIntel_m15 => '15분';

  @override
  String get fieldIntel_h1 => '1시간';

  @override
  String get fieldIntel_h24 => '24시간';

  @override
  String get fieldIntel_older => '이전';

  @override
  String get fieldIntel_lastHour => '최근 1시간';

  @override
  String get fieldIntel_chartHint =>
      '지난 하루 동안 각 노드가 마지막으로 들린 시간을 시간별로 보여 줍니다. 막대를 누르면 목록이 나옵니다.';

  @override
  String get fieldIntel_mix => '노드 종류';

  @override
  String get fieldIntel_reach => '도달 범위';

  @override
  String get fieldIntel_hops1 => '1홉';

  @override
  String get fieldIntel_hops2 => '2홉';

  @override
  String get fieldIntel_hops3 => '3홉 이상';

  @override
  String get fieldIntel_noRoute => '아직 경로 없음';

  @override
  String get fieldIntel_distance => '가장 가까운 / 먼 노드';

  @override
  String get fieldIntel_noneLocated => '위치가 있는 연락처가 없습니다.';

  @override
  String get fieldIntel_noPosition => '무전기에 아직 위치가 없어 거리를 계산할 수 없습니다.';

  @override
  String get fieldIntel_bestRepeaters => '직접 들리는 최고의 리피터';

  @override
  String get fieldIntel_noneDirect => '최근 30분 동안 직접 들린 리피터가 없습니다.';

  @override
  String get fieldIntel_attention => '확인 필요';

  @override
  String get fieldIntel_allGood => '확인이 필요한 항목이 없습니다.';

  @override
  String fieldIntel_lowBattery(String volts) {
    return '배터리 부족: $volts V';
  }

  @override
  String fieldIntel_quietFavorite(String ago) {
    return '즐겨찾기, $ago 이후로 들리지 않음';
  }

  @override
  String get fieldIntel_moreTools => '더 많은 도구';

  @override
  String fieldIntel_nodeCount(int count) {
    return '노드: $count';
  }

  @override
  String get fieldIntel_none => '노드가 없습니다.';

  @override
  String fieldIntel_lastHeard(String ago) {
    return '마지막 수신 $ago';
  }

  @override
  String get fieldIntel_showOnMap => '지도에서 보기';

  @override
  String get fieldIntel_openChat => '채팅 열기';

  @override
  String get repeaterTools_login => '로그인';

  @override
  String get repeaterTools_heardDirect => '직접 수신';

  @override
  String get repeaterTools_filterAll => '전체';

  @override
  String get repeaterTools_filterLowBattery => '배터리 부족';

  @override
  String get repeaterTools_hint =>
      '리피터를 누르면 세부 정보가 나오고, 거기서 로그인하면 상태, 이웃, 텔레메트리, 명령줄을 볼 수 있습니다.';

  @override
  String get repeaterTools_noneMatch => '해당하는 리피터가 없습니다.';

  @override
  String get repeaterTools_toolsTitle => '도구';

  @override
  String get repeaterTools_regionSetupHint => '내 지역의 리전 트리를 찾아 명령을 복사합니다';

  @override
  String get routes_failingOnly => '실패한 경로만';

  @override
  String get routes_contactDetails => '연락처 정보';

  @override
  String get links_contactTitle => '연락처를 추가할까요?';

  @override
  String get links_importAdvert => '이 연락처를 무전기에 추가할까요?';

  @override
  String get links_connectFirst => '먼저 무전기를 연결한 뒤 링크를 다시 여세요.';

  @override
  String get links_added => '연락처를 추가했습니다';

  @override
  String get links_notContact => '이 링크는 MeshCore 연락처가 아닙니다.';

  @override
  String get radioBuzzer_title => '무전기 부저';

  @override
  String get radioBuzzer_hint =>
      '새 메시지가 오면 무전기가 삐 소리를 냅니다. 부저가 있는 무전기에서만 표시됩니다.';

  @override
  String get radioBuzzer_failed => '무전기가 변경을 받아들이지 않았습니다. 다시 시도하세요.';

  @override
  String get appSettings_floodAttempts => '플러드 시도';

  @override
  String get appSettings_floodAttemptsSubtitle =>
      '직접 전송이 실패한 뒤 경로가 바뀌었을 경우를 대비해 플러드로 추가 전송합니다. 시도마다 송신 시간이 더 듭니다. 0이면 끕니다.';

  @override
  String get pathGraph_you => '나';

  @override
  String pathGraph_relayed(int count) {
    return '메시지 $count개 중계';
  }

  @override
  String get pathGraph_ambiguousNote => '이 짧은 ID는 여러 리피터와 일치해 하나로 특정할 수 없습니다.';

  @override
  String get pathGraph_comesFrom => '들어오는 곳';

  @override
  String get pathGraph_goesTo => '나가는 곳';

  @override
  String get pathGraph_repeaterDetails => '리피터 정보';

  @override
  String get pathGraph_days7 => '7일';

  @override
  String get pathGraph_empty =>
      '이 기간에는 아직 채널 메시지 경로가 없습니다. 경로는 메시지 추적이 켜져 있는 동안 받은 채널 메시지에서 수집됩니다.';

  @override
  String pathGraph_summary(int paths, int repeaters) {
    return '들린 경로 $paths · 리피터 $repeaters';
  }

  @override
  String get pathGraph_hashOnly => '각 홉은 해시 접두사로, 아는 리피터라면 이름으로 표시됩니다.';

  @override
  String pathGraph_matched(int count) {
    return '짧은 (1바이트) 홉 $count개를 더 긴 경로로 특정 리피터에 연결했습니다.';
  }

  @override
  String pathGraph_matchedAmbiguous(int matched, int ambiguous) {
    return '짧은 (1바이트) 홉 $matched개를 더 긴 경로로 특정 리피터에 연결했습니다 · $ambiguous개는 아직 모호합니다(? 표시).';
  }

  @override
  String get pathGraph_chartHint =>
      '왼쪽: 더 먼 리피터. 오른쪽: 나. 띠의 두께는 그 홉을 거친 메시지 수입니다. 상자를 누르면 해당 리피터를 봅니다.';

  @override
  String get pathGraph_busiest => '가장 바쁜 리피터';

  @override
  String pathGraph_chartSemantics(String name, int count) {
    return '경로 그래프. 가장 바쁜 리피터 $name, 메시지 $count개 중계.';
  }

  @override
  String diag_copied(String label) {
    return '복사됨: $label';
  }

  @override
  String get diag_noChannels => '이 무전기에는 채널이 없습니다.';

  @override
  String get diag_tapToCopy => '값을 누르면 복사됩니다. 아래로 당겨 새로 고칩니다.';

  @override
  String get diag_storage => '저장 공간';

  @override
  String diag_storageValue(int used, int total) {
    return '$used / $total KB';
  }

  @override
  String get favReturn_setting => '즐겨찾기 범위 복귀';

  @override
  String get favReturn_settingHint => '한동안 조용하던 즐겨찾기가 다시 들리면 알림';

  @override
  String get favReturn_off => '끄기';

  @override
  String favReturn_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count시간 후',
    );
    return '$_temp0';
  }

  @override
  String get favReturn_title => '범위 복귀';

  @override
  String favReturn_body(String name, int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours시간',
    );
    return '$name이(가) $_temp0 만에 다시 들립니다';
  }

  @override
  String get ham_heardFrom => '수신 출처';

  @override
  String get ham_lastHeard => '마지막 수신 프레임';

  @override
  String get ham_nothingHeardYet => '아직 없음';

  @override
  String get ham_readyToTransmit => '송신 준비 완료';

  @override
  String get ham_notReadyToTransmit => '송신하기 전에 아래 표시된 항목을 확인하세요';

  @override
  String get ham_bannerNameMismatch => '송신하기 전에 무선기 이름을 호출부호로 정하세요';

  @override
  String get ham_bannerOutOfBand => '무선기가 아마추어 대역 밖으로 설정되어 있습니다';

  @override
  String get a11y_showPassword => '비밀번호 표시';

  @override
  String get a11y_hidePassword => '비밀번호 숨기기';

  @override
  String get a11y_sendLocation => '내 위치 보내기';

  @override
  String get a11y_toggleFlash => '손전등';

  @override
  String get a11y_switchCamera => '카메라 전환';

  @override
  String get los_worst => '최악';

  @override
  String get los_selectedObstruction => '선택한 장애물';

  @override
  String get bastionHome_stationOk => '노드 이름과 대역이 정상입니다';

  @override
  String get bastionHome_stationConnectToCheck => '무선기를 연결해 이름과 대역을 확인하세요';

  @override
  String get theme_selected => '선택됨';

  @override
  String get theme_desc_blaze => '차콜 슬레이트와 고시인성 주황. 기본 테마.';

  @override
  String get theme_desc_neon_anarchy => '검정 바탕에 독성 초록과 전기 보라';

  @override
  String get theme_desc_tactical => '현장용 올리브, 건메탈, 흙빛 톤';

  @override
  String get theme_desc_pink_overload => '핫핑크, 버블검, 라벤더';

  @override
  String get theme_desc_bare_beauty => '따뜻한 누드, 더스티 로즈, 코코아, 세이지';

  @override
  String get theme_desc_okabe_ito => '색각 이상에 친화적, 청회색 바탕';

  @override
  String get theme_desc_night_ops => '어두운 곳에서 쓰는 은은한 빨강';

  @override
  String get theme_desc_seasonal => '계절을 따르거나 하나를 고르세요';

  @override
  String theme_seasonNow(String season) {
    return '지금: $season';
  }

  @override
  String get theme_season => '계절';

  @override
  String get theme_seasonAuto => '자동';

  @override
  String get season_spring => '봄';

  @override
  String get season_summer => '여름';

  @override
  String get season_autumn => '가을';

  @override
  String get season_winter => '겨울';

  @override
  String get season_halloween => '핼러윈';

  @override
  String get season_christmas => '크리스마스';

  @override
  String get season_valentine => '밸런타인데이';

  @override
  String get theme_holidays => '명절 색상';

  @override
  String get theme_holidaysHint => '계절이 자동일 때 핼러윈, 크리스마스, 밸런타인데이 색상 사용';

  @override
  String get rxLog_title => '수신 로그';

  @override
  String get rxLog_hint => '무전기가 듣는 모든 패킷을 실시간으로';

  @override
  String get rxLog_empty => '아직 패킷이 없습니다. 무전기가 듣는 패킷은 도착하는 대로 여기에 표시됩니다.';

  @override
  String get rxLog_note => '메모리에만 최근 2,000개를 보관합니다. 저장하거나 전송하지 않습니다.';

  @override
  String get rxLog_pause => '일시 정지';

  @override
  String get rxLog_resume => '재개';

  @override
  String get rxLog_export => 'CSV 내보내기';

  @override
  String get rxLog_clearConfirm => '수신 로그를 지울까요?';

  @override
  String rxLog_count(int shown, int total) {
    return '$shown개 표시 · $total개 수신';
  }

  @override
  String get rxLog_paused => '일시 정지됨: 새 패킷이 기록되지 않습니다';

  @override
  String get rxLog_kindAll => '전체';

  @override
  String get rxLog_kindAdvert => '광고';

  @override
  String get rxLog_kindChannel => '채널';

  @override
  String get rxLog_kindDirect => '직접';

  @override
  String get rxLog_kindAck => 'ACK';

  @override
  String get rxLog_kindPath => '경로';

  @override
  String get rxLog_kindTrace => '추적';

  @override
  String get rxLog_kindControl => '제어';

  @override
  String get rxLog_kindOther => '기타';

  @override
  String get rxLog_routeFlood => '플러드';

  @override
  String get rxLog_routeDirect => '직접 경로';

  @override
  String get rxLog_heardDirectly => '직접 수신';

  @override
  String rxLog_hops(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count홉',
    );
    return '$_temp0';
  }

  @override
  String rxLog_bytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count바이트',
    );
    return '$_temp0';
  }

  @override
  String get rxLog_own => '내 무전기';

  @override
  String rxLog_signal(String snr, int rssi) {
    return 'SNR $snr · $rssi dBm';
  }

  @override
  String get rxLog_signalTitle => '신호';

  @override
  String get rxLog_route => '라우팅';

  @override
  String get rxLog_path => '경로';

  @override
  String get rxLog_payloadType => '페이로드 유형';

  @override
  String get rxLog_hash => '패킷 해시';

  @override
  String get rxLog_raw => '원시 패킷';

  @override
  String get rxLog_copyHex => '16진수 복사';

  @override
  String get deliv_title => '전달 세부정보';

  @override
  String get deliv_note => '이 메시지에 저장된 정보로 계산했습니다.';

  @override
  String get deliv_queued => '대기열';

  @override
  String get deliv_sent => '무전기가 전송함';

  @override
  String get deliv_notSent => '무전기가 받지 않음';

  @override
  String get deliv_attempts => '시도';

  @override
  String deliv_attemptsValue(int made, int total) {
    return '$made / $total';
  }

  @override
  String deliv_plan(int direct, int flood) {
    return '계획: 직접 $direct회, 이후 플러드 $flood회';
  }

  @override
  String get deliv_lastRoute => '마지막 경로';

  @override
  String get deliv_routeFlood => '모든 중계기를 거치는 플러드';

  @override
  String get deliv_routeNeighbor => '직접, 중계기 없음';

  @override
  String deliv_routeVia(String path) {
    return '$path 경유 직접';
  }

  @override
  String get deliv_confirmed => '수신 확인됨';

  @override
  String deliv_tripTime(String seconds) {
    return '왕복 $seconds초';
  }

  @override
  String get deliv_waiting => '확인 대기 중';

  @override
  String get deliv_noConfirm => '확인 없음';

  @override
  String deliv_lastHeard(String name) {
    return '$name 마지막 수신';
  }

  @override
  String deliv_hoursAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours시간 전',
    );
    return '$_temp0';
  }

  @override
  String deliv_vDelivered(String name) {
    return '전달됨. $name이(가) 확인했습니다.';
  }

  @override
  String deliv_vDeliveredFlood(String name) {
    return '직접 시도가 실패한 뒤 플러드로 전달되었습니다. $name에 대한 저장된 경로가 오래되었을 수 있습니다.';
  }

  @override
  String deliv_vPending(int attempt, int total) {
    return '계속 시도 중: $total회 중 $attempt번째.';
  }

  @override
  String get deliv_vNotSent => '무전기가 이 메시지를 받지 않았습니다. 연결을 확인한 뒤 다시 시도하세요.';

  @override
  String deliv_vQuiet(String name, int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours시간',
    );
    return '확인 없음. $name이(가) $_temp0 동안 들리지 않아 범위 밖이거나 꺼져 있을 수 있습니다.';
  }

  @override
  String get deliv_vNoFlood =>
      '저장된 경로로 확인이 없고 플러드 시도가 꺼져 있습니다. 설정 → 앱 설정 → 메시지에서 켜거나 다시 시도하세요.';

  @override
  String get deliv_vNoAck =>
      '어느 경로로도 확인이 없습니다. 범위 밖이거나 확인 응답이 돌아오지 못했을 수 있습니다.';

  @override
  String get batteryOpt_title => '배터리 최적화';

  @override
  String get batteryOpt_off => 'NOTORYX Core Ham에 대해 꺼져 있어 백그라운드에서도 알림이 작동합니다.';

  @override
  String get batteryOpt_on =>
      '켜짐. Android가 백그라운드에서 앱을 중지할 수 있어 SOS, 체크인, 메시지 알림이 늦거나 누락될 수 있습니다.';

  @override
  String get batteryOpt_fix => '끄기';

  @override
  String block_sender(String name) {
    return '$name 차단';
  }

  @override
  String get block_confirmBody =>
      '이 사용자의 채널 메시지는 이 기기에서 숨겨지며 알림이 오지 않습니다. 상대방은 여전히 내 메시지를 볼 수 있습니다. 설정에서 차단을 해제할 수 있습니다.';

  @override
  String get block_action => '차단';

  @override
  String block_done(String name) {
    return '$name 차단됨';
  }

  @override
  String get mention_suggestions => '이름 제안';

  @override
  String get block_listTitle => '차단된 발신자';

  @override
  String get block_listHint => '이 이름들의 메시지는 채널에서 숨겨지며 알림이 오지 않습니다.';

  @override
  String get block_listEmpty => '차단된 사용자가 없습니다.';

  @override
  String get block_unblock => '차단 해제';

  @override
  String block_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count명 차단됨',
      zero: '차단 없음',
    );
    return '$_temp0';
  }

  @override
  String contactTable_nearlyFull(int percent) {
    return '무전기 연락처 목록 $percent% 사용 중';
  }

  @override
  String get contactTable_full => '무전기 연락처 목록이 가득 찼습니다';

  @override
  String contactTable_count(int used, int max) {
    return '연락처 $used/$max개';
  }

  @override
  String get contactTable_overwriteHint =>
      '가득 차면 무전기는 가장 오래전에 수신한 연락처를 교체합니다. 즐겨찾기는 유지됩니다.';

  @override
  String get contactTable_stopHint => '가득 차면 무전기는 새로 수신한 연락처를 더 이상 추가하지 않습니다.';

  @override
  String get contactTable_freeUp => '공간 확보';

  @override
  String get contactTable_sheetBody => '가장 오래전에 수신한 순서. 즐겨찾기는 표시되지 않습니다.';

  @override
  String contactTable_lastHeard(String when) {
    return '마지막 수신 $when';
  }

  @override
  String contactTable_remove(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '연락처 $count개 삭제',
    );
    return '$_temp0';
  }

  @override
  String get contactTable_confirmBody =>
      '무전기에서 삭제되며 이 기기의 메시지도 삭제됩니다. 되돌릴 수 없습니다.';

  @override
  String contactTable_removed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '연락처 $count개를 삭제했습니다',
    );
    return '$_temp0';
  }

  @override
  String get contactTable_noneToSuggest => '모든 연락처가 즐겨찾기라 제안할 항목이 없습니다.';

  @override
  String get adminWait_waiting => '응답 대기 중';

  @override
  String adminWait_retrying(int attempt, int total) {
    return '아직 응답이 없습니다. 다시 시도 중 ($attempt/$total)';
  }

  @override
  String adminWait_direct(int hops) {
    String _temp0 = intl.Intl.pluralLogic(
      hops,
      locale: localeName,
      other: '직접, $hops홉',
      zero: '직접',
    );
    return '$_temp0';
  }

  @override
  String adminWait_upTo(int seconds) {
    return '최대 $seconds초';
  }

  @override
  String get seasonal_holidays => '기념일 색상';

  @override
  String get coords_setting => '좌표 형식';

  @override
  String get coords_decimal => '십진 도';

  @override
  String get coords_dms => '도, 분, 초';

  @override
  String get coords_utm => 'UTM';

  @override
  String get coords_mgrs => 'MGRS';

  @override
  String get coords_copyTitle => '위치 복사';

  @override
  String coords_copied(String format) {
    return '$format(으)로 복사됨';
  }

  @override
  String pathHash_badge(int width) {
    return '경로가 $width바이트 경로 해시를 사용';
  }

  @override
  String pathHash_mismatch(int width) {
    return '내 무전기는 $width바이트 사용';
  }

  @override
  String ham_idMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '이름과 맞지 않는 국 식별 $count건',
    );
    return '$_temp0';
  }

  @override
  String get ham_idMismatchBody =>
      '직접 수신한 이 광고들은 이름 앞의 호출부호와 다른 국 식별을 달고 있었습니다. 무전기 설정이 잘못되었을 수 있으니, 믿기 전에 운용자에게 확인하세요.';

  @override
  String ham_idMismatchSentAs(String station) {
    return '국 식별 $station(으)로 전송';
  }

  @override
  String get ham_idMismatchNoCall => '이 이름은 호출부호로 시작하지 않습니다';
}
