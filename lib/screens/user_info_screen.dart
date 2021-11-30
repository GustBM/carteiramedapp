import 'dart:io';

import 'package:async/async.dart';
import 'package:carteiramedapp/providers/notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:carteiramedapp/models/user_info.dart';
import 'package:carteiramedapp/providers/auth.dart';
import 'package:carteiramedapp/providers/users_info.dart';
import 'package:carteiramedapp/widgets/user_info/user_info_form_datefield.dart';
import 'package:carteiramedapp/widgets/user_info/user_info_form_list.dart';
import 'package:carteiramedapp/widgets/user_info/user_info_form_textfield.dart';

class UserInfoScreen extends StatelessWidget {
  static const routeName = '/user-info';
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).primaryColor;
    String userId = ModalRoute.of(context)!.settings.arguments as String;
    var t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(224, 224, 224, 1).withOpacity(0.5),
                  Color.fromRGBO(primaryColor.red, primaryColor.green,
                          primaryColor.blue, 1)
                      .withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: deviceWidth < 500 ? deviceWidth : 500,
              child: Center(
                child: UserInfoForm(userId),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoForm extends StatefulWidget {
  final String thisUser;
  UserInfoForm(this.thisUser);

  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _bthdayController = TextEditingController();
  late final Future<QuerySnapshot<UserInf>> myFuture;
  final AsyncMemoizer<QuerySnapshot<UserInf>> _memoizer = AsyncMemoizer();

  XFile? _imgFile;
  final ImagePicker _imgPicker = ImagePicker();

  var isLoading = false;

  void _takePicture(ImageSource source) async {
    final pickedFile = await _imgPicker.pickImage(source: source);
    setState(() {
      _imgFile = pickedFile;
    });
  }

  Widget _photoOptionBottomSheet() {
    var t = AppLocalizations.of(context);
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(t!.escolhaFoto, style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  _takePicture(ImageSource.camera);
                },
                child: Row(children: [
                  Icon(Icons.camera),
                  Text(t.camera),
                ]),
              ),
              SizedBox(width: 30),
              TextButton(
                onPressed: () {
                  _takePicture(ImageSource.gallery);
                },
                child: Row(children: [
                  Icon(Icons.photo_album),
                  Text(t.galeria),
                ]),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _imageProfile(String? imgFile) {
    return Stack(
      children: [
        CircleAvatar(
            radius: 80.0,
            backgroundImage: _imgFile == null
                ? imgFile == null
                    ? Image.asset('assets/img/standard_user_img.png').image
                    : Image.network(imgFile).image
                : FileImage(File(_imgFile!.path))),
        Positioned(
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: ((builder) => _photoOptionBottomSheet()));
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
          bottom: 20.0,
          right: 20.0,
        ),
      ],
    );
  }

  Future<QuerySnapshot<UserInf>> _fetchData() async {
    return _memoizer.runOnce(() async {
      return await Provider.of<UsersInfo>(context, listen: false)
          .getUserById(widget.thisUser);
    });
  }

  void initState() {
    myFuture = _fetchData();
    super.initState();
  }

  bool edit = true;

  void _canEdit() {
    setState(() {
      edit = !edit;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isUser =
        Provider.of<Auth>(context, listen: false).currentUserId ==
            widget.thisUser;
    var t = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder<QuerySnapshot<UserInf>>(
        future: myFuture,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<UserInf>> snapshot) {
          UserInf userInfo;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.size > 0) {
              userInfo = snapshot.data!.docs[0].data();
              if (!isUser && userInfo.playerId != null) {
                Provider.of<Notifications>(context)
                    .notifyUserOfAcess(userInfo.playerId!);
              }

              _nameController.text = userInfo.name;
              _emailController.text = userInfo.email;
              _cpfController.text = userInfo.cpf;
              _bthdayController.text = userInfo.birthDate;

              return Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: edit
                                  ? CircleAvatar(
                                      backgroundImage: userInfo.imageUrl != null
                                          ? Image.network(userInfo.imageUrl!)
                                              .image
                                          : Image.asset(
                                                  'assets/img/standard_user_img.png')
                                              .image,
                                      maxRadius: 75,
                                    )
                                  : _imageProfile(userInfo.imageUrl),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  UserInfoFormTextField(t!.nome,
                                      _nameController, userInfo.name, edit),
                                  SizedBox(height: 10),
                                  UserInfoFormTextField('CPF', _cpfController,
                                      userInfo.cpf, false),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        UserInfoFormTextField(
                            t.email, _emailController, userInfo.email, edit),
                        SizedBox(height: 10),
                        UserInfoFormDateField(t.dataNascimento,
                            _bthdayController, userInfo.birthDate, edit),
                        SizedBox(height: 10),
                        UserInfoFormList(
                            t.medicacoes, userInfo.medications, edit),
                        UserInfoFormList(t.vacinas, userInfo.vaccines, edit),
                        UserInfoFormList(t.doencas, userInfo.conditions, edit),
                        SizedBox(height: 20),
                        isUser
                            ? Column(
                                children: edit
                                    ? [
                                        SizedBox(height: 30),
                                        ElevatedButton(
                                            onPressed: _canEdit,
                                            child: Text(t.editar)),
                                        SizedBox(height: 30),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context)
                                                  .pushReplacementNamed('/');
                                              Provider.of<Auth>(context,
                                                      listen: false)
                                                  .logout();
                                            },
                                            child: Text(t.sairConta))
                                      ]
                                    : [
                                        !isLoading
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  Provider.of<Auth>(context,
                                                          listen: false)
                                                      .updateUser(
                                                          _cpfController.text,
                                                          _nameController.text,
                                                          _bthdayController
                                                              .text,
                                                          _emailController.text,
                                                          _imgFile != null
                                                              ? File(_imgFile!
                                                                  .path)
                                                              : null,
                                                          userInfo.medications,
                                                          userInfo.conditions,
                                                          userInfo.vaccines)
                                                      .then((value) {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text(t.salvar))
                                            : CircularProgressIndicator(),
                                        SizedBox(height: 10),
                                        ElevatedButton(
                                            onPressed: _canEdit,
                                            child: Text(t.voltar)),
                                      ],
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.data!.size == 0) {
              return Center(
                child: Text(t!.nenhumUsuarioCPF + widget.thisUser),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(t!.erroBuscaUsuario),
              );
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
