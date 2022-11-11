import 'package:animals_adoption_flutter/widgets/base_scaffold.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final Location location = Location();

  late MapController controller;
  late final LatLng _currentLocation;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  
  bool _locationIsLoaded = false;

  @override
  void initState() {
    super.initState();

    controller = MapController();
    _getLocation();
  }

  void _getLocation() async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      _currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
      _locationIsLoaded = true;
    });
  }


  @override
  Widget build(BuildContext context) {


    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);
    
    return BaseScaffold(
      title: 'My location',
      withBackButton: true,
      withBottomNavigator: false,
      body: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: SizedBox(
            height: _responsive.hp(80),
            width: _responsive.wp(100),
            child: _locationIsLoaded ? FlutterMap(
              options: MapOptions(
                minZoom: 3,
                maxZoom: 18,
                zoom: 13,
                center: _currentLocation,
                // controller: _controller
              ),
              layers: [
                TileLayerOptions(
                  backgroundColor: ThemeColors.white,
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/frankrdz/{styleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                  additionalOptions: {
                    'styleId': 'cl6h78sq8007q15pqr3dj6xqp',
                    'accessToken': dotenv.env['MAPBOX_ACCESSTOKEN']!,
                  },
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      point: _currentLocation, 
                      builder: (context){
                        return const Icon(Icons.location_pin, color: Colors.blue);
                      }
                    )
                  ]
                )
              ],
            ) : Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(backgroundColor: ThemeColors.accent.withOpacity(0.5), color: ThemeColors.accent)
              ],
            )
          ),
        ),
      ],
    );
  }
}