import 'package:flutter/material.dart';
import 'base_page.dart';


import 'music_player_sheet.dart';
import 'mini_music_player.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool showMiniPlayer = false;
  bool isPlayerOpen = false;
  bool isPlaying = false;

  Map<String, String> get mockDetail => {
    'avatar': 'https://i.pravatar.cc/120?img=${int.tryParse(widget.id) ?? 1}',
    'title': '内容标题 ${widget.id}',
    'desc': '这里是内容 ${widget.id} 的详细描述，支持多行文本展示。',
    'subtitle': '副标题示例',
  };

  void _openPlayer() async {
    setState(() {
      isPlayerOpen = true;
    });
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => MusicPlayerSheet(
        title: mockDetail['title'] ?? '',
        subtitle: mockDetail['subtitle'] ?? '',
        coverUrl: mockDetail['avatar'] ?? '',
        isPlaying: isPlaying,
        position: Duration.zero,
        duration: const Duration(minutes: 3, seconds: 45),
        onPlayToggle: () {
          setState(() {
            isPlaying = !isPlaying;
          });
        },
        onSeek: (newPos) {},
        onMinimize: () {
          Navigator.of(ctx).pop();
          setState(() {
            showMiniPlayer = true;
            isPlayerOpen = false;
          });
        },
        onClose: () {
          Navigator.of(ctx).pop();
          setState(() {
            showMiniPlayer = false;
            isPlayerOpen = false;
            isPlaying = false;
          });
        },
      ),
    );
    setState(() {
      isPlayerOpen = false;
    });
  }

  void _closeMiniPlayer() {
    setState(() {
      showMiniPlayer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 48),
                CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(mockDetail['avatar']!),
                ),
                const SizedBox(height: 24),
                Text(
                  mockDetail['title']!,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  mockDetail['desc']!,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('播放'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: isPlayerOpen ? null : _openPlayer,
                ),
              ],
            ),
          ),
          Positioned(
            top: 64,
            left: 34,
            child: Material(
              color: Colors.transparent,
              elevation: 0,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => Navigator.of(context).maybePop(),
                child: Ink(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.black87),
                ),
              ),
            ),
          ),
          if (showMiniPlayer)
            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: MiniMusicPlayer(
                title: mockDetail['title']!,
                coverUrl: mockDetail['avatar']!,
                isPlaying: isPlaying,
                onPlay: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
                onOpen: _openPlayer,
                onClose: _closeMiniPlayer,
              ),
            ),
        ],
      ),
    );
  }
}
