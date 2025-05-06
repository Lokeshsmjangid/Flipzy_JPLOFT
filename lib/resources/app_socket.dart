import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:developer' as developer;

class SocketService {
  IO.Socket? socket;

  void connect() {
    developer.log('Connecting to socket...');
    // Configure the socket
    socket = IO.io('${ApiUrls.domain}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      // "timeout": 10000,
    });

    // Add event listeners
    socket?.on('connect', (_) {
      developer.log('Connected to server');
    });

    socket?.on('disconnect', (_) {
      developer.log('Disconnected from server');

    });

    socket?.on('connect_error', (error) {
      developer.log('Connection Error: $error');
    });

    socket?.on('connect_timeout', (_) {
      developer.log('Connection Timeout');
    });

    socket?.on('error', (error) {
      developer.log('Error: $error');
    });

    // Listen for THREADS_LIST_RESPONSE event
    /*socket?.on('THREADS_LIST_RESPONSE', (data) {
      developer.log('Received THREADS_LIST_RESPONSE: $data');
      // Handle the response data as needed
    });*/

    // Connect to the server
    socket?.connect();
  }

  /*void requestThreadsList(String senderId) {
    final requestData = {
      'senderId': senderId,
    };
    developer.log('Requesting threads list with data: $requestData');
    socket?.emit('THREADS_LIST', requestData);
  }*/

  void sendMessage(String event, dynamic data) {
    developer.log('Sending message: $event - $data');
    socket?.emit(event, data);
  }

  void dispose() {
    developer.log('Disposing socket...');
    socket?.dispose();
  }
}
