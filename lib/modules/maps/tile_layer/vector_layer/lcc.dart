/// Flutter package imports
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

///Map import
import 'package:syncfusion_flutter_maps/maps.dart';

///Local import
import '../../../../model/sample_view.dart';

/// Renders the polygon lines map sample
class MapLCCPage extends SampleView {
  /// Creates the polygon lines map sample
  const MapLCCPage(Key key) : super(key: key);

  @override
  _PolylinesSampleState createState() => _PolylinesSampleState();
}

class _PolylinesSampleState extends SampleViewState
    with SingleTickerProviderStateMixin {
  late MapZoomPanBehavior _zoomPanBehavior;
  MapTileLayerController? _mapController;
  AnimationController? _animationController;
  late Animation<double> _animation;
  late bool _isDesktop;
  late List<_RouteDetails> _routes;
  int _currentSelectedCityIndex = 0;
  late String _boundaryJson;
  Color _shapeColor = Colors.green.withOpacity(0.5);

  @override
  void initState() {
    _boundaryJson = 'assets/Marmanet-whole.json';
    _routes = <_RouteDetails>[];
    _mapController = MapTileLayerController();
    _zoomPanBehavior = MapZoomPanBehavior(
      minZoomLevel: 3,
      zoomLevel: 10,
      focalLatLng: const MapLatLng(0.15336727579496373, 36.43277553692863),
      toolbarSettings: const MapToolbarSettings(
          direction: Axis.vertical, position: MapToolbarPosition.bottomRight),
      enableDoubleTapZooming: true,
    );

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _mapController!.dispose();
    _routes.clear();
    super.dispose();
  }

  Future<Set<MapPolygon>> _getPolygonPoints() async {
    List<dynamic> polygonGeometryData;
    int multipolygonGeometryLength;
    final List<List<MapLatLng>> polygons = <List<MapLatLng>>[];
    final String data = await rootBundle.loadString(_boundaryJson);
    final dynamic jsonData = json.decode(data);
    const String key = 'features';
    final int jsonLength = jsonData[key].length as int;
    for (int i = 0; i < jsonLength; i++) {
      final dynamic features = jsonData[key][i];
      final Map<String, dynamic> geometry =
          features['geometry'] as Map<String, dynamic>;

      if (geometry['type'] == 'Polygon') {
        polygonGeometryData = geometry['coordinates'][0] as List<dynamic>;
        polygons.add(_getLatLngPoints(polygonGeometryData));
      } else {
        multipolygonGeometryLength = geometry['coordinates'].length as int;
        for (int j = 0; j < multipolygonGeometryLength; j++) {
          polygonGeometryData = geometry['coordinates'][j][0] as List<dynamic>;
          polygons.add(_getLatLngPoints(polygonGeometryData));
        }
      }
    }
    return _getPolygons(polygons);
  }

  List<MapLatLng> _getLatLngPoints(List<dynamic> polygonPoints) {
    final List<MapLatLng> polygon = <MapLatLng>[];
    for (int i = 0; i < polygonPoints.length; i++) {
      polygon.add(MapLatLng(polygonPoints[i][1], polygonPoints[i][0]));
    }
    return polygon;
  }

  Set<MapPolygon> _getPolygons(List<List<MapLatLng>> polygonPoints) {
    return List<MapPolygon>.generate(
      polygonPoints.length,
      (int index) {
        return MapPolygon(points: polygonPoints[index]);
      },
    ).toSet();
  }

  MapSublayer _getPolygonLayer(Set<MapPolygon> polygons) {
    return MapPolygonLayer(
      polygons: polygons,
      color: _shapeColor,
      strokeColor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    _isDesktop = kIsWeb ||
        themeData.platform == TargetPlatform.macOS ||
        themeData.platform == TargetPlatform.windows ||
        themeData.platform == TargetPlatform.linux;
    return FutureBuilder<dynamic>(
        future: _getPolygonPoints(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapdata) {
          if (snapdata.hasData) {
            return Stack(children: <Widget>[
              Positioned.fill(
                child: Image.asset(
                  'images/maps_grid.png',
                  repeat: ImageRepeat.repeat,
                ),
              ),
              SfMapsTheme(
                data: SfMapsThemeData(
                  shapeHoverColor: Colors.transparent,
                ),
                child: SfMaps(
                  layers: <MapLayer>[
                    MapTileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      initialMarkersCount: _routes.length,
                      controller: _mapController,
                      markerBuilder: (BuildContext context, int index) {
                        if (_routes[index].icon != null) {
                          return MapMarker(
                            key: UniqueKey(),
                            latitude: _routes[index].latLan.latitude,
                            longitude: _routes[index].latLan.longitude,
                            alignment: Alignment.bottomCenter,
                            child: _routes[index].icon,
                          );
                        } else {
                          return MapMarker(
                            key: UniqueKey(),
                            latitude: _routes[index].latLan.latitude,
                            longitude: _routes[index].latLan.longitude,
                            iconColor: Colors.white,
                            iconStrokeWidth: 2.0,
                            size: const Size(15, 15),
                            iconStrokeColor: Colors.black,
                          );
                        }
                      },
                      tooltipSettings: const MapTooltipSettings(
                        color: Color.fromRGBO(45, 45, 45, 1),
                      ),
                      markerTooltipBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_routes[index].city,
                              style: model.themeData.textTheme.caption!
                                  .copyWith(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1))),
                        );
                      },
                      sublayers: <MapSublayer>[_getPolygonLayer(snapdata.data)],
                      zoomPanBehavior: _zoomPanBehavior,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildChipWidget(0, '2010'),
                      _buildChipWidget(1, '2012'),
                      _buildChipWidget(2, '2014'),
                      _buildChipWidget(3, '2016'),
                      _buildChipWidget(4, '2018'),
                    ],
                  ),
                ),
              )
            ]);
          } else {
            return Container();
          }
        });
  }

  Widget _buildChipWidget(int index, String city) {
    return Padding(
      padding: _isDesktop
          ? const EdgeInsets.only(left: 8.0, top: 8.0)
          : const EdgeInsets.only(left: 8.0),
      child: ChoiceChip(
        backgroundColor:
            model.themeData.colorScheme.brightness == Brightness.light
                ? Colors.white
                : Colors.black,
        elevation: 3.0,
        label: Text(
          city,
          style: TextStyle(
            color: model.textColor,
          ),
        ),
        selected: _currentSelectedCityIndex == index,
        selectedColor:
            model.themeData.colorScheme.brightness == Brightness.light
                ? model.backgroundColor.withOpacity(0.25)
                : const Color.fromRGBO(61, 91, 89, 0.9),
        onSelected: (bool isSelected) {
          if (isSelected) {
            setState(() {
              _currentSelectedCityIndex = index;
              _currentNavigationLine(index, city);
            });
          }
        },
      ),
    );
  }

  void _currentNavigationLine(int index, String city) {
    switch (index) {
      case 0:
        setState(() {
          _shapeColor = Colors.green.withOpacity(0.5);
          _zoomPanBehavior.focalLatLng =
              const MapLatLng(0.15336727579496373, 36.43277553692863);
          _zoomPanBehavior.zoomLevel = 13;
        });
        break;
      case 1:
        setState(() {
          _shapeColor = Colors.green.withOpacity(0.7);
          _zoomPanBehavior.focalLatLng =
              const MapLatLng(0.15336727579496373, 36.43277553692863);
          _zoomPanBehavior.zoomLevel = 12;
        });
        break;
      case 2:
        setState(() {
          _shapeColor = Colors.orangeAccent.withOpacity(0.5);
          _zoomPanBehavior.focalLatLng =
              const MapLatLng(0.15336727579496373, 36.43277553692863);
          _zoomPanBehavior.zoomLevel = 13;
        });
        break;
      case 3:
        setState(() {
          _shapeColor = Colors.orange.withOpacity(0.5);
          _zoomPanBehavior.focalLatLng =
              const MapLatLng(0.15336727579496373, 36.43277553692863);
          _zoomPanBehavior.zoomLevel = 10;
        });
        break;
      case 4:
        setState(() {
          _shapeColor = Colors.red.withOpacity(0.5);
          _zoomPanBehavior.focalLatLng =
              const MapLatLng(0.15336727579496373, 36.43277553692863);
          _zoomPanBehavior.zoomLevel = 12;
        });
        break;
    }
  }
}

class _RouteDetails {
  _RouteDetails(this.latLan, this.icon, this.city);

  MapLatLng latLan;
  Widget? icon;
  String city;
}
