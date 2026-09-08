import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class Items {
  final String text;
  bool isCompleted;

  Items({
    required this.text,
    this.isCompleted = false,
  });

  // Un constructor factory puede devolver una instancia de la clase sin
  // crearla directamente con la sintaxis habitual del constructor.
  // En este caso, convierte los datos JSON recibidos en un objeto 'Items'.
  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      text: json['text'],
      isCompleted: json['isCompleted'],
    );
  }

  // Novedad: Método para convertir nuestro objeto 'Items' a JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isCompleted': isCompleted,
    };
  }
}

class _ToDoAppState extends State<ToDoApp> {
  
  final List<Items> _toDoList = [];

  final TextEditingController _controller = TextEditingController();

  // Future<void> representa una operación que termina más adelante y no
  // devuelve ningún valor. 'async' permite usar 'await' dentro del método.
  Future<void> _guardarTareas() async {
    // 'await' espera a que SharedPreferences esté disponible antes de seguir.
    final preferencias = await SharedPreferences.getInstance();
    
    // Transformamos nuestra lista de 'Items' a una lista de 'String' (textos) en formato JSON
    List<String> tareasAString = _toDoList.map((item) => jsonEncode(item.toJson())).toList();
    
    // Ahora sí podemos guardarlo en SharedPreferences
    await preferencias.setStringList("mis_tareas", tareasAString); 
  }

  // Este Future también espera operaciones de almacenamiento y luego carga
  // las tareas guardadas para actualizar la interfaz con setState.
  Future<void> _cargarTareas() async {
    // La ejecución se pausa aquí hasta obtener las preferencias guardadas.
    final preferencias = await SharedPreferences.getInstance();
    final tareasGuardadas = preferencias.getStringList("mis_tareas");

    if (tareasGuardadas != null) {
      setState(() {
        _toDoList.clear();
        
        // Transformamos la lista de 'String' (JSON) de vuelta a nuestra lista de objetos 'Items'
        _toDoList.addAll(
          tareasGuardadas.map((item) => Items.fromJson(jsonDecode(item))).toList()
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Inicia la carga asíncrona sin bloquear la construcción de la pantalla.
    _cargarTareas();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: Text("To Do List"),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Introduce una tarea"),
                content: CustomTextField(
                  textLabel: "Tarea",
                  controller: _controller,
                  ),
                actions: [

                  TextButton(
                    onPressed: () {
                      setState(() {
                        _toDoList.add(Items(text:_controller.text));
                        _guardarTareas();
                        _controller.clear();
                        Navigator.pop(context);
                      });
                    }, 
                    child: Text("Agregar")
                  ),

                  TextButton(
                    onPressed: () {
                      _controller.clear();
                      Navigator.pop(context);
                    }, 
                    child: Text("Cancelar")
                  ),
                ],
              );
            }
          );
        }, 
        icon: Icons.check,
      ),

      body: ListView.builder(
        itemCount: _toDoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                _toDoList[index].text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  decoration: _toDoList[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
              
              leading: Checkbox(
                value: _toDoList[index].isCompleted, 
                onChanged: (value) {
                  setState(() {
                    _toDoList[index].isCompleted = value!;
                    _guardarTareas();
                  }); 
                },
              ),

              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _toDoList.removeAt(index);
                    _guardarTareas();
                  });
                },

                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            )
          );
        },
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {

  final String textLabel;
  final TextEditingController controller;
  
  const CustomTextField({
    super.key,
    required this.textLabel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
   return TextField(
    controller: controller,
    autofocus: true,
    autocorrect: true,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: textLabel,
      ),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      onPressed: onPressed,
      child: Icon(icon, color: Colors.purpleAccent),
    );
  }
}
