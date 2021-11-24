import 'package:flutter/widgets.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Notifications extends ChangeNotifier {
  Future notifyUserOfAcess(String playerId) async {
    await OneSignal.shared.postNotification(
      OSCreateNotification(
          playerIds: [playerId],
          content: 'Alguém está vendo a sua conta no Carteira Médica agora.',
          heading: 'Alerta de Acesso',
          buttons: [
            OSActionButton(text: "Ok", id: "id"),
          ]),
    );
  }
}
