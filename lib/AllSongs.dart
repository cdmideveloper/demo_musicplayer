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

  List<bool> statuslist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    statuslist = List.filled(Model.songlist.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Songlist"),
      ),
      body: ListView.builder(
        itemCount: Model.songlist.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: statuslist[index]
                ? IconButton(
                    onPressed: () async {
                      setState(() {
                        statuslist = List.filled(Model.songlist.length, false);
                      });
                      print(statuslist);
                      await player.stop();
                      },
                    icon: Icon(Icons.pause))
                : IconButton(
                    onPressed: () async {
                      await player.stop();
                      setState(() {
                        statuslist = List.filled(Model.songlist.length, false);
                        statuslist[index] = true;
                      });
                      await player
                          .play(DeviceFileSource(Model.songlist[index].data));

                      print(statuslist);
                    },
                    icon: Icon(Icons.play_arrow)),
            title: Text("${Model.songlist[index].displayNameWOExt}"),
            subtitle: Text("${Model.songlist[index].duration}"),
          );
        },
      ),
    );
  }
}
