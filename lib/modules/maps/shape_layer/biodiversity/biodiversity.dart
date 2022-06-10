///Dart import
import 'dart:async';

///Flutter package imports
import 'package:flutter/material.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

///Map import
import 'package:syncfusion_flutter_maps/maps.dart';

///Local import
import '../../../../model/sample_view.dart';

/// Renders the map zooming sample.
class MapBioDiversityPage extends SampleView {
  /// Creates the map zooming sample.
  const MapBioDiversityPage(Key key) : super(key: key);

  @override
  _MapBioDiversityPageState createState() => _MapBioDiversityPageState();
}

class _MapBioDiversityPageState extends SampleViewState {
  final double _markerSize = 24;

  late MapShapeSource _mapSource;

  late List<_CountryColor> _countryColors;

  late MapZoomPanBehavior _zoomPanBehavior;

  Timer? _tooltipTimer;

  @override
  void initState() {
    _zoomPanBehavior = MapZoomPanBehavior();
    _countryColors = <_CountryColor>[
      const _CountryColor('grass', Colors.green),
    ];

    _mapSource = MapShapeSource.asset(
      'assets/Marmanet-whole.json',
      shapeDataField: 'Name',
      dataCount: 1,
      primaryValueMapper: (int index) => _countryColors[index].country,
      shapeColorValueMapper: (int index) => _countryColors[index].color,
    );

    super.initState();
  }

  @override
  void dispose() {
    _countryColors.clear();
    _tooltipTimer?.cancel();
    _tooltipTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bool isLightTheme =
        themeData.colorScheme.brightness == Brightness.light;
    final Color surfaceColor = isLightTheme
        ? const Color.fromRGBO(45, 45, 45, 1)
        : const Color.fromRGBO(242, 242, 242, 1);
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
      return Container(
          padding: scrollEnabled
              ? EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.05)
              : const EdgeInsets.only(top: 10, bottom: 15),
          child: SfMapsTheme(
            data: SfMapsThemeData(
              shapeHoverColor: Colors.transparent,
              shapeHoverStrokeColor: Colors.grey[700],
              shapeHoverStrokeWidth: 1.5,
            ),
            child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                  child: Align(
                      child: Text('Marmanet Biodiversity Map',
                          style: Theme.of(context).textTheme.subtitle1))),
              Expanded(
                  child: SfMaps(
                layers: <MapLayer>[
                  MapShapeLayer(
                    loadingBuilder: (BuildContext context) {
                      return const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      );
                    },
                    color: Colors.white,
                    strokeColor: const Color.fromRGBO(242, 242, 242, 1),
                    strokeWidth: 1,
                    source: _mapSource,
                    showDataLabels: true,
                    dataLabelSettings: const MapDataLabelSettings(
                      overflowMode: MapLabelOverflow.ellipsis,
                      textStyle: TextStyle(
                        color: Color.fromRGBO(45, 45, 45, 1),
                      ),
                    ),
                    tooltipSettings: MapTooltipSettings(
                      color: surfaceColor,
                    ),

                    /// Adding `zoomPanBehavior` will enable the zooming and
                    /// panning in the shape layer.
                    zoomPanBehavior: _zoomPanBehavior,
                  ),
                ],
              )),
            ]),
          ));
    });
  }
}

class _CountryColor {
  const _CountryColor(this.country, this.color);

  final String country;

  final Color color;
}
