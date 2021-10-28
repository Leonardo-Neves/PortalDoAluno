import 'package:flutter/material.dart';
import 'package:projeto/modules/CustomColor.dart';

// App
import 'package:projeto/controller/schedule.controller.dart';
import 'package:projeto/modules/components.dart';
import 'package:projeto/base_widget.dart';

// Packages
import 'package:provider/provider.dart';

class Schedule extends StatefulWidget {
  Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  dynamic user;
  var _itemsDropDownPeriod = [''];
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      ScheduleController scheduleController =
          new ScheduleController(api: Provider.of(context, listen: false));
      var userData = await scheduleController.getStudent();

      setState(() => user = userData);

      var period = await scheduleController.getPeriod(user.ra);

      setState(() => _itemsDropDownPeriod = period);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ScheduleController>(
      model: ScheduleController(api: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        appBar: Header(
          title: 'Horários',
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                color: Color(CustomColor.WhiteLight),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Segunda Feira',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Color(CustomColor.BlueNormal),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ScheduleItem(),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Terça Feira',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Color(CustomColor.BlueNormal),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ScheduleItem(),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          color: Color(CustomColor.White),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contabilidade Gerencial',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Color(CustomColor.OrangeNormal),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '08/09/2021 - 06/10/2021',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Color(CustomColor.BlueNormal),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '19:00 - 21:30',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Color(CustomColor.BlueNormal),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Clique para reunir',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Color(CustomColor.BlueDark),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
