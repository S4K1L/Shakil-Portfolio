// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class BackgroundVideo extends StatefulWidget {
//   const BackgroundVideo({super.key});

//   @override
//   State<BackgroundVideo> createState() => _BackgroundVideoState();
// }

// class _BackgroundVideoState extends State<BackgroundVideo> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset("assets/images/background.mp4")
//       ..initialize().then((_) {
//         _controller.play();
//         _controller.setLooping(true);
//         _controller.setVolume(0);
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _controller.value.isInitialized
//         ? FittedBox(
//       fit: BoxFit.cover,
//       child: SizedBox(
//         width: _controller.value.size.width,
//         height: _controller.value.size.height,
//         child: Stack(
//           children: [
//             VideoPlayer(_controller),
//             Container(
//               color: Colors.black.withOpacity(0.20), // 🔹 black opacity
//             ),
//           ],
//         ),
//       ),
//     )
//         : Container(color: Colors.black.withOpacity(0.85));
//   }
// }
