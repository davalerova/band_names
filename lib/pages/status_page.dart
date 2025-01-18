import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    // socketService.socket.emit()
    return Scaffold(
      body: Center(
        child: Center(
          child: Text(socketService.serverStatus.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            socketService.emit('emitir-mensaje',
                {'nombre': 'Flutter', 'mensaje': 'Hola desde Flutter'});
            print("Emitiendo mensaje");
          }),
    );
  }
}
