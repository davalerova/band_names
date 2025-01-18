import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // IO.Socket socket = IO.io('https://vibramon.co/ws/socket.io/', {
    // _socket = IO.io('http://192.168.2.31:3000/', {
    _socket = IO.io('https://express-server-socket-io.onrender.com/', {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
      print('connect');
    });
    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
      print('disconnect');
    });
    // socket.on('nuevo-mensaje', (payload) {
    //   print('nuevo mensaje');
    //   print('Nombre: ${payload['nombre']}');
    //   print('Email: ${payload['email']}');
    //   print(
    //       'Mensaje: ${payload.containsKey('mensaje') ? payload['mensaje'] : 'No hay mensaje'}');
    // });
    // socket.on('active-bands', (payload) {
    //   print('active-bands $payload');
    // });
  }
}
