import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as path;
import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simpeg/data/admin_data.dart';
import 'package:steganograph/steganograph.dart';

class SteganographEncryptProvider extends ChangeNotifier {
  TextEditingController etEmail = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  AsciiCodec asciiCodec = const AsciiCodec();
  File? fileImage;
  List<String> test = [];
  String newOtpNum = "";
  XFile? platformFile;
  String image = "";
  bool isLoading = false;
  String errorMessage = "";
  Mac? macEncrypt;
  List<int>? nonce;
  File? fileImageUnCloak;
  XFile? platformFileUncloak;
  String imageUncloakMessage = "";
  final algorithm = AesCbc.with128bits(
    macAlgorithm: Hmac.sha256(),
  );

  Future<bool> takePickture() async {
    try {
      XFile? result = await imagePicker.pickImage(source: ImageSource.gallery);
      if (result == null) {
        return false;
      } else {
        platformFile = result;
        fileImage = File(platformFile!.path);
        notifyListeners();
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  bool generateKey() {
    if (etEmail.text.isEmpty) {
      errorMessage = 'Email Harus Diisi';
      return false;
    } else if (fileImage == null) {
      errorMessage = "Harus Memasukkan Gambar";
      return false;
    } else {
      newOtpNum = "";
      var rng = Random();
      for (var i = 0; i < 4; i++) {
        int randomNum = rng.nextInt(10);
        newOtpNum += randomNum.toString();
      }
      return true;
    }
  }

  Future<bool> takePicktureUncloak() async {
    try {
      XFile? result = await imagePicker.pickImage(source: ImageSource.gallery);
      if (result == null) {
        return false;
      } else {
        platformFileUncloak = result;
        fileImageUnCloak = File(platformFileUncloak!.path);
        notifyListeners();
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> hideMessageEmail(String email, String macEmail) async {
    try {
      if (fileImage != null) {
        final directory = await getApplicationDocumentsDirectory();
        // Ambil nama file asli tanpa ekstensi
        String fileNameWithoutExtension =
            path.basenameWithoutExtension(fileImage!.path);
        String time = DateTime.timestamp().toString();

        // Tambahkan ekstensi .png pada nama file
        String newFileName = '${time}_$fileNameWithoutExtension.png';
        String outputFilePath = path.join(directory.path, newFileName);
        final file = await Steganograph.cloak(
          image: File(fileImage!.path),
          message: "${email}9999${macEmail}",
          outputFilePath: '${outputFilePath}',
        );
        final result =
            await GallerySaver.saveImage(file!.path, albumName: 'Media');
        if (result != null || result == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool validate() {
    if (etEmail.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  String caesarEncrypt(String plainText2, String key) {
    String newText = "";
    int keyGenerated = 0;

    for (var i = 0; i < key.length; i++) {
      int angka = int.parse(key[i]) * int.parse(key[i]);
      keyGenerated += angka;
    }
    print(keyGenerated);
    for (var i = 0; i < plainText2.length; i++) {
      var decoded = asciiCodec.encode(plainText2[i]);
      int newNumber = (decoded[0] + keyGenerated) % 128;
      var newString = asciiCodec.decode([newNumber]);
      newText += newString;
    }

    return newText;
  }

  String vigenereEcrypt(String plainText3, String key) {
    String hasilNew = "";
    List<String> keyGenerated = [];
    List<String> plainText = [];

    for (var i = 0; i < plainText3.length; i++) {
      plainText.add(plainText3[i]);
    }

    for (var i = 0; i < key.length; i++) {
      var kunciTemp = asciiCodec.encode(key[i]);
      keyGenerated.add(kunciTemp[0].toString());
    }

    for (var i = 0; i < key.length; i++) {
      int quadratKey = int.parse(key[i]) * int.parse(key[i]);
      var kunciTemp = asciiCodec.encode(quadratKey.toString());
      keyGenerated.add(kunciTemp[0].toString());
    }
    if (keyGenerated.length <= plainText.length) {
      int index = 0;
      while (keyGenerated.length <= plainText.length) {
        if (index >= plainText.length - 1) {
          index = 0;
        }
        keyGenerated.add(asciiCodec.encode(plainText[index])[0].toString());

        index += 1;
      }
    }

    for (var i = 0; i < plainText.length; i++) {
      var newNumber = asciiCodec.encode(plainText[i])[0];
      var numberIncrease = (newNumber + int.parse(keyGenerated[i])) % 128;
      var newString = asciiCodec.decode([numberIncrease]);
      hasilNew += newString;
    }

    print("Key Generate Encrypt : " + keyGenerated.toString());
    print("Plain Text : " + plainText.toString());
    notifyListeners();
    return hasilNew;
  }

  List<int> convertMessagetoInt(String plaintext) {
    String message = plaintext;
    List<int> listMessage = message.runes.toList();
    return listMessage;
  }

  String intToString(List<int> byte) {
    List<int> message = byte;
    String newMessage = String.fromCharCodes(message);
    return newMessage;
  }

  List<int> generatedKeyAes(String key) {
    List<int> keyAes = [];
    List<int> reverseKey = [];
    int sumKey = 0;
    for (var i = 0; i < key.length; i++) {
      keyAes.add(int.parse(key[i]));
      sumKey += keyAes[i];
    }

    int byte5 = keyAes[0] + keyAes[keyAes.length - 1];

    int byte6 = keyAes[1] + keyAes[2];

    int byte7 = sumKey - byte5;

    int byte8 = sumKey - byte6;
    keyAes.addAll([byte5, byte6, byte7, byte8]);

    for (var i = 0; i < key.length; i++) {
      int keyTempNum = int.parse(key[i]) * int.parse(key[i]);
      keyAes.add(keyTempNum);
    }

    for (var i = 0; i < key.length; i++) {
      reverseKey.add(int.parse(key[i]) * int.parse(key[i]));
    }

    final reversed = reverseKey.reversed;
    for (var element in reversed) {
      keyAes.add(element);
    }
    return keyAes;
  }

  Future<String> enkripsiAes(
      String plainText, String keyAes, AesCbc algorithm) async {
    List<int> message = convertMessagetoInt(plainText);
    List<int> key = generatedKeyAes(keyAes);

    String realMessage = "";

    SecretKey secret = SecretKey(key);
    List<int> nonces = key.reversed.toList();

    SecretBox secretBox =
        await algorithm.encrypt(message, secretKey: secret, nonce: nonces);

    nonce = secretBox.nonce;

    macEncrypt = secretBox.mac;

    realMessage = base64Encode(secretBox.cipherText);
    print("ini : " + realMessage);
    return realMessage;
  }

  String streamCipher(String plainText, String key) {
    List<String> cipherText = binaryConvert(plainText);
    List<String> keyLFSr = generateKeyLfsr(cipherText, key);

    List<String> newCipher = [];

    for (var i = 0; i < cipherText.length; i++) {
      newCipher.add(xorFunction(cipherText[i], keyLFSr[i]));
    }

    List<int> convertedCipher = convertBinerList(newCipher);
    List<int> asciiConvertedCipher =
        convertedCipher.map((value) => value % 128).toList();
    String hasil = String.fromCharCodes(asciiConvertedCipher);

    print("Ini Cipher Stream ${cipherText}");
    print("Ini KeyLFSR Stream ${keyLFSr}");
    print("Ini New Cipher ${newCipher}");
    print("Ini Hasil Konversi ${convertedCipher}");
    print("Hasil Konversi Ascii ${hasil}");
    return hasil;
  }

  List<int> convertBinerList(List<String> cipher) {
    List<List<String>> coversion8BitList = [];
    List<String> temp = [];
    List<int> listDecimal = [];
    for (var i = 0; i < cipher.length; i++) {
      temp.add(cipher[i]);
      if (temp.length == 8) {
        coversion8BitList.add(temp);
        temp = [];
      }
    }
    for (var i = 0; i < coversion8BitList.length; i++) {
      int newNumber = binerToInt(coversion8BitList[i]);
      listDecimal.add(newNumber);
    }
    return listDecimal;
  }

  int binerToInt(List<String> biners) {
    int newInt = 0;
    for (var i = 0; i < biners.length; i++) {
      if (biners[i] == '1') {
        int tempNum = pow(2, (biners.length - 1) - i).toInt();
        newInt += tempNum;
      }
    }
    return newInt;
  }

  List<String> generateKeyLfsr(List<String> cipherText, String seedKey) {
    String seed = seedKey[seedKey.length - 2] + seedKey[seedKey.length - 1];
    List<String> seedBiner8Bit = binaryConvert(seed);
    List<String> keyLfsr = [];
    List<String> bitSeed4 = [];

    for (var i = 0; i < seedBiner8Bit.length; i++) {
      bitSeed4.add(seedBiner8Bit[(seedBiner8Bit.length - 1) - i]);
      if (bitSeed4.length == 4) {
        break;
      }
    }
    List<String> tempSeed = bitSeed4;
    while (keyLfsr.length != cipherText.length) {
      List<String> lfsrTemp = [];
      for (var i = 0; i < tempSeed.length; i++) {
        if (lfsrTemp.isEmpty) {
          String lfsr1 =
              xorFunction(tempSeed[i], tempSeed[tempSeed.length - 1]);
          lfsrTemp.add(lfsr1);
          lfsrTemp.add(tempSeed[i]);
        } else {
          if (lfsrTemp.length == 4) {
            for (var i = 0; i < lfsrTemp.length; i++) {
              keyLfsr.add(lfsrTemp[i]);
            }
            tempSeed = lfsrTemp;
            lfsrTemp = [];
            break;
          } else {
            lfsrTemp.add(tempSeed[i]);
          }
        }
      }
    }
    return keyLfsr;
  }

  String xorFunction(String key1, String key2) {
    if (key1 == '0' && key2 == '0') {
      return '0';
    } else if (key1 == '1' && key2 == '0') {
      return '1';
    } else if (key2 == '1' && key1 == '0') {
      return '1';
    } else {
      return '0';
    }
  }

  List<String> binaryConvert(String plainText) {
    List<int> listDecimal = [];
    List<String> listBinerStream = [];

    for (var i = 0; i < plainText.length; i++) {
      listDecimal.add(asciiCodec.encode(plainText[i])[0]);
    }

    for (var i = 0; i < listDecimal.length; i++) {
      int temp = listDecimal[i];
      List<String> stringTemp = [];
      while (stringTemp.length != 8) {
        if (temp <= 0) {
          stringTemp.add('0');
        } else {
          if (temp % 2 == 0) {
            stringTemp.add('0');
          } else {
            stringTemp.add('1');
          }

          temp = (temp / 2).toInt();
        }
      }
      stringTemp = stringTemp.reversed.toList();
      for (var i = 0; i < stringTemp.length; i++) {
        listBinerStream.add(stringTemp[i]);
      }
    }
    print(listDecimal);
    print(listBinerStream);

    return listBinerStream;
  }

  String transposeCipherEncrpt(String plainText, String key) {
    String cipherMessage = '';
    int trans = key.length;
    List<List<String>> listString = [];
    List<String> temp = [];
    for (var i = 0; i < plainText.length; i++) {
      temp.add(plainText[i]);
      if (temp.length == trans) {
        listString.add(temp);
        temp = [];
      }
    }

    if (temp.isNotEmpty) {
      while (temp.length < trans) {
        temp.add("<");
      }
      listString.add(temp);
      temp = [];
    }

    for (var i = 0; i < trans; i++) {
      for (var j = 0; j < listString.length; j++) {
        cipherMessage += listString[j][i];
      }
    }

    return cipherMessage;
  }

  Future<bool> encryptionProccessEmail() async {
    try {
      resetLoading(true);
      if (generateKey()) {
        String transEncryptEmail =
            transposeCipherEncrpt(etEmail.text, newOtpNum);

        print("Ini Trans Encrypt" + transEncryptEmail);

        String caesarEncryptEmail = caesarEncrypt(transEncryptEmail, newOtpNum);

        print("Ini Caesar Encrypt" + caesarEncryptEmail);

        String vigenereEncryptEmail =
            vigenereEcrypt(caesarEncryptEmail, newOtpNum);

        print("Ini Vigenere Encrypt" + vigenereEncryptEmail);

        String streamEncryptEmail =
            streamCipher(vigenereEncryptEmail, newOtpNum);

        String aesEmailTest =
            await enkripsiAes(streamEncryptEmail, newOtpNum, algorithm);
        String macBytesEmail = base64Encode(macEncrypt!.bytes);

        print("Ini Aes Encrypt" + transEncryptEmail);

        if (await hideMessageEmail(aesEmailTest, macBytesEmail)) {
          String name = etEmail.text.split('@')[0];
          if (await AdminData().sendEmail(
              name,
              etEmail.text,
              "Pengiriman Kunci Gambar",
              "Berikut Merupakan Kunci login dari Gambar ${newOtpNum}")) {
            newOtpNum = '';
            resetLoading(false);
            return true;
          } else {
            newOtpNum = '';
            resetLoading(false);
            return false;
          }
        } else {
          resetLoading(false);
          return false;
        }
      } else {
        resetLoading(false);
        return false;
      }
    } catch (e) {
      errorMessage = e.toString();
      resetLoading(false);
      return false;
    }
  }

  void resetLoading(bool newValue) {
    isLoading = newValue;
    notifyListeners();
  }
}
