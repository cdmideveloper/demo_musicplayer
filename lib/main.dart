import 'package:demo_musicplayer/AllSongs.dart';
import 'package:demo_musicplayer/Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

//131294
void main() {
  runApp(MaterialApp(
    home: demo(),
  ));
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  String curdate = "";
  String curTime = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    curdate = DateTime.now().toString();
    curTime = TimeOfDay.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DatePicker and TimePicker"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025))
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      curdate = value.toString();
                    });
                  }
                });
              },
              child: Text("${curdate}")),
          ElevatedButton(
              onPressed: () {
                showTimePicker(
                        initialEntryMode: TimePickerEntryMode.input,
                        context: context,
                        initialTime: TimeOfDay.now())
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      curTime = value.toString();
                    });
                  }
                });
              },
              child: Text("${curTime}")),
         ElevatedButton(onPressed: () {
           showModalBottomSheet(builder: (context) {
             return  Container(
               height: 150,
               child: CupertinoDatePicker(mode: CupertinoDatePickerMode.time,onDateTimeChanged: (value) {
                 print(value);
               },),
             );
           },context: context);
         }, child: Text("Time"))
        ],
      ),
    );
  }
}

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadAllMusic();
  }

  loadAllMusic() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await [Permission.storage].request();
    }

    Model.songlist = await _audioQuery.querySongs();

    print(Model.songlist);

    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return AllSongs();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Loading....")),
    );
  }
}
