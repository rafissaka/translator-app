import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_language/utils/colors.dart';
import 'package:flutter_language/utils/languages.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:translator/translator.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key});

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  String? selectedto = "Hindi";
  bool isTranslate = true;
  var finaltext = "";
  final stt.SpeechToText _speachtotext = stt.SpeechToText();

  bool isListening = false;
  String speechToText = "Press the button and start speaking";
  // TextEditingController textController = TextEditingController();
  int initialindex = 2;
  final translator = GoogleTranslator();
  final FlutterTts flutterTts = FlutterTts();
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
    await flutterTts.setPitch(0.7);
    await flutterTts.speak(output.toString());
  }

  listen() async {
    if (isListening == false) {
      bool available = await _speachtotext.initialize(
          onStatus: (v) => {}, onError: (v) => {});
      if (available) {
        setState(() {
          isListening = true;
        });
        _speachtotext.listen(onResult: (value) {
          speechToText = value.recognizedWords;
        });
      }
    } else {
      setState(() {
        isListening = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: const Color(0xff003366),
        title: const Text(
          "Voice Translator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("images/background.jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple, width: 3),
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    speechToText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                        Clipboard.setData(ClipboardData(text: speechToText));
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
                            decoration: BoxDecoration(color: ColorsUsed.color),
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
                            setState(() {
                              finaltext = speechToText;
                            });
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
                      const SizedBox(
                        height: 50,
                      ),
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
                        height: 50,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        glowColor: ColorsUsed.iconcolor,
        // endRadius: 75,
        duration: const Duration(milliseconds: 2000),
        // repeatPauseDuration: Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
            backgroundColor: ColorsUsed.buttoncolor,
            onPressed: () {
              listen();
            },
            child: isListening
                ? const Icon(
                    Icons.mic,
                    color: ColorsUsed.iconcolor,
                  )
                : const Icon(Icons.mic_none, color: ColorsUsed.iconcolor)),
      ),
    );
  }
}
