import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:carteiramedapp/models/http_exception.dart';
import 'package:carteiramedapp/models/user_info.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  CollectionReference _userInf = FirebaseFirestore.instance.collection('user');

  String get currentUserId {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> newUser(
      String cpf,
      String name,
      String bthdate,
      String email,
      String? imgUrl,
      List<String> med,
      List<String> cond,
      List<String> vac,
      String pwd) async {
    UserCredential? user;

    try {
      user = await _auth.createUserWithEmailAndPassword(
          email: email, password: pwd);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw HttpException(
            "Senha considerada muito fraca. Tente novamente com numeros, simbolos e letras maiusculas.");
      } else if (e.code == 'email-already-in-use') {
        throw HttpException("Já existe um usuário com este e-mail.");
      }
    } catch (e) {
      throw HttpException("Houve um Erro!" + e.toString());
    }

    UserInf newUser = new UserInf(
        cpf: cpf,
        userId: user!.user!.uid,
        name: name,
        birthDate: bthdate,
        email: email,
        imageUrl: imgUrl,
        medications: med,
        conditions: cond,
        vaccines: vac);

    addAndUpdateAppUser(cpf, newUser).then((value) {
      login(newUser.email, pwd);
    }).catchError(
        (e) => throw HttpException("Houve um Erro!" + e.code.toString()));
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          throw HttpException("E-mail inválido.");

        case "wrong-password":
          throw HttpException("Senha Incorreta");

        case "user-not-found":
          throw HttpException("E-mail não encontrado.");

        case "user-disabled":
          throw HttpException("Usuário desabilitado.");

        default:
          throw HttpException("Houve um erro!\n" + error.toString());
      }
    }
    notifyListeners();
  }

  Future<void> addAndUpdateAppUser(String userCpf, UserInf appUser) async {
    _userInf
        .doc(userCpf)
        .withConverter<UserInf>(
            fromFirestore: (snapshot, _) => UserInf.fromJson(snapshot.data()!),
            toFirestore: (schedule, _) => schedule.toJson())
        .set(appUser);
  }

  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }
}
