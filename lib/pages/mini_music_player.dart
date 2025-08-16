import 'package:flutter/material.dart';

class MiniMusicPlayer extends StatelessWidget {
  final String title;
  final String coverUrl;
  final bool isPlaying;
  final VoidCallback onPlay;
  final VoidCallback onOpen;
  final VoidCallback onClose;
  const MiniMusicPlayer({
    required this.title,
    required this.coverUrl,
    required this.isPlaying,
    required this.onPlay,
    required this.onOpen,
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(32),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(coverUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: Colors.blueAccent,
                ),
                onPressed: onPlay,
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: onClose,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
