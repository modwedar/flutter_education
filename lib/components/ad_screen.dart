import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdScreen extends StatefulWidget {
  final String url;

  const AdScreen({Key key, this.url}) : super(key: key);

  @override
  _AdScreenState createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();

    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
          autoDispose: false,
          autoPlay: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(
              controlBarColor: Colors.transparent,
              enablePlayPause: false,
              showControls: false)),
      betterPlayerDataSource: BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          'https://kitapacademy.com/api/videos/download/ad.mp4'),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()),
                          (route) => false);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 14.0,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.close, color: Colors.black54),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('skip_ad', true);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()),
                          (route) => false);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "تخطي",
                          style: TextStyle(
                            fontFamily: 'ElMessiri',
                            color: Colors.black54,
                            fontSize: 14
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: BetterPlayer(
                  controller: _betterPlayerController,
                ),
              ),
            )
          ],
        ));
  }
}
