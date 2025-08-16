import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class MusicPlayerSheet extends StatefulWidget {
  final String title;
  final String subtitle;
  final String coverUrl;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final VoidCallback onPlayToggle;
  final ValueChanged<Duration> onSeek;
  final VoidCallback onMinimize;
  final VoidCallback onClose;
  const MusicPlayerSheet({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.coverUrl,
    required this.isPlaying,
    required this.position,
    required this.duration,
    required this.onPlayToggle,
    required this.onSeek,
    required this.onMinimize,
    required this.onClose,
  }) : super(key: key);

  @override
  State<MusicPlayerSheet> createState() => _MusicPlayerSheetState();
}

class _MusicPlayerSheetState extends State<MusicPlayerSheet> {
  late String bgImage;
  // 本地播放状态
  bool isPlaying = false;
  bool isLoading = false;
  @override
  void didUpdateWidget(covariant MusicPlayerSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果父组件传入的 isPlaying 变化，则同步到本地
    if (oldWidget.isPlaying != widget.isPlaying) {
      isPlaying = widget.isPlaying;
    }
  }
  final List<String> bgImages = [
    'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=800&q=80',
  ];

  @override
  void initState() {
    super.initState();
    bgImage = bgImages[Random().nextInt(bgImages.length)];
    isPlaying = widget.isPlaying;
  }

  void _togglePlay() {
    if (isLoading) return;
    setState(() {
      isPlaying = !isPlaying;
    });
    widget.onPlayToggle();
  }

  void _seek(double delta) {
    final newPos = widget.position + Duration(seconds: delta.round());
    final clamped = newPos < Duration.zero
        ? Duration.zero
        : (newPos > widget.duration ? widget.duration : newPos);
    widget.onSeek(clamped);
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              bgImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300]),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                color: Colors.black.withOpacity(0.45),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 64.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 32),
                        onPressed: widget.onMinimize,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white, size: 28),
                        onPressed: widget.onClose,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(widget.coverUrl),
                  onBackgroundImageError: (_, __) {},
                  child: widget.coverUrl.isEmpty
                      ? const Icon(Icons.music_note, color: Colors.white, size: 40)
                      : null,
                ),
                const SizedBox(height: 24),
                Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(widget.subtitle, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 24),
                Slider(
                  value: widget.duration.inMilliseconds == 0 ? 0 : widget.position.inMilliseconds.clamp(0, widget.duration.inMilliseconds).toDouble(),
                  min: 0,
                  max: widget.duration.inMilliseconds > 0 ? widget.duration.inMilliseconds.toDouble() : 1,
                  onChanged: (v) {
                    widget.onSeek(Duration(milliseconds: v.toInt()));
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.white24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatTime(widget.position.inSeconds), style: const TextStyle(color: Colors.white70)),
                      Text(_formatTime(widget.duration.inSeconds), style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.replay_5, color: Colors.white, size: 32),
                      onPressed: () => _seek(-5),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, color: Colors.white, size: 56),
                      onPressed: widget.duration.inMilliseconds > 0 ? _togglePlay : null,
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.forward_5, color: Colors.white, size: 32),
                      onPressed: () => _seek(5),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
