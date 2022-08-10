import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/screens/register.dart';

import '../database/UserDbProvider.dart';
import '../database/dao/userDao.dart';
import '../models/phoneNumberFormater.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserDbProvider userDb = UserDbProvider();
  List listLoginInformations = [];

  //AlertDialog
  IconData icon = Icons.error_outline;
  String title = 'Erro desconhecido';
  String content = '';
  String bText = 'Sair';

  final phone = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getLoginInformations();
    return Scaffold(
      body:
        Stack(
            children: [
          Container(
            height: 250,
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.center,
            child: Image.asset("assets/images/mylog.png", scale: 3),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(40, 16, 40, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 4,
                    blurRadius: 25,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              32), //                 <--- border radius here
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Row(children: [
                        Expanded(
                          child: TextField(
                            keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              PhoneNumberFormatter(),
                              LengthLimitingTextInputFormatter(15),
                            ],
                            controller: phone,
                            decoration: InputDecoration(
                              icon: Icon(Icons.phone),
                              hintText: "Telefone",
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            //obscureText: true,
                          ),
                        )
                      ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              32), //                 <--- border radius here
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Row(children: [
                        Expanded(
                          child: TextField(
                            controller: password,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.key),
                              hintText: "Senha",
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            obscureText: true,
                          ),
                        )
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 24),
                    child: TextButton(
                         onPressed: () {  },
                      child: Container(
                        alignment: Alignment.topRight,
                        child: const Text('Esqueceu a senha?',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 12,
                        ),),
                      ), ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              32), //                 <--- border radius here
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          verifyLoginInformation();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.primary),
                        ),
                        child: const Text('LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 48, 0, 0),
                    child:
                    Container(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register(),
                          ));
                        }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Não tem uma conta? ",
                              style: TextStyle(
                              color: Colors.grey,
                                fontSize: 12,
                            ),),
                            Text('Registre-se',
                            style: TextStyle(
                              fontSize: 12,
                            ),),
                          ],
                        ), ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),

    );
  }

  void alertaDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            } else {
                              SystemNavigator.pop();
                            }
                          },
                          child: Text(bText.toString())),
                    ],
                  ),
                ],
              ),
            )
          ],
          //title: Text('aaaaaaaa'),
          //contentPadding: EdgeInsets.all(20),
          //content: Text('bbbbbbbbbbbbbbb'),
        ));
  }

  verifyLoginInformation() {
    if( listLoginInformations.contains(phone.text + password.text) ){
       icon = (Icons.add_reaction_outlined);
       title = 'Bem vindo!';
       content = 'Login realizado com sucesso!';
       bText = '';
       alertaDialog();
    } else if(phone.text.isEmpty || password.text.isEmpty) {
      icon = (Icons.error_outline);
      title = 'Atenção!';
      content = 'Prencha todos os campos para continuar';
      alertaDialog();
    } else if(phone.text.length < 15) {
      icon = (Icons.error_outline);
      title = 'Atenção!';
      content = 'Número de telefone invalido';
      alertaDialog();
    } else {
      icon = (Icons.error_outline);
      title = 'Atenção!';
      content = 'Login ou senha inválido';
      alertaDialog();
    }
    // setState(() {
    //   getLoginInformations();
    // });
  }

  Future<void> getLoginInformations() async {
    listLoginInformations.clear();
    itemCount: listLoginInformations.length;

    var u = await UserDao().GetUsers();
    for (int i = 0; i < u.length; i++) {
      listLoginInformations.add(u[i].phone + u[i].password);
    }
  }



}
