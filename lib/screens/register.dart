import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/database/UserDbProvider.dart';
import 'package:login/database/dao/userDao.dart';
import 'package:login/models/user.dart';
import 'package:login/models/phoneNumberFormater.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  UserDbProvider userDb = UserDbProvider();
  List listPhone = [];

  //AlertDialog
  IconData icon = Icons.error_outline;
  String title = 'Erro desconhecido';
  String content = '';

  var uuid = Uuid();
  final String id = '';
  final name = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getPhones();

    return Scaffold(
      body: Stack(children: [
        Container(
          height: 250,
          color: Theme.of(context).colorScheme.primary,
          alignment: Alignment.center,
          child: Image.asset("assets/images/mylog.png", scale: 3),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
          child: Container(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(48), topRight: Radius.circular(48)),
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
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          controller: name,
                          decoration: InputDecoration(
                            icon: Icon(Icons.account_box_rounded),
                            hintText: "Nome Completo",
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      )
                    ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
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
                        ),
                      )
                    ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(8),
                          ],
                          controller: password,
                          decoration: InputDecoration(
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
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(8),
                          ],
                          controller: confirmPassword,
                          decoration: InputDecoration(
                            icon: Icon(Icons.key),
                            hintText: "Confirmar senha",
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
                  padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
                  child: Container(
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
                    child: ElevatedButton(
                      onPressed: () {
                        addUser();
                      },
                      child: Text('REGISTRAR',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 48, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        SystemNavigator.pop();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Já possui uma conta? ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
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
                                  Navigator.pop(context);
                                } else {
                                  SystemNavigator.pop();
                                  SystemNavigator.pop();
                                }
                              },
                              child: Text('Login')),
                          TextButton(
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                } else {
                                  SystemNavigator.pop();
                                }
                              },
                              child: Text('Sair')),
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

  Future<void> addUser() async {
    if (name.text.isEmpty || phone.text.isEmpty || password.text.isEmpty) {
      icon = (Icons.error_outline);
      title = 'Atenção!';
      content = 'Preencha todos os campos para continuar.';
      alertaDialog();
    } else if (phone.text.length < 15) {
      icon = (Icons.error_outline);
      title = 'Atenção!';
      content = 'Informe um número de telefone válido para continuar.';
      alertaDialog();
    } else if (password.text.length < 8) {
      icon = (Icons.error_outline);
      title = 'Atenção!';
      content = 'A senha precisar conter no mínimo 8 caracteres.';
      alertaDialog();
    } else if (password.text != confirmPassword.text) {
      icon = (Icons.error_outline);
      title = 'Atenção!';
      content = 'As senhas não correspodem.';
      alertaDialog();
    } else {
      if (listPhone.contains(phone.text)) {
        icon = (Icons.error_outline);
        title = 'Atenção!';
        content = 'Número de telefone já cadastrado.';
        alertaDialog();
      } else {
        final now = DateTime.now();
        UserDao().CreateUser(User(
            id: int.parse(now.microsecondsSinceEpoch.toString()),
            name: name.text,
            phone: phone.text,
            password: password.text));
        icon = (Icons.add_reaction_outlined);
        title = 'Nova conta criada';
        String namee = name.text;
        content = 'Bem vindo! \n $namee';
        alertaDialog();
        setState(() {
          getPhones();
        });
      }
    }
  }

  Future<void> getPhones() async {
    listPhone.clear();
    var u = await UserDao().GetUsers();
    for (int i = 0; i <= u.length; i++) {
      listPhone.add(u[i].phone);
    }
  }
}
