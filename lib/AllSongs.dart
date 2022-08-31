import 'package:audioplayers/audioplayers.dart';
import 'package:demo_musicplayer/Model.dart';
import 'package:flutter/material.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({Key? key}) : super(key: key);

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {

  AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Songlist"),),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          onTap: () async {
            await player.play(DeviceFileSource(Model.songlist[index].data));
          },
          title: Text("${Model.songlist[index].displayNameWOExt}"),
          subtitle: Text("${Model.songlist[index].duration}"),
        );
      },),
    );
  }
}
