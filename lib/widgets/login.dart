// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:com_celesoft_notasieo/widgets/lista_estudiantes.dart';

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
  late final bool llogin;
  late String currentYear;
  @override
  void initState() {
    super.initState();
    currentYear = DateTime.now().year.toString();
    llogin = widget.login;
    print({'login': llogin});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: !widget.login
              ? GestureDetector(
                  onLongPressEnd: (details) async {
                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListaEstudiantes()));
                    if (result != null) {
                      print(
                          "Datos recibidos de la pantalla B: ${result.estudiante}");
                      widget.usController.text = result.estudiante;
                      widget.passController.text = result.estudiante;
                      widget.onIngresar();
                    }
                  },
                  child: CachedNetworkImage(
                    imageUrl: "https://app.iedeoccidente.com/escudoNuevo2.png",
                  ),
                )
              : const SpinKitCircle(
                  color: Colors.blue, // Color de la animación
                  size: 50.0, // Tamaño del widget
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(35),
          child: TextField(
            onChanged: (value) {
              print({'oc': value});
            },
            keyboardType: TextInputType.number, // Tipo de teclado numérico
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // Permite solo números
            ],
            controller: widget.usController,
            decoration: const InputDecoration(
              labelText: "Usuario",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(35),
          child: TextField(
            keyboardType: TextInputType.number, // Tipo de teclado numérico
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // Permite solo números
            ],
            controller: widget.passController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Contraseña",
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 20),
          child: DropdownButton<String>(
            // Valor inicial seleccionado
            value: currentYear,
            // Función que se ejecuta cuando se selecciona un elemento
            onChanged: (newValue) {
              // Aquí puedes manejar la lógica cuando se selecciona un elemento
              print('Seleccionado: $newValue');
              currentYear = newValue!;
              setState(() {});
              //
            },
            // Lista de elementos desplegables
            items: ['2021', '2022', '2023', '2024']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
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
