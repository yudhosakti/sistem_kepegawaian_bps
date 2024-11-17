import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:steganograph/steganograph.dart';

class SteganographDecryptProvider extends ChangeNotifier {
  TextEditingController etKeyDecypt = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  AsciiCodec asciiCodec = AsciiCodec();
  File? fileImage;
  List<String> test = [];
  String newOtpNum = "";
  XFile? platformFile;
  Mac? macEncrypt;
  bool isLoading = false;
  List<int>? nonce;
  File? fileImageUnCloak;
  XFile? platformFileUncloak;
  String emailLogin = '';
  String imageUncloakMessage = "";
  final algorithm = AesCbc.with128bits(
    macAlgorithm: Hmac.sha256(),
  );

  void resetLoading(bool newValue) {
    isLoading = newValue;
    notifyListeners();
  }

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

  Future<bool> unCloakMessageNew() async {
    try {
      resetLoading(true);
      if (validateDecrypt()) {
        emailLogin = '';
        if (fileImage != null) {
          final file = await Steganograph.uncloak(File(fileImage!.path));
          if (file != null) {
            imageUncloakMessage = file;
            print(imageUncloakMessage);
            print(test);
            test = imageUncloakMessage.split('9999');
            print(test);
            List<int> macEmail = base64Decode(test[1]);
            print(macEmail);
            String emailAesDecrypt = await dekripsiAes(
                test[0],
                generatedKeyAes(etKeyDecypt.text).reversed.toList(),
                Mac(macEmail),
                etKeyDecypt.text);
            String emailStreamDecrypt =
                streamCipher(emailAesDecrypt, etKeyDecypt.text);
            String emailDecrypt1 = vigenereDecrypt(emailStreamDecrypt);
            print("Ini Email Vigenere" + emailDecrypt1);
            String emailCaesar = caesarDecrypt(emailDecrypt1, etKeyDecypt.text);
            print("Ini Email Caesar" + emailCaesar);
            String emailTranspose = transposeCipherDecrypt(emailCaesar);
            print("Ini Email Transpose" + emailTranspose);

            imageUncloakMessage = "Email : ${emailTranspose}";
            emailLogin = emailTranspose;

            print(emailLogin);
            resetLoading(false);
            return true;
          } else {
            imageUncloakMessage = 'Failed';
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
      resetLoading(false);
      print(e);
      return false;
    }
  }

  bool validateDecrypt() {
    if (etKeyDecypt.text.length < 4) {
      return false;
    } else {
      return true;
    }
  }

  String caesarDecrypt(String plainText, String key) {
    String newText = "";
    if (validateDecrypt()) {
      int keyGenerated = 0;

      for (var i = 0; i < key.length; i++) {
        int angka = int.parse(key[i]) * int.parse(key[i]);
        keyGenerated += angka;
      }
      print(keyGenerated);
      for (var i = 0; i < plainText.length; i++) {
        var decoded = asciiCodec.encode(plainText[i]);
        int newNumber = (decoded[0] - keyGenerated);
        if (newNumber < 0) {
          newNumber = (newNumber + 128) % 128;
        } else {
          newNumber = newNumber % 128;
        }
        var newString = asciiCodec.decode([newNumber]);
        newText += newString;
      }
      return newText;
    } else {
      return newText;
    }
  }

  String vigenereDecrypt(String plainText3) {
    String hasilNew = "";

    if (validateDecrypt()) {
      List<String> keyGenerated = [];
      List<String> plainText = [];

      for (var i = 0; i < plainText3.length; i++) {
        plainText.add(plainText3[i]);
      }

      print("Ini Plain Text ${plainText}");

      for (var i = 0; i < etKeyDecypt.text.length; i++) {
        var kunciTemp = asciiCodec.encode(etKeyDecypt.text[i]);
        keyGenerated.add(kunciTemp[0].toString());
      }
      print("Key Generzated : ${keyGenerated}");

      for (var i = 0; i < etKeyDecypt.text.length; i++) {
        int quadratKey =
            int.parse(etKeyDecypt.text[i]) * int.parse(etKeyDecypt.text[i]);
        var kunciTemp = asciiCodec.encode(quadratKey.toString());
        keyGenerated.add(kunciTemp[0].toString());
      }

      if (keyGenerated.length <= plainText.length) {
        int index = 0;
        while (keyGenerated.length <= plainText.length) {
          if (index >= plainText.length - 1) {
            index = 0;
          }
          int decrypt = (asciiCodec.encode(plainText[index])[0] -
              int.parse(keyGenerated[index]));
          if (decrypt < 0) {
            decrypt += 128;
            decrypt = decrypt % 128;
          } else {
            decrypt = decrypt % 128;
          }
          keyGenerated.add(decrypt.toString());

          index += 1;
        }
      }
      print(keyGenerated);

      for (var i = 0; i < plainText.length; i++) {
        var newNumber = asciiCodec.encode(plainText[i])[0];
        var numberIncrease = (newNumber - int.parse(keyGenerated[i]));
        if (numberIncrease < 0) {
          numberIncrease += 128;
          numberIncrease = numberIncrease % 128;
        } else {
          numberIncrease = numberIncrease % 128;
        }
        var newString = asciiCodec.decode([numberIncrease]);
        hasilNew += newString;
      }

      print("Key Generate Decrypt : " + keyGenerated.toString());
      print("Plain Text : " + plainText.toString());
      return hasilNew;
    } else {
      return hasilNew;
    }
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

  Future<String> dekripsiAes(
      String plainText, List<int> nonces, Mac macs, String keyAes) async {
    List<int> key = generatedKeyAes(keyAes);

    List<int> message = base64Decode(plainText);

    String realMessage = "";

    SecretKey secretKey = SecretKey(key);

    SecretBox secretBoxyest = SecretBox(message, nonce: nonces, mac: macs);

    final clearText = await algorithm.decrypt(
      secretBoxyest,
      secretKey: secretKey,
    );

    print(clearText);

    realMessage = asciiCodec.decode(clearText);

    print(realMessage);

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

  String transposeCipherDecrypt(String plainText) {
    List<List<String>> listString = [];
    List<String> temp = [];
    String cipherText = "";
    int trans = etKeyDecypt.text.length;

    int dividedBy = (plainText.length / trans).ceil();

    for (var i = 0; i < plainText.length; i++) {
      temp.add(plainText[i]);
      if (temp.length == dividedBy) {
        listString.add(temp);
        temp = [];
      }
    }

    if (temp.isNotEmpty) {
      while (temp.length != dividedBy) {
        temp.add("<");
      }
      listString.add(temp);
    }

    print(listString);

    for (var i = 0; i < dividedBy; i++) {
      for (var j = 0; j < listString.length; j++) {
        cipherText += listString[j][i];
      }
    }

    String hasil = '';
    for (var i = 0; i < cipherText.length; i++) {
      if (cipherText[i] != '<') {
        hasil += cipherText[i];
      }
    }

    return hasil;
  }
}
