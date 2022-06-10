///Flutter package imports
import 'package:flutter/material.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

///Map import
import 'package:syncfusion_flutter_maps/maps.dart';

///Local import
import '../../../model/sample_view.dart';

/// Renders the map widget with range color mapping
class MapsWithLocalization extends LocalizationSampleView {
  /// Creates the map widget with range color mapping
  const MapsWithLocalization(Key key) : super(key: key);

  @override
  _MapsWithLocalizationState createState() => _MapsWithLocalizationState();
}

class _MapsWithLocalizationState extends LocalizationSampleViewState {
  late List<_Model> _australiaData;
  late List<String> _stateDataLabelsLocale;
  late MapShapeSource _mapShapeSource;
  late String _title;
  late bool _isLightTheme;
  late ThemeData _themeData;

  @override
  Widget buildSample(BuildContext context) {
    _themeData = Theme.of(context);
    _isLightTheme = _themeData.brightness == Brightness.light;
    _australiaData = <_Model>[
      const _Model(0.809, 'whole'),
      const _Model(1.857, 'Marmanet'),
      const _Model(1.419, 'Rumuruti'),
    ];

    _updateLabelsBasedOnLocale();

    _mapShapeSource = MapShapeSource.asset(
      'assets/Marmanet-KML.json',
      shapeDataField: 'Name',
      dataCount: _australiaData.length,
      primaryValueMapper: (int index) => _australiaData[index].state,
      dataLabelMapper: (int index) => _stateDataLabelsLocale[index],
      shapeColorValueMapper: (int index) => _australiaData[index].state,
      shapeColorMappers: <MapColorMapper>[
        MapColorMapper(
            value: 'whole',
            color: const Color.fromRGBO(255, 215, 0, 1.0),
            text: _stateDataLabelsLocale[0]),
        MapColorMapper(
            value: 'Marmanet',
            color: const Color.fromRGBO(72, 209, 204, 1.0),
            text: _stateDataLabelsLocale[1]),
        MapColorMapper(
            value: 'Rumuruti',
            color: const Color.fromRGBO(255, 78, 66, 1.0),
            text: _stateDataLabelsLocale[2]),
      ],
    );

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final bool scrollEnabled = constraints.maxHeight > 400;
      double height = scrollEnabled ? constraints.maxHeight : 400;
      if (model.isWebFullView ||
          (model.isMobile &&
              MediaQuery.of(context).orientation == Orientation.landscape)) {
        final double refHeight = height * 0.6;
        height = height > 500 ? (refHeight < 500 ? 500 : refHeight) : height;
      }
      return Center(
        child: SingleChildScrollView(
            child: ColoredBox(
          color: model.cardThemeColor,
          child: SizedBox(
            width: constraints.maxWidth,
            height: height,
            child: _buildMapsWidget(scrollEnabled),
          ),
        )),
      );
    });
  }

  Widget _buildMapsWidget(bool scrollEnabled) {
    return Center(
      child: Padding(
        padding: scrollEnabled
            ? EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                bottom: MediaQuery.of(context).size.height * 0.05,
                right: 10)
            : const EdgeInsets.only(right: 10, bottom: 15),
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 30),
                child: Align(
                    child: Text(_title,
                        textDirection: TextDirection.rtl,
                        style: _themeData.textTheme.subtitle1))),
            Expanded(
              child: SfMapsTheme(
                data: SfMapsThemeData(
                    shapeHoverColor: Colors.transparent,
                    shapeHoverStrokeColor: Colors.transparent),
                child: SfMaps(
                  layers: <MapShapeLayer>[
                    MapShapeLayer(
                      source: _mapShapeSource,
                      strokeColor: model.cardColor,
                      strokeWidth: 0.5,
                      showDataLabels: true,
                      legend: const MapLegend(MapElement.shape,
                          position: MapLegendPosition.bottom,
                          iconType: MapIconType.diamond),
                      dataLabelSettings: const MapDataLabelSettings(
                          overflowMode: MapLabelOverflow.ellipsis),
                      tooltipSettings: MapTooltipSettings(
                        color: _isLightTheme
                            ? const Color.fromRGBO(45, 45, 45, 1)
                            : const Color.fromRGBO(242, 242, 242, 1),
                      ),
                      shapeTooltipBuilder: (BuildContext context, int index) {
                        final Color textColor = _isLightTheme
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(10, 10, 10, 1);
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 7.0, 10.0, 8.5),
                              child: IntrinsicWidth(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _stateDataLabelsLocale[index],
                                      textDirection: TextDirection.ltr,
                                      style: _themeData.textTheme.caption!
                                          .copyWith(color: textColor),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      _australiaData[index]
                                              .areaInMillionSqKm
                                              .toString() +
                                          'M sq. km',
                                      textDirection: TextDirection.ltr,
                                      style: _themeData.textTheme.caption!
                                          .copyWith(color: textColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateLabelsBasedOnLocale() {
    if (model.locale == const Locale('en', 'US')) {
      _stateDataLabelsLocale = const <String>['whole', 'Marmanet', 'Rumuruti'];
      _title = 'Marmanet and Rumuruti Forest';
    }
  }
}

class _Model {
  const _Model(this.areaInMillionSqKm, this.state);
  final String state;
  final double areaInMillionSqKm;
}
