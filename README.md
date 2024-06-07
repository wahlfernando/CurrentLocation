# Current Location

Aplicativo para Flutter que carrega a localização atual do usuário no mapa com e sem o recurso de localização do dispositivo.

O aplicativo tem o recurso GPS do dispositivo e carregar a localização com um alfinete exibido no mapa. 
Porém, caso o GPS não esteja disponível, o app solicita a API IP para recuperar a localização aproximada e carregar o pin neste local do mapa.

## Tecnologias Utilizadas

- Flutter 3.19.6
- Dart 3.3.4
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
