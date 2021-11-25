import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:carteiramedapp/models/http_exception.dart';
import 'package:carteiramedapp/providers/auth.dart';
import 'package:carteiramedapp/widgets/user_info/user_info_form_datefield.dart';
import 'package:carteiramedapp/widgets/user_info/user_info_form_list.dart';
import 'package:carteiramedapp/widgets/user_info/user_info_form_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils.dart';

class NewUserScreen extends StatefulWidget {
  static const routeName = '/new-user';
  const NewUserScreen({Key? key}) : super(key: key);

  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _registerForm = GlobalKey();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _cpfController = TextEditingController();
    final TextEditingController _bthdayController = TextEditingController();
    final TextEditingController _pwdController = TextEditingController();
    final TextEditingController _confirmPwdController = TextEditingController();
    List<String> _medications = [];
    List<String> _conditions = [];
    List<String> _vaccines = [];

    var _isLoading = false;
    var t = AppLocalizations.of(context);

    XFile? _imgFile;
    final ImagePicker _imgPicker = ImagePicker();

    void _takePicture(ImageSource source) async {
      final pickedFile = await _imgPicker.pickImage(source: source);
      setState(() {
        _imgFile = pickedFile;
      });
    }

    Widget _photoOptionBottomSheet() {
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
                    Text('Camera'),
                  ]),
                ),
                SizedBox(width: 30),
                TextButton(
                  onPressed: () {
                    _takePicture(ImageSource.gallery);
                  },
                  child: Row(children: [
                    Icon(Icons.photo_album),
                    Text('Galeria'),
                  ]),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget _imageProfile() {
      return Stack(
        children: [
          CircleAvatar(
              radius: 80.0,
              backgroundImage: _imgFile == null
                  ? Image.asset('assets/img/standard_user_img.png').image
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

    Future<void> _submit() async {
      if (!_registerForm.currentState!.validate()) {
        // Invalid!
        return;
      }
      _registerForm.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      String imageUrl = '';
      try {
        if (_imgFile != null) {
          FirebaseStorage storage = FirebaseStorage.instance;
          Reference ref =
              storage.ref().child("profile_image").child(_cpfController.text);
          await ref.putFile(File(_imgFile!.path)).then((storageTask) async {
            imageUrl = await storageTask.ref.getDownloadURL();
          });
        }
        await Provider.of<Auth>(context, listen: false).newUser(
            context,
            _cpfController.text,
            _nameController.text,
            _bthdayController.text,
            _emailController.text,
            imageUrl,
            _medications,
            _conditions,
            _vaccines,
            _pwdController.text);
      } on HttpException catch (e) {
        showWarningDialog(context, e.toString());
      } catch (e) {
        showWarningDialog(context, e.toString());
      }
      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(224, 224, 224, 1).withOpacity(0.5),
              Color.fromRGBO(
                      Theme.of(context).primaryColor.red,
                      Theme.of(context).primaryColor.green,
                      Theme.of(context).primaryColor.blue,
                      1)
                  .withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _registerForm,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: _imageProfile(),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          UserInfoFormTextField(
                              t!.nomeCompleto, _nameController, null, false),
                          SizedBox(height: 10),
                          UserInfoFormTextField(
                              'CPF', _cpfController, null, false),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                UserInfoFormTextField(t.email, _emailController, null, false),
                SizedBox(height: 10),
                UserInfoFormDateField(
                    t.dataNascimento, _bthdayController, null, false),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: t.senha,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) return t.esteCampoObrigatorio;
                    if (_pwdController.text.length < 6) return t.senhaMaisQue6;
                    return null;
                  },
                  controller: _pwdController,
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: t.confirmarSenha,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) return t.esteCampoObrigatorio;
                    if (_pwdController.text != _confirmPwdController.text)
                      return t.senhaEConfirmaNaoIgual;
                    return null;
                  },
                  controller: _confirmPwdController,
                ),
                SizedBox(height: 10),
                UserInfoFormList(t.medicacoes, _medications, false),
                UserInfoFormList(t.vacinas, _conditions, false),
                UserInfoFormList(t.doencas, _vaccines, false),
                Center(
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _submit, child: Text(t.cadastrar)),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
