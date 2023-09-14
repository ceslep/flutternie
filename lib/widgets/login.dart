import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Login extends StatefulWidget {
  final VoidCallback onIngresar;
  final TextEditingController usController;
  final TextEditingController passController;
  final bool login;
  const Login(
      {Key? key,
      required this.usController,
      required this.passController,
      required this.onIngresar,
      required this.login})
      : super(key: key);
  // ignore: library_private_types_in_public_api
  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    print({"login": widget.login});
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: CachedNetworkImage(
            imageUrl: "https://app.iedeoccidente.com/esc.png",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(35),
          child: TextField(
            controller: widget.usController,
            decoration: const InputDecoration(
              labelText: "Usuario",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(35),
          child: TextField(
            controller: widget.passController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Contraseña",
            ),
          ),
        ),
        botones(widget.onIngresar, widget.login)
      ],
    );
  }
}

Widget botones(VoidCallback onIngresar, bool login) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    // Botón Registrarse
    ElevatedButton(
      onPressed: () {
        // Haz algo cuando el botón Registrarse se presione.
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.amberAccent),
        foregroundColor: MaterialStateProperty.all(Colors.black),
      ),
      child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text("Registrar"), Icon(Icons.person_add)]),
    ),
    const SizedBox(width: 20),
    // Botón Cancelar
    ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
        foregroundColor: MaterialStateProperty.all(Colors.black),
      ),
      onPressed: onIngresar,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Text("Ingresar"),
        const Icon(Icons.login),
        login
            ? const SpinKitCircle(
                color: Colors.blue, // Color de la animación
                size: 20.0, // Tamaño del widget
              )
            : const Text(''),
      ]),
    ),
  ]);
}