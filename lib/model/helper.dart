/// dart imports
import 'dart:io' show Platform;

/// Package imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Local imports
import '../widgets/bottom_sheet.dart';
import '../widgets/search_bar.dart';
import 'mobile_view.dart';
import 'model.dart';
import 'sample_view.dart';

/// On tap the button, select the modules.
void onTapControlInMobile(BuildContext context, SampleModel model,
    WidgetCategory category, int position) {
  category.selectedIndex = position;
  Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              LayoutPage(sampleModel: model, category: category)));
}

/// Resets the locale and textDirection values.
void resetLocaleValue(SampleModel model, SubItem currentSample) {
  model.sampleDetail = currentSample;

  if (currentSample != null &&
      (currentSample.title!.toLowerCase().contains('rtl') ||
          currentSample.title!.toLowerCase().contains('directionality'))) {
    model.textDirection = TextDirection.rtl;
    model.locale = const Locale('ar', 'AE');
    model.isInitialRender = true;
  } else if (currentSample != null &&
      currentSample.title!.toLowerCase().contains('localization')) {
    model.textDirection = TextDirection.ltr;
    model.locale = const Locale('en', 'US');
    model.isInitialRender = true;
  }
}

/// On tap the mouse, select the modules in web.
void onTapControlInWeb(BuildContext context, SampleModel model,
    WidgetCategory category, int position) {
  category.selectedIndex = position;
  final SubItem subItem =
      category.controlList![category.selectedIndex!].subItems[0].type ==
              'parent'
          ? category.controlList![category.selectedIndex!].subItems[0]
              .subItems[0].subItems[0] as SubItem
          : category.controlList![category.selectedIndex!].subItems[0].type ==
                  'child'
              ? category.controlList![category.selectedIndex!].subItems[0]
                  .subItems[0] as SubItem
              : category.controlList![category.selectedIndex!].subItems[0]
                  as SubItem;

  Navigator.pushNamed(context, subItem.breadCrumbText!);
}

/// On tap the expand button, get the fullview sample.
void onTapExpandSample(
    BuildContext context, SubItem subItem, SampleModel model) {
  model.isCardView = false;
  final Function sampleWidget = model.sampleWidget[subItem.key]!;
  final SampleView sampleView = sampleWidget(GlobalKey<State>()) as SampleView;
  Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => _FullViewSampleLayout(
                sampleWidget: sampleView,
                sample: subItem,
              )));
  model.sampleList.clear();
  model.editingController.text = '';
  if (!model.isWebFullView &&
      model.searchBar != null &&
      model.searchBar!.key != null) {
    final SearchBarState searchBarState =
        (model.searchBar!.key! as GlobalKey).currentState! as SearchBarState;
    searchBarState.isFocus.unfocus();
    searchBarState.isOpen = false;
  }
  //ignore: invalid_use_of_protected_member
  model.notifyListeners();
}

/// Method to return list of text span from the provide sample description
List<TextSpan> getTextSpan(String description, SampleModel model) {
  final List<String> highlightList = <String>[];
  final List<String> list = <String>[];
  final List<String> value = description.split(' ');
  bool isHightlightStarted = false;
  String? highlightText;
  String? overallText;

  for (int i = 0; i < value.length; i++) {
    if (value[i].contains('<highlight>') &&
        value[i].contains('<endHighlight>')) {
      String word = value[i].replaceAll('<highlight>', '');
      word = word.replaceAll('<endHighlight>', '');
      if (word.isNotEmpty) {
        if (overallText != null) {
          list.add(overallText);
          overallText = null;
          list.add(word);
          highlightList.add(word);
        }
      }
    } else if (value[i] == '<highlight>' || value[i].contains('<highlight>')) {
      if (overallText != null) {
        list.add(overallText);
      }
      overallText = null;
      isHightlightStarted = true;

      if (value[i] == '<highlight>') {
        continue;
      }
    } else if (value[i] == '<endHighlight>' ||
        value[i].contains('<endHighlight>')) {
      String word = '';
      if (value[i].contains('<endHighlight>')) {
        word = value[i].replaceAll('<endHighlight>', '');
      }
      if (overallText != null) {
        list.add(overallText);
      }

      if (word.isNotEmpty) {
        list.add(word);
      }

      if (highlightText != null) {
        highlightList.add(highlightText);
      }

      if (word.isNotEmpty) {
        highlightList.add(word);
      }
      overallText = null;
      highlightText = null;
      isHightlightStarted = false;
      continue;
    }

    if (isHightlightStarted) {
      String word;
      if (value[i].contains('<highlight>')) {
        word = value[i].replaceAll('<highlight>', '');
      } else if (value[i].contains('<endHighlight>')) {
        word = value[i].replaceAll('<endHighlight>', '');
      } else {
        word = value[i];
      }
      if (overallText != null) {
        overallText = overallText + ' ' + word;
      } else {
        overallText = word;
      }

      if (highlightText != null) {
        highlightText = highlightText + ' ' + word;
      } else {
        highlightText = word;
      }
    } else if (!value[i].contains('<highlight>') &&
        !value[i].contains('<endHighlight>')) {
      if (overallText != null) {
        overallText = overallText + ' ' + value[i];
      } else {
        overallText = value[i];
      }
    }
  }

  if (overallText != null && !list.contains(overallText)) {
    list.add(overallText);
  }

  if (highlightText != null && !highlightList.contains(highlightText)) {
    highlightList.add(highlightText);
  }

  final List<TextSpan> textSpans = <TextSpan>[];
  for (int i = 0; i < list.length; i++) {
    if (list[i].contains('[')) {
      final List<String> splits = list[i].split('[');
      final String text = splits[0].isEmpty
          ? splits[1].contains(']')
              ? splits[1].replaceAll(']', '')
              : splits[1]
          : splits[0];
      if (i != 0) {
        textSpans.add(const TextSpan(text: ' '));
      }
      textSpans.add(TextSpan(
          text: text,
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              letterSpacing: 0.25,
              fontFamily: 'Roboto-Regular',
              fontSize: 14,
              color: Color(0xFF0274E5),
              height: 1.2,
              decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launchUrl(Uri.parse(splits[1].replaceAll(']', '')));
            }));
    } else if (highlightList.any((String element) => element == list[i])) {
      if (i != 0) {
        textSpans.add(const TextSpan(text: ' '));
      }

      textSpans.add(TextSpan(
          text: list[i],
          style: const TextStyle(
            backgroundColor: Color.fromRGBO(252, 228, 217, 0.6),
            letterSpacing: 0.25,
            fontSize: 12,
            fontFamily: 'Menlo',
            height: 1.2,
            fontWeight: FontWeight.normal,
            color: Color(0xFF83300C),
          )));
    } else {
      textSpans.add(TextSpan(
        text: i == 0 ? list[i] : ' ' + list[i],
        style: model.isWebFullView
            ? TextStyle(
                color: model.textColor,
                fontFamily: 'Roboto-Regular',
                letterSpacing: 0.3,
              )
            : TextStyle(
                fontWeight: FontWeight.normal,
                letterSpacing: 0.2,
                fontSize: 15,
                height: 1.2,
                color: model.textColor,
              ),
      ));
    }
  }
  return textSpans;
}

///On expanding sample, full view sample layout renders
class _FullViewSampleLayout extends StatelessWidget {
  const _FullViewSampleLayout({this.sample, this.sampleWidget});
  final SubItem? sample;
  final Widget? sampleWidget;
  @override
  Widget build(BuildContext context) {
    final SampleModel model = SampleModel.instance;
    final bool needsFloatingBotton =
        (sample!.sourceLink != null && sample!.sourceLink != '') ||
            (sample!.needsPropertyPanel ?? false);
    final bool needPadding =
        sample!.codeLink != null && sample!.codeLink!.contains('/chart/');
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => SafeArea(
            child: sample == null
                ? Container()
                : Theme(
                    data: model.themeData,
                    child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: model.paletteColor,
                      appBar: PreferredSize(
                          preferredSize: const Size.fromHeight(60.0),
                          child: AppBar(
                            title: Text(sample!.title!),
                            elevation: 0.0,
                            backgroundColor: model.backgroundColor,
                            titleSpacing: NavigationToolbar.kMiddleSpacing,
                          )),
                      body: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              color: model.cardThemeColor),
                          padding: needPadding
                              ? EdgeInsets.fromLTRB(
                                  5, 0, 5, needsFloatingBotton ? 57 : 0)
                              : EdgeInsets.zero,
                          child: Container(child: sampleWidget)),
                      floatingActionButton: needsFloatingBotton
                          ? Stack(children: <Widget>[
                              if (sample!.sourceLink != null &&
                                  sample!.sourceLink != '')
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        30, needPadding ? 50 : 0, 0, 0),
                                    child: SizedBox(
                                      height: 20,
                                      width: 230,
                                      child: InkWell(
                                        onTap: () => launchUrl(
                                            Uri.parse(sample!.sourceLink!)),
                                        child: Row(
                                          children: <Widget>[
                                            Text('Source: ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: model.textColor)),
                                            Text(sample!.sourceText!,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.blue)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Container(),
                              if (sample!.needsPropertyPanel != true)
                                Container()
                              else
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: FloatingActionButton(
                                    heroTag: null,
                                    onPressed: () {
                                      final GlobalKey sampleKey =
                                          sampleWidget!.key! as GlobalKey;
                                      final SampleViewState sampleState =
                                          sampleKey.currentState!
                                              as SampleViewState;
                                      final Widget settingsContent =
                                          sampleState.buildSettings(context)!;
                                      showBottomSheetSettingsPanel(
                                          context, settingsContent);
                                    },
                                    backgroundColor: model.paletteColor,
                                    child: const Icon(Icons.graphic_eq,
                                        color: Colors.white),
                                  ),
                                ),
                            ])
                          : null,
                    ))));
  }
}

/// Shows copyright message, product related links
/// at the bottom of the home page.
Widget getFooter(BuildContext context, SampleModel model) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(width: 0.8, color: model.dividerColor),
      ),
      color: model.themeData.colorScheme.brightness == Brightness.dark
          ? const Color.fromRGBO(33, 33, 33, 1)
          : const Color.fromRGBO(234, 234, 234, 1),
    ),
    padding: model.isMobileResolution
        ? EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.025, 0,
            MediaQuery.of(context).size.width * 0.025, 0)
        : EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0,
            MediaQuery.of(context).size.width * 0.05, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const InkWell(
                  child: Text('Home',
                      style: TextStyle(color: Colors.blue, fontSize: 12)),
                ),
                Text(' | ',
                    style: TextStyle(
                        fontSize: 12, color: model.textColor.withOpacity(0.7))),
                const InkWell(
                  child: Text('Maps',
                      style: TextStyle(color: Colors.blue, fontSize: 12)),
                ),
                Text(' | ',
                    style: TextStyle(
                        fontSize: 12, color: model.textColor.withOpacity(0.7))),
                const InkWell(
                  child: Text('Analytics',
                      style: TextStyle(color: Colors.blue, fontSize: 12)),
                ),
                Text(' | ',
                    style: TextStyle(
                        fontSize: 12, color: model.textColor.withOpacity(0.7))),
                const InkWell(
                  child: Text('Knowledge base',
                      style: TextStyle(color: Colors.blue, fontSize: 12)),
                )
              ],
            ),
            Container(
                padding: const EdgeInsets.only(top: 10),
                child: Text('Copyright © 2022 Forest Inventory.',
                    style: TextStyle(
                        color: model.textColor.withOpacity(0.7),
                        fontSize: 12,
                        letterSpacing: 0.23)))
          ],
        ),
      ],
    ),
  );
}

/// Show Right drawer which contains theme settings for web.
Widget showWebThemeSettings(SampleModel model) {
  int selectedValue = model.selectedThemeIndex;
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    final double width = MediaQuery.of(context).size.width * 0.4;
    final Color textColor =
        model.themeData.colorScheme.brightness == Brightness.light
            ? const Color.fromRGBO(84, 84, 84, 1)
            : const Color.fromRGBO(218, 218, 218, 1);
    return Drawer(
        child: Container(
            color: model.bottomSheetBackgroundColor,
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('   Settings',
                        style: TextStyle(
                            color: model.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto-Medium')),
                    IconButton(
                        icon: Icon(Icons.close, color: model.webIconColor),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Column(children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return CupertinoSegmentedControl<int>(
                                children: <int, Widget>{
                                  0: Container(
                                      width: width,
                                      alignment: Alignment.center,
                                      child: Text('Light theme',
                                          style: TextStyle(
                                              color: selectedValue == 0
                                                  ? Colors.white
                                                  : textColor,
                                              fontFamily: 'Roboto-Medium'))),
                                  1: Container(
                                      width: width,
                                      alignment: Alignment.center,
                                      child: Text('Dark theme',
                                          style: TextStyle(
                                              color: selectedValue == 1
                                                  ? Colors.white
                                                  : textColor,
                                              fontFamily: 'Roboto-Medium')))
                                },
                                padding: const EdgeInsets.all(5),
                                unselectedColor: Colors.transparent,
                                selectedColor: model.paletteColor,
                                pressedColor: model.paletteColor,
                                borderColor: model.paletteColor,
                                groupValue: selectedValue,
                                onValueChanged: (int value) {
                                  selectedValue = value;
                                  model.currentThemeData = (value == 0)
                                      ? ThemeData.from(
                                          colorScheme:
                                              const ColorScheme.light())
                                      : ThemeData.from(
                                          colorScheme:
                                              const ColorScheme.dark());

                                  setState(() {
                                    /// update the theme changes
                                    /// tp [CupertinoSegmentedControl]
                                  });
                                },
                              );
                            }))
                      ]),
                      Container(
                          padding: const EdgeInsets.only(top: 25, left: 15),
                          child: const Text(
                            'Theme colors',
                            style: TextStyle(
                                color: Color.fromRGBO(128, 128, 128, 1),
                                fontSize: 14,
                                fontFamily: 'Roboto-Regular'),
                          )),
                      Container(
                          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 10, 30),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const []),
                                  //_addColorPalettes(model, setState)),
                                ),
                              ),
                            ],
                          )),
                      Container(
                        height: 44,
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  model.paletteColor),
                            ),
                            onPressed: () => _applyThemeAndPaletteColor(
                                model, context, selectedValue),
                            child: const Text('APPLY',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto-Bold',
                                    color: Colors.white))),
                      )
                    ],
                  ),
                ),
              ],
            )));
  });
}

/// Apply the selected theme to the whole application.
void _applyThemeAndPaletteColor(
    SampleModel model, BuildContext context, int selectedValue) {
  model.selectedThemeIndex = selectedValue;
  model.backgroundColor = model.currentThemeData!.brightness == Brightness.dark
      ? model.currentPrimaryColor
      : model.currentPaletteColor;
  model.paletteColor = model.currentPaletteColor;
  model.currentThemeData = model.currentThemeData!.copyWith(
      colorScheme: model.currentThemeData!.colorScheme.copyWith(
          primary: model.currentPaletteColor,
          secondary: model.currentPaletteColor,
          onPrimary: Colors.white));
  model.changeTheme(model.currentThemeData!);
  // ignore: invalid_use_of_protected_member
  model.notifyListeners();
  Navigator.pop(context);
}

/// Adding the palette color in the theme setting panel.
List<Widget> _addColorPalettes(SampleModel model, [StateSetter? setState]) {
  final List<Widget> colorPaletteWidgets = <Widget>[];
  for (int i = 0; i < model.paletteColors!.length; i++) {
    colorPaletteWidgets.add(Material(
        color: model.bottomSheetBackgroundColor,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border:
                Border.all(color: model.paletteBorderColors![i], width: 2.0),
            shape: BoxShape.circle,
          ),
          child: InkWell(
            onTap: () => _changeColorPalette(model, i, setState),
            child: Icon(
              Icons.brightness_1,
              size: 40.0,
              color: model.paletteColors![i],
            ),
          ),
        )));
  }
  return colorPaletteWidgets;
}

/// Changing the palete color of the application.
void _changeColorPalette(SampleModel model, int index,
    [StateSetter? setState]) {
  for (int j = 0; j < model.paletteBorderColors!.length; j++) {
    model.paletteBorderColors![j] = Colors.transparent;
  }
  model.paletteBorderColors![index] = model.paletteColors![index];
  model.currentPaletteColor = model.paletteColors![index];
  model.currentPrimaryColor = model.darkPaletteColors![index];

  model.isWebFullView
      ? setState!(() {
          /// update the palette color changes
        })
      :
      // ignore: invalid_use_of_protected_member
      model.notifyListeners();
}

/// Getting status of the control/subitems/sample.
String getStatusTag(SubItem item) {
  final bool isWeb =
      kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  String status = '';
  if (item.subItems == null) {
    status = (item.status == 'new' || item.status == 'New')
        ? (isWeb ? 'New' : 'N')
        : (item.status == 'updated' || item.status == 'Updated')
            ? (isWeb ? 'Updated' : 'U')
            : '';
  } else {
    int newCount = 0;
    int updateCount = 0;
    for (int i = 0; i < item.subItems!.length; i++) {
      if (item.subItems![i].subItems == null) {
        if (item.subItems![i].status == 'New' ||
            item.subItems![i].status == 'new') {
          newCount++;
        } else if (item.subItems![i].status == 'Updated' ||
            item.subItems![i].status == 'updated') {
          updateCount++;
        }
      } else {
        for (int j = 0; j < item.subItems![i].subItems.length; j++) {
          if (item.subItems![i].subItems[j].status == 'New' ||
              item.subItems![i].subItems[j].status == 'new') {
            newCount++;
          } else if (item.subItems![i].subItems[j].status == 'Updated' ||
              item.subItems![i].subItems[j].status == 'updated') {
            updateCount++;
          }
        }
      }
    }
    status = (newCount != 0 && newCount == item.subItems!.length)
        ? (isWeb ? 'New' : 'N')
        : (newCount != 0 || updateCount != 0)
            ? (isWeb ? 'Updated' : 'U')
            : '';
  }
  return status;
}

/// show bottom sheet which contains theme settings.
void showBottomSettingsPanel(SampleModel model, BuildContext context) {
  int selectedIndex = model.selectedThemeIndex;
  final double orientationPadding =
      ((MediaQuery.of(context).size.width) / 100) * 10;
  final double width = MediaQuery.of(context).size.width * 0.3;
  final Color textColor =
      model.themeData.colorScheme.brightness == Brightness.light
          ? const Color.fromRGBO(84, 84, 84, 1)
          : const Color.fromRGBO(218, 218, 218, 1);
  showRoundedModalBottomSheet<dynamic>(
      context: context,
      color: model.bottomSheetBackgroundColor,
      builder: (BuildContext context) => SizedBox(
          height: 250,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Stack(children: <Widget>[
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Settings',
                            style: TextStyle(
                                color: model.textColor,
                                fontSize: 18,
                                letterSpacing: 0.34,
                                fontFamily: 'HeeboBold',
                                fontWeight: FontWeight.w500)),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: model.textColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              Expanded(
                /// ListView contains a group of widgets
                /// that scroll inside the drawer
                child: ListView(
                  children: <Widget>[
                    Column(children: <Widget>[
                      Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return CupertinoSegmentedControl<int>(
                              children: <int, Widget>{
                                0: Container(
                                    width: width,
                                    alignment: Alignment.center,
                                    child: Text('System theme',
                                        style: TextStyle(
                                            color: selectedIndex == 0
                                                ? Colors.white
                                                : textColor,
                                            fontFamily: 'HeeboMedium'))),
                                1: Container(
                                    width: width,
                                    alignment: Alignment.center,
                                    child: Text('Light theme',
                                        style: TextStyle(
                                            color: selectedIndex == 1
                                                ? Colors.white
                                                : textColor,
                                            fontFamily: 'HeeboMedium'))),
                                2: Container(
                                    width: width,
                                    alignment: Alignment.center,
                                    child: Text('Dark theme',
                                        style: TextStyle(
                                            color: selectedIndex == 2
                                                ? Colors.white
                                                : textColor,
                                            fontFamily: 'HeeboMedium')))
                              },
                              unselectedColor: Colors.transparent,
                              selectedColor: model.paletteColor,
                              pressedColor: model.paletteColor,
                              borderColor: model.paletteColor,
                              groupValue: selectedIndex,
                              padding:
                                  const EdgeInsets.fromLTRB(10, 15, 10, 15),
                              onValueChanged: (int value) {
                                selectedIndex = value;
                                if (value == 0) {
                                  model.currentThemeData =
                                      model.systemTheme.brightness !=
                                              Brightness.dark
                                          ? ThemeData.from(
                                              colorScheme:
                                                  const ColorScheme.light())
                                          : ThemeData.from(
                                              colorScheme:
                                                  const ColorScheme.dark());
                                } else if (value == 1) {
                                  model.currentThemeData = ThemeData.from(
                                      colorScheme: const ColorScheme.light());
                                } else {
                                  model.currentThemeData = ThemeData.from(
                                      colorScheme: const ColorScheme.dark());
                                }
                                setState(() {
                                  /// update the theme changes to
                                  /// [CupertinoSegmentedControl]
                                });
                              },
                            );
                          }))
                    ]),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 10, 30),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: _addColorPalettes(model)),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        orientationPadding + 10,
                                        0,
                                        orientationPadding + 10,
                                        30),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: _addColorPalettes(model)),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.zero,
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              model.paletteColor),
                        ),
                        onPressed: () => _applyThemeAndPaletteColor(
                            model, context, selectedIndex),
                        child: const Text('APPLY',
                            style: TextStyle(
                                fontFamily: 'HeeboMedium',
                                color: Colors.white))),
                  ))
            ],
          )));
}

///To show the settings panel content in the bottom sheet
void showBottomSheetSettingsPanel(BuildContext context, Widget propertyWidget) {
  final SampleModel model = SampleModel.instance;
  showRoundedModalBottomSheet<dynamic>(
      context: context,
      color: model.bottomSheetBackgroundColor,
      builder: (BuildContext context) => Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
            child: Stack(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Settings',
                      style: TextStyle(
                          color: model.textColor,
                          fontSize: 18,
                          letterSpacing: 0.34,
                          fontWeight: FontWeight.w500)),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: model.textColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Theme(
                  data: ThemeData(
                      brightness: model.themeData.colorScheme.brightness,
                      primaryColor: model.backgroundColor,
                      colorScheme: model.themeData.colorScheme),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
                      child: propertyWidget))
            ]),
          ));
}

///To show the sample description in the bottom sheet
void showBottomInfo(BuildContext context, String information) {
  final SampleModel model = SampleModel.instance;
  if (information != null && information != '') {
    List<TextSpan>? textSpans;
    TextSpan? textSpan;
    textSpans = getTextSpan(information, model);
    textSpan = textSpans[0];
    textSpans.removeAt(0);
    showRoundedModalBottomSheet<dynamic>(
        context: context,
        color: model.bottomSheetBackgroundColor,
        builder: (BuildContext context) => Theme(
            data: ThemeData(
                brightness: model.themeData.colorScheme.brightness,
                primaryColor: model.backgroundColor,
                colorScheme: model.themeData.colorScheme),
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
              child: Stack(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Description',
                        style: TextStyle(
                            color: model.textColor,
                            fontSize: 18,
                            letterSpacing: 0.34,
                            fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: model.textColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 45, 12, 15),
                    child: ListView(shrinkWrap: true, children: <Widget>[
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text: textSpan!.text,
                          style: TextStyle(
                              color: model.textColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0,
                              letterSpacing: 0.2,
                              height: 1.2),
                          children: textSpans,
                        ),
                      )
                    ]))
              ]),
            )));
  }
}
