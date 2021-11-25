
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'Carteira Médica'**
  String get appTitle;

  /// No description provided for @welcomeText.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo a carteira Médica'**
  String get welcomeText;

  /// No description provided for @busquePorCPF.
  ///
  /// In pt, this message translates to:
  /// **'Search By CPF'**
  String get busquePorCPF;

  /// No description provided for @buscar.
  ///
  /// In pt, this message translates to:
  /// **'Buscar'**
  String get buscar;

  /// No description provided for @preenchaCampoCPF.
  ///
  /// In pt, this message translates to:
  /// **'Preencha o campo com o CPF.'**
  String get preenchaCampoCPF;

  /// No description provided for @entreNaConta.
  ///
  /// In pt, this message translates to:
  /// **'Entre na sua conta'**
  String get entreNaConta;

  /// No description provided for @invalidoCPF.
  ///
  /// In pt, this message translates to:
  /// **'CPF inválido!'**
  String get invalidoCPF;

  /// No description provided for @senha.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get senha;

  /// No description provided for @senhaObrigatoria.
  ///
  /// In pt, this message translates to:
  /// **'Senha Obrigatória.'**
  String get senhaObrigatoria;

  /// No description provided for @senhaMaisQue6.
  ///
  /// In pt, this message translates to:
  /// **'Senha deve ser maior que 6 caracteres.'**
  String get senhaMaisQue6;

  /// No description provided for @entrar.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get entrar;

  /// No description provided for @naoCadastrado.
  ///
  /// In pt, this message translates to:
  /// **'Não é cadastrado? Regitre-se aqui!'**
  String get naoCadastrado;

  /// No description provided for @esteCampoObrigatorio.
  ///
  /// In pt, this message translates to:
  /// **'Este campo é obrigatório.'**
  String get esteCampoObrigatorio;

  /// No description provided for @digiteAs.
  ///
  /// In pt, this message translates to:
  /// **'Digite as '**
  String get digiteAs;

  /// No description provided for @queEstiverUsando.
  ///
  /// In pt, this message translates to:
  /// **' que você estiver tomando e clique no '**
  String get queEstiverUsando;

  /// No description provided for @paraAdiconarLista.
  ///
  /// In pt, this message translates to:
  /// **' para adiciona-lo a lista.'**
  String get paraAdiconarLista;

  /// No description provided for @escolhaFoto.
  ///
  /// In pt, this message translates to:
  /// **'Escolha a Foto'**
  String get escolhaFoto;

  /// No description provided for @nomeCompleto.
  ///
  /// In pt, this message translates to:
  /// **'Nome Completo'**
  String get nomeCompleto;

  /// No description provided for @nome.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get nome;

  /// No description provided for @email.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @dataNascimento.
  ///
  /// In pt, this message translates to:
  /// **'Data de Nascimento'**
  String get dataNascimento;

  /// No description provided for @confirmarSenha.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Senha'**
  String get confirmarSenha;

  /// No description provided for @senhaEConfirmaNaoIgual.
  ///
  /// In pt, this message translates to:
  /// **'A senha e a confirmação não são iguais.'**
  String get senhaEConfirmaNaoIgual;

  /// No description provided for @medicacoes.
  ///
  /// In pt, this message translates to:
  /// **'Medicações'**
  String get medicacoes;

  /// No description provided for @vacinas.
  ///
  /// In pt, this message translates to:
  /// **'Vacinas'**
  String get vacinas;

  /// No description provided for @doencas.
  ///
  /// In pt, this message translates to:
  /// **'Doenças'**
  String get doencas;

  /// No description provided for @cadastrar.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar'**
  String get cadastrar;

  /// No description provided for @camera.
  ///
  /// In pt, this message translates to:
  /// **'Câmera'**
  String get camera;

  /// No description provided for @galeria.
  ///
  /// In pt, this message translates to:
  /// **'Galeria'**
  String get galeria;

  /// No description provided for @editar.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get editar;

  /// No description provided for @sairConta.
  ///
  /// In pt, this message translates to:
  /// **'Sair da Conta'**
  String get sairConta;

  /// No description provided for @salvar.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get salvar;

  /// No description provided for @voltar.
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get voltar;

  /// No description provided for @nenhumUsuarioCPF.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum usuário com o CPF '**
  String get nenhumUsuarioCPF;

  /// No description provided for @erroBuscaUsuario.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao buscar o usuário'**
  String get erroBuscaUsuario;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
