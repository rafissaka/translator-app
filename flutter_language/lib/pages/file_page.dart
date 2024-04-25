import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_language/utils/colors.dart';
import 'package:flutter_language/utils/languages.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';
import 'package:flutter/services.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  String? selectedto = "Hindi";
  int initialindex = 0;
  File _imagefile = File('assets/image.png');
  final imagepicker = ImagePicker();
  bool isImageLoded = false;
  bool isrecognize = true;
  bool isTranslate = true;
  var finaltext = "";
  final TextEditingController textEditingController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();
  final translator = GoogleTranslator();

  // ignore: prefer_typing_uninitialized_variables
  var output;
  translate(String text, String lang) async {
    await translator.translate(text, to: lang).then((value) {
      setState(() {
        output = value;

        isTranslate = true;
      });
    });
    await flutterTts.setLanguage(lang);
    await flutterTts.setPitch(1.2);
    await flutterTts.speak(output.toString());
  }

  _imageformgallery() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    var image = await imagepicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _imagefile = File(image.path);
        isImageLoded = true;
      });
    }
  }

  _imageformcamara() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    var image = await imagepicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _imagefile = File(image.path);
        isImageLoded = true;
      });
    }
  }

  textfromImage() async {
    // FirebaseVisionImage selectedimage =
    //     FirebaseVisionImage.fromFile(_imagefile);
    // TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    // VisionText outputtext = await textRecognizer.processImage(selectedimage);
    try {
      final inputimg = InputImage.fromFilePath(_imagefile.path);

      final textdectctor = GoogleMlKit.vision.textRecognizer();
      final RecognizedText outputtext =
          await textdectctor.processImage(inputimg);
      for (TextBlock blocks in outputtext.blocks) {
        for (TextLine line in blocks.lines) {
          for (TextElement word in line.elements) {
            setState(() {
              finaltext = "$finaltext ${word.text}";
            });
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    setState(() {
      isrecognize = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: const Color(0xff003366),
        title: const Text(
          "Image Translator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            // image: DecorationImage(
            //  image: AssetImage("images/background.jpg"),
            //   fit: BoxFit.cover,
            // ),
            ),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height + 100),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  isImageLoded
                      ? Center(
                          child: Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: FileImage(_imagefile),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: ColorsUsed.buttoncolor,
                    ),
                    onPressed: () {
                      setState(() {
                        isrecognize = false;
                      });
                      output = "";
                      finaltext = "";
                      textfromImage();
                    },
                    child: isrecognize
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "recognize",
                              style: TextStyle(
                                  color: ColorsUsed.textcolor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: ColorsUsed.textcolor,
                            ),
                          ),
                  ),
                  finaltext.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              color: ColorsUsed.cardcolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 25,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  finaltext,
                                  style: TextStyle(
                                      color: ColorsUsed.textcolor,
                                      fontSize: 17),
                                ),
                              )),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: ColorsUsed.buttoncolor,
                        ),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: finaltext));
                        },
                        child: const Icon(
                          Icons.copy,
                          color: ColorsUsed.iconcolor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Card(
                      color: ColorsUsed.dropdowncolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      elevation: 25,
                      child: SizedBox(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Convert to",
                              style: TextStyle(
                                  color: ColorsUsed.textcolor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration:
                                  BoxDecoration(color: ColorsUsed.color),
                              // color: Colors.white,
                              width: 150,
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  hoverColor: ColorsUsed.color,
                                  fillColor: ColorsUsed.color,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 5, color: ColorsUsed.color),
                                  ),
                                ),
                                value: selectedto,
                                items: Translation_languages.select_languages
                                    .map((language) => DropdownMenuItem<String>(
                                          value: language,
                                          child: Text(
                                            language,
                                            style: TextStyle(
                                                color: ColorsUsed.textcolor),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (language) =>
                                    setState(() => selectedto = language),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.deepPurpleAccent,
                                ),
                                iconSize: 42,
                                // // underline: SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              backgroundColor: ColorsUsed.buttoncolor,
                            ),
                            onPressed: () {
                              setState(() {
                                isTranslate = false;
                              });
                              output = "";
                              // finaltext = "";
                              translate(
                                  finaltext,
                                  Translation_languages.getLanguageCode(
                                      selectedto!));
                            },
                            child: isTranslate
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Translate",
                                      style: TextStyle(
                                          color: ColorsUsed.textcolor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      color: ColorsUsed.textcolor,
                                    ),
                                  )),
                        output == null
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    color: ColorsUsed.cardcolor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    elevation: 25,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        output == null ? "" : output.toString(),
                                        style: TextStyle(
                                            color: ColorsUsed.textcolor,
                                            fontSize: 17),
                                      ),
                                    )),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: ColorsUsed.iconcolor,
                              ),
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: output.toString()));
                              },
                              child: Icon(
                                Icons.copy,
                                color: ColorsUsed.buttoncolor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 150,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 186,
          ),
          SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            foregroundColor: Colors.white,
            backgroundColor: ColorsUsed.textcolor,
            overlayColor: Colors.black,
            overlayOpacity: 0.7,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.add_a_photo),
                label: "Add Image from Camera",
                onTap: () {
                  output = "";

                  finaltext = "";
                  _imageformcamara();
                },
              ),
              SpeedDialChild(
                child: const Icon(Icons.add_photo_alternate_rounded),
                label: "Add Image from Gallery",
                onTap: () {
                  output = "";

                  finaltext = "";
                  _imageformgallery();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
