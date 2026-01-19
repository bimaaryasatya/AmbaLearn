import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../config/api_config.dart';

class AntiCheatService {
  static final AntiCheatService _instance = AntiCheatService._internal();

  factory AntiCheatService() {
    return _instance;
  }

  AntiCheatService._internal();

  IO.Socket? _socket; // Nullable to check init status
  bool _isConnected = false;
  
  // Stream Controllers
  final _statusController = StreamController<Map<dynamic, dynamic>>.broadcast();
  final _cheatingAlertController = StreamController<Map<String, dynamic>>.broadcast();
  final _autoSubmitController = StreamController<String>.broadcast();
  final _connectionChangeController = StreamController<bool>.broadcast();
  final _debugController = StreamController<String>.broadcast();
  
  // Stream Getters
  Stream<Map<dynamic, dynamic>> get statusStream => _statusController.stream;
  Stream<Map<String, dynamic>> get cheatingAlertStream => _cheatingAlertController.stream;
  Stream<String> get autoSubmitStream => _autoSubmitController.stream;
  Stream<bool> get connectionChangeStream => _connectionChangeController.stream;
  Stream<String> get debugStream => _debugController.stream;

  bool get isConnected => _isConnected;

  void init() {
    if (_socket != null) return; // Prevent re-init if already initialized

    _socket = IO.io(ApiConfig.antiCheatBaseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket!.onConnect((_) {
      debugPrint('AC: Connected to anti-cheat service');
      _addDebugLog('Connected to Anti-Cheat Service');
      _isConnected = true;
      _connectionChangeController.add(true);
    });


    _socket!.onDisconnect((_) {
      debugPrint('AC: Disconnected');
      _addDebugLog('Disconnected from Anti-Cheat Service');
      _isConnected = false;
      _connectionChangeController.add(false);
    });

    _socket!.on('cheating_alert', (data) {
      debugPrint('AC: Cheating Alert: $data');
      _addDebugLog('EVENT: cheating_alert -> $data');
      if (data is Map) {
         // reconstruct cleaner map
         final detail = data['detail']?.toString() ?? 'Violation';
         final count = int.tryParse(data['violation_count']?.toString() ?? '0') ?? 0;
         final max = int.tryParse(data['max_violations']?.toString() ?? '3') ?? 3;
         
         _cheatingAlertController.add({
           'detail': detail,
           'count': count,
           'max': max
         });
      }
    });

    _socket!.on('status', (data) {
      // _addDebugLog('EVENT: status -> $data'); // Too noisy? currently disabled
      if (data is Map) {
        _statusController.add(data);
      }
    });

    _socket!.on('auto_submit', (data) {
      debugPrint('AC: Auto Submit: $data');
      _addDebugLog('EVENT: auto_submit -> $data');
      if (data is Map && data.containsKey('detail')) {
        _autoSubmitController.add(data['detail'].toString());
      }
    });
    
    _socket!.onConnectError((data) {
      debugPrint('AC: Connection Error: $data');
      _addDebugLog('ERROR: Connection Error: $data');
    });

    _socket!.onAny((event, data) {
       if (event != 'status' && event != 'processed_frame') {
          _addDebugLog('ANY: $event -> $data');
       }
    });
  }

  void connect() {
    if (_socket != null && !_socket!.connected) {
      _socket!.connect();
    }
  }

  void startExamSession() {
    if (_isConnected && _socket != null) {
      _socket!.emit('start_exam', {});
      debugPrint('AC: Signal Sent -> start_exam');
      _addDebugLog('Signal Sent: start_exam');
    }
  }

  void disconnect() {
    if (_socket != null && _socket!.connected) {
      _socket!.disconnect();
    }
  }

  void sendFrame(String base64Frame) {
    if (_isConnected && _socket != null) {
      _socket!.emit('send_frame', base64Frame);
       // Optional throttle log
       // _addDebugLog('Sent frame'); 
    } else {
      debugPrint("AC: Frame dropped - Not connected");
      _addDebugLog('Frame dropped - Not connected');
    }
  }

  void _addDebugLog(String log) {
    // Add timestamp?
    final time = DateTime.now().toIso8601String().split('T').last.split('.').first;
    _debugController.add("[$time] $log");
  }
  
  void dispose() {
    // Optionally: don't fully dispose, just disconnect or clear listeners.
    // In singleton, we usually want to keep the socket unless app exits.
    // For now, let's just clear listeners but keep connection if needed, 
    // or provide a force dispose.
    
    // We will NOT call dispose() in typical page navigation now.
    // Call reset listeners if needed.
    
    // If you really want to close:
    // disconnect();
    // _socket?.dispose();
    // _socket = null;
  }
  

}
