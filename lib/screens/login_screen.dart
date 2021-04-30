import 'package:flutter/material.dart';
import 'package:gerenteloja/blocs/login_bloc.dart';
import 'package:gerenteloja/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();


  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loginBloc.ouState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
          break;

        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Erro"),
                    content: Text("Você não possui os privilegios necessário"),
                  ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
          child: StreamBuilder<LoginState>(
              stream: _loginBloc.ouState,
              initialData: LoginState.LOADING,
              builder: (context, snapshot) {

                switch (snapshot.data) {
                  case LoginState.LOADING:
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                      ),
                    );

                  case LoginState.FAIL:
                  case LoginState.SUCCESS:
                  case LoginState.IDLE:
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(),
                        SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  //width: MediaQuery.of(context).size.width,
                                  child: Icon(Icons.store_mall_directory,
                                      color: Colors.pinkAccent,
                                      size:
                                          ((MediaQuery.of(context).size.height *
                                                  0.35) *
                                              (80 / 100)) //160.0,
                                      ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  child: StreamBuilder<String>(
                                      stream: _loginBloc.outEmail,
                                      builder: (context, snapshot) {
                                        return TextField(
                                          onChanged: _loginBloc.changedEmail,
                                          decoration: InputDecoration(
                                              icon: Icon(
                                                Icons.person_outline,
                                                color: Colors.white,
                                              ),
                                              hintText: "Usuário",
                                              hintStyle: TextStyle(
                                                  color: Colors.white),
                                              contentPadding: EdgeInsets.only(
                                                  top: 20.0,
                                                  bottom: 20.0,
                                                  left: 20.0,
                                                  right: 20.0),
                                              errorText: snapshot.hasError
                                                  ? snapshot.error
                                                  : null),
                                          style: TextStyle(color: Colors.white),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  child: StreamBuilder<String>(
                                      stream: _loginBloc.outPassword,
                                      builder: (context, snapshot) {
                                        return TextField(
                                          onChanged: _loginBloc.changedPassword,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              icon: Icon(
                                                Icons.lock_outline,
                                                color: Colors.white,
                                              ),
                                              hintText: "Senha",
                                              hintStyle: TextStyle(
                                                  color: Colors.white),
                                              contentPadding: EdgeInsets.only(
                                                  top: 20.0,
                                                  bottom: 20.0,
                                                  left: 20.0,
                                                  right: 20.0),
                                              errorText: snapshot.hasError
                                                  ? snapshot.error
                                                  : null),
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  child: ButtonTheme(
                                    //minWidth: MediaQuery.of(context).size.width,
                                    height: 50.00,
                                    child: StreamBuilder<bool>(
                                        stream: _loginBloc.outSubmitedValid,
                                        builder: (context, snapshot) {
                                          return RaisedButton(
                                            onPressed: snapshot.hasData
                                                ? _loginBloc.submit
                                                : null,
                                            color: Colors.pinkAccent,
                                            textColor: Colors.white,
                                            child: Text(
                                              "Entrar",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                            disabledColor: Colors.pinkAccent
                                                .withAlpha(140),
                                          );
                                        }),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    );
                }
              }

              )),
    );
  }

  onChanged() {}
}
