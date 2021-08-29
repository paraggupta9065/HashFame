import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hashfame/colors.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController toSearch = TextEditingController();
  List hashtags = [
    "dog",
    "dogsofinstagram",
    "dogstagram",
    "puppiesofinstagram",
    "puppylove",
    "dogoftheday",
    "petsofinstagram",
    "dogsofinsta",
    "dogphotography",
    "doggo",
    "cat",
    "catsofinstagram",
    "cats",
    "catstagram",
    "instagram",
    "puppy",
  ];
  bool isLoading = false;

  void searchHashtag() async {
    isLoading = true;

    var restags = await http.get(
      Uri.parse("https://best-hashtags.com/hashtag/" + toSearch.text),
    );
    hashtags = restags.body
        .split('''<div class="tag-box tag-box-v3 margin-bottom-40">''')[1]
        .split("<p1>")[1]
        .split("</p1>")[0]
        .split("#");
    setState(() {
      hashtags = restags.body
          .split('''<div class="tag-box tag-box-v3 margin-bottom-40">''')[1]
          .split("<p1>")[1]
          .split("</p1>")[0]
          .split(" ");
      hashtags.removeAt(0);

      isLoading = false;
    });
    print(
      List.generate(
        hashtags.length,
        (index) => Map.from(
          {
            "display": "$hashtags[index]",
            "value": index,
          },
        ),
      ),
    );
  }

  List tagSelected = [];

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: Palet().primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        showAboutDialog(
                          context: context,
                          applicationName: "Hashfame",
                          applicationVersion: "1.0",
                          applicationIcon: SizedBox(
                            height: 70,
                            width: 70,
                            child: Image.asset(
                                "android/app/src/main/res/mipmap-hdpi/ic_launcher.png"),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.info_outline,
                        color: Palet().textColor,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 30),
                            Text(
                              "Trending",
                              style: TextStyle(
                                  color: Palet().textColor, fontSize: 40),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 30),
                            Text(
                              "Tags",
                              style: TextStyle(
                                  color: Palet().textColor, fontSize: 75),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Text(
                      "#",
                      style: TextStyle(color: Palet().textColor, fontSize: 155),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      color: Palet().textColor,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: TextField(
                            controller: toSearch,
                            decoration: InputDecoration(
                              hintText: "Search Here",
                              border: InputBorder.none,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: isLoading
                                    ? SpinKitThreeBounce(
                                        color: Palet().primaryColor,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            searchHashtag();
                                          });
                                        },
                                        icon: Icon(
                                          Icons.search,
                                          size: 35,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox(
                      height: 300,
                      child: SingleChildScrollView(
                        child: MultiSelectChipDisplay(
                          colorator: (value) {
                            if (tagSelected.contains(value)) {
                              return Palet().secondryColor;
                            } else {
                              return Palet().thirdColor;
                            }
                          },
                          decoration: BoxDecoration(
                            color: Palet().textColor,
                          ),
                          items: hashtags
                              .map((e) => MultiSelectItem(e, e))
                              .toList(),
                          onTap: (value) {
                            setState(() {
                              tagSelected.contains(value)
                                  ? tagSelected.remove(value)
                                  : tagSelected.add(
                                      value.toString(),
                                    );
                            });
                          },
                          textStyle: TextStyle(color: Palet().textColor),
                        ),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: tagSelected.toString()));
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      color: Palet().textColor,
                      child: Center(
                        child: Text(
                          "Copy",
                          textScaleFactor: 1.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      print(e);
      return Scaffold(
        body: Center(
          child: Text(
            "😞Error Occured😞",
            style: TextStyle(),
            textScaleFactor: 2,
          ),
        ),
      );
    }
  }
}
