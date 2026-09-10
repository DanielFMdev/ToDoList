# ToDo List

Aplicación móvil de lista de tareas desarrollada con Flutter y Dart. Permite organizar pendientes desde una interfaz sencilla y conservar el estado de las tareas entre sesiones mediante almacenamiento local.

## Funcionalidades

- Crear nuevas tareas desde un diálogo de entrada.
- Marcar tareas como completadas o pendientes.
- Mostrar visualmente las tareas completadas con texto tachado.
- Eliminar tareas de la lista.
- Guardar y recuperar automáticamente las tareas con `SharedPreferences`.
- Interfaz basada en Material Design con tema oscuro.

## Tecnologías

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.12.2-0175C2?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/license-private-lightgrey)

- **Flutter** para la interfaz multiplataforma.
- **Dart** como lenguaje de programación.
- **Shared Preferences** para la persistencia local.
- **JSON** para serializar y reconstruir las tareas.

## Requisitos

Antes de ejecutar el proyecto, instala:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Dart SDK incluido en Flutter
- Un dispositivo físico o emulador configurado

Comprueba la instalación con:

```bash
flutter doctor
```

## Instalación y ejecución

Clona el repositorio y entra en su directorio:

```bash
git clone https://github.com/DanielFMdev/ToDoList.git
cd ToDoList
```

Instala las dependencias y ejecuta la aplicación:

```bash
flutter pub get
flutter run
```

Para consultar los dispositivos disponibles:

```bash
flutter devices
```

## Estructura principal

```text
lib/
├── main.dart          # Punto de entrada y configuración de la aplicación
└── to_do_app.dart     # Interfaz, modelo de tarea y persistencia local
test/
└── widget_test.dart   # Pruebas de widgets
```

## Persistencia de datos

Las tareas se convierten a JSON y se almacenan localmente con la clave `mis_tareas`. Los datos permanecen en el dispositivo mientras no se borre el almacenamiento de la aplicación.

## Comandos útiles

```bash
# Ejecutar las pruebas
flutter test

# Analizar el código
flutter analyze

# Crear un APK de lanzamiento
flutter build apk --release
```

## Estado del proyecto

Proyecto educativo en desarrollo, creado como parte del aprendizaje de fundamentos de Flutter. La funcionalidad principal de la lista de tareas está implementada; las pruebas automatizadas específicas de creación, edición de estado, eliminación y persistencia pueden ampliarse en futuras iteraciones.

## Licencia

Este proyecto no está publicado como paquete en `pub.dev`. Añade una licencia al repositorio si planeas distribuirlo públicamente.
