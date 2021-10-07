import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:carteiramedapp/models/http_exception.dart';
import 'package:carteiramedapp/models/user_info.dart';

class UsersInfo extends ChangeNotifier {
  CollectionReference _users = FirebaseFirestore.instance.collection('user');

  Future<QuerySnapshot<UserInf>> getUserById(String uid) async {
    return await _users
        .where('userId', isEqualTo: uid)
        .withConverter<UserInf>(
            fromFirestore: (snapshot, _) => UserInf.fromJson(snapshot.data()!),
            toFirestore: (schedule, _) => schedule.toJson())
        .get();
  }

  Future<String> findUserByCpf(String cpf) async {
    return await _users
        .doc(cpf)
        .withConverter<UserInf>(
            fromFirestore: (snapshot, _) => UserInf.fromJson(snapshot.data()!),
            toFirestore: (schedule, _) => schedule.toJson())
        .get()
        .then((userSnapshot) {
      if (userSnapshot.exists) {
        return userSnapshot.data()!.userId;
      } else {
        throw HttpException("CPF não encontrado");
      }
    });
  }

  Future<String?> getEmailByCPF(String cpf) async {
    return await _users
        .doc(cpf)
        .withConverter<UserInf>(
            fromFirestore: (snapshot, _) => UserInf.fromJson(snapshot.data()!),
            toFirestore: (schedule, _) => schedule.toJson())
        .get()
        .then((userSnapshot) {
      if (userSnapshot.exists)
        return userSnapshot.data()!.email;
      else
        throw HttpException("CPF não encontrado");
    }).catchError(
            (e) => throw HttpException("Houve um Erro!" + e.code.toString()));
  }
}
