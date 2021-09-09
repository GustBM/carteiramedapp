import 'package:carteiramedapp/models/http_exception.dart';
import 'package:carteiramedapp/models/user_info.dart';
import 'package:carteiramedapp/utils.dart';
import 'package:flutter/material.dart';

class UsersInfo extends ChangeNotifier {
  /*CollectionReference _schedules =
      FirebaseFirestore.instance.collection('user');
  
  Future<DocumentSnapshot<Schedule>> getUserInfo(String userCpf) async {
    return _schedules
        .doc(userId)
        .withConverter<UserInfo>(
            fromFirestore: (snapshot, _) => UserInfo.fromJson(snapshot.data()!),
            toFirestore: (schedule, _) => schedule.toJson())
        .get();
  }*/

  Future<int> getUserByCPF(String input) async {
    var newInput;
    if (isValidCPF(input)) {
      newInput = int.parse(input);
      print('É cpf');
    } else if (isValidEmail(input)) {
      newInput = input;
    } else {
      throw HttpException('Formato inválido. Apenas CPF ou e-mail');
    }
    if (int.parse(input) == 13047889708)
      return 1;
    else
      throw HttpException('Usuário não encontrado');
  }
}
