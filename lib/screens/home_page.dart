import 'package:core_soft_meeting/config/constants/index.dart';
import 'package:core_soft_meeting/widgets/index.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:core_soft_meeting/services/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final meetingServices = MeetingServices();
  DateTime _selectedDate = DateTime.now();
  List<Map<String, dynamic>> meetings = [];

  @override
  void initState() {
    super.initState();
    _loadMeetings();
  }

   Future<void> _loadMeetings() async {
    try {
      final fetchedMeetings = await meetingServices.getAllMeetings(_selectedDate);
      setState(() {
        meetings = fetchedMeetings;
      });
    } catch (e) {
      throw Exception('Error al obtener las reuniones');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: _appBar(),
        drawer: const BuildDrawer(),
        body: Column(
          children: [_addTaskBar(), _addDateBar(screenWidth, screenHeight), const SizedBox(height: 10), _showMeeting()],
        ));
  }

  _showMeeting() {
    return Expanded(
      child: ListView.builder(
        itemCount: meetings.length,
        itemBuilder: (_, index){
        final meeting = meetings[index];
        return AnimationConfiguration.staggeredList(
          position: index,
          child: SlideAnimation(
            child: FadeInAnimation(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      print("tapped");
                    },
                    child: MeetingTile(
                      meetingTitle: meeting['titulo'],
                      startDate: meeting['fechaInicio'],
                      endDate: meeting['fechaFinal'],
                      place: meeting['lugar'],
                      description: meeting['descripcion'],
                      startTime: meeting['horaInicio'],
                      endTime: meeting['horaFinal'],
                      status: meeting['estado'],
                    ),
                  )
                ],
              ),
            ),
          ),
        ); 
      }),
    );
  }

  _addDateBar(double width, double height) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: height * 0.13,
        width: width * 0.2,
        locale: 'es',
        initialSelectedDate: DateTime.now(),
        selectionColor: black,
        selectedTextColor: white,
        dateTextStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        onDateChange: (date) {
          setState(() {
             _selectedDate = date;
             _loadMeetings();
          });
          
        },
      ),
    );
  }

  _addTaskBar() {
    String _fecha = DateFormat.yMMMMd('es')
        .format(DateTime.now())
        .replaceAll(RegExp(r'\bde\b'), '');
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_fecha, style: subHeadingStyle),
                Text(
                  "Hoy",
                  style: headingStyle,
                )
              ],
            ),
          ),
          MyButton(label: "+ Add Meet", onTap: () => null)
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
        title: const Text('Home Page', style: TextStyle(color: white)),
        iconTheme: const IconThemeData(color: white),
        backgroundColor: black);
  }
}
