import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;

  get serverStatus => _serverStatus;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // IO.Socket socket = IO.io('https://vibramon.co/ws/socket.io/', {
    // IO.Socket socket = IO.io('https://express-server-socket-io.onrender.com/', {
    IO.Socket socket = IO.io('http://192.168.2.31:3000/', {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
      print('connect');
    });
    socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
      print('disconnect');
    });
    socket.on('fromServer', (_) => print(_));
  }
}
