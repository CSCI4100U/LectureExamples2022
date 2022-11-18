import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'i18n Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'i18n Home Page'),
      localizationsDelegates: [
        FlutterI18nDelegate(
          missingTranslationHandler: (key,locale){
            print("MISSING KEY: $key, Language Code: ${locale!.languageCode}");
          },
        translationLoader: FileTranslationLoader(
          useCountryCode: false,
          fallbackFile: 'en',
          basePath: 'assets/i18n/'
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('fr', ''),
        Locale('es', ''),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

String? _username;
String? _password;
bool? _validLogin;
int _num_of_attempts = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          TextButton(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () async {
                Locale newLocale = Locale('en');
                await FlutterI18n.refresh(context, newLocale);
                setState(() {

                });
              },
              child: Text("EN"),
          ),

          TextButton(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () async {
              Locale newLocale = Locale('fr');
              await FlutterI18n.refresh(context, newLocale);
              setState(() {

              });
            },
            child: Text("FR"),
          ),

          TextButton(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () async {
              Locale newLocale = Locale('es');
              await FlutterI18n.refresh(context, newLocale);
              setState(() {

              });
            },
            child: Text("ES"),
          ),

        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              _validLogin == null ? ''
                  : _validLogin! ? "login.success" : "login.failure"
            ),
          ),
          ListTile(
            title: Text(_num_of_attempts.toString()),
          ),
          ListTile(
            leading: Text("login.username"),
            title: TextField(
              controller: TextEditingController(text: _username),
              onChanged: (newValue){
                _username = newValue;
              },
            ),
          ),
          ListTile(
            leading: Text("login.password"),
            title: TextField(
              controller: TextEditingController(text: _username),
              onChanged: (newValue){
                _password = newValue;
              },
            ),
          ),
          ListTile(
            title: TextButton(
              child: Text("login.login"),
              onPressed: (){
                if (_username == 'admin' && _password == '12345'){
                  setState(() {
                    _validLogin = true;
                  });
                } else{
                  setState(() {
                    _validLogin = false;
                    _num_of_attempts++;
                  });
                }
              },
            ),
          ),
        ],
      )
    );
  }
}
