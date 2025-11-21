# Инструкция по сборке APK файла

## Предварительные требования
- Установленный Flutter SDK
- Android Studio с Android SDK
- Подключенное Android устройство или эмулятор

## Шаги сборки

### 1. Подготовка проекта
```bash
# Перейдите в папку проекта
cd calculator-app-zaitsev

# Установите зависимости
flutter pub get

# Проверьте подключение устройства
flutter devices
2. Сборка APK
bash
# Сборка в режиме release
flutter build apk --release
3. Нахождение собранного APK
После успешной сборки APK файл будет находиться по пути:

text
build/app/outputs/flutter-apk/app-release.apk
4. Установка на устройство
bash
# Установка на подключенное устройство
flutter install
Альтернативные команды сборки
Сборка с уменьшенным размером
bash
flutter build apk --release --split-per-abi
Сборка для bundle (Google Play)
bash
flutter build appbundle --release
Проверка подписи APK
bash
# Проверить подпись APK
keytool -printcert -jarfile app-release.apk
Возможные проблемы и решения
Проблема: "Keystore not found"
Решение: Создать keystore для подписи

bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
Проблема: "Minimum supported Gradle version"
Решение: Обновить Gradle в android/build.gradle
Готовый APK
Готовый файл calculator.apk прилагается к проекту в папке build/

- **Commit message:** `Добавлена инструкция по сборке APK`
- **Commit new file**

