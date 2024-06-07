# Current Location

Build an app for Flutter to load the current location of the user in the map with and without the device's location feature.

The app needs to use the device's GPS feature and load the location with a pin displayed in the map. However, if the GPS is unavailable, the app must request the IP API in order to retrieve the approximate location and load the pin at this location of the map.

## Tecnologias Utilizadas

- Flutter
- Dart
- Google Maps API
- Geolocator Package
- HTTP Package

## Instalação

1. Clone este repositório.
2. Navegue até o diretório do projeto.
3. Execute `flutter pub get` para instalar as dependências.

## Como Usar

1. Obtenha uma chave de API da IP-API (ou da Google Maps, se aplicável).
2. Substitua por uma chave valida da api-key no arquivo `location_controller.dart` com sua chave de API.
3. Execute o aplicativo em um emulador ou dispositivo Android/iOS.
