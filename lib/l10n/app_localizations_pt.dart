// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'NOTORYX Core';

  @override
  String get nav_contacts => 'Contactos';

  @override
  String get nav_channels => 'Canais';

  @override
  String get nav_map => 'Mapa';

  @override
  String get nav_messages => 'Mensagens';

  @override
  String get nav_nodes => 'Nós';

  @override
  String get nav_radio => 'Rádio';

  @override
  String get messages_title => 'Mensagens';

  @override
  String get messages_filterAll => 'Todas';

  @override
  String get messages_filterDirect => 'Diretas';

  @override
  String get messages_filterChannels => 'Canais';

  @override
  String messages_filterWithUnread(String label, int count) {
    return '$label · $count';
  }

  @override
  String get messages_search => 'Pesquisar mensagens';

  @override
  String get messages_searchHint => 'Pesquisar conversas';

  @override
  String get messages_closeSearch => 'Fechar pesquisa';

  @override
  String get messages_manageChannels => 'Gerir canais';

  @override
  String get messages_new => 'Nova';

  @override
  String get messages_newDirect => 'Enviar mensagem a um nó';

  @override
  String get messages_newChannel => 'Adicionar ou entrar num canal';

  @override
  String get messages_empty => 'Ainda não há conversas';

  @override
  String get messages_emptyHint =>
      'As mensagens de nós e canais aparecem aqui.';

  @override
  String get messages_noMatches => 'Nenhuma conversa corresponde à pesquisa';

  @override
  String messages_you(String text) {
    return 'Você: $text';
  }

  @override
  String get messages_yesterday => 'Ontem';

  @override
  String messages_unreadCount(int count) {
    return '$count não lidas';
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
    return 'Bateria $percent%';
  }

  @override
  String get radioStatus_openRadio => 'Abrir detalhes do rádio';

  @override
  String get radioOverview_battery => 'Bateria';

  @override
  String radioOverview_firmware(String version) {
    return 'Firmware $version';
  }

  @override
  String get radioOverview_sendAdvert => 'Enviar anúncio';

  @override
  String get radioOverview_stats => 'Estatísticas do rádio';

  @override
  String get accessControl_title => 'Controle de acesso';

  @override
  String get accessControl_hubSubtitle => 'Quem pode entrar sem a senha';

  @override
  String get accessControl_explainRepeater =>
      'As pessoas desta lista entram sem senha. Os administradores podem alterar configurações; Só leitura e Leitura e escrita também recebem a telemetria completa.';

  @override
  String get accessControl_explainRoom =>
      'Os administradores desta lista entram sem senha e podem gerir a sala. Os membros da sala entram com a senha da sala.';

  @override
  String get accessControl_roleReadOnly => 'Só leitura';

  @override
  String get accessControl_roleReadWrite => 'Leitura e escrita';

  @override
  String get accessControl_roleAdmin => 'Administrador';

  @override
  String get accessControl_you => 'Você';

  @override
  String get accessControl_unknownNode => 'Nó desconhecido';

  @override
  String get accessControl_add => 'Adicionar';

  @override
  String get accessControl_addTitle => 'Adicionar à lista de acesso';

  @override
  String get accessControl_pickContact => 'Escolha um contacto';

  @override
  String get accessControl_noContacts =>
      'Não há contactos para adicionar. Os nós aparecem aqui depois de receber o anúncio deles.';

  @override
  String get accessControl_changeRole => 'Alterar função';

  @override
  String get accessControl_remove => 'Remover acesso';

  @override
  String accessControl_removeConfirm(String name) {
    return 'Remover $name da lista de acesso? Passará a precisar da senha para entrar.';
  }

  @override
  String get accessControl_removeSelfWarning =>
      'É você. Se se remover, precisará da senha de administrador para voltar a gerir este nó.';

  @override
  String get accessControl_unknownKeyNote =>
      'Não está nos seus contactos. Alterar a função exige firmware do nó mais recente; remover funciona sempre.';

  @override
  String get accessControl_prefixUnsupported =>
      'O firmware deste nó não consegue alterar a função de alguém que não está nos seus contactos. Pode na mesma removê-lo.';

  @override
  String get accessControl_empty => 'Ninguém está na lista de acesso';

  @override
  String get accessControl_emptyHint =>
      'Adicione pessoas para que possam entrar sem a senha.';

  @override
  String get accessControl_loading => 'A pedir ao nó a lista de acesso…';

  @override
  String get accessControl_timeout =>
      'O nó não respondeu. Verifique o caminho e tente novamente.';

  @override
  String get accessControl_maybeIncomplete =>
      'Este nó enviou uma página completa e o firmware não consegue enviar mais, por isso podem faltar entradas.';

  @override
  String get accessControl_saved => 'Lista de acesso atualizada';

  @override
  String accessControl_failed(String reply) {
    return 'O nó recusou a alteração: $reply';
  }

  @override
  String get companionCli_title => 'Linha de comandos';

  @override
  String get companionCli_tileSubtitle => 'Executar comandos no seu rádio';

  @override
  String get companionCli_warning =>
      'Os comandos correm no rádio conectado e podem alterar as configurações ou reiniciá-lo.';

  @override
  String get companionCli_hint => 'Escreva um comando, p. ex. ver';

  @override
  String get companionCli_send => 'Executar comando';

  @override
  String get companionCli_noReply =>
      'Sem resposta. O rádio pode estar a reiniciar.';

  @override
  String get companionCli_empty =>
      'Experimente um dos comandos acima ou escreva o seu.';

  @override
  String get wifi_title => 'Wi‑Fi';

  @override
  String get wifi_tileSubtitle => 'Conectar o rádio a uma rede Wi‑Fi';

  @override
  String get wifi_unsupported => 'O firmware deste rádio não inclui Wi‑Fi.';

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
  String get wifi_disconnected => 'Não conectado';

  @override
  String get wifi_network => 'Nome da rede (SSID)';

  @override
  String get wifi_password => 'Senha';

  @override
  String get wifi_passwordKeep => 'Deixe vazio para manter a senha atual';

  @override
  String get wifi_save => 'Salvar';

  @override
  String get wifi_forget => 'Esquecer rede';

  @override
  String get wifi_forgetConfirm => 'Remover do rádio a rede e a senha salvas?';

  @override
  String get wifi_rebootNeeded =>
      'Salvo. Reinicie o rádio para aplicar as alterações de Wi‑Fi.';

  @override
  String get wifi_rebootNow => 'Reiniciar rádio';

  @override
  String get wifi_rebootConfirm =>
      'Reiniciar o rádio agora? A app vai se desconectar e precisará reconectar.';

  @override
  String get wifi_loadFailed =>
      'Não foi possível ler as configurações Wi‑Fi do rádio.';

  @override
  String get wifi_retry => 'Tentar novamente';

  @override
  String wifi_saveFailed(String reply) {
    return 'O rádio não aceitou a alteração: $reply';
  }

  @override
  String get accessControl_refresh => 'Atualizar';

  @override
  String get common_cancel => 'Cancelar';

  @override
  String get common_ok => 'Tudo bem';

  @override
  String get common_connect => 'Conectar';

  @override
  String get common_unknownDevice => 'Dispositivo Desconhecido';

  @override
  String get common_save => 'Salvar';

  @override
  String get common_delete => 'Excluir';

  @override
  String get common_deleteAll => 'Excluir Tudo';

  @override
  String get common_close => 'Fechar';

  @override
  String get common_done => 'Done';

  @override
  String get common_edit => 'Editar';

  @override
  String get common_add => 'Adicionar';

  @override
  String get common_settings => 'Configurações';

  @override
  String get common_disconnect => 'Desconectar';

  @override
  String get common_connected => 'Conectado';

  @override
  String get common_disconnected => 'Desconectado';

  @override
  String get common_create => 'Criar';

  @override
  String get common_continue => 'Continuar';

  @override
  String get common_share => 'Compartilhar';

  @override
  String get common_copy => 'Copiar';

  @override
  String get common_retry => 'Tentar novamente';

  @override
  String get common_hide => 'Esconder';

  @override
  String get common_remove => 'Remover';

  @override
  String get common_enable => 'Ativar';

  @override
  String get common_disable => 'Desativar';

  @override
  String get common_undo => 'Desfazer';

  @override
  String get messageStatus_sent => 'Enviado';

  @override
  String get messageStatus_delivered => 'Entregue';

  @override
  String get messageStatus_pending => 'Enviar';

  @override
  String get messageStatus_failed => 'Falhou ao enviar';

  @override
  String get messageStatus_repeated => 'Ouvi repetidamente';

  @override
  String get urlImage_enable => 'Ativar imagens por URL';

  @override
  String get urlImage_possible =>
      'Possível imagem por URL; ative-a nas Configurações.';

  @override
  String get common_reboot => 'Reiniciar';

  @override
  String get common_loading => 'Carregando...';

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
  String get common_autoRefresh => 'Atualização automática';

  @override
  String get common_interval => 'Intervalo';

  @override
  String get scanner_title => 'MeshCore: Versão aberta';

  @override
  String get connectionChoiceUsbLabel => 'USB';

  @override
  String get connectionChoiceBluetoothLabel => 'Bluetooth';

  @override
  String get connectionChoiceTcpLabel => 'TCP';

  @override
  String get tcpScreenTitle => 'Estabelecer conexão via TCP';

  @override
  String get tcpHostLabel => 'Endereço IP';

  @override
  String get tcpHostHint => '192.168.40.10';

  @override
  String get tcpPortLabel => 'Porta';

  @override
  String get tcpPortHint => '5000';

  @override
  String get tcpStatus_notConnected => 'Insira o endereço final e conecte-se.';

  @override
  String tcpStatus_connectingTo(String endpoint) {
    return 'Conectando a $endpoint...';
  }

  @override
  String get tcpErrorHostRequired => 'É necessário fornecer um endereço IP.';

  @override
  String get tcpErrorPortInvalid =>
      'O valor do porto deve estar entre 1 e 65535.';

  @override
  String get tcpErrorUnsupported =>
      'O protocolo TCP não é suportado nesta plataforma.';

  @override
  String get tcpErrorTimedOut => 'A conexão TCP expirou.';

  @override
  String tcpConnectionFailed(String error) {
    return 'Falha na conexão TCP: $error';
  }

  @override
  String get usbScreenTitle => 'Conecte via USB';

  @override
  String get usbScreenSubtitle =>
      'Selecione um dispositivo serial detectado e conecte-o diretamente ao seu nó MeshCore.';

  @override
  String get usbScreenStatus => 'Selecione um dispositivo USB';

  @override
  String get usbScreenNote =>
      'A comunicação serial via USB está ativa em dispositivos Android e plataformas de desktop compatíveis.';

  @override
  String get usbScreenEmptyState =>
      'Nenhum dispositivo USB encontrado. Conecte um e atualize.';

  @override
  String get usbErrorPermissionDenied =>
      'A permissão para acesso via USB foi negada.';

  @override
  String get usbErrorDeviceMissing =>
      'O dispositivo USB selecionado não está mais disponível.';

  @override
  String get usbErrorInvalidPort => 'Selecione um dispositivo USB válido.';

  @override
  String get usbErrorBusy =>
      'Já existe uma solicitação de conexão USB em andamento.';

  @override
  String get usbErrorNotConnected => 'Não há nenhum dispositivo USB conectado.';

  @override
  String get usbErrorOpenFailed =>
      'Não foi possível abrir o dispositivo USB selecionado.';

  @override
  String get usbErrorConnectFailed =>
      'Não foi possível conectar ao dispositivo USB selecionado.';

  @override
  String get usbErrorUnsupported =>
      'A comunicação serial via USB não é suportada nesta plataforma.';

  @override
  String get usbErrorAlreadyActive => 'A conexão USB já está ativa.';

  @override
  String get usbErrorNoDeviceSelected =>
      'Nenhum dispositivo USB foi selecionado.';

  @override
  String get usbErrorPortClosed => 'A conexão USB não está ativa.';

  @override
  String get usbErrorConnectTimedOut =>
      'A conexão expirou. Verifique se o dispositivo possui o firmware USB Companion.';

  @override
  String get usbFallbackDeviceName => 'Dispositivo de Serial para a Web';

  @override
  String get usbStatus_notConnected => 'Selecione um dispositivo USB';

  @override
  String get usbStatus_connecting => 'Conectando ao dispositivo USB...';

  @override
  String get usbStatus_searching => 'Procurando por dispositivos USB...';

  @override
  String usbConnectionFailed(String error) {
    return 'Falha na conexão USB: $error';
  }

  @override
  String get scanner_scanning => 'Procurando por dispositivos...';

  @override
  String get scanner_connecting => 'Conectando...';

  @override
  String get scanner_disconnecting => 'Desconectando...';

  @override
  String get scanner_notConnected => 'Não está conectado';

  @override
  String scanner_connectedTo(String deviceName) {
    return 'Conectado a $deviceName';
  }

  @override
  String get scanner_searchingDevices => 'Procurando dispositivos MeshCore...';

  @override
  String get scanner_tapToScan =>
      'Toque em \"Escanear\" para encontrar dispositivos MeshCore';

  @override
  String scanner_connectionFailed(String error) {
    return 'Falha na conexão: $error';
  }

  @override
  String get scanner_stop => 'Pare';

  @override
  String get scanner_scan => 'Digitalizar';

  @override
  String get scanner_bluetoothOff => 'Bluetooth está desativado';

  @override
  String get scanner_bluetoothOffMessage =>
      'Por favor, ative o Bluetooth para escanear por dispositivos.';

  @override
  String get scanner_chromeRequired => 'Navegador Chrome necessário';

  @override
  String get scanner_chromeRequiredMessage =>
      'Esta aplicação web requer o Google Chrome ou um navegador baseado no Chromium para suporte de Bluetooth.';

  @override
  String get scanner_enableBluetooth => 'Ative o Bluetooth';

  @override
  String get scanner_bluetoothWebUnsupported =>
      'A funcionalidade Bluetooth não está disponível no navegador. Conecte-se via USB em vez disso.';

  @override
  String get device_quickSwitch => 'Mudar rapidamente';

  @override
  String get device_meshcore => 'MeshCore';

  @override
  String get settings_title => 'Configurações';

  @override
  String get settings_deviceInfo => 'Informações do Dispositivo';

  @override
  String get settings_appSettings => 'Configurações do App';

  @override
  String get settings_appSettingsSubtitle =>
      'Notificações, mensagens e preferências de mapa';

  @override
  String get settings_nodeSettings => 'Configurações do Nó';

  @override
  String get settings_nodeName => 'Nome do Nó';

  @override
  String get settings_nodeNameNotSet => 'Não definido';

  @override
  String get settings_nodeNameHint => 'Insira o nome do nó';

  @override
  String get settings_nodeNameUpdated => 'Nome atualizado';

  @override
  String get settings_radioSettings => 'Configurações de Rádio';

  @override
  String get settings_radioSettingsSubtitle =>
      'Frequência, potência, fator de espalhamento';

  @override
  String get settings_radioSettingsUpdated =>
      'Configurações de rádio atualizadas';

  @override
  String get settings_regionSettings => 'Regiões';

  @override
  String get settings_regionSettingsSubtitle => 'Gerenciar regiões armazenadas';

  @override
  String get settings_corridorRegion => 'Região do corredor';

  @override
  String get settings_corridorRegionDefault => '#corridor (predefinida)';

  @override
  String get settings_corridorRegionHelp =>
      'Os pacotes de corredor de flood são marcados com esta região. Repetidores sem firmware de corredor só os reencaminham se permitirem esta região. Deixe vazio para a etiqueta predefinida #corridor.';

  @override
  String get settings_corridorRegionHint => 'Nome da região';

  @override
  String get settings_corridorRegionUseDefault => 'Usar predefinida';

  @override
  String get settings_corridorRegionUpdated => 'Região do corredor atualizada';

  @override
  String get settings_corridorRegionFailed =>
      'Não foi possível atualizar a região do corredor';

  @override
  String get settings_regionManagement_screenTitle => 'Gestão de Região';

  @override
  String get settings_regionNameHint => 'Nome da região';

  @override
  String get settings_regionAddRegion => 'Adicionar região';

  @override
  String get settings_regionFetchRegions =>
      'Regiões de obtenção a partir de repetidores';

  @override
  String get settings_regionFetchRegionsFail => 'Nenhuma região foi encontrada';

  @override
  String get settings_regionFetchRegionsAlreadyExists =>
      'Esta região já foi adicionada';

  @override
  String get settings_regionName => 'Nome da Região';

  @override
  String get settings_regionDeleted => 'Região excluída';

  @override
  String get settings_deleteRegion => 'Excluir Região';

  @override
  String settings_deleteRegionConfirm(String region) {
    return 'Remover \"$region\" da lista de regiões?';
  }

  @override
  String get settings_location => 'Localização';

  @override
  String get settings_locationSubtitle => 'Coordenadas GPS';

  @override
  String get settings_locationUpdated => 'Localização atualizada';

  @override
  String get settings_locationBothRequired =>
      'Insira a latitude e a longitude.';

  @override
  String get settings_locationInvalid => 'Latitude ou longitude inválidos.';

  @override
  String get settings_locationGPSEnable => 'Ativar GPS';

  @override
  String get settings_locationGPSEnableSubtitle =>
      'Habilita a atualização automática da localização via GPS.';

  @override
  String get settings_locationIntervalSec => 'Intervalo para GPS (Segundos)';

  @override
  String get settings_locationIntervalInvalid =>
      'O intervalo deve ser de pelo menos 60 segundos e inferior a 86400 segundos.';

  @override
  String get settings_latitude => 'Latitude';

  @override
  String get settings_longitude => 'Longitude';

  @override
  String get settings_contactSettings => 'Configurações de Contato';

  @override
  String get settings_contactSettingsSubtitle =>
      'Configurações para como os contatos são adicionados';

  @override
  String get settings_privacyMode => 'Modo de Privacidade';

  @override
  String get settings_privacyModeSubtitle =>
      'Esconder nome/localização em anúncios';

  @override
  String get settings_privacyModeToggle =>
      'Ative o modo de privacidade para ocultar seu nome e localização em anúncios.';

  @override
  String get settings_privacyModeEnabled => 'Modo de privacidade ativado';

  @override
  String get settings_privacyModeDisabled => 'Modo de privacidade desativado';

  @override
  String get settings_privacy => 'Configurações de Privacidade';

  @override
  String get settings_privacySubtitle => 'Controle o que é compartilhado.';

  @override
  String get settings_privacySettingsDescription =>
      'Escolha quais informações o seu dispositivo compartilha com os outros.';

  @override
  String get settings_denyAll => 'Negar todos';

  @override
  String get settings_allowByContact => 'Permitir por bandeiras de contato';

  @override
  String get settings_allowAll => 'Permitir todos';

  @override
  String get settings_telemetryBaseMode => 'Modo Base de Telemetria';

  @override
  String get settings_telemetryLocationMode =>
      'Modo de Localização de Telemetria';

  @override
  String get settings_telemetryEnvironmentMode =>
      'Modo de Ambiente de Telemetria';

  @override
  String get settings_advertLocation => 'Localização do Anúncio';

  @override
  String get settings_advertLocationSubtitle =>
      'Incluir localização no anúncio';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdate =>
      'Anúncio zero-hop automático na atualização do GPS';

  @override
  String get settings_autoZeroHopAdvertOnGpsUpdateSubtitle =>
      'Quando a localização GPS mudar, enviar um anúncio zero-hop (requer localização no anúncio).';

  @override
  String get settings_multiAck => 'Multi-ACKs';

  @override
  String get settings_telemetryModeUpdated => 'Modo de telemetria atualizado';

  @override
  String get settings_actions => 'Ações';

  @override
  String get settings_deleteAllPaths => 'Delete All Paths';

  @override
  String get settings_deleteAllPathsSubtitle =>
      'Clear all path data from contacts.';

  @override
  String get settings_sendAdvertisement => 'Enviar Publicidade';

  @override
  String get settings_sendAdvertisementSubtitle =>
      'Presença de transmissão agora';

  @override
  String get settings_advertisementSent => 'Anúncio enviado';

  @override
  String get settings_syncTime => 'Tempo de Sincronização';

  @override
  String get settings_syncTimeSubtitle =>
      'Definir o relógio do dispositivo para o horário do telefone';

  @override
  String get settings_timeSynchronized => 'Sincronizado com o tempo';

  @override
  String get settings_refreshContacts => 'Atualizar Contatos';

  @override
  String get settings_refreshContactsSubtitle =>
      'Recarregar a lista de contatos do dispositivo';

  @override
  String get settings_rebootDevice => 'Reiniciar Dispositivo';

  @override
  String get settings_rebootDeviceSubtitle =>
      'Reiniciar o dispositivo MeshCore';

  @override
  String get settings_rebootDeviceConfirm =>
      'Tem certeza de que deseja reiniciar o dispositivo? Você será desconectado.';

  @override
  String get settings_debug => 'Depurar';

  @override
  String get settings_companionDebugLog => 'Registro de depuração auxiliar';

  @override
  String get settings_companionDebugLogSubtitle =>
      'Comandos, respostas e dados brutos para protocolos BLE/TCP/USB';

  @override
  String get settings_appDebugLog => 'Log de Depuração do Aplicativo';

  @override
  String get settings_appDebugLogSubtitle =>
      'Mensagens de depuração do aplicativo';

  @override
  String get settings_about => 'Sobre';

  @override
  String settings_aboutVersion(String version) {
    return 'NOTORYX Core v$version';
  }

  @override
  String get settings_aboutLegalese => 'Projeto MeshCore de Código Aberto 2024';

  @override
  String get settings_aboutDescription =>
      'Um cliente Flutter de código aberto para dispositivos de rede mesh LoRa Core da MeshCore.';

  @override
  String get settings_aboutOpenMeteoAttribution =>
      'Dados de elevação LOS: Open-Meteo (CC BY 4.0)';

  @override
  String get settings_infoName => 'Nome';

  @override
  String get settings_infoId => 'ID';

  @override
  String get settings_infoStatus => 'Estado';

  @override
  String get settings_infoBattery => 'Bateria';

  @override
  String get settings_infoPublicKey => 'Chave Pública';

  @override
  String get settings_infoContactsCount => 'Número de Contatos';

  @override
  String get settings_infoChannelCount => 'Número do Canal';

  @override
  String get settings_infoHardware => 'Hardware';

  @override
  String get settings_infoFirmware => 'Firmware';

  @override
  String get settings_presets => 'Configurações pré-definidas';

  @override
  String get settings_frequency => 'Frequência (MHz)';

  @override
  String get settings_frequencyHelper => '300,0 - 2500,0';

  @override
  String get settings_frequencyInvalid => 'Frequência inválida (300-2500 MHz)';

  @override
  String get settings_bandwidth => 'Largura de banda';

  @override
  String get settings_spreadingFactor => 'Fator de Dispersão';

  @override
  String get settings_codingRate => 'Taxa de Codificação';

  @override
  String get settings_txPower => 'TX Potência (dBm)';

  @override
  String get settings_txPowerHelper => '0 - 22';

  @override
  String get settings_txPowerInvalid => 'Potência de TX inválida (0-22 dBm)';

  @override
  String get settings_clientRepeat => 'Repetição sem rede';

  @override
  String get settings_clientRepeatSubtitle =>
      'Permita que este dispositivo repita pacotes de rede para outros dispositivos.';

  @override
  String get settings_clientRepeatFreqWarning =>
      'A repetição fora da rede requer frequências de 433, 869 ou 918 MHz.';

  @override
  String settings_error(String message) {
    return 'Erro: $message';
  }

  @override
  String get appSettings_title => 'Configurações do App';

  @override
  String get appSettings_appearance => 'Aparência';

  @override
  String get appSettings_theme => 'Tema';

  @override
  String get appSettings_themeSystem => 'Padrão do sistema';

  @override
  String get appSettings_themeLight => 'Luz';

  @override
  String get appSettings_themeDark => 'Escuro';

  @override
  String get appSettings_language => 'Idioma';

  @override
  String get appSettings_languageSystem => 'Padrão do sistema';

  @override
  String get appSettings_languageEn => 'Inglês';

  @override
  String get appSettings_languageFr => 'Francês';

  @override
  String get appSettings_languageEs => 'Espanhol';

  @override
  String get appSettings_languageDe => 'Alemão';

  @override
  String get appSettings_languagePl => 'Polonês';

  @override
  String get appSettings_languageSl => 'Esloveno';

  @override
  String get appSettings_languagePt => 'Português';

  @override
  String get appSettings_languageIt => 'Italiano';

  @override
  String get appSettings_languageZh => 'Chinês';

  @override
  String get appSettings_languageSv => 'Sueco';

  @override
  String get appSettings_languageNl => 'Holandês';

  @override
  String get appSettings_languageSk => 'Esloveno';

  @override
  String get appSettings_languageBg => 'Búlgaro';

  @override
  String get appSettings_languageRu => 'Russo';

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
      'Ativar rastreamento de mensagens';

  @override
  String get appSettings_enableMessageTracingSubtitle =>
      'Mostrar metadados detalhados de roteamento e tempo para as mensagens';

  @override
  String get appSettings_notifications => 'Notificações';

  @override
  String get appSettings_enableNotifications => 'Ativar Notificações';

  @override
  String get appSettings_enableNotificationsSubtitle =>
      'Receber notificações para mensagens e anúncios';

  @override
  String get appSettings_notificationPermissionDenied =>
      'Permissão de notificação negada';

  @override
  String get appSettings_notificationsEnabled => 'Notificações ativadas';

  @override
  String get appSettings_notificationsDisabled => 'Notificações desativadas';

  @override
  String get appSettings_messageNotifications => 'Notificações de Mensagem';

  @override
  String get appSettings_messageNotificationsSubtitle =>
      'Mostrar notificação ao receber novas mensagens';

  @override
  String get appSettings_channelMessageNotifications =>
      'Notificações de Mensagens do Canal';

  @override
  String get appSettings_channelMessageNotificationsSubtitle =>
      'Mostrar notificação ao receber mensagens do canal';

  @override
  String get appSettings_advertisementNotifications =>
      'Notificações de Anúncios';

  @override
  String get appSettings_advertisementNotificationsSubtitle =>
      'Mostrar notificação quando novos nós forem descobertos';

  @override
  String get appSettings_messaging => 'Mensagens';

  @override
  String get appSettings_clearPathOnMaxRetry =>
      'Limpar Caminho em Tentativas Máximas';

  @override
  String get appSettings_clearPathOnMaxRetrySubtitle =>
      'Redefinir o caminho de contato após 5 tentativas de envio falhas';

  @override
  String get appSettings_pathsWillBeCleared =>
      'Os caminhos serão limpos após 5 tentativas falhas.';

  @override
  String get appSettings_pathsWillNotBeCleared =>
      'Os caminhos não serão limpos automaticamente.';

  @override
  String get appSettings_autoRouteRotation => 'Rotação de Rota Automática';

  @override
  String get appSettings_autoRouteRotationSubtitle =>
      'Alternar entre os melhores caminhos e o modo inundação';

  @override
  String get appSettings_autoRouteRotationEnabled =>
      'Rotação de roteamento automático habilitada';

  @override
  String get appSettings_autoRouteRotationDisabled =>
      'Rotação de roteamento automático desativada';

  @override
  String get appSettings_maxRouteWeight => 'Peso Máximo da Rota';

  @override
  String get appSettings_maxRouteWeightSubtitle =>
      'Peso máximo que um determinado percurso pode acumular com entregas bem-sucedidas.';

  @override
  String get appSettings_initialRouteWeight => 'Peso Inicial da Rota';

  @override
  String get appSettings_initialRouteWeightSubtitle =>
      'Peso inicial para novos caminhos descobertos';

  @override
  String get appSettings_routeWeightSuccessIncrement =>
      'Aumento do peso para indicar sucesso';

  @override
  String get appSettings_routeWeightSuccessIncrementSubtitle =>
      'Peso adicionado a um caminho após a entrega bem-sucedida.';

  @override
  String get appSettings_routeWeightFailureDecrement =>
      'Redução do peso da falha';

  @override
  String get appSettings_routeWeightFailureDecrementSubtitle =>
      'Peso removido de um caminho após uma tentativa de entrega malsucedida.';

  @override
  String get appSettings_maxMessageRetries =>
      'Número máximo de tentativas de envio de mensagens';

  @override
  String get appSettings_maxMessageRetriesSubtitle =>
      'Número de tentativas de reenvio antes de classificar uma mensagem como falha.';

  @override
  String get appSettings_battery => 'Bateria';

  @override
  String get appSettings_batteryChemistry => 'Química da Bateria';

  @override
  String appSettings_batteryChemistryPerDevice(String deviceName) {
    return 'Definir por dispositivo ($deviceName)';
  }

  @override
  String get appSettings_batteryChemistryConnectFirst =>
      'Conecte-se a um dispositivo para escolher';

  @override
  String get appSettings_batteryNmc => '18650 NMC (3,0-4,2V)';

  @override
  String get appSettings_batteryLifepo4 => 'LiFePO4 (2,6-3,65V)';

  @override
  String get appSettings_batteryLipo => 'LiPo (3,0-4,2V)';

  @override
  String get appSettings_batteryLipoHv => 'LiPo HV (3,0-4,35V)';

  @override
  String get appSettings_mapDisplay => 'Exibição do Mapa';

  @override
  String get appSettings_showRepeaters => 'Mostrar Repetidores';

  @override
  String get appSettings_showRepeatersSubtitle =>
      'Exibir nós de repetidor no mapa';

  @override
  String get appSettings_showChatNodes => 'Mostrar Nós de Chat';

  @override
  String get appSettings_showChatNodesSubtitle => 'Exibir nós de chat no mapa';

  @override
  String get appSettings_showOtherNodes => 'Mostrar Outros Nós';

  @override
  String get appSettings_showOtherNodesSubtitle =>
      'Exibir outros tipos de nó no mapa';

  @override
  String get appSettings_timeFilter => 'Filtro de Tempo';

  @override
  String get appSettings_timeFilterShowAll => 'Mostrar todos os nós';

  @override
  String appSettings_timeFilterShowLast(int hours) {
    return 'Mostrar nós das últimas $hours horas';
  }

  @override
  String get appSettings_mapTimeFilter => 'Filtro de Tempo do Mapa';

  @override
  String get appSettings_showNodesDiscoveredWithin =>
      'Mostrar nós descobertos dentro de:';

  @override
  String get appSettings_allTime => 'Todos os tempos';

  @override
  String get appSettings_lastHour => 'Última hora';

  @override
  String get appSettings_last6Hours => 'Últimos 6 horas';

  @override
  String get appSettings_last24Hours => 'Últimas 24 horas';

  @override
  String get appSettings_lastWeek => 'Da última semana';

  @override
  String get appSettings_rasterTileSource => 'Fonte de blocos raster';

  @override
  String get appSettings_stadiaEndpoint => 'Endpoint da Stadia';

  @override
  String get appSettings_stadiaApiKey => 'Chave da API Stadia';

  @override
  String get appSettings_stadiaApiKeyRequired =>
      'Obrigatório para usar o Stadia Maps';

  @override
  String appSettings_stadiaApiKeyConfigured(String maskedKey) {
    return 'Configurado: $maskedKey';
  }

  @override
  String get appSettings_stadiaApiKeyDialogDescription =>
      'Insira sua chave da API Stadia Maps. O aplicativo a usa para solicitações de blocos raster.';

  @override
  String get appSettings_offlineMapCache => 'Cache de Mapa Offline';

  @override
  String get appSettings_unitsTitle => 'Unidades';

  @override
  String get appSettings_unitsMetric => 'Métrico (m/km/°C)';

  @override
  String get appSettings_unitsImperial => 'Imperial (ft/mi/°F)';

  @override
  String get appSettings_noAreaSelected => 'Nenhuma área selecionada';

  @override
  String appSettings_areaSelectedZoom(int minZoom, int maxZoom) {
    return 'Área selecionada (zoom $minZoom-$maxZoom)';
  }

  @override
  String get appSettings_debugCard => 'Depurar';

  @override
  String get appSettings_appDebugLogging =>
      'Rastreamento de Depuração do Aplicativo';

  @override
  String get appSettings_appDebugLoggingSubtitle =>
      'Registrar mensagens de depuração do aplicativo Log para solucionar problemas';

  @override
  String get appSettings_appDebugLoggingEnabled =>
      'Log de depuração do aplicativo habilitado';

  @override
  String get appSettings_appDebugLoggingDisabled =>
      'O registro de depuração do aplicativo está desativado.';

  @override
  String get contacts_title => 'Contactos';

  @override
  String get contacts_noContacts => 'Ainda não existem contatos.';

  @override
  String get contacts_contactsWillAppear =>
      'Os contatos serão exibidos quando os dispositivos anunciarem.';

  @override
  String get contacts_unread => 'Não lido';

  @override
  String get contacts_searchContactsNoNumber => 'Pesquisar Contatos...';

  @override
  String contacts_searchContacts(int number, String str) {
    return 'Pesquisar contatos...';
  }

  @override
  String contacts_searchFavorites(int number, String str) {
    return 'Pesquisar $number$str Favoritos...';
  }

  @override
  String contacts_searchUsers(int number, String str) {
    return 'Pesquisar $number$str Usuários...';
  }

  @override
  String contacts_searchRepeaters(int number, String str) {
    return 'Pesquisar $number$str Repetidores...';
  }

  @override
  String contacts_searchRoomServers(int number, String str) {
    return 'Pesquisar $number$str servidores de sala...';
  }

  @override
  String get contacts_noUnreadContacts => 'Sem contatos não lidos.';

  @override
  String get contacts_noContactsFound =>
      'Não foram encontrados contatos ou grupos.';

  @override
  String get contacts_deleteContact => 'Excluir Contato';

  @override
  String contacts_removeConfirm(String contactName) {
    return 'Remover $contactName dos contatos?';
  }

  @override
  String get contacts_manageRepeater => 'Gerenciar Repetidor';

  @override
  String get contacts_manageRoom => 'Gerenciar Servidor de Sala';

  @override
  String get contacts_roomLogin => 'Login no Quarto';

  @override
  String get contacts_openChat => 'Abrir Chat';

  @override
  String get contacts_editGroup => 'Editar Grupo';

  @override
  String get contacts_deleteGroup => 'Excluir Grupo';

  @override
  String contacts_deleteGroupConfirm(String groupName) {
    return 'Remover $groupName?';
  }

  @override
  String get contacts_newGroup => 'Novo Grupo';

  @override
  String get contacts_moreOptions => 'Mais opções';

  @override
  String get contacts_searchOpen => 'Pesquisar contatos';

  @override
  String get contacts_searchClose => 'Pesquisa avançada';

  @override
  String get contacts_groupName => 'Nome do grupo';

  @override
  String get contacts_groupNameRequired => 'O nome do grupo é obrigatório.';

  @override
  String get contacts_groupNameReserved => 'Este nome de grupo está reservado';

  @override
  String contacts_groupAlreadyExists(String name) {
    return 'O grupo \"$name\" já existe';
  }

  @override
  String get contacts_filterContacts => 'Filtrar contatos...';

  @override
  String get contacts_noContactsMatchFilter =>
      'Não existem contatos que correspondam ao seu filtro';

  @override
  String get contacts_noMembers => 'Nenhum membro';

  @override
  String get contacts_lastSeenNow => 'Última vez que foi visto agora';

  @override
  String contacts_lastSeenMinsAgo(int minutes) {
    return 'Última vez que foi visto $minutes minutos atrás';
  }

  @override
  String get contacts_lastSeenHourAgo => 'Última vez que foi visto há 1 hora.';

  @override
  String contacts_lastSeenHoursAgo(int hours) {
    return 'Última vez visto $hours horas atrás';
  }

  @override
  String get contacts_lastSeenDayAgo => 'Última vez que foi visto 1 dia atrás';

  @override
  String contacts_lastSeenDaysAgo(int days) {
    return 'Última vez visto $days dias atrás';
  }

  @override
  String get contact_info => 'Informações de Contato';

  @override
  String get contact_settings => 'Configurações de Contato';

  @override
  String get contact_telemetry => 'Telemetria';

  @override
  String get contact_lastSeen => 'Visto pela última vez';

  @override
  String get contact_clearChat => 'Limpar Chat';

  @override
  String get contact_teleBase => 'Base de Telemetria';

  @override
  String get contact_teleBaseSubtitle =>
      'Permitir compartilhamento do nível da bateria e telemetria básica';

  @override
  String get contact_teleLoc => 'Localização de Telemetria';

  @override
  String get contact_teleLocSubtitle =>
      'Permitir compartilhamento de dados de localização';

  @override
  String get contact_teleEnv => 'Ambiente de Telemetria';

  @override
  String get contact_teleEnvSubtitle =>
      'Permitir compartilhamento de dados do sensor de ambiente';

  @override
  String get channels_title => 'Canais';

  @override
  String get channels_noChannelsConfigured => 'Nenhuma canalização configurada';

  @override
  String get channels_addPublicChannel => 'Adicionar Canal Público';

  @override
  String get channels_searchChannels => 'Pesquisar canais...';

  @override
  String get channels_noChannelsFound => 'Nenhum canal encontrado';

  @override
  String channels_channelIndex(int index) {
    return 'Canal $index';
  }

  @override
  String get channels_public => 'Público';

  @override
  String channels_via(String path) {
    return 'via $path';
  }

  @override
  String get channels_viaMqtt => 'via MQTT';

  @override
  String get channels_viaMqttSemantics =>
      'Recebida via MQTT, não ouvida pelo seu rádio';

  @override
  String get channels_private => 'Privado';

  @override
  String get channels_editChannel => 'Editar canal';

  @override
  String get channels_muteChannel => 'Silenciar canal';

  @override
  String get channels_unmuteChannel => 'Ativar canal';

  @override
  String get channels_deleteChannel => 'Excluir canal';

  @override
  String channels_deleteChannelConfirm(String name) {
    return 'Excluir \"$name\"? Não pode ser desfeito.';
  }

  @override
  String channels_channelDeleteFailed(String name) {
    return 'Falha ao excluir o canal \"$name\"';
  }

  @override
  String channels_channelDeleted(String name) {
    return 'Canal \"$name\" excluído';
  }

  @override
  String get channels_addChannel => 'Adicionar Canal';

  @override
  String get channels_channelIndexLabel => 'Índice do Canal';

  @override
  String get channels_channelName => 'Nome do Canal';

  @override
  String get channels_usePublicChannel => 'Usar Canal Público';

  @override
  String get channels_standardPublicPsk => 'PSK público padrão';

  @override
  String get channels_pskHex => 'PSK (Hex)';

  @override
  String get channels_generateRandomPsk => 'Gerar PSK aleatório';

  @override
  String get channels_enterChannelName => 'Por favor, insira um nome de canal';

  @override
  String get channels_pskMustBe32Hex =>
      'O PSK deve ter 32 caracteres hexadecimais.';

  @override
  String channels_channelAdded(String name) {
    return 'Canal \"$name\" adicionado';
  }

  @override
  String channels_editChannelTitle(int index) {
    return 'Editar Canal $index';
  }

  @override
  String get channels_smazCompression => 'Compressão SMAZ';

  @override
  String get channels_cyr2latCompression => 'Compressão Cyr2Lat';

  @override
  String get channels_cyr2latCompressionDscr =>
      'Substitui alguns caracteres cirílicos por caracteres latinos ao enviar.';

  @override
  String get channels_cyr2latSettingsHeading => 'Configuração do Cyr2Lat';

  @override
  String get channels_cyr2latSettingsSubheading => 'Lista de substituições';

  @override
  String get channels_cyr2latSettingsDscr =>
      'Editar a configuração JSON de substituição de caracteres';

  @override
  String get channels_cyr2latSettingsDialogHint => 'Mapa de substituições JSON';

  @override
  String channels_cyr2latSettingsDialogWrongJSON(Object error) {
    return 'JSON incorreto: $error';
  }

  @override
  String channels_channelUpdated(String name) {
    return 'Canal \"$name\" atualizado';
  }

  @override
  String get settings_cyr2latProfileAdd => 'Adicionar perfil Cyr2Lat';

  @override
  String get settings_cyr2latProfileName => 'Nome do perfil';

  @override
  String get settings_cyr2latProfileNameEmpty =>
      'O nome do perfil não pode estar vazio';

  @override
  String get settings_cyr2latProfileAdded => 'Perfil adicionado com sucesso';

  @override
  String get settings_cyr2latProfileUpdated => 'Perfil atualizado com sucesso';

  @override
  String get settings_cyr2latProfileEdit => 'Editar perfil Cyr2Lat';

  @override
  String get settings_cyr2latProfileDelete => 'Eliminar perfil Cyr2Lat';

  @override
  String get settings_cyr2latProfileDeleted => 'Perfil eliminado com sucesso';

  @override
  String settings_cyr2latProfileDeleteDscr(String name) {
    return 'Tem a certeza de que deseja eliminar o perfil \"$name\"?';
  }

  @override
  String get channels_publicChannelAdded => 'Canal público adicionado';

  @override
  String get channels_sortBy => 'Ordenar por';

  @override
  String get channels_sortManual => 'Manual';

  @override
  String get channels_sortAZ => 'De A a Z';

  @override
  String get channels_sortLatestMessages => 'Últimas mensagens';

  @override
  String get channels_sortUnread => 'Não lido';

  @override
  String get channels_createPrivateChannel => 'Criar um Canal Privado';

  @override
  String get channels_createPrivateChannelDesc =>
      'Protegido com uma chave secreta.';

  @override
  String get channels_joinPrivateChannel => 'Junte-se a um Canal Privado';

  @override
  String get channels_joinPrivateChannelDesc =>
      'Inserir uma chave secreta manualmente.';

  @override
  String get channels_joinPublicChannel => 'Junte-se ao Canal Público';

  @override
  String get channels_joinPublicChannelDesc =>
      'Qualquer pessoa pode entrar neste canal.';

  @override
  String get channels_joinHashtagChannel => 'Junte-se a um Canal com Hashtag';

  @override
  String get channels_joinHashtagChannelDesc =>
      'Qualquer pessoa pode participar de canais com hashtag.';

  @override
  String get channels_scanQrCode => 'Digitalizar um Código QR';

  @override
  String get channels_scanQrCodeComingSoon => 'Em breve';

  @override
  String get channels_enterHashtag => 'Insira hashtag';

  @override
  String get channels_hashtagHint => 'ex. #equipe';

  @override
  String channels_regionSetTo(String region) {
    return 'Região: $region';
  }

  @override
  String get channels_regionNotSet => 'Região: nenhuma';

  @override
  String get channels_regionSelect_Title => 'Escolha uma região';

  @override
  String get channels_clearRegion => 'Região desimpedida';

  @override
  String get chat_noMessages => 'Ainda não existem mensagens.';

  @override
  String get chat_sendMessage => 'Enviar mensagem';

  @override
  String chat_sendMessageTo(String contactName) {
    return 'Enviar uma mensagem para $contactName';
  }

  @override
  String get chat_sendMessageToStart => 'Enviar uma mensagem para começar';

  @override
  String get chat_originalMessageNotFound => 'Mensagem original não encontrada';

  @override
  String chat_replyingTo(String name) {
    return 'Responder a $name';
  }

  @override
  String chat_replyTo(String name) {
    return 'Responder a $name';
  }

  @override
  String get chat_location => 'Localização';

  @override
  String get chat_typeMessage => 'Digite uma mensagem...';

  @override
  String chat_messageTooLong(int maxBytes) {
    return 'Mensagem muito longa (máximo $maxBytes bytes).';
  }

  @override
  String get chat_messageCopied => 'Mensagem copiada';

  @override
  String get chat_messageDeleted => 'Mensagem excluída';

  @override
  String get chat_retryingMessage => 'Tentando novamente';

  @override
  String chat_retryCount(int current, int max) {
    return 'Tentar $current/$max';
  }

  @override
  String get chat_selectSendAction => 'Selecionar ação de envio';

  @override
  String get chat_sendGif => 'Enviar GIF';

  @override
  String get chat_limitToArea => 'Limitar a uma área';

  @override
  String get chat_limitToAreaTitle => 'Enviar só dentro de…';

  @override
  String get chat_limitToAreaHelp =>
      'Os repetidores com firmware de corredor de flood só retransmitem a mensagem dentro desta área. Os outros repetidores descartam-na, a menos que permitam a sua região de corredor.';

  @override
  String chat_limitToAreaRadius(int km) {
    return '$km km à sua volta';
  }

  @override
  String chat_limitToAreaActive(int km) {
    return 'Só num raio de $km km';
  }

  @override
  String get chat_limitToAreaOff => 'Sem limite';

  @override
  String get chat_limitToAreaNeedsPosition =>
      'Defina a posição do rádio para limitar mensagens a uma área.';

  @override
  String get chat_sendImageLora => 'Enviar imagem via MeshCore';

  @override
  String get chat_imagePickFailed => 'Não consegui abrir essa imagem';

  @override
  String get chat_receivedGif => 'Recebi um GIF';

  @override
  String get chat_reply => 'Responder';

  @override
  String get chat_addReaction => 'Adicionar Reação';

  @override
  String get chat_me => 'Eu';

  @override
  String get reaction_report => 'Reações com emoji';

  @override
  String get emojiCategorySmileys => 'Emojis';

  @override
  String get emojiCategoryGestures => 'Gestos';

  @override
  String get emojiCategoryHearts => 'Corações';

  @override
  String get emojiCategoryObjects => 'Objetos';

  @override
  String get gifPicker_title => 'Escolher um GIF';

  @override
  String get gifPicker_searchHint => 'Pesquisar GIFs...';

  @override
  String get gifPicker_poweredBy => 'Desenvolvido por GIPHY';

  @override
  String get gifPicker_noGifsFound => 'Nenhum GIF encontrado';

  @override
  String get gifPicker_failedLoad => 'Não foi possível carregar os GIFs';

  @override
  String get gifPicker_failedSearch => 'Falha na pesquisa de GIFs';

  @override
  String get gifPicker_noInternet => 'Sem conexão com a internet';

  @override
  String get debugLog_appTitle => 'Log de Depuração do Aplicativo';

  @override
  String get debugLog_bleTitle => 'Log de Depuração BLE';

  @override
  String get debugLog_copyLog => 'Copiar log';

  @override
  String get debugLog_clearLog => 'Limpar log';

  @override
  String get debugLog_copied => 'Log de depuração copiado';

  @override
  String get debugLog_bleCopied => 'Log BLE copiado';

  @override
  String get debugLog_noEntries => 'Ainda não existem logs de depuração.';

  @override
  String get debugLog_enableInSettings =>
      'Ativar o log de depuração do aplicativo nas configurações';

  @override
  String get debugLog_frames => 'Estruturas';

  @override
  String get debugLog_rawLogRx => 'Log Raw-RX';

  @override
  String get debugLog_noBleActivity => 'Ainda não há atividade BLE.';

  @override
  String debugFrame_length(int count) {
    return 'Comprimento do Quadro: $count bytes';
  }

  @override
  String debugFrame_command(String value) {
    return 'Comando: 0x$value';
  }

  @override
  String get debugFrame_textMessageHeader => 'Mensagem de Texto:';

  @override
  String debugFrame_destinationPubKey(String pubKey) {
    return '- Destino PubKey: $pubKey';
  }

  @override
  String debugFrame_timestamp(int timestamp) {
    return '- Carimbo: $timestamp';
  }

  @override
  String debugFrame_flags(String value) {
    return '- Bandeiras: 0x$value';
  }

  @override
  String debugFrame_textType(int type, String label) {
    return '- Tipo de Texto: $type ($label)';
  }

  @override
  String get debugFrame_textTypeCli => 'Interface de Linha de Comando';

  @override
  String get debugFrame_textTypePlain => 'Simples';

  @override
  String debugFrame_text(String text) {
    return '- Texto: \"$text\"';
  }

  @override
  String get debugFrame_hexDump => 'Espaço Hexadecimal:';

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
  String get chat_removePath => 'Remover caminho';

  @override
  String get chat_noPathHistoryYet =>
      'Ainda não há histórico de caminhos.\nEnvie uma mensagem para descobrir caminhos.';

  @override
  String get chat_pathCleared =>
      'Caminho limpo. A próxima mensagem redescobrirá a rota.';

  @override
  String get chat_fullPath => 'Caminho Completo';

  @override
  String get routing_title => 'Rotas';

  @override
  String get routing_modeAuto => 'Carro';

  @override
  String get routing_modeFlood => 'Inundação';

  @override
  String get routing_modeManual => 'Manual';

  @override
  String get routing_modeAutoHint =>
      'Seleciona automaticamente o caminho mais conhecido, e, se nenhum caminho conhecido for encontrado, utiliza a estratégia de \"inundação\".';

  @override
  String get routing_modeFloodHint =>
      'Transmissão através de todos os repetidores. É a opção mais confiável, mas utiliza mais tempo de transmissão.';

  @override
  String get routing_modeManualHint =>
      'Sempre segue exatamente o caminho que você define.';

  @override
  String get routing_currentRoute => 'Rota atual';

  @override
  String get routing_directNoHops => 'Direto – sem saltos de repetidor';

  @override
  String get routing_noPathYet =>
      'Ainda não há um caminho definido. A mensagem continua a ser enviada até que uma rota seja encontrada.';

  @override
  String get routing_floodBroadcast =>
      'Transmissão através de todos os repetidores';

  @override
  String get routing_editPath => 'Editar caminho';

  @override
  String get routing_forgetPath => 'Esqueça o caminho';

  @override
  String get routing_knownPaths => 'Rotas conhecidas';

  @override
  String get routing_knownPathsHint =>
      'Toque em um caminho para alternar para ele.';

  @override
  String get routing_inUse => 'Em uso';

  @override
  String get routing_qualityStrong => 'Primeiro salto notável';

  @override
  String get routing_qualityGood => 'Primeiro salto bem-sucedido';

  @override
  String get routing_qualityFair => 'Primeira etapa bem-sucedida';

  @override
  String get routing_qualityWorked => 'Foi entregue';

  @override
  String get routing_qualityFlood =>
      'Informação obtida através de relatos generalizados.';

  @override
  String get routing_qualityUntested => 'Não testado';

  @override
  String routing_lastWorked(String when) {
    return 'worked $when';
  }

  @override
  String get routing_neverWorked => 'nunca confirmado';

  @override
  String routing_deliveryCounts(int successes, int failures) {
    return '$successes delivered, $failures failed';
  }

  @override
  String get routing_floodDelivery =>
      'Entrega em áreas afetadas por inundações';

  @override
  String get pathEditor_title => 'Criar Caminho';

  @override
  String pathEditor_hopCounter(int count) {
    return '$count de 64 gramas de lúpulo';
  }

  @override
  String get pathEditor_noHops =>
      'Ainda não há lúpulos adicionados. Clique nos repetidores abaixo para adicioná-los na ordem desejada, ou salve sem adicionar lúpulos para enviar diretamente.';

  @override
  String get pathEditor_addHops => 'Adicione os lúpulos na seguinte ordem.';

  @override
  String get pathEditor_searchRepeaters => 'Encontrar repetidores';

  @override
  String get pathEditor_advancedHex => 'Avançado: caminho hexadecimal bruto';

  @override
  String get pathEditor_hexLabel => 'Prefixos hexadecimais';

  @override
  String get pathEditor_hexHelper =>
      'Dois caracteres hexadecimais por salto, separados por vírgulas.';

  @override
  String pathEditor_invalidTokens(String tokens) {
    return 'Inválido: $tokens';
  }

  @override
  String get pathEditor_tooManyHops => 'Máximo de 64 saltos';

  @override
  String get pathEditor_usePath => 'Utilize este caminho.';

  @override
  String get pathEditor_removeHop => 'Remova o lúpulo';

  @override
  String get pathEditor_unknownHop => 'Repetidor desconhecido';

  @override
  String get chat_pathSavedLocally =>
      'Salvo localmente. Conectar para sincronizar.';

  @override
  String get chat_pathDeviceConfirmed => 'Dispositivo confirmado.';

  @override
  String get chat_pathDeviceNotConfirmed => 'Dispositivo ainda não confirmado.';

  @override
  String get chat_type => 'Digite';

  @override
  String get chat_path => 'Caminho';

  @override
  String get chat_publicKey => 'Chave Pública';

  @override
  String get chat_compressOutgoingMessages => 'Comprimir mensagens enviadas';

  @override
  String get chat_floodForced => 'Inundação (forçada)';

  @override
  String get chat_directForced => 'Direto (forçado)';

  @override
  String chat_hopsForced(int count) {
    return '$count saltos (forçado)';
  }

  @override
  String get chat_floodAuto => 'Inundação (automática)';

  @override
  String get chat_direct => 'Salvar';

  @override
  String get chat_poiShared => 'Ponto de Interesse Compartilhado';

  @override
  String chat_unread(int count) {
    return 'Não lido: $count';
  }

  @override
  String get chat_markAsUnread => 'Marcar como não lido';

  @override
  String get chat_newMessages => 'Novas mensagens';

  @override
  String get chat_openLink => 'Abrir link?';

  @override
  String get chat_openLinkConfirmation =>
      'Deseja abrir este link no seu navegador?';

  @override
  String get chat_open => 'Abrir';

  @override
  String chat_couldNotOpenLink(String url) {
    return 'Não foi possível abrir o link: $url';
  }

  @override
  String get chat_invalidLink => 'Formato de link inválido';

  @override
  String get map_title => 'Mapa de Nós';

  @override
  String get map_searchHint => 'Pesquisar por nome ou ID do nó';

  @override
  String get map_activity => 'Atividade';

  @override
  String get map_online => 'Online';

  @override
  String get map_recent => 'Recente';

  @override
  String get map_stale => 'Vencido';

  @override
  String get map_visible => 'Visível';

  @override
  String get map_hidden => 'Escondido';

  @override
  String get map_centerOnNode => 'Centralizar no nó';

  @override
  String get map_details => 'Detalhes';

  @override
  String get map_noGps => 'Sem GPS';

  @override
  String get map_noResults => 'Nenhum nó encontrado';

  @override
  String get map_lineOfSight => 'Linha de visão';

  @override
  String get map_losScreenTitle => 'Linha de visão';

  @override
  String get map_noNodesWithLocation =>
      'Não existem nós com dados de localização.';

  @override
  String get map_nodesNeedGps =>
      'Os nós precisam partilhar as suas coordenadas GPS\npara aparecerem no mapa';

  @override
  String map_nodesCount(int count) {
    return 'Nós: $count';
  }

  @override
  String map_pinsCount(int count) {
    return 'Pinos: $count';
  }

  @override
  String get map_chat => 'Chat';

  @override
  String get map_repeater => 'Repetidor';

  @override
  String get map_room => 'Quarto';

  @override
  String get map_sensor => 'Sensor';

  @override
  String get map_pinDm => 'Gatilho (DM)';

  @override
  String get map_pinPrivate => 'Bloquear (Privado)';

  @override
  String get map_pinPublic => 'Pin (Público)';

  @override
  String get map_lastSeen => 'Última Visão';

  @override
  String get map_disconnectConfirm =>
      'Tem certeza de que deseja desconectar deste dispositivo?';

  @override
  String get map_from => 'De';

  @override
  String get map_source => 'Fonte';

  @override
  String get map_flags => 'Bandeiras';

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
  String get map_shareMarkerHere => 'Compartilhar marcador aqui';

  @override
  String get map_setAsMyLocation => 'Defina minha localização';

  @override
  String get floodCorridor_title => 'Corredor de flood';

  @override
  String get floodCorridor_previewToHere =>
      'Pré-visualizar corredor de flood até aqui';

  @override
  String get floodCorridor_requesting => 'A pedir um corredor ao seu rádio…';

  @override
  String get floodCorridor_unsupported =>
      'O firmware do seu rádio não suporta corredores de flood.';

  @override
  String get floodCorridor_noProposal =>
      'O seu rádio não conseguiu propor um corredor. Confirme que tem uma posição definida.';

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
    return '$inside de $total repetidores conhecidos lá dentro';
  }

  @override
  String get floodCorridor_straightLine =>
      'Linha reta: nenhum repetidor conhecido pelo caminho';

  @override
  String get floodCorridor_followsRepeaters =>
      'Segue os seus repetidores conhecidos';

  @override
  String get floodCorridor_horizonLimited =>
      'Os repetidores conhecidos não chegam ao destino; o resto é uma linha reta';

  @override
  String get floodCorridor_thinStretch =>
      'Parte do corredor tem poucos repetidores conhecidos';

  @override
  String get floodCorridor_moreCoverage =>
      'Exigir mais cobertura de repetidores';

  @override
  String get floodCorridor_previewNote =>
      'Só pré-visualização. Repetidores sem firmware de corredor não aplicam corredores.';

  @override
  String get map_pinLabel => 'Rótulo de marcador';

  @override
  String get map_label => 'Rótulo';

  @override
  String get map_pointOfInterest => 'Ponto de interesse';

  @override
  String get map_sendToContact => 'Enviar para o contato';

  @override
  String get map_sendToChannel => 'Enviar para o canal';

  @override
  String get map_noChannelsAvailable => 'Não existem canais disponíveis.';

  @override
  String get map_publicLocationShare => 'Compartilhar local público';

  @override
  String map_publicLocationShareConfirm(String channelLabel) {
    return 'Você está prestes a compartilhar uma localização em $channelLabel. Este canal é público e qualquer pessoa com a PSK pode visualizá-lo.';
  }

  @override
  String get map_connectToShareMarkers =>
      'Conecte-se a um dispositivo para compartilhar marcadores';

  @override
  String get map_filterNodes => 'Filtrar Nós';

  @override
  String get map_nodeTypes => 'Tipos de Nó';

  @override
  String get map_chatNodes => 'Nós de Chat';

  @override
  String get map_repeaters => 'Repetidores';

  @override
  String get map_otherNodes => 'Outros Nós';

  @override
  String get map_showOverlaps => 'Sobreposições da Chave Repeater';

  @override
  String get map_keyPrefix => 'Prefixo Chave';

  @override
  String get map_filterByKeyPrefix => 'Filtrar por prefixo-chave';

  @override
  String get map_publicKeyPrefix => 'Prefixo de chave pública';

  @override
  String get map_markers => 'Marcadores';

  @override
  String get map_showSharedMarkers => 'Mostrar marcadores compartilhados';

  @override
  String get map_showGuessedLocations =>
      'Mostrar as localizações dos nós estimados';

  @override
  String get map_showDiscoveryContacts => 'Mostrar Contatos de Descoberta';

  @override
  String get map_guessedLocation => 'Localização estimada';

  @override
  String get map_lastSeenTime => 'Último Tempo de Visualização';

  @override
  String get map_sharedPin => 'Pin compartilhado';

  @override
  String get map_sharedAt => 'Compartilhado';

  @override
  String get map_joinRoom => 'Junte-se à Sala';

  @override
  String get map_manageRepeater => 'Gerenciar Repetidor';

  @override
  String get map_tapToAdd => 'Toque nos nós para adicioná-los ao caminho.';

  @override
  String get map_runTrace => 'Executar Traçado de Caminho';

  @override
  String get map_runTraceWithReturnPath => 'Retornar ao mesmo caminho.';

  @override
  String get map_removeLast => 'Remover Último';

  @override
  String get map_pathTraceCancelled => 'Rastreamento de caminho cancelado.';

  @override
  String get mapCache_title => 'Cache de Mapa Offline';

  @override
  String get mapCache_selectAreaFirst =>
      'Selecione uma área para armazenar em cache primeiro';

  @override
  String get mapCache_noTilesToDownload =>
      'Não há tiles para baixar para esta área.';

  @override
  String get mapCache_downloadTilesTitle => 'Baixar tiles';

  @override
  String mapCache_downloadTilesPrompt(int count) {
    return 'Baixar $count tiles para uso offline?';
  }

  @override
  String get mapCache_downloadAction => 'Baixar';

  @override
  String mapCache_cachedTiles(int count) {
    return 'Armazenados $count azulejos';
  }

  @override
  String mapCache_cachedTilesWithFailed(int downloaded, int failed) {
    return 'Tiles em cache ($downloaded) ($failed falhou)';
  }

  @override
  String get mapCache_clearOfflineCacheTitle => 'Limpar cache offline';

  @override
  String get mapCache_clearOfflineCachePrompt =>
      'Remover todas as telhas de mapa em cache?';

  @override
  String get mapCache_offlineCacheCleared => 'Cache offline limpa';

  @override
  String get mapCache_noAreaSelected => 'Nenhuma área selecionada';

  @override
  String get mapCache_cacheArea => 'Área de Cache';

  @override
  String get mapCache_useCurrentView => 'Usar a Visualização Atual';

  @override
  String get mapCache_zoomRange => 'Intervalo de Zoom';

  @override
  String mapCache_estimatedTiles(int count) {
    return 'Estimados azulejos: $count';
  }

  @override
  String mapCache_downloadedTiles(int completed, int total) {
    return 'Baixado $completed / $total';
  }

  @override
  String get mapCache_downloadTilesButton => 'Baixar Tiles';

  @override
  String get mapCache_clearCacheButton => 'Limpar Cache';

  @override
  String mapCache_failedDownloads(int count) {
    return 'Downloads falhas: $count';
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
  String get time_justNow => 'Agora';

  @override
  String time_minutesAgo(int minutes) {
    return '$minutes minutos atrás';
  }

  @override
  String time_hoursAgo(int hours) {
    return '${hours}h atrás';
  }

  @override
  String time_daysAgo(int days) {
    return '$days dias atrás';
  }

  @override
  String get time_hour => 'hora';

  @override
  String get time_hours => 'horas';

  @override
  String get time_day => 'dia';

  @override
  String get time_days => 'dias';

  @override
  String get time_week => 'semana';

  @override
  String get time_weeks => 'semanas';

  @override
  String get time_month => 'mês';

  @override
  String get time_months => 'meses';

  @override
  String get time_minutes => 'minutos';

  @override
  String get time_allTime => 'Todos os tempos';

  @override
  String get dialog_disconnect => 'Desconectar';

  @override
  String get dialog_disconnectConfirm =>
      'Tem certeza de que deseja desconectar deste dispositivo?';

  @override
  String get login_repeaterLogin => 'Login ao Repetidor';

  @override
  String get login_roomLogin => 'Login de Sala';

  @override
  String get login_password => 'Senha';

  @override
  String get login_enterPassword => 'Insira a senha';

  @override
  String get login_savePassword => 'Salvar senha';

  @override
  String get login_savePasswordSubtitle =>
      'A senha será armazenada com segurança neste dispositivo.';

  @override
  String get login_repeaterDescription =>
      'Insira a senha do repetidor para acessar as configurações e o status.';

  @override
  String get login_roomDescription =>
      'Insira a senha da sala para acessar as configurações e o status.';

  @override
  String get login_routing => 'Rotas';

  @override
  String get login_routingMode => 'Modo de roteamento';

  @override
  String get login_autoUseSavedPath => 'Auto (usar caminho salvo)';

  @override
  String get login_forceFloodMode => 'Modo de Inundação Forçado';

  @override
  String get login_managePaths => 'Gerenciar Caminhos';

  @override
  String get login_login => 'Entrar';

  @override
  String login_attempt(int current, int max) {
    return 'Tentar $current/$max';
  }

  @override
  String login_failed(String error) {
    return 'Login falhou: $error';
  }

  @override
  String get login_failedMessage =>
      'Falha no login. A senha está incorreta ou o repetidor está inacessível.';

  @override
  String get common_reload => 'Recarregar';

  @override
  String get common_clear => 'Limpar';

  @override
  String get path_currentPathLabel => 'Caminho atual';

  @override
  String get path_noRepeatersFound =>
      'Não foram encontrados repetidores ou servidores de sala.';

  @override
  String get repeater_management => 'Gerenciamento de Repetidor';

  @override
  String get room_management => 'Gerenciamento de Servidor de Sala';

  @override
  String get repeater_guest => 'Informações sobre repetidores';

  @override
  String get room_guest => 'Informações do Servidor';

  @override
  String get repeater_managementTools => 'Ferramentas de Gerenciamento';

  @override
  String get repeater_guestTools => 'Ferramentas para hóspedes';

  @override
  String get repeater_status => 'Estado';

  @override
  String get repeater_statusSubtitle =>
      'Visualizar status do repetidor, estatísticas e vizinhos.';

  @override
  String get repeater_telemetry => 'Telemetria';

  @override
  String get repeater_telemetrySubtitle =>
      'Visualizar telemetria de sensores e estatísticas do sistema';

  @override
  String get repeater_cli => 'Interface de Linha de Comando';

  @override
  String get repeater_cliSubtitle => 'Enviar comandos ao repetidor';

  @override
  String get repeater_neighbors => 'Vizinhos';

  @override
  String get repeater_neighborsSubtitle => 'Visualizar vizinhos de salto zero.';

  @override
  String get repeater_settings => 'Configurações';

  @override
  String get repeater_settingsSubtitle => 'Configurar parâmetros do repetidor';

  @override
  String get repeater_clockSyncAfterLogin =>
      'Sincronização do relógio após o login';

  @override
  String get repeater_clockSyncAfterLoginSubtitle =>
      'Enviar automaticamente a sincronização do \"relógio\" após um login bem-sucedido.';

  @override
  String get repeater_statusTitle => 'Status do Repetidor';

  @override
  String get repeater_routingMode => 'Modo de roteamento';

  @override
  String get repeater_refresh => 'Atualizar';

  @override
  String get repeater_statusRequestTimeout => 'Solicitação de status expirou.';

  @override
  String repeater_errorLoadingStatus(String error) {
    return 'Erro ao carregar o status: $error';
  }

  @override
  String get repeater_systemInformation => 'Informações do Sistema';

  @override
  String get repeater_battery => 'Bateria';

  @override
  String get repeater_clockAtLogin => 'Relógio (no login)';

  @override
  String get repeater_uptime => 'Disponibilidade';

  @override
  String get repeater_queueLength => 'Comprimento da Fila';

  @override
  String get repeater_debugFlags => 'Marcar Flags de Depuração';

  @override
  String get repeater_radioStatistics => 'Estatísticas de Rádio';

  @override
  String get repeater_lastRssi => 'Último RSSI';

  @override
  String get repeater_lastSnr => 'Último SNR';

  @override
  String get repeater_noiseFloor => 'Nível de Ruído';

  @override
  String get repeater_txAirtime => 'TX Airtime';

  @override
  String get repeater_rxAirtime => 'RX Airtime';

  @override
  String get repeater_chanUtil => 'Utilização do canal';

  @override
  String get repeater_packetStatistics => 'Estatísticas de Pacote';

  @override
  String get repeater_sent => 'Enviado';

  @override
  String get repeater_received => 'Recebido';

  @override
  String get repeater_duplicates => 'Duplicatas';

  @override
  String repeater_daysHoursMinsSecs(
    int days,
    int hours,
    int minutes,
    int seconds,
  ) {
    return '$days dias ${hours}h ${minutes}m ${seconds}s';
  }

  @override
  String repeater_packetTxTotal(int total, String flood, String direct) {
    return 'Total: $total, Inundação: $flood, Direto: $direct';
  }

  @override
  String repeater_packetRxTotal(int total, String flood, String direct) {
    return 'Total: $total, Inundação: $flood, Direto: $direct';
  }

  @override
  String repeater_duplicatesFloodDirect(String flood, String direct) {
    return 'Inundação: $flood, Direto: $direct';
  }

  @override
  String repeater_duplicatesTotal(int total) {
    return 'Total: $total';
  }

  @override
  String get repeater_settingsTitle => 'Configurações do Repetidor';

  @override
  String get repeater_basicSettings => 'Configurações Básicas';

  @override
  String get repeater_repeaterName => 'Nome do Repetidor';

  @override
  String get repeater_repeaterNameHelper => 'Exibir nome para este repetidor';

  @override
  String get repeater_adminPassword => 'Senha de Administrador';

  @override
  String get repeater_adminPasswordHelper => 'Acesso completo de senha';

  @override
  String get repeater_guestPassword => 'Senha de convidado';

  @override
  String get repeater_guestPasswordHelper =>
      'Acesso com senha de leitura somente';

  @override
  String get repeater_radioSettings => 'Configurações de Rádio';

  @override
  String get repeater_frequencyMhz => 'Frequência (MHz)';

  @override
  String get repeater_frequencyHelper => '300-2500 MHz';

  @override
  String get repeater_txPower => 'Energia da TX';

  @override
  String get repeater_txPowerHelper => '1-30 dBm';

  @override
  String get repeater_bandwidth => 'Largura de banda';

  @override
  String get repeater_spreadingFactor => 'Fator de Dispersão';

  @override
  String get repeater_codingRate => 'Taxa de Codificação';

  @override
  String get repeater_locationSettings => 'Configurações de Localização';

  @override
  String get repeater_latitude => 'Latitude';

  @override
  String get repeater_latitudeHelper => 'Graus decimais (por exemplo, 37,7749)';

  @override
  String get repeater_longitude => 'Longitude';

  @override
  String get repeater_longitudeHelper =>
      'Graus decimais (por exemplo, -122,4194)';

  @override
  String get repeater_features => 'Recursos';

  @override
  String get repeater_packetForwarding => 'Encaminhamento de Pacotes';

  @override
  String get repeater_packetForwardingSubtitle =>
      'Habilitar o repetidor para encaminhar pacotes';

  @override
  String get repeater_guestAccess => 'Acesso de Convidado';

  @override
  String get repeater_guestAccessSubtitle =>
      'Permitir acesso de convidado somente leitura';

  @override
  String get repeater_privacyMode => 'Modo de Privacidade';

  @override
  String get repeater_privacyModeSubtitle =>
      'Esconder nome/localização em anúncios';

  @override
  String get repeater_advertisementSettings => 'Configurações de Anúncios';

  @override
  String get repeater_localAdvertInterval => 'Intervalo de Anúncio Local';

  @override
  String repeater_localAdvertIntervalMinutes(int minutes) {
    return '$minutes minutos';
  }

  @override
  String get repeater_floodAdvertInterval =>
      'Intervalo de Anúncio de Inundação';

  @override
  String repeater_floodAdvertIntervalHours(int hours) {
    return '$hours horas';
  }

  @override
  String get repeater_encryptedAdvertInterval =>
      'Intervalo de Anúncio Criptografado';

  @override
  String get repeater_dangerZone => 'Zona de Perigo';

  @override
  String get repeater_rebootRepeater => 'Reiniciar Repetidor';

  @override
  String get repeater_rebootRepeaterSubtitle =>
      'Reiniciar o dispositivo repetidor';

  @override
  String get repeater_rebootRepeaterConfirm =>
      'Tem certeza de que deseja reiniciar este repetidor?';

  @override
  String get repeater_regenerateIdentityKey => 'Gerar Chave de Identidade';

  @override
  String get repeater_regenerateIdentityKeySubtitle =>
      'Gerar nova chave pública/privada';

  @override
  String get repeater_regenerateIdentityKeyConfirm =>
      'Isso gerará uma nova identidade para o repetidor. Continuar?';

  @override
  String get repeater_eraseFileSystem => 'Excluir Sistema de Arquivos';

  @override
  String get repeater_eraseFileSystemSubtitle =>
      'Formatar o sistema de arquivos do repetidor';

  @override
  String get repeater_eraseFileSystemConfirm =>
      'AVISO: Isso apagará todos os dados no repetidor. Isso não pode ser desfeito!';

  @override
  String get repeater_eraseSerialOnly =>
      'Apagar está disponível apenas via console serial.';

  @override
  String repeater_commandSent(String command) {
    return 'Comando enviado: $command';
  }

  @override
  String repeater_errorSendingCommand(String error) {
    return 'Erro ao enviar comando: $error';
  }

  @override
  String get repeater_confirm => 'Confirmar';

  @override
  String get repeater_settingsSaved => 'Configurações salvas com sucesso';

  @override
  String get repeater_rxGain => 'Aumento do ganho do RX';

  @override
  String get repeater_rxGainHelper =>
      'Maior sensibilidade, maior consumo de corrente (apenas para SX1262/SX1268)';

  @override
  String get repeater_refreshRxGain => 'Reforçar o ganho do RX';

  @override
  String get repeater_multiAcks => 'Múltiplas respostas de confirmação';

  @override
  String get repeater_multiAcksSubtitle =>
      'Reconheça mensagens através de múltiplos caminhos para uma melhor entrega.';

  @override
  String get repeater_refreshMultiAcks => 'Reiniciar múltiplas confirmações';

  @override
  String get repeater_networkHealth => 'Saúde da rede';

  @override
  String get repeater_loopDetect => 'Detecção de loops';

  @override
  String get repeater_loopDetectHelper =>
      'Envie pacotes que pareçam ser loops de roteamento.';

  @override
  String get repeater_loopDetectOff => 'Desligado';

  @override
  String get repeater_loopDetectMinimal => 'Mínimo';

  @override
  String get repeater_loopDetectModerate => 'Moderado';

  @override
  String get repeater_loopDetectStrict => 'Rígido';

  @override
  String get repeater_dutyCycle => 'Ciclo de operação';

  @override
  String get repeater_dutyCycleHelper =>
      'Porcentagem máxima de tempo de transmissão';

  @override
  String repeater_dutyCyclePercent(int percent) {
    return '$percent%';
  }

  @override
  String get repeater_ownerInfo => 'Informações sobre o operador';

  @override
  String get repeater_ownerInfoHelper =>
      'Metadados públicos para este repetidor';

  @override
  String get repeater_refreshOwnerInfo => 'Atualizar informações do operador';

  @override
  String get repeater_floodMax =>
      'Número máximo de saltos em caso de inundação';

  @override
  String get repeater_floodMaxHelper =>
      'Número máximo de saltos que um pacote de inundação pode percorrer (0-64)';

  @override
  String get repeater_advancedSettings => 'Avançado';

  @override
  String get repeater_advancedSettingsSubtitle =>
      'Controles de ajuste para operadores experientes';

  @override
  String get repeater_pathHashMode => 'Modo de hash de caminho';

  @override
  String get repeater_pathHashModeHelper =>
      'Bytes usados para codificar o ID deste repetidor nas tags de caminho flood/detecção de loop. 0=1 byte (256 IDs, até 64 saltos), 1=2 bytes (65.000 IDs, até 32 saltos), 2=3 bytes (16 milhões de IDs, até 21 saltos). O firmware anterior à v1.14 sempre usava caminhos de 1 byte; v1.14 e versões mais recentes podem ser configuradas para caminhos de 2 ou 3 bytes.';

  @override
  String get repeater_keySettings => 'Alterar Chaves de Identidade';

  @override
  String get repeater_keySettingsSubtitle =>
      'Altere a chave pública/chave privada';

  @override
  String get repeater_prvKey => 'Chave privada';

  @override
  String get repeater_prvKeyHelper =>
      'Uma nova chave privada para o repetidor, uma string hexadecimal de 128 caracteres.';

  @override
  String get repeater_generatePrvKey => 'Gere um par de chaves aleatório';

  @override
  String get repeater_stopGeneratingPrvKey =>
      'Interrompa a busca por par de chaves';

  @override
  String get repeater_pubKey => 'Chave pública';

  @override
  String get repeater_pubKeyHelper =>
      'Esta é a chave pública que acompanha a chave privada gerada. Você não pode definir isso diretamente.';

  @override
  String get repeater_pubKeyPrefix => 'Prefixo desejado';

  @override
  String repeater_pubKeyPrefixHelper(int tries) {
    return 'Encontre uma chave pública que comece com esses dígitos hexadecimais. Número esperado de tentativas: $tries.';
  }

  @override
  String get repeater_txDelay => 'Atraso na entrega em Flood, TX';

  @override
  String get repeater_txDelayHelper =>
      'Ajuste de espaçamento para tráfego de inundações, como um multiplicador do tempo de transmissão (0-2, padrão 0,5). Quanto maior, menos colisões, mas uma entrega mais lenta.';

  @override
  String get repeater_directTxDelay => 'Atraso direto no sinal TX';

  @override
  String get repeater_directTxDelayHelper =>
      'Intervalo de retransmissão para tráfego direto (não em enxame), como um multiplicador do tempo de transmissão do pacote (0-2, padrão 0,3).';

  @override
  String get repeater_intThresh => 'Limite de interferência';

  @override
  String get repeater_intThreshHelper =>
      'O limite é definido para o nível de ruído do rádio, de modo que ele rejeite interferências acima desse nível. 0 desativa – aumente apenas se você observar erros de RX em uma faixa de frequência com ruído.';

  @override
  String get repeater_agcResetInterval => 'Intervalo de reinicialização do AGC';

  @override
  String get repeater_agcResetIntervalHelper =>
      'Com que frequência redefinir o controle automático de ganho do rádio para recuperar de um estado em que o ganho está travado. Segundos, reduzidos a um múltiplo de 4. 0 desativa as redefinições periódicas.';

  @override
  String get repeater_actionsTitle => 'Ações';

  @override
  String get repeater_sendAdvert => 'Envie anúncio sobre inundações';

  @override
  String get repeater_sendAdvertSubtitle =>
      'Transmita um anúncio sobre inundações pela rede.';

  @override
  String get repeater_sendAdvertZeroHop => 'Enviar anúncio sem intermediários';

  @override
  String get repeater_sendAdvertZeroHopSubtitle =>
      'Transmita um anúncio de um único salto (sem repetição).';

  @override
  String get repeater_clockSync => 'Sincronize o relógio agora';

  @override
  String get repeater_clockSyncSubtitle =>
      'Envie a hora do seu telefone para o repetidor.';

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
      'Configurações salvas — reinicie o repetidor para aplicar as alterações.';

  @override
  String repeater_settingsPartialFailure(String failures) {
    return 'Algumas configurações falharam: $failures';
  }

  @override
  String repeater_errorSavingSettings(String error) {
    return 'Erro ao salvar as configurações: $error';
  }

  @override
  String get repeater_refreshBasicSettings => 'Atualizar Configurações Básicas';

  @override
  String get repeater_refreshRadioSettings =>
      'Atualizar Configurações de Rádio';

  @override
  String get repeater_refreshTxPower => 'Atualizar TX de energia';

  @override
  String get repeater_refreshPacketForwarding =>
      'Atualizar Roteamento de Pacotes';

  @override
  String get repeater_refreshGuestAccess => 'Atualizar Acesso de Convidados';

  @override
  String get repeater_refreshPrivacyMode => 'Atualizar Modo Privacidade';

  @override
  String repeater_refreshed(String label) {
    return '$label atualizado';
  }

  @override
  String repeater_errorRefreshing(String label) {
    return 'Erro ao atualizar $label';
  }

  @override
  String get repeater_cliTitle => 'Repetidor CLI';

  @override
  String get repeater_debugNextCommand => 'Depurar Próximo Comando';

  @override
  String get repeater_commandHelp => 'Ajuda';

  @override
  String get repeater_clearHistory => 'Limpar Histórico';

  @override
  String get repeater_noCommandsSent => 'Ainda não foram enviadas comandos.';

  @override
  String get repeater_typeCommandOrUseQuick =>
      'Digite um comando abaixo ou use comandos rápidos';

  @override
  String get repeater_enterCommandHint => 'Insira o comando...';

  @override
  String get repeater_previousCommand => 'Comando anterior';

  @override
  String get repeater_nextCommand => 'Próxima ação';

  @override
  String get repeater_enterCommandFirst => 'Insira um comando primeiro';

  @override
  String get repeater_cliCommandFrameTitle => 'Frame de Comando CLI';

  @override
  String repeater_cliCommandError(String error) {
    return 'Erro: $error';
  }

  @override
  String get repeater_cliQuickGetName => 'Obter Nome';

  @override
  String get repeater_cliQuickGetRadio => 'Obter Rádio';

  @override
  String get repeater_cliQuickGetTx => 'Obter TX';

  @override
  String get repeater_cliQuickNeighbors => 'Vizinhos';

  @override
  String get repeater_cliQuickVersion => 'Versão';

  @override
  String get repeater_cliQuickAdvertise => 'Anunciar';

  @override
  String get repeater_cliQuickClock => 'Relógio';

  @override
  String get repeater_cliQuickClockSync => 'Sincronização do Relógio';

  @override
  String get repeater_cliQuickDiscovery => 'Descobrir Vizinhos';

  @override
  String get repeater_cliHelpAdvert => 'Envia um pacote de anúncios';

  @override
  String get repeater_cliHelpReboot =>
      'Reinicia o dispositivo. (note, você pode obter \'Timeout\' que é normal)';

  @override
  String get repeater_cliHelpClock =>
      'Exibe a hora atual de cada dispositivo, de acordo com o relógio do dispositivo.';

  @override
  String get repeater_cliHelpPassword =>
      'Define uma nova senha de administrador para o dispositivo.';

  @override
  String get repeater_cliHelpVersion =>
      'Mostra a versão do dispositivo e a data de construção do firmware.';

  @override
  String get repeater_cliHelpClearStats =>
      'Reseta vários contadores de estatísticas para zero.';

  @override
  String get repeater_cliHelpSetAf => 'Define o fator de tempo de ar.';

  @override
  String get repeater_cliHelpSetTx =>
      'Define a potência de transmissão LoRa em dBm (redefinir para aplicar).';

  @override
  String get repeater_cliHelpSetRepeat =>
      'Habilita ou desabilita o papel do repetidor para este nó.';

  @override
  String get repeater_cliHelpSetAllowReadOnly =>
      '(Servidor de sala) Se \'ligado\', então o login com senha em branco será permitido, mas não poderá Postar na sala. (apenas ler).';

  @override
  String get repeater_cliHelpSetFloodMax =>
      'Define o número máximo de saltos de pacotes de inundação de entrada (se for >= máximo, o pacote não é encaminhado)';

  @override
  String get repeater_cliHelpSetIntThresh =>
      'Define o Limite de Interferência (em dB). O valor padrão é 14. Defina como 0 para desativar a detecção de interferência de canal.';

  @override
  String get repeater_cliHelpSetAgcResetInterval =>
      'Define o intervalo para resetar o Controlador de Ganho Automático. Defina como 0 para desativar.';

  @override
  String get repeater_cliHelpSetMultiAcks =>
      'Habilita ou desabilita a funcionalidade de \"double ACKs\".';

  @override
  String get repeater_cliHelpSetAdvertInterval =>
      'Define o intervalo do timer em minutos para enviar um pacote de anúncio local (sem salto). Defina como 0 para desativar.';

  @override
  String get repeater_cliHelpSetFloodAdvertInterval =>
      'Define o intervalo do timer em horas para enviar um pacote de anúncio em massa. Defina como 0 para desativar.';

  @override
  String get repeater_cliHelpSetGuestPassword =>
      'Define/atualiza a senha do convidado. (para repetidores, os logins de convidados podem enviar a solicitação \"Obter Estatísticas\")';

  @override
  String get repeater_cliHelpSetName => 'Define o nome do anúncio.';

  @override
  String get repeater_cliHelpSetLat =>
      'Define a latitude do mapa de anúncios. (graus decimais)';

  @override
  String get repeater_cliHelpSetLon =>
      'Define a longitude do mapa de anúncios. (graus decimais)';

  @override
  String get repeater_cliHelpSetRadio =>
      'Define completamente novos parâmetros de rádio e salva nas preferências. Requer um comando \"reboot\" para aplicar.';

  @override
  String get repeater_cliHelpSetRxDelay =>
      'Configurações (experimental) base (deve ser > 1 para efeito) para aplicar um pequeno atraso aos pacotes recebidos, com base na força do sinal/pontuação. Defina como 0 para desativar.';

  @override
  String get repeater_cliHelpSetTxDelay =>
      'Define um fator multiplicado com o tempo-em-ar para um pacote de modo de inundação e com um sistema de slot aleatório, para atrasar seu encaminhamento. (para diminuir a probabilidade de colisões)';

  @override
  String get repeater_cliHelpSetDirectTxDelay =>
      'Igual a txdelay, mas para aplicar um atraso aleatório à encaminhamento de pacotes em modo direto.';

  @override
  String get repeater_cliHelpSetBridgeEnabled => 'Ativar/Desativar ponte.';

  @override
  String get repeater_cliHelpSetBridgeDelay =>
      'Definir atraso antes de retransmitir pacotes.';

  @override
  String get repeater_cliHelpSetBridgeSource =>
      'Escolha se a ponte retransmitirá pacotes recebidos ou pacotes transmitidos.';

  @override
  String get repeater_cliHelpSetBridgeBaud =>
      'Definir a taxa de baud para as pontes rs232.';

  @override
  String get repeater_cliHelpSetBridgeSecret =>
      'Definir segredo de ponte para pontes espnow.';

  @override
  String get repeater_cliHelpSetAdcMultiplier =>
      'Define um fator personalizado para ajustar a voltagem de bateria relatada (apenas suportado em placas selecionadas).';

  @override
  String get repeater_cliHelpTempRadio =>
      'Define parâmetros de rádio temporários para o número especificado de minutos, revertendo para os parâmetros de rádio originais posteriormente. (não salva nas preferências).';

  @override
  String get repeater_cliHelpSetPerm =>
      'Modifica o ACL. Remove a entrada correspondente (pelo prefixo de pubkey) se \"permissions\" for zero. Adiciona uma nova entrada se o pubkey-hex for de comprimento total e não estiver atualmente no ACL. Atualiza a entrada por correspondência de prefixo de pubkey. Os bits de permissão variam conforme o papel do firmware, mas os 2 bits inferiores são: 0 (Guest), 1 (Read only), 2 (Read write), 3 (Admin)';

  @override
  String get repeater_cliHelpGetBridgeType =>
      'Obtém tipo de ponte nenhum, rs232, espnow';

  @override
  String get repeater_cliHelpLogStart =>
      'Inicia o registro de pacotes no sistema de arquivos.';

  @override
  String get repeater_cliHelpLogStop =>
      'Para interromper o registro de pacotes no sistema de arquivos.';

  @override
  String get repeater_cliHelpLogErase =>
      'Apaga os logs do pacote do sistema de arquivos.';

  @override
  String get repeater_cliHelpNeighbors =>
      'Mostra uma lista de outros nós de repetição ouvidos através de anúncios zero-hop. Cada linha é id-prefixo-hexadecimal:timestamp:snr-vezes-4';

  @override
  String get repeater_cliHelpNeighborRemove =>
      'Remove a primeira entrada correspondente (por prefixo de chave pública (hexadecimal)) da lista de vizinhos.';

  @override
  String get repeater_cliHelpRegion =>
      '(série apenas) Lista todas as regiões definidas e as permissões de inundação atuais.';

  @override
  String get repeater_cliHelpRegionLoad =>
      'NOTA: isto é uma invocação multi-comando especial. Cada comando subsequente é um nome de região (indentado com espaços para indicar a hierarquia pai, com um espaço mínimo). Terminado enviando uma linha em branco/comando.';

  @override
  String get repeater_cliHelpRegionGet =>
      'Procura região com o prefixo de nome dado (ou \"\\\" para o âmbito global). Responde com \"-> nome-região (nome-pai) \'F\'\"';

  @override
  String get repeater_cliHelpRegionPut =>
      'Adiciona ou atualiza uma definição de região com o nome fornecido.';

  @override
  String get repeater_cliHelpRegionRemove =>
      'Remove uma definição de região com o nome fornecido. (deve corresponder exatamente e não ter regiões filhas)';

  @override
  String get repeater_cliHelpRegionAllowf =>
      'Define a permissão de \'F\'luido para a região especificada. (\'\' para o escopo global/legado)';

  @override
  String get repeater_cliHelpRegionDenyf =>
      'Remove a permissão de \"F\"luido para a região especificada. (NOTA: neste momento NÃO é aconselhável usar isso no escopo global/legado!!)';

  @override
  String get repeater_cliHelpRegionHome =>
      'Responde com a região \'home\' atual. (Observação aplicada em nenhum lugar ainda, reservado para o futuro)';

  @override
  String get repeater_cliHelpRegionHomeSet => 'Define a região \'casa\'.';

  @override
  String get repeater_cliHelpRegionSave =>
      'Persiste a lista/mapa de regiões para o armazenamento.';

  @override
  String get repeater_cliHelpGps =>
      'Mostra o status do GPS. Quando o GPS estiver desligado, responde apenas com \"off\", se estiver ligado, responde com \"on\", status, fix, contagem de satélites.';

  @override
  String get repeater_cliHelpGpsOnOff => 'Alterna o estado de energia do GPS.';

  @override
  String get repeater_cliHelpGpsSync =>
      'Sincroniza o tempo do nó com o relógio GPS.';

  @override
  String get repeater_cliHelpGpsSetLoc =>
      'Define a posição do nó para coordenadas GPS e salvar preferências.';

  @override
  String get repeater_cliHelpGpsAdvert =>
      'Define a configuração de anúncio da localização do nó:\n- nenhum: não incluir a localização nos anúncios\n- compartilhar: compartilhar a localização GPS (do SensorManager)\n- preferências: anunciar a localização armazenada nas preferências';

  @override
  String get repeater_cliHelpGpsAdvertSet =>
      'Define a configuração do anúncio de localização.';

  @override
  String get repeater_commandsListTitle => 'Lista de Comandos';

  @override
  String get repeater_commandsListNote =>
      'NOTA: para os diversos comandos \"set...\", também existe um comando \"get...\".';

  @override
  String get repeater_general => 'Geral';

  @override
  String get repeater_settingsCategory => 'Configurações';

  @override
  String get repeater_bridge => 'Ponte';

  @override
  String get repeater_logging => 'Registrar';

  @override
  String get repeater_neighborsRepeaterOnly => 'Vizinhos (apenas repetidor)';

  @override
  String get repeater_regionManagementRepeaterOnly =>
      'Gerenciamento de Região (Apenas Repetidor)';

  @override
  String get repeater_regionNote =>
      'Os comandos de região foram introduzidos para gerenciar definições e permissões de região.';

  @override
  String get repeater_gpsManagement => 'Gerenciamento GPS';

  @override
  String get repeater_gpsNote =>
      'O comando GPS foi introduzido para gerenciar tópicos relacionados à localização.';

  @override
  String get repeater_getCategory => 'Obter valores';

  @override
  String get repeater_powerMgmt => 'Gerenciamento de energia';

  @override
  String get repeater_sensors => 'Sensores';

  @override
  String get repeater_cliHelpPowerOff =>
      'Desliga o dispositivo. (não se espera resposta)';

  @override
  String get repeater_cliHelpClkReboot =>
      'Redefine o relógio para uma data conhecida e reinicia o dispositivo.';

  @override
  String get repeater_cliHelpAdvertZeroHop =>
      'Envia um anúncio sem \"salto\" (apenas para vizinhos próximos).';

  @override
  String get repeater_cliHelpStartOta =>
      'Inicia uma atualização de firmware via rádio em placas compatíveis.';

  @override
  String get repeater_cliHelpTime =>
      'Define o relógio do dispositivo para os segundos da época Unix especificados. O relógio não pode retroceder.';

  @override
  String get repeater_cliHelpBoard =>
      'Indica o fabricante da placa / identificador de hardware.';

  @override
  String get repeater_cliHelpDiscoverNeighbors =>
      'Envia uma solicitação de descoberta de nós para os vizinhos próximos. (Apenas para repetidores)';

  @override
  String get repeater_cliHelpPowersaving =>
      'Indica se o modo de economia de energia está ativado ou desativado.';

  @override
  String get repeater_cliHelpPowersavingOnOff =>
      'Habilita ou desabilita o modo de economia de energia (quando disponível).';

  @override
  String get repeater_cliHelpErase =>
      '(Apenas para dispositivos) Formata o sistema de arquivos do dispositivo. Apaga todas as configurações e contatos.';

  @override
  String get repeater_cliHelpSetDutyCycle =>
      'Define o ciclo de transmissão máximo permitido como uma porcentagem (1-100). Ajusta internamente o fator de tempo de transmissão.';

  @override
  String get repeater_cliHelpSetPrvKey =>
      '(Apenas para uso em série) Substitui a chave privada de identificação do dispositivo. É necessário reiniciar o dispositivo para aplicar a alteração. Gera uma nova chave pública.';

  @override
  String get repeater_cliHelpSetRadioRxGain =>
      '(Apenas para SX126x) Alterna o ganho amplificado do receptor (RX) para melhorar a sensibilidade em condições de corrente mais elevada.';

  @override
  String get repeater_cliHelpSetOwnerInfo =>
      'Define a string com as informações de contato do proprietário, que será incluída nos anúncios. Utilize \'|\' para indicar novas linhas.';

  @override
  String get repeater_cliHelpSetPathHashMode =>
      'Define o modo de hash de caminho. 0 = modo legado, 1 = modo padrão, 2 = modo rigoroso. Afeta a forma como os caminhos de roteamento são correspondidos.';

  @override
  String get repeater_cliHelpSetLoopDetect =>
      'Define o nível de sensibilidade para a detecção de loops de roteamento: desligado, mínimo, moderado ou estrito.';

  @override
  String get repeater_cliHelpSetFreq =>
      '(Apenas para rádio) Define rapidamente a frequência. É necessário reiniciar o dispositivo. Recomenda-se usar a opção \"configurar rádio\" para definir todos os parâmetros do rádio.';

  @override
  String get repeater_cliHelpSetBridgeChannel =>
      '(Apenas para a ponte ESPNow) Define o canal Wi-Fi (1-14) utilizado pela ponte.';

  @override
  String get repeater_cliHelpGetName => 'Mostra o nome do nó configurado.';

  @override
  String get repeater_cliHelpGetRole =>
      'Mostra o papel do firmware (Repetidor, Servidor de Sala, etc.).';

  @override
  String get repeater_cliHelpGetPublicKey =>
      'Exibe a chave pública do dispositivo.';

  @override
  String get repeater_cliHelpGetPrvKey =>
      '(Apenas para uso em série) Exibe a chave privada do dispositivo. Trate-a como uma informação confidencial.';

  @override
  String get repeater_cliHelpGetRepeat =>
      'Indica se a função de encaminhamento de pacotes (função de repetidor) está ativada ou desativada.';

  @override
  String get repeater_cliHelpGetTx => 'Mostra a potência atual em dBm.';

  @override
  String get repeater_cliHelpGetFreq =>
      'Mostra a frequência de rádio configurada em MHz.';

  @override
  String get repeater_cliHelpGetRadio =>
      'Exibe todos os parâmetros de rádio: frequência, largura de banda, fator de espalhamento, taxa de codificação.';

  @override
  String get repeater_cliHelpGetRadioRxGain =>
      '(Apenas para SX126x) Mostra o estado do ganho amplificado do RX.';

  @override
  String get repeater_cliHelpGetAf =>
      'Mostra o fator de tempo de transmissão atual.';

  @override
  String get repeater_cliHelpGetDutyCycle =>
      'Mostra o ciclo de trabalho atual permitido em porcentagem.';

  @override
  String get repeater_cliHelpGetIntThresh =>
      'Mostra o limite de interferência do canal em dB.';

  @override
  String get repeater_cliHelpGetAgcResetInterval =>
      'Mostra o intervalo de reinicialização do AGC em segundos.';

  @override
  String get repeater_cliHelpGetMultiAcks =>
      'Indica se o modo de confirmação dupla está ativado (1) ou desativado (0).';

  @override
  String get repeater_cliHelpGetAllowReadOnly =>
      'Indica se o acesso somente de leitura para os convidados está habilitado.';

  @override
  String get repeater_cliHelpGetAdvertInterval =>
      'Indica o intervalo de publicidade local em minutos.';

  @override
  String get repeater_cliHelpGetFloodAdvertInterval =>
      'Mostra o intervalo de tempo da publicidade relacionada às inundações, em horas.';

  @override
  String get repeater_cliHelpGetGuestPassword =>
      'Mostra a senha de convidado configurada.';

  @override
  String get repeater_cliHelpGetLat => 'Mostra a latitude configurada.';

  @override
  String get repeater_cliHelpGetLon => 'Mostra a longitude configurada.';

  @override
  String get repeater_cliHelpGetRxDelay =>
      'Mostra o valor base do atraso de resposta.';

  @override
  String get repeater_cliHelpGetTxDelay =>
      'Mostra o fator de atraso em modo de inundação.';

  @override
  String get repeater_cliHelpGetDirectTxDelay =>
      'Mostra o fator de atraso direto.';

  @override
  String get repeater_cliHelpGetFloodMax =>
      'Mostra o número máximo de saltos devido às inundações.';

  @override
  String get repeater_cliHelpGetOwnerInfo =>
      'Exibe a string de informações de contato do proprietário.';

  @override
  String get repeater_cliHelpGetPathHashMode =>
      'Mostra o modo de hash de caminho (0/1/2).';

  @override
  String get repeater_cliHelpGetLoopDetect =>
      'Demonstra a sensibilidade na detecção de loops.';

  @override
  String get repeater_cliHelpGetAcl =>
      '(Apenas para séries) Lista as entradas de controle de acesso em um repetidor.';

  @override
  String get repeater_cliHelpGetBridgeEnabled =>
      'Indica se a ponte está habilitada.';

  @override
  String get repeater_cliHelpGetBridgeDelay =>
      'Mostra o atraso da ponte em milissegundos.';

  @override
  String get repeater_cliHelpGetBridgeSource =>
      'Indica se a ponte está enviando ou recebendo pacotes RX ou TX.';

  @override
  String get repeater_cliHelpGetBridgeBaud =>
      '(Apenas para ponte RS232) Exibe a taxa de baud da ponte.';

  @override
  String get repeater_cliHelpGetBridgeChannel =>
      '(Apenas para a ponte ESPNow) Exibe o canal WiFi da ponte.';

  @override
  String get repeater_cliHelpGetBridgeSecret =>
      '(Apenas para a ponte ESPNow) Exibe o segredo compartilhado pela ponte.';

  @override
  String get repeater_cliHelpGetBootloaderVer =>
      '(Apenas para NRF52) Exibe a versão do bootloader.';

  @override
  String get repeater_cliHelpGetAdcMultiplier =>
      'Mostra o multiplicador do ADC (escalonamento da tensão da bateria).';

  @override
  String get repeater_cliHelpGetPwrMgtSupport =>
      'Indica se o sistema possui suporte para gerenciamento de energia.';

  @override
  String get repeater_cliHelpGetPwrMgtSource =>
      'Indica a fonte de energia atual: externa ou bateria.';

  @override
  String get repeater_cliHelpGetPwrMgtBootReason =>
      'Mostra as razões mais recentes para a reinicialização e desligamento.';

  @override
  String get repeater_cliHelpGetPwrMgtBootMv =>
      'Mostra a tensão da bateria no momento da inicialização, em milivolts (mV).';

  @override
  String get repeater_cliHelpSensorGet =>
      'Lê uma configuração de sensor personalizada através de uma chave.';

  @override
  String get repeater_cliHelpSensorSet =>
      'Cria uma configuração personalizada para um sensor.';

  @override
  String get repeater_cliHelpSensorList =>
      'Lista todas as configurações de sensores personalizadas, organizadas em páginas a partir de um índice de início opcional.';

  @override
  String get repeater_cliHelpRegionDefault =>
      'Mostra o escopo de região padrão atual.';

  @override
  String get repeater_cliHelpRegionDefaultSet =>
      'Define o escopo regional padrão. Use \"<null>\" para limpar.';

  @override
  String get repeater_cliHelpRegionListAllowed =>
      'Lista as regiões que permitem o tráfego em áreas de risco de inundações.';

  @override
  String get repeater_cliHelpRegionListDenied =>
      'Lista as regiões que restringem o tráfego em áreas de risco de inundações.';

  @override
  String get repeater_cliHelpStatsPackets =>
      '(Apenas para séries) Apresenta estatísticas em nível de pacotes.';

  @override
  String get repeater_cliHelpStatsRadio =>
      '(Apenas para transmissões em série) Exibe estatísticas de rádio.';

  @override
  String get repeater_cliHelpStatsCore =>
      '(Apenas para dispositivos em série) Exibe estatísticas básicas do firmware.';

  @override
  String get telemetry_receivedData => 'Dados de Telemetria Recebidos';

  @override
  String get telemetry_requestTimeout =>
      'Solicitação de telemetria expirou o tempo.';

  @override
  String telemetry_errorLoading(String error) {
    return 'Erro ao carregar a telemetria: $error';
  }

  @override
  String get telemetry_noData => 'Não estão disponíveis dados de telemetria.';

  @override
  String telemetry_channelTitle(int channel) {
    return 'Canal $channel';
  }

  @override
  String get telemetry_batteryLabel => 'Bateria';

  @override
  String get telemetry_voltageLabel => 'Tensão';

  @override
  String get telemetry_mcuTemperatureLabel => 'Temperatura do MCU';

  @override
  String get telemetry_temperatureLabel => 'Temperatura';

  @override
  String get telemetry_currentLabel => 'Atual';

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
  String get telemetry_digitalOutputLabel => 'Saída digital';

  @override
  String get telemetry_analogInputLabel => 'Entrada analógica';

  @override
  String get telemetry_analogOutputLabel => 'Saída analógica';

  @override
  String get telemetry_genericLabel => 'Sensor genérico';

  @override
  String get telemetry_luminosityLabel => 'Luminosidade';

  @override
  String get telemetry_presenceLabel => 'Presença';

  @override
  String get telemetry_humidityLabel => 'Humidade';

  @override
  String get telemetry_accelerometerLabel => 'Acelerómetro';

  @override
  String get telemetry_pressureLabel => 'Pressão';

  @override
  String get telemetry_altitudeLabel => 'Altitude';

  @override
  String get telemetry_frequencyLabel => 'Frequência';

  @override
  String get telemetry_percentageLabel => 'Percentagem';

  @override
  String get telemetry_concentrationLabel => 'Concentração';

  @override
  String get telemetry_powerLabel => 'Potência';

  @override
  String get telemetry_distanceLabel => 'Distância';

  @override
  String get telemetry_energyLabel => 'Energia';

  @override
  String get telemetry_directionLabel => 'Direção';

  @override
  String get telemetry_timeLabel => 'Hora';

  @override
  String get telemetry_gyrometerLabel => 'Girómetro';

  @override
  String get telemetry_colourLabel => 'Cor';

  @override
  String get telemetry_gpsLabel => 'GPS';

  @override
  String get telemetry_switchLabel => 'Interruptor';

  @override
  String get telemetry_polylineLabel => 'Polilinha';

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
  String get telemetry_autoFetchQuantity => 'Número de solicitações';

  @override
  String get telemetry_error => 'Não foi possível obter os dados';

  @override
  String get neighbors_receivedData => 'Dados dos Vizinhos Recebidos';

  @override
  String get neighbors_requestTimedOut =>
      'Vizinhos solicitam tempo limite esgotado.';

  @override
  String neighbors_errorLoading(String error) {
    return 'Erro ao carregar vizinhos: $error';
  }

  @override
  String get neighbors_repeatersNeighbors => 'Repetidores Vizinhos';

  @override
  String get neighbors_noData => 'Não estão disponíveis dados de vizinhos.';

  @override
  String neighbors_unknownContact(String pubkey) {
    return '$pubkey Desconhecido';
  }

  @override
  String neighbors_heardAgo(String time) {
    return 'Ouvido: $time atrás';
  }

  @override
  String get channelPath_title => 'Rótulo de Caminho de Pacote';

  @override
  String get channelPath_viewMap => 'Ver mapa';

  @override
  String get channelPath_otherObservedPaths => 'Outros Caminhos Observados';

  @override
  String get channelPath_repeaterHops => 'Saltos do Repetidor';

  @override
  String get channelPath_noHopDetails =>
      'Os detalhes do pacote não estão disponíveis.';

  @override
  String get channelPath_sourceLabel => 'Origem';

  @override
  String get channelPath_sourceMqtt => 'MQTT';

  @override
  String get channelPath_viaMqttNoRfPath =>
      'Esta mensagem chegou por MQTT. O seu rádio não a ouviu, por isso não há caminho de rádio a partir do seu rádio.';

  @override
  String get channelPath_messageDetails => 'Detalhes da Mensagem';

  @override
  String get channelPath_senderLabel => 'Remetente';

  @override
  String get channelPath_timeLabel => 'Tempo';

  @override
  String get channelPath_repeatsLabel => 'Repete';

  @override
  String channelPath_pathLabel(int index) {
    return 'Caminho $index';
  }

  @override
  String get channelPath_observedLabel => 'Observado';

  @override
  String channelPath_observedPathTitle(int index, String hops) {
    return 'Rastreamento observado $index • $hops';
  }

  @override
  String get channelPath_noLocationData => 'Não há dados de localização.';

  @override
  String channelPath_timeWithDate(int day, int month, String time) {
    return '$day/$month $time';
  }

  @override
  String channelPath_timeOnly(String time) {
    return '$time';
  }

  @override
  String get channelPath_unknownPath => 'Desconhecido';

  @override
  String get channelPath_floodPath => 'Inundação';

  @override
  String get channelPath_directPath => 'Salvar';

  @override
  String channelPath_observedZeroOf(int total) {
    return '0 de $total saltos';
  }

  @override
  String channelPath_observedSomeOf(int observed, int total) {
    return '$observed de $total saltos';
  }

  @override
  String get channelPath_mapTitle => 'Mapa de Caminhos';

  @override
  String get channelPath_noRepeaterLocations =>
      'Não estão disponíveis localizações de repetidores para este caminho.';

  @override
  String channelPath_primaryPath(int index) {
    return 'Caminho $index (Primário)';
  }

  @override
  String get channelPath_pathLabelTitle => 'Caminho';

  @override
  String get channelPath_observedPathHeader => 'Rastreamento Observado';

  @override
  String channelPath_selectedPathLabel(String label, String prefixes) {
    return '$label • $prefixes';
  }

  @override
  String get channelPath_noHopDetailsAvailable =>
      'Não estão disponíveis detalhes de voo para este pacote.';

  @override
  String get channelPath_unknownRepeater => 'Repetidor Desconhecido';

  @override
  String get community_title => 'Comunidade';

  @override
  String get community_create => 'Criar Comunidade';

  @override
  String get community_createDesc =>
      'Crie uma nova comunidade e compartilhe via código QR.';

  @override
  String get community_join => 'Junte-se';

  @override
  String get community_joinTitle => 'Junte-se à Comunidade';

  @override
  String community_joinConfirmation(String name) {
    return 'Você gostaria de se juntar à comunidade \"$name\"?';
  }

  @override
  String get community_scanQr => 'Digitalizar a QR Code da Comunidade';

  @override
  String get community_scanInstructions =>
      'Aponte a câmera para um código QR da comunidade';

  @override
  String get community_showQr => 'Mostrar Código QR';

  @override
  String get community_publicChannel => 'Comunidade Pública';

  @override
  String get community_hashtagChannel => 'Hashtag da Comunidade';

  @override
  String get community_name => 'Nome da Comunidade';

  @override
  String get community_enterName => 'Insira o nome da comunidade';

  @override
  String community_created(String name) {
    return 'Comunidade \"$name\" criada';
  }

  @override
  String community_joined(String name) {
    return 'Juntou-se à comunidade \"$name\"';
  }

  @override
  String get community_qrTitle => 'Partilhar Comunidade';

  @override
  String community_qrInstructions(String name) {
    return 'Escanear este código QR para juntar-se a $name';
  }

  @override
  String get community_hashtagPrivacyHint =>
      'Os canais de hashtag da comunidade só podem ser acessados por membros da comunidade';

  @override
  String get community_invalidQrCode => 'Código QR da comunidade inválido';

  @override
  String get community_alreadyMember => 'Já é Membro';

  @override
  String community_alreadyMemberMessage(String name) {
    return 'Você já é membro de \"$name\".';
  }

  @override
  String get community_addPublicChannel =>
      'Adicionar Canal Público da Comunidade';

  @override
  String get community_addPublicChannelHint =>
      'Adicionar automaticamente o canal público para esta comunidade';

  @override
  String get community_noCommunities =>
      'Ainda não foram adicionadas comunidades.';

  @override
  String get community_scanOrCreate =>
      'Escaneie um código QR ou crie uma comunidade para começar.';

  @override
  String get community_manageCommunities => 'Gerenciar Comunidades';

  @override
  String get community_delete => 'Deixar Comunidade';

  @override
  String community_deleteConfirm(String name) {
    return 'Sair de \"$name\"?';
  }

  @override
  String community_deleteChannelsWarning(int count) {
    return 'Isso também excluirá $count canal/canais e suas mensagens.';
  }

  @override
  String community_deleted(String name) {
    return 'Saiu da comunidade \"$name\"';
  }

  @override
  String get community_regenerateSecret => 'Regenerar Senha Segura';

  @override
  String community_regenerateSecretConfirm(String name) {
    return 'Regenerar a chave secreta para \"$name\"? Todos os membros precisarão escanear o novo código QR para continuar a comunicação.';
  }

  @override
  String get community_regenerate => 'Regenerar';

  @override
  String community_secretRegenerated(String name) {
    return 'Senha secreta regenerada para \"$name\"';
  }

  @override
  String get community_updateSecret => 'Atualizar Segredo';

  @override
  String community_secretUpdated(String name) {
    return 'Segredo atualizado para \"$name\"';
  }

  @override
  String community_scanToUpdateSecret(String name) {
    return 'Scanar o novo código QR para atualizar o segredo para \"$name\"\n\n\n+++++';
  }

  @override
  String get community_addHashtagChannel => 'Adicionar Hashtag da Comunidade';

  @override
  String get community_addHashtagChannelDesc =>
      'Adicionar um canal de hashtag para esta comunidade';

  @override
  String get community_selectCommunity => 'Selecione Comunidade';

  @override
  String get community_regularHashtag => 'Hashtag Regular';

  @override
  String get community_regularHashtagDesc =>
      'Hashtag público (qualquer pessoa pode participar)';

  @override
  String get community_communityHashtag => 'Hashtag da Comunidade';

  @override
  String get community_communityHashtagDesc =>
      'Apenas para membros da comunidade';

  @override
  String community_forCommunity(String name) {
    return 'Para $name';
  }

  @override
  String get listFilter_tooltip => 'Filtrar e ordenar';

  @override
  String get listFilter_sortBy => 'Ordenar por';

  @override
  String get listFilter_latestMessages => 'Últimas mensagens';

  @override
  String get listFilter_heardRecently => 'Ouvido recentemente';

  @override
  String get listFilter_az => 'De A a Z';

  @override
  String get listFilter_filters => 'Filtros';

  @override
  String get listFilter_all => 'Tudo';

  @override
  String get listFilter_favorites => 'Favoritos';

  @override
  String get listFilter_addToFavorites => 'Adicionar aos favoritos';

  @override
  String get listFilter_removeFromFavorites => 'Remover da lista de favoritos';

  @override
  String get listFilter_users => 'Usuários';

  @override
  String get listFilter_repeaters => 'Repetidores';

  @override
  String get listFilter_roomServers => 'Servidores de sala';

  @override
  String get listFilter_unreadOnly => 'Apenas não lido';

  @override
  String get listFilter_newGroup => 'Novo grupo';

  @override
  String get pathTrace_you => 'Você';

  @override
  String get pathTrace_failed => 'Falha no rastreamento de caminho.';

  @override
  String get pathTrace_notAvailable => 'Traçado de caminho não disponível.';

  @override
  String get pathTrace_refreshTooltip => 'Atualizar Path Trace.';

  @override
  String get pathTrace_someHopsNoLocation =>
      'Um ou mais dos lúpulos estão sem localização!';

  @override
  String get pathTrace_clearTooltip => 'Limpar caminho';

  @override
  String get losSelectStartEnd => 'Selecione nós iniciais e finais para LOS.';

  @override
  String losRunFailed(String error) {
    return 'Falha na verificação da linha de visão: $error';
  }

  @override
  String get losClearAllPoints => 'Limpe todos os pontos';

  @override
  String get losRunToViewElevationProfile =>
      'Execute o LOS para visualizar o perfil de elevação';

  @override
  String get losMenuTitle => 'Menu LOS';

  @override
  String get losMenuSubtitle =>
      'Toque nos nós ou mantenha pressionado o mapa para obter pontos personalizados';

  @override
  String get losShowDisplayNodes => 'Mostrar nós de exibição';

  @override
  String get losCustomPoints => 'Pontos personalizados';

  @override
  String losCustomPointLabel(int index) {
    return '$index personalizado';
  }

  @override
  String get losPointA => 'Ponto A';

  @override
  String get losPointB => 'Ponto B';

  @override
  String losAntennaA(String value, String unit) {
    return 'Antena A: $value $unit';
  }

  @override
  String losAntennaB(String value, String unit) {
    return 'Antena B: $value $unit';
  }

  @override
  String get losRun => 'Executar LOS';

  @override
  String get losNoElevationData => 'Sem dados de elevação';

  @override
  String losProfileClear(
    String distance,
    String distanceUnit,
    String clearance,
    String heightUnit,
  ) {
    return '$distance $distanceUnit, limpar LOS, liberação mínima $clearance $heightUnit';
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
  String get losStatusChecking => 'LOS: verificando...';

  @override
  String get losStatusNoData => 'LOS: sem dados';

  @override
  String losStatusSummary(int clear, int total, int blocked, int unknown) {
    return 'LOS: $clear/$total limpo, $blocked bloqueado, $unknown desconhecido';
  }

  @override
  String get losErrorElevationUnavailable =>
      'Dados de elevação indisponíveis para uma ou mais amostras.';

  @override
  String get losErrorInvalidInput =>
      'Dados de pontos/elevação inválidos para cálculo de LOS.';

  @override
  String get losRenameCustomPoint => 'Renomear ponto personalizado';

  @override
  String get losPointName => 'Nome do ponto';

  @override
  String get losShowPanelTooltip => 'Mostrar painel LOS';

  @override
  String get losHidePanelTooltip => 'Ocultar painel LOS';

  @override
  String get losElevationAttribution =>
      'Dados de elevação: Open-Meteo (CC BY 4.0)';

  @override
  String get losLegendRadioHorizon => 'Horizonte de rádio';

  @override
  String get losLegendLosBeam => 'Linha de visada';

  @override
  String get losLegendTerrain => 'Terreno';

  @override
  String get losBlockedSpotsTitle => 'Locais ocupados';

  @override
  String get losBlockedSpotsHint =>
      'Toque em um ponto bloqueado para destacá-lo no mapa.';

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
  String get losSelectedObstructionTitle => 'Obstrução selecionada';

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
  String get losFrequencyLabel => 'Frequência';

  @override
  String get losFrequencyInfoTooltip => 'Ver detalhes do cálculo';

  @override
  String get losFrequencyDialogTitle => 'Cálculo do horizonte de rádio';

  @override
  String losFrequencyDialogDescription(
    double baselineK,
    double baselineFreq,
    double frequencyMHz,
    double kFactor,
  ) {
    return 'Começando em k=$baselineK em $baselineFreq MHz, o cálculo ajusta o fator k para a banda atual de $frequencyMHz MHz, que define o limite do horizonte de rádio curvo.';
  }

  @override
  String get contacts_pathTrace => 'Traçado de Caminho';

  @override
  String get contacts_ping => 'Pingar';

  @override
  String get contacts_repeaterPathTrace => 'Traçar caminho para repetidor';

  @override
  String get contacts_repeaterPing => 'Pingar repetidor';

  @override
  String get contacts_roomPathTrace => 'Traçar caminho para o servidor da sala';

  @override
  String get contacts_roomPing => 'Pingar servidor da sala';

  @override
  String get contacts_chatTraceRoute => 'Rastrear rota do caminho';

  @override
  String contacts_pathTraceTo(String name) {
    return 'Rastrear rota para $name';
  }

  @override
  String get contacts_clipboardEmpty => 'Área de Transferência Está Vazia.';

  @override
  String get contacts_pasteNotContact =>
      'Isto não é um contacto MeshCore. Copie uma ligação ou anúncio meshcore:// e tente novamente.';

  @override
  String get contacts_invalidAdvertFormat => 'Dados de Contato Inválidos';

  @override
  String get contacts_contactImported => 'Contato foi importado.';

  @override
  String get contacts_contactImportFailed => 'Contato falhou ao ser importado.';

  @override
  String get contacts_zeroHopAdvert => 'Anúncio Zero Hop';

  @override
  String get contacts_floodAdvert => 'Anúncio de Inundação';

  @override
  String get contacts_copyAdvertToClipboard =>
      'Copiar Anúncio para Área de Transferência';

  @override
  String get contacts_addContactFromClipboard =>
      'Adicionar Contato da Área de Transferência';

  @override
  String get contacts_ShareContact =>
      'Copiar contato para Área de Transferência';

  @override
  String get contacts_ShareContactZeroHop => 'Compartilhar contato por anúncio';

  @override
  String get contacts_zeroHopContactAdvertSent => 'Enviou contato por anúncio.';

  @override
  String get contacts_zeroHopContactAdvertFailed => 'Falha ao enviar contato.';

  @override
  String get contacts_contactAdvertCopied =>
      'Anúncio copiado para a Área de Transferência.';

  @override
  String get contacts_contactAdvertCopyFailed =>
      'Cópia do anúncio para a Área de Transferência falhou.';

  @override
  String get notification_activityTitle => 'Atividade MeshCore';

  @override
  String notification_messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'mensagens',
      one: 'mensagem',
    );
    return '$count $_temp0';
  }

  @override
  String notification_channelMessagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'mensagens de canal',
      one: 'mensagem de canal',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'novos nós',
      one: 'novo nó',
    );
    return '$count $_temp0';
  }

  @override
  String notification_newTypeDiscovered(String contactType) {
    return 'Novo $contactType descoberto';
  }

  @override
  String get notification_receivedNewMessage => 'Nova mensagem recebida';

  @override
  String get settings_gpxExportRepeaters =>
      'Exportar repetidores / servidor de sala para GPX';

  @override
  String get settings_gpxExportRepeatersSubtitle =>
      'Exporta repetidores / roomserver com localização para arquivo GPX.';

  @override
  String get settings_gpxExportContacts => 'Exportar companheiros para GPX';

  @override
  String get settings_gpxExportContactsSubtitle =>
      'Exporta companheiros com uma localização para um arquivo GPX.';

  @override
  String get settings_gpxExportAll => 'Exportar todos os contatos para GPX';

  @override
  String get settings_gpxExportAllSubtitle =>
      'Exporta todos os contatos com uma localização para um arquivo GPX.';

  @override
  String get settings_gpxExportSuccess => 'Arquivo GPX exportado com sucesso.';

  @override
  String get settings_gpxExportNoContacts => 'Nenhum contato para exportar.';

  @override
  String get settings_gpxExportNotAvailable =>
      'Não suportado no seu dispositivo/SO';

  @override
  String get settings_gpxExportError => 'Ocorreu um erro ao exportar.';

  @override
  String get settings_gpxExportRepeatersRoom =>
      'Localizações do servidor de repetidor e sala';

  @override
  String get settings_gpxExportChat => 'Localizações de companheiros';

  @override
  String get settings_gpxExportAllContacts => 'Todos os locais de contatos';

  @override
  String get settings_gpxExportShareText =>
      'Dados do mapa exportados do NOTORYX Core';

  @override
  String get settings_gpxExportShareSubject =>
      'NOTORYX Core exportação de dados de mapa GPX';

  @override
  String get snrIndicator_nearByRepeaters => 'Repetidores Próximos';

  @override
  String get snrIndicator_lastSeen => 'Visto pela última vez';

  @override
  String get contactsSettings_title => 'Configurações de contatos';

  @override
  String get contactsSettings_autoAddTitle => 'Descoberta Automática';

  @override
  String get contactsSettings_otherTitle =>
      'Outras configurações relacionadas a contatos';

  @override
  String get contactsSettings_autoAddUsersTitle =>
      'Adicionar usuários automaticamente';

  @override
  String get contactsSettings_autoAddUsersSubtitle =>
      'Permitir que o companheiro adicione automaticamente os usuários descobertos.';

  @override
  String get contactsSettings_autoAddRepeatersTitle =>
      'Adicionar repetidores automaticamente';

  @override
  String get contactsSettings_autoAddRepeatersSubtitle =>
      'Permitir que o companheiro adicione automaticamente os repetidores descobertos.';

  @override
  String get contactsSettings_autoAddRoomServersTitle =>
      'Adicionar automaticamente servidores de sala';

  @override
  String get contactsSettings_autoAddRoomServersSubtitle =>
      'Permitir que o companheiro adicione automaticamente os servidores de salas descobertos.';

  @override
  String get contactsSettings_autoAddSensorsTitle =>
      'Adicionar sensores automaticamente';

  @override
  String get contactsSettings_autoAddSensorsSubtitle =>
      'Permitir que o companheiro adicione automaticamente sensores descobertos.';

  @override
  String get contactsSettings_overwriteOldestTitle =>
      'Sobrescrever o Mais Antigo';

  @override
  String get contactsSettings_overwriteOldestSubtitle =>
      'Quando a lista de contatos estiver cheia, o contato mais antigo não favoritado será substituído.';

  @override
  String get discoveredContacts_Title => 'Contatos Descobertos';

  @override
  String get discoveredContacts_noMatching => 'Nenhum contato correspondente';

  @override
  String get discoveredContacts_searchHint => 'Pesquisar contatos descobertos';

  @override
  String get discoveredContacts_contactAdded => 'Contato adicionado';

  @override
  String get discoveredContacts_addContact => 'Adicionar Contato';

  @override
  String get discoveredContacts_copyContact =>
      'Copiar Contato para a área de transferência';

  @override
  String get discoveredContacts_deleteContact => 'Excluir Contato';

  @override
  String get discoveredContacts_deleteContactAll =>
      'Excluir Todos os Contatos Descobertos';

  @override
  String get discoveredContacts_deleteContactAllContent =>
      'Tem certeza de que deseja excluir todos os contatos descobertos?';

  @override
  String get chat_sendCooldown =>
      'Por favor, aguarde um momento antes de reenviar.';

  @override
  String get appSettings_jumpToOldestUnread =>
      'Vá para a mensagem mais antiga não lida';

  @override
  String get appSettings_jumpToOldestUnreadSubtitle =>
      'Ao abrir uma conversa com mensagens não lidas, role para a primeira mensagem não lida, em vez da mais recente.';

  @override
  String get appSettings_languageHu => 'Húngaro';

  @override
  String get appSettings_languageJa => 'Japonês';

  @override
  String get appSettings_languageKo => 'Coreano';

  @override
  String get radioStats_tooltip => 'Estatísticas de rádio e malha';

  @override
  String get radioStats_screenTitle => 'Estatísticas de rádio';

  @override
  String get radioStats_notConnected =>
      'Conecte-se a um dispositivo para visualizar estatísticas de rádio.';

  @override
  String get radioStats_firmwareTooOld =>
      'As estatísticas de rádio exigem o firmware v8 ou uma versão mais recente.';

  @override
  String get radioStats_waiting => 'Aguardando dados…';

  @override
  String radioStats_noiseFloor(int noiseDbm) {
    return 'Nível de ruído: $noiseDbm dBm';
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
    return 'Tempo de transmissão da TX (total): $seconds s';
  }

  @override
  String radioStats_rxAir(int seconds) {
    return 'Tempo de uso do RX (total): $seconds s';
  }

  @override
  String get radioStats_chartCaption =>
      'Nível de ruído (dBm) em amostras recentes.';

  @override
  String radioStats_stripNoise(int noiseDbm) {
    return 'Nível de ruído: $noiseDbm dBm';
  }

  @override
  String get radioStats_stripWaiting => 'Obtendo estatísticas de rádio…';

  @override
  String get radioStats_settingsTile => 'Estatísticas de rádio';

  @override
  String get radioStats_settingsSubtitle =>
      'Nível de ruído, RSSI, SNR e tempo de transmissão';

  @override
  String get translation_title => 'Tradução';

  @override
  String get imageMessages_enableTitle => 'Mensagens de imagem';

  @override
  String get imageMessages_enableSubtitle =>
      'Envie as imagens pela malha. Requer o download de um modelo de imagem único.';

  @override
  String get imageMessages_modelSectionTitle => 'Modelo de imagem';

  @override
  String get imageMessages_downloadModel => 'Download';

  @override
  String get imageMessages_cancelDownload => 'Cancelar';

  @override
  String get imageMessages_removeModel => 'Remover modelo';

  @override
  String get imageMessages_modelReady => 'Pronto';

  @override
  String get imageMessages_modelNotPublished =>
      'Ainda não publicado — esta versão não pode baixá-lo.';

  @override
  String get imageMessages_downloadFailed =>
      'O modelo de imagem não pôde ser baixado.';

  @override
  String get imageMessages_autoProcessTitle =>
      'Processar imagens automaticamente';

  @override
  String get imageMessages_autoProcessSubtitle =>
      'Reconstrua cada imagem assim que ela chegar. Utiliza cerca de 2 GB de memória por segundo; dispense a reconstrução com um toque.';

  @override
  String get translation_enableTitle => 'Ativar a tradução';

  @override
  String get translation_enableSubtitle =>
      'Traduzir mensagens recebidas e permitir a tradução antes do envio.';

  @override
  String get translation_composerTitle => 'Traduza antes de enviar';

  @override
  String get translation_composerSubtitle =>
      'Controla o estado padrão do ícone de tradução do compositor.';

  @override
  String get translation_autoIncomingTitle =>
      'Traduzir mensagens automaticamente';

  @override
  String get translation_autoIncomingSubtitle =>
      'Traduz automaticamente mensagens para notificações e para chats ou canais.';

  @override
  String get translation_translateMessage => 'Traduzir mensagem';

  @override
  String get translation_targetLanguage => 'Língua-alvo';

  @override
  String get translation_useAppLanguage => 'Utilize o idioma da aplicação';

  @override
  String get translation_downloadedModelLabel => 'Modelo baixado';

  @override
  String get translation_presetModelLabel =>
      'Modelo pré-definido da Hugging Face';

  @override
  String get translation_manualUrlLabel => 'URL do modelo manual';

  @override
  String get translation_downloadModel => 'Baixar modelo';

  @override
  String get translation_downloading => 'Baixando...';

  @override
  String get translation_working => 'Trabalhando...';

  @override
  String get translation_stop => 'Pare';

  @override
  String get translation_mergingChunks =>
      'Combinando os fragmentos baixados em um único arquivo...';

  @override
  String get translation_downloadedModels => 'Modelos baixados';

  @override
  String get translation_deleteModel => 'Excluir modelo';

  @override
  String get translation_modelDownloaded => 'Modelo de tradução baixado.';

  @override
  String get translation_downloadStopped => 'Download interrompido.';

  @override
  String translation_downloadFailed(String error) {
    return 'Falha na descarga: $error';
  }

  @override
  String get translation_enterUrlFirst => 'Insira primeiro a URL do modelo.';

  @override
  String get scanner_linuxPairingShowPin => 'Mostrar PIN';

  @override
  String get scanner_linuxPairingHidePin => 'Ocultar PIN';

  @override
  String get scanner_linuxPairingPinTitle => 'PIN de emparelhamento Bluetooth';

  @override
  String scanner_linuxPairingPinPrompt(String deviceName) {
    return 'Insira o PIN para $deviceName (deixe em branco se não houver).';
  }

  @override
  String get translation_messageTranslation => 'Tradução da mensagem';

  @override
  String get translation_translateBeforeSending => 'Traduzir antes de enviar';

  @override
  String get translation_composerEnabledHint =>
      'As mensagens serão traduzidas antes de serem enviadas.';

  @override
  String get translation_composerDisabledHint =>
      'Envie mensagens no idioma original, conforme digitado.';

  @override
  String translation_translateTo(String language) {
    return 'Traduzir para $language';
  }

  @override
  String get translation_translationOptions => 'Opções de tradução';

  @override
  String get translation_systemLanguage => 'Idioma do sistema';

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
  String get map_zoomIn => 'Ampliar';

  @override
  String get map_zoomOut => 'Ampliar';

  @override
  String get map_centerMap => 'Mapa do centro';

  @override
  String get chrome_bluetoothRequiresChromium =>
      'O Web Bluetooth requer um navegador Chromium.';

  @override
  String channels_communityShortId(String id) {
    return 'ID: $id...';
  }

  @override
  String get pathTrace_legendGpsConfirmed => 'GPS confirmado';

  @override
  String get pathTrace_legendInferred => 'Posição inferida';

  @override
  String get pathMap_viewSingle => 'Único';

  @override
  String get pathMap_viewCombined => 'Combinado';

  @override
  String get pathMap_play => 'Reproduzir';

  @override
  String get pathMap_pause => 'Pausa';

  @override
  String get pathMap_replay => 'Repetir';

  @override
  String get pathMap_stepBack => 'Salto anterior';

  @override
  String get pathMap_stepForward => 'Próximo salto';

  @override
  String get pathMap_animationOn => 'Exibir animação do pacote';

  @override
  String get pathMap_animationOff => 'Ocultar a animação do pacote';

  @override
  String pathMap_hopOf(int current, int total) {
    return 'Salto $current de $total';
  }

  @override
  String pathMap_observedPaths(int count) {
    return 'Caminhos observados: $count';
  }

  @override
  String get pathMap_primary => 'Primário';

  @override
  String pathMap_alternate(int index) {
    return 'Alt $index';
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
  String get pathMap_legendShared => 'Segmento compartilhado';

  @override
  String get pathMap_legendEstimated => 'Segmento estimado';

  @override
  String pathMap_sharedNodeCount(int count) {
    return 'Utilizado em $count caminhos';
  }

  @override
  String pathMap_partialAnimation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saltos não têm localização — o caminho mostrado é parcial',
      one: '1 salto não tem localização — o caminho mostrado é parcial',
    );
    return '$_temp0';
  }

  @override
  String get pathMap_showAllPaths => 'Mostrar tudo';

  @override
  String get pathMap_hidePath => 'Esconder caminho';

  @override
  String get pathMap_showPath => 'Mostrar o caminho';

  @override
  String get pathMap_collapsePanel => 'Recolher painel';

  @override
  String get pathMap_expandPanel => 'Expandir painel';

  @override
  String get pathMap_noLocation => 'Sem localização';

  @override
  String get pathMap_followPacket => 'Fixar vista no pacote';

  @override
  String get pathMap_unfollowPacket => 'Liberar vista do pacote';

  @override
  String get imageSend_title => 'Enviar imagem';

  @override
  String get imageSend_cropNote =>
      'Redimensionado para 512 × 512 · a proporção de aspecto não foi preservada';

  @override
  String get imageSend_originalSize => 'Texto Original';

  @override
  String get imageSend_onAirSize => 'Ao ar';

  @override
  String get imageSend_quality => 'Qualidade';

  @override
  String get imageSend_qualityStandard => 'Padrão';

  @override
  String get imageSend_qualityHigh => 'Alto';

  @override
  String get imageSend_packetsLabel => 'Pacotes';

  @override
  String get imageSend_airtimeLabel => 'Tempo em transmissão';

  @override
  String get imageSend_sizeLabel => 'Carga útil';

  @override
  String imageSend_packetsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pacotes',
      one: 'pacote',
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
      'Configurações de rádio desconhecidas';

  @override
  String get imageSend_radioUnknownBody =>
      'Conecte-se a um dispositivo para que o horário de transmissão possa ser calculado.';

  @override
  String get imageSend_longSendTitle => 'Transmissão longa';

  @override
  String imageSend_longSendBody(String duration) {
    return 'Isso manterá o canal por cerca de $duration.';
  }

  @override
  String get imageSend_floodNote =>
      'Roteamento de inundação: cada repetidor na faixa retransmite cada pacote, fazendo com que o canal permaneça ocupado por mais tempo do que isso.';

  @override
  String get imageSend_parityTitle => 'Pacote de recuperação';

  @override
  String get imageSend_paritySubtitle =>
      'Um pacote extra. As mensagens em grupo não são reconhecidas, assim permitindo que o destinatário reconstrua a imagem caso um pacote seja perdido.';

  @override
  String get imageSend_send => 'Enviar';

  @override
  String get imageSend_cancel => 'Cancelar';

  @override
  String get imageSend_encodeFailed => 'Esta imagem não pode ser codificada.';

  @override
  String get imageSend_codecDownloading =>
      'O modelo de imagem ainda está baixando.';

  @override
  String get imageSend_codecUnavailable =>
      'O envio de imagem não está disponível neste dispositivo.';

  @override
  String get imageSend_codecDisabled =>
      'As mensagens de imagem estão desativadas nas configurações.';

  @override
  String get imageSend_deviceUnsupported =>
      'Este rádio não pode enviar pacotes de imagem. Conecte um dispositivo com firmware companheiro versão 13 ou superior.';

  @override
  String get imageSend_directMessagesUnsupported =>
      'As imagens viajam como dados em grupo, portanto, só podem ser enviadas para um canal — não em mensagem direta.';

  @override
  String get imageSend_tooLarge =>
      'Essa imagem foi codificada em mais pacotes do que o formato de malha permite.';

  @override
  String imageSend_sentConfirmation(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pacotes',
      one: 'pacote',
    );
    return 'Imagem enviada como $count $_temp0.';
  }

  @override
  String imageSend_sendFailed(String error) {
    return 'A imagem não pôde ser enviada: $error';
  }

  @override
  String imageSend_sendingProgress(int sent, int total) {
    return 'Envio da imagem — pacote $sent de $total';
  }

  @override
  String receivedImage_senderPrefix(String prefix) {
    return 'Nó $prefix';
  }

  @override
  String receivedImage_incoming(int received, int total) {
    return '$received de $total pacotes';
  }

  @override
  String get receivedImage_queued => 'Aguardando para decodificar';

  @override
  String get receivedImage_tapToDecode => 'Toque para decodificar';

  @override
  String get receivedImage_decoding => 'Reconstruindo… cerca de 1 segundo';

  @override
  String receivedImage_incomplete(int received, int total) {
    return 'Imagem incompleta — $received de $total pacotes chegaram';
  }

  @override
  String get receivedImage_corrupt => 'A imagem não pôde ser reconstruída';

  @override
  String get receivedImage_decoderMissing =>
      'Imagem recebida — decodificação de imagem incorreta';

  @override
  String get receivedImage_evicted => 'Imagem não armazenada';

  @override
  String get receivedImage_retry => 'Tente novamente';

  @override
  String get receivedImage_decodeAgain => 'Decodifique novamente';

  @override
  String get receivedImage_openSettings => 'Configurar';

  @override
  String get receivedImage_tapToProcess => 'Toque para processar';

  @override
  String receivedImage_awaiting(int bytes, int packets) {
    String _temp0 = intl.Intl.pluralLogic(
      packets,
      locale: localeName,
      other: 'pacotes',
      one: 'pacote',
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
  String get bastion_tagline => 'Comunicação sem infraestrutura.';

  @override
  String get bastion_nodes => 'Nós';

  @override
  String get bastion_repeaters => 'Repetidores';

  @override
  String get bastion_active1h => 'Ativos 1 h';

  @override
  String get bastion_mapCoverage => 'Mapa + cobertura';

  @override
  String get bastion_routeIntelligence => 'Inteligência de rotas';

  @override
  String get bastion_repeaterTools => 'Ferramentas de repetidor';

  @override
  String get bastion_fieldStats => 'Estatísticas de campo';

  @override
  String get bastion_fieldOps => 'Saída + operações de campo';

  @override
  String get bastion_coverageCapture => 'Captura de cobertura';

  @override
  String get bastion_mapAttribution =>
      'Dados do mapa © colaboradores do OpenStreetMap; blocos do fornecedor selecionado';

  @override
  String bastion_observationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count observações',
      one: '1 observação',
    );
    return '$_temp0';
  }

  @override
  String bastion_uniqueNodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nós únicos',
      one: '1 nó único',
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
      'Mantenha pressionado 2 segundos. Envia a sua posição aos contactos da saída a cada 5 minutos até alguém responder.';

  @override
  String sos_holdHintChannel(String channel) {
    return 'Mantenha pressionado 2 segundos. Envia a sua posição aos contactos da saída e a $channel a cada 5 minutos até alguém responder.';
  }

  @override
  String sos_notSent(String error) {
    return 'SOS não enviado: $error';
  }

  @override
  String sos_acknowledged(String name) {
    return 'Confirmado por $name. Repetições paradas.';
  }

  @override
  String get sos_waitingForRadio => 'À espera que o rádio envie…';

  @override
  String sos_repeatsFinished(int sends, int max) {
    return 'Enviado $sends de $max vezes. Repetições terminadas; ainda sem resposta.';
  }

  @override
  String sos_nextAt(int sends, int max, String time) {
    return 'Enviado $sends de $max vezes. Próximo às $time.';
  }

  @override
  String get sos_active => 'SOS ATIVO';

  @override
  String get sos_stop => 'PARAR';

  @override
  String get sos_imSafe => 'ESTOU EM SEGURANÇA';

  @override
  String get sos_holdSemantics => 'SOS. Mantenha pressionado para enviar.';

  @override
  String get sos_keepHolding => 'CONTINUE A PRESSIONAR…';

  @override
  String get sos_holdForSos => 'MANTENHA PARA SOS';

  @override
  String get sos_blockStorage =>
      'Resolva primeiro o erro de armazenamento do registo de campo.';

  @override
  String get sos_blockNotConnected =>
      'Ligue o seu rádio MeshCore para enviar um SOS.';

  @override
  String get sos_blockNoTarget =>
      'Escolha contactos da saída ou um canal SOS em Planear saída.';

  @override
  String get checkIn_labelOk => 'Estou bem';

  @override
  String get checkIn_labelAtCamp => 'No acampamento';

  @override
  String get checkIn_labelDelayed => 'Atrasado';

  @override
  String get checkIn_labelHeadingBack => 'A regressar';

  @override
  String get checkIn_blockLoading => 'A carregar a sua saída…';

  @override
  String get checkIn_blockStorage =>
      'Resolva o erro de armazenamento do registo de campo antes de enviar.';

  @override
  String get checkIn_blockBusy => 'Está a ser enviado um check-in. Aguarde.';

  @override
  String get checkIn_blockNoContacts =>
      'Escolha contactos da saída em Planear saída.';

  @override
  String get checkIn_blockRosterIncomplete =>
      'Alguns contactos da saída não estão disponíveis. Reveja a sua lista.';

  @override
  String get checkIn_blockNotConnected =>
      'Ligue o seu rádio MeshCore para fazer check-in.';

  @override
  String get checkIn_blockNotActive =>
      'Inicie a sua saída para ativar os check-ins.';

  @override
  String get checkIn_notSent => 'Não enviado';

  @override
  String checkIn_deliveredToOne(String name) {
    return 'Entregue a $name';
  }

  @override
  String checkIn_deliveredToAll(int count) {
    return 'Entregue aos $count contactos';
  }

  @override
  String checkIn_deliveredSome(String delivered, String total) {
    return 'Entregue a $delivered de $total';
  }

  @override
  String checkIn_notDeliveredTo(String names) {
    return 'Não entregue: $names';
  }

  @override
  String get checkIn_waitingForRest => 'À espera dos restantes';

  @override
  String get checkIn_aContact => 'um contacto';

  @override
  String get checkIn_statusPending => 'Pendente';

  @override
  String get checkIn_statusSent => 'Enviado';

  @override
  String get checkIn_statusDelivered => 'Entregue';

  @override
  String get checkIn_statusFailed => 'Falhou';

  @override
  String get checkIn_explainPending =>
      'Em fila localmente. Isto não confirma a transmissão por rádio nem a receção.';

  @override
  String get checkIn_explainSent =>
      'O rádio aceitou o envio. Não foi registada nenhuma confirmação de entrega.';

  @override
  String get checkIn_explainDelivered =>
      'A app registou uma confirmação de entrega. Não prova que a pessoa leu.';

  @override
  String get checkIn_explainFailed =>
      'Sem entrega confirmada. Verifique a ligação do rádio, a acessibilidade do destinatário e o histórico de tentativas.';

  @override
  String get checkIn_explainUnknown =>
      'O estado de entrega não está disponível. Não assuma que esta mensagem chegou.';

  @override
  String get tripBrief_heading => 'NOTORYX • Resumo de saída MeshCore';

  @override
  String tripBrief_trip(String name) {
    return 'Saída: $name';
  }

  @override
  String tripBrief_status(String status) {
    return 'Estado: $status';
  }

  @override
  String get tripBrief_active => 'Ativa';

  @override
  String get tripBrief_stopped => 'Parada';

  @override
  String tripBrief_contacts(String names) {
    return 'Contactos: $names';
  }

  @override
  String get tripBrief_noneSelected => 'Nenhum selecionado';

  @override
  String get tripBrief_unavailableContact =>
      'Contacto indisponível (reveja a lista)';

  @override
  String tripBrief_overdueAfter(int minutes) {
    return 'Atividade em atraso após: $minutes minutos (este telemóvel alerta quando um contacto fica em silêncio)';
  }

  @override
  String tripBrief_reminder(String value) {
    return 'Lembrete de check-in: $value';
  }

  @override
  String tripBrief_reminderEvery(int minutes) {
    return 'a cada $minutes minutos sem check-in';
  }

  @override
  String tripBrief_choices(String choices) {
    return 'Opções de check-in: $choices';
  }

  @override
  String tripBrief_position(String value) {
    return 'Posição do rádio nos check-ins: $value';
  }

  @override
  String get tripBrief_includedMayBeStale =>
      'Incluída; pode estar desatualizada';

  @override
  String tripBrief_battery(String value) {
    return 'Bateria do rádio nos check-ins: $value';
  }

  @override
  String get tripBrief_included => 'Incluída';

  @override
  String get tripBrief_off => 'Desativada';

  @override
  String get tripBrief_review =>
      'Reveja os destinatários e a mensagem antes de enviar um check-in.';

  @override
  String get tripBrief_noProof =>
      'Em fila ou enviado não prova a entrega. Uma confirmação não prova que foi lido.';

  @override
  String get tripBrief_overdueMeaning =>
      'Em atraso significa sem atividade recente do contacto; não é uma emergência confirmada.';

  @override
  String get tripBrief_automations =>
      'As automatizações de campo só funcionam enquanto a app está ativa. Combinem um plano separado para contacto falhado.';

  @override
  String get tripBrief_sharesOnly =>
      'Este resumo só partilha informação; não envia uma mensagem de rádio nem inicia uma saída.';

  @override
  String get fieldOps_title => 'Operações de campo NOTORYX Core';

  @override
  String get fieldOps_tabTrip => 'Saída';

  @override
  String get fieldOps_tabReady => 'Pronto';

  @override
  String get fieldOps_tabLog => 'Registo';

  @override
  String get fieldOps_tabAuto => 'Auto';

  @override
  String get fieldOps_tabCoverage => 'Cobertura';

  @override
  String get fieldOps_tabConnection => 'Ligação';

  @override
  String get fieldOps_diagnostics => 'Diagnóstico';

  @override
  String get fieldOps_storageLoadError =>
      'Não foi possível carregar os dados de campo. Os dados guardados foram mantidos; as automatizações continuam desativadas.';

  @override
  String get fieldOps_storageSaveError =>
      'Não foi possível guardar os dados de campo. Automatizações paradas; os dados já guardados são mantidos.';

  @override
  String get fieldOps_regionHint =>
      'Selecione uma área e níveis de zoom em Mapas offline.';

  @override
  String fieldOps_regionLabel(String source, String minZoom, String maxZoom) {
    return '$source • zoom $minZoom–$maxZoom';
  }

  @override
  String fieldOps_mapVerifyFailed(String error) {
    return 'Não foi possível verificar a área do mapa: $error';
  }

  @override
  String fieldOps_tripActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Saída ativa • $count contactos',
      one: 'Saída ativa • 1 contacto',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_tripStopped =>
      'Saída parada. Inicie-a quando estiver pronto.';

  @override
  String fieldOps_reminderAt(String time) {
    return 'Lembrete de check-in às $time';
  }

  @override
  String fieldOps_quietTooLong(String names) {
    return 'Em silêncio há demasiado tempo: $names';
  }

  @override
  String get fieldOps_planTrip => 'Planear saída';

  @override
  String get fieldOps_endTrip => 'Terminar saída';

  @override
  String get fieldOps_startTrip => 'Iniciar saída';

  @override
  String get fieldOps_tripBrief => 'Resumo da saída';

  @override
  String get fieldOps_connectRadio => 'Ligar rádio';

  @override
  String get fieldOps_previewedCheckIns => 'Check-ins com pré-visualização';

  @override
  String get fieldOps_previewedCheckInsHint =>
      'Escolha um estado, reveja os destinatários reais e a mensagem e depois envie. Em fila não significa entregue.';

  @override
  String get fieldOps_tripRoster => 'Lista da saída';

  @override
  String get fieldOps_rosterEmpty =>
      'Escolha até seis contactos de chat conhecidos em Planear saída.';

  @override
  String get fieldOps_rosterCaveat =>
      '«Ouvido pela última vez» é prova de atividade passada. Não estabelece acessibilidade atual. Os indicadores de atraso significam sem atividade recente do contacto, não uma emergência confirmada.';

  @override
  String get fieldOps_offlineMaps => 'Mapas offline';

  @override
  String get fieldOps_checkingTiles => 'A verificar blocos guardados…';

  @override
  String fieldOps_cachedTiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count blocos em cache.',
      one: '1 bloco em cache.',
    );
    return '$_temp0 Isto não garante que todo o seu percurso está coberto.';
  }

  @override
  String get fieldOps_downloadAreas => 'Transferir / inspecionar áreas offline';

  @override
  String fieldOps_lastCheckIn(String time) {
    return 'Último check-in, $time';
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
      other: 'Reenviar a $count não entregues',
      one: 'Reenviar a 1 não entregue',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_memberUnavailable => 'Contacto selecionado indisponível';

  @override
  String get fieldOps_memberUnavailableHint =>
      'Reveja esta saída antes de enviar.';

  @override
  String fieldOps_lastActivity(int minutes) {
    return 'Última atividade há $minutes min';
  }

  @override
  String fieldOps_lastActivityOverdue(int minutes) {
    return 'Última atividade há $minutes min • em atraso';
  }

  @override
  String get fieldOps_noCheckInRecorded =>
      'Nenhum check-in registado neste registo.';

  @override
  String get fieldOps_tripMap => 'Mapa da saída';

  @override
  String get fieldOps_tripMapEmpty =>
      'Nenhum contacto selecionado anunciou coordenadas ainda.';

  @override
  String get fieldOps_lastPositions => 'Últimas posições anunciadas';

  @override
  String get fieldOps_positionsCaveat =>
      'As posições podem estar desatualizadas. Este mapa não segue o GPS do telemóvel nem prova que os membros estão aqui agora.';

  @override
  String get fieldOps_briefPreviewTitle => 'Pré-visualizar resumo da saída';

  @override
  String get fieldOps_briefPreviewHint =>
      'Inclui nomes da saída e dos contactos. Reveja antes de partilhar. Coordenadas, chaves e histórico de mensagens são omitidos.';

  @override
  String get fieldOps_shareBrief => 'Partilhar resumo';

  @override
  String get fieldOps_briefSubject => 'Resumo de saída NOTORYX Core';

  @override
  String get fieldOps_tripName => 'Nome da saída';

  @override
  String get fieldOps_defaultTripName => 'A minha saída';

  @override
  String get fieldOps_includePosition =>
      'Incluir a posição anunciada pelo rádio';

  @override
  String get fieldOps_includePositionHint =>
      'Pode estar desatualizada; a partilha está desativada por predefinição.';

  @override
  String get fieldOps_includeBattery => 'Incluir bateria do rádio';

  @override
  String get fieldOps_overdueLabel =>
      'Alertar-me quando um contacto estiver em silêncio durante';

  @override
  String get fieldOps_reminderLabel => 'Lembrar-me de fazer check-in';

  @override
  String get fieldOps_reminderHelper =>
      'Uma notificação do telemóvel, mesmo com o NOTORYX Core fechado.';

  @override
  String get fieldOps_reminderOff => 'Desativado';

  @override
  String fieldOps_reminderAfter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Após $count minutos sem check-in',
      one: 'Após 1 minuto sem check-in',
    );
    return '$_temp0';
  }

  @override
  String get fieldOps_sosChannelLabel => 'O SOS também vai para o canal';

  @override
  String get fieldOps_sosChannelNone => 'Nenhum';

  @override
  String get fieldOps_selectContacts =>
      'Selecione até seis contactos de chat conhecidos';

  @override
  String get fieldOps_sendCheckInTitle => 'Enviar check-in?';

  @override
  String fieldOps_recipients(String names) {
    return 'Para: $names';
  }

  @override
  String get fieldOps_sendCheckInHint =>
      'Usa envios normais de mensagens diretas. A entrega será acompanhada no registo de campo.';

  @override
  String get fieldOps_send => 'Enviar';

  @override
  String get sosRelay_title => 'Retransmissão de SOS';

  @override
  String get sosRelay_enable => 'Retransmitir SOS que nenhum repetidor passou';

  @override
  String get sosRelay_needsFirmware =>
      'Requer firmware do rádio v1.16 ou mais recente';

  @override
  String get sosRelay_noneYet => 'Ainda nenhum SOS retransmitido';

  @override
  String sosRelay_relayedCount(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pacotes SOS retransmitidos, o último às $time',
      one: '1 pacote SOS retransmitido, o último às $time',
    );
    return '$_temp0';
  }

  @override
  String get sosRelay_explainer =>
      'Quando o rádio ouve um SOS diretamente do remetente e nenhum repetidor o passa em cerca de 15 segundos, o NOTORYX envia-o mais uma vez, sem alterações, para chegar a um repetidor que você ouve e o remetente não. Só são retransmitidos SOS dos seus canais. Gasta alguma bateria e tempo no ar, por isso está desligado por omissão.';

  @override
  String get fieldOps_beforeYouLeave => 'Antes de partir';

  @override
  String get fieldOps_radioConnected => 'Rádio ligado';

  @override
  String get fieldOps_connectHint => 'Ligue por Bluetooth, USB ou TCP.';

  @override
  String get fieldOps_radioBattery => 'Bateria do rádio';

  @override
  String get fieldOps_batteryUnknown => 'Desconhecida; inspecione o rádio.';

  @override
  String fieldOps_batteryDetail(String percent) {
    return '$percent% • carregue para a saída planeada.';
  }

  @override
  String get fieldOps_tripContacts => 'Contactos da saída';

  @override
  String fieldOps_tripContactsDetail(String available, String selected) {
    return '$available/$selected disponíveis. Verifique se têm rádios e canais compatíveis.';
  }

  @override
  String get fieldOps_offlineArea => 'Área de mapa offline selecionada';

  @override
  String get fieldOps_checkingFiles => 'A verificar ficheiros locais…';

  @override
  String fieldOps_regionStatus(
    String available,
    String expected,
    String missing,
  ) {
    return '$available/$expected ficheiros de blocos disponíveis; faltam $missing. Isto é um instantâneo; abra a área offline antes de partir.';
  }

  @override
  String get fieldOps_locationChoice => 'Partilha de localização';

  @override
  String get fieldOps_locationOptedIn =>
      'Ativada: as coordenadas anunciadas pelo rádio podem estar desatualizadas.';

  @override
  String get fieldOps_locationOff =>
      'A partilha está desativada. Os seus check-ins omitem as coordenadas.';

  @override
  String get fieldOps_automationAvailability =>
      'Disponibilidade das automatizações';

  @override
  String get fieldOps_automationAvailabilityDetail =>
      'Só funciona enquanto esta app está ativa. Suspensão, fecho ou perda do rádio podem impedir ações agendadas.';

  @override
  String get fieldOps_readinessCaveat =>
      'As verificações são indicativas; não provam o alcance do rádio nem garantem a entrega de mensagens.';

  @override
  String get fieldOps_radio => 'Rádio';

  @override
  String get fieldOps_refreshChecks => 'Atualizar verificações';

  @override
  String get fieldOps_searchLog => 'Pesquisar no registo de campo';

  @override
  String get fieldOps_kindAll => 'Tudo';

  @override
  String get fieldOps_kindCheckIn => 'Check-in';

  @override
  String get fieldOps_kindReceived => 'Recebido';

  @override
  String get fieldOps_kindNote => 'Nota';

  @override
  String get fieldOps_kindDeadZone => 'Zona sem cobertura';

  @override
  String get fieldOps_kindRadio => 'Rádio';

  @override
  String get fieldOps_kindAutomation => 'Automatização';

  @override
  String get fieldOps_kindMissed => 'Falhado';

  @override
  String get fieldOps_kindSos => 'SOS';

  @override
  String get fieldOps_kindTrip => 'Saída';

  @override
  String get fieldOps_kindOverdue => 'Em atraso';

  @override
  String get fieldOps_addNote => 'Adicionar nota';

  @override
  String get fieldOps_exportJson => 'Exportar JSON';

  @override
  String get fieldOps_deleteLog => 'Eliminar registo';

  @override
  String get fieldOps_logSubject => 'Registo de campo NOTORYX Core';

  @override
  String get fieldOps_logCaveat =>
      'Guardado localmente, até 1000 entradas. As exportações podem conter chaves de contactos, mensagens e localizações; reveja antes de partilhar.';

  @override
  String get fieldOps_noEntries => 'Nenhuma entrada correspondente.';

  @override
  String get fieldOps_tripUnspecified => 'Saída não especificada';

  @override
  String fieldOps_entryStatus(String status, String explanation) {
    return '$status: $explanation';
  }

  @override
  String fieldOps_entryPosition(String latitude, String longitude) {
    return 'Posição anunciada pelo rádio registada $latitude, $longitude (pode estar desatualizada)';
  }

  @override
  String get fieldOps_noteTitle => 'Observação de campo';

  @override
  String get fieldOps_noteLabel => 'O que observou?';

  @override
  String get fieldOps_deadZone => 'Zona sem cobertura reportada';

  @override
  String get fieldOps_deadZoneHint =>
      'A sua observação, não uma previsão de cobertura verificada.';

  @override
  String get fieldOps_savePosition => 'Guardar a posição anunciada pelo rádio';

  @override
  String fieldOps_positionDetail(String latitude, String longitude) {
    return '$latitude, $longitude • pode estar desatualizada; não é o GPS do telemóvel';
  }

  @override
  String get fieldOps_noPosition => 'Sem coordenadas anunciadas utilizáveis';

  @override
  String get fieldOps_deleteLogTitle => 'Eliminar o registo de campo?';

  @override
  String get fieldOps_deleteLogBody =>
      'Isto remove todas as entradas guardadas neste telemóvel. As definições da saída são mantidas.';

  @override
  String get fieldOps_localAutomations => 'Automatizações locais';

  @override
  String get fieldOps_enableForTrip => 'Ativar para esta saída';

  @override
  String get fieldOps_automationsCaveat =>
      'Desativam-se após cada reinício da app. As regras só funcionam enquanto a app está ativa. Ações agendadas falhadas aparecem no registo de campo e nunca são repetidas em rajada. Os check-ins automáticos estão limitados a um lote a cada 10 minutos.';

  @override
  String get fieldOps_openBotMode => 'Abrir o modo bot do NOTORYX';

  @override
  String get fieldOps_ruleEnabled => 'Regra ativada';

  @override
  String get fieldOps_dryRun => 'Simulação';

  @override
  String get fieldOps_dryRunHint => 'Registar a ação sem enviar nem notificar.';

  @override
  String get fieldOps_then => 'Então';

  @override
  String get fieldOps_actionLog => 'Escrever no registo de campo';

  @override
  String get fieldOps_actionNotify => 'Mostrar notificação local';

  @override
  String get fieldOps_actionCheckIn =>
      'Enviar «I\'m OK» aos contactos da saída';

  @override
  String get fieldOps_batteryThreshold => 'Bateria igual ou inferior a';

  @override
  String fieldOps_nextDue(String time) {
    return 'Próximo: $time';
  }

  @override
  String get fieldOps_nextDueNone => 'Próximo: não agendado';

  @override
  String get fieldOps_previewInLog => 'Pré-visualizar no registo';

  @override
  String get fieldOps_allowNotifications => 'Permitir notificações';

  @override
  String get fieldOps_triggerReconnect => 'QUANDO o rádio voltar a ligar';

  @override
  String get fieldOps_triggerDisconnect => 'QUANDO o rádio desligar';

  @override
  String get fieldOps_triggerLowBattery =>
      'QUANDO a bateria do rádio passar o limite';

  @override
  String get fieldOps_triggerNewNode => 'QUANDO for adicionado um novo nó';

  @override
  String get fieldOps_triggerRepeater =>
      'QUANDO for adicionado um novo repetidor';

  @override
  String get fieldOps_triggerScheduled =>
      'QUANDO for hora de um check-in agendado';

  @override
  String get fieldOps_explainConnection => 'Explicar a minha ligação';

  @override
  String fieldOps_connectionState(String state, String transport) {
    return 'Estado: $state • $transport';
  }

  @override
  String get fieldOps_connectedCaveat =>
      'O telemóvel tem ligação ao rádio. Isso por si só não estabelece uma rota até aos seus destinatários.';

  @override
  String get fieldOps_disconnectedHint =>
      'Sem ligação de rádio ativa. Verifique as permissões de Bluetooth, a alimentação e o alcance do rádio; USB/TCP estão disponíveis em Ligar rádio.';

  @override
  String fieldOps_awaitingConfirmation(int count) {
    return 'Check-ins da saída à espera de confirmação: $count';
  }

  @override
  String get fieldOps_staleCaveat =>
      'As horas de última visualização e as posições anunciadas dos nós podem estar desatualizadas. A inteligência de rotas mostra rotas aprendidas com tentativas observadas; não inventa caminhos.';

  @override
  String get fieldOps_routeIntelligence => 'Inteligência de rotas';

  @override
  String get fieldOps_coverageIntelligence => 'Inteligência de cobertura';

  @override
  String get fieldOps_coverageIntelligenceHint =>
      'Compare observações registadas entre duas sessões de campo. Os pontos marcam as posições anunciadas pelo rádio do registador onde nós foram ouvidos. Não implicam cobertura contínua. Os instantâneos RSSI/SNR não são medições por nó.';

  @override
  String get fieldOps_captureSession => 'Capturar uma sessão';

  @override
  String get fieldOps_refreshHistory => 'Atualizar histórico';

  @override
  String get fieldOps_noCoverageSessions =>
      'Ainda não há sessões de cobertura guardadas.';

  @override
  String get fieldOps_sessionA => 'Sessão A • verde-azulado';

  @override
  String get fieldOps_sessionB => 'Sessão B • âmbar';

  @override
  String fieldOps_uniqueCompare(String a, String b) {
    return 'A: $a nós únicos • B: $b nós únicos';
  }

  @override
  String fieldOps_overlap(String shared, String onlyA, String onlyB) {
    return 'Partilhados: $shared • Só A: $onlyA • Só B: $onlyB';
  }

  @override
  String get fieldOps_compareCaveat =>
      'Não ouvir um nó durante uma sessão não estabelece uma zona sem cobertura. As condições e a duração da observação diferem.';

  @override
  String get fieldOps_heardTooltip =>
      'Observação de nó ouvido; não prova uma ligação bem-sucedida';

  @override
  String get fieldOps_noteTooltip =>
      'Nota local nas coordenadas anunciadas pelo rádio; pode estar desatualizada.';

  @override
  String get bastionHome_aboutTooltip => 'Acerca do NOTORYX Core';

  @override
  String get bastionHome_getStarted => 'Começar';

  @override
  String get bastionHome_getStartedHint =>
      'Ligue o seu rádio e verifique a sua primeira mensagem';

  @override
  String get bastionHome_planYourTrip => 'Planeie a sua saída';

  @override
  String get bastionHome_tripActive => 'Saída ativa';

  @override
  String get bastionHome_tripStopped => 'Saída parada';

  @override
  String bastionHome_tripSummary(String state, String contacts, String unread) {
    return '$state • $contacts contactos • $unread mensagens não lidas';
  }

  @override
  String get bastionHome_checkInOk => 'Check-in: estou bem';

  @override
  String get bastionHome_checkInHint =>
      'Reveja os contactos e a mensagem antes de enviar. Acompanhe as confirmações no registo de campo.';

  @override
  String bastionHome_lastCheckIn(String summary) {
    return 'Último check-in: $summary';
  }

  @override
  String get bastionHome_connectRadio => 'Ligar rádio';

  @override
  String get bastionHome_connectRadioHint =>
      'Ligações MeshCore por Bluetooth, USB e TCP';

  @override
  String get bastionHome_liveDiagnostics => 'Diagnóstico em direto';

  @override
  String get bastionHome_liveDiagnosticsHint =>
      'Estado do rádio, sinal, dispositivo e ferramentas de tramas';

  @override
  String get bastionHome_meshDiscovery => 'Descoberta da malha';

  @override
  String get bastionHome_meshDiscoveryHint =>
      'Encontre nós e inspecione a malha à sua volta';

  @override
  String get bastionHome_fieldOpsHint =>
      'Resumo da saída, preparação, registo de campo, automatizações e comparação de cobertura';

  @override
  String get bastionHome_fieldTools => 'Ferramentas de campo NOTORYX';

  @override
  String get bastionHome_statusActive => 'ATIVO';

  @override
  String get bastionHome_consoleOnline => 'Consola de campo online';

  @override
  String get bastionHome_consoleReady => 'Consola de campo pronta';

  @override
  String get bastionHome_consoleHint =>
      'Ligue um rádio para ativar o painel em direto.';

  @override
  String bastionHome_battery(String value) {
    return 'Bat $value';
  }

  @override
  String get bastionTools_title => 'Ferramentas de campo';

  @override
  String get bastionTools_backup => 'Cópia de segurança cifrada';

  @override
  String get bastionTools_backupHint =>
      'Guarde definições, contactos e chaves, com histórico de chat opcional';

  @override
  String get bastionTools_fieldOpsHint =>
      'Check-ins, preparação, registo de campo, automatizações e comparações';

  @override
  String get bastionTools_mapHint =>
      'Mapa em direto, sessões de captura, ferramentas de mapas offline e regiões';

  @override
  String get bastionTools_pathAnalysis => 'Análise de caminhos';

  @override
  String get bastionTools_pathHint =>
      'Rotas, descoberta e inteligência de caminhos';

  @override
  String get bastionTools_repeaterHint =>
      'Estado, início de sessão, telemetria, vizinhos e administração';

  @override
  String get bastionTools_statsHint =>
      'Contagens da malha em direto e atividade dos contactos';

  @override
  String get bastionTools_diagnostics => 'Diagnóstico';

  @override
  String get bastionTools_diagnosticsHint =>
      'Estado do rádio, informação do dispositivo, tramas em bruto e exportação';

  @override
  String get bastionTools_about => 'Acerca + créditos';

  @override
  String get bastionTools_aboutHint =>
      'Versão do NOTORYX Core, declaração de independência e licenças de código aberto';

  @override
  String get bastionAbout_title => 'Acerca + Créditos';

  @override
  String get bastionAbout_intro =>
      'Uma app comunitária independente para redes MeshCore. O NOTORYX Core não é uma app oficial MeshCore e a inclusão de recursos da comunidade não implica parceria nem aprovação.';

  @override
  String get bastionAbout_version => 'Versão';

  @override
  String get bastionAbout_openSource => 'Base de código aberto';

  @override
  String get bastionAbout_openSourceBody =>
      'O NOTORYX Core é construído a partir do código aberto MeshCore Open sob a licença MIT, que modifica. O trabalho no fluxo de cobertura também credita, quando aplicável, a MeshMapper Flutter App com licença MIT.';

  @override
  String get bastionAbout_community => 'A comunidade primeiro';

  @override
  String get bastionAbout_communityBody =>
      'Os recursos de criadores terceiros continuam a ser propriedade dos respetivos criadores. Não se implica propriedade nem parceria.';

  @override
  String get bastionAbout_legalese =>
      'NOTORYX Core • Companheiro MeshCore independente';

  @override
  String get bastionAbout_licenses => 'Licenças de código aberto';

  @override
  String get bastionSetup_title => 'Começar com o NOTORYX Core';

  @override
  String get bastionSetup_intro =>
      'Ligue, escolha um contacto e depois verifique uma mensagem. Pode voltar a este guia a partir do painel a qualquer momento.';

  @override
  String get bastionSetup_step1 => '1. Ligue o seu rádio MeshCore';

  @override
  String bastionSetup_connectedTo(String device, String transport) {
    return 'Ligado a $device através de $transport.';
  }

  @override
  String get bastionSetup_noRadio => 'Ainda não há nenhum rádio ligado.';

  @override
  String get bastionSetup_step1Power =>
      'Ligue um rádio companheiro MeshCore. Abra Ligar rádio e escolha Bluetooth, USB ou TCP. Conceda as permissões pedidas para a ligação escolhida.';

  @override
  String get bastionSetup_step1Bluetooth =>
      'Se a pesquisa Bluetooth estiver vazia, verifique se o Bluetooth está ativo e se o NOTORYX Core tem a permissão Dispositivos próximos nas definições de apps do Android. Siga qualquer outro pedido de permissão mostrado pelo scanner.';

  @override
  String get bastionSetup_connectionDiagnostics => 'Diagnóstico da ligação';

  @override
  String get bastionSetup_step2 => '2. Escolha um contacto de chat';

  @override
  String get bastionSetup_step2Body =>
      'Peça a um parceiro próximo com definições de rádio MeshCore compatíveis que anuncie o seu nó. Escolha abaixo um contacto de chat conhecido; os repetidores são geridos à parte.';

  @override
  String get bastionSetup_noContacts =>
      'Sem contactos de chat disponíveis. Ligue o seu rádio e abra Descoberta da malha.';

  @override
  String get bastionSetup_testRecipient => 'Destinatário de teste';

  @override
  String get bastionSetup_meshDiscovery => 'Descoberta da malha';

  @override
  String get bastionSetup_step3 => '3. Envie e verifique uma mensagem';

  @override
  String get bastionSetup_step3Body =>
      'Abra o chat, escreva uma mensagem de teste curta, reveja o destinatário e toque em Enviar. Volte aqui para ver a última mensagem enviada registada desde que abriu este guia.';

  @override
  String get bastionSetup_openTestChat => 'Abrir chat de teste';

  @override
  String get bastionSetup_connectFirst =>
      'Ligue o seu rádio para abrir o chat de teste.';

  @override
  String get bastionSetup_chooseRecipient =>
      'Escolha primeiro um destinatário.';

  @override
  String get bastionSetup_noTestMessage =>
      'Nenhuma mensagem de teste enviada registada nesta sessão do guia.';

  @override
  String bastionSetup_latestMessage(String status, String time) {
    return 'Última mensagem: $status • $time';
  }

  @override
  String get bastionSetup_confirmReceipt =>
      'Peça ao seu parceiro para confirmar a receção ou responder. Uma confirmação registada não prova que leu. Volte a verificar a ligação e o destinatário se uma mensagem falhar.';

  @override
  String get bastionSetup_step4 => '4. Prepare-se para o campo';

  @override
  String get bastionSetup_step4Body =>
      'Planeie os contactos da saída e inspecione as áreas de mapa transferidas. O modo bot e as automatizações de campo começam desativados; as automatizações de campo só funcionam enquanto a app está ativa.';

  @override
  String get bastionSetup_tripTools => 'Ferramentas de saída e preparação';

  @override
  String get bastionDiag_title => 'Diagnóstico';

  @override
  String get bastionDiag_export => 'Exportar diagnóstico';

  @override
  String get bastionDiag_channels => 'Canais';

  @override
  String get bastionDiag_radio => 'Rádio';

  @override
  String get bastionDiag_frequency => 'Frequência';

  @override
  String get bastionDiag_bandwidth => 'Largura de banda';

  @override
  String get bastionDiag_spreadingFactor => 'Fator de espalhamento';

  @override
  String get bastionDiag_codingRate => 'Taxa de codificação';

  @override
  String get bastionDiag_txPower => 'Potência TX';

  @override
  String get bastionDiag_noiseFloor => 'Nível de ruído';

  @override
  String get bastionDiag_device => 'Dispositivo';

  @override
  String get bastionDiag_name => 'Nome';

  @override
  String get bastionDiag_manufacturer => 'Fabricante';

  @override
  String get bastionDiag_firmware => 'Firmware';

  @override
  String get bastionDiag_battery => 'Bateria';

  @override
  String get bastionDiag_transport => 'Transporte';

  @override
  String get bastionDiag_deepTools => 'Ferramentas avançadas';

  @override
  String get bastionDiag_liveStats => 'Estatísticas de rádio em direto';

  @override
  String get bastionDiag_liveStatsHint => 'Ruído, RSSI, SNR e tempo no ar';

  @override
  String get bastionDiag_frameDebug => 'Depuração de tramas / BLE';

  @override
  String get bastionDiag_frameDebugHint =>
      'Inspecione tramas recebidas descodificadas e em bruto';

  @override
  String get bastionDiag_appLog => 'Registo de depuração da app';

  @override
  String get bastionDiag_appLogHint =>
      'Reveja eventos de diagnóstico da aplicação';

  @override
  String get bastionDiag_online => 'Rádio online';

  @override
  String get bastionDiag_offline => 'Rádio offline';

  @override
  String get bastionDiag_offlineHint =>
      'Ligue um companheiro MeshCore para preencher o diagnóstico em direto.';

  @override
  String get coverage_title => 'Captura de cobertura';

  @override
  String get coverage_leaveBlocked => 'Pare e guarde a sessão antes de sair.';

  @override
  String get coverage_savedSessions => 'Sessões guardadas';

  @override
  String get coverage_caveat =>
      'RSSI/SNR são instantâneos do rádio e podem pertencer a outro pacote. As posições são coordenadas anunciadas pelo rádio, não GPS do telemóvel nem prova de cobertura. Ciano: registador; âmbar: nó anunciado. Não é feita interpolação.';

  @override
  String get coverage_captureActive => 'Captura ativa';

  @override
  String get coverage_fieldSession => 'Sessão de cobertura de campo';

  @override
  String get coverage_connectedBody =>
      'O NOTORYX Core regista os nós recém-ouvidos durante esta sessão, incluindo dados de rota, metadados de nó/localização e o instantâneo RSSI/SNR do rádio mais próximo disponível.';

  @override
  String get coverage_disconnectedBody =>
      'Ligue um rádio antes de começar. A captura de cobertura regista observações da malha em direto a partir do rádio companheiro ligado.';

  @override
  String get coverage_observations => 'Observações';

  @override
  String get coverage_uniqueNodes => 'Nós únicos';

  @override
  String get coverage_elapsed => 'Decorrido';

  @override
  String get coverage_radioConnected => 'Rádio ligado';

  @override
  String get coverage_noRadio => 'Sem rádio';

  @override
  String get coverage_gpsReady => 'GPS do rádio pronto';

  @override
  String get coverage_noGps => 'Sem GPS do rádio';

  @override
  String get coverage_stopSave => 'Parar + guardar sessão';

  @override
  String get coverage_start => 'Iniciar sessão de cobertura';

  @override
  String get coverage_exportJson => 'Exportar JSON';

  @override
  String get coverage_exportCsv => 'Exportar CSV';

  @override
  String get coverage_liveObservations => 'Observações em direto';

  @override
  String get coverage_waiting => 'À espera de atividade da malha';

  @override
  String get coverage_waitingBody =>
      'Inicie uma sessão e os nós ativos recém-ouvidos aparecerão aqui. Os valores RSSI/SNR são instantâneos do rádio e nem sempre podem ser atribuídos a um pacote específico.';

  @override
  String get coverage_signalNa => 'sinal n/d';

  @override
  String get coverage_snrNa => 'SNR n/d';

  @override
  String get coverage_gpsUnavailable => 'GPS do rádio indisponível';

  @override
  String coverage_pathLine(String path, String location) {
    return 'Caminho: $path  •  $location';
  }

  @override
  String get coverage_pathFlood => 'inundação';

  @override
  String get coverage_pathDirect => 'direto';

  @override
  String get coverage_shareSubject => 'Sessão de cobertura NOTORYX Core';

  @override
  String get coverage_shareText =>
      'Exportação de captura de cobertura NOTORYX Core';

  @override
  String get coverage_historyTitle => 'Sessões de cobertura guardadas';

  @override
  String coverage_loadFailed(String error) {
    return 'Não foi possível carregar as sessões: $error';
  }

  @override
  String get coverage_deleteTitle => 'Eliminar a sessão guardada?';

  @override
  String coverage_deleteBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count observações serão removidas deste dispositivo.',
      one: '1 observação será removida deste dispositivo.',
    );
    return '$_temp0';
  }

  @override
  String coverage_deleteFailed(String error) {
    return 'Não foi possível eliminar a sessão: $error';
  }

  @override
  String get coverage_retention =>
      'São mantidas as 20 sessões concluídas mais recentes. Partilhe as sessões que quer guardar. Capturas interrompidas podem ser reabertas abaixo.';

  @override
  String get coverage_noSessions =>
      'Ainda não há sessões guardadas. Pare uma captura para a guardar.';

  @override
  String get coverage_interrupted => 'Captura interrompida';

  @override
  String get coverage_saved => 'Guardada';

  @override
  String get coverage_deleteTooltip => 'Eliminar sessão';

  @override
  String coverage_exportFailed(String error) {
    return 'Falha na exportação: $error';
  }

  @override
  String get coverage_sessionTitle => 'Sessão de cobertura';

  @override
  String get coverage_shareJson => 'Partilhar JSON';

  @override
  String get coverage_shareCsv => 'Partilhar CSV';

  @override
  String coverage_snapshotDetail(String rssi, String snr, String age) {
    return '$rssi dBm • SNR $snr dB • idade do instantâneo $age ms';
  }

  @override
  String get coverage_unknown => 'desconhecida';

  @override
  String coverage_pathValue(String path) {
    return 'caminho $path';
  }

  @override
  String get coverage_recorder => 'Registador';

  @override
  String get coverage_noCoordinates =>
      'Sem coordenadas utilizáveis nesta sessão. As observações continuam disponíveis abaixo.';

  @override
  String get coverage_osmAttribution =>
      '© colaboradores do OpenStreetMap • mapa base online';

  @override
  String get fieldStats_title => 'Inteligência de campo';

  @override
  String get fieldStats_chatNodes => 'Nós de chat';

  @override
  String get fieldStats_rooms => 'Salas';

  @override
  String get fieldStats_sensors => 'Sensores';

  @override
  String get fieldStats_direct => 'Diretos';

  @override
  String get mapHub_title => 'Mapa de campo NOTORYX';

  @override
  String get mapHub_intro =>
      'Mapas em direto, áreas offline, perfis regionais e sessões de cobertura de campo do NOTORYX Core.';

  @override
  String get mapHub_captureHint =>
      'Inicie e pare uma sessão de cobertura de campo';

  @override
  String get mapHub_badgeNew => 'NOVO';

  @override
  String get mapHub_liveMap => 'Mapa da malha em direto';

  @override
  String get mapHub_liveMapHint =>
      'Nós, repetidores, posições, rotas e ferramentas de mapa';

  @override
  String get mapHub_badgeLive => 'DIRETO';

  @override
  String get mapHub_offlinePacks => 'Pacotes de mapas offline';

  @override
  String get mapHub_offlinePacksHint =>
      'Guarde blocos de mapa para saídas e zonas sem rede';

  @override
  String get mapHub_badgeOffline => 'OFFLINE';

  @override
  String get mapHub_regions => 'Perfis de região';

  @override
  String get mapHub_regionsHint =>
      'Gira e obtenha definições regionais da malha';

  @override
  String get mapHub_badgeRegions => 'REGIÕES';

  @override
  String get routes_title => 'Inteligência de rotas';

  @override
  String get routes_headline => 'Veja como o tráfego circula pela malha.';

  @override
  String get routes_body =>
      'O NOTORYX Core classifica as rotas guardadas usando o histórico de caminhos já aprendido com tentativas reais de mensagens e descobertas.';

  @override
  String get routes_routes => 'Rotas';

  @override
  String get routes_success => 'Sucesso';

  @override
  String get routes_failed => 'Falhadas';

  @override
  String get routes_routeMap => 'Mapa de rotas';

  @override
  String get routes_routeMapHint => 'Inspecione nós e caminhos';

  @override
  String get routes_discover => 'Descobrir';

  @override
  String get routes_discoverHint => 'Encontre novas rotas';

  @override
  String get routes_learned => 'Rotas aprendidas';

  @override
  String get routes_none => 'Ainda sem histórico de rotas';

  @override
  String get routes_noneBody =>
      'Use a malha normalmente ou execute uma descoberta. O NOTORYX Core mostrará aqui as rotas aprendidas à medida que houver histórico de caminhos.';

  @override
  String get routes_direct => 'DIRETO';

  @override
  String routes_routeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rotas',
      one: '1 rota',
    );
    return '$_temp0';
  }

  @override
  String routes_best(String path) {
    return 'MELHOR  $path';
  }

  @override
  String routes_bestDetail(
    String hops,
    String weight,
    String success,
    String fail,
  ) {
    return '$hops  •  peso $weight  •  $success sucessos / $fail falhas';
  }

  @override
  String routes_fastest(String ms) {
    return 'Mais rápida conhecida: $ms ms';
  }

  @override
  String routes_flood(String success, String fail) {
    return 'Inundação: $success sucessos / $fail falhas';
  }

  @override
  String get repeaterTools_unnamed => 'Repetidor sem nome';

  @override
  String get repeaterTools_empty =>
      'Ainda não foram descobertos repetidores. Ligue um rádio e descubra a malha primeiro.';

  @override
  String get notification_fieldAlertTitle => 'Alerta de campo NOTORYX';

  @override
  String get notification_checkInReminderTitle =>
      'Lembrete de check-in NOTORYX Core';

  @override
  String notification_checkInReminderBody(int minutes, String trip) {
    return 'Sem check-in há $minutes minutos em $trip. Abra o NOTORYX Core para fazer check-in.';
  }

  @override
  String notification_overdueBody(String name, int minutes) {
    return 'Sem notícias de $name há $minutes minutos. Não é uma emergência confirmada.';
  }

  @override
  String get notification_aTripContact => 'Um contacto da saída';

  @override
  String notification_checkInNotDelivered(String name) {
    return 'Check-in não entregue a $name. Pode reenviá-lo a partir de Saída.';
  }

  @override
  String notification_sosAcknowledged(String name) {
    return 'SOS confirmado por $name';
  }

  @override
  String get settings_batterySaver => 'Poupança de bateria';

  @override
  String get settings_batterySaverOn =>
      'Ativado: bateria do rádio a cada 10 min, GPS a cada 5 min, estatísticas no máximo uma vez por minuto, verificações da saída a cada 1–2 min. Mensagens, alertas e SOS não mudam.';

  @override
  String get settings_batterySaverOff =>
      'Verificar o rádio e a saída com menos frequência para poupar a bateria do telemóvel e do rádio. Mensagens, alertas e SOS não mudam.';

  @override
  String get settings_readAloud => 'Ler novas mensagens em voz alta';

  @override
  String get settings_readAloudHelper =>
      'Enquanto o NOTORYX Core estiver aberto. Canais silenciados ficam em silêncio. Qualquer mensagem também pode ser lida a partir do seu menu.';

  @override
  String get settings_readAloudOff => 'Desativado';

  @override
  String get settings_readAloudDirect => 'Mensagens diretas';

  @override
  String get settings_readAloudAll => 'Mensagens diretas e de canal';

  @override
  String get chat_readAloud => 'Ler em voz alta';

  @override
  String get messageSearch_title => 'Pesquisar mensagens';

  @override
  String get messageSearch_intro =>
      'Pesquise em todas as mensagens diretas e de canal guardadas neste telemóvel.';

  @override
  String messageSearch_noResults(String query) {
    return 'Nenhuma mensagem contém «$query».';
  }

  @override
  String messageSearch_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count resultados',
      one: '1 resultado',
    );
    return '$_temp0';
  }

  @override
  String messageSearch_capped(int count) {
    return 'A mostrar os $count resultados mais recentes';
  }

  @override
  String get shortcuts_checkIn => 'Check-in';

  @override
  String get shortcuts_trip => 'Saída';

  @override
  String get shortcuts_chats => 'Chats';

  @override
  String get shortcuts_map => 'Mapa';

  @override
  String get sensor_liveUpdates => 'Atualizações em direto';

  @override
  String get sensor_intro =>
      'Faça o sensor enviar as leituras sozinho quando mudam, em vez de perguntar sempre. Requer início de sessão com acesso de leitura.';

  @override
  String get sensor_watch => 'Vigiar alterações';

  @override
  String get sensor_loadFirst =>
      'Carregue primeiro a telemetria para escolher leituras.';

  @override
  String sensor_watching(String readings, String time) {
    return 'A vigiar $readings até às $time.';
  }

  @override
  String sensor_watchingRegion(String readings, String time, String region) {
    return 'A vigiar $readings até às $time • região $region.';
  }

  @override
  String get sensor_noChanges => 'Ainda não foram comunicadas alterações.';

  @override
  String sensor_lastUpdate(String time, int count) {
    return 'Última atualização $time • $count recebidas';
  }

  @override
  String get sensor_stop => 'Parar atualizações em direto';

  @override
  String sensor_stopUnconfirmed(String error) {
    return 'Parado aqui; o sensor não confirmou e vai parar quando o tempo acabar. $error';
  }

  @override
  String get sensor_dialogBody =>
      'O sensor verifica cerca de uma vez por minuto e envia uma atualização quando uma leitura escolhida muda mais do que o seu limite.';

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
    return 'Atualizar com uma alteração de $delta';
  }

  @override
  String get sensor_changeThreshold => 'Alterar limite';

  @override
  String sensor_capacity(int max, String used) {
    return 'O sensor pode vigiar até $max bytes de leituras ($used usados).';
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
    return 'Limite de $label';
  }

  @override
  String get sensor_typeTemperature => 'Temperatura';

  @override
  String get sensor_typeHumidity => 'Humidade';

  @override
  String get sensor_typePressure => 'Pressão';

  @override
  String get sensor_typeVoltage => 'Tensão';

  @override
  String get sensor_typeCurrent => 'Corrente';

  @override
  String get sensor_typeLight => 'Luz';

  @override
  String get sensor_typeConcentration => 'Concentração';

  @override
  String get sensor_typePercentage => 'Percentagem';

  @override
  String get sensor_typeAnalogInput => 'Entrada analógica';

  @override
  String get sensor_typeAltitude => 'Altitude';

  @override
  String get setupWizard_title => 'Conectar o rádio';

  @override
  String get setupWizard_choose => '1. Escolha uma conexão';

  @override
  String get setupWizard_prepare => '2. Prepare o rádio';

  @override
  String get setupWizard_intro =>
      'Escolha como este telefone ou computador se vai conectar ao seu rádio. O rádio transporta as mensagens pela rede mesh.';

  @override
  String get setupWizard_bluetooth =>
      'Conexão sem fios a um rádio compatível próximo.';

  @override
  String get setupWizard_noBluetooth =>
      'O Bluetooth não está disponível neste navegador. Use a app nativa ou uma conexão USB suportada.';

  @override
  String get setupWizard_usb => 'Conexão por cabo com um cabo de dados USB.';

  @override
  String get setupWizard_noUsb =>
      'O USB série não está disponível aqui. Use uma app de computador ou Android suportada, ou o Chrome com Web Serial.';

  @override
  String get setupWizard_bluetoothSteps =>
      'Ligue o rádio e mantenha-o próximo. Ative o Bluetooth e dê permissão à app para o usar. Feche outras apps conectadas ao rádio, abra a lista de dispositivos e procure.';

  @override
  String get setupWizard_usbSteps =>
      'Conecte um rádio ligado com um cabo de dados USB; um cabo só de carregamento não funciona. Feche outras apps série. Abra a lista de dispositivos USB, escolha o rádio e permita o acesso se for pedido.';

  @override
  String get setupWizard_firmwareTitle =>
      'Verifique a compatibilidade antes de mudar o firmware';

  @override
  String get setupWizard_firmware =>
      'O seu rádio precisa de firmware companion MeshCore que suporte a conexão escolhida. O suporte varia com a placa e a compilação do firmware; ter uma porta USB não garante suporte para USB série. Consulte as instruções da sua placa e da compilação instalada. Firmware de repetidor ou de servidor de sala não é companion. Uma conexão falhada não significa por si só que precise de reinstalar o firmware.';

  @override
  String get setupWizard_settings =>
      'Este guia não instala firmware nem altera configurações do rádio. Depois de conectar, use as Configurações para região, frequência e opções avançadas. Confirme as configurações com a sua rede mesh local antes de as alterar.';

  @override
  String get setupWizard_openBluetooth => 'Abrir dispositivos Bluetooth';

  @override
  String get setupWizard_openUsb => 'Abrir dispositivos USB';

  @override
  String get setupWizard_change => 'Alterar tipo de conexão';

  @override
  String get setupWizard_later => 'Configurar mais tarde';

  @override
  String get setupWizard_bluetoothError =>
      'Não foi possível conectar ao rádio. Mantenha-o ligado e próximo, verifique as permissões de Bluetooth e feche outras apps conectadas. Depois procure de novo.';

  @override
  String get setupWizard_scanError =>
      'Não foi possível procurar rádios. Ative o Bluetooth e permita o acesso a Bluetooth ou Dispositivos próximos nas configurações do sistema e procure de novo.';

  @override
  String get setupWizard_usbError =>
      'Não foi possível conectar por USB. Verifique o cabo de dados e o dispositivo escolhido, permita o acesso USB e feche outras apps série. Reconecte o cabo e tente novamente.';

  @override
  String get connections_title => 'Conexões';

  @override
  String get connections_radioTitle => 'Conexão do rádio';

  @override
  String get connections_bluetoothOffNotice =>
      'O Bluetooth está desligado. Ligue-o para reconectar; o app tentará de novo quando ele voltar.';

  @override
  String get connections_transport => 'Transporte';

  @override
  String connections_lastError(String error) {
    return 'Último erro: $error';
  }

  @override
  String get connections_disconnectRadio => 'Desconectar rádio';

  @override
  String connections_reconnectTo(String name) {
    return 'Reconectar a $name';
  }

  @override
  String get connections_forgetRadio => 'Esquecer rádio';

  @override
  String get connections_connectAnother => 'Conectar outro rádio';

  @override
  String get connections_usbSerial => 'USB serial';

  @override
  String get connections_tcpIp => 'TCP/IP';

  @override
  String get connections_device => 'Dispositivo';

  @override
  String get connections_publicKey => 'Chave pública';

  @override
  String get connections_firmware => 'Firmware';

  @override
  String connections_firmwareProtocol(String code) {
    return 'protocolo v$code';
  }

  @override
  String get connections_battery => 'Bateria';

  @override
  String get connections_lastRx => 'Última recepção';

  @override
  String get connections_reconnectFailed =>
      'Não foi possível reconectar ao rádio';

  @override
  String get connections_statusBluetoothOff => 'O Bluetooth está desligado';

  @override
  String get connections_statusConnected => 'Conectado';

  @override
  String get connections_statusConnecting => 'Conectando…';

  @override
  String get connections_statusDisconnecting => 'Desconectando…';

  @override
  String get connections_statusScanning => 'Procurando rádios…';

  @override
  String get connections_statusReconnectingSoon => 'Reconectando em breve…';

  @override
  String get connections_statusNotConnected => 'Não conectado';

  @override
  String get mqtt_cardTitle => 'Conexão MQTT';

  @override
  String get mqtt_statusNotConfigured => 'Não configurado';

  @override
  String get mqtt_statusDisconnected => 'Desconectado';

  @override
  String get mqtt_statusConnecting => 'Conectando';

  @override
  String get mqtt_statusConnected => 'Conectado';

  @override
  String get mqtt_statusReconnecting => 'Reconectando';

  @override
  String get mqtt_statusError => 'Erro de conexão';

  @override
  String mqtt_broker(String host, int port, String transport) {
    return 'Broker: $host:$port ($transport)';
  }

  @override
  String get mqtt_tokenSignIn => 'Entra com um token assinado pelo rádio';

  @override
  String mqtt_tokenSignInAs(String username) {
    return 'Entra com um token assinado pelo rádio como $username…';
  }

  @override
  String get mqtt_connectRadioToSignIn => 'Conecte seu rádio para entrar';

  @override
  String mqtt_tokenRenewsAt(String time) {
    return 'O token é renovado às $time';
  }

  @override
  String mqtt_signedInAs(String username) {
    return 'Conectado como $username';
  }

  @override
  String mqtt_listeningOn(String topic) {
    return 'Ouvindo em $topic';
  }

  @override
  String mqtt_packetCounts(int accepted, int duplicate, int invalid) {
    return 'Pacotes: $accepted novos, $duplicate duplicados, $invalid inválidos';
  }

  @override
  String mqtt_retryCount(int attempt, int max) {
    return 'Tentativa $attempt de $max';
  }

  @override
  String get mqtt_sharingWaitsForRadio =>
      'O compartilhamento aguarda uma conexão de rádio';

  @override
  String mqtt_sharingOn(String topic) {
    return 'Compartilhando em $topic';
  }

  @override
  String mqtt_willShareOn(String topic) {
    return 'Vai compartilhar em $topic';
  }

  @override
  String mqtt_onlineStatusOn(String topic) {
    return 'Status online em $topic';
  }

  @override
  String mqtt_sharedCounts(int shared, int held) {
    return 'Compartilhados $shared, retidos $held';
  }

  @override
  String get mqtt_addBrokerHint =>
      'Adicione um broker para ligar o tráfego MeshCore pela internet. A conexão do rádio funciona de forma independente.';

  @override
  String get mqtt_disconnect => 'Desconectar MQTT';

  @override
  String get mqtt_connect => 'Conectar MQTT';

  @override
  String get mqtt_packetFeed => 'Feed de pacotes';

  @override
  String get mqtt_setUpBroker => 'Configurar broker';

  @override
  String get mqtt_brokerSettings => 'Configurações do broker';

  @override
  String get mqtt_settingsTitle => 'Configurações do broker MQTT';

  @override
  String get mqtt_presetLabel => 'Começar de uma predefinição';

  @override
  String get mqtt_presetCustom => 'Broker personalizado';

  @override
  String get mqtt_presetLocal => 'Broker local (informe o endereço)';

  @override
  String get mqtt_presetLetsMeshUs => 'Analisador LetsMesh (EUA, comunidade)';

  @override
  String get mqtt_presetLetsMeshEu => 'Analisador LetsMesh (UE, comunidade)';

  @override
  String get mqtt_presetLetsMeshNote =>
      'LetsMesh é um analisador de pacotes MeshCore mantido pela comunidade; não faz parte do NOTORYX nem tem o seu endosso. O compartilhamento precisa do rádio conectado e fica desligado até você ativá-lo.';

  @override
  String get mqtt_hostname => 'Nome do host do broker';

  @override
  String get mqtt_port => 'Porta';

  @override
  String get mqtt_useTls => 'Usar TLS';

  @override
  String get mqtt_allowCleartext =>
      'Permitir texto sem criptografia para um broker local';

  @override
  String get mqtt_allowCleartextHint =>
      'Apenas localhost, .local e hosts privados 10.x / 192.168.x.';

  @override
  String get mqtt_useWebSocket => 'Usar WebSocket';

  @override
  String get mqtt_webSocketPath => 'Caminho WebSocket';

  @override
  String get mqtt_topicPrefix => 'Prefixo de tópico';

  @override
  String get mqtt_region => 'Região (opcional)';

  @override
  String get mqtt_regionHelp =>
      'Código de região do observador, como PHL. Deixe vazio para todas.';

  @override
  String get mqtt_deliverChannel =>
      'Adicionar mensagens de canal recebidas via MQTT';

  @override
  String get mqtt_deliverChannelHint =>
      'Mensagens dos seus canais ouvidas por observadores aparecem nas suas conversas. Elas não são enviadas pelo seu rádio.';

  @override
  String get mqtt_sharingTitle => 'Compartilhar como observador';

  @override
  String get mqtt_share => 'Compartilhar pacotes que meu rádio ouve';

  @override
  String get mqtt_shareHint =>
      'Publica anúncios e tráfego de canal que seu rádio recebe, com a chave pública dele, a intensidade do sinal e a região. As mensagens de canal continuam criptografadas. Exige uma região.';

  @override
  String get mqtt_shareDirect => 'Incluir tráfego de mensagens diretas';

  @override
  String get mqtt_shareDirectHint =>
      'Solicitações, respostas e mensagens diretas. O conteúdo continua criptografado, mas isso mostra quais nós conversam entre si.';

  @override
  String get mqtt_shareOwn => 'Incluir minhas próprias mensagens e anúncios';

  @override
  String get mqtt_signInTitle => 'Entrada';

  @override
  String get mqtt_authPassword => 'Usuário e senha';

  @override
  String get mqtt_authToken => 'Token assinado pelo rádio';

  @override
  String get mqtt_tokenExplain =>
      'Seu rádio assina com a própria chave um token de entrada válido por uma hora, e o app o renova antes de vencer. A chave nunca sai do rádio. O usuário é v1_ seguido da chave pública do rádio.';

  @override
  String get mqtt_radioReady => 'Rádio conectado: pronto para entrar.';

  @override
  String get mqtt_radioNeeded =>
      'Conecte seu rádio para entrar. O MQTT aguarda por ele.';

  @override
  String get mqtt_username => 'Usuário (opcional)';

  @override
  String get mqtt_password => 'Senha';

  @override
  String get mqtt_keepPassword => 'Deixe vazio para manter a senha salva.';

  @override
  String get mqtt_credentialsWeb =>
      'No navegador, as credenciais ficam guardadas só até a página ser fechada.';

  @override
  String get mqtt_credentialsKeychain =>
      'As credenciais ficam no chaveiro do sistema, nunca nas configurações do app nem em logs.';

  @override
  String get mqtt_saveSettings => 'Salvar configurações';

  @override
  String get mqtt_feedTitle => 'Feed de pacotes MQTT';

  @override
  String get mqtt_feedConnect =>
      'Conecte-se a um broker para ver pacotes dos observadores.';

  @override
  String mqtt_feedWaiting(String topic) {
    return 'Aguardando pacotes em $topic';
  }

  @override
  String get mqtt_feedUnknownObserver => 'Observador desconhecido';

  @override
  String mqtt_feedHeardBy(String observer) {
    return 'Ouvido por $observer';
  }

  @override
  String mqtt_feedHopsBytes(int hops, int bytes) {
    return '$hops saltos · $bytes bytes';
  }

  @override
  String get mqtt_packetRequest => 'Solicitação';

  @override
  String get mqtt_packetResponse => 'Resposta';

  @override
  String get mqtt_packetDirectMessage => 'Mensagem direta';

  @override
  String get mqtt_packetAck => 'Confirmação';

  @override
  String get mqtt_packetAdvert => 'Anúncio';

  @override
  String get mqtt_packetChannelMessage => 'Mensagem de canal';

  @override
  String get mqtt_packetChannelData => 'Dados de canal';

  @override
  String get mqtt_packetAnonymousRequest => 'Solicitação anônima';

  @override
  String get mqtt_packetPath => 'Caminho';

  @override
  String get mqtt_packetTrace => 'Rastreio';

  @override
  String get mqtt_packetMultipart => 'Multiparte';

  @override
  String get mqtt_packetControl => 'Controle';

  @override
  String mqtt_packetType(int type) {
    return 'Tipo $type';
  }

  @override
  String get mqtt_routeTransportFlood => 'Flood com transporte';

  @override
  String get mqtt_routeFlood => 'Flood';

  @override
  String get mqtt_routeDirect => 'Direta';

  @override
  String get mqtt_routeTransportDirect => 'Direta com transporte';

  @override
  String get mqtt_noticeInvalidHost =>
      'Informe um nome de host ou endereço IPv4 sem esquema nem porta.';

  @override
  String get mqtt_noticeInvalidPort => 'A porta deve estar entre 1 e 65535.';

  @override
  String get mqtt_noticeInvalidWebSocketPath =>
      'O caminho WebSocket deve começar com / e não conter consulta nem fragmento.';

  @override
  String get mqtt_noticeInvalidTopicPrefix =>
      'O prefixo de tópico deve ser um caminho MQTT não vazio, sem curingas.';

  @override
  String get mqtt_noticeInvalidRegion =>
      'A região deve ter de 2 a 8 letras ou dígitos, como PHL.';

  @override
  String get mqtt_noticeTlsRequired =>
      'TLS é obrigatório, a menos que o acesso inseguro a um broker local esteja permitido explicitamente.';

  @override
  String get mqtt_noticeCleartextLocalOnly =>
      'MQTT sem criptografia é restrito a hosts locais aprovados explicitamente.';

  @override
  String get mqtt_noticeRegionNeededToShare =>
      'Defina uma região para compartilhar pacotes como observador.';

  @override
  String mqtt_noticePasswordNeeded(String username) {
    return 'Informe a senha de $username.';
  }

  @override
  String get mqtt_noticeNoNetwork =>
      'Sem conexão de rede. O MQTT reconecta quando ela voltar.';

  @override
  String get mqtt_noticeSubscriptionRefused =>
      'O broker recusou a inscrição em pacotes.';

  @override
  String get mqtt_noticeBadCredentials =>
      'O broker rejeitou o usuário ou a senha.';

  @override
  String get mqtt_noticeNotAuthorized =>
      'Esta conta não tem autorização no broker.';

  @override
  String get mqtt_noticeConnectionRefused => 'O broker recusou a conexão.';

  @override
  String get mqtt_noticeUnreachable => 'Não foi possível alcançar o broker.';

  @override
  String get mqtt_noticeTlsFailed =>
      'Não foi possível estabelecer a conexão segura (TLS).';

  @override
  String get mqtt_noticeWebSocketOnly =>
      'Esta plataforma só suporta MQTT via WebSocket.';

  @override
  String get mqtt_noticeRadioNotConnected =>
      'Conecte seu rádio para entrar com a chave dele.';

  @override
  String get mqtt_noticeSigningUnsupported =>
      'O firmware deste rádio não suporta assinar com a chave dele.';

  @override
  String get mqtt_noticeSigningTimeout =>
      'O rádio não respondeu ao pedido de assinatura. O firmware dele pode não suportar assinatura.';

  @override
  String get mqtt_noticeSigningTooLong =>
      'Os dados são longos demais para o rádio assinar.';

  @override
  String get mqtt_noticeSigningRejected =>
      'O rádio se recusou a assinar os dados.';

  @override
  String get scanner_signalStrong => 'Forte';

  @override
  String get scanner_signalGood => 'Bom';

  @override
  String get scanner_signalFair => 'Razoável';

  @override
  String get scanner_signalWeak => 'Fraco';

  @override
  String get scanner_nearbyRadios => 'Rádios por perto';

  @override
  String get scanner_lastRadio => 'Último rádio';

  @override
  String get scanner_reconnect => 'Reconectar';

  @override
  String get scanner_tcpHint => 'Um rádio com firmware Wi‑Fi na sua rede.';

  @override
  String get scanner_otherWays => 'Outras formas de conectar';

  @override
  String scanner_radiosFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rádios por perto',
      one: '1 rádio por perto',
    );
    return '$_temp0';
  }

  @override
  String get scanner_searchingTitle => 'Procurando rádios…';

  @override
  String get scanner_findTitle => 'Encontre seu rádio';

  @override
  String get scanner_heroHint =>
      'Ligue seu rádio e mantenha-o a poucos metros. Ele precisa do firmware MeshCore companion.';

  @override
  String get scanner_tipsTitle => 'Não vê seu rádio?';

  @override
  String get scanner_tipPower => 'Verifique se ele está ligado e ativo.';

  @override
  String get scanner_tipFirmware =>
      'Ele precisa do firmware MeshCore companion. Repetidores e servidores de sala não aparecem aqui.';

  @override
  String get scanner_tipOtherDevice =>
      'Um rádio se conecta a um dispositivo por vez. Desconecte-o de outros celulares ou computadores.';

  @override
  String get connections_internetBridge => 'Ponte de internet';

  @override
  String get connections_noRadio => 'Nenhum rádio';

  @override
  String get connections_radioSettings => 'Configurações do rádio';

  @override
  String get connections_viewDashboard => 'Ver painel de conexões';

  @override
  String get channelDirectory_title => 'Diretório de canais';

  @override
  String get channelDirectory_subtitle =>
      'Encontre canais públicos com hashtag perto de você';

  @override
  String get channelDirectory_search => 'Pesquisar canais ou lugares';

  @override
  String get channelDirectory_nearYou => 'Perto de você';

  @override
  String get channelDirectory_all => 'Todos os canais';

  @override
  String get channelDirectory_catAll => 'Todos';

  @override
  String get channelDirectory_catEmergency => 'Emergência';

  @override
  String get channelDirectory_catLocal => 'Locais';

  @override
  String get channelDirectory_catGeneral => 'Gerais';

  @override
  String get channelDirectory_catInterest => 'Interesses';

  @override
  String get channelDirectory_catTest => 'Testes';

  @override
  String get channelDirectory_join => 'Entrar';

  @override
  String get channelDirectory_joined => 'Participando';

  @override
  String get channelDirectory_noMatches =>
      'Nenhum canal corresponde à sua busca.';

  @override
  String get channelDirectory_connectFirst =>
      'Conecte seu rádio para entrar em canais.';

  @override
  String get channelDirectory_slotsFull =>
      'Todos os espaços de canal do rádio estão em uso. Remova um canal primeiro.';

  @override
  String get channelDirectory_joinFailed =>
      'Não foi possível adicionar o canal. Tente novamente.';

  @override
  String get channelDirectory_addHint =>
      'Falta um canal? Qualquer pessoa pode sugerir um editando a lista compartilhada no GitHub.';

  @override
  String get prefixTool_title => 'IDs dos repetidores';

  @override
  String get prefixTool_subtitle =>
      'Quem usa uma ID, quais IDs coincidem e IDs livres para um novo repetidor';

  @override
  String get prefixTool_width => 'Tamanho da ID de rota';

  @override
  String prefixTool_widthBytes(int bytes) {
    return '$bytes byte(s)';
  }

  @override
  String get prefixTool_includeCompanions => 'Incluir companions e sensores';

  @override
  String prefixTool_summary(int nodes, int used, int shared) {
    return '$nodes nós conhecidos · $used IDs em uso · $shared compartilhadas';
  }

  @override
  String prefixTool_freeOfSpace(int free, int space) {
    return '$free de $space IDs livres';
  }

  @override
  String get prefixTool_lookupHint => 'Procure uma ID, ex. 3D';

  @override
  String prefixTool_lookupFree(String id) {
    return 'Nenhum nó conhecido usa $id.';
  }

  @override
  String prefixTool_lookupUsed(int count, String id) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nós usam $id',
      one: '1 nó usa $id',
    );
    return '$_temp0';
  }

  @override
  String get prefixTool_shared => 'IDs compartilhadas';

  @override
  String get prefixTool_sharedHint =>
      'Rotas por essas IDs parecem iguais, a menos que a malha use IDs mais longas.';

  @override
  String get prefixTool_noShared =>
      'Nenhuma ID compartilhada entre os nós conhecidos.';

  @override
  String get prefixTool_free => 'IDs livres';

  @override
  String get prefixTool_shuffle => 'Mais sugestões';

  @override
  String get prefixTool_makeKey => 'Criar uma chave';

  @override
  String get prefixTool_onlyKnown =>
      'Baseado apenas nos nós que seu rádio ouviu. Uma ID livre aqui ainda pode pertencer a um repetidor que você não ouviu.';

  @override
  String prefixTool_inUseWarning(String id, String name) {
    return '$id já é usada por $name.';
  }

  @override
  String get prefixTool_pickFree => 'Escolher uma ID livre';

  @override
  String keyGen_title(String id) {
    return 'Chave para a ID $id';
  }

  @override
  String keyGen_searching(int tries) {
    return 'Procurando… $tries chaves testadas';
  }

  @override
  String get keyGen_publicKey => 'Chave pública';

  @override
  String get keyGen_privateKey => 'Chave privada';

  @override
  String get keyGen_copy => 'Copiar';

  @override
  String get keyGen_copied => 'Copiado';

  @override
  String get keyGen_secretWarning =>
      'Mantenha a chave privada em segredo. Quem a tiver pode se passar por este nó.';

  @override
  String get keyGen_howToUse =>
      'Para usar num repetidor, abra as configurações dele, cole como chave privada e salve. Rádios companion precisam de firmware que permita importar chaves.';

  @override
  String get keyGen_tryAgain => 'Criar outra';

  @override
  String get regionSetup_title => 'Configurar regiões';

  @override
  String get regionSetup_hubSubtitle =>
      'Coloque este repetidor na árvore de regiões da sua área';

  @override
  String get regionSetup_intro =>
      'As regiões mantêm uma mensagem dentro de uma área em vez de inundar toda a malha. Um repetidor só retransmite mensagens de uma região se tiver essa região, então dê a ele a própria região e todas acima dela.';

  @override
  String get regionSetup_where => 'Onde fica o repetidor?';

  @override
  String get regionSetup_tree => 'Árvore de regiões';

  @override
  String get regionSetup_custom => 'Personalizado';

  @override
  String get regionSetup_region => 'Região mais local';

  @override
  String get regionSetup_customLabel =>
      'Regiões, da mais ampla para a mais local';

  @override
  String regionSetup_invalidName(String name) {
    return '\"$name\" não é um nome de região válido. Use letras minúsculas, números e hífens, até 29 caracteres.';
  }

  @override
  String regionSetup_tooMany(int max) {
    return 'Um repetidor pode ter no máximo $max regiões.';
  }

  @override
  String get regionSetup_options => 'Opções';

  @override
  String get regionSetup_setDefault => 'Usar a região mais local como padrão';

  @override
  String get regionSetup_setDefaultBody =>
      'Os anúncios do próprio repetidor ficam nessa região.';

  @override
  String get regionSetup_legacy => 'Firmware 1.14';

  @override
  String get regionSetup_legacyBody =>
      'Adiciona region allowf após cada região. Não é preciso na 1.15 ou mais nova.';

  @override
  String get regionSetup_denyUnscoped =>
      'Parar de retransmitir mensagens sem região';

  @override
  String get regionSetup_denyUnscopedBody =>
      'Ative só quando toda a sua área usar regiões, senão mensagens de apps antigos não passarão.';

  @override
  String get regionSetup_commands => 'Comandos';

  @override
  String get regionSetup_copyAll => 'Copiar tudo';

  @override
  String get regionSetup_copied => 'Copiado';

  @override
  String get regionSetup_pickFirst =>
      'Escolha uma região para ver os comandos.';

  @override
  String regionSetup_sendTo(String name) {
    return 'Enviar para $name';
  }

  @override
  String get regionSetup_howToSend =>
      'Para enviá-los, entre no repetidor e abra Configurar regiões no menu dele, ou cole-os na linha de comando.';

  @override
  String get regionSetup_noReply => 'Sem resposta. Parou aqui.';

  @override
  String get regionSetup_addToMine => 'Adicionar estas regiões à minha lista';

  @override
  String regionSetup_addedToMine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count regiões adicionadas à sua lista',
      one: '1 região adicionada à sua lista',
    );
    return '$_temp0';
  }

  @override
  String get trackLog_title => 'Registro de trajeto';

  @override
  String get trackLog_subtitle => 'Grave um rastro com o GPS do seu rádio';

  @override
  String get trackLog_recording => 'Gravando';

  @override
  String get trackLog_notRecording => 'Sem gravação';

  @override
  String get trackLog_noGps =>
      'Seu rádio não está informando uma posição GPS. O registro de trajeto precisa de um rádio com GPS ligado.';

  @override
  String get trackLog_start => 'Começar a gravar';

  @override
  String get trackLog_stop => 'Parar de gravar';

  @override
  String get trackLog_howItWorks =>
      'Usa a posição informada pelo rádio, cerca de uma vez por minuto, enquanto o NOTORYX Core está aberto. Um ponto é adicionado após você se mover 25 m, ou a cada 15 minutos parado.';

  @override
  String get trackLog_snap => 'Arredondar posições para cerca de 100 m';

  @override
  String get trackLog_snapBody =>
      'Para privacidade ao compartilhar um trajeto.';

  @override
  String get trackLog_saved => 'Trajetos salvos';

  @override
  String get trackLog_none => 'Nenhum trajeto ainda.';

  @override
  String get trackLog_export => 'Exportar como GPX';

  @override
  String get trackLog_exportFailed => 'Não foi possível exportar o trajeto.';

  @override
  String get trackLog_deleteTitle => 'Excluir este trajeto?';

  @override
  String get trackLog_deleteBody =>
      'Ele é removido deste dispositivo. Arquivos GPX exportados não são afetados.';

  @override
  String trackLog_stats(String km, String duration, int points) {
    return '$km km · $duration · $points pontos';
  }

  @override
  String trackLog_gpxName(String when) {
    return 'Trajeto NOTORYX $when';
  }

  @override
  String get routes_nearbyTitle => 'Melhores repetidores perto';

  @override
  String get routes_nearbyEmptyTitle => 'Nenhum repetidor ouvido ainda';

  @override
  String get routes_nearbyEmpty =>
      'Os repetidores que seu rádio ouve diretamente aparecem aqui, os mais fortes primeiro, conforme ele recebe tráfego. A lista cobre a última hora.';

  @override
  String get routes_unknownRepeater => 'Repetidor desconhecido';

  @override
  String routes_nearbyDetail(int count, String ago) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ouvido $count vezes',
      one: 'ouvido uma vez',
    );
    return '$_temp0 · $ago';
  }

  @override
  String routes_minutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'há $minutes min',
      one: 'há 1 min',
      zero: 'agora mesmo',
    );
    return '$_temp0';
  }

  @override
  String routes_via(String names) {
    return 'via $names';
  }

  @override
  String get nav_home => 'Início';

  @override
  String get nav_chats => 'Conversas';

  @override
  String get nav_tools => 'Ferramentas';

  @override
  String get nav_settings => 'Definições';

  @override
  String get nav_more => 'Mais';

  @override
  String get tools_groupApp => 'App e definições';

  @override
  String get tools_groupField => 'No terreno';

  @override
  String get tools_groupMaps => 'Mapas e cobertura';

  @override
  String get tools_groupRouting => 'Rotas e repetidores';

  @override
  String get tools_pathGraph => 'Grafo de caminhos';

  @override
  String get tools_pathGraphHint =>
      'Como as mensagens chegam até si: cada caminho ouvido, com os repetidores mais ativos';

  @override
  String get tools_antenna => 'Cobertura da antena';

  @override
  String get tools_antennaHint =>
      'Estime até onde uma antena chega sobre o terreno';

  @override
  String routes_repeaterWithId(String id) {
    return 'Repetidor $id';
  }

  @override
  String get coverageHex_title => 'Hexágonos de cobertura';

  @override
  String get coverageHex_toolSubtitle =>
      'Mapeie onde o rádio ouve a malha e partilhe';

  @override
  String get coverageHex_mapCoverage => 'Mapear cobertura';

  @override
  String get coverageHex_statusOff =>
      'Desligado. Ligue enquanto conduz ou caminha para mapear onde o rádio ouve a malha.';

  @override
  String get coverageHex_waitingGps => 'À espera do GPS…';

  @override
  String coverageHex_gpsTooRough(String meters) {
    return 'Precisão GPS $meters m: demasiado imprecisa, sem gravar.';
  }

  @override
  String coverageHex_recording(String meters) {
    return 'A gravar. Precisão GPS $meters m.';
  }

  @override
  String get coverageHex_hexagons => 'Hexágonos';

  @override
  String get coverageHex_samples => 'Amostras';

  @override
  String get coverageHex_privacyNote =>
      'Usa o GPS do telefone enquanto este interruptor está ligado. Só são partilhados ID de hexágonos (cerca de 0,9 km), nunca a sua posição exata.';

  @override
  String get coverageHex_uploadSection => 'Enviar para mapas de cobertura';

  @override
  String get coverageHex_wifiOnly => 'Enviar só por Wi-Fi';

  @override
  String get coverageHex_wifiOnlyHint =>
      'As amostras esperam no telefone (até 7 dias) pelo Wi-Fi.';

  @override
  String coverageHex_waiting(String count) {
    return '$count em espera';
  }

  @override
  String get coverageHex_addMap => 'Adicionar mapa de cobertura';

  @override
  String get coverageHex_addMapHint =>
      'Qualquer endpoint HTTPS que aceite cobertura.';

  @override
  String get coverageHex_uploadNow => 'Enviar agora';

  @override
  String get coverageHex_mapDialogTitle => 'Mapa de cobertura';

  @override
  String get coverageHex_nameMissing => 'Dê-lhe um nome.';

  @override
  String get coverageHex_url => 'URL de envio';

  @override
  String get coverageHex_urlInvalid => 'Tem de ser um URL https://.';

  @override
  String get coverageHex_apiKey => 'Chave API (opcional)';

  @override
  String get coverageHex_apiKeyHint => 'Enviada como X-API-Key.';

  @override
  String get coverageHex_format => 'Formato';

  @override
  String get coverageHex_formatHex => 'ID de hexágonos (NOTORYX)';

  @override
  String get coverageHex_formatMeshMapper => 'Compatível com MeshMapper';

  @override
  String get coverageHex_privacy => 'Privacidade';

  @override
  String get coverageHex_privacyLive => 'Em direto';

  @override
  String get coverageHex_privacyDelayed => 'Atrasado 3 h';

  @override
  String get coverageHex_privacyAnonymous => 'Anónimo, 24 h';

  @override
  String get coverageHex_privacyLiveHint => 'Enviado em cerca de 15 minutos.';

  @override
  String get coverageHex_privacyDelayedHint =>
      'Retido 3 horas para o mapa não mostrar onde está agora.';

  @override
  String get coverageHex_privacyAnonymousHint =>
      'Retido 24 horas, só com a data e sem assinatura, para não se ligarem os envios.';

  @override
  String get coverageHex_uploadsOn => 'Envios ligados';

  @override
  String coverageHex_sent(String count, String time) {
    return 'Enviadas $count células às $time.';
  }

  @override
  String coverageHex_httpError(String code) {
    return 'O mapa respondeu $code; vai tentar de novo.';
  }

  @override
  String get coverageHex_unreachable =>
      'Não foi possível contactar o mapa; vai tentar de novo.';

  @override
  String get coverageHex_noPermission =>
      'A permissão de localização não foi concedida.';

  @override
  String get coverageHex_noGps => 'O GPS não está disponível.';

  @override
  String get coverageHex_loadFailed =>
      'Não foi possível ler a cobertura guardada; recomeça.';

  @override
  String get mqttExtra_wifiOnly => 'Ligar só por Wi-Fi';

  @override
  String mqttExtra_backlog(String count) {
    return '$count pacotes à espera de envio (guardados até 72 horas).';
  }

  @override
  String get mqttExtra_add => 'Adicionar outro broker';

  @override
  String get mqttExtra_addBody =>
      'Partilha o que o rádio ouve com mais um broker MQTT, além do principal. Só envia; nunca devolve pacotes à app.';

  @override
  String get mqttExtra_separateKey => 'Usar uma chave separada';

  @override
  String get mqttExtra_separateKeyHint =>
      'Inicia sessão com uma chave criada neste telefone em vez da do rádio, para o broker não ligar os envios ao seu rádio.';

  @override
  String mqttExtra_removeTitle(String name) {
    return 'Remover $name?';
  }

  @override
  String get mqttExtra_removeBody =>
      'Desliga e esquece definições, palavra-passe, chave e pacotes em espera.';

  @override
  String mqttExtra_ownKey(String key) {
    return 'Inicia sessão com a própria chave: $key…';
  }

  @override
  String get botWx_title => 'Publicar alertas meteorológicos num canal';

  @override
  String get botWx_body =>
      'Consulta a cada 10 minutos o National Weather Service dos EUA para avisos graves e extremos na posição GPS do rádio (arredondada a cerca de 1 km) e publica cada novo uma vez. Requer internet no telefone.';

  @override
  String get botWx_channel => 'Publicar no canal';

  @override
  String get botWx_moderate => 'Incluir alertas moderados';

  @override
  String get botWx_moderateHint => 'Avisos e alertas. Mais mensagens.';

  @override
  String botWx_lastChecked(String time) {
    return 'Última verificação $time.';
  }

  @override
  String get botWx_noPosition => 'O rádio ainda não indicou a posição GPS.';

  @override
  String get botWx_noChannel => 'Escolha um canal para os alertas.';

  @override
  String get botWx_channelGone => 'O canal escolhido já não existe.';

  @override
  String botWx_httpError(String code) {
    return 'O serviço meteorológico respondeu $code.';
  }

  @override
  String get botWx_unreachable =>
      'Não foi possível contactar o serviço meteorológico.';

  @override
  String get botCmd_sun => 'Nascer e pôr do sol na posição GPS do rádio.';

  @override
  String get botCmd_moon => 'Fase da Lua e quanto está iluminada.';

  @override
  String get botCmd_weather =>
      'Tempo atual no rádio (Open-Meteo). Envia a posição arredondada a cerca de 1 km.';

  @override
  String get botCmd_dice => 'Lança dados: !dice, !dice 20 ou !dice 2d6.';

  @override
  String get botCmd_trace => 'Lista os repetidores por onde a mensagem passou.';

  @override
  String get ping_title => 'Ping a repetidor';

  @override
  String get ping_toolSubtitle =>
      'Tempo de ida e volta e sinal nos dois sentidos para um repetidor próximo';

  @override
  String get ping_noRepeaters => 'Ainda sem repetidores conhecidos';

  @override
  String get ping_choose => 'Escolha um repetidor';

  @override
  String get ping_avgMs => 'ms ida e volta';

  @override
  String get ping_snrThere => 'SNR lá';

  @override
  String get ping_snrBack => 'SNR de volta';

  @override
  String get ping_loss => 'Perdidos';

  @override
  String ping_running(int done, int total) {
    return 'Ping $done de $total…';
  }

  @override
  String ping_start(int count) {
    return 'Fazer ping $count vezes';
  }

  @override
  String get ping_results => 'Sondagens';

  @override
  String get ping_noReply => 'Sem resposta';

  @override
  String ping_resultLine(String ms, String snr) {
    return '$ms ms · SNR lá $snr';
  }

  @override
  String get ping_explainer =>
      'Cada sondagem é um traçado de um salto: o repetidor regista como o ouviu e devolve. Funciona com repetidores que o rádio ouve diretamente.';

  @override
  String get hunt_title => 'Busca com antena';

  @override
  String get hunt_toolSubtitle =>
      'Medidor de sinal grande que estala mais depressa quando fica mais forte';

  @override
  String get hunt_noSignal => 'Ainda sem sinal';

  @override
  String get hunt_noReply => 'Sem resposta — mova ou rode a antena';

  @override
  String get hunt_heardHere => 'dB ouvidos aqui';

  @override
  String get hunt_best => 'Melhor';

  @override
  String get hunt_sound => 'Estalar quando fica mais forte';

  @override
  String get hunt_soundHint =>
      'Com vibração em cada estalo, para apontar sem olhar.';

  @override
  String get hunt_stop => 'Parar';

  @override
  String get hunt_start => 'Começar a procurar';

  @override
  String get hunt_explainer =>
      'Sonda o repetidor cerca de uma vez por segundo. Aponte uma antena direcional ou caminhe: o número é quão bem o rádio o ouve.';

  @override
  String get settings_refreshRate => 'Frequência de atualização';

  @override
  String get settings_refreshFast => 'Rápida';

  @override
  String get settings_refreshNormal => 'Normal';

  @override
  String get settings_refreshSlow => 'Lenta';

  @override
  String get settings_refreshFastHint =>
      'Bateria a cada minuto, GPS a cada 30 s. Dados mais recentes, mais consumo.';

  @override
  String get settings_refreshNormalHint =>
      'Bateria a cada 2 minutos, GPS a cada minuto.';

  @override
  String get settings_refreshSlowHint =>
      'Bateria a cada 6 minutos, GPS a cada 3. Poupa bateria.';

  @override
  String get settings_refreshSaverOn =>
      'A poupança de bateria está ligada e define o ritmo (bateria a cada 10 minutos).';

  @override
  String get reach_check => 'Verificar alcance nos observadores';

  @override
  String get reach_title => 'Alcance nos observadores';

  @override
  String get reach_noHash =>
      'Ainda não é possível consultar esta mensagem: nenhum repetidor a devolveu ao rádio, por isso o ID do pacote é desconhecido.';

  @override
  String get reach_unreachable =>
      'Não foi possível contactar o analisador. Verifique a internet ou o endereço do analisador nas definições.';

  @override
  String get reach_none =>
      'Nenhum observador o ouviu ainda. Os observadores enviam pouco depois de ouvir, verifique de novo daqui a um minuto.';

  @override
  String get reach_observers => 'observadores';

  @override
  String get reach_maxHops => 'saltos máx.';

  @override
  String get reach_bestSnr => 'melhor SNR';

  @override
  String reach_hops(int count) {
    return 'a $count saltos';
  }

  @override
  String get reach_explainer =>
      'Do analisador online: observadores que ouviram e enviaram este pacote.';

  @override
  String get reach_checkAgain => 'Verificar de novo';

  @override
  String get analyzer_title => 'Analisador online';

  @override
  String get analyzer_url => 'Endereço do analisador';

  @override
  String get analyzer_urlHint =>
      'Um analisador CoreScope (https://). Use o da sua região.';

  @override
  String get analyzer_reset => 'Predefinido';

  @override
  String get analyzer_hint =>
      'Serve para verificar que observadores ouviram as mensagens. Só envia o ID do pacote.';

  @override
  String get analyzer_hopLookup => 'Nomear repetidores desconhecidos online';

  @override
  String get analyzer_hopLookupHint =>
      'Se um ID de repetidor não estiver nos contactos, pede-se o nome ao analisador. Só se enviam os ID curtos. Um nome com «?» indica que vários repetidores partilham o ID.';

  @override
  String discovered_tray(int count) {
    return 'Canais ouvidos por perto: $count';
  }

  @override
  String get discovered_title => 'Ouvidos por perto, não aderidos';

  @override
  String discovered_heard(int count, String time) {
    return 'Ouvido $count× · último $time';
  }

  @override
  String get discovered_ignore => 'Ignorar';

  @override
  String get discovered_ignoreAll => 'Ignorar todos';

  @override
  String get discovered_joinAll => 'Aderir a todos';

  @override
  String get discovered_explainer =>
      'São canais públicos do diretório onde o rádio ouviu tráfego. Cada um foi confirmado ao decifrar uma mensagem com a sua chave. Os ignorados ficam ocultos.';

  @override
  String get mqtt_presetMeshRank => 'MeshRank (comunidade)';

  @override
  String get mqtt_presetMeshRankNote =>
      'O MeshRank é um ranking comunitário de redes MeshCore, que não faz parte do NOTORYX nem é recomendado por ele. Sem início de sessão: os pacotes são partilhados com a chave e o código de região do rádio, só depois de ligar a partilha.';

  @override
  String get pathFilter_title => 'Filtro de largura de caminho';

  @override
  String get pathFilter_firmwareNote =>
      'Requer firmware do repetidor com regras de reencaminhamento (mikecarper/MeshCore). O firmware oficial MeshCore rejeita estes comandos.';

  @override
  String get pathFilter_width => 'Largura do caminho';

  @override
  String get pathFilter_anyWidth => 'Qualquer largura';

  @override
  String pathFilter_bytes(int n) {
    return 'Caminhos de $n bytes';
  }

  @override
  String get pathFilter_twoOrMore => '2 ou 3 bytes (2+)';

  @override
  String get pathFilter_path => 'Aplica-se a';

  @override
  String get pathFilter_radio => 'Inundações rádio';

  @override
  String get pathFilter_bridge => 'Ponte';

  @override
  String get pathFilter_cross => 'Cruzamento';

  @override
  String get pathFilter_bridgeCross => 'Ponte e cruzamento';

  @override
  String get pathFilter_limit => 'Limitar em vez de descartar';

  @override
  String get pathFilter_limitOn => 'Reencaminha até um número fixo por minuto.';

  @override
  String get pathFilter_drop =>
      'As inundações correspondentes são descartadas.';

  @override
  String get pathFilter_perMinute => 'Por minuto';

  @override
  String get pathFilter_rateInvalid => 'Introduza de 1 a 65534.';

  @override
  String get pathFilter_reviewNote =>
      'Isto só preenche a linha de comandos. Verifique e prima Enviar. Use primeiro «get fr» para ver as regras.';

  @override
  String get pathFilter_useCommand => 'Usar comando';

  @override
  String get settings_linkPreviews => 'Pré-visualizações de links';

  @override
  String get settings_linkPreviewsHint =>
      'Mostra o título de um link numa mensagem. Desligado por omissão: obter a página revela o seu IP ao site.';

  @override
  String get guide_title => 'Guia de campo';

  @override
  String get guide_subtitle => 'Básico, baterias no frio, solar e antenas';

  @override
  String get guide_secMesh => 'Entrar na malha';

  @override
  String get guide_mesh1 =>
      'O telefone fala com o rádio por Bluetooth, USB ou Wi-Fi; o rádio fala com a malha por LoRa. As mensagens funcionam sem rede móvel.';

  @override
  String get guide_mesh2 =>
      'Os repetidores passam as mensagens; cada reencaminhamento é um salto. Menos saltos, entrega mais rápida e fiável.';

  @override
  String get guide_mesh3 =>
      'Mensagens curtas e sem inundar canais movimentados: cada mensagem usa tempo de antena partilhado.';

  @override
  String get guide_secCold => 'Baterias no frio';

  @override
  String get guide_cold1 =>
      'Não carregue baterias de lítio abaixo de 0 °C: danifica-as permanentemente.';

  @override
  String get guide_cold2 =>
      'Leve o rádio dentro do casaco. O frio reduz a capacidade, que volta quando a bateria aquece.';

  @override
  String get guide_cold3 =>
      'Em locais fixos de clima frio, o LiFePO4 aguenta melhor do que o iões de lítio; uma caixa isolada ou aquecida ajuda ambos.';

  @override
  String get guide_secSolar => 'Solar para repetidores';

  @override
  String get guide_solar1 =>
      'Um repetidor gasta muito pouco, mas dimensione painel e bateria para a semana mais escura do inverno, não para um dia de verão.';

  @override
  String get guide_solar2 =>
      'Vire o painel para o equador e incline-o bastante no inverno; mantenha-o sem neve nem sombra.';

  @override
  String get guide_secAntenna => 'Antenas e posicionamento';

  @override
  String get guide_ant1 =>
      'A altura vence a potência: um rádio a poucos metros de altura chega muito mais longe do que numa secretária.';

  @override
  String get guide_ant2 =>
      'Mantenha a antena vertical e longe de metal, e use uma feita para a sua banda (por exemplo 868 MHz na Europa).';

  @override
  String get guide_secMore => 'Saber mais';

  @override
  String get guide_moreMeshcore => 'O projeto oficial MeshCore';

  @override
  String get guide_moreCascadia =>
      'Guias da comunidade: começar, wardriving, regiões, solar';

  @override
  String get post_signed => 'Assinado';

  @override
  String get post_unverified => 'Não verificado';

  @override
  String post_signedKnown(String name) {
    return 'Assinado por $name, um dos seus contactos.';
  }

  @override
  String get post_signedUnknownKey =>
      'Assinado, mas não por nenhum dos seus contactos. Adicione o remetente aos contactos para ver quem é.';

  @override
  String get post_unverifiedHint =>
      'Veio uma assinatura com esta mensagem que não corresponde. Pode ter sido alterada pelo caminho ou não ser de quem diz.';

  @override
  String get settings_signPosts => 'Assinar todas as minhas mensagens de canal';

  @override
  String get settings_signPostsHint =>
      'Um SOS num canal é sempre assinado. Isto assina todas as mensagens para que outros utilizadores NOTORYX saibam que é mesmo você. Cada assinatura é mais um pacote no ar.';

  @override
  String get tools_search => 'Pesquisar ferramentas e definições';

  @override
  String get tools_noMatches => 'Nenhuma ferramenta corresponde à pesquisa.';

  @override
  String get tools_bot => 'Modo bot';

  @override
  String get tools_botHint =>
      'Respostas automáticas, !comandos e alertas meteorológicos nos canais';

  @override
  String get botChannels_title => 'Canais';

  @override
  String get botChannels_hint =>
      'O bot também responde a !comandos nos canais que ativar, no próprio canal. Nunca envia respostas de ausência aí.';

  @override
  String get botChannels_none => 'Ainda não há canais neste rádio.';

  @override
  String get advert_zeroHopHint =>
      'Só os rádios que o ouvem diretamente. Os repetidores não o reencaminham.';

  @override
  String get advert_floodHint =>
      'Os repetidores espalham-no por toda a malha. Usa mais tempo de emissão.';

  @override
  String get radioPresets_custom => 'Personalizado';

  @override
  String get radioPresets_search => 'Pesquisar predefinições';

  @override
  String get radioPresets_suggested => 'Sugerido para a sua região';

  @override
  String get radioPresets_community => 'Predefinições da comunidade';

  @override
  String get radioPresets_hint =>
      'Estas são as predefinições sugeridas pela comunidade MeshCore. Escolha a da sua malha local. Define frequência, largura de banda, fator de espalhamento e taxa de codificação; a potência de transmissão mantém-se.';

  @override
  String get mySensors_title => 'Sensores';

  @override
  String get mySensors_refresh => 'Ler sensores';

  @override
  String get mySensors_reading => 'A ler os sensores do rádio…';

  @override
  String get mySensors_failed =>
      'O rádio não respondeu. Toque em atualizar para tentar de novo.';

  @override
  String get mySensors_none => 'Sem leituras de sensores do rádio.';

  @override
  String get activeChannels_title => 'Ativos online';

  @override
  String activeChannels_messages(int count) {
    return '$count mensagens';
  }

  @override
  String activeChannels_source(String host) {
    return 'Canais em uso, segundo os observadores de $host. Mude o analisador nas definições para ver a sua zona.';
  }

  @override
  String get fieldOps_checkInChannelLabel =>
      'Check-ins também vão para o canal';

  @override
  String get fieldOps_checkInChannelHint =>
      'Assinado com a chave do rádio, para que os outros no canal vejam que é mesmo você. Os contactos da viagem continuam a recebê-lo diretamente.';

  @override
  String get channels_regionUnknown => 'Regional';

  @override
  String channels_regionSemantics(String region) {
    return 'Enviado para a região $region';
  }

  @override
  String get channels_regionUnknownSemantics =>
      'Enviado para uma região que a app não conhece';

  @override
  String get wardrive_title => 'Wardrive';

  @override
  String get wardrive_hint =>
      'Faça ping de onde está e mapeie que repetidores o ouvem';

  @override
  String get wardrive_start => 'Iniciar';

  @override
  String get wardrive_stop => 'Parar';

  @override
  String get wardrive_pings => 'pings';

  @override
  String get wardrive_heard => 'ouvidos';

  @override
  String get wardrive_pinging => 'A fazer ping…';

  @override
  String get wardrive_waitPosition =>
      'À espera de posição GPS do telemóvel ou do rádio.';

  @override
  String get wardrive_waitRadio => 'Ligue um rádio para fazer ping.';

  @override
  String get wardrive_history => 'Histórico';

  @override
  String get wardrive_noSessions => 'Ainda sem percursos.';

  @override
  String wardrive_sessionSummary(int pings, int heard) {
    return '$pings pings · $heard ouvidos';
  }

  @override
  String get wardrive_delete => 'Eliminar';

  @override
  String get wardrive_recentre => 'Voltar à minha posição';

  @override
  String get wardrive_youAreHere => 'Está aqui';

  @override
  String get wardrive_backToLive => 'Voltar ao percurso atual';

  @override
  String get wardrive_noReplies => 'Nenhum repetidor ouviu este ping.';

  @override
  String wardrive_replyDetail(String there, String here) {
    return 'Ouviu-o a $there dB · ouviu-o a $here dB';
  }

  @override
  String get wardrive_explainer =>
      'Cada ping é um pedido de descoberta de salto zero: só respondem repetidores ao alcance direto e nada é publicado num canal. As posições vêm do GPS do telemóvel ou, se não houver, do rádio.';

  @override
  String get mapTelemetry_policy =>
      'As leituras guardadas ficam esbatidas após 1 hora e desaparecem após 24 horas. Atualizar envia um pedido; o nó deve permitir telemetria e os sensores podem exigir início de sessão. O mapa nunca pede atualizações automaticamente.';

  @override
  String get autoConnect_title => 'Ligar automaticamente ao meu rádio';

  @override
  String get autoConnect_hint =>
      'Ao abrir a app, volta a ligar ao último rádio sem tocar. Tenta algumas vezes se o rádio ainda não estiver ao alcance.';

  @override
  String get networks_title => 'Redes';

  @override
  String get networks_hint => 'Procurar redes próximas e manter um registo';

  @override
  String get networks_yourNetwork => 'A sua rede';

  @override
  String get networks_scanTitle => 'Procurar redes';

  @override
  String get networks_scanExplainer =>
      'O rádio só ouve redes com exatamente as mesmas definições, por isso a procura muda-o para cada uma à vez, escuta e volta a repô-lo. Durante a procura fica fora da sua malha.';

  @override
  String get networks_listenFor => 'Escutar em cada uma';

  @override
  String networks_choose(int count) {
    return 'Redes a procurar: $count';
  }

  @override
  String get networks_suggested => 'Sugeridas';

  @override
  String get networks_start => 'Iniciar procura';

  @override
  String get networks_cancel => 'Parar procura';

  @override
  String networks_listening(String name, int step, int steps) {
    return 'A escutar $name ($step de $steps)';
  }

  @override
  String get networks_blockNoRadio => 'Ligue um rádio para procurar.';

  @override
  String get networks_blockSettings => 'À espera das definições do rádio.';

  @override
  String get networks_blockSos =>
      'Não com um SOS ativo: a procura tira-o da sua malha.';

  @override
  String get networks_blockTrip =>
      'Não durante uma viagem: a procura tira-o da sua malha.';

  @override
  String get networks_nearby => 'Redes próximas';

  @override
  String get networks_nothingYet =>
      'Ainda não foi ouvida nenhuma rede. Faça uma procura.';

  @override
  String networks_heardSummary(int nodes, int packets, String snr) {
    return 'Nós $nodes · pacotes $packets · SNR $snr dB';
  }

  @override
  String networks_lastHeard(String time) {
    return 'Ouvida pela última vez $time';
  }

  @override
  String networks_timesHeard(int count) {
    return 'Vezes ouvida: $count';
  }

  @override
  String get networks_saved => 'Redes guardadas';

  @override
  String get networks_noSaved => 'Ainda não há redes guardadas.';

  @override
  String get networks_add => 'Adicionar uma rede';

  @override
  String get networks_join => 'Juntar-se';

  @override
  String networks_joinConfirm(String name) {
    return 'Mudar o rádio para $name? Vai sair da rede atual. A potência de transmissão mantém-se.';
  }

  @override
  String networks_joined(String name) {
    return 'O rádio está agora em $name.';
  }

  @override
  String get networks_log => 'Registo de redes';

  @override
  String get networks_logEmpty => 'Ainda nada registado.';

  @override
  String get networks_showMap => 'Mapa';

  @override
  String get networks_exportCsv => 'Exportar CSV';

  @override
  String get networks_exportGpx => 'Exportar GPX';

  @override
  String get networks_clearLog => 'Limpar registo';

  @override
  String get networks_clearLogConfirm => 'Apagar todas as redes registadas?';

  @override
  String get networks_name => 'Nome';

  @override
  String get networks_invalid =>
      'Verifique as definições: estão fora do que os rádios MeshCore aceitam.';

  @override
  String get networks_nodesHeard => 'Nós ouvidos';

  @override
  String get chat_resendNeedsRadio =>
      'Não enviada: ligue o rádio e tente novamente. A mensagem é mantida.';

  @override
  String get quick_title => 'Mensagens rápidas';

  @override
  String get quick_ok => 'OK';

  @override
  String get quick_onMyWay => 'Estou a caminho';

  @override
  String get quick_atCamp => 'No acampamento';

  @override
  String get quick_runningLate => 'Vou atrasar-me';

  @override
  String get quick_needHelp => 'Preciso de ajuda';

  @override
  String get quick_copyThat => 'Recebido';

  @override
  String get quick_empty =>
      'Não há mensagens rápidas. Toque em Editar para adicionar uma.';

  @override
  String get quick_add => 'Nova mensagem rápida';

  @override
  String get quick_reset => 'Repor as predefinidas';

  @override
  String get chat_stopRetrying => 'Parar de tentar';

  @override
  String chat_addFirstBanner(String name) {
    return '$name só pode ler e responder às suas mensagens diretas depois de o adicionar como contacto. Se ainda não o fez, envie o seu anúncio ou partilhe o seu contacto.';
  }

  @override
  String get map_goToMyPosition => 'Ir para a minha posição';

  @override
  String get map_positionUnavailable =>
      'A sua posição não está disponível. Ative a localização ou defina a posição do rádio.';

  @override
  String get contact_forgetAdvert => 'Esquecer o último anúncio';

  @override
  String get contact_forgetAdvertHint =>
      'Se os anúncios deste nó deixaram de atualizar depois de o relógio ser reposto, Esquecer o último anúncio deixa passar o seguinte.';

  @override
  String get contact_forgetAdvertDone =>
      'Feito. O próximo anúncio deste nó será aceite.';

  @override
  String get networks_modeQuick => 'Rápida';

  @override
  String get networks_modeThorough => 'Completa';

  @override
  String get networks_modeQuickHint =>
      'Envia um ping curto de salto zero em cada rede e escuta alguns segundos. Encontra redes com um repetidor ao alcance.';

  @override
  String get networks_modeThoroughHint =>
      'Só escuta, mais tempo em cada rede. Não envia nada e também encontra redes sem repetidor ao alcance se alguém transmitir.';

  @override
  String networks_estimate(String time) {
    return 'cerca de $time';
  }

  @override
  String discoveredContacts_selected(int count) {
    return '$count selecionados';
  }

  @override
  String get discoveredContacts_selectAll => 'Selecionar tudo';

  @override
  String get discoveredContacts_addSelected => 'Adicionar selecionados';

  @override
  String discoveredContacts_addAllShown(int count) {
    return 'Adicionar todos os mostrados ($count)';
  }

  @override
  String discoveredContacts_addManyTitle(int count) {
    return 'Adicionar $count contactos?';
  }

  @override
  String discoveredContacts_roomLeft(int room) {
    return 'O rádio tem espaço para mais $room contactos.';
  }

  @override
  String discoveredContacts_roomLimit(int room, int count) {
    return 'O rádio tem espaço para mais $room contactos, por isso só serão adicionados os primeiros $room de $count.';
  }

  @override
  String discoveredContacts_adding(int done, int total) {
    return 'A adicionar $done de $total…';
  }

  @override
  String discoveredContacts_addedMany(int count) {
    return 'Contactos adicionados: $count';
  }

  @override
  String discoveredContacts_addedSome(int added, int failed) {
    return 'Contactos adicionados: $added. Não adicionados: $failed.';
  }

  @override
  String get discoveredContacts_radioFull =>
      'A lista de contactos do rádio está cheia. Remova alguns contactos primeiro.';

  @override
  String get fieldIntel_radioNow => 'Rádio agora';

  @override
  String get fieldIntel_noRadio => 'Ligue o rádio para ver dados em direto.';

  @override
  String get fieldIntel_noise => 'ruído dBm';

  @override
  String get fieldIntel_lastSnr => 'último SNR';

  @override
  String get fieldIntel_lastRssi => 'último RSSI';

  @override
  String get fieldIntel_battery => 'bateria V';

  @override
  String fieldIntel_airtime(String sent, String received) {
    return 'Tempo no ar desde que o rádio arrancou: enviado $sent, recebido $received';
  }

  @override
  String get fieldIntel_whoAround => 'Quem está por perto';

  @override
  String get fieldIntel_m15 => '15 min';

  @override
  String get fieldIntel_h1 => '1 hora';

  @override
  String get fieldIntel_h24 => '24 horas';

  @override
  String get fieldIntel_older => 'Mais antigos';

  @override
  String get fieldIntel_lastHour => 'Última hora';

  @override
  String get fieldIntel_chartHint =>
      'Quando cada nó foi ouvido pela última vez, hora a hora, no último dia. Toque numa barra para ver quem.';

  @override
  String get fieldIntel_mix => 'Tipos de nó';

  @override
  String get fieldIntel_reach => 'Alcance';

  @override
  String get fieldIntel_hops1 => '1 salto';

  @override
  String get fieldIntel_hops2 => '2 saltos';

  @override
  String get fieldIntel_hops3 => '3+ saltos';

  @override
  String get fieldIntel_noRoute => 'Ainda sem rota';

  @override
  String get fieldIntel_distance => 'Mais perto e mais longe';

  @override
  String get fieldIntel_noneLocated => 'Nenhum dos seus contactos tem posição.';

  @override
  String get fieldIntel_noPosition =>
      'O rádio ainda não tem posição, por isso não é possível calcular distâncias.';

  @override
  String get fieldIntel_bestRepeaters =>
      'Melhores repetidores ouvidos diretamente';

  @override
  String get fieldIntel_noneDirect =>
      'Nenhum repetidor ouvido diretamente nos últimos 30 minutos.';

  @override
  String get fieldIntel_attention => 'Requer atenção';

  @override
  String get fieldIntel_allGood => 'Nada requer atenção.';

  @override
  String fieldIntel_lowBattery(String volts) {
    return 'Bateria fraca: $volts V';
  }

  @override
  String fieldIntel_quietFavorite(String ago) {
    return 'Favorito sem ser ouvido desde $ago';
  }

  @override
  String get fieldIntel_moreTools => 'Mais ferramentas';

  @override
  String fieldIntel_nodeCount(int count) {
    return 'Nós: $count';
  }

  @override
  String get fieldIntel_none => 'Sem nós.';

  @override
  String fieldIntel_lastHeard(String ago) {
    return 'Ouvido pela última vez $ago';
  }

  @override
  String get fieldIntel_showOnMap => 'Mostrar no mapa';

  @override
  String get fieldIntel_openChat => 'Abrir conversa';

  @override
  String get repeaterTools_login => 'Iniciar sessão';

  @override
  String get repeaterTools_heardDirect => 'Ouvido diretamente';

  @override
  String get repeaterTools_filterAll => 'Todos';

  @override
  String get repeaterTools_filterLowBattery => 'Bateria fraca';

  @override
  String get repeaterTools_hint =>
      'Toque num repetidor para ver os detalhes e inicie sessão a partir daí para ver estado, vizinhos, telemetria e a linha de comandos.';

  @override
  String get repeaterTools_noneMatch => 'Sem repetidores aqui.';

  @override
  String get repeaterTools_toolsTitle => 'Ferramentas';

  @override
  String get repeaterTools_regionSetupHint =>
      'Procure a árvore de regiões da sua zona e copie os comandos';

  @override
  String get routes_failingOnly => 'Só rotas que falharam';

  @override
  String get routes_contactDetails => 'Detalhes do contacto';

  @override
  String get pathGraph_you => 'Você';

  @override
  String pathGraph_relayed(int count) {
    return 'Retransmitiu $count mensagens';
  }

  @override
  String get pathGraph_ambiguousNote =>
      'Este ID curto corresponde a mais de um repetidor, por isso não pode ser atribuído a um só.';

  @override
  String get pathGraph_comesFrom => 'Vem de';

  @override
  String get pathGraph_goesTo => 'Vai para';

  @override
  String get pathGraph_repeaterDetails => 'Detalhes do repetidor';

  @override
  String get pathGraph_days7 => '7 dias';

  @override
  String get pathGraph_empty =>
      'Ainda não há caminhos de mensagens de canal neste período. Os caminhos são recolhidos das mensagens de canal recebidas enquanto o rastreio está ligado.';

  @override
  String pathGraph_summary(int paths, int repeaters) {
    return '$paths caminhos ouvidos · $repeaters repetidores';
  }

  @override
  String get pathGraph_hashOnly =>
      'Cada salto é mostrado pelo prefixo de hash, ou pelo nome se conhecer o repetidor.';

  @override
  String pathGraph_matched(int count) {
    return '$count saltos curtos (1 byte) associados a um repetidor específico com caminhos mais longos.';
  }

  @override
  String pathGraph_matchedAmbiguous(int matched, int ambiguous) {
    return '$matched saltos curtos (1 byte) associados a um repetidor específico com caminhos mais longos · $ambiguous ainda ambíguos (marcados com ?).';
  }

  @override
  String get pathGraph_chartHint =>
      'Esquerda: repetidores mais distantes. Direita: você. A largura da faixa é quantas mensagens passaram por esse salto. Toque numa caixa para ver o repetidor.';

  @override
  String get pathGraph_busiest => 'Repetidores mais usados';

  @override
  String pathGraph_chartSemantics(String name, int count) {
    return 'Grafo de caminhos. Repetidor mais usado $name, retransmitiu $count mensagens.';
  }

  @override
  String diag_copied(String label) {
    return 'Copiado: $label';
  }

  @override
  String get diag_noChannels => 'Sem canais neste rádio.';

  @override
  String get diag_tapToCopy =>
      'Toque num valor para o copiar. Puxe para baixo para atualizar.';

  @override
  String get diag_storage => 'Armazenamento';

  @override
  String diag_storageValue(int used, int total) {
    return '$used de $total KB';
  }
}
