import 'dart:ui';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_language/controller.dart/sharedpreference_controller.dart';
import 'package:flutter_language/utils/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final FavoriteTranslationsController _favoriteTranslationsController =
      Get.find();
  void storeFavoriteTranslation(String key, String value) {
    _favoriteTranslationsController.addFavorite(key, value);
  }

  late AnimationController _animationController;
  late Animation<double> _animation;
  String selectedLanguage = 'English';
  String selectedConvertLanguage = 'Spanish';
  bool _isStarred = false;

  var input = TextEditingController(text: "How are you");
  String output = "";
  GoogleTranslator translator = GoogleTranslator();
  late FocusNode _textFocusNode;

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 10).animate(_animationController);
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

// Function to start the animation
  void startAnimation() {
    _animationController.forward();
  }

  // Function to stop the animation
  void stopAnimation() {
    _animationController.reverse();
  }

  // Add this method call in your translate() method to start and stop the animation
  translate() async {
    startAnimation();
    String? fromCode = languageCode[selectedLanguage];
    String? toCode = languageCode[selectedConvertLanguage];

    if (fromCode != null && toCode != null) {
      await translator
          .translate(input.text, from: fromCode, to: toCode)
          .then((value) {
        output = value.text;
        setState(() {});
      });
    }
    stopAnimation();
  }

  languageTranslate(String text, String lang) async {
    await translator.translate(text, to: lang).then((value) {
      input.clear();
      input.text = value.text;
    });
  }
  // Get the current date and time

  // Get the current date and time

  List listLanguage = [
    "Afrikaans",
    "Albanian",
    "Amharic",
    "Arabic",
    "Armenian",
    "Azerbaijani",
    'Basque',
    'Belarusian',
    'Bengali',
    'Bosnian',
    'Bulgarian',
    'Catalan',
    'Cebuano',
    'Chichewa',
    'Chinese Simplified',
    'Chinese Traditional',
    'Corsican',
    'Croatian',
    'Czech',
    'Danish',
    'Dutch',
    'English',
    'Esperanto',
    'Estonian',
    'Filipino',
    'Finnish',
    'French',
    'Frisian',
    'Galician',
    'Georgian',
    'German',
    'Greek',
    'Gujarati',
    'Haitian Creole',
    'Hausa',
    'Hawaiian',
    'Hebrew',
    'Hindi',
    'Hmong',
    'Hungarian',
    'Icelandic',
    'Igbo',
    'Indonesian',
    'Irish',
    'Italian',
    'Japanese',
    'Javanese',
    'Kannada',
    'Kazakh',
    'Khmer',
    'Korean',
    'Kurdish (Kurmanji)',
    'Kyrgyz',
    'Lao',
    'Latin',
    'Latvian',
    'Lithuanian',
    'Luxembourgish',
    'Macedonian',
    'Malagasy',
    'Malay',
    'Malayalam',
    'Maltese',
    'Maori',
    'Marathi',
    'Mongolian',
    'Myanmar (Burmese)',
    'Nepali',
    'Norwegian',
    'Pashto',
    'Persian',
    'Polish',
    'Portuguese',
    'Punjabi',
    'Romanian',
    'Russian',
    'Samoan',
    'Scots Gaelic',
    'Serbian',
    'Lesotho',
    'Shona',
    'Sindhi',
    'Sinhala',
    'Slovak',
    'Slovenian',
    'Somali',
    'Spanish',
    'Sundanese',
    'Swahili',
    'Swedish',
    'Tajik',
    'Tamil',
    'Telugu',
    'Thai',
    'Twi',
    'Turkish',
    'Ukrainian',
    'Urdu',
    'Uzbek',
    'Vietnamese',
    'Welsh',
    'Xhosa',
    'Yiddish',
    'Yoruba',
    'Zulu'
  ];

  Map<String, String> languageToCountryCode = {
    "Afrikaans": "ZA",
    "Albanian": "AL",
    "Amharic": "ET",
    "Arabic": "SY",
    "Armenian": "AM",
    "Azerbaijani": "AZ",
    "Basque": "ES",
    "Belarusian": "BY",
    "Bengali": "BD",
    "Bosnian": "BA",
    "Bulgarian": "BG",
    "Catalan": "ES",
    "Cebuano": "PH",
    "Chichewa": "MW",
    "Chinese Simplified": "CN",
    "Chinese Traditional": "TW",
    "Corsican": "FR",
    "Croatian": "HR",
    "Czech": "CZ",
    "Danish": "DK",
    "Dutch": "NL",
    "English": "US",
    "Esperanto": "XK",
    "Estonian": "EE",
    "Filipino": "PH",
    "Finnish": "FI",
    "French": "FR",
    "Frisian": "NL",
    "Galician": "ES",
    "Georgian": "GE",
    "German": "DE",
    "Greek": "GR",
    "Gujarati": "IN",
    "Haitian Creole": "HT",
    "Hausa": "NG",
    "Hawaiian": "US",
    "Hebrew": "IL",
    "Hindi": "IN",
    "Hmong": "CN",
    "Hungarian": "HU",
    "Icelandic": "IS",
    "Igbo": "NG",
    "Indonesian": "ID",
    "Irish": "IE",
    "Italian": "IT",
    "Japanese": "JP",
    "Javanese": "ID",
    "Kannada": "IN",
    "Kazakh": "KZ",
    "Khmer": "KH",
    "Korean": "KR",
    "Kurdish (Kurmanji)": "IQ",
    "Kyrgyz": "KG",
    "Lao": "LA",
    "Latin": "VA",
    "Latvian": "LV",
    "Lithuanian": "LT",
    "Luxembourgish": "LU",
    "Macedonian": "MK",
    "Malagasy": "MG",
    "Malay": "MY",
    "Malayalam": "IN",
    "Maltese": "MT",
    "Maori": "NZ",
    "Marathi": "IN",
    "Mongolian": "MN",
    "Myanmar (Burmese)": "MM",
    "Nepali": "NP",
    "Norwegian": "NO",
    "Pashto": "AF",
    "Persian": "IR",
    "Polish": "PL",
    "Portuguese": "PT",
    "Punjabi": "IN",
    "Romanian": "RO",
    "Russian": "RU",
    "Samoan": "WS",
    "Scots Gaelic": "GB",
    "Serbian": "RS",
    "Lesotho": "LS",
    "Shona": "ZW",
    "Sindhi": "PK",
    "Sinhala": "LK",
    "Slovak": "SK",
    "Slovenian": "SI",
    "Somali": "SO",
    "Spanish": "ES",
    "Sundanese": "ID",
    "Swahili": "KE",
    "Swedish": "SE",
    "Tajik": "TJ",
    "Tamil": "IN",
    "Telugu": "IN",
    "Thai": "TH",
    "Turkish": "TR",
    "Twi": "GH",
    "Ukrainian": "UA",
    "Urdu": "PK",
    "Uzbek": "UZ",
    "Vietnamese": "VN",
    "Welsh": "GB",
    "Xhosa": "ZA",
    "Yiddish": "IL",
    "Yoruba": "NG",
    "Zulu": "ZA",
  };

  Map<String, String> languageCode = {
    "Afrikaans": "af",
    "Albanian": "sq",
    "Amharic": "am",
    "Arabic": "ar",
    "Armenian": "hy",
    "Azerbaijani": "az",
    "Basque": "eu",
    "Belarusian": "be",
    "Bengali": "bn",
    "Bosnian": "bs",
    "Bulgarian": "bg",
    "Catalan": "ca",
    "Cebuano": "ceb",
    "Chichewa": "ny",
    "Chinese Simplified": "zh-CN",
    "Chinese Traditional": "zh-TW",
    "Corsican": "co",
    "Croatian": "hr",
    "Czech": "cs",
    "Danish": "da",
    "Dutch": "nl",
    "English": "en",
    "Esperanto": "eo",
    "Estonian": "et",
    "Filipino": "fil",
    "Finnish": "fi",
    "French": "fr",
    "Frisian": "fy",
    "Galician": "gl",
    "Georgian": "ka",
    "German": "de",
    "Greek": "el",
    "Gujarati": "gu",
    "Haitian Creole": "ht",
    "Hausa": "ha",
    "Hawaiian": "haw",
    "Hebrew": "he",
    "Hindi": "hi",
    "Hmong": "hmn",
    "Hungarian": "hu",
    "Icelandic": "is",
    "Igbo": "ig",
    "Indonesian": "id",
    "Irish": "ga",
    "Italian": "it",
    "Japanese": "ja",
    "Javanese": "jv",
    "Kannada": "kn",
    "Kazakh": "kk",
    "Khmer": "km",
    "Korean": "ko",
    "Kurdish (Kurmanji)": "ku",
    "Kyrgyz": "ky",
    "Lao": "lo",
    "Latin": "la",
    "Latvian": "lv",
    "Lithuanian": "lt",
    "Luxembourgish": "lb",
    "Macedonian": "mk",
    "Malagasy": "mg",
    "Malay": "ms",
    "Malayalam": "ml",
    "Maltese": "mt",
    "Maori": "mi",
    "Marathi": "mr",
    "Mongolian": "mn",
    "Myanmar (Burmese)": "my",
    "Nepali": "ne",
    "Norwegian": "no",
    "Pashto": "ps",
    "Persian": "fa",
    "Polish": "pl",
    "Portuguese": "pt",
    "Punjabi": "pa",
    "Romanian": "ro",
    "Russian": "ru",
    "Samoan": "sm",
    "Scots Gaelic": "gd",
    "Serbian": "sr",
    "Sesotho": "st",
    "Shona": "sn",
    "Sindhi": "sd",
    "Sinhala": "si",
    "Slovak": "sk",
    "Slovenian": "sl",
    "Somali": "so",
    "Spanish": "es",
    "Sundanese": "su",
    "Swahili": "sw",
    "Swedish": "sv",
    "Tagalog (Filipino)": "tl",
    "Tajik": "tg",
    "Tamil": "ta",
    "Twi": "ak",
    "Telugu": "te",
    "Thai": "th",
    "Turkish": "tr",
    "Ukrainian": "uk",
    "Urdu": "ur",
    "Uzbek": "uz",
    "Vietnamese": "vi",
    "Welsh": "cy",
    "Xhosa": "xh",
    "Yiddish": "yi",
    "Yoruba": "yo",
    "Zulu": "zu",
  };

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    DateTime now = DateTime.now();

    // Format the date and time
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('HH:mm:ss').format(now);

    // Concatenate the formatted date and time
    String currentDateTime = '$formattedDate $formattedTime';
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: const Color(0xff003366),
        title: const Text(
          "Language Translator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height + 100),
          child: SingleChildScrollView(
              child: Column(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: const Color(0xffFFFBFE),
                              border: Border.all(
                                color: const Color(0XFF6750A4),
                                width: 0.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CountryFlag.fromCountryCode(
                                      languageToCountryCode[selectedLanguage] ??
                                          'US',
                                      height: 24,
                                      width: 24,
                                      borderRadius: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        items: listLanguage.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        value: selectedLanguage,
                                        style: TextStyle(
                                            color: ColorsUsed.textcolor,
                                            fontWeight: FontWeight.w500),
                                        onChanged: (val) {
                                          if (val != null) {
                                            setState(() {
                                              selectedLanguage = val;
                                            });
                                          }
                                          languageTranslate(input.text,
                                              languageCode[selectedLanguage]!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset("images/ch.png"),
                                buildLanguageDropdown(
                                  selectedConvertLanguage,
                                  (String? value) {
                                    if (value != null) {
                                      setState(() {
                                        selectedConvertLanguage = value;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Card(
                            elevation: 4,
                            margin: const EdgeInsets.all(16),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            selectedLanguage,
                                            style: TextStyle(
                                                color: ColorsUsed.textcolor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container()
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              input.clear();
                                            });
                                          },
                                          icon: const Icon(Icons.close))
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    minLines: null,
                                    maxLines: null,
                                    controller: input,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter text here',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      ElevatedButton(
                                        onPressed: translate,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffFF6600),
                                          elevation: 8,
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: _animation.value,
                                                  sigmaY: _animation.value),
                                              child: Container(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            const Text(
                                              "Translate",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          output.isNotEmpty
                              ? Card(
                                  elevation: 4,
                                  margin: const EdgeInsets.all(16),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  selectedConvertLanguage,
                                                  style: const TextStyle(
                                                      color: Color(0xff003366),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Container()
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    output = "";
                                                    _isStarred = false;
                                                  });
                                                },
                                                icon: const Icon(Icons.close))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [Container()],
                                        ),
                                        const SizedBox(height: 16),
                                        Text(output),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  // Copy output to clipboard
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: output));

                                                  // Show a toast message

                                                  Get.snackbar(
                                                    "Message",
                                                    "Copied",
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                    backgroundColor:
                                                        Colors.green,
                                                    borderRadius: 20,
                                                    margin:
                                                        const EdgeInsets.all(
                                                            15),
                                                    colorText: Colors.white,
                                                    duration: const Duration(
                                                        seconds: 4),
                                                    isDismissible: true,
                                                    dismissDirection:
                                                        DismissDirection
                                                            .horizontal,
                                                    forwardAnimationCurve:
                                                        Curves.easeOutBack,
                                                  );
                                                },
                                                icon: const Icon(Icons.copy)),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _isStarred = !_isStarred;
                                                  });
                                                  storeFavoriteTranslation(
                                                      currentDateTime, output);
                                                  setState(() {});
                                                },
                                                icon: Icon(Icons.star,
                                                    color: _isStarred
                                                        ? Colors.yellow
                                                        : null))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget buildLanguageDropdown(
    String selectedValue,
    void Function(String?) onChanged,
  ) {
    return Row(
      children: [
        CountryFlag.fromCountryCode(
          languageToCountryCode[selectedValue] ?? 'US',
          height: 24,
          width: 24,
          borderRadius: 8,
        ),
        const SizedBox(width: 5),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            items: listLanguage.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: selectedValue,
            style: TextStyle(
                color: ColorsUsed.textcolor, fontWeight: FontWeight.w500),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
