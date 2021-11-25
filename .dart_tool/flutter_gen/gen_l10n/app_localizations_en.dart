


import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Medical File';

  @override
  String get welcomeText => 'Welcome to the Medical File';

  @override
  String get busquePorCPF => 'Search By CPF';

  @override
  String get buscar => 'Search';

  @override
  String get preenchaCampoCPF => 'Input CPF in this field.';

  @override
  String get entreNaConta => 'Login into your account';

  @override
  String get invalidoCPF => 'invalid CPF!';

  @override
  String get senha => 'Password';

  @override
  String get senhaObrigatoria => 'Password Required.';

  @override
  String get senhaMaisQue6 => 'Password must be longer than 6 characters.';

  @override
  String get entrar => 'Login';

  @override
  String get naoCadastrado => 'Not Registered? Sign-up here!';

  @override
  String get esteCampoObrigatorio => 'Required Field';

  @override
  String get digiteAs => 'Type the ';

  @override
  String get queEstiverUsando => ' that you are using and press the ';

  @override
  String get paraAdiconarLista => ' to add it to the list.';

  @override
  String get escolhaFoto => 'Choose a Photo';

  @override
  String get nomeCompleto => 'Full Name';

  @override
  String get nome => 'Name';

  @override
  String get email => 'E-mail';

  @override
  String get dataNascimento => 'Date of Birth';

  @override
  String get confirmarSenha => 'Confirm Password';

  @override
  String get senhaEConfirmaNaoIgual => 'Passwords do not match';

  @override
  String get medicacoes => 'Medication';

  @override
  String get vacinas => 'Vaccines';

  @override
  String get doencas => 'Diseases';

  @override
  String get cadastrar => 'Register';

  @override
  String get camera => 'Camera';

  @override
  String get galeria => 'Gallery';

  @override
  String get editar => 'Edit';

  @override
  String get sairConta => 'Logout';

  @override
  String get salvar => 'Salve';

  @override
  String get voltar => 'Return';

  @override
  String get nenhumUsuarioCPF => 'No user with this CPF ';

  @override
  String get erroBuscaUsuario => 'An Error occurred while looking for the user';
}
