
import 'package:flutter/material.dart';
import 'backend_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoApp(),
    );
  }
}

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  List<String> videoUrls = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    try {
      final List<String> urls = await BackendService.getVideoUrls();
      setState(() {
        videoUrls = urls;
      });
    } catch (e) {
      print('Error: $e');
      // Manejar el error según sea necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video App'),
      ),
      body: Center(
        child: videoUrls.isEmpty
            ? CircularProgressIndicator()
            : GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = (currentIndex + 1) % videoUrls.length;
                  });
                },
                child: AspectRatio(
                  aspectRatio: 16 / 9, // Ajusta según el formato de tus videos
                  child: VideoPlayerWidget(url: videoUrls[currentIndex]),
                ),
              ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final String url;

  const VideoPlayerWidget({required this.url});

  @override
  Widget build(BuildContext context) {
    // Implementa tu reproductor de video aquí
    // Puedes usar paquetes como 'chewie' o 'video_player'
    // Consulta la documentación para detalles de implementación
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          'Video Player\n$url',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
