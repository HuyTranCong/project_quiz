import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double _setVolumeValue = 0;
  double _volumeListenerValue = 0;

  @override
  void initState() {
    super.initState();

    VolumeController().listener((volume) {
      setState(() => _volumeListenerValue = volume);
    });

    VolumeController().getVolume().then((value) => _setVolumeValue = value);
  }

  @override
  void dispose() {
    VolumeController().removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF09031D),
            Color(0xFF1B1E44),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text('Cài Đặt',
              style: TextStyle(color: Color(0xFFA9DED8), fontSize: 30)),
          iconTheme: IconThemeData(color: Colors.blue),
          centerTitle: true,
        ),
        body: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //text
              Image.asset(
                'assets/images/voice.png',
                fit: BoxFit.cover,
                width: size.width / 12,
                color: Colors.white,
              ),
              Text(
                'Âm Thanh',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              //chinh am thanh
              Flexible(
                child: Slider(
                  min: 0,
                  max: 1,
                  onChanged: (double value) {
                    _setVolumeValue = value;
                    VolumeController().setVolume(_setVolumeValue);
                    setState(() {});
                  },
                  value: _setVolumeValue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
